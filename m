Return-Path: <linux-kernel+bounces-180885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB5B58C7461
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 12:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FB391C225CD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 10:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CB8143888;
	Thu, 16 May 2024 10:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LMtLWC/d"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B89143754
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 10:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715854063; cv=none; b=s4q43sLZsZV9c7Bog8lYPiWAO0v/j0Csgaismg8vxr4zF5CtR2NOYBBibwEFrPhaxdV7FOD/p62g4cUQVIBCOzpUCcyoP4dG0D14xxOziGTdN/fUVC0VwQmy7HUc3BBJV03XLG9W2CZ9+JkU/OwPIRe1X9YLqaqCii2JKmvlRts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715854063; c=relaxed/simple;
	bh=46cxWsxK7M6NmR+71K/PlmRRy2/uo3oiJ+k6Sdjaa7I=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=mWS098R2N14Intc9ysXcWdaxCb3Sau7ioXnGjqBfeKEsMJcWQBMLXbZkD8t10x/0QeRhhom8ZdUjYra2BpZ4g88Q6xyl1vRgsX1tnx/9RTtYXqMLo0EBrI+a3LU2hBq8gq2XHHAVSwbtx8Ven3CfE5ywtOpNr8HXoie2m8E36V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LMtLWC/d; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715854059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MQPWajTDOyNPAqun5OBH73OiFHOjggyuwMvlEj+T/p0=;
	b=LMtLWC/dr3lc+/BW5TPoJjgpjiUXyjcCqF1uMne8Y0GyaLDW7FGrYZx72D2D5Dq927BrPW
	EUgu4eMTbQBK2Wnyit5wmNCaYx6N78kVu8TqPeARxYqH94k4Mq4MQVtD1AnGBRHsN9Nwos
	H6DvMeGiGKMf5UHLRWWUf5OkRLrNHWo=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-viXCM23sPKGV6dTBUwogXg-1; Thu, 16 May 2024 06:07:38 -0400
X-MC-Unique: viXCM23sPKGV6dTBUwogXg-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-558aafe9bf2so2608276a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 03:07:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715854057; x=1716458857;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MQPWajTDOyNPAqun5OBH73OiFHOjggyuwMvlEj+T/p0=;
        b=dli1JX4eOqp24MHixxg8c9j+msc2v0X9hRMoejC5GczeP3krwX7VQaIKz4hz0EDhLx
         KQijwgJpbupdh4089bw4uch5Lgyo5Oqa8diem5VWjmzpPU9nxcyRNC6iwQHHmx3ex1Jn
         XNP5JYkUciKZABKvrxGW613g34MN/vg3qqKYmpb4+TZT/lesrNjielCGyTjV1syXR3rX
         QzkqJ+kYruW8wNwr4yrGPwIhLFErAn3h1MI4oIYYdIVY3qIpPdqz0DstEN50FiGD8STh
         8LCgbMClNgUHEj7wbk9lszuBA2xQN9itpgeGD4dpO8Euvzo6sqEYxAg0OlpusTGQ/0IH
         tcdw==
X-Forwarded-Encrypted: i=1; AJvYcCUOU3AgFIaSnmxGqsOdwkO5Lv6CnXopfIoekfFUgdKGjG20FMtz1ENSsTK5ye95eoY1qXVGLSxlUP9me9dz7x9GdEvx/jJNH+4Gt8dR
X-Gm-Message-State: AOJu0YxWChmN3Qmdug42pNwPOyHs0jxHbaPodEwZYidKpm24GQSr8vsq
	oGmegUUcFdF837HkoIMgaDUxS1z9JouBbm/qLTfeelua6b+1gHqJYk9oQBJ3jdgm1HijhiH1Y3E
	leE8LwP1KkVsnB+R+eVYMhyQJev8B2xsh6yNY4VuAL/TMbwJqG35TDCEck/0uIcLbQkErDA==
X-Received: by 2002:a50:9e44:0:b0:570:374:d6ab with SMTP id 4fb4d7f45d1cf-5734d590448mr14626987a12.3.1715854056977;
        Thu, 16 May 2024 03:07:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+dhw9hMeOKeKns5EIY2FqnytoK2sY5Qu+3fPs3dhF9cVDc3KFEcOZb22gS11RmtB6VBkP+Q==
