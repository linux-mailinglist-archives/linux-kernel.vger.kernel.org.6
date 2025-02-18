Return-Path: <linux-kernel+bounces-520284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 774A3A3A7F3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 20:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 439A8172889
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 19:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503D71E833D;
	Tue, 18 Feb 2025 19:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ONSbl5Q7"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA6521B9C5;
	Tue, 18 Feb 2025 19:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739907971; cv=none; b=leTefC165JEmXmUrGT/Q17pCuAzpBCbrA9aFCLR4TBcxHnaI88NNV89DKOEHgtWb1tbxwnHCUAdx8JvPdC9R2yTb8Sx7bp0GtUoTqhNwOUnFwRH3YnA49xYBcDxMhiliGKHOZJLBj/dXsOJV4ktJlnK7sOIlJYt5J+KBpmLAPRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739907971; c=relaxed/simple;
	bh=yrjCylDVvM1JzrFd8ihuKPjDtBMnkU0vBwOAngnuvGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FvnMBORl72Qw2RE6SAfT1zcGMQwElzvpLEt4mosOP2SGSRLm4NhUlaA9rnFkPHSURnaSP38qnmf3aK5BOs+0d2AjYgrch2Hd7OtD758/KnBnSMOqUxRtZwRd0a61ekXiR16hwe+lUVRgV9O9cdsUFNVt6A4/S0mpsOsxpuwJpV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ONSbl5Q7; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4397e5d5d99so17375685e9.1;
        Tue, 18 Feb 2025 11:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739907968; x=1740512768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yrjCylDVvM1JzrFd8ihuKPjDtBMnkU0vBwOAngnuvGU=;
        b=ONSbl5Q7hqKvkZTcXKwqGFPnrROX4qNPJTfHjxPhHQWdeIRForWly3i4/EF5E6bQLc
         XTb5Bley3WKecpn2QgOVOS9o/JCAX5T3bPOBjXLEWtrgnrToRLoWR4y5J3zdtSEHI3MV
         nBCvQym0Ie+N3ntcCHkKhfUbKs2NvKvpgZG2YESGsG1i4+qpRWUrx8UoFLoxBKuWWcyw
         2NEPCNMs3iLIrtfFv9D5gH2IN8E1YGApf52DsSxqc0lUCXot4T2pwFrp9qCmO2jXwEQU
         wy+b/JAGnDSKjZeDVIZoLiJDUCiUY4QWGW/G21iLDZBFI6rABB19zJmewG2psiHzHWn4
         Y7HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739907968; x=1740512768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yrjCylDVvM1JzrFd8ihuKPjDtBMnkU0vBwOAngnuvGU=;
        b=s3kMfu+6dveomCDKVjkNty9DPjQoQsChIFpfkIIdl2HGPbYHApLZOxD2jmd16eadDO
         lZMjXy7PdlYnUs5WQQDM8ElA/wpI3t6Rb7k3usDxAYjDw9UFLcA3N6XAd+A9f8l4WNI4
         RHdxkSLPnEMZr04TI/2RFIL1pp8sH2IDdulDOIDVWF7YJB0AY3nk7c4JiKkEDcLy+Cqp
         v42Ywqu//1a/tTP+eCOf4F6yOF7iYiD5Em9oiafS2WSoawcMg4cxCQKalJ7+x9yarjQY
         IVRHPid3TrwAYe2BHQinLmHRNB0WCWkptOM6u3WLDdR0ScctNVXOOxcCXZubK1TYZEkY
         ym3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUzN94sqZX9C9kA8eSw/TXXQPj6yAgz8ypoQThMYa7Yat9b0aJvwBd+wU9LZN2ANfj7N7NsNMvhvo/f1R8Y@vger.kernel.org, AJvYcCWBuDniMb3QxxnOeejUTIv3lrKCUC7k8WChglVRc5lBF1gM9V7sx2RCmgQHpI13NyTLFXqydYubro/m@vger.kernel.org, AJvYcCXv6O8FGY1yegwMTu/cHj2tur2HpntdtFClUhuFkCPozgLBeQRYwIPFhhi/3lFLKMqxvUvpz48bcHMa@vger.kernel.org
X-Gm-Message-State: AOJu0YwWrrvERoHC4+OpUXGxly150qyH/0Bv6+C0NhzvYN3DMdvc0L/K
	WnmD77s9LpFmaAxKTbNCq7OOHEXZmmuUEH/JnkNf7sv9Ei5s9qFd
X-Gm-Gg: ASbGncuhDOyGbdTHh30hquiYV2uH4rW8vK4fLEd2wmzzVpSQdRqzx25GxcfFjovDQEA
	6Xn4GNmK8q8Nsk0PsiMM2TRBAK9zCVk1j0OcjpTDoYcvxH6/VuAogoGXn23M6XYlslxT6ZR/gyt
	RWetvGV5HyRh4y408YKEw84YcrkFmVMJDrD5Fs7j0bMk+U9YzxSq2/ViCL2z1y1IAE9TV6xpJdl
	pLSbSx6uaFbto/4E2gxuuaMoDB/5aXEER9ejFDmLfc/KsqbTYvJQvBUdk4AxbKy1S2pWCdoCAdT
	Yeqa6G4rwM1jQjvB8Q8LBdquxLhyTAhygxzm1X7vAlKrWNHsoz+gVigD3Ussqo1rQa8=
X-Google-Smtp-Source: AGHT+IFA6p9n50aVJnqGFUk/7jRV35aPeAFF0EkhsdD9wheQ/uYJENSRNYwnKizaauIZeKc29AB6rw==
X-Received: by 2002:a05:600c:1c84:b0:439:8c80:6af2 with SMTP id 5b1f17b1804b1-4398c806da5mr61455325e9.21.1739907966616;
        Tue, 18 Feb 2025 11:46:06 -0800 (PST)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43984924201sm68753485e9.6.2025.02.18.11.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 11:46:06 -0800 (PST)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
 Andre Przywara <andre.przywara@arm.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/15] clk: sunxi-ng: a523: add USB mod clocks
Date: Tue, 18 Feb 2025 20:46:05 +0100
Message-ID: <2220848.Mh6RI2rZIc@jernej-laptop>
In-Reply-To: <20250214125359.5204-11-andre.przywara@arm.com>
References:
 <20250214125359.5204-1-andre.przywara@arm.com>
 <20250214125359.5204-11-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne petek, 14. februar 2025 ob 13:53:54 Srednjeevropski standardni =C4=8Das=
 je Andre Przywara napisal(a):
> Add the clocks driving the USB subsystem: this just covers the two
> clocks creating the 12 MHz rate for the OHCI (USB 1.x) device. The rest
> of the USB clocks are either gate clocks (added later) or created
> internal to the USB IP.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



