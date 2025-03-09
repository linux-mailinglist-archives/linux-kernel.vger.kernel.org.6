Return-Path: <linux-kernel+bounces-552933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A529A5812B
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 07:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD79D16A85D
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 06:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37EC16F265;
	Sun,  9 Mar 2025 06:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+cQOKTP"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93254C79;
	Sun,  9 Mar 2025 06:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741502623; cv=none; b=K2Sz+sESMClrtRw564TEzmZZDQ04ZazVA0A1G98atP2IwU0aRN1QphirQlorduGGsPVKmiP4D/CRTCqJhm8qdaXOpkpQ9+U1yq44eYJuXiZA7VxZ0Zg+MGPg6HQx11rGjSKI5s+vulU7herQEx76ZEepNF13Vb9FWEV2K52p8mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741502623; c=relaxed/simple;
	bh=pcbrVw4Njs0Kum/2VhRZM7j2L0V2JUwYQMRq+XXSVQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z53PORWtPYsqLLge1WaBEx/CNT8h9qO/z1y6aBvN9bi054CYeHoJYlVGu73JKm2z594mbsKomVc+vrhLbjRhZyKK7nhs+8Et26N6IHswV2FtRUZrUNP8bhygp0vk5dRTf8kyMwrmQM6CEypD1k0Uuqermgi7iU7i7GuB8CQgwvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b+cQOKTP; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e5c7d6b96fso5244728a12.3;
        Sat, 08 Mar 2025 22:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741502620; x=1742107420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pcbrVw4Njs0Kum/2VhRZM7j2L0V2JUwYQMRq+XXSVQ8=;
        b=b+cQOKTPCSwr/riYERqUAZkQYKXCDH5490g5ej97iDHdZtWWy3bosqKZA75UWNjynE
         a9JJIMlIUHosIkRCZgHzJ9+FxKobVWrc9XGTl2pJSwSspW0QzEMeUaS69QtgbM2VM59B
         TyS3O4PO21yInQYPbB4YCxqla9irWROtcAriN2IqlK3B6Eib0KyJyurCpjmu/Gaaow5C
         D30DZJqhBHgqgO+e0Z+xkpGbDLzlGG+WclHijDHLWE/P3QrLqx8emd740eVxY21NTKUG
         DZJY58mcl93QLzS46g6KB44mmEdq5N4Y9fjpyQhWTevniH+wuvaYTc/MyIZ8qs6SYjTn
         Ksfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741502620; x=1742107420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pcbrVw4Njs0Kum/2VhRZM7j2L0V2JUwYQMRq+XXSVQ8=;
        b=WGBiBZx/bMzHVd/cxIe30ZFuyoXjOViI2t9TFDBvTgEF6ensrzS/Sey5MOKHpZWfGf
         AnISL402QP9tyircO2Lo4TKykr9aYfZA7AYxC84m2i+4IG1LKmoZD6CsX51S1BNVVLT3
         QcqFKdZqyg1qRvUYKMwlk+aqc9hmLSeMSngfXnSnLZ9881mdPGAvh7TbbUUwvaPui72V
         251yJGfBO7NgRHXEu6dRUjAmAapA+EeUkmmRxlJib7lhVS8zRPxr3DJFzlCa7RaMSBvA
         5wvYCqhTnkIVSDR3VB3vOh6ZQXQTliCSXMqdBI5AzsI8Pbgj29nFvg7itS14QCG8KZmo
         7NBQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4CTULiw/Rh3temun2BE6ZZ67xZ8ffeB30/e7bmK3ET55W65TcfoplfnUctSQftVsQS03Mi4e9tBFofDMp@vger.kernel.org, AJvYcCUtysMGHblL1jEqICEZVXQPoW9DOpopLiP3AtpetmUBXTKvueWdywL0U9izxOuoh054JHok4WFZmPE2@vger.kernel.org, AJvYcCXHTIzyeDpCN62Q/lO4GWWuWvUaJ724a8IUnR9YpZVTJYiFrFEKIU+zTVl2G58EwtY/M67tw8DI5CFL@vger.kernel.org
X-Gm-Message-State: AOJu0YwX0Nj6D/nZ9BBJLh/kDI1s7BYr+zeq7A7gw3C0WleliuDbVbGg
	mDK7zf0Dxot9aHTULPvOAHMSK/2/2LvCvH+3hzf6vmJfsbyWNdmf
X-Gm-Gg: ASbGnctbw0mVYP+1/uSPLoYxUWF3eLbWURWVJPsxQ1wGqWO5NzUKd3d+sVMgsnpoMa/
	UIXX4h+5ioSo3pe8eNMBDOfqXmEDM5RAksb68nUiKb5+Ofnpk36D/ifB9SaB3q0+jDRLl4GmDMx
	gMkauku6enFJI2dov7e9AAQoQx5WBzUJkZFuFqTXRP7KfdulwvD+6jZHau/dSwOiwe5jQSLUIvw
	ZJUQjAEmWM/PWDIWmB46wEGCH5aMKDiDZr8Klag2UtRON4rScm+ya/+PMF+YtLaHLEWHCpPYFpA
	LkxOCszKAxyJl9zlZ+zaXZ0vuf0Pqiw50plrxHJSQD3tnjs0xVTbYKwrk/3quURBtw==
X-Google-Smtp-Source: AGHT+IGoHXU/ZKdJQBXrrTuO1peZxmq65riLT31sE4BFWMi71oPY28XqAsCq2AVsnbOJtj538rdAGw==
X-Received: by 2002:a17:907:2d92:b0:ac1:fab4:a83 with SMTP id a640c23a62f3a-ac252b5a837mr1044767666b.25.1741502620028;
        Sat, 08 Mar 2025 22:43:40 -0800 (PST)
Received: from jernej-laptop.localnet ([188.159.248.16])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac287653e64sm109036266b.136.2025.03.08.22.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Mar 2025 22:43:39 -0800 (PST)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
 Andre Przywara <andre.przywara@arm.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v4 05/14] clk: sunxi-ng: Add support for the A523/T527 CCU PLLs
Date: Sun, 09 Mar 2025 07:43:38 +0100
Message-ID: <4633243.LvFx2qVVIh@jernej-laptop>
In-Reply-To: <20250307002628.10684-6-andre.przywara@arm.com>
References:
 <20250307002628.10684-1-andre.przywara@arm.com>
 <20250307002628.10684-6-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne petek, 7. marec 2025 ob 01:26:19 Srednjeevropski standardni =C4=8Das je=
 Andre Przywara napisal(a):
> Add the PLL clocks of the main CCU of the Allwinner A523 and T527 SoCs.
> The clocks were modelled after the A523 and T527 manual, and double
> checked by writing all 1's into the respective register, to spot all
> implemented bits.
>=20
> The PLL and mod clocks for the two CPU clusters and the DSU are part of
> a separate CCU, also most audio clocks are collected in a DSP CCU, so
> both of these clock groups are missing from this driver.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



