Return-Path: <linux-kernel+bounces-387061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D059B4B51
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 14:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3BE0284F16
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 13:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DF520607F;
	Tue, 29 Oct 2024 13:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C7EVde6K"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48412205ADA;
	Tue, 29 Oct 2024 13:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730209885; cv=none; b=B6TmVoRA6DUjHbZfLqBGTey2yr2xMN1pvM8xr5Q6ZpDg3X77w5O8pV8ikTtAUm2lLKGiQRCTlYDtCUI53YwK5UslFE3FxhhPA4eGQk0zo2c8fjaLHtUCtPDVuuH0DAfDgp9fSdhYUM3QSKHp+S0H/zkWIdNjR2JwSXQSU1/cc2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730209885; c=relaxed/simple;
	bh=6fIXkY1nsYTr4QPhh8Jy4/EcIWVNw33Gak8V8LCjqMU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HsKqCwJpNHnRAtaYM3NpTQXs3CeHtrabyQ69QKL1hGdBDUb6bNeu41B53bTy5qB4FRoIznDoThw3rFE+zkwJt8IX9zvhdNDArQcIUGOp+NczsG8ji1oYl17qv0zp1xzv/nPp8uD3ELf9EMPWLHi9i414uBNZ+rjJ5FnKHaWXdM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C7EVde6K; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-656d8b346d2so3659866a12.2;
        Tue, 29 Oct 2024 06:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730209882; x=1730814682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TQ4Bw20wgJNY0fJsA2FYSPxhSRd3cXno8+ZSPH/YSvo=;
        b=C7EVde6KuShtNtVIHhjmexGegy6Wgh+SpOxcWx2clows9oIjNUNaIrEvRGOIIbdWtZ
         vUfs496uojqlAasj5l5Ozlg8Vygoy0lyQ8llMzJHNvrGVDY0B3019LtvpMmtXu4cKzqb
         ni0WBC+Wp3HCgCViivL0fEnfq+OErWB+Fbb3xzPJF+nBZGfIMt1qdegAsz4e0Jsnpu5C
         xa1jkmor4SjEw9CDiiDpE3HJNADJ+ZI2FKAlYl32+i+iMEQrz/WaB4OnbcOtI+BVGF7b
         rA9rUmRojsyKnyQastvg6KKomTzhNzuBY57HqmIIyXEf2S8+QqEpdL8HKxOW5WHNCKru
         eIUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730209882; x=1730814682;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TQ4Bw20wgJNY0fJsA2FYSPxhSRd3cXno8+ZSPH/YSvo=;
        b=vbQSUU21mu/q/vzv8GacpWnBNNEWiLy5pAJKxHdlrt94/l/rr7oxET/DwEDwPP0lGK
         3nWSbmCjKbNzsPpdpn0xmUr5Ux2wtLvg8QKvyYMHHHoHcqnmC/Trsc4zoDrL7fxotZMk
         owGzoLGP8LYDcgudeZme8ShZVFb9v14OfFYFuRTogwQfVT2wV45BPm3JLgPgBXXPLqjb
         GFpKLUhSRsBVUKwqEsxrTBVYpXmfWezNNymyQrFR6UjGH3xKU77rP+CU851Y14Sr+Try
         Wn5FzXpFCEiO/ArEaS5BW8H6e/hJKN9NGg4BjmXfbmt0Qwc/uQkbdvE37DkEhaIa79UH
         lcpA==
X-Forwarded-Encrypted: i=1; AJvYcCU4dA9LLVO5JpulJKMHBJjxi6uNsg41T9FLMl55lTl9dui+nC73pa1v520Fqe26IgpwkgJNiqxvnYvSctqay6Yj5Dqeiw==@vger.kernel.org, AJvYcCWFKi3eR/sv+HPs/A4B0FheTyCoM48U4CFrvsdZYPZwgQh6DgiFtAY7JIpEo5muEeVrjVgRnt5t62h1CDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvN9QKkSudVWZwwBLiueInwS0ug1Mzl01y7tXwizdlh9o6scql
	sUY6mDWZQav4xzIB56nVWlpdOpqGs6JOjDFr7nOEkipRiS/5WNp4
X-Google-Smtp-Source: AGHT+IEU0ZRWC7zFl5d+3Q8Tj0jYMBwQEHDtda+HXmbcjUSCGYXK31BXcdbO/OEqPxbzv+jw5XAppg==
X-Received: by 2002:a05:6a21:1690:b0:1d2:f124:a1cb with SMTP id adf61e73a8af0-1d9a83a63c5mr16656710637.9.1730209882530;
        Tue, 29 Oct 2024 06:51:22 -0700 (PDT)
Received: from localhost.localdomain (host95.181-12-202.telecom.net.ar. [181.12.202.95])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a1f61bsm7761132b3a.144.2024.10.29.06.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 06:51:21 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
To: kuurtb@gmail.com
Cc: W_Armin@gmx.de,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH v10 0/5] Dell AWCC platform_profile support
Date: Tue, 29 Oct 2024 10:51:08 -0300
Message-ID: <20241029135107.5582-2-kuurtb@gmail.com>
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
v10:
 - `thermal` and `gmode` quirks are now manually selected because some
   models with the WMAX interface don't have the necessary thermal
   methods.
 - Added force_platform_profile and force_gmode patch for a better user
   experience
v9:
 - Minor changes on patch 3/4
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

Kurt Borja (5):
  alienware-wmi: fixed indentation and clean up
  alienware-wmi: alienware_wmax_command() is now input size agnostic
  alienware-wmi: added platform profile support
  alienware-wmi: added force module parameters
  alienware-wmi: WMAX interface documentation

 Documentation/wmi/devices/alienware-wmi.rst | 388 ++++++++++++++++
 MAINTAINERS                                 |   1 +
 drivers/platform/x86/dell/Kconfig           |   1 +
 drivers/platform/x86/dell/alienware-wmi.c   | 477 ++++++++++++++++----
 4 files changed, 791 insertions(+), 76 deletions(-)
 create mode 100644 Documentation/wmi/devices/alienware-wmi.rst

-- 
2.47.0


