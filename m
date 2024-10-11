Return-Path: <linux-kernel+bounces-361971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 246AE99AF72
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 01:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 280F41F22DBC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 23:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67E21E47BE;
	Fri, 11 Oct 2024 23:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b="H9Xs3/vx"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E011D151F
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 23:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728689884; cv=none; b=luTKoT58mFN2GErIv+poJNY1FKcpK+FUxDLaDygG9if+wImOwrpfOJmcPd0E909BwWhee7pSmWRDzoBzmkSDqYxtSE5vDtyh/X6G2nFV6lRG7NDlpSEk9vEs8DxS86llOKboHT/wdjhM1jqHBR1GXYAAdglF3dE6tVh+ytb8uSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728689884; c=relaxed/simple;
	bh=NiRMBLYfT/NqXydt08CiJXlzwLwmu2TSYX0/HjiVorc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZEbLvy7laXoEUuCdARcoRVdgO7PDklM81pMWouZY6uHUwtYebhPzNVFo7BDmhm1LuBwOh4jM+DnCxj/uILCkTZ4+JqJamN92THOxse6rNn/JgU0f3MREJ2fxhOe4I417Jkl8V4yqRTl8DwmahrR9yVmciQTvH+c2TPLUfRbw48U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org; spf=pass smtp.mailfrom=kfocus.org; dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b=H9Xs3/vx; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kfocus.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-82aac438539so101538439f.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 16:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kfocus-org.20230601.gappssmtp.com; s=20230601; t=1728689877; x=1729294677; darn=vger.kernel.org;
        h=mime-version:organization:references:in-reply-to:message-id:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IBcDKDBREfQ6UKfi4KoIMVGhL7xllufrABlq9EkgF5k=;
        b=H9Xs3/vxfo+jK2TiPqX5pstscCafTRz0sP9eSem2xT22wHCT1AGl23beybu6boAKFZ
         BlVhmjKhYr7NX6Llj8tJuWHjr+Ek0rMpaeyl9eoqmY1WGuXg4h9pkOb2rxeG39sWYHhw
         V84ESyi2qsLYt1RBbP5rElSCrEPeRhAKUL0Tv06IRWcfUcZr+48kThVX5korzaJEu2CR
         PDpp/CXeu0Msb7RU2qkZ1eESnqjkvaCMbZjPr3FuBrX+dy4bn0dTxQNa4frbmetM7NJh
         Q/S5Uc3c3VeAWgQfe/dfp822DT63EtCrqZ6+PTeV3WB6GrIu+VzivlOhjTG4IY227geK
         v7xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728689877; x=1729294677;
        h=mime-version:organization:references:in-reply-to:message-id:subject
         :cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IBcDKDBREfQ6UKfi4KoIMVGhL7xllufrABlq9EkgF5k=;
        b=L+hzF04DNhmLiX8t7Qmq6aB7EaLMVB0Fc7QJm67+AYrC1giBcO3Q/E0l0jxP4Hfeyk
         4sImpQ+U7lWGB8Y9Ov0I6WJmNIYM6NfJ6TdXckyxbThFO9YEX06MDTBbpsht0WEIiDlo
         qjmPnI0X3igxlLN2+vVSb4jEMRiLsW9kNWaTGHM10NZbD28bPK4c0ywJJjlOzDgT0NQk
         2zCljsxsjHym92jUrkTQGDzsU31tdJB7Jo5m+mAC3Ck3ifmz6u+gaFrTalHwvgX0rx9w
         XJQFZmGrH1IuYXqWQFGfbAu1o5N/48/yRMF8Ut4oVBvkLF8D1mCPh8xC/mw8stx9C305
         amcg==
X-Forwarded-Encrypted: i=1; AJvYcCVsTbZBk+ZLL1+BrDb6OH+wKemPcff3hbZBI5xCmkGiBDcIA9BCNukrnT6G2JQfAFO8BRAMuuQ2OL5/liw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhfRx6FOV5/su+SsgaNZ6Tlm1cfXer8T3N7/JudSXgy70B3PH0
	JBfisZm5YV8tPsdvHZEfI8i3AgXBH6DqNfFnzo1IZq7Boq5bB71rjucpL8sBrOM=
X-Google-Smtp-Source: AGHT+IGpu47vVY7+urc32+C47VgrPCVqDZ2+fZ1lfc282KDbdBoBFDZOOhTbZXE7r004pf5fM8AmxA==
X-Received: by 2002:a05:6e02:164c:b0:3a3:b254:ca2a with SMTP id e9e14a558f8ab-3a3bcdbdb6amr6947505ab.9.1728689876389;
        Fri, 11 Oct 2024 16:37:56 -0700 (PDT)
Received: from kf-ir16 ([2607:fb91:1126:8abd:cfbd:d58d:3879:6479])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a3afdae1b2sm9173125ab.3.2024.10.11.16.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 16:37:55 -0700 (PDT)
Date: Fri, 11 Oct 2024 18:37:51 -0500
From: Aaron Rainbolt <arainbolt@kfocus.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: YehezkelShB@gmail.com, michael.jamet@intel.com,
 andreas.noever@gmail.com, linux-usb@vger.kernel.org, mmikowski@kfocus.org,
 linux-kernel@vger.kernel.org, Gil Fine <gil.fine@linux.intel.com>
Subject: Re: USB-C DisplayPort display failing to stay active with Intel
 Barlow Ridge USB4 controller, power-management related issue?
Message-ID: <20241011183751.7d27c59c@kf-ir16>
In-Reply-To: <20241011163811.GU275077@black.fi.intel.com>
References: <20241009220118.70bfedd0@kf-ir16>
	<20241010044919.GD275077@black.fi.intel.com>
	<20241010232656.7fc6359e@kf-ir16>
	<20241011163811.GU275077@black.fi.intel.com>
Organization: Kubuntu Focus
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/=_++1Fd/UC4uZ2dD5GFiPsE"

--MP_/=_++1Fd/UC4uZ2dD5GFiPsE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Fri, 11 Oct 2024 19:38:11 +0300
Mika Westerberg <mika.westerberg@linux.intel.com> wrote:

