Return-Path: <linux-kernel+bounces-387944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D989B5846
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 01:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E59EA28392B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 00:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2058C3D6D;
	Wed, 30 Oct 2024 00:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iogunstX"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DED1FB4;
	Wed, 30 Oct 2024 00:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730246974; cv=none; b=jaFfM8UEx7Vo6cSEv8utVYn/xt14aoSrw+qxJ1AMrFFNmhz+n7/v07SygMNYKWH+FNzoJeeEyw59swRVq5TO/GTu2xqC8cqgS7/72KVwjKpZHjYF+awYnCY4mx62FsoRarYJ7ANBogVupwbQJKw+6pBxnOe9yxCmdx6zOVTdG/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730246974; c=relaxed/simple;
	bh=G1PkH1UqztosHEF0QChWfxVBbtE1GtH8KTH8GzJyuQE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eEpN/TQrKvtti4V7IEVzeb3DV2Ar0fuO6ClZHzxZ/+IehPzqdxkpS3Q0vQHbwwE+BocKzURFoD+Rl12EyR3+4SCdPTCHOwxHmleDGzjo22p+B6dn3CQT4wnqXUeanOToY3eQhnKKV/nlkIGVM+QT0U5CcuLESKTSyz6XObAmxtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iogunstX; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20c767a9c50so55281505ad.1;
        Tue, 29 Oct 2024 17:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730246972; x=1730851772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hYmx3Imo6THljZa+s7wQTWidNlfbfWZkmtY6Iazs7Cs=;
        b=iogunstXNi0V6kOrgh5LJBl7fUESn3TC5dshh92Gdj5Z5+bAsZXtC8XPJ+qOXonjiQ
         SINsmpsxwO89srHRY6xMr3r1Hae69O5wQhjLEU1emiOgTQDJMHXm5OcloHTlKn8ENOqy
         kUP4CPcItYnNEt12Oy4OCU1ks9PQwkME11q2QEiSVAk+wj2p1Ct5641wpzDKUCdO2uMS
         HuIsK6MI4cBzclON5781VmuaMIN7tpuAnydO7Gd8phbvi5Ua1QUJVVmr0XUiDFjWwmQW
         8i9YhmCGC8EPMq7oPuCOmlZ5MggnJ1e7G774op22EhoDUTT+GhZnLGSRqKO3x6YePG/0
         bwvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730246972; x=1730851772;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hYmx3Imo6THljZa+s7wQTWidNlfbfWZkmtY6Iazs7Cs=;
        b=JqIM+DNMlijhksQ5EtZpb/E6jSsYbWbx3It5qzChi8Nmv3cOlWMEDYxUZRBT/oH4Gs
         lcaYSAUj8GpCxdaVQsDeQJvgUJQWT/zEfqrz4ovPlvCzp4uhlqb4uBgTgr1Ptmfx0kHa
         LVA7UdAiJor8YvS9HtxadMMxzztK1CexLhQiFGgyV+HR8mLBEoOvU8jEQmT94tGj69h0
         inywV8b+xDNT0Nu7OTk6igChhk6NsTOrtURr8VXoW+LrkLP834/zAHnVyyiNrSc/yIF9
         qsJouMMyzK2kNLAck04kUVABMnp+7sJP0sflVjk2wiWQkln8AWbKOpit3CvRMcigHJA0
         nvNw==
X-Forwarded-Encrypted: i=1; AJvYcCU6EcCmd4e4rLwnFTTeyDgJc/jT6oCFGl5AusYnZ07h+X68fQR6i+sHpZl7O9A+ca6xvGuz5FNdg8OloFcorkGKo1NEtQ==@vger.kernel.org, AJvYcCX13eldA1+XFzl/gvDSBC81ZczpSzQA+gQuhWb/SDOHyr1f8Fxp0zxXDK6fmcS6B8COhMIupDD0doiUKKA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1snpzYgtlJQMXEtfuFczGZfFx3sa7c+xBMkKxDZeiJKwy9IMz
	e4xNO6cllixMt1XBuq5objrnZQ/GO1UHbQ0YdolUdv0LMWcqcxE2
X-Google-Smtp-Source: AGHT+IFlA5aRj4o1iHxm5yrZvF5jyKmVhYK/d2oKSPGLgW9QtMUDsRf23eYusuhjo5WTVq6yqNZyeQ==
X-Received: by 2002:a17:902:ec88:b0:20c:763e:d9cc with SMTP id d9443c01a7336-210c68a1a50mr230676095ad.7.1730246971749;
        Tue, 29 Oct 2024 17:09:31 -0700 (PDT)
Received: from localhost.localdomain (host95.181-12-202.telecom.net.ar. [181.12.202.95])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc082736sm71626415ad.288.2024.10.29.17.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 17:09:31 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
To: kuurtb@gmail.com
Cc: W_Armin@gmx.de,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH v11 0/5] Dell AWCC platform_profile support
Date: Tue, 29 Oct 2024 21:09:05 -0300
Message-ID: <20241030000904.7205-2-kuurtb@gmail.com>
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
v11:
 - Minor changes on patch 4/5
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


