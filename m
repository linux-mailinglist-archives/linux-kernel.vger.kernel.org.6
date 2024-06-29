Return-Path: <linux-kernel+bounces-234902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5FE791CC37
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 13:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1447A1F21D78
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 11:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9C147A7C;
	Sat, 29 Jun 2024 11:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DyCMUlxU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C782739FD9
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 11:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719659251; cv=none; b=uws7SA3ADPulzigcNMNc6C85vcOuQ+m+30g37KdCV577KKcyoOO7UndFClDqSvl1iKO84wHWlKAXgiqHvw0hnDIZ7kV20t/R+BR+eYakJZfclO+LAmPGtQQc/SZSUDiBe/MibbuXUXqxsHgEJWLwjuBhKgN1K5atDNgEFFa2IBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719659251; c=relaxed/simple;
	bh=NcxFNUMMQezM2LMdc1WYMgJDFmd3gJrEycPqfxG99F4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=jE97Ry/6TJ+I1fqMylZTQuOZD1sMdf6t3c62TPmM4Yo0v52vWsTnFOamizgYOM45e0QY/tTKEchQ5BTeYZAK6JSryEnJQjZ0yA9VaZLS1Ou4SgkWy9a6GceazSahSXfuzBWi3ONdb2deN9ga2uBGw0f3Ptn8G2AUXYFpnPZEirM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DyCMUlxU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719659248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xeiu4yUjhxRvSoRvsElkoFHjxoTJHRpvHUxDn3uagD0=;
	b=DyCMUlxUmMAHfqPM9a2OgcFpSOobRUuGyeNNOckjZG/Wn3DlNcd52HAe5n2XNyyCjpTx6c
	f8JsvSgq5xInMA3y1XCe/hsPIYyA8bdScz9OwiR5o3VdRU8BcGhbS4gaDyvC3MHmYJZlvn
	I3EH6Dhmj8ukqHgwJHKUjXFEpNZJHdU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-ZtXeLYFeOcKl5tag-2BMjA-1; Sat, 29 Jun 2024 07:07:26 -0400
X-MC-Unique: ZtXeLYFeOcKl5tag-2BMjA-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-57d3d594107so1032915a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 04:07:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719659246; x=1720264046;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xeiu4yUjhxRvSoRvsElkoFHjxoTJHRpvHUxDn3uagD0=;
        b=MEU2fiIdLURfTJCletijjvqjYN0nMyqL/v5UNLUFFr+eeJgNGXqDv1cq7T2ILaFWM+
         +tLwMLBzOqt+aCXQ1falC3svzyjtWifgbaozCheRAwMjzszbbYKaKvJS79DKzRdcpIVu
         HnxD4/dt8RB0wstF5IuNj1h2wsUcLwTasrOcDWQ9Zs7AVfpmtdwNAxK4bQu1hADyLmeO
         oprelHbBBxDONufyntunoetGCsrBk2hUOXvScrwlcZVJQ3FSeFEachBW1Ha4G6rQ6+LT
         BL3EItE8CRpDSqfmaVBUrE4WhaPyvs2yKEgHlXlfAHGrdahTxFiy0hl5vTD6DRzpqpGP
         vndQ==
X-Gm-Message-State: AOJu0Yzcf+zfjj+GBof7oRs0F2QJWCFvnQwgpg1te8Zipec++Ait9Ewn
	LDHd5XUC45CATRezdvXzlgzQTBNy5lwYZuOCWwnOr3+mrOHJUEfR/tLG+x37buKu5pqDTLBFhuy
	v+aWoLHftaHRMFCTMCdu3N1/boF6K8i+5JNHBGwxUQ//NtjyOvr+kpPDgbptsmw==
X-Received: by 2002:a05:6402:13c5:b0:57d:5ac:7426 with SMTP id 4fb4d7f45d1cf-5879f0c68dcmr617475a12.9.1719659245794;
        Sat, 29 Jun 2024 04:07:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKKZ2Whjr0POZ5x7iFcBXdDHfuXZ1a5911pCuil2ybmEGOUa7+r9+7NPJ1vu40qlVCKgzoqg==
X-Received: by 2002:a05:6402:13c5:b0:57d:5ac:7426 with SMTP id 4fb4d7f45d1cf-5879f0c68dcmr617463a12.9.1719659245292;
        Sat, 29 Jun 2024 04:07:25 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5861381756esm2154757a12.56.2024.06.29.04.07.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Jun 2024 04:07:24 -0700 (PDT)
