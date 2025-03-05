Return-Path: <linux-kernel+bounces-547176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F68A503D8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 16:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D63B31891CB6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36682500AA;
	Wed,  5 Mar 2025 15:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="itUGPaAO"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FAB18FC90
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 15:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741189911; cv=none; b=sM3m+UsBmbpP/T0RXBwQmH0vusznGW4SGaSQxjENGlSOeme7EBgmIfQba52pmYWZ8iBwniQkzcJWmF2Rq9D9BRMHUxN8cXE9LOdd4vo3cMWE5jmoFO2U28MZg0900rLC+fqP3+bM5Dbh9ofGG66L9z1FN4mGbi9MLeXr/e+yaV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741189911; c=relaxed/simple;
	bh=O/cTFmq280CPrxPXEkld2Dj3tT2/ZM0b/LQwLiDBrBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D/064pYWQw68k9PzZXSMMsg6IM48xL03iW26lOhrsS8N5auU/bsKpbW1jF4ePgoS1qCJ1j+5O24Gc0HAekKhye3VLAtJf6WHrV4jEUWhTvND2xrptO3SFyX7ID/RnvtW/wFORto2V7q/Abx1DbNB7Bd2GsS/ur0ArlO2jsOz5L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=itUGPaAO; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43bc38bb6baso22254575e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 07:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741189908; x=1741794708; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DZ2S+gHwbsXckxzFFhUyQLhk9IBYR1YjauglVfzrk5M=;
        b=itUGPaAO7cVl+fwidqUHgI3zpFFfdrhDDvpGOggCgETt1tL1ZgiyvFMLH/rA6y5mar
         XKFzfX2Qnrc4YOFCjloT9rwowl41vdaSgZD1lk4q0f/OEc5AeuNVl594wEsQAmVQL1tb
         cwaFVcYoyAjIBSK/gpYLAIYmOlFPMm+cqEoDPxAaD1Gpdw2KWa59tgno2jDVsPVyoEzF
         yRsa6D/50rDuOO/MLee+WM/T6F2axlhqHBDBmImJGxG9lDa597abpMKTkeo/kpov2f5g
         R46leZPju2hDVOz976uSq0Z/JS4JlWQgm8Zgg9OV1eKGBjsasiA27C+Udf7UXz8QcaK0
         VHpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741189908; x=1741794708;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DZ2S+gHwbsXckxzFFhUyQLhk9IBYR1YjauglVfzrk5M=;
        b=UcukYYAcPmkrtXdrtjRlIV3vGh4z1Ls6deBPi2VvPxxUfAZBhu7V/tVnCR5etHL47G
         rFMHDpEJPntb8vwKarEribuVUy1PADTNGnXYtclLLDokcXW4SEgq6NZOG2jxAAdrnkYi
         ytmQPhswiaERqfOCHvTROXTIHD6A5a8kwoP660rFOsho6VBTZ8MtcY1s4bdJ7lVWmVL7
         n7gttMHMS8X+kOfldAs6QG9/ftBGlJwjxgkSWP3YZaF4FZu4KF3QYc9y64gGoeFWS26J
         yd5lxZuuPi6hf7l3gkJIIMxLkujy6mygZPuZcb6XzquNwgFsl+i135t8D0kvVF/qdqxZ
         mEnw==
X-Forwarded-Encrypted: i=1; AJvYcCVqqcrwo3X0ZGks67HKnIBa5cly3hEA1gWL+/5igURXvnnh99LmzpmUX5xpZe1+ZEm/IxZLt3jM0YZp384=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzyiu1ffFSLkmv2brRZ11CYBJNA7DxJb8hrqEJeB3DgDXUahOv
	jUqlBLG15fHNtLshq7B/jWHqU1xSqsX/305B7hr6dIkDytbjqd3MPShW4r7pPxk=
X-Gm-Gg: ASbGnct9sbUAkgvw6TKCQbMc+kKNn3cgChihsCEDs+yxZsqf42TxtpCdktgbZn0+oiR
	L4ljgleoAjH8by2xP8RZcpz+b4nZheN6FITcjz5xUn2oy6o8SsHfVi7gudDVLV/HjegiNX9eO5A
	SLUUHehL8J92BKkwrQuWEjMhmRy4uHPL0Vb1JsKg0tay+Tptl1toTX5cYnt0Me5rN8NYlzg8XDf
	SF+ct+W06sMOP0YB0Vxt6wQhaRYXNh2FkxANbYAqZXXiJx0dacfMIzXD4vZ0xo5F8rXMgLTKpnT
	xdyHWyeYolOdKdbr4PJwIceH3H8y2JbJTn14zk/N59Wvi893Fc/EyQI=
X-Google-Smtp-Source: AGHT+IG7qv+nb9cXjGGw9HHaPPCvBWbDrCLu9uLjG/6FTP2fC03dynof25NfR+yCRjeYdVlhkyXSaw==
X-Received: by 2002:a05:600c:3b95:b0:43b:cfbb:3806 with SMTP id 5b1f17b1804b1-43bd29d2d84mr29598645e9.14.1741189907949;
        Wed, 05 Mar 2025 07:51:47 -0800 (PST)
Received: from [192.168.1.247] ([209.198.129.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd4352eb1sm20794925e9.31.2025.03.05.07.51.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 07:51:47 -0800 (PST)
Message-ID: <7ac4947b-76b1-4748-8ea0-a949613a3cfc@linaro.org>
Date: Wed, 5 Mar 2025 15:51:46 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] coresight: docs: Remove target sink from examples
To: coresight@lists.linaro.org
Cc: yeoreum.yun@arm.com, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Mike Leach <mike.leach@linaro.org>, Jonathan Corbet <corbet@lwn.net>,
 Leo Yan <leo.yan@linux.dev>, Namhyung Kim <namhyung@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241210144933.295798-1-james.clark@linaro.org>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20241210144933.295798-1-james.clark@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/12/2024 2:49 pm, James Clark wrote:
> Previously the sink had to be specified, but now it auto selects one by
> default. Including a sink in the examples causes issues when copy
> pasting the command because it might not work if that sink isn't
> present. Remove the sink from all the basic examples and create a new
> section specifically about overriding the default one.
> 
> Make the text a but more concise now that it's in the advanced section,
> and similarly for removing the old kernel advice.
> 
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---

Ping, thanks.

I think Steve's comments are somewhat related, but shouldn't block this 
change going in.


