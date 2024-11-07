Return-Path: <linux-kernel+bounces-399967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB8B9C072C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 14:22:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B6AF1F22C57
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 13:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC8A20F5A5;
	Thu,  7 Nov 2024 13:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FLRNk7Rt"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9B8202F7A
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 13:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730985743; cv=none; b=tFzYRWnrLe0z2bBQ33WTSPfgHBJXTmpzEnEVHBN649WCDVxIKnGQFkflMNbH8Oo24OIi1Lpod/MNf9lkqawJhqeP65vlhXoCYHB4W+xunOOpCxrWbcMcwrbzc9GfN31uP/eNyuxpqzdEXdIMdD2X9fAcYi8BLuuOCzl275sJ5nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730985743; c=relaxed/simple;
	bh=tafXy6T8mvGXw1f1p//OoV2OKeMhQpmhKK+Y05sbk70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BoYThDHA0JBGVU+SKIjyb2KaP1RQBz1SjufNP27B+Vsmw4sbtcMuDqh6KEV6a4gUsPGy0WxQAErlDoAvwiB2er4OKucnyUdYh//r1vvFEktJYaUlSSZuA4zuoaJZvORDS9r9deWLrY+OaRaKi8HHY7LbJuM9EBnPXRHQ6T/k6V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FLRNk7Rt; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-539d9fffea1so786955e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 05:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730985739; x=1731590539; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O78jUSo2VAB2jjaBqcpu1sFn5+Qacu329/7bBRcH7BY=;
        b=FLRNk7RtRik1FSeRpfxV5jPbKsShu0GFrIE/FKEo6HUKyFcYKNmMYTPLYN5V80wO2p
         vBCXF5Fta7yIQ6aUv2VEHYsyGwOepiaW3LsleMNmQfOFde5gbo9uZBj3UUnaPN6svRk7
         eVtg6gpODJOcCjIl3IWX+6+LSiGGdheSY8yFtoSiFpGPb0AnjqgeCrSIf5XDNyegsnjy
         qgqHL3vW0Z7YxpoKzguUW1xZDfFVboF62QoOOpZjmJITr9F7MNmWqXPitvBZlwl8Ha5O
         EH/fpKbfNJK2JMHnRFfWCO4S8XXhGqOH7FEzRjbQy4JRRI48MFNPa8n7G0CPeLURnF9h
         N+Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730985739; x=1731590539;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O78jUSo2VAB2jjaBqcpu1sFn5+Qacu329/7bBRcH7BY=;
        b=mhNoFpJhqMIXYiuU9d97HRfi45xl/PmUjRHsIbOhSBnF/0y6ZXEV7jbYWdqvpcVOC5
         EKvvr3H+fbC9YDdIut5JX0TxHgAohEjkofFYRe3kXxFGE8VLVsnjTZUzqAHOgP0StCxm
         txgOGER4QIqWHAXVbtd7PqxOOgMknq4pfmUZcYgiWtc9r/SMjpMFFfgkZ6qmQ0xTsoDX
         U4EdMMjx1lYzWZDPZurAuVXWUYl/LVceYhbYPYT2MGiQfRTZM3NPPNLXiE6ADCPz5SVg
         i8IHfY/mkz6SUMQl+cmMa9Vor9meDXB5wyoC1Q+3PK9D4GO8QbdAmqp9gj/HfNtVDskB
         2v3A==
X-Forwarded-Encrypted: i=1; AJvYcCUijSa7RHlK4I7/u2FcEKUt4Z79YDD+WxpHf9F9PzONIdmvgJW6yI4rFvBlATpzF/tRdvOREOaBafttEIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvCnIGOboW/qJx1DnTPcJ8Z8qPqrwXhZW7DJUT9Uu/wjTR5rCs
	avJpu7a/azyoCReogCMKNoKkq0QsavOxohQRJVHlfdmHDg3e9cZqIkc0b85Le14=
X-Google-Smtp-Source: AGHT+IE7iCnTN6cJcxYydY0LNjIyPayqcFupD1/fQ2SNQljIoWv7ce8HamPJfCQEBawmCBwWNzoUXQ==
X-Received: by 2002:a05:6512:3981:b0:539:eb2f:a026 with SMTP id 2adb3069b0e04-53b34921a44mr22822155e87.33.1730985739182;
        Thu, 07 Nov 2024 05:22:19 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53d82686327sm215610e87.102.2024.11.07.05.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 05:22:17 -0800 (PST)
Date: Thu, 7 Nov 2024 15:22:15 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Vikash Garodia <quic_vgarodia@quicinc.com>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH 1/4] media: venus: hfi_parser: add check to avoid out of
 bound access
Message-ID: <ql6hftuo7udkqachofws6lcpwx7sbjakonoehm7zsh43kqndsf@rwmiwqngldn2>
References: <20241105-venus_oob-v1-0-8d4feedfe2bb@quicinc.com>
 <20241105-venus_oob-v1-1-8d4feedfe2bb@quicinc.com>
 <b2yvyaycylsxo2bmynlrqp3pzhge2tjvtvzhmpvon2lzyx3bb4@747g3erapcro>
 <81d6a054-e02a-7c98-0479-0e17076fabd7@quicinc.com>
 <ndlf4bsijb723cctkvd7hkwmo7plbzr3q2dhqc3tpyujbfcr3z@g4rvg5p7vhfs>
 <975f4ecd-2029-469a-8ecf-fbd6397547d4@linaro.org>
 <57544d01-a7c6-1ea6-d408-ffe1678e0b5e@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57544d01-a7c6-1ea6-d408-ffe1678e0b5e@quicinc.com>

On Thu, Nov 07, 2024 at 06:32:33PM +0530, Vikash Garodia wrote:
> 
> On 11/7/2024 5:37 PM, Bryan O'Donoghue wrote:
> > On 07/11/2024 10:41, Dmitry Baryshkov wrote:
> >>> init_codecs() parses the payload received from firmware and . I don't think we
> >>> can control this part when we have something like this from a malicious firmware
> >>> payload
> >>> HFI_PROPERTY_PARAM_CODEC_SUPPORTED
> >>> HFI_PROPERTY_PARAM_CODEC_SUPPORTED
> >>> HFI_PROPERTY_PARAM_CODEC_SUPPORTED
> >>> ...
> >>> Limiting it to second iteration would restrict the functionality when property
> >>> HFI_PROPERTY_PARAM_CODEC_SUPPORTED is sent for supported number of codecs.
> >> If you can have a malicious firmware (which is owned and signed by
> >> Qualcomm / OEM), then you have to be careful and skip duplicates. So
> >> instead of just adding new cap to core->caps, you have to go through
> >> that array, check that you are not adding a duplicate (and report a
> >> [Firmware Bug] for duplicates), check that there is an empty slot, etc.
> >>
> >> Just ignoring the "extra" entries is not enough.
> Thinking of something like this
> 
> for_each_set_bit(bit, &core->dec_codecs, MAX_CODEC_NUM) {
>     if (core->codecs_count >= MAX_CODEC_NUM)
>         return;
>     cap = &caps[core->codecs_count++];
>     if (cap->codec == BIT(bit)) --> each code would have unique bitfield
>         return;

This won't work and it's pretty obvious why.

> > +1
> > 
> > This is a more rational argument. If you get a second message, you should surely
> > reinit the whole array i.e. update the array with the new list, as opposed to
> > throwing away the second message because it over-indexes your local storage..
> That would be incorrect to overwrite the array with new list, whenever new
> payload is received.

I'd say, don't overwrite the array. Instead the driver should extend it
with the new information.

> 
> Regards,
> Vikash

-- 
With best wishes
Dmitry

