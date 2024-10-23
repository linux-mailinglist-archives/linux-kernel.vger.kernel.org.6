Return-Path: <linux-kernel+bounces-378778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D35BD9AD562
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 22:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 721AE1F255D4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 20:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F6F19EEBF;
	Wed, 23 Oct 2024 20:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMrTws7S"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793E22AD20;
	Wed, 23 Oct 2024 20:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729714563; cv=none; b=hdAgCGqhuvJxteY4JHoT1Q+nbL25OngpjQuBLgWloUeNdcA04xbD00oOmufmCym/lwESnLY2gwtLJVGiXO0r76bpsK/+3gHYQnrmCh81Ipet1gyXTkNboTAs+57nWWs0zPd57sRhGcLI0oswGEMWomWBrJGqin9WmNPIfKZ6+sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729714563; c=relaxed/simple;
	bh=6+AK9AuAFG6ADjbrX2AqsaD78/Tzko+n62pg8Y7ZzXc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sXFWIuDXQ3ghIbMi0WscUT5iPuAoG58Zkcst5WbzjhSjsu3LQ0HYqhxlb6xcFJ3PkeMOFIkFs8TzUEceWf+XzXpjyGogo7BjwOq+yRzu55sGadZhvrAJCw9sXgNyklnk4Va3lKCGGJUiEVROSu34eGXBH8tZhyKEcSKqd8JvLjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LMrTws7S; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a99cc265e0aso13476166b.3;
        Wed, 23 Oct 2024 13:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729714559; x=1730319359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AsH0ZzoWvB4uqTZ7SJcyUc1fyfeZci7lyqSTKLMlkxI=;
        b=LMrTws7S6MnclIqsEWB42dljjES0N281AGJ6ZIGIAd901fFMjiy0QTI2TnQx8ZoWcj
         GOAEjDdoQWDb/aqa/7HCIaKtl+CRBm+PquQcw+SB5MhSyIJN5Th3gHk/fPvsk0ETtihq
         DaMe/cdoegjy/iQQTpBVkBYcermMhLKvgzOcMX6Wi9MrglFVQNDKB+M2up0doH9Yy3/5
         vBHYxMD04r3vvOCGzVtHq0LeyUdropYo4sAD4easoLrhgdhCGmUQ80v7Jvxy8+XEI728
         PZq/kGcVH/hUN5mdxR6EuSEeEZl+R2kEvKbjWBQgl5atyv7D+oWHH6jtMcVI5sVbM842
         9cVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729714559; x=1730319359;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AsH0ZzoWvB4uqTZ7SJcyUc1fyfeZci7lyqSTKLMlkxI=;
        b=cEHS/0obA6mElFZKuZb3959Xyd91v3e9qo4rgfZGJ/rQ22RPY9TqpeuFExQJFWSLEs
         CQbN+3wLgc9inRszuIMBqgLD7Ifq9KGwpG8FQcBLznRe1f+g6elwWdW9ef4GkUYg0Vps
         /ZynHbI//VcClp0f6nDPI85Z3KnSaNDZ/4ivl0zge1gm8T6IaR78jGDIFtvr9TWvMpjJ
         cF8OqH2wJvuPmBmiG5AbtnArI5entpIXyy7FTr47hvXBUhrMlAYgLBxoahdpfapVM+tM
         nmE6IkqZTB0+6FJ8E4THdeZut3OVKcB5C8GzQxJ455c49wutPIuujrQChFbbzkkdi8Og
         dkmA==
X-Gm-Message-State: AOJu0YwUfAveq2nx+Ypkyjb9s2uLvGUKZ4dtqt2W99JaPel6hG76kWBt
	qxogIev7BG2ts0AgRno+Ci9MJwZbRo00vkPIZGHIiNqbRgiuXkS/9sD88pDk
X-Google-Smtp-Source: AGHT+IHHWwET6DgOp1B0qnobQwHnsDPKqVqwWFB1Lh7QIcUZ8L/bkRViH8wAd/wC6jYtQbCz+nOjtA==
X-Received: by 2002:a17:906:7949:b0:a99:92d3:7171 with SMTP id a640c23a62f3a-a9abf965d97mr318107666b.61.1729714559194;
        Wed, 23 Oct 2024 13:15:59 -0700 (PDT)
Received: from amezin-laptop.home.arpa ([2a01:5a8:415:c7f3:98d9:da9b:465c:b70e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a91573645sm512863366b.182.2024.10.23.13.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 13:15:58 -0700 (PDT)
From: Aleksandr Mezin <mezin.alexander@gmail.com>
To: linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Jonas Malaco <jonas@protocubo.io>,
	Aleksa Savic <savicaleksa83@gmail.com>,
	Aleksandr Mezin <mezin.alexander@gmail.com>
Subject: [PATCH] MAINTAINERS: remove me from nzxt-smart2 maintainers
Date: Wed, 23 Oct 2024 23:12:34 +0300
Message-ID: <20241023201334.250764-1-mezin.alexander@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm a Russian troll. So remove myself from the maintainers list.

Signed-off-by: Aleksandr Mezin <mezin.alexander@gmail.com>
---
Never did a good job as a driver maintainer anyway.

Maybe Jonas Malaco or Aleksa Savic will be interested in picking up
the driver.

Apologies for any inconvenience.

 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e9659a5a7fb3..15b804952c67 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16679,9 +16679,8 @@ F:	Documentation/hwmon/nzxt-kraken3.rst
 F:	drivers/hwmon/nzxt-kraken3.c
 
 NZXT-SMART2 HARDWARE MONITORING DRIVER
-M:	Aleksandr Mezin <mezin.alexander@gmail.com>
 L:	linux-hwmon@vger.kernel.org
-S:	Maintained
+S:	Orphan
 F:	Documentation/hwmon/nzxt-smart2.rst
 F:	drivers/hwmon/nzxt-smart2.c
 
-- 
2.47.0


