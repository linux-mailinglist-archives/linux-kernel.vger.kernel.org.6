Return-Path: <linux-kernel+bounces-369391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD2D9A1CBD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 10:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D3ED1C27288
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 08:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B1D1D0BAE;
	Thu, 17 Oct 2024 08:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DbV6XEub"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB1E762EB;
	Thu, 17 Oct 2024 08:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729152756; cv=none; b=RVBHp82WcdR1tneK8oYOzg9bv9KI+MPTZFHEDJc3pPuV7MxiBH/dUHhOHNjP4sCUtgIZ5H8xFWDJ9bGTGnV8eVTzrxkRciUaWoDGBqW2bAIed0Qh1sor/1MWCk06DPvYRb3uQxycCQQ2Nf11O9U3qIIQlV8slz8SZmLGWlGpvXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729152756; c=relaxed/simple;
	bh=hGD4gXgTNGefn4kpiO1XAx3iwk0yVuHMM6fybFEKedc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t7EuqCa0KYNoHnoti9+wwB31ovyUqtoZZTesGHBA15Ifpwxwiz/frNx0YHEgH6/iW4WkapYEKwlwNrlyX6wEqCTQnGb75fRGJRRevjPyTf9Rbc+SM9yPgC2ldXByU3Xg40a6p+1XDJTMESBE1r5EMun0frQ52mogOlJ3/CZBrkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DbV6XEub; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71e3fce4a60so434295b3a.0;
        Thu, 17 Oct 2024 01:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729152755; x=1729757555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=djuuMRbAeAhXPdxEVOQW60yT/L5xeu0t0likGb1ze1c=;
        b=DbV6XEubGhJyITQl4zbGxL9lKCuYJI/PuyHk8BgRCEG9ptsgowil8Pk/rMRwvbq8Kl
         fP4JTfFgSEsOvc2L5E6yuJN2sBXZ4YISOVf5we9o9y4s93G7jGte/5pKeHq08lB0ntXT
         3Rk59nEi2Vt6GP6M7QVKF18N3uQh0IZNjTZjG0QCHPQ2PA/EoC9i4rck1KB0XC3ooDR0
         Y52eMYDyAyrw+XJcms5KS/IBwVyXgvSypySLEI2qkeTv0OJ7CuJ08gUionzw15duVSxH
         zsOeosJNmzFuKtEKhAb2iWgHIQO1LIT4S+su3ijRMK+d0cSqo+M1Z4pBMbf2gmxtEHx4
         tV0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729152755; x=1729757555;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=djuuMRbAeAhXPdxEVOQW60yT/L5xeu0t0likGb1ze1c=;
        b=dCk2mObE6+UCkU3G4zX8jwf/aRnI9CnPiZBtQo9DTQFh4EzpshEtakBeXxjkCwh+GP
         L2DMxjAMHJLy1yZbVf07QuvDGmlKYN27CfScAKQljX8ClITt2Fp485wseLhRalrD3WcP
         tozIApHqaJ/P9jhINtDxCv22U+6GCW7U4551E+tbwJBrNkvDrk12BebGybGjRKqIuvjt
         PY9H8+e/Owg3j6F2w3dy/IJGVVpqnOlAHtJcqoDIxrb0X+LwggFUQcvg+ev4Ac0dS5jX
         aR/aaLgvHQfNPj0iptAihoczbcDytwfuv/ypN86agF+C4PZl5lh1KPY6Te+3mhwVDQGi
         Ynog==
X-Forwarded-Encrypted: i=1; AJvYcCVn2bww0n0AfDaC040EqrTtfVkvU06XX8RkCelspIWeJjBChrZcjMRwcF06OOl6x1cbOwHmLbkRYbJby30=@vger.kernel.org, AJvYcCX8A8BGYDjMzKBCvWCRUo8ZjXr5MIgzwgkDI0EPg167vD+JFFtFPigum1zTnYB4i70nVsiEwpH/+lrw0IdUBC4klMxHhA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwuqMQ7mLlTktE0TZDTd5d2ovopu5vL19VwNMpuKDYrYY13yM0l
	qNDlLAoQK0Qyg+Tk0yugNr0PG6qstgNDXr1eZoK/WpAWG6As2ez3
X-Google-Smtp-Source: AGHT+IFKYmPHX2E0pk5pWo7LerZQeothFFsM1MeCD7usLzrRq/mNOK7d4123bETmjhf2bt/74NPHtg==
X-Received: by 2002:a05:6a00:22c9:b0:71e:7b8a:5953 with SMTP id d2e1a72fcca58-71e7db094e1mr10053458b3a.24.1729152754578;
        Thu, 17 Oct 2024 01:12:34 -0700 (PDT)
Received: from localhost.localdomain (host95.181-12-202.telecom.net.ar. [181.12.202.95])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e77394ca3sm4221366b3a.49.2024.10.17.01.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 01:12:34 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
To: kuurtb@gmail.com
Cc: hdegoede@redhat.com,
	W_Armin@gmx.de,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH v6 0/5] Dell AWCC platform_profile support
Date: Thu, 17 Oct 2024 05:12:12 -0300
Message-ID: <20241017081211.126214-2-kuurtb@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds platform_profile support for Dell devices which implement
User Selectable Thermal Tables (USTT) that are meant to be controlled by
Alienware Command Center (AWCC). These devices may include newer Alienware
M-Series, Alienware X-Series and Dell's G-Series. This patch, was tested
by me on an Alienware x15 R1.

---
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

Kurt Borja (5):
  alienware-wmi: fixed indentation and clean up
  alienware-wmi: alienware_wmax_command() is now input size agnostic
  alienware-wmi: added platform profile support
  alienware-wmi: added autodetect_thermal_profile for devices with
    quirk_unknown
  alienware-wmi: WMAX interface documentation

 Documentation/wmi/devices/alienware-wmi.rst | 366 ++++++++++++++++
 MAINTAINERS                                 |   1 +
 drivers/platform/x86/dell/Kconfig           |   1 +
 drivers/platform/x86/dell/alienware-wmi.c   | 446 ++++++++++++++++----
 4 files changed, 738 insertions(+), 76 deletions(-)
 create mode 100644 Documentation/wmi/devices/alienware-wmi.rst

-- 
2.47.0


