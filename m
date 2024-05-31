Return-Path: <linux-kernel+bounces-197495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8494F8D6B6E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 23:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A4241C222D2
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 21:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546778002A;
	Fri, 31 May 2024 21:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTBfIe/t"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6CF1CAA6;
	Fri, 31 May 2024 21:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717190320; cv=none; b=g+YmUoyXGZIK9KUwJtAmMDAmLNHkgOwEdVwtZ4CrBAOZoR0U1JGXHSb1w9oHBf+ezzbAcuyDWeT5kX2CHHTjZGX/H0/JuNEE1l63WtLlO8ryXzqgcvbQXen6jjfBISSCgCOFHub6/47bcihZY4jGtXcGNYYf+eMSMEeAZpt9mBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717190320; c=relaxed/simple;
	bh=BhBOMOlRBLDWP/YBXKC6zqzoAkUA/qWA2XLKoJ3alxU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EHmGDym2Y9w5GjfiNUXtMR7qco93JypYevFrLsJIvaNbGgxoipGB7/U27CMjuevU7JfTK6er7M1R5ryzJLdnW0R1vIr7jfd7cEgUzY0KgfjYqhKJVfKRx8wZmqdnyysZMIFlP+bCdYRo8Tsf8WklKpoaz4lLE0likrbBBXO8+ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cTBfIe/t; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70249faa853so988771b3a.3;
        Fri, 31 May 2024 14:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717190318; x=1717795118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=MaBWr+6fkh5iqMGxTtmf+W5u5Z9ZApCsEmoFL6gcvcg=;
        b=cTBfIe/t61lk2xQTSG77NqVJ6gcYlc4rbnOVv18qUeE76rJ2CZ5YOcnicssUNinmmB
         RiJCKlIg93eT5yTSA5ig7OJtYvi/gZx/j2Snv+CiVTlbjq8HaLeJyj4XHiCELNORU2FB
         kOb3ghBiLCpzLbteSX5ga+L1Syhmyt8qM39BKt+SxQFjm0yrYXvP8PlJJHXEtrW3A0x8
         36cm6z61zUwPdRSkupsj6OyPhV/sNC6guWIerMv26KDjHf1yFun9q7ZybvHVEr21YdNg
         GKEq2fYGYwONs6EcgKjJbVF8dG/iajszBon+PFgLx6zCBhQV1aOWwJfJMIzkMWlR2+5h
         2pFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717190318; x=1717795118;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MaBWr+6fkh5iqMGxTtmf+W5u5Z9ZApCsEmoFL6gcvcg=;
        b=T8u6mUPeoS+L4U/vAuVYMHRJ9bbdr8yYSdGxiCVBWdguGWsMoRRSpVjFthjdWuFEA4
         jDTt1Gd7gRje252IT2OWqaMREHiALK1pMaeQAn30rim2nkc6Or8CoZw/DLOSM9WOPbL0
         eQpCTKeUy7C/920hXHk2M8zwxTjeB2uRRv6sXU+l3Z6gKJvd0on5au4aMnC+MUUwnOqO
         xDpAx+Gy26cwX872Q7HGOsjHAipAtAtHErXCzDWgdwrI0E6t1sm8RU8gHxndY4TLqCtZ
         797E8yWnxFaIYd5xh18sTELnj/MR8PX3mRfIiSLO89RLm6aa6z4QsVXIEYkvLx10MGMK
         205w==
X-Forwarded-Encrypted: i=1; AJvYcCUMbPjw5FJxTHTQFLFXUrC30FVtkkqHk155PCAPrMsFcQd7pkgV6m9tun0yLJIFTETPEDYwGUpu5OIjfuQ0c4ZxetDS1m9QaguRLQNY
X-Gm-Message-State: AOJu0YyStAG68b0VyWRypKjRCKEEUQamki9mSid/H8b9LKl0qhoKrmKh
	nb7uDyjjWXS+C5N6IAHbvYvHSNUkWwqM4fK3L78aNlOckbQOagntUe1Epg==
X-Google-Smtp-Source: AGHT+IFtFJA5qR3yNkD7xEBE4XbGvkqen1FBezmBDocw69MZvDul9M5nGW73ihK2AYRZ+tZvCJrAAw==
X-Received: by 2002:a05:6a20:841e:b0:1b2:7004:5103 with SMTP id adf61e73a8af0-1b27004520amr3462793637.47.1717190318330;
        Fri, 31 May 2024 14:18:38 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c1c2844133sm2057688a91.49.2024.05.31.14.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 14:18:37 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon fixes for v6.10-rc2
Date: Fri, 31 May 2024 14:18:36 -0700
Message-Id: <20240531211836.1399346-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull hwmon fixes for Linux v6.10-rc2 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.10-rc2

Thanks,
Guenter
------

The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v6.10-rc2

for you to fetch changes up to 52a2c70c3ec555e670a34dd1ab958986451d2dd2:

  hwmon: (shtc1) Fix property misspelling (2024-05-30 09:05:19 -0700)

----------------------------------------------------------------
hwmon fixes for v6.10-rc2

* sttcs: Fix property spelling

* intel-m10-bmc-hwmon: Fix multiplier for N6000 board power sensor

* ltc2992: Fix memory leak

* dell-smm: Add Dell G15 5511 to fan control whitelist

----------------------------------------------------------------
Armin Wolf (1):
      hwmon: (dell-smm) Add Dell G15 5511 to fan control whitelist

Guenter Roeck (1):
      hwmon: (shtc1) Fix property misspelling

Javier Carrasco (1):
      hwmon: (ltc2992) Fix memory leak in ltc2992_parse_dt()

Peter Colberg (1):
      hwmon: (intel-m10-bmc-hwmon) Fix multiplier for N6000 board power sensor

 drivers/hwmon/dell-smm-hwmon.c      | 8 ++++++++
 drivers/hwmon/intel-m10-bmc-hwmon.c | 2 +-
 drivers/hwmon/ltc2992.c             | 4 +++-
 drivers/hwmon/shtc1.c               | 2 +-
 4 files changed, 13 insertions(+), 3 deletions(-)

