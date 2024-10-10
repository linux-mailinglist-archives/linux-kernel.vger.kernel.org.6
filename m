Return-Path: <linux-kernel+bounces-358246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 289A5997BFC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 06:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D73892850EB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 04:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F78919DF8B;
	Thu, 10 Oct 2024 04:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M54YrQTi"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF873D66;
	Thu, 10 Oct 2024 04:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728535764; cv=none; b=Jn3BBR2SxlB7ez3OM+lT1XrH7Sa0R5M244duUSLYl70jf1lt1PQ8zEgijBGiFUNedm3eE8q141xwKdu4qO/8XI/IHGx2iD1uxsMJm4129qbsftfqQlD/rH254elKhyKwfS2Q5YkeNe/HlSQHCWtLURnYlQHr+rzR8Oz2Xmg2uCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728535764; c=relaxed/simple;
	bh=6uD7+Lz1uQ9AvseMbxbYZZEXYTNf2RjByl/bq7iRchk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hpm2u1eJKY+4LS48WEX1xEnrY+BFxv93zD7hcLZDPShnSg57JUaC86peiLMv34cvNy5mdFHXulSOWEaqp11joGSdgAXSHrXp5tyX51uk57r2W5LH0V4y/uViK8Gv1j7Hpv73CfSWAV81jAU6RHP+rTffM5q/1sqQglnKhiIZxy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M54YrQTi; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728535763; x=1760071763;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=6uD7+Lz1uQ9AvseMbxbYZZEXYTNf2RjByl/bq7iRchk=;
  b=M54YrQTiVbwm5PBkAJnLpI/MI0KJVXAWG/WnGzodsUYfqTJ+kzl5hMU7
   XZXNo3FCE5ByPBT1aCfuMKLVsm38hv1wnf7CtLR/zXBz1YTTLpPg9EOyV
   rNdmHaacAcTM2xgKbeNagW5eJY9LnDCIcpKYAndCUKWHTCUhnixcWA/sh
   pngCg4pWG4cbxyQs0Xy6DMeeUmApkfM3tFucw2f4FCHy1Whn0p4OVdU/a
   1wqBwBgZgTB6F3+A5PFAfi3nTJXLUq9yOnBF0RaxlJXUmSS8Xzc6+nrxN
   I3rBWp2dUVKDVqNgCqfoe1u1CdKqGqs668jGZsQFah8EOK04kFvT/U2U+
   w==;
X-CSE-ConnectionGUID: NHg1FerCRDiSJdKmA4wRsw==
X-CSE-MsgGUID: afbkvpB8S/KHcGI4+eWt4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="30746399"
X-IronPort-AV: E=Sophos;i="6.11,191,1725346800"; 
   d="scan'208";a="30746399"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 21:49:22 -0700
X-CSE-ConnectionGUID: eFTJs6mfTfqtojUaSIuLww==
X-CSE-MsgGUID: kmFueEPGR1eXTYaiys3yiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,191,1725346800"; 
   d="scan'208";a="76085520"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 09 Oct 2024 21:49:20 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 796D4192; Thu, 10 Oct 2024 07:49:19 +0300 (EEST)
Date: Thu, 10 Oct 2024 07:49:19 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Aaron Rainbolt <arainbolt@kfocus.org>
Cc: YehezkelShB@gmail.com, michael.jamet@intel.com,
	andreas.noever@gmail.com, linux-usb@vger.kernel.org,
	mmikowski@kfocus.org, linux-kernel@vger.kernel.org
Subject: Re: USB-C DisplayPort display failing to stay active with Intel
 Barlow Ridge USB4 controller, power-management related issue?
Message-ID: <20241010044919.GD275077@black.fi.intel.com>
References: <20241009220118.70bfedd0@kf-ir16>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241009220118.70bfedd0@kf-ir16>

Hi,

