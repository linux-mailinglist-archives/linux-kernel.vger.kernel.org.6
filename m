Return-Path: <linux-kernel+bounces-189513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE428CF112
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 20:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BDA51F219C6
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 18:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02390127E25;
	Sat, 25 May 2024 18:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u7woUNvd"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A618F127B6A
	for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 18:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716663543; cv=none; b=geJJj2nJPAlYI8adxEAZVlDVR2vol3Z7T/jUlyiNHlT4TYXVIpXVlO7vGIbBnioQ4pVBbMt3q39ssAAkicUscjRZy9xMJLe3cnuAwat2dEOvH0bmUl6VMGDHH3M1GUwQGCdwnz7kPAo3wA1AF+nOdWl2Xvd1AlPmV9ytLyzic54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716663543; c=relaxed/simple;
	bh=EKyzkvw7ItMT2A1KApog1OWblbXsMQaqWtGfoyM3PzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bmXlarXeix9KBmajfSqo3pt/WWED8wcR7TbvUGMjIBjOTpFnJ+EpJ/XZo2HNB7QLvzxO9Ux3hN8VTcD0vfZcDd0ES4KsgFwmZ5Fa/YDqRJj3gaeWg68RdnIJ5jcSv7DFF5bjIAOboePY1YIUbJ0RYgqRra52HJbCTl0FlG4zCj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u7woUNvd; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-420160f8f52so39909485e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 11:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716663540; x=1717268340; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=C1ltb2McNZuu2wPm9iznTsJgQEP1zyUhfvWhmZMyoGA=;
        b=u7woUNvdU8F0WrbLq0im1Wl7bJCbZSYb1D37msa1KGSRXnqMGyZc2ahPpcgXXCNCpr
         50/xfM4EPHtwbBc/NSOd2NKh+K7QT0kr7WgJ1fwWFUjxV2ZL9AUYiBXgC0/2QP7i0FA0
         fEMFdN9H6JTMJ6eNRrco1/NOUAZWMIV7zkZb9MODv3J3T6t1RQL4WlyUZDazsAZ8pn4F
         fyp0CPJUW0Vt0DvSpfiTlhO+BWAaR7E1GCXLNPD0ISOAGvvb1zGZX+fHTs5+Q24PChcW
         o9HH8ddAWTC/k4Oh0qw5L6DfzMrHdCR4N0phRxrwIMcHe8pfmzes/7XePQxx4DG28KIC
         oBAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716663540; x=1717268340;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C1ltb2McNZuu2wPm9iznTsJgQEP1zyUhfvWhmZMyoGA=;
        b=MLElMt0LcHMRX/L5IEVg5U3dMwcK4cBf1kBpaWy/1b9MYLED+E75B9Ksicm3ZzPX/5
         ZGuiMev1/5Ae6e+r6UeFNnzG2gkrEv74WeJP8v4w3/QqN93BKUtf5v8c9SCP5ZhdjRXB
         ib6L0/dPjWEbkMtGtoV4XkBYBrUF643Vc3psH5CNLHRU5bKEJilB93FSnhLNEqpmo2b9
         gyz4C/WroNlQOIdXPKnp2gnvpN5hKNYJXEI2jPjPetEiGTl2tsgndve6ONV6oQkjDv34
         PTmNoenXnCS3LSPDHFvdFNrPyaEAlHOiRm5aogxgeqQbO0B9WQwj2LyzFH675oDhplL9
         jNmA==
X-Forwarded-Encrypted: i=1; AJvYcCXwcXlHS8SCDNqvUep0YRRPqZachIwbpXhMYE0WgKa7x8Sr6fLPa33jwYoN0dvy7H3GBoPulWScU6GU++ybFZLgM3koPmWZ2CoG4XSC
X-Gm-Message-State: AOJu0YwkPaQ5EVDybvOUEsCf0FPGZvtUlIA3vo72rB2fY5ds6PlrQsOE
	UQn35WzgZeJ+vGF1tZ4e9XYyAMEhuisXl4C0eCfflIBJxr8mkuG4comKOyiopvg=
X-Google-Smtp-Source: AGHT+IHI+mBtTEcC58bs/lQSj2ZRcVFjCFjDftFjbvks/j0ZOZdiYC24EihRv026a89MlOJq5l169Q==
X-Received: by 2002:a05:600c:19d2:b0:418:2ccf:cbc7 with SMTP id 5b1f17b1804b1-421089ebd3dmr39580715e9.2.1716663539942;
        Sat, 25 May 2024 11:58:59 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.206.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42108970b4esm56327965e9.14.2024.05.25.11.58.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 May 2024 11:58:59 -0700 (PDT)
Message-ID: <f2650797-f681-4363-8a67-87c8c16226e3@linaro.org>
Date: Sat, 25 May 2024 20:58:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/10] dt-bindings: mfd: bd96801 PMIC core
To: Matti Vaittinen <mazziesaccount@gmail.com>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1716533790.git.mazziesaccount@gmail.com>
 <bd468e695d8331762d5be77196368b82366be7af.1716533790.git.mazziesaccount@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <bd468e695d8331762d5be77196368b82366be7af.1716533790.git.mazziesaccount@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/05/2024 10:17, Matti Vaittinen wrote:
> ROHM BD96801 is a highly configurable automotive grade PMIC. Introduce
> DT bindings for the BD96801 core.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 


Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof


