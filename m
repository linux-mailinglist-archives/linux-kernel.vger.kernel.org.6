Return-Path: <linux-kernel+bounces-548038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6B1A53F17
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 01:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFDE77A215C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 00:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E074AFC12;
	Thu,  6 Mar 2025 00:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VkwwWBuf"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644EC5672
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 00:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741220896; cv=none; b=Xn8jH0qQDnJpmcf8A9p3rFZ4UWLI2SYmYSUx0PWraJ5lLRVKX7QfXweNXx5WNW7z/RMVoJWWlbjLWNAkap2C5qilT0+3NKTRQwy+BUkfTaFRfSWwCoCLWpfoHBPU/0KnlXqEIwtRITpZYYj2Wz+lE291ENIE07B4XtdV+w68ymQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741220896; c=relaxed/simple;
	bh=l7IkmxhJKCqOpfwAPHGjlggNj4BTe7Zg69JAi3gfjF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L62suYqPBGpP6AQZRu/pUa93fppTllCHt5/6INJTAZ5hgkK+mieEe2T0SEl2kriPdKfYr1mAf6Qb5W0Bfq2b3l2yQY3C5RJgsNLb1qUgQwaCyVDOzEgbIHP27k7efSGRjhHwHe7btL1AjHEzvMokLs+G3ssTj5zsmwdpc4AXW3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VkwwWBuf; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-390fb1b987fso82358f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 16:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741220891; x=1741825691; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Pm97bU1p7cb7fMHRK51BDpV9RUcVY6lH9dKA/ipyBc=;
        b=VkwwWBufD+gQch648V2iWu2toR7S8ha55CQaU6trwOv066u2RgLM2uQn3Y6AZwOv5M
         oL7sC5ajSl2tqvy0EpaJo2zWrfPjW1jM3uf4pylwCgxNdQECLKph1hzBmVKJ2VYuCD5z
         kaU4tokYhClrEr2L+WrdfvpeK5t5vTnDIaI4fNWpg16FCpO7oGQ7DX9CB/8LrtGdZiBY
         W0ESNh34Xz/oVNhXjgEL4uiyVlRKsQFHI0boINaHY3Funu+lzja3D4FzEBX3iJguuw5y
         ICzKGezauqg2csAw1YHTxRrEy+aRWP3UknOAUVJToxtLDFvaaTQinlWuAjGotl96D47Z
         //hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741220891; x=1741825691;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Pm97bU1p7cb7fMHRK51BDpV9RUcVY6lH9dKA/ipyBc=;
        b=H87O3q6L3z14Zv/ug8iHS3IMOYgLJOSD4vPDqWfo+aQFSFPuN9hw3hs75hsF0ZRGIT
         EUpjKtQVCF++1VBasL75QdXMiK+9NmP6qikOpeJeJDAbPQD3PWTgDH+lim7cgJHSBw7K
         tJX1NpT6I93RyJRY9hUfAvyIqLZuS+ASno4YytIbqUJugDlLNdjHS4c3vcuEKediV/TC
         2W6wFAkkSRN4I1Hp3A7tY5BlZL8BZpf5lOXOrMXi724+Li1rTGUfPFImZsEfntUYlqJV
         0jLce9RsTBc7oHkmcQtq0UC0y+gM8xDUL7cjfuK9IKc4hl1Pm+ZUiMb36UuSk07Znprj
         Pq/w==
X-Forwarded-Encrypted: i=1; AJvYcCXQejV+CIndWtaG495PrLoFlCDXzy7e9OQ8rT89F+4oEc8S/rZNYjTVrL497KIonBiuKG0xVVHvpvbm7B4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZbLuEuUTJzUaakCJZY7qZc3DqJ/WEj0DvA8xa+F//+SkjAv1P
	NlpSzRyF2RbL2mBFXWL+t0UVgdLHBjZi6QG4oJGp1eilpRo3v5VqVPCbqx+XdNA=
