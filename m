Return-Path: <linux-kernel+bounces-306435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47383963F0D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 10:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F25FE2827C7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 08:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B76318C34D;
	Thu, 29 Aug 2024 08:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Yz7Yu7tj"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6191370
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 08:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724921509; cv=none; b=Bg/HZXWYkQHVzxmVtvuePtlX33Bh5J2qqtAHHeAPvJQ7vKbmLOYjX9Vxd7KdiSboHA2fJEFhF8BO+NQm0afg2Cg0HOTGg3V2L/dzeC2ngeqRrNF0ZBm0iZOE7sizIUCawieu8L/EfxnZ97b0QozNWJqjDtCiDGSSAXY9wDuBk2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724921509; c=relaxed/simple;
	bh=WCcwlos8RPRDVUo1I4MOX4l1vAUk/vzepg1fJvslmns=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M2wk2X1p6g7RsOSj9Kwbz/PDnZDq5pc2vIDqPn787n+cXWc59oPLeAxqYthC6h9pEny5ZZF+NrCffWX0e248TogXH3Rv9jNwUKuCfQmzVlwCEULgfhE7q696QMrUXldLIIuytPR9j4KQYl4G0TqPZ8h/Sc2MzZoB0fTQRtRmmuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Yz7Yu7tj; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2021c08b95cso11600015ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 01:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724921507; x=1725526307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eIAeAASz/ZYrof6JHmNSUqvtaNF6cnHwnLCZxylqj3w=;
        b=Yz7Yu7tjl+IeNZb3NKZxXA2Ceay63SMQeT8RN10EqCAnghtYamZodZ2rKMtDgL60+g
         YzSbQZfqYx1PmDFm6fKOBf83S/WULWhBFgLcEznvQ4h8XSwakGzqC8rsDZi+LEJAqshG
         dkjrPbKqnLL0e4P4k9vi0spW4zr/KAG1hmda4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724921507; x=1725526307;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eIAeAASz/ZYrof6JHmNSUqvtaNF6cnHwnLCZxylqj3w=;
        b=fDkrhpZNNRVP3F0sSW89EB2ZuUSj1UFmWsjAHn+dzFlnJFCnyUw9UKHVqa3E/0ko/O
         XJ1DcMYw9lNqREB/jZPk03ZMSDQIKC8rJeGHpUcnJD/XE9HcWM73UhIvJ6HLCYxX2o0c
         sVL3a3rNLQIEevY9M5n6ukUGL3r3QRkBwonJHE76e1NGij0nFIp1XXcrF4GvtnQsOFGG
         ugb9003UpIdTfLf6tuqH1rwFLvCB2PZFm0QVX1oAqP6cvbbBzHoY6BxMdyxq1uFkUFyn
         VorNrSRpvH5WQZt1p+CgG1IJOTCXJZwS/6Wb/E4USWAYp9Ny2ylMe0ekqibk/UH6AdGw
         QnMw==
X-Forwarded-Encrypted: i=1; AJvYcCXOGln9yeGix5VP2cPNF4eEz5bWKjOQCfU2Hs1EkB2bDeVYIiNa8dtabqNcScE3fLPUPnwjpOPOMRyoZz4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzto8I1m8KLbpGTnV9REVR8tS47dBY3moQCCSsN/XdD1Vynnvn5
	OM/zTCCbm4Jz3SIb2Asz+jP54tTHhbSKGjxGAu1DS/8dQpbeAohBnsRwsPYz2/JjmNHn9XuSAzs
	=
X-Google-Smtp-Source: AGHT+IGb9fFiKk0XqfZAGeXj9gAdeNWQ0xstFw+ZSWhcMFLXArgx8GV6bPpRRck/Rprv/rWAmDWHpg==
X-Received: by 2002:a17:903:11d1:b0:202:3617:d52a with SMTP id d9443c01a7336-205166db944mr15710715ad.6.1724921507527;
        Thu, 29 Aug 2024 01:51:47 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:fbe5:6d6c:1cc7:23f3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20515543fbdsm6924165ad.218.2024.08.29.01.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 01:51:47 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 00/10] regulator: kerneldoc section fixes
Date: Thu, 29 Aug 2024 16:51:20 +0800
Message-ID: <20240829085131.1361701-1-wenst@chromium.org>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This is v2 of my regulator kerneldoc fixes series. The series sort of
came as a request from Andy to not move code that already had warnings
without fixing said warnings. So here I'm fixing them first.

Changes since v1:
- Replaced "true, false" with "valid return values" in commit message of
  "Fix regulator_is_supported_voltage() kerneldoc return value".
- Added articles ("the", "a") to the description based on surrounding
  and function implementation context.
  - The indefinite article ("a", "an") is used when the return value can
    vary in the case of negative error numbers or when the returned
    pointer points to a newly allocated memory object.
  - The definite article ("the") is used when a specific return value is
    mentioned, or when the returned pointer points to some existing object.
- Capitalized first word of first sentence in "Return" section.
- Indented "Return" section for regulator_is_enabled().
- s/alloc/allocation/
- s/error code/error number/
- For patch 'regulator: irq_helpers: Add missing "Return" kerneldoc section':
  - Changed subject to "Fix regulator_irq_map_event_simple() kerneldoc".
  - Described output fields in @rid clearly.
- Added patch to fix of_regulator_bulk_get_all() kerneldoc.
- Added patch to align "negative error number" terminology.

Link to v1:
https://lore.kernel.org/all/20240827095550.675018-1-wenst@chromium.org/

The bulk of the fixes are in the regulator core and OF code, but I also
fixed up a few bits in common code that were missing "Return" sections.
There's also a final patch to align terminology around "negative error
number" within the regulator subsystem. These are purely kerneldoc and
comment fixes and don't touch any actual code. I left the devres code
and helpers alone for now.

The patch series is based on next-20240829. Please merge if possible.
I will rebase my I2C OF component prober series [1] on top of them.

Thanks
ChenYu

[1] https://lore.kernel.org/all/20240822092006.3134096-1-wenst@chromium.org/

Chen-Yu Tsai (10):
  regulator: core: Fix short description for
    _regulator_check_status_enabled()
  regulator: core: Fix regulator_is_supported_voltage() kerneldoc return
    value
  regulator: core: Fix incorrectly formatted kerneldoc "Return" sections
  regulator: core: Add missing kerneldoc "Return" sections
  regulator: of: Fix incorrectly formatted kerneldoc "Return" sections
  regulator: fixed: Fix incorrectly formatted kerneldoc "Return" section
  regulator: fixed-helper: Add missing "Return" kerneldoc section
  regulator: irq_helpers: Fix regulator_irq_map_event_simple() kerneldoc
  regulator: of: Fix kerneldoc format for of_regulator_bulk_get_all()
  regulator: Unify "negative error number" terminology in comments

 drivers/regulator/core.c                | 178 +++++++++++++++++-------
 drivers/regulator/devres.c              |  18 +--
 drivers/regulator/fixed-helper.c        |   2 +
 drivers/regulator/fixed.c               |   8 +-
 drivers/regulator/irq_helpers.c         |  17 ++-
 drivers/regulator/max77802-regulator.c  |   4 +-
 drivers/regulator/of_regulator.c        |  21 +--
 drivers/regulator/qcom-rpmh-regulator.c |   6 +-
 drivers/regulator/qcom_smd-regulator.c  |   2 +-
 9 files changed, 170 insertions(+), 86 deletions(-)

-- 
2.46.0.295.g3b9ea8a38a-goog


