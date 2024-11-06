Return-Path: <linux-kernel+bounces-397883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE289BE1E2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 10:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 609411F25444
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 09:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C239B1DDA33;
	Wed,  6 Nov 2024 09:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="bzY/9+IA"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524D51DD547
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 09:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730883972; cv=none; b=TTwk2djkJtiK7CMq+tZ4rhLT5u7SUnB46K3oVJUgDgyjNBOHafSGUjb3uR3OHcRwogP0lKeaBu76X4ZTn7gMj5JU+xiFDknuEeo6EuUAuJbkyxBRSvUF+f7PRDTe2eNr4A9IPo45AOnAyMWALs8axoivKJD/l4OG1G+qmJrPNyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730883972; c=relaxed/simple;
	bh=LtDcq5GNGdpLQi/gwT3VpDWdk4u/M9CX5RZIK3YonB0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hT4EWOaK+EWB/fC2Y92npo6Fa/Zq/cb0twdbYUOwDsLn32i1sbBFmuhGDAftYbQDx+Zf/PjQJeh7jZtvIYfHucyeMuwOwUOp+YyV1Y/qp+pu2a1BUZkLGNWrDTZn3YW6bOmGq1KSPtFPi4+SqSzwOxSAbavuMr35Hdh5Fvbn1/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=bzY/9+IA; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9a6b4ca29bso818907766b.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 01:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1730883968; x=1731488768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EQGfCgtGxny3+etN5uPGt5VE9z/U2oT3XLy2KTaMLtM=;
        b=bzY/9+IAG4+vCRjEKg2vUR2P2hwk3khkxoYqPa/u1nDk1bTL1snzWVQWXxEERxk2yq
         VTmVOrD9HwwSRhzYlwP0GJoMfUJE/jUWVlA3jfoqsM2xuGkrrCFOahL/WQPdOqAOukG9
         YGV6fWldwCAT6H27GK7F+LHz80a7mjg5nXyQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730883968; x=1731488768;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EQGfCgtGxny3+etN5uPGt5VE9z/U2oT3XLy2KTaMLtM=;
        b=ZiU5re5MZTWQFRDuTG+lEL9DS+l/5NbV4MA+XM0CAMwsbzYGhZH1m1xqvNVKxENs9p
         ZhkZSTmHNrr6z5R646ZZCoqQ54Tzw20NsMsQwGJwWTPMZHzVZdKUApxPg19k+SIk7JYV
         KcM0+mB3iMA7RBXZKczKOdjIJNGh50Ch0q49wqL2MLc3atwMczdQem0JVNGp90krmL7U
         sOKz+FxKWym9mCMV6peoLRlcBinz6xdBpESOMvfU0qLICqExrfmLtJdLAI4x99v1wnTp
         PrZez692dJ80QoVfHoC/OdCKKvJGD+J5mYd0OuxN9XJ5ZsvnU9rtpD50IrXVrGb3Lj2/
         O5gQ==
X-Gm-Message-State: AOJu0YxV1hD5Ph4HdelCssCtZL/blcYTzN4ZLatN2CGEQlnZKYIJemH5
	AStZnqCKiJf9ulqvAcKq0HGzKevM8i80zOC5YNxWwC70jyK0Yv2gazhLaTGY3m12dyhPLnaEldV
	n
X-Google-Smtp-Source: AGHT+IHS33PWmczfWikAhpAdNlCU+a9+IAsnRCa7MMogy1tCzBHrZ2XtY5RmjifBnJRTUzSpIvQdoQ==
X-Received: by 2002:a17:907:724d:b0:a9a:bbcc:5092 with SMTP id a640c23a62f3a-a9e50978806mr1335979766b.39.1730883968287;
        Wed, 06 Nov 2024 01:06:08 -0800 (PST)
Received: from localhost.localdomain ([2001:b07:6474:ebbf:afb5:f524:6416:8e3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb17f9422sm247781366b.139.2024.11.06.01.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 01:06:07 -0800 (PST)
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
Subject: [PATCH v3 0/8] Support spread spectrum clocking for i.MX8{M,N,P} PLLs
Date: Wed,  6 Nov 2024 09:57:56 +0100
Message-ID: <20241106090549.3684963-1-dario.binacchi@amarulasolutions.com>
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
boards using i.MX8MN and i.MX8MP.

Changes in v3:
- Patches 1/8 has been added in version 3. The dt-bindings have
  been moved from fsl,imx8m-anatop.yaml to imx8m-clock.yaml. The
  anatop device (fsl,imx8m-anatop.yaml) is indeed more or less a
  syscon, so it represents a memory area accessible by ccm
  (imx8m-clock.yaml) to setup the PLLs.
- Patches {3,5}/8 have been added in version 3.
- Patches {4,6,8}/8 use ccm device node instead of the anatop one.

Changes in v2:
- Add "allOf:" and place it after "required:" block, like in the
  example schema.
- Move the properties definition to the top-level.
- Drop unit types as requested by the "make dt_binding_check" command.

Dario Binacchi (8):
  dt-bindings: clock: imx8m-clock: support spread spectrum clocking
  clk: imx: pll14xx: support spread spectrum clock generation
  clk: imx: imx8mm: distinguish between ccm and anatop references
  clk: imx8mm: support spread spectrum clock generation
  clk: imx: imx8mn: distinguish between ccm and anatop references
  clk: imx8mn: support spread spectrum clock generation
  clk: imx8mp: don't lose the anatop device node
  clk: imx8mp: support spread spectrum clock generation

 .../bindings/clock/imx8m-clock.yaml           |  46 ++++++++
 drivers/clk/imx/clk-imx8mm.c                  |  99 +++++++++--------
 drivers/clk/imx/clk-imx8mn.c                  | 102 +++++++++---------
 drivers/clk/imx/clk-imx8mp-audiomix.c         |   2 +-
 drivers/clk/imx/clk-imx8mp.c                  |  21 ++--
 drivers/clk/imx/clk-pll14xx.c                 | 102 +++++++++++++++++-
 drivers/clk/imx/clk.h                         |  24 ++++-
 7 files changed, 289 insertions(+), 107 deletions(-)

-- 
2.43.0


