Return-Path: <linux-kernel+bounces-378968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 662489AD801
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 00:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 148B328286F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 22:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A202200BBA;
	Wed, 23 Oct 2024 22:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b="HXnj9VLN"
Received: from mail-il1-f196.google.com (mail-il1-f196.google.com [209.85.166.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93ABD1FAC3F
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 22:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729723471; cv=none; b=tfzpfrvOFVIZVfUmGGsgES3fxRoJK6AmioaD3z/Q/kg8NDS59XKyi/tHNucmwrNILzQiUuOFtqLBB8iDtNWoqxanrvC5j63HQsuleDMmNv7HcHCIj3XSDZEtzwlUHPa7JVLVhoclYi1AtHoTqj4PqqdDpQFo7XOEr3RZO8GDUdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729723471; c=relaxed/simple;
	bh=8axrOeTyoyzs9iexDJteCx8GI0Ux9Q96p4EsUJPrf50=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bdRYNODx7cACEdhmZfAlK538TqBMK4EpXhadCZKClptC/nTcUMUpRq2i34Y7gbbSMtOkQZgk25J3FMx/1Fl/Pm1Tf2wqrupKss/zv4fIP+by5hPolHp3Mg7sNnZwbMzn3spvreK3brZKZ+DE+s3o4px/psEO2wNo7Io9ANAQ/6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org; spf=pass smtp.mailfrom=kfocus.org; dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b=HXnj9VLN; arc=none smtp.client-ip=209.85.166.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kfocus.org
Received: by mail-il1-f196.google.com with SMTP id e9e14a558f8ab-3a4dc2fff04so1663435ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 15:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kfocus-org.20230601.gappssmtp.com; s=20230601; t=1729723458; x=1730328258; darn=vger.kernel.org;
        h=mime-version:organization:references:in-reply-to:message-id:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NLYPwytElto2Jkhn75PvLwETLKRfEFFfx1XkSoonrVQ=;
        b=HXnj9VLNitkcpUBNZQR+ti3mqX73zpnXIcMDzO1hhSOX0UjR7K2tE2B1gNWsKeSyl+
         4kao2bXcVjJVExjf3OT5NaKa+g57/h6qf2C3MjygqP6WOmCuMNuNCHtokDbVWr4jAjTW
         CfcgoO6hWdOsS6C7Ck4uD4TrXPLQ5dNwFp3WrLxC3JdI2kY8Wj4bjlBrNNP2c7BlFJ7J
         dkQyqmq0T4Q9ACZyuDKcxD/32rWTTzP2Os7a83xfghoK7ojv+7102DOtEFPOyOyo4r1x
         3M0+txKgiUMf2SSYN5jFtqb0j2Zhmszz9YUq37G1g3btoPZiI3ZbzFU57n767OFxHBCY
         okbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729723458; x=1730328258;
        h=mime-version:organization:references:in-reply-to:message-id:subject
         :cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NLYPwytElto2Jkhn75PvLwETLKRfEFFfx1XkSoonrVQ=;
        b=SNcOGlBegf/dalh4CkPr18fJiMDXuY3L5qpZIb9OebKtnQd13HpQgg2he6ptaz+Jhk
         7WvY+nc5Io9DFP58F90Hry6zb1Op5PCWN74xuGbJV6mh/TyIsIex2OIgfk8Guxl/AltZ
         AzUiQDZMI6pDaME9Nk2Rp4nj5sNRq5IEdnUtAI5X3dcujaImhEl1vVa+mTd1oGSkGUqK
         tC9rI1sZhLPYu5rFVMPhRbRSoR0vL5r17Lajn/sT4V4+F/hn5Rod+oTTza3TJYJrJi/w
         cK70cujAYEhQwUpC8VplxHciwy/eYmur+CRh4my7evsuYodcY55eMaUy2g0U5qRipOYq
         6fqw==
X-Forwarded-Encrypted: i=1; AJvYcCVrub5hEU1DO+UgMOIP+QcDEVqMvGRONYhoBhtFeApgPuYuBlnevJdCu2JWklrB5Lb7QXV4pZvNwb79xw8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw25XOGomdj+MONI2ScRuC/B+ygbX+t9fqDZTXo5BaWLnG44ecc
	pG3WgJm9sNG6OjGl4jSOkDThjGBLeH4FcTesZv+eLEmhglmosjfRmPfeicG55pQ=
X-Google-Smtp-Source: AGHT+IEInsm7jgDDz7yyph4aSGVQOuSJHAgF5xvqA7F+JMuZbdF9MMOtI4GOQqyzzRWuobL3WEZJQQ==
X-Received: by 2002:a05:6e02:527:b0:3a3:449b:597b with SMTP id e9e14a558f8ab-3a4d59be106mr41393285ab.18.1729723458384;
        Wed, 23 Oct 2024 15:44:18 -0700 (PDT)
Received: from kf-ir16 ([2607:fb91:759:8d6:7418:d0dc:9da5:cb39])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a4dc1efc35sm3930485ab.51.2024.10.23.15.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 15:44:17 -0700 (PDT)
Date: Wed, 23 Oct 2024 17:44:13 -0500
From: Aaron Rainbolt <arainbolt@kfocus.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: YehezkelShB@gmail.com, michael.jamet@intel.com,
 andreas.noever@gmail.com, linux-usb@vger.kernel.org, mmikowski@kfocus.org,
 linux-kernel@vger.kernel.org, Gil Fine <gil.fine@linux.intel.com>
Subject: Re: USB-C DisplayPort display failing to stay active with Intel
 Barlow Ridge USB4 controller, power-management related issue?
Message-ID: <20241023174413.451710ea@kf-ir16>
In-Reply-To: <20241023073931.GH275077@black.fi.intel.com>
References: <20241009220118.70bfedd0@kf-ir16>
	<20241010044919.GD275077@black.fi.intel.com>
	<20241010232656.7fc6359e@kf-ir16>
	<20241011163811.GU275077@black.fi.intel.com>
	<20241011183751.7d27c59c@kf-ir16>
	<20241023062737.GG275077@black.fi.intel.com>
	<20241023073931.GH275077@black.fi.intel.com>
Organization: Kubuntu Focus
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/_0+LG6F0OE0r8ceD.u3ft65"

--MP_/_0+LG6F0OE0r8ceD.u3ft65
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wed, 23 Oct 2024 10:39:31 +0300
Mika Westerberg <mika.westerberg@linux.intel.com> wrote:

> On Wed, Oct 23, 2024 at 09:27:37AM +0300, Mika Westerberg wrote:
> > So at this point we are not in "redrive" mode anymore and the
> > domain is allowed to runtime suspend.
> >   
> > > [  353.611933] thunderbolt 0000:06:00.0: looking for DP IN <-> DP
> > > OUT pairs: [  353.612076] thunderbolt 0000:06:00.0: 0:14: DP IN
> > > available [  353.612258] thunderbolt 0000:06:00.0: 0:13: DP IN
> > > available [  353.612264] thunderbolt 0000:06:00.0: no suitable DP
> > > OUT adapter available, not tunneling [  372.362496] thunderbolt
> > > 0000:06:00.0: 0: suspending switch [  372.362506] thunderbolt
> > > 0000:06:00.0: 0: enabling wakeup: 0x3f [  372.363480] thunderbolt
> > > 0000:06:00.0: stopping RX ring 0 [  372.363497] thunderbolt
> > > 0000:06:00.0: disabling interrupt at register 0x38200 bit 12
> > > (0x1001 -> 0x1) [  372.363523] thunderbolt 0000:06:00.0: stopping
> > > TX ring 0 [  372.363539] thunderbolt 0000:06:00.0: disabling
> > > interrupt at register 0x38200 bit 0 (0x1 -> 0x0) [  372.363558]
> > > thunderbolt 0000:06:00.0: control channel stopped  
> > 
> > Which is what happens here.
> > 
> > I think the driver does the correct thing but why you don't see
> > anything in the screen is beyond me. Can reproduce just this case
> > with the patch and then run "xrandr" and see if the monitors are
> > visible there?  
> 
> The other option is that there is no wake when you plugged in the
> monitors and it only wakes up when you did this:
> 
> > 8. Open a terminal and run 'lspci -k' 
> >     - Both displays are activated and remain active.
> >     - There is no timeout.
> >     - This is desired behavior.  
> 
> There is one such wake in the dmesg, this:
> 
> [   60.126328] thunderbolt 0000:06:00.0: control channel starting...
> [   60.126332] thunderbolt 0000:06:00.0: starting TX ring 0
> [   60.126337] thunderbolt 0000:06:00.0: enabling interrupt at
> register 0x38200 bit 0 (0x0 -> 0x1) [   60.126339] thunderbolt
> 0000:06:00.0: starting RX ring 0 [   60.126344] thunderbolt
> 0000:06:00.0: enabling interrupt at register 0x38200 bit 12 (0x1 ->
> 0x1001) [   60.126347] thunderbolt 0000:06:00.0: 0: resuming switch [
>   60.126348] thunderbolt 0000:06:00.0: restoring Switch at 0x0
> (depth: 0, up port: 15) [   60.128535] thunderbolt 0000:06:00.0: 0:
> disabling wakeup [   60.129481] thunderbolt 0000:06:00.0: acking hot
> plug event on 0:13 [   60.129601] thunderbolt 0000:06:00.0: acking
> hot plug event on 0:14 [   60.129730] thunderbolt 0000:06:00.0:
> acking hot plug event on 0:16
> 
> but here we get plug event for all the DP IN adapters (13, 14, 16)
> which tells me that there is nothing connected to the Type-C ports.
> Otherwise it would not send the plug event. This may be due the older
> firmware.
> 
> [   60.137467] thunderbolt 0000:06:00.0: 0: TMU: supports
> uni-directional mode [   60.137478] thunderbolt 0000:06:00.0: 0: TMU:
> supports enhanced uni-directional mode [   60.137589] thunderbolt
> 0000:06:00.0: 0: TMU: current mode: off [   60.137591] thunderbolt
> 0000:06:00.0: 0: TMU: mode change off -> bi-directional, HiFi
> requested [   60.138102] thunderbolt 0000:06:00.0: 0: TMU: mode set
> to: bi-directional, HiFi [   60.139778] thunderbolt 0000:06:00.0:
> 0:13: DP IN resource available after hotplug [   60.139783]
> thunderbolt 0000:06:00.0: looking for DP IN <-> DP OUT pairs: [
> 60.139895] thunderbolt 0000:06:00.0: 0:13: DP IN available [
> 60.139896] thunderbolt 0000:06:00.0: no suitable DP OUT adapter
> available, not tunneling [   60.140018] thunderbolt 0000:06:00.0:
> 0:14: DP IN resource available after hotplug [   60.140021]
> thunderbolt 0000:06:00.0: looking for DP IN <-> DP OUT pairs: [
> 60.140145] thunderbolt 0000:06:00.0: 0:13: DP IN available [
> 60.140277] thunderbolt 0000:06:00.0: 0:14: DP IN available [
> 60.140278] thunderbolt 0000:06:00.0: no suitable DP OUT adapter
> available, not tunneling [   78.863111] thunderbolt 0000:06:00.0: 0:
> suspending switch [   78.863125] thunderbolt 0000:06:00.0: 0:
> enabling wakeup: 0x3f [   78.864812] thunderbolt 0000:06:00.0:
> stopping RX ring 0 [   78.864825] thunderbolt 0000:06:00.0: disabling
> interrupt at register 0x38200 bit 12 (0x1001 -> 0x1) [   78.864849]
> thunderbolt 0000:06:00.0: stopping TX ring 0 [   78.864857]
> thunderbolt 0000:06:00.0: disabling interrupt at register 0x38200 bit
> 0 (0x1 -> 0x0) [   78.864870] thunderbolt 0000:06:00.0: control
> channel stopped
> 
> There is no unplug at all here so the domain can go back to runtime
> suspend.

Hey, thanks for taking a look! Our tester re-did the tests with kernel
6.12~rc4, and reported the following results doing so, along with
another dmesg log. I think your question about xrandr is answered in
this report. The dmesg log is attached.

With the vanilla rc4 kernel plus your patch from earlier:

-----

1. Start with Laptop powered-off
2. Unplug all USB-C connectors.
3. Boot Kubuntu 24.04 with patched kernel 6.12.0-rc4, add cmdline
   parameter thunderbolt.dyndbg=+p. All other optional parameters were
   removed.
4. Log in to normal SDDM to KDE 5.27.11.
5. Open 'Display Settings KCM' to view display detection.
6. Plug in one UBC-C connector attached to 4k display.
   * Note these work with Kernel 6.1 and non-Barlow Ridge systems (TBT
     4).
   * Display does not wake up.
   * Display never appears in 'Display Settings KCM.'
   * This is NOT desired behavior; display should show.
   * (Note: The test results I was given do not mention xrandr here,
     however as subsequent results mention it I believe that the
     monitor does *not* appear in xrandr here. I will double-check
     to be sure.)
7. Open a terminal and run 'lspci -k'
   * Display is activated and remains active. There is a checkerboard
     pattern pattern of where 50% of pixels are black. Probably
     caused by Nouveau.
   * There is no timeout.
   * Device is shown in xrandr --listmonitors
   * This is desired behavior (except for checkerboard)
8. Plug in secone UBC-C connector attached to 4k display.
   * Display is activated and remains active
   * Device is shown in xrandr --listmonitors
   * This is desired behavior (except for checkerboard)

Notes:

1. With debug off, the recognition of screens is better, and previously
   "just worked", at least for one screen.
2. W11 updated works, as do kernels Kernels 6.1 and earlier.
3. W11 from Q4 2022 (pre-update) and kernels 6.5+ do not. With both,
   the screens usually initially attach and then time out after 15s.

-----

Looking at what you describe, it sounds like we should pursue trying to
update the firmware to see if that resolves the issue in combination
with the patch. I'm not entirely sure if it will be possible to do
that, but I'll see if our ODM can help us with that.

--MP_/_0+LG6F0OE0r8ceD.u3ft65
Content-Type: text/x-log
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename=2024-10-23_6.12.0-rc4_dmesg_barlow-ridge-tbt.log

[    0.000000] Linux version 6.12.0-rc4 (qa@qa-m2) (gcc (Ubuntu 13.2.0-23ubuntu4) 13.2.0, GNU ld (GNU Binutils for Ubuntu) 2.42) #1 SMP PREEMPT_DYNAMIC Tue Oct 22 11:01:01 PDT 2024
[    0.000000] Command line: BOOT_IMAGE=/@boot/vmlinuz-6.12.0-rc4 root=UUID=aa8cb093-9cb3-4cc7-b44e-4bff76ca37fb ro rootflags=subvol=@ quiet cryptdevice=UUID=1a8d8cdb-8d8f-4689-b744-8f32d2067f56:luks-1a8d8cdb-8d8f-4689-b744-8f32d2067f56 root=/dev/mapper/luks-1a8d8cdb-8d8f-4689-b744-8f32d2067f56 splash thunderbolt.dyndbg=+p vt.handoff=7
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
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x00000008bf7fffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] APIC: Static calls initialized
[    0.000000] efi: EFI v2.8 by INSYDE Corp.
[    0.000000] efi: ACPI=0x33afe000 ACPI 2.0=0x33afe014 TPMFinalLog=0x33866000 SMBIOS=0x2efda000 MEMATTR=0x26ca0018 ESRT=0x28a1e018 MOKvar=0x2ef86000 INITRD=0x27d91418 RNG=0x33a24018 TPMEventLog=0x33a17018 
[    0.000000] random: crng init done
[    0.000000] efi: Remove mem90: MMIO range=[0xc0000000-0xcfffffff] (256MB) from e820 map
[    0.000000] e820: remove [mem 0xc0000000-0xcfffffff] reserved
[    0.000000] efi: Remove mem92: MMIO range=[0xff000000-0xffffffff] (16MB) from e820 map
[    0.000000] e820: remove [mem 0xff000000-0xffffffff] reserved
[    0.000000] SMBIOS 3.4 present.
[    0.000000] DMI: Notebook X370SNx1/X370SNx1, BIOS 1.07.03aMIN29 09/18/2024
[    0.000000] DMI: Memory slots populated: 2/2
[    0.000000] tsc: Detected 2400.000 MHz processor
[    0.000000] tsc: Detected 2419.200 MHz TSC
[    0.000007] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000011] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000019] last_pfn = 0x8bf800 max_arch_pfn = 0x400000000
[    0.000025] MTRR map: 5 entries (3 fixed + 2 variable; max 23), built from 10 variable MTRRs
[    0.000027] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.000743] last_pfn = 0x33b00 max_arch_pfn = 0x400000000
[    0.009631] esrt: Reserving ESRT space from 0x0000000028a1e018 to 0x0000000028a1e0a0.
[    0.009639] e820: update [mem 0x28a1e000-0x28a1efff] usable ==> reserved
[    0.009662] Using GB pages for direct mapping
[    0.009663] Incomplete global flushes, disabling PCID
[    0.010001] Secure boot disabled
[    0.010002] RAMDISK: [mem 0x17b00000-0x1c3eefff]
[    0.010078] ACPI: Early table checksum verification disabled
[    0.010082] ACPI: RSDP 0x0000000033AFE014 000024 (v02 INSYDE)
[    0.010088] ACPI: XSDT 0x0000000033A38188 00012C (v01 INSYDE ADL      00000002      01000013)
[    0.010096] ACPI: FACP 0x0000000033ADB000 000114 (v06 INSYDE ADL      00000002 ACPI 00040000)
[    0.010103] ACPI: DSDT 0x0000000033A4E000 089652 (v02 INSYDE ADL      00000002 ACPI 00040000)
[    0.010107] ACPI: FACS 0x000000003383E000 000040
[    0.010111] ACPI: UEFI 0x000000003398E000 0001CF (v01 INSYDE H2O BIOS 00000001 ACPI 00040000)
[    0.010115] ACPI: SSDT 0x0000000033AF3000 00908F (v02 DptfTb DptfTabl 00001000 INTL 20200717)
[    0.010119] ACPI: SSDT 0x0000000033AED000 005D34 (v02 CpuRef CpuSsdt  00003000 INTL 20200717)
[    0.010123] ACPI: SSDT 0x0000000033AEA000 00276F (v02 SaSsdt SaSsdt   00003000 INTL 20200717)
[    0.010127] ACPI: SSDT 0x0000000033AE6000 00328B (v02 INTEL  IgfxSsdt 00003000 INTL 20200717)
[    0.010131] ACPI: SSDT 0x0000000033AE5000 00077B (v02 INSYDE Tpm2Tabl 00001000 INTL 20200717)
[    0.010135] ACPI: TPM2 0x0000000033AE4000 00004C (v04 INSYDE ADL      00000002 ACPI 00040000)
[    0.010139] ACPI: SSDT 0x0000000033ADF000 003249 (v02 INTEL  DTbtSsdt 00001000 INTL 20200717)
[    0.010142] ACPI: SSDT 0x0000000033ADD000 0016A6 (v02 INSYDE UsbCTabl 00001000 INTL 20200717)
[    0.010146] ACPI: NHLT 0x0000000033ADC000 00002D (v00 INSYDE ADL      00000002 ACPI 00040000)
[    0.010150] ACPI: HPET 0x0000000033ADA000 000038 (v01 INSYDE ADL      00000002 ACPI 00040000)
[    0.010154] ACPI: APIC 0x0000000033AD9000 0001DC (v05 INSYDE ADL      00000002 ACPI 00040000)
[    0.010157] ACPI: MCFG 0x0000000033AD8000 00003C (v01 INSYDE ADL      00000002 ACPI 00040000)
[    0.010161] ACPI: SSDT 0x0000000033A48000 0054E4 (v02 INSYDE ADL      00000002      01000013)
[    0.010165] ACPI: WSMT 0x0000000033A47000 000028 (v01 INSYDE ADL      00000002 ACPI 00040000)
[    0.010169] ACPI: SSDT 0x0000000033A45000 0015FD (v02 INSYDE PtidDevc 00001000 INTL 20200717)
[    0.010172] ACPI: SSDT 0x0000000033A3B000 009573 (v02 INSYDE TbtTypeC 00000000 INTL 20200717)
[    0.010176] ACPI: DBGP 0x0000000033A3A000 000034 (v01 INSYDE ADL      00000002 ACPI 00040000)
[    0.010180] ACPI: DBG2 0x0000000033A39000 000054 (v00 INSYDE ADL      00000002 ACPI 00040000)
[    0.010184] ACPI: DMAR 0x0000000033AFD000 000088 (v01 INTEL  ICL      00000002 ACPI 00040000)
[    0.010187] ACPI: SSDT 0x0000000033A35000 002EE7 (v01 NvdRef NvdTabl  00001000 INTL 20200717)
[    0.010191] ACPI: SSDT 0x0000000033A34000 000244 (v01 NvdRef NvdExt   00001000 INTL 20200717)
[    0.010195] ACPI: SSDT 0x0000000033A33000 000640 (v01 NvdRef NvdDds   00001000 INTL 20200717)
[    0.010199] ACPI: UEFI 0x000000003383B000 00063A (v01 INTEL  RstVmdE  00000000 ACPI 00040000)
[    0.010203] ACPI: UEFI 0x000000003383A000 00005C (v01 INTEL  RstVmdV  00000000 ACPI 00040000)
[    0.010207] ACPI: SSDT 0x0000000033A31000 001057 (v02 INTEL  xh_rplsb 00000000 INTL 20200717)
[    0.010211] ACPI: SSDT 0x0000000033A2D000 0039DA (v02 SocGpe SocGpe   00003000 INTL 20200717)
[    0.010215] ACPI: SSDT 0x0000000033A29000 0039DA (v02 SocCmn SocCmn   00003000 INTL 20200717)
[    0.010218] ACPI: SSDT 0x0000000033A28000 0000F8 (v02 INSYDE PcdTabl  00001000 INTL 20200717)
[    0.010222] ACPI: FPDT 0x0000000033A27000 000044 (v01 INSYDE ADL      00000002 ACPI 00040000)
[    0.010226] ACPI: PHAT 0x0000000033A25000 0005ED (v01 INSYDE ADL      00000005 ACPI 00040000)
[    0.010230] ACPI: BGRT 0x0000000033A26000 000038 (v01 INSYDE H2O BIOS 00000001 ACPI 00040000)
[    0.010233] ACPI: Reserving FACP table memory at [mem 0x33adb000-0x33adb113]
[    0.010235] ACPI: Reserving DSDT table memory at [mem 0x33a4e000-0x33ad7651]
[    0.010237] ACPI: Reserving FACS table memory at [mem 0x3383e000-0x3383e03f]
[    0.010238] ACPI: Reserving UEFI table memory at [mem 0x3398e000-0x3398e1ce]
[    0.010239] ACPI: Reserving SSDT table memory at [mem 0x33af3000-0x33afc08e]
[    0.010240] ACPI: Reserving SSDT table memory at [mem 0x33aed000-0x33af2d33]
[    0.010241] ACPI: Reserving SSDT table memory at [mem 0x33aea000-0x33aec76e]
[    0.010243] ACPI: Reserving SSDT table memory at [mem 0x33ae6000-0x33ae928a]
[    0.010244] ACPI: Reserving SSDT table memory at [mem 0x33ae5000-0x33ae577a]
[    0.010245] ACPI: Reserving TPM2 table memory at [mem 0x33ae4000-0x33ae404b]
[    0.010246] ACPI: Reserving SSDT table memory at [mem 0x33adf000-0x33ae2248]
[    0.010247] ACPI: Reserving SSDT table memory at [mem 0x33add000-0x33ade6a5]
[    0.010248] ACPI: Reserving NHLT table memory at [mem 0x33adc000-0x33adc02c]
[    0.010249] ACPI: Reserving HPET table memory at [mem 0x33ada000-0x33ada037]
[    0.010249] ACPI: Reserving APIC table memory at [mem 0x33ad9000-0x33ad91db]
[    0.010250] ACPI: Reserving MCFG table memory at [mem 0x33ad8000-0x33ad803b]
[    0.010251] ACPI: Reserving SSDT table memory at [mem 0x33a48000-0x33a4d4e3]
[    0.010252] ACPI: Reserving WSMT table memory at [mem 0x33a47000-0x33a47027]
[    0.010253] ACPI: Reserving SSDT table memory at [mem 0x33a45000-0x33a465fc]
[    0.010254] ACPI: Reserving SSDT table memory at [mem 0x33a3b000-0x33a44572]
[    0.010255] ACPI: Reserving DBGP table memory at [mem 0x33a3a000-0x33a3a033]
[    0.010256] ACPI: Reserving DBG2 table memory at [mem 0x33a39000-0x33a39053]
[    0.010257] ACPI: Reserving DMAR table memory at [mem 0x33afd000-0x33afd087]
[    0.010257] ACPI: Reserving SSDT table memory at [mem 0x33a35000-0x33a37ee6]
[    0.010258] ACPI: Reserving SSDT table memory at [mem 0x33a34000-0x33a34243]
[    0.010259] ACPI: Reserving SSDT table memory at [mem 0x33a33000-0x33a3363f]
[    0.010260] ACPI: Reserving UEFI table memory at [mem 0x3383b000-0x3383b639]
[    0.010261] ACPI: Reserving UEFI table memory at [mem 0x3383a000-0x3383a05b]
[    0.010262] ACPI: Reserving SSDT table memory at [mem 0x33a31000-0x33a32056]
[    0.010263] ACPI: Reserving SSDT table memory at [mem 0x33a2d000-0x33a309d9]
[    0.010264] ACPI: Reserving SSDT table memory at [mem 0x33a29000-0x33a2c9d9]
[    0.010265] ACPI: Reserving SSDT table memory at [mem 0x33a28000-0x33a280f7]
[    0.010266] ACPI: Reserving FPDT table memory at [mem 0x33a27000-0x33a27043]
[    0.010267] ACPI: Reserving PHAT table memory at [mem 0x33a25000-0x33a255ec]
[    0.010267] ACPI: Reserving BGRT table memory at [mem 0x33a26000-0x33a26037]
[    0.010508] No NUMA configuration found
[    0.010509] Faking a node at [mem 0x0000000000000000-0x00000008bf7fffff]
[    0.010518] NODE_DATA(0) allocated [mem 0x8bf7d5680-0x8bf7fffff]
[    0.010791] Zone ranges:
[    0.010791]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.010794]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.010796]   Normal   [mem 0x0000000100000000-0x00000008bf7fffff]
[    0.010797]   Device   empty
[    0.010798] Movable zone start for each node
[    0.010800] Early memory node ranges
[    0.010800]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.010802]   node   0: [mem 0x0000000000100000-0x000000002c228fff]
[    0.010803]   node   0: [mem 0x000000002cb29000-0x000000002e93efff]
[    0.010804]   node   0: [mem 0x0000000033aff000-0x0000000033afffff]
[    0.010805]   node   0: [mem 0x0000000100000000-0x00000008bf7fffff]
[    0.010809] Initmem setup node 0 [mem 0x0000000000001000-0x00000008bf7fffff]
[    0.010816] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.010841] On node 0, zone DMA: 97 pages in unavailable ranges
[    0.011949] On node 0, zone DMA32: 2304 pages in unavailable ranges
[    0.012139] On node 0, zone DMA32: 20928 pages in unavailable ranges
[    0.055456] On node 0, zone Normal: 17664 pages in unavailable ranges
[    0.055473] On node 0, zone Normal: 2048 pages in unavailable ranges
[    0.055544] Reserving Intel graphics memory at [mem 0x3c800000-0x407fffff]
[    0.056176] ACPI: PM-Timer IO Port: 0x1808
[    0.056189] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.056191] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.056192] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.056192] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.056193] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
[    0.056194] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[    0.056194] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
[    0.056195] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
[    0.056196] ACPI: LAPIC_NMI (acpi_id[0x09] high edge lint[0x1])
[    0.056196] ACPI: LAPIC_NMI (acpi_id[0x0a] high edge lint[0x1])
[    0.056197] ACPI: LAPIC_NMI (acpi_id[0x0b] high edge lint[0x1])
[    0.056198] ACPI: LAPIC_NMI (acpi_id[0x0c] high edge lint[0x1])
[    0.056198] ACPI: LAPIC_NMI (acpi_id[0x0d] high edge lint[0x1])
[    0.056199] ACPI: LAPIC_NMI (acpi_id[0x0e] high edge lint[0x1])
[    0.056200] ACPI: LAPIC_NMI (acpi_id[0x0f] high edge lint[0x1])
[    0.056200] ACPI: LAPIC_NMI (acpi_id[0x10] high edge lint[0x1])
[    0.056201] ACPI: LAPIC_NMI (acpi_id[0x11] high edge lint[0x1])
[    0.056202] ACPI: LAPIC_NMI (acpi_id[0x12] high edge lint[0x1])
[    0.056202] ACPI: LAPIC_NMI (acpi_id[0x13] high edge lint[0x1])
[    0.056203] ACPI: LAPIC_NMI (acpi_id[0x14] high edge lint[0x1])
[    0.056204] ACPI: LAPIC_NMI (acpi_id[0x15] high edge lint[0x1])
[    0.056204] ACPI: LAPIC_NMI (acpi_id[0x16] high edge lint[0x1])
[    0.056205] ACPI: LAPIC_NMI (acpi_id[0x17] high edge lint[0x1])
[    0.056206] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.056245] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-119
[    0.056249] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.056251] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.056256] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.056257] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.056266] e820: update [mem 0x26cdf000-0x26d99fff] usable ==> reserved
[    0.056283] TSC deadline timer available
[    0.056286] CPU topo: Max. logical packages:   1
[    0.056287] CPU topo: Max. logical dies:       1
[    0.056288] CPU topo: Max. dies per package:   1
[    0.056291] CPU topo: Max. threads per core:   2
[    0.056292] CPU topo: Num. cores per package:    24
[    0.056293] CPU topo: Num. threads per package:  32
[    0.056293] CPU topo: Allowing 32 present CPUs plus 0 hotplug CPUs
[    0.056309] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.056312] PM: hibernation: Registered nosave memory: [mem 0x0009f000-0x000fffff]
[    0.056313] PM: hibernation: Registered nosave memory: [mem 0x26cdf000-0x26d99fff]
[    0.056315] PM: hibernation: Registered nosave memory: [mem 0x28a1e000-0x28a1efff]
[    0.056316] PM: hibernation: Registered nosave memory: [mem 0x2c229000-0x2cb28fff]
[    0.056318] PM: hibernation: Registered nosave memory: [mem 0x2e93f000-0x309defff]
[    0.056319] PM: hibernation: Registered nosave memory: [mem 0x309df000-0x3398efff]
[    0.056319] PM: hibernation: Registered nosave memory: [mem 0x3398f000-0x33afefff]
[    0.056321] PM: hibernation: Registered nosave memory: [mem 0x33b00000-0x383fffff]
[    0.056322] PM: hibernation: Registered nosave memory: [mem 0x38400000-0x38dfffff]
[    0.056322] PM: hibernation: Registered nosave memory: [mem 0x38e00000-0x407fffff]
[    0.056323] PM: hibernation: Registered nosave memory: [mem 0x40800000-0xfed1ffff]
[    0.056324] PM: hibernation: Registered nosave memory: [mem 0xfed20000-0xfed7ffff]
[    0.056324] PM: hibernation: Registered nosave memory: [mem 0xfed80000-0xffffffff]
[    0.056326] [mem 0x40800000-0xfed1ffff] available for PCI devices
[    0.056327] Booting paravirtualized kernel on bare hardware
[    0.056330] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.056347] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:32 nr_cpu_ids:32 nr_node_ids:1
[    0.058265] percpu: Embedded 88 pages/cpu s237568 r8192 d114688 u524288
[    0.058272] pcpu-alloc: s237568 r8192 d114688 u524288 alloc=1*2097152
[    0.058274] pcpu-alloc: [0] 00 01 02 03 [0] 04 05 06 07 
[    0.058279] pcpu-alloc: [0] 08 09 10 11 [0] 12 13 14 15 
[    0.058283] pcpu-alloc: [0] 16 17 18 19 [0] 20 21 22 23 
[    0.058286] pcpu-alloc: [0] 24 25 26 27 [0] 28 29 30 31 
[    0.058307] Kernel command line: BOOT_IMAGE=/@boot/vmlinuz-6.12.0-rc4 root=UUID=aa8cb093-9cb3-4cc7-b44e-4bff76ca37fb ro rootflags=subvol=@ quiet cryptdevice=UUID=1a8d8cdb-8d8f-4689-b744-8f32d2067f56:luks-1a8d8cdb-8d8f-4689-b744-8f32d2067f56 root=/dev/mapper/luks-1a8d8cdb-8d8f-4689-b744-8f32d2067f56 splash thunderbolt.dyndbg=+p vt.handoff=7
[    0.058412] Unknown kernel command line parameters "splash BOOT_IMAGE=/@boot/vmlinuz-6.12.0-rc4 cryptdevice=UUID=1a8d8cdb-8d8f-4689-b744-8f32d2067f56:luks-1a8d8cdb-8d8f-4689-b744-8f32d2067f56", will be passed to user space.
[    0.061068] Dentry cache hash table entries: 4194304 (order: 13, 33554432 bytes, linear)
[    0.062385] Inode-cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
[    0.062785] Fallback order for Node 0: 0 
[    0.062789] Built 1 zonelists, mobility grouping on.  Total pages: 8312798
[    0.062791] Policy zone: Normal
[    0.062799] mem auto-init: stack:all(zero), heap alloc:on, heap free:off
[    0.062807] software IO TLB: area num 32.
[    0.135169] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=32, Nodes=1
[    0.135249] ftrace: allocating 56190 entries in 220 pages
[    0.145298] ftrace: allocated 220 pages with 5 groups
[    0.146122] Dynamic Preempt: voluntary
[    0.146307] rcu: Preemptible hierarchical RCU implementation.
[    0.146308] rcu: 	RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=32.
[    0.146309] 	Trampoline variant of Tasks RCU enabled.
[    0.146310] 	Rude variant of Tasks RCU enabled.
[    0.146310] 	Tracing variant of Tasks RCU enabled.
[    0.146311] rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
[    0.146312] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=32
[    0.146334] RCU Tasks: Setting shift to 5 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=32.
[    0.146337] RCU Tasks Rude: Setting shift to 5 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=32.
[    0.146340] RCU Tasks Trace: Setting shift to 5 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=32.
[    0.149410] NR_IRQS: 524544, nr_irqs: 2312, preallocated irqs: 16
[    0.149775] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.150045] Console: colour dummy device 80x25
[    0.150048] printk: legacy console [tty0] enabled
[    0.150113] ACPI: Core revision 20240827
[    0.150600] hpet: HPET dysfunctional in PC10. Force disabled.
[    0.150656] APIC: Switch to symmetric I/O mode setup
[    0.150659] DMAR: Host address width 39
[    0.150660] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
[    0.150673] DMAR: dmar0: reg_base_addr fed90000 ver 4:0 cap 1c0000c40660462 ecap 29a00f0505e
[    0.150676] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
[    0.150682] DMAR: dmar1: reg_base_addr fed91000 ver 5:0 cap d2008c40660462 ecap f050da
[    0.150684] DMAR: RMRR base: 0x0000003c000000 end: 0x000000407fffff
[    0.150688] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
[    0.150690] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
[    0.150691] DMAR-IR: Queued invalidation will be enabled to support x2apic and Intr-remapping.
[    0.152605] DMAR-IR: Enabled IRQ remapping in x2apic mode
[    0.152608] x2apic enabled
[    0.152678] APIC: Switched APIC routing to: cluster x2apic
[    0.157474] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x22df1149949, max_idle_ns: 440795312789 ns
[    0.157482] Calibrating delay loop (skipped), value calculated using timer frequency.. 4838.40 BogoMIPS (lpj=2419200)
[    0.157552] CPU0: Thermal monitoring enabled (TM1)
[    0.157554] x86/cpu: User Mode Instruction Prevention (UMIP) activated
[    0.157716] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[    0.157717] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[    0.157721] process: using mwait in idle threads
[    0.157724] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.157727] Spectre V2 : Mitigation: Enhanced / Automatic IBRS
[    0.157728] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.157729] Spectre V2 : Spectre v2 / PBRSB-eIBRS: Retire a single CALL on VMEXIT
[    0.157731] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
[    0.157733] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
[    0.157735] Register File Data Sampling: Mitigation: Clear Register File
[    0.157751] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.157753] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.157754] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.157755] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys User registers'
[    0.157756] x86/fpu: Supporting XSAVE feature 0x800: 'Control-flow User registers'
[    0.157758] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.157759] x86/fpu: xstate_offset[9]:  832, xstate_sizes[9]:    8
[    0.157761] x86/fpu: xstate_offset[11]:  840, xstate_sizes[11]:   16
[    0.157762] x86/fpu: Enabled xstate features 0xa07, context size is 856 bytes, using 'compacted' format.
[    0.158479] Freeing SMP alternatives memory: 48K
[    0.158479] pid_max: default: 32768 minimum: 301
[    0.158479] LSM: initializing lsm=lockdown,capability,landlock,yama,apparmor,ima,evm
[    0.158479] landlock: Up and running.
[    0.158479] Yama: becoming mindful.
[    0.158479] AppArmor: AppArmor initialized
[    0.158479] Mount-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.158479] Mountpoint-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.158479] smpboot: CPU0: Intel(R) Core(TM) i9-14900HX (family: 0x6, model: 0xb7, stepping: 0x1)
[    0.158479] Performance Events: XSAVE Architectural LBR, PEBS fmt4+-baseline,  AnyThread deprecated, Alderlake Hybrid events, 32-deep LBR, full-width counters, Intel PMU driver.
[    0.158479] core: cpu_core PMU driver: 
[    0.158479] ... version:                5
[    0.158479] ... bit width:              48
[    0.158479] ... generic registers:      8
[    0.158479] ... value mask:             0000ffffffffffff
[    0.158479] ... max period:             00007fffffffffff
[    0.158479] ... fixed-purpose events:   4
[    0.158479] ... event mask:             0001000f000000ff
[    0.158479] signal: max sigframe size: 3632
[    0.158479] Estimated ratio of average max frequency by base frequency (times 1024): 2218
[    0.158479] rcu: Hierarchical SRCU implementation.
[    0.158479] rcu: 	Max phase no-delay instances is 400.
[    0.158479] Timer migration: 2 hierarchy levels; 8 children per group; 2 crossnode level
[    0.160047] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    0.160322] smp: Bringing up secondary CPUs ...
[    0.160423] smpboot: x86: Booting SMP configuration:
[    0.160425] .... node  #0, CPUs:        #2  #4  #6  #8 #10 #12 #14 #16 #17 #18 #19 #20 #21 #22 #23 #24 #25 #26 #27 #28 #29 #30 #31
[    0.008526] core: cpu_atom PMU driver: PEBS-via-PT 
[    0.008526] ... version:                5
[    0.008526] ... bit width:              48
[    0.008526] ... generic registers:      6
[    0.008526] ... value mask:             0000ffffffffffff
[    0.008526] ... max period:             00007fffffffffff
[    0.008526] ... fixed-purpose events:   3
[    0.008526] ... event mask:             000000070000003f
[    0.200520]   #1  #3  #5  #7  #9 #11 #13 #15
[    0.218568] smp: Brought up 1 node, 32 CPUs
[    0.218568] smpboot: Total of 32 processors activated (154828.80 BogoMIPS)
[    0.219851] Memory: 32426288K/33251192K available (22528K kernel code, 4585K rwdata, 14292K rodata, 5064K init, 4492K bss, 776764K reserved, 0K cma-reserved)
[    0.220771] devtmpfs: initialized
[    0.220771] x86/mm: Memory block size: 128MB
[    0.224087] ACPI: PM: Registering ACPI NVS region [mem 0x309df000-0x3398efff] (50003968 bytes)
[    0.224639] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.224692] futex hash table entries: 8192 (order: 7, 524288 bytes, linear)
[    0.224815] pinctrl core: initialized pinctrl subsystem
[    0.225065] PM: RTC time: 16:21:13, date: 2024-10-23
[    0.225641] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.226182] DMA: preallocated 4096 KiB GFP_KERNEL pool for atomic allocations
[    0.226566] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[    0.226958] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[    0.226969] audit: initializing netlink subsys (disabled)
[    0.226981] audit: type=2000 audit(1729700472.069:1): state=initialized audit_enabled=0 res=1
[    0.226981] thermal_sys: Registered thermal governor 'fair_share'
[    0.226981] thermal_sys: Registered thermal governor 'bang_bang'
[    0.226981] thermal_sys: Registered thermal governor 'step_wise'
[    0.226981] thermal_sys: Registered thermal governor 'user_space'
[    0.226981] thermal_sys: Registered thermal governor 'power_allocator'
[    0.226981] EISA bus registered
[    0.226981] cpuidle: using governor ladder
[    0.226981] cpuidle: using governor menu
[    0.226981] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.227593] PCI: ECAM [mem 0xc0000000-0xce0fffff] (base 0xc0000000) for domain 0000 [bus 00-e0]
[    0.227608] PCI: Using configuration type 1 for base access
[    0.227766] kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
[    0.227771] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    0.227771] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
[    0.227771] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.227771] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.228627] ACPI: Added _OSI(Module Device)
[    0.228629] ACPI: Added _OSI(Processor Device)
[    0.228631] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.228633] ACPI: Added _OSI(Processor Aggregator Device)
[    0.371418] ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PC00.MHBR], AE_NOT_FOUND (20240827/psargs-332)
[    0.371432] ACPI: Ignoring error and continuing table load
[    0.371457] ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PTID.PBAR], AE_NOT_FOUND (20240827/dsfield-500)
[    0.379469] ACPI: 18 ACPI AML tables successfully acquired and loaded
[    0.398831] ACPI: USB4 _OSC: OS supports USB3+ DisplayPort+ PCIe+ XDomain+
[    0.398834] ACPI: USB4 _OSC: OS controls USB3+ DisplayPort+ PCIe+ XDomain+
[    0.400690] ACPI: Dynamic OEM Table Load:
[    0.400704] ACPI: SSDT 0xFFFF9CDB83E20800 000394 (v02 PmRef  Cpu0Cst  00003001 INTL 20200717)
[    0.402583] ACPI: Dynamic OEM Table Load:
[    0.402591] ACPI: SSDT 0xFFFF9CDB83E29000 00053F (v02 PmRef  Cpu0Ist  00003000 INTL 20200717)
[    0.404472] ACPI: Dynamic OEM Table Load:
[    0.404479] ACPI: SSDT 0xFFFF9CDB83DB1C00 0001AB (v02 PmRef  Cpu0Psd  00003000 INTL 20200717)
[    0.406262] ACPI: Dynamic OEM Table Load:
[    0.406269] ACPI: SSDT 0xFFFF9CDB83E2A000 0004B5 (v02 PmRef  Cpu0Hwp  00003000 INTL 20200717)
[    0.408671] ACPI: Dynamic OEM Table Load:
[    0.408691] ACPI: SSDT 0xFFFF9CDB83E30000 001BAF (v02 PmRef  ApIst    00003000 INTL 20200717)
[    0.411482] ACPI: Dynamic OEM Table Load:
[    0.411490] ACPI: SSDT 0xFFFF9CDB83E34000 001038 (v02 PmRef  ApHwp    00003000 INTL 20200717)
[    0.414008] ACPI: Dynamic OEM Table Load:
[    0.414017] ACPI: SSDT 0xFFFF9CDB83E36000 001349 (v02 PmRef  ApPsd    00003000 INTL 20200717)
[    0.416558] ACPI: Dynamic OEM Table Load:
[    0.416567] ACPI: SSDT 0xFFFF9CDB83E45000 000FBB (v02 PmRef  ApCst    00003000 INTL 20200717)
[    0.436196] ACPI: EC: EC started
[    0.436198] ACPI: EC: interrupt blocked
[    0.453333] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.453336] ACPI: \_SB_.PC00.LPCB.EC__: Boot DSDT EC used to handle transactions
[    0.453338] ACPI: Interpreter enabled
[    0.453429] ACPI: PM: (supports S0 S3 S4 S5)
[    0.453430] ACPI: Using IOAPIC for interrupt routing
[    0.455876] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.455877] PCI: Ignoring E820 reservations for host bridge windows
[    0.457702] ACPI: Enabled 11 GPEs in block 00 to 7F
[    0.460142] ACPI: \_SB_.PC00.PEG2.PG00: New power resource
[    0.488502] ACPI: \_SB_.PC00.XHCI.RHUB.HS14.BTRT: New power resource
[    0.488527] ACPI: \_SB_.PC00.XHCI.RHUB.HS14.DBTR: New power resource
[    0.498720] ACPI: \_SB_.PC00.CNVW.WRST: New power resource
[    0.504494] ACPI: \_SB_.PC00.RP09.PXP_: New power resource
[    0.531248] ACPI: \PIN_: New power resource
[    0.532130] ACPI: PCI Root Bridge [PC00] (domain 0000 [bus 00-e0])
[    0.532137] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
[    0.536005] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotplug PME AER PCIeCapability LTR DPC]
[    0.542157] PCI host bridge to bus 0000:00
[    0.542161] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.542163] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.542165] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.542167] pci_bus 0000:00: root bus resource [mem 0x40800000-0xbfffffff window]
[    0.542169] pci_bus 0000:00: root bus resource [mem 0x4000000000-0x7fffffffff window]
[    0.542171] pci_bus 0000:00: root bus resource [bus 00-e0]
[    0.542212] pci 0000:00:00.0: [8086:a702] type 00 class 0x060000 conventional PCI endpoint
[    0.542342] pci 0000:00:01.0: [8086:a70d] type 01 class 0x060400 PCIe Root Port
[    0.542359] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.542419] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    0.542445] pci 0000:00:01.0: PTM enabled (root), 4ns granularity
[    0.543253] pci 0000:00:01.1: [8086:a72d] type 01 class 0x060400 PCIe Root Port
[    0.543271] pci 0000:00:01.1: PCI bridge to [bus 02]
[    0.543274] pci 0000:00:01.1:   bridge window [io  0x3000-0x3fff]
[    0.543277] pci 0000:00:01.1:   bridge window [mem 0x4e000000-0x4f0fffff]
[    0.543283] pci 0000:00:01.1:   bridge window [mem 0x6000000000-0x6401ffffff 64bit pref]
[    0.543335] pci 0000:00:01.1: PME# supported from D0 D3hot D3cold
[    0.543359] pci 0000:00:01.1: PTM enabled (root), 4ns granularity
[    0.544117] pci 0000:00:02.0: [8086:a788] type 00 class 0x030000 PCIe Root Complex Integrated Endpoint
[    0.544127] pci 0000:00:02.0: BAR 0 [mem 0x6404000000-0x6404ffffff 64bit]
[    0.544134] pci 0000:00:02.0: BAR 2 [mem 0x4000000000-0x400fffffff 64bit pref]
[    0.544139] pci 0000:00:02.0: BAR 4 [io  0x4000-0x403f]
[    0.544157] pci 0000:00:02.0: DMAR: Skip IOMMU disabling for graphics
[    0.544160] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.544192] pci 0000:00:02.0: VF BAR 0 [mem 0x00000000-0x00ffffff 64bit]
[    0.544194] pci 0000:00:02.0: VF BAR 0 [mem 0x00000000-0x06ffffff 64bit]: contains BAR 0 for 7 VFs
[    0.544199] pci 0000:00:02.0: VF BAR 2 [mem 0x00000000-0x1fffffff 64bit pref]
[    0.544201] pci 0000:00:02.0: VF BAR 2 [mem 0x00000000-0xdfffffff 64bit pref]: contains BAR 2 for 7 VFs
[    0.544385] pci 0000:00:04.0: [8086:a71d] type 00 class 0x118000 conventional PCI endpoint
[    0.544402] pci 0000:00:04.0: BAR 0 [mem 0x6405200000-0x640521ffff 64bit]
[    0.544766] pci 0000:00:08.0: [8086:a74f] type 00 class 0x088000 conventional PCI endpoint
[    0.544777] pci 0000:00:08.0: BAR 0 [mem 0x6405241000-0x6405241fff 64bit]
[    0.544886] pci 0000:00:0a.0: [8086:a77d] type 00 class 0x118000 PCIe Root Complex Integrated Endpoint
[    0.544895] pci 0000:00:0a.0: BAR 0 [mem 0x6405220000-0x6405227fff 64bit]
[    0.544914] pci 0000:00:0a.0: enabling Extended Tags
[    0.545024] pci 0000:00:0e.0: [8086:a77f] type 00 class 0x010400 PCIe Root Complex Integrated Endpoint
[    0.545039] pci 0000:00:0e.0: BAR 0 [mem 0x6402000000-0x6403ffffff 64bit]
[    0.545046] pci 0000:00:0e.0: BAR 2 [mem 0x4c000000-0x4dffffff]
[    0.545062] pci 0000:00:0e.0: BAR 4 [mem 0x6405100000-0x64051fffff 64bit]
[    0.545397] pci 0000:00:14.0: [8086:7a60] type 00 class 0x0c0330 conventional PCI endpoint
[    0.545418] pci 0000:00:14.0: BAR 0 [mem 0x4f380000-0x4f38ffff 64bit]
[    0.545501] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.546114] pci 0000:00:14.2: [8086:7a27] type 00 class 0x050000 conventional PCI endpoint
[    0.546138] pci 0000:00:14.2: BAR 0 [mem 0x6405238000-0x640523bfff 64bit]
[    0.546155] pci 0000:00:14.2: BAR 2 [mem 0x6405240000-0x6405240fff 64bit]
[    0.546311] pci 0000:00:14.3: [8086:7a70] type 00 class 0x028000 PCIe Root Complex Integrated Endpoint
[    0.546357] pci 0000:00:14.3: BAR 0 [mem 0x6405234000-0x6405237fff 64bit]
[    0.546547] pci 0000:00:14.3: PME# supported from D0 D3hot D3cold
[    0.546968] pci 0000:00:15.0: [8086:7a4c] type 00 class 0x0c8000 conventional PCI endpoint
[    0.547043] pci 0000:00:15.0: BAR 0 [mem 0x00000000-0x00000fff 64bit]
[    0.547623] pci 0000:00:15.1: [8086:7a4d] type 00 class 0x0c8000 conventional PCI endpoint
[    0.547692] pci 0000:00:15.1: BAR 0 [mem 0x00000000-0x00000fff 64bit]
[    0.548159] pci 0000:00:16.0: [8086:7a68] type 00 class 0x078000 conventional PCI endpoint
[    0.548182] pci 0000:00:16.0: BAR 0 [mem 0x640523d000-0x640523dfff 64bit]
[    0.548266] pci 0000:00:16.0: PME# supported from D3hot
[    0.548859] pci 0000:00:1c.0: [8086:7a3e] type 01 class 0x060400 PCIe Root Port
[    0.548892] pci 0000:00:1c.0: PCI bridge to [bus 03]
[    0.548898] pci 0000:00:1c.0:   bridge window [mem 0x4f100000-0x4f2fffff]
[    0.548994] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.549035] pci 0000:00:1c.0: PTM enabled (root), 4ns granularity
[    0.549903] pci 0000:00:1d.0: [8086:7a30] type 01 class 0x060400 PCIe Root Port
[    0.549934] pci 0000:00:1d.0: PCI bridge to [bus 04-54]
[    0.549941] pci 0000:00:1d.0:   bridge window [mem 0x44000000-0x4bffffff]
[    0.549952] pci 0000:00:1d.0:   bridge window [mem 0x6410000000-0x74100fffff 64bit pref]
[    0.550096] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    0.551015] pci 0000:00:1f.0: [8086:7a0c] type 00 class 0x060100 conventional PCI endpoint
[    0.551447] pci 0000:00:1f.3: [8086:7a50] type 00 class 0x040300 conventional PCI endpoint
[    0.551489] pci 0000:00:1f.3: BAR 0 [mem 0x6405230000-0x6405233fff 64bit]
[    0.551544] pci 0000:00:1f.3: BAR 4 [mem 0x6405000000-0x64050fffff 64bit]
[    0.551652] pci 0000:00:1f.3: PME# supported from D3hot D3cold
[    0.551757] pci 0000:00:1f.4: [8086:7a23] type 00 class 0x0c0500 conventional PCI endpoint
[    0.551783] pci 0000:00:1f.4: BAR 0 [mem 0x640523c000-0x640523c0ff 64bit]
[    0.551814] pci 0000:00:1f.4: BAR 4 [io  0xefa0-0xefbf]
[    0.552129] pci 0000:00:1f.5: [8086:7a24] type 00 class 0x0c8000 conventional PCI endpoint
[    0.552150] pci 0000:00:1f.5: BAR 0 [mem 0xfe010000-0xfe010fff]
[    0.552299] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.552346] acpiphp: Slot [1] registered
[    0.552363] pci 0000:02:00.0: [10de:27e0] type 00 class 0x030000 PCIe Legacy Endpoint
[    0.552373] pci 0000:02:00.0: BAR 0 [mem 0x4e000000-0x4effffff]
[    0.552380] pci 0000:02:00.0: BAR 1 [mem 0x6000000000-0x63ffffffff 64bit pref]
[    0.552388] pci 0000:02:00.0: BAR 3 [mem 0x6400000000-0x6401ffffff 64bit pref]
[    0.552393] pci 0000:02:00.0: BAR 5 [io  0x3000-0x307f]
[    0.552398] pci 0000:02:00.0: ROM [mem 0xfff80000-0xffffffff pref]
[    0.552452] pci 0000:02:00.0: PME# supported from D0 D3hot
[    0.552522] pci 0000:02:00.0: 126.024 Gb/s available PCIe bandwidth, limited by 16.0 GT/s PCIe x8 link at 0000:00:01.1 (capable of 252.048 Gb/s with 16.0 GT/s PCIe x16 link)
[    0.552796] pci 0000:02:00.1: [10de:22bc] type 00 class 0x040300 PCIe Endpoint
[    0.552806] pci 0000:02:00.1: BAR 0 [mem 0x4f000000-0x4f003fff]
[    0.552935] pci 0000:00:01.1: PCI bridge to [bus 02]
[    0.553073] pci 0000:03:00.0: [8086:3102] type 00 class 0x020000 PCIe Endpoint
[    0.553098] pci 0000:03:00.0: BAR 0 [mem 0x4f100000-0x4f1fffff]
[    0.553137] pci 0000:03:00.0: BAR 3 [mem 0x4f200000-0x4f203fff]
[    0.553295] pci 0000:03:00.0: PME# supported from D0 D3hot D3cold
[    0.553572] pci 0000:00:1c.0: PCI bridge to [bus 03]
[    0.553677] pci 0000:04:00.0: [8086:5780] type 01 class 0x060400 PCIe Switch Upstream Port
[    0.553719] pci 0000:04:00.0: PCI bridge to [bus 05-54]
[    0.553730] pci 0000:04:00.0:   bridge window [mem 0x44000000-0x4befffff]
[    0.553744] pci 0000:04:00.0:   bridge window [mem 0x6410000000-0x74100fffff 64bit pref]
[    0.553761] pci 0000:04:00.0: enabling Extended Tags
[    0.553898] pci 0000:04:00.0: supports D1 D2
[    0.553899] pci 0000:04:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.554303] pci 0000:00:1d.0: PCI bridge to [bus 04-54]
[    0.554431] pci 0000:05:00.0: [8086:5780] type 01 class 0x060400 PCIe Switch Downstream Port
[    0.554472] pci 0000:05:00.0: PCI bridge to [bus 06]
[    0.554496] pci 0000:05:00.0:   bridge window [mem 0x7410000000-0x74100fffff 64bit pref]
[    0.554515] pci 0000:05:00.0: enabling Extended Tags
[    0.554644] pci 0000:05:00.0: supports D1 D2
[    0.554645] pci 0000:05:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.554962] pci 0000:05:01.0: [8086:5780] type 01 class 0x060400 PCIe Switch Downstream Port
[    0.555003] pci 0000:05:01.0: PCI bridge to [bus 07-2c]
[    0.555015] pci 0000:05:01.0:   bridge window [mem 0x48000000-0x4befffff]
[    0.555045] pci 0000:05:01.0: enabling Extended Tags
[    0.555183] pci 0000:05:01.0: supports D1 D2
[    0.555184] pci 0000:05:01.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.555502] pci 0000:05:02.0: [8086:5780] type 01 class 0x060400 PCIe Switch Downstream Port
[    0.555543] pci 0000:05:02.0: PCI bridge to [bus 2d]
[    0.555554] pci 0000:05:02.0:   bridge window [mem 0x47f00000-0x47ffffff]
[    0.555585] pci 0000:05:02.0: enabling Extended Tags
[    0.555713] pci 0000:05:02.0: supports D1 D2
[    0.555714] pci 0000:05:02.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.556030] pci 0000:05:03.0: [8086:5780] type 01 class 0x060400 PCIe Switch Downstream Port
[    0.556071] pci 0000:05:03.0: PCI bridge to [bus 2e-54]
[    0.556083] pci 0000:05:03.0:   bridge window [mem 0x44000000-0x47efffff]
[    0.556113] pci 0000:05:03.0: enabling Extended Tags
[    0.556250] pci 0000:05:03.0: supports D1 D2
[    0.556252] pci 0000:05:03.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.556577] pci 0000:04:00.0: PCI bridge to [bus 05-54]
[    0.556685] pci 0000:06:00.0: [8086:5781] type 00 class 0x0c0340 PCIe Endpoint
[    0.556713] pci 0000:06:00.0: BAR 0 [mem 0x7410000000-0x741003ffff 64bit pref]
[    0.556731] pci 0000:06:00.0: BAR 2 [mem 0x7410040000-0x7410040fff 64bit pref]
[    0.556773] pci 0000:06:00.0: enabling Extended Tags
[    0.556888] pci 0000:06:00.0: supports D1 D2
[    0.556889] pci 0000:06:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.557160] pci 0000:05:00.0: PCI bridge to [bus 06]
[    0.557222] pci 0000:05:01.0: PCI bridge to [bus 07-2c]
[    0.557330] pci 0000:2d:00.0: [8086:5782] type 00 class 0x0c0330 PCIe Endpoint
[    0.557354] pci 0000:2d:00.0: BAR 0 [mem 0x47f00000-0x47f0ffff 64bit]
[    0.557403] pci 0000:2d:00.0: enabling Extended Tags
[    0.557485] pci 0000:2d:00.0: PME# supported from D3hot D3cold
[    0.557524] pci 0000:2d:00.0: 8.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:05:02.0 (capable of 31.504 Gb/s with 8.0 GT/s PCIe x4 link)
[    0.557667] pci 0000:05:02.0: PCI bridge to [bus 2d]
[    0.557741] pci 0000:05:03.0: PCI bridge to [bus 2e-54]
[    0.582968] ACPI: EC: interrupt unblocked
[    0.582970] ACPI: EC: event unblocked
[    0.582986] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.582988] ACPI: EC: GPE=0x6e
[    0.582989] ACPI: \_SB_.PC00.LPCB.EC__: Boot DSDT EC initialization complete
[    0.582991] ACPI: \_SB_.PC00.LPCB.EC__: EC: Used to handle transactions and events
[    0.583499] iommu: Default domain type: Translated
[    0.583499] iommu: DMA domain TLB invalidation policy: lazy mode
[    0.583683] SCSI subsystem initialized
[    0.583697] libata version 3.00 loaded.
[    0.583697] ACPI: bus type USB registered
[    0.583697] usbcore: registered new interface driver usbfs
[    0.583697] usbcore: registered new interface driver hub
[    0.583697] usbcore: registered new device driver usb
[    0.583697] pps_core: LinuxPPS API ver. 1 registered
[    0.583697] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.583697] PTP clock support registered
[    0.583697] EDAC MC: Ver: 3.0.0
[    0.584493] efivars: Registered efivars operations
[    0.584819] NetLabel: Initializing
[    0.584820] NetLabel:  domain hash size = 128
[    0.584821] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.584843] NetLabel:  unlabeled traffic allowed by default
[    0.584865] mctp: management component transport protocol core
[    0.584865] NET: Registered PF_MCTP protocol family
[    0.584865] PCI: Using ACPI for IRQ routing
[    0.600769] PCI: pci_cache_line_size set to 64 bytes
[    0.600919] pci 0000:00:1f.5: BAR 0 [mem 0xfe010000-0xfe010fff]: can't claim; no compatible bridge window
[    0.601066] e820: reserve RAM buffer [mem 0x0009f000-0x0009ffff]
[    0.601068] e820: reserve RAM buffer [mem 0x26cdf000-0x27ffffff]
[    0.601069] e820: reserve RAM buffer [mem 0x28a1e000-0x2bffffff]
[    0.601070] e820: reserve RAM buffer [mem 0x2c229000-0x2fffffff]
[    0.601072] e820: reserve RAM buffer [mem 0x2e93f000-0x2fffffff]
[    0.601073] e820: reserve RAM buffer [mem 0x33b00000-0x33ffffff]
[    0.601074] e820: reserve RAM buffer [mem 0x8bf800000-0x8bfffffff]
[    0.601497] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    0.601497] pci 0000:00:02.0: vgaarb: bridge control possible
[    0.601497] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    0.601497] pci 0000:02:00.0: vgaarb: bridge control possible
[    0.601497] pci 0000:02:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
[    0.601498] vgaarb: loaded
[    0.601607] clocksource: Switched to clocksource tsc-early
[    0.602081] VFS: Disk quotas dquot_6.6.0
[    0.602093] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.602224] AppArmor: AppArmor Filesystem Enabled
[    0.602257] pnp: PnP ACPI init
[    0.602545] pnp 00:00: disabling [io  0x3322-0x3323] because it overlaps 0000:00:01.1 BAR 13 [io  0x3000-0x3fff]
[    0.602770] system 00:02: [io  0x1854-0x1857] has been reserved
[    0.619422] pnp 00:05: disabling [mem 0xc0000000-0xcfffffff] because it overlaps 0000:00:02.0 BAR 9 [mem 0x00000000-0xdfffffff 64bit pref]
[    0.619461] system 00:05: [mem 0xfedc0000-0xfedc7fff] has been reserved
[    0.619464] system 00:05: [mem 0xfeda0000-0xfeda0fff] has been reserved
[    0.619466] system 00:05: [mem 0xfeda1000-0xfeda1fff] has been reserved
[    0.619468] system 00:05: [mem 0xfed20000-0xfed7ffff] could not be reserved
[    0.619470] system 00:05: [mem 0xfed90000-0xfed93fff] could not be reserved
[    0.619472] system 00:05: [mem 0xfed45000-0xfed8ffff] could not be reserved
[    0.619474] system 00:05: [mem 0xfee00000-0xfeefffff] has been reserved
[    0.619955] system 00:06: [io  0x2000-0x20fe] has been reserved
[    0.621420] pnp: PnP ACPI: found 8 devices
[    0.627790] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.627874] NET: Registered PF_INET protocol family
[    0.628247] IP idents hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.647358] tcp_listen_portaddr_hash hash table entries: 16384 (order: 6, 262144 bytes, linear)
[    0.647402] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    0.647726] TCP established hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.648267] TCP bind hash table entries: 65536 (order: 9, 2097152 bytes, linear)
[    0.648375] TCP: Hash tables configured (established 262144 bind 65536)
[    0.648543] MPTCP token hash table entries: 32768 (order: 7, 786432 bytes, linear)
[    0.648681] UDP hash table entries: 16384 (order: 7, 524288 bytes, linear)
[    0.648807] UDP-Lite hash table entries: 16384 (order: 7, 524288 bytes, linear)
[    0.648912] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.648920] NET: Registered PF_XDP protocol family
[    0.648923] pci 0000:02:00.0: ROM [mem 0xfff80000-0xffffffff pref]: can't claim; no compatible bridge window
[    0.648930] pci_bus 0000:00: max bus depth: 3 pci_try_num: 4
[    0.648944] pci 0000:00:02.0: VF BAR 2 [mem 0x4020000000-0x40ffffffff 64bit pref]: assigned
[    0.648949] pci 0000:00:02.0: VF BAR 0 [mem 0x4010000000-0x4016ffffff 64bit]: assigned
[    0.648952] pci 0000:00:15.0: BAR 0 [mem 0x4017000000-0x4017000fff 64bit]: assigned
[    0.649013] pci 0000:00:15.1: BAR 0 [mem 0x4017001000-0x4017001fff 64bit]: assigned
[    0.649072] pci 0000:00:1d.0: bridge window [io  0x5000-0x7fff]: assigned
[    0.649074] pci 0000:00:1f.5: BAR 0 [mem 0x40800000-0x40800fff]: assigned
[    0.649085] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.649093] pci 0000:02:00.0: ROM [mem 0x4f080000-0x4f0fffff pref]: assigned
[    0.649095] pci 0000:00:01.1: PCI bridge to [bus 02]
[    0.649096] pci 0000:00:01.1:   bridge window [io  0x3000-0x3fff]
[    0.649100] pci 0000:00:01.1:   bridge window [mem 0x4e000000-0x4f0fffff]
[    0.649102] pci 0000:00:01.1:   bridge window [mem 0x6000000000-0x6401ffffff 64bit pref]
[    0.649107] pci 0000:00:1c.0: PCI bridge to [bus 03]
[    0.649117] pci 0000:00:1c.0:   bridge window [mem 0x4f100000-0x4f2fffff]
[    0.649126] pci 0000:04:00.0: bridge window [io  0x5000-0x6fff]: assigned
[    0.649129] pci 0000:05:01.0: bridge window [mem 0x6410000000-0x64101fffff 64bit pref]: assigned
[    0.649131] pci 0000:05:03.0: bridge window [mem 0x6410200000-0x64103fffff 64bit pref]: assigned
[    0.649132] pci 0000:05:01.0: bridge window [io  0x5000-0x5fff]: assigned
[    0.649134] pci 0000:05:03.0: bridge window [io  0x6000-0x6fff]: assigned
[    0.649136] pci 0000:05:00.0: PCI bridge to [bus 06]
[    0.649156] pci 0000:05:00.0:   bridge window [mem 0x7410000000-0x74100fffff 64bit pref]
[    0.649164] pci 0000:05:01.0: PCI bridge to [bus 07-2c]
[    0.649166] pci 0000:05:01.0:   bridge window [io  0x5000-0x5fff]
[    0.649172] pci 0000:05:01.0:   bridge window [mem 0x48000000-0x4befffff]
[    0.649176] pci 0000:05:01.0:   bridge window [mem 0x6410000000-0x64101fffff 64bit pref]
[    0.649184] pci 0000:05:02.0: PCI bridge to [bus 2d]
[    0.649189] pci 0000:05:02.0:   bridge window [mem 0x47f00000-0x47ffffff]
[    0.649199] pci 0000:05:03.0: PCI bridge to [bus 2e-54]
[    0.649202] pci 0000:05:03.0:   bridge window [io  0x6000-0x6fff]
[    0.649208] pci 0000:05:03.0:   bridge window [mem 0x44000000-0x47efffff]
[    0.649212] pci 0000:05:03.0:   bridge window [mem 0x6410200000-0x64103fffff 64bit pref]
[    0.649219] pci 0000:04:00.0: PCI bridge to [bus 05-54]
[    0.649221] pci 0000:04:00.0:   bridge window [io  0x5000-0x6fff]
[    0.649227] pci 0000:04:00.0:   bridge window [mem 0x44000000-0x4befffff]
[    0.649231] pci 0000:04:00.0:   bridge window [mem 0x6410000000-0x74100fffff 64bit pref]
[    0.649238] pci 0000:00:1d.0: PCI bridge to [bus 04-54]
[    0.649240] pci 0000:00:1d.0:   bridge window [io  0x5000-0x7fff]
[    0.649245] pci 0000:00:1d.0:   bridge window [mem 0x44000000-0x4bffffff]
[    0.649248] pci 0000:00:1d.0:   bridge window [mem 0x6410000000-0x74100fffff 64bit pref]
[    0.649254] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.649256] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.649258] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    0.649259] pci_bus 0000:00: resource 7 [mem 0x40800000-0xbfffffff window]
[    0.649261] pci_bus 0000:00: resource 8 [mem 0x4000000000-0x7fffffffff window]
[    0.649262] pci_bus 0000:02: resource 0 [io  0x3000-0x3fff]
[    0.649264] pci_bus 0000:02: resource 1 [mem 0x4e000000-0x4f0fffff]
[    0.649265] pci_bus 0000:02: resource 2 [mem 0x6000000000-0x6401ffffff 64bit pref]
[    0.649267] pci_bus 0000:03: resource 1 [mem 0x4f100000-0x4f2fffff]
[    0.649269] pci_bus 0000:04: resource 0 [io  0x5000-0x7fff]
[    0.649270] pci_bus 0000:04: resource 1 [mem 0x44000000-0x4bffffff]
[    0.649271] pci_bus 0000:04: resource 2 [mem 0x6410000000-0x74100fffff 64bit pref]
[    0.649273] pci_bus 0000:05: resource 0 [io  0x5000-0x6fff]
[    0.649274] pci_bus 0000:05: resource 1 [mem 0x44000000-0x4befffff]
[    0.649275] pci_bus 0000:05: resource 2 [mem 0x6410000000-0x74100fffff 64bit pref]
[    0.649277] pci_bus 0000:06: resource 2 [mem 0x7410000000-0x74100fffff 64bit pref]
[    0.649278] pci_bus 0000:07: resource 0 [io  0x5000-0x5fff]
[    0.649280] pci_bus 0000:07: resource 1 [mem 0x48000000-0x4befffff]
[    0.649281] pci_bus 0000:07: resource 2 [mem 0x6410000000-0x64101fffff 64bit pref]
[    0.649282] pci_bus 0000:2d: resource 1 [mem 0x47f00000-0x47ffffff]
[    0.649284] pci_bus 0000:2e: resource 0 [io  0x6000-0x6fff]
[    0.649285] pci_bus 0000:2e: resource 1 [mem 0x44000000-0x47efffff]
[    0.649287] pci_bus 0000:2e: resource 2 [mem 0x6410200000-0x64103fffff 64bit pref]
[    0.651495] pci 0000:02:00.1: extending delay after power-on from D3hot to 20 msec
[    0.651523] pci 0000:02:00.1: D0 power state depends on 0000:02:00.0
[    0.652017] pci 0000:2d:00.0: enabling device (0000 -> 0002)
[    0.652056] PCI: CLS 64 bytes, default 64
[    0.652096] DMAR: No ATSR found
[    0.652097] DMAR: No SATC found
[    0.652098] DMAR: IOMMU feature fl1gp_support inconsistent
[    0.652099] DMAR: IOMMU feature pgsel_inv inconsistent
[    0.652100] DMAR: IOMMU feature nwfs inconsistent
[    0.652101] DMAR: IOMMU feature dit inconsistent
[    0.652102] DMAR: IOMMU feature sc_support inconsistent
[    0.652103] DMAR: IOMMU feature dev_iotlb_support inconsistent
[    0.652104] DMAR: dmar0: Using Queued invalidation
[    0.652108] DMAR: dmar1: Using Queued invalidation
[    0.652178] Trying to unpack rootfs image as initramfs...
[    0.652512] pci 0000:00:02.0: Adding to iommu group 0
[    0.653353] pci 0000:00:00.0: Adding to iommu group 1
[    0.653368] pci 0000:00:01.0: Adding to iommu group 2
[    0.653382] pci 0000:00:01.1: Adding to iommu group 3
[    0.653395] pci 0000:00:04.0: Adding to iommu group 4
[    0.653406] pci 0000:00:08.0: Adding to iommu group 5
[    0.653416] pci 0000:00:0a.0: Adding to iommu group 6
[    0.653428] pci 0000:00:0e.0: Adding to iommu group 7
[    0.653450] pci 0000:00:14.0: Adding to iommu group 8
[    0.653461] pci 0000:00:14.2: Adding to iommu group 8
[    0.653472] pci 0000:00:14.3: Adding to iommu group 9
[    0.653493] pci 0000:00:15.0: Adding to iommu group 10
[    0.653503] pci 0000:00:15.1: Adding to iommu group 10
[    0.653520] pci 0000:00:16.0: Adding to iommu group 11
[    0.653544] pci 0000:00:1c.0: Adding to iommu group 12
[    0.653570] pci 0000:00:1d.0: Adding to iommu group 13
[    0.653600] pci 0000:00:1f.0: Adding to iommu group 14
[    0.653612] pci 0000:00:1f.3: Adding to iommu group 14
[    0.653624] pci 0000:00:1f.4: Adding to iommu group 14
[    0.653635] pci 0000:00:1f.5: Adding to iommu group 14
[    0.653656] pci 0000:02:00.0: Adding to iommu group 15
[    0.653670] pci 0000:02:00.1: Adding to iommu group 15
[    0.653690] pci 0000:03:00.0: Adding to iommu group 16
[    0.653722] pci 0000:04:00.0: Adding to iommu group 17
[    0.653742] pci 0000:05:00.0: Adding to iommu group 18
[    0.653764] pci 0000:05:01.0: Adding to iommu group 19
[    0.653778] pci 0000:05:02.0: Adding to iommu group 20
[    0.653792] pci 0000:05:03.0: Adding to iommu group 21
[    0.653818] pci 0000:06:00.0: Adding to iommu group 22
[    0.653843] pci 0000:2d:00.0: Adding to iommu group 23
[    0.659492] DMAR: Intel(R) Virtualization Technology for Directed I/O
[    0.659496] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.659498] software IO TLB: mapped [mem 0x0000000022ca0000-0x0000000026ca0000] (64MB)
[    0.664446] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x22df1149949, max_idle_ns: 440795312789 ns
[    0.664496] clocksource: Switched to clocksource tsc
[    0.665827] Initialise system trusted keyrings
[    0.665838] Key type blacklist registered
[    0.665906] workingset: timestamp_bits=36 max_order=23 bucket_order=0
[    0.665916] zbud: loaded
[    0.666259] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.666399] fuse: init (API version 7.41)
[    0.666597] integrity: Platform Keyring initialized
[    0.666603] integrity: Machine keyring initialized
[    0.680370] Key type asymmetric registered
[    0.680373] Asymmetric key parser 'x509' registered
[    0.680402] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 243)
[    0.680479] io scheduler mq-deadline registered
[    0.681381] ledtrig-cpu: registered to indicate activity on CPUs
[    0.681748] pcieport 0000:00:01.0: PME: Signaling with IRQ 122
[    0.682041] pcieport 0000:00:01.1: PME: Signaling with IRQ 123
[    0.682377] pcieport 0000:00:1c.0: PME: Signaling with IRQ 124
[    0.682498] pcieport 0000:00:1c.0: AER: enabled with IRQ 124
[    0.682694] pcieport 0000:00:1d.0: PME: Signaling with IRQ 125
[    0.682781] pcieport 0000:00:1d.0: AER: enabled with IRQ 125
[    0.682815] pcieport 0000:00:1d.0: pciehp: Slot #8 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
[    0.683756] pcieport 0000:05:01.0: pciehp: Slot #1 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
[    0.684389] pcieport 0000:05:03.0: pciehp: Slot #3 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
[    0.684634] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    0.684980] Monitor-Mwait will be used to enter C-1 state
[    0.684996] Monitor-Mwait will be used to enter C-2 state
[    0.685007] Monitor-Mwait will be used to enter C-3 state
[    0.688549] ACPI: AC: AC Adapter [AC] (on-line)
[    0.688628] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    0.688682] ACPI: button: Power Button [PWRB]
[    0.688716] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input1
[    0.688753] ACPI: button: Sleep Button [SLPB]
[    0.688791] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input2
[    0.688825] ACPI: button: Lid Switch [LID0]
[    0.688860] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
[    0.688903] ACPI: button: Power Button [PWRF]
[    0.779865] thermal LNXTHERM:00: registered as thermal_zone0
[    0.779870] ACPI: thermal: Thermal Zone [TZ0] (25 C)
[    0.780326] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    0.781231] ACPI: battery: Slot [BAT0] (battery present)
[    0.783163] hpet_acpi_add: no address or irqs in _CRS
[    0.783198] Linux agpgart interface v0.103
[    0.785282] tpm_tis IFX1523:00: 2.0 TPM (device-id 0x1D, rev-id 54)
[    0.899863] ACPI: bus type drm_connector registered
[    0.907424] loop: module loaded
[    0.907703] tun: Universal TUN/TAP device driver, 1.6
[    0.907737] PPP generic driver version 2.4.2
[    0.908056] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    0.908062] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
[    0.909271] xhci_hcd 0000:00:14.0: hcc params 0x20007fc1 hci version 0x120 quirks 0x0000000200009810
[    0.909705] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    0.909708] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
[    0.909711] xhci_hcd 0000:00:14.0: Host supports USB 3.2 Enhanced SuperSpeed
[    0.909762] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.12
[    0.909765] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.909767] usb usb1: Product: xHCI Host Controller
[    0.909768] usb usb1: Manufacturer: Linux 6.12.0-rc4 xhci-hcd
[    0.909770] usb usb1: SerialNumber: 0000:00:14.0
[    0.909907] hub 1-0:1.0: USB hub found
[    0.909936] hub 1-0:1.0: 16 ports detected
[    0.913653] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.12
[    0.913656] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.913658] usb usb2: Product: xHCI Host Controller
[    0.913659] usb usb2: Manufacturer: Linux 6.12.0-rc4 xhci-hcd
[    0.913661] usb usb2: SerialNumber: 0000:00:14.0
[    0.913730] hub 2-0:1.0: USB hub found
[    0.913752] hub 2-0:1.0: 10 ports detected
[    0.915869] xhci_hcd 0000:2d:00.0: xHCI Host Controller
[    0.915873] xhci_hcd 0000:2d:00.0: new USB bus registered, assigned bus number 3
[    0.917072] xhci_hcd 0000:2d:00.0: hcc params 0x20007fc1 hci version 0x120 quirks 0x0000000200009810
[    0.917467] xhci_hcd 0000:2d:00.0: xHCI Host Controller
[    0.917469] xhci_hcd 0000:2d:00.0: new USB bus registered, assigned bus number 4
[    0.917472] xhci_hcd 0000:2d:00.0: Host supports USB 3.2 Enhanced SuperSpeed
[    0.917505] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.12
[    0.917507] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.917509] usb usb3: Product: xHCI Host Controller
[    0.917510] usb usb3: Manufacturer: Linux 6.12.0-rc4 xhci-hcd
[    0.917511] usb usb3: SerialNumber: 0000:2d:00.0
[    0.917594] hub 3-0:1.0: USB hub found
[    0.917607] hub 3-0:1.0: 2 ports detected
[    0.918825] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.12
[    0.918827] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.918829] usb usb4: Product: xHCI Host Controller
[    0.918830] usb usb4: Manufacturer: Linux 6.12.0-rc4 xhci-hcd
[    0.918831] usb usb4: SerialNumber: 0000:2d:00.0
[    0.918903] hub 4-0:1.0: USB hub found
[    0.918917] hub 4-0:1.0: 2 ports detected
[    0.920706] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[    0.926688] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.926692] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.926919] mousedev: PS/2 mouse device common for all mice
[    0.927126] rtc_cmos 00:01: RTC can wake from S4
[    0.927910] rtc_cmos 00:01: registered as rtc0
[    0.928077] rtc_cmos 00:01: setting system clock to 2024-10-23T16:21:13 UTC (1729700473)
[    0.928114] rtc_cmos 00:01: alarms up to one month, y3k, 242 bytes nvram
[    0.928120] i2c_dev: i2c /dev entries driver
[    0.930853] device-mapper: core: CONFIG_IMA_DISABLE_HTABLE is disabled. Duplicate IMA measurements will not be recorded in the IMA log.
[    0.930870] device-mapper: uevent: version 1.0.3
[    0.930917] device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) initialised: dm-devel@lists.linux.dev
[    0.930935] platform eisa.0: Probing EISA bus 0
[    0.930940] platform eisa.0: EISA: Cannot allocate resource for mainboard
[    0.930942] platform eisa.0: Cannot allocate resource for EISA slot 1
[    0.930943] platform eisa.0: Cannot allocate resource for EISA slot 2
[    0.930945] platform eisa.0: Cannot allocate resource for EISA slot 3
[    0.930946] platform eisa.0: Cannot allocate resource for EISA slot 4
[    0.930947] platform eisa.0: Cannot allocate resource for EISA slot 5
[    0.930948] platform eisa.0: Cannot allocate resource for EISA slot 6
[    0.930949] platform eisa.0: Cannot allocate resource for EISA slot 7
[    0.930950] platform eisa.0: Cannot allocate resource for EISA slot 8
[    0.930951] platform eisa.0: EISA: Detected 0 cards
[    0.930954] intel_pstate: Intel P-state driver initializing
[    0.934504] intel_pstate: HWP enabled
[    0.934665] [drm] Initialized simpledrm 1.0.0 for simple-framebuffer.0 on minor 0
[    0.936954] fbcon: Deferring console take-over
[    0.936955] simple-framebuffer simple-framebuffer.0: [drm] fb0: simpledrmdrmfb frame buffer device
[    0.937030] drop_monitor: Initializing network drop monitor service
[    0.937056] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input5
[    0.937126] NET: Registered PF_INET6 protocol family
[    0.987480] Freeing initrd memory: 74684K
[    0.994163] Segment Routing with IPv6
[    0.994178] In-situ OAM (IOAM) with IPv6
[    0.994202] NET: Registered PF_PACKET protocol family
[    0.994551] Key type dns_resolver registered
[    1.000160] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    1.002082] microcode: Current revision: 0x00000129
[    1.004065] IPI shorthand broadcast: enabled
[    1.005069] sched_clock: Marking stable (997000584, 7526151)->(1076374261, -71847526)
[    1.005727] registered taskstats version 1
[    1.009235] Loading compiled-in X.509 certificates
[    1.009734] Loaded X.509 cert 'Build time autogenerated kernel key: 84d395bd31cee4a05297ad9c1b9c63dc2b3e4d3d'
[    1.013192] Demotion targets for Node 0: null
[    1.013350] Key type .fscrypt registered
[    1.013352] Key type fscrypt-provisioning registered
[    1.013429] Key type trusted registered
[    1.019503] cryptd: module verification failed: signature and/or required key missing - tainting kernel
[    1.020279] cryptd: max_cpu_qlen set to 1000
[    1.021127] AES CTR mode by8 optimization enabled
[    1.031112] Key type encrypted registered
[    1.031118] AppArmor: AppArmor sha256 policy hashing enabled
[    1.035704] integrity: Loading X.509 certificate: UEFI:db
[    1.035769] integrity: Loaded X.509 cert 'Microsoft Windows Production PCA 2011: a92902398e16c49778cd90f99e4f9ae17c55af53'
[    1.035772] integrity: Loading X.509 certificate: UEFI:db
[    1.035788] integrity: Loaded X.509 cert 'Microsoft Corporation: Windows UEFI CA 2023: aefc5fbbbe055d8f8daa585473499417ab5a5272'
[    1.035790] integrity: Loading X.509 certificate: UEFI:db
[    1.035805] integrity: Loaded X.509 cert 'Microsoft Corporation UEFI CA 2011: 13adbf4309bd82709c8cd54f316ed522988a1bd4'
[    1.035806] integrity: Loading X.509 certificate: UEFI:db
[    1.035819] integrity: Loaded X.509 cert 'Microsoft UEFI CA 2023: 81aa6b3244c935bce0d6628af39827421e32497d'
[    1.035820] integrity: Loading X.509 certificate: UEFI:db
[    1.036020] integrity: Loaded X.509 cert 'Secure Certificate: 01dcc89619884ca147983429f8a4a1a0'
[    1.036021] integrity: Loading X.509 certificate: UEFI:db
[    1.036163] integrity: Loaded X.509 cert 'Cus CA: d6136d376b87ef934511c12ce2c3880c'
[    1.043489] Loading compiled-in module X.509 certificates
[    1.043923] Loaded X.509 cert 'Build time autogenerated kernel key: 84d395bd31cee4a05297ad9c1b9c63dc2b3e4d3d'
[    1.043930] ima: Allocated hash algorithm: sha256
[    1.148784] usb 1-6: new high-speed USB device number 2 using xhci_hcd
[    1.196131] ima: No architecture policies found
[    1.196199] evm: Initialising EVM extended attributes:
[    1.196202] evm: security.selinux
[    1.196204] evm: security.SMACK64
[    1.196206] evm: security.SMACK64EXEC
[    1.196208] evm: security.SMACK64TRANSMUTE
[    1.196210] evm: security.SMACK64MMAP
[    1.196211] evm: security.apparmor
[    1.196213] evm: security.ima
[    1.196215] evm: security.capability
[    1.196217] evm: HMAC attrs: 0x1
[    1.197113] PM:   Magic number: 12:274:389
[    1.197162] thermal cooling_device4: hash matches
[    1.197227] acpi ACPI0007:39: hash matches
[    1.197237] acpi ACPI0007:0c: hash matches
[    1.206734] RAS: Correctable Errors collector initialized.
[    1.218576] clk: Disabling unused clocks
[    1.218579] PM: genpd: Disabling unused power domains
[    1.224611] Freeing unused decrypted memory: 2028K
[    1.225424] Freeing unused kernel image (initmem) memory: 5064K
[    1.225439] Write protecting the kernel read-only data: 36864k
[    1.226240] Freeing unused kernel image (rodata/data gap) memory: 44K
[    1.233487] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    1.233491] Run /init as init process
[    1.233492]   with arguments:
[    1.233493]     /init
[    1.233494]     splash
[    1.233494]   with environment:
[    1.233495]     HOME=/
[    1.233495]     TERM=linux
[    1.233496]     BOOT_IMAGE=/@boot/vmlinuz-6.12.0-rc4
[    1.233496]     cryptdevice=UUID=1a8d8cdb-8d8f-4689-b744-8f32d2067f56:luks-1a8d8cdb-8d8f-4689-b744-8f32d2067f56
[    1.303797] usb 1-6: New USB device found, idVendor=04f2, idProduct=b7e7, bcdDevice= 0.04
[    1.303812] usb 1-6: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    1.303818] usb 1-6: Product: Chicony USB2.0 Camera
[    1.303820] usb 1-6: Manufacturer: SunplusIT Inc
[    1.303822] usb 1-6: SerialNumber: 01.00.00
[    1.326685] hid: raw HID events driver (C) Jiri Kosina
[    1.327079] wmi_bus wmi_bus-PNP0C14:01: [Firmware Bug]: WQ00 data block query control method not found
[    1.332135] vmd 0000:00:0e.0: PCI host bridge to bus 10000:e0
[    1.332142] pci_bus 10000:e0: root bus resource [bus e0-ff]
[    1.332145] pci_bus 10000:e0: root bus resource [mem 0x4c000000-0x4dffffff]
[    1.332146] pci_bus 10000:e0: root bus resource [mem 0x6405102000-0x64051fffff 64bit]
[    1.332178] pci 10000:e0:1b.0: [8086:09ab] type 00 class 0x088000 conventional PCI endpoint
[    1.332370] pci 10000:e0:1b.0: Adding to iommu group 7
[    1.332413] pci 10000:e0:1b.4: [8086:7a44] type 01 class 0x060400 PCIe Root Port
[    1.332450] pci 10000:e0:1b.4: PCI bridge to [bus e1]
[    1.332458] pci 10000:e0:1b.4:   bridge window [io  0x0000-0x0fff]
[    1.332461] pci 10000:e0:1b.4:   bridge window [mem 0x4c000000-0x4c0fffff]
[    1.332562] pci 10000:e0:1b.4: PME# supported from D0 D3hot D3cold
[    1.332610] pci 10000:e0:1b.4: PTM enabled (root), 4ns granularity
[    1.333502] Intel(R) 2.5G Ethernet Linux Driver
[    1.333505] Copyright(c) 2018 Intel Corporation.
[    1.333653] pci 10000:e0:1b.4: Adding to iommu group 7
[    1.333680] pci 10000:e0:1b.4: Primary bus is hard wired to 0
[    1.333815] pci 10000:e1:00.0: [144d:a808] type 00 class 0x010802 PCIe Endpoint
[    1.333847] pci 10000:e1:00.0: BAR 0 [mem 0x4c000000-0x4c003fff 64bit]
[    1.333933] igc 0000:03:00.0: PTM enabled, 4ns granularity
[    1.335557] pci 10000:e1:00.0: Adding to iommu group 7
[    1.335585] pci 10000:e0:1b.4: PCI bridge to [bus e1]
[    1.335601] pci 10000:e0:1b.4: Primary bus is hard wired to 0
[    1.342518] ACPI: bus type thunderbolt registered
[    1.342790] thunderbolt 0000:06:00.0: total paths: 12
[    1.342796] thunderbolt 0000:06:00.0: IOMMU DMA protection is enabled
[    1.343558] intel-lpss 0000:00:15.0: enabling device (0004 -> 0006)
[    1.343831] idma64 idma64.0: Found Intel integrated DMA 64-bit
[    1.386250] pps pps0: new PPS source ptp0
[    1.386398] igc 0000:03:00.0 (unnamed net_device) (uninitialized): PHC added
[    1.415161] igc 0000:03:00.0: 4.000 Gb/s available PCIe bandwidth (5.0 GT/s PCIe x1 link)
[    1.415170] igc 0000:03:00.0 eth0: MAC: d4:93:90:44:67:64
[    1.417245] igc 0000:03:00.0 enp3s0: renamed from eth0
[    1.431750] usb 1-7: new full-speed USB device number 3 using xhci_hcd
[    1.444729] thunderbolt 0000:06:00.0: host router reset successful
[    1.445381] thunderbolt 0000:06:00.0: allocating TX ring 0 of size 10
[    1.445450] thunderbolt 0000:06:00.0: allocating RX ring 0 of size 10
[    1.445482] thunderbolt 0000:06:00.0: control channel created
[    1.445486] thunderbolt 0000:06:00.0: using software connection manager
[    1.446033] thunderbolt 0000:06:00.0: device links to tunneled native ports are missing!
[    1.446035] thunderbolt 0000:06:00.0: NHI initialized, starting thunderbolt
[    1.446038] thunderbolt 0000:06:00.0: control channel starting...
[    1.446039] thunderbolt 0000:06:00.0: starting TX ring 0
[    1.446053] thunderbolt 0000:06:00.0: enabling interrupt at register 0x38200 bit 0 (0x0 -> 0x1)
[    1.446058] thunderbolt 0000:06:00.0: starting RX ring 0
[    1.446066] thunderbolt 0000:06:00.0: enabling interrupt at register 0x38200 bit 12 (0x1 -> 0x1001)
[    1.446074] thunderbolt 0000:06:00.0: security level set to user
[    1.446309] thunderbolt 0000:06:00.0: current switch config:
[    1.446311] thunderbolt 0000:06:00.0:  USB4 Switch: 8087:5781 (Revision: 131, TB Version: 64)
[    1.446315] thunderbolt 0000:06:00.0:   Max Port Number: 23
[    1.446317] thunderbolt 0000:06:00.0:   Config:
[    1.446319] thunderbolt 0000:06:00.0:    Upstream Port Number: 15 Depth: 0 Route String: 0x0 Enabled: 0, PlugEventsDelay: 10ms
[    1.446323] thunderbolt 0000:06:00.0:    unknown1: 0x0 unknown4: 0x0
[    1.449464] thunderbolt 0000:06:00.0: initializing Switch at 0x0 (depth: 0, up port: 15)
[    1.450612] thunderbolt 0000:06:00.0: 0: credit allocation parameters:
[    1.450616] thunderbolt 0000:06:00.0: 0:  USB3: 20
[    1.450619] thunderbolt 0000:06:00.0: 0:  DP AUX: 1
[    1.450621] thunderbolt 0000:06:00.0: 0:  DP main: 6
[    1.450624] thunderbolt 0000:06:00.0: 0:  PCIe: 80
[    1.450626] thunderbolt 0000:06:00.0: 0:  DMA: 40
[    1.451629] thunderbolt 0000:06:00.0: acking hot plug event on 0:13
[    1.451762] thunderbolt 0000:06:00.0: acking hot plug event on 0:14
[    1.451884] thunderbolt 0000:06:00.0: acking hot plug event on 0:16
[    1.453050] thunderbolt 0000:06:00.0: 0: DROM version: 3
[    1.453056] thunderbolt 0000:06:00.0: 0: DROM data CRC32 mismatch (expected: 0x56000000, got: 0x56473b0f), continuing
[    1.453689] thunderbolt 0000:06:00.0: 0: uid: 0xb93e650000006ecd
[    1.454964] thunderbolt 0000:06:00.0:  Port 1: 0:5780 (Revision: 0, TB Version: 1, Type: Port (0x1))
[    1.454971] thunderbolt 0000:06:00.0:   Max hop id (in/out): 31/31
[    1.454975] thunderbolt 0000:06:00.0:   Max counters: 4
[    1.454977] thunderbolt 0000:06:00.0:   NFC Credits: 0x8a000000
[    1.454980] thunderbolt 0000:06:00.0:   Credits (total/control): 160/2
[    1.456118] thunderbolt 0000:06:00.0:  Port 2: 0:5780 (Revision: 0, TB Version: 1, Type: Port (0x1))
[    1.456123] thunderbolt 0000:06:00.0:   Max hop id (in/out): 31/31
[    1.456126] thunderbolt 0000:06:00.0:   Max counters: 0
[    1.456128] thunderbolt 0000:06:00.0:   NFC Credits: 0xa000000
[    1.456130] thunderbolt 0000:06:00.0:   Credits (total/control): 160/2
[    1.457389] thunderbolt 0000:06:00.0:  Port 3: 0:5780 (Revision: 0, TB Version: 1, Type: Port (0x1))
[    1.457392] thunderbolt 0000:06:00.0:   Max hop id (in/out): 31/31
[    1.457395] thunderbolt 0000:06:00.0:   Max counters: 4
[    1.457397] thunderbolt 0000:06:00.0:   NFC Credits: 0x8a000000
[    1.457399] thunderbolt 0000:06:00.0:   Credits (total/control): 160/2
[    1.458548] thunderbolt 0000:06:00.0:  Port 4: 0:5780 (Revision: 0, TB Version: 1, Type: Port (0x1))
[    1.458551] thunderbolt 0000:06:00.0:   Max hop id (in/out): 31/31
[    1.458553] thunderbolt 0000:06:00.0:   Max counters: 0
[    1.458555] thunderbolt 0000:06:00.0:   NFC Credits: 0xa000000
[    1.458557] thunderbolt 0000:06:00.0:   Credits (total/control): 160/2
[    1.459823] thunderbolt 0000:06:00.0:  Port 5: 0:5780 (Revision: 0, TB Version: 1, Type: Inactive (0x0))
[    1.459827] thunderbolt 0000:06:00.0:   Max hop id (in/out): 31/31
[    1.459829] thunderbolt 0000:06:00.0:   Max counters: 4
[    1.459831] thunderbolt 0000:06:00.0:   NFC Credits: 0x8a000000
[    1.459833] thunderbolt 0000:06:00.0:   Credits (total/control): 160/0
[    1.460588] thunderbolt 0000:06:00.0:  Port 6: 0:5780 (Revision: 0, TB Version: 1, Type: Inactive (0x0))
[    1.460591] thunderbolt 0000:06:00.0:   Max hop id (in/out): 31/31
[    1.460594] thunderbolt 0000:06:00.0:   Max counters: 0
[    1.460596] thunderbolt 0000:06:00.0:   NFC Credits: 0xa000000
[    1.460598] thunderbolt 0000:06:00.0:   Credits (total/control): 160/0
[    1.461876] thunderbolt 0000:06:00.0:  Port 7: 0:5780 (Revision: 0, TB Version: 1, Type: Inactive (0x0))
[    1.461880] thunderbolt 0000:06:00.0:   Max hop id (in/out): 31/31
[    1.461883] thunderbolt 0000:06:00.0:   Max counters: 4
[    1.461885] thunderbolt 0000:06:00.0:   NFC Credits: 0x8a000000
[    1.461887] thunderbolt 0000:06:00.0:   Credits (total/control): 160/0
[    1.462637] thunderbolt 0000:06:00.0:  Port 8: 0:5780 (Revision: 0, TB Version: 1, Type: Inactive (0x0))
[    1.462641] thunderbolt 0000:06:00.0:   Max hop id (in/out): 31/31
[    1.462644] thunderbolt 0000:06:00.0:   Max counters: 0
[    1.462646] thunderbolt 0000:06:00.0:   NFC Credits: 0xa000000
[    1.462648] thunderbolt 0000:06:00.0:   Credits (total/control): 160/0
[    1.462900] thunderbolt 0000:06:00.0:  Port 9: 0:5780 (Revision: 0, TB Version: 1, Type: PCIe (0x100101))
[    1.462904] thunderbolt 0000:06:00.0:   Max hop id (in/out): 8/8
[    1.462907] thunderbolt 0000:06:00.0:   Max counters: 2
[    1.462909] thunderbolt 0000:06:00.0:   NFC Credits: 0x40800000
[    1.462912] thunderbolt 0000:06:00.0:   Credits (total/control): 8/0
[    1.463150] thunderbolt 0000:06:00.0:  Port 10: 0:5780 (Revision: 0, TB Version: 1, Type: PCIe (0x100101))
[    1.463155] thunderbolt 0000:06:00.0:   Max hop id (in/out): 8/8
[    1.463157] thunderbolt 0000:06:00.0:   Max counters: 2
[    1.463159] thunderbolt 0000:06:00.0:   NFC Credits: 0x40800000
[    1.463161] thunderbolt 0000:06:00.0:   Credits (total/control): 8/0
[    1.463669] thunderbolt 0000:06:00.0:  Port 11: 0:5780 (Revision: 0, TB Version: 1, Type: DP/HDMI (0xe0102))
[    1.463673] thunderbolt 0000:06:00.0:   Max hop id (in/out): 9/9
[    1.463675] thunderbolt 0000:06:00.0:   Max counters: 2
[    1.463677] thunderbolt 0000:06:00.0:   NFC Credits: 0x800000
[    1.463679] thunderbolt 0000:06:00.0:   Credits (total/control): 8/0
[    1.464179] thunderbolt 0000:06:00.0:  Port 12: 0:5780 (Revision: 0, TB Version: 1, Type: DP/HDMI (0xe0102))
[    1.464183] thunderbolt 0000:06:00.0:   Max hop id (in/out): 9/9
[    1.464185] thunderbolt 0000:06:00.0:   Max counters: 2
[    1.464187] thunderbolt 0000:06:00.0:   NFC Credits: 0x800000
[    1.464189] thunderbolt 0000:06:00.0:   Credits (total/control): 8/0
[    1.464434] thunderbolt 0000:06:00.0:  Port 13: 0:5780 (Revision: 0, TB Version: 1, Type: DP/HDMI (0xe0101))
[    1.464438] thunderbolt 0000:06:00.0:   Max hop id (in/out): 9/9
[    1.464440] thunderbolt 0000:06:00.0:   Max counters: 2
[    1.464442] thunderbolt 0000:06:00.0:   NFC Credits: 0x100000d
[    1.464444] thunderbolt 0000:06:00.0:   Credits (total/control): 16/0
[    1.464692] thunderbolt 0000:06:00.0:  Port 14: 0:5780 (Revision: 0, TB Version: 1, Type: DP/HDMI (0xe0101))
[    1.464696] thunderbolt 0000:06:00.0:   Max hop id (in/out): 9/9
[    1.464698] thunderbolt 0000:06:00.0:   Max counters: 2
[    1.464700] thunderbolt 0000:06:00.0:   NFC Credits: 0x100000d
[    1.464702] thunderbolt 0000:06:00.0:   Credits (total/control): 16/0
[    1.465457] thunderbolt 0000:06:00.0:  Port 15: 0:5780 (Revision: 0, TB Version: 1, Type: NHI (0x2))
[    1.465460] thunderbolt 0000:06:00.0:   Max hop id (in/out): 11/11
[    1.465462] thunderbolt 0000:06:00.0:   Max counters: 4
[    1.465464] thunderbolt 0000:06:00.0:   NFC Credits: 0x41c00000
[    1.465466] thunderbolt 0000:06:00.0:   Credits (total/control): 28/0
[    1.465468] thunderbolt 0000:06:00.0: 0:16: disabled by eeprom
[    1.465715] thunderbolt 0000:06:00.0:  Port 17: 0:5780 (Revision: 0, TB Version: 1, Type: Inactive (0x0))
[    1.465718] thunderbolt 0000:06:00.0:   Max hop id (in/out): 8/8
[    1.465720] thunderbolt 0000:06:00.0:   Max counters: 2
[    1.465722] thunderbolt 0000:06:00.0:   NFC Credits: 0x40800000
[    1.465724] thunderbolt 0000:06:00.0:   Credits (total/control): 8/0
[    1.465967] thunderbolt 0000:06:00.0:  Port 18: 0:5780 (Revision: 0, TB Version: 1, Type: Inactive (0x0))
[    1.465970] thunderbolt 0000:06:00.0:   Max hop id (in/out): 8/8
[    1.465972] thunderbolt 0000:06:00.0:   Max counters: 2
[    1.465974] thunderbolt 0000:06:00.0:   NFC Credits: 0x40800000
[    1.465976] thunderbolt 0000:06:00.0:   Credits (total/control): 8/0
[    1.466477] thunderbolt 0000:06:00.0:  Port 19: 0:5780 (Revision: 0, TB Version: 1, Type: DP/HDMI (0xe0102))
[    1.466480] thunderbolt 0000:06:00.0:   Max hop id (in/out): 9/9
[    1.466482] thunderbolt 0000:06:00.0:   Max counters: 2
[    1.466484] thunderbolt 0000:06:00.0:   NFC Credits: 0x800000
[    1.466486] thunderbolt 0000:06:00.0:   Credits (total/control): 8/0
[    1.466730] thunderbolt 0000:06:00.0:  Port 20: 0:5780 (Revision: 0, TB Version: 1, Type: Inactive (0x0))
[    1.466733] thunderbolt 0000:06:00.0:   Max hop id (in/out): 8/8
[    1.466735] thunderbolt 0000:06:00.0:   Max counters: 1
[    1.466737] thunderbolt 0000:06:00.0:   NFC Credits: 0x800000
[    1.466738] thunderbolt 0000:06:00.0:   Credits (total/control): 8/0
[    1.466987] thunderbolt 0000:06:00.0:  Port 21: 0:5780 (Revision: 0, TB Version: 1, Type: USB (0x200101))
[    1.466990] thunderbolt 0000:06:00.0:   Max hop id (in/out): 8/8
[    1.466992] thunderbolt 0000:06:00.0:   Max counters: 1
[    1.466994] thunderbolt 0000:06:00.0:   NFC Credits: 0x800000
[    1.466996] thunderbolt 0000:06:00.0:   Credits (total/control): 8/0
[    1.467247] thunderbolt 0000:06:00.0:  Port 22: 0:5780 (Revision: 0, TB Version: 1, Type: USB (0x200101))
[    1.467250] thunderbolt 0000:06:00.0:   Max hop id (in/out): 8/8
[    1.467252] thunderbolt 0000:06:00.0:   Max counters: 1
[    1.467253] thunderbolt 0000:06:00.0:   NFC Credits: 0x800000
[    1.467255] thunderbolt 0000:06:00.0:   Credits (total/control): 8/0
[    1.467501] thunderbolt 0000:06:00.0:  Port 23: 0:5780 (Revision: 0, TB Version: 1, Type: Inactive (0x0))
[    1.467504] thunderbolt 0000:06:00.0:   Max hop id (in/out): 8/8
[    1.467505] thunderbolt 0000:06:00.0:   Max counters: 1
[    1.467507] thunderbolt 0000:06:00.0:   NFC Credits: 0x800000
[    1.467509] thunderbolt 0000:06:00.0:   Credits (total/control): 8/0
[    1.467512] thunderbolt 0000:06:00.0: 0: running tb_retimer_remove_all [thunderbolt]
[    1.467549] thunderbolt 0000:06:00.0: 0:21: USB3 maximum bandwidth limited to 16376 Mb/s
[    1.467552] thunderbolt 0000:06:00.0: 0:22: USB3 maximum bandwidth limited to 16376 Mb/s
[    1.467555] thunderbolt 0000:06:00.0: 0: running tb_retimer_remove_all [thunderbolt]
[    1.467569] thunderbolt 0000:06:00.0: 0: preventing runtime PM in DP redrive mode
[    1.467572] thunderbolt 0000:06:00.0: 0: linked ports 1 <-> 2
[    1.467574] thunderbolt 0000:06:00.0: 0: linked ports 3 <-> 4
[    1.475825] thunderbolt 0000:06:00.0: 0: TMU: supports uni-directional mode
[    1.475829] thunderbolt 0000:06:00.0: 0: TMU: supports enhanced uni-directional mode
[    1.475953] thunderbolt 0000:06:00.0: 0: TMU: current mode: off
[    1.479988] thunderbolt 0000:06:00.0: 0: NVM version 14.86
[    1.480136] thunderbolt 0000:06:00.0: 0: TMU: mode change off -> uni-directional, LowRes requested
[    1.480557] thunderbolt 0000:06:00.0: 0: TMU: mode set to: uni-directional, LowRes
[    1.481456] thunderbolt 0000:06:00.0: 0:13: DP IN resource available
[    1.482091] thunderbolt 0000:06:00.0: 0:14: DP IN resource available
[    1.500832] pci 10000:e0:1b.4: bridge window [mem 0x4c000000-0x4c0fffff]: assigned
[    1.500840] pci 10000:e0:1b.4: bridge window [io  size 0x1000]: can't assign; no space
[    1.500844] pci 10000:e0:1b.4: bridge window [io  size 0x1000]: failed to assign
[    1.500848] pci 10000:e1:00.0: BAR 0 [mem 0x4c000000-0x4c003fff 64bit]: assigned
[    1.500866] pci 10000:e0:1b.4: PCI bridge to [bus e1]
[    1.500875] pci 10000:e0:1b.4:   bridge window [mem 0x4c000000-0x4c0fffff]
[    1.500979] pcieport 10000:e0:1b.4: can't derive routing for PCI INT A
[    1.500982] pcieport 10000:e0:1b.4: PCI INT A: no GSI
[    1.501166] pcieport 10000:e0:1b.4: PME: Signaling with IRQ 186
[    1.501488] pcieport 10000:e0:1b.4: AER: enabled with IRQ 186
[    1.501634] vmd 0000:00:0e.0: Bound to PCI domain 10000
[    1.511663] intel-lpss 0000:00:15.1: enabling device (0004 -> 0006)
[    1.513723] idma64 idma64.1: Found Intel integrated DMA 64-bit
[    1.561277] usb 1-7: New USB device found, idVendor=048d, idProduct=8910, bcdDevice= 0.01
[    1.561293] usb 1-7: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    1.561300] usb 1-7: Product: ITE Device(829x)
[    1.561304] usb 1-7: Manufacturer: ITE Tech. Inc.
[    1.675764] usb 1-14: new full-speed USB device number 4 using xhci_hcd
[    1.802101] usb 1-14: New USB device found, idVendor=8087, idProduct=0033, bcdDevice= 0.00
[    1.802118] usb 1-14: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    1.818590] usbcore: registered new interface driver usbhid
[    1.818596] usbhid: USB HID core driver
[    1.857126] hid-generic 0003:048D:8910.0001: hiddev0,hidraw0: USB HID v1.10 Device [ITE Tech. Inc. ITE Device(829x)] on usb-0000:00:14.0-7/input0
[    1.857578] input: FTCS1000:01 2808:0102 Mouse as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-0/i2c-FTCS1000:01/0018:2808:0102.0002/input/input8
[    1.857719] input: FTCS1000:01 2808:0102 Touchpad as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-0/i2c-FTCS1000:01/0018:2808:0102.0002/input/input9
[    1.857863] hid-generic 0018:2808:0102.0002: input,hidraw1: I2C HID v1.00 Mouse [FTCS1000:01 2808:0102] on i2c-FTCS1000:01
[    1.862608] nvme nvme0: pci function 10000:e1:00.0
[    1.862635] pcieport 10000:e0:1b.4: can't derive routing for PCI INT A
[    1.862638] nvme 10000:e1:00.0: PCI INT A: not connected
[    1.864979] nvme nvme0: missing or invalid SUBNQN field.
[    1.865139] nvme nvme0: D3 entry latency set to 8 seconds
[    1.885018] nvme nvme0: 18/0/0 default/read/poll queues
[    1.893542]  nvme0n1: p1 p2 p3
[    1.911424] input: FTCS1000:01 2808:0102 Mouse as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-0/i2c-FTCS1000:01/0018:2808:0102.0002/input/input11
[    1.911901] input: FTCS1000:01 2808:0102 Touchpad as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-0/i2c-FTCS1000:01/0018:2808:0102.0002/input/input12
[    1.912215] hid-multitouch 0018:2808:0102.0002: input,hidraw1: I2C HID v1.00 Mouse [FTCS1000:01 2808:0102] on i2c-FTCS1000:01
[    2.746743] input: ImPS/2 Generic Wheel Mouse as /devices/platform/i8042/serio1/input/input7
[    6.827207] ucsi_acpi USBC000:00: error -ETIMEDOUT: PPM init failed
[    9.110528] raid6: avx2x4   gen() 25078 MB/s
[    9.127606] raid6: avx2x2   gen() 36413 MB/s
[    9.144528] raid6: avx2x1   gen() 34182 MB/s
[    9.144529] raid6: using algorithm avx2x2 gen() 36413 MB/s
[    9.161528] raid6: .... xor() 28616 MB/s, rmw enabled
[    9.161530] raid6: using avx2x2 recovery algorithm
[    9.162598] xor: automatically using best checksumming function   avx       
[    9.193521] Btrfs loaded, zoned=yes, fsverity=yes
[    9.218674] BTRFS: device label kfocus_2404 devid 1 transid 4700 /dev/mapper/luks-1a8d8cdb-8d8f-4689-b744-8f32d2067f56 (252:0) scanned by mount (750)
[    9.220703] BTRFS info (device dm-0): first mount of filesystem aa8cb093-9cb3-4cc7-b44e-4bff76ca37fb
[    9.220720] BTRFS info (device dm-0): using crc32c (crc32c-intel) checksum algorithm
[    9.220728] BTRFS info (device dm-0): using free-space-tree
[    9.373157] systemd[1]: Inserted module 'autofs4'
[    9.525952] systemd[1]: systemd 255.4-1ubuntu8.4 running in system mode (+PAM +AUDIT +SELINUX +APPARMOR +IMA +SMACK +SECCOMP +GCRYPT -GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP +LIBFDISK +PCRE2 -PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD -BPF_FRAMEWORK -XKBCOMMON +UTMP +SYSVINIT default-hierarchy=unified)
[    9.525956] systemd[1]: Detected architecture x86-64.
[    9.527072] systemd[1]: Hostname set to <qa-m2>.
[    9.631216] systemd[1]: Configuration file /run/systemd/system/netplan-ovs-cleanup.service is marked world-inaccessible. This has no effect as configuration data is accessible via APIs without restrictions. Proceeding anyway.
[    9.658744] systemd[1]: Queued start job for default target graphical.target.
[    9.673507] systemd[1]: Created slice system-modprobe.slice - Slice /system/modprobe.
[    9.673697] systemd[1]: Created slice system-systemd\x2dcryptsetup.slice - Encrypted Volume Units Service Slice.
[    9.673876] systemd[1]: Created slice system-systemd\x2dfsck.slice - Slice /system/systemd-fsck.
[    9.673971] systemd[1]: Created slice user.slice - User and Session Slice.
[    9.674000] systemd[1]: Started systemd-ask-password-wall.path - Forward Password Requests to Wall Directory Watch.
[    9.674094] systemd[1]: Set up automount proc-sys-fs-binfmt_misc.automount - Arbitrary Executable File Formats File System Automount Point.
[    9.674105] systemd[1]: Expecting device dev-disk-by\x2duuid-167A\x2d6858.device - /dev/disk/by-uuid/167A-6858...
[    9.674110] systemd[1]: Expecting device dev-disk-by\x2duuid-1a8d8cdb\x2d8d8f\x2d4689\x2db744\x2d8f32d2067f56.device - /dev/disk/by-uuid/1a8d8cdb-8d8f-4689-b744-8f32d2067f56...
[    9.674114] systemd[1]: Expecting device dev-disk-by\x2duuid-aa8cb093\x2d9cb3\x2d4cc7\x2db44e\x2d4bff76ca37fb.device - /dev/disk/by-uuid/aa8cb093-9cb3-4cc7-b44e-4bff76ca37fb...
[    9.674118] systemd[1]: Expecting device dev-disk-by\x2duuid-abbbc711\x2d9904\x2d466b\x2d8a35\x2d783f0d19bf50.device - /dev/disk/by-uuid/abbbc711-9904-466b-8a35-783f0d19bf50...
[    9.674122] systemd[1]: Expecting device dev-mapper-luks\x2d1a8d8cdb\x2d8d8f\x2d4689\x2db744\x2d8f32d2067f56.device - /dev/mapper/luks-1a8d8cdb-8d8f-4689-b744-8f32d2067f56...
[    9.674134] systemd[1]: Reached target integritysetup.target - Local Integrity Protected Volumes.
[    9.674148] systemd[1]: Reached target nss-user-lookup.target - User and Group Name Lookups.
[    9.674154] systemd[1]: Reached target remote-fs.target - Remote File Systems.
[    9.674160] systemd[1]: Reached target slices.target - Slice Units.
[    9.674167] systemd[1]: Reached target snapd.mounts-pre.target - Mounting snaps.
[    9.674180] systemd[1]: Reached target veritysetup.target - Local Verity Protected Volumes.
[    9.674214] systemd[1]: Listening on dm-event.socket - Device-mapper event daemon FIFOs.
[    9.674509] systemd[1]: Listening on lvm2-lvmpolld.socket - LVM2 poll daemon socket.
[    9.674802] systemd[1]: Listening on syslog.socket - Syslog Socket.
[    9.674840] systemd[1]: Listening on systemd-fsckd.socket - fsck to fsckd communication Socket.
[    9.674863] systemd[1]: Listening on systemd-initctl.socket - initctl Compatibility Named Pipe.
[    9.674902] systemd[1]: Listening on systemd-journald-dev-log.socket - Journal Socket (/dev/log).
[    9.674946] systemd[1]: Listening on systemd-journald.socket - Journal Socket.
[    9.674970] systemd[1]: systemd-pcrextend.socket - TPM2 PCR Extension (Varlink) was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
[    9.675372] systemd[1]: Listening on systemd-udevd-control.socket - udev Control Socket.
[    9.675405] systemd[1]: Listening on systemd-udevd-kernel.socket - udev Kernel Socket.
[    9.676838] systemd[1]: Mounting dev-hugepages.mount - Huge Pages File System...
[    9.677371] systemd[1]: Mounting dev-mqueue.mount - POSIX Message Queue File System...
[    9.677929] systemd[1]: Mounting sys-kernel-debug.mount - Kernel Debug File System...
[    9.678411] systemd[1]: Mounting sys-kernel-tracing.mount - Kernel Trace File System...
[    9.680176] systemd[1]: Starting systemd-journald.service - Journal Service...
[    9.680223] systemd[1]: Finished blk-availability.service - Availability of block devices.
[    9.680901] systemd[1]: Starting keyboard-setup.service - Set the console keyboard layout...
[    9.681376] systemd[1]: Starting kmod-static-nodes.service - Create List of Static Device Nodes...
[    9.681851] systemd[1]: Starting lvm2-monitor.service - Monitoring of LVM2 mirrors, snapshots etc. using dmeventd or progress polling...
[    9.682309] systemd[1]: Starting modprobe@configfs.service - Load Kernel Module configfs...
[    9.682778] systemd[1]: Starting modprobe@dm_mod.service - Load Kernel Module dm_mod...
[    9.683157] systemd[1]: Starting modprobe@drm.service - Load Kernel Module drm...
[    9.683627] systemd[1]: Starting modprobe@efi_pstore.service - Load Kernel Module efi_pstore...
[    9.684173] systemd[1]: Starting modprobe@fuse.service - Load Kernel Module fuse...
[    9.684653] systemd[1]: Starting modprobe@loop.service - Load Kernel Module loop...
[    9.685328] systemd[1]: Starting modprobe@nvme_fabrics.service - Load Kernel Module nvme_fabrics...
[    9.685838] systemd[1]: Starting systemd-modules-load.service - Load Kernel Modules...
[    9.685847] systemd[1]: systemd-pcrmachine.service - TPM2 PCR Machine ID Measurement was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
[    9.686181] systemd[1]: Starting systemd-remount-fs.service - Remount Root and Kernel File Systems...
[    9.686202] systemd[1]: systemd-tpm2-setup-early.service - TPM2 SRK Setup (Early) was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
[    9.686564] systemd[1]: Starting systemd-udev-trigger.service - Coldplug All udev Devices...
[    9.687082] systemd[1]: Mounted dev-hugepages.mount - Huge Pages File System.
[    9.687123] systemd[1]: Mounted dev-mqueue.mount - POSIX Message Queue File System.
[    9.687152] systemd[1]: Mounted sys-kernel-debug.mount - Kernel Debug File System.
[    9.687179] systemd[1]: Mounted sys-kernel-tracing.mount - Kernel Trace File System.
[    9.687263] systemd[1]: Finished kmod-static-nodes.service - Create List of Static Device Nodes.
[    9.687361] systemd[1]: modprobe@configfs.service: Deactivated successfully.
[    9.687420] systemd[1]: Finished modprobe@configfs.service - Load Kernel Module configfs.
[    9.687515] systemd[1]: modprobe@dm_mod.service: Deactivated successfully.
[    9.687584] systemd[1]: Finished modprobe@dm_mod.service - Load Kernel Module dm_mod.
[    9.687696] systemd[1]: modprobe@drm.service: Deactivated successfully.
[    9.687745] systemd[1]: Finished modprobe@drm.service - Load Kernel Module drm.
[    9.687832] systemd[1]: modprobe@fuse.service: Deactivated successfully.
[    9.687844] pstore: Using crash dump compression: deflate
[    9.687882] systemd[1]: Finished modprobe@fuse.service - Load Kernel Module fuse.
[    9.687960] systemd[1]: modprobe@loop.service: Deactivated successfully.
[    9.688006] systemd[1]: Finished modprobe@loop.service - Load Kernel Module loop.
[    9.688572] systemd[1]: Mounting sys-fs-fuse-connections.mount - FUSE Control File System...
[    9.689154] systemd[1]: Mounting sys-kernel-config.mount - Kernel Configuration File System...
[    9.689176] systemd[1]: systemd-repart.service - Repartition Root Disk was skipped because no trigger condition checks were met.
[    9.689378] systemd-journald[821]: Collecting audit messages is disabled.
[    9.689569] systemd[1]: Starting systemd-tmpfiles-setup-dev-early.service - Create Static Device Nodes in /dev gracefully...
[    9.691429] BTRFS info (device dm-0 state M): turning on sync discard
[    9.691434] BTRFS info (device dm-0 state M): enabling auto defrag
[    9.691435] BTRFS info (device dm-0 state M): use lzo compression, level 0
[    9.691730] Key type psk registered
[    9.691798] systemd[1]: Mounted sys-fs-fuse-connections.mount - FUSE Control File System.
[    9.691935] systemd[1]: Finished systemd-remount-fs.service - Remount Root and Kernel File Systems.
[    9.692694] systemd[1]: systemd-hwdb-update.service - Rebuild Hardware Database was skipped because of an unmet condition check (ConditionNeedsUpdate=/etc).
[    9.693184] systemd[1]: Starting systemd-random-seed.service - Load/Save OS Random Seed...
[    9.693196] systemd[1]: systemd-tpm2-setup.service - TPM2 SRK Setup was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
[    9.693494] systemd[1]: Mounted sys-kernel-config.mount - Kernel Configuration File System.
[    9.698161] systemd[1]: modprobe@nvme_fabrics.service: Deactivated successfully.
[    9.698279] systemd[1]: Finished modprobe@nvme_fabrics.service - Load Kernel Module nvme_fabrics.
[    9.699579] systemd[1]: Finished systemd-tmpfiles-setup-dev-early.service - Create Static Device Nodes in /dev gracefully.
[    9.699694] systemd[1]: systemd-sysusers.service - Create System Users was skipped because no trigger condition checks were met.
[    9.700429] systemd[1]: Starting systemd-tmpfiles-setup-dev.service - Create Static Device Nodes in /dev...
[    9.712826] systemd[1]: Finished keyboard-setup.service - Set the console keyboard layout.
[    9.722671] lp: driver loaded but no devices found
[    9.723270] systemd[1]: Started systemd-journald.service - Journal Service.
[    9.728481] ppdev: user-space parallel port driver
[    9.732172] systemd-journald[821]: Received client request to flush runtime journal.
[    9.749884] pstore: Registered efi_pstore as persistent store backend
[    9.751863] systemd-journald[821]: /var/log/journal/86d43f3761a64806a644a560706664c5/system.journal: Journal file uses a different sequence number ID, rotating.
[    9.751867] systemd-journald[821]: Rotating system journal.
[    9.783239] loop0: detected capacity change from 0 to 152056
[    9.783466] loop1: detected capacity change from 0 to 152112
[    9.784310] loop2: detected capacity change from 0 to 21952
[    9.784429] loop3: detected capacity change from 0 to 8
[    9.785650] loop4: detected capacity change from 0 to 1034424
[    9.785749] loop5: detected capacity change from 0 to 22752
[    9.786311] loop6: detected capacity change from 0 to 187776
[    9.788838] loop7: detected capacity change from 0 to 79328
[    9.789842] loop8: detected capacity change from 0 to 79520
[    9.793164] BTRFS info: devid 1 device path /dev/mapper/luks-1a8d8cdb-8d8f-4689-b744-8f32d2067f56 changed to /dev/dm-0 scanned by (udev-worker) (889)
[    9.794928] BTRFS info: devid 1 device path /dev/dm-0 changed to /dev/mapper/luks-1a8d8cdb-8d8f-4689-b744-8f32d2067f56 scanned by (udev-worker) (889)
[    9.814801] Consider using thermal netlink events interface
[    9.815847] input: Intel HID events as /devices/platform/INTC1051:00/input/input14
[    9.826248] intel_pmc_core INT33A1:00:  initialized
[    9.855434] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[    9.855568] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    9.855663] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c7248db18c600'
[    9.856083] mei_me 0000:00:16.0: enabling device (0000 -> 0002)
[    9.858849] i801_smbus 0000:00:1f.4: SPD Write Disable is set
[    9.858911] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
[    9.867387] i2c i2c-2: Successfully instantiated SPD at 0x50
[    9.870468] Intel(R) Wireless WiFi driver for Linux
[    9.872312] iwlwifi 0000:00:14.3: Detected crf-id 0x400410, cnv-id 0x80401 wfpm id 0x80000020
[    9.872338] iwlwifi 0000:00:14.3: PCI dev 7a70/0094, rev=0x430, rfid=0x2010d000
[    9.872340] iwlwifi 0000:00:14.3: Detected Intel(R) Wi-Fi 6E AX211 160MHz
[    9.872406] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-so-a0-gf-a0-89.ucode failed with error -2
[    9.872419] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-so-a0-gf-a0-88.ucode failed with error -2
[    9.872430] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-so-a0-gf-a0-87.ucode failed with error -2
[    9.876336] iwlwifi 0000:00:14.3: TLV_FW_FSEQ_VERSION: FSEQ Version: 0.0.2.41
[    9.876614] iwlwifi 0000:00:14.3: loaded firmware version 86.fb5c9aeb.0 so-a0-gf-a0-86.ucode op_mode iwlmvm
[    9.881755] intel_rapl_msr: PL4 support detected.
[    9.881811] RAPL PMU: API unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
[    9.881814] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[    9.881815] RAPL PMU: hw unit of domain package 2^-14 Joules
[    9.881815] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
[    9.881816] RAPL PMU: hw unit of domain psys 2^-14 Joules
[    9.881824] intel_rapl_common: Found RAPL domain package
[    9.881827] intel_rapl_common: Found RAPL domain core
[    9.881828] intel_rapl_common: Found RAPL domain uncore
[    9.881830] intel_rapl_common: Found RAPL domain psys
[    9.887634] spd5118 2-0050: DDR5 temperature sensor: vendor 0x06:0x32 revision 1.6
[    9.889578] Bluetooth: Core ver 2.22
[    9.889594] NET: Registered PF_BLUETOOTH protocol family
[    9.889595] Bluetooth: HCI device and connection manager initialized
[    9.889598] Bluetooth: HCI socket layer initialized
[    9.889599] Bluetooth: L2CAP socket layer initialized
[    9.889602] Bluetooth: SCO socket layer initialized
[    9.900437] Creating 1 MTD partitions on "0000:00:1f.5":
[    9.900464] 0x000000000000-0x000002000000 : "BIOS"
[    9.904753] mc: Linux media interface: v0.10
[    9.919485] videodev: Linux video capture interface: v2.00
[    9.922122] intel_rapl_common: Found RAPL domain package
[    9.934090] usbcore: registered new interface driver btusb
[    9.936254] Bluetooth: hci0: Device revision is 0
[    9.936259] Bluetooth: hci0: Secure boot is enabled
[    9.936261] Bluetooth: hci0: OTP lock is enabled
[    9.936262] Bluetooth: hci0: API lock is enabled
[    9.936263] Bluetooth: hci0: Debug lock is disabled
[    9.936264] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
[    9.936265] Bluetooth: hci0: Bootloader timestamp 2019.40 buildtype 1 build 38
[    9.936507] Bluetooth: hci0: DSM reset method type: 0x00
[    9.941064] Bluetooth: hci0: Found device firmware: intel/ibt-1040-0041.sfi
[    9.941079] Bluetooth: hci0: Boot Address: 0x100800
[    9.941081] Bluetooth: hci0: Firmware Version: 60-48.23
[   10.025954] i915 0000:00:02.0: [drm] Found ALDERLAKE_S/RPL-S (device ID a788) display version 12.00 stepping D0
[   10.026736] i915 0000:00:02.0: [drm] VT-d active for gfx access
[   10.072075] MXM: GUID detected in BIOS
[   10.072216] pci 0000:02:00.0: optimus capabilities: enabled, status dynamic power, hda bios codec supported
[   10.072219] VGA switcheroo: detected Optimus DSM method \_SB_.PC00.PEG2.PEGP handle
[   10.072220] nouveau: detected PR support, will not use DSM
[   10.072237] nouveau 0000:02:00.0: enabling device (0400 -> 0403)
[   10.072343] nouveau 0000:02:00.0: NVIDIA AD104 (194000a1)
[   10.075165] intel_tcc_cooling: Programmable TCC Offset detected
[   10.075892] usb 1-6: Found UVC 1.50 device Chicony USB2.0 Camera (04f2:b7e7)
[   10.083100] i915 0000:00:02.0: vgaarb: deactivate vga console
[   10.083166] i915 0000:00:02.0: [drm] Using Transparent Hugepages
[   10.083959] i915 0000:00:02.0: vgaarb: VGA decodes changed: olddecodes=io+mem,decodes=none:owns=io+mem
[   10.090099] i915 0000:00:02.0: [drm] Finished loading DMC firmware i915/adls_dmc_ver2_01.bin (v2.1)
[   10.091058] snd_hda_intel 0000:00:1f.3: enabling device (0000 -> 0002)
[   10.091420] snd_hda_intel 0000:02:00.1: enabling device (0000 -> 0002)
[   10.091476] snd_hda_intel 0000:02:00.1: Disabling MSI
[   10.091480] snd_hda_intel 0000:02:00.1: Handle vga_switcheroo audio client
[   10.104581] i915 0000:00:02.0: [drm] GT0: GuC firmware i915/tgl_guc_70.bin version 70.20.0
[   10.104585] i915 0000:00:02.0: [drm] GT0: HuC firmware i915/tgl_huc.bin version 7.9.3
[   10.109077] iwlwifi 0000:00:14.3: WFPM_UMAC_PD_NOTIFICATION: 0x20
[   10.109109] iwlwifi 0000:00:14.3: WFPM_LMAC2_PD_NOTIFICATION: 0x1f
[   10.109118] iwlwifi 0000:00:14.3: WFPM_AUTH_KEY_0: 0x90
[   10.109128] iwlwifi 0000:00:14.3: CNVI_SCU_SEQ_DATA_DW9: 0x0
[   10.109541] iwlwifi 0000:00:14.3: loaded PNVM version e28bb9d7
[   10.110201] iwlwifi 0000:00:14.3: RFIm is deactivated, reason = 5
[   10.112344] i915 0000:00:02.0: [drm] GT0: HuC: authenticated for all workloads
[   10.113089] i915 0000:00:02.0: [drm] GT0: GUC: submission enabled
[   10.113090] i915 0000:00:02.0: [drm] GT0: GUC: SLPC enabled
[   10.113529] i915 0000:00:02.0: [drm] GT0: GUC: RC enabled
[   10.114343] mei_pxp 0000:00:16.0-fbf6fcf1-96cf-4e2e-a6a6-1bab8cbe36b1: bound 0000:00:02.0 (ops tfp410_ops [i915])
[   10.114400] i915 0000:00:02.0: [drm] Protected Xe Path (PXP) protected content support initialized
[   10.114403] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i9xx_always_on_power_well_ops [i915])
[   10.123246] usb 1-6: Found UVC 1.50 device Chicony USB2.0 Camera (04f2:b7e7)
[   10.126494] iwlwifi 0000:00:14.3: Detected RF GF, rfid=0x2010d000
[   10.134007] usbcore: registered new interface driver uvcvideo
[   10.156254] input: HDA NVidia HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:01.1/0000:02:00.1/sound/card0/input15
[   10.156292] input: HDA NVidia HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:01.1/0000:02:00.1/sound/card0/input16
[   10.156313] input: HDA NVidia HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:01.1/0000:02:00.1/sound/card0/input17
[   10.156333] input: HDA NVidia HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:01.1/0000:02:00.1/sound/card0/input18
[   10.194996] iwlwifi 0000:00:14.3: base HW address: dc:97:ba:75:8a:32
[   10.227977] iwlwifi 0000:00:14.3 wlp0s20f3: renamed from wlan0
[   10.243026] nouveau 0000:02:00.0: bios: version 95.04.63.00.24
[   10.708501] BTRFS: device label kfocus_boot devid 1 transid 285 /dev/nvme0n1p2 (259:2) scanned by mount (1154)
[   10.708952] BTRFS info (device nvme0n1p2): first mount of filesystem abbbc711-9904-466b-8a35-783f0d19bf50
[   10.708965] BTRFS info (device nvme0n1p2): using crc32c (crc32c-intel) checksum algorithm
[   10.708968] BTRFS info (device nvme0n1p2): using free-space-tree
[   10.720225] Adding 524284k swap on /swap/swapfile.  Priority:-2 extents:2 across:1686444k SS
[   10.742928] audit: type=1400 audit(1729700483.313:2): apparmor="STATUS" operation="profile_load" profile="unconfined" name="cam" pid=1217 comm="apparmor_parser"
[   10.742933] audit: type=1400 audit(1729700483.313:3): apparmor="STATUS" operation="profile_load" profile="unconfined" name="chrome" pid=1220 comm="apparmor_parser"
[   10.742949] audit: type=1400 audit(1729700483.313:4): apparmor="STATUS" operation="profile_load" profile="unconfined" name="brave" pid=1214 comm="apparmor_parser"
[   10.742966] audit: type=1400 audit(1729700483.313:5): apparmor="STATUS" operation="profile_load" profile="unconfined" name="busybox" pid=1216 comm="apparmor_parser"
[   10.743054] audit: type=1400 audit(1729700483.313:6): apparmor="STATUS" operation="profile_load" profile="unconfined" name=4D6F6E676F444220436F6D70617373 pid=1211 comm="apparmor_parser"
[   10.743138] audit: type=1400 audit(1729700483.313:7): apparmor="STATUS" operation="profile_load" profile="unconfined" name="ch-checkns" pid=1218 comm="apparmor_parser"
[   10.743143] audit: type=1400 audit(1729700483.313:8): apparmor="STATUS" operation="profile_load" profile="unconfined" name="vscode" pid=1221 comm="apparmor_parser"
[   10.743145] audit: type=1400 audit(1729700483.313:9): apparmor="STATUS" operation="profile_load" profile="unconfined" name="1password" pid=1209 comm="apparmor_parser"
[   10.743153] audit: type=1400 audit(1729700483.313:10): apparmor="STATUS" operation="profile_load" profile="unconfined" name="buildah" pid=1215 comm="apparmor_parser"
[   10.743169] audit: type=1400 audit(1729700483.313:11): apparmor="STATUS" operation="profile_load" profile="unconfined" name="balena-etcher" pid=1213 comm="apparmor_parser"
[   11.183971] nouveau 0000:02:00.0: drm: VRAM: 12282 MiB
[   11.183974] nouveau 0000:02:00.0: drm: GART: 536870912 MiB
[   11.240499] nouveau 0000:02:00.0: drm: MM: using COPY for buffer copies
[   11.267239] snd_hda_intel 0000:02:00.1: bound 0000:02:00.0 (ops disp50xx_modifiers [nouveau])
[   11.272961] [drm] Initialized nouveau 1.4.0 for 0000:02:00.0 on minor 2
[   11.275846] nouveau 0000:02:00.0: [drm] Cannot find any crtc or sizes
[   11.281363] nouveau 0000:02:00.0: [drm] Cannot find any crtc or sizes
[   11.282470] nouveau 0000:02:00.0: [drm] Cannot find any crtc or sizes
[   11.336539] Bluetooth: hci0: Waiting for firmware download to complete
[   11.337238] Bluetooth: hci0: Firmware loaded in 1363446 usecs
[   11.337292] Bluetooth: hci0: Waiting for device to boot
[   11.353321] Bluetooth: hci0: Device booted in 15676 usecs
[   11.353412] Bluetooth: hci0: Malformed MSFT vendor event: 0x02
[   11.355593] Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-1040-0041.ddc
[   11.357464] Bluetooth: hci0: Applying Intel DDC parameters completed
[   11.360345] Bluetooth: hci0: Firmware timestamp 2023.48 buildtype 1 build 75324
[   11.360351] Bluetooth: hci0: Firmware SHA1: 0x23bac558
[   11.364376] Bluetooth: hci0: Fseq status: Success (0x00)
[   11.364388] Bluetooth: hci0: Fseq executed: 00.00.02.41
[   11.364393] Bluetooth: hci0: Fseq BT Top: 00.00.02.41
[   11.787454] i915 0000:00:02.0: [drm] Skipping intel_backlight registration
[   11.787931] [drm] Initialized i915 1.6.0 for 0000:00:02.0 on minor 1
[   11.788455] ACPI: video: [Firmware Bug]: ACPI(PEGP) defines _DOD but not _DOS
[   11.788504] ACPI: video: Video Device [PEGP] (multi-head: yes  rom: no  post: no)
[   11.788600] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:05/LNXVIDEO:00/input/input19
[   11.791189] ACPI: video: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[   11.791669] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:01/input/input20
[   11.794597] fbcon: i915drmfb (fb0) is primary device
[   11.794602] fbcon: Deferring console take-over
[   11.794625] i915 0000:00:02.0: [drm] fb0: i915drmfb frame buffer device
[   11.796558] snd_hda_intel 0000:00:1f.3: bound 0000:00:02.0 (ops i915_fence_ops [i915])
[   11.814796] vga_switcheroo: enabled
[   11.832609] snd_hda_codec_realtek hdaudioC1D0: autoconfig for ALC1220: line_outs=1 (0x1b/0x0/0x0/0x0/0x0) type:speaker
[   11.832618] snd_hda_codec_realtek hdaudioC1D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[   11.832621] snd_hda_codec_realtek hdaudioC1D0:    hp_outs=1 (0x14/0x0/0x0/0x0/0x0)
[   11.832624] snd_hda_codec_realtek hdaudioC1D0:    mono: mono_out=0x0
[   11.832625] snd_hda_codec_realtek hdaudioC1D0:    dig-out=0x1e/0x0
[   11.832627] snd_hda_codec_realtek hdaudioC1D0:    inputs:
[   11.832629] snd_hda_codec_realtek hdaudioC1D0:      Headset Mic=0x19
[   11.832631] snd_hda_codec_realtek hdaudioC1D0:      Mic=0x18
[   11.832633] snd_hda_codec_realtek hdaudioC1D0:      Internal Mic=0x12
[   11.862547] input: HDA Intel PCH Mic as /devices/pci0000:00/0000:00:1f.3/sound/card1/input21
[   11.862597] input: HDA Intel PCH Headphone as /devices/pci0000:00/0000:00:1f.3/sound/card1/input22
[   11.862630] input: HDA Intel PCH HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:1f.3/sound/card1/input23
[   11.862654] input: HDA Intel PCH HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:1f.3/sound/card1/input24
[   11.862681] input: HDA Intel PCH HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:1f.3/sound/card1/input25
[   11.862706] input: HDA Intel PCH HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:1f.3/sound/card1/input26
[   12.020790] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   12.020794] Bluetooth: BNEP filters: protocol multicast
[   12.020797] Bluetooth: BNEP socket layer initialized
[   12.021707] Bluetooth: MGMT ver 1.23
[   12.027363] NET: Registered PF_ALG protocol family
[   12.065399] loop9: detected capacity change from 0 to 8
[   12.082321] NET: Registered PF_QIPCRTR protocol family
[   12.592932] iwlwifi 0000:00:14.3: WFPM_UMAC_PD_NOTIFICATION: 0x20
[   12.592962] iwlwifi 0000:00:14.3: WFPM_LMAC2_PD_NOTIFICATION: 0x1f
[   12.592971] iwlwifi 0000:00:14.3: WFPM_AUTH_KEY_0: 0x90
[   12.592980] iwlwifi 0000:00:14.3: CNVI_SCU_SEQ_DATA_DW9: 0x0
[   12.594042] iwlwifi 0000:00:14.3: RFIm is deactivated, reason = 5
[   12.694542] iwlwifi 0000:00:14.3: Registered PHC clock: iwlwifi-PTP, with index: 1
[   15.333558] igc 0000:03:00.0 enp3s0: NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
[   20.225673] thunderbolt 0000:06:00.0: 0: suspending switch
[   20.225677] thunderbolt 0000:06:00.0: 0: enabling wakeup: 0x3f
[   20.226784] thunderbolt 0000:06:00.0: stopping RX ring 0
[   20.226797] thunderbolt 0000:06:00.0: disabling interrupt at register 0x38200 bit 12 (0x1001 -> 0x1)
[   20.226975] thunderbolt 0000:06:00.0: stopping TX ring 0
[   20.226991] thunderbolt 0000:06:00.0: disabling interrupt at register 0x38200 bit 0 (0x1 -> 0x0)
[   20.226998] thunderbolt 0000:06:00.0: control channel stopped
[   25.388142] Bluetooth: RFCOMM TTY layer initialized
[   25.388148] Bluetooth: RFCOMM socket layer initialized
[   25.388150] Bluetooth: RFCOMM ver 1.11
[  570.464648] thunderbolt 0000:06:00.0: control channel starting...
[  570.464661] thunderbolt 0000:06:00.0: starting TX ring 0
[  570.464679] thunderbolt 0000:06:00.0: enabling interrupt at register 0x38200 bit 0 (0x0 -> 0x1)
[  570.464686] thunderbolt 0000:06:00.0: starting RX ring 0
[  570.464696] thunderbolt 0000:06:00.0: enabling interrupt at register 0x38200 bit 12 (0x1 -> 0x1001)
[  570.464709] thunderbolt 0000:06:00.0: 0: resuming switch
[  570.464713] thunderbolt 0000:06:00.0: restoring Switch at 0x0 (depth: 0, up port: 15)
[  570.465126] thunderbolt 0000:06:00.0: 0: disabling wakeup
[  570.465468] thunderbolt 0000:06:00.0: acking hot plug event on 0:13
[  570.465638] thunderbolt 0000:06:00.0: acking hot plug event on 0:14
[  570.465703] thunderbolt 0000:06:00.0: acking hot plug event on 0:16
[  570.466117] xhci_hcd 0000:2d:00.0: xHC error in resume, USBSTS 0x401, Reinit
[  570.466129] usb usb3: root hub lost power or was reset
[  570.466134] usb usb4: root hub lost power or was reset
[  570.474094] thunderbolt 0000:06:00.0: 0: TMU: supports uni-directional mode
[  570.474099] thunderbolt 0000:06:00.0: 0: TMU: supports enhanced uni-directional mode
[  570.474221] thunderbolt 0000:06:00.0: 0: TMU: current mode: off
[  570.474224] thunderbolt 0000:06:00.0: 0: TMU: mode change off -> bi-directional, HiFi requested
[  570.474733] thunderbolt 0000:06:00.0: 0: TMU: mode set to: bi-directional, HiFi
[  570.476426] thunderbolt 0000:06:00.0: 0:13: DP IN resource available after hotplug
[  570.476430] thunderbolt 0000:06:00.0: looking for DP IN <-> DP OUT pairs:
[  570.476534] thunderbolt 0000:06:00.0: 0:13: DP IN available
[  570.476535] thunderbolt 0000:06:00.0: 0:13: no suitable DP OUT adapter available, not tunneling
[  570.476662] thunderbolt 0000:06:00.0: 0:14: DP IN resource available after hotplug
[  570.476664] thunderbolt 0000:06:00.0: looking for DP IN <-> DP OUT pairs:
[  570.476798] thunderbolt 0000:06:00.0: 0:13: DP IN available
[  570.476803] thunderbolt 0000:06:00.0: 0:13: no suitable DP OUT adapter available, not tunneling
[  570.476918] thunderbolt 0000:06:00.0: 0:14: DP IN available
[  570.476919] thunderbolt 0000:06:00.0: 0:14: no suitable DP OUT adapter available, not tunneling
[  588.718848] thunderbolt 0000:06:00.0: 0: suspending switch
[  588.718866] thunderbolt 0000:06:00.0: 0: enabling wakeup: 0x3f
[  588.720505] thunderbolt 0000:06:00.0: stopping RX ring 0
[  588.720528] thunderbolt 0000:06:00.0: disabling interrupt at register 0x38200 bit 12 (0x1001 -> 0x1)
[  588.720569] thunderbolt 0000:06:00.0: stopping TX ring 0
[  588.720583] thunderbolt 0000:06:00.0: disabling interrupt at register 0x38200 bit 0 (0x1 -> 0x0)
[  588.720601] thunderbolt 0000:06:00.0: control channel stopped
[ 2853.849107] systemd-journald[821]: /var/log/journal/86d43f3761a64806a644a560706664c5/user-1000.journal: Journal file uses a different sequence number ID, rotating.
[ 2855.792552] warning: `kded5' uses wireless extensions which will stop working for Wi-Fi 7 hardware; use nl80211
[ 2856.815169] thunderbolt 0000:06:00.0: control channel starting...
[ 2856.815174] thunderbolt 0000:06:00.0: starting TX ring 0
[ 2856.815190] thunderbolt 0000:06:00.0: enabling interrupt at register 0x38200 bit 0 (0x0 -> 0x1)
[ 2856.815194] thunderbolt 0000:06:00.0: starting RX ring 0
[ 2856.815200] thunderbolt 0000:06:00.0: enabling interrupt at register 0x38200 bit 12 (0x1 -> 0x1001)
[ 2856.815206] thunderbolt 0000:06:00.0: 0: resuming switch
[ 2856.815208] thunderbolt 0000:06:00.0: restoring Switch at 0x0 (depth: 0, up port: 15)
[ 2856.815386] thunderbolt 0000:06:00.0: acking hot plug event on 0:13
[ 2856.815559] thunderbolt 0000:06:00.0: acking hot plug event on 0:14
[ 2856.815626] thunderbolt 0000:06:00.0: acking hot plug event on 0:16
[ 2856.815831] xhci_hcd 0000:2d:00.0: xHC error in resume, USBSTS 0x401, Reinit
[ 2856.815834] usb usb3: root hub lost power or was reset
[ 2856.815836] usb usb4: root hub lost power or was reset
[ 2856.816885] thunderbolt 0000:06:00.0: 0: disabling wakeup
[ 2856.826783] thunderbolt 0000:06:00.0: 0: TMU: supports uni-directional mode
[ 2856.826790] thunderbolt 0000:06:00.0: 0: TMU: supports enhanced uni-directional mode
[ 2856.826909] thunderbolt 0000:06:00.0: 0: TMU: current mode: off
[ 2856.826913] thunderbolt 0000:06:00.0: 0: TMU: mode change off -> bi-directional, HiFi requested
[ 2856.827423] thunderbolt 0000:06:00.0: 0: TMU: mode set to: bi-directional, HiFi
[ 2856.829241] thunderbolt 0000:06:00.0: 0:13: DP IN resource available after hotplug
[ 2856.829248] thunderbolt 0000:06:00.0: looking for DP IN <-> DP OUT pairs:
[ 2856.829272] thunderbolt 0000:06:00.0: 0:13: DP IN available
[ 2856.829274] thunderbolt 0000:06:00.0: 0:13: no suitable DP OUT adapter available, not tunneling
[ 2856.829404] thunderbolt 0000:06:00.0: 0:14: DP IN resource available after hotplug
[ 2856.829406] thunderbolt 0000:06:00.0: looking for DP IN <-> DP OUT pairs:
[ 2856.829528] thunderbolt 0000:06:00.0: 0:13: DP IN available
[ 2856.829530] thunderbolt 0000:06:00.0: 0:13: no suitable DP OUT adapter available, not tunneling
[ 2856.829659] thunderbolt 0000:06:00.0: 0:14: DP IN available
[ 2856.829663] thunderbolt 0000:06:00.0: 0:14: no suitable DP OUT adapter available, not tunneling
[ 2861.450869] wlp0s20f3: authenticate with a0:55:1f:2f:2c:93 (local address=dc:97:ba:75:8a:32)
[ 2861.452748] wlp0s20f3: send auth to a0:55:1f:2f:2c:93 (try 1/3)
[ 2861.497119] wlp0s20f3: authenticate with a0:55:1f:2f:2c:93 (local address=dc:97:ba:75:8a:32)
[ 2861.497589] wlp0s20f3: send auth to a0:55:1f:2f:2c:93 (try 1/3)
[ 2861.498980] wlp0s20f3: authenticated
[ 2861.499754] wlp0s20f3: associate with a0:55:1f:2f:2c:93 (try 1/3)
[ 2861.514163] wlp0s20f3: RX AssocResp from a0:55:1f:2f:2c:93 (capab=0x1011 status=0 aid=14)
[ 2861.521955] wlp0s20f3: associated
[ 2863.199657] workqueue: pm_runtime_work hogged CPU for >10000us 4 times, consider switching to WQ_UNBOUND
[ 2875.282349] thunderbolt 0000:06:00.0: 0: suspending switch
[ 2875.282359] thunderbolt 0000:06:00.0: 0: enabling wakeup: 0x3f
[ 2875.283649] thunderbolt 0000:06:00.0: stopping RX ring 0
[ 2875.283661] thunderbolt 0000:06:00.0: disabling interrupt at register 0x38200 bit 12 (0x1001 -> 0x1)
[ 2875.283681] thunderbolt 0000:06:00.0: stopping TX ring 0
[ 2875.283698] thunderbolt 0000:06:00.0: disabling interrupt at register 0x38200 bit 0 (0x1 -> 0x0)
[ 2875.283708] thunderbolt 0000:06:00.0: control channel stopped
[ 2915.283167] workqueue: pm_runtime_work hogged CPU for >10000us 5 times, consider switching to WQ_UNBOUND
[ 2950.492372] usb 1-10: new full-speed USB device number 5 using xhci_hcd
[ 2950.630555] usb 1-10: not running at top speed; connect to a high speed hub
[ 2950.644806] usb 1-10: New USB device found, idVendor=2109, idProduct=0103, bcdDevice= 2.00
[ 2950.644820] usb 1-10: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[ 2950.644825] usb 1-10: Product: USB 2.0 BILLBOARD             
[ 2950.644830] usb 1-10: Manufacturer: VIA Technologies Inc.         
[ 2950.644834] usb 1-10: SerialNumber: 0000000000000001
[ 3044.625919] thunderbolt 0000:06:00.0: control channel starting...
[ 3044.625931] thunderbolt 0000:06:00.0: starting TX ring 0
[ 3044.625949] thunderbolt 0000:06:00.0: enabling interrupt at register 0x38200 bit 0 (0x0 -> 0x1)
[ 3044.625956] thunderbolt 0000:06:00.0: starting RX ring 0
[ 3044.625967] thunderbolt 0000:06:00.0: enabling interrupt at register 0x38200 bit 12 (0x1 -> 0x1001)
[ 3044.625980] thunderbolt 0000:06:00.0: 0: resuming switch
[ 3044.625984] thunderbolt 0000:06:00.0: restoring Switch at 0x0 (depth: 0, up port: 15)
[ 3044.626699] thunderbolt 0000:06:00.0: acking hot plug event on 0:14
[ 3044.626773] thunderbolt 0000:06:00.0: acking hot plug event on 0:16
[ 3044.627010] xhci_hcd 0000:2d:00.0: xHC error in resume, USBSTS 0x401, Reinit
[ 3044.627020] usb usb3: root hub lost power or was reset
[ 3044.627027] usb usb4: root hub lost power or was reset
[ 3044.629043] thunderbolt 0000:06:00.0: 0: disabling wakeup
[ 3044.637977] thunderbolt 0000:06:00.0: 0: TMU: supports uni-directional mode
[ 3044.637984] thunderbolt 0000:06:00.0: 0: TMU: supports enhanced uni-directional mode
[ 3044.638102] thunderbolt 0000:06:00.0: 0: TMU: current mode: off
[ 3044.638107] thunderbolt 0000:06:00.0: 0: TMU: mode change off -> bi-directional, HiFi requested
[ 3044.638621] thunderbolt 0000:06:00.0: 0: TMU: mode set to: bi-directional, HiFi
[ 3044.640183] thunderbolt 0000:06:00.0: 0:13: enter redrive mode, keeping powered
[ 3044.641097] thunderbolt 0000:06:00.0: 0:14: DP IN resource available after hotplug
[ 3044.641108] thunderbolt 0000:06:00.0: looking for DP IN <-> DP OUT pairs:
[ 3044.641143] thunderbolt 0000:06:00.0: 0:14: DP IN available
[ 3044.641146] thunderbolt 0000:06:00.0: 0:14: no suitable DP OUT adapter available, not tunneling
[ 3044.708463] workqueue: pm_runtime_work hogged CPU for >10000us 7 times, consider switching to WQ_UNBOUND
[ 3046.118445] fbcon: Deferring console take-over
[ 3046.118449] nouveau 0000:02:00.0: [drm] fb1: nouveaudrmfb frame buffer device
[ 3047.743654] i915 0000:00:02.0: Using 39-bit DMA addresses
[ 3129.398283] usb 1-9: new high-speed USB device number 6 using xhci_hcd
[ 3129.415685] thunderbolt 0000:06:00.0: acking hot unplug event on 0:14
[ 3129.415798] thunderbolt 0000:06:00.0: 0:14: DP IN resource unavailable
[ 3129.416442] thunderbolt 0000:06:00.0: 0:14: enter redrive mode, keeping powered
[ 3129.416458] thunderbolt 0000:06:00.0: bandwidth consumption changed, re-calculating estimated bandwidth
[ 3129.416465] thunderbolt 0000:06:00.0: bandwidth re-calculation done
[ 3129.416470] thunderbolt 0000:06:00.0: looking for DP IN <-> DP OUT pairs:
[ 3129.416473] thunderbolt 0000:06:00.0: no suitable DP IN adapter available, not tunneling
[ 3129.542579] usb 1-9: New USB device found, idVendor=0bda, idProduct=5411, bcdDevice= 1.49
[ 3129.542592] usb 1-9: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[ 3129.542596] usb 1-9: Product: 4-Port USB 2.0 Hub
[ 3129.542599] usb 1-9: Manufacturer: Generic
[ 3129.546460] hub 1-9:1.0: USB hub found
[ 3129.547858] hub 1-9:1.0: 4 ports detected
[ 3130.778282] usb 1-9.3: new full-speed USB device number 7 using xhci_hcd
[ 3130.865790] usb 1-9.3: New USB device found, idVendor=043e, idProduct=9a39, bcdDevice= 4.11
[ 3130.865794] usb 1-9.3: New USB device strings: Mfr=1, Product=3, SerialNumber=4
[ 3130.865795] usb 1-9.3: Product: LG Monitor Controls
[ 3130.865795] usb 1-9.3: Manufacturer: LG Electronics Inc.
[ 3130.865796] usb 1-9.3: SerialNumber: 005INTX1F153
[ 3130.874624] hid-generic 0003:043E:9A39.0003: hiddev1,hidraw2: USB HID v1.11 Device [LG Electronics Inc. LG Monitor Controls] on usb-0000:00:14.0-9.3/input0

--MP_/_0+LG6F0OE0r8ceD.u3ft65--

