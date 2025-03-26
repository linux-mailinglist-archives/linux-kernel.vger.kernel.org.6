Return-Path: <linux-kernel+bounces-576864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 571DAA71551
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 12:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31C563A86CC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 11:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FBFC1D6187;
	Wed, 26 Mar 2025 11:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aERq/NW6"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC6D1AF0AE;
	Wed, 26 Mar 2025 11:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742987349; cv=none; b=CJqo5cK+6+Wwji9vLVzBbHWHT7i/ii31CoEfl1rR9RKx5Xp4Jpo9m7CRJ6oXn85nEjEP7UjqVqktWJz+J4aSYDuWgv/w09vX7WZ/3y0K5qym/Qv7Fkw3xLX8pBt2czYYQMAt7p1EX/YklvwkAk8IOIRCMhC7WE5yk+Vxn4+Pthw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742987349; c=relaxed/simple;
	bh=ZrGXGtpLu9V6i8WaDAYslIOE9Xmgz7g6O3/KWU/N4BQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BbH1c1Cy+Z8gTAx0UkazDv9E20UUHQPPy97x3ltOrqs0tcNxsxela3CS3MebG//+FP269BVxJ+T2L3ym4Tvvb5GwpTEz1sPkate4T4fy/3N7moMFz1/jK4kzbWgWdHXvgm/HKwh6/FIcmGGSYeKamF2Eq2tk5fUfUuk+8GXGpY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aERq/NW6; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22622ddcc35so16407145ad.2;
        Wed, 26 Mar 2025 04:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742987347; x=1743592147; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZrGXGtpLu9V6i8WaDAYslIOE9Xmgz7g6O3/KWU/N4BQ=;
        b=aERq/NW6M1Qv+xhCLkJTpueK0YFK5NW/RbH6NFkoO5iPO1+I12Wf8pJEMbYRbWZXfK
         yMjOPbf0u8uMdz4pUHB2p25ZiMhCEL5z9qCpb+9m7VUkSGRfHntuD0EagUXmMugp8sv0
         bd3tyZagEyxRgUDg0Wx7GMMYNxZ6zHJAjvsdt+G+xU8eIRZhpQsy3ofb+8J5LiguldF0
         nuqebF5f1QW1wghxuggs3gXNomcxyy1WgMQbTQ7PM2wUhGGIS2txRM1jNuaRfQh4iA39
         kxHBoY76/QRewKjyDhvBD458iwSArEvWKT4qeTrWQ1F2x+xc+FtTQNsri7Df6FYEgGNo
         tGCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742987347; x=1743592147;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZrGXGtpLu9V6i8WaDAYslIOE9Xmgz7g6O3/KWU/N4BQ=;
        b=KSu2iprSRaA8pzRCk+dkc58gp5w/LVfoq31KrumF+0c792n/3qcZWNDuxilu8QuX2r
         VhH8he1/usTmKr024zndllSyBYDM5LRrsaBVqu8mX7yactPUD46p828c+b1tA+VqlQiu
         Kds8erIE+IbXazzqIGC2AMuFtBdB2h0C4ie2v+M+eRCUHiXUrjvfDF5NNSQi6BIR27TZ
         QxixDIdxQtK/MDEe7g5QU6Vf8134WJZKb2/4bsSE4pl0iEyGl+OwFCPufgnAAapvlVat
         5M4waqRKzboX4kqzkriWLdOClcgBrxb/3/Ppl775BOCJyW1UrZnpEIliWB6oxCV1hKBV
         1O7A==
X-Forwarded-Encrypted: i=1; AJvYcCW8mjFXhobqi9MZ9LAXJwezBEFfyY3e3iKxhFFTkgBPNPYR/Q1zSJ08MlY/hzNx90FmSZ6dVoGbt0kR@vger.kernel.org, AJvYcCWhQmYvzPO2XUEur5ZpHIoSXsOkvAtwOzi1uX6YwfZ7PSR4Kf7Ie9pdIhHbZlKAaeye+6mVq0L7EvLOJwd9@vger.kernel.org
X-Gm-Message-State: AOJu0YymZIpSCvioSdsvt6rXdKMvt1GPZ1WKkQTy21j+BXPL+rdQMgYB
	0RPiTOXDtG5YFouyhKRGY/HJDYn++GyRSTxoInoKtGBk2GsV6T4Z
