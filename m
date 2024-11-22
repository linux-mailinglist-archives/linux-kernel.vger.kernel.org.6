Return-Path: <linux-kernel+bounces-418040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1FE9D5C2B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 10:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A341B23DD4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 09:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC4E1DE3DC;
	Fri, 22 Nov 2024 09:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MV5t7/nt"
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372CD1DACA7
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 09:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732268902; cv=none; b=eKFRQec2S190It7Qaibyc5e/2aU9Q0JqYVfj9MJypH9d1FtKPOkyseGcFwtMIaQKGn1c2K6fcwEPg257SlYRtK4qltSyjIfCsNdhn/R2Is2L3uHBrX+yB0nlvNanCDNwuFZ3UpOW2CfX3rNWN7icYcuA2JCK8hRzL8dX1nmJSTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732268902; c=relaxed/simple;
	bh=h7Fy6ID2Wea+cuB0h198OsRtS8B+sBBixK2ZtTg/Lzc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QXGvqklOe3yl8PFgGl7RuEXHAfyMW1WuyvNPSQKOdRaFWZizSO3E/uYHwMyeOtzfXdrhjM7BPk2p2FRGDKAM1PbvmPRXrt2laHZHAkIuyyIpM61uqerIWMIIlixRPhNIM4KeUAT9proYpK+kmzhskVZykk/YGIApndw3+fO5j94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MV5t7/nt; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-4ad633f4cd9so323195137.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 01:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732268899; x=1732873699; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cs82EvgmY8NzBFhpFn/AfZi8XWnAsUV99htkSHmKbBI=;
        b=MV5t7/ntlXkaqtRcmYYHpH0YeQAS6YNpbSBWTvhiSupqC8t10r5dRE+ymV9od7Q6Gc
         /Zd1rrF0HZaH7JAHHGnLDd/oqWsvhZFjC7RyQuBYt3/xhQcOvvD1W7sGI69zPkzVr0DZ
         l4q3MRNaLZst6JiWKCKh1hBRyR37p1L6y3RDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732268899; x=1732873699;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cs82EvgmY8NzBFhpFn/AfZi8XWnAsUV99htkSHmKbBI=;
        b=sxE+iYbhMLprKiPcChdPGYydlVBhd7xp9mfFQd5DiEeoparwEGA4c2SDeoFeivpyML
         s6rRzeta1nxfwCsL9hDbFjX3wjGyzFiJVjPzCSH6P8hPGZpJFEZHziOQU6OY8e4r574u
         NJrAMaeZLCdyJimrApxRnysYKVNlTuakLLX4RCf9hmc2Lqnw0az2B2htZbiTLX39hJV5
         BYAPB3oUPUJ9zmA0vzY7pjucThptc+jh75zLKj/ZML4GXpEtKnBPka2d25VjTyFqTKKY
         RFocsx1y76mHxDnxHrPV97dFdIlzj+388bBOvAWnkNExqTFuvWyY7D183JYZR2P2wkt9
         c91Q==
X-Forwarded-Encrypted: i=1; AJvYcCWd5RQgvjkBhXTbfx82hhvw/Dvh8CjUn1NdDmcbqh6zUMZh9tTt+4zFwdpXqFXKdS4GD32pQwwRbUgEqnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6vvuTTJfdSeNtldaX2JzlA1jhwS+R2TsDiY2UPzz7k/qRtihY
	WHlACZ7ygdggFa/7Jgvk574jkYAqE/NiXv/cU58YTWOi0pFE5K1QXMgcNfHVuQ==
X-Gm-Gg: ASbGnctjEV39DubI8TvegfiUJTL3+FsGB1ifOSirBUzjzpNxUDn2wEs9LVjoEYzsVTM
	XeOVkglu1qn5z33UltYmDVupqvYysqX5+ybZ47g22WJ2LT5jFxy4VANGROJDz8IbrU+pcWh9/Jt
	jHuVgyplENcdrJHHfo/RWO94pbq1uWMTgFSSqJVVkyRj0pt4QE0FLk+H34WbditXE2GGFkwlaQ9
	ZxQLzT8/E5RYWJ2ZMwOEAebHGKa2DziF5srwnj8Ec61bLHQ2af1L5Kqjc69aZCrOhZp+iZ1HewZ
	nuFIruze4uQgbP+a0WnVIYrS
X-Google-Smtp-Source: AGHT+IG5fsWaqF4gOiWjJqQ6Ito5ITspaw7yFFwQpvPeXryHfu3kCm7Z8WMVNfAz6obym8tjtrdSCA==
X-Received: by 2002:a05:6102:942:b0:4ac:fe47:1bcf with SMTP id ada2fe7eead31-4addce7430cmr2745642137.24.1732268899126;
        Fri, 22 Nov 2024 01:48:19 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4653c47f124sm9282731cf.62.2024.11.22.01.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 01:48:18 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v2 0/7] ipu6: get rid of all the IS_ENABLED(CONFIG_ACPI)
Date: Fri, 22 Nov 2024 09:47:57 +0000
Message-Id: <20241122-fix-ipu-v2-0-bba65856e9ff@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE1TQGcC/2WMyw6CMBBFf4XM2jF0Unm48j8MC6wDzAJKptJoS
 P/dytbluffk7BBYhQNcix2UowTxSwY6FeCmfhkZ5ZkZqCRrDBEO8kZZN+xpYGrasmkrC9lelfN
 1lO5d5knCy+vnCEfzW/8b0aBBshXTxbpHXbubm9TPss1nryN0KaUvYJ5GEqEAAAA=
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
 acpica-devel@lists.linux.dev, Ricardo Ribalda <ribalda@chromium.org>, 
 kernel test robot <lkp@intel.com>
X-Mailer: b4 0.13.0

We want to be able to compile_test the ipu6 driver in situations with
!ACPI.

In order to do this we had to add some conditional #ifs, which lead to
false positives on the static analysers.

Let's implement some helpers when !ACPI in the acpi headers to make the
code more easier to maintain.

We can land the first patch of this series ASAP to fix the current
smatch warning.

To: Mauro Carvalho Chehab <mchehab@kernel.org>
To: Rafael J. Wysocki <rafael@kernel.org>
To: Len Brown <lenb@kernel.org>
To: Robert Moore <robert.moore@intel.com>
To: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-media@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-acpi@vger.kernel.org
Cc: acpica-devel@lists.linux.dev
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Changes in v2:
- Add helpers in acpi to avoid conditional compilation
- Link to v1: https://lore.kernel.org/r/20241122-fix-ipu-v1-1-246e254cb77c@chromium.org

---
Ricardo Ribalda (7):
      media: ipu-bridge: Fix warning when !ACPI
      ACPI: bus: implement for_each_acpi_dev_match when !ACPI
      ACPI: bus: implement acpi_get_physical_device_location when !ACPI
      ACPI: header: implement acpi_device_handle when !ACPI
      ACPI: bus: implement for_each_acpi_consumer_dev when !ACPI
      ACPI: bus: implement acpi_device_hid when !ACPI
      media: ipu-bridge: Remove unneeded conditional compilations

 drivers/media/pci/intel/ipu-bridge.c | 23 ++---------------------
 include/acpi/acpi_bus.h              | 16 +++++++++++++---
 include/linux/acpi.h                 |  1 +
 3 files changed, 16 insertions(+), 24 deletions(-)
---
base-commit: 72ad4ff638047bbbdf3232178fea4bec1f429319
change-id: 20241122-fix-ipu-a2fe28908964

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


