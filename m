Return-Path: <linux-kernel+bounces-339713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA95986962
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 01:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADC3C1C214B5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 23:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BED41A38FC;
	Wed, 25 Sep 2024 23:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqYeOOiz"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621A912BEBB;
	Wed, 25 Sep 2024 23:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727306458; cv=none; b=BjmLgB82iGULdhCqxNMjhpoziK4WnWPAx+v6LXEm2Q5LGG6jwobIevbmviEVlQhmbeI8w/B3lHkpzTGD3iZnb8LDImYwfM8FZNfqJWbnYxOA4/9UXmfXGXaRXNmbhyZw8DmfL9cBxfnPUMuffEhxcHOsbymjhuUblhH+LYqQ3iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727306458; c=relaxed/simple;
	bh=Dt3mws66hpidkeU8bZmwgKFd/DilihuEBnlmhuq74v0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ljy8HQLN/trnCoDpiIEzZ95425VU7qSMB0lLxdMiUZFKigYxkkJW2YdJQ6BFWLyzPNci8qoLOt+GUQOX+/bsau8KFr2VZltXKvfB1ZVZ2Pp5ZG/QZC/wVUnphSE4DrhbouHZ/gdFuVTkYv3ANGfWgygQkUJGClPLLZiulXu7fUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gqYeOOiz; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c40942358eso742179a12.1;
        Wed, 25 Sep 2024 16:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727306455; x=1727911255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wzQJ809oKF/8Xbcsp5/HlODndiAMn4sR7T/Hw/y3LL4=;
        b=gqYeOOizF8tJc73zYPp/o3M14NjRSPsIetzd6D0Ija6VaoTS/ffx/e1W+N3ivWFj+e
         PFmWzUjIKTjA2qP3hAo2kmMVAj2zzhctn6K0tNZunbikY8J+v3Aj22z7vs2PpsCV0zG4
         92aQsi5k9tsukNT43nx/z4rrnr4tSY2jiYtgRSL6+rSSNrk7bCwbVEb9dFSxwfAz/U3o
         mUE0mOWKrEGUWCNfwNMYYkZAlKqYZzjr5Jz1B0zqJ3mBL8TpJ141yiUYA0gekuWGmW3E
         PZ6FAF3LMT6jn029HKze3np00T5Hsm7ZyrUDrfrwawccs0M/nCqNlfIj1GJqyeiHrcR5
         sAQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727306455; x=1727911255;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wzQJ809oKF/8Xbcsp5/HlODndiAMn4sR7T/Hw/y3LL4=;
        b=AdGMHMC9+ZQ/mBSe4tpsKHFClpO3RxqsyIUi59MrfbQypFZqOFZzqHZYumSYRVclmj
         2PmYpgL8qHSlwxYSyxdaV1k3KD6L2D+pfkAbTAQAsGbhu5Oe6je6CbHP94Zr5VA7A4Sd
         rfkufpGOnNq+zsmoEBevo4mbe4OSG8QfghDNvGFenW18CANEt0Ujh4C+EQus+uYiOgBI
         08h/M3M+l/0bw08mFwoQ7MqRZGK3v5mpOb1eO2uRicokHv8bX0KbXS3MglVCQOaJ1Xau
         mN3pA3x88F/NIgLj0ibLWrt/nAjtYhw6sb/CFzgXVuCmwP9sqDegFheCr56zn931Qen0
         MDcg==
X-Forwarded-Encrypted: i=1; AJvYcCUGDHWZXBOtL5dbpbH2LCoeLNrGgYSPdgXHp3txc8rjqM/okQ1pUNY5g7D3O36RLYK6qMeoOA/IVAPFm40=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4vP1iAOJXrbdZwcBhv30TwZFuqj5pgacBdgt5hvEFp8+bapiD
	pncw7sXOhDbCTr+x2B+yGrx021atCLdLY9dPb2Fb2YoHeqAiGTsl
X-Google-Smtp-Source: AGHT+IETQdtsFkGWoGdY4X7UEHpfnHcKB9JMAlZCzHF/aPebg3M4dDMG8IxcrM6yp357zbxA8T3DDw==
X-Received: by 2002:a05:6402:40d2:b0:5c7:2209:dedb with SMTP id 4fb4d7f45d1cf-5c8777b59c1mr999343a12.8.1727306454482;
        Wed, 25 Sep 2024 16:20:54 -0700 (PDT)
Received: from playground.localdomain ([86.127.146.72])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c5cf48c315sm2481026a12.15.2024.09.25.16.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 16:20:53 -0700 (PDT)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Iuliana Prodan <iuliana.prodan@nxp.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/6] configure imx8 dsp DT node for rproc usage
Date: Wed, 25 Sep 2024 19:20:02 -0400
Message-Id: <20240925232008.205802-1-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Configure/add imx8 dsp DT node for rproc usage.
Additionally, fix number of power domains from the fsl,dsp.yaml binding.

---
Changes in v2:
- Modify subject of commit changing fsl,dsp.yaml to state that the change
  is for fsl,dsp.yaml

- Fix issue with arm,mhuv2 binding found by Rob's bot caused by the
  changes to fsl,dsp binding

- Improve formatting of commit messages

- Link to v1: https://lore.kernel.org/lkml/20240918182117.86221-1-laurentiumihalcea111@gmail.com
---

Laurentiu Mihalcea (6):
  dt-bindings: dsp: fsl,dsp: fix power domain count
  dt-bindings: arm: arm,mhuv2: remove power domain from example client
    node
  arm64: dts: imx8qxp: configure dsp node for rproc usage
  arm64: dts: imx8qm: drop dsp node from audio_subsys bus
  arm64: dts: imx8qm: add node for VPU dsp
  arm64: dts: imx8qm: enable dsp node for rproc usage

 .../devicetree/bindings/dsp/fsl,dsp.yaml      | 62 +++++++++++++++----
 .../bindings/mailbox/arm,mhuv2.yaml           |  2 +-
 .../boot/dts/freescale/imx8-ss-audio.dtsi     | 20 +++---
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts  | 27 ++++++++
 arch/arm64/boot/dts/freescale/imx8qm.dtsi     | 29 +++++++++
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 15 ++++-
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi    | 19 ++++++
 7 files changed, 148 insertions(+), 26 deletions(-)

-- 
2.34.1


