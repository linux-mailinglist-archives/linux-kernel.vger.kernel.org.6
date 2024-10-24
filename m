Return-Path: <linux-kernel+bounces-379240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8224E9ADBEE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 08:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A84E9B23092
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 06:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3141A17836B;
	Thu, 24 Oct 2024 06:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KD4bJpSS"
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980481662E8;
	Thu, 24 Oct 2024 06:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729750600; cv=none; b=p1VA0STWIhOdTDS3yKv0qcGTLa4eFmrpf3UjDrPHR6iRIvJK4vAAnL/iie8mgv+cOjD7IWvWtbuF91Ldtd8tS8yfkIGm4xf/hOgX8AK90HUkr1nkGTezz9p/A5CD5JlaCzFDszMNUwoupEZfZyt8LDDZv6Mz9I8n+X+9GwBhkzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729750600; c=relaxed/simple;
	bh=Rz9gcIh2T984d6q4XYRRs9ihe2oBjbaS4KKpRfQZtcM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=abMEJZRl69BDD/Px2COgXO7UYXyyjeR/Ni/Xb5PSdcFT6sTXR0PBqU8bWUGlCPLt4W9Pye6A9sRS5MWjGiJXHtV01bqqowsnVJ6hqFD9+r/NfBzCKHweLt3TWpdJDLLW/yCC+48cdEvdujicQCV/IkNYp2g4p4uaNDmfFY7Z9pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KD4bJpSS; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-288a90e4394so309265fac.0;
        Wed, 23 Oct 2024 23:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729750598; x=1730355398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rhU89+FS6LG/pnvMPb4jHbxWWyR3TKaTBd3ILGa9E0A=;
        b=KD4bJpSS7sGrcJZ6nHMzl7l2jQsNmHcLfadUmvBoY4/kTNmrQEfhjZ4L3SMEJX8vCK
         0RNWQ4APN2dAC0KJBCuW09WyJH+hSQBeSTGWsB/rotofUiKK3BRzxWE2lr5lcITaNjWD
         e5OFUe02575VIxG38KrxmGPwrdnntMY6efMWmy/pBX6Dtm0nf3+xZoZAwqJJt9VGAP99
         FRJIy6SRQ8kQa2ehO+BNxn6NGYpjMy3YkLfGxbpVxuc5125EkjZ7M6YvcEkl9hjROYWD
         uNdxuM61RQGhtojJ6k+EWxSTwOSM9yyrmPP/8TfADTqyrI9Vp96qQlNSl9ohBkskhICu
         fbEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729750598; x=1730355398;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rhU89+FS6LG/pnvMPb4jHbxWWyR3TKaTBd3ILGa9E0A=;
        b=nIemKcJ4SqgQe4PuFSLiZb7Xb+ygwd6e0YGQYSsUbp9bDHGEWd0ma3av0KIQ3UOQnq
         wjQe+sckCQnVHmCm7AZX18+LSqmr+BPJGeJdLiNuN2AM+6pzG3VV0VOj3QF0cXF5XHF3
         N66CAuJyG0QNotWXfRp3DdtCzx96EKGwjr4xtn/Y2V5FK4ecL0edd1HABsoGlFQ2HA8C
         1ts7gdi0hC8k9JpV8hxSsutXOOFpzKjfMV1g5Uc0TNqj2S3POjjcYXhd5YdrsCXyOUBJ
         K1CYhhLTI5rWY+ABnqKz2LghG7unrbwJ5U+oREO5xMBBz+E427FUzwy/S9kwIiuzIHRC
         RjjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwVpMVC1KPqUaJ2YxxsEajOix5hnFmrNoxnTzod5jU3qApyyoP3yrgp61O6HvGjurxhO+4722Itf1CZgc=@vger.kernel.org, AJvYcCXzNTNg2GTchadv+M9S9IyXMdmusKikoyfrRXnNfNQLtaOlTSy50d6egrxBxVoRww5iHCeS3yrrH5cDdB54L3WUWlzmEA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwhRAMTmx/KmDAUPUzuORKXw02JkqlZF+t94Gzo5Ull0YcKYxSB
	o3SfgWy84l5CWwnDlvRbLXDDsikT+jz8toC2DRznVl1MUbgFfinI
X-Google-Smtp-Source: AGHT+IGxyiC1qiHDctfXP/glrz7aFXuDsu2S/QxjXUI4biGmtqSSqvBVqvlllwt5i8Np2wF+tqpdHw==
X-Received: by 2002:a05:6870:15d0:b0:288:49a5:7562 with SMTP id 586e51a60fabf-28ccb73b52dmr4751102fac.41.1729750597589;
        Wed, 23 Oct 2024 23:16:37 -0700 (PDT)
Received: from localhost.localdomain (host95.181-12-202.telecom.net.ar. [181.12.202.95])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec1313988sm7297063b3a.22.2024.10.23.23.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 23:16:37 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
To: kuurtb@gmail.com
Cc: W_Armin@gmx.de,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH v7 0/4] Dell AWCC platform_profile support
Date: Thu, 24 Oct 2024 03:15:48 -0300
Message-ID: <20241024061547.33918-2-kuurtb@gmail.com>
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

 Documentation/wmi/devices/alienware-wmi.rst | 378 +++++++++++++++++
 MAINTAINERS                                 |   1 +
 drivers/platform/x86/dell/Kconfig           |   1 +
 drivers/platform/x86/dell/alienware-wmi.c   | 435 ++++++++++++++++----
 4 files changed, 739 insertions(+), 76 deletions(-)
 create mode 100644 Documentation/wmi/devices/alienware-wmi.rst

-- 
2.47.0


