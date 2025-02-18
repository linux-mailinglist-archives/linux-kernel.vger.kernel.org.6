Return-Path: <linux-kernel+bounces-519618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D50AAA39F89
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 15:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ACA3188E10E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 14:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221A926B95F;
	Tue, 18 Feb 2025 14:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DHSy1I3B"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE6226A1C7
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 14:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739888820; cv=none; b=rqjSpLm3FM9DGTgOyS2c2MCQvw48xq67zIM320Ng0Xh0uhZNPabCpfNfJmo7Bq6cebfVOPAA41Jb3CR4fZhBwn5a3XW9g6+74SLIO1qpAgd224wHxlOoRleXZ8ozwJp06S8pTi44p2LFuc+PVfbSHuGpepAi1FcNfDWJ0iS7H50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739888820; c=relaxed/simple;
	bh=fAs3dRD0u6BFc+urwpqRLW7N8APiGaj+bD3c4M7v0yQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sI6THg3MFycEg1feVZup/hLe4tXQQ0eObp3iBF8E2IBMAZnARPjiK5C/h1q3Fy+Dhlqcf9tnKEXVnFxEy/WPDdm+eb/zYm6SRCIpiD+2eJ1eO4O1ZZlJ63t3zUuv81jEmo00sxm/DVAaLAqCnjlnMntswM5wuD7f9L8sza6vACY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DHSy1I3B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739888816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b9YdB2lf/xAULty1c3rpqiX1ztJ6KQXsmrrMcR64c6s=;
	b=DHSy1I3Bj5mFh3WY/cPpfT37ZXxN1Q0SO9/cdmYv5U38ICbjZlvDaVlDcIT9RXVQU6aa8Y
	PQ4VwGL09/GvkF7GSyOvqGra3VoQFrE+9eB2NqQMcpgM/J9DdSFKxLvJG0tqc2zOAVPg/t
	6M+8fp3X8E7rgjoTM2psvIoe7CIcHIQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-141-ONeTPkMZNVmZOCsw6QROjg-1; Tue,
 18 Feb 2025 09:26:51 -0500
X-MC-Unique: ONeTPkMZNVmZOCsw6QROjg-1
X-Mimecast-MFC-AGG-ID: ONeTPkMZNVmZOCsw6QROjg_1739888810
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A79C219030AC;
	Tue, 18 Feb 2025 14:26:49 +0000 (UTC)
Received: from [10.22.65.116] (unknown [10.22.65.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7AA5F19560A3;
	Tue, 18 Feb 2025 14:26:47 +0000 (UTC)
Message-ID: <b37a4f6c-95a9-430d-89f9-141b72fd6be8@redhat.com>
Date: Tue, 18 Feb 2025 09:26:46 -0500
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Bryan, since we are re-spinning this patch please make the changes below.

On 2/4/25 4:11 PM, Bryan Gurney wrote:
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 2bcd9f710cb6..b07cd482fbc1 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3809,14 +3809,6 @@ static int nvme_init_ns_head(struct nvme_ns *ns, struct nvme_ns_info *info)
>   					info->nsid);
>   			goto out_put_ns_head;
>   		}
> -
> -		if (!multipath) {
> -			dev_warn(ctrl->device,
> -				"Found shared namespace %d, but multipathing not supported.\n",
> -				info->nsid);
> -			dev_warn_once(ctrl->device,
> -				"Support for shared namespaces without CONFIG_NVME_MULTIPATH is deprecated and will be removed in Linux 6.0.\n");
> -		}

I think we want to keep a similar warning like the above, only move it down below.

Let's wait for Sagi's approval of the exact message.

>   	}
>   
>   	list_add_tail_rcu(&ns->siblings, &head->list);
> @@ -3915,12 +3907,14 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
>   		sprintf(disk->disk_name, "nvme%dc%dn%d", ctrl->subsys->instance,
>   			ctrl->instance, ns->head->instance);
>   		disk->flags |= GENHD_FL_HIDDEN;
> -	} else if (multipath) {
> +	} else {
> +#ifdef CONFIG_NVME_MULTIPATH
>   		sprintf(disk->disk_name, "nvme%dn%d", ctrl->subsys->instance,
>   			ns->head->instance);
> -	} else {
 > +#else

You don't need the this #ifdef conditional statement because the nvme_ns_head_multipath() function checks CONFIG_NVME_MULTIPATH
for you and the sprintf(disk->disk_name, "nvme%dn%d" statement is kind of redundant.


>   		sprintf(disk->disk_name, "nvme%dn%d", ctrl->instance,
>   			ns->head->instance);
> +#endif
>   	}
>   
>   	if (nvme_update_ns_info(ns, info))

Thanks,

/John


