Return-Path: <linux-kernel+bounces-544257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C50EA4DF62
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E813188BCB5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 13:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96EA12045AB;
	Tue,  4 Mar 2025 13:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RdPkV5Eb"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F8E1E505
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 13:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741095345; cv=none; b=rp0mxY59BqT+V0cCJTm4BfviHLUtdJuF0/NTgFK2ercSGSrvSP/P8o4dbSbNwKO6MyhOZO+icM6kfigooabB2LTLB1k1b39FTdZZE1jMS0S5VzF8/Biw1hYQ5hkpDDkPv2VfT3OkhjaJO/Muf9HJ0Yj93y631P5KmOC1SPiG1fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741095345; c=relaxed/simple;
	bh=XSeHuB6ocRwPo+sLZUIVXBWvKQyopt6QwF9mv4NwgqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=axCGBCAJYmuFGBf5rYmBrbJA/JZaxapS+K6pi+JiF1YWSmjKRS4EXjxxusCW8bUvU9gZlNZpC9JSZqfLDgTbQmP63bHzqIIDBot0IJbVS2phv/0ELKsx1Opk4j+igDJSsCdRUQEYCCBoHD70pXFV5kFAbT5S/37GTHJs4v6Tlq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RdPkV5Eb; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43995b907cfso36299015e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 05:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741095341; x=1741700141; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O76uDqbBmf3rFbQrn4Mxp+kcp0bjlTkLWk8f6ScdEIg=;
        b=RdPkV5Eb8s5ZyOZBaxwK2TbP9YIDr5Zgt5apHIx6VNM8i8mB0/D2yAEeDWGkKIdWyg
         cI3Y0UFNVCrhqGOGPkkXEyHMWNzHnJ5xxzF7Oyzlkh9X/VWc3XBEdx1RLa+P9h+Wa4wT
         lobZM5m7lyo5BHPGn6eyODWYGSoh1Dn6tsSJomc9eznaiE7aObsCuo45arLOImWvgQVD
         GIiLh2wk6J8WHwoG97UxucH/6eVwHZ6mK3mHp0JjEZlNOBE6eB6tqV7sG4bph/WG9Vb5
         pIhayo5sRqlhi7FX9mrklLYrH5XHYE4KI96EsODR+ikndyhmxP9p9BjxIDLMgB0uJ6lr
         vUOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741095341; x=1741700141;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O76uDqbBmf3rFbQrn4Mxp+kcp0bjlTkLWk8f6ScdEIg=;
        b=eVHVU5u3IDbeLp7m1OfiwsA5nCgepCQoU0XJ5YaCn1sJfzR1KRH4biHRFnDYLCe01o
         EOJb6AqxmATKYDYtY9Q1RaliRC8hxEEr+4UFt3vVc5GWs/Z7vxeg39jRxj02lLvWAW2r
         TxOoiqJMEGaBObTLIuYe8FutJRcfK8g9spqJTj+Isi9KLIDZb3f5z2a2qlOE05Uln5e8
         KL7LiPLsCOWhQZ8MqdEkqQgO19yy9anUl2wS20inFfGpzeDV7rcMbObLM52J/2rqfDNq
         wPminpWir4m9ffuU6h/mH6mjlnRwxOKjMMTCMxuNNkzAvb+/7CTKj9oBWFuAe6dQHrQD
         sz4Q==
X-Forwarded-Encrypted: i=1; AJvYcCX7RimHm4NsmFacLmsp2aoFwiIdJf9r4vbbDXGj1ry/7i6IiIW35tTTXeFr3znW+ael93IUl/J8P10FRr0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPDIdYNxBVQSvQdtQhu9M4vb3MSOYWMuncOK5Y4MDVRScnSj5N
	Xk7bFUP2xfGi+UizUr3euTWmeAN39/otIlY1U0XGxNMxG10pEOularchmJkFcUQ=
X-Gm-Gg: ASbGncv65zJ7HUTmSnpzSXhicvPVNQtglG/Ohp6tc53LADgLyFxfd9rPe2WwcvZzJyY
	dbcYEikjSjvDi0lcOWkGvGM3YQXOWXIbgPCAay3ejO7K/7LpvQo/jM/uhH14BgTRWKgYdYpjHNN
	bMaCIb4/K/K02hIbYbj0fzyGDqj0HsHZ1QvrDt5xqVe+4BvDkUBfnIStafIg07JoYkwsA2M1cs/
	4tqqyPSzXNnNQ0AS3PfxN6KmLsqqRM2ijd10Wat7FibztVwhGbRaE8XADaFpnbJfKVLpMEt9iPJ
	Qa6W1S9kaCx8e2Lcp/gLiWoBv4uwzF3dpxkYJugeATpS6QRUwJ6HM+Qp6E71fum4/074LdkZlic
	wWXdrWfH3CQ==
