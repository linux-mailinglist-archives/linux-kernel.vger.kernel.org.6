Return-Path: <linux-kernel+bounces-174704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2A68C1336
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 18:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEF731C21A08
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 16:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3868BF1;
	Thu,  9 May 2024 16:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CyEej2Xe"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90572F24;
	Thu,  9 May 2024 16:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715273001; cv=none; b=KqK50jPu9qgha1/3KofRq5PlerzMoBj9Cp/n6temB3sJbQt6xpsqPGmEMav3pIkM1+SDXXlHom98zRaJDiFkJ+S6w4PUhkpc6jcPt+iXRX5NjcCUc2BqRyyyWpR/x5XS8zRmuJ3zh8ndbNx/6uA57tfjtpe9Mc3yjiS8YRj2owU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715273001; c=relaxed/simple;
	bh=0AwIvUlnW4lCfUG4D7qRiLz+lWSN/1R0NdcLcsB9njo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U7YK5phCxOi4p9Rml4vbnoDCYWeZhkfNOaYQ7ocrKOog6YA3o0xAYsMJxCsz956e5mIQZuafqy+wpVtjbPmx9MHkhnIAj/Rh9mVPh+lKE051vrDNnWE1A1IChojbDWEhfiQ+yCiHrkEdAhryCO2EccOtYL7n3+ysil0U80CdB78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CyEej2Xe; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1eb0e08bfd2so7171085ad.1;
        Thu, 09 May 2024 09:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715272999; x=1715877799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=dq5l0e1y2tiW5zzqrOBBkXmIVHVwwkyt7NGBvVrmm+Y=;
        b=CyEej2XeHClhg/+sp+wdsamg2rXcyXJdCzfF9pECOi4Gc/ifNfGaxl3Xxdt0fje2ym
         2xgyHF6QYzCw72SBQMnb2Ark+wVSJsb4Jhw6nwsGLrs9ctGDLdRFz2DSuq7bLfuCazKL
         N69ZH/anBAooKzmu4Hp+Wze0dZbZPaux5VRU35EMWHBVeWniu2Mj3AS5KqkEO9zOsins
         wcch6OIff4iucfhklj0lQmzLh58GB+kUY3laYn/+hTORxabNt4WoUV4myLuQF2EzRRXe
         D5OZ2MvPOc3uHrkq0XC2TF1Ano2NbPCHvtia5qzqnhD2NCAuYUa++DuGPWOKt+O9UE0w
         7HVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715272999; x=1715877799;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dq5l0e1y2tiW5zzqrOBBkXmIVHVwwkyt7NGBvVrmm+Y=;
        b=h5dvGf2cul0Fm1mk61+W55D1Z4lZSVMlcIf+/FCR6jxvCUEhr6nOd3mzE2vV2tuf5k
         cWv3g/8TQ7+BAtCyTZVM/2eaAj1217PiXPMR3AoN27kdiacz5T4QF5kzP2ApXtl4N36u
         xhvU14ivkkTbHUPXoagRC3AP7b9jSzfub4g4uiMBPvCEpQeXZfdVAk99TDnDg0pPaxbJ
         n5P9pF+gvaUwY6VtLqcCdXGUuwkRzABWpWQRCTmJWZS5dDcjgs+7DDYOOxcY0+ue/x09
         KuuDyutwnlV2smnUq09Y26xQpTEkjhRzJPh1KrNOyxugeOj56zQq154z8WPCV4SGREVV
         S41w==
X-Forwarded-Encrypted: i=1; AJvYcCUiRJaqOMyxSmFhj2C2VqPlU6FuI8MZ/4OBuhGgqrKvwVm5ZL5QxmTkdFZCWyE/dQM6EmbMvCh6bQjs4ulXBOytAL3+Gdc9Ea63Ptgm
X-Gm-Message-State: AOJu0YweqL+al58rMC9KfG5bKc+rciJXpVzqQivrWpnXzUdk8FEXc8az
	KeAXCaCd2bPbZzpVes/ZPBxvFU9l1Yx3KEPLicxAvZx1XCiYMTwu5CSLFg==
X-Google-Smtp-Source: AGHT+IEewnTAzj8MUnI6YI4M9wFxLUJyfGMaKptYriUZ3npN1Qe2yacoQc+IcJtBsm6jX4ApHyWkpg==
X-Received: by 2002:a17:902:82c8:b0:1ec:5f1f:364f with SMTP id d9443c01a7336-1ef43d18196mr1905495ad.26.1715272999192;
        Thu, 09 May 2024 09:43:19 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c136d53sm16433195ad.254.2024.05.09.09.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 09:43:17 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon fixes for v6.9-rc8
Date: Thu,  9 May 2024 09:43:16 -0700
Message-Id: <20240509164316.3876202-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull hwmon fixes for Linux v6.9-rc8 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.9-rc8

Thanks,
Guenter
------

The following changes since commit e67572cd2204894179d89bd7b984072f19313b03:

  Linux 6.9-rc6 (2024-04-28 13:47:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v6.9-rc8

for you to fetch changes up to 26e8383b116d0dbe74e28f86646563ab46d66d83:

  hwmon: (pmbus/ucd9000) Increase delay from 250 to 500us (2024-05-09 09:37:06 -0700)

----------------------------------------------------------------
hwmon fixes for v6.9-rc8

- pmbus/ucd9000: Increase chip access delay to avoid random access
  errors

- corsair-cpro: Protect kernel code against parallel hidraw access
  from userspace

----------------------------------------------------------------
Aleksa Savic (3):
      hwmon: (corsair-cpro) Use a separate buffer for sending commands
      hwmon: (corsair-cpro) Use complete_all() instead of complete() in ccp_raw_event()
      hwmon: (corsair-cpro) Protect ccp->wait_input_report with a spinlock

Lakshmi Yadlapati (1):
      hwmon: (pmbus/ucd9000) Increase delay from 250 to 500us

 drivers/hwmon/corsair-cpro.c  | 43 +++++++++++++++++++++++++++++++------------
 drivers/hwmon/pmbus/ucd9000.c |  6 +++---
 2 files changed, 34 insertions(+), 15 deletions(-)

