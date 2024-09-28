Return-Path: <linux-kernel+bounces-342405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A04E1988E88
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 10:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15E6CB208C8
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 08:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D7319E989;
	Sat, 28 Sep 2024 08:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="lhvZOQNQ"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F3219E986
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 08:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727512697; cv=none; b=W2WWXG9cHofJJpJ/VhnQw80Mj9+4nkwCJ8HqUwrzymnhpufCpt/+xMetxycIiOF1c1LdWxzZwutM6VSbqbC4xAaZcuC+CxmHNAWUeRBrJ7sM00sFB9wjg/2xxpJsppurujMxfjCY9GfPTdYosS1WQUMkjNNwEt9DU+LtZwXc2ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727512697; c=relaxed/simple;
	bh=XBVcSsI6SfYZO2oZC/+zS6umDLhfmyLe2aIRpM+7vdw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FpDQUwIZETcLW1yfXffMilipf+YREQ2DYU7NA+mQ8a3y3/W0pJ+vqumMXgs/VFVA9HDK0rHkmuLze/b/EO+dIzZ16NKZZfid4B0pufl5tcagNrPCExgh0aS86ImY2nXK23HylZErp48P7O9yX/qjn6Ewp7j5aWZRJuqlpmpqw9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=lhvZOQNQ; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a8ce5db8668so466917266b.1
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 01:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1727512694; x=1728117494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9LrytHNZtSXo7AmRE+wgJFzGOYaJlj3QtdpLmr/8fPs=;
        b=lhvZOQNQWuZvd3aNF0AKjqfFQOAqIjp9AdF7l+7Lx2hysa1h5Lv5/VJo8+fclFoolH
         5eq/5sINQTDiyCC5m/w6lgZy12D40uelW1sejQGsR2414r45E2DHLJPzZXCRSncUY7OS
         7LokZQZ8e//2wowtlONuepCkqvuZnqbe7c+LI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727512694; x=1728117494;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9LrytHNZtSXo7AmRE+wgJFzGOYaJlj3QtdpLmr/8fPs=;
        b=VYCYU91WEoOIpLdzmxg0aYi7ZuOVTquHeyv7WSOlV6XW/lxFQkFuWCeJUi5l43PKQn
         kHAEvYa/cyasJoFMprTiRCEIM7R4cOXtDJzOf/Tu16EdTq0WhZMrAUxEmJKI3KY9BSt1
         pRL2xA45sw/VKr3jY3iWX2JCHVLECCqZhm9R14uLL77HmWA3zGI5rDq8rFkOaDvso4uZ
         W0hkE9tq9IqmFz4QMvZjy3Az7wcXV4EYVfD1yjZkxcZzVpbboZnG1oTPFiBOf+hSKxrW
         ItlnUSyhB3Wc/SW7Iux7+26eezAcmCVOj2Iys288RMOOzGRdTvumn0h62PesYIsVbUBe
         F9VQ==
X-Gm-Message-State: AOJu0YweF5/nnQW09+nUuzKdzmaEbXFaVdvrNJmR54IqGY2/73FKtzWr
	YOseRQj0zXCdximE1hLu53eXcRbNR+mXHaqtTYucXtEtpYXHH09LpkfaTaPVxxHNmM0WkeHuhj1
	jbYk=
X-Google-Smtp-Source: AGHT+IEkHCCPklUKDrG/O+n08MGRKv6oRGKdMfRpXV+dG1tZEcS/RKgDqAfK93J9aJhrYzeMmU8vWA==
X-Received: by 2002:a17:907:7ea4:b0:a90:41a5:bb58 with SMTP id a640c23a62f3a-a93c4908b08mr674466466b.16.1727512693994;
        Sat, 28 Sep 2024 01:38:13 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-79-54-102-102.retail.telecomitalia.it. [79.54.102.102])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2947a48sm223679466b.118.2024.09.28.01.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Sep 2024 01:38:13 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Abel Vesa <abelvesa@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Peng Fan <peng.fan@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org
Subject: [PATCH 0/6] Support spread spectrum clocking for i.MX8{M,N,P} PLLs
Date: Sat, 28 Sep 2024 10:37:48 +0200
Message-ID: <20240928083804.1073942-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The series adds support for spread spectrum clocking for i.MX8M{N,M,P}
PLLs (audio, video and DRAM). It has been tested for the video PLL on
a board using the i.MX8MP.


Dario Binacchi (6):
  dt-bindings: clock: imx8m-anatop: support spread spectrum clocking
  clk: imx: pll14xx: support spread spectrum clock generation
  clk: imx8mm: support spread spectrum clock generation
  clk: imx8mn: support spread spectrum clock generation
  clk: imx8mp: don't lose the anatop device node
  clk: imx8mp: support spread spectrum clock generation

 .../bindings/clock/fsl,imx8m-anatop.yaml      |  41 +++++++
 drivers/clk/imx/clk-imx8mm.c                  |  13 ++-
 drivers/clk/imx/clk-imx8mn.c                  |  13 ++-
 drivers/clk/imx/clk-imx8mp-audiomix.c         |   2 +-
 drivers/clk/imx/clk-imx8mp.c                  |  21 ++--
 drivers/clk/imx/clk-pll14xx.c                 | 102 +++++++++++++++++-
 drivers/clk/imx/clk.h                         |  24 ++++-
 7 files changed, 196 insertions(+), 20 deletions(-)

-- 
2.43.0


