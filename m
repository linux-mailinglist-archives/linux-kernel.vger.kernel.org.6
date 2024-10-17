Return-Path: <linux-kernel+bounces-370346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DD09A2B57
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 19:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C24841F24347
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 17:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A0A1DF97B;
	Thu, 17 Oct 2024 17:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="WdbWPib5"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282B61DFD8B
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 17:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729187274; cv=none; b=bhfZMR+lxCMVRXuJL2A1B2b5l1iEgiGmHWqsZeCr6kKDuIpcBz28nmEm4DkI5y5BUWUpZQIEX631faOSkz6AjAoeeXx60H5Vu0Gp8t5C5ZkSF9vBCW9jS5m0AO5L48oF+iEHGnqDLJnZ4ZkS44jQBEMBIZGs1RsUJ3Cbq/A5hew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729187274; c=relaxed/simple;
	bh=eZjhXMRVyoTUk0OAje7sjGHZ/YnqTms9bJWWFzJAFYY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=tI1DohI5QM5we84u+4VxjjAtbnGTnGjlAyURcAcfgtpxeUc7ccY+/CRupQKTJmsWYGAX76XTICIZFNqmgLml0j90fNNuUqPdOdHFF8UegDK5Yl1F/5hJgSrI0a9bKxia8bAsjSLxbqmNnEOF/qKqpvZnESYFBD9uOAkq6bLcG0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=WdbWPib5; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7b1343e8042so122198085a.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 10:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729187267; x=1729792067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=54GhF2upJw4275dZmdws3Pd1W0s5MQOwhp0NxjAL5+c=;
        b=WdbWPib5Q/RwJB8H2fx+zXRw90l0YRdis2tez44jvlq48dp/Y8IwEbo/lnSV6vKaab
         srAM4Dntovc6BjSIZLcjCwJgML0X3zJCosCRJn81LD6ra9sEYQ8xDdO2bJix0i5D+7cu
         4KLe2zOzcldELASAJ2QdWhBfNpkEWl29qU6tCDyaWUHOf7GXQZ5sCzto4Ecs1iMSmZcJ
         heKxgFHut9gvdcJhBiVVRg1kXHetGk77RvxHlOXnw5+cVWetNe5L4y/hq8uBGSYL5A7a
         xclyTN/CTpS/At/z9T0KosrZsI3irfl5fnxTHO3Ku1IF2mnhPq4ElrRzbhAP54dqsicC
         x2Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729187267; x=1729792067;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=54GhF2upJw4275dZmdws3Pd1W0s5MQOwhp0NxjAL5+c=;
        b=eTscpVXqWyQirfvBMfNgYWxWifXLtEKyO4Ex7hKHUMvDrtYYBZHXkgv23CODaL0vbN
         6nRDdGotonrSG3tlMyQQfs6H3maOcvpSP3qxnW4v1HY6itNUHDtldNo8Ic1H3LTJj/Oz
         b3gbIQN/NvyDelMlanwwRkyMa2hufoEwfrmYLtDFicJcMk6JfNj94BVosT7nD6NAQ26Q
         SDHVd4vsZU20luJrnRtCPqwpporWSGNeAHUp8noaZJgAq7eXXsW37XOQ/+0bH1RKCbln
         +SVCD0oxo2LTpsy8gFS/EEir1ce1aa57nmVTqnnT1ZftrFCLnGARCtfHCmS/zai53w8G
         1dvA==
X-Forwarded-Encrypted: i=1; AJvYcCU+gZ4ukeHm36tciscwf1z2tQgQ+zFYVgGUxfD98SHZzWrHpbXMAn45P9uVQESyFjz9G4zdRxVKAQptj4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH7DdqF5D5+MleIx98mTtGgyzWi7iUsC85o7fdmdFwcTiyV2Zz
	5UTdvYVzp6EnZoMnl7bBcQJzhJ//+FNwSd6bMo4qgEbsPsY1bLaZ5+fqxIGKP0I=
X-Google-Smtp-Source: AGHT+IEFPUkOK0eLP6z1lBrU0QTOOYA3R3KSYRYiDrJyfydjWV6H8jXefX7+W+/cik2Ooc89qJjV7Q==
X-Received: by 2002:a05:620a:2986:b0:7b1:1a1e:3013 with SMTP id af79cd13be357-7b1417a2b73mr1163907985a.8.1729187266985;
        Thu, 17 Oct 2024 10:47:46 -0700 (PDT)
Received: from megalith.oryx-coho.ts.net (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b1435a2681sm238047685a.74.2024.10.17.10.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 10:47:46 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: ukleinek@kernel.org,
	michael.hennerich@analog.com,
	nuno.sa@analog.com,
	linux-kernel@vger.kernel.org,
	tgamblin@baylibre.com
Subject: [PATCH] MAINTAINERS: add self as reviewer for AXI PWM GENERATOR
Date: Thu, 17 Oct 2024 13:47:44 -0400
Message-Id: <20241017174744.902454-1-tgamblin@baylibre.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The initial author of the driver has moved on, so add the final
submitter (myself) as reviewer for the AXI PWM driver.

Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c27f3190737f..a506fa4f6825 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3758,6 +3758,7 @@ F:	drivers/spi/spi-axi-spi-engine.c
 AXI PWM GENERATOR
 M:	Michael Hennerich <michael.hennerich@analog.com>
 M:	Nuno Sá <nuno.sa@analog.com>
+R:	Trevor Gamblin <tgamblin@baylibre.com>
 L:	linux-pwm@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
-- 
2.39.5