On Wed, Oct 09, 2024 at 10:01:18PM -0500, Aaron Rainbolt wrote:
> We're experiencing a Linux kernel bug affecting multiple Clevo X370SNx1
> laptops (specifically the X370SNW1 variant). The bug appears to be
> present in kernels greater than or equal to 6.5, worsening
> significantly with kernel 6.11.2 (latest stable at time of this
> writing). It is unclear if all of the issues encountered are the same
> bug, however the primary problem we've run into appears to be a
> consequence of the power management code involving Intel Barlow Ridge
> controllers and DisplayPort. The issue occurs with in-kernel Nouveau
> drivers and also with proprietary NVIDIA drivers.
> 
> When a DisplayPort monitor is attached to these laptops via a USB-C
> connection, the monitor is recognized by the system and comes on for
> approximately 15 seconds. It then blanks out and is automatically
> disconnected from the system as if it had been unplugged. It will
> remain that way indefinitely until unplugged and replugged, or until
> something "jiggles" (for lack of a better term) the thunderbolt driver.
> When either of these things occur, the display will re-attach and come
> back on for 15 seconds, then blank out and detach again. There are
> various different things that can "jiggle" the thunderbolt driver,
> including but not limited to:
> 
> * Running `lspci -k` (this one came as a particular surprise)
> * Removing and re-inserting the thunderbolt driver (`sudo modprobe -r
>   thunderbolt; sleep 1; sudo modprobe thunderbolt`)
> * Running `nvidia-detector` while proprietary NVIDIA drivers are loaded

Or just disabling runtime PM, I presume.

