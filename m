Return-Path: <linux-kernel+bounces-283217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D777494EEBB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 15:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ECC02831B2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 13:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E1D17C9FE;
	Mon, 12 Aug 2024 13:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xt3d1OPf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE0A17C7BD
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 13:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723470579; cv=none; b=bQAZ0AWCU7EX7MOwlkpanen0ZkJbki3eQdNKBAQe2D/4+GzJUBqy1Bzy4T6B1bx+u9tVZZv+lprlUNUWd08Zyr9G9odVKrcvGVxNyIETwspnsAQITkxQmevIpkhwouQrdRbbMI0xG4//pIlTpge7o5xqXgWxKmCZoJ6JiXz/9G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723470579; c=relaxed/simple;
	bh=+vX0WcMYp0ADVbGL9UAp0+5o+3Z3WsCo9EMAN7YgIkM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NuhIB1f4viibvPwNDRGEKG2OJuWcZ2AKOHYPVs9Xaqr+J9cvnoxzcUcC5fW6fFmYGI/ObjBSpNcdpyZegU+YQ9k8c8yeYz88Gah0ryJJHiJDKRoqZ6DGVPkQ2sIFjtpxQL6ie7IuYBBZxxb4crrjktv09HigB0qlnBKzBKxiXSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xt3d1OPf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723470575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4L2BKBldGmTgWegBX3tar5oC0/S4jMH9FREzmdYBeQM=;
	b=Xt3d1OPfPBTgmoJW5vTrPaMPC7LW6s3Dwc3zH0jsiiT3sxS/fekO9iu0o8L5/JqDmRjtmv
	JcYGl+DgsMaQC+baLuJ9/YUKuqtle4Pa260fDsmxKs2lSBTlYYP4frhbwVszgzUqSnSoRX
	XgswOM9ikeWdmHPlnGEdgj7cLonAMng=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-QPBdceeQPNaMqbinzS-2WQ-1; Mon, 12 Aug 2024 09:49:33 -0400
X-MC-Unique: QPBdceeQPNaMqbinzS-2WQ-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5bb8fc3df4aso3361857a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 06:49:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723470572; x=1724075372;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4L2BKBldGmTgWegBX3tar5oC0/S4jMH9FREzmdYBeQM=;
        b=kulLW9q+XFZLAV52+IIud/0Jcr5jjfcR3uUpCboHzpStZvsPlvI7UCg2pwvdV+DQTY
         2uP8xyO1ZSAsviGOO1YfninR3lS2V4loVJzVyIB7hpu0CPvTo6Pxu2kAOmZwb1Kk7Dh0
         urbS43+zq2Egp13C2g3mqpFf8Amg1P1adF8WrqVISTvUVB+LMcVCQNvs7uDUuSPLr3ke
         5skBg2/o5LvzisjlQcTTdKOkQ7NDggK47Tzxh8CFJCT+ExJLOQ6gLoIEXaM7JC29atTr
         zcHNNYG0/8y4RI1pQGlUbiXOrDddbb0jpCqpezS2HVauoK3tA2DHkItvaNMilK1KMgfB
         2LYw==
X-Forwarded-Encrypted: i=1; AJvYcCUKCMM59598HjN2wPIbl8Jdgk9HqMzYHit1MWSpxYTw0Ad7jz2dcGesYVpULsZn42S17dsW1SI+X+eiUnk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yylh9/3L9k/bmwUyx/YIxXN7pBnIo7ejMW+DnkumOjrmZwXnfRM
	xVcQXTUz3rRZ+emWsfZCOoYd2nv+HvGgVGXiFAYOAH+iFhFfkJi9S3P/aW8lDjOBeKxuHBcS9gz
	opZ42jSiR8/DtiG2TlbLmKekoNNh883ofLUIcFatPa/MVmkJph0k2RqOr5031s118V4Vi+w==
X-Received: by 2002:a05:6402:40cc:b0:5bb:9ae0:4a4b with SMTP id 4fb4d7f45d1cf-5bd44c10131mr316692a12.7.1723470571740;
        Mon, 12 Aug 2024 06:49:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjXk8VpKyXfEM+J7aLarCyM7RNef3VHKx4k31tFTSzBJt1OSgtDuCMkUf2DvrwpAxI5uLOXg==
