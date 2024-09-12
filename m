Return-Path: <linux-kernel+bounces-327275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54503977342
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 23:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87D781C240BA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 21:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007771BF80A;
	Thu, 12 Sep 2024 21:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XuzCqWuA"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D0713CFB7;
	Thu, 12 Sep 2024 21:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726174940; cv=none; b=XrpFBOVxoGz3r38opUoIBYxu6fD9ivYvP99tNfoc8qqtjID5TfNgaJz5G5qNWzCaEEvQUGPLqorQG4wwKssJciiBCDNu8oMdLIi9uBvlulVUePGWfRzWrAZLbOd+RIJ+V+mQEBIHxqQyao7l3np0K2/DsOlne9hP/VRT2RQQ28M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726174940; c=relaxed/simple;
	bh=rssm9HJWK2a0zh7wx7igItT3UMlUUg3vCxnu4E+AOEE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uIY4HZxRgsHbQbGqgtboLkgZeBwTyPtQQH7Mvlpx6KIbJRNOiKg2HBSAhsqfyTMEbyfsuv4w/9BRZkTfCAphfIgHAZOJuuaHjAHlR1L+qr/t6b78nYqdzOugNzE6iojzYWHvDgxT+CQOjXbc8DbLVchIrABhMQg0xsl93u97e1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XuzCqWuA; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-206b9455460so11938185ad.0;
        Thu, 12 Sep 2024 14:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726174938; x=1726779738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=RrSckW6x9uomKy/ENMgMIUSNKJ25LuLqiiUE4kLcewk=;
        b=XuzCqWuAEQ2E1RoTUn/nLCgKJOFa4Lt2w77zsd+1Duu9kgfSjUCc5X8ueQnmAZag8R
         aTuDlf6no4RvfAXwwrc5DKX/92h58bx+uHIG3bAd8uU1zNk3BEfdtLAtSaNeOPrBSdQt
         ozb5ASUp6m8jXF2Jqn0zhnZGUXzdz3ibAB8rqISZ1iCQnERTbaAoNPxVPeWtO1YaQB98
         YZ/dz4cejpGzgKxJzR5sxb5PU86nvaF/zvwd7NcOhXdTtQed19jvG0lsNOgfF7EPZOuN
         9K3WtTiRN3B5/7Hh7wVu4wjgGV3jAIppukBPhGOw1Rcaj2oyGrZ6pREDXINCrpx+8gxH
         sQZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726174938; x=1726779738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RrSckW6x9uomKy/ENMgMIUSNKJ25LuLqiiUE4kLcewk=;
        b=sBwSWhgr2ZfFAwhrf8BYSnITRlaQ/RVygaXoABlsdrv0W1ihIMRLV+ij3Qj0SbN1jZ
         0wfKd0pKAKyDrlCFYb8L7K8KzAIefb9oVAbYygFamBCsK2hWvYjAd5GeUcDbSAKdlvfE
         +JHtmmFaT7Xnz0YSCCbHrspHZ3ITpCNqMMf9x/6Wjb1lt2nJZgEZ/yVY0IFIzNJ0Z/5M
         d0n7BmTOWYCFScL6ZjsLy+/g0zDyIB0TY8sySyeGA67l8tznYnVKg0+SyVmmhFKqVbe8
         VsVkxZsXY5AoWBi6mfAaBwVx1BCFb9l21h465EfIPHZ7TB0xDNfaEOK5mxjlOUNNqVk5
         P+cQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrg6KsWnkuFR4y3fhF/Cz3XoOEpseMQpAz2G8ej8YMdss/7QbUP6An1Zkp16vWBXX/xVyTkdfV3lh9br4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsAwplTGRfLWJHCPzAIXBYNh+5k+BBNWNA4aPuMEJzdrGQqKbh
	DKj0zNJJTl2Qsp4ub2VqpYRw118ZttqDENEVu3dwr0PPxiVNWrC4XDrpUw==
X-Google-Smtp-Source: AGHT+IHKG7QyKtTs1qWEPh7TiqTVtdGQobXWdjhjaSGLocZkDEjmhrneg8j2M1Jv8DiBxeNUgaX1+w==
X-Received: by 2002:a17:903:2a90:b0:206:aa47:adc0 with SMTP id d9443c01a7336-2074c6dcfdbmr153269085ad.24.1726174937843;
        Thu, 12 Sep 2024 14:02:17 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076af25709sm18051745ad.24.2024.09.12.14.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 14:02:16 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon fixes for v6.11-rc8
Date: Thu, 12 Sep 2024 14:02:15 -0700
Message-ID: <20240912210215.1907774-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull hwmon fixes for Linux v6.11-rc8 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.11-rc8

Thanks,
Guenter
------

The following changes since commit da3ea35007d0af457a0afc87e84fddaebc4e0b63:

  Linux 6.11-rc7 (2024-09-08 14:50:28 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v6.11-rc8

for you to fetch changes up to 20471071f198c8626dbe3951ac9834055b387844:

  hwmon: (pmbus) Conditionally clear individual status bits for pmbus rev >= 1.2 (2024-09-09 10:58:09 -0700)

----------------------------------------------------------------
hwmon fixes for v6.11-rc8/v6.11

- Fix clearing status register bits for chips supporting older
  PMBus versions

----------------------------------------------------------------
Patryk Biel (1):
      hwmon: (pmbus) Conditionally clear individual status bits for pmbus rev >= 1.2

 drivers/hwmon/pmbus/pmbus.h      |  6 ++++++
 drivers/hwmon/pmbus/pmbus_core.c | 17 ++++++++++++++---
 2 files changed, 20 insertions(+), 3 deletions(-)

