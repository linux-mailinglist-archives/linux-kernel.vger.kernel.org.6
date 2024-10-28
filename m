Return-Path: <linux-kernel+bounces-384550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C01429B2BA4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 10:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DCBDB22EA8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 09:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67261192B6D;
	Mon, 28 Oct 2024 09:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SP9F35Mv"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D090E155744
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 09:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730108280; cv=none; b=XqmKio0i5UpJhN0pEY+jNaAEazNVo5dLR1qIrnlBZFQQm+vf7rROvAYiiC5Y3VfjOhGHpPM81LijwYmsm9dKVpNlUvbY8b8nD3TmtCy97mYW6T0yyRV5D9lpFFXvi9PXbVFi4+WqhAcgkkVhwMIImCJXHFwP0cQ1F+8KZVVKwgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730108280; c=relaxed/simple;
	bh=qJISTUAGM1Sk9VlnAUjbDwyVuT6U98xvMznKzuQhry8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uPa13nuestVuMXMOcooiC+Aq9uIt8S/NrvDk8/xQRillVK6Ejks1BM/GTU6L3/sa88FfLWL2my+J30QgNGoh1noAQtWN1o7lPAukrrjNWRgtlz/M1gSTAa/2I9Od3qxmU09wKPxhR06nxb7NRBAyJUPyCpkczuXERtHvXfpYHRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SP9F35Mv; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37d4c482844so2725432f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 02:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730108277; x=1730713077; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+4kvxdQvqSmN65+ZGA8szwL65OsN8Xi7ITeBdBaj9iE=;
        b=SP9F35Mv4jBaNGZWZfOTRNIh05C2L7DM/hXV+cqh8+6tp49diMGbIUBr0B37qQMRD5
         Hn/cUm/xvWFNtYDHcDuiJBU+T0Vs9ncgseb86uFaHSev9xzWRtEIt+sTz8YTsfz/GOHM
         u3W5nZdyxnydb/5D7Wo02ZFjNFY0eEmjMc8aWj91LVh7WMnZZCjVx8PNIkBj6lxN6D+L
         OfL71FOyCP8gKscmf4pJJY5Wp/J/6aJQaPZc8kAnMEG9Xpk1HhUNVP3jaWmWPtdRbyU2
         d2u5a6juNoDE/gJQD4KBui8QwXiIf8P4gd1t3AgL/+CY4jlNvYjGb+8yeswVfN5nMIXK
         Nxbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730108277; x=1730713077;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+4kvxdQvqSmN65+ZGA8szwL65OsN8Xi7ITeBdBaj9iE=;
        b=A3UWKbjNLs71qAvCAa/Imfy5FqXCXmAUaATK7sg/X7gcKZ2w0Vs/3xrBl/2vYx7Mnh
         49vKGjER42hvz3REQNEnpRRN6Nx/hxvAnoRyJR5bkgowGf/Nw5PJgaekcjzfE5WAjVVU
         5nm+oNiiZlOYaB6fYOfSlKvvQcom09s4YAm+0kel77rU0EXikLUOpr+nOPBUedqIGrTT
         Owjwa8f6IFv9n/CCDvaceVqFRmhNiFuEC0LUyMl9Wh0DPoiY8NLSSCk8Qo2oYhAgcuWg
         Ge1/ZIXtPh9ncDW4gmRGDD07zXH7WS2smezLpgOwCHJ6fK4gw2ASAoyweJ7akz1vc9f3
         C5uw==
X-Gm-Message-State: AOJu0Yzk8g8B4r7vr0JrLEIgWi8rb4GfwO3CZBgej1Prei2YKfm5+3mp
	7WPWpi/+NNm1vwE1H9ysJU5Qq9D38wUD1wDgXTcsxb24+rMkmeF6+fbgj9iKMdKqOFqxyCdHAUu
	z
X-Google-Smtp-Source: AGHT+IGTs+ff2QTEnOLMho4Aw+9cbpHlVIucr9RKtQb16JkGVUN9VfELT1cWoow3VERcxplazgYiRA==
X-Received: by 2002:a5d:63cf:0:b0:37c:d57d:71cd with SMTP id ffacd0b85a97d-380611ff862mr5585322f8f.52.1730108277184;
        Mon, 28 Oct 2024 02:37:57 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38058b3c861sm8981783f8f.44.2024.10.28.02.37.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 02:37:56 -0700 (PDT)
Message-ID: <0aee828d-b55d-4585-b997-1d8fc3b478e1@linaro.org>
Date: Mon, 28 Oct 2024 10:37:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clocksource: Remove unused dw_apb_clockevent functions
To: linux@treblig.org, tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org
References: <20241025203101.241709-1-linux@treblig.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20241025203101.241709-1-linux@treblig.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 25/10/2024 22:31, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> dw_apb_clockevent_pause(), dw_apb_clockevent_resume() and
> dw_apb_clockevent_stop() have been unused since 2021's
> commit 1b79fc4f2bfd ("x86/apb_timer: Remove driver for deprecated
> platform")
> 
> Remove them.
> 
> (Some of the other clockevent functions are still called by
> dw_apb_timer_of.c  so I guess it is still in use?)
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---

Applied, thanks for the cleanup


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

