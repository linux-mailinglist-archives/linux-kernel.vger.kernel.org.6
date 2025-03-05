Return-Path: <linux-kernel+bounces-547046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 922BAA50252
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C429189BD06
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FC2153808;
	Wed,  5 Mar 2025 14:37:07 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156CE2E3364
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 14:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741185427; cv=none; b=m2ovQDrxT/jtRs+e5Bqmetfdl8OKZNWAYlwdj3ZVhMYFwNQDd7Ek9o4XZYzBzGM/VB7FrwTLl/hWZY2sI/3miEKMkwU49jgXt74vDkGaOqhjYLAcaSC8XzX94cihJvEOmM6OVjSn+w0tomvZPCZImZwzzPMhc3HV8oWMKQ5jLA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741185427; c=relaxed/simple;
	bh=nbpG+FmZvGqr7e31Hb74Wj4rE8qNB52Uh7oCxGE8Y84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SlUKGRIQnbh3lLCSVdQ8ruCUppw9c9KjrKIbdh7wJp/YzVwiB6kqYBCEhD/7A4F0nlp7Tvk8Uh5OlGntr3ObUwfB5QAaubnGK+qYVhtx/2fuHgWJlTCr0YaBa/d6AaFHDp/omX4v+vWwoiGGt0XjsJh8zymSFfpBvlC3aOjg/2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3F18C68AFE; Wed,  5 Mar 2025 15:37:01 +0100 (CET)
Date: Wed, 5 Mar 2025 15:37:01 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Meneghini <jmeneghi@redhat.com>
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, loberman@redhat.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	emilne@redhat.com, bgurney@redhat.com
Subject: Re: [PATCH 4/4] nvme: add mulitipath warning to nvme_alloc_ns
Message-ID: <20250305143701.GA18818@lst.de>
References: <20250228032541.369804-1-jmeneghi@redhat.com> <20250228032541.369804-5-jmeneghi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228032541.369804-5-jmeneghi@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Feb 27, 2025 at 10:25:41PM -0500, John Meneghini wrote:
> When CONFIG_NVME_MULTIPATH is disabled, add a warning if
> we discover a multipath enabled controller with an attached
> shared namespace.
> 
> Signed-off-by: John Meneghini <jmeneghi@redhat.com>
> ---
>  drivers/nvme/host/core.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index c2b7e6834535..465069c0f6a8 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3938,6 +3938,15 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
>  	} else {
>  		sprintf(disk->disk_name, "nvme%dn%d", ctrl->instance,
>  			ns->head->instance);
> +#ifndef CONFIG_NVME_MULTIPATH

This can use IS_ENABLED to clean the code up a bit.

> +		if ((ctrl->subsys->cmic & NVME_CTRL_CMIC_MULTI_CTRL) && info->is_shared) {

overly long line.