> Hi,
> 
> On Thu, Oct 10, 2024 at 11:26:56PM -0500, Aaron Rainbolt wrote:
> > > Can you share full dmesg with the repro and
> > > "thunderbolt.dyndbg=+p" in the kernel command line?  
> > 
> > The full log is very long, so I've included it as an email
> > attachment. The exact steps taken after booting with the requested
> > kernel parameter were:
> > 
> > 1. boot with thunderbolt.dyndbg=+p kernel param, no USB-C plugged
> > in. 2. After login, hot-plug two USB-C cables. This time, the
> > displays came up and stayed resident (this happens sometimes)
> > 3. Unplugged both cables.
> > 4. Replugged both. This time, the displays did not show anything.
> > 5. lspci -k "jiggled" the displays and they came back on.
> > 6. After ~15s, the displays blacked out again.
> > 7. Save to the demsg file after about 30s.
> > 
> > The laptop's firmware is fully up-to-date. One of the fixes we tried
> > was installing Windows 11, updating the firmware, and then
> > re-installing Kubuntu 24.04. This had no effect on the issue.
> > 
> > Notes:
> > 
> > * Kernel 6.1 does not exhibit this time out. 6.5 and later do.
> > * Windows 11 had very similar behavior before installing Windows
> >   updates. After update, it was fixed.
> > * All distros and W11 were tested on the same hardware with the
> > latest firmware, so we know this is not a hardware failure.  
> 
> Thanks for the logs and steps!
> 
> I now realize that
> 
>   a75e0684efe5 ("thunderbolt: Keep the domain powered when USB4 port
> is in redrive mode")
> 
> was half-baked. Yes it deals with the situation where plugging in
> monitor when the domain is powered. However, it completely misses
> these cases:
> 
> * Plug in monitor to the Type-C port when the controller is runtime
>    suspended.
> * Boot with monitor plugged in to the Type-C port.
> 
> At the end of this email there is a hack patch that tries to solve
> this. Can you try it out? I will be on vacation next week but I'm
> copying my colleague Gil who is familiar with this too. He should be
> able to help you out during my absense.
> 
> Couple of notes about the dmesg you shared. They don't affect this
> issue but may cause other issues:
> 
> > [    1.382718] thunderbolt 0000:06:00.0: device links to tunneled
> > native ports are missing!  
> 
> This is means the BIOS does not implement the USB4 power contract
> which means that USB 3.x and PCIe tunnels will not work as expected
> after power transition.
> 
> > [    1.416488] thunderbolt 0000:06:00.0: 0: NVM version 14.86  
> 
> This is really old firmware version. My development system for example
> has 56.x so yours might have a bunch of issues that are solved in the
> later versions.
> 
> The hack patch below:
> 
> diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
> index 07a66594e904..0e424b7661be 100644
> --- a/drivers/thunderbolt/tb.c
> +++ b/drivers/thunderbolt/tb.c
> @@ -2113,6 +2113,37 @@ static void tb_exit_redrive(struct tb_port
> *port) }
>  }
>  
> +static void tb_switch_enter_redrive(struct tb_switch *sw)
> +{
> +	struct tb_port *port;
> +
> +	tb_switch_for_each_port(sw, port)
> +		tb_enter_redrive(port);
> +}
> +
> +/*
> + * Called during system and runtime suspend to forcefully exit
> redrive
> + * mode without querying whether the resource is available.
> + */
> +static void tb_switch_exit_redrive(struct tb_switch *sw)
> +{
> +	struct tb_port *port;
> +
> +	if (!(sw->quirks & QUIRK_KEEP_POWER_IN_DP_REDRIVE))
> +		return;
> +
> +	tb_switch_for_each_port(sw, port) {
> +		if (!tb_port_is_dpin(port))
> +			continue;
> +
> +		if (port->redrive) {
> +			port->redrive = false;
> +			pm_runtime_put(&sw->dev);
> +			tb_port_dbg(port, "exit redrive mode\n");
> +		}
> +	}
> +}
> +
>  static void tb_dp_resource_unavailable(struct tb *tb, struct tb_port
> *port, const char *reason)
>  {
> @@ -2987,6 +3018,7 @@ static int tb_start(struct tb *tb, bool reset)
>  	tb_create_usb3_tunnels(tb->root_switch);
>  	/* Add DP IN resources for the root switch */
>  	tb_add_dp_resources(tb->root_switch);
> +	tb_switch_enter_redrive(tb->root_switch);
>  	/* Make the discovered switches available to the userspace */
>  	device_for_each_child(&tb->root_switch->dev, NULL,
>  			      tb_scan_finalize_switch);
> @@ -3002,6 +3034,7 @@ static int tb_suspend_noirq(struct tb *tb)
>  
>  	tb_dbg(tb, "suspending...\n");
>  	tb_disconnect_and_release_dp(tb);
> +	tb_switch_exit_redrive(tb->root_switch);
>  	tb_switch_suspend(tb->root_switch, false);
>  	tcm->hotplug_active = false; /* signal tb_handle_hotplug to
> quit */ tb_dbg(tb, "suspend finished\n");
> @@ -3094,6 +3127,7 @@ static int tb_resume_noirq(struct tb *tb)
>  		tb_dbg(tb, "tunnels restarted, sleeping for
> 100ms\n"); msleep(100);
>  	}
> +	tb_switch_enter_redrive(tb->root_switch);
>  	 /* Allow tb_handle_hotplug to progress events */
>  	tcm->hotplug_active = true;
>  	tb_dbg(tb, "resume finished\n");
> @@ -3157,6 +3191,8 @@ static int tb_runtime_suspend(struct tb *tb)
>  	struct tb_cm *tcm = tb_priv(tb);
>  
>  	mutex_lock(&tb->lock);
> +	tb_disconnect_and_release_dp(tb);
> +	tb_switch_exit_redrive(tb->root_switch);
>  	tb_switch_suspend(tb->root_switch, true);
>  	tcm->hotplug_active = false;
>  	mutex_unlock(&tb->lock);
> @@ -3188,6 +3224,7 @@ static int tb_runtime_resume(struct tb *tb)
>  	tb_restore_children(tb->root_switch);
>  	list_for_each_entry_safe(tunnel, n, &tcm->tunnel_list, list)
>  		tb_tunnel_activate(tunnel);
> +	tb_switch_enter_redrive(tb->root_switch);
>  	tcm->hotplug_active = true;
>  	mutex_unlock(&tb->lock);
>  

Attached are the test results (including dmesg log) after testing with
our version of the 6.8 kernel with this patch applied. Sadly we didn't
have time to test with 6.11.2 as the machines we were testing on had to
be shipped to customers and we found a working stop-gap solution in the
mean time. The test that we did, along with it's results, are as
follows:

1. Start with Laptop powered-off
2. Unplug all USB-C connectors.
3. Attempt to update firmware using Windows.
   Version remains 'thunderbolt 0000:06:00.0: 0: NVM version 14.86'
4. Boot Kubuntu 24.04 with patched kernel, add cmdline parameter
thunderbolt.dyndbg=+p Note that a "thunderbolt.kf_force_redrive=1"
kernel parameter was also included by mistake, but it is ignored in
this kernel. (That was a leftover of a testing kernel we made.)
5. Log in to normal SDDM to KDE 5.27.11.
6. Open 'Display Settings KCM' to view display
   detection.
7. Plug in 2 x UBC-C connectors attached to 4k displays.
    - Note these work with Kernel 6.1 and non-Barlow Ridge systems (TB
      4). 
    - Displays wake up, but never show graphics signal. They timeout
      and resume powersave mode.
    - Displays never appear in 'Display Settings KCM.'
    - This is NOT desired behavior; displays should show.
8. Open a terminal and run 'lspci -k' 
    - Both displays are activated and remain active.
    - There is no timeout.
    - This is desired behavior.
9. Unplug USB-C connectors on at a time.
    - System recognizes unplug, retains other display
    - This is desired behavior.
10. Replug USB-C #1 attached to 4k display
    - System does not show reattached display
    - This is NOT desired behavior; display should show.
11. Replug USB-C #2
    - System does not show reattached display
    - This is NOT desired behavior; display should show.
12. Sleep and resume laptop (this powers-down and repowers USB-C)
    - Displays are restored in 'Display Settings KCM'
    - Displays show graphical output
    - Display remain connected
    - This is desired behavior.
13. Replug cables again
    - Displays now are removed and shown as expected.
    - This is desired behavior.
14. Write dmesg log attached here.

Thanks again for your assistance. We should have a dedicated testing
machine in a few days, which will let us repeat our tests on the latest
stable upstream kernel.

--MP_/=_++1Fd/UC4uZ2dD5GFiPsE
Content-Type: text/x-log
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename=2024-10-11_dmesg-thunderbolt.dynaorg+p_fw14.86.log

[    0.000000] Linux version 6.8.0-45-kfocus (root@kf-jane) (x86_64-linux-gnu-gcc-13 (Ubuntu 13.2.0-23ubuntu4) 13.2.0, GNU ld (GNU Binutils for Ubuntu) 2.42) #45+kfocus2 SMP PREEMPT_DYNAMIC Fri Oct 11 10:55:49 PDT 2024 (Ubuntu 6.8.0-45.45+kfocus2-kfocus 6.8.12)
[    0.000000] Command line: BOOT_IMAGE=/@boot/vmlinuz-6.8.0-45-kfocus root=UUID=9c2a749a-d478-4e57-b7a7-f4d8c5de2902 ro rootflags=subvol=@ quiet cryptdevice=UUID=10f3ea80-0841-49c9-8f38-b720275ff4e1:luks-10f3ea80-0841-49c9-8f38-b720275ff4e1 root=/dev/mapper/luks-10f3ea80-0841-49c9-8f38-b720275ff4e1 splash thunderbolt.kf_force_redrive=1 modprobe.blacklist=nouveau modprobe.blacklist=ucsi_acpi tpm_tis.interrupts=0 intel_pstate=passive snd_hda_core.gpu_bind=0 pci=noaer loglevel=3 vt.handoff=7 thunderbolt.dyndbg=+p
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
[    0.000000] efi: ACPI=0x33afe000 ACPI 2.0=0x33afe014 TPMFinalLog=0x33866000 SMBIOS=0x2efda000 MEMATTR=0x27a20118 ESRT=0x28a15018 MOKvar=0x2ef86000 INITRD=0x27b1cf98 RNG=0x33a24018 TPMEventLog=0x278b1018 
[    0.000000] random: crng init done
[    0.000000] efi: Remove mem115: MMIO range=[0xc0000000-0xcfffffff] (256MB) from e820 map
[    0.000000] e820: remove [mem 0xc0000000-0xcfffffff] reserved
[    0.000000] efi: Remove mem117: MMIO range=[0xff000000-0xffffffff] (16MB) from e820 map
[    0.000000] e820: remove [mem 0xff000000-0xffffffff] reserved
[    0.000000] secureboot: Secure boot disabled
[    0.000000] SMBIOS 3.4 present.
[    0.000000] DMI: Notebook X370SNx1/X370SNx1, BIOS 1.07.03aMIN29 09/18/2024
[    0.000000] tsc: Detected 2400.000 MHz processor
[    0.000000] tsc: Detected 2419.200 MHz TSC
[    0.000008] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000012] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000021] last_pfn = 0x18bf800 max_arch_pfn = 0x400000000
[    0.000027] MTRR map: 5 entries (3 fixed + 2 variable; max 23), built from 10 variable MTRRs
[    0.000030] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.000805] last_pfn = 0x33b00 max_arch_pfn = 0x400000000
[    0.009586] esrt: Reserving ESRT space from 0x0000000028a15018 to 0x0000000028a150a0.
[    0.009595] e820: update [mem 0x28a15000-0x28a15fff] usable ==> reserved
[    0.009623] Using GB pages for direct mapping
[    0.009948] secureboot: Secure boot disabled
[    0.009949] RAMDISK: [mem 0x0c15a000-0x15db0fff]
[    0.010496] ACPI: Early table checksum verification disabled
[    0.010501] ACPI: RSDP 0x0000000033AFE014 000024 (v02 INSYDE)
[    0.010506] ACPI: XSDT 0x0000000033A38188 00012C (v01 INSYDE ADL      00000002      01000013)
[    0.010515] ACPI: FACP 0x0000000033ADB000 000114 (v06 INSYDE ADL      00000002 ACPI 00040000)
[    0.010522] ACPI: DSDT 0x0000000033A4E000 089652 (v02 INSYDE ADL      00000002 ACPI 00040000)
[    0.010527] ACPI: FACS 0x000000003383E000 000040
[    0.010530] ACPI: UEFI 0x000000003398E000 0001CF (v01 INSYDE H2O BIOS 00000001 ACPI 00040000)
[    0.010534] ACPI: SSDT 0x0000000033AF3000 00908F (v02 DptfTb DptfTabl 00001000 INTL 20200717)
[    0.010538] ACPI: SSDT 0x0000000033AED000 005D34 (v02 CpuRef CpuSsdt  00003000 INTL 20200717)
[    0.010542] ACPI: SSDT 0x0000000033AEA000 00276F (v02 SaSsdt SaSsdt   00003000 INTL 20200717)
[    0.010546] ACPI: SSDT 0x0000000033AE6000 00328B (v02 INTEL  IgfxSsdt 00003000 INTL 20200717)
[    0.010549] ACPI: SSDT 0x0000000033AE5000 00077B (v02 INSYDE Tpm2Tabl 00001000 INTL 20200717)
[    0.010553] ACPI: TPM2 0x0000000033AE4000 00004C (v04 INSYDE ADL      00000002 ACPI 00040000)
[    0.010557] ACPI: SSDT 0x0000000033ADF000 003249 (v02 INTEL  DTbtSsdt 00001000 INTL 20200717)
[    0.010560] ACPI: SSDT 0x0000000033ADD000 0016A6 (v02 INSYDE UsbCTabl 00001000 INTL 20200717)
[    0.010564] ACPI: NHLT 0x0000000033ADC000 00002D (v00 INSYDE ADL      00000002 ACPI 00040000)
[    0.010567] ACPI: HPET 0x0000000033ADA000 000038 (v01 INSYDE ADL      00000002 ACPI 00040000)
[    0.010571] ACPI: APIC 0x0000000033AD9000 0001DC (v05 INSYDE ADL      00000002 ACPI 00040000)
[    0.010574] ACPI: MCFG 0x0000000033AD8000 00003C (v01 INSYDE ADL      00000002 ACPI 00040000)
[    0.010578] ACPI: SSDT 0x0000000033A48000 0054E4 (v02 INSYDE ADL      00000002      01000013)
[    0.010581] ACPI: WSMT 0x0000000033A47000 000028 (v01 INSYDE ADL      00000002 ACPI 00040000)
[    0.010585] ACPI: SSDT 0x0000000033A45000 0015FD (v02 INSYDE PtidDevc 00001000 INTL 20200717)
[    0.010589] ACPI: SSDT 0x0000000033A3B000 009573 (v02 INSYDE TbtTypeC 00000000 INTL 20200717)
[    0.010592] ACPI: DBGP 0x0000000033A3A000 000034 (v01 INSYDE ADL      00000002 ACPI 00040000)
[    0.010596] ACPI: DBG2 0x0000000033A39000 000054 (v00 INSYDE ADL      00000002 ACPI 00040000)
[    0.010599] ACPI: DMAR 0x0000000033AFD000 000088 (v01 INTEL  ICL      00000002 ACPI 00040000)
[    0.010603] ACPI: SSDT 0x0000000033A35000 002EE7 (v01 NvdRef NvdTabl  00001000 INTL 20200717)
[    0.010606] ACPI: SSDT 0x0000000033A34000 000244 (v01 NvdRef NvdExt   00001000 INTL 20200717)
[    0.010610] ACPI: SSDT 0x0000000033A33000 000640 (v01 NvdRef NvdDds   00001000 INTL 20200717)
[    0.010614] ACPI: UEFI 0x000000003383B000 00063A (v01 INTEL  RstVmdE  00000000 ACPI 00040000)
[    0.010617] ACPI: UEFI 0x000000003383A000 00005C (v01 INTEL  RstVmdV  00000000 ACPI 00040000)
[    0.010621] ACPI: SSDT 0x0000000033A31000 001057 (v02 INTEL  xh_rplsb 00000000 INTL 20200717)
[    0.010624] ACPI: SSDT 0x0000000033A2D000 0039DA (v02 SocGpe SocGpe   00003000 INTL 20200717)
[    0.010628] ACPI: SSDT 0x0000000033A29000 0039DA (v02 SocCmn SocCmn   00003000 INTL 20200717)
[    0.010631] ACPI: SSDT 0x0000000033A28000 0000F8 (v02 INSYDE PcdTabl  00001000 INTL 20200717)
[    0.010635] ACPI: FPDT 0x0000000033A27000 000044 (v01 INSYDE ADL      00000002 ACPI 00040000)
[    0.010639] ACPI: BGRT 0x0000000033A26000 000038 (v01 INSYDE H2O BIOS 00000001 ACPI 00040000)
[    0.010642] ACPI: PHAT 0x0000000033A25000 00026D (v01 INSYDE ADL      00000005 ACPI 00040000)
[    0.010645] ACPI: Reserving FACP table memory at [mem 0x33adb000-0x33adb113]
[    0.010647] ACPI: Reserving DSDT table memory at [mem 0x33a4e000-0x33ad7651]
[    0.010648] ACPI: Reserving FACS table memory at [mem 0x3383e000-0x3383e03f]
[    0.010649] ACPI: Reserving UEFI table memory at [mem 0x3398e000-0x3398e1ce]
[    0.010650] ACPI: Reserving SSDT table memory at [mem 0x33af3000-0x33afc08e]
[    0.010651] ACPI: Reserving SSDT table memory at [mem 0x33aed000-0x33af2d33]
[    0.010653] ACPI: Reserving SSDT table memory at [mem 0x33aea000-0x33aec76e]
[    0.010654] ACPI: Reserving SSDT table memory at [mem 0x33ae6000-0x33ae928a]
[    0.010655] ACPI: Reserving SSDT table memory at [mem 0x33ae5000-0x33ae577a]
[    0.010656] ACPI: Reserving TPM2 table memory at [mem 0x33ae4000-0x33ae404b]
[    0.010657] ACPI: Reserving SSDT table memory at [mem 0x33adf000-0x33ae2248]
[    0.010658] ACPI: Reserving SSDT table memory at [mem 0x33add000-0x33ade6a5]
[    0.010659] ACPI: Reserving NHLT table memory at [mem 0x33adc000-0x33adc02c]
[    0.010660] ACPI: Reserving HPET table memory at [mem 0x33ada000-0x33ada037]
[    0.010661] ACPI: Reserving APIC table memory at [mem 0x33ad9000-0x33ad91db]
[    0.010662] ACPI: Reserving MCFG table memory at [mem 0x33ad8000-0x33ad803b]
[    0.010663] ACPI: Reserving SSDT table memory at [mem 0x33a48000-0x33a4d4e3]
[    0.010664] ACPI: Reserving WSMT table memory at [mem 0x33a47000-0x33a47027]
[    0.010665] ACPI: Reserving SSDT table memory at [mem 0x33a45000-0x33a465fc]
[    0.010666] ACPI: Reserving SSDT table memory at [mem 0x33a3b000-0x33a44572]
[    0.010667] ACPI: Reserving DBGP table memory at [mem 0x33a3a000-0x33a3a033]
[    0.010668] ACPI: Reserving DBG2 table memory at [mem 0x33a39000-0x33a39053]
[    0.010669] ACPI: Reserving DMAR table memory at [mem 0x33afd000-0x33afd087]
[    0.010670] ACPI: Reserving SSDT table memory at [mem 0x33a35000-0x33a37ee6]
[    0.010671] ACPI: Reserving SSDT table memory at [mem 0x33a34000-0x33a34243]
[    0.010672] ACPI: Reserving SSDT table memory at [mem 0x33a33000-0x33a3363f]
[    0.010673] ACPI: Reserving UEFI table memory at [mem 0x3383b000-0x3383b639]
[    0.010674] ACPI: Reserving UEFI table memory at [mem 0x3383a000-0x3383a05b]
[    0.010676] ACPI: Reserving SSDT table memory at [mem 0x33a31000-0x33a32056]
[    0.010677] ACPI: Reserving SSDT table memory at [mem 0x33a2d000-0x33a309d9]
[    0.010678] ACPI: Reserving SSDT table memory at [mem 0x33a29000-0x33a2c9d9]
[    0.010679] ACPI: Reserving SSDT table memory at [mem 0x33a28000-0x33a280f7]
[    0.010680] ACPI: Reserving FPDT table memory at [mem 0x33a27000-0x33a27043]
[    0.010681] ACPI: Reserving BGRT table memory at [mem 0x33a26000-0x33a26037]
[    0.010682] ACPI: Reserving PHAT table memory at [mem 0x33a25000-0x33a2526c]
[    0.010923] No NUMA configuration found
[    0.010924] Faking a node at [mem 0x0000000000000000-0x00000018bf7fffff]
[    0.010934] NODE_DATA(0) allocated [mem 0x18bf7d5000-0x18bf7fffff]
[    0.011240] Zone ranges:
[    0.011241]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.011243]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.011245]   Normal   [mem 0x0000000100000000-0x00000018bf7fffff]
[    0.011247]   Device   empty
[    0.011249] Movable zone start for each node
[    0.011251] Early memory node ranges
[    0.011251]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.011253]   node   0: [mem 0x0000000000100000-0x000000002c228fff]
[    0.011255]   node   0: [mem 0x000000002cb29000-0x000000002e93efff]
[    0.011256]   node   0: [mem 0x0000000033aff000-0x0000000033afffff]
[    0.011257]   node   0: [mem 0x0000000100000000-0x00000018bf7fffff]
[    0.011265] Initmem setup node 0 [mem 0x0000000000001000-0x00000018bf7fffff]
[    0.011272] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.011297] On node 0, zone DMA: 97 pages in unavailable ranges
[    0.012404] On node 0, zone DMA32: 2304 pages in unavailable ranges
[    0.012586] On node 0, zone DMA32: 20928 pages in unavailable ranges
[    0.142624] On node 0, zone Normal: 17664 pages in unavailable ranges
[    0.142640] On node 0, zone Normal: 2048 pages in unavailable ranges
[    0.142710] Reserving Intel graphics memory at [mem 0x3c800000-0x407fffff]
[    0.143344] ACPI: PM-Timer IO Port: 0x1808
[    0.143355] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.143357] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.143358] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.143358] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.143359] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
[    0.143360] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[    0.143361] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
[    0.143362] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
[    0.143362] ACPI: LAPIC_NMI (acpi_id[0x09] high edge lint[0x1])
[    0.143363] ACPI: LAPIC_NMI (acpi_id[0x0a] high edge lint[0x1])
[    0.143364] ACPI: LAPIC_NMI (acpi_id[0x0b] high edge lint[0x1])
[    0.143365] ACPI: LAPIC_NMI (acpi_id[0x0c] high edge lint[0x1])
[    0.143365] ACPI: LAPIC_NMI (acpi_id[0x0d] high edge lint[0x1])
[    0.143366] ACPI: LAPIC_NMI (acpi_id[0x0e] high edge lint[0x1])
[    0.143367] ACPI: LAPIC_NMI (acpi_id[0x0f] high edge lint[0x1])
[    0.143368] ACPI: LAPIC_NMI (acpi_id[0x10] high edge lint[0x1])
[    0.143369] ACPI: LAPIC_NMI (acpi_id[0x11] high edge lint[0x1])
[    0.143369] ACPI: LAPIC_NMI (acpi_id[0x12] high edge lint[0x1])
[    0.143370] ACPI: LAPIC_NMI (acpi_id[0x13] high edge lint[0x1])
[    0.143371] ACPI: LAPIC_NMI (acpi_id[0x14] high edge lint[0x1])
[    0.143372] ACPI: LAPIC_NMI (acpi_id[0x15] high edge lint[0x1])
[    0.143372] ACPI: LAPIC_NMI (acpi_id[0x16] high edge lint[0x1])
[    0.143373] ACPI: LAPIC_NMI (acpi_id[0x17] high edge lint[0x1])
[    0.143374] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.143414] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-119
[    0.143417] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.143419] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.143423] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.143424] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.143432] e820: update [mem 0x265a8000-0x26662fff] usable ==> reserved
[    0.143443] TSC deadline timer available
[    0.143444] smpboot: Allowing 32 CPUs, 0 hotplug CPUs
[    0.143458] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.143460] PM: hibernation: Registered nosave memory: [mem 0x0009f000-0x000fffff]
[    0.143461] PM: hibernation: Registered nosave memory: [mem 0x265a8000-0x26662fff]
[    0.143463] PM: hibernation: Registered nosave memory: [mem 0x28a15000-0x28a15fff]
[    0.143464] PM: hibernation: Registered nosave memory: [mem 0x2c229000-0x2cb28fff]
[    0.143466] PM: hibernation: Registered nosave memory: [mem 0x2e93f000-0x309defff]
[    0.143466] PM: hibernation: Registered nosave memory: [mem 0x309df000-0x3398efff]
[    0.143467] PM: hibernation: Registered nosave memory: [mem 0x3398f000-0x33afefff]
[    0.143468] PM: hibernation: Registered nosave memory: [mem 0x33b00000-0x383fffff]
[    0.143469] PM: hibernation: Registered nosave memory: [mem 0x38400000-0x38dfffff]
[    0.143470] PM: hibernation: Registered nosave memory: [mem 0x38e00000-0x407fffff]
[    0.143471] PM: hibernation: Registered nosave memory: [mem 0x40800000-0xfed1ffff]
[    0.143471] PM: hibernation: Registered nosave memory: [mem 0xfed20000-0xfed7ffff]
[    0.143472] PM: hibernation: Registered nosave memory: [mem 0xfed80000-0xffffffff]
[    0.143474] [mem 0x40800000-0xfed1ffff] available for PCI devices
[    0.143475] Booting paravirtualized kernel on bare hardware
[    0.143478] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.143488] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:32 nr_cpu_ids:32 nr_node_ids:1
[    0.145368] percpu: Embedded 86 pages/cpu s229376 r8192 d114688 u524288
[    0.145374] pcpu-alloc: s229376 r8192 d114688 u524288 alloc=1*2097152
[    0.145376] pcpu-alloc: [0] 00 01 02 03 [0] 04 05 06 07 
[    0.145382] pcpu-alloc: [0] 08 09 10 11 [0] 12 13 14 15 
[    0.145388] pcpu-alloc: [0] 16 17 18 19 [0] 20 21 22 23 
[    0.145393] pcpu-alloc: [0] 24 25 26 27 [0] 28 29 30 31 
[    0.145416] Kernel command line: BOOT_IMAGE=/@boot/vmlinuz-6.8.0-45-kfocus root=UUID=9c2a749a-d478-4e57-b7a7-f4d8c5de2902 ro rootflags=subvol=@ quiet cryptdevice=UUID=10f3ea80-0841-49c9-8f38-b720275ff4e1:luks-10f3ea80-0841-49c9-8f38-b720275ff4e1 root=/dev/mapper/luks-10f3ea80-0841-49c9-8f38-b720275ff4e1 splash thunderbolt.kf_force_redrive=1 modprobe.blacklist=nouveau modprobe.blacklist=ucsi_acpi tpm_tis.interrupts=0 intel_pstate=passive snd_hda_core.gpu_bind=0 pci=noaer loglevel=3 vt.handoff=7 thunderbolt.dyndbg=+p
[    0.145644] Unknown kernel command line parameters "splash BOOT_IMAGE=/@boot/vmlinuz-6.8.0-45-kfocus cryptdevice=UUID=10f3ea80-0841-49c9-8f38-b720275ff4e1:luks-10f3ea80-0841-49c9-8f38-b720275ff4e1", will be passed to user space.
[    0.150989] Dentry cache hash table entries: 8388608 (order: 14, 67108864 bytes, linear)
[    0.153673] Inode-cache hash table entries: 4194304 (order: 13, 33554432 bytes, linear)
[    0.154061] Fallback order for Node 0: 0 
[    0.154066] Built 1 zonelists, mobility grouping on.  Total pages: 24697823
[    0.154068] Policy zone: Normal
[    0.154073] mem auto-init: stack:all(zero), heap alloc:on, heap free:off
[    0.154083] software IO TLB: area num 32.
[    0.335466] Memory: 98288380K/100360056K available (22528K kernel code, 4442K rwdata, 13892K rodata, 4976K init, 4732K bss, 2071416K reserved, 0K cma-reserved)
[    0.336882] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=32, Nodes=1
[    0.336918] ftrace: allocating 57873 entries in 227 pages
[    0.346163] ftrace: allocated 227 pages with 5 groups
[    0.346934] Dynamic Preempt: voluntary
[    0.347082] rcu: Preemptible hierarchical RCU implementation.
[    0.347084] rcu: 	RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=32.
[    0.347085] 	Trampoline variant of Tasks RCU enabled.
[    0.347086] 	Rude variant of Tasks RCU enabled.
[    0.347086] 	Tracing variant of Tasks RCU enabled.
[    0.347087] rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
[    0.347088] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=32
[    0.349670] NR_IRQS: 524544, nr_irqs: 2312, preallocated irqs: 16
[    0.350012] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.350279] Console: colour dummy device 80x25
[    0.350282] printk: legacy console [tty0] enabled
[    0.350338] ACPI: Core revision 20230628
[    0.350785] hpet: HPET dysfunctional in PC10. Force disabled.
[    0.350786] APIC: Switch to symmetric I/O mode setup
[    0.350789] DMAR: Host address width 39
[    0.350790] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
[    0.350799] DMAR: dmar0: reg_base_addr fed90000 ver 4:0 cap 1c0000c40660462 ecap 29a00f0505e
[    0.350802] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
[    0.350807] DMAR: dmar1: reg_base_addr fed91000 ver 5:0 cap d2008c40660462 ecap f050da
[    0.350809] DMAR: RMRR base: 0x0000003c000000 end: 0x000000407fffff
[    0.350812] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
[    0.350814] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
[    0.350815] DMAR-IR: Queued invalidation will be enabled to support x2apic and Intr-remapping.
[    0.352783] DMAR-IR: Enabled IRQ remapping in x2apic mode
[    0.352785] x2apic enabled
[    0.352855] APIC: Switched APIC routing to: cluster x2apic
[    0.357883] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x22df1149949, max_idle_ns: 440795312789 ns
[    0.357890] Calibrating delay loop (skipped), value calculated using timer frequency.. 4838.40 BogoMIPS (lpj=2419200)
[    0.357956] CPU0: Thermal monitoring enabled (TM1)
[    0.357959] x86/cpu: User Mode Instruction Prevention (UMIP) activated
[    0.358109] process: using mwait in idle threads
[    0.358113] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[    0.358114] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[    0.358117] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.358122] Spectre V2 : Mitigation: Enhanced / Automatic IBRS
[    0.358123] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.358124] Spectre V2 : Spectre v2 / PBRSB-eIBRS: Retire a single CALL on VMEXIT
[    0.358126] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
[    0.358129] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
[    0.358130] Register File Data Sampling: Mitigation: Clear Register File
[    0.358141] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.358142] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.358143] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.358144] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys User registers'
[    0.358145] x86/fpu: Supporting XSAVE feature 0x800: 'Control-flow User registers'
[    0.358146] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.358148] x86/fpu: xstate_offset[9]:  832, xstate_sizes[9]:    8
[    0.358149] x86/fpu: xstate_offset[11]:  840, xstate_sizes[11]:   16
[    0.358150] x86/fpu: Enabled xstate features 0xa07, context size is 856 bytes, using 'compacted' format.
[    0.358888] Freeing SMP alternatives memory: 48K
[    0.358888] pid_max: default: 32768 minimum: 301
[    0.358888] LSM: initializing lsm=lockdown,capability,landlock,yama,apparmor,integrity
[    0.358888] landlock: Up and running.
[    0.358888] Yama: becoming mindful.
[    0.358888] AppArmor: AppArmor initialized
[    0.358888] Mount-cache hash table entries: 131072 (order: 8, 1048576 bytes, linear)
[    0.358888] Mountpoint-cache hash table entries: 131072 (order: 8, 1048576 bytes, linear)
[    0.358888] smpboot: CPU0: Intel(R) Core(TM) i9-14900HX (family: 0x6, model: 0xb7, stepping: 0x1)
[    0.358888] RCU Tasks: Setting shift to 5 and lim to 1 rcu_task_cb_adjust=1.
[    0.358888] RCU Tasks Rude: Setting shift to 5 and lim to 1 rcu_task_cb_adjust=1.
[    0.358888] RCU Tasks Trace: Setting shift to 5 and lim to 1 rcu_task_cb_adjust=1.
[    0.358888] Performance Events: XSAVE Architectural LBR, PEBS fmt4+-baseline,  AnyThread deprecated, Alderlake Hybrid events, 32-deep LBR, full-width counters, Intel PMU driver.
[    0.358888] core: cpu_core PMU driver: 
[    0.358888] ... version:                5
[    0.358888] ... bit width:              48
[    0.358888] ... generic registers:      8
[    0.358888] ... value mask:             0000ffffffffffff
[    0.358888] ... max period:             00007fffffffffff
[    0.358888] ... fixed-purpose events:   4
[    0.358888] ... event mask:             0001000f000000ff
[    0.358888] signal: max sigframe size: 3632
[    0.358888] Estimated ratio of average max frequency by base frequency (times 1024): 2218
[    0.358888] rcu: Hierarchical SRCU implementation.
[    0.358888] rcu: 	Max phase no-delay instances is 400.
[    0.360315] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    0.360599] smp: Bringing up secondary CPUs ...
[    0.360705] smpboot: x86: Booting SMP configuration:
[    0.360706] .... node  #0, CPUs:        #2  #4  #6  #8 #10 #12 #14 #16 #17 #18 #19 #20 #21 #22 #23 #24 #25 #26 #27 #28 #29 #30 #31
[    0.008697] core: cpu_atom PMU driver: PEBS-via-PT 
[    0.008697] ... version:                5
[    0.008697] ... bit width:              48
[    0.008697] ... generic registers:      6
[    0.008697] ... value mask:             0000ffffffffffff
[    0.008697] ... max period:             00007fffffffffff
[    0.008697] ... fixed-purpose events:   3
[    0.008697] ... event mask:             000000070000003f
[    0.374963]   #1  #3  #5  #7  #9 #11 #13 #15
[    0.383962] smp: Brought up 1 node, 32 CPUs
[    0.383962] smpboot: Max logical packages: 1
[    0.383962] smpboot: Total of 32 processors activated (154828.80 BogoMIPS)
[    0.388010] devtmpfs: initialized
[    0.388010] x86/mm: Memory block size: 2048MB
[    0.389633] ACPI: PM: Registering ACPI NVS region [mem 0x309df000-0x3398efff] (50003968 bytes)
[    0.390248] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.390303] futex hash table entries: 8192 (order: 7, 524288 bytes, linear)
[    0.390427] pinctrl core: initialized pinctrl subsystem
[    0.390678] PM: RTC time: 19:50:08, date: 2024-10-11
[    0.391253] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.391832] DMA: preallocated 4096 KiB GFP_KERNEL pool for atomic allocations
[    0.392258] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[    0.392631] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[    0.392642] audit: initializing netlink subsys (disabled)
[    0.392653] audit: type=2000 audit(1728676208.034:1): state=initialized audit_enabled=0 res=1
[    0.392653] thermal_sys: Registered thermal governor 'fair_share'
[    0.392653] thermal_sys: Registered thermal governor 'bang_bang'
[    0.392653] thermal_sys: Registered thermal governor 'step_wise'
[    0.392653] thermal_sys: Registered thermal governor 'user_space'
[    0.392653] thermal_sys: Registered thermal governor 'power_allocator'
[    0.392653] EISA bus registered
[    0.392653] cpuidle: using governor ladder
[    0.392897] cpuidle: using governor menu
[    0.392922] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.393085] PCI: ECAM [mem 0xc0000000-0xce0fffff] (base 0xc0000000) for domain 0000 [bus 00-e0]
[    0.393102] PCI: Using configuration type 1 for base access
[    0.393304] kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
[    0.393894] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    0.393894] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
[    0.393894] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.393894] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.394057] ACPI: Added _OSI(Module Device)
[    0.394059] ACPI: Added _OSI(Processor Device)
[    0.394060] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.394062] ACPI: Added _OSI(Processor Aggregator Device)
[    0.530820] ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PC00.MHBR], AE_NOT_FOUND (20230628/psargs-330)
[    0.530840] ACPI: Ignoring error and continuing table load
[    0.530863] ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PTID.PBAR], AE_NOT_FOUND (20230628/dsfield-500)
[    0.538580] ACPI: 18 ACPI AML tables successfully acquired and loaded
[    0.557546] ACPI: USB4 _OSC: OS supports USB3+ DisplayPort+ PCIe+ XDomain+
[    0.557549] ACPI: USB4 _OSC: OS controls USB3+ DisplayPort+ PCIe+ XDomain+
[    0.559359] ACPI: Dynamic OEM Table Load:
[    0.559373] ACPI: SSDT 0xFFFF8BCC0261B800 000394 (v02 PmRef  Cpu0Cst  00003001 INTL 20200717)
[    0.561203] ACPI: Dynamic OEM Table Load:
[    0.561211] ACPI: SSDT 0xFFFF8BCC02620000 00053F (v02 PmRef  Cpu0Ist  00003000 INTL 20200717)
[    0.563060] ACPI: Dynamic OEM Table Load:
[    0.563067] ACPI: SSDT 0xFFFF8BCC03F38C00 0001AB (v02 PmRef  Cpu0Psd  00003000 INTL 20200717)
[    0.564799] ACPI: Dynamic OEM Table Load:
[    0.564805] ACPI: SSDT 0xFFFF8BCC02622800 0004B5 (v02 PmRef  Cpu0Hwp  00003000 INTL 20200717)
[    0.567127] ACPI: Dynamic OEM Table Load:
[    0.567137] ACPI: SSDT 0xFFFF8BCC0262A000 001BAF (v02 PmRef  ApIst    00003000 INTL 20200717)
[    0.569876] ACPI: Dynamic OEM Table Load:
[    0.569884] ACPI: SSDT 0xFFFF8BCC0262E000 001038 (v02 PmRef  ApHwp    00003000 INTL 20200717)
[    0.572336] ACPI: Dynamic OEM Table Load:
[    0.572345] ACPI: SSDT 0xFFFF8BCC02628000 001349 (v02 PmRef  ApPsd    00003000 INTL 20200717)
[    0.574824] ACPI: Dynamic OEM Table Load:
[    0.574832] ACPI: SSDT 0xFFFF8BCC02631000 000FBB (v02 PmRef  ApCst    00003000 INTL 20200717)
[    0.593388] ACPI: _OSC evaluated successfully for all CPUs
[    0.593466] ACPI: EC: EC started
[    0.593467] ACPI: EC: interrupt blocked
[    0.617683] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.617686] ACPI: \_SB_.PC00.LPCB.EC__: Boot DSDT EC used to handle transactions
[    0.617688] ACPI: Interpreter enabled
[    0.617772] ACPI: PM: (supports S0 S3 S4 S5)
[    0.617773] ACPI: Using IOAPIC for interrupt routing
[    0.620186] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.620188] PCI: Ignoring E820 reservations for host bridge windows
[    0.621956] ACPI: Enabled 11 GPEs in block 00 to 7F
[    0.624272] ACPI: \_SB_.PC00.PEG2.PG00: New power resource
[    0.651942] ACPI: \_SB_.PC00.XHCI.RHUB.HS14.BTRT: New power resource
[    0.651967] ACPI: \_SB_.PC00.XHCI.RHUB.HS14.DBTR: New power resource
[    0.661854] ACPI: \_SB_.PC00.CNVW.WRST: New power resource
[    0.667319] ACPI: \_SB_.PC00.RP09.PXP_: New power resource
[    0.692956] ACPI: \PIN_: New power resource
[    0.693385] ACPI: PCI Root Bridge [PC00] (domain 0000 [bus 00-e0])
[    0.693392] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
[    0.697231] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotplug PME PCIeCapability LTR DPC]
[    0.703086] PCI host bridge to bus 0000:00
[    0.703089] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.703091] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.703093] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.703095] pci_bus 0000:00: root bus resource [mem 0x40800000-0xbfffffff window]
[    0.703096] pci_bus 0000:00: root bus resource [mem 0x4000000000-0x7fffffffff window]
[    0.703099] pci_bus 0000:00: root bus resource [bus 00-e0]
[    0.703136] pci 0000:00:00.0: [8086:a702] type 00 class 0x060000 conventional PCI endpoint
[    0.703275] pci 0000:00:01.0: [8086:a70d] type 01 class 0x060400 PCIe Root Port
[    0.703292] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.703352] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    0.703377] pci 0000:00:01.0: PTM enabled (root), 4ns granularity
[    0.704153] pci 0000:00:01.1: [8086:a72d] type 01 class 0x060400 PCIe Root Port
[    0.704170] pci 0000:00:01.1: PCI bridge to [bus 02]
[    0.704173] pci 0000:00:01.1:   bridge window [io  0x3000-0x3fff]
[    0.704176] pci 0000:00:01.1:   bridge window [mem 0x4e000000-0x4f0fffff]
[    0.704182] pci 0000:00:01.1:   bridge window [mem 0x6000000000-0x6401ffffff 64bit pref]
[    0.704233] pci 0000:00:01.1: PME# supported from D0 D3hot D3cold
[    0.704258] pci 0000:00:01.1: PTM enabled (root), 4ns granularity
[    0.704997] pci 0000:00:02.0: [8086:a788] type 00 class 0x030000 PCIe Root Complex Integrated Endpoint
[    0.705007] pci 0000:00:02.0: BAR 0 [mem 0x6404000000-0x6404ffffff 64bit]
[    0.705014] pci 0000:00:02.0: BAR 2 [mem 0x4000000000-0x400fffffff 64bit pref]
[    0.705018] pci 0000:00:02.0: BAR 4 [io  0x4000-0x403f]
[    0.705036] pci 0000:00:02.0: DMAR: Skip IOMMU disabling for graphics
[    0.705039] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.705068] pci 0000:00:02.0: VF BAR 0 [mem 0x00000000-0x00ffffff 64bit]
[    0.705070] pci 0000:00:02.0: VF BAR 0 [mem 0x00000000-0x06ffffff 64bit]: contains BAR 0 for 7 VFs
[    0.705076] pci 0000:00:02.0: VF BAR 2 [mem 0x00000000-0x1fffffff 64bit pref]
[    0.705077] pci 0000:00:02.0: VF BAR 2 [mem 0x00000000-0xdfffffff 64bit pref]: contains BAR 2 for 7 VFs
[    0.705262] pci 0000:00:04.0: [8086:a71d] type 00 class 0x118000 conventional PCI endpoint
[    0.705279] pci 0000:00:04.0: BAR 0 [mem 0x6405200000-0x640521ffff 64bit]
[    0.705619] pci 0000:00:06.0: [8086:09ab] type 00 class 0x088000 conventional PCI endpoint
[    0.706391] pci 0000:00:08.0: [8086:a74f] type 00 class 0x088000 conventional PCI endpoint
[    0.706402] pci 0000:00:08.0: BAR 0 [mem 0x6405241000-0x6405241fff 64bit]
[    0.706518] pci 0000:00:0a.0: [8086:a77d] type 00 class 0x118000 PCIe Root Complex Integrated Endpoint
[    0.706527] pci 0000:00:0a.0: BAR 0 [mem 0x6405220000-0x6405227fff 64bit]
[    0.706546] pci 0000:00:0a.0: enabling Extended Tags
[    0.706655] pci 0000:00:0e.0: [8086:a77f] type 00 class 0x010400 PCIe Root Complex Integrated Endpoint
[    0.706670] pci 0000:00:0e.0: BAR 0 [mem 0x6402000000-0x6403ffffff 64bit]
[    0.706678] pci 0000:00:0e.0: BAR 2 [mem 0x4c000000-0x4dffffff]
[    0.706693] pci 0000:00:0e.0: BAR 4 [mem 0x6405100000-0x64051fffff 64bit]
[    0.707011] pci 0000:00:14.0: [8086:7a60] type 00 class 0x0c0330 conventional PCI endpoint
[    0.707032] pci 0000:00:14.0: BAR 0 [mem 0x4f380000-0x4f38ffff 64bit]
[    0.707116] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.707697] pci 0000:00:14.2: [8086:7a27] type 00 class 0x050000 conventional PCI endpoint
[    0.707722] pci 0000:00:14.2: BAR 0 [mem 0x6405238000-0x640523bfff 64bit]
[    0.707738] pci 0000:00:14.2: BAR 2 [mem 0x6405240000-0x6405240fff 64bit]
[    0.707896] pci 0000:00:14.3: [8086:7a70] type 00 class 0x028000 PCIe Root Complex Integrated Endpoint
[    0.707941] pci 0000:00:14.3: BAR 0 [mem 0x6405234000-0x6405237fff 64bit]
[    0.708110] pci 0000:00:14.3: PME# supported from D0 D3hot D3cold
[    0.708536] pci 0000:00:15.0: [8086:7a4c] type 00 class 0x0c8000 conventional PCI endpoint
[    0.708606] pci 0000:00:15.0: BAR 0 [mem 0x00000000-0x00000fff 64bit]
[    0.709171] pci 0000:00:15.1: [8086:7a4d] type 00 class 0x0c8000 conventional PCI endpoint
[    0.709242] pci 0000:00:15.1: BAR 0 [mem 0x00000000-0x00000fff 64bit]
[    0.709703] pci 0000:00:16.0: [8086:7a68] type 00 class 0x078000 conventional PCI endpoint
[    0.709726] pci 0000:00:16.0: BAR 0 [mem 0x640523d000-0x640523dfff 64bit]
[    0.709811] pci 0000:00:16.0: PME# supported from D3hot
[    0.710379] pci 0000:00:1c.0: [8086:7a3e] type 01 class 0x060400 PCIe Root Port
[    0.710411] pci 0000:00:1c.0: PCI bridge to [bus 03]
[    0.710418] pci 0000:00:1c.0:   bridge window [mem 0x4f100000-0x4f2fffff]
[    0.710513] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.710554] pci 0000:00:1c.0: PTM enabled (root), 4ns granularity
[    0.711395] pci 0000:00:1d.0: [8086:7a30] type 01 class 0x060400 PCIe Root Port
[    0.711426] pci 0000:00:1d.0: PCI bridge to [bus 04-54]
[    0.711433] pci 0000:00:1d.0:   bridge window [mem 0x44000000-0x4bffffff]
[    0.711443] pci 0000:00:1d.0:   bridge window [mem 0x6410000000-0x74100fffff 64bit pref]
[    0.711584] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    0.712465] pci 0000:00:1f.0: [8086:7a0c] type 00 class 0x060100 conventional PCI endpoint
[    0.712893] pci 0000:00:1f.3: [8086:7a50] type 00 class 0x040300 conventional PCI endpoint
[    0.712937] pci 0000:00:1f.3: BAR 0 [mem 0x6405230000-0x6405233fff 64bit]
[    0.712992] pci 0000:00:1f.3: BAR 4 [mem 0x6405000000-0x64050fffff 64bit]
[    0.713100] pci 0000:00:1f.3: PME# supported from D3hot D3cold
[    0.713206] pci 0000:00:1f.4: [8086:7a23] type 00 class 0x0c0500 conventional PCI endpoint
[    0.713232] pci 0000:00:1f.4: BAR 0 [mem 0x640523c000-0x640523c0ff 64bit]
[    0.713263] pci 0000:00:1f.4: BAR 4 [io  0xefa0-0xefbf]
[    0.713571] pci 0000:00:1f.5: [8086:7a24] type 00 class 0x0c8000 conventional PCI endpoint
[    0.713592] pci 0000:00:1f.5: BAR 0 [mem 0xfe010000-0xfe010fff]
[    0.713742] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.713790] acpiphp: Slot [1] registered
[    0.713807] pci 0000:02:00.0: [10de:2757] type 00 class 0x030000 PCIe Legacy Endpoint
[    0.713816] pci 0000:02:00.0: BAR 0 [mem 0x4e000000-0x4effffff]
[    0.713823] pci 0000:02:00.0: BAR 1 [mem 0x6000000000-0x63ffffffff 64bit pref]
[    0.713831] pci 0000:02:00.0: BAR 3 [mem 0x6400000000-0x6401ffffff 64bit pref]
[    0.713835] pci 0000:02:00.0: BAR 5 [io  0x3000-0x307f]
[    0.713840] pci 0000:02:00.0: ROM [mem 0xfff80000-0xffffffff pref]
[    0.713893] pci 0000:02:00.0: PME# supported from D0 D3hot
[    0.713960] pci 0000:02:00.0: 126.024 Gb/s available PCIe bandwidth, limited by 16.0 GT/s PCIe x8 link at 0000:00:01.1 (capable of 252.048 Gb/s with 16.0 GT/s PCIe x16 link)
[    0.714224] pci 0000:02:00.1: [10de:22bb] type 00 class 0x040300 PCIe Endpoint
[    0.714234] pci 0000:02:00.1: BAR 0 [mem 0x4f000000-0x4f003fff]
[    0.714350] pci 0000:00:01.1: PCI bridge to [bus 02]
[    0.714492] pci 0000:03:00.0: [8086:3102] type 00 class 0x020000 PCIe Endpoint
[    0.714517] pci 0000:03:00.0: BAR 0 [mem 0x4f100000-0x4f1fffff]
[    0.714555] pci 0000:03:00.0: BAR 3 [mem 0x4f200000-0x4f203fff]
[    0.714714] pci 0000:03:00.0: PME# supported from D0 D3hot D3cold
[    0.714976] pci 0000:00:1c.0: PCI bridge to [bus 03]
[    0.715081] pci 0000:04:00.0: [8086:5780] type 01 class 0x060400 PCIe Switch Upstream Port
[    0.715122] pci 0000:04:00.0: PCI bridge to [bus 05-54]
[    0.715133] pci 0000:04:00.0:   bridge window [mem 0x44000000-0x4befffff]
[    0.715147] pci 0000:04:00.0:   bridge window [mem 0x6410000000-0x74100fffff 64bit pref]
[    0.715164] pci 0000:04:00.0: enabling Extended Tags
[    0.715301] pci 0000:04:00.0: supports D1 D2
[    0.715302] pci 0000:04:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.715687] pci 0000:00:1d.0: PCI bridge to [bus 04-54]
[    0.715810] pci 0000:05:00.0: [8086:5780] type 01 class 0x060400 PCIe Switch Downstream Port
[    0.715851] pci 0000:05:00.0: PCI bridge to [bus 06]
[    0.715875] pci 0000:05:00.0:   bridge window [mem 0x7410000000-0x74100fffff 64bit pref]
[    0.715892] pci 0000:05:00.0: enabling Extended Tags
[    0.716021] pci 0000:05:00.0: supports D1 D2
[    0.716022] pci 0000:05:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.716301] pci 0000:05:01.0: [8086:5780] type 01 class 0x060400 PCIe Switch Downstream Port
[    0.716342] pci 0000:05:01.0: PCI bridge to [bus 07-2c]
[    0.716353] pci 0000:05:01.0:   bridge window [mem 0x48000000-0x4befffff]
[    0.716384] pci 0000:05:01.0: enabling Extended Tags
[    0.716521] pci 0000:05:01.0: supports D1 D2
[    0.716522] pci 0000:05:01.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.716797] pci 0000:05:02.0: [8086:5780] type 01 class 0x060400 PCIe Switch Downstream Port
[    0.716838] pci 0000:05:02.0: PCI bridge to [bus 2d]
[    0.716849] pci 0000:05:02.0:   bridge window [mem 0x47f00000-0x47ffffff]
[    0.716879] pci 0000:05:02.0: enabling Extended Tags
[    0.717007] pci 0000:05:02.0: supports D1 D2
[    0.717008] pci 0000:05:02.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.717283] pci 0000:05:03.0: [8086:5780] type 01 class 0x060400 PCIe Switch Downstream Port
[    0.717324] pci 0000:05:03.0: PCI bridge to [bus 2e-54]
[    0.717335] pci 0000:05:03.0:   bridge window [mem 0x44000000-0x47efffff]
[    0.717366] pci 0000:05:03.0: enabling Extended Tags
[    0.717502] pci 0000:05:03.0: supports D1 D2
[    0.717504] pci 0000:05:03.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.717787] pci 0000:04:00.0: PCI bridge to [bus 05-54]
[    0.717894] pci 0000:06:00.0: [8086:5781] type 00 class 0x0c0340 PCIe Endpoint
[    0.717921] pci 0000:06:00.0: BAR 0 [mem 0x7410000000-0x741003ffff 64bit pref]
[    0.717939] pci 0000:06:00.0: BAR 2 [mem 0x7410040000-0x7410040fff 64bit pref]
[    0.717981] pci 0000:06:00.0: enabling Extended Tags
[    0.718096] pci 0000:06:00.0: supports D1 D2
[    0.718098] pci 0000:06:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.718332] pci 0000:05:00.0: PCI bridge to [bus 06]
[    0.718404] pci 0000:05:01.0: PCI bridge to [bus 07-2c]
[    0.718512] pci 0000:2d:00.0: [8086:5782] type 00 class 0x0c0330 PCIe Endpoint
[    0.718535] pci 0000:2d:00.0: BAR 0 [mem 0x47f00000-0x47f0ffff 64bit]
[    0.718584] pci 0000:2d:00.0: enabling Extended Tags
[    0.718668] pci 0000:2d:00.0: PME# supported from D3hot D3cold
[    0.718707] pci 0000:2d:00.0: 8.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:05:02.0 (capable of 31.504 Gb/s with 8.0 GT/s PCIe x4 link)
[    0.718819] pci 0000:05:02.0: PCI bridge to [bus 2d]
[    0.718890] pci 0000:05:03.0: PCI bridge to [bus 2e-54]
[    0.743346] ACPI: EC: interrupt unblocked
[    0.743348] ACPI: EC: event unblocked
[    0.743888] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.743888] ACPI: EC: GPE=0x6e
[    0.743888] ACPI: \_SB_.PC00.LPCB.EC__: Boot DSDT EC initialization complete
[    0.743888] ACPI: \_SB_.PC00.LPCB.EC__: EC: Used to handle transactions and events
[    0.743919] iommu: Default domain type: Translated
[    0.743919] iommu: DMA domain TLB invalidation policy: lazy mode
[    0.744086] SCSI subsystem initialized
[    0.744105] libata version 3.00 loaded.
[    0.744105] ACPI: bus type USB registered
[    0.744105] usbcore: registered new interface driver usbfs
[    0.744105] usbcore: registered new interface driver hub
[    0.744105] usbcore: registered new device driver usb
[    0.744105] pps_core: LinuxPPS API ver. 1 registered
[    0.744105] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.744105] PTP clock support registered
[    0.744105] EDAC MC: Ver: 3.0.0
[    0.744891] efivars: Registered efivars operations
[    0.745200] NetLabel: Initializing
[    0.745201] NetLabel:  domain hash size = 128
[    0.745203] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.745234] NetLabel:  unlabeled traffic allowed by default
[    0.745254] mctp: management component transport protocol core
[    0.745254] NET: Registered PF_MCTP protocol family
[    0.745254] PCI: Using ACPI for IRQ routing
[    0.761546] PCI: pci_cache_line_size set to 64 bytes
[    0.761704] pci 0000:00:1f.5: BAR 0 [mem 0xfe010000-0xfe010fff]: can't claim; no compatible bridge window
[    0.761854] e820: reserve RAM buffer [mem 0x0009f000-0x0009ffff]
[    0.761858] e820: reserve RAM buffer [mem 0x265a8000-0x27ffffff]
[    0.761859] e820: reserve RAM buffer [mem 0x28a15000-0x2bffffff]
[    0.761861] e820: reserve RAM buffer [mem 0x2c229000-0x2fffffff]
[    0.761863] e820: reserve RAM buffer [mem 0x2e93f000-0x2fffffff]
[    0.761864] e820: reserve RAM buffer [mem 0x33b00000-0x33ffffff]
[    0.761865] e820: reserve RAM buffer [mem 0x18bf800000-0x18bfffffff]
[    0.761917] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    0.761917] pci 0000:00:02.0: vgaarb: bridge control possible
[    0.761917] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    0.761917] pci 0000:02:00.0: vgaarb: bridge control possible
[    0.761917] pci 0000:02:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
[    0.761917] vgaarb: loaded
[    0.762091] clocksource: Switched to clocksource tsc-early
[    0.762417] VFS: Disk quotas dquot_6.6.0
[    0.762437] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.762576] AppArmor: AppArmor Filesystem Enabled
[    0.762614] pnp: PnP ACPI init
[    0.762894] pnp 00:00: disabling [io  0x3322-0x3323] because it overlaps 0000:00:01.1 BAR 13 [io  0x3000-0x3fff]
[    0.763096] system 00:02: [io  0x1854-0x1857] has been reserved
[    0.780484] pnp 00:05: disabling [mem 0xc0000000-0xcfffffff] because it overlaps 0000:00:02.0 BAR 9 [mem 0x00000000-0xdfffffff 64bit pref]
[    0.780514] system 00:05: [mem 0xfedc0000-0xfedc7fff] has been reserved
[    0.780516] system 00:05: [mem 0xfeda0000-0xfeda0fff] has been reserved
[    0.780518] system 00:05: [mem 0xfeda1000-0xfeda1fff] has been reserved
[    0.780520] system 00:05: [mem 0xfed20000-0xfed7ffff] could not be reserved
[    0.780521] system 00:05: [mem 0xfed90000-0xfed93fff] could not be reserved
[    0.780523] system 00:05: [mem 0xfed45000-0xfed8ffff] could not be reserved
[    0.780524] system 00:05: [mem 0xfee00000-0xfeefffff] has been reserved
[    0.780925] system 00:06: [io  0x2000-0x20fe] has been reserved
[    0.782169] pnp: PnP ACPI: found 8 devices
[    0.788194] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.788286] NET: Registered PF_INET protocol family
[    0.788519] IP idents hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.804667] tcp_listen_portaddr_hash hash table entries: 65536 (order: 8, 1048576 bytes, linear)
[    0.804746] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    0.805093] TCP established hash table entries: 524288 (order: 10, 4194304 bytes, linear)
[    0.805591] TCP bind hash table entries: 65536 (order: 9, 2097152 bytes, linear)
[    0.805738] TCP: Hash tables configured (established 524288 bind 65536)
[    0.805973] MPTCP token hash table entries: 65536 (order: 8, 1572864 bytes, linear)
[    0.806218] UDP hash table entries: 65536 (order: 9, 2097152 bytes, linear)
[    0.806507] UDP-Lite hash table entries: 65536 (order: 9, 2097152 bytes, linear)
[    0.806677] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.806684] NET: Registered PF_XDP protocol family
[    0.806688] pci 0000:02:00.0: ROM [mem 0xfff80000-0xffffffff pref]: can't claim; no compatible bridge window
[    0.806695] pci_bus 0000:00: max bus depth: 3 pci_try_num: 4
[    0.806709] pci 0000:00:02.0: VF BAR 2 [mem 0x4020000000-0x40ffffffff 64bit pref]: assigned
[    0.806712] pci 0000:00:02.0: VF BAR 0 [mem 0x4010000000-0x4016ffffff 64bit]: assigned
[    0.806715] pci 0000:00:15.0: BAR 0 [mem 0x4017000000-0x4017000fff 64bit]: assigned
[    0.806773] pci 0000:00:15.1: BAR 0 [mem 0x4017001000-0x4017001fff 64bit]: assigned
[    0.806791] pci 0000:00:1d.0: bridge window [io  0x5000-0x7fff]: assigned
[    0.806793] pci 0000:00:1f.5: BAR 0 [mem 0x40800000-0x40800fff]: assigned
[    0.806805] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.806813] pci 0000:02:00.0: ROM [mem 0x4f080000-0x4f0fffff pref]: assigned
[    0.806814] pci 0000:00:01.1: PCI bridge to [bus 02]
[    0.806816] pci 0000:00:01.1:   bridge window [io  0x3000-0x3fff]
[    0.806819] pci 0000:00:01.1:   bridge window [mem 0x4e000000-0x4f0fffff]
[    0.806821] pci 0000:00:01.1:   bridge window [mem 0x6000000000-0x6401ffffff 64bit pref]
[    0.806826] pci 0000:00:1c.0: PCI bridge to [bus 03]
[    0.806837] pci 0000:00:1c.0:   bridge window [mem 0x4f100000-0x4f2fffff]
[    0.806845] pci 0000:04:00.0: bridge window [io  0x5000-0x6fff]: assigned
[    0.806847] pci 0000:05:01.0: bridge window [mem 0x6410000000-0x64101fffff 64bit pref]: assigned
[    0.806849] pci 0000:05:03.0: bridge window [mem 0x6410200000-0x64103fffff 64bit pref]: assigned
[    0.806850] pci 0000:05:01.0: bridge window [io  0x5000-0x5fff]: assigned
[    0.806852] pci 0000:05:03.0: bridge window [io  0x6000-0x6fff]: assigned
[    0.806853] pci 0000:05:00.0: PCI bridge to [bus 06]
[    0.806877] pci 0000:05:00.0:   bridge window [mem 0x7410000000-0x74100fffff 64bit pref]
[    0.806884] pci 0000:05:01.0: PCI bridge to [bus 07-2c]
[    0.806887] pci 0000:05:01.0:   bridge window [io  0x5000-0x5fff]
[    0.806893] pci 0000:05:01.0:   bridge window [mem 0x48000000-0x4befffff]
[    0.806897] pci 0000:05:01.0:   bridge window [mem 0x6410000000-0x64101fffff 64bit pref]
[    0.806904] pci 0000:05:02.0: PCI bridge to [bus 2d]
[    0.806910] pci 0000:05:02.0:   bridge window [mem 0x47f00000-0x47ffffff]
[    0.806920] pci 0000:05:03.0: PCI bridge to [bus 2e-54]
[    0.806922] pci 0000:05:03.0:   bridge window [io  0x6000-0x6fff]
[    0.806928] pci 0000:05:03.0:   bridge window [mem 0x44000000-0x47efffff]
[    0.806932] pci 0000:05:03.0:   bridge window [mem 0x6410200000-0x64103fffff 64bit pref]
[    0.806939] pci 0000:04:00.0: PCI bridge to [bus 05-54]
[    0.806941] pci 0000:04:00.0:   bridge window [io  0x5000-0x6fff]
[    0.806947] pci 0000:04:00.0:   bridge window [mem 0x44000000-0x4befffff]
[    0.806951] pci 0000:04:00.0:   bridge window [mem 0x6410000000-0x74100fffff 64bit pref]
[    0.806958] pci 0000:00:1d.0: PCI bridge to [bus 04-54]
[    0.806960] pci 0000:00:1d.0:   bridge window [io  0x5000-0x7fff]
[    0.806964] pci 0000:00:1d.0:   bridge window [mem 0x44000000-0x4bffffff]
[    0.806967] pci 0000:00:1d.0:   bridge window [mem 0x6410000000-0x74100fffff 64bit pref]
[    0.806973] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.806975] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.806976] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    0.806977] pci_bus 0000:00: resource 7 [mem 0x40800000-0xbfffffff window]
[    0.806979] pci_bus 0000:00: resource 8 [mem 0x4000000000-0x7fffffffff window]
[    0.806980] pci_bus 0000:02: resource 0 [io  0x3000-0x3fff]
[    0.806981] pci_bus 0000:02: resource 1 [mem 0x4e000000-0x4f0fffff]
[    0.806982] pci_bus 0000:02: resource 2 [mem 0x6000000000-0x6401ffffff 64bit pref]
[    0.806984] pci_bus 0000:03: resource 1 [mem 0x4f100000-0x4f2fffff]
[    0.806985] pci_bus 0000:04: resource 0 [io  0x5000-0x7fff]
[    0.806986] pci_bus 0000:04: resource 1 [mem 0x44000000-0x4bffffff]
[    0.806987] pci_bus 0000:04: resource 2 [mem 0x6410000000-0x74100fffff 64bit pref]
[    0.806988] pci_bus 0000:05: resource 0 [io  0x5000-0x6fff]
[    0.806989] pci_bus 0000:05: resource 1 [mem 0x44000000-0x4befffff]
[    0.806990] pci_bus 0000:05: resource 2 [mem 0x6410000000-0x74100fffff 64bit pref]
[    0.806992] pci_bus 0000:06: resource 2 [mem 0x7410000000-0x74100fffff 64bit pref]
[    0.806993] pci_bus 0000:07: resource 0 [io  0x5000-0x5fff]
[    0.806994] pci_bus 0000:07: resource 1 [mem 0x48000000-0x4befffff]
[    0.806995] pci_bus 0000:07: resource 2 [mem 0x6410000000-0x64101fffff 64bit pref]
[    0.806996] pci_bus 0000:2d: resource 1 [mem 0x47f00000-0x47ffffff]
[    0.806997] pci_bus 0000:2e: resource 0 [io  0x6000-0x6fff]
[    0.806998] pci_bus 0000:2e: resource 1 [mem 0x44000000-0x47efffff]
[    0.806999] pci_bus 0000:2e: resource 2 [mem 0x6410200000-0x64103fffff 64bit pref]
[    0.809214] pci 0000:02:00.1: extending delay after power-on from D3hot to 20 msec
[    0.809240] pci 0000:02:00.1: D0 power state depends on 0000:02:00.0
[    0.809619] pci 0000:2d:00.0: enabling device (0000 -> 0002)
[    0.809653] PCI: CLS 64 bytes, default 64
[    0.809694] DMAR: No ATSR found
[    0.809695] DMAR: No SATC found
[    0.809696] DMAR: IOMMU feature fl1gp_support inconsistent
[    0.809701] DMAR: IOMMU feature pgsel_inv inconsistent
[    0.809702] DMAR: IOMMU feature nwfs inconsistent
[    0.809703] DMAR: IOMMU feature dit inconsistent
[    0.809703] DMAR: IOMMU feature sc_support inconsistent
[    0.809704] DMAR: IOMMU feature dev_iotlb_support inconsistent
[    0.809705] DMAR: dmar0: Using Queued invalidation
[    0.809708] DMAR: dmar1: Using Queued invalidation
[    0.809753] Trying to unpack rootfs image as initramfs...
[    0.810064] pci 0000:00:02.0: Adding to iommu group 0
[    0.810503] pci 0000:00:00.0: Adding to iommu group 1
[    0.810516] pci 0000:00:01.0: Adding to iommu group 2
[    0.810526] pci 0000:00:01.1: Adding to iommu group 3
[    0.810535] pci 0000:00:04.0: Adding to iommu group 4
[    0.810549] pci 0000:00:06.0: Adding to iommu group 5
[    0.810558] pci 0000:00:08.0: Adding to iommu group 6
[    0.810567] pci 0000:00:0a.0: Adding to iommu group 7
[    0.810576] pci 0000:00:0e.0: Adding to iommu group 8
[    0.810595] pci 0000:00:14.0: Adding to iommu group 9
[    0.810604] pci 0000:00:14.2: Adding to iommu group 9
[    0.810613] pci 0000:00:14.3: Adding to iommu group 10
[    0.810631] pci 0000:00:15.0: Adding to iommu group 11
[    0.810641] pci 0000:00:15.1: Adding to iommu group 11
[    0.810656] pci 0000:00:16.0: Adding to iommu group 12
[    0.810674] pci 0000:00:1c.0: Adding to iommu group 13
[    0.810703] pci 0000:00:1d.0: Adding to iommu group 14
[    0.810731] pci 0000:00:1f.0: Adding to iommu group 15
[    0.810741] pci 0000:00:1f.3: Adding to iommu group 15
[    0.810752] pci 0000:00:1f.4: Adding to iommu group 15
[    0.810762] pci 0000:00:1f.5: Adding to iommu group 15
[    0.810781] pci 0000:02:00.0: Adding to iommu group 16
[    0.810793] pci 0000:02:00.1: Adding to iommu group 16
[    0.810810] pci 0000:03:00.0: Adding to iommu group 17
[    0.810837] pci 0000:04:00.0: Adding to iommu group 18
[    0.810864] pci 0000:05:00.0: Adding to iommu group 19
[    0.810892] pci 0000:05:01.0: Adding to iommu group 20
[    0.810918] pci 0000:05:02.0: Adding to iommu group 21
[    0.810946] pci 0000:05:03.0: Adding to iommu group 22
[    0.810976] pci 0000:06:00.0: Adding to iommu group 23
[    0.811006] pci 0000:2d:00.0: Adding to iommu group 24
[    0.814330] DMAR: Intel(R) Virtualization Technology for Directed I/O
[    0.814332] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.814333] software IO TLB: mapped [mem 0x00000000210ee000-0x00000000250ee000] (64MB)
[    0.822372] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x22df1149949, max_idle_ns: 440795312789 ns
[    0.822435] clocksource: Switched to clocksource tsc
[    0.824879] Initialise system trusted keyrings
[    0.824891] Key type blacklist registered
[    0.824947] workingset: timestamp_bits=36 max_order=25 bucket_order=0
[    0.824954] zbud: loaded
[    0.825236] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.825351] fuse: init (API version 7.39)
[    0.825513] integrity: Platform Keyring initialized
[    0.825518] integrity: Machine keyring initialized
[    0.835839] Key type asymmetric registered
[    0.835841] Asymmetric key parser 'x509' registered
[    0.835858] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 243)
[    0.835931] io scheduler mq-deadline registered
[    0.836607] pcieport 0000:00:01.0: PME: Signaling with IRQ 122
[    0.836855] pcieport 0000:00:01.1: PME: Signaling with IRQ 123
[    0.837122] pcieport 0000:00:1c.0: PME: Signaling with IRQ 124
[    0.837284] pcieport 0000:00:1d.0: PME: Signaling with IRQ 125
[    0.837315] pcieport 0000:00:1d.0: pciehp: Slot #8 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
[    0.838200] pcieport 0000:05:01.0: pciehp: Slot #1 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
[    0.838796] pcieport 0000:05:03.0: pciehp: Slot #3 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
[    0.839018] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    0.839322] Monitor-Mwait will be used to enter C-1 state
[    0.839334] Monitor-Mwait will be used to enter C-2 state
[    0.839345] Monitor-Mwait will be used to enter C-3 state
[    0.839350] ACPI: \_SB_.PR00: Found 3 idle states
[    0.845989] ACPI: AC: AC Adapter [AC] (on-line)
[    0.846056] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    0.846280] ACPI: button: Power Button [PWRB]
[    0.846304] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input1
[    0.846573] ACPI: button: Sleep Button [SLPB]
[    0.846595] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input2
[    0.846877] ACPI: button: Lid Switch [LID0]
[    0.846900] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
[    0.847165] ACPI: button: Power Button [PWRF]
[    0.951734] thermal LNXTHERM:00: registered as thermal_zone0
[    0.951737] ACPI: thermal: Thermal Zone [TZ0] (25 C)
[    0.951954] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    0.953006] ACPI: battery: Slot [BAT0] (battery present)
[    0.953596] hpet_acpi_add: no address or irqs in _CRS
[    0.953629] Linux agpgart interface v0.103
[    0.955585] tpm_tis IFX1523:00: 2.0 TPM (device-id 0x1D, rev-id 54)
[    0.976989] loop: module loaded
[    0.977480] ACPI: bus type drm_connector registered
[    0.977741] tun: Universal TUN/TAP device driver, 1.6
[    0.977772] PPP generic driver version 2.4.2
[    0.977879] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[    0.981827] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.981832] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.981893] mousedev: PS/2 mouse device common for all mice
[    0.982011] rtc_cmos 00:01: RTC can wake from S4
[    0.982814] rtc_cmos 00:01: registered as rtc0
[    0.982993] rtc_cmos 00:01: setting system clock to 2024-10-11T19:50:09 UTC (1728676209)
[    0.983025] rtc_cmos 00:01: alarms up to one month, y3k, 242 bytes nvram
[    0.983032] i2c_dev: i2c /dev entries driver
[    0.985419] device-mapper: core: CONFIG_IMA_DISABLE_HTABLE is disabled. Duplicate IMA measurements will not be recorded in the IMA log.
[    0.985430] device-mapper: uevent: version 1.0.3
[    0.985482] device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) initialised: dm-devel@redhat.com
[    0.985497] platform eisa.0: Probing EISA bus 0
[    0.985503] platform eisa.0: EISA: Cannot allocate resource for mainboard
[    0.985505] platform eisa.0: Cannot allocate resource for EISA slot 1
[    0.985506] platform eisa.0: Cannot allocate resource for EISA slot 2
[    0.985507] platform eisa.0: Cannot allocate resource for EISA slot 3
[    0.985508] platform eisa.0: Cannot allocate resource for EISA slot 4
[    0.985509] platform eisa.0: Cannot allocate resource for EISA slot 5
[    0.985510] platform eisa.0: Cannot allocate resource for EISA slot 6
[    0.985511] platform eisa.0: Cannot allocate resource for EISA slot 7
[    0.985512] platform eisa.0: Cannot allocate resource for EISA slot 8
[    0.985513] platform eisa.0: EISA: Detected 0 cards
[    0.985516] intel_pstate: Intel P-state driver initializing
[    0.986354] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input4
[    0.991485] intel_pstate: HWP enabled
[    0.992799] ledtrig-cpu: registered to indicate activity on CPUs
[    0.992953] [drm] Initialized simpledrm 1.0.0 20200625 for simple-framebuffer.0 on minor 0
[    0.994411] fbcon: Deferring console take-over
[    0.994413] simple-framebuffer simple-framebuffer.0: [drm] fb0: simpledrmdrmfb frame buffer device
[    0.994510] drop_monitor: Initializing network drop monitor service
[    0.994629] NET: Registered PF_INET6 protocol family
[    1.057342] Freeing initrd memory: 160092K
[    1.064809] Segment Routing with IPv6
[    1.064839] In-situ OAM (IOAM) with IPv6
[    1.064895] NET: Registered PF_PACKET protocol family
[    1.065113] Key type dns_resolver registered
[    1.070356] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    1.072456] microcode: Current revision: 0x00000129
[    1.074596] IPI shorthand broadcast: enabled
[    1.076637] sched_clock: Marking stable (1068000801, 7697376)->(1150013944, -74315767)
[    1.077279] registered taskstats version 1
[    1.081372] Loading compiled-in X.509 certificates
[    1.082142] Loaded X.509 cert 'Build time autogenerated kernel key: 3926023fa310b7bddbfc4c635bb21a6dd408b69b'
[    1.082765] Loaded X.509 cert 'Canonical Ltd. Live Patch Signing: 14df34d1a87cf37625abec039ef2bf521249b969'
[    1.083376] Loaded X.509 cert 'Canonical Ltd. Kernel Module Signing: 88f752e560a1e0737e31163a466ad7b70a850c19'
[    1.083378] blacklist: Loading compiled-in revocation X.509 certificates
[    1.083408] Loaded X.509 cert 'Canonical Ltd. Secure Boot Signing: 61482aa2830d0ab2ad5af10b7250da9033ddcef0'
[    1.083427] Loaded X.509 cert 'Canonical Ltd. Secure Boot Signing (2017): 242ade75ac4a15e50d50c84b0d45ff3eae707a03'
[    1.083444] Loaded X.509 cert 'Canonical Ltd. Secure Boot Signing (ESM 2018): 365188c1d374d6b07c3c8f240f8ef722433d6a8b'
[    1.083461] Loaded X.509 cert 'Canonical Ltd. Secure Boot Signing (2019): c0746fd6c5da3ae827864651ad66ae47fe24b3e8'
[    1.083479] Loaded X.509 cert 'Canonical Ltd. Secure Boot Signing (2021 v1): a8d54bbb3825cfb94fa13c9f8a594a195c107b8d'
[    1.083496] Loaded X.509 cert 'Canonical Ltd. Secure Boot Signing (2021 v2): 4cf046892d6fd3c9a5b03f98d845f90851dc6a8c'
[    1.083512] Loaded X.509 cert 'Canonical Ltd. Secure Boot Signing (2021 v3): 100437bb6de6e469b581e61cd66bce3ef4ed53af'
[    1.083528] Loaded X.509 cert 'Canonical Ltd. Secure Boot Signing (Ubuntu Core 2019): c1d57b8f6b743f23ee41f4f7ee292f06eecadfb9'
[    1.087234] Key type .fscrypt registered
[    1.087236] Key type fscrypt-provisioning registered
[    1.087292] Key type trusted registered
[    1.095429] cryptd: max_cpu_qlen set to 1000
[    1.099497] AVX2 version of gcm_enc/dec engaged.
[    1.099550] AES CTR mode by8 optimization enabled
[    1.113331] Key type encrypted registered
[    1.113348] AppArmor: AppArmor sha256 policy hashing enabled
[    1.117728] integrity: Loading X.509 certificate: UEFI:db
[    1.117818] integrity: Loaded X.509 cert 'Microsoft Windows Production PCA 2011: a92902398e16c49778cd90f99e4f9ae17c55af53'
[    1.117819] integrity: Loading X.509 certificate: UEFI:db
[    1.117835] integrity: Loaded X.509 cert 'Microsoft Corporation: Windows UEFI CA 2023: aefc5fbbbe055d8f8daa585473499417ab5a5272'
[    1.117836] integrity: Loading X.509 certificate: UEFI:db
[    1.117850] integrity: Loaded X.509 cert 'Microsoft Corporation UEFI CA 2011: 13adbf4309bd82709c8cd54f316ed522988a1bd4'
[    1.117851] integrity: Loading X.509 certificate: UEFI:db
[    1.117875] integrity: Loaded X.509 cert 'Microsoft UEFI CA 2023: 81aa6b3244c935bce0d6628af39827421e32497d'
[    1.117876] integrity: Loading X.509 certificate: UEFI:db
[    1.118307] integrity: Loaded X.509 cert 'Secure Certificate: 01dcc89619884ca147983429f8a4a1a0'
[    1.118310] integrity: Loading X.509 certificate: UEFI:db
[    1.118458] integrity: Loaded X.509 cert 'Cus CA: d6136d376b87ef934511c12ce2c3880c'
[    1.126356] Loading compiled-in module X.509 certificates
[    1.126805] Loaded X.509 cert 'Build time autogenerated kernel key: 3926023fa310b7bddbfc4c635bb21a6dd408b69b'
[    1.126808] ima: Allocated hash algorithm: sha256
[    1.152033] ima: No architecture policies found
[    1.152048] evm: Initialising EVM extended attributes:
[    1.152049] evm: security.selinux
[    1.152050] evm: security.SMACK64
[    1.152051] evm: security.SMACK64EXEC
[    1.152051] evm: security.SMACK64TRANSMUTE
[    1.152052] evm: security.SMACK64MMAP
[    1.152052] evm: security.apparmor
[    1.152053] evm: security.ima
[    1.152054] evm: security.capability
[    1.152054] evm: HMAC attrs: 0x1
[    1.152395] PM:   Magic number: 12:654:849
[    1.152477] graphics fbcon: hash matches
[    1.152482] processor cpu13: hash matches
[    1.156781] RAS: Correctable Errors collector initialized.
[    1.156850] clk: Disabling unused clocks
[    1.169999] Freeing unused decrypted memory: 2028K
[    1.170942] Freeing unused kernel image (initmem) memory: 4976K
[    1.170945] Write protecting the kernel read-only data: 36864k
[    1.171772] Freeing unused kernel image (rodata/data gap) memory: 444K
[    1.180416] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    1.180420] Run /init as init process
[    1.180421]   with arguments:
[    1.180422]     /init
[    1.180423]     splash
[    1.180424]   with environment:
[    1.180424]     HOME=/
[    1.180425]     TERM=linux
[    1.180425]     BOOT_IMAGE=/@boot/vmlinuz-6.8.0-45-kfocus
[    1.180426]     cryptdevice=UUID=10f3ea80-0841-49c9-8f38-b720275ff4e1:luks-10f3ea80-0841-49c9-8f38-b720275ff4e1
[    1.265599] wmi_bus wmi_bus-PNP0C14:01: WQ00 data block query control method not found
[    1.268848] hid: raw HID events driver (C) Jiri Kosina
[    1.273954] vmd 0000:00:0e.0: PCI host bridge to bus 10000:e0
[    1.273959] pci_bus 10000:e0: root bus resource [bus e0-ff]
[    1.273961] pci_bus 10000:e0: root bus resource [mem 0x4c000000-0x4dffffff]
[    1.273963] pci_bus 10000:e0: root bus resource [mem 0x6405102000-0x64051fffff 64bit]
[    1.273988] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    1.273995] pci 10000:e0:06.0: [8086:a74d] type 01 class 0x060400 PCIe Root Port
[    1.273998] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
[    1.274014] pci 10000:e0:06.0: PCI bridge to [bus e1]
[    1.274019] pci 10000:e0:06.0:   bridge window [io  0x0000-0x0fff]
[    1.274022] pci 10000:e0:06.0:   bridge window [mem 0x4c000000-0x4c0fffff]
[    1.274071] pci 10000:e0:06.0: PME# supported from D0 D3hot D3cold
[    1.274095] pci 10000:e0:06.0: PTM enabled (root), 4ns granularity
[    1.274257] pci 10000:e0:06.0: Adding to iommu group 8
[    1.274286] pci 10000:e0:1b.0: [8086:09ab] type 00 class 0x088000 conventional PCI endpoint
[    1.274339] pci 10000:e0:1b.0: Adding to iommu group 8
[    1.274379] pci 10000:e0:1b.4: [8086:7a44] type 01 class 0x060400 PCIe Root Port
[    1.274415] pci 10000:e0:1b.4: PCI bridge to [bus e2]
[    1.274423] pci 10000:e0:1b.4:   bridge window [io  0x0000-0x0fff]
[    1.274425] pci 10000:e0:1b.4:   bridge window [mem 0x4c100000-0x4c1fffff]
[    1.274513] pci 10000:e0:1b.4: PME# supported from D0 D3hot D3cold
[    1.274557] pci 10000:e0:1b.4: PTM enabled (root), 4ns granularity
[    1.274681] pci 10000:e0:1b.4: Adding to iommu group 8
[    1.274693] pci 10000:e0:06.0: Primary bus is hard wired to 0
[    1.274745] pci 10000:e1:00.0: [144d:a808] type 00 class 0x010802 PCIe Endpoint
[    1.274765] pci 10000:e1:00.0: BAR 0 [mem 0x4c000000-0x4c003fff 64bit]
[    1.275009] pci 10000:e1:00.0: Adding to iommu group 8
[    1.275028] pci 10000:e0:06.0: PCI bridge to [bus e1]
[    1.275034] pci 10000:e0:1b.4: Primary bus is hard wired to 0
[    1.275114] pci 10000:e2:00.0: [144d:a80a] type 00 class 0x010802 PCIe Endpoint
[    1.275152] pci 10000:e2:00.0: BAR 0 [mem 0x4c100000-0x4c103fff 64bit]
[    1.275177] xhci_hcd 0000:00:14.0: hcc params 0x20007fc1 hci version 0x120 quirks 0x0000000200009810
[    1.275575] pci 10000:e2:00.0: Adding to iommu group 8
[    1.275603] pci 10000:e0:1b.4: PCI bridge to [bus e2]
[    1.275619] pci 10000:e0:06.0: Primary bus is hard wired to 0
[    1.275623] pci 10000:e0:1b.4: Primary bus is hard wired to 0
[    1.275654] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    1.275655] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
[    1.275657] xhci_hcd 0000:00:14.0: Host supports USB 3.2 Enhanced SuperSpeed
[    1.275798] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.08
[    1.275802] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.275805] usb usb1: Product: xHCI Host Controller
[    1.275806] usb usb1: Manufacturer: Linux 6.8.0-45-kfocus xhci-hcd
[    1.275807] usb usb1: SerialNumber: 0000:00:14.0
[    1.276124] hub 1-0:1.0: USB hub found
[    1.276164] hub 1-0:1.0: 16 ports detected
[    1.276987] Intel(R) 2.5G Ethernet Linux Driver
[    1.276989] Copyright(c) 2018 Intel Corporation.
[    1.277281] igc 0000:03:00.0: PTM enabled, 4ns granularity
[    1.279574] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.08
[    1.279579] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.279581] usb usb2: Product: xHCI Host Controller
[    1.279582] usb usb2: Manufacturer: Linux 6.8.0-45-kfocus xhci-hcd
[    1.279583] usb usb2: SerialNumber: 0000:00:14.0
[    1.279762] hub 2-0:1.0: USB hub found
[    1.279797] hub 2-0:1.0: 10 ports detected
[    1.281572] xhci_hcd 0000:2d:00.0: xHCI Host Controller
[    1.281582] xhci_hcd 0000:2d:00.0: new USB bus registered, assigned bus number 3
[    1.282772] xhci_hcd 0000:2d:00.0: hcc params 0x20007fc1 hci version 0x120 quirks 0x0000000200009810
[    1.283173] xhci_hcd 0000:2d:00.0: xHCI Host Controller
[    1.283175] xhci_hcd 0000:2d:00.0: new USB bus registered, assigned bus number 4
[    1.283176] xhci_hcd 0000:2d:00.0: Host supports USB 3.2 Enhanced SuperSpeed
[    1.283280] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.08
[    1.283284] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.283286] usb usb3: Product: xHCI Host Controller
[    1.283288] usb usb3: Manufacturer: Linux 6.8.0-45-kfocus xhci-hcd
[    1.283289] usb usb3: SerialNumber: 0000:2d:00.0
[    1.283436] hub 3-0:1.0: USB hub found
[    1.283458] hub 3-0:1.0: 2 ports detected
[    1.284361] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.08
[    1.284364] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.284365] usb usb4: Product: xHCI Host Controller
[    1.284366] usb usb4: Manufacturer: Linux 6.8.0-45-kfocus xhci-hcd
[    1.284366] usb usb4: SerialNumber: 0000:2d:00.0
[    1.284437] hub 4-0:1.0: USB hub found
[    1.284445] hub 4-0:1.0: 2 ports detected
[    1.286308] thunderbolt: unknown parameter 'kf_force_redrive' ignored
[    1.286719] intel-lpss 0000:00:15.0: enabling device (0004 -> 0006)
[    1.287090] idma64 idma64.0: Found Intel integrated DMA 64-bit
[    1.290242] ACPI: bus type thunderbolt registered
[    1.290481] thunderbolt 0000:06:00.0: total paths: 12
[    1.290487] thunderbolt 0000:06:00.0: IOMMU DMA protection is enabled
[    1.327478] pps pps0: new PPS source ptp0
[    1.327497] igc 0000:03:00.0 (unnamed net_device) (uninitialized): PHC added
[    1.353103] igc 0000:03:00.0: 4.000 Gb/s available PCIe bandwidth (5.0 GT/s PCIe x1 link)
[    1.353106] igc 0000:03:00.0 eth0: MAC: d4:93:90:48:c5:ea
[    1.355693] igc 0000:03:00.0 enp3s0: renamed from eth0
[    1.397852] thunderbolt 0000:06:00.0: host router reset successful
[    1.398123] thunderbolt 0000:06:00.0: allocating TX ring 0 of size 10
[    1.398153] thunderbolt 0000:06:00.0: allocating RX ring 0 of size 10
[    1.398180] thunderbolt 0000:06:00.0: control channel created
[    1.398181] thunderbolt 0000:06:00.0: using software connection manager
[    1.398360] thunderbolt 0000:06:00.0: device links to tunneled native ports are missing!
[    1.398361] thunderbolt 0000:06:00.0: NHI initialized, starting thunderbolt
[    1.398362] thunderbolt 0000:06:00.0: control channel starting...
[    1.398362] thunderbolt 0000:06:00.0: starting TX ring 0
[    1.398373] thunderbolt 0000:06:00.0: enabling interrupt at register 0x38200 bit 0 (0x0 -> 0x1)
[    1.398375] thunderbolt 0000:06:00.0: starting RX ring 0
[    1.398380] thunderbolt 0000:06:00.0: enabling interrupt at register 0x38200 bit 12 (0x1 -> 0x1001)
[    1.398383] thunderbolt 0000:06:00.0: security level set to user
[    1.398558] thunderbolt 0000:06:00.0: current switch config:
[    1.398559] thunderbolt 0000:06:00.0:  USB4 Switch: 8087:5781 (Revision: 131, TB Version: 64)
[    1.398561] thunderbolt 0000:06:00.0:   Max Port Number: 23
[    1.398562] thunderbolt 0000:06:00.0:   Config:
[    1.398562] thunderbolt 0000:06:00.0:    Upstream Port Number: 15 Depth: 0 Route String: 0x0 Enabled: 0, PlugEventsDelay: 10ms
[    1.398563] thunderbolt 0000:06:00.0:    unknown1: 0x0 unknown4: 0x0
[    1.401681] thunderbolt 0000:06:00.0: initializing Switch at 0x0 (depth: 0, up port: 15)
[    1.402817] thunderbolt 0000:06:00.0: 0: credit allocation parameters:
[    1.402818] thunderbolt 0000:06:00.0: 0:  USB3: 20
[    1.402819] thunderbolt 0000:06:00.0: 0:  DP AUX: 1
[    1.402820] thunderbolt 0000:06:00.0: 0:  DP main: 6
[    1.402820] thunderbolt 0000:06:00.0: 0:  PCIe: 80
[    1.402821] thunderbolt 0000:06:00.0: 0:  DMA: 40
[    1.405254] thunderbolt 0000:06:00.0: 0: DROM version: 3
[    1.405256] thunderbolt 0000:06:00.0: 0: DROM data CRC32 mismatch (expected: 0x56000000, got: 0x56473b0f), continuing
[    1.405892] thunderbolt 0000:06:00.0: 0: uid: 0xb9cde50000006ecd
[    1.407168] thunderbolt 0000:06:00.0:  Port 1: 0:5780 (Revision: 0, TB Version: 1, Type: Port (0x1))
[    1.407170] thunderbolt 0000:06:00.0:   Max hop id (in/out): 31/31
[    1.407171] thunderbolt 0000:06:00.0:   Max counters: 4
[    1.407171] thunderbolt 0000:06:00.0:   NFC Credits: 0x8a000000
[    1.407172] thunderbolt 0000:06:00.0:   Credits (total/control): 160/2
[    1.408322] thunderbolt 0000:06:00.0:  Port 2: 0:5780 (Revision: 0, TB Version: 1, Type: Port (0x1))
[    1.408328] thunderbolt 0000:06:00.0:   Max hop id (in/out): 31/31
[    1.408332] thunderbolt 0000:06:00.0:   Max counters: 0
[    1.408335] thunderbolt 0000:06:00.0:   NFC Credits: 0xa000000
[    1.408338] thunderbolt 0000:06:00.0:   Credits (total/control): 160/2
[    1.409597] thunderbolt 0000:06:00.0:  Port 3: 0:5780 (Revision: 0, TB Version: 1, Type: Port (0x1))
[    1.409598] thunderbolt 0000:06:00.0:   Max hop id (in/out): 31/31
[    1.409599] thunderbolt 0000:06:00.0:   Max counters: 4
[    1.409599] thunderbolt 0000:06:00.0:   NFC Credits: 0x8a000000
[    1.409600] thunderbolt 0000:06:00.0:   Credits (total/control): 160/2
[    1.410748] thunderbolt 0000:06:00.0: acking hot plug event on 0:13
[    1.410760] thunderbolt 0000:06:00.0:  Port 4: 0:5780 (Revision: 0, TB Version: 1, Type: Port (0x1))
[    1.410765] thunderbolt 0000:06:00.0:   Max hop id (in/out): 31/31
[    1.410768] thunderbolt 0000:06:00.0:   Max counters: 0
[    1.410771] thunderbolt 0000:06:00.0:   NFC Credits: 0xa000000
[    1.410774] thunderbolt 0000:06:00.0:   Credits (total/control): 160/2
[    1.410876] thunderbolt 0000:06:00.0: acking hot plug event on 0:14
[    1.411004] thunderbolt 0000:06:00.0: acking hot plug event on 0:16
[    1.412032] thunderbolt 0000:06:00.0:  Port 5: 0:5780 (Revision: 0, TB Version: 1, Type: Inactive (0x0))
[    1.412033] thunderbolt 0000:06:00.0:   Max hop id (in/out): 31/31
[    1.412034] thunderbolt 0000:06:00.0:   Max counters: 4
[    1.412034] thunderbolt 0000:06:00.0:   NFC Credits: 0x8a000000
[    1.412035] thunderbolt 0000:06:00.0:   Credits (total/control): 160/0
[    1.412805] thunderbolt 0000:06:00.0:  Port 6: 0:5780 (Revision: 0, TB Version: 1, Type: Inactive (0x0))
[    1.412809] thunderbolt 0000:06:00.0:   Max hop id (in/out): 31/31
[    1.412813] thunderbolt 0000:06:00.0:   Max counters: 0
[    1.412816] thunderbolt 0000:06:00.0:   NFC Credits: 0xa000000
[    1.412819] thunderbolt 0000:06:00.0:   Credits (total/control): 160/0
[    1.414084] thunderbolt 0000:06:00.0:  Port 7: 0:5780 (Revision: 0, TB Version: 1, Type: Inactive (0x0))
[    1.414089] thunderbolt 0000:06:00.0:   Max hop id (in/out): 31/31
[    1.414092] thunderbolt 0000:06:00.0:   Max counters: 4
[    1.414095] thunderbolt 0000:06:00.0:   NFC Credits: 0x8a000000
[    1.414098] thunderbolt 0000:06:00.0:   Credits (total/control): 160/0
[    1.414851] thunderbolt 0000:06:00.0:  Port 8: 0:5780 (Revision: 0, TB Version: 1, Type: Inactive (0x0))
[    1.414852] thunderbolt 0000:06:00.0:   Max hop id (in/out): 31/31
[    1.414853] thunderbolt 0000:06:00.0:   Max counters: 0
[    1.414853] thunderbolt 0000:06:00.0:   NFC Credits: 0xa000000
[    1.414854] thunderbolt 0000:06:00.0:   Credits (total/control): 160/0
[    1.415105] thunderbolt 0000:06:00.0:  Port 9: 0:5780 (Revision: 0, TB Version: 1, Type: PCIe (0x100101))
[    1.415110] thunderbolt 0000:06:00.0:   Max hop id (in/out): 8/8
[    1.415114] thunderbolt 0000:06:00.0:   Max counters: 2
[    1.415116] thunderbolt 0000:06:00.0:   NFC Credits: 0x40800000
[    1.415119] thunderbolt 0000:06:00.0:   Credits (total/control): 8/0
[    1.415362] thunderbolt 0000:06:00.0:  Port 10: 0:5780 (Revision: 0, TB Version: 1, Type: PCIe (0x100101))
[    1.415363] thunderbolt 0000:06:00.0:   Max hop id (in/out): 8/8
[    1.415364] thunderbolt 0000:06:00.0:   Max counters: 2
[    1.415364] thunderbolt 0000:06:00.0:   NFC Credits: 0x40800000
[    1.415365] thunderbolt 0000:06:00.0:   Credits (total/control): 8/0
[    1.415872] thunderbolt 0000:06:00.0:  Port 11: 0:5780 (Revision: 0, TB Version: 1, Type: DP/HDMI (0xe0102))
[    1.415873] thunderbolt 0000:06:00.0:   Max hop id (in/out): 9/9
[    1.415874] thunderbolt 0000:06:00.0:   Max counters: 2
[    1.415874] thunderbolt 0000:06:00.0:   NFC Credits: 0x800000
[    1.415875] thunderbolt 0000:06:00.0:   Credits (total/control): 8/0
[    1.416383] thunderbolt 0000:06:00.0:  Port 12: 0:5780 (Revision: 0, TB Version: 1, Type: DP/HDMI (0xe0102))
[    1.416384] thunderbolt 0000:06:00.0:   Max hop id (in/out): 9/9
[    1.416385] thunderbolt 0000:06:00.0:   Max counters: 2
[    1.416385] thunderbolt 0000:06:00.0:   NFC Credits: 0x800000
[    1.416386] thunderbolt 0000:06:00.0:   Credits (total/control): 8/0
[    1.416645] thunderbolt 0000:06:00.0:  Port 13: 0:5780 (Revision: 0, TB Version: 1, Type: DP/HDMI (0xe0101))
[    1.416650] thunderbolt 0000:06:00.0:   Max hop id (in/out): 9/9
[    1.416653] thunderbolt 0000:06:00.0:   Max counters: 2
[    1.416656] thunderbolt 0000:06:00.0:   NFC Credits: 0x100000d
[    1.416659] thunderbolt 0000:06:00.0:   Credits (total/control): 16/0
[    1.416896] thunderbolt 0000:06:00.0:  Port 14: 0:5780 (Revision: 0, TB Version: 1, Type: DP/HDMI (0xe0101))
[    1.416897] thunderbolt 0000:06:00.0:   Max hop id (in/out): 9/9
[    1.416898] thunderbolt 0000:06:00.0:   Max counters: 2
[    1.416898] thunderbolt 0000:06:00.0:   NFC Credits: 0x100000d
[    1.416899] thunderbolt 0000:06:00.0:   Credits (total/control): 16/0
[    1.417667] thunderbolt 0000:06:00.0:  Port 15: 0:5780 (Revision: 0, TB Version: 1, Type: NHI (0x2))
[    1.417672] thunderbolt 0000:06:00.0:   Max hop id (in/out): 11/11
[    1.417675] thunderbolt 0000:06:00.0:   Max counters: 4
[    1.417678] thunderbolt 0000:06:00.0:   NFC Credits: 0x41c00000
[    1.417681] thunderbolt 0000:06:00.0:   Credits (total/control): 28/0
[    1.417685] thunderbolt 0000:06:00.0: 0:16: disabled by eeprom
[    1.417919] thunderbolt 0000:06:00.0:  Port 17: 0:5780 (Revision: 0, TB Version: 1, Type: Inactive (0x0))
[    1.417920] thunderbolt 0000:06:00.0:   Max hop id (in/out): 8/8
[    1.417921] thunderbolt 0000:06:00.0:   Max counters: 2
[    1.417922] thunderbolt 0000:06:00.0:   NFC Credits: 0x40800000
[    1.417922] thunderbolt 0000:06:00.0:   Credits (total/control): 8/0
[    1.418176] thunderbolt 0000:06:00.0:  Port 18: 0:5780 (Revision: 0, TB Version: 1, Type: Inactive (0x0))
[    1.418177] thunderbolt 0000:06:00.0:   Max hop id (in/out): 8/8
[    1.418178] thunderbolt 0000:06:00.0:   Max counters: 2
[    1.418178] thunderbolt 0000:06:00.0:   NFC Credits: 0x40800000
[    1.418179] thunderbolt 0000:06:00.0:   Credits (total/control): 8/0
[    1.418689] thunderbolt 0000:06:00.0:  Port 19: 0:5780 (Revision: 0, TB Version: 1, Type: DP/HDMI (0xe0102))
[    1.418693] thunderbolt 0000:06:00.0:   Max hop id (in/out): 9/9
[    1.418697] thunderbolt 0000:06:00.0:   Max counters: 2
[    1.418707] thunderbolt 0000:06:00.0:   NFC Credits: 0x800000
[    1.418710] thunderbolt 0000:06:00.0:   Credits (total/control): 8/0
[    1.418941] thunderbolt 0000:06:00.0:  Port 20: 0:5780 (Revision: 0, TB Version: 1, Type: Inactive (0x0))
[    1.418942] thunderbolt 0000:06:00.0:   Max hop id (in/out): 8/8
[    1.418943] thunderbolt 0000:06:00.0:   Max counters: 1
[    1.418943] thunderbolt 0000:06:00.0:   NFC Credits: 0x800000
[    1.418944] thunderbolt 0000:06:00.0:   Credits (total/control): 8/0
[    1.419204] thunderbolt 0000:06:00.0:  Port 21: 0:5780 (Revision: 0, TB Version: 1, Type: USB (0x200101))
[    1.419205] thunderbolt 0000:06:00.0:   Max hop id (in/out): 8/8
[    1.419206] thunderbolt 0000:06:00.0:   Max counters: 1
[    1.419207] thunderbolt 0000:06:00.0:   NFC Credits: 0x800000
[    1.419207] thunderbolt 0000:06:00.0:   Credits (total/control): 8/0
[    1.419460] thunderbolt 0000:06:00.0:  Port 22: 0:5780 (Revision: 0, TB Version: 1, Type: USB (0x200101))
[    1.419465] thunderbolt 0000:06:00.0:   Max hop id (in/out): 8/8
[    1.419468] thunderbolt 0000:06:00.0:   Max counters: 1
[    1.419471] thunderbolt 0000:06:00.0:   NFC Credits: 0x800000
[    1.419474] thunderbolt 0000:06:00.0:   Credits (total/control): 8/0
[    1.419712] thunderbolt 0000:06:00.0:  Port 23: 0:5780 (Revision: 0, TB Version: 1, Type: Inactive (0x0))
[    1.419713] thunderbolt 0000:06:00.0:   Max hop id (in/out): 8/8
[    1.419714] thunderbolt 0000:06:00.0:   Max counters: 1
[    1.419714] thunderbolt 0000:06:00.0:   NFC Credits: 0x800000
[    1.419715] thunderbolt 0000:06:00.0:   Credits (total/control): 8/0
[    1.419716] thunderbolt 0000:06:00.0: 0: running quirk_usb3_maximum_bandwidth [thunderbolt]
[    1.419742] thunderbolt 0000:06:00.0: 0:21: USB3 maximum bandwidth limited to 16376 Mb/s
[    1.419743] thunderbolt 0000:06:00.0: 0:22: USB3 maximum bandwidth limited to 16376 Mb/s
[    1.419744] thunderbolt 0000:06:00.0: 0: running quirk_block_rpm_in_redrive [thunderbolt]
[    1.419760] thunderbolt 0000:06:00.0: 0: preventing runtime PM in DP redrive mode
[    1.419761] thunderbolt 0000:06:00.0: 0: linked ports 1 <-> 2
[    1.419762] thunderbolt 0000:06:00.0: 0: linked ports 3 <-> 4
[    1.425838] intel-lpss 0000:00:15.1: enabling device (0004 -> 0006)
[    1.426116] idma64 idma64.1: Found Intel integrated DMA 64-bit
[    1.428031] thunderbolt 0000:06:00.0: 0: TMU: supports uni-directional mode
[    1.428032] thunderbolt 0000:06:00.0: 0: TMU: supports enhanced uni-directional mode
[    1.428159] thunderbolt 0000:06:00.0: 0: TMU: current mode: off
[    1.432161] thunderbolt 0000:06:00.0: 0: NVM version 14.86
[    1.432229] thunderbolt 0000:06:00.0: 0: TMU: mode change off -> uni-directional, LowRes requested
[    1.432639] thunderbolt 0000:06:00.0: 0: TMU: mode set to: uni-directional, LowRes
[    1.433023] thunderbolt 0000:06:00.0: 0:1: is unplugged (state: 7)
[    1.433151] thunderbolt 0000:06:00.0: 0:3: is unplugged (state: 7)
[    1.434948] thunderbolt 0000:06:00.0: 0:13: DP IN resource available
[    1.435587] thunderbolt 0000:06:00.0: 0:14: DP IN resource available
[    1.445869] pci 10000:e0:06.0: bridge window [mem 0x4c000000-0x4c0fffff]: assigned
[    1.445874] pci 10000:e0:1b.4: bridge window [mem 0x4c100000-0x4c1fffff]: assigned
[    1.445875] pci 10000:e0:06.0: bridge window [io  size 0x1000]: can't assign; no space
[    1.445877] pci 10000:e0:06.0: bridge window [io  size 0x1000]: failed to assign
[    1.445878] pci 10000:e0:1b.4: bridge window [io  size 0x1000]: can't assign; no space
[    1.445879] pci 10000:e0:1b.4: bridge window [io  size 0x1000]: failed to assign
[    1.445881] pci 10000:e1:00.0: BAR 0 [mem 0x4c000000-0x4c003fff 64bit]: assigned
[    1.445891] pci 10000:e0:06.0: PCI bridge to [bus e1]
[    1.445894] pci 10000:e0:06.0:   bridge window [mem 0x4c000000-0x4c0fffff]
[    1.445900] pci 10000:e2:00.0: BAR 0 [mem 0x4c100000-0x4c103fff 64bit]: assigned
[    1.445928] pci 10000:e0:1b.4: PCI bridge to [bus e2]
[    1.445934] pci 10000:e0:1b.4:   bridge window [mem 0x4c100000-0x4c1fffff]
[    1.446008] pcieport 10000:e0:06.0: can't derive routing for PCI INT D
[    1.446010] pcieport 10000:e0:06.0: PCI INT D: no GSI
[    1.446091] pcieport 10000:e0:06.0: PME: Signaling with IRQ 186
[    1.446188] pcieport 10000:e0:1b.4: can't derive routing for PCI INT A
[    1.446190] pcieport 10000:e0:1b.4: PCI INT A: no GSI
[    1.446279] pcieport 10000:e0:1b.4: PME: Signaling with IRQ 187
[    1.446397] vmd 0000:00:0e.0: Bound to PCI domain 10000
[    1.485985] nvidia: loading out-of-tree module taints kernel.
[    1.486012] nvidia: module license 'NVIDIA' taints kernel.
[    1.486015] Disabling lock debugging due to kernel taint
[    1.486020] nvidia: module verification failed: signature and/or required key missing - tainting kernel
[    1.486021] nvidia: module license taints kernel.
[    1.519813] usb 1-1: new full-speed USB device number 2 using xhci_hcd
[    1.546337] nvidia-nvlink: Nvlink Core is being initialized, major device number 239