X-Received: by 2002:a50:9e44:0:b0:570:374:d6ab with SMTP id 4fb4d7f45d1cf-5734d590448mr14626968a12.3.1715854056516;
        Thu, 16 May 2024 03:07:36 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-574eaace761sm3214085a12.91.2024.05.16.03.07.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 May 2024 03:07:35 -0700 (PDT)
Message-ID: <d9c1d381-be31-49e9-8a99-4a40a1344a66@redhat.com>
Date: Thu, 16 May 2024 12:07:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans de Goede <hdegoede@redhat.com>
Subject: [GIT PULL] platform-drivers-x86 for 6.10-1
To: Linus Torvalds <torvalds@linux-foundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Content-Language: en-US, nl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

Here is the main PDx86 PR for 6.10.

This includes a new drivers/platform/arm64 directory which is used
exclusively for arm64 laptop embedded controller (EC) drivers. This
has been put under the pdx86 umbrella because that is where most of
the experience with userspace APIs for EC functions lives.

Highlights:
 - New drivers for:
   - Acer Aspire 1 embedded controllers (for arm64 models)
   - ACPI quickstart PNP0C32 buttons
   - Dell All-In-One backlight support (dell-uart-backlight)
   - Lenovo WMI camera buttons
   - Lenovo Yoga Tablet 2 Pro 1380F/L fast charging
   - MeeGoPad ANX7428 Type-C Cross Switch (power sequencing only)
   - MSI WMI sensors (fan speed sensors only for now)
 - Asus WMI:
   - 2024 ROG Mini-LED support
   - MCU powersave support
   - Vivobook GPU MUX support
   - Misc. other improvements
 - Ideapad laptop:
   - Export FnLock LED as LED class device
   - Switch platform profiles using thermal management key
 - Intel drivers:
   - IFS: various improvements
   - PMC: Lunar Lake support
   - SDSI: various improvements
   - TPMI/ISST: various improvements
   - tools: intel-speed-select: various improvements
 - MS Surface drivers:
   - Fan profile switching support
   - Surface Pro thermal sensors support
 - ThinkPad ACPI:
   - Reworked hotkey support to use sparse keymaps
   - Add support for new trackpoint-doubletap, Fn+N and Fn+G hotkeys
 - WMI core:
   - New WMI driver development guide
 - x86 Android tablets:
   - Lenovo Yoga Tablet 2 Pro 1380F/L support
   - Xiaomi MiPad 2 status LED and bezel touch buttons backlight support
 - Miscellaneous cleanups / fixes / improvements


Regards,

Hans


The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.10-1

for you to fetch changes up to 2513563edc984c3cf05bca1244b46de06daa4755:

  platform/x86: Add new MeeGoPad ANX7428 Type-C Cross Switch driver (2024-05-15 10:07:11 +0200)

----------------------------------------------------------------
platform-drivers-x86 for v6.10-1

Highlights:
 - New drivers/platform/arm64 directory for arm64 embedded-controller drivers
 - New drivers for:
   - Acer Aspire 1 embedded controllers (for arm64 models)
   - ACPI quickstart PNP0C32 buttons
   - Dell All-In-One backlight support (dell-uart-backlight)
   - Lenovo WMI camera buttons
   - Lenovo Yoga Tablet 2 Pro 1380F/L fast charging
   - MeeGoPad ANX7428 Type-C Cross Switch (power sequencing only)
   - MSI WMI sensors (fan speed sensors only for now)
 - Asus WMI:
   - 2024 ROG Mini-LED support
   - MCU powersave support
   - Vivobook GPU MUX support
   - Misc. other improvements
 - Ideapad laptop:
   - Export FnLock LED as LED class device
   - Switch platform profiles using thermal management key
 - Intel drivers:
   - IFS: various improvements
   - PMC: Lunar Lake support
   - SDSI: various improvements
   - TPMI/ISST: various improvements
   - tools: intel-speed-select: various improvements
 - MS Surface drivers:
   - Fan profile switching support
   - Surface Pro thermal sensors support
 - ThinkPad ACPI:
   - Reworked hotkey support to use sparse keymaps
   - Add support for new trackpoint-doubletap, Fn+N and Fn+G hotkeys
 - WMI core:
   - New WMI driver development guide
 - x86 Android tablets:
   - Lenovo Yoga Tablet 2 Pro 1380F/L support
   - Xiaomi MiPad 2 status LED and bezel touch buttons backlight support
 - Miscellaneous cleanups / fixes / improvements

