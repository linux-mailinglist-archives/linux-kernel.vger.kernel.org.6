Return-Path: <linux-kernel+bounces-568371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28678A69494
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 17:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B714D1B60ADD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 16:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F9D1E231A;
	Wed, 19 Mar 2025 16:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hiP7OV/X"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38BE1DF738;
	Wed, 19 Mar 2025 16:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742400729; cv=none; b=mTnXLNJaulzXNsUGGwHCOHqHYPJ4tOBLpvgEJ3m+mwMalvimIVorY+Q1EG5vCOaO/eFbYMlTm7gDT2JvfyatyOOT1bKRT0IIU8EU1dgBc4E3ScbHchLXjITBy0qQBXQwEWe5mhpuRnhnqacH+knjz0MPNfFLmEMGDBT4aE3aUoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742400729; c=relaxed/simple;
	bh=PitlnMBcSUQWByVc/F9g1dyEBupB1s6/VlSzt+WGqm8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N0KsJcbgMsew/dJnMWmJ11pBv5MnbHoFAqJ5NtOJNXJfAGH2yrSM3St3t6x0GYETFh7V3bbuLJt5iE3ysUTqugJmXCxam4t/PaYUNfoKuT2vI/aedbhU6ds8ZAtaCqfQgEY1UsJS6VoJvNoBJy33kkI6gT9E3Y4nb3ruh8CmSVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hiP7OV/X; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2243803b776so32000325ad.0;
        Wed, 19 Mar 2025 09:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742400727; x=1743005527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Jt1+akIffF5Oy8MHqoXlvpzmjdsajTsQHLl116uC05c=;
        b=hiP7OV/XoMj7W+9jYz5ijXMnJ61orxP5K1Sq406JjHRc2Z4MVkGvv8plnw9GsdkxRa
         tNptR76hMyKwsc5HclE/86Hd96vQHdBSm3Y6sLYQl+3674UZKEJZwL1XSRuucz7gV0eO
         zBAky6r8onGrF2tLCKqjmS5SPAqnkiDzx8v1tl+VKKf0uUR1oencH9xuzX07fe8XrohG
         BCfszxS2LYSea5x3+fcyZrhAjlvbJPWbwYIUQoFknRUZU+inGaFrrK8FU23xn8HbvelW
         apoW8CcgbJTkHYXT2Scif/fYPFo4gkez9CfwL+AKSlf3yImZZfuuaSBXhEYQVMojrYXB
         CBLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742400727; x=1743005527;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jt1+akIffF5Oy8MHqoXlvpzmjdsajTsQHLl116uC05c=;
        b=DFXRZ8Odb6pVoyHmOXHcNZExKi4W/i52msvawy/ORtIpgGVvVdRv9yGBf+3XcN18SJ
         jSN2grnc8N7lT/PPKCyTKTSP9m131TLH4sO99RvPXvpOzoszsytkYUwxL352GCEDy/kU
         rIwdJqBKX4CuksXQUxTeIzIXve5vJJQ+vtVpIdQztPIpPBhP9roVNJFUrdhB4h5s2iCt
         /kEmIYHQ3Ksl97SpmvuPJrlbIlWooac45wAoxE6Q6ZILCBsZapR/2H9FcwnsucfW+iGd
         BqFHWLtz4Iy8wRLxUX39svP9r2lcQwcs8wL0F8/AxzIuTAe9xqwd5dN5lArCiuYXbQVu
         qBBA==
X-Forwarded-Encrypted: i=1; AJvYcCVwvCZwy//PVEf3kZqySySIITF4uyJQAJjHraZzzoeCGAVZfkPYQz85SPMjAxuKUjq1r2XzfS9YoXLN9FI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOw3pK0izJGXAno5rhFoS7LSfrXBwyH0/8GIuwjb3NRI3lrtfq
	7BrNJjliORpxQt5M7d5yl/yjdGedA8k0PG8lYQtuDDmn6Tn3DKOg6F5Xzg==
X-Gm-Gg: ASbGncsSIYZSXjW7jvUIT7J1Ez+ZdqlOZq14ifu0NfmEI6vOrHivnrnRBN7C3AASKDh
	PYgyE8V5BUj7AtqtBNgYVQamfScMZPQoZRik8q3gDkm5hxUcarkriZc/s8p3lkj8bZiAk0LCFkY
	6ODnYUmmYLOSGzEPxi3xVC4hKS17LRtuh3pvDdYtsyWEnvsEsJHpsPrqqVG3aMvv/cHAfibabQ2
	0ZehYdpAURqksxenh6zDl/7LeISWFQ19hqANH7NjLH+ZTLQVWoKnfwSxEX/FvtaiBFaX5oKvSvB
	fL/n+rrPsZFtrgw6tNAmkn0AnqL1qFDyAGE6x4H6BE585yrmy7YsfgptIQ==
X-Google-Smtp-Source: AGHT+IH0+8T6k0R4d1Cn4WzhD5rZY9gGzROe5ukycibivAGzLk0az/sSIWMaYeVgz0atvw8P/PWfOg==
X-Received: by 2002:a17:903:2288:b0:224:1609:a747 with SMTP id d9443c01a7336-22649a375damr41156825ad.31.1742400726479;
        Wed, 19 Mar 2025 09:12:06 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7371152953csm12216720b3a.11.2025.03.19.09.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 09:12:05 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon fixes for v6.14-rc8/6.14
Date: Wed, 19 Mar 2025 09:12:03 -0700
Message-ID: <20250319161203.358370-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull hwmon fixes for Linux v6.14-rc8/6.14 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-fixes-for-v6.14-rc8/6.14

Thanks,
Guenter
------

The following changes since commit 80e54e84911a923c40d7bee33a34c1b4be148d7a:

  Linux 6.14-rc6 (2025-03-09 13:45:25 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-fixes-for-v6.14-rc8/6.14

for you to fetch changes up to 815f80ad20b63830949a77c816e35395d5d55144:

  hwmon: (nct6775-core) Fix out of bounds access for NCT679{8,9} (2025-03-17 04:44:20 -0700)

----------------------------------------------------------------
hwmon fixes for v6.14-rc8/v6.14

- Fix an entry in MAINTAINERS to avoid sending hwmon review requests
  to the i2c mailing list.

- Fix an out-of-bounds access in nct6775 driver

----------------------------------------------------------------
Tasos Sahanidis (1):
      hwmon: (nct6775-core) Fix out of bounds access for NCT679{8,9}

Wolfram Sang (1):
      MAINTAINERS: correct list and scope of LTC4286 HARDWARE MONITOR

 MAINTAINERS                  | 4 +---
 drivers/hwmon/nct6775-core.c | 4 ++--
 2 files changed, 3 insertions(+), 5 deletions(-)

