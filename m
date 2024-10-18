Return-Path: <linux-kernel+bounces-371898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 838F29A41EB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 17:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24F87B23A5D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 15:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD7C1FF61E;
	Fri, 18 Oct 2024 15:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gi8/rTi1"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007B9768E1;
	Fri, 18 Oct 2024 15:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729263937; cv=none; b=uHU4L2FbWuWOXvtiBxrWw6NPv6bAHk+OAI3smARQxke/htkVocp4QT38fy96QX9HTmxfv7lyrkfvNUvJR7rKp+lCeETdFr+tUyEKDEvYA95QxK6rwoJA8bUcDod64jH5aApwoNf5oZlE9Xxc7ajGd0q6IeLlNgvscuf/2YBYCK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729263937; c=relaxed/simple;
	bh=+fD6lCQpOeCSm54/WtMVv/HCy1IcHILJsJdnbVjIPu8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YltMLd9p/C7tKXtGIG88IrJFCuq8ksWrxZ4uNMF2eLHdNKvR6ukb58M02pD9fbrZjrihQM74ZWBVn6bNFFTQyaavZQUsd4JvJG6sAGFGA3nQnnXPPNCRxl0JAG7dsV+31eF78qtOa5d47zVQroIPJrdm+tVxB8OK7Yw3YAUeDBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gi8/rTi1; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71e592d7f6eso1443163b3a.3;
        Fri, 18 Oct 2024 08:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729263935; x=1729868735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=7TwL/yuSTYlBpZHh1TaBOF8oIGjU6Y4M0/4saRikpmE=;
        b=Gi8/rTi1tC2SqD51llGnkD9BTTKp/o5cDrhkI5AehHcJEXboJGUeV5tiLF50uBWSfL
         mP8+xzj02MiiEJWZOyS2BKD9fYOn7NAtF9zt/YSLBZ/gf2yuVet8vEOBsGvhXb8ozXVp
         A8XjJSeMRNy8D+M6BzbD4HcFHQe0RmOSppD9BsYUm1PgiVvfRLe6XOnHEEuch8BUNxzA
         R3KF4dHUlj29mjA5yN4yNd+axmFFIm+vosf0vR7BpCXdm7o9YIM/FCGJkDBu2ORB2gSa
         HRnEFHpPwf65lPfwf3cMmyYT4fobdDm9XJ7VwQ1nTA6jDFCsRUq+QxQdHF4xHij/I5ZO
         jKZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729263935; x=1729868735;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7TwL/yuSTYlBpZHh1TaBOF8oIGjU6Y4M0/4saRikpmE=;
        b=mRyxxA0XV3zNxY0GCHvZNFbMxxv83PVv4vY4sGrRHMkQx496bPJ3GMGI/cU659F9qj
         qXLEgV0NVpFzYhfPFQtJgEKL+cQrdg8aD1jBOKvYUu/uUvAF9Pwki+j8VjN6+AqHgeVW
         wUB2Mc+x2NhjgtzkgqZIgTLXk1uc/xoAwMgyYko2VViQEiVYjBolqKTO/emv7BkMpXu9
         a6JNhejytdLti53FpYrGOroBfNAvvdKZZpQgT+1eSnv5A+hFS1iD397O2y2PF11g+wfQ
         odUaLB0GIPySTI+juFghgJDcFXBxJ0sF45N3AJBlhAAMQS+f7+Uvf8Vg5qBo0LtABagS
         gZBw==
X-Forwarded-Encrypted: i=1; AJvYcCV3GC+8XF8Hk90RoA54+V3AoItwMCAnEl5Aa0PIRLaZ/4qk/O9YP1F1VsqkhcA+ItgB0rkr49OtfUjAfrg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/6hCbNKxUdnqnaEmLCB/IFKVbUZK+ejHXKM+GBxU5Ey9Xr4dJ
	zV3aRRnszNoDoYwd7gyiYapzEfRLJTbjwVO/mUa7eCVqeBR1JIeRsq/bQw==
X-Google-Smtp-Source: AGHT+IG7WeTXxSVwQPpjkZEZaKRpxxQQko5XiH2CAecb4x/TajkPATNCTzbkWF+Yxg6QChWLP5S4IA==
X-Received: by 2002:a05:6a00:8c3:b0:71e:108e:9c16 with SMTP id d2e1a72fcca58-71ea314f37dmr3789520b3a.12.1729263935009;
        Fri, 18 Oct 2024 08:05:35 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ea333e870sm1547121b3a.67.2024.10.18.08.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 08:05:33 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon fixes for v6.12-rc4
Date: Fri, 18 Oct 2024 08:05:31 -0700
Message-ID: <20241018150531.122425-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull hwmon fixes for Linux v6.12-rc4 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.12-rc4

Thanks,
Guenter
------

The following changes since commit 8e929cb546ee42c9a61d24fae60605e9e3192354:

  Linux 6.12-rc3 (2024-10-13 14:33:32 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v6.12-rc4

for you to fetch changes up to eabb03810194b75417b09cff8a526d26939736ac:

  [PATCH} hwmon: (jc42) Properly detect TSE2004-compliant devices again (2024-10-14 19:14:08 -0700)

----------------------------------------------------------------
hwmon fixes for v6.12-rc4

Fix auto-detect regression in jc42 driver.

----------------------------------------------------------------
Jean Delvare (1):
      [PATCH} hwmon: (jc42) Properly detect TSE2004-compliant devices again

 drivers/hwmon/jc42.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

