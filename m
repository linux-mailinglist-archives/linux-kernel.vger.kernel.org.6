Return-Path: <linux-kernel+bounces-343340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6299899D3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 06:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0390BB21521
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 04:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD1213A244;
	Mon, 30 Sep 2024 04:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FpY+fjX2"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F0642AAF
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 04:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727671597; cv=none; b=VbYnKtNu2K0RYiIq0cQncTxLPu0DnTJrYyKfKSq7B749ELC2Sf6R0RHiPdzwt/eb4gp3qLQ/aKne18pISKXhO/mv/cQhKocEnlx6FvPKVkwOp9TXAsVomUxRdeKdGTGi4yUKfegavmIH41hCaILHO+D+qIt7IuxxtYhf+GZ+hg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727671597; c=relaxed/simple;
	bh=Xri5kWiebzmt5N8SwFi0njY4c80jL9hRys92Pd7U5HE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kKw3Cmue8Ff8CgNOanltj4+e9fu4JBkH4Gjgy7mGQx5Hvn6FlKFlzLEELSDhrXIEaauOmCXhsiehNV/8wOS4CRaPt2138/CLIg6Cb9X8bDMFjm/NbHlakLAjXGnd3QGLB8YKIv7+Ad+BY6bZFamJsVnOQi6yyJ8AAzalBc/Jx3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FpY+fjX2; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-206bd1c6ccdso36110585ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 21:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727671594; x=1728276394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x6fQANF7cLgNYEImELd2aRDhcfXDngeWPNi/O1BMJo8=;
        b=FpY+fjX2RBNXBwckhuiMobUqEmK0p5YzPmdCGmJ1gF3QwIqhBAM7jkJ4Ny/qrJz0Mi
         N8e4TtKJb2PZ/9/d8TAcWcNnBhuHTmgIhHHzQ57hTWBc7y9dS0oPwiYIBALIbiwSdn/o
         p+9Z/9YnvlyccLANSGkJN1K58NjJGvqPp1lOE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727671594; x=1728276394;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x6fQANF7cLgNYEImELd2aRDhcfXDngeWPNi/O1BMJo8=;
        b=VqkJSxgzxt9fVLnGcXcgDhk4vGxV8aJXmbMqFfoyYi2+wes3EfDPrRHoVECrPmIZqo
         RodL3OrYI0cf+yEF9SiUkxbVD5VefBJC8sOF6BX5bX67yqbMryM0W+I9oL2B8RelJesn
         RsM+U5Zwyvowp7QawA0LlUhUtNh8wnEOqgF0mnjgDxnxKTLXWmulzKbkYIU9e5NH5pQg
         d2HcXzxy3UVbrTkvVhokVZJAjmcoLRr3Rq7fqW5oIURWRcqtN0RNwZBnforkGj81KlkB
         GO3aUPEdts1B7AW2B1YJoCDhc/XZf8ebukK3fwPTBcultMlglLQMmKWaxflv5xdRuHG1
         srqg==
X-Forwarded-Encrypted: i=1; AJvYcCXAw24sBmb2LfdAlnPSLW6/vbi4s35Y51nWelHN26sOQLe2ULqNuIPcykQA5J2IHhQEYLtKmGevW6jCyXc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnuhBavYIZOYM4wpGxgCani3ZNfKqvsGubf4Pag7pf56WoLjUV
	LlvHlN/3K3LEWQohL3+3yaxpwBsSltZnoCCOTvcYF9K+IN76QhhuQrfmiqr8GA==
X-Google-Smtp-Source: AGHT+IENQ7NhAJEfEEzudtLCJxzrSxYTgcSTJ2qYcUG48+ffvUH/sGw4msh0WJHorJMBcHhknsJBxQ==
X-Received: by 2002:a17:902:e844:b0:20b:65a8:917c with SMTP id d9443c01a7336-20b65a923c0mr77993745ad.10.1727671594304;
        Sun, 29 Sep 2024 21:46:34 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:659b:6caf:831b:3926])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e0d65asm46236925ad.123.2024.09.29.21.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 21:46:33 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Mark Brown <broonie@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>,
	Johan Hovold <johan@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Pablo Sun <pablo.sun@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v9 0/3] Add of_regulator_get_optional() and Fix MTK Power Domain Driver
Date: Mon, 30 Sep 2024 12:45:20 +0800
Message-ID: <20240930044525.2043884-1-wenst@chromium.org>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi folks,

This is v9 of my of_regulator_get_optional() series. This series was
split off from my "DT hardware prober" series [1].

Changes since v8:
- Reformated stub versions with `clang-format`
- Collected Andy's Reviewed-by for the first patch
- Moved OF-specific devres version to of_regulator.c
- Made _of_regulator_get() static again
- Made devm_regulator_release non-static

Changes since v7:
- Added stub versions for of_regulator_get_optional() for !CONFIG_OF
  and !CONFIG_REGULATOR
- Added new patches for devres version and converting MTK pmdomain
  driver

At ELCE, Sebastian told me about his recent work on adding regulator
supply support to the Rockchip power domain driver [2], how the MediaTek
driver has been using the existing devm_regulator_get() API and
reassigning different device nodes to the device doing the lookup, and
how the new of_regulator_get_optional() is the proper fit for this.

Patch 1 adds a new of_regulator_get_optional() function to look up
regulator supplies using device tree nodes.

Patch 2 adds a devres version of the aforementioned function at
Sebastian's request for the two power domain drivers.

Patch 3 converts the MediaTek power domain driver to use function.


Each of the latter two patches depend on the previous one at build time.
Ulf would like the regulator patches on an immutable topic branch so
that he can merge it and the pmdomain patch. Mark, if you could oblige?


Thanks
ChenYu


[1] https://lore.kernel.org/all/20240911072751.365361-1-wenst@chromium.org/
[2] https://lore.kernel.org/all/20240919091834.83572-1-sebastian.reichel@collabora.com/

Chen-Yu Tsai (3):
  regulator: Add of_regulator_get_optional() for pure DT regulator
    lookup
  regulator: Add devres version of of_regulator_get_optional()
  pmdomain: mediatek: Use OF-specific regulator API to get power domain
    supply

 drivers/pmdomain/mediatek/mtk-pm-domains.c | 12 +--
 drivers/regulator/core.c                   |  4 +-
 drivers/regulator/devres.c                 |  2 +-
 drivers/regulator/internal.h               |  4 +
 drivers/regulator/of_regulator.c           | 88 ++++++++++++++++++++--
 include/linux/regulator/consumer.h         | 31 ++++++++
 6 files changed, 121 insertions(+), 20 deletions(-)


base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
-- 
2.46.1.824.gd892dcdcdd-goog


