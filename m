Return-Path: <linux-kernel+bounces-519664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDC8A3A077
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 15:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDF663B67DC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 14:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D547C26A0EC;
	Tue, 18 Feb 2025 14:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AfIU3O0n"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D8324113C
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 14:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739889830; cv=none; b=WQa79ZCmQwtx20k5qXe+dkCFwCi9gcCwOMda7r7sitJeJY1acxscMlBPfOq2OqukT3FfLFpC5A2rQaDhTtloWQLNiEscDcxtUpc01MJyhcgiJ0hpMERN/eVO5VsjhxEuI1ItSPHHifeyq2IJIYId3SSx+WqdF+p01J7VzolkbgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739889830; c=relaxed/simple;
	bh=h8DEt1/6IHk73Srir2K3HMIdQ2xbglOD0uGMGqLPCeU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bEexfr/Pj95O4sztYQcJkEKqbkmNJWQuyplapVWj9y3UPzyLuP6LmnjZbCKImllNWsMd5rFvT/PHI9hS2RuhC/Qjj1kWrw4E0MOzPKs5h925yL0asmibJLnZ2RiNjX7wKxTwjZJmPRrKa9LHI36HH+KQTO9lg6T3I0xz+7ylOro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AfIU3O0n; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739889827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OLp9JRNVUhT0m1v0T73vab4YaM/Pfh0Xi9X9EVQSmqg=;
	b=AfIU3O0n4h2Cd6+EQqBLqzPKdEMckV6jHV/y6r0BEXTjWT1sVJJJIfVwd8Kr80VkMB6fTR
	f6E9TSkmZXVaX3ppu0Q9LDRWXDKsZgeLpGopuXm7mztNFM7cSz6TjyQlATSw2OepypH9Tp
	ITid6uGjUZ5LtHmOdrwZb6jSsSdcgX0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-rPY--Uj5NOyhtVFz1p5B2w-1; Tue,
 18 Feb 2025 09:43:43 -0500
X-MC-Unique: rPY--Uj5NOyhtVFz1p5B2w-1
X-Mimecast-MFC-AGG-ID: rPY--Uj5NOyhtVFz1p5B2w_1739889822
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D5A681800874;
	Tue, 18 Feb 2025 14:43:41 +0000 (UTC)
Received: from [10.22.65.116] (unknown [10.22.65.116])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2B8E21956094;
	Tue, 18 Feb 2025 14:43:40 +0000 (UTC)
Message-ID: <21abd9e4-de2f-4d9e-a6d2-700b3d326524@redhat.com>
Date: Tue, 18 Feb 2025 09:43:39 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: remove multipath module parameter
To: Bryan Gurney <bgurney@redhat.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me, axboe@kernel.dk
Cc: bmarzins@redhat.com
References: <20250204211158.43126-1-bgurney@redhat.com>
Content-Language: en-US
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <20250204211158.43126-1-bgurney@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Bryan,  See my comments below.

On 2/4/25 4:11 PM, Bryan Gurney wrote:
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index a85d190942bd..28ab868182b2 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -9,11 +9,6 @@
>   #include <trace/events/block.h>
>   #include "nvme.h"
>   
> -bool multipath = true;
> -module_param(multipath, bool, 0444);
> -MODULE_PARM_DESC(multipath,
> -	"turn on native support for multiple controllers per subsystem");
> -
>   static const char *nvme_iopolicy_names[] = {
>   	[NVME_IOPOLICY_NUMA]	= "numa",
>   	[NVME_IOPOLICY_RR]	= "round-robin",
> @@ -632,9 +627,11 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
>   	 * We also do this for private namespaces as the namespace sharing flag
>   	 * could change after a rescan.
>   	 */
> +#ifdef CONFIG_NVME_MULTIPATH
>   	if (!(ctrl->subsys->cmic & NVME_CTRL_CMIC_MULTI_CTRL) ||
> -	    !nvme_is_unique_nsid(ctrl, head) || !multipath)
> +	    !nvme_is_unique_nsid(ctrl, head))
>   		return 0;
> +#endif

You don't need to add these #ifdef CONFIG_NVME_MULTIPATH conditional compile statements
to multipath.c because the multipath.c is not compiled when CONFIG_NVME_MULTIPATH=N.

These won't hurt anything, but they are redundant and we can make the patch smaller by removing them.

>   	blk_set_stacking_limits(&lim);
>   	lim.dma_alignment = 3;
> @@ -1038,10 +1035,11 @@ int nvme_mpath_init_identify(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
>   	size_t ana_log_size;
>   	int error = 0;
>   
> +#ifdef CONFIG_NVME_MULTIPATH
>   	/* check if multipath is enabled and we have the capability */
> -	if (!multipath || !ctrl->subsys ||
> -	    !(ctrl->subsys->cmic & NVME_CTRL_CMIC_ANA))
> +	if (!ctrl->subsys || !(ctrl->subsys->cmic & NVME_CTRL_CMIC_ANA))
>   		return 0;
> +#endif

Same here.

>   	/* initialize this in the identify path to cover controller resets */
>   	atomic_set(&ctrl->nr_active, 0);
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 2c76afd00390..6dea04f05b59 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -972,7 +972,6 @@ static inline void nvme_trace_bio_complete(struct request *req)
>   		trace_block_bio_complete(ns->head->disk->queue, req->bio);
>   }
>   

/John


