Return-Path: <linux-kernel+bounces-220836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB8A90E7F8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 12:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A76C282B27
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 10:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13EF5824BB;
	Wed, 19 Jun 2024 10:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Woqa+H3o"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EC48248B
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 10:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718791932; cv=none; b=co460LhIwEecrWW53kt1kA9DH+b7h8lPPlJ+76otbmKm62WpnxuIc2lwsLzAnowpLOKL0LCPKx50znF8g1JQO3n29CtEXfEt+geF/y5QktQP5m9P75biHu4v/UdkuMwYqnRPxdn8fL0X/F4diQo1AYqQxF26V+tkwEehHwjDIyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718791932; c=relaxed/simple;
	bh=kHY1vH6BBkxxZFRnYufEk6fxcSBFGkIlkEUUcK6K/FU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gI94lwWc2R7tzBpFW11vWy5LlULu9QBqepQhirxTrMidsgCb1/3L+dt3jJKR8rdzdNwI206yQb8kkGZtqKQgU0dtHFLB7stLRkCs4RhiOWbdI2t+kZ4ZkqH2+F1jmEmYfkVxfY2LMHDsObFXR12chuIGvg9epV2aTUFB66DxtHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Woqa+H3o; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ebe0a81dc8so68632681fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 03:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718791928; x=1719396728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hcu8+Zif/ccINpaWODxcQKH3yfc3YxmRr6966jXAh7I=;
        b=Woqa+H3o0qmt4Suf2t8irflv4gE9LfAQ/QX0X8K79Kub54OnhJvowp1YpxSDWI7W1s
         OxjSvquFhyuVoCn5J+lozPfachdw1EmJ92Pg8fyw82YmVxz6Vb1gLQYgVNTxBa/6mPDo
         fTWpGLLzQEu6TqOFv5hZYHeq1ekX7/N8INyJNDHSDAz70vHjjpdYasgxWRBikSzN4gWm
         HeMiDu3xbOeASbM70CayVQQEySQ0nHpVUvl/N5vS0XBqwVCqheL7+zSIp/SLfA2jYF6k
         4ZecztwEXGz8PA+9azXrKQX/8YUXv5ZCAK+7ESJravPruVcYogqo93qRlmYCDzuZqROl
         vbGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718791928; x=1719396728;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hcu8+Zif/ccINpaWODxcQKH3yfc3YxmRr6966jXAh7I=;
        b=vzyyf7t8pZ1/dkTlC1WeC7sP5FQo8NNjekOLxuXGKaFC68d62qmpyH4pAGK0FxEkVF
         m/XSPyqjYUVg0q0Hj8LWGl3aSa+Ew1pZS1rLmgjCW+V+FTYiE/N76o6mJxGwGZcnRXJW
         6/Xc8gAVQZP1OelSm12CLAV7xT/YyZub6ByhPa9gN8R8iCSel0rW3mfiAnkYrv/yj43W
         SqgnJFszNke3kI7eDNX+vQpw3bHXkmCDzyJ6SwHmdPDZ0tnwMPMxb4sqImdQ6HGvao+A
         cFWWsd7m16mytfv1QmHMs+1kxFKeYJR6w0g9RcWk1JXHqJVzUTk3dqN6wyFdkBMD525G
         n5yg==
X-Forwarded-Encrypted: i=1; AJvYcCVg6yrS+ztdsVXt8ofNOnVMJF4hjEpbee5oqVd/z8mPcn4GNowj9bfboh8ZJl1wt2jyUv/IZEkweBlfApBbdiJxCqLyxV3oyIdTej8M
X-Gm-Message-State: AOJu0Yx8t3SqmBzfglD0o+s/BPeY1Wrwoz9EISb5Z4inTbm/3oR93LQf
	vMqVdG3s5F8T7WUxNihtMoq19GVPcHxQ5rNd7vxDpyz9Y80NBIdxUni09qZfWCE=
