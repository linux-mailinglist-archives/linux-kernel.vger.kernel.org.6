Return-Path: <linux-kernel+bounces-381996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 332BB9B0775
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 17:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B91C51F268FA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 15:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81FCF2022E9;
	Fri, 25 Oct 2024 15:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nh27OIu/"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F209C13B58B;
	Fri, 25 Oct 2024 15:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729868980; cv=none; b=srtOb1FgNFVAwpcpDMvjEcFxxcf8TlSPw/j+6K8nCdkrHB/dCrX7u8z1rjASy/vtZu1oZwKfSCnIrsjYSfAR7s1l/ZAZwba2KqljXy83nXuQUqLu/zcHl3ffRhkGryPJEb0rC8lwdbLVYjcij/47eo3uh08ou70LVmsznXROXSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729868980; c=relaxed/simple;
	bh=1RmGyCC7xFcxha+iZTUHKP2cHQyqM10VhqLeYFhDvMI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nCpyXYElRoUpOpSgLtVLwVZKuCAizo16oZl+kirK7PHYGUmbUV3ATLHLPJf+LF9oqGx22jAuMZTAJds0D/yOL4jTowv/6/KP3NhpJVE/0rgOxmdXd9EANy1621Kd1NYT4Fpz3JiTFAov+0wmWBwc85G9Z7K9ozeTiVjcAoD2iQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nh27OIu/; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7ed9c16f687so1494593a12.0;
        Fri, 25 Oct 2024 08:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729868978; x=1730473778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4kEDX3VX0lJ7Y1euvUERu5sAYhFEMjFPoZUkr45HNg4=;
        b=Nh27OIu/sI60+AM5SU/tPuJXovUTIQavendBUPDlP5xfIgDDWTw/vAhrewTYGITvLV
         7ldtXR63QJRKWDqBBlQqmg+BJZuKhR74Q+5/6cQaqrvehqwEsVZojHK+Z3MgfzHEcqL7
         As8Nx/2L8MzeFvysiyfHeiVOmerkerdSf3EA/bgw9VVzIm78rpG6gb4OCaHlgZDARD91
         cn02NH9xcd6SfyvJX8jyhomH+5oqfIjnf0zwKaFhVhAxPWtltS7imartP6gsy7XxZk6W
         hga0L7OKW3+AO8UkpfRu3jsQq0NNwaRDHKER6RdIIlWbgBg8L769JXMxVrW4TZN0j/WD
         Q/uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729868978; x=1730473778;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4kEDX3VX0lJ7Y1euvUERu5sAYhFEMjFPoZUkr45HNg4=;
        b=vKmo49nVUkAoAdO7DNpILFmnVJ0Z5ulNbMqN7+Ux+ujz4cuDbhYKzlnqfyBvYUlja/
         v1PBw2RUTTsK5Zl7XSTRukruoBvgNvUNlJVUiDWuUlcIImKcj+Af3aQ73PtxJFjo42Nx
         lzWQqjmZxTrgTnneP9ACQDzs9aR6mb1nttO/gbdMsI3dgcCTLPJI2vAbaMUnbXCZMtjh
         PTBcOJAlKFU5wU7MpHVQ2lYcXsfboDSFgDAXedUxVQNY3f0rBQV/Shy4rZ2AQ3NhvAOL
         AcER+5QFjXG9toDhdF5/FADo6IOWhXhPZ7CGDnP2iZgolLTuVwmmvVRLfco3AaiKJnjG
         xUfQ==
X-Forwarded-Encrypted: i=1; AJvYcCV27+sNlvMF3yzk+QFn1YsnqHZ3ULX7NpMxD6ROAwnp3zzPKMeNrfoa9YeZbubj+MvUnV1Pu1KQ7Qd9U/0=@vger.kernel.org, AJvYcCVMXv6YYf6YPE4MapHvBxBuCuPCr9mKKXx8dlR+gvJp02oKQiBL9UnmAyKAiJtDgaKeoJHeFS1kjxys1P2KQElwFO8I3g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxWGyKmaddd1Jgse4wgiEVpxWEUgbtj6QXw59zLoi5RbatHVDU/
	ubGbPWFmFj24GpavZkUWHekkLfCR5T5sSt8tfNFErU5Bh8FgU4bI
X-Google-Smtp-Source: AGHT+IGRnvUSPE6mhlSYvyOP2tmIWMrCG8/eqS5fDv9kZu7I3EIg+silMau+oSOifU9sRreghRCjNw==
X-Received: by 2002:a05:6a20:cf8e:b0:1d5:125f:feb0 with SMTP id adf61e73a8af0-1d978af82e4mr10724716637.18.1729868978188;
        Fri, 25 Oct 2024 08:09:38 -0700 (PDT)
Received: from localhost.localdomain (host95.181-12-202.telecom.net.ar. [181.12.202.95])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a0b956sm1158685b3a.116.2024.10.25.08.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 08:09:37 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
To: kuurtb@gmail.com
Cc: W_Armin@gmx.de,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH v9 0/4] Dell AWCC platform_profile support
Date: Fri, 25 Oct 2024 12:09:17 -0300
Message-ID: <20241025150916.3618-2-kuurtb@gmail.com>
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


