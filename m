Return-Path: <linux-kernel+bounces-361504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4D099A907
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 18:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE5AE1C214EE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 16:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE2D19B3EE;
	Fri, 11 Oct 2024 16:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QnHzVntw"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F36199932;
	Fri, 11 Oct 2024 16:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728664698; cv=none; b=KV6HH+t3jqhUVYH3jF5ZNQOb1g30BdFIGFk+L7sjDT0Irx+QnGqJloeHy02wa295jRDHlf8zcNjW0S07mTtcGYu/xUvVgeVAKVSohmKnh1EZKaBnAWTjFmO14eCaNr2mcRN7S2ClxjjIKK2boHh9Pp7ilUo5ls8LTt5M1sOPj70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728664698; c=relaxed/simple;
	bh=W9FTFxeHKW+H3zO9bJftr6UAwVhKYCVBgdeNnVC55Aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZsNwU3rwSAl4SoD+sT0eA7YsTu84vk4BgnTX5aBbbni2aqVYUBGfBMqGFYRbO48PtWbD3ILOe0/sL9iJnY5k/FXMXEEzzr6AAWs9SIyv5S5dTYY9tQh1xItTMzPgCIc7/SYuMFqjEKNyATQ19VEnL/jdqN0t07SU5PyHEx7igvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QnHzVntw; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728664696; x=1760200696;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=W9FTFxeHKW+H3zO9bJftr6UAwVhKYCVBgdeNnVC55Aw=;
  b=QnHzVntwocP5omFrMpSTg/d/ENOrD9KleAi67A92vWFMmAxBeyrkswKp
   DQY72uKGCrlHzzFUpaJBW0VJan14u7F++0t62F0LmvulC8/S8N+EbfRIP
   2iiNfiw9WTEGHwpZcc2T84eOvIZdxH3T7gWotCguIT9v/syLKUyZWYz/H
   qoYW4z6VTUUYoDIGOGFaxfYTVE2jh7eGVXvNKW5FV0yL74jpI9btYauAF
   fy76rJ7yHoL9ji31bKxlYcLGUBzFwQ9Oes2Z5yDxw2CJBfSoB3z0J0jfF
   IxkobIfKxDfT4KSsJW6moWeCbFK1xr6wO42tENinwasSLtPor9xTu4jYv
   Q==;
X-CSE-ConnectionGUID: agZ6dnKyRoq8/X/+wywpJQ==
X-CSE-MsgGUID: 0kyCEa2ASH+vp9tmPMMxrA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="15697845"
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="15697845"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 09:38:15 -0700
X-CSE-ConnectionGUID: dbe8p01jQPW8OG00bSVVXw==
X-CSE-MsgGUID: MGnya2K1QnGO4qFC2EvJyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="76855011"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa009.jf.intel.com with ESMTP; 11 Oct 2024 09:38:14 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id BAD45807; Fri, 11 Oct 2024 19:38:11 +0300 (EEST)
Date: Fri, 11 Oct 2024 19:38:11 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Aaron Rainbolt <arainbolt@kfocus.org>
Cc: YehezkelShB@gmail.com, michael.jamet@intel.com,
	andreas.noever@gmail.com, linux-usb@vger.kernel.org,
	mmikowski@kfocus.org, linux-kernel@vger.kernel.org,
	Gil Fine <gil.fine@linux.intel.com>
Subject: Re: USB-C DisplayPort display failing to stay active with Intel
 Barlow Ridge USB4 controller, power-management related issue?
Message-ID: <20241011163811.GU275077@black.fi.intel.com>
References: <20241009220118.70bfedd0@kf-ir16>
 <20241010044919.GD275077@black.fi.intel.com>
 <20241010232656.7fc6359e@kf-ir16>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241010232656.7fc6359e@kf-ir16>

Hi,

On Thu, Oct 10, 2024 at 11:26:56PM -0500, Aaron Rainbolt wrote:
> > Can you share full dmesg with the repro and "thunderbolt.dyndbg=+p" in
> > the kernel command line?
> 
> The full log is very long, so I've included it as an email attachment.
> The exact steps taken after booting with the requested kernel parameter
> were:
> 
> 1. boot with thunderbolt.dyndbg=+p kernel param, no USB-C plugged in.
> 2. After login, hot-plug two USB-C cables. This time, the displays came
>   up and stayed resident (this happens sometimes)
> 3. Unplugged both cables.
> 4. Replugged both. This time, the displays did not show anything.
> 5. lspci -k "jiggled" the displays and they came back on.
> 6. After ~15s, the displays blacked out again.
> 7. Save to the demsg file after about 30s.
> 
> The laptop's firmware is fully up-to-date. One of the fixes we tried
> was installing Windows 11, updating the firmware, and then
> re-installing Kubuntu 24.04. This had no effect on the issue.
> 
> Notes:
> 
> * Kernel 6.1 does not exhibit this time out. 6.5 and later do.
> * Windows 11 had very similar behavior before installing Windows
>   updates. After update, it was fixed.
> * All distros and W11 were tested on the same hardware with the latest
>   firmware, so we know this is not a hardware failure.

