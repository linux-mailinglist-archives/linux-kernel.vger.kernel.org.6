Return-Path: <linux-kernel+bounces-362013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 796A199AFF3
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 04:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 389DF2832A5
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 02:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E72ADDCD;
	Sat, 12 Oct 2024 01:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OooCudZ2"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F1A4C83;
	Sat, 12 Oct 2024 01:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728698398; cv=none; b=N5q0JP1kIt+907JC/59LhkE+yTsSS6UiSLWp2iZHbkdROUmcAtxoa24Drb1dhR/Pli5YFsgcgPw4SdVM9YZ8PjbVbnpCRpTaNsMd5lLfRgy5nPqxtl4HjLQw3w0HfRE5ZR5izTQTvhBKbJfipU73uHyZl3htw0cASW/eJ8mlCK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728698398; c=relaxed/simple;
	bh=DFD9Y+f2RlNx6ManSa6m5r0PIKgGmKBd2kF+wtLcwwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T52wFmv53tDOcWyzBngxg2McUelMVg/dgMmShOnEID2v2PzszZVm/ol2GXmw4BJlsXlavb2nMW765icM/iOCpmH+braIDBWqJLJa9OGmFSSbBWWPUPzziD1LNAaFLK53G2K9Gr5jicvxFBYMKg8jOb0aXBFpwjtxFnDINphA1nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OooCudZ2; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7ea6a4f287bso327394a12.3;
        Fri, 11 Oct 2024 18:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728698397; x=1729303197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dfzA/lgqAF/5GaOTJU8o318tCaS9kYyQ2ESNMptb9ck=;
        b=OooCudZ2dGc94ZIsKuQ3bA2RuaCaZ5TBcF3iXR6Eh11uF/74gwPYgHhKr4+kVJEi+o
         YzOCk9InZZiaCjIZBYr79vH92HENwL4cx1xCDNBQTiv1qx/bN3RZk86EwPEhcRykOmjQ
         jJWn6I4Th+UkYRceubPKvu4JJu+DbgghgESv7L45D+iswBA4iMtaIKy7eS0P710fLWR6
         kbVFneBi8mfemh+u7Bz1gjXGZrBGDe/WjXaomwYLF7mYWwqX8DGiTQF2thNLEOQHJHo7
         Dary2eYEHINxo1LudsyDg6is/7S58d+dQnh7T+yHabeE071HEniqzMaSopDwB6a0aSTD
         1SmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728698397; x=1729303197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dfzA/lgqAF/5GaOTJU8o318tCaS9kYyQ2ESNMptb9ck=;
        b=fB9Ns/bLArcQT1LKyCyQWnbe1iWcQDoAF9zoiOpv6BXYwV+rjcDiVMg+Qplg5i60T9
         k6NUKZZy0TPEC5DARvmeYzaObyFgYUHxbJ3LpY4yT5+ygCM9wYZmEHnzkZHMQeniSo9Y
         JifIydTYIy4gcgTE/JvFyBdbyrXwLFAciMZ/dY60NcENuCn7OiZoxnsLspyfVWCfuI4/
         0wWRpS87cgeDKiJ33PGpXiBOkzgG8rQ3nhEKHHtiRSgN/P7aVQWU//AXc92N2pUaamg7
         jsAvHuxDNLcs+UZvapmMwDfwsTVYvb8NN2jr8Dj2EHgTdqPqUhGCHzgWAxvFMpCNNgho
         vMEg==
X-Forwarded-Encrypted: i=1; AJvYcCWyuVFwNz+CbvJu3LASD+A6P7qaPeAJCUnqcH3Yas7Q2Rq6t/Yer2zA2ejjjhtOedP0RKFxptY063y/nkGec62UObETag==@vger.kernel.org, AJvYcCXc1v2AHv9h6YVF8A+yU2QrjHdGCy5qAe74sKO1mRwj21iBXI+JCygktyfurSy9h8DKi1RYxjB1ZmUjcwo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBw7prE1b+xb/ujY+mVHs82GyBNE2LAf3IZsmhsGH5X8bpaBd7
	Q9I8RM1wPIAn+k92NdGy/0/EqFo+O+QViOj2BsgfXfTWoqkXQLk6
X-Google-Smtp-Source: AGHT+IHh6ckkyWCcRsd6gl7A78coSQwUpbZQWsfbI59KOaf2AwZomLhAt361YeAy9WQ4ciRoBeQMqg==
X-Received: by 2002:a05:6a20:c997:b0:1d6:fe5e:176e with SMTP id adf61e73a8af0-1d8c96c2fa0mr1761407637.46.1728698396588;
        Fri, 11 Oct 2024 18:59:56 -0700 (PDT)
Received: from localhost.localdomain (host95.181-12-202.telecom.net.ar. [181.12.202.95])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2a9e9526sm3428340b3a.12.2024.10.11.18.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 18:59:56 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
To: kuurtb@gmail.com
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH v5 0/4] Dell AWCC platform_profile support
Date: Fri, 11 Oct 2024 22:58:51 -0300
Message-ID: <20241012015849.19036-3-kuurtb@gmail.com>
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

 Documentation/wmi/devices/alienware-wmi.rst | 366 ++++++++++++++++++
 drivers/platform/x86/dell/Kconfig           |   1 +
 drivers/platform/x86/dell/alienware-wmi.c   | 389 ++++++++++++++++----
 3 files changed, 680 insertions(+), 76 deletions(-)
 create mode 100644 Documentation/wmi/devices/alienware-wmi.rst

-- 
2.47.0


