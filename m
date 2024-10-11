Return-Path: <linux-kernel+bounces-360578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FCAF999CD5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 08:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4685A1C224D1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 06:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874B320898E;
	Fri, 11 Oct 2024 06:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TwOFHQkE"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B88199FB9;
	Fri, 11 Oct 2024 06:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728628850; cv=none; b=WMfMjXvTKspm9hwPvwy6DHFXCgotwq4LQTON4n2KaF+b+otpdTWrc+h5946OQfqet70b7hTj5rbN93lJGGxP5bg6MMLdla4Lx5Bo4x1D+ZoUawZ2wBhN2GC63Z5eZ0QjFlhVhBe4TAu/8qB8i9h1wMEnIlYuLagntPNFRDVIQgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728628850; c=relaxed/simple;
	bh=n+zxY4Rf474dyrGixT8wUjQqxiY6uFnLEoLhANImtyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EPEQsAkx/du8cnuodYijyxwbYm6rqzbRd+tPbGwoZFhmqwAkDf5Wi6L8pGqJkguJQ1/Kk3D/4B7pmtP6CZ7hMI6m0/1PAqUSmdM1pb4M9zLwsJhutPTMYs0ZeW9yT5VzAtMac8BIJKaK4E6C4zFADSPlQVmmWfaUqCtIZiHSa6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TwOFHQkE; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71e038f3835so1648117b3a.0;
        Thu, 10 Oct 2024 23:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728628848; x=1729233648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2N/8TaScJ2RN0jgasqsAf8d391FaErzcf9On+L6fPbs=;
        b=TwOFHQkEpfQfEIVqwv3UC9on0ZlVW7u3Dw920iqp7a8O6s1Uj5aGLy5gEUHQF50Dkb
         +4EFY4y29L/Ud1EjFE1litliAVYFAQisAqWeF2YkWt1v6svfJKxb1mTFEMLGpiORpzCn
         ot1dspbEZR/x0qiGqL38VLiG6XEsw+GwQWhwlBCy1tlZCveQzzdhEDdJeDOIW4BnQf5l
         WU5/H6nmjATsFFyoPUpoCGAIyHzqg4e6Kb8ftzqlqxBQNAzg3bo2MLUEB7iByK5byR4V
         pG6jBIDjTs82u+KMMlYz//Hx6QGfCZEHzZk7hE4zaZZ/bBQmpOoX6qyTavVa/wYguRtf
         Gxkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728628848; x=1729233648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2N/8TaScJ2RN0jgasqsAf8d391FaErzcf9On+L6fPbs=;
        b=ep3mHT+lJTSm96C6ZFAS9gxlOJCMyHruZ1kRqrT/wWStcEcgaV4ZJtsOjXSYXRrC1C
         Sozk5D/rZG57judrSL9AoS5WEHCoUx5vP4KB5vLAnNVFExenguTKDZRhdIRUR2QLtFtG
         RccFTUVHo8UnO+E/IDZilvOe0IvE3kwFjg2K75NyzqILGCIbqmyPEz8hOQviecVZ3g/9
         AWHWqrL9+QuMus4UN+gC4FVtQdz+6g3UAYBhlps8ZkNciTjyy60VPRyNXwJnh/2TvFZZ
         2fqBxqH55ee2wehCfCVj8RPz4fUKEWddUHx3ryUTpJgrBFi9NSa3h65g0+EBz7iDvKp/
         um7Q==
X-Forwarded-Encrypted: i=1; AJvYcCULgiQ4Abv8Cke1taMfh7lnsu2rkaDwoPIHy6PLjj9/AWhB0Kv/Sc/nULolqtTgLWugabpg0Cs28c6B2l0=@vger.kernel.org, AJvYcCWSzmZhqD2MIUTqrqA4Eno/BVo0Mk6itbNDS2tAutJS+CVcglC1mPzNWijW9YUz2oWmYyPG0mAQDeFnEZS77PCq1/auhg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzlGmDDoKb6s5o0XXBvrwCFnzJaMx75+WkNnEcU+tord3eFBGAP
	whbQN0qjF0VA+uBGJPxuGZof2//2Jr4/x0YAnuekdQ6N0SxtcDXA
X-Google-Smtp-Source: AGHT+IGJDSygOGHJgJcC4TgrH1GjS9gF5Lat4fZCtP6snV9njgB/bIlLoYLauuo3zpIykRB4RROTJg==
X-Received: by 2002:aa7:8883:0:b0:71d:fad0:df28 with SMTP id d2e1a72fcca58-71e37e4be43mr2430573b3a.8.1728628847734;
        Thu, 10 Oct 2024 23:40:47 -0700 (PDT)
Received: from localhost.localdomain (host95.181-12-202.telecom.net.ar. [181.12.202.95])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2ab0fcf4sm2013501b3a.219.2024.10.10.23.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 23:40:47 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
To: kuurtb@gmail.com
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	W_Armin@gmx.de,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH 0/4] Dell AWCC platform_profile support
Date: Fri, 11 Oct 2024 03:40:06 -0300
Message-ID: <20241011064005.305038-2-kuurtb@gmail.com>
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


