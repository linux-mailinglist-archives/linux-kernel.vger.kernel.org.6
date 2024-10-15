Return-Path: <linux-kernel+bounces-366908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1830D99FC26
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 01:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0F8F285783
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 23:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0F41C75F9;
	Tue, 15 Oct 2024 23:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lBcZsQE9"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D303C173357
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 23:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729033980; cv=none; b=ac45nyjBgOPqC+uXcKLDD9/A3IQT5q78ujGwkX8tByKTHj0KwakGRjK8V5iioJZP/vN8zKM0gxwwV54OOfMs9EnsTN11dsReArVLbde6QBIpj0i3bb+BxqhhssC0DNoRDjUFLH7b33nYOgUaBGSs42CU/kti9L4F6k1XFF+FLiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729033980; c=relaxed/simple;
	bh=RWqlw+8u2Zt41/yQztVKI9ZpheCOIPjne05sgHhv6x0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rOzsaxYJy9UTO1rylNWifm5iqrVbMDCOvj5JeT11c/bOnoOw+418llACR8Z3Y2FotLAI9zFEm2bJ6uopM6lEDhnmDAGPeg1MqZ0vtGAMQLZZpOlglfj9YE7XOz9i8aQQrcni33yBztwwT2QxoeR11qUiDnbJn/A+j8IsUMbLCTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lBcZsQE9; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a9a16b310f5so326420366b.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 16:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729033977; x=1729638777; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YsTfxtNmSnHSpS1GVrU4G72wmYQhb3/HlyX+GQvuTPk=;
        b=lBcZsQE97tFzXi2+wfImI9U4aDBdWTPbe9iBTHPCnhk/LYw3TduvMgSeYUQOplgcLz
         KHVaugQdQWv4tOsbCa0AA5s5TiUHAy2iiv1C5tilQvQ9y3Y0rnggsvv5xs6cwLLswjIe
         mxCMYaWtxfzcPAdex2Lz7n7ICyISP5GP3mYrFcL4FxefQy7eXWzAOh1V6RJrCxUKE5Ko
         gDgeuadXO1sOrP47WKDwYvvsQJuaNTTdi4KPnrtJlS/RXR++ecEIkeQI4qGRv8maasII
         v7vZ5iQdBBocx2gRlQTgGLJOtowyDsLozZDDy61gw38uzPiMCmT6s1CKmmzxUaphMwXY
         mwPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729033977; x=1729638777;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YsTfxtNmSnHSpS1GVrU4G72wmYQhb3/HlyX+GQvuTPk=;
        b=QuedsHBDi8ohRhGnTqPrrUo99jc6oP+MMBTdXZs1ZwMSOy/ElBgfqEKX7LFNul7WQF
         2T3DkCcFb5dL5h0eZKDXM3DD+I+eXfyOviiYdYw1cLzit31s86PDD1m59AdL4V4vnVOS
         VanTWfM6ELYedibnsaIxLd2pVUB7WW6ObAXATQYJq3tS/elrd6/ZOh6uh0sRPd3mQMuu
         MvdiwKlME4rn1epl3uWK80+IK1OISEGkr6G1vITYfpyPOY8Dt3kFfM1bgMnBYUCEk/9H
         8D8SKHWURmHhEfx5vPX0qAnumvOYPg6PquwlqXKVyAbXPdWvbDy3//3y301bRSZ1vKn9
         rOgg==
X-Forwarded-Encrypted: i=1; AJvYcCXnhBLbCxg7PcqjxywfFw+7nJdftTtZHDDDxXUe48vnNRG2CWxjDyY+YL6GOl1pM1LrUA3dsY5uLH9t++0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLL/2nauRpH/52uBAAy51WYdvoKDE1Xq1cVAvvZ2hyHTHQuvju
	RKbvJ6QiI2ZDNoYH3cT81SPtQyWszwnCn3mrF29tKgs5H8unpHwRTPAIrLVP5N0=
X-Google-Smtp-Source: AGHT+IEWzh2eNvnTzVKZKXexuSdzn+yKYxn62+JRj0yBk79QfJhJYmXwkzy1tfmjdbM0eQKmrbxOng==
X-Received: by 2002:a17:907:3f8a:b0:a99:f4c3:580d with SMTP id a640c23a62f3a-a99f4c35955mr1127076466b.42.1729033977197;
        Tue, 15 Oct 2024 16:12:57 -0700 (PDT)