> It is possible to mitigate this issue by simply running
> `sudo modprobe -r thunderbolt` or `sudo rmmod thunderbolt` and then
> leaving the driver unloaded. USB-C displays become stable after this -
> they are recognized when attached and remain recognized and functional
> indefinitely as one would expect.
> 
> We believe this is related to the Intel Barlow Ridge USB4 controller
> because:
> 
> * Removing the thunderbolt driver restores normal display operation.
> * This issue was *not* a problem on Clevo X370SNx machines, which are
>   identical to the X370SNx1 except for the Maple Ridge TBT controller
>   on the board has been replaced with a Barlow Ridge USB4 controller.
> * This problem does not occur on the affected models with the 6.1
>   kernel. It occurs with the 6.5 kernel and on all newer kernels we
>   have tried.
> 
> Furthermore, from inspecting the Thunderbolt driver code, we believe
> this is related to the power management features of the driver, because:
> 
> * There is only one 15-second timeout defined in the driver source
>   code, that being TB_AUTOSUSPEND_DELAY in drivers/thunderbolt/tb.h
> * On earlier kernels (Ubuntu’s variant of 6.8 at least), displays are
>   stable even when the thunderbolt driver is loaded if we:
>   * Remove the thunderbolt driver
>   * Attach a USB-C dock
>   * Attach displays to the dock (we used 2 4K HDMI monitors)
>   * Reload the thunderbolt driver
> 
> During our investigation, we discovered commit
> a75e0684efe567ae5f6a8e91a8360c4c1773cf3a (patch on mailing list at
> https://lore.kernel.org/linux-usb/20240213114318.3023150-1-mika.westerberg@linux.intel.com/)
> which appears to be a fix for this exact problem. It adds a quirk for
> Intel Barlow Ridge controllers, which detects when a DisplayPort device
> has been plugged directly into the USB4 port (thus using "redrive"
> mode), and instructs the power management subsystem to not power the
> chip down during this time if so. Unfortunately, this quirk seems to be
> silently ignored, as we built a custom kernel with some `printk` lines
> added to the `tb_enter_redrive` and `tb_exit_redrive` functions to
> announce when they were called, and nothing in the dmesg log indicated
> that they had been called when we did this.
> 
> This bug is easily reproducible using the stock kernels in Kubuntu
> 22.04, Kubuntu 24.04, Kali Linux 2024.2, and Fedora Workstation
> Rawhide. Similar behavior is observed across all of these distributions.
> 
> We built the 6.11.2 kernel from source and tested it on Kubuntu 24.04,
> but while the kernel built, installed, and functioned properly in most
> respects, it actually made the problem with USB-C displays worse. As
> long as the thunderbolt driver was loaded, no displays were detected
> when plugged in (not for even a short length of time), and when the
> thunderbolt driver was unloaded, displays would only be recognized and
> function if there was only one display attached. Attaching a second
> display resulted in the first external display becoming detached and
> the second display not coming on. Unplugging the second display
> resulted in the first display reattaching. This machine supports up to
> three external displays and this has proven to be achievable and stable
> with earlier kernels. No valuable error messages were logged in dmesg
> when these problems occurred.
> 
> Our testing has been limited to the Clevo X370SNW1 model, however we
> expect that the X370SNV1 model will exhibit the same issues as it uses
> very similar internal components on the system board.
> 
> This is basically the extent of our knowledge at this point. We
> attempted various patches on Ubuntu's 6.8 kernel to resolve the issue,
> all without success:
> 
> * We attempted reverting fd4d58d1fef9ae9b0ee235eaad73d2e0a6a73025
>   (thunderbolt: Enable CL2 low power state), which had no effect.
> * We noticed that one of the Barlow Ridge bridge controllers
>   listed by `lspci -k` appeared to not have its device ID in
>   drivers/thunderbolt/nhi.h and there was a corresponding quirk in
>   drivers/thunderbolt/quirks.c that looked like it might be vaguely
>   related to the issue (specifically quirk_usb3_maximum_bandwidth), so
>   we tried adding that device to the appropriate files in order to make
>   that quirk apply to that device as well, this had no visible effect
>   on the kernel's operation and did not resolve the issue.
> * After narrowing it down to `quirk_block_rpm_in_redrive`, we attempted
>   adding a new `thunderbolt.kf_force_redrive` kernel parameter in
>   drivers/thunderbolt/tb.c that forced the code in
>   `tb_enter_redrive` and `tb_exit_redrive` to be executed even *if* the
>   device didn't have the appropriate quirk bit set, in the hopes that
>   this would make the quirk execute and resolve the issue. What ended
>   up happening was somehow `tb_enter_redrive` was never called at all
>   and `tb_exit_redrive` was called. This in turn made it so that no
>   USB-C displays would even be recognized for a short period of time if
>   the thunderbolt driver was loaded.
> * Looking at PCI vendor IDs, we noticed that the PCI vendor ID used to
>   recognize all Intel controllers in drivers/thunderbolt/quirks.c was
>   0x8087, whereas the Barlow Ridge controller in our device reported a
>   vendor ID of 0x8086. On the off chance that this was a typo of epic
>   proportions, we tried adjusting all of the occurrences of 0x8087 in
>   the tb_quirks[] array to PCI_VENDOR_ID_INTEL (which is defined as
>   0x8086 in include/linux/pci_ids.h). This has no visible effect on the
>   kernel's behavior, and did not resolve the issue. (Presumably there's
>   something going on with the IDs there that we're not aware of.)
> 
> As to my speculation as to what's wrong, I believe this is likely a
> combination of two things:
> 
> * Some data in the `tb_quirks` array in drivers/thunderbolt/quirks.c is
>   incorrect and leading to the Barlow Ridge controllers not being
>   recognized as needing the DisplayPort redrive mode quirk.
> * The code in drivers/thunderbolt/tb.c `tb_dp_resource_unavailable`
>   that controls whether or not to run `tb_enter_redrive` is faulty in
>   some way and is not calling `tb_enter_redrive` in all scenarios where
>   it is necessary. To be clear, the exact code I'm talking about is
>   this chunk from the aforementioned function:
> 
>         tunnel = tb_find_tunnel(tb, TB_TUNNEL_DP, in, out);
>         if (tunnel)
>                 tb_deactivate_and_free_tunnel(tunnel);
>         else 
>                 tb_enter_redrive(port);
> 
> Finally, this is probably a result of me misreading the driver code
> somehow, but I was surprised by the following conditional at the top
> of `tb_enter_redrive`:
> 
>         if (!(sw->quirks & QUIRK_KEEP_POWER_IN_DP_REDRIVE))
>                 return;
> 
> To me this reads as "if the DP redrive quirk bit is set, return and do
> nothing. Otherwise, if the bit is not set, run the quirk function."

There is the "return;" which reads that if the quirk is not set, return
from this function early.

> This is the opposite of what I would expect - shouldn't the code run if
> the bit is set, not if it is clear? Or does the bit being unset mean
> that the quirk is active? (I do not believe that this is the root cause
> of the issue because even when I forced this function to run any time
> it was invoked, it wasn't being invoked at all.)

Okay, thanks for the very detailed report.

We need bit more information to investigate this. The commit you
referred is exactly for this purpose and I'm surprised it did not work
but also the Barlow Ridge PCI IDs are suprised too, as if this would
have some old firmware or something.

Can you share full dmesg with the repro and "thunderbolt.dyndbg=+p" in
the kernel command line?