X-Gm-Gg: ASbGnctmRqN1EBU8y01nZmYpD95WVGNUuuKZiawYBPlzRjeC2z5oxTEMV7CGYD/UcEB
	hR9xGB0CLtUnylgHcbiZ/2wUfFyDM6Vvh6BCtdQAE4PMJMV/MNzlopVg4oPkENuSl4HVqcy+R/e
	hTyBlK+ZXS2cnIkKfl1VtESwqJS0fBBL3kMM+Y7kg3/PjMR1WhX+orsXQLSBWHod20ZP4ZlZsQV
	NCpG/V9GIbzUd3QjU4JspuTMIUANWALdxNTOn/sRWulVJwCRz6GnJSPMNtb3vrl90XS1e5oQ3n9
	xOeykkB8crI/nM6kZM8yFXuzkpueAiXck6yby3HqqF0anOv/OzuU/4LYnOOg1sX92s/SmKJm+vH
	nlOSXBUahdw==
X-Google-Smtp-Source: AGHT+IF+WL61BrLlHQNOlUcTe4ptGJeJWmfrP/sGQ0/N6uW9lVQZ3x3bRcpntHSbzuDXG0SHCEvaNQ==
X-Received: by 2002:a5d:6da3:0:b0:391:2c67:7983 with SMTP id ffacd0b85a97d-3912c677ab7mr37532f8f.39.1741220891530;
        Wed, 05 Mar 2025 16:28:11 -0800 (PST)
Received: from [192.168.0.35] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfdff57sm129939f8f.37.2025.03.05.16.28.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 16:28:10 -0800 (PST)
Message-ID: <f4354a08-46e2-4bf5-9395-f9b861a9d7c8@linaro.org>
Date: Thu, 6 Mar 2025 00:28:09 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 02/12] media: iris: Add platform capabilities for HEVC
 and VP9 decoders
To: Dikshita Agarwal <quic_dikshita@quicinc.com>, quic_vgarodia@quicinc.com,
 quic_abhinavk@quicinc.com, mchehab@kernel.org
Cc: hverkuil@xs4all.nl, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250305104335.3629945-1-quic_dikshita@quicinc.com>
 <20250305104335.3629945-3-quic_dikshita@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20250305104335.3629945-3-quic_dikshita@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/03/2025 10:43, Dikshita Agarwal wrote:
