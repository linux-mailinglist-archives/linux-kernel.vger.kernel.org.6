Return-Path: <linux-kernel+bounces-383129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D099B179C
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 13:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF533B22F75
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 11:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2001D433F;
	Sat, 26 Oct 2024 11:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UV/momk1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219CE1D2B03
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 11:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729943552; cv=none; b=g99jZCMmmI0IfJbXLqEzMGQtdxMCNADAI6Umk46gleEIZybBrJb9SsQUSSGoiXNG+oVjofYpk+THMYDGPO/e5HCVxRdmjBFJZmjA3/mWFK30D9byTz1dXDBRoE8diqHBj16XhGttobsAf/T4TumMledZnoL/ghIFBG9rPnTJ5wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729943552; c=relaxed/simple;
	bh=MphIURdCjiW0NEo0bx6DHrqkknsDKHxnpMDrVItzUFA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=r5P6Ynn6Pgp4a1o1LRRV3hwXtPACIpmjWK2GpKDaiT08CzpNpqO0J+SvDIa+k2Y0ojofihgoxUKfS7RYiUlOEy5TUKsO7kQG+66ctsVQEonCuOV3EI76/xx+cYnnFoI6NbbgR4fLqqPEmRnPbZ18iloZXATvQSP6Yjx5T33KiLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UV/momk1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729943548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QtzZktEu9avuwDKeUy+G3IcD5daRVFERadBqCe8g8CM=;
	b=UV/momk1spsfvohJPN3IND5XXuL6L/A7P/sLUzAdkn20wjFuIcp18GtEMzLrxx46Z0maco
	ljEieBGJao3qOaR9Nqgw2kXMUdwrV59tIFMHOhc63nkQFsEKETo+HPMU6MlZAzbhMJdBqO
	a5rYX7/5P9tK2IhxmZGyiNnlfCwSMIY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-zn5yU0aFOFuFnotX-r08yQ-1; Sat, 26 Oct 2024 07:52:27 -0400
X-MC-Unique: zn5yU0aFOFuFnotX-r08yQ-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5c92e8b8101so1988800a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 04:52:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729943546; x=1730548346;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QtzZktEu9avuwDKeUy+G3IcD5daRVFERadBqCe8g8CM=;
        b=F86QjrHwoTx99vQOX8W1cFRCDyqsWyZMQAZrN0FtQCQhjda6KDQCVXgc15gD++H4Lg
         HNeEjSE41wR20UH+qWFM/DIZGB0cHDop4lKYPPJeZDhFA7KoGfa+VpOX7nVXec0xWjJn
         h5dX9OaGFEjLqXsVwSoQYFGMN4i7b38TgoybB1xAvmdqUrN5KJ0qThy4x784kA+3LQXN
         FGmQe6NVV29TANsQ+K8pamxvWmavP8y/uh/18Uuqp5TY2qdDwMVK64TDFafX130YKrCc
         +p3E4uDo00MGL3ppwrnRVaGjDRS4CqW4mvZmJfM9zV2wg8SAo6Dsp3t45Rw2QmYYgwHz
         Thsg==
X-Gm-Message-State: AOJu0Yx1FL19iLcV3OglVKgnF8Ad2mh97Fd9vBf8w902WmvNXLEtHSfb
	+04spaJ48dvqk/FJ3N3rMir6uAoDO5m38bjVl63NSJaY+YUyj23LhwzSX3q/YMNIi2ZZD/uaQ7S
	IC1H3xqYsoQpOQh+WSSn9F5SOOeLYq8Q36Yn+8hnqqtoIFJk1T/GbkUoUuBodpw==
X-Received: by 2002:a05:6402:d09:b0:5c8:8d5e:19b0 with SMTP id 4fb4d7f45d1cf-5cbbfa74da6mr1478947a12.30.1729943545864;
        Sat, 26 Oct 2024 04:52:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3+JE4gpJZaQ1HaEFJyiJ8LCXJx9mu5O68c5w8T8EW7iW9hGjHq0ii+QE257w339vAnW1JNw==
X-Received: by 2002:a05:6402:d09:b0:5c8:8d5e:19b0 with SMTP id 4fb4d7f45d1cf-5cbbfa74da6mr1478934a12.30.1729943545360;
        Sat, 26 Oct 2024 04:52:25 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cbb629d587sm1474785a12.30.2024.10.26.04.52.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Oct 2024 04:52:24 -0700 (PDT)
Message-ID: <b220d6bc-41da-4ae6-8f69-4f008f15d540@redhat.com>
Date: Sat, 26 Oct 2024 13:52:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans de Goede <hdegoede@redhat.com>
Subject: [GIT PULL] platform-drivers-x86 for 6.12-3
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 platform-driver-x86@vger.kernel.org,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Content-Language: en-US, nl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Here is the second round of fixes for platform-drivers-x86 for 6.12.

Highlights:
 - Asus thermal profile fix, fixing performance issues on Lunar Lake
 - Intel PMC: 1 revert for a lockdep issue + 1 bugfix
 - Dell WMI: Ignore some WMI events on suspend/resume to silence warnings

Regards,

Hans


The following changes since commit 2fae3129c0c08e72b1fe93e61fd8fd203252094a:

  platform/x86: x86-android-tablets: Fix use after free on platform_device_register() errors (2024-10-06 12:50:50 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.12-3

for you to fetch changes up to b012170fed282151f7ba8988a347670c299f5ab3:

  platform/x86: asus-wmi: Fix thermal profile initialization (2024-10-26 13:03:10 +0200)

----------------------------------------------------------------
platform-drivers-x86 for v6.12-3

Highlights:
 - Asus thermal profile fix, fixing performance issues on Lunar Lake
 - Intel PMC: 1 revert for a lockdep issue + 1 bugfix
 - Dell WMI: Ignore some WMI events on suspend/resume to silence warnings

The following is an automated git shortlog grouped by driver:

asus-wmi:
 -  Fix thermal profile initialization

dell-wmi:
 -  Ignore suspend notifications

intel/pmc:
 -  Revert "Enable the ACPI PM Timer to be turned off when suspended"

platform/x86/intel/pmc:
 -  Fix pmc_core_iounmap to call iounmap for valid addresses

----------------------------------------------------------------
Armin Wolf (2):
      platform/x86: dell-wmi: Ignore suspend notifications
      platform/x86: asus-wmi: Fix thermal profile initialization

Marek Maslanka (1):
      platform/x86:intel/pmc: Revert "Enable the ACPI PM Timer to be turned off when suspended"

Vamsi Krishna Brahmajosyula (1):
      platform/x86/intel/pmc: Fix pmc_core_iounmap to call iounmap for valid addresses

 drivers/platform/x86/asus-wmi.c             | 10 +++++++
 drivers/platform/x86/dell/dell-wmi-base.c   |  9 ++++++
 drivers/platform/x86/intel/pmc/adl.c        |  2 --
 drivers/platform/x86/intel/pmc/cnp.c        |  2 --
 drivers/platform/x86/intel/pmc/core.c       | 46 -----------------------------
 drivers/platform/x86/intel/pmc/core.h       |  8 -----
 drivers/platform/x86/intel/pmc/core_ssram.c |  4 ++-
 drivers/platform/x86/intel/pmc/icl.c        |  2 --
 drivers/platform/x86/intel/pmc/mtl.c        |  2 --
 drivers/platform/x86/intel/pmc/tgl.c        |  2 --
 10 files changed, 22 insertions(+), 65 deletions(-)


