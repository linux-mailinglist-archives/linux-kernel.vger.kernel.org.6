Return-Path: <linux-kernel+bounces-547727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B13A50CB2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 21:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50D07188DD84
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 20:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3A4254AEC;
	Wed,  5 Mar 2025 20:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cas72uP4"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65DD253340
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 20:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741207459; cv=none; b=uJxtwZHowfYB5nJbwFhKfATey2xhL4C7/i/7wzzGQPitn5IXIU9SWh4UdsLrbom87Zez6jaP2IomrRgcuMQhpaXpNv5qg6L2Gj62xp6kpmjL60CZRituTaOe4oKLb1xauwQpQBD2Wwq7kBuaGCMwmY+ZvcHTgOroX0FdkBRCqP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741207459; c=relaxed/simple;
	bh=uBiu/q+tZsa0gP4L7tZmIGYWrBiby7aTZSxyh/yRlQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJNydIFQMJcqzw9YXxo9JogqDPrbk8o9QZ4IliHJXBzM/gdOYX4OHNXPANrJN7kFqYhT1Zyzuc6dy145MG6jrZDN9YKKLQWii2bI+D3oEZy1U4jf7FhRy7RUXDVdgA6HgJi/oeXRhCWRapazvbXG25C5LvDY+jXzFllAHxcL5uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cas72uP4; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30ba563a6d1so14736721fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 12:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741207456; x=1741812256; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YNdiW6NwgPN019oEVN4C32QrEjKTlign/S0WBpecrZc=;
        b=cas72uP47srT3rT/xE/UP1wwgiw4uBleT9VzbILnEtYmFx37KrEtEDI3PTojoJdrM3
         GBlESaiaUh1Cre7NdDMa5rhkiczA6jWJwtWeJxxIA+MaHQptyYmR7WutZM4fhJK3auow
         BU/gWu5NawElIEbamBuZcDyvYyMZPyMnmEcVt/vFBVEO9vYMc1gOi/OjoXrGX9C9eDG9
         IBJJlG4eOi35pRCS2qIIxsY/ISLob3ZM4KsRY44gXRI4R/7Ayroz8LuPebgudEEu4yFx
         h6fujTRLlnGkcDENsaaqFCwvkT1pGeSF/XGSX3OAxl5VpbUFWvEloveizyIlQFMoS+6q
         gOHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741207456; x=1741812256;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YNdiW6NwgPN019oEVN4C32QrEjKTlign/S0WBpecrZc=;
        b=VjQyXWDIBCpFRrxh0u6DJXN/yNZT86BYk4iaIV9Fh/1PaHmMBoxYSZL6QAE7Byxl4F
         JkZJRHO4KsU/W8pMJ9mrXOKivRvamfpLuBopEwoMxDo8su6ia2ioxZMDVCaBDz4n8YWC
         vtzTYrU62afF+KTOXNCwUdXnx3kYQXpaYt+iWnpglZSGFA5tF/CjPRjVrE7L7DgIJw6y
         Qvs4TS3cMm2fDcV1knPwpzkAZZ7TyZHI1yfTCNgW7cUIXSi56OqCbdHCvlqOtIgyBbNp
         Ik808vGTUCeO8AguOWjtlGbmx5r7zuP1G96rgbqBKq/sIqAeINIMoczJM9pipoZZ0mgh
         nQBg==
X-Forwarded-Encrypted: i=1; AJvYcCVJ1GxwrgfCpEB0K6KqXm1okJ8wSYBwPuW9LkfPT+U3TGzFpeP6YRu7fungZJ4hbcHl8/omkNfQivUbE/U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2f8fC7yZUuwxWAyr/WDUKSLzgVFwOAnffZgTL3jYPYaUN+oz9
	+xpx6ymHAHb/yyaLgXADycLWZNXvznLeDhL+INNyeZiA7KBHRzS4dtHrHHBKO7c=
X-Gm-Gg: ASbGnct4WdfuJ57YaQhhhJZVesFFBzLJodOvGXKjzLrjNhjmLqjxCYFdYm/P4yZCoyP
	+S216idwAIMG5sL94cV0A6op6ZxlF97ejO+IlL3XEjCiAXCl7Jwx32nF+A8qQcDc3NgjY+iXWl/
	LJEOkVS8xFjjoqJvPMjfIRyltCydpEUI2qGVZYoOqubrTzelZlmR2H8Dx5OroPXlUU5KQ4DZfPq
	qcW+hqVH1kj393HsqQDZTtOJEWpjbbZ2eZejMRNl+DWW96ntPgvcEO/25/Rt1GFk2tp1qyheTG3
	62GVpzbL70Z4Diarvq4BCk9kCj65POP81SYinDpOG3g9Et53AZWOVoFHp4lgPz3rlHyMjAhSmLk
	xfH+KeOi5I4sDl+4CdkjJXmaV
X-Google-Smtp-Source: AGHT+IFczkI3MTzyRZfvWgh/m7rUtd4PnjEbD7z5Jr0gFGe3Qx3ssOoX6oc3c7cd0UiybO63WkVYGQ==
X-Received: by 2002:a2e:bea1:0:b0:30b:c608:22bf with SMTP id 38308e7fff4ca-30be341a1e8mr3100481fa.9.1741207455704;
        Wed, 05 Mar 2025 12:44:15 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30b867ca1dfsm20636091fa.58.2025.03.05.12.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 12:44:14 -0800 (PST)
Date: Wed, 5 Mar 2025 22:44:12 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Dikshita Agarwal <quic_dikshita@quicinc.com>
Cc: quic_vgarodia@quicinc.com, quic_abhinavk@quicinc.com, 
	mchehab@kernel.org, hverkuil@xs4all.nl, linux-media@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 05/12] media: iris: Skip destroying internal buffer
 if not dequeued
Message-ID: <aevtzaqo3pqi5kwufdwciocybibuketxlfy6revxc6r6bzxdai@njgt56fev2vq>
References: <20250305104335.3629945-1-quic_dikshita@quicinc.com>
 <20250305104335.3629945-6-quic_dikshita@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305104335.3629945-6-quic_dikshita@quicinc.com>

On Wed, Mar 05, 2025 at 04:13:28PM +0530, Dikshita Agarwal wrote:
> Firmware might hold the DPB buffers for reference in case of sequence
> change, so skip destroying buffers for which QUEUED flag is not removed.
> 
> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>

Please add FIxes tag and move closer to the top.

> ---
>  drivers/media/platform/qcom/iris/iris_buffer.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/media/platform/qcom/iris/iris_buffer.c b/drivers/media/platform/qcom/iris/iris_buffer.c
> index 8c9d5b7fe75c..305b630ca269 100644
> --- a/drivers/media/platform/qcom/iris/iris_buffer.c
> +++ b/drivers/media/platform/qcom/iris/iris_buffer.c
> @@ -399,6 +399,13 @@ int iris_destroy_internal_buffers(struct iris_inst *inst, u32 plane)
>  	for (i = 0; i < len; i++) {
>  		buffers = &inst->buffers[internal_buf_type[i]];
>  		list_for_each_entry_safe(buf, next, &buffers->list, list) {
> +			/*
> +			 * skip destroying internal(DPB) buffer if firmware
> +			 * did not return it.
> +			 */
> +			if (buf->attr & BUF_ATTR_QUEUED)
> +				continue;
> +
>  			ret = iris_destroy_internal_buffer(inst, buf);
>  			if (ret)
>  				return ret;
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