X-Gm-Gg: ASbGncuMoFVQrX3zTKSBWgV5n7bqf/Phu8LEj6GDR5kbZpm8ktCN4sxhZUy1JFpCNFy
	qcxnOLTXW65Rzq1Y58NUapNW5/xsosXjMTdMu/Ylok7gKplmOkSDr17+AfzrdFytfIF181qL7BD
	3TnEf/24Vai1xtLduVYopJsy+H8DGlcOBPZoiRsL5QZapYEUXIiK+qTaqzFo8x1AMId1Bf0nxSI
	We4Gr0y/GqKEqYtgtVtQkydPHEON26R67T5b19GxLQANcaqFVV+vC6HIENiiTFZys6RQTIk7Ss7
	5avRGPIcWKm9Ta5MRbRUu2qJu4lR2bKrzVfDYk91i2Ix4xbLiK/VkYmfVHX77Zxq0q/LRVWMVBh
	I7CU=
X-Google-Smtp-Source: AGHT+IEdpeiZOhB9p6BzPG2n+dG5uj/m8aGyipMLZavA4DA41FA6uOxitkCJlsSQo6NctVfLWb7LBw==
X-Received: by 2002:a17:902:d491:b0:224:1074:63a0 with SMTP id d9443c01a7336-22780e0305dmr375094395ad.34.1742987347254;
        Wed, 26 Mar 2025 04:09:07 -0700 (PDT)
Received: from joaog-nb.corp.toradex.com ([67.159.246.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f396fasm106711465ad.27.2025.03.26.04.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 04:09:06 -0700 (PDT)
Date: Wed, 26 Mar 2025 08:09:00 -0300
From: 
	=?utf-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>
To: Marek Vasut <marex@denx.de>
Cc: linux-arm-kernel@lists.infradead.org, 
	Alexander Stein <alexander.stein@ew.tq-group.com>, Conor Dooley <conor+dt@kernel.org>, 
	Fabio Estevam <festevam@gmail.com>, Francesco Dolcini <francesco.dolcini@toradex.com>, 
	Frieder Schrempf <frieder.schrempf@kontron.de>, Hiago De Franco <hiago.franco@toradex.com>, 
	Joao Goncalves <joao.goncalves@toradex.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Max Merchel <Max.Merchel@ew.tq-group.com>, Michael Walle <mwalle@kernel.org>, Peng Fan <peng.fan@nxp.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, 
	Tim Harvey <tharvey@gateworks.com>, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: freescale: add initial support for i.MX
 95 Verdin Evaluation Kit (EVK)
Message-ID: <7ts6jkfg2kfpfhteomlhn5ewxetcaav5bi6x5kgtklqhaa5iph@olxjy6l3icy4>
References: <20250324234013.140440-1-marex@denx.de>
 <20250324234013.140440-2-marex@denx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250324234013.140440-2-marex@denx.de>

On Tue, Mar 25, 2025 at 12:40:02AM +0100, Marek Vasut wrote:
> Add initial support for i.MX 95 Verdin Evaluation Kit (EVK), which
> used to be the Titan EVK. Currently supported is lpuart1 as console,
> SDHC1/2/3 as storage, WM8904 Audio, USB3.0 and ENETC ethernet RGMII
> Gigabit port.
>
> Note that the SoM used in this EVK is a derivative SoM from Verdin
> line of SoMs, an actual i.MX95 Verdin SoM is under development.
>
> [1] https://www.toradex.com/computer-on-modules/verdin-arm-family/nxp-imx95-evaluation-kit
>
> Signed-off-by: Marek Vasut <marex@denx.de>

Reviewed-by: João Paulo Gonçalves <joao.goncalves@toradex.com>
Tested-by: João Paulo Gonçalves <joao.goncalves@toradex.com> # i.MX95 Verdin EVK

Best Regards,
João Paulo Gonçalves

