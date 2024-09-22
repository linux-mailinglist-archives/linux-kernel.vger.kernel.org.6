Return-Path: <linux-kernel+bounces-335222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D3997E2C9
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 19:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C0081F21756
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 17:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857263839C;
	Sun, 22 Sep 2024 17:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCc6s2qm"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659CBEEB5;
	Sun, 22 Sep 2024 17:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727026989; cv=none; b=UOsgs9tJq6XBpFscrn9uzSzC12zPpPh5RNXxsUYMmnXa8Bln62P4mlHdz+daFcUdCNsVgpmHbRk0UzlcWBFuwch1xR2Qn7m22oZYjvqD1zodXKnO6N3aSVBONtXdzpUPZZOPYWypvBLelJZBMH5wdW5G0GywfTPMtPVSZeOr3GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727026989; c=relaxed/simple;
	bh=KndTiR0OdHzTrM/PlQIXJZHsx0xGG+vgh0h+TjCqPxU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H5RFAAEePBTKy8VV1+JtAhdA2p9gr1J9c6pDOmv3Lutsw21QG7UeGXcmoGdSQ+SMQaG+WHsOocvPs8cgv8I8r995CZJUn8L2+h+kuQP5vfI/H9AS3M/QirT4lMhzlRP2qORd9WELEkr6ThspmYgvUq+ZxKYqbKbZ1W5tMHF4xQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mCc6s2qm; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42bb7298bdeso46136065e9.1;
        Sun, 22 Sep 2024 10:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727026986; x=1727631786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G0/0BxLdpF3XJIV7yia9b61Vkm7p/ygaIQczFUDvFiQ=;
        b=mCc6s2qm9C1ZO8jAsVV17wF7RiyujUKt54btUUpABS47YMC3eKSaYMQaeveWNJLPsw
         r3DaEe8RixwITDKL2kr1u+dfBtZNB8BMnnLR+VtDY2QvMDiJsyInvZnhEq2ibKf4Mez1
         xbaCV5UHS7s5JdYz5UIxdDU6XUr7lyZOXHusQ54F/nxVaR3lG3L4o7CC+iFuRuJLCbzc
         2qcROF5JPsO/g8Kl1p+ac6/gIWOMlxwKv7oqbBB9CsagvnWSmNPrnzIEDk+6WZ94cXKr
         We17hKmUjKVFY2Z3kNziczzpD+fs8XGFeirgyFJ5SoO8UChB0hGm0L/7iP15q09/PfcJ
         FznA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727026986; x=1727631786;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G0/0BxLdpF3XJIV7yia9b61Vkm7p/ygaIQczFUDvFiQ=;
        b=h2Rs3gaFmYMXGgzqeXZAPkMbP5kzYqUhQIqmCh+CPfraMgKsvdyt0qglq7NnC5smf4
         sLoucVUqWl5XWMXj57f7OK09360U+3VlJYZt/awsDnfYNO06cFVeYgQIALUS6NlvoMLb
         qQDZZUkDVX94SEA5BW4zRkAyvORGfAC7nkTgXSymHEJyTvBb626SoWR8hvkBoug3L6rb
         Nh5wcBtS95h61Tj8w3f+OWH/V0FvFFR4rtCZedVhTWBAyQ9/3//3ZvllEnkEMIv4u4X8
         5PaXGLBswyi7kXlzwHrMnJtqPHc3eURTMjBDqe7iImmTm8KWutK45qi2CyH4lWu5kBAy
         XmmQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1VHqDvWLKxH9XOa9Zsqt46I3A3pGcdSmFHNbLd70unQvRgi3Z+rY00o5T4a43zevt3JVYusmlCa7SJKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrEXO5H0TJNLkXx4Wct2tBJu8MUywG9i9bv/G4FMaCMfzeRLwD
	QI0MAJLhLe9YfwMm+6WDn2XK9AJDdhB3F5tJURCV0JL7yqAWcoAQ
X-Google-Smtp-Source: AGHT+IGchA2fv4nZU1ta/RUrDf2dN/GNHctnNcz+zD6gzD0c9IOIG5YzEx5w9yEWjC1Qqw4lvnsGAQ==
X-Received: by 2002:a05:600c:3b92:b0:426:5e1c:1ac2 with SMTP id 5b1f17b1804b1-42e7abf06b0mr104218855e9.8.1727026985479;
        Sun, 22 Sep 2024 10:43:05 -0700 (PDT)
Received: from playground.localdomain ([86.127.146.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e7ae60ad0sm80758535e9.1.2024.09.22.10.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 10:43:04 -0700 (PDT)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Liu Ying <victor.liu@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/3] Add support for imx8ulp's SIM
Date: Sun, 22 Sep 2024 13:42:22 -0400
Message-Id: <20240922174225.75948-1-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

i.MX8ULP's SIM (System Integration Module) allows
control and configuration of certain components
form the domain it's assigned to. Add DT node
and schema for it. Its child shall also be
included.

---
Changes in v5:
- Fixed SoB mismatch
- Link to v4: https://lore.kernel.org/all/20240915114311.75496-1-laurentiu.mihalcea@nxp.com/

Changes in v4:
- Addressed Rob and Krzysztof's comments
- Link to v3: https://lore.kernel.org/all/20240715164514.8718-1-laurentiumihalcea111@gmail.com/

Changes in v3:
- Addressed Krzysztof's comments
- The "reset: add driver for imx8ulp SIM reset controller" patch might generate conflict when
applied to Rob and Shawn Guo's trees (for-next branch). Tested all patches with linux-next,
next-20240715 tag and no conflicts.
- Link to v2: https://lore.kernel.org/all/20240609125901.76274-1-laurentiumihalcea111@gmail.com/

Changes in v2:
- Reset controller is now also a syscon provider.
- Changed vendor prefix to nxp.
- Link to v1: https://lore.kernel.org/all/20240516204031.171920-1-laurentiumihalcea111@gmail.com/

---
Laurentiu Mihalcea (3):
  dt-bindings: reset: add schema for imx8ulp SIM reset
  reset: add driver for imx8ulp SIM reset controller
  arm64: dts: imx8ulp: add AVD-SIM node

 .../reset/nxp,imx8ulp-avd-sim-reset.yaml      |  58 ++++++++++
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi    |  13 +++
 drivers/reset/Kconfig                         |   7 ++
 drivers/reset/Makefile                        |   1 +
 drivers/reset/reset-imx8ulp-sim.c             | 106 ++++++++++++++++++
 5 files changed, 185 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/nxp,imx8ulp-avd-sim-reset.yaml
 create mode 100644 drivers/reset/reset-imx8ulp-sim.c

-- 
2.34.1


