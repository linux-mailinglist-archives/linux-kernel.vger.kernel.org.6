Return-Path: <linux-kernel+bounces-278107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 159E094AB16
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 17:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4E89282EBA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 15:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8528783CA0;
	Wed,  7 Aug 2024 15:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vNkVNiRI"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E579A81AB6
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 15:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723042961; cv=none; b=a2CQXpVpXEkMgIJD7aGjXrohyFsBumxtrSdfcsMPf33IBF5zYeB1DWAMAN1LNwa1bU/6qPw7eJk3L2KujdgdYyWAEyp1S2FFRKDjHCdOEEYJr0G5+cD9yIZ6vyy2lqpFM+4erz7G4uLi/I8CV/VJL6zXflnuLHgXJOo4DfAo3Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723042961; c=relaxed/simple;
	bh=+wyWa9keKYvJvojA0lUFTGTwanpx4GNfWBttcW1dW/g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=h9wRNa55n5d0wO+8I/78BO3qJPh7bnjqCSJ2vBqowSc4xoqGEw2CH/XefrxxyrBlVVbgQ50Yz+rOS24zJUa8sk01nGHw82FG1Xw3RMPZFTVjo+Kj6L0sDo6JgTjw3Z1WEo3Hkax5ijjlWU+hvvmMVxtuTIePivNTt5zFQha71U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vNkVNiRI; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5b01af9b0c9so2122468a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 08:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723042958; x=1723647758; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gboyXAEeXuINog3pkYnMpOO7y/D6nwWKyvX/1H9FuXk=;
        b=vNkVNiRIiEuYNWAb3JQc5NGoBRI1GKEAAKxzG8F9vh8fvkjcxpIE0zYjSKRxkYHCdJ
         zAS+0OETGMew8Qpru4eA2vSckG1O3PQ2qwH2aSQF3W43MZ7vtIdYMf7V8rQ8oeh5rIYZ
         Z4OlBn+qib7TyhUaWJlVvPLnOcGDb3OUyeCWIbvG0Uz3RISC9OI69n9VgwpBOK3fkZMr
         NSQDXe9p82hxZ7pJ5btnOQxM1k1fdE3iudfMWQX+xBfwgY4XHl9p4NCiu0WpS9N/VSLt
         siLzr4viGuSZKGFCPeb0Cjlxn1UCsUOz8krvuxcld18sME9dc5HmMNWyE32qP9i+qffK
         oHjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723042958; x=1723647758;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gboyXAEeXuINog3pkYnMpOO7y/D6nwWKyvX/1H9FuXk=;
        b=pmBdzqOyeTxNDq9LqZ1viON+JjVSKaZ7iaqALAhQnfwsUSqveJOtQctu5b9Qp2sYi4
         uXSyGZivHjegFyxYmw9hw1Xgu0IBhec3r8bCVgwhRtyf8jiyo4x7cnLFZvrpRRpD8kH9
         uKXuSBkAa4qhYdV7qA2ZB95jLHS+GuBNRVt+rhMv6HA2UOr66iEaxEBgJe3ftY2N/BTf
         uryUUjCYujUP7l1ys6LMxgKX4TGSQf4Fg9DFItrkeq/h99ptSodVOCEBxMO8K2iV7J9T
         tV/oIdSDlUouzlZ1OmKuuY9oHbxZNwJ2cXGUSmztEe6/m0xHaax2mcwVy/yfeQAX+6VL
         Uj3A==
X-Forwarded-Encrypted: i=1; AJvYcCWokLwwddLBtmTupJRioZcKBeKkcSunLLcwWjX0C5RL0yZLoMXHV51lZz3rV9zE2BV8lF6PKHUT5fSQ5T/TDN7ecLdpurtXL+qhH/6D
X-Gm-Message-State: AOJu0YxpFNpGcgfozAOQ7FvY9HAUcu6YMnYU3133xj6uUkdky4ruYwmT
	xcmmPzipJupR4UIQ3kaGugTKk+lo+ahShbcbLQEv1jkAc5yA77pLq2IElg9+QwiVj/jYbEvvOsP
	J
X-Google-Smtp-Source: AGHT+IFAVMAyBYgyjB17PgBIAsqIPvYIgbKexhMjycc9NMyI226M25xxGJarXKv+Tma4MwJ18ohlaQ==
X-Received: by 2002:aa7:dcd9:0:b0:5a1:40d9:6a46 with SMTP id 4fb4d7f45d1cf-5b7f5dc5d68mr12204944a12.36.1723042957750;
        Wed, 07 Aug 2024 08:02:37 -0700 (PDT)
Received: from lino.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bb90be3a91sm2583047a12.65.2024.08.07.08.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 08:02:37 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2 0/3] ASoC: tas*: Fix up GPIO usage
Date: Wed, 07 Aug 2024 17:02:31 +0200
Message-Id: <20240807-asoc-tas-gpios-v2-0-bd0f2705d58b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIeMs2YC/3XMywrCMBCF4Vcps3YkifYSV76HdBGS2A5IU2ZKU
 Ere3di9y//A+XaQyBQFbs0OHDMJpaWGOTXgZ7dMESnUBqPMVfVKo5PkcXOC00pJsPWq1WFQoe8
 GqKeV45PeB/gYa88kW+LP4Wf9W/9SWaPC0Nno29Bbe7H3Fy2O0znxBGMp5QsYLWOsrQAAAA==
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
Changes in v2:
- Rebased onto v6.11-rc1
- Link to v1: https://lore.kernel.org/r/20240701-asoc-tas-gpios-v1-0-d69ec5d79939@linaro.org

---
Linus Walleij (3):
      ASoC: tas2781-i2c: Drop weird GPIO code
      ASoC: tas2781-i2c: Get the right GPIO line
      ASoC: tas*: Drop unused GPIO includes

 include/sound/tas2781.h           |  7 +------
 sound/pci/hda/tas2781_hda_i2c.c   |  2 +-
 sound/soc/codecs/tas2552.c        |  1 -
 sound/soc/codecs/tas2764.c        |  1 -
 sound/soc/codecs/tas2770.c        |  1 -
 sound/soc/codecs/tas2780.c        |  1 -
 sound/soc/codecs/tas2781-comlib.c |  3 ---
 sound/soc/codecs/tas2781-fmwlib.c |  1 -
 sound/soc/codecs/tas2781-i2c.c    | 26 ++++----------------------
 9 files changed, 6 insertions(+), 37 deletions(-)
---
base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
change-id: 20240701-asoc-tas-gpios-5c051d80d768

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>


