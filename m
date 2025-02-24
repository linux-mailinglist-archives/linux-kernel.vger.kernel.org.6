Return-Path: <linux-kernel+bounces-529398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B61EA425C0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 16:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 732A3444514
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE5A19AD86;
	Mon, 24 Feb 2025 14:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YqlOCL5C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B7B18A6C5
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 14:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740408902; cv=none; b=gS6mhbD1HZs2iHy1WIzbj4sYJ0ORn2uGVaajJPVXq0JFDGRpJwYhcZsRaYv/8NUy8GPPCLQ3TulNfVno77E/xvI74I7RJK6ug82xI1YLBruNNw41Skopq4j3qwjwB3oRxg+FJluGjzeKhYcYz2EEhndJMZMqu5+21HLzHXU1EcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740408902; c=relaxed/simple;
	bh=dKZc9e3gq+oO0H966QlwGQMVdhoN7cwOA7FPVKPrTlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Orhcs/o3rNpayykOzNUSjdDtMIKf+tySzjqB1ILraG4wIokZ0tat2mKjsm4Yf+152FUijWMyYgqhI/tHD04lWE46ybCdDv01siutfskTA0NWqhGpTITa8knsdcu3O7cErropYEL9Xv0xsduLN0NGbFG72/eLewX85AE5VAmOnH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YqlOCL5C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11A1BC4CED6;
	Mon, 24 Feb 2025 14:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740408902;
	bh=dKZc9e3gq+oO0H966QlwGQMVdhoN7cwOA7FPVKPrTlQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YqlOCL5C76tCAk6mKNeJt/4p7qAcBdHn+Ou3r2b8EiJJvT7YtvHh0ZoaKSyKzP1Ui
	 pXOEcRlvo2eNGwIZzWuK1Cxe3jkHxegR3qAUY90OozB8T+9X7fW09YojQK2huYWWZJ
	 hb5953O2gaQb1CB1oOETU5Xxib6/3P89OZLH8DrTK5C+RJktnDNLnO5NnlJajoNfD1
	 qHIfiGvGE7cte3Tk3UR5y0SbR3YWlFYkOMDzN4YRe4Bw1DMhTeoYNxQxSlxLT1ayox
	 M97/pnL/wu/b9wHa/2RiPNOxc9sqcOycc80UrW0iqZZeMqqjYpW4ZOrQmkPC+0Hybc
	 dWJ+sMuoIO61g==
Date: Mon, 24 Feb 2025 07:54:59 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Xinyu Zhang <xizhang@purestorage.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: Re: [PATCH] nvme: map uring_cmd data even if address is 0
Message-ID: <Z7yIQzPhgD1Elx-H@kbusch-mbp>
References: <20250220235101.119852-1-xizhang@purestorage.com>
 <20250224143350.GB1406@lst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224143350.GB1406@lst.de>

On Mon, Feb 24, 2025 at 03:33:51PM +0100, Christoph Hellwig wrote:
> On Thu, Feb 20, 2025 at 04:51:01PM -0700, Xinyu Zhang wrote:
> > When using kernel registered bvec fixed buffers, the "address" is
> > actually the offset into the bvec rather than userspace address.
> > Therefore it can be 0.
> 
> How is that actually going to work?  Who is interpreting that address?

io_import_fixed() treats the address as an offset into its bio_vec.

