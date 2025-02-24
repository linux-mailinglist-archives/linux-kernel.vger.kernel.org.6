Return-Path: <linux-kernel+bounces-529523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6BAA42774
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B068A3A5717
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 16:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B49261398;
	Mon, 24 Feb 2025 16:04:39 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CCE25A645
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 16:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740413079; cv=none; b=fDeoizBnXErEIicK2qHiRl1PhTgsMN/xGR1uPMt/mggJ7jJxEBeHC7iA7mvRAcXKI1dfHFCv5/a7k+Ww0AIFnFGN3elJjca+QFpIl6is8gfUnCMZC0rQocX94t8w/M8qT+OAxLVBKZbsWzyJ44khCvzy+/AZP2aTpg7uyysrREw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740413079; c=relaxed/simple;
	bh=V6HJWEjEwWCenyosq6TvBpaucYgCfmgqgEiHILSPIrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nSjWQA19IurofZBSVmLINQeEaIHF2j4LmYJLZju8gVxlglarWWfevemCGqTWE7l/NNPPnM5CkcU8ZGKQORt8INSvJUbXBL0P6oDnoHak8OtCAiDdU364XQEDBxd06nppI31FDSNnLS/Ha+rKE8lCUTOck4jiwGu4gMUH5ZbCKFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C936F68BFE; Mon, 24 Feb 2025 17:04:31 +0100 (CET)
Date: Mon, 24 Feb 2025 17:04:30 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Xinyu Zhang <xizhang@purestorage.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: Re: [PATCH] nvme: map uring_cmd data even if address is 0
Message-ID: <20250224160430.GB4701@lst.de>
References: <20250220235101.119852-1-xizhang@purestorage.com> <20250224143350.GB1406@lst.de> <Z7yIQzPhgD1Elx-H@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7yIQzPhgD1Elx-H@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Feb 24, 2025 at 07:54:59AM -0700, Keith Busch wrote:
> On Mon, Feb 24, 2025 at 03:33:51PM +0100, Christoph Hellwig wrote:
> > On Thu, Feb 20, 2025 at 04:51:01PM -0700, Xinyu Zhang wrote:
> > > When using kernel registered bvec fixed buffers, the "address" is
> > > actually the offset into the bvec rather than userspace address.
> > > Therefore it can be 0.
> > 
> > How is that actually going to work?  Who is interpreting that address?
> 
> io_import_fixed() treats the address as an offset into its bio_vec.

Ah, yes.  This is in nvme_uring_data and read from the SQE.  I thought
we were further down.

