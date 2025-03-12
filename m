Return-Path: <linux-kernel+bounces-558072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6C9A5E14F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 16:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC3981890353
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 16:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209FF2566CE;
	Wed, 12 Mar 2025 15:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="yJUviGCw"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1DD1DE2BD
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 15:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741795190; cv=none; b=EcSS6+hT0PNx3RADpzmscSjVBFxMtWmBNf+W9gGEKZSfZK1LxAY8oRb46RTC7POIbrRz8fjapVfqg5Ar2taP8jnJqVCnZf7c8IOBWEQKMoKEF3gN4JGBqMFG13mW3rkP00xnlnEe1imk9/sn8sx02HrOKJSdAwrX6PWgVk9W08o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741795190; c=relaxed/simple;
	bh=nFdOFljCBq9qTUvXB/DPSZ7x1HAQc8srezgLFgh/qyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DCal9pTjs+DhzGAieQMfPeauEBd3hPwcbuaYmVDh5w4zYu8spaL7IEAHgmr19ATn2LzTybR2NZNAVGzZxf6twxD19ho1+QxVKFSUOL9uUV/5K74Z9YvUiXGKgo9NHRcTI6D0diGguULW4sur3/jhW3yRUhwOeRQI6MSGnhnqovE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=yJUviGCw; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 7339F45742;
	Wed, 12 Mar 2025 16:59:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1741795187;
	bh=nFdOFljCBq9qTUvXB/DPSZ7x1HAQc8srezgLFgh/qyo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yJUviGCwHKWpFfh3Tn4HRP9jpsFdE94yGdVS0d0rIwbyR8qfucd3dO1fZI6fme8n9
	 DgnQSMJP1rpPb3ZNFyeSsFrejDocHwzVA0xC/eyKajlqn7m/ddgrbkQkbijmW3VZE1
	 brtIFz8+BHMVI2iITmTqqQ9FHHDWKrm3US8AUfAkraMqxrZidK5Laf1o+rjqMs14/p
	 XI8WuPM+BZ5lQIXkYLTrm563iVx9e1LOCL9mODGbKVRFCwqgUg+TseEBXBh7NWVMza
	 NabtHJQrhiQs8Jbgiq3+KWS4CXZgHXQ2cuoiL6Hw4/pq9tkfkYawehW0Q+WzVKpQ4u
	 0UuDXRP82Oxeg==
Date: Wed, 12 Mar 2025 16:59:46 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: will@kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	baolu.lu@linux.intel.com
Subject: Re: [PATCH] iommu: Don't warn prematurely about dodgy probes
Message-ID: <Z9Gvci0DVVBo20Co@8bytes.org>
References: <72a4853e7ef36e7c1c4ca171ed4ed8e1a463a61a.1741791691.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72a4853e7ef36e7c1c4ca171ed4ed8e1a463a61a.1741791691.git.robin.murphy@arm.com>

Hi Robin,

On Wed, Mar 12, 2025 at 03:01:31PM +0000, Robin Murphy wrote:
> The warning for suspect probe conditions inadvertently got moved too
> early in a prior respin - it happened to work out OK for fwspecs, but in
> general still needs to be after the ops->probe_device call so drivers
> which filter devices for themselves have a chance do do that.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/iommu.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Added a fixes tag and applied it, thanks for handling this quickly.

Regards,

	Joerg