The following is an automated git shortlog grouped by driver:

ACPI:
 -  platform-profile: add platform_profile_cycle()

Add ACPI quickstart button (PNP0C32) driver:
 - Add ACPI quickstart button (PNP0C32) driver

Add lenovo-yoga-tab2-pro-1380-fastcharger driver:
 - Add lenovo-yoga-tab2-pro-1380-fastcharger driver

Add new Dell UART backlight driver:
 - Add new Dell UART backlight driver

Add lenovo WMI camera button driver:
 - Add lenovo WMI camera button driver

Add new MeeGoPad ANX7428 Type-C Cross Switch driver:
 - Add new MeeGoPad ANX7428 Type-C Cross Switch driver

ISST:
 -  Support SST-BF and SST-TF per level
 -  Add missing MODULE_DESCRIPTION
 -  Add dev_fmt
 -  Use in_range() to check package ID validity
 -  Support partitioned systems
 -  Shorten the assignments for power_domain_info
 -  Use local variable for auxdev->dev

MAINTAINERS:
 -  drop Daniel Oliveira Nascimento

arm64:
 -  dts: qcom: acer-aspire1: Add embedded controller

asus-laptop:
 -  Use sysfs_emit() and sysfs_emit_at() to replace sprintf()

asus-wmi:
 -  cleanup main struct to avoid some holes
 -  Add support for MCU powersave
 -  ROG Ally increase wait time, allow MCU powersave
 -  adjust formatting of ppt-<name>() functions
 -  store a min default for ppt options
 -  support toggling POST sound
 -  add support variant of TUF RGB
 -  add support for Vivobook GPU MUX
 -  add support for 2024 ROG Mini-LED
 -  use sysfs_emit() instead of sprintf()

classmate-laptop:
 -  Add missing MODULE_DESCRIPTION()

devm-helpers:
 -  Fix a misspelled cancellation in the comments

dt-bindings:
 -  leds: Add LED_FUNCTION_FNLOCK
 -  platform: Add Acer Aspire 1 EC

hp-wmi:
 -  use sysfs_emit() instead of sprintf()

huawei-wmi:
 -  use sysfs_emit() instead of sprintf()

ideapad-laptop:
 -  switch platform profiles using thermal management key
 -  add FnLock LED class device
 -  add fn_lock_get/set functions

intel-vbtn:
 -  Log event code on unexpected button events

intel/pmc:
 -  Enable S0ix blocker show in Lunar Lake
 -  Add support to show S0ix blocker counter
 -  Update LNL signal status map

msi-laptop:
 -  Use sysfs_emit() to replace sprintf()

p2sb:
 -  Don't init until unassigned resources have been assigned
 -  Make p2sb_get_devfn() return void

platform:
 -  arm64: Add Acer Aspire 1 embedded controller driver
 -  Add ARM64 platform directory

platform/surface:
 -  aggregator: Log critical errors during SAM probing
 -  aggregator_registry: Add support for thermal sensors on the Surface Pro 9
 -  platform_profile: add fan profile switching

platform/x86/amd:
 -  pmc: Add new ACPI ID AMDI000B
 -  pmf: Add new ACPI ID AMDI0105

platform/x86/amd/hsmp:
 -  switch to use device_add_groups()

platform/x86/amd/pmc:
 -  Fix implicit declaration error on i386
 -  Add AMD MP2 STB functionality

platform/x86/fujitsu-laptop:
 -  Replace sprintf() with sysfs_emit()

platform/x86/intel-uncore-freq:
 -  Don't present root domain on error

platform/x86/intel/ifs:
 -  Disable irq during one load stage
 -  trace: display batch num in hex
 -  Classify error scenarios correctly

platform/x86/intel/pmc:
 -  Fix PCH names in comments

platform/x86/intel/sdsi:
 -  Add attribute to read the current meter state
 -  Add in-band BIOS lock support
 -  Combine read and write mailbox flows
 -  Set message size during writes

platform/x86/intel/tpmi:
 -  Add additional TPMI header fields
 -  Align comments in kernel-doc
 -  Check major version change for TPMI Information
 -  Handle error from tpmi_process_info()

quickstart:
 -  Fix race condition when reporting input event
 -  fix Kconfig selects
 -  Miscellaneous improvements