[    1.547209] nvidia 0000:02:00.0: enabling device (0000 -> 0003)
[    1.547333] nvidia 0000:02:00.0: vgaarb: VGA decodes changed: olddecodes=io+mem,decodes=none:owns=none
[    1.596933] NVRM: loading NVIDIA UNIX x86_64 Kernel Module  535.183.01  Sun May 12 19:39:15 UTC 2024
[    1.650646] usb 1-1: New USB device found, idVendor=046d, idProduct=c52b, bcdDevice=12.11
[    1.650668] usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    1.650672] usb 1-1: Product: USB Receiver
[    1.650675] usb 1-1: Manufacturer: Logitech
[    1.767762] usb 1-6: new high-speed USB device number 3 using xhci_hcd
[    1.775384] input: FTCS1000:01 2808:0102 Mouse as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-0/i2c-FTCS1000:01/0018:2808:0102.0001/input/input8
[    1.775541] input: FTCS1000:01 2808:0102 Touchpad as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-0/i2c-FTCS1000:01/0018:2808:0102.0001/input/input9
[    1.775671] hid-generic 0018:2808:0102.0001: input,hidraw0: I2C HID v1.00 Mouse [FTCS1000:01 2808:0102] on i2c-FTCS1000:01
[    1.786280] nvme nvme1: pci function 10000:e2:00.0
[    1.786302] pcieport 10000:e0:1b.4: can't derive routing for PCI INT A
[    1.786305] nvme 10000:e2:00.0: PCI INT A: not connected
[    1.786304] nvme nvme0: pci function 10000:e1:00.0
[    1.786330] pcieport 10000:e0:06.0: can't derive routing for PCI INT A
[    1.786333] nvme 10000:e1:00.0: PCI INT A: not connected
[    1.787711] nvidia-modeset: Loading NVIDIA Kernel Mode Setting Driver for UNIX platforms  535.183.01  Sun May 12 19:31:08 UTC 2024
[    1.788381] nvme nvme0: Shutdown timeout set to 10 seconds
[    1.792978] nvme nvme0: 18/0/0 default/read/poll queues
[    1.797396]  nvme0n1: p1 p2 p3
[    1.798138] nvme nvme1: Shutdown timeout set to 10 seconds
[    1.803211] nvme nvme1: 18/0/0 default/read/poll queues
[    1.806737]  nvme1n1: p1 p2 p3 p4
[    1.811407] [drm] [nvidia-drm] [GPU ID 0x00000200] Loading driver
[    1.857306] input: FTCS1000:01 2808:0102 Mouse as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-0/i2c-FTCS1000:01/0018:2808:0102.0001/input/input11
[    1.857404] input: FTCS1000:01 2808:0102 Touchpad as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-0/i2c-FTCS1000:01/0018:2808:0102.0001/input/input12
[    1.857484] hid-multitouch 0018:2808:0102.0001: input,hidraw0: I2C HID v1.00 Mouse [FTCS1000:01 2808:0102] on i2c-FTCS1000:01
[    1.863850] ACPI Warning: \_SB.NPCF._DSM: Argument #4 type mismatch - Found [Buffer], ACPI requires [Package] (20230628/nsarguments-61)
[    1.863971] ACPI Warning: \_SB.PC00.PEG2.PEGP._DSM: Argument #4 type mismatch - Found [Buffer], ACPI requires [Package] (20230628/nsarguments-61)
[    1.927619] usb 1-6: New USB device found, idVendor=04f2, idProduct=b7e7, bcdDevice= 0.04
[    1.927633] usb 1-6: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    1.927637] usb 1-6: Product: Chicony USB2.0 Camera
[    1.927639] usb 1-6: Manufacturer: SunplusIT Inc
[    1.927640] usb 1-6: SerialNumber: 01.00.00
[    2.057821] usb 1-7: new full-speed USB device number 4 using xhci_hcd
[    2.188828] usb 1-7: New USB device found, idVendor=048d, idProduct=8910, bcdDevice= 0.01
[    2.188842] usb 1-7: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.188848] usb 1-7: Product: ITE Device(829x)
[    2.188852] usb 1-7: Manufacturer: ITE Tech. Inc.
[    2.303822] usb 1-14: new full-speed USB device number 5 using xhci_hcd
[    2.432054] usb 1-14: New USB device found, idVendor=8087, idProduct=0033, bcdDevice= 0.00
[    2.432069] usb 1-14: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    2.438939] input: Logitech USB Receiver as /devices/pci0000:00/0000:00:14.0/usb1/1-1/1-1:1.0/0003:046D:C52B.0002/input/input14
[    2.490981] hid-generic 0003:046D:C52B.0002: input,hidraw1: USB HID v1.11 Keyboard [Logitech USB Receiver] on usb-0000:00:14.0-1/input0
[    2.492907] input: Logitech USB Receiver Mouse as /devices/pci0000:00/0000:00:14.0/usb1/1-1/1-1:1.1/0003:046D:C52B.0003/input/input15
[    2.492989] input: Logitech USB Receiver Consumer Control as /devices/pci0000:00/0000:00:14.0/usb1/1-1/1-1:1.1/0003:046D:C52B.0003/input/input16
[    2.544875] input: Logitech USB Receiver System Control as /devices/pci0000:00/0000:00:14.0/usb1/1-1/1-1:1.1/0003:046D:C52B.0003/input/input17
[    2.544951] hid-generic 0003:046D:C52B.0003: input,hiddev0,hidraw2: USB HID v1.11 Mouse [Logitech USB Receiver] on usb-0000:00:14.0-1/input1
[    2.546292] hid-generic 0003:046D:C52B.0004: hiddev1,hidraw3: USB HID v1.11 Device [Logitech USB Receiver] on usb-0000:00:14.0-1/input2
[    2.547420] hid-generic 0003:048D:8910.0005: hiddev2,hidraw4: USB HID v1.10 Device [ITE Tech. Inc. ITE Device(829x)] on usb-0000:00:14.0-7/input0
[    2.547444] usbcore: registered new interface driver usbhid
[    2.547445] usbhid: USB HID core driver
[    2.610782] logitech-djreceiver 0003:046D:C52B.0004: hiddev0,hidraw1: USB HID v1.11 Device [Logitech USB Receiver] on usb-0000:00:14.0-1/input2
[    2.645952] nvidia-modeset: WARNING: GPU:0: Unable to read EDID for display device DP-2
[    2.655153] nvidia-modeset: WARNING: GPU:0: Unable to read EDID for display device DP-2
[    2.656488] [drm] Initialized nvidia-drm 0.0.0 20160202 for 0000:02:00.0 on minor 1
[    2.718078] input: Logitech Wireless Device PID:4082 Keyboard as /devices/pci0000:00/0000:00:14.0/usb1/1-1/1-1:1.2/0003:046D:C52B.0004/0003:046D:4082.0006/input/input19
[    2.718310] input: Logitech Wireless Device PID:4082 Mouse as /devices/pci0000:00/0000:00:14.0/usb1/1-1/1-1:1.2/0003:046D:C52B.0004/0003:046D:4082.0006/input/input20
[    2.718552] hid-generic 0003:046D:4082.0006: input,hidraw2: USB HID v1.11 Keyboard [Logitech Wireless Device PID:4082] on usb-0000:00:14.0-1/input2:1
[    2.720089] input: Logitech Wireless Device PID:408a Keyboard as /devices/pci0000:00/0000:00:14.0/usb1/1-1/1-1:1.2/0003:046D:C52B.0004/0003:046D:408A.0007/input/input24
[    2.720304] input: Logitech Wireless Device PID:408a Mouse as /devices/pci0000:00/0000:00:14.0/usb1/1-1/1-1:1.2/0003:046D:C52B.0004/0003:046D:408A.0007/input/input25
[    2.720542] hid-generic 0003:046D:408A.0007: input,hidraw3: USB HID v1.11 Keyboard [Logitech Wireless Device PID:408a] on usb-0000:00:14.0-1/input2:2
[    2.767664] input: Logitech MX Master 3 as /devices/pci0000:00/0000:00:14.0/usb1/1-1/1-1:1.2/0003:046D:C52B.0004/0003:046D:4082.0006/input/input29
[    2.768172] logitech-hidpp-device 0003:046D:4082.0006: input,hidraw2: USB HID v1.11 Keyboard [Logitech MX Master 3] on usb-0000:00:14.0-1/input2:1
[    2.813754] input: Logitech MX Keys as /devices/pci0000:00/0000:00:14.0/usb1/1-1/1-1:1.2/0003:046D:C52B.0004/0003:046D:408A.0007/input/input30
[    2.814257] logitech-hidpp-device 0003:046D:408A.0007: input,hidraw3: USB HID v1.11 Keyboard [Logitech MX Keys] on usb-0000:00:14.0-1/input2:2
[    2.913522] input: ImPS/2 Generic Wheel Mouse as /devices/platform/i8042/serio1/input/input7
[   20.182389] thunderbolt 0000:06:00.0: 0: suspending switch
[   20.182403] thunderbolt 0000:06:00.0: 0: enabling wakeup: 0x3f
[   20.183455] thunderbolt 0000:06:00.0: stopping RX ring 0
[   20.183476] thunderbolt 0000:06:00.0: disabling interrupt at register 0x38200 bit 12 (0x1001 -> 0x1)
[   20.183498] thunderbolt 0000:06:00.0: stopping TX ring 0
[   20.183518] thunderbolt 0000:06:00.0: disabling interrupt at register 0x38200 bit 0 (0x1 -> 0x0)
[   20.183544] thunderbolt 0000:06:00.0: control channel stopped
[   39.899702] raid6: avx2x4   gen() 33930 MB/s
[   39.916702] raid6: avx2x2   gen() 36928 MB/s
[   39.933701] raid6: avx2x1   gen() 35983 MB/s
[   39.933702] raid6: using algorithm avx2x2 gen() 36928 MB/s
[   39.950701] raid6: .... xor() 28556 MB/s, rmw enabled
[   39.950702] raid6: using avx2x2 recovery algorithm
[   39.952912] xor: automatically using best checksumming function   avx       
[   40.019919] Btrfs loaded, zoned=yes, fsverity=yes
[   40.076816] BTRFS: device label kfocus_2404 devid 1 transid 13746 /dev/mapper/luks-10f3ea80-0841-49c9-8f38-b720275ff4e1 scanned by mount (708)
[   40.077334] BTRFS info (device dm-0): first mount of filesystem 9c2a749a-d478-4e57-b7a7-f4d8c5de2902
[   40.077348] BTRFS info (device dm-0): using crc32c (crc32c-intel) checksum algorithm
[   40.077357] BTRFS info (device dm-0): using free-space-tree
[   40.249750] systemd[1]: Inserted module 'autofs4'
[   40.479360] systemd[1]: systemd 255.4-1ubuntu8.4 running in system mode (+PAM +AUDIT +SELINUX +APPARMOR +IMA +SMACK +SECCOMP +GCRYPT -GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP +LIBFDISK +PCRE2 -PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD -BPF_FRAMEWORK -XKBCOMMON +UTMP +SYSVINIT default-hierarchy=unified)
[   40.479369] systemd[1]: Detected architecture x86-64.
[   40.480712] systemd[1]: Hostname set to <kf-jane>.
[   40.566463] systemd[1]: Configuration file /run/systemd/system/netplan-ovs-cleanup.service is marked world-inaccessible. This has no effect as configuration data is accessible via APIs without restrictions. Proceeding anyway.
[   40.596846] systemd[1]: Queued start job for default target graphical.target.
[   40.617075] systemd[1]: Created slice system-modprobe.slice - Slice /system/modprobe.
[   40.617412] systemd[1]: Created slice system-systemd\x2dcryptsetup.slice - Encrypted Volume Units Service Slice.
[   40.617665] systemd[1]: Created slice system-systemd\x2dfsck.slice - Slice /system/systemd-fsck.
[   40.617868] systemd[1]: Created slice user.slice - User and Session Slice.
[   40.617913] systemd[1]: Started systemd-ask-password-wall.path - Forward Password Requests to Wall Directory Watch.
[   40.618066] systemd[1]: Set up automount proc-sys-fs-binfmt_misc.automount - Arbitrary Executable File Formats File System Automount Point.
[   40.618081] systemd[1]: Expecting device dev-disk-by\x2duuid-0883\x2d4F93.device - /dev/disk/by-uuid/0883-4F93...
[   40.618089] systemd[1]: Expecting device dev-disk-by\x2duuid-10f3ea80\x2d0841\x2d49c9\x2d8f38\x2db720275ff4e1.device - /dev/disk/by-uuid/10f3ea80-0841-49c9-8f38-b720275ff4e1...
[   40.618093] systemd[1]: Expecting device dev-disk-by\x2duuid-9c2a749a\x2dd478\x2d4e57\x2db7a7\x2df4d8c5de2902.device - /dev/disk/by-uuid/9c2a749a-d478-4e57-b7a7-f4d8c5de2902...
[   40.618097] systemd[1]: Expecting device dev-disk-by\x2duuid-c04cfaca\x2d531b\x2d479b\x2da332\x2d848b3211ce9d.device - /dev/disk/by-uuid/c04cfaca-531b-479b-a332-848b3211ce9d...
[   40.618101] systemd[1]: Expecting device dev-mapper-luks\x2d10f3ea80\x2d0841\x2d49c9\x2d8f38\x2db720275ff4e1.device - /dev/mapper/luks-10f3ea80-0841-49c9-8f38-b720275ff4e1...
[   40.618117] systemd[1]: Reached target integritysetup.target - Local Integrity Protected Volumes.
[   40.618130] systemd[1]: Reached target nss-user-lookup.target - User and Group Name Lookups.
[   40.618138] systemd[1]: Reached target remote-fs.target - Remote File Systems.
[   40.618145] systemd[1]: Reached target slices.target - Slice Units.
[   40.618154] systemd[1]: Reached target snapd.mounts-pre.target - Mounting snaps.
[   40.618172] systemd[1]: Reached target veritysetup.target - Local Verity Protected Volumes.
[   40.618224] systemd[1]: Listening on dm-event.socket - Device-mapper event daemon FIFOs.
[   40.618579] systemd[1]: Listening on lvm2-lvmpolld.socket - LVM2 poll daemon socket.
[   40.619024] systemd[1]: Listening on syslog.socket - Syslog Socket.
[   40.619097] systemd[1]: Listening on systemd-fsckd.socket - fsck to fsckd communication Socket.
[   40.619118] systemd[1]: Listening on systemd-initctl.socket - initctl Compatibility Named Pipe.
[   40.619158] systemd[1]: Listening on systemd-journald-dev-log.socket - Journal Socket (/dev/log).
[   40.619198] systemd[1]: Listening on systemd-journald.socket - Journal Socket.
[   40.619226] systemd[1]: systemd-pcrextend.socket - TPM2 PCR Extension (Varlink) was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
[   40.619491] systemd[1]: Listening on systemd-udevd-control.socket - udev Control Socket.
[   40.619524] systemd[1]: Listening on systemd-udevd-kernel.socket - udev Kernel Socket.
[   40.620993] systemd[1]: Mounting dev-hugepages.mount - Huge Pages File System...
[   40.621424] systemd[1]: Mounting dev-mqueue.mount - POSIX Message Queue File System...
[   40.622079] systemd[1]: Mounting sys-kernel-debug.mount - Kernel Debug File System...
[   40.622620] systemd[1]: Mounting sys-kernel-tracing.mount - Kernel Trace File System...
[   40.624715] systemd[1]: Starting systemd-journald.service - Journal Service...
[   40.624792] systemd[1]: Finished blk-availability.service - Availability of block devices.
[   40.625931] systemd[1]: Starting keyboard-setup.service - Set the console keyboard layout...
[   40.626950] systemd[1]: Starting kmod-static-nodes.service - Create List of Static Device Nodes...
[   40.627909] systemd[1]: Starting lvm2-monitor.service - Monitoring of LVM2 mirrors, snapshots etc. using dmeventd or progress polling...
[   40.628533] systemd[1]: Starting modprobe@configfs.service - Load Kernel Module configfs...
[   40.629204] systemd[1]: Starting modprobe@dm_mod.service - Load Kernel Module dm_mod...
[   40.629957] systemd[1]: Starting modprobe@drm.service - Load Kernel Module drm...
[   40.630525] systemd[1]: Starting modprobe@efi_pstore.service - Load Kernel Module efi_pstore...
[   40.631179] systemd[1]: Starting modprobe@fuse.service - Load Kernel Module fuse...
[   40.631605] systemd[1]: Starting modprobe@loop.service - Load Kernel Module loop...
[   40.632045] systemd[1]: Starting modprobe@nvme_fabrics.service - Load Kernel Module nvme_fabrics...
[   40.632836] systemd[1]: Starting systemd-modules-load.service - Load Kernel Modules...
[   40.632857] systemd[1]: systemd-pcrmachine.service - TPM2 PCR Machine ID Measurement was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
[   40.634009] systemd[1]: Starting systemd-remount-fs.service - Remount Root and Kernel File Systems...
[   40.634057] systemd[1]: systemd-tpm2-setup-early.service - TPM2 SRK Setup (Early) was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
[   40.634809] pstore: Using crash dump compression: deflate
[   40.635147] systemd[1]: Starting systemd-udev-trigger.service - Coldplug All udev Devices...
[   40.635613] systemd-journald[779]: Collecting audit messages is disabled.
[   40.636277] systemd[1]: Mounted dev-hugepages.mount - Huge Pages File System.
[   40.636347] systemd[1]: Mounted dev-mqueue.mount - POSIX Message Queue File System.
[   40.636389] systemd[1]: Mounted sys-kernel-debug.mount - Kernel Debug File System.
[   40.636430] systemd[1]: Mounted sys-kernel-tracing.mount - Kernel Trace File System.
[   40.636590] systemd[1]: Finished kmod-static-nodes.service - Create List of Static Device Nodes.
[   40.636793] systemd[1]: modprobe@configfs.service: Deactivated successfully.
[   40.636876] systemd[1]: Finished modprobe@configfs.service - Load Kernel Module configfs.
[   40.637007] systemd[1]: modprobe@dm_mod.service: Deactivated successfully.
[   40.637088] systemd[1]: Finished modprobe@dm_mod.service - Load Kernel Module dm_mod.
[   40.637203] systemd[1]: modprobe@drm.service: Deactivated successfully.
[   40.637270] systemd[1]: Finished modprobe@drm.service - Load Kernel Module drm.
[   40.637390] systemd[1]: modprobe@fuse.service: Deactivated successfully.
[   40.637455] systemd[1]: Finished modprobe@fuse.service - Load Kernel Module fuse.
[   40.637571] systemd[1]: modprobe@loop.service: Deactivated successfully.
[   40.637672] systemd[1]: Finished modprobe@loop.service - Load Kernel Module loop.
[   40.638486] systemd[1]: Mounting sys-fs-fuse-connections.mount - FUSE Control File System...
[   40.638992] systemd[1]: Mounting sys-kernel-config.mount - Kernel Configuration File System...
[   40.639026] systemd[1]: systemd-repart.service - Repartition Root Disk was skipped because no trigger condition checks were met.
[   40.639513] systemd[1]: Starting systemd-tmpfiles-setup-dev-early.service - Create Static Device Nodes in /dev gracefully...
[   40.640153] BTRFS info (device dm-0: state M): turning on sync discard
[   40.640156] BTRFS info (device dm-0: state M): enabling auto defrag
[   40.640157] BTRFS info (device dm-0: state M): use lzo compression, level 0
[   40.640884] systemd[1]: modprobe@nvme_fabrics.service: Deactivated successfully.
[   40.641000] systemd[1]: Finished modprobe@nvme_fabrics.service - Load Kernel Module nvme_fabrics.
[   40.641231] systemd[1]: Finished systemd-remount-fs.service - Remount Root and Kernel File Systems.
[   40.641630] systemd[1]: Mounted sys-fs-fuse-connections.mount - FUSE Control File System.
[   40.642220] systemd[1]: systemd-hwdb-update.service - Rebuild Hardware Database was skipped because of an unmet condition check (ConditionNeedsUpdate=/etc).
[   40.642947] systemd[1]: Starting systemd-random-seed.service - Load/Save OS Random Seed...
[   40.642960] systemd[1]: systemd-tpm2-setup.service - TPM2 SRK Setup was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
[   40.643209] systemd[1]: Mounted sys-kernel-config.mount - Kernel Configuration File System.
[   40.660521] systemd[1]: Finished keyboard-setup.service - Set the console keyboard layout.
[   40.669781] lp: driver loaded but no devices found
[   40.671583] systemd[1]: Finished systemd-tmpfiles-setup-dev-early.service - Create Static Device Nodes in /dev gracefully.
[   40.671659] systemd[1]: systemd-sysusers.service - Create System Users was skipped because no trigger condition checks were met.
[   40.674821] ppdev: user-space parallel port driver
[   40.689930] systemd[1]: Starting systemd-tmpfiles-setup-dev.service - Create Static Device Nodes in /dev...
[   40.690037] systemd[1]: Started systemd-journald.service - Journal Service.
[   40.694816] pstore: Registered efi_pstore as persistent store backend
[   40.694958] tuxedo_keyboard: module init
[   40.705188] systemd-journald[779]: Received client request to flush runtime journal.
[   40.727395] systemd-journald[779]: /var/log/journal/947663c1d7a1413e89306987834604de/system.journal: Journal file uses a different sequence number ID, rotating.
[   40.727399] systemd-journald[779]: Rotating system journal.
[   40.752222] loop0: detected capacity change from 0 to 111920
[   40.754710] loop1: detected capacity change from 0 to 111984
[   40.756772] loop2: detected capacity change from 0 to 152040
[   40.758067] loop3: detected capacity change from 0 to 8
[   40.758924] loop4: detected capacity change from 0 to 152056
[   40.759180] loop5: detected capacity change from 0 to 135520
[   40.759922] loop6: detected capacity change from 0 to 135512
[   40.761121] loop7: detected capacity change from 0 to 21952
[   40.768738] loop10: detected capacity change from 0 to 187776
[   40.768780] loop9: detected capacity change from 0 to 79328
[   40.769639] loop8: detected capacity change from 0 to 1034424
[   40.770668] BTRFS info: devid 1 device path /dev/mapper/luks-10f3ea80-0841-49c9-8f38-b720275ff4e1 changed to /dev/dm-0 scanned by (udev-worker) (859)
[   40.773597] loop11: detected capacity change from 0 to 79520
[   40.773915] loop13: detected capacity change from 0 to 923472
[   40.774128] BTRFS info: devid 1 device path /dev/dm-0 changed to /dev/mapper/luks-10f3ea80-0841-49c9-8f38-b720275ff4e1 scanned by (udev-worker) (859)
[   40.774788] loop12: detected capacity change from 0 to 923480
[   40.785780] mei_me 0000:00:16.0: enabling device (0000 -> 0002)
[   40.792879] input: Intel HID events as /devices/platform/INTC1051:00/input/input31
[   40.806406] nvidia_uvm: module uses symbols nvUvmInterfaceDisableAccessCntr from proprietary module nvidia, inheriting taint.
[   40.847369] Consider using thermal netlink events interface
[   40.848458] nvidia-uvm: Loaded the UVM driver, major device number 511.
[   40.871723] mc: Linux media interface: v0.10
[   40.876282] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[   40.876538] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   40.876733] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c7248db18c600'
[   40.901170] tuxedo_keyboard: set_mode on CUSTOM
[   40.903540] i801_smbus 0000:00:1f.4: SPD Write Disable is set
[   40.903597] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
[   40.904262] intel_pmc_core INT33A1:00:  initialized
[   40.912619] Intel(R) Wireless WiFi driver for Linux
[   40.914443] iwlwifi 0000:00:14.3: Detected crf-id 0x400410, cnv-id 0x80401 wfpm id 0x80000020
[   40.914468] iwlwifi 0000:00:14.3: PCI dev 7a70/0094, rev=0x430, rfid=0x2010d000
[   40.918555] iwlwifi 0000:00:14.3: TLV_FW_FSEQ_VERSION: FSEQ Version: 0.0.2.41
[   40.918771] iwlwifi 0000:00:14.3: loaded firmware version 86.fb5c9aeb.0 so-a0-gf-a0-86.ucode op_mode iwlmvm
[   40.928579] Bluetooth: Core ver 2.22
[   40.928596] NET: Registered PF_BLUETOOTH protocol family
[   40.928597] Bluetooth: HCI device and connection manager initialized
[   40.928600] Bluetooth: HCI socket layer initialized
[   40.928601] Bluetooth: L2CAP socket layer initialized
[   40.928603] Bluetooth: SCO socket layer initialized
[   40.928902] RAPL PMU: API unit is 2^-32 Joules, 3 fixed counters, 655360 ms ovfl timer
[   40.928904] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[   40.928905] RAPL PMU: hw unit of domain package 2^-14 Joules
[   40.928906] RAPL PMU: hw unit of domain psys 2^-14 Joules
[   40.935561] tuxedo_keyboard: Set brightness on 125
[   40.941741] tuxedo_keyboard: Set keyboard enabled to: 1
[   40.944371] input: TUXEDO Keyboard as /devices/platform/tuxedo_keyboard/input/input32
[   40.944453] clevo_wmi: interface initialized
[   40.944468] clevo_acpi: interface initialized
[   40.944551] i2c i2c-8: 2/2 memory slots populated (from DMI)
[   40.944552] i2c i2c-8: Memory type 0x22 not supported yet, not instantiating SPD
[   40.949774] intel_rapl_msr: PL4 support detected.
[   40.949825] intel_rapl_common: Found RAPL domain package
[   40.949833] intel_rapl_common: Found RAPL domain core
[   40.949838] intel_rapl_common: Found RAPL domain psys
[   40.958051] videodev: Linux video capture interface: v2.00
[   40.958111] usbcore: registered new interface driver btusb
[   40.960405] Bluetooth: hci0: Device revision is 0
[   40.960410] Bluetooth: hci0: Secure boot is enabled
[   40.960413] Bluetooth: hci0: OTP lock is enabled
[   40.960415] Bluetooth: hci0: API lock is enabled
[   40.960416] Bluetooth: hci0: Debug lock is disabled
[   40.960418] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
[   40.960420] Bluetooth: hci0: Bootloader timestamp 2019.40 buildtype 1 build 38
[   40.960696] ACPI Warning: \_SB.PC00.XHCI.RHUB.HS14._DSM: Argument #4 type mismatch - Found [Integer], ACPI requires [Package] (20230628/nsarguments-61)
[   40.960769] Bluetooth: hci0: DSM reset method type: 0x00
[   40.962679] Creating 1 MTD partitions on "0000:00:1f.5":
[   40.962682] 0x000000000000-0x000002000000 : "BIOS"
[   40.964645] Bluetooth: hci0: Found device firmware: intel/ibt-1040-0041.sfi
[   40.964653] Bluetooth: hci0: Boot Address: 0x100800
[   40.964654] Bluetooth: hci0: Firmware Version: 60-48.23
[   41.028957] intel_rapl_common: Found RAPL domain package
[   41.041257] usb 1-6: Found UVC 1.50 device Chicony USB2.0 Camera (04f2:b7e7)
[   41.064952] iwlwifi 0000:00:14.3: Detected Intel(R) Wi-Fi 6E AX211 160MHz, REV=0x430
[   41.064994] thermal thermal_zone8: failed to read out thermal zone (-61)
[   41.074949] iwlwifi 0000:00:14.3: WRT: Invalid buffer destination
[   41.077380] usb 1-6: Found UVC 1.50 device Chicony USB2.0 Camera (04f2:b7e7)
[   41.087851] usbcore: registered new interface driver uvcvideo
[   41.236061] iwlwifi 0000:00:14.3: WFPM_UMAC_PD_NOTIFICATION: 0x20
[   41.236093] iwlwifi 0000:00:14.3: WFPM_LMAC2_PD_NOTIFICATION: 0x1f
[   41.236102] iwlwifi 0000:00:14.3: WFPM_AUTH_KEY_0: 0x90
[   41.236111] iwlwifi 0000:00:14.3: CNVI_SCU_SEQ_DATA_DW9: 0x0
[   41.237136] iwlwifi 0000:00:14.3: RFIm is deactivated, reason = 5
[   41.245076] iwlwifi 0000:00:14.3: loaded PNVM version e28bb9d7
[   41.262076] iwlwifi 0000:00:14.3: Detected RF GF, rfid=0x2010d000
[   41.329472] i915 0000:00:02.0: [drm] VT-d active for gfx access
[   41.330216] snd_hda_intel 0000:00:1f.3: enabling device (0000 -> 0002)
[   41.330298] iwlwifi 0000:00:14.3: base HW address: 98:5f:41:dd:bb:cf
[   41.330375] snd_hda_intel 0000:02:00.1: enabling device (0000 -> 0002)
[   41.330426] snd_hda_intel 0000:02:00.1: Disabling MSI
[   41.330429] snd_hda_intel 0000:02:00.1: Handle vga_switcheroo audio client
[   41.331846] intel_tcc_cooling: Programmable TCC Offset detected
[   41.347493] iwlwifi 0000:00:14.3 wlp0s20f3: renamed from wlan0
[   41.352559] input: HDA NVidia HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:01.1/0000:02:00.1/sound/card1/input33
[   41.352710] input: HDA NVidia HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:01.1/0000:02:00.1/sound/card1/input34
[   41.352753] input: HDA NVidia HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:01.1/0000:02:00.1/sound/card1/input35
[   41.352807] input: HDA NVidia HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:01.1/0000:02:00.1/sound/card1/input36
[   41.353722] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC1220: line_outs=1 (0x1b/0x0/0x0/0x0/0x0) type:speaker
[   41.353727] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[   41.353730] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=1 (0x14/0x0/0x0/0x0/0x0)
[   41.353732] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=0x0
[   41.353734] snd_hda_codec_realtek hdaudioC0D0:    dig-out=0x1e/0x0
[   41.353735] snd_hda_codec_realtek hdaudioC0D0:    inputs:
[   41.353749] snd_hda_codec_realtek hdaudioC0D0:      Mic=0x18
[   41.353750] snd_hda_codec_realtek hdaudioC0D0:      Internal Mic=0x12
[   41.355003] i915 0000:00:02.0: vgaarb: deactivate vga console
[   41.355057] i915 0000:00:02.0: [drm] Using Transparent Hugepages
[   41.355745] i915 0000:00:02.0: vgaarb: VGA decodes changed: olddecodes=io+mem,decodes=none:owns=io+mem
[   41.356661] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
[   41.357499] i915 0000:00:02.0: [drm] Finished loading DMC firmware i915/adls_dmc_ver2_01.bin (v2.1)
[   41.364117] input: HDA Intel PCH Mic as /devices/pci0000:00/0000:00:1f.3/sound/card0/input37
[   41.364176] input: HDA Intel PCH Headphone as /devices/pci0000:00/0000:00:1f.3/sound/card0/input38
[   41.376222] i915 0000:00:02.0: [drm] GT0: GuC firmware i915/tgl_guc_70.bin version 70.20.0
[   41.376226] i915 0000:00:02.0: [drm] GT0: HuC firmware i915/tgl_huc.bin version 7.9.3
[   41.385645] i915 0000:00:02.0: [drm] GT0: HuC: authenticated for all workloads
[   41.386353] i915 0000:00:02.0: [drm] GT0: GUC: submission enabled
[   41.386355] i915 0000:00:02.0: [drm] GT0: GUC: SLPC enabled
[   41.386921] i915 0000:00:02.0: [drm] GT0: GUC: RC enabled
[   41.387771] mei_pxp 0000:00:16.0-fbf6fcf1-96cf-4e2e-a6a6-1bab8cbe36b1: bound 0000:00:02.0 (ops i915_pxp_tee_component_ops [i915])
[   41.387927] i915 0000:00:02.0: [drm] Protected Xe Path (PXP) protected content support initialized
[   41.663834] BTRFS: device label kfocus_boot devid 1 transid 1419 /dev/nvme0n1p2 scanned by mount (1341)
[   41.664307] BTRFS info (device nvme0n1p2): first mount of filesystem c04cfaca-531b-479b-a332-848b3211ce9d
[   41.664320] BTRFS info (device nvme0n1p2): using crc32c (crc32c-intel) checksum algorithm
[   41.664324] BTRFS info (device nvme0n1p2): using free-space-tree
[   41.677529] Adding 524284k swap on /swap/swapfile.  Priority:-2 extents:1 across:524284k 
[   41.709597] audit: type=1400 audit(1728676250.224:2): apparmor="STATUS" operation="profile_load" profile="unconfined" name="crun" pid=1399 comm="apparmor_parser"
[   41.709601] audit: type=1400 audit(1728676250.224:3): apparmor="STATUS" operation="profile_load" profile="unconfined" name="epiphany" pid=1402 comm="apparmor_parser"
[   41.709734] audit: type=1400 audit(1728676250.225:4): apparmor="STATUS" operation="profile_load" profile="unconfined" name="balena-etcher" pid=1390 comm="apparmor_parser"
[   41.709820] audit: type=1400 audit(1728676250.225:5): apparmor="STATUS" operation="profile_load" profile="unconfined" name="QtWebEngineProcess" pid=1389 comm="apparmor_parser"
[   41.709824] audit: type=1400 audit(1728676250.225:6): apparmor="STATUS" operation="profile_load" profile="unconfined" name="1password" pid=1386 comm="apparmor_parser"
[   41.709826] audit: type=1400 audit(1728676250.225:7): apparmor="STATUS" operation="profile_load" profile="unconfined" name="element-desktop" pid=1401 comm="apparmor_parser"
[   41.709964] audit: type=1400 audit(1728676250.225:8): apparmor="STATUS" operation="profile_load" profile="unconfined" name="geary" pid=1408 comm="apparmor_parser"
[   41.709968] audit: type=1400 audit(1728676250.225:9): apparmor="STATUS" operation="profile_load" profile="unconfined" name="firefox" pid=1405 comm="apparmor_parser"
[   41.709989] audit: type=1400 audit(1728676250.225:10): apparmor="STATUS" operation="profile_load" profile="unconfined" name="evolution" pid=1403 comm="apparmor_parser"
[   41.710102] audit: type=1400 audit(1728676250.225:11): apparmor="STATUS" operation="profile_load" profile="unconfined" name="flatpak" pid=1406 comm="apparmor_parser"
[   42.374901] Bluetooth: hci0: Waiting for firmware download to complete
[   42.374916] Bluetooth: hci0: Firmware loaded in 1377216 usecs
[   42.375155] Bluetooth: hci0: Waiting for device to boot
[   42.391801] Bluetooth: hci0: Device booted in 16437 usecs
[   42.391818] Bluetooth: hci0: Malformed MSFT vendor event: 0x02
[   42.392157] Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-1040-0041.ddc
[   42.394699] Bluetooth: hci0: Applying Intel DDC parameters completed
[   42.397727] Bluetooth: hci0: Firmware timestamp 2023.48 buildtype 1 build 75324
[   42.397740] Bluetooth: hci0: Firmware SHA1: 0x23bac558
[   43.040405] i915 0000:00:02.0: [drm] Skipping intel_backlight registration
[   43.040723] [drm] Initialized i915 1.6.0 20230929 for 0000:00:02.0 on minor 2
[   43.041155] ACPI: video: [Firmware Bug]: ACPI(PEGP) defines _DOD but not _DOS
[   43.041189] ACPI: video: Video Device [PEGP] (multi-head: yes  rom: no  post: no)
[   43.041250] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:05/LNXVIDEO:00/input/input39
[   43.042740] ACPI: video: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[   43.043112] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:01/input/input40
[   43.043434] i915 display info: display version: 12
[   43.043437] i915 display info: cursor_needs_physical: no
[   43.043438] i915 display info: has_cdclk_crawl: no
[   43.043440] i915 display info: has_cdclk_squash: no
[   43.043441] i915 display info: has_ddi: yes
[   43.043443] i915 display info: has_dp_mst: yes
[   43.043444] i915 display info: has_dsb: yes
[   43.043445] i915 display info: has_fpga_dbg: yes
[   43.043446] i915 display info: has_gmch: no
[   43.043448] i915 display info: has_hotplug: yes
[   43.043449] i915 display info: has_hti: yes
[   43.043450] i915 display info: has_ipc: yes
[   43.043451] i915 display info: has_overlay: no
[   43.043452] i915 display info: has_psr: yes
[   43.043454] i915 display info: has_psr_hw_tracking: no
[   43.043455] i915 display info: overlay_needs_physical: no
[   43.043456] i915 display info: supports_tv: no
[   43.043457] i915 display info: has_hdcp: yes
[   43.043458] i915 display info: has_dmc: yes
[   43.043460] i915 display info: has_dsc: yes
[   43.046169] fbcon: i915drmfb (fb0) is primary device
[   43.046173] fbcon: Deferring console take-over
[   43.046177] i915 0000:00:02.0: [drm] fb0: i915drmfb frame buffer device
[   43.344559] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   43.344562] Bluetooth: BNEP filters: protocol multicast
[   43.344566] Bluetooth: BNEP socket layer initialized
[   43.345757] Bluetooth: MGMT ver 1.22
[   43.349244] NET: Registered PF_ALG protocol family
[   43.387927] loop14: detected capacity change from 0 to 8
[   43.469606] NET: Registered PF_QIPCRTR protocol family
[   44.132712] iwlwifi 0000:00:14.3: WRT: Invalid buffer destination
[   44.289153] iwlwifi 0000:00:14.3: WFPM_UMAC_PD_NOTIFICATION: 0x20
[   44.289196] iwlwifi 0000:00:14.3: WFPM_LMAC2_PD_NOTIFICATION: 0x1f
[   44.289228] iwlwifi 0000:00:14.3: WFPM_AUTH_KEY_0: 0x90
[   44.289260] iwlwifi 0000:00:14.3: CNVI_SCU_SEQ_DATA_DW9: 0x0
[   44.290153] iwlwifi 0000:00:14.3: RFIm is deactivated, reason = 5
[   44.382075] iwlwifi 0000:00:14.3: Registered PHC clock: iwlwifi-PTP, with index: 1
[   47.104454] igc 0000:03:00.0 enp3s0: NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
[   47.806067] vboxdrv: Found 32 processor cores/threads
[   47.822234] vboxdrv: TSC mode is Invariant, tentative frequency 2419176517 Hz
[   47.822238] vboxdrv: Successfully loaded version 7.0.16_Ubuntu r162802 (interface 0x00330004)
[   47.832200] VBoxNetFlt: Successfully started.
[   47.838104] VBoxNetAdp: Successfully started.
[   47.887565] kauditd_printk_skb: 138 callbacks suppressed
[   47.887574] audit: type=1400 audit(1728676256.402:150): apparmor="STATUS" operation="profile_load" profile="unconfined" name="docker-default" pid=2639 comm="apparmor_parser"
[   48.349939] evm: overlay not supported
[   48.541144] Initializing XFRM netlink socket
[   48.564822] bridge: filtering via arp/ip/ip6tables is no longer available by default. Update your scripts to load br_netfilter if you need this.
[   50.258944] Bluetooth: RFCOMM TTY layer initialized
[   50.258950] Bluetooth: RFCOMM socket layer initialized
[   50.258953] Bluetooth: RFCOMM ver 1.11
[   58.348938] systemd-journald[779]: /var/log/journal/947663c1d7a1413e89306987834604de/user-1000.journal: Journal file uses a different sequence number ID, rotating.
[   59.190835] warning: `kded5' uses wireless extensions which will stop working for Wi-Fi 7 hardware; use nl80211
[   59.687857] wlp0s20f3: authenticate with a0:55:1f:2f:2c:92 (local address=98:5f:41:dd:bb:cf)
[   59.688981] wlp0s20f3: send auth to a0:55:1f:2f:2c:92 (try 1/3)
[   59.721336] wlp0s20f3: authenticated
[   59.721719] wlp0s20f3: associate with a0:55:1f:2f:2c:92 (try 1/3)
[   59.723783] wlp0s20f3: RX AssocResp from a0:55:1f:2f:2c:92 (capab=0x1011 status=0 aid=22)
[   59.730027] wlp0s20f3: associated
[   59.737562] wlp0s20f3: Limiting TX power to 30 (30 - 0) dBm as advertised by a0:55:1f:2f:2c:92
[   60.126328] thunderbolt 0000:06:00.0: control channel starting...
[   60.126332] thunderbolt 0000:06:00.0: starting TX ring 0
[   60.126337] thunderbolt 0000:06:00.0: enabling interrupt at register 0x38200 bit 0 (0x0 -> 0x1)
[   60.126339] thunderbolt 0000:06:00.0: starting RX ring 0
[   60.126344] thunderbolt 0000:06:00.0: enabling interrupt at register 0x38200 bit 12 (0x1 -> 0x1001)
[   60.126347] thunderbolt 0000:06:00.0: 0: resuming switch
[   60.126348] thunderbolt 0000:06:00.0: restoring Switch at 0x0 (depth: 0, up port: 15)
[   60.126877] xhci_hcd 0000:2d:00.0: xHC error in resume, USBSTS 0x401, Reinit
[   60.126879] usb usb3: root hub lost power or was reset
[   60.126880] usb usb4: root hub lost power or was reset
[   60.128535] thunderbolt 0000:06:00.0: 0: disabling wakeup
[   60.129481] thunderbolt 0000:06:00.0: acking hot plug event on 0:13
[   60.129601] thunderbolt 0000:06:00.0: acking hot plug event on 0:14
[   60.129730] thunderbolt 0000:06:00.0: acking hot plug event on 0:16
[   60.137467] thunderbolt 0000:06:00.0: 0: TMU: supports uni-directional mode
[   60.137478] thunderbolt 0000:06:00.0: 0: TMU: supports enhanced uni-directional mode
[   60.137589] thunderbolt 0000:06:00.0: 0: TMU: current mode: off
[   60.137591] thunderbolt 0000:06:00.0: 0: TMU: mode change off -> bi-directional, HiFi requested
[   60.138102] thunderbolt 0000:06:00.0: 0: TMU: mode set to: bi-directional, HiFi
[   60.139778] thunderbolt 0000:06:00.0: 0:13: DP IN resource available after hotplug
[   60.139783] thunderbolt 0000:06:00.0: looking for DP IN <-> DP OUT pairs:
[   60.139895] thunderbolt 0000:06:00.0: 0:13: DP IN available
[   60.139896] thunderbolt 0000:06:00.0: no suitable DP OUT adapter available, not tunneling
[   60.140018] thunderbolt 0000:06:00.0: 0:14: DP IN resource available after hotplug
[   60.140021] thunderbolt 0000:06:00.0: looking for DP IN <-> DP OUT pairs:
[   60.140145] thunderbolt 0000:06:00.0: 0:13: DP IN available
[   60.140277] thunderbolt 0000:06:00.0: 0:14: DP IN available
[   60.140278] thunderbolt 0000:06:00.0: no suitable DP OUT adapter available, not tunneling
[   78.863111] thunderbolt 0000:06:00.0: 0: suspending switch
[   78.863125] thunderbolt 0000:06:00.0: 0: enabling wakeup: 0x3f
[   78.864812] thunderbolt 0000:06:00.0: stopping RX ring 0
[   78.864825] thunderbolt 0000:06:00.0: disabling interrupt at register 0x38200 bit 12 (0x1001 -> 0x1)
[   78.864849] thunderbolt 0000:06:00.0: stopping TX ring 0
[   78.864857] thunderbolt 0000:06:00.0: disabling interrupt at register 0x38200 bit 0 (0x1 -> 0x0)
[   78.864870] thunderbolt 0000:06:00.0: control channel stopped
[  115.145733] usb 1-9: new high-speed USB device number 6 using xhci_hcd
[  115.621717] usb 1-9: New USB device found, idVendor=2109, idProduct=0100, bcdDevice= 3.00
[  115.621725] usb 1-9: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[  115.621727] usb 1-9: Product: USB-C dongle
[  115.621729] usb 1-9: Manufacturer: VIA Technologies Inc.         
[  115.621731] usb 1-9: SerialNumber: 0000000000000001
[  116.025680] usb 1-10: new high-speed USB device number 7 using xhci_hcd
[  116.172071] usb 1-10: New USB device found, idVendor=0bda, idProduct=5411, bcdDevice= 1.49
[  116.172087] usb 1-10: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[  116.172092] usb 1-10: Product: 4-Port USB 2.0 Hub
[  116.172096] usb 1-10: Manufacturer: Generic
[  116.175384] hub 1-10:1.0: USB hub found
[  116.177810] hub 1-10:1.0: 4 ports detected
[  116.466759] usb 1-10.3: new full-speed USB device number 8 using xhci_hcd
[  116.557830] usb 1-10.3: New USB device found, idVendor=043e, idProduct=9a39, bcdDevice= 4.11
[  116.557840] usb 1-10.3: New USB device strings: Mfr=1, Product=3, SerialNumber=4
[  116.557843] usb 1-10.3: Product: LG Monitor Controls
[  116.557845] usb 1-10.3: Manufacturer: LG Electronics Inc.
[  116.557847] usb 1-10.3: SerialNumber: 005INTX1F153
[  116.564157] hid-generic 0003:043E:9A39.0008: hiddev1,hidraw5: USB HID v1.11 Device [LG Electronics Inc. LG Monitor Controls] on usb-0000:00:14.0-10.3/input0
[  182.118304] thunderbolt 0000:06:00.0: control channel starting...
[  182.118314] thunderbolt 0000:06:00.0: starting TX ring 0
[  182.118325] thunderbolt 0000:06:00.0: enabling interrupt at register 0x38200 bit 0 (0x0 -> 0x1)
[  182.118329] thunderbolt 0000:06:00.0: starting RX ring 0
[  182.118338] thunderbolt 0000:06:00.0: enabling interrupt at register 0x38200 bit 12 (0x1 -> 0x1001)
[  182.118348] thunderbolt 0000:06:00.0: 0: resuming switch
[  182.118351] thunderbolt 0000:06:00.0: restoring Switch at 0x0 (depth: 0, up port: 15)
[  182.118509] xhci_hcd 0000:2d:00.0: xHC error in resume, USBSTS 0x401, Reinit
[  182.118519] usb usb3: root hub lost power or was reset
[  182.118522] usb usb4: root hub lost power or was reset
[  182.118608] thunderbolt 0000:06:00.0: 0: disabling wakeup
[  182.127404] thunderbolt 0000:06:00.0: 0: TMU: supports uni-directional mode
[  182.127416] thunderbolt 0000:06:00.0: 0: TMU: supports enhanced uni-directional mode
[  182.127524] thunderbolt 0000:06:00.0: 0: TMU: current mode: off
[  182.127527] thunderbolt 0000:06:00.0: 0: TMU: mode change off -> bi-directional, HiFi requested
[  182.128042] thunderbolt 0000:06:00.0: 0: TMU: mode set to: bi-directional, HiFi
[  182.128938] thunderbolt 0000:06:00.0: 0:13: enter redrive mode, keeping powered
[  182.129059] thunderbolt 0000:06:00.0: acking hot plug event on 0:16
[  182.129759] thunderbolt 0000:06:00.0: 0:14: enter redrive mode, keeping powered
[  315.548678] usb 1-10: USB disconnect, device number 7
[  315.548692] usb 1-10.3: USB disconnect, device number 8
[  315.601384] thunderbolt 0000:06:00.0: acking hot plug event on 0:14
[  315.601762] thunderbolt 0000:06:00.0: 0:14: DP IN resource available after hotplug
[  315.602370] thunderbolt 0000:06:00.0: 0:14: exit redrive mode
[  315.602375] thunderbolt 0000:06:00.0: looking for DP IN <-> DP OUT pairs:
[  315.602549] thunderbolt 0000:06:00.0: 0:14: DP IN available
[  315.602553] thunderbolt 0000:06:00.0: no suitable DP OUT adapter available, not tunneling
[  353.564629] usb 1-9: USB disconnect, device number 6
[  353.610947] thunderbolt 0000:06:00.0: acking hot plug event on 0:13
[  353.611260] thunderbolt 0000:06:00.0: 0:13: DP IN resource available after hotplug
[  353.611921] thunderbolt 0000:06:00.0: 0:13: exit redrive mode
[  353.611933] thunderbolt 0000:06:00.0: looking for DP IN <-> DP OUT pairs:
[  353.612076] thunderbolt 0000:06:00.0: 0:14: DP IN available
[  353.612258] thunderbolt 0000:06:00.0: 0:13: DP IN available
[  353.612264] thunderbolt 0000:06:00.0: no suitable DP OUT adapter available, not tunneling
[  372.362496] thunderbolt 0000:06:00.0: 0: suspending switch
[  372.362506] thunderbolt 0000:06:00.0: 0: enabling wakeup: 0x3f
[  372.363480] thunderbolt 0000:06:00.0: stopping RX ring 0
[  372.363497] thunderbolt 0000:06:00.0: disabling interrupt at register 0x38200 bit 12 (0x1001 -> 0x1)
[  372.363523] thunderbolt 0000:06:00.0: stopping TX ring 0
[  372.363539] thunderbolt 0000:06:00.0: disabling interrupt at register 0x38200 bit 0 (0x1 -> 0x0)
[  372.363558] thunderbolt 0000:06:00.0: control channel stopped
[  397.557526] logitech-hidpp-device 0003:046D:4082.0006: HID++ 4.5 device connected.
[  404.630560] usb 1-10: new high-speed USB device number 9 using xhci_hcd
[  404.775633] usb 1-10: New USB device found, idVendor=0bda, idProduct=5411, bcdDevice= 1.49
[  404.775641] usb 1-10: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[  404.775644] usb 1-10: Product: 4-Port USB 2.0 Hub
[  404.775645] usb 1-10: Manufacturer: Generic
[  404.783748] hub 1-10:1.0: USB hub found
[  404.785121] hub 1-10:1.0: 4 ports detected
[  405.073499] usb 1-10.3: new full-speed USB device number 10 using xhci_hcd
[  405.165278] usb 1-10.3: New USB device found, idVendor=043e, idProduct=9a39, bcdDevice= 4.11
[  405.165293] usb 1-10.3: New USB device strings: Mfr=1, Product=3, SerialNumber=4
[  405.165298] usb 1-10.3: Product: LG Monitor Controls
[  405.165302] usb 1-10.3: Manufacturer: LG Electronics Inc.
[  405.165305] usb 1-10.3: SerialNumber: 005INTX1F153
[  405.172171] hid-generic 0003:043E:9A39.0009: hiddev1,hidraw5: USB HID v1.11 Device [LG Electronics Inc. LG Monitor Controls] on usb-0000:00:14.0-10.3/input0
[  473.933405] usb 1-9: new high-speed USB device number 11 using xhci_hcd
[  474.408981] usb 1-9: New USB device found, idVendor=2109, idProduct=0100, bcdDevice= 3.00
[  474.408999] usb 1-9: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[  474.409005] usb 1-9: Product: USB-C dongle
[  474.409010] usb 1-9: Manufacturer: VIA Technologies Inc.         
[  474.409014] usb 1-9: SerialNumber: 0000000000000001
[  545.126296] wlp0s20f3: deauthenticating from a0:55:1f:2f:2c:92 by local choice (Reason: 3=DEAUTH_LEAVING)
[  545.867762] PM: suspend entry (deep)
[  546.017682] Filesystems sync: 0.149 seconds
[  546.193145] Freezing user space processes
[  546.194723] Freezing user space processes completed (elapsed 0.001 seconds)
[  546.194726] OOM killer disabled.
[  546.194726] Freezing remaining freezable tasks
[  546.196173] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
[  546.196227] printk: Suspending console(s) (use no_console_suspend to debug)
[  546.215655] tuxedo_keyboard: Set keyboard enabled to: 0
[  546.652610] thunderbolt 0000:06:00.0: control channel starting...
[  546.652621] thunderbolt 0000:06:00.0: starting TX ring 0
[  546.652632] thunderbolt 0000:06:00.0: enabling interrupt at register 0x38200 bit 0 (0x0 -> 0x1)
[  546.652637] thunderbolt 0000:06:00.0: starting RX ring 0
[  546.652645] thunderbolt 0000:06:00.0: enabling interrupt at register 0x38200 bit 12 (0x1 -> 0x1001)
[  546.652655] thunderbolt 0000:06:00.0: 0: resuming switch
[  546.652658] thunderbolt 0000:06:00.0: restoring Switch at 0x0 (depth: 0, up port: 15)
[  546.652778] thunderbolt 0000:06:00.0: 0: disabling wakeup
[  546.652832] xhci_hcd 0000:2d:00.0: xHC error in resume, USBSTS 0x401, Reinit
[  546.652841] usb usb3: root hub lost power or was reset
[  546.652844] usb usb4: root hub lost power or was reset
[  546.661566] thunderbolt 0000:06:00.0: 0: TMU: supports uni-directional mode
[  546.661572] thunderbolt 0000:06:00.0: 0: TMU: supports enhanced uni-directional mode
[  546.661693] thunderbolt 0000:06:00.0: 0: TMU: current mode: off
[  546.661698] thunderbolt 0000:06:00.0: 0: TMU: mode change off -> bi-directional, HiFi requested
[  546.662207] thunderbolt 0000:06:00.0: 0: TMU: mode set to: bi-directional, HiFi
[  546.663106] thunderbolt 0000:06:00.0: 0:13: enter redrive mode, keeping powered
[  546.663743] thunderbolt 0000:06:00.0: 0:14: enter redrive mode, keeping powered
[  546.663867] thunderbolt 0000:06:00.0: acking hot plug event on 0:16
[  547.004747] ACPI: EC: interrupt blocked
[  547.004897] thunderbolt 0000:06:00.0: suspending...
[  547.004907] thunderbolt 0000:06:00.0: 0:13: exit redrive mode
[  547.004914] thunderbolt 0000:06:00.0: 0:14: exit redrive mode
[  547.004918] thunderbolt 0000:06:00.0: 0: suspending switch
[  547.004923] thunderbolt 0000:06:00.0: 0: enabling wakeup: 0x1c
[  547.006135] thunderbolt 0000:06:00.0: suspend finished
[  547.006139] thunderbolt 0000:06:00.0: stopping RX ring 0
[  547.006144] thunderbolt 0000:06:00.0: disabling interrupt at register 0x38200 bit 12 (0x1001 -> 0x1)
[  547.006156] thunderbolt 0000:06:00.0: stopping TX ring 0
[  547.006160] thunderbolt 0000:06:00.0: disabling interrupt at register 0x38200 bit 0 (0x1 -> 0x0)
[  547.006166] thunderbolt 0000:06:00.0: control channel stopped
[  547.097940] ACPI: PM: Preparing to enter system sleep state S3
[  547.113846] ACPI: EC: event blocked
[  547.113847] ACPI: EC: EC stopped
[  547.113847] ACPI: PM: Saving platform NVS memory
[  547.114190] Disabling non-boot CPUs ...
[  547.115955] IRQ186: set affinity failed(-22).
[  547.115957] IRQ187: set affinity failed(-22).
[  547.122147] smpboot: CPU 1 is now offline
[  547.125420] IRQ186: set affinity failed(-22).
[  547.125424] IRQ187: set affinity failed(-22).
[  547.126457] smpboot: CPU 2 is now offline
[  547.130149] IRQ186: set affinity failed(-22).
[  547.130152] IRQ187: set affinity failed(-22).
[  547.131219] smpboot: CPU 3 is now offline
[  547.133781] IRQ186: set affinity failed(-22).
[  547.133787] IRQ187: set affinity failed(-22).
[  547.134823] smpboot: CPU 4 is now offline
[  547.141552] IRQ186: set affinity failed(-22).
[  547.141556] IRQ187: set affinity failed(-22).
[  547.142595] smpboot: CPU 5 is now offline
[  547.146331] smpboot: CPU 6 is now offline
[  547.153984] smpboot: CPU 7 is now offline
[  547.157377] smpboot: CPU 8 is now offline
[  547.164202] smpboot: CPU 9 is now offline
[  547.168230] smpboot: CPU 10 is now offline
[  547.174867] smpboot: CPU 11 is now offline
[  547.178451] smpboot: CPU 12 is now offline
[  547.185254] smpboot: CPU 13 is now offline
[  547.188975] smpboot: CPU 14 is now offline
[  547.195666] smpboot: CPU 15 is now offline
[  547.200152] smpboot: CPU 16 is now offline
[  547.204594] smpboot: CPU 17 is now offline
[  547.209000] smpboot: CPU 18 is now offline
[  547.214078] smpboot: CPU 19 is now offline
[  547.219071] smpboot: CPU 20 is now offline
[  547.224104] smpboot: CPU 21 is now offline
[  547.228585] smpboot: CPU 22 is now offline
[  547.232932] smpboot: CPU 23 is now offline
[  547.237182] smpboot: CPU 24 is now offline
[  547.241171] smpboot: CPU 25 is now offline
[  547.244602] smpboot: CPU 26 is now offline
[  547.248143] smpboot: CPU 27 is now offline
[  547.251375] smpboot: CPU 28 is now offline
[  547.254468] smpboot: CPU 29 is now offline
[  547.258266] smpboot: CPU 30 is now offline
[  547.261212] smpboot: CPU 31 is now offline
[  547.265331] ACPI: PM: Low-level resume complete
[  547.265408] ACPI: EC: EC started
[  547.265409] ACPI: PM: Restoring platform NVS memory
[  547.267119] Enabling non-boot CPUs ...
[  547.267212] smpboot: Booting Node 0 Processor 1 APIC 0x1
[  547.274467] CPU1 is up
[  547.274481] smpboot: Booting Node 0 Processor 2 APIC 0x8
[  547.280063] CPU2 is up
[  547.280078] smpboot: Booting Node 0 Processor 3 APIC 0x9
[  547.285991] CPU3 is up
[  547.286009] smpboot: Booting Node 0 Processor 4 APIC 0x10
[  547.291017] CPU4 is up
[  547.291032] smpboot: Booting Node 0 Processor 5 APIC 0x11
[  547.296051] CPU5 is up
[  547.296067] smpboot: Booting Node 0 Processor 6 APIC 0x18
[  547.301086] CPU6 is up
[  547.301102] smpboot: Booting Node 0 Processor 7 APIC 0x19
[  547.305102] CPU7 is up
[  547.305117] smpboot: Booting Node 0 Processor 8 APIC 0x20
[  547.309136] CPU8 is up
[  547.309161] smpboot: Booting Node 0 Processor 9 APIC 0x21
[  547.313130] CPU9 is up
[  547.313149] smpboot: Booting Node 0 Processor 10 APIC 0x28
[  547.319525] CPU10 is up
[  547.319567] smpboot: Booting Node 0 Processor 11 APIC 0x29
[  547.327549] CPU11 is up
[  547.327594] smpboot: Booting Node 0 Processor 12 APIC 0x30
[  547.333558] CPU12 is up
[  547.333600] smpboot: Booting Node 0 Processor 13 APIC 0x31
[  547.341838] CPU13 is up
[  547.341882] smpboot: Booting Node 0 Processor 14 APIC 0x38
[  547.349858] CPU14 is up
[  547.349903] smpboot: Booting Node 0 Processor 15 APIC 0x39
[  547.357754] CPU15 is up
[  547.357800] smpboot: Booting Node 0 Processor 16 APIC 0x40
[  547.363050] core: cpu_atom PMU driver: PEBS-via-PT 
[  547.363057] ... version:                5
[  547.363059] ... bit width:              48
[  547.363060] ... generic registers:      6
[  547.363061] ... value mask:             0000ffffffffffff
[  547.363062] ... max period:             00007fffffffffff
[  547.363063] ... fixed-purpose events:   3
[  547.363063] ... event mask:             000000070000003f
[  547.365071] CPU16 is up
[  547.365110] smpboot: Booting Node 0 Processor 17 APIC 0x42
[  547.372308] CPU17 is up
[  547.372354] smpboot: Booting Node 0 Processor 18 APIC 0x44
[  547.379394] CPU18 is up
[  547.379440] smpboot: Booting Node 0 Processor 19 APIC 0x46
[  547.386408] CPU19 is up
[  547.386451] smpboot: Booting Node 0 Processor 20 APIC 0x48
[  547.393841] CPU20 is up
[  547.393888] smpboot: Booting Node 0 Processor 21 APIC 0x4a
[  547.400506] CPU21 is up
[  547.400551] smpboot: Booting Node 0 Processor 22 APIC 0x4c
[  547.407548] CPU22 is up
[  547.407592] smpboot: Booting Node 0 Processor 23 APIC 0x4e
[  547.415142] CPU23 is up
[  547.415199] smpboot: Booting Node 0 Processor 24 APIC 0x50
[  547.422687] CPU24 is up
[  547.422732] smpboot: Booting Node 0 Processor 25 APIC 0x52
[  547.430404] CPU25 is up
[  547.430453] smpboot: Booting Node 0 Processor 26 APIC 0x54
[  547.439772] CPU26 is up
[  547.439813] smpboot: Booting Node 0 Processor 27 APIC 0x56
[  547.446848] CPU27 is up
[  547.446897] smpboot: Booting Node 0 Processor 28 APIC 0x58
[  547.455930] CPU28 is up
[  547.455984] smpboot: Booting Node 0 Processor 29 APIC 0x5a
[  547.464981] CPU29 is up
[  547.465025] smpboot: Booting Node 0 Processor 30 APIC 0x5c
[  547.474105] CPU30 is up
[  547.474149] smpboot: Booting Node 0 Processor 31 APIC 0x5e
[  547.482160] CPU31 is up
[  547.498400] ACPI: PM: Waking up from system sleep state S3
[  547.520016] ACPI: EC: interrupt unblocked
[  547.760783] thunderbolt 0000:06:00.0: control channel starting...
[  547.760796] thunderbolt 0000:06:00.0: starting TX ring 0
[  547.760813] thunderbolt 0000:06:00.0: enabling interrupt at register 0x38200 bit 0 (0x0 -> 0x1)
[  547.760819] thunderbolt 0000:06:00.0: starting RX ring 0
[  547.760829] thunderbolt 0000:06:00.0: enabling interrupt at register 0x38200 bit 12 (0x1 -> 0x1001)
[  547.760841] thunderbolt 0000:06:00.0: resuming...
[  547.760844] thunderbolt 0000:06:00.0: 0: resuming switch
[  547.760848] thunderbolt 0000:06:00.0: restoring Switch at 0x0 (depth: 0, up port: 15)
[  547.761110] thunderbolt 0000:06:00.0: 0:1: USB4 wake: no, connection wake: no, disconnection wake: no
[  547.761354] thunderbolt 0000:06:00.0: 0:3: USB4 wake: no, connection wake: no, disconnection wake: no
[  547.761373] thunderbolt 0000:06:00.0: 0: disabling wakeup
[  547.764232] thunderbolt 0000:06:00.0: acking hot plug event on 0:16
[  547.770380] thunderbolt 0000:06:00.0: 0: TMU: supports uni-directional mode
[  547.770393] thunderbolt 0000:06:00.0: 0: TMU: supports enhanced uni-directional mode
[  547.770504] thunderbolt 0000:06:00.0: 0: TMU: current mode: off
[  547.770512] thunderbolt 0000:06:00.0: 0: TMU: mode change off -> bi-directional, HiFi requested
[  547.771015] thunderbolt 0000:06:00.0: 0: TMU: mode set to: bi-directional, HiFi
[  547.772681] thunderbolt 0000:06:00.0: 0:13: enter redrive mode, keeping powered
[  547.773320] thunderbolt 0000:06:00.0: 0:14: enter redrive mode, keeping powered
[  547.773324] thunderbolt 0000:06:00.0: resume finished
[  547.777468] ACPI: EC: event unblocked
[  547.781233] xhci_hcd 0000:2d:00.0: xHC error in resume, USBSTS 0x401, Reinit
[  547.781241] usb usb3: root hub lost power or was reset
[  547.781244] usb usb4: root hub lost power or was reset
[  547.783440] pcieport 10000:e0:06.0: can't derive routing for PCI INT A
[  547.783447] nvme 10000:e1:00.0: PCI INT A: no GSI
[  547.783531] pcieport 10000:e0:1b.4: can't derive routing for PCI INT A
[  547.783537] nvme 10000:e2:00.0: PCI INT A: no GSI
[  547.795596] nvme nvme0: Shutdown timeout set to 10 seconds
[  547.795803] i915 0000:00:02.0: [drm] GT0: GuC firmware i915/tgl_guc_70.bin version 70.20.0
[  547.795806] i915 0000:00:02.0: [drm] GT0: HuC firmware i915/tgl_huc.bin version 7.9.3
[  547.796414] nvme nvme1: Shutdown timeout set to 10 seconds
[  547.798737] nvme nvme0: 18/0/0 default/read/poll queues
[  547.800009] nvme nvme1: 18/0/0 default/read/poll queues
[  547.803993] i915 0000:00:02.0: [drm] GT0: HuC: authenticated for all workloads
[  547.804685] i915 0000:00:02.0: [drm] GT0: GUC: submission enabled
[  547.804685] i915 0000:00:02.0: [drm] GT0: GUC: SLPC enabled
[  547.805154] i915 0000:00:02.0: [drm] GT0: GUC: RC enabled
[  548.037654] tuxedo_keyboard: set_mode on CUSTOM
[  548.062597] tuxedo_keyboard: Set brightness on 125
[  548.063812] usb 1-6: reset high-speed USB device number 3 using xhci_hcd
[  548.069562] tuxedo_keyboard: Set keyboard enabled to: 1
[  548.312653] usb 1-7: reset full-speed USB device number 4 using xhci_hcd
[  548.824688] pci_bus 0000:06: Allocating resources
[  548.824704] pci_bus 0000:2d: Allocating resources
[  548.824755] pci_bus 0000:06: Allocating resources
[  548.824767] pci_bus 0000:2d: Allocating resources
[  548.824729] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
[  548.825768] mei_pxp 0000:00:16.0-fbf6fcf1-96cf-4e2e-a6a6-1bab8cbe36b1: bound 0000:00:02.0 (ops i915_pxp_tee_component_ops [i915])
[  548.825965] OOM killer enabled.
[  548.825966] Restarting tasks ... done.
[  548.826676] random: crng reseeded on system resumption
[  548.828981] PM: suspend exit
[  548.828996] thermal thermal_zone8: failed to read out thermal zone (-61)
[  548.971190] iwlwifi 0000:00:14.3: WRT: Invalid buffer destination
[  549.127332] iwlwifi 0000:00:14.3: WFPM_UMAC_PD_NOTIFICATION: 0x20
[  549.127389] iwlwifi 0000:00:14.3: WFPM_LMAC2_PD_NOTIFICATION: 0x1f
[  549.127398] iwlwifi 0000:00:14.3: WFPM_AUTH_KEY_0: 0x90
[  549.127406] iwlwifi 0000:00:14.3: CNVI_SCU_SEQ_DATA_DW9: 0x0
[  549.128430] iwlwifi 0000:00:14.3: RFIm is deactivated, reason = 5
[  551.941912] igc 0000:03:00.0 enp3s0: NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
[  552.566710] wlp0s20f3: authenticate with a0:55:1f:2f:2c:92 (local address=98:5f:41:dd:bb:cf)
[  552.567831] wlp0s20f3: send auth to a0:55:1f:2f:2c:92 (try 1/3)
[  552.600514] wlp0s20f3: authenticated
[  552.601185] wlp0s20f3: associate with a0:55:1f:2f:2c:92 (try 1/3)
[  552.603298] wlp0s20f3: RX AssocResp from a0:55:1f:2f:2c:92 (capab=0x1011 status=0 aid=19)
[  552.609422] wlp0s20f3: associated
[  552.661499] wlp0s20f3: Limiting TX power to 30 (30 - 0) dBm as advertised by a0:55:1f:2f:2c:92

--MP_/=_++1Fd/UC4uZ2dD5GFiPsE--