> Add platform capabilities for HEVC and VP9 codecs in decoder driver
> with related hooks.
> 
> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> ---
>   drivers/media/platform/qcom/iris/iris_ctrls.c | 28 ++++++-
>   .../qcom/iris/iris_hfi_gen2_command.c         | 30 ++++++-
>   .../qcom/iris/iris_hfi_gen2_defines.h         |  1 +
>   .../qcom/iris/iris_hfi_gen2_response.c        | 36 ++++++++-
>   .../platform/qcom/iris/iris_platform_common.h |  9 ++-
>   .../platform/qcom/iris/iris_platform_sm8550.c | 80 ++++++++++++++++++-
>   6 files changed, 170 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/iris/iris_ctrls.c b/drivers/media/platform/qcom/iris/iris_ctrls.c
> index b690578256d5..fb2b818c7c5c 100644
> --- a/drivers/media/platform/qcom/iris/iris_ctrls.c
> +++ b/drivers/media/platform/qcom/iris/iris_ctrls.c
> @@ -20,9 +20,19 @@ static enum platform_inst_fw_cap_type iris_get_cap_id(u32 id)
>   	case V4L2_CID_MPEG_VIDEO_DECODER_MPEG4_DEBLOCK_FILTER:
>   		return DEBLOCK;
>   	case V4L2_CID_MPEG_VIDEO_H264_PROFILE:
> -		return PROFILE;
> +		return PROFILE_H264;
> +	case V4L2_CID_MPEG_VIDEO_HEVC_PROFILE:
> +		return PROFILE_HEVC;
> +	case V4L2_CID_MPEG_VIDEO_VP9_PROFILE:
> +		return PROFILE_VP9;
>   	case V4L2_CID_MPEG_VIDEO_H264_LEVEL:
> -		return LEVEL;
> +		return LEVEL_H264;
> +	case V4L2_CID_MPEG_VIDEO_HEVC_LEVEL:
> +		return LEVEL_HEVC;
> +	case V4L2_CID_MPEG_VIDEO_VP9_LEVEL:
> +		return LEVEL_VP9;
> +	case V4L2_CID_MPEG_VIDEO_HEVC_TIER:
> +		return TIER;
>   	default:
>   		return INST_FW_CAP_MAX;
>   	}
> @@ -36,10 +46,20 @@ static u32 iris_get_v4l2_id(enum platform_inst_fw_cap_type cap_id)
>   	switch (cap_id) {
>   	case DEBLOCK:
>   		return V4L2_CID_MPEG_VIDEO_DECODER_MPEG4_DEBLOCK_FILTER;
> -	case PROFILE:
> +	case PROFILE_H264:
>   		return V4L2_CID_MPEG_VIDEO_H264_PROFILE;
> -	case LEVEL:
> +	case PROFILE_HEVC:
> +		return V4L2_CID_MPEG_VIDEO_HEVC_PROFILE;
> +	case PROFILE_VP9:
> +		return V4L2_CID_MPEG_VIDEO_VP9_PROFILE;
> +	case LEVEL_H264:
>   		return V4L2_CID_MPEG_VIDEO_H264_LEVEL;
> +	case LEVEL_HEVC:
> +		return V4L2_CID_MPEG_VIDEO_HEVC_LEVEL;
> +	case LEVEL_VP9:
> +		return V4L2_CID_MPEG_VIDEO_VP9_LEVEL;
> +	case TIER:
> +		return V4L2_CID_MPEG_VIDEO_HEVC_TIER;
>   	default:
>   		return 0;
>   	}
> diff --git a/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c b/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
> index beaf3a051d7c..a3ebcda9a2ba 100644
> --- a/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
> +++ b/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
> @@ -309,7 +309,20 @@ static int iris_hfi_gen2_set_profile(struct iris_inst *inst)
>   {
>   	struct iris_inst_hfi_gen2 *inst_hfi_gen2 = to_iris_inst_hfi_gen2(inst);
>   	u32 port = iris_hfi_gen2_get_port(V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE);
> -	u32 profile = inst->fw_caps[PROFILE].value;
> +	u32 profile;
> +
> +	switch (inst->codec) {
> +	case V4L2_PIX_FMT_HEVC:
> +		profile = inst->fw_caps[PROFILE_HEVC].value;
> +		break;
> +	case V4L2_PIX_FMT_VP9:
> +		profile = inst->fw_caps[PROFILE_VP9].value;
> +		break;
> +	case V4L2_PIX_FMT_H264:
> +	default:
> +		profile = inst->fw_caps[PROFILE_H264].value;
> +		break;

Following up on my previous comment about returning a 0 default and 
running with it instead of erroring it - you then treat default == 0 @ 
inst->codec assigned in iris_hfi_gen[1|2]_sys_init as H264.

In fact why have a default by the time you get this this point in the 
code anyway ?

Just chuck out parameters which aren't expected as errors and then don't 
bother with these defaults.

> +	}
>   
>   	inst_hfi_gen2->src_subcr_params.profile = profile;
>   
> @@ -326,7 +339,20 @@ static int iris_hfi_gen2_set_level(struct iris_inst *inst)
>   {
>   	struct iris_inst_hfi_gen2 *inst_hfi_gen2 = to_iris_inst_hfi_gen2(inst);
>   	u32 port = iris_hfi_gen2_get_port(V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE);
> -	u32 level = inst->fw_caps[LEVEL].value;
> +	u32 level;
> +
> +	switch (inst->codec) {
> +	case V4L2_PIX_FMT_HEVC:
> +		level = inst->fw_caps[LEVEL_HEVC].value;
> +		break;
> +	case V4L2_PIX_FMT_VP9:
> +		level = inst->fw_caps[LEVEL_VP9].value;
> +		break;
> +	case V4L2_PIX_FMT_H264:
> +	default:
> +		level = inst->fw_caps[LEVEL_H264].value;
> +		break;
> +	}
>   
>   	inst_hfi_gen2->src_subcr_params.level = level;
>   
> diff --git a/drivers/media/platform/qcom/iris/iris_hfi_gen2_defines.h b/drivers/media/platform/qcom/iris/iris_hfi_gen2_defines.h
> index 2fcf7914b70f..48c507a1ec27 100644
> --- a/drivers/media/platform/qcom/iris/iris_hfi_gen2_defines.h
> +++ b/drivers/media/platform/qcom/iris/iris_hfi_gen2_defines.h
> @@ -46,6 +46,7 @@
>   #define HFI_PROP_CROP_OFFSETS			0x03000105
>   #define HFI_PROP_PROFILE			0x03000107
>   #define HFI_PROP_LEVEL				0x03000108
> +#define HFI_PROP_TIER				0x03000109
>   #define HFI_PROP_STAGE				0x0300010a
>   #define HFI_PROP_PIPE				0x0300010b
>   #define HFI_PROP_LUMA_CHROMA_BIT_DEPTH		0x0300010f

These seem like - probably bitfields ?

Could we get the bits in a follow on patch/series ?

> diff --git a/drivers/media/platform/qcom/iris/iris_hfi_gen2_response.c b/drivers/media/platform/qcom/iris/iris_hfi_gen2_response.c
> index b75a01641d5d..809bf0f238bd 100644
> --- a/drivers/media/platform/qcom/iris/iris_hfi_gen2_response.c
> +++ b/drivers/media/platform/qcom/iris/iris_hfi_gen2_response.c
> @@ -563,8 +563,22 @@ static void iris_hfi_gen2_read_input_subcr_params(struct iris_inst *inst)
>   	inst->crop.width = pixmp_ip->width -
>   		((subsc_params.crop_offsets[1] >> 16) & 0xFFFF) - inst->crop.left;
>   
> -	inst->fw_caps[PROFILE].value = subsc_params.profile;
> -	inst->fw_caps[LEVEL].value = subsc_params.level;
> +	switch (inst->codec) {
> +	case V4L2_PIX_FMT_HEVC:
> +		inst->fw_caps[PROFILE_HEVC].value = subsc_params.profile;
> +		inst->fw_caps[LEVEL_HEVC].value = subsc_params.level;
> +		break;
> +	case V4L2_PIX_FMT_VP9:
> +		inst->fw_caps[PROFILE_VP9].value = subsc_params.profile;
> +		inst->fw_caps[LEVEL_VP9].value = subsc_params.level;
> +		break;
> +	case V4L2_PIX_FMT_H264:
> +	default:
> +		inst->fw_caps[PROFILE_H264].value = subsc_params.profile;
> +		inst->fw_caps[LEVEL_H264].value = subsc_params.level;
> +		break;
> +	}
> +
>   	inst->fw_caps[POC].value = subsc_params.pic_order_cnt;
>   
>   	if (subsc_params.bit_depth != BIT_DEPTH_8 ||
> @@ -791,8 +805,22 @@ static void iris_hfi_gen2_init_src_change_param(struct iris_inst *inst)
>   					     full_range, video_format,
>   					     video_signal_type_present_flag);
>   
> -	subsc_params->profile = inst->fw_caps[PROFILE].value;
> -	subsc_params->level = inst->fw_caps[LEVEL].value;
> +	switch (inst->codec) {
> +	case V4L2_PIX_FMT_HEVC:
> +		subsc_params->profile = inst->fw_caps[PROFILE_HEVC].value;
> +		subsc_params->level = inst->fw_caps[LEVEL_HEVC].value;
> +		break;
> +	case V4L2_PIX_FMT_VP9:
> +		subsc_params->profile = inst->fw_caps[PROFILE_VP9].value;
> +		subsc_params->level = inst->fw_caps[LEVEL_VP9].value;
> +		break;
> +	case V4L2_PIX_FMT_H264:
> +	default:
> +		subsc_params->profile = inst->fw_caps[PROFILE_H264].value;
> +		subsc_params->level = inst->fw_caps[LEVEL_H264].value;
> +		break;
> +	}
> +
>   	subsc_params->pic_order_cnt = inst->fw_caps[POC].value;
>   	subsc_params->bit_depth = inst->fw_caps[BIT_DEPTH].value;
>   	if (inst->fw_caps[CODED_FRAMES].value ==
> diff --git a/drivers/media/platform/qcom/iris/iris_platform_common.h b/drivers/media/platform/qcom/iris/iris_platform_common.h
> index f6b15d2805fb..67204cddd44a 100644
> --- a/drivers/media/platform/qcom/iris/iris_platform_common.h
> +++ b/drivers/media/platform/qcom/iris/iris_platform_common.h
> @@ -78,8 +78,12 @@ struct platform_inst_caps {
>   };
>   
>   enum platform_inst_fw_cap_type {
> -	PROFILE = 1,
> -	LEVEL,
> +	PROFILE_H264 = 1,
> +	PROFILE_HEVC,
> +	PROFILE_VP9,
> +	LEVEL_H264,
> +	LEVEL_HEVC,
> +	LEVEL_VP9,
>   	INPUT_BUF_HOST_MAX_COUNT,
>   	STAGE,
>   	PIPE,
> @@ -88,6 +92,7 @@ enum platform_inst_fw_cap_type {
>   	BIT_DEPTH,
>   	RAP_FRAME,
>   	DEBLOCK,
> +	TIER,
>   	INST_FW_CAP_MAX,
>   };
>   
> diff --git a/drivers/media/platform/qcom/iris/iris_platform_sm8550.c b/drivers/media/platform/qcom/iris/iris_platform_sm8550.c
> index 35d278996c43..29bc50785da5 100644
> --- a/drivers/media/platform/qcom/iris/iris_platform_sm8550.c
> +++ b/drivers/media/platform/qcom/iris/iris_platform_sm8550.c
> @@ -14,7 +14,7 @@
>   
>   static struct platform_inst_fw_cap inst_fw_cap_sm8550[] = {
>   	{
> -		.cap_id = PROFILE,
> +		.cap_id = PROFILE_H264,
>   		.min = V4L2_MPEG_VIDEO_H264_PROFILE_BASELINE,
>   		.max = V4L2_MPEG_VIDEO_H264_PROFILE_CONSTRAINED_HIGH,
>   		.step_or_mask = BIT(V4L2_MPEG_VIDEO_H264_PROFILE_BASELINE) |
> @@ -28,7 +28,29 @@ static struct platform_inst_fw_cap inst_fw_cap_sm8550[] = {
>   		.set = iris_set_u32_enum,
>   	},
>   	{
> -		.cap_id = LEVEL,
> +		.cap_id = PROFILE_HEVC,
> +		.min = V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN,
> +		.max = V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN_STILL_PICTURE,
> +		.step_or_mask = BIT(V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN) |
> +				BIT(V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN_STILL_PICTURE),
> +		.value = V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN,
> +		.hfi_id = HFI_PROP_PROFILE,
> +		.flags = CAP_FLAG_OUTPUT_PORT | CAP_FLAG_MENU,
> +		.set = iris_set_u32_enum,
> +	},
> +	{
> +		.cap_id = PROFILE_VP9,
> +		.min = V4L2_MPEG_VIDEO_VP9_PROFILE_0,
> +		.max = V4L2_MPEG_VIDEO_VP9_PROFILE_2,
> +		.step_or_mask = BIT(V4L2_MPEG_VIDEO_VP9_PROFILE_0) |
> +				BIT(V4L2_MPEG_VIDEO_VP9_PROFILE_2),
> +		.value = V4L2_MPEG_VIDEO_VP9_PROFILE_0,
> +		.hfi_id = HFI_PROP_PROFILE,
> +		.flags = CAP_FLAG_OUTPUT_PORT | CAP_FLAG_MENU,
> +		.set = iris_set_u32_enum,
> +	},
> +	{
> +		.cap_id = LEVEL_H264,
>   		.min = V4L2_MPEG_VIDEO_H264_LEVEL_1_0,
>   		.max = V4L2_MPEG_VIDEO_H264_LEVEL_6_2,
>   		.step_or_mask = BIT(V4L2_MPEG_VIDEO_H264_LEVEL_1_0) |
> @@ -56,6 +78,60 @@ static struct platform_inst_fw_cap inst_fw_cap_sm8550[] = {
>   		.flags = CAP_FLAG_OUTPUT_PORT | CAP_FLAG_MENU,
>   		.set = iris_set_u32_enum,
>   	},
> +	{
> +		.cap_id = LEVEL_HEVC,
> +		.min = V4L2_MPEG_VIDEO_HEVC_LEVEL_1,
> +		.max = V4L2_MPEG_VIDEO_HEVC_LEVEL_6_2,
> +		.step_or_mask = BIT(V4L2_MPEG_VIDEO_HEVC_LEVEL_1) |
> +				BIT(V4L2_MPEG_VIDEO_HEVC_LEVEL_2) |
> +				BIT(V4L2_MPEG_VIDEO_HEVC_LEVEL_2_1) |
> +				BIT(V4L2_MPEG_VIDEO_HEVC_LEVEL_3) |
> +				BIT(V4L2_MPEG_VIDEO_HEVC_LEVEL_3_1) |
> +				BIT(V4L2_MPEG_VIDEO_HEVC_LEVEL_4) |
> +				BIT(V4L2_MPEG_VIDEO_HEVC_LEVEL_4_1) |
> +				BIT(V4L2_MPEG_VIDEO_HEVC_LEVEL_5) |
> +				BIT(V4L2_MPEG_VIDEO_HEVC_LEVEL_5_1) |
> +				BIT(V4L2_MPEG_VIDEO_HEVC_LEVEL_5_2) |
> +				BIT(V4L2_MPEG_VIDEO_HEVC_LEVEL_6) |
> +				BIT(V4L2_MPEG_VIDEO_HEVC_LEVEL_6_1) |
> +				BIT(V4L2_MPEG_VIDEO_HEVC_LEVEL_6_2),
> +		.value = V4L2_MPEG_VIDEO_HEVC_LEVEL_6_1,
> +		.hfi_id = HFI_PROP_LEVEL,
> +		.flags = CAP_FLAG_OUTPUT_PORT | CAP_FLAG_MENU,
> +		.set = iris_set_u32_enum,
> +	},
> +	{
> +		.cap_id = LEVEL_VP9,
> +		.min = V4L2_MPEG_VIDEO_VP9_LEVEL_1_0,
> +		.max = V4L2_MPEG_VIDEO_VP9_LEVEL_6_0,
> +		.step_or_mask = BIT(V4L2_MPEG_VIDEO_VP9_LEVEL_1_0) |
> +				BIT(V4L2_MPEG_VIDEO_VP9_LEVEL_1_1) |
> +				BIT(V4L2_MPEG_VIDEO_VP9_LEVEL_2_0) |
> +				BIT(V4L2_MPEG_VIDEO_VP9_LEVEL_2_1) |
> +				BIT(V4L2_MPEG_VIDEO_VP9_LEVEL_3_0) |
> +				BIT(V4L2_MPEG_VIDEO_VP9_LEVEL_3_1) |
> +				BIT(V4L2_MPEG_VIDEO_VP9_LEVEL_4_0) |
> +				BIT(V4L2_MPEG_VIDEO_VP9_LEVEL_4_1) |
> +				BIT(V4L2_MPEG_VIDEO_VP9_LEVEL_5_0) |
> +				BIT(V4L2_MPEG_VIDEO_VP9_LEVEL_5_1) |
> +				BIT(V4L2_MPEG_VIDEO_VP9_LEVEL_5_2) |
> +				BIT(V4L2_MPEG_VIDEO_VP9_LEVEL_6_0),
> +		.value = V4L2_MPEG_VIDEO_VP9_LEVEL_6_0,
> +		.hfi_id = HFI_PROP_LEVEL,
> +		.flags = CAP_FLAG_OUTPUT_PORT | CAP_FLAG_MENU,
> +		.set = iris_set_u32_enum,
> +	},
> +	{
> +		.cap_id = TIER,
> +		.min = V4L2_MPEG_VIDEO_HEVC_TIER_MAIN,
> +		.max = V4L2_MPEG_VIDEO_HEVC_TIER_HIGH,
> +		.step_or_mask = BIT(V4L2_MPEG_VIDEO_HEVC_TIER_MAIN) |
> +				BIT(V4L2_MPEG_VIDEO_HEVC_TIER_HIGH),
> +		.value = V4L2_MPEG_VIDEO_HEVC_TIER_HIGH,
> +		.hfi_id = HFI_PROP_TIER,
> +		.flags = CAP_FLAG_OUTPUT_PORT | CAP_FLAG_MENU,
> +		.set = iris_set_u32_enum,
> +	},
>   	{
>   		.cap_id = INPUT_BUF_HOST_MAX_COUNT,
>   		.min = DEFAULT_MAX_HOST_BUF_COUNT,

Other than those nits

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

