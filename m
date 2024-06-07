Return-Path: <linux-kernel+bounces-205711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B55C48FFF3F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 11:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06F8CB24455
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 09:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB8015B97D;
	Fri,  7 Jun 2024 09:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fHQ0Qfz3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84FC15443F
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 09:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717752157; cv=none; b=IMLuha2QOYJGdPVXur/6Z14R8yt9Z50zOGuO8egnmaNzxvwMnEg4v4MZrYiZARtFg/hPMj0n4sc69oJknPq/zVoyfiTEvGfxQ9rB2nLxMXECwTIycnzW/kOqT64RvNuoXV+qyKIrtHeExY181a4CM4jwOov8yHHK3kHqsMcx66o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717752157; c=relaxed/simple;
	bh=PxPoCnti8PmsO0RZO4P2cppfylAFmUMCeYLiTq60OZ8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=cp2QporPlO10UpolKH4/wLRTXciGuLyeLYLbRT6sq0C/jKHYqNfxRFgYXzk8cc0MfhlPOE0EVE2angjTZwWFUZFKL/sA30crpw7ejY80rPvYTvISrZRGnNBoCkJ4DJcmcNelsK01RxGDM/tW0fjz3x21yIIVxki6cAn9AKctk9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fHQ0Qfz3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717752154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SRqQ/AWbxoxEZebHKh1nFKhD+CG00A7FWiDUssUfhzw=;
	b=fHQ0Qfz3WmugUGjm1I0WZGPXTBeaJNM937/p+ZrPae/9k53YRbl2SJLFi0Fe0xzU7a019C
	cgdztOFWIU2jL7BgtSrmweb8DqwYu+M8hYTXKBG7zQb2GGpAdBc2bJtD1Bd6E5ROrqJ4IN
	RA4FWBqL9poF350+Cm0G5kVfWNu/QFs=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-_PqQxFEgP16EavU4SNhyxg-1; Fri, 07 Jun 2024 05:22:33 -0400
X-MC-Unique: _PqQxFEgP16EavU4SNhyxg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a592c35ac06so189693766b.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 02:22:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717752152; x=1718356952;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SRqQ/AWbxoxEZebHKh1nFKhD+CG00A7FWiDUssUfhzw=;
        b=Tn58AcdYd5JZ4rh7pxkQAI4AYzIve4nTC8uM+FjKKOOmfVMPrKk0xU/IX/m9p58RMQ
         RVHF2EHNSFBPTCKXgABk/G0cU4jVVxq6hL5BB0+HFM9pB7ahTfn7S6/kwHsMYISwGMyQ
         RjiPPaBbwSU10VW/c2TdIRxoPsWnQYo38zdYWisqXToESjDMvaFKys5LxBqBlJ4RgbRA
         ZwlHm9HKnkTNW8pVC7rsjHEynsDpqSkOwT3SXTo10M03jdnSsQupSvbgaDvq7rDhqwmB
         /UQWvi7fPtam6GLnrGTSjdAjiM5nNtVzzpPkrNXAgfLWDafUJFfhul/ya9uY10QNkPOa
         OKPw==
X-Gm-Message-State: AOJu0Yx2Hey8iGh8ho9ozUmBUr0f8leBgULTBAOg6F3G1yEjvJY7nQK9
	9bg0+BpdVKgl7eEBfFMg/PGWyDmVrKmynEo7xXxw79US/RWpzw84QBh7e0E+m9syApmdc5IMp/W
	IWAPuN/WtzDFA3dkBIFr2ywTNb424vA3rbaMApkcLIZGuXvRogYl75NKHLAD8Jw==
X-Received: by 2002:a17:906:684a:b0:a68:5fb6:1a7f with SMTP id a640c23a62f3a-a6c7629781cmr423081666b.21.1717752152160;
        Fri, 07 Jun 2024 02:22:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfabF485ZdkmsAwzX+jysrYwcbJShkygx3TpR3C7b7Kchhjzr88ulzEmZ6cuvF8E9LLmrfJQ==
