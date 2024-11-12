Return-Path: <linux-kernel+bounces-405845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A19D9C5889
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 14:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A300B378E6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 12:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E13E1F77A6;
	Tue, 12 Nov 2024 12:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C7cDdtyZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9A52309AA
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 12:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731415329; cv=none; b=e5px8vxdLI39JhExoe7gLSAvSRvh042dwIxnzjk85ZqsSrjSEjmdT2RvBm6r9Rm/TaMm1Q+pTamQBkvjRJYMh63BMul2moWtFbpt/q2lcGd3N1gJPahP2/pW9jONylweL4zBMYL9FWs/6LPf/PTln5btVDfkYA/STUfLbDV3AQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731415329; c=relaxed/simple;
	bh=chn0Og9dknh9NFD1+hug6TJ2cJiq2gS7K5SjC3tf5F0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nytSfZB7hTa1a27xO93PvFiUMIdo5+H35GFGO74n7YlJ2USrgJQWRX1mmfex0fXVQN11omMiSJJ4iMQ0A17ohHAP/crN078EUHJTXwv6nU4vGy4HAGpFoTEPGQHAK4TIS5zIKACqONIOcwjDUBJyH6N/NN40kBrLiN0pAW7O9+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C7cDdtyZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731415326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wDLehEjuNsFPCSJ4jDeCsWR7/ytRVPGdGFIf0zIq5Rk=;
	b=C7cDdtyZrYtRkivb1E1UR8lSjefeHlmpSn32uXJHdV6CO/FE7/6tv702wgrMwQtDWkxlQk
	wBFf5sK+43CqqTSnIl5XG3fEPms5IYmymldLwjSegB3D56zM8ThDwTrdy14G+MbjR1AYKs
	uqYmwF8UapOngQYs7EfClZomtGQqp+A=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-CYhE2ZH3OpW_RZMD_IZGgA-1; Tue, 12 Nov 2024 07:42:03 -0500
X-MC-Unique: CYhE2ZH3OpW_RZMD_IZGgA-1
X-Mimecast-MFC-AGG-ID: CYhE2ZH3OpW_RZMD_IZGgA
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6cbd2cb2f78so110522336d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 04:42:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731415323; x=1732020123;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wDLehEjuNsFPCSJ4jDeCsWR7/ytRVPGdGFIf0zIq5Rk=;
        b=R3Q4xh39+mwaS2IJdvMlmjGma9CJ0OV3pqcJgH4A20gn1NN+wNKpJRKljHW4/54jZD
         xjXfl9g9vLhkhtBjkhYfoV8zuL4Y3wH/NKJFADIlR1Or6vTEz+eUQcZ+Es1Ponazw3YR
         A+AjhEHDQjtR5Q5U+d6Rr8ldkemwqbVi+bM2kv8vXzm4wawZJ6q9EpZmDwTbI0mOH8vs
         JRw5OQc7H6S+kjhI+B91xEOhrXJrIJmfR+3+T08GCkh3E/mr18Bblf2jRun7pYG8CjD1
         8cLwqVNuzXsAN1CXY/eCq8HVwZyM/245B3qJnDs5Ots4UDf267R+j6IficdvIA8NWDcQ
         CK/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVG1NNzPOc7CgYj/IFweXyiypAz5pGqCHOfplJCoB1uPkb1YCU/DpKVJw9zwHzYhmeBuwh2aoy+nJ+9LGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgMZ/vZd2fVvpgudXqPhbw6Pxfw0xrPxc0AB8mD5RVtZTtvZ+4
	45fxINN/K7BCDVFrt8Q5iXtuWmDKTzA9kWOIpoeKxc+0GvtB0RJB/+n7BiSnsUS1hJIvlm9tngL
	NT9MYcjI/V2wapDR4HRaetmIwBHXvtFHljNhuuORqMJc78Hg/h/4q0MzjDktygw==
X-Received: by 2002:a05:6214:469c:b0:6cb:81ba:8ac1 with SMTP id 6a1803df08f44-6d39e239cc4mr278418006d6.0.1731415323018;
        Tue, 12 Nov 2024 04:42:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGWKpKe63uXm6m6ge9fO7av9h0wMJ5vFHEYuk+a846d4GvgyTt2A4xoaqDo6lq2M33RyfUSrg==
X-Received: by 2002:a05:6214:469c:b0:6cb:81ba:8ac1 with SMTP id 6a1803df08f44-6d39e239cc4mr278417706d6.0.1731415322679;
        Tue, 12 Nov 2024 04:42:02 -0800 (PST)
Received: from [192.168.88.24] (146-241-44-112.dyn.eolo.it. [146.241.44.112])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d3983445f0sm69184166d6.83.2024.11.12.04.42.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 04:42:02 -0800 (PST)
Message-ID: <c9d61267-4bc8-4c1e-a3a2-ff1cbd46f7a5@redhat.com>
Date: Tue, 12 Nov 2024 13:41:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v9 5/8] cn10k-ipsec: Add SA add/del support for
 outb ipsec crypto offload