samsung-laptop:
 -  Use sysfs_emit() to replace the old interface sprintf()

think-lmi:
 -  Convert container_of() macros to static inline

thinkpad_acpi:
 -  Use false to set acpi_send_ev to false
 -  Support hotkey to disable trackpoint doubletap
 -  Support for system debug info hotkey
 -  Support for trackpoint doubletap
 -  Simplify known_ev handling
 -  Add mappings for adaptive kbd clipping-tool and cloud keys
 -  Switch to using sparse-keymap helpers
 -  Drop KEY_RESERVED special handling
 -  Use correct keycodes for volume and brightness keys
 -  Change hotkey_reserved_mask initialization
 -  Do not send ACPI netlink events for unknown hotkeys
 -  Move tpacpi_driver_event() call to tpacpi_input_send_key()
 -  Move hkey > scancode mapping to tpacpi_input_send_key()
 -  Drop tpacpi_input_send_key_masked() and hotkey_driver_event()
 -  Always call tpacpi_driver_event() for hotkeys
 -  Move hotkey_user_mask check to tpacpi_input_send_key()
 -  Move special original hotkeys handling out of switch-case
 -  Move adaptive kbd event handling to tpacpi_driver_event()
 -  Make tpacpi_driver_event() return if it handled the event
 -  Do hkey to scancode translation later
 -  Use tpacpi_input_send_key() in adaptive kbd code
 -  Drop ignore_acpi_ev
 -  Drop setting send_/ignore_acpi_ev defaults twice
 -  Provide hotkey_poll_stop_sync() dummy
 -  Take hotkey_mutex during hotkey_exit()
 -  change sprintf() to sysfs_emit()
 -  use platform_profile_cycle()

tools arch x86:
 -  Add dell-uart-backlight-emulator

tools/arch/x86/intel_sdsi:
 -  Add current meter support
 -  Simplify ascii printing
 -  Fix meter_certificate decoding
 -  Fix meter_show display
 -  Fix maximum meter bundle length

tools/power/x86/intel-speed-select:
 -  v1.19 release
 -  Display CPU as None for -1
 -  SST BF/TF support per level
 -  Increase number of CPUs displayed
 -  Present all TRL levels for turbo-freq
 -  Fix display for unsupported levels
 -  Support multiple dies
 -  Increase die count

toshiba_acpi:
 -  Add quirk for buttons on Z830

uv_sysfs:
 -  use sysfs_emit() instead of sprintf()

wmi:
 -  Add MSI WMI Platform driver
 -  Add driver development guide
 -  Mark simple WMI drivers as legacy-free
 -  Avoid returning AE_OK upon unknown error
 -  Support reading/writing 16 bit EC values

x86-android-tablets:
 -  Create LED device for Xiaomi Pad 2 bottom bezel touch buttons
 -  Xiaomi pad2 RGB LED fwnode updates
 -  Pass struct device to init()
 -  Add Lenovo Yoga Tablet 2 Pro 1380F/L data
 -  Unregister devices in reverse order
 -  Add swnode for Xiaomi pad2 indicator LED
 -  Use GPIO_LOOKUP() macro

xiaomi-wmi:
 -  Drop unnecessary NULL checks
 -  Fix race condition when reporting key events

----------------------------------------------------------------
Ai Chao (5):
      platform/x86: hp-wmi: use sysfs_emit() instead of sprintf()
      platform/x86: asus-wmi: use sysfs_emit() instead of sprintf()
      platform/x86: huawei-wmi: use sysfs_emit() instead of sprintf()
      platform/x86: uv_sysfs: use sysfs_emit() instead of sprintf()
      platform/x86: add lenovo WMI camera button driver

Andy Shevchenko (4):
      platform/x86: quickstart: Miscellaneous improvements
      platform/x86: android-tablets: Use GPIO_LOOKUP() macro
      platform/x86: classmate-laptop: Add missing MODULE_DESCRIPTION()
      devm-helpers: Fix a misspelled cancellation in the comments

Armin Wolf (9):
      platform/x86: wmi: Support reading/writing 16 bit EC values
      platform/x86: wmi: Avoid returning AE_OK upon unknown error
      platform/x86: Add ACPI quickstart button (PNP0C32) driver
      platform/x86: quickstart: Fix race condition when reporting input event
      platform/x86: wmi: Mark simple WMI drivers as legacy-free
      platform/x86: xiaomi-wmi: Fix race condition when reporting key events
      platform/x86: xiaomi-wmi: Drop unnecessary NULL checks
      platform/x86: wmi: Add driver development guide
      platform/x86: wmi: Add MSI WMI Platform driver

