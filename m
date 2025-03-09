Return-Path: <linux-kernel+bounces-552932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A938CA58127
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 07:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB7F87A4E13
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 06:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0AF1624C3;
	Sun,  9 Mar 2025 06:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2GA3mzl"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77997383A2;
	Sun,  9 Mar 2025 06:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741502289; cv=none; b=ONuC2Zl0qHYtlhrPCSj2yFTH+54PcOcnJlyCxFTkl/fNhTLBHvJQ9ytHcKGYU7FQAJ0XONtuxk1hfKK2HWlhNRX6AHVgCjAk8UuLP1MliLSLA/51bFXafLhROXMeu64sD1hcIHBUGbpkwVeWEBzI8AQ1iNC5YWP1GcvBK2SEVpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741502289; c=relaxed/simple;
	bh=Fz6Jf36xcTh8dqFosjtzLD6W+gVvPK4QQTcyeflwbf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mp42AnEY3npcm4v1z3AAv2hZZJKISNl+Yx8Nrt94HzzdhBdS57423LJTx+J1F6VnfOK2vxcE9JPdEXpmeFSDVj52rC1AziOlpvw/NaLuFFSBWr7sTZIaKltvfWta/x00i5Xj14mYIJ+WrLHU7YifAIgzAlKmggMuKUinN8J2YTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K2GA3mzl; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e5b572e45cso5525273a12.0;
        Sat, 08 Mar 2025 22:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741502286; x=1742107086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fz6Jf36xcTh8dqFosjtzLD6W+gVvPK4QQTcyeflwbf0=;
        b=K2GA3mzlHo/abNU9LwtHCZS2k6G7hBssOIrRu4iSuRl0bnnh11EuL1auxh0fBiBM8r
         mPNsLHXl7vUMLvu2Wfy5aCAezZrfUuPWNOK6Uq39M+6VtLTuFPDyPtsRo+yijtmA9Xjz
         ZUPtfNWmUXinfQSK0Z4/fNPYUB1aa4XW4BoBZXT4tvbfw5/ZGA899ExJ7+Z/x4m3YEvs
         JnSlacoseDILbD12UV2kNOXwVrbFGIagzSxpeUsZP797RMPmQrtam7nuZSqho7V4cfeT
         GAud17bKwvKA3nMIQOWmywLjyGmybqXLIF1wDC5Af+x4SWGVw6xeANFGiWnVNAaWuuJz
         Yfrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741502286; x=1742107086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fz6Jf36xcTh8dqFosjtzLD6W+gVvPK4QQTcyeflwbf0=;
        b=kqOxlSL17KIQIaeT4EuKk5jKdP1pAW8mrminPlK67e6jaaiOhNlTrWPXOp4osrq2w1
         OHtsL3P5iwOAM8ey/lttUQpA6TX6zSw26gEiyNC4zfn1nSQmTcWWxNItZhHPimpew24d
         Wp973yqESY2GlTs/YhfHL5N2G6oYjW66y2bXpnhqpHc1SOcX1zvbj/iLaWQxJFQGzF0w
         RfMX8cHxOcOZOiWXojUThDGRlkbVvPCdkICajSzzFO+QkZz5GezMcagtPoYQPTa4Gz6W
         d2ht7lHy3VRkvaYExNPZKiQx+cbvDmR1SKi6820gP2PEuO1uDBmELsGkOqZ6txeruwOQ
         sBRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjJJCBDzwBpSoIw8I4+B/h66ZBzx2mHOCHGfqkekXZuRI/rBbi2eCl9h7b/3j57cBTWAhsEomgfBsK@vger.kernel.org, AJvYcCW5eMLZ9Zjwcjug3pB9n7a+yzNiBJOKzrwkBp0gowRjFbRC6szxFMj7Pts3nzx1CZzh12oBn1syVrP7GE0L@vger.kernel.org, AJvYcCWdUarCMn+H1OeQgcKiydyRaF4y4+oJpJYUWjLhQAYfUanAd0zretD120SPFcsaPIP8UDd7XZMtOfl0@vger.kernel.org
X-Gm-Message-State: AOJu0YyykWd+iCeiApHUPoPBKC0j3CzTAtNP1jEeVtbOQUJ2Eny9b5sV
	Ag/VabJxUKcNxPGwxHVL2ce8DLNoI7NEeMuzRgPKRnGhdDMmoN0wNg46sg==
X-Gm-Gg: ASbGncvMTIuBDRaW4n1zyPE38KHRNK5SRcNjNW9WBKSJ0SHpEk2NaIfrUf4lzVjO0wN
	tevOyT9OZ1wRqhdrwL2PjjijAK6rjSRb15hF72qKspCb6QF0v5I9akA2QNMmR7DaTe1YNlLE2vb
	j9xNVIX1vF82tp/5oG19ByIAyaenKBVZdhgKvkH6dwAQu0DXXbfqZpoM/SfDTZGHA68/YNCu1Dm
	jMbFE2ulh5zC7UhfE/1We8detcwJfpkL5LQHQk+O9Lu7yfWXjDXRTNS5gEXVc8m3RsrdbhtkOOh
	Xd3Fbms3T8F2sF0pyj+ekazO+aib0pMBa6etYUNNZ10cTPUZIWeV4vJaPpUHJep7ew==
X-Google-Smtp-Source: AGHT+IHhG0nyJSWhRdWZlqSDCjjx4E4luGYWfPo00aAv/HBDZfhIYjAS5k26NpukDfuKeycSfkBWmw==
X-Received: by 2002:a17:907:97c6:b0:abf:4c82:22b1 with SMTP id a640c23a62f3a-ac252738126mr1024070266b.32.1741502285623;
        Sat, 08 Mar 2025 22:38:05 -0800 (PST)
Received: from jernej-laptop.localnet ([188.159.248.16])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac23943945asm538979266b.22.2025.03.08.22.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Mar 2025 22:38:05 -0800 (PST)
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
 Re: [PATCH v4 02/14] clk: sunxi-ng: mp: provide wrappers for setting feature
 flags
Date: Sun, 09 Mar 2025 07:38:04 +0100
Message-ID: <5865232.DvuYhMxLoT@jernej-laptop>
In-Reply-To: <20250307002628.10684-3-andre.przywara@arm.com>
References:
 <20250307002628.10684-1-andre.przywara@arm.com>
 <20250307002628.10684-3-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne petek, 7. marec 2025 ob 01:26:16 Srednjeevropski standardni =C4=8Das je=
 Andre Przywara napisal(a):
> So far our sunxi clock instantiation macros set the required clock
> features depending on the clock type, but the new "dual divider MP
> clock" requires us to pass that piece of information in by the user.
>=20
> Add new wrapper macros that allow to specify a "features" field, to
> allow marking those dual-divider clocks accordingly. Also add two
> convenience macros that deal with the most common cases.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