X-Google-Smtp-Source: AGHT+IEzhMWtxs5cTYTajp8i9SldB6gh0A8ivaB2clHoeVqUAeVMsyroeG07KMstx6mQ8pQMtp+O1Q==
X-Received: by 2002:a2e:90d1:0:b0:2eb:2e0b:72c with SMTP id 38308e7fff4ca-2ec3ce940c5mr14717371fa.16.1718791927842;
        Wed, 19 Jun 2024 03:12:07 -0700 (PDT)
Received: from localhost (p509153eb.dip0.t-ipconnect.de. [80.145.83.235])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f6320bcdsm226186795e9.35.2024.06.19.03.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 03:12:07 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	William Breathitt Gray <wbg@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-pwm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Thorsten Scherer <T.Scherer@eckelmann.de>
Subject: [PATCH v2 0/5] mfd: stm32-timers: Make register definition more flexible
Date: Wed, 19 Jun 2024 12:11:41 +0200
Message-ID: <cover.1718791090.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1724; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=kHY1vH6BBkxxZFRnYufEk6fxcSBFGkIlkEUUcK6K/FU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmcq7erMUf6iircChQ0RcAdlPwtSu8f0VDee7Kn n3MWM2MKluJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZnKu3gAKCRCPgPtYfRL+ TrTCCACLqYUAHkJZT0Tw/SLsxP+jGGK0k7jYsnE8R/rp8lXu7e3RVClxmNFOaUN9xqaQUfTKV1R thDnxrP64UR7FGN9NufoxhW5qJhmwi6FG9pmcjAwCvDqTJBe4k0UvavEtH/y2freKrnVKYZUoIv tcDhHbm2O9AP7a1tvAE5sbS0wIo53nVho728sKSY6yJRjTVj/1PyN+Ev0Kd8ae29xEqtMoCLpQu GAxYhrXrkgQbHQ2YsfTe3Pp8xyJ6uMmRBIbr6LAVbnT2IPcbePU0T1Sn8p5XUS7Xlme8dbG1phD wDtnbmSwF5mY9vILtIlNAoUe7S2pwq3C7hUMppx6gou2E4ts
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

(implicit) v1 is available at
https://lore.kernel.org/lkml/cover.1718352022.git.u.kleine-koenig@baylibre.com
.

Changes introduced here:

 - Split the patch removing TIM_DIER_CC_IE() and use appropriate subject
   prefixes. Lee and William didn't like the patch touching both
   include/linux/mfd/stm32-timers.h and
   drivers/counter/stm32-timer-cnt.c not having a hint to the counter
   subsystem (at least that's my interpretation of their feedback).
   Not mentioning mfd didn't seem to be considerably better in my eyes,
   so I split this patch.
 - Fix typo noticed by Thorsten.
 - Update subject prefix of the last patch to match what is usually done
   for pwm.

I have some further updates to the pwm-stm32 driver that will probably
go in before v6.10-rc1. They shouldn't conflict, still I'd prefer to let
the pwm patch go in via my tree as I might have some further changes for
that driver. So if this is merged using the mfd or counter tree, please
skip the pwm patch. A stable branch would be welcome in this case.

Best regards
Uwe


Uwe Kleine-König (5):
  mfd: stm32-timers: Unify alignment of register definition
  mfd: stm32-timers: Add some register definitions with a parameter
  counter: stm32-timer-cnt: Use TIM_DIER_CCxIE(x) instead of
    TIM_DIER_CCxIE(x)
  mfd: stm32-timers: Drop unused TIM_DIER_CC_IE
  pwm: stm32: Make use of parametrised register definitions

 drivers/counter/stm32-timer-cnt.c |   4 +-
 drivers/pwm/pwm-stm32.c           |  22 ++--
 include/linux/mfd/stm32-timers.h  | 179 ++++++++++++++++--------------
 3 files changed, 107 insertions(+), 98 deletions(-)

base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
-- 
2.43.0