Arnd Bergmann (1):
      platform/x86: quickstart: fix Kconfig selects

Arvid Norlander (1):
      platform/x86: toshiba_acpi: Add quirk for buttons on Z830

Basavaraj Natikar (2):
      platform/x86/amd/pmc: Add AMD MP2 STB functionality
      platform/x86/amd/pmc: Fix implicit declaration error on i386

Ben Fradella (1):
      platform/x86: p2sb: Don't init until unassigned resources have been assigned

Colin Ian King (1):
      platform/x86/intel/pmc: Fix PCH names in comments

David E. Box (8):
      platform/x86/intel/sdsi: Set message size during writes
      platform/x86/intel/sdsi: Combine read and write mailbox flows
      platform/x86/intel/sdsi: Add attribute to read the current meter state
      tools/arch/x86/intel_sdsi: Fix maximum meter bundle length
      tools/arch/x86/intel_sdsi: Fix meter_show display
      tools/arch/x86/intel_sdsi: Fix meter_certificate decoding
      tools/arch/x86/intel_sdsi: Simplify ascii printing
      tools/arch/x86/intel_sdsi: Add current meter support

Gergo Koteles (6):
      dt-bindings: leds: Add LED_FUNCTION_FNLOCK
      platform/x86: ideapad-laptop: add fn_lock_get/set functions
      platform/x86: ideapad-laptop: add FnLock LED class device
      ACPI: platform-profile: add platform_profile_cycle()
      platform/x86: ideapad-laptop: switch platform profiles using thermal management key
      platform/x86: thinkpad_acpi: use platform_profile_cycle()

Greg Kroah-Hartman (1):
      platform/x86/amd/hsmp: switch to use device_add_groups()

Hans de Goede (31):
      platform/x86: p2sb: Make p2sb_get_devfn() return void
      platform/x86: intel-vbtn: Log event code on unexpected button events
      platform/x86: x86-android-tablets: Unregister devices in reverse order
      platform/x86: x86-android-tablets: Add Lenovo Yoga Tablet 2 Pro 1380F/L data
      platform/x86: thinkpad_acpi: Take hotkey_mutex during hotkey_exit()
      platform/x86: thinkpad_acpi: Provide hotkey_poll_stop_sync() dummy
      platform/x86: thinkpad_acpi: Drop setting send_/ignore_acpi_ev defaults twice
      platform/x86: thinkpad_acpi: Drop ignore_acpi_ev
      platform/x86: thinkpad_acpi: Use tpacpi_input_send_key() in adaptive kbd code
      platform/x86: thinkpad_acpi: Do hkey to scancode translation later
      platform/x86: thinkpad_acpi: Make tpacpi_driver_event() return if it handled the event
      platform/x86: thinkpad_acpi: Move adaptive kbd event handling to tpacpi_driver_event()
      platform/x86: thinkpad_acpi: Move special original hotkeys handling out of switch-case
      platform/x86: thinkpad_acpi: Move hotkey_user_mask check to tpacpi_input_send_key()
      platform/x86: thinkpad_acpi: Always call tpacpi_driver_event() for hotkeys
      platform/x86: thinkpad_acpi: Drop tpacpi_input_send_key_masked() and hotkey_driver_event()
      platform/x86: thinkpad_acpi: Move hkey > scancode mapping to tpacpi_input_send_key()
      platform/x86: thinkpad_acpi: Move tpacpi_driver_event() call to tpacpi_input_send_key()
      platform/x86: thinkpad_acpi: Do not send ACPI netlink events for unknown hotkeys
      platform/x86: thinkpad_acpi: Change hotkey_reserved_mask initialization
      platform/x86: thinkpad_acpi: Use correct keycodes for volume and brightness keys
      platform/x86: thinkpad_acpi: Drop KEY_RESERVED special handling
      platform/x86: thinkpad_acpi: Switch to using sparse-keymap helpers
      platform/x86: thinkpad_acpi: Add mappings for adaptive kbd clipping-tool and cloud keys
      platform/x86: thinkpad_acpi: Use false to set acpi_send_ev to false
      platform/x86: Add lenovo-yoga-tab2-pro-1380-fastcharger driver
      platform/x86: x86-android-tablets: Pass struct device to init()
      platform/x86: x86-android-tablets: Create LED device for Xiaomi Pad 2 bottom bezel touch buttons
      platform/x86: Add new Dell UART backlight driver
      tools arch x86: Add dell-uart-backlight-emulator
      platform/x86: Add new MeeGoPad ANX7428 Type-C Cross Switch driver