Received: from [192.168.0.40] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a29844899sm116776766b.178.2024.10.15.16.12.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 16:12:56 -0700 (PDT)
Message-ID: <079045ac-27e7-43f4-a4a4-bc9d03de61c8@linaro.org>
Date: Wed, 16 Oct 2024 00:12:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] media: venus: Helper function for dynamically
 updating bitrate
To: Fritz Koenig <frkoenig@chromium.org>,
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Dikshita Agarwal <quic_dikshita@quicinc.com>
Cc: Nathan Hebert <nhebert@chromium.org>, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240814-submit-v3-0-f7d05e3e8560@chromium.org>
 <20240814-submit-v3-1-f7d05e3e8560@chromium.org>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20240814-submit-v3-1-f7d05e3e8560@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/08/2024 23:14, Fritz Koenig wrote:
> Move the dynamic bitrate updating functionality to a separate function
> so that it can be shared.
> 
> No functionality changes.
> 
> Signed-off-by: Fritz Koenig <frkoenig@chromium.org>
> ---
>   drivers/media/platform/qcom/venus/venc_ctrls.c | 34 +++++++++++++++-----------
>   1 file changed, 20 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/venc_ctrls.c b/drivers/media/platform/qcom/venus/venc_ctrls.c
> index d9d2a293f3ef..3e1f6f26eddf 100644
> --- a/drivers/media/platform/qcom/venus/venc_ctrls.c
> +++ b/drivers/media/platform/qcom/venus/venc_ctrls.c
> @@ -67,12 +67,28 @@ static int venc_calc_bpframes(u32 gop_size, u32 conseq_b, u32 *bf, u32 *pf)
>   	return 0;
>   }
>   
> +static int dynamic_bitrate_update(struct venus_inst *inst, u32 bitrate,
> +				  u32 layer_id)
> +{
> +	int ret = 0;
> +
> +	mutex_lock(&inst->lock);
> +	if (inst->streamon_out && inst->streamon_cap) {
> +		u32 ptype = HFI_PROPERTY_CONFIG_VENC_TARGET_BITRATE;
> +		struct hfi_bitrate brate = { .bitrate = bitrate, .layer_id = layer_id };
> +
> +		ret = hfi_session_set_property(inst, ptype, &brate);
> +	}
> +	mutex_unlock(&inst->lock);
> +
> +	return ret;
> +}
> +
>   static int venc_op_s_ctrl(struct v4l2_ctrl *ctrl)
>   {
>   	struct venus_inst *inst = ctrl_to_inst(ctrl);
>   	struct venc_controls *ctr = &inst->controls.enc;
>   	struct hfi_enable en = { .enable = 1 };
> -	struct hfi_bitrate brate;
>   	struct hfi_ltr_use ltr_use;
>   	struct hfi_ltr_mark ltr_mark;
>   	u32 bframes;
> @@ -85,19 +101,9 @@ static int venc_op_s_ctrl(struct v4l2_ctrl *ctrl)
>   		break;
>   	case V4L2_CID_MPEG_VIDEO_BITRATE:
>   		ctr->bitrate = ctrl->val;
> -		mutex_lock(&inst->lock);
> -		if (inst->streamon_out && inst->streamon_cap) {
> -			ptype = HFI_PROPERTY_CONFIG_VENC_TARGET_BITRATE;
> -			brate.bitrate = ctr->bitrate;
> -			brate.layer_id = 0;
> -
> -			ret = hfi_session_set_property(inst, ptype, &brate);
> -			if (ret) {
> -				mutex_unlock(&inst->lock);
> -				return ret;
> -			}
> -		}
> -		mutex_unlock(&inst->lock);
> +		ret = dynamic_bitrate_update(inst, ctr->bitrate, 0);
> +		if (ret)
> +			return ret;
>   		break;
>   	case V4L2_CID_MPEG_VIDEO_BITRATE_PEAK:
>   		ctr->bitrate_peak = ctrl->val;
> 

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

