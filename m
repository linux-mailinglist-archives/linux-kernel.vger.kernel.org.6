Return-Path: <linux-kernel+bounces-529317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81680A422E6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08CCF188C06F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62AE91514EE;
	Mon, 24 Feb 2025 14:19:45 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408ABF9F8;
	Mon, 24 Feb 2025 14:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740406785; cv=none; b=JsO2zhQx1nMJVlME1av83KJ2G0ngI7/8KKqhH8mXSqPVqCsWO9v5Qc3I0WtLKbvCvTEy/ybu1/Eto9wGjzlGLd/0UXtAQecD5kaawFddgycgHA10JkETMSXMw62JkizryaGSvbLlQ138pI++rlvz/O+PFTbnrsOMSkY7wMGflC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740406785; c=relaxed/simple;
	bh=W/f0yAzq1mScPeEGhNq8mBrJl42gIG57yuyoRTNWbNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m7blHVgJQOhHWhlGxZtz9eIILYQUjO9lGlfQdXuWr+chDw3nY295BuNfii/w1nygEqGAVpNzBn+yCQN3CX1+CLQ//bNKBBXKknW0ZlI3tmAAv1XhoVfIcwbfYUF6RM5oSvfxZDJtIS+KTp+yX31RkfgxmpWTFlnHyBeSiqOaBpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4C0BD68B05; Mon, 24 Feb 2025 15:19:38 +0100 (CET)
Date: Mon, 24 Feb 2025 15:19:38 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 6/8][next] nvme: target: Avoid
 -Wflex-array-member-not-at-end warnings
Message-ID: <20250224141938.GB1088@lst.de>
References: <cover.1739957534.git.gustavoars@kernel.org> <ef7a6920384ab2f8f83c0f630f94edc73cd65997.1739957534.git.gustavoars@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef7a6920384ab2f8f83c0f630f94edc73cd65997.1739957534.git.gustavoars@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Feb 24, 2025 at 08:30:10PM +1030, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Change the type of the middle struct members currently causing trouble
> from `struct bio` to `struct bio_hdr`.
> 
> We also use `container_of()` whenever we need to retrieve a pointer to
> the flexible structure `struct bio`, through which we can access the
> flexible-array member in it, if necessary.
> 
> With these changes fix 38 of the following warnings:
> 
> drivers/nvme/target/nvmet.h:455:49: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/nvme/target/nvmet.h:462:49: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 

I'm not sure where you bio_hdr structure comes from, but maybe that's
because you annoyingly split CC over the series, and by the number of
patches probably also bundled unrelated changes.

In general our first resort here should be to move embedded bio to the
of containing structures.  If that's not possible you'll need to explain
why.


