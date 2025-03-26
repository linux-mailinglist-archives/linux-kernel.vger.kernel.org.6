Return-Path: <linux-kernel+bounces-576738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 499D2A713CB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 10:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26F18189542E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 09:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF81515381A;
	Wed, 26 Mar 2025 09:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Meadw21h"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2B11A08B8
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 09:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742981723; cv=none; b=PzsDKcahwRbZNAPSVEL6cJZbUTQu9eFMH7LlI6ybZFZF7JfudzbRvabLYd+vDl+kI9RquacPLbWTjtMZzuL9bPwgKm5lEJObqQ4PCDZx2DwQDn4WjNabbQbao3uAPXi9D2HU3Kc5cgK0CVlQgcWy/doAxf8EB1nDh6vKTW4Cqs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742981723; c=relaxed/simple;
	bh=mO7U4m0oTja17D3RFzqvynDUKnVhiYqxVxjxnWasqbo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ExONWOb8GIQbfFvXSM4jLQCfk7yMpsMLSfSGOesXWFg/l2PAyTG6OQiTVYzJaRp2OHlZ2/BMrwPb/vsj1qL9A16i0cGukaA60W2UR6vYezqqg32PYV1qQPEQOC3HbElJGVGHyAvvIwa2inFhjUweaQrLfI16zG1hZdptIiO5ewk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Meadw21h; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43cf0d787eeso68333235e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 02:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742981720; x=1743586520; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mO7U4m0oTja17D3RFzqvynDUKnVhiYqxVxjxnWasqbo=;
        b=Meadw21hAJAbPxHWIvE2IdbDLH8Iu3gP2LwW1a7LUKHThLlqX6CsngMPJQR3Q8jmMi
         Y/eXaeJ2x7qmckOmGM+Jt76QXYznKk6sayGrFiGmC3p4f12N30t7L+d30z9E2Q8aBkXP
         iQ9hoRNkYoHeidu7iB/Di4Nb87PM8VkZiIUZy8lIkD+LLt/igq+9XyvPqk1gxuPfoNxl
         az/n99XmR9iXn/FKMzOJ5s0zKA/MJzY5VQAMMlW+2epY2do+caRJMfrvEs7M1EEfVSIC
         BfJkoIRfkPD63mUG+g0R72X73Y+mHNCvriWSWpX1id9Hr4XFD9b76gm+Vt2PfVNWG7gs
         QRsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742981720; x=1743586520;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mO7U4m0oTja17D3RFzqvynDUKnVhiYqxVxjxnWasqbo=;
        b=PSoLvWwxL+Twgv9go77bXiazvs5sQzAAVWZJfsD+SYEoZCOSvDN2Vc4pwmLBH3diG1
         XJnEaTspB0ja7W1qvld/QMZNydPxoHwJSnx2Fif53ouyn/44gLSLq8dAmOd49GYYnpeB
         yYXsqgkSVTzZmSxypqQ2fTuAARvloLtD4hO+EEXEeNJaAL4jo/C6aIBK3h0wBBpL8MAO
         56PIPNBmlx+1OGkH/+NYGEvAm+5AYrIbQTAVBu9/MGCd1GdHl0W8RT1tBUS6kcWUfn7J
         YKo7Zj/xSeuElL5c4HddYNbN5iJUvBK4B28L5eQVUkVxOX5NkWd7i019zZtY/Qw6Gir8
         lGgw==
X-Forwarded-Encrypted: i=1; AJvYcCW5yufQjlLtaoBFG7Jn3D9eU7dMh3vw2PTxjwxwTAuM3xmOBpbi8+RGgT77wiVocDhdO9vtXjZXORreW2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMQMuvGwmz52+meLbRt3SnGwsXcj8hxjIBvN314DhGgSqz/4Bd
	TVXzvcQjFwoNxRSzlKn8FhRZ9xmM53PG3upTeeZH8eXHXl1oNpMmqWVeIjrkscs=
X-Gm-Gg: ASbGnctwpELPs0nzkDvG3JcsCZP2VD2/u0AE5CUZ5edpV1YM7XOrRqUMT/qc4PQ8bZ2
	p/KRh1WyoQE+rkbjMNiV52GoYDt94ZxMeWsUR6199MqHrtbnZ1Xx4o8xH9cp8vwkCxHpvag/h6Y
	gl3DdlJYWN+C/ONDa4XbfySRd/fQFMfi2legGLo+xFBDYufg4Ap/en1Czx0UnuJuboSAUphkgwC
	5GzzDTcoK9OfqSOBMmxyaqxG/LJEXaJChjMp7b+64ieOpBDPURamg8pQOJnqowvRpRDU2gWsHZI
	tykftWsUbvaGNjrn18vr9bcEtVf4ZYFr9moWYkQQRZ/ghgDPJg==
X-Google-Smtp-Source: AGHT+IGcfQ6I4FNrJirurd36EI4HsUJuWVwi1KHS1E2yEYqjMI56gm6awQtr8PEUURenI12KJk6YUQ==
X-Received: by 2002:a05:600c:c0d:b0:43d:738:4a9 with SMTP id 5b1f17b1804b1-43d50a33d03mr152636725e9.27.1742981719714;
        Wed, 26 Mar 2025 02:35:19 -0700 (PDT)
Received: from [10.1.1.109] ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f32fcdsm232615235e9.7.2025.03.26.02.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 02:35:19 -0700 (PDT)
Message-ID: <40a8d82aab764669cf755adbabac80a5c0044a5e.camel@linaro.org>
Subject: Re: [PATCH 12/34] mfd: sec: add support for S2MPG10 PMIC
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>, Rob
 Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Sylwester
 Nawrocki	 <s.nawrocki@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>,
 Alim Akhtar	 <alim.akhtar@samsung.com>, Michael Turquette
 <mturquette@baylibre.com>,  Stephen Boyd <sboyd@kernel.org>, Russell King
 <linux@armlinux.org.uk>, Catalin Marinas	 <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, Alexandre Belloni	 <alexandre.belloni@bootlin.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, Tudor Ambarus
	 <tudor.ambarus@linaro.org>, Will McVicker <willmcvicker@google.com>, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rtc@vger.kernel.org
Date: Wed, 26 Mar 2025 09:35:18 +0000
In-Reply-To: <25eb9c47-96ba-4037-b320-af16e0226f4c@kernel.org>
References: <20250323-s2mpg10-v1-0-d08943702707@linaro.org>
	 <20250323-s2mpg10-v1-12-d08943702707@linaro.org>
	 <25eb9c47-96ba-4037-b320-af16e0226f4c@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.53.2-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-03-26 at 08:22 +0100, Krzysztof Kozlowski wrote:
> On 23/03/2025 23:39, Andr=C3=A9 Draszik wrote:
> > Add support for Samsung's S2MPG10 PMIC, which is a Power Management IC
> > for mobile applications with buck converters, various LDOs, power
> > meters, RTC, clock outputs, and additional GPIOs interfaces.
> >=20
> > Contrary to existing Samsung S2M series PMICs supported, communication
> > is not via I2C, but via the Samsung ACPM firmware.
> >=20
> > This commit adds the core driver.
> >=20
> > Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> >=20
> > ---
> > Checkpatch suggests to update MAINTAINERS, but the new file is covered
> > already due to using a wildcard.
> > ---
>=20
> I did a quick look and seems fine, but I suspect small rework when PMIC
> becames child of ACPM, so full review later.

Thanks Krzysztof! And yes, there'll be a small change to support that appro=
ach
instead.


Cheers,
Andre'


