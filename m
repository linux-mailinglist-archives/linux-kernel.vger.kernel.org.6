Return-Path: <linux-kernel+bounces-343077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A19989685
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 19:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11BFC284955
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 17:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D7B2C859;
	Sun, 29 Sep 2024 17:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="FR6NZGAA"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3552BB04
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 17:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727630869; cv=none; b=UayDLri1k4BV9OKsJpgrWZ40nLycut8LcVVmBBYZ1MhfUHT58ieBA1m/OxEZjW7Nglg9oub5aE7LxydPkm+3ZdJfPKfFBeTqjidsv/jSOHrbVz3MSzC9WHRfSFfyaRe0hWbUcpoAdW2561+Hf9EGwrF3MlBY4e/3WYaYiLAdNrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727630869; c=relaxed/simple;
	bh=WUERIKhk0ysr6XjanYIBJIslPRVSyrgdwPzHbxGARM8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Oz8Pt3YP6nqGIBmU1JOR14JED5AWNptXuZy1Bho4Q5MPuCZ8QRDag6HgsIKZOGjUljQXWmE0+dIWiCh45/lB2DAU41VLdQop9BJi3UEkG6bQGNt7NAqF6HRt7MTl9N5R9tkfSjq656YHlAji7kGsveK7ZzGY94xa2xoiKoNv/r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=FR6NZGAA; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a8a789c4fc5so802704566b.0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 10:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1727630866; x=1728235666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N1af6m0P26utxo00AsF/VQkLQHLRIxDCh3EYFZpR7sY=;
        b=FR6NZGAA3kMI1HJk892P0c8Z+mfm5ApKukLyvEsFo0vOyjnYaloPQFE+RzSh4e0ZIk
         rHwBdA1j3Gobh1dqlpmA+vBHYh2lffkdcmQWkp2rnr94mJ1/Al4RfPxnwjqcwSiazTuK
         A1JtToMIlhC4vOM2aULb9jmISxkna/0T7+I7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727630866; x=1728235666;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N1af6m0P26utxo00AsF/VQkLQHLRIxDCh3EYFZpR7sY=;
        b=Pf/SQl8VDn7m8UE0i7FlKyP2xYMAwK0vsDjLbOY7c+eTP9joSup257GYxgZ8LgyhxT
         v4JrYNLeJrfJ1fAyWP0i6JiQmcFF9N2d0UyIL9qxpphjZo0/sZFC9W9gHpk59tqK/6GR
         TLQe8LBQTmRPxp0nVrzBwvFfnSQNiINFN5mLdiyS6ntoe1JTdTDJcxCtd89Ue5E91O5I
         UiYKA2d82N9lTQ8jFhkUefX+y/Dhv3FBDnMiow0vtlV7SVovDhnx+QOVLtyOxx/P2L+R
         kpf/JdWWzlUneeZH0cc4EYRLZNhpUPQ7F5XtZwimJC4SXTAr+CgD9u/nUKaCgYNj9A1w
         jioA==
X-Gm-Message-State: AOJu0YxQvxJKfwsWszENR1UERYAKRDY5t8HE+OiT85kK7oBdT0d9+kHO
	G7SlFJYMvc5cJ+gP9ncU94zLIH2QxJgm7Oh6lkIWokF5q+aa8U+x7PAl9Vf1FenbkVwm+qVlnII
	jQQ0=
X-Google-Smtp-Source: AGHT+IHeQSLDDGaGM06C3DmT6DPfJ9OxZZEG7iZ3wShlX9PB2tTp0g7klku7UD5UU2zkoa72aIzLJg==
X-Received: by 2002:a17:907:7f26:b0:a75:7a8:d70c with SMTP id a640c23a62f3a-a93c3098a87mr1230197566b.4.1727630866257;
        Sun, 29 Sep 2024 10:27:46 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-79-54-102-102.retail.telecomitalia.it. [79.54.102.102])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c27776a1sm403176866b.8.2024.09.29.10.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 10:27:45 -0700 (PDT)
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
Subject: [PATCH v2 0/6] Support spread spectrum clocking for i.MX8{M,N,P} PLLs
Date: Sun, 29 Sep 2024 19:27:10 +0200
Message-ID: <20240929172743.1758292-1-dario.binacchi@amarulasolutions.com>
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

Changes in v2:
- Add "allOf:" and place it after "required:" block, like in the
  example schema.
- Move the properties definition to the top-level.
- Drop unit types as requested by the "make dt_binding_check" command.

Dario Binacchi (6):
  dt-bindings: clock: imx8m-anatop: support spread spectrum clocking
  clk: imx: pll14xx: support spread spectrum clock generation
  clk: imx8mm: support spread spectrum clock generation
  clk: imx8mn: support spread spectrum clock generation
  clk: imx8mp: don't lose the anatop device node
  clk: imx8mp: support spread spectrum clock generation

 .../bindings/clock/fsl,imx8m-anatop.yaml      |  45 ++++++++
 drivers/clk/imx/clk-imx8mm.c                  |  13 ++-
 drivers/clk/imx/clk-imx8mn.c                  |  13 ++-
 drivers/clk/imx/clk-imx8mp-audiomix.c         |   2 +-
 drivers/clk/imx/clk-imx8mp.c                  |  21 ++--
 drivers/clk/imx/clk-pll14xx.c                 | 102 +++++++++++++++++-
 drivers/clk/imx/clk.h                         |  24 ++++-
 7 files changed, 200 insertions(+), 20 deletions(-)

-- 
2.43.0