X-Google-Smtp-Source: AGHT+IGK3euBVgNMsY02qpWDwml9sIebOqmYetENxzdJ5g6djs4fL6o19MEgkXHyoB+UC4TW1vMgtQ==
X-Received: by 2002:a05:600c:3513:b0:439:9f42:c137 with SMTP id 5b1f17b1804b1-43ba66e218emr164087295e9.11.1741095341439;
        Tue, 04 Mar 2025 05:35:41 -0800 (PST)
Received: from [192.168.0.35] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bcbcbfb2asm12012765e9.0.2025.03.04.05.35.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 05:35:41 -0800 (PST)
Message-ID: <664809e5-c027-4d0e-a604-d9fdf4b1f2da@linaro.org>
Date: Tue, 4 Mar 2025 13:35:40 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] media: venus: fix OOB access issue while reading
 sequence changed events
To: Vedang Nagar <quic_vnagar@quicinc.com>,
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250215-venus-security-fixes-v2-0-cfc7e4b87168@quicinc.com>
 <20250215-venus-security-fixes-v2-2-cfc7e4b87168@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20250215-venus-security-fixes-v2-2-cfc7e4b87168@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/02/2025 17:19, Vedang Nagar wrote:
> num_properties_changed is being read from the message queue but is
> not validated. Value can be corrupted from the firmware leading to
> OOB read access issues. Add fix to read the size of the packets as
> well and crosscheck before reading from the packet.
> 
> Signed-off-by: Vedang Nagar <quic_vnagar@quicinc.com>
> ---
>   drivers/media/platform/qcom/venus/hfi_msgs.c | 72 ++++++++++++++++++++++++----
>   1 file changed, 62 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/hfi_msgs.c b/drivers/media/platform/qcom/venus/hfi_msgs.c
> index 0a041b4db9efc549621de07dd13b4a3a37a70d11..2ad60a3fbfe0286de09a44664fc3b30259aa0368 100644
> --- a/drivers/media/platform/qcom/venus/hfi_msgs.c
> +++ b/drivers/media/platform/qcom/venus/hfi_msgs.c
> @@ -19,6 +19,16 @@
>   #define VER_STR_SZ		128
>   #define SMEM_IMG_OFFSET_VENUS	(14 * 128)
>   
> +static inline int increment_data_ptr(u8 *data_ptr, u32 *rem_bytes)
> +{
> +	if (*rem_bytes < sizeof(u32))
> +		return -EINVAL;
> +	data_ptr += sizeof(u32);
> +	*rem_bytes -= sizeof(u32);
> +
> +	return 0;
> +}
> +
>   static void event_seq_changed(struct venus_core *core, struct venus_inst *inst,
>   			      struct hfi_msg_event_notify_pkt *pkt)
>   {
> @@ -33,8 +43,8 @@ static void event_seq_changed(struct venus_core *core, struct venus_inst *inst,
>   	struct hfi_buffer_requirements *bufreq;
>   	struct hfi_extradata_input_crop *crop;
>   	struct hfi_dpb_counts *dpb_count;
> +	u32 ptype, rem_bytes;
>   	u8 *data_ptr;
> -	u32 ptype;
>   
>   	inst->error = HFI_ERR_NONE;
>   
> @@ -56,66 +66,108 @@ static void event_seq_changed(struct venus_core *core, struct venus_inst *inst,
>   	}
>   
>   	data_ptr = (u8 *)&pkt->ext_event_data[0];
> +	rem_bytes = pkt->shdr.hdr.size - sizeof(*pkt);
> +	if (rem_bytes - 4 < 0) {
> +		inst->error = HFI_ERR_SESSION_INSUFFICIENT_RESOURCES;
> +		goto done;
> +	}

This doesn't make sense.

u32 rem_bytes;

if (rem_bytes - 4 < 0)


> +
>   	do {
>   		ptype = *((u32 *)data_ptr);
>   		switch (ptype) {
>   		case HFI_PROPERTY_PARAM_FRAME_SIZE:
> -			data_ptr += sizeof(u32);
> +			if (increment_data_ptr(data_ptr, &rem_bytes))
> +				break;
> +			if (rem_bytes < sizeof(struct hfi_framesize))
> +				break;

In every case you are return -EINVAL but not setting

inst->error = HFI_ERR_SESSION_INSUFFICIENT_RESOURCES;

surely that is a natural and logical outcome of running out of buffer 
and a fact you'd want to communicate outside of the driver, rather than 
silent failing in this switch ?

---
bod