To: Bharat Bhushan <bbhushan2@marvell.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, sgoutham@marvell.com, gakula@marvell.com,
 sbhatta@marvell.com, hkelam@marvell.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, jerinj@marvell.com,
 lcherian@marvell.com, ndabilpuram@marvell.com, sd@queasysnail.net
References: <20241108045708.1205994-1-bbhushan2@marvell.com>
 <20241108045708.1205994-6-bbhushan2@marvell.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241108045708.1205994-6-bbhushan2@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/8/24 05:57, Bharat Bhushan wrote:
> This patch adds support to add and delete Security Association
> (SA) xfrm ops. Hardware maintains SA context in memory allocated
> by software. Each SA context is 128 byte aligned and size of
> each context is multiple of 128-byte. Add support for transport
> and tunnel ipsec mode, ESP protocol, aead aes-gcm-icv16, key size
> 128/192/256-bits with 32bit salt.
> 
> Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> ---
> v8->v9:
>  - Previous versions were supporting only 64 SAs and a bitmap was
>    used for same. That limitation is removed from this version.
>  - Replaced netdev_err with NL_SET_ERR_MSG_MOD in state add flow
>    as per comment in previous version 
>  - Changes related to mutex lock removal 
> 
> v5->v6:
>  - In ethtool flow, so not cleanup cptlf if SA are installed and
>    call netdev_update_features() when all SA's are un-installed.
>  - Description and comment re-word to replace "inline ipsec"
>    with "ipsec crypto offload"
> 
> v3->v4:
>  - Added check for crypto offload (XFRM_DEV_OFFLOAD_CRYPTO)
>    Thanks "Leon Romanovsky" for pointing out
> 
> v2->v3:
>  - Removed memset to zero wherever possible
>   (comment from Kalesh Anakkur Purayil)
>  - Corrected error handling when setting SA for inbound
>    (comment from Kalesh Anakkur Purayil)
>  - Move "netdev->xfrmdev_ops = &cn10k_ipsec_xfrmdev_ops;" to this patch
>    This fix build error with W=1
> 
>  .../marvell/octeontx2/nic/cn10k_ipsec.c       | 415 ++++++++++++++++++
>  .../marvell/octeontx2/nic/cn10k_ipsec.h       | 113 +++++
>  2 files changed, 528 insertions(+)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
> index e09ce42075c7..ccbcc5001431 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
> @@ -375,6 +375,391 @@ static int cn10k_outb_cpt_clean(struct otx2_nic *pf)
>  	return ret;
>  }
>  
> +static void cn10k_cpt_inst_flush(struct otx2_nic *pf, struct cpt_inst_s *inst,
> +				 u64 size)
> +{
> +	struct otx2_lmt_info *lmt_info;
> +	u64 val = 0, tar_addr = 0;
> +
> +	lmt_info = per_cpu_ptr(pf->hw.lmt_info, smp_processor_id());
> +	/* FIXME: val[0:10] LMT_ID.
> +	 * [12:15] no of LMTST - 1 in the burst.
> +	 * [19:63] data size of each LMTST in the burst except first.
> +	 */
> +	val = (lmt_info->lmt_id & 0x7FF);
> +	/* Target address for LMTST flush tells HW how many 128bit
> +	 * words are present.
> +	 * tar_addr[6:4] size of first LMTST - 1 in units of 128b.
> +	 */
> +	tar_addr |= pf->ipsec.io_addr | (((size / 16) - 1) & 0x7) << 4;
> +	dma_wmb();
> +	memcpy((u64 *)lmt_info->lmt_addr, inst, size);
> +	cn10k_lmt_flush(val, tar_addr);
> +}
> +
> +static int cn10k_wait_for_cpt_respose(struct otx2_nic *pf,
> +				      struct cpt_res_s *res)
> +{
> +	unsigned long timeout = jiffies + msecs_to_jiffies(10000);
> +
> +	do {
> +		if (time_after(jiffies, timeout)) {
> +			netdev_err(pf->netdev, "CPT response timeout\n");
> +			return -EBUSY;
> +		}
> +	} while (res->compcode == CN10K_CPT_COMP_E_NOTDONE);

Why a READ_ONCE() annotation is not needed around the 'res->compcode'
access?

Possibly more relevant: it looks like this code is busy polling the H/W
for at most 10s, is that correct? If so that timeout is way too high my
several order of magnitude. You should likely use usleep_range() or
sleep_interruptible()

[...]
> +static int cn10k_ipsec_validate_state(struct xfrm_state *x,
> +				      struct netlink_ext_ack *extack)
> +{
> +	if (x->props.aalgo != SADB_AALG_NONE) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Cannot offload authenticated xfrm states\n");

No '\n' at the end of extack messages.

(many cases below)

Thanks,

Paolo


