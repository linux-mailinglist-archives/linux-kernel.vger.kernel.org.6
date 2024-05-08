Return-Path: <linux-kernel+bounces-173673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5CEF8C03CC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 19:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7127828467C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 17:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132B212BEAE;
	Wed,  8 May 2024 17:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z3I5vugc"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C6412B14B
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 17:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715190816; cv=none; b=l1QHeArZXAFLAV+P03ClsDQW/bRVJN7pN/1tlpvBWpeBQ/bywXfyyhjEQzCg3cTITRPunR0p2gPxOXjjew/txuyshLzeGhzIGC9SAtwDpShsFmHLC9UiUUN1jKsbRp9kdlwUYXSAfk/Y6oQprvBsb0XM64ZAVKBmvrCXVt1USsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715190816; c=relaxed/simple;
	bh=HXVW8h5p3JlTih8gUxuhHHUusD8gorkN4xSmGzUCymw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Juk+bTw9M1XD5TvcgDJeTYWMWfcIwVqup0rI5bV8m5skGdLeVu5RwHLQZKLY3kqyi0TGu1piz9h9PaKPIOI06ssOn6KPaKffqrCQ6bVfMSMygoeVvNVj3RJ+SIbDjMjY8k3D1SBWmAor6by+Dj3fCeLWOCfsnoNBDNT07Py6MGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=z3I5vugc; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2dcc8d10d39so295961fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 10:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715190813; x=1715795613; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o2vH4bNd6Ss0R422TZj0wAc00Y2LU/Z/9oAmYOP5+g0=;
        b=z3I5vugcrxwKKVNljde2uGKdCz5e1lece186rznyzUoAWTjcFspW73CSjOCEB0V79i
         1c8VxYIz9ism7HR+lQwDchbjnCs9rs47QX0BaHOWlEyRowLFYU4M1usjK0yt8NtIVL7C
         Q/O11nRqCzyh+fPfp6D6mrTy1MHEjZLlTYIbfGT6eZxVXWx1+ucgkTImwRXzC7ToKOaP
         YdwJzKA9QsuxnsfO+WbBFJfmmkjNSTVjdYOdPC57rhWpt3/UXpaQCcjaYFTnlwi/qE5Q
         bvQNvQEciyVhffFF1LBuBRZKC2HyfYVpoX6M7wxknTEHNrrUWMTTFXoMDWpFrH9TRo4t
         b42Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715190813; x=1715795613;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o2vH4bNd6Ss0R422TZj0wAc00Y2LU/Z/9oAmYOP5+g0=;
        b=JnQ0kXIajvQvW8W6GyDSZSFmKOzi1S2z8wctZijeGxp8UIMZ9IAQdKEdFk1tDZNQfg
         O0Em95dWvqCaH/d/g3Lfr18t0JwpuRySoDAu5pV/AmE87Sfw8aktYXo35ov1yslgpcHF
         QxvHQ4BubKkzu4tCoIzR78h+mQ9aaG8B3Y/bYKZyvYq/XuwG6pTj+zwr0I5VJcXQ+X4F
         va9nPT6jIhNFmhJyeYoCNF+EqDzqnBiiZgPEzbsUHeDFYFS4HE+2l6r1LMiY42V+1IjC
         9QLyfFMfUlnZPH5Qgs3kFSFm4X8rPjt8pWVfzUWlRTAS6fww2l8i70Rv6L7e3/tEB9yF
         0n9w==
X-Forwarded-Encrypted: i=1; AJvYcCVIE+6Z0qYs+I7XAdKoikyKPi3QgJzeDZOs9wN17+UyQ5Gwi+4m6L4ZPO6KWLN4D/xmrUCA57FtC+V0eeOOO34CkTZtf74ocr7ZgkmF
X-Gm-Message-State: AOJu0YzdtOiSUKQjHFdljz+EdNJ0To/pUADfQiLH+OKo+78wL3BkQ9Tx
	OAj5aK0jUsJRr+iIoK+1CO0Budo0UNklF00i+N21ADsmTPhWR2bggp7SkXRkhnA=
X-Google-Smtp-Source: AGHT+IF2J+4cHJzRkZkOke7CEGfqkv9jue8DGyFyfN7rnlviR2OAOQp+F+Jb2MFYGSJCq+ODh52Ncw==
X-Received: by 2002:a05:651c:228:b0:2e1:c6bd:ebba with SMTP id 38308e7fff4ca-2e446d83be8mr19651601fa.1.1715190812970;
        Wed, 08 May 2024 10:53:32 -0700 (PDT)
Received: from [192.168.0.3] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f882085a4sm30541715e9.39.2024.05.08.10.53.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 10:53:32 -0700 (PDT)
Message-ID: <b372c0a3-facf-4576-91b8-acabef270d87@linaro.org>
Date: Wed, 8 May 2024 18:53:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/13] arm64: dts: qcom: sc8280xp-x13s: enable pm8008
 camera pmic
To: Johan Hovold <johan+linaro@kernel.org>, Lee Jones <lee@kernel.org>,
 Mark Brown <broonie@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Das Srinagesh <quic_gurus@quicinc.com>,
 Satya Priya <quic_c_skakit@quicinc.com>, Stephen Boyd <swboyd@chromium.org>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
References: <20240506150830.23709-1-johan+linaro@kernel.org>
 <20240506150830.23709-14-johan+linaro@kernel.org>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20240506150830.23709-14-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/05/2024 16:08, Johan Hovold wrote:
> Enable the PM8008 PMIC which is used to power the camera sensors.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Tested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>



