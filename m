Return-Path: <linux-kernel+bounces-352357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 257AE991E00
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 13:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B66C72822E6
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 11:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6C0173355;
	Sun,  6 Oct 2024 11:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MuTdGPuC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF6B4C91
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 11:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728212860; cv=none; b=p3PprKyJq1HfPcDSoEqtoGCbRtV+a2ObB3xwcb5hFc90Y/v1X5NLtb9LB1ghYDpiIz4ChdJPYZ4lm7S7Z7a5y0RiZzN5snCDoVyJFMZ+E7Kf6CypAJsT+6YbyNhhO1QNWBuiH4Tc4wU5mQKOsojh82L2uM52ZW9uIgU5+6NKysI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728212860; c=relaxed/simple;
	bh=Qcxjj234pIpZOfz5P472ZIKGo3Vd966nLGayQOANXmg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=bq0HhTnn0EHT/44EIT9zq+kKvSuk4qMwuSdH6obgDZpzY50IUdp4JAh8VrSaL2vN5XYPgqUuBZhgq9vL6qizC0pjJDZNF4nz2ybSbWmFZwDr73vFPnq7tyeGstZeCt6pmRZoREPkmIM3U3cqCt+DUYMhzxSM7XwSOBi9YIVSUUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MuTdGPuC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728212857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=C5HhCG62PPs1E+U8cz4OCTWqVv8ereOedx5o6z48nJM=;
	b=MuTdGPuCrbE/aJ25UBf6nvBj0qEk/GNIhy20iTVFTYPGvCSPsHtBf8mtEwCKn3+TGJCMLJ
	0YC/Ek92wemj+5JUTZlaRCAxzJ+IrKzcDDNx1hZdjcs5VF7i06GTt7aMT3sHol8OL2JMbp
	XWn7jUOgPNBMVbe4QfdvToCTyWyJ6QI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-qR7rZQUTM9y5CnSMFbsPRg-1; Sun, 06 Oct 2024 07:07:36 -0400
X-MC-Unique: qR7rZQUTM9y5CnSMFbsPRg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-37cd4acb55aso2827709f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2024 04:07:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728212854; x=1728817654;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C5HhCG62PPs1E+U8cz4OCTWqVv8ereOedx5o6z48nJM=;
        b=eRofHFgpdEYt8EX/wT3Yf5i+wrbRZjgM5bha87b65sxRl01Eqyc0tQMPLq5pBXR9x5
         3TejVXgA3s1fsPECJlnR/1jniqheThYyMczF/0yDVtB+JWv/e17RtP7xZ7w0w475AksN
         l8kVRkdBrhL8SSd9CBop1XqgKrQTrZ+aTRWrNGah941WG851qPGH7PB3RG4wcvm+901h
         xVV9U7e2QIOVy2k+nidNds0w0/hhzVRO3CerfsGA0KSgsDGeeXCEqAefUbWhauySmY1Z
         upew2I8FFosmQtszsmTok6e+RpgDSXTAY+Gg3zBx8lKFfctLtLdkT0NllJUlx5zwqdX4
         yX/g==
X-Gm-Message-State: AOJu0YzmbLIG0kD/Er2pHqKbS5uDXzqiRFMnKkZjDSNbNTUQRGZxsCJ1
	aSvo31CHEDap87D4aiPv1+Ol3uURq2TCD4uT2xE9YORnxzQJuV+b2RQIIDPh/5cMPxIrzp96Hia
	HX/KtFucIF7aMAbVYwhkDnvx3K7U0Dsz/kjL5IOkMXdvz/UJIYKotjTvAe7770UZ+yhFIb++0
X-Received: by 2002:a5d:4b4b:0:b0:374:c7a5:d610 with SMTP id ffacd0b85a97d-37d0e8daf56mr7650570f8f.43.1728212854600;
        Sun, 06 Oct 2024 04:07:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqV7rEFAdRSmfxg2aB/sQA0wW2C3g/6PDO0oKR32MFZfVdo9fErm3V+MYLUbBoAgK9DCQR7A==