Thanks for the logs and steps!

I now realize that

  a75e0684efe5 ("thunderbolt: Keep the domain powered when USB4 port is in redrive mode")

was half-baked. Yes it deals with the situation where plugging in
monitor when the domain is powered. However, it completely misses these
cases:

* Plug in monitor to the Type-C port when the controller is runtime
   suspended.
* Boot with monitor plugged in to the Type-C port.

At the end of this email there is a hack patch that tries to solve this.
Can you try it out? I will be on vacation next week but I'm copying my
colleague Gil who is familiar with this too. He should be able to help
you out during my absense.

Couple of notes about the dmesg you shared. They don't affect this issue
but may cause other issues:

> [    1.382718] thunderbolt 0000:06:00.0: device links to tunneled native ports are missing!

This is means the BIOS does not implement the USB4 power contract which
means that USB 3.x and PCIe tunnels will not work as expected after
power transition.

> [    1.416488] thunderbolt 0000:06:00.0: 0: NVM version 14.86

This is really old firmware version. My development system for example
has 56.x so yours might have a bunch of issues that are solved in the
later versions.

The hack patch below:

diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index 07a66594e904..0e424b7661be 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -2113,6 +2113,37 @@ static void tb_exit_redrive(struct tb_port *port)
 	}
 }
 
+static void tb_switch_enter_redrive(struct tb_switch *sw)
+{
+	struct tb_port *port;
+
+	tb_switch_for_each_port(sw, port)
+		tb_enter_redrive(port);
+}
+
+/*
+ * Called during system and runtime suspend to forcefully exit redrive
+ * mode without querying whether the resource is available.
+ */
+static void tb_switch_exit_redrive(struct tb_switch *sw)
+{
+	struct tb_port *port;
+
+	if (!(sw->quirks & QUIRK_KEEP_POWER_IN_DP_REDRIVE))
+		return;
+
+	tb_switch_for_each_port(sw, port) {
+		if (!tb_port_is_dpin(port))
+			continue;
+
+		if (port->redrive) {
+			port->redrive = false;
+			pm_runtime_put(&sw->dev);
+			tb_port_dbg(port, "exit redrive mode\n");
+		}
+	}
+}
+
 static void tb_dp_resource_unavailable(struct tb *tb, struct tb_port *port,
 				       const char *reason)
 {
@@ -2987,6 +3018,7 @@ static int tb_start(struct tb *tb, bool reset)
 	tb_create_usb3_tunnels(tb->root_switch);
 	/* Add DP IN resources for the root switch */
 	tb_add_dp_resources(tb->root_switch);
+	tb_switch_enter_redrive(tb->root_switch);
 	/* Make the discovered switches available to the userspace */
 	device_for_each_child(&tb->root_switch->dev, NULL,
 			      tb_scan_finalize_switch);
@@ -3002,6 +3034,7 @@ static int tb_suspend_noirq(struct tb *tb)
 
 	tb_dbg(tb, "suspending...\n");
 	tb_disconnect_and_release_dp(tb);
+	tb_switch_exit_redrive(tb->root_switch);
 	tb_switch_suspend(tb->root_switch, false);
 	tcm->hotplug_active = false; /* signal tb_handle_hotplug to quit */
 	tb_dbg(tb, "suspend finished\n");
@@ -3094,6 +3127,7 @@ static int tb_resume_noirq(struct tb *tb)
 		tb_dbg(tb, "tunnels restarted, sleeping for 100ms\n");
 		msleep(100);
 	}
+	tb_switch_enter_redrive(tb->root_switch);
 	 /* Allow tb_handle_hotplug to progress events */
 	tcm->hotplug_active = true;
 	tb_dbg(tb, "resume finished\n");
@@ -3157,6 +3191,8 @@ static int tb_runtime_suspend(struct tb *tb)
 	struct tb_cm *tcm = tb_priv(tb);
 
 	mutex_lock(&tb->lock);
+	tb_disconnect_and_release_dp(tb);
+	tb_switch_exit_redrive(tb->root_switch);
 	tb_switch_suspend(tb->root_switch, true);
 	tcm->hotplug_active = false;
 	mutex_unlock(&tb->lock);
@@ -3188,6 +3224,7 @@ static int tb_runtime_resume(struct tb *tb)
 	tb_restore_children(tb->root_switch);
 	list_for_each_entry_safe(tunnel, n, &tcm->tunnel_list, list)
 		tb_tunnel_activate(tunnel);
+	tb_switch_enter_redrive(tb->root_switch);
 	tcm->hotplug_active = true;
 	mutex_unlock(&tb->lock);
 

