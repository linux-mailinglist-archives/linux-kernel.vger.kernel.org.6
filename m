Return-Path: <linux-kernel+bounces-291931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBC995690C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 13:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9692F1F22A42
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 11:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9AC1662F6;
	Mon, 19 Aug 2024 11:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="THTsQOob"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA54165F1D
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 11:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724065821; cv=none; b=gVU42x43DSzjSpw9jdtWUgX2p6ZDMOwS1Ubx0JqxvlmObVF/E/15ivHR44r9wWlLbB5K80Qkl9FaDHUjxIkoGMPgpNYVXcrZGpl70DwKF5hw0DU7hLnSK/OWNsV+nZ11WUNMS1N4sk2sTbouAIAMLHGTOr9rvDCAGWY+TKcSViw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724065821; c=relaxed/simple;
	bh=zOlYH3GTgzKAHU8di3VALmbBP8ocav6kVwNdHek7zxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UvZQkn2GKSr3RN/YtbPCFeBfT4SvUc5pZ3yLi5ut+49KwQfwoovtXDkeHay3wU7OLR5VUAerUI24XO2bbuYHYAF+JsAhks84MsqGEsaHNwt5+i+f2Y3ojidW7TtyI6o6Y2uED2/zYXCkZtTCadVlQ4CJBJqt299ZJisJWiV9jQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=THTsQOob; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-530e2548dfdso4719527e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 04:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1724065817; x=1724670617; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XE2ug3irN3B0PzcH/qnDG30H87tv6xYk/Cf9lQioacg=;
        b=THTsQOobrrifUcn+RgJmj6zAOqWzfiDCjRaXYBr+Q1JJediOe6MBj11XFNDyPMKBCg
         G4swmIjtcNdTSGXkajU7Lr7kr1ZqcHZEeLWf2h+fSly9jdvq0ksOqlZkGqH9OQevJblI
         hQvy+zrJzqAkkJp+RE8dCkhJpPFD2thP7ulVfORQnv2mrn4fA+aTKN6d4REmOEb1UGbl
         ffRnScbZ/z4whweQewhjqJas1Z/8T+3TNKsnwQgJ67m3AP6x3VfAs1/wUMISFHe/18yy
         BGp8GMfVWTbiheNIkISXFd05Y/FirXXFBMzNi2izqCl0Ze4DpwlHUibBQ5m46fMaPYD7
         wpWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724065817; x=1724670617;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XE2ug3irN3B0PzcH/qnDG30H87tv6xYk/Cf9lQioacg=;
        b=pyj2vlY7uF8/GJL8S6z3AdkgVs843ygPSZ68NFn9/VHEFmr/E7pDqtmLM13l1QAxJh
         /SXaE5ID4Lf+WWo2stOeCjydkpwimkWMgK18JC8w+giKhvXoNyDHf2ToxcMNpdFVzR35
         J8oDkTLEKyUyYlmoMSHfAddT9twBLARzRCj2614zWRq8FPeDELGpQlqY1OkiVeizejZ4
         rTbBQiry8SEDg63nS+n4S/uCYUzweEmSuGFvj7XdAIVFDd0U8aVsIKtuBDgcGcJuwIYF
         wM9SpeIbRULmlXPITvwFM0FpbYKv29yv563TMxz36k2wnQJEc+5t0jQWTuzU7PhwA7n/
         IVNQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2ZomJoJS1cSQntHTlfT96WJZuwYM+nX01BjjdjS9gHtn/2Wv54txKJf0XNmwbrTjsaiDkg6o1fYUEKQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO/wytBQ8iNhKRusqfJd6Kh8x41DtqLVEJ+2hDral7T+BEcQfb
	T7ZHHaAV4weQJhCz0U3ylYSEsUa6esMCTMFY6MwsocLz02y6NXn+KR2Qj23LcL8=
X-Google-Smtp-Source: AGHT+IFVSravI8lfSdiu804ftuzvsmERhC3uU+IGlqmkWfmDLfcT8JqBkHBmuPpnv9kff6wDZ8wXAQ==
X-Received: by 2002:a05:6512:3e22:b0:52f:307:d5ee with SMTP id 2adb3069b0e04-5332df3699fmr4142624e87.4.1724065816798;
        Mon, 19 Aug 2024 04:10:16 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838c6998sm627728366b.19.2024.08.19.04.10.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 04:10:16 -0700 (PDT)
Message-ID: <e6377448-9af3-4807-a8fd-197f5b2b4aa4@tuxon.dev>
Date: Mon, 19 Aug 2024 14:10:14 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/11] dt-bindings: i2c: renesas,riic: Document the
 R9A08G045 support
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: chris.brandt@renesas.com, andi.shyti@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, geert+renesas@glider.be,
 magnus.damm@gmail.com, p.zabel@pengutronix.de,
 wsa+renesas@sang-engineering.com, linux-renesas-soc@vger.kernel.org,
 linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20240819102348.1592171-1-claudiu.beznea.uj@bp.renesas.com>
 <20240819102348.1592171-8-claudiu.beznea.uj@bp.renesas.com>
 <gxjlmdjicwzlexitsx673beyn7ijuf47637nao2luc5h6h6hvi@qstobttin7dw>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <gxjlmdjicwzlexitsx673beyn7ijuf47637nao2luc5h6h6hvi@qstobttin7dw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 19.08.2024 14:05, Krzysztof Kozlowski wrote:
> On Mon, Aug 19, 2024 at 01:23:44PM +0300, Claudiu wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> Document the Renesas RZ/G3S (R9A08G045) RIIC IP. This is compatible with
>> the version available on Renesas RZ/V2H (R9A09G075).
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>> ---
>>
>> Changes in v4:
>> - added comment near the fallback for RZ/G3S; because of this
>>   dropped Conor's tag
> 
> That's not a reason to request a re-review.

Sorry for that, I wasn't aware of the procedure for this on bindings.

Thank you,
Claudiu Beznea

> 
> Best regards,
> Krzysztof
> 