X-Received: by 2002:a5d:4b4b:0:b0:374:c7a5:d610 with SMTP id ffacd0b85a97d-37d0e8daf56mr7650545f8f.43.1728212854242;
        Sun, 06 Oct 2024 04:07:34 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a992e78498fsm241786866b.107.2024.10.06.04.07.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Oct 2024 04:07:33 -0700 (PDT)
Message-ID: <280a792b-ec54-419d-8cca-17b020a38d3f@redhat.com>
Date: Sun, 6 Oct 2024 13:07:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans de Goede <hdegoede@redhat.com>
Subject: [GIT PULL] platform-drivers-x86 for 6.12-2
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 platform-driver-x86@vger.kernel.org,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Content-Language: en-US, nl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Here is the first round of fixes for platform-drivers-x86 for 6.12.

Highlights:
 -  Intel PMC fix for suspend/resume issues on some Sky and Kaby Lake laptops
 -  Intel Diamond Rapids hw-id additions
 -  Documentation and MAINTAINERS fixes
 -  Some other small fixes

Regards,

Hans


The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:

  Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.12-2

for you to fetch changes up to 2fae3129c0c08e72b1fe93e61fd8fd203252094a:

  platform/x86: x86-android-tablets: Fix use after free on platform_device_register() errors (2024-10-06 12:50:50 +0200)

----------------------------------------------------------------
platform-drivers-x86 for v6.12-2

Highlights:
 -  Intel PMC fix for suspend/resume issues on some Sky and Kaby Lake laptops
 -  Intel Diamond Rapids hw-id additions
 -  Documentation and MAINTAINERS fixes
 -  Some other small fixes

The following is an automated git shortlog grouped by driver:

ISST:
 -  Add Diamond Rapids to support list
 -  Fix the KASAN report slab-out-of-bounds bug

MAINTAINERS:
 -  Update Intel In Field Scan(IFS) entry

dell-ddv:
 -  Fix typo in documentation

dell-laptop:
 -  Do not fail when encountering unsupported batteries

dell-sysman:
 -  add support for alienware products

intel/pmc:
 -  Disable ACPI PM Timer disabling on Sky and Kaby Lake

platform/x86/intel:
 -  power-domains: Add Diamond Rapids support

wmi:
 -  Update WMI driver API documentation

x86-android-tablets:
 -  Fix use after free on platform_device_register() errors

----------------------------------------------------------------
Anaswara T Rajan (1):
      platform/x86: dell-ddv: Fix typo in documentation

Armin Wolf (2):
      platform/x86: dell-laptop: Do not fail when encountering unsupported batteries
      platform/x86: wmi: Update WMI driver API documentation

Crag Wang (1):
      platform/x86: dell-sysman: add support for alienware products

Hans de Goede (2):
      platform/x86:intel/pmc: Disable ACPI PM Timer disabling on Sky and Kaby Lake
      platform/x86: x86-android-tablets: Fix use after free on platform_device_register() errors

Jithu Joseph (1):
      MAINTAINERS: Update Intel In Field Scan(IFS) entry

Srinivas Pandruvada (2):
      platform/x86: ISST: Add Diamond Rapids to support list
      platform/x86/intel: power-domains: Add Diamond Rapids support

Zach Wade (1):
      platform/x86: ISST: Fix the KASAN report slab-out-of-bounds bug

 Documentation/driver-api/wmi.rst                          | 11 +++++------
 Documentation/wmi/devices/dell-wmi-ddv.rst                |  4 ++--
 MAINTAINERS                                               |  2 +-
 drivers/platform/x86/dell/dell-laptop.c                   | 15 ++++++++++++---
 drivers/platform/x86/dell/dell-wmi-sysman/sysman.c        |  1 +
 drivers/platform/x86/intel/pmc/spt.c                      |  2 --
 .../platform/x86/intel/speed_select_if/isst_if_common.c   |  5 ++++-
 drivers/platform/x86/intel/tpmi_power_domains.c           |  1 +
 drivers/platform/x86/x86-android-tablets/core.c           |  6 ++++--
 9 files changed, 30 insertions(+), 17 deletions(-)


