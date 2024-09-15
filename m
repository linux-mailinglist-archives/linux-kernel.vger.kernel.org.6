Return-Path: <linux-kernel+bounces-329831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC83597967D
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 13:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 691A81F21FC0
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 11:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1926A1C68AB;
	Sun, 15 Sep 2024 11:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMbKPBNX"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30331C57A0;
	Sun, 15 Sep 2024 11:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726400642; cv=none; b=rzdied57a4dT+jHiBrt7EBgSdgqAIA13W2WWSdgmleheXZwvwub+8W7Gru6jAepQscWq/3ALc73pAqE538vplkdHh69OYt7oXpud9ONYzpCQ2kDsUCW2BfDyrfFw8Shz3rUj+j/23H+bYSmNL/I6ukS48vY60+cez9i49vfBbvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726400642; c=relaxed/simple;
	bh=H9q9CQoYEll1vyUTQ0sNcL7d6nkLtx+8/uKIZDi4t8k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pa1if6D+KTJ5K3m+BYyZTJHDyJVVQueABQGbUGPcYd2jx88hUQQG+ycFXgSJ02jqiEDe7wt8HQgoroOJbMS6/K5Mj97oMZwf3nFyeQGtBOePUiC9j+qlgRcNpk3Xcbikva0Wh6mVJSC9+mq7DiJBZZmBOn7QBJ/tkGl9u7foJKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lMbKPBNX; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a8d2daa2262so295248766b.1;
        Sun, 15 Sep 2024 04:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726400639; x=1727005439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4mH+l6efe7nU0WFZ7S2EM77Dno5UaL2UqZkqt5PiIGk=;
        b=lMbKPBNXpolt8oCve6f8QPRS6dX3Og6covNvzJOniEwg+y8zQSE3MqIbE72TTsXHay
         gyWaATi56SZu7sk7PaTo5NqJmu/oX2BFTryVVFOHQs3Al0f+IPAuG31QTlXaaAFQnt7L
         mg8G4mMBmd8YTtU0gthcRQdeXApnUXc0Txc8tHc4ZlVSnbaBBdjIkDMlCM+DIN512gVa
         A0Uq93GAwOtqNWo8kdzxpaRbluxuEKl5BaYW3HdOtHltsEWo7fx5X6kSv6aZ9UehA3d0
         3dRN0bu7pnwiaeFz1HhdEKYPE8ZzwK68oKk3fL3dV0pZu7uiZOt+jwHT0TT8WFtotSRb
         NQpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726400639; x=1727005439;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4mH+l6efe7nU0WFZ7S2EM77Dno5UaL2UqZkqt5PiIGk=;
        b=lemi2y7XWqUa0UFpzP9CnAfZ17kE7g2dH8saDiY5B/Rz4S5AkQWpLwR/jcSIJ+3S9N
         eMxaupQLaZexbjswEMsAho99QV7xyMsX/qwYF51febGXu+yc5IijRQrNdoGvrvYRJ9mP
         H9JuDUgVosE0dAWBJFfNgGa9m+OWOonDESkLLWBFZZhtqCAKGlBMTVXwWflfpDWGgOBo
         CqEHV2RB7g7sDH6gYK1SkXaW4q4hvlW0k8ZkoDmkCN/bC0YQhebbVvH5tIgIn/kwuQM9
         ssQsvR3euGKeSP0FObizyuxzbaAn0EevGZvglFgtnVk7BW6p8Ouhbi7jjRrLp3t4a3Hs
         vuJg==
X-Forwarded-Encrypted: i=1; AJvYcCXgaElQjOswzQ3dG7TMDuXGjipFeZeir0CCFFMIQaCD8GTWuSSxCdY6JOcmCHUxJ36ygldaMQZ2SS8HKnE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9DDchArdvnwiz5AJA0/HOKckDCXAcGz1nZPCcWk0/eEao7xVS
	aMZtCfD3OysxF0dSGJEvkAAM1xFhsagMfxA1v3TE3PpPGY9L8Fal
X-Google-Smtp-Source: AGHT+IGpuSYUApsVlxE96RegA0p6FojKMuwIiy0j7XRDE+Uns7f4FOzDKSl5hSO6PEgMpBfIYTWuqA==
X-Received: by 2002:a17:907:3daa:b0:a86:94e2:2a47 with SMTP id a640c23a62f3a-a9047ca074bmr759433466b.15.1726400638297;
        Sun, 15 Sep 2024 04:43:58 -0700 (PDT)
Received: from playground.localdomain ([86.127.146.72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a906109676esm188778266b.33.2024.09.15.04.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 04:43:57 -0700 (PDT)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
X-Google-Original-From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
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
Subject: [PATCH v4 0/3] Add support for imx8ulp's SIM
Date: Sun, 15 Sep 2024 07:43:08 -0400
Message-Id: <20240915114311.75496-1-laurentiu.mihalcea@nxp.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

i.MX8ULP's SIM (System Integration Module) allows
control and configuration of certain components
form the domain it's assigned to. Add DT node
and schema for it. Its child shall also be
included.

---
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


