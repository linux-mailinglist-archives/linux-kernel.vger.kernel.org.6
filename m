Return-Path: <linux-kernel+bounces-252842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A399318BA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 18:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 879A61C2185C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 16:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465591CD2C;
	Mon, 15 Jul 2024 16:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NB4bh/wr"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EC13BBD7;
	Mon, 15 Jul 2024 16:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721062000; cv=none; b=BVEEkomZT7Y8z4VdnoY8gNbiyUmSCM4Doh7JjhHHE1aYTAQpYuGhzmIUb5s7hiaEZztahF87x8kEanEaKV9WxZgXkJ2/ED9K68BgUeK0bSaH9JFQQoPOdbtMaQxsgKbnWrcPaVSrmawz44wgaN3Rdx3UVsz2PEQGlN4ITxSzSSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721062000; c=relaxed/simple;
	bh=HQDOhH7XAMOdNRYtmv99nO77pkyE+TiuqMXtUvMoQPw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PeiWyOo0D0nZE/KpZysoqrQ9bwwv0ICwJ/IWOl0+1U0Nz3hXjBud9vaKDEN3qf/KHIGFsJpw6Y9Zkx98DBbLPgVO7X9B8tLkqBBTmeAUiV2WlDUHdSJ49PP9sLJFSLJHhGGWwQ2+ZMEN7TRlwC+gT7YsO0ub5XGUlvzRt7sdmnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NB4bh/wr; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52e99060b41so4672322e87.2;
        Mon, 15 Jul 2024 09:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721061996; x=1721666796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eL/AZF0Nl9JOTvoaifBbGBBpS8fEo+MN57T3BTmyTWk=;
        b=NB4bh/wr1Ap5L4NOlrYaDG5cY1WgBp1WTVviAZhjNe4S67RMzOm+zUaA5rUbS4gbQ5
         pEUW/sPO7SbI+3k/h3nhlTFQiya+1MtYjRlBT4MivHhz6rO7FVRo11Wnwn2N/XI91kAm
         odmvyaorjTiUW9w46C4sJOqC7OQeLU6UROmTHz/CHHk7KKJ1aDAkvS1lNHx9FzkFiFRi
         Ss8PxMwlMPjRJ5DzsZQd4ty9HeDeCswAsG6k95LprtadRWxp++9dPKD5vxbtbqtF1054
         116WMOMINbGkuTy0vgzWTRGSwSJTbTg/S6iDFQDnKaPKaI1aZgB3DHDM+YaMXj6Z4TVd
         t14A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721061996; x=1721666796;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eL/AZF0Nl9JOTvoaifBbGBBpS8fEo+MN57T3BTmyTWk=;
        b=u84ppSE7XKaakPtkD1UcSBF+0IYInVJTtAKaau+NtXzMF5CufkPB8n9GAROr34eb5B
         Fehc1YSqfNFlNxWjD3N1SWfLPjXpHCkqJQvCgFlXb3iX/MoRktHNqtZX1YFmtg3niWMe
         rjY2GuqgFRrnSqiuUN5vXXuhHaYPmiPsqxMe7iyNQYVAPq8e2S+OwViLcoJX63P5PH8M
         Kphs63VTottJ2SErb2nqfNExpExe7A5DlOrPI3ousTwYayJ6bJt+8tPywQUjQlpklqst
         Yd+r3qoh/Z+Z1kAch0o6TgIv+xQNchmaKVAm+r8ZwH8PJnDerVUqLUl71tbobhe4r+7o
         p7Rw==
X-Forwarded-Encrypted: i=1; AJvYcCU6PkVEfOBu8j0P38jXAzim6zbmb5V9mEW4YcSFWvvxvMZT+oAK7DFft9+OFNsza/Vhzrklj8KSDo7LJAVHD2T47XErOn+CBZ8kBMLF
X-Gm-Message-State: AOJu0YwGqTtZvMgjc74RnXGywEsLlPzpdwSBL8ohXKwqTN6/XjXIwZ/5
	bWXyfT5uBxDe26CCWeE7Qk0/6mECpOtTxmiAv4qv7b3ie9kUb8Fo
X-Google-Smtp-Source: AGHT+IG8rnVQYsXD0i3Gs8pZTZ5c3cJcdn0hTvsIVtcTaVANdf0u4nlLOVSzLYvdx+l7EpEEqs2fuA==
X-Received: by 2002:a05:6512:304f:b0:52c:def3:44b with SMTP id 2adb3069b0e04-52ede1b6ed4mr57286e87.31.1721061996292;
        Mon, 15 Jul 2024 09:46:36 -0700 (PDT)
Received: from playground.localdomain ([188.25.209.252])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427a5e7749esm94316975e9.2.2024.07.15.09.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 09:46:35 -0700 (PDT)
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
Subject: [PATCH v3 0/3] Add support for imx8ulp's SIM
Date: Mon, 15 Jul 2024 12:45:11 -0400
Message-Id: <20240715164514.8718-1-laurentiumihalcea111@gmail.com>
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

 .../reset/nxp,imx8ulp-avd-sim-reset.yaml      |  59 ++++++++++
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi    |  13 +++
 drivers/reset/Kconfig                         |   7 ++
 drivers/reset/Makefile                        |   1 +
 drivers/reset/reset-imx8ulp-sim.c             | 106 ++++++++++++++++++
 5 files changed, 186 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/nxp,imx8ulp-avd-sim-reset.yaml
 create mode 100644 drivers/reset/reset-imx8ulp-sim.c

---
base-commit: 91e3b24eb7d297d9d99030800ed96944b8652eaf

