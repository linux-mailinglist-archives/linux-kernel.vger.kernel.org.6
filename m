Return-Path: <linux-kernel+bounces-388841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA1F9B6521
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 15:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF3CA1F23406
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 14:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF471EBA05;
	Wed, 30 Oct 2024 14:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rjyxvTy0"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AB01EB9FC
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 14:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730297023; cv=none; b=DF+1evxgJMwfT+mq5doUkYl6A6EmnqCCHFB35nGTK3bibeZ7nkuWu5QeBODHWD2ipRovd/jJKzI8IB3iJTzSeQEg6scRM8m8ehrywJ7QaNkG6Uyh1ap0feT49y45M8bpANloX0BqZtiHmdMcskPn7NJQ8RaDV6yhpmCKZ1MY6L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730297023; c=relaxed/simple;
	bh=V68lRlqhJjkuFECOUQe/LCcMmXUBD6cb2ff39IBPW5k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S0mWJgwkZYt1RzZqyOEE6eiizGkorTAarWj8HYvPaX3Jv8ovceDHR8qSrB2drMI7Oj0oxiZ/2yvelWmaI/HvZhO8R3LDAt3Km0NBW27XjtqspRqFvNXSJWUdgkdULYqBc07tvL7j5OrBqjjDetTXg3icWgI3WmbhPDaO1kR5mjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rjyxvTy0; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43152b79d25so59809855e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 07:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730297019; x=1730901819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oo2UsCaa9/o8/pWgc/XjCGKDfENCDpPIQJDB92tB+0c=;
        b=rjyxvTy0eleUDCQJ7ELXjccipQCVVILGSgFCghppyoHKN1Q7gbAaEMCUni0Q4CmH6O
         DDJbeeL4ZubwCF5TtS9jsbjXgCt9nwiCGQv4oxjzG9FsQmEdRWj+NqtfN3RmlRify7lR
         14xthFvvPwveRwMPrj6z23r6nIXAC5AuiAeIpa//rAR6aJZSgeKxt0q34t2gBLLcv0v3
         H7BeryaDRIS8iS9bSNnujXYsI1lNClM6RmEzH6LuZ9oPFyyysUuI9xKrjqP/EUbPi2ch
         couIOTuWf1KVrI9i+XFH18Jpv40gGxPyX7mrrcwt++THV/nNYyBv7rXr/75a2LCbfPwS
         FAVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730297019; x=1730901819;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oo2UsCaa9/o8/pWgc/XjCGKDfENCDpPIQJDB92tB+0c=;
        b=r/UDXWtqec3+ONpjl2b/je8sFNAz7dEIjJkf1qSNnCJ25cht3mURoYA9WApcPw9KX8
         zMgkpSQtL6ND4bdcPYnCS2F5JQW0IW8UyJlNxC4dYm2K3hM07AqS27FLWfoqgUu4ovcR
         jSoeZRzFBaflCs77b0RPMuSBUumcwVp8ZzpQjzWPkCR7AGpUOoS5y+2ZrHaa1YHmxSH+
         aEFb42CHYvI7aiSgABp5ZBiXoIPYWEAqx5SvXvuvsnor6z51/emO6oBIpt/Dv50+RgoP
         6WZDvi/B6IBSki37pdZGU288K7J8zsUJkMZptyjixKHTgj2RzsbqQdZftvXenlyuzrUF
         Hnug==
X-Gm-Message-State: AOJu0Yyj/zpE+Em/mNjtjsNlMIr0nfRV2qEG5QWxZ1EQatr/k4XJ77V0
	Wv/I+Msg30v4mQ5bHAtkrkhjjWFIQMz9mPXeWNj+F6RW85agh/yHFG+8aVFKwAA=
X-Google-Smtp-Source: AGHT+IHpEFuh71Joe94j3PZM9Iu0kCO39E9J69Q9YbCSWSQJ3g+QbAmDEM4ZYrjMl69OWoOsVZYYtg==
X-Received: by 2002:a05:600c:1d9e:b0:431:5957:27e8 with SMTP id 5b1f17b1804b1-4319ad0fbabmr126162285e9.28.1730297018639;
        Wed, 30 Oct 2024 07:03:38 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd97d84bsm22498405e9.30.2024.10.30.07.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 07:03:38 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/7] nvmem: patches(set 1) for 6.13
