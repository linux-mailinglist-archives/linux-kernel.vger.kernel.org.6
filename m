Return-Path: <linux-kernel+bounces-362001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FB399AFD7
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 03:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80E801C214D7
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 01:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C52C8CE;
	Sat, 12 Oct 2024 01:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ANE0fbUx"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5AB8BFF;
	Sat, 12 Oct 2024 01:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728696536; cv=none; b=tpZnSLTygqzNS0lQW3I0RW1SPMpHlKVXVHLmSIRg7uKkZxW1CMHx1F0Ku5+IMLvjHyn4qBD43BTusGTC/BKw+kWNm/ZtPF/BDps1GQ4BnnZ+P4zLubm89t2sOy+d4uzzXneiPFS5QqmgvKDUAdP5M3bRFxzPpaisq2ouwg+nd0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728696536; c=relaxed/simple;
	bh=16qJtVuNU/38QRhzP+3SpP5icDTY+tKQH2jy0ESHtso=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YB5uP4ApjeiQjrM4X73BFYuudxB6QtuQ/yQC0G2gKZu61yodHzAQLGRHuT+ci0vWOxSMoU+nIg/94GrqAQuD9++hLbot5sZcyPKRxIXRN6/t0959G7soFm5qhtPkevYFYzbFnhBncPCK+klbX7E3PfmNS2F2sUNFNO8Q8fMRfIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ANE0fbUx; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20b93887decso24125825ad.3;
        Fri, 11 Oct 2024 18:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728696534; x=1729301334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=+uz3rbpJz9TtBYHIDBHTeD17IgRp0RlMKwvHZrhK6bE=;
        b=ANE0fbUxhvLWQL1KhJgYF0QZLA8xO91+OkA/eANXDbemrVNdFIfCUTNkAxhdbpplXe
         +qZ2NiGoejBHTLOJWw+WCMyskMyZq5K0vJevVKPtsszB4+pfdj5hXCE9//QgPprHrRFE
         WzBHo7jO+2wTLSL4s5OPbXYfWAlwlnCgEyNAqNunnqFjtcRjXdtpWoWVitmPzvKebEP2
         pwaKtLThUm1BKl9T46Uk2wTEBzX1+sv89wzOtQzgMCbJrIC8pHw/7SqeIc3losZWf4e1
         TzTqbJjIDATM0toBDV0A022y3nDHCeq7VXYVc6FrsMWfAuFQ0V4bKgpQuIYm03kt97Tn
         zsbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728696534; x=1729301334;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+uz3rbpJz9TtBYHIDBHTeD17IgRp0RlMKwvHZrhK6bE=;
        b=P0igWA10KgIRziRLmcM1s/dIDYP14QYzmaKsjdU5CwXWclHgyLTmykopDWbk2lk9s6
         XE0zwvmXTQqbzoc0mDqZmgo3qErrBjtUVGitDU6oo/orGJCiA24yQpvbLV8XvVW91CcB
         GNfUuBociGzJDGKrtNnCsNvWmXQfLGrYRyJuFakscM2nrDY91RXyeVIj/LGb4s7LrlCa
         tMMLEIlSrRk7Mgmw0cKB1b3yqHGv47j8e82nDAd8U4yN5kBeTtGuCxA2yMNCDJpxSI+f
         BUco/OySdHTXQN7P6Yfd9VfeEYQZxElnWy+ITN+C5CwXvDeoSzAuaPmQZYdmlh1adltB
         a5fw==
X-Forwarded-Encrypted: i=1; AJvYcCVxZKmZhohArIC1wchiYt0RMfM+NdD2xkditpOeUMF61lvRZURz4/YU/vf9lM/3BBRDjp8FXUSmysc4rIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQuQ6B4lmjYjBv3cJRyF1aEnZdGXHVuwEKCn+jT6R5srm7PXHj
	M6cv5TLBM17kpWNqeN4AJqBFait2Oov2QBrH4Y6oxWNJjGAwYeqDmK67Uw==
X-Google-Smtp-Source: AGHT+IEjZFT3mf8QHZ/bTzsZsfHOzMGGXzGjJ0KbA8FXuFtrabRAyrbPCvXCWbBlD5NeDZPEdD8z6w==
X-Received: by 2002:a17:903:244e:b0:20c:62e1:6361 with SMTP id d9443c01a7336-20cbb1acfe8mr27580545ad.25.1728696533800;
        Fri, 11 Oct 2024 18:28:53 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c0eb491sm29663435ad.179.2024.10.11.18.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 18:28:52 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon fixes for v6.12-rc3
Date: Fri, 11 Oct 2024 18:28:50 -0700
Message-ID: <20241012012850.1580196-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull hwmon fixes for Linux v6.12-rc3 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.12-rc3

Thanks,
Guenter
------

The following changes since commit 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b:

  Linux 6.12-rc2 (2024-10-06 15:32:27 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v6.12-rc3

for you to fetch changes up to 2d6c668902e5834f54d7eb673318455492730cbf:

  hwmon: (max1668) Add missing dependency on REGMAP_I2C (2024-10-07 08:42:32 -0700)

----------------------------------------------------------------
hwmon fixes for v6.12-rc3

- Add missing dependencies on REGMAP_I2C for several drivers

- Fix memory leak in adt7475 driver

- Relabel Columbiaville temperature sensor in intel-m10-bmc-hwmon driver
  to match other sensor labels

----------------------------------------------------------------
Guenter Roeck (1):
      hwmon: (tmp513) Add missing dependency on REGMAP_I2C

Javier Carrasco (6):
      hwmon: (adt7475) Fix memory leak in adt7475_fan_pwm_config()
      hwmon: (mc34vr500) Add missing dependency on REGMAP_I2C
      hwmon: (adm9240) Add missing dependency on REGMAP_I2C
      hwmon: (adt7470) Add missing dependency on REGMAP_I2C
      hwmon: (ltc2991) Add missing dependency on REGMAP_I2C
      hwmon: (max1668) Add missing dependency on REGMAP_I2C

Peter Colberg (1):
      hwmon: intel-m10-bmc-hwmon: relabel Columbiaville to CVL Die Temperature

 drivers/hwmon/Kconfig               | 6 ++++++
 drivers/hwmon/adt7475.c             | 3 +--
 drivers/hwmon/intel-m10-bmc-hwmon.c | 2 +-
 3 files changed, 8 insertions(+), 3 deletions(-)

