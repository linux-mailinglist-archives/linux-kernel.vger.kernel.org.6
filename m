Return-Path: <linux-kernel+bounces-235690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FD591D876
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 09:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 377051C21E04
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 07:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F80659160;
	Mon,  1 Jul 2024 07:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lU1RygW+"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E652C39855
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 07:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719817359; cv=none; b=RSPBy4d/5yvdL4P+vcSzuOnOXdjpi8/YKI7YSY+MO1AV/rVzsmxtFLyfyP3Yd0ar76qOfPYq/lgzQ70CMz5F/QOrzFjJCEXkuEHwjh5waw5noenme46BuEwdpb903Uoxhh9LRo5joPwI+PVKpfiGM/OYKwyjg1iL5+l1p835td0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719817359; c=relaxed/simple;
	bh=cBYvlD+uGm4bJQ4B0yh+wG+da72WDtr4bU+1bwuff10=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BJNOZnyG+7k8wcJiHldeq4KD/dwiP3B0KSFwS99qXZO0ZrZczzS7wswy3BcOQPoaJoj3O1vlj70daCkoOKGt3xoYnsek9tJ83cRP1oc1WfVV3DRVoTnW3fksASrjQWSLCYKvpYkFGl/AJo0F3GU/GYI0HpMWtrgJPda8Ly278g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lU1RygW+; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57d106e69a2so2809174a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 00:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719817356; x=1720422156; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BNxRkokndQgS6PANhpBf3Erk5CI3oT2TsBCHeOpBCbw=;
        b=lU1RygW++E7DGEz+m/mFKTKpRgHzJYtaN4mS0LXVPNRShqBCwvSUZf24l8L/Hlv8Ub
         tsaFv7EWUP8Mkl6VUmiT6ypAI3i945YCWm9Tx4+lFcQCbt0NPHRJ/tZsG9wu9+1hF4mk
         jRNeUSK73fbGSrdB+wOnUfYFKxYMMaNrwwpWT/iAj5d5ZPM45wPc4RpNb3AouaecAYA1
         JHKqAr76yavsWV2DsY9u80uywyM+xUgO22IwQYcp1qhgWm2RvRGpIAccn5HdY81dNq9h
         yrBp+iWbxcL8etEb3tLC7qRv2VkIbVBAIIkr1QkDM11lx6HzSCJrzAFpbNHrRrHawblC
         IijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719817356; x=1720422156;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BNxRkokndQgS6PANhpBf3Erk5CI3oT2TsBCHeOpBCbw=;
        b=tOOkdZi1uqwVO0XJnbtPMI/65JoInd1VtDYaEe+S+jRowJmcRpoI13vEe2efaZJquY
         dQv6F01EDewkY+vf5xlg7qX2JpiDRccN5f7kXqxdS0bWZQLQE5Gg726qw0Ql450IOuvX
         Amdf31JqdCx6xZV+QBA3ETpIE+RRvkAbQkgI2Q7GPWdsIkRR6/BmYoEZ7VvKL1GbAR5x
         dmb0jgaLyFNtndBFK09vB4phPwT77+mC23MAFeys8VPUXipgWTTOIRNScsw3LctJ/U4j
         xM/7m4JjrlOkwCIkTJaWBOwRQYJwrPjfbGAHPMrlBukSM4nEhaZL568iX0tk+Bvhe0O4
         yotg==
X-Forwarded-Encrypted: i=1; AJvYcCUBaPw81T/g37HIxntYOFU5pdCGGB0c9+w5Fh19OjE3J1BHtNNW7KFdYM9zwL7leH3OVjf9zcpm/mUX8DHD+OaC21sToOJru2KijSz3
X-Gm-Message-State: AOJu0YwwCa0qy4RVbDC0LjUL2X5cQu3g1CTrykedrGQ8L55jQAyvkmgE
	UvuTSas6d1V1K/89Rf3YPNZbYaJRQOSG5Kb8NxKCpnp0leH3Bb7ZB9yoDSPtm34=
X-Google-Smtp-Source: AGHT+IFNhztsKQspA93PM83poO4cdAZw8JWQkG10BqzhYODnEj8VuZNhOj6/m2oKwI+kNWX5P2Ac9w==
X-Received: by 2002:a05:6402:26c8:b0:584:21eb:7688 with SMTP id 4fb4d7f45d1cf-5865d47375fmr7232268a12.14.1719817334068;
        Mon, 01 Jul 2024 00:02:14 -0700 (PDT)
Received: from lino.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5861324f036sm4034383a12.34.2024.07.01.00.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 00:02:13 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 0/4] ASoC: tas*: Fix up GPIO usage
Date: Mon, 01 Jul 2024 09:02:11 +0200
Message-Id: <20240701-asoc-tas-gpios-v1-0-d69ec5d79939@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHNUgmYC/x3MPQqAMAxA4auUzAZS8Q+vIg6ljZrFlkZEkN7d4
 vgN772gnIUVZvNC5ltU4llhGwP+cOfOKKEaWmo7Gsmi0+jxcop7kqjYe+ptmCiMwwQ1Spk3ef7
 hspbyAUdqO69gAAAA
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>, 
 Baojun Xu <baojun.xu@ti.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Shenghao Ding <13916275206@139.com>, alsa-devel@alsa-project.org, 
 Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.14.0

The TI TAS drivers use some legacy GPIO code and headers,
this series fixes it up.

The TAS2781 is a special case since it adds a handful of
lines of deviating code to reconfigure a GPIO line for
IRQ mode and then never actually use the IRQ obtained in
the code. Is the line used by autonomous hardware? I'm
puzzled by this.

Anyways the patch suggest how to solve this properly by
fixing the parent irqchip and I'm happy to help.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Linus Walleij (4):
      ASoC: tas5086: Convert to GPIO descriptors
      ASoC: tas2781-i2c: Drop weird GPIO code
      ASoC: tas2781-i2c: Get the right GPIO line
      ASoC: tas*: Drop unused GPIO includes

 include/sound/tas2781.h           |  7 +------
 sound/pci/hda/tas2781_hda_i2c.c   |  2 +-
 sound/soc/codecs/tas2552.c        |  2 --
 sound/soc/codecs/tas2764.c        |  2 --
 sound/soc/codecs/tas2770.c        |  2 --
 sound/soc/codecs/tas2780.c        |  2 --
 sound/soc/codecs/tas2781-comlib.c |  3 ---
 sound/soc/codecs/tas2781-fmwlib.c |  1 -
 sound/soc/codecs/tas2781-i2c.c    | 26 ++++----------------------
 sound/soc/codecs/tas5086.c        | 27 ++++++++++++---------------
 10 files changed, 18 insertions(+), 56 deletions(-)
---
base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
change-id: 20240701-asoc-tas-gpios-5c051d80d768

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>


