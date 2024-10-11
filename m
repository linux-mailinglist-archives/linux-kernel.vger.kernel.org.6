Return-Path: <linux-kernel+bounces-360483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3690999BA1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 06:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62500285AE8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 04:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C671F4FA0;
	Fri, 11 Oct 2024 04:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b="WHhvC0vj"
Received: from mail-io1-f66.google.com (mail-io1-f66.google.com [209.85.166.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F1F1A0704
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 04:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728620832; cv=none; b=XK4LPEqLjkvHJhW4Ky3Qv52/qgcproe6ikdgaF5SopOsaHysglQejmC9EGOagBXPS153Kpmmwu5wyM84GGlD1xsOxBNiKFd4i3onasDXUYaeIwx06YM/91mbcVFunCzfWChN8F5m/v/DjGzWrKmGcypM/WHh/8h0r+cBAnOaHYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728620832; c=relaxed/simple;
	bh=D13xg27l7oD6WfxZx+HOLJmlei96HBYLbtXUemAcwkE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QgPWXK3vBatGItc9l214nEtPYJunWafw2Co8A0/4WuOAOyNJUFlNvE4j9eZy2F7NqMQpLrqvAHe3zSEMIpWVqWEgFVfiTfbeEYgtWVrm8FhwK1WtQk8lufDfP3WAl50k+ytbPVx8RaXEAIzT/O/WWj839yJ9FRiAjWtNlCQ65IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org; spf=pass smtp.mailfrom=kfocus.org; dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b=WHhvC0vj; arc=none smtp.client-ip=209.85.166.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kfocus.org
Received: by mail-io1-f66.google.com with SMTP id ca18e2360f4ac-8354599fd8aso62227139f.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 21:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kfocus-org.20230601.gappssmtp.com; s=20230601; t=1728620824; x=1729225624; darn=vger.kernel.org;
        h=mime-version:organization:references:in-reply-to:message-id:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GnnQTxo1mxtUcp5Jov+4kxx1UfBqVkC0tLEQdRPxumk=;
        b=WHhvC0vjHya0MK3eyJImcyqIYRIWt71UE/4qFwxZQdMCZePyrSbmHEGcDysuhsh0h1
         UHlXFafUpIcng/eGggxABchaCL5cq66JrcpQfRl5v9nXX79uVaiTyYPtgra3X0NZSjLo
         7z9QUgTgGs3hrR7UHebgqSNp3oEPa5Vw9xWlwkElE2qfd8CuSV0wEXwJXJCx6JoBjdAG
         OF68sTOUdBBUoujEfuBGXlZqKBWKbXmheHjTMoIbBAtP/M+CWCGxAHi9+YmseVzYoGBp
         2Un/FzXSw4+5VzV00qYky0a9JPilgCsejGVXXxq3dg9nqwy9OPJr/0uGxa6zwFfYCrUn
         IRTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728620824; x=1729225624;
        h=mime-version:organization:references:in-reply-to:message-id:subject
         :cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GnnQTxo1mxtUcp5Jov+4kxx1UfBqVkC0tLEQdRPxumk=;
        b=CSUqNgOKzdatntHWD2W3iLCODI3lYN3+bRjv47u4PLJNmOk/njwbIRvl/MG6PA6LD4
         AOISpa8F2m405mVDsoVsfb0Wd2bOSTTGVdDXvPw21Z945tydgSPi5L1zRwVWJ3QbyKzB
         WWjV2MSucm3hLlTx2MZ5Z4wtBuqnhX0M3FpzK4IFFS1TcqavNMfmBnP8MMpGggAgylZo
         K/TLzJJTwfpXSnI+tuCs50qf1oNNHHOG7oH71hCQxgSGX3Ygw6sK2A1RaCMgO5CIZdYn
         AnX3JoC/VVOsSTrjvAD3uhfnly5o6wtFiPqiYNnEdvj9ulZQpVZTyqpktyalNLfLyS7w
         cjVA==
X-Forwarded-Encrypted: i=1; AJvYcCUyhUxy42pu0oogw1+v1kB56+9Qh7nri24i+XAZDJL/pBxwA7AB4WUvwe/EdIlmWN7kF833J1D5GWicntE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeFI2m/B1FRY6H8uQE49BUelwpbQtpXu9+uqIb/YjtqXHuZjfV
	0I3Os8jUDCgbAN+bpnzrsNIdJPNics3RBxVGfo+HO2XEJOsSv96jbMmTJ++nfd4=
X-Google-Smtp-Source: AGHT+IF0+AqH5hIMkdm6FvozjSyb9Peppl66cWU/6HfdU3j+vN3gEFzR7a1I/0F/jhgtbj//LlvxzQ==
X-Received: by 2002:a05:6602:2c87:b0:835:46e0:d169 with SMTP id ca18e2360f4ac-8379250fe62mr92153139f.1.1728620824194;
        Thu, 10 Oct 2024 21:27:04 -0700 (PDT)
Received: from kf-ir16 ([2607:fb91:1111:56d8:ac6a:66ff:e76d:be16])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-835ca82369asm44736639f.20.2024.10.10.21.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 21:27:03 -0700 (PDT)
Date: Thu, 10 Oct 2024 23:26:56 -0500
From: Aaron Rainbolt <arainbolt@kfocus.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: YehezkelShB@gmail.com, michael.jamet@intel.com,
 andreas.noever@gmail.com, linux-usb@vger.kernel.org, mmikowski@kfocus.org,
 linux-kernel@vger.kernel.org
Subject: Re: USB-C DisplayPort display failing to stay active with Intel
 Barlow Ridge USB4 controller, power-management related issue?
Message-ID: <20241010232656.7fc6359e@kf-ir16>
In-Reply-To: <20241010044919.GD275077@black.fi.intel.com>
References: <20241009220118.70bfedd0@kf-ir16>
	<20241010044919.GD275077@black.fi.intel.com>
Organization: Kubuntu Focus
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/XUtY2b=33lKMSh9PCBuX0pe"

--MP_/XUtY2b=33lKMSh9PCBuX0pe
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thu, 10 Oct 2024 07:49:19 +0300
Mika Westerberg <mika.westerberg@linux.intel.com> wrote:

> Hi,
>=20
> On Wed, Oct 09, 2024 at 10:01:18PM -0500, Aaron Rainbolt wrote:
> > We're experiencing a Linux kernel bug affecting multiple Clevo
> > X370SNx1 laptops (specifically the X370SNW1 variant). The bug
> > appears to be present in kernels greater than or equal to 6.5,
> > worsening significantly with kernel 6.11.2 (latest stable at time
> > of this writing). It is unclear if all of the issues encountered
> > are the same bug, however the primary problem we've run into
> > appears to be a consequence of the power management code involving
> > Intel Barlow Ridge controllers and DisplayPort. The issue occurs
> > with in-kernel Nouveau drivers and also with proprietary NVIDIA
> > drivers.
> >=20
> > When a DisplayPort monitor is attached to these laptops via a USB-C
> > connection, the monitor is recognized by the system and comes on for
> > approximately 15 seconds. It then blanks out and is automatically
> > disconnected from the system as if it had been unplugged. It will
> > remain that way indefinitely until unplugged and replugged, or until
> > something "jiggles" (for lack of a better term) the thunderbolt
> > driver. When either of these things occur, the display will
> > re-attach and come back on for 15 seconds, then blank out and
> > detach again. There are various different things that can "jiggle"
> > the thunderbolt driver, including but not limited to:
> >=20
> > * Running `lspci -k` (this one came as a particular surprise)
> > * Removing and re-inserting the thunderbolt driver (`sudo modprobe
> > -r thunderbolt; sleep 1; sudo modprobe thunderbolt`)
> > * Running `nvidia-detector` while proprietary NVIDIA drivers are
> > loaded =20
>=20
> Or just disabling runtime PM, I presume.
>=20
> > It is possible to mitigate this issue by simply running
> > `sudo modprobe -r thunderbolt` or `sudo rmmod thunderbolt` and then
> > leaving the driver unloaded. USB-C displays become stable after
> > this - they are recognized when attached and remain recognized and
> > functional indefinitely as one would expect.
> >=20
> > We believe this is related to the Intel Barlow Ridge USB4 controller
> > because:
> >=20
> > * Removing the thunderbolt driver restores normal display operation.
> > * This issue was *not* a problem on Clevo X370SNx machines, which
> > are identical to the X370SNx1 except for the Maple Ridge TBT
> > controller on the board has been replaced with a Barlow Ridge USB4
> > controller.
> > * This problem does not occur on the affected models with the 6.1
> >   kernel. It occurs with the 6.5 kernel and on all newer kernels we
> >   have tried.
> >=20
> > Furthermore, from inspecting the Thunderbolt driver code, we believe
> > this is related to the power management features of the driver,
> > because:
> >=20
> > * There is only one 15-second timeout defined in the driver source
> >   code, that being TB_AUTOSUSPEND_DELAY in drivers/thunderbolt/tb.h
> > * On earlier kernels (Ubuntu=E2=80=99s variant of 6.8 at least), displa=
ys
> > are stable even when the thunderbolt driver is loaded if we:
> >   * Remove the thunderbolt driver
> >   * Attach a USB-C dock
> >   * Attach displays to the dock (we used 2 4K HDMI monitors)
> >   * Reload the thunderbolt driver
> >=20
> > During our investigation, we discovered commit
> > a75e0684efe567ae5f6a8e91a8360c4c1773cf3a (patch on mailing list at
> > https://lore.kernel.org/linux-usb/20240213114318.3023150-1-mika.westerb=
erg@linux.intel.com/)
> > which appears to be a fix for this exact problem. It adds a quirk
> > for Intel Barlow Ridge controllers, which detects when a
> > DisplayPort device has been plugged directly into the USB4 port
> > (thus using "redrive" mode), and instructs the power management
> > subsystem to not power the chip down during this time if so.
> > Unfortunately, this quirk seems to be silently ignored, as we built
> > a custom kernel with some `printk` lines added to the
> > `tb_enter_redrive` and `tb_exit_redrive` functions to announce when
> > they were called, and nothing in the dmesg log indicated that they
> > had been called when we did this.
> >=20
> > This bug is easily reproducible using the stock kernels in Kubuntu
> > 22.04, Kubuntu 24.04, Kali Linux 2024.2, and Fedora Workstation
> > Rawhide. Similar behavior is observed across all of these
> > distributions.
> >=20
> > We built the 6.11.2 kernel from source and tested it on Kubuntu
> > 24.04, but while the kernel built, installed, and functioned
> > properly in most respects, it actually made the problem with USB-C
> > displays worse. As long as the thunderbolt driver was loaded, no
> > displays were detected when plugged in (not for even a short length
> > of time), and when the thunderbolt driver was unloaded, displays
> > would only be recognized and function if there was only one display
> > attached. Attaching a second display resulted in the first external
> > display becoming detached and the second display not coming on.
> > Unplugging the second display resulted in the first display
> > reattaching. This machine supports up to three external displays
> > and this has proven to be achievable and stable with earlier
> > kernels. No valuable error messages were logged in dmesg when these
> > problems occurred.
> >=20
> > Our testing has been limited to the Clevo X370SNW1 model, however we
> > expect that the X370SNV1 model will exhibit the same issues as it
> > uses very similar internal components on the system board.
> >=20
> > This is basically the extent of our knowledge at this point. We
> > attempted various patches on Ubuntu's 6.8 kernel to resolve the
> > issue, all without success:
> >=20
> > * We attempted reverting fd4d58d1fef9ae9b0ee235eaad73d2e0a6a73025
> >   (thunderbolt: Enable CL2 low power state), which had no effect.
> > * We noticed that one of the Barlow Ridge bridge controllers
> >   listed by `lspci -k` appeared to not have its device ID in
> >   drivers/thunderbolt/nhi.h and there was a corresponding quirk in
> >   drivers/thunderbolt/quirks.c that looked like it might be vaguely
> >   related to the issue (specifically quirk_usb3_maximum_bandwidth),
> > so we tried adding that device to the appropriate files in order to
> > make that quirk apply to that device as well, this had no visible
> > effect on the kernel's operation and did not resolve the issue.
> > * After narrowing it down to `quirk_block_rpm_in_redrive`, we
> > attempted adding a new `thunderbolt.kf_force_redrive` kernel
> > parameter in drivers/thunderbolt/tb.c that forced the code in
> >   `tb_enter_redrive` and `tb_exit_redrive` to be executed even *if*
> > the device didn't have the appropriate quirk bit set, in the hopes
> > that this would make the quirk execute and resolve the issue. What
> > ended up happening was somehow `tb_enter_redrive` was never called
> > at all and `tb_exit_redrive` was called. This in turn made it so
> > that no USB-C displays would even be recognized for a short period
> > of time if the thunderbolt driver was loaded.
> > * Looking at PCI vendor IDs, we noticed that the PCI vendor ID used
> > to recognize all Intel controllers in drivers/thunderbolt/quirks.c
> > was 0x8087, whereas the Barlow Ridge controller in our device
> > reported a vendor ID of 0x8086. On the off chance that this was a
> > typo of epic proportions, we tried adjusting all of the occurrences
> > of 0x8087 in the tb_quirks[] array to PCI_VENDOR_ID_INTEL (which is
> > defined as 0x8086 in include/linux/pci_ids.h). This has no visible
> > effect on the kernel's behavior, and did not resolve the issue.
> > (Presumably there's something going on with the IDs there that
> > we're not aware of.)
> >=20
> > As to my speculation as to what's wrong, I believe this is likely a
> > combination of two things:
> >=20
> > * Some data in the `tb_quirks` array in
> > drivers/thunderbolt/quirks.c is incorrect and leading to the Barlow
> > Ridge controllers not being recognized as needing the DisplayPort
> > redrive mode quirk.
> > * The code in drivers/thunderbolt/tb.c `tb_dp_resource_unavailable`
> >   that controls whether or not to run `tb_enter_redrive` is faulty
> > in some way and is not calling `tb_enter_redrive` in all scenarios
> > where it is necessary. To be clear, the exact code I'm talking
> > about is this chunk from the aforementioned function:
> >=20
> >         tunnel =3D tb_find_tunnel(tb, TB_TUNNEL_DP, in, out);
> >         if (tunnel)
> >                 tb_deactivate_and_free_tunnel(tunnel);
> >         else=20
> >                 tb_enter_redrive(port);
> >=20
> > Finally, this is probably a result of me misreading the driver code
> > somehow, but I was surprised by the following conditional at the top
> > of `tb_enter_redrive`:
> >=20
> >         if (!(sw->quirks & QUIRK_KEEP_POWER_IN_DP_REDRIVE))
> >                 return;
> >=20
> > To me this reads as "if the DP redrive quirk bit is set, return and
> > do nothing. Otherwise, if the bit is not set, run the quirk
> > function." =20
>=20
> There is the "return;" which reads that if the quirk is not set,
> return from this function early.
>=20
> > This is the opposite of what I would expect - shouldn't the code
> > run if the bit is set, not if it is clear? Or does the bit being
> > unset mean that the quirk is active? (I do not believe that this is
> > the root cause of the issue because even when I forced this
> > function to run any time it was invoked, it wasn't being invoked at
> > all.) =20
>=20
> Okay, thanks for the very detailed report.
>=20
> We need bit more information to investigate this. The commit you
> referred is exactly for this purpose and I'm surprised it did not work
> but also the Barlow Ridge PCI IDs are suprised too, as if this would
> have some old firmware or something.
>=20
> Can you share full dmesg with the repro and "thunderbolt.dyndbg=3D+p" in
> the kernel command line?

The full log is very long, so I've included it as an email attachment.
The exact steps taken after booting with the requested kernel parameter
were:

1. boot with thunderbolt.dyndbg=3D+p kernel param, no USB-C plugged in.
2. After login, hot-plug two USB-C cables. This time, the displays came
  up and stayed resident (this happens sometimes)
3. Unplugged both cables.
4. Replugged both. This time, the displays did not show anything.
5. lspci -k "jiggled" the displays and they came back on.
6. After ~15s, the displays blacked out again.
7. Save to the demsg file after about 30s.

The laptop's firmware is fully up-to-date. One of the fixes we tried
was installing Windows 11, updating the firmware, and then
re-installing Kubuntu 24.04. This had no effect on the issue.

Notes:

* Kernel 6.1 does not exhibit this time out. 6.5 and later do.
* Windows 11 had very similar behavior before installing Windows
  updates. After update, it was fixed.
* All distros and W11 were tested on the same hardware with the latest
  firmware, so we know this is not a hardware failure.

Thanks for your help!

--MP_/XUtY2b=33lKMSh9PCBuX0pe
Content-Type: text/x-log
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=2024-10-10-thunderbolt.dyndbg+p.log

[    0.000000] Linux version 6.8.0-45-kfocus (buildd@lcy02-amd64-017) (x86_64-linux-gnu-gcc-13 (Ubuntu 13.2.0-23ubuntu4) 13.2.0, GNU ld (GNU Binutils for Ubuntu) 2.42) #45+kfocus2-Ubuntu SMP PREEMPT_DYNAMIC Fri Oct  4 17:21:48 UTC 2 (Ubuntu 6.8.0-45.45+kfocus2-kfocus 6.8.12)
[    0.000000] Command line: BOOT_IMAGE=/@boot/vmlinuz-6.8.0-45-kfocus root=UUID=d4f6fb42-b08b-4b54-a060-a4e3fc1f51fd ro rootflags=subvol=@ quiet cryptdevice=UUID=9992e62a-e20e-4d65-8cd4-d1988f6f3ab3:luks-9992e62a-e20e-4d65-8cd4-d1988f6f3ab3 root=/dev/mapper/luks-9992e62a-e20e-4d65-8cd4-d1988f6f3ab3 splash modprobe.blacklist=nouveau modprobe.blacklist=ucsi_acpi tpm_tis.interrupts=0 intel_pstate=passive snd_hda_core.gpu_bind=0 pci=noaer loglevel=3 vt.handoff=7 thunderbolt.dyndbg=+p
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Hygon HygonGenuine
[    0.000000]   Centaur CentaurHauls
[    0.000000]   zhaoxin   Shanghai  
[    0.000000] x86/split lock detection: #AC: crashing the kernel on kernel split_locks and warning on user-space split_locks
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009efff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009f000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000002c228fff] usable
[    0.000000] BIOS-e820: [mem 0x000000002c229000-0x000000002cb28fff] reserved
[    0.000000] BIOS-e820: [mem 0x000000002cb29000-0x000000002e93efff] usable
[    0.000000] BIOS-e820: [mem 0x000000002e93f000-0x00000000309defff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000309df000-0x000000003398efff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000003398f000-0x0000000033afefff] ACPI data
[    0.000000] BIOS-e820: [mem 0x0000000033aff000-0x0000000033afffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000033b00000-0x00000000383fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000038e00000-0x00000000407fffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000c0000000-0x00000000cfffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed20000-0x00000000fed7ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x00000018bf7fffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] APIC: Static calls initialized
[    0.000000] efi: EFI v2.8 by INSYDE Corp.
[    0.000000] efi: ACPI=0x33afe000 ACPI 2.0=0x33afe014 TPMFinalLog=0x33866000 SMBIOS=0x2efda000 MEMATTR=0x27d90018 ESRT=0x28a1f018 MOKvar=0x2ef86000 INITRD=0x274bdf98 RNG=0x33a24018 TPMEventLog=0x274b0018 
[    0.000000] random: crng init done
[    0.000000] efi: Remove mem90: MMIO range=[0xc0000000-0xcfffffff] (256MB) from e820 map
[    0.000000] e820: remove [mem 0xc0000000-0xcfffffff] reserved
[    0.000000] efi: Remove mem92: MMIO range=[0xff000000-0xffffffff] (16MB) from e820 map
[    0.000000] e820: remove [mem 0xff000000-0xffffffff] reserved
[    0.000000] secureboot: Secure boot disabled
[    0.000000] SMBIOS 3.4 present.
[    0.000000] DMI: Notebook X370SNx1/X370SNx1, BIOS 1.07.03aMIN29 09/18/2024
[    0.000000] tsc: Detected 2400.000 MHz processor
[    0.000000] tsc: Detected 2419.200 MHz TSC
[    0.000009] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000013] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000022] last_pfn = 0x18bf800 max_arch_pfn = 0x400000000
[    0.000028] MTRR map: 5 entries (3 fixed + 2 variable; max 23), built from 10 variable MTRRs
[    0.000031] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.000804] last_pfn = 0x33b00 max_arch_pfn = 0x400000000
[    0.009530] esrt: Reserving ESRT space from 0x0000000028a1f018 to 0x0000000028a1f0a0.
[    0.009538] e820: update [mem 0x28a1f000-0x28a1ffff] usable ==> reserved
[    0.009562] Using GB pages for direct mapping
[    0.010106] secureboot: Secure boot disabled
[    0.010107] RAMDISK: [mem 0x0d5ee000-0x17228fff]
[    0.010658] ACPI: Early table checksum verification disabled
[    0.010662] ACPI: RSDP 0x0000000033AFE014 000024 (v02 INSYDE)
[    0.010668] ACPI: XSDT 0x0000000033A38188 00012C (v01 INSYDE ADL      00000002      01000013)
[    0.010676] ACPI: FACP 0x0000000033ADB000 000114 (v06 INSYDE ADL      00000002 ACPI 00040000)
[    0.010683] ACPI: DSDT 0x0000000033A4E000 089652 (v02 INSYDE ADL      00000002 ACPI 00040000)
[    0.010687] ACPI: FACS 0x000000003383E000 000040
[    0.010690] ACPI: UEFI 0x000000003398E000 0001CF (v01 INSYDE H2O BIOS 00000001 ACPI 00040000)
[    0.010694] ACPI: SSDT 0x0000000033AF3000 00908F (v02 DptfTb DptfTabl 00001000 INTL 20200717)
[    0.010698] ACPI: SSDT 0x0000000033AED000 005D34 (v02 CpuRef CpuSsdt  00003000 INTL 20200717)
[    0.010702] ACPI: SSDT 0x0000000033AEA000 00276F (v02 SaSsdt SaSsdt   00003000 INTL 20200717)
[    0.010706] ACPI: SSDT 0x0000000033AE6000 00328B (v02 INTEL  IgfxSsdt 00003000 INTL 20200717)
[    0.010709] ACPI: SSDT 0x0000000033AE5000 00077B (v02 INSYDE Tpm2Tabl 00001000 INTL 20200717)
[    0.010713] ACPI: TPM2 0x0000000033AE4000 00004C (v04 INSYDE ADL      00000002 ACPI 00040000)
[    0.010717] ACPI: SSDT 0x0000000033ADF000 003249 (v02 INTEL  DTbtSsdt 00001000 INTL 20200717)
[    0.010720] ACPI: SSDT 0x0000000033ADD000 0016A6 (v02 INSYDE UsbCTabl 00001000 INTL 20200717)
[    0.010724] ACPI: NHLT 0x0000000033ADC000 00002D (v00 INSYDE ADL      00000002 ACPI 00040000)
[    0.010727] ACPI: HPET 0x0000000033ADA000 000038 (v01 INSYDE ADL      00000002 ACPI 00040000)
[    0.010731] ACPI: APIC 0x0000000033AD9000 0001DC (v05 INSYDE ADL      00000002 ACPI 00040000)
[    0.010734] ACPI: MCFG 0x0000000033AD8000 00003C (v01 INSYDE ADL      00000002 ACPI 00040000)
[    0.010738] ACPI: SSDT 0x0000000033A48000 0054E4 (v02 INSYDE ADL      00000002      01000013)
[    0.010742] ACPI: WSMT 0x0000000033A47000 000028 (v01 INSYDE ADL      00000002 ACPI 00040000)
[    0.010745] ACPI: SSDT 0x0000000033A45000 0015FD (v02 INSYDE PtidDevc 00001000 INTL 20200717)
[    0.010749] ACPI: SSDT 0x0000000033A3B000 009573 (v02 INSYDE TbtTypeC 00000000 INTL 20200717)
[    0.010752] ACPI: DBGP 0x0000000033A3A000 000034 (v01 INSYDE ADL      00000002 ACPI 00040000)
[    0.010756] ACPI: DBG2 0x0000000033A39000 000054 (v00 INSYDE ADL      00000002 ACPI 00040000)
[    0.010759] ACPI: DMAR 0x0000000033AFD000 000088 (v01 INTEL  ICL      00000002 ACPI 00040000)
[    0.010763] ACPI: SSDT 0x0000000033A35000 002EE7 (v01 NvdRef NvdTabl  00001000 INTL 20200717)
[    0.010766] ACPI: SSDT 0x0000000033A34000 000244 (v01 NvdRef NvdExt   00001000 INTL 20200717)
[    0.010770] ACPI: SSDT 0x0000000033A33000 000640 (v01 NvdRef NvdDds   00001000 INTL 20200717)
[    0.010774] ACPI: UEFI 0x000000003383B000 00063A (v01 INTEL  RstVmdE  00000000 ACPI 00040000)
[    0.010777] ACPI: UEFI 0x000000003383A000 00005C (v01 INTEL  RstVmdV  00000000 ACPI 00040000)
[    0.010781] ACPI: SSDT 0x0000000033A31000 001057 (v02 INTEL  xh_rplsb 00000000 INTL 20200717)
[    0.010784] ACPI: SSDT 0x0000000033A2D000 0039DA (v02 SocGpe SocGpe   00003000 INTL 20200717)
[    0.010788] ACPI: SSDT 0x0000000033A29000 0039DA (v02 SocCmn SocCmn   00003000 INTL 20200717)
[    0.010792] ACPI: SSDT 0x0000000033A28000 0000F8 (v02 INSYDE PcdTabl  00001000 INTL 20200717)
[    0.010795] ACPI: FPDT 0x0000000033A27000 000044 (v01 INSYDE ADL      00000002 ACPI 00040000)
[    0.010799] ACPI: PHAT 0x0000000033A25000 0005ED (v01 INSYDE ADL      00000005 ACPI 00040000)
[    0.010802] ACPI: BGRT 0x0000000033A26000 000038 (v01 INSYDE H2O BIOS 00000001 ACPI 00040000)
[    0.010806] ACPI: Reserving FACP table memory at [mem 0x33adb000-0x33adb113]
[    0.010808] ACPI: Reserving DSDT table memory at [mem 0x33a4e000-0x33ad7651]
[    0.010809] ACPI: Reserving FACS table memory at [mem 0x3383e000-0x3383e03f]
[    0.010810] ACPI: Reserving UEFI table memory at [mem 0x3398e000-0x3398e1ce]
[    0.010811] ACPI: Reserving SSDT table memory at [mem 0x33af3000-0x33afc08e]
[    0.010812] ACPI: Reserving SSDT table memory at [mem 0x33aed000-0x33af2d33]
[    0.010813] ACPI: Reserving SSDT table memory at [mem 0x33aea000-0x33aec76e]
[    0.010814] ACPI: Reserving SSDT table memory at [mem 0x33ae6000-0x33ae928a]
[    0.010815] ACPI: Reserving SSDT table memory at [mem 0x33ae5000-0x33ae577a]
[    0.010816] ACPI: Reserving TPM2 table memory at [mem 0x33ae4000-0x33ae404b]
[    0.010817] ACPI: Reserving SSDT table memory at [mem 0x33adf000-0x33ae2248]
[    0.010818] ACPI: Reserving SSDT table memory at [mem 0x33add000-0x33ade6a5]
[    0.010819] ACPI: Reserving NHLT table memory at [mem 0x33adc000-0x33adc02c]
[    0.010820] ACPI: Reserving HPET table memory at [mem 0x33ada000-0x33ada037]
[    0.010821] ACPI: Reserving APIC table memory at [mem 0x33ad9000-0x33ad91db]
[    0.010822] ACPI: Reserving MCFG table memory at [mem 0x33ad8000-0x33ad803b]
[    0.010823] ACPI: Reserving SSDT table memory at [mem 0x33a48000-0x33a4d4e3]
[    0.010824] ACPI: Reserving WSMT table memory at [mem 0x33a47000-0x33a47027]
[    0.010825] ACPI: Reserving SSDT table memory at [mem 0x33a45000-0x33a465fc]
[    0.010827] ACPI: Reserving SSDT table memory at [mem 0x33a3b000-0x33a44572]
[    0.010828] ACPI: Reserving DBGP table memory at [mem 0x33a3a000-0x33a3a033]
[    0.010829] ACPI: Reserving DBG2 table memory at [mem 0x33a39000-0x33a39053]
[    0.010830] ACPI: Reserving DMAR table memory at [mem 0x33afd000-0x33afd087]
[    0.010831] ACPI: Reserving SSDT table memory at [mem 0x33a35000-0x33a37ee6]
[    0.010832] ACPI: Reserving SSDT table memory at [mem 0x33a34000-0x33a34243]
[    0.010833] ACPI: Reserving SSDT table memory at [mem 0x33a33000-0x33a3363f]
[    0.010834] ACPI: Reserving UEFI table memory at [mem 0x3383b000-0x3383b639]
[    0.010835] ACPI: Reserving UEFI table memory at [mem 0x3383a000-0x3383a05b]
[    0.010836] ACPI: Reserving SSDT table memory at [mem 0x33a31000-0x33a32056]
[    0.010837] ACPI: Reserving SSDT table memory at [mem 0x33a2d000-0x33a309d9]
[    0.010838] ACPI: Reserving SSDT table memory at [mem 0x33a29000-0x33a2c9d9]
[    0.010839] ACPI: Reserving SSDT table memory at [mem 0x33a28000-0x33a280f7]
[    0.010840] ACPI: Reserving FPDT table memory at [mem 0x33a27000-0x33a27043]
[    0.010842] ACPI: Reserving PHAT table memory at [mem 0x33a25000-0x33a255ec]
[    0.010843] ACPI: Reserving BGRT table memory at [mem 0x33a26000-0x33a26037]
[    0.011076] No NUMA configuration found
[    0.011078] Faking a node at [mem 0x0000000000000000-0x00000018bf7fffff]
[    0.011086] NODE_DATA(0) allocated [mem 0x18bf7d5000-0x18bf7fffff]
[    0.011400] Zone ranges:
[    0.011401]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.011403]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.011405]   Normal   [mem 0x0000000100000000-0x00000018bf7fffff]
[    0.011407]   Device   empty
[    0.011408] Movable zone start for each node
[    0.011410] Early memory node ranges
[    0.011411]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.011413]   node   0: [mem 0x0000000000100000-0x000000002c228fff]
[    0.011414]   node   0: [mem 0x000000002cb29000-0x000000002e93efff]
[    0.011415]   node   0: [mem 0x0000000033aff000-0x0000000033afffff]
[    0.011416]   node   0: [mem 0x0000000100000000-0x00000018bf7fffff]
[    0.011424] Initmem setup node 0 [mem 0x0000000000001000-0x00000018bf7fffff]
[    0.011430] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.011454] On node 0, zone DMA: 97 pages in unavailable ranges
[    0.012572] On node 0, zone DMA32: 2304 pages in unavailable ranges
[    0.012751] On node 0, zone DMA32: 20928 pages in unavailable ranges
[    0.142815] On node 0, zone Normal: 17664 pages in unavailable ranges
[    0.142834] On node 0, zone Normal: 2048 pages in unavailable ranges
[    0.142904] Reserving Intel graphics memory at [mem 0x3c800000-0x407fffff]
[    0.143535] ACPI: PM-Timer IO Port: 0x1808
[    0.143546] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.143549] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.143549] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.143550] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.143551] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
[    0.143552] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[    0.143553] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
[    0.143553] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
[    0.143554] ACPI: LAPIC_NMI (acpi_id[0x09] high edge lint[0x1])
[    0.143555] ACPI: LAPIC_NMI (acpi_id[0x0a] high edge lint[0x1])
[    0.143556] ACPI: LAPIC_NMI (acpi_id[0x0b] high edge lint[0x1])
[    0.143556] ACPI: LAPIC_NMI (acpi_id[0x0c] high edge lint[0x1])
[    0.143557] ACPI: LAPIC_NMI (acpi_id[0x0d] high edge lint[0x1])
[    0.143558] ACPI: LAPIC_NMI (acpi_id[0x0e] high edge lint[0x1])
[    0.143559] ACPI: LAPIC_NMI (acpi_id[0x0f] high edge lint[0x1])
[    0.143560] ACPI: LAPIC_NMI (acpi_id[0x10] high edge lint[0x1])
[    0.143560] ACPI: LAPIC_NMI (acpi_id[0x11] high edge lint[0x1])
[    0.143561] ACPI: LAPIC_NMI (acpi_id[0x12] high edge lint[0x1])
[    0.143562] ACPI: LAPIC_NMI (acpi_id[0x13] high edge lint[0x1])
[    0.143563] ACPI: LAPIC_NMI (acpi_id[0x14] high edge lint[0x1])
[    0.143564] ACPI: LAPIC_NMI (acpi_id[0x15] high edge lint[0x1])
[    0.143564] ACPI: LAPIC_NMI (acpi_id[0x16] high edge lint[0x1])
[    0.143565] ACPI: LAPIC_NMI (acpi_id[0x17] high edge lint[0x1])
[    0.143566] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.143605] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-119
[    0.143608] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.143610] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.143615] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.143616] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.143625] e820: update [mem 0x26c18000-0x26cd2fff] usable ==> reserved
[    0.143637] TSC deadline timer available
[    0.143637] smpboot: Allowing 32 CPUs, 0 hotplug CPUs
[    0.143652] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.143654] PM: hibernation: Registered nosave memory: [mem 0x0009f000-0x000fffff]
[    0.143656] PM: hibernation: Registered nosave memory: [mem 0x26c18000-0x26cd2fff]
[    0.143657] PM: hibernation: Registered nosave memory: [mem 0x28a1f000-0x28a1ffff]
[    0.143659] PM: hibernation: Registered nosave memory: [mem 0x2c229000-0x2cb28fff]
[    0.143660] PM: hibernation: Registered nosave memory: [mem 0x2e93f000-0x309defff]
[    0.143661] PM: hibernation: Registered nosave memory: [mem 0x309df000-0x3398efff]
[    0.143661] PM: hibernation: Registered nosave memory: [mem 0x3398f000-0x33afefff]
[    0.143663] PM: hibernation: Registered nosave memory: [mem 0x33b00000-0x383fffff]
[    0.143664] PM: hibernation: Registered nosave memory: [mem 0x38400000-0x38dfffff]
[    0.143664] PM: hibernation: Registered nosave memory: [mem 0x38e00000-0x407fffff]
[    0.143665] PM: hibernation: Registered nosave memory: [mem 0x40800000-0xfed1ffff]
[    0.143666] PM: hibernation: Registered nosave memory: [mem 0xfed20000-0xfed7ffff]
[    0.143667] PM: hibernation: Registered nosave memory: [mem 0xfed80000-0xffffffff]
[    0.143668] [mem 0x40800000-0xfed1ffff] available for PCI devices
[    0.143670] Booting paravirtualized kernel on bare hardware
[    0.143673] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.143684] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:32 nr_cpu_ids:32 nr_node_ids:1
[    0.145501] percpu: Embedded 86 pages/cpu s229376 r8192 d114688 u524288
[    0.145506] pcpu-alloc: s229376 r8192 d114688 u524288 alloc=1*2097152
[    0.145509] pcpu-alloc: [0] 00 01 02 03 [0] 04 05 06 07 
[    0.145515] pcpu-alloc: [0] 08 09 10 11 [0] 12 13 14 15 
[    0.145520] pcpu-alloc: [0] 16 17 18 19 [0] 20 21 22 23 
[    0.145525] pcpu-alloc: [0] 24 25 26 27 [0] 28 29 30 31 
[    0.145548] Kernel command line: BOOT_IMAGE=/@boot/vmlinuz-6.8.0-45-kfocus root=UUID=d4f6fb42-b08b-4b54-a060-a4e3fc1f51fd ro rootflags=subvol=@ quiet cryptdevice=UUID=9992e62a-e20e-4d65-8cd4-d1988f6f3ab3:luks-9992e62a-e20e-4d65-8cd4-d1988f6f3ab3 root=/dev/mapper/luks-9992e62a-e20e-4d65-8cd4-d1988f6f3ab3 splash modprobe.blacklist=nouveau modprobe.blacklist=ucsi_acpi tpm_tis.interrupts=0 intel_pstate=passive snd_hda_core.gpu_bind=0 pci=noaer loglevel=3 vt.handoff=7 thunderbolt.dyndbg=+p
[    0.145763] Unknown kernel command line parameters "splash BOOT_IMAGE=/@boot/vmlinuz-6.8.0-45-kfocus cryptdevice=UUID=9992e62a-e20e-4d65-8cd4-d1988f6f3ab3:luks-9992e62a-e20e-4d65-8cd4-d1988f6f3ab3", will be passed to user space.
[    0.151112] Dentry cache hash table entries: 8388608 (order: 14, 67108864 bytes, linear)
[    0.153793] Inode-cache hash table entries: 4194304 (order: 13, 33554432 bytes, linear)
[    0.154176] Fallback order for Node 0: 0 
[    0.154181] Built 1 zonelists, mobility grouping on.  Total pages: 24697823
[    0.154183] Policy zone: Normal
[    0.154190] mem auto-init: stack:all(zero), heap alloc:on, heap free:off
[    0.154198] software IO TLB: area num 32.
[    0.335669] Memory: 98306000K/100360056K available (22528K kernel code, 4442K rwdata, 13908K rodata, 4976K init, 4732K bss, 2053796K reserved, 0K cma-reserved)
[    0.337063] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=32, Nodes=1
[    0.337096] ftrace: allocating 57873 entries in 227 pages
[    0.346311] ftrace: allocated 227 pages with 5 groups
[    0.347076] Dynamic Preempt: voluntary
[    0.347226] rcu: Preemptible hierarchical RCU implementation.
[    0.347227] rcu: 	RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=32.
[    0.347229] 	Trampoline variant of Tasks RCU enabled.
[    0.347230] 	Rude variant of Tasks RCU enabled.
[    0.347230] 	Tracing variant of Tasks RCU enabled.
[    0.347231] rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
[    0.347232] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=32
[    0.349844] NR_IRQS: 524544, nr_irqs: 2312, preallocated irqs: 16
[    0.350174] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.350413] Console: colour dummy device 80x25
[    0.350415] printk: legacy console [tty0] enabled
[    0.350470] ACPI: Core revision 20230628
[    0.350925] hpet: HPET dysfunctional in PC10. Force disabled.
[    0.350926] APIC: Switch to symmetric I/O mode setup
[    0.350928] DMAR: Host address width 39
[    0.350929] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
[    0.350938] DMAR: dmar0: reg_base_addr fed90000 ver 4:0 cap 1c0000c40660462 ecap 29a00f0505e
[    0.350941] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
[    0.350946] DMAR: dmar1: reg_base_addr fed91000 ver 5:0 cap d2008c40660462 ecap f050da
[    0.350949] DMAR: RMRR base: 0x0000003c000000 end: 0x000000407fffff
[    0.350951] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
[    0.350953] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
[    0.350954] DMAR-IR: Queued invalidation will be enabled to support x2apic and Intr-remapping.
[    0.352933] DMAR-IR: Enabled IRQ remapping in x2apic mode
[    0.352935] x2apic enabled
[    0.353003] APIC: Switched APIC routing to: cluster x2apic
[    0.357937] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x22df1149949, max_idle_ns: 440795312789 ns
[    0.357945] Calibrating delay loop (skipped), value calculated using timer frequency.. 4838.40 BogoMIPS (lpj=2419200)
[    0.358012] CPU0: Thermal monitoring enabled (TM1)
[    0.358014] x86/cpu: User Mode Instruction Prevention (UMIP) activated
[    0.358172] process: using mwait in idle threads
[    0.358175] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[    0.358176] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[    0.358180] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.358184] Spectre V2 : Mitigation: Enhanced / Automatic IBRS
[    0.358185] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.358186] Spectre V2 : Spectre v2 / PBRSB-eIBRS: Retire a single CALL on VMEXIT
[    0.358188] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
[    0.358191] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
[    0.358192] Register File Data Sampling: Mitigation: Clear Register File
[    0.358203] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.358205] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.358206] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.358207] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys User registers'
[    0.358208] x86/fpu: Supporting XSAVE feature 0x800: 'Control-flow User registers'
[    0.358209] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.358210] x86/fpu: xstate_offset[9]:  832, xstate_sizes[9]:    8
[    0.358212] x86/fpu: xstate_offset[11]:  840, xstate_sizes[11]:   16
[    0.358213] x86/fpu: Enabled xstate features 0xa07, context size is 856 bytes, using 'compacted' format.
[    0.358942] Freeing SMP alternatives memory: 48K
[    0.358942] pid_max: default: 32768 minimum: 301
[    0.358942] LSM: initializing lsm=lockdown,capability,landlock,yama,apparmor,integrity
[    0.358942] landlock: Up and running.
[    0.358942] Yama: becoming mindful.
[    0.358942] AppArmor: AppArmor initialized
[    0.358942] Mount-cache hash table entries: 131072 (order: 8, 1048576 bytes, linear)
[    0.358942] Mountpoint-cache hash table entries: 131072 (order: 8, 1048576 bytes, linear)
[    0.358942] smpboot: CPU0: Intel(R) Core(TM) i9-14900HX (family: 0x6, model: 0xb7, stepping: 0x1)
[    0.358942] RCU Tasks: Setting shift to 5 and lim to 1 rcu_task_cb_adjust=1.
[    0.358942] RCU Tasks Rude: Setting shift to 5 and lim to 1 rcu_task_cb_adjust=1.
[    0.358942] RCU Tasks Trace: Setting shift to 5 and lim to 1 rcu_task_cb_adjust=1.
[    0.358942] Performance Events: XSAVE Architectural LBR, PEBS fmt4+-baseline,  AnyThread deprecated, Alderlake Hybrid events, 32-deep LBR, full-width counters, Intel PMU driver.
[    0.358942] core: cpu_core PMU driver: 
[    0.358942] ... version:                5
[    0.358942] ... bit width:              48
[    0.358942] ... generic registers:      8
[    0.358942] ... value mask:             0000ffffffffffff
[    0.358942] ... max period:             00007fffffffffff
[    0.358942] ... fixed-purpose events:   4
[    0.358942] ... event mask:             0001000f000000ff
[    0.358942] signal: max sigframe size: 3632
[    0.358942] Estimated ratio of average max frequency by base frequency (times 1024): 2218
[    0.358942] rcu: Hierarchical SRCU implementation.
[    0.358942] rcu: 	Max phase no-delay instances is 400.
[    0.360372] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    0.360648] smp: Bringing up secondary CPUs ...
[    0.360752] smpboot: x86: Booting SMP configuration:
[    0.360753] .... node  #0, CPUs:        #2  #4  #6  #8 #10 #12 #14 #16 #17 #18 #19 #20 #21 #22 #23 #24 #25 #26 #27 #28 #29 #30 #31
[    0.008610] core: cpu_atom PMU driver: PEBS-via-PT 
[    0.008610] ... version:                5
[    0.008610] ... bit width:              48
[    0.008610] ... generic registers:      6
[    0.008610] ... value mask:             0000ffffffffffff
[    0.008610] ... max period:             00007fffffffffff
[    0.008610] ... fixed-purpose events:   3
[    0.008610] ... event mask:             000000070000003f
[    0.375014]   #1  #3  #5  #7  #9 #11 #13 #15
[    0.384015] smp: Brought up 1 node, 32 CPUs
[    0.384015] smpboot: Max logical packages: 1
[    0.384015] smpboot: Total of 32 processors activated (154828.80 BogoMIPS)
[    0.388076] devtmpfs: initialized
[    0.388076] x86/mm: Memory block size: 2048MB
[    0.389692] ACPI: PM: Registering ACPI NVS region [mem 0x309df000-0x3398efff] (50003968 bytes)
[    0.390299] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.390351] futex hash table entries: 8192 (order: 7, 524288 bytes, linear)
[    0.390472] pinctrl core: initialized pinctrl subsystem
[    0.390727] PM: RTC time: 03:44:22, date: 2024-10-11
[    0.391294] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.391867] DMA: preallocated 4096 KiB GFP_KERNEL pool for atomic allocations
[    0.392292] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[    0.392670] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[    0.392681] audit: initializing netlink subsys (disabled)
[    0.392688] audit: type=2000 audit(1728618261.034:1): state=initialized audit_enabled=0 res=1
[    0.392688] thermal_sys: Registered thermal governor 'fair_share'
[    0.392688] thermal_sys: Registered thermal governor 'bang_bang'
[    0.392688] thermal_sys: Registered thermal governor 'step_wise'
[    0.392688] thermal_sys: Registered thermal governor 'user_space'
[    0.392688] thermal_sys: Registered thermal governor 'power_allocator'
[    0.392688] EISA bus registered
[    0.392688] cpuidle: using governor ladder
[    0.392688] cpuidle: using governor menu
[    0.392973] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.393129] PCI: ECAM [mem 0xc0000000-0xce0fffff] (base 0xc0000000) for domain 0000 [bus 00-e0]
[    0.393148] PCI: Using configuration type 1 for base access
[    0.393332] kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
[    0.393332] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    0.393332] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
[    0.393332] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.393332] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.394107] ACPI: Added _OSI(Module Device)
[    0.394109] ACPI: Added _OSI(Processor Device)
[    0.394111] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.394112] ACPI: Added _OSI(Processor Aggregator Device)
[    0.530743] ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PC00.MHBR], AE_NOT_FOUND (20230628/psargs-330)
[    0.530754] ACPI: Ignoring error and continuing table load
[    0.530777] ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PTID.PBAR], AE_NOT_FOUND (20230628/dsfield-500)
[    0.538514] ACPI: 18 ACPI AML tables successfully acquired and loaded
[    0.557460] ACPI: USB4 _OSC: OS supports USB3+ DisplayPort+ PCIe+ XDomain+
[    0.557463] ACPI: USB4 _OSC: OS controls USB3+ DisplayPort+ PCIe+ XDomain+
[    0.559282] ACPI: Dynamic OEM Table Load:
[    0.559295] ACPI: SSDT 0xFFFF8C0802224400 000394 (v02 PmRef  Cpu0Cst  00003001 INTL 20200717)
[    0.561125] ACPI: Dynamic OEM Table Load:
[    0.561132] ACPI: SSDT 0xFFFF8C080222F800 00053F (v02 PmRef  Cpu0Ist  00003000 INTL 20200717)
[    0.562988] ACPI: Dynamic OEM Table Load:
[    0.562994] ACPI: SSDT 0xFFFF8C0803EB3C00 0001AB (v02 PmRef  Cpu0Psd  00003000 INTL 20200717)
[    0.564754] ACPI: Dynamic OEM Table Load:
[    0.564761] ACPI: SSDT 0xFFFF8C080222A800 0004B5 (v02 PmRef  Cpu0Hwp  00003000 INTL 20200717)
[    0.567114] ACPI: Dynamic OEM Table Load:
[    0.567130] ACPI: SSDT 0xFFFF8C0802232000 001BAF (v02 PmRef  ApIst    00003000 INTL 20200717)
[    0.569870] ACPI: Dynamic OEM Table Load:
[    0.569878] ACPI: SSDT 0xFFFF8C0802234000 001038 (v02 PmRef  ApHwp    00003000 INTL 20200717)
[    0.572332] ACPI: Dynamic OEM Table Load:
[    0.572340] ACPI: SSDT 0xFFFF8C0802236000 001349 (v02 PmRef  ApPsd    00003000 INTL 20200717)
[    0.574849] ACPI: Dynamic OEM Table Load:
[    0.574857] ACPI: SSDT 0xFFFF8C0803EF1000 000FBB (v02 PmRef  ApCst    00003000 INTL 20200717)
[    0.593613] ACPI: _OSC evaluated successfully for all CPUs
[    0.593737] ACPI: EC: EC started
[    0.593738] ACPI: EC: interrupt blocked
[    0.612579] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.612582] ACPI: \_SB_.PC00.LPCB.EC__: Boot DSDT EC used to handle transactions
[    0.612584] ACPI: Interpreter enabled
[    0.612672] ACPI: PM: (supports S0 S3 S4 S5)
[    0.612673] ACPI: Using IOAPIC for interrupt routing
[    0.615099] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.615101] PCI: Ignoring E820 reservations for host bridge windows
[    0.616883] ACPI: Enabled 11 GPEs in block 00 to 7F
[    0.619222] ACPI: \_SB_.PC00.PEG2.PG00: New power resource
[    0.647381] ACPI: \_SB_.PC00.XHCI.RHUB.HS14.BTRT: New power resource
[    0.647405] ACPI: \_SB_.PC00.XHCI.RHUB.HS14.DBTR: New power resource
[    0.657277] ACPI: \_SB_.PC00.CNVW.WRST: New power resource
[    0.662794] ACPI: \_SB_.PC00.RP09.PXP_: New power resource
[    0.688530] ACPI: \PIN_: New power resource
[    0.688958] ACPI: PCI Root Bridge [PC00] (domain 0000 [bus 00-e0])
[    0.688965] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
[    0.692905] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotplug PME PCIeCapability LTR DPC]
[    0.698743] PCI host bridge to bus 0000:00
[    0.698745] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.698747] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.698749] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.698751] pci_bus 0000:00: root bus resource [mem 0x40800000-0xbfffffff window]
[    0.698752] pci_bus 0000:00: root bus resource [mem 0x4000000000-0x7fffffffff window]
[    0.698755] pci_bus 0000:00: root bus resource [bus 00-e0]
[    0.698796] pci 0000:00:00.0: [8086:a702] type 00 class 0x060000 conventional PCI endpoint
[    0.698925] pci 0000:00:01.0: [8086:a70d] type 01 class 0x060400 PCIe Root Port
[    0.698942] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.699001] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    0.699026] pci 0000:00:01.0: PTM enabled (root), 4ns granularity
[    0.699797] pci 0000:00:01.1: [8086:a72d] type 01 class 0x060400 PCIe Root Port
[    0.699814] pci 0000:00:01.1: PCI bridge to [bus 02]
[    0.699817] pci 0000:00:01.1:   bridge window [io  0x3000-0x3fff]
[    0.699819] pci 0000:00:01.1:   bridge window [mem 0x4e000000-0x4f0fffff]
[    0.699825] pci 0000:00:01.1:   bridge window [mem 0x6000000000-0x6401ffffff 64bit pref]
[    0.699876] pci 0000:00:01.1: PME# supported from D0 D3hot D3cold
[    0.699900] pci 0000:00:01.1: PTM enabled (root), 4ns granularity
[    0.700640] pci 0000:00:02.0: [8086:a788] type 00 class 0x030000 PCIe Root Complex Integrated Endpoint
[    0.700651] pci 0000:00:02.0: BAR 0 [mem 0x6404000000-0x6404ffffff 64bit]
[    0.700657] pci 0000:00:02.0: BAR 2 [mem 0x4000000000-0x400fffffff 64bit pref]
[    0.700661] pci 0000:00:02.0: BAR 4 [io  0x4000-0x403f]
[    0.700679] pci 0000:00:02.0: DMAR: Skip IOMMU disabling for graphics
[    0.700682] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.700712] pci 0000:00:02.0: VF BAR 0 [mem 0x00000000-0x00ffffff 64bit]
[    0.700714] pci 0000:00:02.0: VF BAR 0 [mem 0x00000000-0x06ffffff 64bit]: contains BAR 0 for 7 VFs
[    0.700719] pci 0000:00:02.0: VF BAR 2 [mem 0x00000000-0x1fffffff 64bit pref]
[    0.700721] pci 0000:00:02.0: VF BAR 2 [mem 0x00000000-0xdfffffff 64bit pref]: contains BAR 2 for 7 VFs
[    0.700902] pci 0000:00:04.0: [8086:a71d] type 00 class 0x118000 conventional PCI endpoint
[    0.700918] pci 0000:00:04.0: BAR 0 [mem 0x6405200000-0x640521ffff 64bit]
[    0.701257] pci 0000:00:06.0: [8086:09ab] type 00 class 0x088000 conventional PCI endpoint
[    0.702027] pci 0000:00:08.0: [8086:a74f] type 00 class 0x088000 conventional PCI endpoint
[    0.702038] pci 0000:00:08.0: BAR 0 [mem 0x6405241000-0x6405241fff 64bit]
[    0.702145] pci 0000:00:0a.0: [8086:a77d] type 00 class 0x118000 PCIe Root Complex Integrated Endpoint
[    0.702154] pci 0000:00:0a.0: BAR 0 [mem 0x6405220000-0x6405227fff 64bit]
[    0.702173] pci 0000:00:0a.0: enabling Extended Tags
[    0.702281] pci 0000:00:0e.0: [8086:a77f] type 00 class 0x010400 PCIe Root Complex Integrated Endpoint
[    0.702296] pci 0000:00:0e.0: BAR 0 [mem 0x6402000000-0x6403ffffff 64bit]
[    0.702303] pci 0000:00:0e.0: BAR 2 [mem 0x4c000000-0x4dffffff]
[    0.702319] pci 0000:00:0e.0: BAR 4 [mem 0x6405100000-0x64051fffff 64bit]
[    0.702639] pci 0000:00:14.0: [8086:7a60] type 00 class 0x0c0330 conventional PCI endpoint
[    0.702660] pci 0000:00:14.0: BAR 0 [mem 0x4f380000-0x4f38ffff 64bit]
[    0.702741] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.703321] pci 0000:00:14.2: [8086:7a27] type 00 class 0x050000 conventional PCI endpoint
[    0.703345] pci 0000:00:14.2: BAR 0 [mem 0x6405238000-0x640523bfff 64bit]
[    0.703361] pci 0000:00:14.2: BAR 2 [mem 0x6405240000-0x6405240fff 64bit]
[    0.703516] pci 0000:00:14.3: [8086:7a70] type 00 class 0x028000 PCIe Root Complex Integrated Endpoint
[    0.703563] pci 0000:00:14.3: BAR 0 [mem 0x6405234000-0x6405237fff 64bit]
[    0.703729] pci 0000:00:14.3: PME# supported from D0 D3hot D3cold
[    0.704143] pci 0000:00:15.0: [8086:7a4c] type 00 class 0x0c8000 conventional PCI endpoint
[    0.704214] pci 0000:00:15.0: BAR 0 [mem 0x00000000-0x00000fff 64bit]
[    0.704772] pci 0000:00:15.1: [8086:7a4d] type 00 class 0x0c8000 conventional PCI endpoint
[    0.704843] pci 0000:00:15.1: BAR 0 [mem 0x00000000-0x00000fff 64bit]
[    0.705349] pci 0000:00:16.0: [8086:7a68] type 00 class 0x078000 conventional PCI endpoint
[    0.705372] pci 0000:00:16.0: BAR 0 [mem 0x640523d000-0x640523dfff 64bit]
[    0.705455] pci 0000:00:16.0: PME# supported from D3hot
[    0.706016] pci 0000:00:1c.0: [8086:7a3e] type 01 class 0x060400 PCIe Root Port
[    0.706048] pci 0000:00:1c.0: PCI bridge to [bus 03]
[    0.706055] pci 0000:00:1c.0:   bridge window [mem 0x4f100000-0x4f2fffff]
[    0.706149] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.706190] pci 0000:00:1c.0: PTM enabled (root), 4ns granularity
[    0.707035] pci 0000:00:1d.0: [8086:7a30] type 01 class 0x060400 PCIe Root Port
[    0.707065] pci 0000:00:1d.0: PCI bridge to [bus 04-54]
[    0.707072] pci 0000:00:1d.0:   bridge window [mem 0x44000000-0x4bffffff]
[    0.707082] pci 0000:00:1d.0:   bridge window [mem 0x6410000000-0x74100fffff 64bit pref]
[    0.707222] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    0.708095] pci 0000:00:1f.0: [8086:7a0c] type 00 class 0x060100 conventional PCI endpoint
[    0.708512] pci 0000:00:1f.3: [8086:7a50] type 00 class 0x040300 conventional PCI endpoint
[    0.708556] pci 0000:00:1f.3: BAR 0 [mem 0x6405230000-0x6405233fff 64bit]
[    0.708610] pci 0000:00:1f.3: BAR 4 [mem 0x6405000000-0x64050fffff 64bit]
[    0.708717] pci 0000:00:1f.3: PME# supported from D3hot D3cold
[    0.708823] pci 0000:00:1f.4: [8086:7a23] type 00 class 0x0c0500 conventional PCI endpoint
[    0.708849] pci 0000:00:1f.4: BAR 0 [mem 0x640523c000-0x640523c0ff 64bit]
[    0.708879] pci 0000:00:1f.4: BAR 4 [io  0xefa0-0xefbf]
[    0.709187] pci 0000:00:1f.5: [8086:7a24] type 00 class 0x0c8000 conventional PCI endpoint
[    0.709207] pci 0000:00:1f.5: BAR 0 [mem 0xfe010000-0xfe010fff]
[    0.709361] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.709406] acpiphp: Slot [1] registered
[    0.709423] pci 0000:02:00.0: [10de:2757] type 00 class 0x030000 PCIe Legacy Endpoint
[    0.709432] pci 0000:02:00.0: BAR 0 [mem 0x4e000000-0x4effffff]
[    0.709440] pci 0000:02:00.0: BAR 1 [mem 0x6000000000-0x63ffffffff 64bit pref]
[    0.709447] pci 0000:02:00.0: BAR 3 [mem 0x6400000000-0x6401ffffff 64bit pref]
[    0.709451] pci 0000:02:00.0: BAR 5 [io  0x3000-0x307f]
[    0.709456] pci 0000:02:00.0: ROM [mem 0xfff80000-0xffffffff pref]
[    0.709509] pci 0000:02:00.0: PME# supported from D0 D3hot
[    0.709575] pci 0000:02:00.0: 126.024 Gb/s available PCIe bandwidth, limited by 16.0 GT/s PCIe x8 link at 0000:00:01.1 (capable of 252.048 Gb/s with 16.0 GT/s PCIe x16 link)
[    0.709836] pci 0000:02:00.1: [10de:22bb] type 00 class 0x040300 PCIe Endpoint
[    0.709846] pci 0000:02:00.1: BAR 0 [mem 0x4f000000-0x4f003fff]
[    0.709962] pci 0000:00:01.1: PCI bridge to [bus 02]
[    0.710099] pci 0000:03:00.0: [8086:3102] type 00 class 0x020000 PCIe Endpoint
[    0.710124] pci 0000:03:00.0: BAR 0 [mem 0x4f100000-0x4f1fffff]
[    0.710162] pci 0000:03:00.0: BAR 3 [mem 0x4f200000-0x4f203fff]
[    0.710320] pci 0000:03:00.0: PME# supported from D0 D3hot D3cold
[    0.710602] pci 0000:00:1c.0: PCI bridge to [bus 03]
[    0.710712] pci 0000:04:00.0: [8086:5780] type 01 class 0x060400 PCIe Switch Upstream Port
[    0.710753] pci 0000:04:00.0: PCI bridge to [bus 05-54]
[    0.710764] pci 0000:04:00.0:   bridge window [mem 0x44000000-0x4befffff]
[    0.710778] pci 0000:04:00.0:   bridge window [mem 0x6410000000-0x74100fffff 64bit pref]
[    0.710794] pci 0000:04:00.0: enabling Extended Tags
[    0.710931] pci 0000:04:00.0: supports D1 D2
[    0.710932] pci 0000:04:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.711310] pci 0000:00:1d.0: PCI bridge to [bus 04-54]
[    0.711433] pci 0000:05:00.0: [8086:5780] type 01 class 0x060400 PCIe Switch Downstream Port
[    0.711473] pci 0000:05:00.0: PCI bridge to [bus 06]
[    0.711497] pci 0000:05:00.0:   bridge window [mem 0x7410000000-0x74100fffff 64bit pref]
[    0.711515] pci 0000:05:00.0: enabling Extended Tags
[    0.711643] pci 0000:05:00.0: supports D1 D2
[    0.711644] pci 0000:05:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.711917] pci 0000:05:01.0: [8086:5780] type 01 class 0x060400 PCIe Switch Downstream Port
[    0.711957] pci 0000:05:01.0: PCI bridge to [bus 07-2c]
[    0.711969] pci 0000:05:01.0:   bridge window [mem 0x48000000-0x4befffff]
[    0.711999] pci 0000:05:01.0: enabling Extended Tags
[    0.712136] pci 0000:05:01.0: supports D1 D2
[    0.712137] pci 0000:05:01.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.712412] pci 0000:05:02.0: [8086:5780] type 01 class 0x060400 PCIe Switch Downstream Port
[    0.712453] pci 0000:05:02.0: PCI bridge to [bus 2d]
[    0.712464] pci 0000:05:02.0:   bridge window [mem 0x47f00000-0x47ffffff]
[    0.712494] pci 0000:05:02.0: enabling Extended Tags
[    0.712621] pci 0000:05:02.0: supports D1 D2
[    0.712622] pci 0000:05:02.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.712894] pci 0000:05:03.0: [8086:5780] type 01 class 0x060400 PCIe Switch Downstream Port
[    0.712935] pci 0000:05:03.0: PCI bridge to [bus 2e-54]
[    0.712946] pci 0000:05:03.0:   bridge window [mem 0x44000000-0x47efffff]
[    0.712977] pci 0000:05:03.0: enabling Extended Tags
[    0.713113] pci 0000:05:03.0: supports D1 D2
[    0.713114] pci 0000:05:03.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.713399] pci 0000:04:00.0: PCI bridge to [bus 05-54]
[    0.713505] pci 0000:06:00.0: [8086:5781] type 00 class 0x0c0340 PCIe Endpoint
[    0.713533] pci 0000:06:00.0: BAR 0 [mem 0x7410000000-0x741003ffff 64bit pref]
[    0.713550] pci 0000:06:00.0: BAR 2 [mem 0x7410040000-0x7410040fff 64bit pref]
[    0.713592] pci 0000:06:00.0: enabling Extended Tags
[    0.713706] pci 0000:06:00.0: supports D1 D2
[    0.713707] pci 0000:06:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.713942] pci 0000:05:00.0: PCI bridge to [bus 06]
[    0.714014] pci 0000:05:01.0: PCI bridge to [bus 07-2c]
[    0.714120] pci 0000:2d:00.0: [8086:5782] type 00 class 0x0c0330 PCIe Endpoint
[    0.714143] pci 0000:2d:00.0: BAR 0 [mem 0x47f00000-0x47f0ffff 64bit]
[    0.714191] pci 0000:2d:00.0: enabling Extended Tags
[    0.714274] pci 0000:2d:00.0: PME# supported from D3hot D3cold
[    0.714312] pci 0000:2d:00.0: 8.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:05:02.0 (capable of 31.504 Gb/s with 8.0 GT/s PCIe x4 link)
[    0.714432] pci 0000:05:02.0: PCI bridge to [bus 2d]
[    0.714504] pci 0000:05:03.0: PCI bridge to [bus 2e-54]
[    0.739521] ACPI: EC: interrupt unblocked
[    0.739523] ACPI: EC: event unblocked
[    0.739538] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.739539] ACPI: EC: GPE=0x6e
[    0.739541] ACPI: \_SB_.PC00.LPCB.EC__: Boot DSDT EC initialization complete
[    0.739543] ACPI: \_SB_.PC00.LPCB.EC__: EC: Used to handle transactions and events
[    0.739953] iommu: Default domain type: Translated
[    0.739953] iommu: DMA domain TLB invalidation policy: lazy mode
[    0.740136] SCSI subsystem initialized
[    0.740149] libata version 3.00 loaded.
[    0.740149] ACPI: bus type USB registered
[    0.740149] usbcore: registered new interface driver usbfs
[    0.740149] usbcore: registered new interface driver hub
[    0.740149] usbcore: registered new device driver usb
[    0.740149] pps_core: LinuxPPS API ver. 1 registered
[    0.740149] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.740149] PTP clock support registered
[    0.740149] EDAC MC: Ver: 3.0.0
[    0.740948] efivars: Registered efivars operations
[    0.741244] NetLabel: Initializing
[    0.741245] NetLabel:  domain hash size = 128
[    0.741246] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.741275] NetLabel:  unlabeled traffic allowed by default
[    0.741298] mctp: management component transport protocol core
[    0.741298] NET: Registered PF_MCTP protocol family
[    0.741298] PCI: Using ACPI for IRQ routing
[    0.756283] PCI: pci_cache_line_size set to 64 bytes
[    0.756432] pci 0000:00:1f.5: BAR 0 [mem 0xfe010000-0xfe010fff]: can't claim; no compatible bridge window
[    0.756576] e820: reserve RAM buffer [mem 0x0009f000-0x0009ffff]
[    0.756578] e820: reserve RAM buffer [mem 0x26c18000-0x27ffffff]
[    0.756580] e820: reserve RAM buffer [mem 0x28a1f000-0x2bffffff]
[    0.756581] e820: reserve RAM buffer [mem 0x2c229000-0x2fffffff]
[    0.756582] e820: reserve RAM buffer [mem 0x2e93f000-0x2fffffff]
[    0.756583] e820: reserve RAM buffer [mem 0x33b00000-0x33ffffff]
[    0.756584] e820: reserve RAM buffer [mem 0x18bf800000-0x18bfffffff]
[    0.756949] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    0.756950] pci 0000:00:02.0: vgaarb: bridge control possible
[    0.756951] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    0.756956] pci 0000:02:00.0: vgaarb: bridge control possible
[    0.756957] pci 0000:02:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
[    0.756960] vgaarb: loaded
[    0.757121] clocksource: Switched to clocksource tsc-early
[    0.757472] VFS: Disk quotas dquot_6.6.0
[    0.757489] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.757646] AppArmor: AppArmor Filesystem Enabled
[    0.757680] pnp: PnP ACPI init
[    0.757944] pnp 00:00: disabling [io  0x3322-0x3323] because it overlaps 0000:00:01.1 BAR 13 [io  0x3000-0x3fff]
[    0.758158] system 00:02: [io  0x1854-0x1857] has been reserved
[    0.774719] pnp 00:05: disabling [mem 0xc0000000-0xcfffffff] because it overlaps 0000:00:02.0 BAR 9 [mem 0x00000000-0xdfffffff 64bit pref]
[    0.774758] system 00:05: [mem 0xfedc0000-0xfedc7fff] has been reserved
[    0.774761] system 00:05: [mem 0xfeda0000-0xfeda0fff] has been reserved
[    0.774763] system 00:05: [mem 0xfeda1000-0xfeda1fff] has been reserved
[    0.774765] system 00:05: [mem 0xfed20000-0xfed7ffff] could not be reserved
[    0.774767] system 00:05: [mem 0xfed90000-0xfed93fff] could not be reserved
[    0.774769] system 00:05: [mem 0xfed45000-0xfed8ffff] could not be reserved
[    0.774771] system 00:05: [mem 0xfee00000-0xfeefffff] has been reserved
[    0.775227] system 00:06: [io  0x2000-0x20fe] has been reserved
[    0.776689] pnp: PnP ACPI: found 8 devices
[    0.782856] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.782931] NET: Registered PF_INET protocol family
[    0.783281] IP idents hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.802406] tcp_listen_portaddr_hash hash table entries: 65536 (order: 8, 1048576 bytes, linear)
[    0.802512] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    0.803031] TCP established hash table entries: 524288 (order: 10, 4194304 bytes, linear)
[    0.803807] TCP bind hash table entries: 65536 (order: 9, 2097152 bytes, linear)
[    0.803929] TCP: Hash tables configured (established 524288 bind 65536)
[    0.804341] MPTCP token hash table entries: 65536 (order: 8, 1572864 bytes, linear)
[    0.804752] UDP hash table entries: 65536 (order: 9, 2097152 bytes, linear)
[    0.805221] UDP-Lite hash table entries: 65536 (order: 9, 2097152 bytes, linear)
[    0.805456] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.805464] NET: Registered PF_XDP protocol family
[    0.805469] pci 0000:02:00.0: ROM [mem 0xfff80000-0xffffffff pref]: can't claim; no compatible bridge window
[    0.805477] pci_bus 0000:00: max bus depth: 3 pci_try_num: 4
[    0.805493] pci 0000:00:02.0: VF BAR 2 [mem 0x4020000000-0x40ffffffff 64bit pref]: assigned
[    0.805497] pci 0000:00:02.0: VF BAR 0 [mem 0x4010000000-0x4016ffffff 64bit]: assigned
[    0.805501] pci 0000:00:15.0: BAR 0 [mem 0x4017000000-0x4017000fff 64bit]: assigned
[    0.805557] pci 0000:00:15.1: BAR 0 [mem 0x4017001000-0x4017001fff 64bit]: assigned
[    0.805663] pci 0000:00:1d.0: bridge window [io  0x5000-0x7fff]: assigned
[    0.805666] pci 0000:00:1f.5: BAR 0 [mem 0x40800000-0x40800fff]: assigned
[    0.805678] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.805702] pci 0000:02:00.0: ROM [mem 0x4f080000-0x4f0fffff pref]: assigned
[    0.805705] pci 0000:00:01.1: PCI bridge to [bus 02]
[    0.805707] pci 0000:00:01.1:   bridge window [io  0x3000-0x3fff]
[    0.805710] pci 0000:00:01.1:   bridge window [mem 0x4e000000-0x4f0fffff]
[    0.805713] pci 0000:00:01.1:   bridge window [mem 0x6000000000-0x6401ffffff 64bit pref]
[    0.805718] pci 0000:00:1c.0: PCI bridge to [bus 03]
[    0.805729] pci 0000:00:1c.0:   bridge window [mem 0x4f100000-0x4f2fffff]
[    0.805737] pci 0000:04:00.0: bridge window [io  0x5000-0x6fff]: assigned
[    0.805740] pci 0000:05:01.0: bridge window [mem 0x6410000000-0x64101fffff 64bit pref]: assigned
[    0.805742] pci 0000:05:03.0: bridge window [mem 0x6410200000-0x64103fffff 64bit pref]: assigned
[    0.805743] pci 0000:05:01.0: bridge window [io  0x5000-0x5fff]: assigned
[    0.805745] pci 0000:05:03.0: bridge window [io  0x6000-0x6fff]: assigned
[    0.805747] pci 0000:05:00.0: PCI bridge to [bus 06]
[    0.805768] pci 0000:05:00.0:   bridge window [mem 0x7410000000-0x74100fffff 64bit pref]
[    0.805775] pci 0000:05:01.0: PCI bridge to [bus 07-2c]
[    0.805778] pci 0000:05:01.0:   bridge window [io  0x5000-0x5fff]
[    0.805784] pci 0000:05:01.0:   bridge window [mem 0x48000000-0x4befffff]
[    0.805788] pci 0000:05:01.0:   bridge window [mem 0x6410000000-0x64101fffff 64bit pref]
[    0.805795] pci 0000:05:02.0: PCI bridge to [bus 2d]
[    0.805801] pci 0000:05:02.0:   bridge window [mem 0x47f00000-0x47ffffff]
[    0.805811] pci 0000:05:03.0: PCI bridge to [bus 2e-54]
[    0.805814] pci 0000:05:03.0:   bridge window [io  0x6000-0x6fff]
[    0.805819] pci 0000:05:03.0:   bridge window [mem 0x44000000-0x47efffff]
[    0.805824] pci 0000:05:03.0:   bridge window [mem 0x6410200000-0x64103fffff 64bit pref]
[    0.805831] pci 0000:04:00.0: PCI bridge to [bus 05-54]
[    0.805833] pci 0000:04:00.0:   bridge window [io  0x5000-0x6fff]
[    0.805839] pci 0000:04:00.0:   bridge window [mem 0x44000000-0x4befffff]
[    0.805843] pci 0000:04:00.0:   bridge window [mem 0x6410000000-0x74100fffff 64bit pref]
[    0.805850] pci 0000:00:1d.0: PCI bridge to [bus 04-54]
[    0.805852] pci 0000:00:1d.0:   bridge window [io  0x5000-0x7fff]
[    0.805857] pci 0000:00:1d.0:   bridge window [mem 0x44000000-0x4bffffff]
[    0.805860] pci 0000:00:1d.0:   bridge window [mem 0x6410000000-0x74100fffff 64bit pref]
[    0.805866] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.805868] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.805870] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    0.805871] pci_bus 0000:00: resource 7 [mem 0x40800000-0xbfffffff window]
[    0.805873] pci_bus 0000:00: resource 8 [mem 0x4000000000-0x7fffffffff window]
[    0.805875] pci_bus 0000:02: resource 0 [io  0x3000-0x3fff]
[    0.805876] pci_bus 0000:02: resource 1 [mem 0x4e000000-0x4f0fffff]
[    0.805878] pci_bus 0000:02: resource 2 [mem 0x6000000000-0x6401ffffff 64bit pref]
[    0.805879] pci_bus 0000:03: resource 1 [mem 0x4f100000-0x4f2fffff]
[    0.805881] pci_bus 0000:04: resource 0 [io  0x5000-0x7fff]
[    0.805882] pci_bus 0000:04: resource 1 [mem 0x44000000-0x4bffffff]
[    0.805883] pci_bus 0000:04: resource 2 [mem 0x6410000000-0x74100fffff 64bit pref]
[    0.805885] pci_bus 0000:05: resource 0 [io  0x5000-0x6fff]
[    0.805886] pci_bus 0000:05: resource 1 [mem 0x44000000-0x4befffff]
[    0.805888] pci_bus 0000:05: resource 2 [mem 0x6410000000-0x74100fffff 64bit pref]
[    0.805889] pci_bus 0000:06: resource 2 [mem 0x7410000000-0x74100fffff 64bit pref]
[    0.805891] pci_bus 0000:07: resource 0 [io  0x5000-0x5fff]
[    0.805892] pci_bus 0000:07: resource 1 [mem 0x48000000-0x4befffff]
[    0.805893] pci_bus 0000:07: resource 2 [mem 0x6410000000-0x64101fffff 64bit pref]
[    0.805895] pci_bus 0000:2d: resource 1 [mem 0x47f00000-0x47ffffff]
[    0.805896] pci_bus 0000:2e: resource 0 [io  0x6000-0x6fff]
[    0.805898] pci_bus 0000:2e: resource 1 [mem 0x44000000-0x47efffff]
[    0.805899] pci_bus 0000:2e: resource 2 [mem 0x6410200000-0x64103fffff 64bit pref]
[    0.808271] pci 0000:02:00.1: extending delay after power-on from D3hot to 20 msec
[    0.808307] pci 0000:02:00.1: D0 power state depends on 0000:02:00.0
[    0.808766] pci 0000:2d:00.0: enabling device (0000 -> 0002)
[    0.808803] PCI: CLS 64 bytes, default 64
[    0.808846] DMAR: No ATSR found
[    0.808847] DMAR: No SATC found
[    0.808848] DMAR: IOMMU feature fl1gp_support inconsistent
[    0.808849] DMAR: IOMMU feature pgsel_inv inconsistent
[    0.808850] DMAR: IOMMU feature nwfs inconsistent
[    0.808851] DMAR: IOMMU feature dit inconsistent
[    0.808852] DMAR: IOMMU feature sc_support inconsistent
[    0.808853] DMAR: IOMMU feature dev_iotlb_support inconsistent
[    0.808854] DMAR: dmar0: Using Queued invalidation
[    0.808858] DMAR: dmar1: Using Queued invalidation
[    0.808907] Trying to unpack rootfs image as initramfs...
[    0.809242] pci 0000:00:02.0: Adding to iommu group 0
[    0.810145] pci 0000:00:00.0: Adding to iommu group 1
[    0.810160] pci 0000:00:01.0: Adding to iommu group 2
[    0.810172] pci 0000:00:01.1: Adding to iommu group 3
[    0.810184] pci 0000:00:04.0: Adding to iommu group 4
[    0.810200] pci 0000:00:06.0: Adding to iommu group 5
[    0.810211] pci 0000:00:08.0: Adding to iommu group 6
[    0.810223] pci 0000:00:0a.0: Adding to iommu group 7
[    0.810234] pci 0000:00:0e.0: Adding to iommu group 8
[    0.810255] pci 0000:00:14.0: Adding to iommu group 9
[    0.810267] pci 0000:00:14.2: Adding to iommu group 9
[    0.810279] pci 0000:00:14.3: Adding to iommu group 10
[    0.810300] pci 0000:00:15.0: Adding to iommu group 11
[    0.810311] pci 0000:00:15.1: Adding to iommu group 11
[    0.810327] pci 0000:00:16.0: Adding to iommu group 12
[    0.810347] pci 0000:00:1c.0: Adding to iommu group 13
[    0.810372] pci 0000:00:1d.0: Adding to iommu group 14
[    0.810406] pci 0000:00:1f.0: Adding to iommu group 15
[    0.810419] pci 0000:00:1f.3: Adding to iommu group 15
[    0.810431] pci 0000:00:1f.4: Adding to iommu group 15
[    0.810444] pci 0000:00:1f.5: Adding to iommu group 15
[    0.810465] pci 0000:02:00.0: Adding to iommu group 16
[    0.810479] pci 0000:02:00.1: Adding to iommu group 16
[    0.810497] pci 0000:03:00.0: Adding to iommu group 17
[    0.810526] pci 0000:04:00.0: Adding to iommu group 18
[    0.810547] pci 0000:05:00.0: Adding to iommu group 19
[    0.810572] pci 0000:05:01.0: Adding to iommu group 20
[    0.810590] pci 0000:05:02.0: Adding to iommu group 21
[    0.810604] pci 0000:05:03.0: Adding to iommu group 22
[    0.810634] pci 0000:06:00.0: Adding to iommu group 23
[    0.810663] pci 0000:2d:00.0: Adding to iommu group 24
[    0.816490] DMAR: Intel(R) Virtualization Technology for Directed I/O
[    0.816494] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.816495] software IO TLB: mapped [mem 0x0000000022c18000-0x0000000026c18000] (64MB)
[    0.821102] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x22df1149949, max_idle_ns: 440795312789 ns
[    0.821160] clocksource: Switched to clocksource tsc
[    0.825982] Initialise system trusted keyrings
[    0.825993] Key type blacklist registered
[    0.826043] workingset: timestamp_bits=36 max_order=25 bucket_order=0
[    0.826054] zbud: loaded
[    0.826397] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.826516] fuse: init (API version 7.39)
[    0.826716] integrity: Platform Keyring initialized
[    0.826723] integrity: Machine keyring initialized
[    0.841163] Key type asymmetric registered
[    0.841165] Asymmetric key parser 'x509' registered
[    0.841187] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 243)
[    0.841270] io scheduler mq-deadline registered
[    0.842088] pcieport 0000:00:01.0: PME: Signaling with IRQ 122
[    0.842395] pcieport 0000:00:01.1: PME: Signaling with IRQ 123
[    0.842729] pcieport 0000:00:1c.0: PME: Signaling with IRQ 124
[    0.842937] pcieport 0000:00:1d.0: PME: Signaling with IRQ 125
[    0.842981] pcieport 0000:00:1d.0: pciehp: Slot #8 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
[    0.843939] pcieport 0000:05:01.0: pciehp: Slot #1 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
[    0.844588] pcieport 0000:05:03.0: pciehp: Slot #3 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
[    0.844837] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    0.845193] Monitor-Mwait will be used to enter C-1 state
[    0.845215] Monitor-Mwait will be used to enter C-2 state
[    0.845230] Monitor-Mwait will be used to enter C-3 state
[    0.845237] ACPI: \_SB_.PR00: Found 3 idle states
[    0.848562] ACPI: AC: AC Adapter [AC] (on-line)
[    0.848649] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    0.848701] ACPI: button: Power Button [PWRB]
[    0.848736] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input1
[    0.848778] ACPI: button: Sleep Button [SLPB]
[    0.848814] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input2
[    0.848846] ACPI: button: Lid Switch [LID0]
[    0.848882] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
[    0.848925] ACPI: button: Power Button [PWRF]
[    0.926264] thermal LNXTHERM:00: registered as thermal_zone0
[    0.926268] ACPI: thermal: Thermal Zone [TZ0] (25 C)
[    0.926642] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    0.927652] ACPI: battery: Slot [BAT0] (battery present)
[    0.929369] hpet_acpi_add: no address or irqs in _CRS
[    0.929413] Linux agpgart interface v0.103
[    0.931412] tpm_tis IFX1523:00: 2.0 TPM (device-id 0x1D, rev-id 54)
[    0.947939] loop: module loaded
[    0.948471] ACPI: bus type drm_connector registered
[    0.948771] tun: Universal TUN/TAP device driver, 1.6
[    0.948817] PPP generic driver version 2.4.2
[    0.948955] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[    0.952387] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.952391] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.952528] mousedev: PS/2 mouse device common for all mice
[    0.952699] rtc_cmos 00:01: RTC can wake from S4
[    0.953525] rtc_cmos 00:01: registered as rtc0
[    0.953685] rtc_cmos 00:01: setting system clock to 2024-10-11T03:44:22 UTC (1728618262)
[    0.953730] rtc_cmos 00:01: alarms up to one month, y3k, 242 bytes nvram
[    0.953741] i2c_dev: i2c /dev entries driver
[    0.955866] device-mapper: core: CONFIG_IMA_DISABLE_HTABLE is disabled. Duplicate IMA measurements will not be recorded in the IMA log.
[    0.955886] device-mapper: uevent: version 1.0.3
[    0.955947] device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) initialised: dm-devel@redhat.com
[    0.955968] platform eisa.0: Probing EISA bus 0
[    0.955977] platform eisa.0: EISA: Cannot allocate resource for mainboard
[    0.955979] platform eisa.0: Cannot allocate resource for EISA slot 1
[    0.955981] platform eisa.0: Cannot allocate resource for EISA slot 2
[    0.955982] platform eisa.0: Cannot allocate resource for EISA slot 3
[    0.955983] platform eisa.0: Cannot allocate resource for EISA slot 4
[    0.955985] platform eisa.0: Cannot allocate resource for EISA slot 5
[    0.955986] platform eisa.0: Cannot allocate resource for EISA slot 6
[    0.955987] platform eisa.0: Cannot allocate resource for EISA slot 7
[    0.955988] platform eisa.0: Cannot allocate resource for EISA slot 8
[    0.955990] platform eisa.0: EISA: Detected 0 cards
[    0.955993] intel_pstate: Intel P-state driver initializing
[    0.960219] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input5
[    0.962194] intel_pstate: HWP enabled
[    0.963295] ledtrig-cpu: registered to indicate activity on CPUs
[    0.963528] [drm] Initialized simpledrm 1.0.0 20200625 for simple-framebuffer.0 on minor 0
[    0.965013] fbcon: Deferring console take-over
[    0.965015] simple-framebuffer simple-framebuffer.0: [drm] fb0: simpledrmdrmfb frame buffer device
[    0.965204] drop_monitor: Initializing network drop monitor service
[    0.965330] NET: Registered PF_INET6 protocol family
[    1.039344] Freeing initrd memory: 159980K
[    1.047932] Segment Routing with IPv6
[    1.047947] In-situ OAM (IOAM) with IPv6
[    1.047980] NET: Registered PF_PACKET protocol family
[    1.048265] Key type dns_resolver registered
[    1.053883] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    1.055817] microcode: Current revision: 0x00000129
[    1.057986] IPI shorthand broadcast: enabled
[    1.059999] sched_clock: Marking stable (1052000925, 7610457)->(1129524456, -69913074)
[    1.060755] registered taskstats version 1
[    1.065023] Loading compiled-in X.509 certificates
[    1.065814] Loaded X.509 cert 'Build time autogenerated kernel key: 9be8e5b2569132a22d1fff4e72c8e5b54f0dca0d'
[    1.066439] Loaded X.509 cert 'Canonical Ltd. Live Patch Signing: 14df34d1a87cf37625abec039ef2bf521249b969'
[    1.067089] Loaded X.509 cert 'Canonical Ltd. Kernel Module Signing: 88f752e560a1e0737e31163a466ad7b70a850c19'
[    1.067091] blacklist: Loading compiled-in revocation X.509 certificates
[    1.067118] Loaded X.509 cert 'Canonical Ltd. Secure Boot Signing: 61482aa2830d0ab2ad5af10b7250da9033ddcef0'
[    1.067139] Loaded X.509 cert 'Canonical Ltd. Secure Boot Signing (2017): 242ade75ac4a15e50d50c84b0d45ff3eae707a03'
[    1.067157] Loaded X.509 cert 'Canonical Ltd. Secure Boot Signing (ESM 2018): 365188c1d374d6b07c3c8f240f8ef722433d6a8b'
[    1.067175] Loaded X.509 cert 'Canonical Ltd. Secure Boot Signing (2019): c0746fd6c5da3ae827864651ad66ae47fe24b3e8'
[    1.067193] Loaded X.509 cert 'Canonical Ltd. Secure Boot Signing (2021 v1): a8d54bbb3825cfb94fa13c9f8a594a195c107b8d'
[    1.067211] Loaded X.509 cert 'Canonical Ltd. Secure Boot Signing (2021 v2): 4cf046892d6fd3c9a5b03f98d845f90851dc6a8c'
[    1.067230] Loaded X.509 cert 'Canonical Ltd. Secure Boot Signing (2021 v3): 100437bb6de6e469b581e61cd66bce3ef4ed53af'
[    1.067248] Loaded X.509 cert 'Canonical Ltd. Secure Boot Signing (Ubuntu Core 2019): c1d57b8f6b743f23ee41f4f7ee292f06eecadfb9'
[    1.071166] Key type .fscrypt registered
[    1.071168] Key type fscrypt-provisioning registered
[    1.071227] Key type trusted registered
[    1.081466] cryptd: max_cpu_qlen set to 1000
[    1.085862] AVX2 version of gcm_enc/dec engaged.
[    1.085916] AES CTR mode by8 optimization enabled
[    1.097966] Key type encrypted registered
[    1.097982] AppArmor: AppArmor sha256 policy hashing enabled
[    1.101843] integrity: Loading X.509 certificate: UEFI:db
[    1.101929] integrity: Loaded X.509 cert 'Microsoft Windows Production PCA 2011: a92902398e16c49778cd90f99e4f9ae17c55af53'
[    1.101931] integrity: Loading X.509 certificate: UEFI:db
[    1.101952] integrity: Loaded X.509 cert 'Microsoft Corporation: Windows UEFI CA 2023: aefc5fbbbe055d8f8daa585473499417ab5a5272'
[    1.101953] integrity: Loading X.509 certificate: UEFI:db
[    1.101970] integrity: Loaded X.509 cert 'Microsoft Corporation UEFI CA 2011: 13adbf4309bd82709c8cd54f316ed522988a1bd4'
[    1.101971] integrity: Loading X.509 certificate: UEFI:db
[    1.101987] integrity: Loaded X.509 cert 'Microsoft UEFI CA 2023: 81aa6b3244c935bce0d6628af39827421e32497d'
[    1.101988] integrity: Loading X.509 certificate: UEFI:db
[    1.102427] integrity: Loaded X.509 cert 'Secure Certificate: 01dcc89619884ca147983429f8a4a1a0'
[    1.102431] integrity: Loading X.509 certificate: UEFI:db
[    1.102598] integrity: Loaded X.509 cert 'Cus CA: d6136d376b87ef934511c12ce2c3880c'
[    1.109958] Loading compiled-in module X.509 certificates
[    1.110417] Loaded X.509 cert 'Build time autogenerated kernel key: 9be8e5b2569132a22d1fff4e72c8e5b54f0dca0d'
[    1.110420] ima: Allocated hash algorithm: sha256
[    1.134814] ima: No architecture policies found
[    1.134843] evm: Initialising EVM extended attributes:
[    1.134845] evm: security.selinux
[    1.134848] evm: security.SMACK64
[    1.134849] evm: security.SMACK64EXEC
[    1.134850] evm: security.SMACK64TRANSMUTE
[    1.134852] evm: security.SMACK64MMAP
[    1.134853] evm: security.apparmor
[    1.134854] evm: security.ima
[    1.134855] evm: security.capability
[    1.134857] evm: HMAC attrs: 0x1
[    1.135420] PM:   Magic number: 12:849:714
[    1.141468] RAS: Correctable Errors collector initialized.
[    1.141590] clk: Disabling unused clocks
[    1.156365] Freeing unused decrypted memory: 2028K
[    1.157310] Freeing unused kernel image (initmem) memory: 4976K
[    1.157312] Write protecting the kernel read-only data: 36864k
[    1.158197] Freeing unused kernel image (rodata/data gap) memory: 428K
[    1.167108] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    1.167113] Run /init as init process
[    1.167114]   with arguments:
[    1.167115]     /init
[    1.167115]     splash
[    1.167116]   with environment:
[    1.167117]     HOME=/
[    1.167117]     TERM=linux
[    1.167118]     BOOT_IMAGE=/@boot/vmlinuz-6.8.0-45-kfocus
[    1.167118]     cryptdevice=UUID=9992e62a-e20e-4d65-8cd4-d1988f6f3ab3:luks-9992e62a-e20e-4d65-8cd4-d1988f6f3ab3
[    1.253726] wmi_bus wmi_bus-PNP0C14:01: WQ00 data block query control method not found
[    1.254064] hid: raw HID events driver (C) Jiri Kosina
[    1.259568] vmd 0000:00:0e.0: PCI host bridge to bus 10000:e0
[    1.259572] pci_bus 10000:e0: root bus resource [bus e0-ff]
[    1.259574] pci_bus 10000:e0: root bus resource [mem 0x4c000000-0x4dffffff]
[    1.259575] pci_bus 10000:e0: root bus resource [mem 0x6405102000-0x64051fffff 64bit]
[    1.259599] pci 10000:e0:06.0: [8086:a74d] type 01 class 0x060400 PCIe Root Port
[    1.259617] pci 10000:e0:06.0: PCI bridge to [bus e1]
[    1.259621] pci 10000:e0:06.0:   bridge window [io  0x0000-0x0fff]
[    1.259623] pci 10000:e0:06.0:   bridge window [mem 0x4c000000-0x4c0fffff]
[    1.259666] pci 10000:e0:06.0: PME# supported from D0 D3hot D3cold
[    1.259688] pci 10000:e0:06.0: PTM enabled (root), 4ns granularity
[    1.259784] pci 10000:e0:06.0: Adding to iommu group 8
[    1.259803] pci 10000:e0:06.0: Primary bus is hard wired to 0
[    1.259840] pci 10000:e1:00.0: [144d:a808] type 00 class 0x010802 PCIe Endpoint
[    1.259859] pci 10000:e1:00.0: BAR 0 [mem 0x4c000000-0x4c003fff 64bit]
[    1.260063] pci 10000:e1:00.0: Adding to iommu group 8
[    1.260073] pci 10000:e0:06.0: PCI bridge to [bus e1]
[    1.260078] pci 10000:e0:06.0: Primary bus is hard wired to 0
[    1.260622] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    1.260630] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
[    1.261802] xhci_hcd 0000:00:14.0: hcc params 0x20007fc1 hci version 0x120 quirks 0x0000000200009810
[    1.262353] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    1.262356] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
[    1.262358] xhci_hcd 0000:00:14.0: Host supports USB 3.2 Enhanced SuperSpeed
[    1.262409] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.08
[    1.262412] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.262414] usb usb1: Product: xHCI Host Controller
[    1.262415] usb usb1: Manufacturer: Linux 6.8.0-45-kfocus xhci-hcd
[    1.262416] usb usb1: SerialNumber: 0000:00:14.0
[    1.262716] hub 1-0:1.0: USB hub found
[    1.262765] hub 1-0:1.0: 16 ports detected
[    1.263475] Intel(R) 2.5G Ethernet Linux Driver
[    1.263478] Copyright(c) 2018 Intel Corporation.
[    1.263764] igc 0000:03:00.0: PTM enabled, 4ns granularity
[    1.265691] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.08
[    1.265694] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.265695] usb usb2: Product: xHCI Host Controller
[    1.265696] usb usb2: Manufacturer: Linux 6.8.0-45-kfocus xhci-hcd
[    1.265697] usb usb2: SerialNumber: 0000:00:14.0
[    1.265788] hub 2-0:1.0: USB hub found
[    1.265809] hub 2-0:1.0: 10 ports detected
[    1.267339] xhci_hcd 0000:2d:00.0: xHCI Host Controller
[    1.267344] xhci_hcd 0000:2d:00.0: new USB bus registered, assigned bus number 3
[    1.268532] xhci_hcd 0000:2d:00.0: hcc params 0x20007fc1 hci version 0x120 quirks 0x0000000200009810
[    1.268942] xhci_hcd 0000:2d:00.0: xHCI Host Controller
[    1.268944] xhci_hcd 0000:2d:00.0: new USB bus registered, assigned bus number 4
[    1.268946] xhci_hcd 0000:2d:00.0: Host supports USB 3.2 Enhanced SuperSpeed
[    1.269185] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.08
[    1.269189] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.269190] usb usb3: Product: xHCI Host Controller
[    1.269191] usb usb3: Manufacturer: Linux 6.8.0-45-kfocus xhci-hcd
[    1.269192] usb usb3: SerialNumber: 0000:2d:00.0
[    1.269339] hub 3-0:1.0: USB hub found
[    1.269361] hub 3-0:1.0: 2 ports detected
[    1.270327] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.08
[    1.270330] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.270331] usb usb4: Product: xHCI Host Controller
[    1.270332] usb usb4: Manufacturer: Linux 6.8.0-45-kfocus xhci-hcd
[    1.270333] usb usb4: SerialNumber: 0000:2d:00.0
[    1.270448] hub 4-0:1.0: USB hub found
[    1.270456] hub 4-0:1.0: 2 ports detected
[    1.271632] intel-lpss 0000:00:15.0: enabling device (0004 -> 0006)
[    1.272057] idma64 idma64.0: Found Intel integrated DMA 64-bit
[    1.275849] ACPI: bus type thunderbolt registered
[    1.276032] thunderbolt 0000:06:00.0: total paths: 12
[    1.276038] thunderbolt 0000:06:00.0: IOMMU DMA protection is enabled
[    1.313325] pps pps0: new PPS source ptp0
[    1.313379] igc 0000:03:00.0 (unnamed net_device) (uninitialized): PHC added
[    1.339070] igc 0000:03:00.0: 4.000 Gb/s available PCIe bandwidth (5.0 GT/s PCIe x1 link)
[    1.339073] igc 0000:03:00.0 eth0: MAC: d4:93:90:48:c5:ea
[    1.339981] igc 0000:03:00.0 enp3s0: renamed from eth0
[    1.381768] thunderbolt 0000:06:00.0: host router reset successful
[    1.382174] thunderbolt 0000:06:00.0: allocating TX ring 0 of size 10
[    1.382212] thunderbolt 0000:06:00.0: allocating RX ring 0 of size 10
[    1.382245] thunderbolt 0000:06:00.0: control channel created
[    1.382247] thunderbolt 0000:06:00.0: using software connection manager
[    1.382718] thunderbolt 0000:06:00.0: device links to tunneled native ports are missing!
[    1.382720] thunderbolt 0000:06:00.0: NHI initialized, starting thunderbolt
[    1.382721] thunderbolt 0000:06:00.0: control channel starting...
[    1.382722] thunderbolt 0000:06:00.0: starting TX ring 0
[    1.382736] thunderbolt 0000:06:00.0: enabling interrupt at register 0x38200 bit 0 (0x0 -> 0x1)
[    1.382739] thunderbolt 0000:06:00.0: starting RX ring 0
[    1.382747] thunderbolt 0000:06:00.0: enabling interrupt at register 0x38200 bit 12 (0x1 -> 0x1001)
[    1.382751] thunderbolt 0000:06:00.0: security level set to user
[    1.382936] thunderbolt 0000:06:00.0: current switch config:
[    1.382939] thunderbolt 0000:06:00.0:  USB4 Switch: 8087:5781 (Revision: 131, TB Version: 64)
[    1.382942] thunderbolt 0000:06:00.0:   Max Port Number: 23
[    1.382946] thunderbolt 0000:06:00.0:   Config:
[    1.382947] thunderbolt 0000:06:00.0:    Upstream Port Number: 15 Depth: 0 Route String: 0x0 Enabled: 0, PlugEventsDelay: 10ms
[    1.382949] thunderbolt 0000:06:00.0:    unknown1: 0x0 unknown4: 0x0
[    1.386008] thunderbolt 0000:06:00.0: initializing Switch at 0x0 (depth: 0, up port: 15)
[    1.387169] thunderbolt 0000:06:00.0: 0: credit allocation parameters:
[    1.387177] thunderbolt 0000:06:00.0: 0:  USB3: 20
[    1.387182] thunderbolt 0000:06:00.0: 0:  DP AUX: 1
[    1.387186] thunderbolt 0000:06:00.0: 0:  DP main: 6
[    1.387190] thunderbolt 0000:06:00.0: 0:  PCIe: 80
[    1.387194] thunderbolt 0000:06:00.0: 0:  DMA: 40
[    1.389588] thunderbolt 0000:06:00.0: 0: DROM version: 3
[    1.389590] thunderbolt 0000:06:00.0: 0: DROM data CRC32 mismatch (expected: 0x56000000, got: 0x56473b0f), continuing
[    1.390230] thunderbolt 0000:06:00.0: 0: uid: 0xb9cde50000006ecd
[    1.391508] thunderbolt 0000:06:00.0:  Port 1: 0:5780 (Revision: 0, TB Version: 1, Type: Port (0x1))
[    1.391511] thunderbolt 0000:06:00.0:   Max hop id (in/out): 31/31
[    1.391512] thunderbolt 0000:06:00.0:   Max counters: 4
[    1.391514] thunderbolt 0000:06:00.0:   NFC Credits: 0x8a000000
[    1.391515] thunderbolt 0000:06:00.0:   Credits (total/control): 160/2
[    1.392660] thunderbolt 0000:06:00.0:  Port 2: 0:5780 (Revision: 0, TB Version: 1, Type: Port (0x1))
[    1.392662] thunderbolt 0000:06:00.0:   Max hop id (in/out): 31/31
[    1.392663] thunderbolt 0000:06:00.0:   Max counters: 0
[    1.392664] thunderbolt 0000:06:00.0:   NFC Credits: 0xa000000
[    1.392665] thunderbolt 0000:06:00.0:   Credits (total/control): 160/2
[    1.393939] thunderbolt 0000:06:00.0:  Port 3: 0:5780 (Revision: 0, TB Version: 1, Type: Port (0x1))
[    1.393941] thunderbolt 0000:06:00.0:   Max hop id (in/out): 31/31
[    1.393942] thunderbolt 0000:06:00.0:   Max counters: 4
[    1.393943] thunderbolt 0000:06:00.0:   NFC Credits: 0x8a000000
[    1.393944] thunderbolt 0000:06:00.0:   Credits (total/control): 160/2
[    1.395092] thunderbolt 0000:06:00.0:  Port 4: 0:5780 (Revision: 0, TB Version: 1, Type: Port (0x1))
[    1.395094] thunderbolt 0000:06:00.0:   Max hop id (in/out): 31/31
[    1.395095] thunderbolt 0000:06:00.0:   Max counters: 0
[    1.395096] thunderbolt 0000:06:00.0:   NFC Credits: 0xa000000
[    1.395097] thunderbolt 0000:06:00.0:   Credits (total/control): 160/2
[    1.396372] thunderbolt 0000:06:00.0: acking hot plug event on 0:13
[    1.396378] thunderbolt 0000:06:00.0:  Port 5: 0:5780 (Revision: 0, TB Version: 1, Type: Inactive (0x0))
[    1.396380] thunderbolt 0000:06:00.0:   Max hop id (in/out): 31/31
[    1.396381] thunderbolt 0000:06:00.0:   Max counters: 4
[    1.396382] thunderbolt 0000:06:00.0:   NFC Credits: 0x8a000000
[    1.396383] thunderbolt 0000:06:00.0:   Credits (total/control): 160/0
[    1.396499] thunderbolt 0000:06:00.0: acking hot plug event on 0:14
[    1.396626] thunderbolt 0000:06:00.0: acking hot plug event on 0:16
[    1.397140] thunderbolt 0000:06:00.0:  Port 6: 0:5780 (Revision: 0, TB Version: 1, Type: Inactive (0x0))
[    1.397142] thunderbolt 0000:06:00.0:   Max hop id (in/out): 31/31
[    1.397143] thunderbolt 0000:06:00.0:   Max counters: 0
[    1.397143] thunderbolt 0000:06:00.0:   NFC Credits: 0xa000000
[    1.397144] thunderbolt 0000:06:00.0:   Credits (total/control): 160/0
[    1.398420] thunderbolt 0000:06:00.0:  Port 7: 0:5780 (Revision: 0, TB Version: 1, Type: Inactive (0x0))
[    1.398421] thunderbolt 0000:06:00.0:   Max hop id (in/out): 31/31
[    1.398422] thunderbolt 0000:06:00.0:   Max counters: 4
[    1.398423] thunderbolt 0000:06:00.0:   NFC Credits: 0x8a000000
[    1.398424] thunderbolt 0000:06:00.0:   Credits (total/control): 160/0
[    1.399188] thunderbolt 0000:06:00.0:  Port 8: 0:5780 (Revision: 0, TB Version: 1, Type: Inactive (0x0))
[    1.399189] thunderbolt 0000:06:00.0:   Max hop id (in/out): 31/31
[    1.399190] thunderbolt 0000:06:00.0:   Max counters: 0
[    1.399191] thunderbolt 0000:06:00.0:   NFC Credits: 0xa000000
[    1.399192] thunderbolt 0000:06:00.0:   Credits (total/control): 160/0
[    1.399444] thunderbolt 0000:06:00.0:  Port 9: 0:5780 (Revision: 0, TB Version: 1, Type: PCIe (0x100101))
[    1.399446] thunderbolt 0000:06:00.0:   Max hop id (in/out): 8/8
[    1.399447] thunderbolt 0000:06:00.0:   Max counters: 2
[    1.399448] thunderbolt 0000:06:00.0:   NFC Credits: 0x40800000
[    1.399448] thunderbolt 0000:06:00.0:   Credits (total/control): 8/0
[    1.399704] thunderbolt 0000:06:00.0:  Port 10: 0:5780 (Revision: 0, TB Version: 1, Type: PCIe (0x100101))
[    1.399705] thunderbolt 0000:06:00.0:   Max hop id (in/out): 8/8
[    1.399706] thunderbolt 0000:06:00.0:   Max counters: 2
[    1.399707] thunderbolt 0000:06:00.0:   NFC Credits: 0x40800000
[    1.399708] thunderbolt 0000:06:00.0:   Credits (total/control): 8/0
[    1.400212] thunderbolt 0000:06:00.0:  Port 11: 0:5780 (Revision: 0, TB Version: 1, Type: DP/HDMI (0xe0102))
[    1.400214] thunderbolt 0000:06:00.0:   Max hop id (in/out): 9/9
[    1.400215] thunderbolt 0000:06:00.0:   Max counters: 2
[    1.400215] thunderbolt 0000:06:00.0:   NFC Credits: 0x800000
[    1.400216] thunderbolt 0000:06:00.0:   Credits (total/control): 8/0
[    1.400725] thunderbolt 0000:06:00.0:  Port 12: 0:5780 (Revision: 0, TB Version: 1, Type: DP/HDMI (0xe0102))
[    1.400727] thunderbolt 0000:06:00.0:   Max hop id (in/out): 9/9
[    1.400728] thunderbolt 0000:06:00.0:   Max counters: 2
[    1.400729] thunderbolt 0000:06:00.0:   NFC Credits: 0x800000
[    1.400730] thunderbolt 0000:06:00.0:   Credits (total/control): 8/0
[    1.400980] thunderbolt 0000:06:00.0:  Port 13: 0:5780 (Revision: 0, TB Version: 1, Type: DP/HDMI (0xe0101))
[    1.400981] thunderbolt 0000:06:00.0:   Max hop id (in/out): 9/9
[    1.400982] thunderbolt 0000:06:00.0:   Max counters: 2
[    1.400983] thunderbolt 0000:06:00.0:   NFC Credits: 0x100000d
[    1.400984] thunderbolt 0000:06:00.0:   Credits (total/control): 16/0
[    1.401235] thunderbolt 0000:06:00.0:  Port 14: 0:5780 (Revision: 0, TB Version: 1, Type: DP/HDMI (0xe0101))
[    1.401236] thunderbolt 0000:06:00.0:   Max hop id (in/out): 9/9
[    1.401237] thunderbolt 0000:06:00.0:   Max counters: 2
[    1.401238] thunderbolt 0000:06:00.0:   NFC Credits: 0x100000d
[    1.401239] thunderbolt 0000:06:00.0:   Credits (total/control): 16/0
[    1.402004] thunderbolt 0000:06:00.0:  Port 15: 0:5780 (Revision: 0, TB Version: 1, Type: NHI (0x2))
[    1.402006] thunderbolt 0000:06:00.0:   Max hop id (in/out): 11/11
[    1.402007] thunderbolt 0000:06:00.0:   Max counters: 4
[    1.402008] thunderbolt 0000:06:00.0:   NFC Credits: 0x41c00000
[    1.402009] thunderbolt 0000:06:00.0:   Credits (total/control): 28/0
[    1.402010] thunderbolt 0000:06:00.0: 0:16: disabled by eeprom
[    1.402260] thunderbolt 0000:06:00.0:  Port 17: 0:5780 (Revision: 0, TB Version: 1, Type: Inactive (0x0))
[    1.402261] thunderbolt 0000:06:00.0:   Max hop id (in/out): 8/8
[    1.402262] thunderbolt 0000:06:00.0:   Max counters: 2
[    1.402263] thunderbolt 0000:06:00.0:   NFC Credits: 0x40800000
[    1.402264] thunderbolt 0000:06:00.0:   Credits (total/control): 8/0
[    1.402516] thunderbolt 0000:06:00.0:  Port 18: 0:5780 (Revision: 0, TB Version: 1, Type: Inactive (0x0))
[    1.402518] thunderbolt 0000:06:00.0:   Max hop id (in/out): 8/8
[    1.402519] thunderbolt 0000:06:00.0:   Max counters: 2
[    1.402520] thunderbolt 0000:06:00.0:   NFC Credits: 0x40800000
[    1.402521] thunderbolt 0000:06:00.0:   Credits (total/control): 8/0
[    1.403037] thunderbolt 0000:06:00.0:  Port 19: 0:5780 (Revision: 0, TB Version: 1, Type: DP/HDMI (0xe0102))
[    1.403043] thunderbolt 0000:06:00.0:   Max hop id (in/out): 9/9
[    1.403047] thunderbolt 0000:06:00.0:   Max counters: 2
[    1.403050] thunderbolt 0000:06:00.0:   NFC Credits: 0x800000
[    1.403054] thunderbolt 0000:06:00.0:   Credits (total/control): 8/0
[    1.403284] thunderbolt 0000:06:00.0:  Port 20: 0:5780 (Revision: 0, TB Version: 1, Type: Inactive (0x0))
[    1.403285] thunderbolt 0000:06:00.0:   Max hop id (in/out): 8/8
[    1.403286] thunderbolt 0000:06:00.0:   Max counters: 1
[    1.403287] thunderbolt 0000:06:00.0:   NFC Credits: 0x800000
[    1.403288] thunderbolt 0000:06:00.0:   Credits (total/control): 8/0
[    1.403540] thunderbolt 0000:06:00.0:  Port 21: 0:5780 (Revision: 0, TB Version: 1, Type: USB (0x200101))
[    1.403541] thunderbolt 0000:06:00.0:   Max hop id (in/out): 8/8
[    1.403542] thunderbolt 0000:06:00.0:   Max counters: 1
[    1.403543] thunderbolt 0000:06:00.0:   NFC Credits: 0x800000
[    1.403544] thunderbolt 0000:06:00.0:   Credits (total/control): 8/0
[    1.403796] thunderbolt 0000:06:00.0:  Port 22: 0:5780 (Revision: 0, TB Version: 1, Type: USB (0x200101))
[    1.403798] thunderbolt 0000:06:00.0:   Max hop id (in/out): 8/8
[    1.403798] thunderbolt 0000:06:00.0:   Max counters: 1
[    1.403799] thunderbolt 0000:06:00.0:   NFC Credits: 0x800000
[    1.403800] thunderbolt 0000:06:00.0:   Credits (total/control): 8/0
[    1.404051] thunderbolt 0000:06:00.0:  Port 23: 0:5780 (Revision: 0, TB Version: 1, Type: Inactive (0x0))
[    1.404053] thunderbolt 0000:06:00.0:   Max hop id (in/out): 8/8
[    1.404054] thunderbolt 0000:06:00.0:   Max counters: 1
[    1.404055] thunderbolt 0000:06:00.0:   NFC Credits: 0x800000
[    1.404056] thunderbolt 0000:06:00.0:   Credits (total/control): 8/0
[    1.404057] thunderbolt 0000:06:00.0: 0: running quirk_usb3_maximum_bandwidth [thunderbolt]
[    1.404096] thunderbolt 0000:06:00.0: 0:21: USB3 maximum bandwidth limited to 16376 Mb/s
[    1.404098] thunderbolt 0000:06:00.0: 0:22: USB3 maximum bandwidth limited to 16376 Mb/s
[    1.404099] thunderbolt 0000:06:00.0: 0: running quirk_block_rpm_in_redrive [thunderbolt]
[    1.404122] thunderbolt 0000:06:00.0: 0: preventing runtime PM in DP redrive mode
[    1.404123] thunderbolt 0000:06:00.0: 0: linked ports 1 <-> 2
[    1.404125] thunderbolt 0000:06:00.0: 0: linked ports 3 <-> 4
[    1.409747] intel-lpss 0000:00:15.1: enabling device (0004 -> 0006)
[    1.410025] idma64 idma64.1: Found Intel integrated DMA 64-bit
[    1.412371] thunderbolt 0000:06:00.0: 0: TMU: supports uni-directional mode
[    1.412373] thunderbolt 0000:06:00.0: 0: TMU: supports enhanced uni-directional mode
[    1.412499] thunderbolt 0000:06:00.0: 0: TMU: current mode: off
[    1.416488] thunderbolt 0000:06:00.0: 0: NVM version 14.86
[    1.416559] thunderbolt 0000:06:00.0: 0: TMU: mode change off -> uni-directional, LowRes requested
[    1.416979] thunderbolt 0000:06:00.0: 0: TMU: mode set to: uni-directional, LowRes
[    1.417364] thunderbolt 0000:06:00.0: 0:1: is unplugged (state: 7)
[    1.417502] thunderbolt 0000:06:00.0: 0:3: is unplugged (state: 7)
[    1.419284] thunderbolt 0000:06:00.0: 0:13: DP IN resource available
[    1.419923] thunderbolt 0000:06:00.0: 0:14: DP IN resource available
[    1.422809] pci 10000:e0:06.0: bridge window [mem 0x4c000000-0x4c0fffff]: assigned
[    1.422812] pci 10000:e0:06.0: bridge window [io  size 0x1000]: can't assign; no space
[    1.422813] pci 10000:e0:06.0: bridge window [io  size 0x1000]: failed to assign
[    1.422815] pci 10000:e1:00.0: BAR 0 [mem 0x4c000000-0x4c003fff 64bit]: assigned
[    1.422824] pci 10000:e0:06.0: PCI bridge to [bus e1]
[    1.422826] pci 10000:e0:06.0:   bridge window [mem 0x4c000000-0x4c0fffff]
[    1.422857] pcieport 10000:e0:06.0: can't derive routing for PCI INT D
[    1.422858] pcieport 10000:e0:06.0: PCI INT D: no GSI
[    1.422913] pcieport 10000:e0:06.0: PME: Signaling with IRQ 186
[    1.422971] vmd 0000:00:0e.0: Bound to PCI domain 10000
[    1.504753] usb 1-2: new full-speed USB device number 2 using xhci_hcd
[    1.534773] nvidia: loading out-of-tree module taints kernel.
[    1.534781] nvidia: module license 'NVIDIA' taints kernel.
[    1.534782] Disabling lock debugging due to kernel taint
[    1.534783] nvidia: module verification failed: signature and/or required key missing - tainting kernel
[    1.534784] nvidia: module license taints kernel.
[    1.594557] nvidia-nvlink: Nvlink Core is being initialized, major device number 239

