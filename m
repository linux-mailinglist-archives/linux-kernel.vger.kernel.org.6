Return-Path: <linux-kernel+bounces-380851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 323F39AF6EE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 03:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBBEC1F2295A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 01:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652B945009;
	Fri, 25 Oct 2024 01:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mhOYe+ky"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3711173F;
	Fri, 25 Oct 2024 01:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729820357; cv=none; b=aLnCKcOEi9vhecVZejGi0Y3P7pvIXR4ivHR9si1HjXh0hD7KZ1jEMQ/5uiBmTSp7fW+GbUbv2lJJDED+ttYImA3JU72+3ieREfWyW0ZZcUspRzi5SxMojZT7Pf88ks9uNSK1pi73JR7q/67vwuYkQ83sU5yzxO2hGOQrt3Re9WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729820357; c=relaxed/simple;
	bh=MWD6xrVE76U25/D9XmLYC3i3s+hR6lHJmgwBuSibn1o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YxGIOKcXEJ0qLecq+p4YQ/5ospHp0sFane89rkZQZo3jqXRTvEczZJlDx4SgNxqKIBfFIgtDm0deFJ2+bgWROXwGk4o7t2mXBw2gWbs4Eou4PAp9QysGvs7QKhwBt+BFVMUc3bkd5Hz8/XrUktCz/9TXrG/02tkMS3jHiiCug04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mhOYe+ky; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71e93d551a3so1103304b3a.1;
        Thu, 24 Oct 2024 18:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729820355; x=1730425155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mYnD3ml2ldfmwD1lxKH73BM8pCdVtdACHlhM+jRAINw=;
        b=mhOYe+kyc1crTWovPcx6bogPSiC/Oxzrg+5tER206z50QRQEO5rtYoHB6ytQ/ihqtF
         d1dC2/gRsdpYXMh/3D2oYBRtQciNfTjR0p9mDT+FYJTnsfVBRwk/qDlZG89/vm3jHt2b
         7/jZNs+ZqQvJVKNIjye5r3X4lkMUn+1lVk/JIRZuOQkdSJp6AkTrs4agEd9Kqj0LBIz4
         Wrq4Wsk7LclomPRZcREuF1C4xFsVbSNoyYUXehuNEbQyw3y1o1JBwhLurvYi6BGDaoGm
         Zz18hWD5nfEZcGFOcum+jr7xxAy4T9u+365+VtO7d+tXXk+Ed2+Zda0+4+X2F5RbVzRH
         rWLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729820355; x=1730425155;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mYnD3ml2ldfmwD1lxKH73BM8pCdVtdACHlhM+jRAINw=;
        b=SPtRPiJ31PW7LZYoXDquVIqEmugnXcCXJpxyR8OL0IaUYgExJqpoOJpLicDNPafqXo
         fDOJbrvzWWlbMDWmxxwFXo4mSKH+fGYoeqi3IyhLEYPxmgsyTu4OAb2cBia9YN4/wXJd
         WsLANtQ0ZBWYREuLGX37T+OBi8VBBS9KM3NX2xvbLObkCjd6jvrUTNRTbgV7bkDsNQqC
         4s9dMPYCrB4aByazomZine2qS9+hNQ7zBpzKKhkLtTDE2N6iLf45Ekt0YaoPBvuYoB1R
         uipfrcNJ9Ew5QolTtN9r3YcMiusTKe9IxFoEteWBDt6cDI/KJU6AMxnjI6LGOKLra8is
         2CoA==
X-Forwarded-Encrypted: i=1; AJvYcCUER753WSgybAb/Gqs9jPaIU8/YbIC7to2S53rqvWJ+n3tpliF5+zf6KzgVpc38h4V4XhNemDMEUhUP6/W72aDNG8XuJA==@vger.kernel.org, AJvYcCWrJK0FVgYa3ZYvMd+PZgIsCgqSKSFx0tbxsJpztalw2qYNb7s6q6+sxzOKcWcNqKTRBY3zfruDefVlQKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YydhLnWqzc3pNZ05P8nW+I6WanqknI1KRk5twMpTLew4se8ZSpx
	XDTQ7Z+kQJk2Gmld7O5DrLoxskrHS6Xr8wLu1yz0Xdtm5v1cXT4Y