X-Received: by 2002:a17:906:684a:b0:a68:5fb6:1a7f with SMTP id a640c23a62f3a-a6c7629781cmr423080466b.21.1717752151697;
        Fri, 07 Jun 2024 02:22:31 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c80586f8csm219107566b.40.2024.06.07.02.22.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jun 2024 02:22:31 -0700 (PDT)
Message-ID: <6d69dc47-67e5-468b-aa7c-879bbad7ef77@redhat.com>
Date: Fri, 7 Jun 2024 11:22:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans de Goede <hdegoede@redhat.com>
Subject: [GIT PULL] platform-drivers-x86 for 6.10-3
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 platform-driver-x86@vger.kernel.org,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Content-Language: en-US, nl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Here is the second round of fixes for platform-drivers-x86 for 6.10.

Highlights:
 -  Default silead touchscreen driver to 10 fingers and drop 10 finger setting
    from all DMI quirks. More of a cleanup then a pure fix, but since the DMI
    quirks always get updated through the fixes branch this avoids conflicts.
 -  Kconfig fix for randconfig builds
 -  dell-smbios: Fix wrong token data in sysfs
 -  amd-hsmp: Fix driver poking unsupported hw when loaded manually

Regards,

Hans


The following changes since commit 3050052613790e75b5e4a8536930426b0a8b0774:

  platform/x86: touchscreen_dmi: Add info for the EZpad 6s Pro (2024-05-27 11:43:03 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.10-3

for you to fetch changes up to 77f1972bdcf7513293e8bbe376b9fe837310ee9c:

  platform/x86/amd/hsmp: Check HSMP support on AMD family of processors (2024-06-03 11:57:28 +0200)

----------------------------------------------------------------
platform-drivers-x86 for v6.10-3

Highlights:
 -  Default silead touchscreen driver to 10 fingers and drop 10 finger setting
    from all DMI quirks. More of a cleanup then a pure fix, but since the DMI
    quirks always get updated through the fixes branch this avoids conflicts.
 -  Kconfig fix for randconfig builds
 -  dell-smbios: Fix wrong token data in sysfs
 -  amd-hsmp: Fix driver poking unsupported hw when loaded manually

The following is an automated git shortlog grouped by driver:

Input:
 -  silead - Always support 10 fingers

dell-smbios:
 -  Simplify error handling
 -  Fix wrong token data in sysfs

platform/x86/amd/hsmp:
 -  Check HSMP support on AMD family of processors

touchscreen_dmi:
 -  Use 2-argument strscpy()
 -  Drop "silead,max-fingers" property

yt2-1380:
 -  add CONFIG_EXTCON dependency

----------------------------------------------------------------
Andy Shevchenko (1):
      platform/x86: touchscreen_dmi: Use 2-argument strscpy()

Armin Wolf (2):
      platform/x86: dell-smbios: Fix wrong token data in sysfs
      platform/x86: dell-smbios: Simplify error handling

Arnd Bergmann (1):
      platform/x86: yt2-1380: add CONFIG_EXTCON dependency

Hans de Goede (2):
      Input: silead - Always support 10 fingers
      platform/x86: touchscreen_dmi: Drop "silead,max-fingers" property

Suma Hegde (1):
      platform/x86/amd/hsmp: Check HSMP support on AMD family of processors

 drivers/input/touchscreen/silead.c           |  19 ++---
 drivers/platform/x86/Kconfig                 |   1 +
 drivers/platform/x86/amd/hsmp.c              |  50 +++++++++++--
 drivers/platform/x86/dell/dell-smbios-base.c | 101 +++++++++++----------------
 drivers/platform/x86/touchscreen_dmi.c       |  59 +---------------
 5 files changed, 89 insertions(+), 141 deletions(-)


