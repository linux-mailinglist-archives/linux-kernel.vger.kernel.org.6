Return-Path: <linux-kernel+bounces-215269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C7D909075
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 18:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40A961C2430C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 16:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76F51836D3;
	Fri, 14 Jun 2024 16:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="muRdsBAD"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6410D181B91
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 16:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718382920; cv=none; b=RgdTUoTwAOVjR14gPba7a2FMsvPIjLETs7Nf7g51qat1lc4s7r2FoKV7UmglyKUxQU/tlLyXtQflFs2TiaAvf2qSIE/F5bLwFv3Ar7LogbKD4etU6DUsoNhujQGwgJjRSZJXkuypb79PNiGeunGiv/OkDeti5MYBxzM33bKj144=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718382920; c=relaxed/simple;
	bh=LuXmN9tx1+9vM/aOgvWFhrlm3ooXyRad8K9vUy2MI7U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FbBFcFmvetkbzVszAlXT+/dFkucmrV6E91ssny10Op5Mvq4QuK7PLgc+NLFMS+DYZV8IhEBk7ccLvlOW9zPdyJmoJ0EUP3xH5VA8s0Mhfyh+zd/e2NtrLncRKOi70TbFhsDiZte7fydf5Ed/T6J/sFfqIVZJXT8+RCCFHmfENYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=timesys.com; spf=pass smtp.mailfrom=timesys.com; dkim=pass (2048-bit key) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b=muRdsBAD; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=timesys.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57c83100c5fso2609682a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 09:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1718382916; x=1718987716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SYP4VucbC2/Jnuz/5Y5TpJxKEc0YEshxNGoLKrFr67Y=;
        b=muRdsBAD40yg3pIdz7aI5D2k7rPYq8ypP30XjfXYzXS5ci/sRYOzA0IbQ3+S/1qFkP
         GTRaOd9/7i1tvpIAl7AaoR7f5KSeJARSlroMnSTdwwG8gdJ5jqkgHBVW6pmiBvX0SUvN
         Z8aXuyovSKsEQPhwYBdPQId7K5lnajZ/6tOzJa7TuZBcVWEafAESHRekXYyXr459OK9b
         ej9BWggbnW76MlNccbbWFRQyslWJqLsBwGMoRoVl7uGoVb/YqTxb4gqkHlZTDk1ubA2p
         qrCZQlvzBJnVHz0N+zZEUWTSai+ZYrEzYWtU1XDErVuL82Pe9ooPk1fHNY7AnbwzgAXo
         qYcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718382916; x=1718987716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SYP4VucbC2/Jnuz/5Y5TpJxKEc0YEshxNGoLKrFr67Y=;
        b=MFDTLmsSRKqrMA3wSVVVtdY7wO54SRAzer69pZlVWdMGr7t7Oeni9Gd8v43BVHnhS5
         DCqU0CQRarluicRbsBpCeqMyoq4Bq1er7Y1C4wCqyhXXlMrWb4GNCO7Fz1/28rBdptLQ
         VSYnVnLmf/OYG2w5U542xcww6VO1uTgHs5CLKAc0Jg9Wp5n6BU9FHgcGUBiXW90pRqz2
         FN0F2R5vvBhubNMC1AaUVqzrG7nqFvmQDZUI889OncvP4McCSVXxmjapZ1/303Fsn95L
         ZvJzcgpgK27FU+5516AzLpkiUelbcoUDdAW9OpYWLf2GkjcJKOHHf5jryJZY7jfhkmit
         Ek1g==
X-Forwarded-Encrypted: i=1; AJvYcCUS9sxu86xTfmtZTYm0r40VB8l13kBBWw0Ba4nl+R43txBAG787tiq4B7d4ezJB3Y4kjlDsN7xHufvKIOKxnUQom5AXDJn+GcaUEsmO
X-Gm-Message-State: AOJu0Yx+MiPe4nSB5rPRsiA6Fk5FhKNHUfRzUSfK9hOsRz6lCe1eBNyW
	plMkwVdY5clW5f7uYAV6TeI1wf43zQ6SreKto+Zz5ge5gezKhCUo/0npFuqZPN0=
X-Google-Smtp-Source: AGHT+IFQDhA6L9B70v4e6G80Nc6QL8RMeX1jv/kC5wcXSX1xgpnIA6zLuA7OULi82c0Ut96o3OIgbQ==
X-Received: by 2002:a50:a6ca:0:b0:579:e7c5:1001 with SMTP id 4fb4d7f45d1cf-57cbd68ffe3mr1913077a12.23.1718382915504;
        Fri, 14 Jun 2024 09:35:15 -0700 (PDT)
Received: from localhost.localdomain ([91.216.213.152])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb72da156sm2462893a12.22.2024.06.14.09.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 09:35:15 -0700 (PDT)
From: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
To: 
Cc: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Russell King <linux@armlinux.org.uk>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	"J.M.B. Downing" <jonathan.downing@nautel.com>,
	Chancel Liu <chancel.liu@nxp.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Michael Ellerman <mpe@ellerman.id.au>,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 0/4] Add audio support for LPC32XX CPUs
Date: Fri, 14 Jun 2024 18:34:48 +0200
Message-Id: <20240614163500.386747-1-piotr.wojtaszczyk@timesys.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240611094810.27475-1-piotr.wojtaszczyk@timesys.com>
References: <20240611094810.27475-1-piotr.wojtaszczyk@timesys.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This pach set is to bring back audio to machines with a LPC32XX CPU.
The legacy LPC32XX SoC used to have audio spport in linux 2.6.27.
The support was dropped due to lack of interest from mainaeners.

Piotr Wojtaszczyk (4):
  ASoC: dt-bindings: lpc32xx: Add lpc32xx i2s DT binding
  ARM: dts: lpc32xx: Add missing properties for the i2s interfaces
  ARM: lpc32xx: Add pl08x virtual dma channels for spi and i2s
  ASoC: fsl: Add i2s and pcm drivers for LPC32xx CPUs

 .../bindings/sound/nxp,lpc3220-i2s.yaml       |  69 +++
 MAINTAINERS                                   |   8 +
 arch/arm/boot/dts/nxp/lpc/lpc32xx.dtsi        |   8 +
 arch/arm/mach-lpc32xx/phy3250.c               | 111 ++++-
 sound/soc/fsl/Kconfig                         |   7 +
 sound/soc/fsl/Makefile                        |   2 +
 sound/soc/fsl/lpc3xxx-i2s.c                   | 393 ++++++++++++++++++
 sound/soc/fsl/lpc3xxx-i2s.h                   |  79 ++++
 sound/soc/fsl/lpc3xxx-pcm.c                   |  74 ++++
 9 files changed, 750 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/sound/nxp,lpc3220-i2s.yaml
 create mode 100644 sound/soc/fsl/lpc3xxx-i2s.c
 create mode 100644 sound/soc/fsl/lpc3xxx-i2s.h
 create mode 100644 sound/soc/fsl/lpc3xxx-pcm.c

-- 
2.25.1


