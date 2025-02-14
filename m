Return-Path: <linux-kernel+bounces-515691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02716A367BD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 22:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCE29189806E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 21:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598DD1DC9B1;
	Fri, 14 Feb 2025 21:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IkFSI/lX"
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047CA1DC1A7;
	Fri, 14 Feb 2025 21:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739569547; cv=none; b=RLXCCK4j+M2Bsa/SGSB4L4Pf770JOsgQl/4uaCrDdUK0T7RvYMQojHcLx5tNPTW/mHNgOZkGuhVAhY/J5M5//WJZycZeXYhimTqyrH/VVizdnipj7p/inoxz5LP+nQFEtE76XPW/7YjMas4ereReRf029UsKc2HpObbiPnOyH14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739569547; c=relaxed/simple;
	bh=K+jPzZClWQRCZ7Cg40c+iZEKMCImjqYkWhHwSabsgz0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DL04z65KBCqEIot2+jWf8VTUHup0p5WOHtq414PXUPMIaaJj6MzMJUnWUjoTw5u7uvlEQIfsNYncdGpH9pMyZPN0zdwPsKByxLJVhn0DA7EZdAmhtA1GusaReh3/PNHj4zZc+FLuhFbGKZIqlmkrEFhMoMMaA5VRgpvIMKIotwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IkFSI/lX; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-51eb1818d4fso1607955e0c.1;
        Fri, 14 Feb 2025 13:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739569545; x=1740174345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1r1AabeSVH8zgNhUYDElr31NowXg/suEqQ5N2d2keR0=;
        b=IkFSI/lXz2/48X0ZUzLT3smU7tpDk5fhd4EHn5mLGOtcBfDbW0Qcaw0fHkcto30w3K
         T/o/pTv07RA7kfTbT6zXvUhpjmz/CiUeEY4/f62gfVJfJKxyB/RJTfF4Nv6NHCVdI5bR
         yU2oTjo792aZwDOjlJT+FVP6sGJYhsW9d+xentYgquQU5U0TrHtQxvjguaAD49+lFfMH
         GidRzSk+j03vaKNj/C0W7iFN1s7yF6keBsEL5/+2GqKTvuCNx1XqwjDhbR/jZtwCa+fN
         GGmc0EXP7AQ9y6iKUheksdYmyqj4DTQAn+uM9CAQUsofAl43UO2fnoF/tZzVg3uo6Bwg
         zBaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739569545; x=1740174345;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1r1AabeSVH8zgNhUYDElr31NowXg/suEqQ5N2d2keR0=;
        b=jeNBagG3ruh00qWsO5Q/wIuoKaoe6F6osZNQ/MzKBymxlqjTOiuLHy9+QrLMV4guyb
         5Ue7RvODzLfIiJjXyhTB/VGGmTL3ZEu2A6Kca+UHRHqeIQy0LRqC2Cu1IcIdrjU4jutv
         ayIrbDhj1LkeoJn0lIRQe0tRC0+Yi2aAwU3y9H8TCYcpXPIoiQDae+hdK3nbgciw0/bs
         3XqgAb5K9H2MHsLH5+MNG+ubbhfdy72ooV/m/JQt6CuMrwwArqseESdVtjkhJeubRCNB
         kDkc0ege46M4qRoiH5kzQmBSI21kvaVLpmELUj7zvREWXj2DXg9LY2KyxxOCeD6rSKR5
         dQsQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1JNSkovF+kHY/kLfLjaXsUEo1b/eTJxzhuWT2C48/Egw9kdR8SqANltXEz4te/4Q9/LXrEb1egERaYIg=@vger.kernel.org, AJvYcCX2KTgzbsMBcGhh5t9W/NmhzvtpoFAqMGq1O1kowJR+u0FjEasRcXI72KNz4ZNA/yCCul+pyc5rQ8pyTYoXufdz7JptjA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyEN+QGdnt7nHP+TSteo6VRbQkN4jcejgcXGbT1A3plpjfLEMXf
	0Wt3Lx2MWjThilfhp2u3EjWJTkiMDFUtGbp6mfdKNYQu5cbIx/n3