Ilpo Järvinen (1):
      platform/x86: think-lmi: Convert container_of() macros to static inline

Ivor Wanders (1):
      platform/surface: platform_profile: add fan profile switching

Jithu Joseph (3):
      platform/x86/intel/ifs: Classify error scenarios correctly
      platform/x86/intel/ifs: trace: display batch num in hex
      platform/x86/intel/ifs: Disable irq during one load stage

Kate Hsuan (2):
      platform/x86: x86-android-tablets: Add swnode for Xiaomi pad2 indicator LED
      platform/x86: x86-android-tablets: Xiaomi pad2 RGB LED fwnode updates

Krzysztof Kozlowski (1):
      platform/x86: MAINTAINERS: drop Daniel Oliveira Nascimento

Kuppuswamy Sathyanarayanan (1):
      platform/x86/intel/sdsi: Add in-band BIOS lock support

Luke D. Jones (9):
      platform/x86: asus-wmi: add support for 2024 ROG Mini-LED
      platform/x86: asus-wmi: add support for Vivobook GPU MUX
      platform/x86: asus-wmi: add support variant of TUF RGB
      platform/x86: asus-wmi: support toggling POST sound
      platform/x86: asus-wmi: store a min default for ppt options
      platform/x86: asus-wmi: adjust formatting of ppt-<name>() functions
      platform/x86: asus-wmi: ROG Ally increase wait time, allow MCU powersave
      platform/x86: asus-wmi: Add support for MCU powersave
      platform/x86: asus-wmi: cleanup main struct to avoid some holes

Mark Pearson (4):
      platform/x86: thinkpad_acpi: Simplify known_ev handling
      platform/x86: thinkpad_acpi: Support for trackpoint doubletap
      platform/x86: thinkpad_acpi: Support for system debug info hotkey
      platform/x86: thinkpad_acpi: Support hotkey to disable trackpoint doubletap

Maximilian Luz (1):
      platform/surface: aggregator_registry: Add support for thermal sensors on the Surface Pro 9

Nikita Travkin (4):
      dt-bindings: platform: Add Acer Aspire 1 EC
      platform: Add ARM64 platform directory
      platform: arm64: Add Acer Aspire 1 embedded controller driver
      arm64: dts: qcom: acer-aspire1: Add embedded controller

Shyam Sundar S K (2):
      platform/x86/amd: pmf: Add new ACPI ID AMDI0105
      platform/x86/amd: pmc: Add new ACPI ID AMDI000B

Srinivas Pandruvada (20):
      platform/x86/intel-uncore-freq: Don't present root domain on error
      platform/x86/intel/tpmi: Handle error from tpmi_process_info()
      platform/x86/intel/tpmi: Check major version change for TPMI Information
      platform/x86/intel/tpmi: Align comments in kernel-doc
      platform/x86/intel/tpmi: Add additional TPMI header fields
      platform/x86: ISST: Use local variable for auxdev->dev
      platform/x86: ISST: Shorten the assignments for power_domain_info
      platform/x86: ISST: Support partitioned systems
      platform/x86: ISST: Use in_range() to check package ID validity
      platform/x86: ISST: Add dev_fmt
      platform/x86: ISST: Add missing MODULE_DESCRIPTION
      tools/power/x86/intel-speed-select: Increase die count
      tools/power/x86/intel-speed-select: Support multiple dies
      tools/power/x86/intel-speed-select: Fix display for unsupported levels
      tools/power/x86/intel-speed-select: Present all TRL levels for turbo-freq
      tools/power/x86/intel-speed-select: Increase number of CPUs displayed
      tools/power/x86/intel-speed-select: SST BF/TF support per level
      tools/power/x86/intel-speed-select: Display CPU as None for -1
      tools/power/x86/intel-speed-select: v1.19 release
      platform/x86: ISST: Support SST-BF and SST-TF per level