X-Received: by 2002:a05:6402:40cc:b0:5bb:9ae0:4a4b with SMTP id 4fb4d7f45d1cf-5bd44c10131mr316674a12.7.1723470571231;
        Mon, 12 Aug 2024 06:49:31 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd187f2abasm2105719a12.8.2024.08.12.06.49.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Aug 2024 06:49:30 -0700 (PDT)
Message-ID: <7225c299-6086-499a-8dfd-cbc5a8fcc7b6@redhat.com>
Date: Mon, 12 Aug 2024 15:49:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] platform/x86/intel/pmc: Show live substate
 requirements
To: Kane Chen <kane.chen@intel.com>, linux-kernel@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, ilpo.jarvinen@linux.intel.com
References: <20240719122807.3853292-1-kane.chen@intel.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240719122807.3853292-1-kane.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 7/19/24 2:28 PM, Kane Chen wrote:
> While debugging runtime s0ix, we do need to check which required IPs
> are not power gated. This patch adds code to show live substate status
> vs requirements in sys/kernel/debug/pmc_core/substate_requirements to
> help runtime s0ix debug.
> 
> Signed-off-by: Kane Chen <kane.chen@intel.com>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans



> ---
>  drivers/platform/x86/intel/pmc/core.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
> index 2ad2f8753e5d4..b93ecc5169745 100644
> --- a/drivers/platform/x86/intel/pmc/core.c
> +++ b/drivers/platform/x86/intel/pmc/core.c
> @@ -791,13 +791,15 @@ static void pmc_core_substate_req_header_show(struct seq_file *s, int pmc_index)
>  	pmc_for_each_mode(i, mode, pmcdev)
>  		seq_printf(s, " %9s |", pmc_lpm_modes[mode]);
>  
> -	seq_printf(s, " %9s |\n", "Status");
> +	seq_printf(s, " %9s |", "Status");
> +	seq_printf(s, " %11s |\n", "Live Status");
>  }
>  
>  static int pmc_core_substate_req_regs_show(struct seq_file *s, void *unused)
>  {
>  	struct pmc_dev *pmcdev = s->private;
>  	u32 sts_offset;
> +	u32 sts_offset_live;
>  	u32 *lpm_req_regs;
>  	int num_maps, mp, pmc_index;
>  
> @@ -811,6 +813,7 @@ static int pmc_core_substate_req_regs_show(struct seq_file *s, void *unused)
>  		maps = pmc->map->lpm_sts;
>  		num_maps = pmc->map->lpm_num_maps;
>  		sts_offset = pmc->map->lpm_status_offset;
> +		sts_offset_live = pmc->map->lpm_live_status_offset;
>  		lpm_req_regs = pmc->lpm_req_regs;
>  
>  		/*
> @@ -828,6 +831,7 @@ static int pmc_core_substate_req_regs_show(struct seq_file *s, void *unused)
>  		for (mp = 0; mp < num_maps; mp++) {
>  			u32 req_mask = 0;
>  			u32 lpm_status;
> +			u32 lpm_status_live;
>  			const struct pmc_bit_map *map;
>  			int mode, idx, i, len = 32;
>  
> @@ -842,6 +846,9 @@ static int pmc_core_substate_req_regs_show(struct seq_file *s, void *unused)
>  			/* Get the last latched status for this map */
>  			lpm_status = pmc_core_reg_read(pmc, sts_offset + (mp * 4));
>  
> +			/* Get the runtime status for this map */
> +			lpm_status_live = pmc_core_reg_read(pmc, sts_offset_live + (mp * 4));
> +
>  			/*  Loop over elements in this map */
>  			map = maps[mp];
>  			for (i = 0; map[i].name && i < len; i++) {
> @@ -868,6 +875,9 @@ static int pmc_core_substate_req_regs_show(struct seq_file *s, void *unused)
>  				/* In Status column, show the last captured state of this agent */
>  				seq_printf(s, " %9s |", lpm_status & bit_mask ? "Yes" : " ");
>  
> +				/* In Live status column, show the live state of this agent */
> +				seq_printf(s, " %11s |", lpm_status_live & bit_mask ? "Yes" : " ");
> +
>  				seq_puts(s, "\n");
>  			}
>  		}


