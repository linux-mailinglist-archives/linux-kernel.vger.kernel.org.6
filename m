Return-Path: <linux-kernel+bounces-206079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6079003FD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 14:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C60ED1F26099
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 12:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91A1190682;
	Fri,  7 Jun 2024 12:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VUoqhp0a"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560F6193062
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 12:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717764225; cv=none; b=LZi/0I/a2C1ww9oLrnK9FUtC4U7Ded/7xh69RicMFwoQF2123YTzc0H4Tj+PAWfkvj7cw4XWN0dcQqFlO89ADyLHO7mOne6uf9Hq7JCv2SVCuEjA/V/huIZVl4gcfyTHw9lPROzOdmkGWPdSbtRXACFpndSgFOSy2N5SGHB5CPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717764225; c=relaxed/simple;
	bh=DKpJMqjH6UtbwvLCWvGMlCN5FOTyMqaNnYZVGLw5QrA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BXDxyt9dAihwKYTS82hodGhUTyz/plRa4bSrOkVAWs2suVOOOFAbMWdYfEkJdokZldh3W1qNAwN8KKCfjwRA4FwEJicrbS6c2QDwBMXMOTIoiPVMwgTj5wtK4ma8kyYo6yUroSEZxoDj85fVPpnlw+8r3KjQ9rZ//ULFIajaE8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VUoqhp0a; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a68a4a9946cso254146566b.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 05:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717764222; x=1718369022; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vPT1BhYTFvN8bBYnTvz9S5wwBpb/ePs438aoM49eAiY=;
        b=VUoqhp0aC25mHhp92CVulstkQ6dKtmZKzGGX6ez4EW8U3UDdTwgNYtahE9OzPLRuIf
         cPUvtStd3o8qeBfNk8CHY7OIh6i2RyJzHo7VLmdQh0F2S4r4h/LcRa5IqQ1c9ovQoCDb
         /AyLrwnnsmyB60J93dmXerb5TUx5q49Mw5LW9c+6voXBXiKanHUCoa7Li2MFxKuonigC
         TKMuyCmNDgoa49EQv87l3zGqBFaJxJLfEiSHiFl02J2ROZdtYTlGFfcYHRRld7/EaZ3w
         NqkS/6jXrY5z2S+5c0CRLz98gxJIJo1GoPlKNshT2nPwh/rnCJzSkCVKavpkpahCyxUY
         9LOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717764222; x=1718369022;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vPT1BhYTFvN8bBYnTvz9S5wwBpb/ePs438aoM49eAiY=;
        b=UGnVg+LcyKV0OQbk4W+0v/MpfQo4qDFT81mx3RGP4FzQbIpF9fzNiLvzjL+c5EApwP
         36OU4pvBVvzRj+W3yhgjRXdZQWEYyz8I468DZonX5a0f89x8RhZ9WwcLKxIBYGWU+og3
         nyZ3zQvFbxWxWeYftAjeo6n/W4ANTFEoD5BVOlr8uQyXQHlORZDxNO+5QAnEcoC9pBU/
         ABuOZSEkBW+uWNBbrv4ntb/5uHtQ2Qf7OzZodxzLHHaVKgfOVuB4HjNKAiq93oJOpBcO
         6XNh0ZWyjrTtfNgzpXLjv6ZTB3+Vga5aTT7A6TGP/6R7+OEICdJ4IAGGm1Z7/UyZcdjW
         ftjA==
X-Forwarded-Encrypted: i=1; AJvYcCUTCA4UIuJ0Enkj/ixT+RTUx7CiY1f8gCu00g3JfAihTcK6IJ1yj7YuXPQgDYxhT65cW/LS6YJR+KxS0PV5hwxAnt/ejfSj29jIYEcU
X-Gm-Message-State: AOJu0YzBvxrhCrT8s9aid12DpQE1a0Jw9X43bl/zMccaq6CIHBbygE8L
	H1/RKcTY7wDKZaiTuscIH21rke+iNifMgaY4/KUnbCq74PvjnkGIikmvfbNtK0M=
X-Google-Smtp-Source: AGHT+IHtfKE/HfIALfDQFvlb45n2TB4/rMk87fD9LzhzyTIhts6WW2zXNjchATbkzKvluIQutnGQOg==
X-Received: by 2002:a17:907:31c4:b0:a6a:617a:5da1 with SMTP id a640c23a62f3a-a6cd675ce0fmr184414366b.27.1717764221743;
        Fri, 07 Jun 2024 05:43:41 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::8090? ([2a02:8109:aa0d:be00::8090])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c8070f879sm243927166b.173.2024.06.07.05.43.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jun 2024 05:43:41 -0700 (PDT)
Message-ID: <4ac692bf-55d5-4a66-acda-72353d817de4@linaro.org>
Date: Fri, 7 Jun 2024 14:43:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/11] misc: fastrpc: Avoid updating PD type for
 capability request
To: Ekansh Gupta <quic_ekangupt@quicinc.com>, srinivas.kandagatla@linaro.org,
 linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
 stable <stable@kernel.org>
References: <20240606165939.12950-1-quic_ekangupt@quicinc.com>
 <20240606165939.12950-5-quic_ekangupt@quicinc.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240606165939.12950-5-quic_ekangupt@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 06/06/2024 18:59, Ekansh Gupta wrote:
> When user is requesting for DSP capability, the process pd type is
> getting updated to USER_PD which is incorrect as DSP will assume the
> process which is making the request is a user PD and this will never
> get updated back to the original value. The actual PD type should not
> be updated for capability request and it should be serviced by the
> respective PD on DSP side. Adding changes to avoid process PD type
> modification.
> 
> Fixes: 6c16fd8bdd40 ("misc: fastrpc: Add support to get DSP capabilities")
> Cc: stable <stable@kernel.org>
> Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   drivers/misc/fastrpc.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index f64781c3012f..abdd35b7c3ad 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -1703,7 +1703,6 @@ static int fastrpc_get_info_from_dsp(struct fastrpc_user *fl, uint32_t *dsp_attr
>   	args[1].ptr = (u64)(uintptr_t)&dsp_attr_buf[1];
>   	args[1].length = dsp_attr_buf_len * sizeof(u32);
>   	args[1].fd = -1;
> -	fl->pd = USER_PD;
>   
>   	return fastrpc_internal_invoke(fl, true, FASTRPC_DSP_UTILITIES_HANDLE,
>   				       FASTRPC_SCALARS(0, 1, 1), args);

-- 
// Caleb (they/them)