Message-ID: <e472b2cb-a6bc-4959-9b3d-540930f8118a@redhat.com>
Date: Sat, 29 Jun 2024 13:07:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans de Goede <hdegoede@redhat.com>
Subject: [GIT PULL] platform-drivers-x86 for 6.10-4
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 platform-driver-x86@vger.kernel.org,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Content-Language: en-US, nl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Here is the third round of fixes for platform-drivers-x86 for 6.10.

Highlights:
 -  Fix lg-laptop driver not working with 2024 LG laptop models
 -  Add missing MODULE_DESCRIPTION() macros to various modules
 -  nvsw-sn2201: Add check for platform_device_add_resources

Regards,

Hans


The following changes since commit 77f1972bdcf7513293e8bbe376b9fe837310ee9c:

  platform/x86/amd/hsmp: Check HSMP support on AMD family of processors (2024-06-03 11:57:28 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.10-4

for you to fetch changes up to 7add1ee34692aabd146b86a8e88abad843ed6659:

  platform/x86: add missing MODULE_DESCRIPTION() macros (2024-06-24 13:33:20 +0200)

----------------------------------------------------------------
platform-drivers-x86 for v6.10-4

Highlights:
 -  Fix lg-laptop driver not working with 2024 LG laptop models
 -  Add missing MODULE_DESCRIPTION() macros to various modules
 -  nvsw-sn2201: Add check for platform_device_add_resources

The following is an automated git shortlog grouped by driver:

add missing MODULE_DESCRIPTION() macros:
 -  add missing MODULE_DESCRIPTION() macros

lg-laptop:
 -  Use ACPI device handle when evaluating WMAB/WMBB
 -  Change ACPI device id
 -  Remove LGEX0815 hotkey handling

platform/mellanox:
 -  nvsw-sn2201: Add check for platform_device_add_resources

platform/x86/intel:
 -  add missing MODULE_DESCRIPTION() macros

platform/x86/siemens:
 -  add missing MODULE_DESCRIPTION() macros

wireless-hotkey:
 -  Add support for LG Airplane Button

----------------------------------------------------------------
Armin Wolf (4):
      platform/x86: wireless-hotkey: Add support for LG Airplane Button
      platform/x86: lg-laptop: Remove LGEX0815 hotkey handling
      platform/x86: lg-laptop: Change ACPI device id
      platform/x86: lg-laptop: Use ACPI device handle when evaluating WMAB/WMBB

Chen Ni (1):
      platform/mellanox: nvsw-sn2201: Add check for platform_device_add_resources

Jeff Johnson (3):
      platform/x86/siemens: add missing MODULE_DESCRIPTION() macros
      platform/x86/intel: add missing MODULE_DESCRIPTION() macros
      platform/x86: add missing MODULE_DESCRIPTION() macros

 drivers/platform/mellanox/nvsw-sn2201.c            |  5 +-
 drivers/platform/x86/amilo-rfkill.c                |  1 +
 drivers/platform/x86/firmware_attributes_class.c   |  1 +
 drivers/platform/x86/ibm_rtl.c                     |  1 +
 drivers/platform/x86/intel/hid.c                   |  1 +
 drivers/platform/x86/intel/pmc/pltdrv.c            |  1 +
 drivers/platform/x86/intel/rst.c                   |  1 +
 drivers/platform/x86/intel/smartconnect.c          |  1 +
 drivers/platform/x86/intel/vbtn.c                  |  1 +
 drivers/platform/x86/lg-laptop.c                   | 89 +++++++++-------------
 .../x86/siemens/simatic-ipc-batt-apollolake.c      |  1 +
 .../x86/siemens/simatic-ipc-batt-elkhartlake.c     |  1 +
 .../platform/x86/siemens/simatic-ipc-batt-f7188x.c |  1 +
 drivers/platform/x86/siemens/simatic-ipc-batt.c    |  1 +
 drivers/platform/x86/siemens/simatic-ipc.c         |  1 +
 drivers/platform/x86/uv_sysfs.c                    |  1 +
 drivers/platform/x86/wireless-hotkey.c             |  3 +
 drivers/platform/x86/xo1-rfkill.c                  |  1 +
 18 files changed, 56 insertions(+), 56 deletions(-)


