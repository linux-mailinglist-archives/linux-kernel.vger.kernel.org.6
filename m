Return-Path: <linux-kernel+bounces-552942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 688BFA58148
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 08:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9579116C63F
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 07:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C8B17A302;
	Sun,  9 Mar 2025 07:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OivxfR8V"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838FD14EC60;
	Sun,  9 Mar 2025 07:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741503626; cv=none; b=s6hYIRUz02+Z9nA85Tw+qfKClOOWP11KVo64a1ZnOGbpGmGLNfAVAdDVn9YnXqC65EWZ2rciGEdiHO9wYinu5WgmPQysdvUUB3eIKj1wwGeboGV6093bPAYDafYo32IfA3OPzar4D2/dFCSjx6px00Agh5nlGjuwIWTsqPF8pkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741503626; c=relaxed/simple;
	bh=rOXmjlR5Rk5KRf6rwJVBLM/R3Wk88g6lM6HYMKYo1vc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EPaaizeyVXno11gm91jqfF/IQ6oQs00z2Qs+kNAZpah5L8baWW8jJnWWqt9CfwD6aN8yIPv7m8/uvvgXKTtM3U7MIllPF1Gtj5/OtBkEGQhUfrUpntTv25k3as4cF45I9pTHdovOq1iqnnDnjDORCxGXE2nw1yqoPQQjUzkwqvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OivxfR8V; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac286d4ed05so69452166b.3;
        Sat, 08 Mar 2025 23:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741503623; x=1742108423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rOXmjlR5Rk5KRf6rwJVBLM/R3Wk88g6lM6HYMKYo1vc=;
        b=OivxfR8VZ5XR8G77NtRLleFptoKasQXkSyJKpSLlZxf3AFUUKRo4NFb8tnEgcBNvOy
         cR7gW1dxB+1akXWuJqyGix1IiLsIfy0I5Am5SlPVeWjQ0/sPQoaKfp92PNe6J/1sJGJl
         VSiNt5ik9cFviAjB/xkQ7E2QkpY1TbFu37Ju8WwZbX4+iAMatlKKYIlwzteijzSkSG9r
         vAvP8yeVlKLLqSAYjyTyJpPA6U/zKn1H9fwMSOSWyLkTUzrQPc9Xgi2dozvzCSxr1hU9
         0ncFrBqQbfaTG21rlusRcArneeogS3UQjktn5xtXqCUvG6lJ2XLhWu6B1sCxY1LT1RnT
         m+SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741503623; x=1742108423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rOXmjlR5Rk5KRf6rwJVBLM/R3Wk88g6lM6HYMKYo1vc=;
        b=oAyLtl/ZkjVwgMwicVccu2fF/DC4NpNmotPVgDk9DUTMIh5raauHgoiP5iZQqobL+x
         kKnrwvs16Yky0UBNyFUtshP4HpQvjcN9SDADT6UuOK/Hc/smsmeUo6Lm4XyLRXLiYEhx
         Jinwl0HAmip02KVb7jpVee2eCmMWyhqGzT4CkzAsJP7TfQJN/kaJhEv1Vce5LSVwr3X3
         SJ8TVOUUA1oIRxrQLgqSGaoVwrQQAWYs7CqCE5n2ywGvQFTMZdnMNGRODcZ67y8kBcpr
         Cr9rS1wrhWlLXYq169WUb52BW2YJLDBjZ3aGORo3FMtvpHH0g1v/4MX35kn3pyOl+Z/9
         B+ww==
X-Forwarded-Encrypted: i=1; AJvYcCW8P1LhDBb3HDvsIQHm2rWYdpgjfDDcO5ZcSwkiqGkbtRH+JT6FHbFNOz6ikXyIdVHcZC78uPvTskUA@vger.kernel.org, AJvYcCWMwxB6t+7doB8KxkBONHSvpK+4eAxOI9d4BXJP6bXiOQtpC0TzfLlT8LieV9iKLBTjia2jkQZ3ps4ETYt5@vger.kernel.org, AJvYcCWlh4teTddDfxn1E9v2S9iiJHQ5dxfelNM71A405NvCb3OrGDX0JlSdxl+ER0nQCggdLut+vMRDPVc6@vger.kernel.org
X-Gm-Message-State: AOJu0YxlfGoRjHbeaURsX+UfNWME0KDB512pRwk4y89SIzlROnjEEHqA
	+pSsyqZ8rAYfxHHSEFZFzQZRtDlbxzf2qrctd6MhFSYE08K/5j9b
X-Gm-Gg: ASbGncsdO8Bjg2B5lqEUtTCUZtvrceqRjw2oWLhE+/1mO3Incayhg237K2kjPyUNfGI
	LaThPTp43DHKTrfORj/bAhSKVt87aMjyCKrf/27y3sk/ewj6G6ZTMah4vjESHTDY9zR/dylOQUI
	esGGA3ehJVcRXgIO1cWKHsii/wULi1AKTsy6B+Wo566JT6msKU6yQJ+zG+KWSQF4Qpl+H+V7YRv
	0GNV4tl6MCvt6Td6RJUhNDDnsTnblhsI9tagshOtnmyjghRJEAMiqHc2pddAkPE3GyKtWrQUZY9
	3aVeUkLhfDBpLXI2MihAQYR0bvYpo9sZEpPIkCyQTNmS3LYN6RMUzYrhz2DBuxVFzg==
X-Google-Smtp-Source: AGHT+IHYSxE3dHIHTEa8uoEGGMpuf/AZ9EL0n7GTLf/jTzfr1egAgB9Y7RFOLIp+NZliiikRziEP0A==
X-Received: by 2002:a17:907:94c8:b0:abf:45d9:2607 with SMTP id a640c23a62f3a-ac252598005mr1084558066b.3.1741503622721;
        Sat, 08 Mar 2025 23:00:22 -0800 (PST)
Received: from jernej-laptop.localnet ([188.159.248.16])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac299a025c7sm14713966b.51.2025.03.08.23.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Mar 2025 23:00:22 -0800 (PST)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
 Andre Przywara <andre.przywara@arm.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 13/14] clk: sunxi-ng: a523: add reset lines
Date: Sun, 09 Mar 2025 08:00:20 +0100
Message-ID: <1994155.PYKUYFuaPT@jernej-laptop>
In-Reply-To: <20250307002628.10684-14-andre.przywara@arm.com>
References:
 <20250307002628.10684-1-andre.przywara@arm.com>
 <20250307002628.10684-14-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne petek, 7. marec 2025 ob 01:26:27 Srednjeevropski standardni =C4=8Das je=
 Andre Przywara napisal(a):
> Allwinner SoCs do not contain a separate reset controller, instead the
> reset lines for the various devices are integrated into the "BGR" (Bus
> Gate / Reset) registers, for each device group: one for all UARTs, one
> for all SPI interfaces, and so on.
> The Allwinner CCU driver also doubles as a reset provider, and since the
> reset lines are indeed just single bits in those BGR register, we can
> represent them easily in an array of structs, just containing the
> register offset and the bit number.
>=20
> Add the location of the reset bits for all devices in the A523/T527
> SoCs, using the existing sunxi CCU infrastructure.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