X-Gm-Gg: ASbGncv5yxU6jHw4tR1820w2lI9I/cLBkzDIhHi/fUsxwrD7GshuMH/aNx3vIC2oUGB
	J+FFhJv7m+ppglr3KNgArm49RqXXJI4Rz7BaovdEkLc8HZbjENw4i5MIJMbGBWT8uFErgtNHb1U
	HVRHrIONdF5DRaC+rKJMmxBzNZLJidbyw+p9FjCH8fkKqv+ydlNDJqOlw9b7HJSlqwBwuEBAybe
	spe9s1SLEvz4a68evM02ZLB5ohQcJQaEVGlspIaonCFtGSoeaNEtgnGsL3OULwn9H76IOpwowAz
	PD71/sydwOZLiNIuDfcn/gU=
X-Google-Smtp-Source: AGHT+IHD3FQ1gBJA2FMr9qmhFIqFOfi1bONU1DURUotV9p6bU8NSF+t5Y/x+Z9Jz9EHhB4SCgiVYqw==
X-Received: by 2002:a05:6122:2525:b0:520:4996:7cf2 with SMTP id 71dfb90a1353d-5209dd874bamr638775e0c.10.1739569544796;
        Fri, 14 Feb 2025 13:45:44 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5207aa64476sm873819e0c.17.2025.02.14.13.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 13:45:44 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Dell.Client.Kernel@dell.com,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	Kurt Borja <kuurtb@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH] platform/x86: dell: Use *-y instead of *-objs in Makefile
Date: Fri, 14 Feb 2025 16:45:35 -0500
Message-ID: <20250214214535.4947-1-kuurtb@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `objs` suffix is reserved for user-space tools. Use the `y` suffix
instead, which is usually used for kernel drivers.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
Hi all,

I based this patch on top of the for-next branch.

Ilpo, if you prefer this patch to be based on top of the fixes branch,
let me know. I'd submit two separate patches, one for alienware-wmi, on
top of the for-next branch and one for the other drivers, on top of
fixes.

~ Kurt

 drivers/platform/x86/dell/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/dell/Makefile b/drivers/platform/x86/dell/Makefile
index 8ac9a933c770..c7501c25e627 100644
--- a/drivers/platform/x86/dell/Makefile
+++ b/drivers/platform/x86/dell/Makefile
@@ -5,7 +5,7 @@
 #
 
 obj-$(CONFIG_ALIENWARE_WMI)			+= alienware-wmi.o
-alienware-wmi-objs				:= alienware-wmi-base.o
+alienware-wmi-y					:= alienware-wmi-base.o
 alienware-wmi-$(CONFIG_ALIENWARE_WMI_LEGACY)	+= alienware-wmi-legacy.o
 alienware-wmi-$(CONFIG_ALIENWARE_WMI_WMAX)	+= alienware-wmi-wmax.o
 obj-$(CONFIG_DCDBAS)				+= dcdbas.o
@@ -14,14 +14,14 @@ obj-$(CONFIG_DELL_RBTN)				+= dell-rbtn.o
 obj-$(CONFIG_DELL_RBU)				+= dell_rbu.o
 obj-$(CONFIG_DELL_PC)				+= dell-pc.o
 obj-$(CONFIG_DELL_SMBIOS)			+= dell-smbios.o
-dell-smbios-objs				:= dell-smbios-base.o
+dell-smbios-y					:= dell-smbios-base.o
 dell-smbios-$(CONFIG_DELL_SMBIOS_WMI)		+= dell-smbios-wmi.o
 dell-smbios-$(CONFIG_DELL_SMBIOS_SMM)		+= dell-smbios-smm.o
 obj-$(CONFIG_DELL_SMO8800)			+= dell-smo8800.o
 obj-$(CONFIG_DELL_SMO8800)			+= dell-lis3lv02d.o
 obj-$(CONFIG_DELL_UART_BACKLIGHT)		+= dell-uart-backlight.o
 obj-$(CONFIG_DELL_WMI)				+= dell-wmi.o
-dell-wmi-objs					:= dell-wmi-base.o
+dell-wmi-y					:= dell-wmi-base.o
 dell-wmi-$(CONFIG_DELL_WMI_PRIVACY)		+= dell-wmi-privacy.o
 obj-$(CONFIG_DELL_WMI_AIO)			+= dell-wmi-aio.o
 obj-$(CONFIG_DELL_WMI_DESCRIPTOR)		+= dell-wmi-descriptor.o

base-commit: d497c47481f8e8f13e3191c9a707ed942d3bb3d7
-- 
2.48.1


