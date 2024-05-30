Return-Path: <linux-kernel+bounces-195782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A528D51CB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 20:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 656C41C22E3E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 18:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503734D5B0;
	Thu, 30 May 2024 18:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S7gjuGR6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E2D18756B
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 18:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717093853; cv=none; b=psWHWtaqXP8iHy4TZv4Lbof0ToNa9yXdcz1NuKo+0z23DXsW2nR/RFVIxsrgV8BFeCXOkUGHXMg2UvpZgGf6dVWfzr97CDAHORRJCvravX/hLKbewJQiuGU/xr8MK0a6rAnhqMRmwkAIjq/Ez9dsiiq1DdjxQeNdGrPwF3gITcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717093853; c=relaxed/simple;
	bh=33L6s4vKy97GaN4BZzqEE5/renpH8a2GYzMSjcrPTFQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=F1oLdpu3Nugpe/0E3cEZc27nqtdjXturO0R3RdJiPHeGe7t+w6GubOtzFPjjPZ74vYA06WTOYeNG1W+8XAdDH99J8K4XngnjlnycqGRjV4HFIpPmOv0I87EbdkRIYaZ3fJeIHBw+IExkTukLkMaqqrysVlP56G+DOeVf14p9iwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S7gjuGR6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717093851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nd2gyK4ZonhwCOT/Y7f2LA/uGx9MOgzn7+cShk0mQFA=;
	b=S7gjuGR67/iL1TF8qIIElhmNhswN9rCu42pRPTB9FA9XWHf3w5hHNAYt2G5D0lkIrE6G9d
	+3StaA8GFiJSfqFdA7WXApoBPIfM11f3QVqSYvMgIauW86bZqu/sFEBldeCMBzpvZaraUE
	eyoAFaUXX0XjHLDzCnFwOkIhkgxW8mM=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-aI51XmRtO2-TRSg1fso_gw-1; Thu, 30 May 2024 14:30:47 -0400
X-MC-Unique: aI51XmRtO2-TRSg1fso_gw-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-5234e83c4a6so894257e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 11:30:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717093846; x=1717698646;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nd2gyK4ZonhwCOT/Y7f2LA/uGx9MOgzn7+cShk0mQFA=;
        b=fK3/Hoh+c9rQTizD8QWVHuAxo785C723ZdiBdBM08MV/CE9e89hEWFAPLkBNwF2n6N
         4lDktRd2lm09M8E3c5/jmhVvmz3W71CcHacptIT1NNmZ611mMxTtfDOWrkbMe3VEpeh/
         sQJbACGLmWSlWgDAnk9xcE7XZmE7OOAc3HXhsimgjgwW/QDEQtDfs+7YbGel0x0y3llv
         lIWCWxXnyXM6pPKLIq2l9ikYLWsUnVHplGZilp+nZKVNYgDEpMXZqAD2jMt+RuD9kZMY
         CpbKIKFpHNvHj5Dp/x1xdr/pPUxh2V4HuQo8Z2xY81mjdhMfgoeb0k4Sw6qY0mJJUhKj
         G6Nw==
X-Gm-Message-State: AOJu0YzyiNWNOiM5OAz6/NLTXkLrugw3g3FURbjxf2PwnloMJdD6ls0s
	iYdKHNkkTl6BtOrtGUgWbw44Tc7GE8JwG9R/dwdV+40uAjNMcaZOxSdJ9k35ZKs47dev16zO7/v
	gMsfP3EmHAgOVm2e2xx/s2o4XPQMMf+IiC/T1rQkv4OQNdT87UizRtMfKVtQhTvuuUILFlQ==
X-Received: by 2002:ac2:52ad:0:b0:52b:68e3:6e02 with SMTP id 2adb3069b0e04-52b7d4263ffmr1732274e87.27.1717093845809;
        Thu, 30 May 2024 11:30:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGm6WIHSy1XP/kCjJRfi19l9VpuwmnbTkKAggfM+5EFREAwdT4X0ElY/xJHa6zOBTaduJM7Wg==
X-Received: by 2002:ac2:52ad:0:b0:52b:68e3:6e02 with SMTP id 2adb3069b0e04-52b7d4263ffmr1732263e87.27.1717093845326;
        Thu, 30 May 2024 11:30:45 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a67eb344426sm2429566b.215.2024.05.30.11.30.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 May 2024 11:30:44 -0700 (PDT)
Message-ID: <470d8b3d-1c9a-475e-a6fb-4fcc4b9ef98e@redhat.com>
Date: Thu, 30 May 2024 20:30:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans de Goede <hdegoede@redhat.com>
Subject: [GIT PULL] platform-drivers-x86 for 6.10-2
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 platform-driver-x86@vger.kernel.org,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Content-Language: en-US, nl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Here is the first round of fixes for platform-drivers-x86 for 6.10.

Highlights:
 -  A use-after-free bugfix
 -  2 Kconfig fixes for randconfig builds
 -  Allow setting touchscreen_dmi quirks from the cmdline for debugging
 -  touchscreen_dmi quirks for 2 new laptop/tablet models

Regards,

Hans


The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.10-2

for you to fetch changes up to 3050052613790e75b5e4a8536930426b0a8b0774:

  platform/x86: touchscreen_dmi: Add info for the EZpad 6s Pro (2024-05-27 11:43:03 +0200)

----------------------------------------------------------------
platform-drivers-x86 for v6.10-2

Highlights:
 -  A use-after-free bugfix
 -  2 Kconfig fixes for randconfig builds
 -  Allow setting touchscreen_dmi quirks from the cmdline for debugging
 -  touchscreen_dmi quirks for 2 new laptop/tablet models

The following is an automated git shortlog grouped by driver:

ISST:
 -  fix use-after-free in tpmi_sst_dev_remove()

thinkpad_acpi:
 -  Select INPUT_SPARSEKMAP in Kconfig

touchscreen_dmi:
 -  Add info for the EZpad 6s Pro
 -  Add info for GlobalSpace SolT IVW 11.6" tablet
 -  Add support for setting touchscreen properties from cmdline

x86-android-tablets:
 -  Add "select LEDS_CLASS"

----------------------------------------------------------------
Hans de Goede (2):
      platform/x86: x86-android-tablets: Add "select LEDS_CLASS"
      platform/x86: touchscreen_dmi: Add support for setting touchscreen properties from cmdline

Harshit Mogalapalli (1):
      platform/x86: ISST: fix use-after-free in tpmi_sst_dev_remove()

Steven Rostedt (Google) (1):
      platform/x86: thinkpad_acpi: Select INPUT_SPARSEKMAP in Kconfig

hmtheboy154 (2):
      platform/x86: touchscreen_dmi: Add info for GlobalSpace SolT IVW 11.6" tablet
      platform/x86: touchscreen_dmi: Add info for the EZpad 6s Pro

 Documentation/admin-guide/kernel-parameters.txt    |  22 ++++
 drivers/platform/x86/Kconfig                       |   1 +
 .../x86/intel/speed_select_if/isst_tpmi_core.c     |   2 +-
 drivers/platform/x86/touchscreen_dmi.c             | 117 ++++++++++++++++++++-
 drivers/platform/x86/x86-android-tablets/Kconfig   |   2 +
 5 files changed, 139 insertions(+), 5 deletions(-)