Date: Wed, 30 Oct 2024 14:03:08 +0000
Message-Id: <20241030140315.40562-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2738; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=4gmAdEeRCINDTCTuhWTuiG+m6mcMJEPhbySFunKkS3o=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBnIjyi01UaLchjM5jyJZivuXRHAudkJlo+P3RPN ZwlAwci8BWJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZyI8ogAKCRB6of1ZxzRV N02uB/4vNhC86nWdqEGJLJf5qn9kGij793NFP6DI0RKwu11AixDdnpLeRLvNA7ap9b4Xpolc4Jo a2sDBAO621dM6SZhdGxY0lgcCSCCr4aZgjdxkek1owNH5rlOvwMqabbSq+Aij4+aK/1r51MaYII TSjTGVNUjEmEqEMxgXI5GMgNHTU+wO8xyIf3JVXDYKPhFXcJah0YWHzhQN2vYfl1QVAYRnrY+Pj E33HmjiDhZgVg3H1PILCqFRMK6zDjZjmaj8P9EAtJlYu+EutNdgoTGEe1sd2vas7NSHPoccl/Av QtuYfc2Yxhq64pAfJ/Vs6cP2grB88ArT3j4YsnGl8ZcKvTSf
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Hi Greg,

Here are few patches in nvmem for 6.13 that includes
- support for R-Car E-Fuse.
- fix some spelling typos
- convert sprd,* efuse bindings to Yaml.
- move renesas efuse and otp bindings to correct location.
- convert zi-rave eeprom bindings to Yaml.
There is a warning in this dt-bindings due to missing patches,
However all the patches that are required are now picked up by Rob H via
dt-tree.

Can you please queue them up for 6.13.

Thanks,
Srini

Frank Li (1):
  dt-bindings: nvmem: convert zii,rave-sp-eeprom.txt to yaml format

Geert Uytterhoeven (2):
  dt-bindings: fuse: Move renesas,rcar-{efuse,otp} to nvmem
  nvmem: Add R-Car E-FUSE driver

Shen Lichuan (2):
  nvmem: Correct some typos in comments
  nvmem: imx-iim: Convert comma to semicolon

Stanislav Jakubek (2):
  dt-bindings: nvmem: sprd,sc2731-efuse: convert to YAML
  dt-bindings: nvmem: sprd,ums312-efuse: convert to YAML

 .../{fuse => nvmem}/renesas,rcar-efuse.yaml   |  35 +++--
 .../{fuse => nvmem}/renesas,rcar-otp.yaml     |  17 ++-
 .../bindings/nvmem/sc27xx-efuse.txt           |  52 -------
 .../bindings/nvmem/sprd,sc2731-efuse.yaml     |  68 +++++++++
 .../bindings/nvmem/sprd,ums312-efuse.yaml     |  61 ++++++++
 .../devicetree/bindings/nvmem/sprd-efuse.txt  |  39 -----
 .../bindings/nvmem/zii,rave-sp-eeprom.txt     |  40 -----
 .../bindings/nvmem/zii,rave-sp-eeprom.yaml    |  54 +++++++
 MAINTAINERS                                   |   2 +
 drivers/nvmem/Kconfig                         |  11 ++
 drivers/nvmem/Makefile                        |   2 +
 drivers/nvmem/brcm_nvram.c                    |   2 +-
 drivers/nvmem/core.c                          |   4 +-
 drivers/nvmem/imx-iim.c                       |  10 +-
 drivers/nvmem/lpc18xx_otp.c                   |   2 +-
 drivers/nvmem/microchip-otpc.c                |   2 +-
 drivers/nvmem/rcar-efuse.c                    | 142 ++++++++++++++++++
 17 files changed, 385 insertions(+), 158 deletions(-)
 rename Documentation/devicetree/bindings/{fuse => nvmem}/renesas,rcar-efuse.yaml (54%)
 rename Documentation/devicetree/bindings/{fuse => nvmem}/renesas,rcar-otp.yaml (60%)
 delete mode 100644 Documentation/devicetree/bindings/nvmem/sc27xx-efuse.txt
 create mode 100644 Documentation/devicetree/bindings/nvmem/sprd,sc2731-efuse.yaml
 create mode 100644 Documentation/devicetree/bindings/nvmem/sprd,ums312-efuse.yaml
 delete mode 100644 Documentation/devicetree/bindings/nvmem/sprd-efuse.txt
 delete mode 100644 Documentation/devicetree/bindings/nvmem/zii,rave-sp-eeprom.txt
 create mode 100644 Documentation/devicetree/bindings/nvmem/zii,rave-sp-eeprom.yaml
 create mode 100644 drivers/nvmem/rcar-efuse.c

-- 
2.25.1