Szilard Fabian (1):
      platform/x86/fujitsu-laptop: Replace sprintf() with sysfs_emit()

Weifeng Liu (1):
      platform/surface: aggregator: Log critical errors during SAM probing

Xi Pardee (3):
      platform/x86:intel/pmc: Update LNL signal status map
      platform/x86:intel/pmc: Add support to show S0ix blocker counter
      platform/x86:intel/pmc: Enable S0ix blocker show in Lunar Lake

yunshui (4):
      platform/x86: thinkpad_acpi: change sprintf() to sysfs_emit()
      platform/x86: msi-laptop: Use sysfs_emit() to replace sprintf()
      platform/x86: samsung-laptop: Use sysfs_emit() to replace the old interface sprintf()
      platform/x86: asus-laptop: Use sysfs_emit() and sysfs_emit_at() to replace sprintf()

 Documentation/ABI/testing/debugfs-msi-wmi-platform |  14 +
 Documentation/ABI/testing/sysfs-platform-asus-wmi  |  26 +
 .../bindings/platform/acer,aspire1-ec.yaml         |  60 ++
 Documentation/wmi/devices/msi-wmi-platform.rst     | 194 +++++
 Documentation/wmi/driver-development-guide.rst     | 178 +++++
 Documentation/wmi/index.rst                        |   1 +
 MAINTAINERS                                        |  31 +-
 arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts   |  40 +-
 drivers/acpi/platform_profile.c                    |  39 +
 drivers/platform/Kconfig                           |   2 +
 drivers/platform/Makefile                          |   1 +
 drivers/platform/arm64/Kconfig                     |  35 +
 drivers/platform/arm64/Makefile                    |   8 +
 drivers/platform/arm64/acer-aspire1-ec.c           | 562 +++++++++++++
 drivers/platform/surface/aggregator/core.c         |  42 +-
 .../platform/surface/surface_aggregator_registry.c |  43 +-
 .../platform/surface/surface_platform_profile.c    |  88 ++-
 drivers/platform/x86/Kconfig                       |  58 ++
 drivers/platform/x86/Makefile                      |   9 +
 drivers/platform/x86/amd/hsmp.c                    |   2 +-
 drivers/platform/x86/amd/pmc/Kconfig               |  15 +
 drivers/platform/x86/amd/pmc/Makefile              |   1 +
 drivers/platform/x86/amd/pmc/mp2_stb.c             | 280 +++++++
 drivers/platform/x86/amd/pmc/pmc.c                 |   5 +
 drivers/platform/x86/amd/pmc/pmc.h                 |  15 +
 drivers/platform/x86/amd/pmf/core.c                |   1 +
 drivers/platform/x86/asus-laptop.c                 |  44 +-
 drivers/platform/x86/asus-wmi.c                    | 417 +++++++---
 drivers/platform/x86/classmate-laptop.c            |   4 +-
 drivers/platform/x86/dell/Kconfig                  |  15 +
 drivers/platform/x86/dell/Makefile                 |   1 +
 drivers/platform/x86/dell/dell-uart-backlight.c    | 398 ++++++++++
 drivers/platform/x86/fujitsu-laptop.c              |  18 +-
 drivers/platform/x86/hp/hp-wmi.c                   |  12 +-
 drivers/platform/x86/huawei-wmi.c                  |   8 +-
 drivers/platform/x86/ideapad-laptop.c              | 140 +++-
 drivers/platform/x86/inspur_platform_profile.c     |   1 +
 drivers/platform/x86/intel/ifs/load.c              |   2 +
 drivers/platform/x86/intel/ifs/runtest.c           |  27 +-
 drivers/platform/x86/intel/pmc/arl.c               |   2 +-
 drivers/platform/x86/intel/pmc/core.c              |  38 +
 drivers/platform/x86/intel/pmc/core.h              |   9 +
 drivers/platform/x86/intel/pmc/lnl.c               | 477 ++++++-----
 drivers/platform/x86/intel/sdsi.c                  | 118 ++-
 .../x86/intel/speed_select_if/isst_if_common.c     |   1 +
 .../x86/intel/speed_select_if/isst_tpmi_core.c     | 387 +++++++--
 drivers/platform/x86/intel/tpmi.c                  |  39 +-
 .../intel/uncore-frequency/uncore-frequency-tpmi.c |   7 +
 drivers/platform/x86/intel/vbtn.c                  |   3 +-
 drivers/platform/x86/lenovo-wmi-camera.c           | 127 +++
 .../x86/lenovo-yoga-tab2-pro-1380-fastcharger.c    | 338 ++++++++
 drivers/platform/x86/meegopad_anx7428.c            | 150 ++++
 drivers/platform/x86/msi-laptop.c                  |  20 +-
 drivers/platform/x86/msi-wmi-platform.c            | 428 ++++++++++
 drivers/platform/x86/p2sb.c                        |  44 +-
 drivers/platform/x86/quickstart.c                  | 246 ++++++
 drivers/platform/x86/samsung-laptop.c              |  10 +-
 drivers/platform/x86/think-lmi.c                   |  13 +-
 drivers/platform/x86/thinkpad_acpi.c               | 875 +++++++++------------
 drivers/platform/x86/toshiba_acpi.c                |  36 +-
 drivers/platform/x86/uv_sysfs.c                    |  20 +-
 drivers/platform/x86/wmi.c                         |  60 +-
 drivers/platform/x86/x86-android-tablets/core.c    |  16 +-
 drivers/platform/x86/x86-android-tablets/dmi.c     |  18 +
 drivers/platform/x86/x86-android-tablets/lenovo.c  | 224 +++++-
 drivers/platform/x86/x86-android-tablets/other.c   | 133 +++-
 .../x86/x86-android-tablets/x86-android-tablets.h  |   3 +-
 drivers/platform/x86/xiaomi-wmi.c                  |  30 +-
 include/dt-bindings/leds/common.h                  |   1 +
 include/linux/devm-helpers.h                       |   4 +-
 include/linux/intel_tpmi.h                         |  12 +-
 include/linux/platform_data/x86/asus-wmi.h         |   6 +
 include/linux/platform_profile.h                   |   1 +
 include/trace/events/intel_ifs.h                   |   2 +-
 .../x86/dell-uart-backlight-emulator/.gitignore    |   1 +
 .../arch/x86/dell-uart-backlight-emulator/Makefile |  19 +
 tools/arch/x86/dell-uart-backlight-emulator/README |  46 ++
 .../dell-uart-backlight-emulator.c                 | 163 ++++
 tools/arch/x86/intel_sdsi/intel_sdsi.c             | 108 ++-
 tools/power/x86/intel-speed-select/isst-config.c   |  25 +-
 .../power/x86/intel-speed-select/isst-core-mbox.c  |   3 +-
 .../power/x86/intel-speed-select/isst-core-tpmi.c  |  10 +-
 tools/power/x86/intel-speed-select/isst-core.c     |   1 +
 tools/power/x86/intel-speed-select/isst-display.c  |  30 +-
 tools/power/x86/intel-speed-select/isst.h          |   2 +-
 85 files changed, 5942 insertions(+), 1201 deletions(-)
 create mode 100644 Documentation/ABI/testing/debugfs-msi-wmi-platform
 create mode 100644 Documentation/devicetree/bindings/platform/acer,aspire1-ec.yaml
 create mode 100644 Documentation/wmi/devices/msi-wmi-platform.rst
 create mode 100644 Documentation/wmi/driver-development-guide.rst
 create mode 100644 drivers/platform/arm64/Kconfig
 create mode 100644 drivers/platform/arm64/Makefile
 create mode 100644 drivers/platform/arm64/acer-aspire1-ec.c
 create mode 100644 drivers/platform/x86/amd/pmc/mp2_stb.c
 create mode 100644 drivers/platform/x86/dell/dell-uart-backlight.c
 create mode 100644 drivers/platform/x86/lenovo-wmi-camera.c
 create mode 100644 drivers/platform/x86/lenovo-yoga-tab2-pro-1380-fastcharger.c
 create mode 100644 drivers/platform/x86/meegopad_anx7428.c
 create mode 100644 drivers/platform/x86/msi-wmi-platform.c
 create mode 100644 drivers/platform/x86/quickstart.c
 create mode 100644 tools/arch/x86/dell-uart-backlight-emulator/.gitignore
 create mode 100644 tools/arch/x86/dell-uart-backlight-emulator/Makefile
 create mode 100644 tools/arch/x86/dell-uart-backlight-emulator/README
 create mode 100644 tools/arch/x86/dell-uart-backlight-emulator/dell-uart-backlight-emulator.c


