Return-Path: <linux-kernel+bounces-360582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 399BA999CE0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 08:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7948285A53
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 06:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826CD208997;
	Fri, 11 Oct 2024 06:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dUq6a/2k"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA9D19995E;
	Fri, 11 Oct 2024 06:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728629044; cv=none; b=P7zpSCKj8Hjwf/MjqSJTwfc7AUTmWwqLJKcdpoiMsoaVcQV6F8tj/KL68MAriV9b7gbOsFGIv0n1XQkyK3V7zLp1cms+igiqVykuTDmkuouhGTU16moSMdiHIuzwSXd2hR7oliulsJhvsevAbC4sFN48tHNZ3SwfVbbIDggsk6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728629044; c=relaxed/simple;
	bh=n+zxY4Rf474dyrGixT8wUjQqxiY6uFnLEoLhANImtyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KiFO4ju+TS7MKwQeT6+okiyfXWtaClxVd0d8rfg1h3LhX5NcxqbiU6tQ9vzAYmzJ9m78vlaIDBASGkaLE+QDZVrFPV85elN0ZrmkbuHjhP0i8sGr/sSIitbbQCBxf7t0QlVszqrrquZKIf1C4IYnKCLZVLnCOpr1Y+G4mNnhmrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dUq6a/2k; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71def715ebdso1196356b3a.2;
        Thu, 10 Oct 2024 23:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728629042; x=1729233842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2N/8TaScJ2RN0jgasqsAf8d391FaErzcf9On+L6fPbs=;
        b=dUq6a/2kgDluW5k9pIrn8i/QTFpgTOS8FNu0q8a/aC/URZPjYNx2rGeOo115IjVJ6L
         zLyMopA4+hP26+4i300nASFlpQpzn8KSy5xpHKV4EtjJ+c1ufGHceVNLo67DwwVi+AZC
         VAq2eFxUGZ+sNdNmkGk/NJ1lD2V0IvXVU3oKM6Jy909D5v7z2JpE8uvhsDIbXciTG1Ag
         PfJSXHXbxv4gQizXQoS/kyYORCWFluTXGXWLNI/aucC4tmcJ3YWUtLeKTKCuea2MnZli
         vbDDW5ltPYRc8J+pft2ENdm8Ba8YrPxq3tM5BrRTu1Ka0dAFqWuq8bKXSTPdskEkW8pB
         EOGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728629042; x=1729233842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2N/8TaScJ2RN0jgasqsAf8d391FaErzcf9On+L6fPbs=;
        b=D5ybj4efmeV8GvW1OPSxfTihX8m37zzxZSUPfBxLMain9gaB9reDVvcfPizMpgEoi0
         UQlkevcso3sP+A0dzOZufZNNnGqDmIkX8raUJpK+Y+PNY3XsnErZ3b8QJ1/FDaZ3HZKr
         /3lllwFHKWnn0RKER6DGtEKvjEom6/VogZ6W97gqzj81pTVwZNdR9cf1nte2a9jXKjoe
         w1eZj/9lDRdCbdIz3jlNnhhVBwutgQxKYyLazepS1fnWLW72Ebj/Q2knodCSBDM432+f
         xGAsMpgyrevnIPE+AP02jvVKKidYF7G42/FBu/NPJPE4FTioiN3FL0qHOuSXtgdKG8cB
         //ZA==
X-Forwarded-Encrypted: i=1; AJvYcCUAo/w+zFKs2Q44CWgUKTPvb69cEQyCW+JvDjmiaCuqEfIfcJILPKfchNzbLPYJc+yqmkkQSt6oCUuzs4zgULC1Pa2UQA==@vger.kernel.org, AJvYcCXfhHTzswNLYAshtE5oSzU02T1pyhpUMB4q5DRmo8288hR+JnnYHc856VM2r3OrjcpYFKttnP+6FOAaosQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcMFpOgdSa5m2a/uPw08iaBLyPMr3pVCgKsIvuCRrQt1uiX4A1
	F2TL9spEZYiQw6BkSVKwkobLvPVOUr8rMLmADKIIwUXxmJGBlQZgm35AKgjJ
X-Google-Smtp-Source: AGHT+IGwW8tc0uX5g0yRRAPz7XUMSxPjV/+DFCi123qYmSNFm87AILU+Ux5ulnPzTmx8cGZufFB7mA==
X-Received: by 2002:a05:6a21:4d8a:b0:1cf:2843:f798 with SMTP id adf61e73a8af0-1d8bcfc7fb6mr2516363637.47.1728629041635;
        Thu, 10 Oct 2024 23:44:01 -0700 (PDT)
Received: from localhost.localdomain (host95.181-12-202.telecom.net.ar. [181.12.202.95])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2aaba5d4sm2081980b3a.174.2024.10.10.23.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 23:44:01 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
To: kuurtb@gmail.com
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	W_Armin@gmx.de,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH v4 0/4] Dell AWCC platform_profile support
Date: Fri, 11 Oct 2024 03:43:37 -0300
Message-ID: <20241011064336.305795-2-kuurtb@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241007093324.49631-3-kuurtb@gmail.com>
References: <20241007093324.49631-3-kuurtb@gmail.com>
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

 Documentation/wmi/devices/alienware-wmi.rst | 364 ++++++++++++++++++
 drivers/platform/x86/dell/Kconfig           |   1 +
 drivers/platform/x86/dell/alienware-wmi.c   | 389 ++++++++++++++++----
 3 files changed, 678 insertions(+), 76 deletions(-)
 create mode 100644 Documentation/wmi/devices/alienware-wmi.rst

-- 
2.47.0