X-Google-Smtp-Source: AGHT+IFoy9+pJJlj+/1zvTFpYCfrmkT6FHiktlZNcmBFlbaqh9eVWnMIA7KxjAsSDHsZg+kH8yyzIQ==
X-Received: by 2002:a05:6a00:4f90:b0:71d:f64d:ec60 with SMTP id d2e1a72fcca58-72030babcb0mr11467886b3a.7.1729820355119;
        Thu, 24 Oct 2024 18:39:15 -0700 (PDT)
Received: from localhost.localdomain (host95.181-12-202.telecom.net.ar. [181.12.202.95])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a1fe82sm72245b3a.164.2024.10.24.18.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 18:39:14 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
To: kuurtb@gmail.com
Cc: W_Armin@gmx.de,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH v8 0/4] Dell AWCC platform_profile support
Date: Thu, 24 Oct 2024 22:38:57 -0300
Message-ID: <20241025013856.4729-2-kuurtb@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds platform_profile support for Dell devices which implement
WMAX thermal interface, that are meant to be controlled by Alienware Command
Center (AWCC). These devices may include newer Alienware M-Series, Alienware
X-Series and Dell's G-Series.

Tested on an Alienware x15 R1.
---
v8:
 - Aesthetic and readibility fixes on patch 3/4
 - Better commit message for patch 3/4
v7:
 - Platform profile implementation refactored in order to efficently
   autodetect available thermal profiles
 - Added GameShiftStatus method to documentation
 - Implemented GameShiftStatus switch for devices that support it 
v6:
 - Removed quirk thermal_ustt.
 - Now quirk thermal can take canonical thermal profile _tables_ defined
   in enum WMAX_THERMAL_TABLES
 - Added autodetect_thermal_profile
 - Proper removal of thermal profile
v5:
 - Better commit messages
 - insize renamed to in_size in alienware_wmax_command() to match other
   arguments.
 - Kudos in documentation now at the end of the file
v4:
 - Fixed indentation on previous code
 - Removed unnecessary (acpi_size) and (u32 *) casts
 - Return -EIO on ACPI_FAILURE
 - Appropiate prefixes given to macros
 - 0xFFFFFFFF named WMAX_FAILURE_CODE
 - Added support for a new set of thermal codes. Old ones now have USTT
   in their names
 - A new quirk has been added to differantiate between the two sets.
   thermal and thermal_ustt are mutually exclusive
 - Added documentation for WMAX interface
v3:
 - Removed extra empty line
 - 0x0B named WMAX_ARG_GET_CURRENT_PROF
 - Removed casts to the same type on functions added in this patch
 - Thermal profile to WMAX argument is now an static function and makes
   use of in-built kernel macros
 - Platform profile is now removed only if it was created first
 - create_platform_profile is now create_thermal_profile to avoid
   confusion
 - profile_get and profile_set functions renamed too to match the above
v2:
 - Moved functionality to alienware-wmi driver
 - Added thermal and gmode quirks to add support based on dmi match
 - Performance profile is now GMODE for devices that support it
 - alienware_wmax_command now is insize agnostic to support new thermal
   methods

Kurt Borja (4):
  alienware-wmi: fixed indentation and clean up
  alienware-wmi: alienware_wmax_command() is now input size agnostic
  alienware-wmi: added platform profile support
  alienware-wmi: WMAX interface documentation

 Documentation/wmi/devices/alienware-wmi.rst | 388 ++++++++++++++++++
 MAINTAINERS                                 |   1 +
 drivers/platform/x86/dell/Kconfig           |   1 +
 drivers/platform/x86/dell/alienware-wmi.c   | 433 ++++++++++++++++----
 4 files changed, 747 insertions(+), 76 deletions(-)
 create mode 100644 Documentation/wmi/devices/alienware-wmi.rst

-- 
2.47.0


