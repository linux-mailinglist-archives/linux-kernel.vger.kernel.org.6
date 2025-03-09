Return-Path: <linux-kernel+bounces-552935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E90EA58135
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 07:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A112F16A580
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 06:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C1516F841;
	Sun,  9 Mar 2025 06:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CbUzP61E"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151C1C2FD;
	Sun,  9 Mar 2025 06:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741503056; cv=none; b=CtLnUQVF4Oa9Bghj/m9kni5RQHPOL+DEFfgHad7F7CooEeAmZped6Dbr3Hdd9tQNOeudJw0WqWYYpCWo8tTdSO6g39uDCA+y7L/htasUGJYXqOKOgvLU0U2OBSJN2j3YyfSW8Cydg1L+LhQG3oPCVrwe35HA1gISc4GVecs1DP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741503056; c=relaxed/simple;
	bh=XXrGeMKEDMltcTZOnuSwc6OZdvzBmHyoGR0fdEWW+BE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BBhsHzevqDMTs+ur9o9R3scuXqY7xmHxksyu2Wlz/fW3uspZqGWRO7bSv0INitWSZcujy6wp8OpnnQ9dpT1X/KzgF6WF/XRZ961FGCebFcw8OGje8pYg878V3+blqvWnEA3+crsgnZsu+VBExfzVXyjKjGaG9FV/HHHHjjpGxSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CbUzP61E; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aaecf50578eso575385266b.2;
        Sat, 08 Mar 2025 22:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741503052; x=1742107852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XXrGeMKEDMltcTZOnuSwc6OZdvzBmHyoGR0fdEWW+BE=;
        b=CbUzP61ECY+iTbNpLudDISWzCX83M4Qbpkg0fVFH+UqxoEsiIKIVGtrkh1VL60Dbgh
         xmBblD69OAZR7iFLsiOJjiJVoIiX4TO3yzmVpbQQ40PTJR9qzou4BbIb6hrC4hCWLwH9
         hKpir2ygr7u/rxaKDbrQcN7Tb+d4k/C7Vo4HtKRwAzKD8YEmDX4aBmtfsSgXtIcC5QDm
         HWiYd0A22PYtWx1TIDv9AyrN8aP+mkI4bOvICnHXqSAuBHVZst/ym49K0LPIumzdCaws
         zuGgitkohBoHiUiWgrxfdeh+ytvFVlFn7oxOgbBrVJFWiLS6zVANjjwI1PQWyUz2m0/0
         RGpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741503052; x=1742107852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XXrGeMKEDMltcTZOnuSwc6OZdvzBmHyoGR0fdEWW+BE=;
        b=Wi6+oeNnmmf80L/N4hExp9X8eo3MmsLQIk5Ww3oCtcZJUbwLvHs+tXw4FHP/CC2k5C
         nfyh0v48Ahq04OcmQNkgEuI7kZOGVQ3vTkUJDMXXDEw6SvPbpw2J4eOtFBTcU7qnYzxO
         trWJN6tzSombf/uBadYXRgLD6Gcq6O+HRu9jE9cKr3Dgsia1tQCycugGZhknqY9O+Oq4
         fexYmuNo5i7XnJnA101TPWC11oLCBYOicOobqa8OJJtMnfuvVuByjwYf4JEGAwlCEbCL
         R5JASNF0NwgHG/RLx/vZxQ5gEkn8YZobO1kuDOutQuiia8u4DdjeAGvYnuNonfE3Dukd
         JrWg==
X-Forwarded-Encrypted: i=1; AJvYcCUM2WFLRBcW0eABej9gqJbRUbS/v0FBKB73ecPzEfcvaKOUfjGxb6yAl759TTAbNHwbELYgpKSkoDjo@vger.kernel.org, AJvYcCVlHnrB7DV+EDX1JZPjUHDEZsZ5trWypNH7LueQ9Sw7hMCOP9IBpVTrP2rWrsFT6uevlNay0XYiA0p5i3hs@vger.kernel.org, AJvYcCWsKXCYYmUA6eFtYZBkgdn9uOIRRDKJku17IPlKMDKoplB2N97INWuiOvNzyt/NDIFw93U15tM3l1M9@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj+Mz/3gWSPqS/Ze2o2ZPLm+IE4xtdjOzvX0Wv/3uNcmYDUDIz
	LOgjGoC7fVilAoT0Es++WCtngOGTbC69FyY5g10gqFcpwDosCLfRSI8hsA==
X-Gm-Gg: ASbGncs9iLQhXas0zDg8tpbmydb4GGDM0NpPULJd6Ox3PVeheADiu1I+zyQvIrQniLN
	l6lCKJe3BOybWqVSXxTtdL0q4tlSpVKefF6gBGvsiuHPr9mDYfM/GwgOyAEqPE5zBIbCBvTEbwi
	ycnM1RiDmu4Yq71qIlaicH7XEchWiLLQJDWTLJ7JUzl3P9iGKJ/F/mKZ0hA2OtliAcjjsO7zrmR
	I9zZGRcscyzgUntW8We+h0dsJpjhatBIxCd6SKfmOuXX2s7+MI98wX4JXrB5cWKTkFVlXRCyGa9
	gF213DkdxK5cQLVBL8abfu+i5/0jjOpoz0AZ5F1NPvjAijikmDRaxVrE14G2xa9eRA==
X-Google-Smtp-Source: AGHT+IFXyBjwKS8n+FEnVkJuV0T3jFruhFE2A6vtlJI4jqzFnqL4g16+EpSl4SMNWytxbOSvgcDIjA==
X-Received: by 2002:a17:907:9490:b0:ab7:9df1:e562 with SMTP id a640c23a62f3a-ac252fe7196mr919864166b.48.1741503052319;
        Sat, 08 Mar 2025 22:50:52 -0800 (PST)
Received: from jernej-laptop.localnet ([188.159.248.16])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac23943c476sm544681966b.3.2025.03.08.22.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Mar 2025 22:50:51 -0800 (PST)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
 Andre Przywara <andre.przywara@arm.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 08/14] clk: sunxi-ng: a523: add system mod clocks
Date: Sun, 09 Mar 2025 07:50:50 +0100
Message-ID: <2214425.irdbgypaU6@jernej-laptop>
In-Reply-To: <20250307002628.10684-9-andre.przywara@arm.com>
References:
 <20250307002628.10684-1-andre.przywara@arm.com>
 <20250307002628.10684-9-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne petek, 7. marec 2025 ob 01:26:22 Srednjeevropski standardni =C4=8Das je=
 Andre Przywara napisal(a):
> Add the clocks driving some core system related subsystems of the SoC:
> the "CE" crypto engine, the high speed timers, the DRAM and the associated
> MBUS clock, and the PCIe clock.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