[    1.595188] nvidia 0000:02:00.0: enabling device (0100 -> 0103)
[    1.595308] nvidia 0000:02:00.0: vgaarb: VGA decodes changed: olddecodes=io+mem,decodes=none:owns=none
[    1.637834] NVRM: loading NVIDIA UNIX x86_64 Kernel Module  535.183.01  Sun May 12 19:39:15 UTC 2024
[    1.660235] usb 1-2: New USB device found, idVendor=046d, idProduct=c52b, bcdDevice=12.11
[    1.660249] usb 1-2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    1.660254] usb 1-2: Product: USB Receiver
[    1.660258] usb 1-2: Manufacturer: Logitech
[    1.759113] input: FTCS1000:01 2808:0102 Mouse as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-0/i2c-FTCS1000:01/0018:2808:0102.0001/input/input8
[    1.759283] input: FTCS1000:01 2808:0102 Touchpad as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-0/i2c-FTCS1000:01/0018:2808:0102.0001/input/input9
[    1.759412] hid-generic 0018:2808:0102.0001: input,hidraw0: I2C HID v1.00 Mouse [FTCS1000:01 2808:0102] on i2c-FTCS1000:01
[    1.762409] nvidia-modeset: Loading NVIDIA Kernel Mode Setting Driver for UNIX platforms  535.183.01  Sun May 12 19:31:08 UTC 2024
[    1.763673] nvme nvme0: pci function 10000:e1:00.0
[    1.763694] pcieport 10000:e0:06.0: can't derive routing for PCI INT A
[    1.763697] nvme 10000:e1:00.0: PCI INT A: not connected
[    1.764173] [drm] [nvidia-drm] [GPU ID 0x00000200] Loading driver
[    1.766038] nvme nvme0: missing or invalid SUBNQN field.
[    1.766179] nvme nvme0: Shutdown timeout set to 8 seconds
[    1.776627] usb 1-6: new high-speed USB device number 3 using xhci_hcd
[    1.784892] nvme nvme0: 18/0/0 default/read/poll queues
[    1.790804]  nvme0n1: p1 p2 p3
[    1.804181] ACPI Warning: \_SB.NPCF._DSM: Argument #4 type mismatch - Found [Buffer], ACPI requires [Package] (20230628/nsarguments-61)
[    1.804248] ACPI Warning: \_SB.PC00.PEG2.PEGP._DSM: Argument #4 type mismatch - Found [Buffer], ACPI requires [Package] (20230628/nsarguments-61)
[    1.825927] input: FTCS1000:01 2808:0102 Mouse as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-0/i2c-FTCS1000:01/0018:2808:0102.0001/input/input11
[    1.826160] input: FTCS1000:01 2808:0102 Touchpad as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-0/i2c-FTCS1000:01/0018:2808:0102.0001/input/input12
[    1.826236] hid-multitouch 0018:2808:0102.0001: input,hidraw0: I2C HID v1.00 Mouse [FTCS1000:01 2808:0102] on i2c-FTCS1000:01
[    1.935417] usb 1-6: New USB device found, idVendor=04f2, idProduct=b7e7, bcdDevice= 0.04
[    1.935429] usb 1-6: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    1.935434] usb 1-6: Product: Chicony USB2.0 Camera
[    1.935437] usb 1-6: Manufacturer: SunplusIT Inc
[    1.935439] usb 1-6: SerialNumber: 01.00.00
[    2.065707] usb 1-7: new full-speed USB device number 4 using xhci_hcd
[    2.196226] usb 1-7: New USB device found, idVendor=048d, idProduct=8910, bcdDevice= 0.01
[    2.196239] usb 1-7: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.196244] usb 1-7: Product: ITE Device(829x)
[    2.196247] usb 1-7: Manufacturer: ITE Tech. Inc.
[    2.311713] usb 1-14: new full-speed USB device number 5 using xhci_hcd
[    2.439823] usb 1-14: New USB device found, idVendor=8087, idProduct=0033, bcdDevice= 0.00
[    2.439827] usb 1-14: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    2.445937] input: Logitech USB Receiver as /devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2:1.0/0003:046D:C52B.0002/input/input14
[    2.498162] hid-generic 0003:046D:C52B.0002: input,hidraw1: USB HID v1.11 Keyboard [Logitech USB Receiver] on usb-0000:00:14.0-2/input0
[    2.500280] input: Logitech USB Receiver Mouse as /devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2:1.1/0003:046D:C52B.0003/input/input15
[    2.500544] input: Logitech USB Receiver Consumer Control as /devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2:1.1/0003:046D:C52B.0003/input/input16
[    2.552200] input: Logitech USB Receiver System Control as /devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2:1.1/0003:046D:C52B.0003/input/input17
[    2.552628] hid-generic 0003:046D:C52B.0003: input,hiddev0,hidraw2: USB HID v1.11 Mouse [Logitech USB Receiver] on usb-0000:00:14.0-2/input1
[    2.554477] hid-generic 0003:046D:C52B.0004: hiddev1,hidraw3: USB HID v1.11 Device [Logitech USB Receiver] on usb-0000:00:14.0-2/input2
[    2.556111] hid-generic 0003:048D:8910.0005: hiddev2,hidraw4: USB HID v1.10 Device [ITE Tech. Inc. ITE Device(829x)] on usb-0000:00:14.0-7/input0
[    2.556147] usbcore: registered new interface driver usbhid
[    2.556150] usbhid: USB HID core driver
[    2.586274] nvidia-modeset: WARNING: GPU:0: Unable to read EDID for display device DP-2
[    2.595704] nvidia-modeset: WARNING: GPU:0: Unable to read EDID for display device DP-2
[    2.597338] [drm] Initialized nvidia-drm 0.0.0 20160202 for 0000:02:00.0 on minor 1
[    2.648013] logitech-djreceiver 0003:046D:C52B.0004: hiddev0,hidraw1: USB HID v1.11 Device [Logitech USB Receiver] on usb-0000:00:14.0-2/input2
[    2.755057] input: Logitech Wireless Device PID:4082 Keyboard as /devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2:1.2/0003:046D:C52B.0004/0003:046D:4082.0006/input/input19
[    2.755833] input: Logitech Wireless Device PID:4082 Mouse as /devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2:1.2/0003:046D:C52B.0004/0003:046D:4082.0006/input/input20
[    2.756868] hid-generic 0003:046D:4082.0006: input,hidraw2: USB HID v1.11 Keyboard [Logitech Wireless Device PID:4082] on usb-0000:00:14.0-2/input2:1
[    2.757764] input: Logitech Wireless Device PID:408a Keyboard as /devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2:1.2/0003:046D:C52B.0004/0003:046D:408A.0007/input/input24
[    2.758047] input: Logitech Wireless Device PID:408a Mouse as /devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2:1.2/0003:046D:C52B.0004/0003:046D:408A.0007/input/input25
[    2.758397] hid-generic 0003:046D:408A.0007: input,hidraw3: USB HID v1.11 Keyboard [Logitech Wireless Device PID:408a] on usb-0000:00:14.0-2/input2:2
[    2.809821] input: Logitech MX Master 3 as /devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2:1.2/0003:046D:C52B.0004/0003:046D:4082.0006/input/input29
[    2.810274] logitech-hidpp-device 0003:046D:4082.0006: input,hidraw2: USB HID v1.11 Keyboard [Logitech MX Master 3] on usb-0000:00:14.0-2/input2:1
[    2.865931] input: Logitech MX Keys as /devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2:1.2/0003:046D:C52B.0004/0003:046D:408A.0007/input/input30
[    2.866266] logitech-hidpp-device 0003:046D:408A.0007: input,hidraw3: USB HID v1.11 Keyboard [Logitech MX Keys] on usb-0000:00:14.0-2/input2:2
[    2.899100] input: ImPS/2 Generic Wheel Mouse as /devices/platform/i8042/serio1/input/input7
[   20.166709] thunderbolt 0000:06:00.0: 0: suspending switch
[   20.166725] thunderbolt 0000:06:00.0: 0: enabling wakeup: 0x3f
[   20.167899] thunderbolt 0000:06:00.0: stopping RX ring 0
[   20.167922] thunderbolt 0000:06:00.0: disabling interrupt at register 0x38200 bit 12 (0x1001 -> 0x1)
[   20.167956] thunderbolt 0000:06:00.0: stopping TX ring 0
[   20.167972] thunderbolt 0000:06:00.0: disabling interrupt at register 0x38200 bit 0 (0x1 -> 0x0)
[   20.167995] thunderbolt 0000:06:00.0: control channel stopped
[  130.160621] raid6: avx2x4   gen() 33395 MB/s
[  130.177621] raid6: avx2x2   gen() 36541 MB/s
[  130.194621] raid6: avx2x1   gen() 33840 MB/s
[  130.194621] raid6: using algorithm avx2x2 gen() 36541 MB/s
[  130.211621] raid6: .... xor() 28781 MB/s, rmw enabled
[  130.211622] raid6: using avx2x2 recovery algorithm
[  130.213900] xor: automatically using best checksumming function   avx       
[  130.280876] Btrfs loaded, zoned=yes, fsverity=yes
[  130.315767] BTRFS: device label kfocus_2404 devid 1 transid 262 /dev/mapper/luks-9992e62a-e20e-4d65-8cd4-d1988f6f3ab3 scanned by mount (673)
[  130.316523] BTRFS info (device dm-0): first mount of filesystem d4f6fb42-b08b-4b54-a060-a4e3fc1f51fd
[  130.316537] BTRFS info (device dm-0): using crc32c (crc32c-intel) checksum algorithm
[  130.316541] BTRFS info (device dm-0): using free-space-tree
[  130.462629] systemd[1]: Inserted module 'autofs4'
[  130.709082] systemd[1]: systemd 255.4-1ubuntu8.4 running in system mode (+PAM +AUDIT +SELINUX +APPARMOR +IMA +SMACK +SECCOMP +GCRYPT -GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP +LIBFDISK +PCRE2 -PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD -BPF_FRAMEWORK -XKBCOMMON +UTMP +SYSVINIT default-hierarchy=unified)
[  130.709091] systemd[1]: Detected architecture x86-64.
[  130.709954] systemd[1]: Hostname set to <oem>.
[  130.784313] systemd[1]: Configuration file /run/systemd/system/netplan-ovs-cleanup.service is marked world-inaccessible. This has no effect as configuration data is accessible via APIs without restrictions. Proceeding anyway.
[  130.816824] systemd[1]: Queued start job for default target graphical.target.
[  130.832571] systemd[1]: Created slice system-modprobe.slice - Slice /system/modprobe.
[  130.832785] systemd[1]: Created slice system-systemd\x2dcryptsetup.slice - Encrypted Volume Units Service Slice.
[  130.832947] systemd[1]: Created slice system-systemd\x2dfsck.slice - Slice /system/systemd-fsck.
[  130.833067] systemd[1]: Created slice user.slice - User and Session Slice.
[  130.833100] systemd[1]: Started systemd-ask-password-wall.path - Forward Password Requests to Wall Directory Watch.
[  130.833208] systemd[1]: Set up automount proc-sys-fs-binfmt_misc.automount - Arbitrary Executable File Formats File System Automount Point.
[  130.833218] systemd[1]: Expecting device dev-disk-by\x2duuid-46d5c175\x2dd275\x2d43d0\x2db7a3\x2d4d93351da834.device - /dev/disk/by-uuid/46d5c175-d275-43d0-b7a3-4d93351da834...
[  130.833223] systemd[1]: Expecting device dev-disk-by\x2duuid-9992e62a\x2de20e\x2d4d65\x2d8cd4\x2dd1988f6f3ab3.device - /dev/disk/by-uuid/9992e62a-e20e-4d65-8cd4-d1988f6f3ab3...
[  130.833227] systemd[1]: Expecting device dev-disk-by\x2duuid-CCB5\x2dDF12.device - /dev/disk/by-uuid/CCB5-DF12...
[  130.833232] systemd[1]: Expecting device dev-disk-by\x2duuid-d4f6fb42\x2db08b\x2d4b54\x2da060\x2da4e3fc1f51fd.device - /dev/disk/by-uuid/d4f6fb42-b08b-4b54-a060-a4e3fc1f51fd...
[  130.833235] systemd[1]: Expecting device dev-mapper-luks\x2d9992e62a\x2de20e\x2d4d65\x2d8cd4\x2dd1988f6f3ab3.device - /dev/mapper/luks-9992e62a-e20e-4d65-8cd4-d1988f6f3ab3...
[  130.833249] systemd[1]: Reached target integritysetup.target - Local Integrity Protected Volumes.
[  130.833261] systemd[1]: Reached target nss-user-lookup.target - User and Group Name Lookups.
[  130.833267] systemd[1]: Reached target remote-fs.target - Remote File Systems.
[  130.833274] systemd[1]: Reached target slices.target - Slice Units.
[  130.833282] systemd[1]: Reached target snapd.mounts-pre.target - Mounting snaps.
[  130.833298] systemd[1]: Reached target veritysetup.target - Local Verity Protected Volumes.
[  130.833336] systemd[1]: Listening on dm-event.socket - Device-mapper event daemon FIFOs.
[  130.833668] systemd[1]: Listening on lvm2-lvmpolld.socket - LVM2 poll daemon socket.
[  130.833984] systemd[1]: Listening on syslog.socket - Syslog Socket.
[  130.834029] systemd[1]: Listening on systemd-fsckd.socket - fsck to fsckd communication Socket.
[  130.834051] systemd[1]: Listening on systemd-initctl.socket - initctl Compatibility Named Pipe.
[  130.834094] systemd[1]: Listening on systemd-journald-dev-log.socket - Journal Socket (/dev/log).
[  130.834138] systemd[1]: Listening on systemd-journald.socket - Journal Socket.
[  130.834164] systemd[1]: systemd-pcrextend.socket - TPM2 PCR Extension (Varlink) was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
[  130.835386] systemd[1]: Listening on systemd-udevd-control.socket - udev Control Socket.
[  130.835455] systemd[1]: Listening on systemd-udevd-kernel.socket - udev Kernel Socket.
[  130.837682] systemd[1]: Mounting dev-hugepages.mount - Huge Pages File System...
[  130.838486] systemd[1]: Mounting dev-mqueue.mount - POSIX Message Queue File System...
[  130.839139] systemd[1]: Mounting sys-kernel-debug.mount - Kernel Debug File System...
[  130.839790] systemd[1]: Mounting sys-kernel-tracing.mount - Kernel Trace File System...
[  130.841995] systemd[1]: Starting systemd-journald.service - Journal Service...
[  130.842075] systemd[1]: Finished blk-availability.service - Availability of block devices.
[  130.843677] systemd[1]: Starting keyboard-setup.service - Set the console keyboard layout...
[  130.844599] systemd[1]: Starting kmod-static-nodes.service - Create List of Static Device Nodes...
[  130.845368] systemd[1]: Starting lvm2-monitor.service - Monitoring of LVM2 mirrors, snapshots etc. using dmeventd or progress polling...
[  130.846192] systemd[1]: Starting modprobe@configfs.service - Load Kernel Module configfs...
[  130.847034] systemd[1]: Starting modprobe@dm_mod.service - Load Kernel Module dm_mod...
[  130.847734] systemd[1]: Starting modprobe@drm.service - Load Kernel Module drm...
[  130.848382] systemd[1]: Starting modprobe@efi_pstore.service - Load Kernel Module efi_pstore...
[  130.849313] systemd[1]: Starting modprobe@fuse.service - Load Kernel Module fuse...
[  130.850055] systemd[1]: Starting modprobe@loop.service - Load Kernel Module loop...
[  130.851274] systemd[1]: Starting modprobe@nvme_fabrics.service - Load Kernel Module nvme_fabrics...
[  130.852313] systemd-journald[745]: Collecting audit messages is disabled.
[  130.852459] systemd[1]: Starting systemd-modules-load.service - Load Kernel Modules...
[  130.852476] systemd[1]: systemd-pcrmachine.service - TPM2 PCR Machine ID Measurement was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
[  130.853064] systemd[1]: Starting systemd-remount-fs.service - Remount Root and Kernel File Systems...
[  130.853090] systemd[1]: systemd-tpm2-setup-early.service - TPM2 SRK Setup (Early) was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
[  130.853648] systemd[1]: Starting systemd-udev-trigger.service - Coldplug All udev Devices...
[  130.854243] systemd[1]: Mounted dev-hugepages.mount - Huge Pages File System.
[  130.854299] systemd[1]: Mounted dev-mqueue.mount - POSIX Message Queue File System.
[  130.854332] systemd[1]: Mounted sys-kernel-debug.mount - Kernel Debug File System.
[  130.854362] systemd[1]: Mounted sys-kernel-tracing.mount - Kernel Trace File System.
[  130.854424] pstore: Using crash dump compression: deflate
[  130.854453] systemd[1]: Finished kmod-static-nodes.service - Create List of Static Device Nodes.
[  130.854554] systemd[1]: modprobe@configfs.service: Deactivated successfully.
[  130.854615] systemd[1]: Finished modprobe@configfs.service - Load Kernel Module configfs.
[  130.854717] systemd[1]: modprobe@dm_mod.service: Deactivated successfully.
[  130.854774] systemd[1]: Finished modprobe@dm_mod.service - Load Kernel Module dm_mod.
[  130.854865] systemd[1]: modprobe@drm.service: Deactivated successfully.
[  130.854917] systemd[1]: Finished modprobe@drm.service - Load Kernel Module drm.
[  130.855004] systemd[1]: modprobe@fuse.service: Deactivated successfully.
[  130.855056] systemd[1]: Finished modprobe@fuse.service - Load Kernel Module fuse.
[  130.855547] systemd[1]: Mounting sys-fs-fuse-connections.mount - FUSE Control File System...
[  130.855924] systemd[1]: Mounting sys-kernel-config.mount - Kernel Configuration File System...
[  130.856386] systemd[1]: Starting systemd-tmpfiles-setup-dev-early.service - Create Static Device Nodes in /dev gracefully...
[  130.856507] systemd[1]: modprobe@loop.service: Deactivated successfully.
[  130.856574] systemd[1]: Finished modprobe@loop.service - Load Kernel Module loop.
[  130.856643] systemd[1]: systemd-repart.service - Repartition Root Disk was skipped because no trigger condition checks were met.
[  130.858792] systemd[1]: Mounted sys-fs-fuse-connections.mount - FUSE Control File System.
[  130.859697] systemd[1]: Mounted sys-kernel-config.mount - Kernel Configuration File System.
[  130.860889] BTRFS info (device dm-0: state M): turning on sync discard
[  130.860892] BTRFS info (device dm-0: state M): enabling auto defrag
[  130.860893] BTRFS info (device dm-0: state M): use lzo compression, level 0
[  130.861578] systemd[1]: Finished systemd-remount-fs.service - Remount Root and Kernel File Systems.
[  130.862215] systemd[1]: systemd-hwdb-update.service - Rebuild Hardware Database was skipped because of an unmet condition check (ConditionNeedsUpdate=/etc).
[  130.862783] systemd[1]: Starting systemd-random-seed.service - Load/Save OS Random Seed...
[  130.862793] systemd[1]: systemd-tpm2-setup.service - TPM2 SRK Setup was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
[  130.862909] systemd[1]: modprobe@nvme_fabrics.service: Deactivated successfully.
[  130.862979] systemd[1]: Finished modprobe@nvme_fabrics.service - Load Kernel Module nvme_fabrics.
[  130.865660] systemd[1]: Finished systemd-tmpfiles-setup-dev-early.service - Create Static Device Nodes in /dev gracefully.
[  130.865745] systemd[1]: systemd-sysusers.service - Create System Users was skipped because no trigger condition checks were met.
[  130.866148] lp: driver loaded but no devices found
[  130.866207] systemd[1]: Starting systemd-tmpfiles-setup-dev.service - Create Static Device Nodes in /dev...
[  130.875929] systemd[1]: Finished keyboard-setup.service - Set the console keyboard layout.
[  130.886127] ppdev: user-space parallel port driver
[  130.889187] systemd[1]: Started systemd-journald.service - Journal Service.
[  130.894029] systemd-journald[745]: Received client request to flush runtime journal.
[  130.902807] systemd-journald[745]: /var/log/journal/727848098c2c4158adab42128cd9626b/system.journal: Journal file uses a different sequence number ID, rotating.
[  130.902811] systemd-journald[745]: Rotating system journal.
[  130.911679] tuxedo_keyboard: module init
[  130.919912] pstore: Registered efi_pstore as persistent store backend
[  130.944649] loop0: detected capacity change from 0 to 21952
[  130.944745] loop1: detected capacity change from 0 to 152040
[  130.944840] loop2: detected capacity change from 0 to 8
[  130.946508] loop3: detected capacity change from 0 to 1034424
[  130.947545] loop4: detected capacity change from 0 to 79520
[  130.947805] loop5: detected capacity change from 0 to 187776
[  130.947892] loop6: detected capacity change from 0 to 79328
[  130.956720] BTRFS info: devid 1 device path /dev/mapper/luks-9992e62a-e20e-4d65-8cd4-d1988f6f3ab3 changed to /dev/dm-0 scanned by (udev-worker) (844)
[  130.957106] BTRFS info: devid 1 device path /dev/dm-0 changed to /dev/mapper/luks-9992e62a-e20e-4d65-8cd4-d1988f6f3ab3 scanned by (udev-worker) (844)
[  130.971763] mei_me 0000:00:16.0: enabling device (0000 -> 0002)
[  130.975012] input: Intel HID events as /devices/platform/INTC1051:00/input/input31
[  130.986346] nvidia_uvm: module uses symbols nvUvmInterfaceDisableAccessCntr from proprietary module nvidia, inheriting taint.
[  131.018193] nvidia-uvm: Loaded the UVM driver, major device number 511.
[  131.020783] Consider using thermal netlink events interface
[  131.046319] mc: Linux media interface: v0.10
[  131.046866] i801_smbus 0000:00:1f.4: SPD Write Disable is set
[  131.046921] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
[  131.046944] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[  131.046972] intel_pmc_core INT33A1:00:  initialized
[  131.047064] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[  131.047130] tuxedo_keyboard: set_mode on CUSTOM
[  131.047166] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c7248db18c600'
[  131.049128] ite_829x 0003:048D:8910.0005: hiddev1,hidraw4: USB HID v1.10 Device [ITE Tech. Inc. ITE Device(829x)] on usb-0000:00:14.0-7/input0
[  131.049261] RAPL PMU: API unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
[  131.049264] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[  131.049265] RAPL PMU: hw unit of domain package 2^-14 Joules
[  131.049266] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
[  131.049266] RAPL PMU: hw unit of domain psys 2^-14 Joules
[  131.085850] tuxedo_keyboard: Set brightness on 75
[  131.092374] tuxedo_keyboard: Set keyboard enabled to: 1
[  131.097774] input: TUXEDO Keyboard as /devices/platform/tuxedo_keyboard/input/input32
[  131.097956] clevo_acpi: interface initialized
[  131.098024] clevo_wmi: interface initialized
[  131.098097] i2c i2c-8: 2/2 memory slots populated (from DMI)
[  131.098101] i2c i2c-8: Memory type 0x22 not supported yet, not instantiating SPD
[  131.104137] intel_rapl_msr: PL4 support detected.
[  131.104183] intel_rapl_common: Found RAPL domain package
[  131.104185] intel_rapl_common: Found RAPL domain core
[  131.104187] intel_rapl_common: Found RAPL domain uncore
[  131.104188] intel_rapl_common: Found RAPL domain psys
[  131.111950] Intel(R) Wireless WiFi driver for Linux
[  131.113965] videodev: Linux video capture interface: v2.00
[  131.114590] iwlwifi 0000:00:14.3: Detected crf-id 0x400410, cnv-id 0x80401 wfpm id 0x80000020
[  131.114661] iwlwifi 0000:00:14.3: PCI dev 7a70/0094, rev=0x430, rfid=0x2010d000
[  131.116174] Creating 1 MTD partitions on "0000:00:1f.5":
[  131.116197] 0x000000000000-0x000002000000 : "BIOS"
[  131.121465] iwlwifi 0000:00:14.3: TLV_FW_FSEQ_VERSION: FSEQ Version: 0.0.2.41
[  131.121675] iwlwifi 0000:00:14.3: loaded firmware version 86.fb5c9aeb.0 so-a0-gf-a0-86.ucode op_mode iwlmvm
[  131.151024] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_1 due to name collision
[  131.151035] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_2 due to name collision
[  131.151045] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_3 due to name collision
[  131.151054] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_4 due to name collision
[  131.151064] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_5 due to name collision
[  131.151075] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_6 due to name collision
[  131.151086] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_7 due to name collision
[  131.151100] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_8 due to name collision
[  131.151113] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_9 due to name collision
[  131.151127] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_10 due to name collision
[  131.151142] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_11 due to name collision
[  131.151158] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_12 due to name collision
[  131.151176] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_13 due to name collision
[  131.151193] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_14 due to name collision
[  131.151212] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_15 due to name collision
[  131.151231] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_16 due to name collision
[  131.151253] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_17 due to name collision
[  131.151275] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_18 due to name collision
[  131.151298] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_19 due to name collision
[  131.151322] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_20 due to name collision
[  131.151348] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_21 due to name collision
[  131.151375] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_22 due to name collision
[  131.151405] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_23 due to name collision
[  131.151441] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_24 due to name collision
[  131.151472] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_25 due to name collision
[  131.151503] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_26 due to name collision
[  131.151537] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_27 due to name collision
[  131.151573] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_28 due to name collision
[  131.151608] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_29 due to name collision
[  131.151649] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_30 due to name collision
[  131.151688] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_31 due to name collision
[  131.151728] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_32 due to name collision
[  131.151770] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_33 due to name collision
[  131.151813] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_34 due to name collision
[  131.151858] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_35 due to name collision
[  131.151904] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_36 due to name collision
[  131.151951] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_37 due to name collision
[  131.152001] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_38 due to name collision
[  131.152053] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_39 due to name collision
[  131.152105] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_40 due to name collision
[  131.152159] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_41 due to name collision
[  131.152215] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_42 due to name collision
[  131.152274] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_43 due to name collision
[  131.152333] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_44 due to name collision
[  131.152395] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_45 due to name collision
[  131.152458] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_46 due to name collision
[  131.152523] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_47 due to name collision
[  131.152591] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_48 due to name collision
[  131.152663] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_49 due to name collision
[  131.152734] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_50 due to name collision
[  131.152807] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_51 due to name collision
[  131.152883] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_52 due to name collision
[  131.152960] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_53 due to name collision
[  131.153040] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_54 due to name collision
[  131.153123] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_55 due to name collision
[  131.153212] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_56 due to name collision
[  131.153298] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_57 due to name collision
[  131.153387] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_58 due to name collision
[  131.153478] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_59 due to name collision
[  131.153572] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_60 due to name collision
[  131.153668] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_61 due to name collision
[  131.153765] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_62 due to name collision
[  131.153864] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_63 due to name collision
[  131.153966] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_64 due to name collision
[  131.154070] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_65 due to name collision
[  131.154176] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_66 due to name collision
[  131.154286] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_67 due to name collision
[  131.154396] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_68 due to name collision
[  131.154510] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_69 due to name collision
[  131.154629] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_70 due to name collision
[  131.154749] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_71 due to name collision
[  131.154870] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_72 due to name collision
[  131.154995] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_73 due to name collision
[  131.155121] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_74 due to name collision
[  131.155250] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_75 due to name collision
[  131.155382] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_76 due to name collision
[  131.155517] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_77 due to name collision
[  131.155657] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_78 due to name collision
[  131.155797] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_79 due to name collision
[  131.155940] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_80 due to name collision
[  131.156086] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_81 due to name collision
[  131.156234] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_82 due to name collision
[  131.156386] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_83 due to name collision
[  131.156541] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_84 due to name collision
[  131.156702] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_85 due to name collision
[  131.156862] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_86 due to name collision
[  131.157027] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_87 due to name collision
[  131.157196] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_88 due to name collision
[  131.157366] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_89 due to name collision
[  131.157539] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_90 due to name collision
[  131.157717] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_91 due to name collision
[  131.157896] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_92 due to name collision
[  131.158082] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_93 due to name collision
[  131.158271] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_94 due to name collision
[  131.158469] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_95 due to name collision
[  131.158669] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_96 due to name collision
[  131.158876] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_97 due to name collision
[  131.159165] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_98 due to name collision
[  131.159474] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_99 due to name collision
[  131.159481] Bluetooth: Core ver 2.22
[  131.159511] NET: Registered PF_BLUETOOTH protocol family
[  131.159513] Bluetooth: HCI device and connection manager initialized
[  131.159517] Bluetooth: HCI socket layer initialized
[  131.159520] Bluetooth: L2CAP socket layer initialized
[  131.159525] Bluetooth: SCO socket layer initialized
[  131.159786] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_100 due to name collision
[  131.160066] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_101 due to name collision
[  131.160354] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_102 due to name collision
[  131.160642] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_103 due to name collision
[  131.160958] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_104 due to name collision
[  131.161294] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_105 due to name collision
[  131.161600] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_106 due to name collision
[  131.161861] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_107 due to name collision
[  131.162149] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_108 due to name collision
[  131.162468] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_109 due to name collision
[  131.162814] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_110 due to name collision
[  131.163170] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_111 due to name collision
[  131.163493] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_112 due to name collision
[  131.163860] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_113 due to name collision
[  131.164194] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_114 due to name collision
[  131.164531] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_115 due to name collision
[  131.164923] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_116 due to name collision
[  131.165331] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_117 due to name collision
[  131.165743] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_118 due to name collision
[  131.166161] ite_829x 0003:048D:8910.0005: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_119 due to name collision
[  131.168685] intel_rapl_common: Found RAPL domain package
[  131.183624] usb 1-6: Found UVC 1.50 device Chicony USB2.0 Camera (04f2:b7e7)
[  131.185120] usbcore: registered new interface driver btusb
[  131.186538] Bluetooth: hci0: Device revision is 0
[  131.186542] Bluetooth: hci0: Secure boot is enabled
[  131.186544] Bluetooth: hci0: OTP lock is enabled
[  131.186545] Bluetooth: hci0: API lock is enabled
[  131.186545] Bluetooth: hci0: Debug lock is disabled
[  131.186547] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
[  131.186548] Bluetooth: hci0: Bootloader timestamp 2019.40 buildtype 1 build 38
[  131.186699] ACPI Warning: \_SB.PC00.XHCI.RHUB.HS14._DSM: Argument #4 type mismatch - Found [Integer], ACPI requires [Package] (20230628/nsarguments-61)
[  131.186800] Bluetooth: hci0: DSM reset method type: 0x00
[  131.190884] Bluetooth: hci0: Found device firmware: intel/ibt-1040-0041.sfi
[  131.190897] Bluetooth: hci0: Boot Address: 0x100800
[  131.190898] Bluetooth: hci0: Firmware Version: 60-48.23
[  131.220140] usb 1-6: Found UVC 1.50 device Chicony USB2.0 Camera (04f2:b7e7)
[  131.230860] usbcore: registered new interface driver uvcvideo
[  131.475330] i915 0000:00:02.0: [drm] VT-d active for gfx access
[  131.491773] snd_hda_intel 0000:00:1f.3: enabling device (0000 -> 0002)
[  131.496428] intel_tcc_cooling: Programmable TCC Offset detected
[  131.497938] i915 0000:00:02.0: vgaarb: deactivate vga console
[  131.498000] i915 0000:00:02.0: [drm] Using Transparent Hugepages
[  131.498762] i915 0000:00:02.0: vgaarb: VGA decodes changed: olddecodes=io+mem,decodes=none:owns=io+mem
[  131.500320] snd_hda_intel 0000:02:00.1: enabling device (0000 -> 0002)
[  131.500450] snd_hda_intel 0000:02:00.1: Disabling MSI
[  131.500459] snd_hda_intel 0000:02:00.1: Handle vga_switcheroo audio client
[  131.500725] iwlwifi 0000:00:14.3: Detected Intel(R) Wi-Fi 6E AX211 160MHz, REV=0x430
[  131.500861] thermal thermal_zone9: failed to read out thermal zone (-61)
[  131.501257] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
[  131.503257] i915 0000:00:02.0: [drm] Finished loading DMC firmware i915/adls_dmc_ver2_01.bin (v2.1)
[  131.513109] iwlwifi 0000:00:14.3: WRT: Invalid buffer destination
[  131.521035] i915 0000:00:02.0: [drm] GT0: GuC firmware i915/tgl_guc_70.bin version 70.20.0
[  131.521038] i915 0000:00:02.0: [drm] GT0: HuC firmware i915/tgl_huc.bin version 7.9.3
[  131.521444] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC1220: line_outs=1 (0x1b/0x0/0x0/0x0/0x0) type:speaker
[  131.521450] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[  131.521453] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=1 (0x14/0x0/0x0/0x0/0x0)
[  131.521455] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=0x0
[  131.521456] snd_hda_codec_realtek hdaudioC0D0:    dig-out=0x1e/0x0
[  131.521457] snd_hda_codec_realtek hdaudioC0D0:    inputs:
[  131.521459] snd_hda_codec_realtek hdaudioC0D0:      Mic=0x18
[  131.521461] snd_hda_codec_realtek hdaudioC0D0:      Internal Mic=0x12
[  131.524256] input: HDA NVidia HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:01.1/0000:02:00.1/sound/card1/input33
[  131.524351] input: HDA NVidia HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:01.1/0000:02:00.1/sound/card1/input34
[  131.524392] input: HDA NVidia HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:01.1/0000:02:00.1/sound/card1/input35
[  131.524430] input: HDA NVidia HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:01.1/0000:02:00.1/sound/card1/input36
[  131.529547] i915 0000:00:02.0: [drm] GT0: HuC: authenticated for all workloads
[  131.530260] i915 0000:00:02.0: [drm] GT0: GUC: submission enabled
[  131.530263] i915 0000:00:02.0: [drm] GT0: GUC: SLPC enabled
[  131.530844] i915 0000:00:02.0: [drm] GT0: GUC: RC enabled
[  131.531809] mei_pxp 0000:00:16.0-fbf6fcf1-96cf-4e2e-a6a6-1bab8cbe36b1: bound 0000:00:02.0 (ops i915_pxp_tee_component_ops [i915])
[  131.532017] i915 0000:00:02.0: [drm] Protected Xe Path (PXP) protected content support initialized
[  131.532216] input: HDA Intel PCH Mic as /devices/pci0000:00/0000:00:1f.3/sound/card0/input37
[  131.532295] input: HDA Intel PCH Headphone as /devices/pci0000:00/0000:00:1f.3/sound/card0/input38
[  131.674524] iwlwifi 0000:00:14.3: WFPM_UMAC_PD_NOTIFICATION: 0x20
[  131.674539] iwlwifi 0000:00:14.3: WFPM_LMAC2_PD_NOTIFICATION: 0x1f
[  131.674548] iwlwifi 0000:00:14.3: WFPM_AUTH_KEY_0: 0x90
[  131.674558] iwlwifi 0000:00:14.3: CNVI_SCU_SEQ_DATA_DW9: 0x0
[  131.675452] iwlwifi 0000:00:14.3: RFIm is deactivated, reason = 5
[  131.675969] iwlwifi 0000:00:14.3: loaded PNVM version e28bb9d7
[  131.693901] iwlwifi 0000:00:14.3: Detected RF GF, rfid=0x2010d000
[  131.762890] iwlwifi 0000:00:14.3: base HW address: 98:5f:41:dd:bb:cf
[  131.782406] iwlwifi 0000:00:14.3 wlp0s20f3: renamed from wlan0
[  131.873853] BTRFS: device label kfocus_boot devid 1 transid 39 /dev/nvme0n1p2 scanned by mount (1294)
[  131.874404] BTRFS info (device nvme0n1p2): first mount of filesystem 46d5c175-d275-43d0-b7a3-4d93351da834
[  131.874416] BTRFS info (device nvme0n1p2): using crc32c (crc32c-intel) checksum algorithm
[  131.874422] BTRFS info (device nvme0n1p2): using free-space-tree
[  131.895437] Adding 524284k swap on /swap/swapfile.  Priority:-2 extents:2 across:6891796k 
[  131.923601] audit: type=1400 audit(1728618393.467:2): apparmor="STATUS" operation="profile_load" profile="unconfined" name="QtWebEngineProcess" pid=1342 comm="apparmor_parser"
[  131.923607] audit: type=1400 audit(1728618393.467:3): apparmor="STATUS" operation="profile_load" profile="unconfined" name="balena-etcher" pid=1344 comm="apparmor_parser"
[  131.923685] audit: type=1400 audit(1728618393.468:4): apparmor="STATUS" operation="profile_load" profile="unconfined" name="busybox" pid=1347 comm="apparmor_parser"
[  131.923696] audit: type=1400 audit(1728618393.468:5): apparmor="STATUS" operation="profile_load" profile="unconfined" name="buildah" pid=1346 comm="apparmor_parser"
[  131.923787] audit: type=1400 audit(1728618393.468:6): apparmor="STATUS" operation="profile_load" profile="unconfined" name=4D6F6E676F444220436F6D70617373 pid=1341 comm="apparmor_parser"
[  131.923888] audit: type=1400 audit(1728618393.468:7): apparmor="STATUS" operation="profile_load" profile="unconfined" name="cam" pid=1348 comm="apparmor_parser"
[  131.923892] audit: type=1400 audit(1728618393.468:8): apparmor="STATUS" operation="profile_load" profile="unconfined" name="ch-checkns" pid=1349 comm="apparmor_parser"
[  131.923894] audit: type=1400 audit(1728618393.468:9): apparmor="STATUS" operation="profile_load" profile="unconfined" name="brave" pid=1345 comm="apparmor_parser"
[  131.924174] audit: type=1400 audit(1728618393.468:10): apparmor="STATUS" operation="profile_load" profile="unconfined" name="github-desktop" pid=1363 comm="apparmor_parser"
[  131.924197] audit: type=1400 audit(1728618393.468:11): apparmor="STATUS" operation="profile_load" profile="unconfined" name="ipa_verify" pid=1365 comm="apparmor_parser"
[  132.605022] Bluetooth: hci0: Waiting for firmware download to complete
[  132.605036] Bluetooth: hci0: Firmware loaded in 1381004 usecs
[  132.605193] Bluetooth: hci0: Waiting for device to boot
[  132.620927] Bluetooth: hci0: Device booted in 15481 usecs
[  132.620944] Bluetooth: hci0: Malformed MSFT vendor event: 0x02
[  132.621190] Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-1040-0041.ddc
[  132.623690] Bluetooth: hci0: Applying Intel DDC parameters completed
[  132.626717] Bluetooth: hci0: Firmware timestamp 2023.48 buildtype 1 build 75324
[  132.626723] Bluetooth: hci0: Firmware SHA1: 0x23bac558
[  133.205885] i915 0000:00:02.0: [drm] Skipping intel_backlight registration
[  133.206352] [drm] Initialized i915 1.6.0 20230929 for 0000:00:02.0 on minor 2
[  133.206857] ACPI: video: [Firmware Bug]: ACPI(PEGP) defines _DOD but not _DOS
[  133.206905] ACPI: video: Video Device [PEGP] (multi-head: yes  rom: no  post: no)
[  133.206973] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:05/LNXVIDEO:00/input/input39
[  133.208806] ACPI: video: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[  133.209237] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:01/input/input40
[  133.209687] i915 display info: display version: 12
[  133.209690] i915 display info: cursor_needs_physical: no
[  133.209692] i915 display info: has_cdclk_crawl: no
[  133.209694] i915 display info: has_cdclk_squash: no
[  133.209696] i915 display info: has_ddi: yes
[  133.209697] i915 display info: has_dp_mst: yes
[  133.209699] i915 display info: has_dsb: yes
[  133.209700] i915 display info: has_fpga_dbg: yes
[  133.209702] i915 display info: has_gmch: no
[  133.209703] i915 display info: has_hotplug: yes
[  133.209704] i915 display info: has_hti: yes
[  133.209706] i915 display info: has_ipc: yes
[  133.209707] i915 display info: has_overlay: no
[  133.209709] i915 display info: has_psr: yes
[  133.209710] i915 display info: has_psr_hw_tracking: no
[  133.209712] i915 display info: overlay_needs_physical: no
[  133.209714] i915 display info: supports_tv: no
[  133.209715] i915 display info: has_hdcp: yes
[  133.209716] i915 display info: has_dmc: yes
[  133.209718] i915 display info: has_dsc: yes
[  133.212720] fbcon: i915drmfb (fb0) is primary device
[  133.212725] fbcon: Deferring console take-over
[  133.212729] i915 0000:00:02.0: [drm] fb0: i915drmfb frame buffer device
[  133.496550] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[  133.496553] Bluetooth: BNEP filters: protocol multicast
[  133.496558] Bluetooth: BNEP socket layer initialized
[  133.497897] Bluetooth: MGMT ver 1.22
[  133.500167] NET: Registered PF_ALG protocol family
[  133.559382] loop7: detected capacity change from 0 to 8
[  133.561173] NET: Registered PF_QIPCRTR protocol family
[  134.221366] iwlwifi 0000:00:14.3: WRT: Invalid buffer destination
[  134.378152] iwlwifi 0000:00:14.3: WFPM_UMAC_PD_NOTIFICATION: 0x20
[  134.378190] iwlwifi 0000:00:14.3: WFPM_LMAC2_PD_NOTIFICATION: 0x1f
[  134.378222] iwlwifi 0000:00:14.3: WFPM_AUTH_KEY_0: 0x90
[  134.378234] iwlwifi 0000:00:14.3: CNVI_SCU_SEQ_DATA_DW9: 0x0
[  134.378860] iwlwifi 0000:00:14.3: RFIm is deactivated, reason = 5
[  134.471691] iwlwifi 0000:00:14.3: Registered PHC clock: iwlwifi-PTP, with index: 1
[  137.118726] igc 0000:03:00.0 enp3s0: NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
[  140.026565] systemd-journald[745]: /var/log/journal/727848098c2c4158adab42128cd9626b/user-60999.journal: Journal file uses a different sequence number ID, rotating.
[  140.509790] Bluetooth: RFCOMM TTY layer initialized
[  140.509796] Bluetooth: RFCOMM socket layer initialized
[  140.509799] Bluetooth: RFCOMM ver 1.11
[  141.054758] warning: `kded5' uses wireless extensions which will stop working for Wi-Fi 7 hardware; use nl80211
[  141.974222] xhci_hcd 0000:2d:00.0: xHC error in resume, USBSTS 0x401, Reinit
[  141.974226] usb usb3: root hub lost power or was reset
[  141.974228] usb usb4: root hub lost power or was reset
[  141.974338] thunderbolt 0000:06:00.0: control channel starting...
[  141.974342] thunderbolt 0000:06:00.0: starting TX ring 0
[  141.974348] thunderbolt 0000:06:00.0: enabling interrupt at register 0x38200 bit 0 (0x0 -> 0x1)
[  141.974351] thunderbolt 0000:06:00.0: starting RX ring 0
[  141.974356] thunderbolt 0000:06:00.0: enabling interrupt at register 0x38200 bit 12 (0x1 -> 0x1001)
[  141.974360] thunderbolt 0000:06:00.0: 0: resuming switch
[  141.974362] thunderbolt 0000:06:00.0: restoring Switch at 0x0 (depth: 0, up port: 15)
[  141.974469] thunderbolt 0000:06:00.0: 0: disabling wakeup
[  141.977493] thunderbolt 0000:06:00.0: acking hot plug event on 0:13
[  141.977622] thunderbolt 0000:06:00.0: acking hot plug event on 0:14
[  141.977747] thunderbolt 0000:06:00.0: acking hot plug event on 0:16
[  141.983254] thunderbolt 0000:06:00.0: 0: TMU: supports uni-directional mode
[  141.983258] thunderbolt 0000:06:00.0: 0: TMU: supports enhanced uni-directional mode
[  141.983382] thunderbolt 0000:06:00.0: 0: TMU: current mode: off
[  141.983386] thunderbolt 0000:06:00.0: 0: TMU: mode change off -> bi-directional, HiFi requested
[  141.983894] thunderbolt 0000:06:00.0: 0: TMU: mode set to: bi-directional, HiFi
[  144.199474] wlp0s20f3: authenticate with a0:55:1f:2f:2c:92 (local address=98:5f:41:dd:bb:cf)
[  144.200586] wlp0s20f3: send auth to a0:55:1f:2f:2c:92 (try 1/3)
[  144.232738] wlp0s20f3: authenticated
[  144.233659] wlp0s20f3: associate with a0:55:1f:2f:2c:92 (try 1/3)
[  144.236773] wlp0s20f3: RX AssocResp from a0:55:1f:2f:2c:92 (capab=0x1011 status=0 aid=26)
[  144.243415] wlp0s20f3: associated
[  144.247699] wlp0s20f3: Limiting TX power to 30 (30 - 0) dBm as advertised by a0:55:1f:2f:2c:92
[  149.936087] thunderbolt 0000:06:00.0: acking hot unplug event on 0:13
[  149.936218] thunderbolt 0000:06:00.0: 0:13: DP IN resource unavailable
[  149.936912] thunderbolt 0000:06:00.0: 0:13: enter redrive mode, keeping powered
[  149.936921] thunderbolt 0000:06:00.0: bandwidth consumption changed, re-calculating estimated bandwidth
[  149.936924] thunderbolt 0000:06:00.0: bandwidth re-calculation done
[  149.936926] thunderbolt 0000:06:00.0: looking for DP IN <-> DP OUT pairs:
[  149.937119] thunderbolt 0000:06:00.0: 0:14: DP IN available
[  149.937134] thunderbolt 0000:06:00.0: no suitable DP OUT adapter available, not tunneling
[  151.708652] usb 1-9: new high-speed USB device number 6 using xhci_hcd
[  152.183069] usb 1-9: New USB device found, idVendor=2109, idProduct=0100, bcdDevice= 3.00
[  152.183086] usb 1-9: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[  152.183092] usb 1-9: Product: USB-C dongle
[  152.183097] usb 1-9: Manufacturer: VIA Technologies Inc.         
[  152.183101] usb 1-9: SerialNumber: 0000000000000001
[  155.225784] usb 1-10: new high-speed USB device number 7 using xhci_hcd
[  155.232971] thunderbolt 0000:06:00.0: acking hot unplug event on 0:14
[  155.233076] thunderbolt 0000:06:00.0: 0:14: DP IN resource unavailable
[  155.233845] thunderbolt 0000:06:00.0: 0:14: enter redrive mode, keeping powered
[  155.233853] thunderbolt 0000:06:00.0: bandwidth consumption changed, re-calculating estimated bandwidth
[  155.233856] thunderbolt 0000:06:00.0: bandwidth re-calculation done
[  155.233858] thunderbolt 0000:06:00.0: looking for DP IN <-> DP OUT pairs:
[  155.233859] thunderbolt 0000:06:00.0: no suitable DP IN adapter available, not tunneling
[  155.371973] usb 1-10: New USB device found, idVendor=0bda, idProduct=5411, bcdDevice= 1.49
[  155.371983] usb 1-10: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[  155.371985] usb 1-10: Product: 4-Port USB 2.0 Hub
[  155.371988] usb 1-10: Manufacturer: Generic
[  155.375342] hub 1-10:1.0: USB hub found
[  155.376561] hub 1-10:1.0: 4 ports detected
[  156.602750] usb 1-10.3: new full-speed USB device number 8 using xhci_hcd
[  156.694015] usb 1-10.3: New USB device found, idVendor=043e, idProduct=9a39, bcdDevice= 4.11
[  156.694023] usb 1-10.3: New USB device strings: Mfr=1, Product=3, SerialNumber=4
[  156.694026] usb 1-10.3: Product: LG Monitor Controls
[  156.694028] usb 1-10.3: Manufacturer: LG Electronics Inc.
[  156.694030] usb 1-10.3: SerialNumber: 005INTX1F153
[  156.700635] hid-generic 0003:043E:9A39.0008: hiddev2,hidraw5: USB HID v1.11 Device [LG Electronics Inc. LG Monitor Controls] on usb-0000:00:14.0-10.3/input0
[  219.413699] usb 1-10: USB disconnect, device number 7
[  219.413713] usb 1-10.3: USB disconnect, device number 8
[  219.469939] thunderbolt 0000:06:00.0: acking hot plug event on 0:14
[  219.470254] thunderbolt 0000:06:00.0: 0:14: DP IN resource available after hotplug
[  219.471098] thunderbolt 0000:06:00.0: 0:14: exit redrive mode
[  219.471113] thunderbolt 0000:06:00.0: looking for DP IN <-> DP OUT pairs:
[  219.471366] thunderbolt 0000:06:00.0: 0:14: DP IN available
[  219.471381] thunderbolt 0000:06:00.0: no suitable DP OUT adapter available, not tunneling
[  222.509634] usb 1-9: USB disconnect, device number 6
[  222.556869] thunderbolt 0000:06:00.0: acking hot plug event on 0:13
[  222.557202] thunderbolt 0000:06:00.0: 0:13: DP IN resource available after hotplug
[  222.557941] thunderbolt 0000:06:00.0: 0:13: exit redrive mode
[  222.557951] thunderbolt 0000:06:00.0: looking for DP IN <-> DP OUT pairs:
[  222.558143] thunderbolt 0000:06:00.0: 0:14: DP IN available
[  222.558248] thunderbolt 0000:06:00.0: 0:13: DP IN available
[  222.558257] thunderbolt 0000:06:00.0: no suitable DP OUT adapter available, not tunneling
[  222.835652] logitech-hidpp-device 0003:046D:4082.0006: HID++ 4.5 device connected.
[  240.135744] thunderbolt 0000:06:00.0: 0: suspending switch
[  240.135760] thunderbolt 0000:06:00.0: 0: enabling wakeup: 0x3f
[  240.136913] thunderbolt 0000:06:00.0: stopping RX ring 0
[  240.136934] thunderbolt 0000:06:00.0: disabling interrupt at register 0x38200 bit 12 (0x1001 -> 0x1)
[  240.136973] thunderbolt 0000:06:00.0: stopping TX ring 0
[  240.136988] thunderbolt 0000:06:00.0: disabling interrupt at register 0x38200 bit 0 (0x1 -> 0x0)
[  240.137005] thunderbolt 0000:06:00.0: control channel stopped
[  247.326555] usb 1-9: new high-speed USB device number 9 using xhci_hcd
[  247.803092] usb 1-9: New USB device found, idVendor=2109, idProduct=0100, bcdDevice= 3.00
[  247.803109] usb 1-9: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[  247.803114] usb 1-9: Product: USB-C dongle
[  247.803119] usb 1-9: Manufacturer: VIA Technologies Inc.         
[  247.803122] usb 1-9: SerialNumber: 0000000000000001
[  253.228170] usb 1-10: new high-speed USB device number 10 using xhci_hcd
[  253.376422] usb 1-10: New USB device found, idVendor=0bda, idProduct=5411, bcdDevice= 1.49
[  253.376433] usb 1-10: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[  253.376437] usb 1-10: Product: 4-Port USB 2.0 Hub
[  253.376440] usb 1-10: Manufacturer: Generic
[  253.379673] hub 1-10:1.0: USB hub found
[  253.382247] hub 1-10:1.0: 4 ports detected
[  253.670094] usb 1-10.3: new full-speed USB device number 11 using xhci_hcd
[  253.764308] usb 1-10.3: New USB device found, idVendor=043e, idProduct=9a39, bcdDevice= 4.11
[  253.764328] usb 1-10.3: New USB device strings: Mfr=1, Product=3, SerialNumber=4
[  253.764334] usb 1-10.3: Product: LG Monitor Controls
[  253.764338] usb 1-10.3: Manufacturer: LG Electronics Inc.
[  253.764341] usb 1-10.3: SerialNumber: 005INTX1F153
[  253.773314] hid-generic 0003:043E:9A39.0009: hiddev2,hidraw5: USB HID v1.11 Device [LG Electronics Inc. LG Monitor Controls] on usb-0000:00:14.0-10.3/input0
[  298.240145] thunderbolt 0000:06:00.0: control channel starting...
[  298.240154] thunderbolt 0000:06:00.0: starting TX ring 0
[  298.240163] thunderbolt 0000:06:00.0: enabling interrupt at register 0x38200 bit 0 (0x0 -> 0x1)
[  298.240168] thunderbolt 0000:06:00.0: starting RX ring 0
[  298.240175] thunderbolt 0000:06:00.0: enabling interrupt at register 0x38200 bit 12 (0x1 -> 0x1001)
[  298.240182] thunderbolt 0000:06:00.0: 0: resuming switch
[  298.240185] thunderbolt 0000:06:00.0: restoring Switch at 0x0 (depth: 0, up port: 15)
[  298.240374] xhci_hcd 0000:2d:00.0: xHC error in resume, USBSTS 0x401, Reinit
[  298.240380] usb usb3: root hub lost power or was reset
[  298.240381] usb usb4: root hub lost power or was reset
[  298.240425] thunderbolt 0000:06:00.0: 0: disabling wakeup
[  298.249228] thunderbolt 0000:06:00.0: 0: TMU: supports uni-directional mode
[  298.249233] thunderbolt 0000:06:00.0: 0: TMU: supports enhanced uni-directional mode
[  298.249355] thunderbolt 0000:06:00.0: 0: TMU: current mode: off
[  298.249359] thunderbolt 0000:06:00.0: 0: TMU: mode change off -> bi-directional, HiFi requested
[  298.249738] thunderbolt 0000:06:00.0: acking hot plug event on 0:16
[  298.249868] thunderbolt 0000:06:00.0: 0: TMU: mode set to: bi-directional, HiFi
[  316.130969] thunderbolt 0000:06:00.0: 0: suspending switch
[  316.130988] thunderbolt 0000:06:00.0: 0: enabling wakeup: 0x3f
[  316.132187] thunderbolt 0000:06:00.0: stopping RX ring 0
[  316.132211] thunderbolt 0000:06:00.0: disabling interrupt at register 0x38200 bit 12 (0x1001 -> 0x1)
[  316.132252] thunderbolt 0000:06:00.0: stopping TX ring 0
[  316.132266] thunderbolt 0000:06:00.0: disabling interrupt at register 0x38200 bit 0 (0x1 -> 0x0)
[  316.132283] thunderbolt 0000:06:00.0: control channel stopped

--MP_/XUtY2b=33lKMSh9PCBuX0pe--

