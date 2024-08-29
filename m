Return-Path: <linux-kernel+bounces-307129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95EEB9648C3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 16:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D62BFB24244
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 14:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12231B012B;
	Thu, 29 Aug 2024 14:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNJ4Ibd5"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55478197A99;
	Thu, 29 Aug 2024 14:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724942478; cv=none; b=pcOh8fjs/TjESwfcjVu3A5zb1HLg0++tw2FXaABCo3hieP1UfmGPVrMGkI0GVenXyeOYaaq0tYnpD5mTOv2IcVkd5IENyuu99Qhoo3/iTWGSoO3MUtW+nbH/8zQvtTpsQD7qZeWkfNXVsVRHVMXzGfCcQhlE4s/UzoP3k5iywwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724942478; c=relaxed/simple;
	bh=MnHHEGxsondQXOfnrl6ZHPEYA+iRed56Kho9qhoBvEM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VN5YJm2q5ASOK3LMK4w5NXycpcYyXP5EzXpg0V+JVzShQjBL3lUCQWyKVQYKuzVFvZaNXJb4CBkl8qJ8BkdM+Xdxrt4UsXyqcpbKKLfPW5hLmVi/hEg2QCkbKtKyJMrdDzcYJOT7KXNPSd8LlKR2D0nJfuzQa5OmjYURAYBviYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DNJ4Ibd5; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-39d380d4ffcso2722005ab.0;
        Thu, 29 Aug 2024 07:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724942475; x=1725547275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=kZX0ZNUhjjtpPJ5y9WyzEvD5KDhmXlzPYE4GEmpGplo=;
        b=DNJ4Ibd544BaIhIMwFXJXv5I3vd/+qYSb/GQGi5KYXzHUvnNJw+D+wcctR6VxjPUaw
         D57u7TOs1lRID5SkvVSLx4lO70QSjMyMHQKE50MSmNqXXQ+YgYWJtn8awhUrzXhoqXto
         Gjfc5BuM2y9SqaiwUb9BRHxqqC8rXYYgT8aAxEsdzAM03nnkI8IxeKlmEIiAeNvmUPJh
         qPZ01nIO79z+j8R7nxzG8xkKtsXJbaEnOdc6r4O2yBJ5p04zDZdmcFQvLOoshezfbMyE
         Qh6Yal7N8uD/g6F/PU2zBK2HdYmRM3EAPwrTwhHVoa/d/I+7jvXXqOfLkM2negh9BETF
         J/aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724942475; x=1725547275;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kZX0ZNUhjjtpPJ5y9WyzEvD5KDhmXlzPYE4GEmpGplo=;
        b=tmPy2Lv4d477D40vCHV9K9jnnqrLZ2Kscgy/IuID3oqFWbkEYBVa+1vXLSwyBbuXj1
         IlZ6Gty50WZ1fer0vmPna02MwMw8pNVIbsbVz2WfFip8xK3NzZKNWEFOXRi6xVeZtYak
         qPwQCUjX/VHVKyivhKkWNlLEzOPW/SB3PDSlZBv0JLZdKFLrJX38uz8tHhKq5Pn+pZ/q
         DjuHGB8p1Tm5J/Du4rWswl8F0E+dSIozMZQBRhLaxADirEn1MewCWDf9/yFhPJy6BwzC
         9P+FGvANpB4IJMccYod2o3ObIeWSdGjrKssC3tjwMc5PrGdyL0QWFWmvj0xTNvgzEyxe
         WuFg==
X-Forwarded-Encrypted: i=1; AJvYcCVyEzu7akfSZRUGBJDDnUZvPJlpHyrBrMHtQnNszwMOZ3OtAdNmnQdwyjCRk5zlcHsZU12H57+8e5D9TGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNDrOvzxrpdogeKdhwiSD+AMrT/KY7LYNUS6psdsokTuqjmYLY
	36UoIV++7ZgzzH6FB1+Gn/JnslofnpYhw1fX6I3XRMQFnKGAwq0XZhKU7A==
X-Google-Smtp-Source: AGHT+IHPDsSbMw1O5nv4rlHNJGEzMDKNIIzlxIoKkmMJcyf7j7giGN7H2QLT7jtVQV5tbrhY/TNFzA==
X-Received: by 2002:a05:6a00:2d17:b0:70d:2621:57fe with SMTP id d2e1a72fcca58-715dfc0370dmr3464892b3a.11.1724941991295;
        Thu, 29 Aug 2024 07:33:11 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e55b9b9esm1223511b3a.95.2024.08.29.07.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 07:33:09 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon fixes for v6.11-rc6
Date: Thu, 29 Aug 2024 07:33:08 -0700
Message-ID: <20240829143308.1398637-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull hwmon fixes for Linux v6.11-rc6 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.11-rc6

Thanks,
Guenter
------

The following changes since commit 5be63fc19fcaa4c236b307420483578a56986a37:

  Linux 6.11-rc5 (2024-08-25 19:07:11 +1200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v6.11-rc6

for you to fetch changes up to 7bbc079531fc38d401e1c4088d4981435a8828e3:

  hwmon: (pt5161l) Fix invalid temperature reading (2024-08-26 20:58:05 -0700)

----------------------------------------------------------------
hwmon fixes for v6.11-rc6

- pt5161l: Fix invalid temperature reading of bad ADC values

- asus-ec-sensors: Remove unsupported VRM temperature from X570-E GAMING

----------------------------------------------------------------
Cosmo Chou (1):
      hwmon: (pt5161l) Fix invalid temperature reading

Ross Brown (1):
      hwmon: (asus-ec-sensors) remove VRM temp X570-E GAMING

 drivers/hwmon/asus-ec-sensors.c | 2 +-
 drivers/hwmon/pt5161l.c         | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

