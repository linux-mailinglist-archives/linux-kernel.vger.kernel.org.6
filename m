Return-Path: <linux-kernel+bounces-391813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E43F9B8BFC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 08:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5288B2149B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 07:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A0C1537C3;
	Fri,  1 Nov 2024 07:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AN3QLthj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4AF86252;
	Fri,  1 Nov 2024 07:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730445727; cv=none; b=sDvvF0vqpsYMD9qX3LsAOlZ/CTuA8eEAfzqu/wKWQToUdEXyl8paA5MbKPAdRtKlAyURrRkFWbjgWvOAICLsi4dwgowWVqN3IvkoKz5Nm6CgqQqZ73hwf4tZhLxVfL38brvO1H0aEUFTu07AzAU/Tn8SwoJfRomIK5/BQHJODrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730445727; c=relaxed/simple;
	bh=80mLy5/GPeVpsv/5/0vLFBWuUCXFd6SrJOEk1FfnxrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XRCergMf8moz/SKqFFfRCr3uCeaxlq2ubmD14grGzJKnRpTZj8h5Xey/odVOhp+xMpY0rIBLQg7uz5L0eIxMkZh9kkQXbk4IZXPlxuecybK5F7iKQZHatjEBe3FvxkmmgFB1WyqUhAV6lHIN+UDipZmdCt4p1SSgpklfUWWpLeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AN3QLthj; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730445725; x=1761981725;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=80mLy5/GPeVpsv/5/0vLFBWuUCXFd6SrJOEk1FfnxrU=;
  b=AN3QLthjQw4KGHlxLznx4Vt23h1B3EJCCfu3pMlwszMmCD5D8gapk/Ee
   Kfj6Lm/68IeQH7WALAqArvBdVQgzYlfd9SoEnuZhsl4ZB00u6JZx9yufb
   NEn58dqvhbwcIUdjaJHga+OeFzWJYv+RH3iU2cMmQab4bOby9ph5n+Pul
   B/3lcKi3FHSERYDkEw+rSBaI2OoAzopuFhd4kmT1lrnG7xyvb6Y/XFlFx
   jsc4fWD7od0WdY/OfeAvaWnuZc6PDZmI5dEcRb5PF6MkwTw+4zh0GcnxY
   9CCYvV6tmW15IlKcWDJVVqPCQHqVRGq3HcKJogsiDJYuinjtrRuC4qGuk
   Q==;
X-CSE-ConnectionGUID: JoTC6UFxRcuDKhxLRyv3xg==
X-CSE-MsgGUID: znNK6P6FQT2EhZfE95NdNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11242"; a="34010521"
X-IronPort-AV: E=Sophos;i="6.11,249,1725346800"; 
   d="scan'208";a="34010521"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 00:21:59 -0700
X-CSE-ConnectionGUID: qaMgTW1jTPm6auqF7n2A5Q==
X-CSE-MsgGUID: /5uBrf5FS8SMK+j5egd9fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,249,1725346800"; 
   d="scan'208";a="87486055"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa004.fm.intel.com with ESMTP; 01 Nov 2024 00:21:56 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 4B9D31AC; Fri, 01 Nov 2024 09:21:55 +0200 (EET)
Date: Fri, 1 Nov 2024 09:21:55 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Aaron Rainbolt <arainbolt@kfocus.org>
Cc: YehezkelShB@gmail.com, michael.jamet@intel.com,
	andreas.noever@gmail.com, linux-usb@vger.kernel.org,
	mmikowski@kfocus.org, linux-kernel@vger.kernel.org,
	Gil Fine <gil.fine@linux.intel.com>
Subject: Re: USB-C DisplayPort display failing to stay active with Intel
 Barlow Ridge USB4 controller, power-management related issue?
Message-ID: <20241101072155.GW275077@black.fi.intel.com>
References: <20241009220118.70bfedd0@kf-ir16>
 <20241010044919.GD275077@black.fi.intel.com>
 <20241010232656.7fc6359e@kf-ir16>
 <20241011163811.GU275077@black.fi.intel.com>
 <20241011183751.7d27c59c@kf-ir16>
 <20241023062737.GG275077@black.fi.intel.com>
 <20241023073931.GH275077@black.fi.intel.com>
 <20241023174413.451710ea@kf-ir16>
 <20241024154341.GK275077@black.fi.intel.com>
 <20241031095542.587e8aa6@kf-ir16>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241031095542.587e8aa6@kf-ir16>

Hi Aaron,

On Thu, Oct 31, 2024 at 09:55:42AM -0500, Aaron Rainbolt wrote:
> Sorry for the delays, been working on testing the patch and had other
> things taking priority.
> 
> I keep having to manually apply the patches you're sending "by hand" to
> the latest mainline kernel because it doesn't apply cleanly. In
> particular, I notice that in the very last "segment" of the patch (the
> one that applies to tb_runtime_resume), the "list_for_each_entry_safe"
> line shows that it's running "tb_tunnel_activate" in your tree, whereas
> the upstream 6.12~rc5 code is running "tb_tunnel_restart" there. Would
> it be too much of a hassle to ask for a patch that applies cleanly to
> the 6.11.5 kernel? That would be very handy since that's the easiest
> supported upstream kernel for us to test against, and would make sure
> that we're not seeing any weird bugs as a result of kernel sources
> mismatch.

Sorry about that. I did not realize that it might not apply. It indeed
was on top of my local changes. The patch below applies cleanly to v6.11
but let me know if it does not.

> [    1.429876] thunderbolt 0000:06:00.0: device links to tunneled native ports are missing!

I keep worrying about this one, althought not related to your issue. I
wonder if you reported this to the manufacturer? If this is missing
PCIe/USB tunneling will not work as expected over sleep cycles.

Anyways, I realized now another oddity:

> [    1.436154] thunderbolt 0000:06:00.0: acking hot plug event on 0:13
> [    1.436280] thunderbolt 0000:06:00.0: acking hot plug event on 0:14
> [    1.436410] thunderbolt 0000:06:00.0: acking hot plug event on 0:16
...
> [    1.449347] thunderbolt 0000:06:00.0: 0:16: disabled by eeprom

The DROM claims the adapter to be disabled. This is most likely not
the intention. Can you try the below patch? It includes the redrive
changes and also quirk for this thing.

It is enough to do these steps so no need to do the full cycle:

  1. Boot the system up, nothing connected.
  2. Wait for Barlow Ridge to enter runtime suspend. This takes ~15
     seconds so waiting for > 15 seconds should be enough.
  3. Plug in USB-C monitor to the USB-C port of the Barlow Ridge.

This is essentially the same as you do in the first steps and this is
where it fails (and you "fixed" it by running lspci -k). I'm hoping that
the quirk would make the DP IN adapter 16 to enter redrive mode too and
keep the domain powered. Alternative is that you only have two
connections from the dGPU to the Barlow Ridge in which case disabling
the adapter might actually be correct. However, in that case we should
not be getting plug events to the adapters that are not available for
tunneling.

diff --git a/drivers/thunderbolt/eeprom.c b/drivers/thunderbolt/eeprom.c
index eb241b270f79..22a41e524b21 100644
--- a/drivers/thunderbolt/eeprom.c
+++ b/drivers/thunderbolt/eeprom.c
@@ -703,10 +703,18 @@ static int tb_drom_device_read(struct tb_switch *sw)
  */
 int tb_drom_read(struct tb_switch *sw)
 {
+	int ret;
+
 	if (sw->drom)
 		return 0;
 
-	if (!tb_route(sw))
-		return tb_drom_host_read(sw);
-	return tb_drom_device_read(sw);
+	if (tb_route(sw))
+		ret = tb_drom_device_read(sw);
+	else
+		ret = tb_drom_host_read(sw);
+	if (ret)
+		return ret;
+
+	tb_check_drom_quirks(sw);
+	return 0;
 }
diff --git a/drivers/thunderbolt/quirks.c b/drivers/thunderbolt/quirks.c
index e81de9c30eac..5f7eec97cfb9 100644
--- a/drivers/thunderbolt/quirks.c
+++ b/drivers/thunderbolt/quirks.c
@@ -49,66 +49,105 @@ static void quirk_block_rpm_in_redrive(struct tb_switch *sw)
 	tb_sw_dbg(sw, "preventing runtime PM in DP redrive mode\n");
 }
 
+static void quirk_enable_drom_dp_in(struct tb_switch *sw)
+{
+	if (sw->ports[16].disabled) {
+		tb_port_dbg(&sw->ports[16], "re-enabling adapter\n");
+		sw->ports[16].disabled = false;
+	}
+}
+
 struct tb_quirk {
 	u16 hw_vendor_id;
 	u16 hw_device_id;
 	u16 vendor;
 	u16 device;
+	void (*drom_hook)(struct tb_switch *sw);
 	void (*hook)(struct tb_switch *sw);
 };
 
 static const struct tb_quirk tb_quirks[] = {
 	/* Dell WD19TB supports self-authentication on unplug */
-	{ 0x0000, 0x0000, 0x00d4, 0xb070, quirk_force_power_link },
-	{ 0x0000, 0x0000, 0x00d4, 0xb071, quirk_force_power_link },
+	{ 0x0000, 0x0000, 0x00d4, 0xb070, quirk_force_power_link, NULL },
+	{ 0x0000, 0x0000, 0x00d4, 0xb071, quirk_force_power_link, NULL },
 	/*
 	 * Intel Goshen Ridge NVM 27 and before report wrong number of
 	 * DP buffers.
 	 */
-	{ 0x8087, 0x0b26, 0x0000, 0x0000, quirk_dp_credit_allocation },
+	{ 0x8087, 0x0b26, 0x0000, 0x0000, quirk_dp_credit_allocation, NULL },
 	/*
 	 * Limit the maximum USB3 bandwidth for the following Intel USB4
 	 * host routers due to a hardware issue.
 	 */
 	{ 0x8087, PCI_DEVICE_ID_INTEL_ADL_NHI0, 0x0000, 0x0000,
-		  quirk_usb3_maximum_bandwidth },
+		  quirk_usb3_maximum_bandwidth, NULL },
 	{ 0x8087, PCI_DEVICE_ID_INTEL_ADL_NHI1, 0x0000, 0x0000,
-		  quirk_usb3_maximum_bandwidth },
+		  quirk_usb3_maximum_bandwidth, NULL },
 	{ 0x8087, PCI_DEVICE_ID_INTEL_RPL_NHI0, 0x0000, 0x0000,
-		  quirk_usb3_maximum_bandwidth },
+		  quirk_usb3_maximum_bandwidth, NULL },
 	{ 0x8087, PCI_DEVICE_ID_INTEL_RPL_NHI1, 0x0000, 0x0000,
-		  quirk_usb3_maximum_bandwidth },
+		  quirk_usb3_maximum_bandwidth, NULL },
 	{ 0x8087, PCI_DEVICE_ID_INTEL_MTL_M_NHI0, 0x0000, 0x0000,
-		  quirk_usb3_maximum_bandwidth },
+		  quirk_usb3_maximum_bandwidth, NULL },
 	{ 0x8087, PCI_DEVICE_ID_INTEL_MTL_P_NHI0, 0x0000, 0x0000,
-		  quirk_usb3_maximum_bandwidth },
+		  quirk_usb3_maximum_bandwidth, NULL },
 	{ 0x8087, PCI_DEVICE_ID_INTEL_MTL_P_NHI1, 0x0000, 0x0000,
-		  quirk_usb3_maximum_bandwidth },
+		  quirk_usb3_maximum_bandwidth, NULL },
 	{ 0x8087, PCI_DEVICE_ID_INTEL_BARLOW_RIDGE_HOST_80G_NHI, 0x0000, 0x0000,
-		  quirk_usb3_maximum_bandwidth },
+		  quirk_usb3_maximum_bandwidth, NULL },
 	{ 0x8087, PCI_DEVICE_ID_INTEL_BARLOW_RIDGE_HOST_40G_NHI, 0x0000, 0x0000,
-		  quirk_usb3_maximum_bandwidth },
+		  quirk_usb3_maximum_bandwidth, NULL },
 	{ 0x8087, PCI_DEVICE_ID_INTEL_BARLOW_RIDGE_HUB_80G_BRIDGE, 0x0000, 0x0000,
-		  quirk_usb3_maximum_bandwidth },
+		  quirk_usb3_maximum_bandwidth, NULL },
 	{ 0x8087, PCI_DEVICE_ID_INTEL_BARLOW_RIDGE_HUB_40G_BRIDGE, 0x0000, 0x0000,
-		  quirk_usb3_maximum_bandwidth },
+		  quirk_usb3_maximum_bandwidth, NULL },
 	/*
 	 * Block Runtime PM in DP redrive mode for Intel Barlow Ridge host
 	 * controllers.
+	 *
+	 * Re-enable DP IN adapter 16 which is marked as disabled in
+	 * some Clevo systems.
 	 */
 	{ 0x8087, PCI_DEVICE_ID_INTEL_BARLOW_RIDGE_HOST_80G_NHI, 0x0000, 0x0000,
-		  quirk_block_rpm_in_redrive },
+		  quirk_block_rpm_in_redrive, quirk_enable_drom_dp_in },
 	{ 0x8087, PCI_DEVICE_ID_INTEL_BARLOW_RIDGE_HOST_40G_NHI, 0x0000, 0x0000,
-		  quirk_block_rpm_in_redrive },
+		  quirk_block_rpm_in_redrive, NULL },
 	/*
 	 * CLx is not supported on AMD USB4 Yellow Carp and Pink Sardine platforms.
 	 */
-	{ 0x0438, 0x0208, 0x0000, 0x0000, quirk_clx_disable },
-	{ 0x0438, 0x0209, 0x0000, 0x0000, quirk_clx_disable },
-	{ 0x0438, 0x020a, 0x0000, 0x0000, quirk_clx_disable },
-	{ 0x0438, 0x020b, 0x0000, 0x0000, quirk_clx_disable },
+	{ 0x0438, 0x0208, 0x0000, 0x0000, quirk_clx_disable, NULL },
+	{ 0x0438, 0x0209, 0x0000, 0x0000, quirk_clx_disable, NULL },
+	{ 0x0438, 0x020a, 0x0000, 0x0000, quirk_clx_disable, NULL },
+	{ 0x0438, 0x020b, 0x0000, 0x0000, quirk_clx_disable, NULL },
 };
 
+static bool match(const struct tb_switch *sw, const struct tb_quirk *q)
+{
+	if (q->hw_vendor_id && q->hw_vendor_id != sw->config.vendor_id)
+		return false;
+	if (q->hw_device_id && q->hw_device_id != sw->config.device_id)
+		return false;
+	if (q->vendor && q->vendor != sw->vendor)
+		return false;
+	if (q->device && q->device != sw->device)
+		return false;
+	return true;
+}
+
+void tb_check_drom_quirks(struct tb_switch *sw)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(tb_quirks); i++) {
+		const struct tb_quirk *q = &tb_quirks[i];
+
+		if (match(sw, q) && q->drom_hook) {
+			tb_sw_dbg(sw, "running %ps\n", q->drom_hook);
+			q->drom_hook(sw);
+		}
+	}
+}
+
 /**
  * tb_check_quirks() - Check for quirks to apply
  * @sw: Thunderbolt switch
@@ -122,16 +161,9 @@ void tb_check_quirks(struct tb_switch *sw)
 	for (i = 0; i < ARRAY_SIZE(tb_quirks); i++) {
 		const struct tb_quirk *q = &tb_quirks[i];
 
-		if (q->hw_vendor_id && q->hw_vendor_id != sw->config.vendor_id)
-			continue;
-		if (q->hw_device_id && q->hw_device_id != sw->config.device_id)
-			continue;
-		if (q->vendor && q->vendor != sw->vendor)
-			continue;
-		if (q->device && q->device != sw->device)
-			continue;
-
-		tb_sw_dbg(sw, "running %ps\n", q->hook);
-		q->hook(sw);
+		if (match(sw, q) && q->hook) {
+			tb_sw_dbg(sw, "running %ps\n", q->hook);
+			q->hook(sw);
+		}
 	}
 }
diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index 10e719dd837c..633aaf9e0574 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -2023,6 +2023,37 @@ static void tb_exit_redrive(struct tb_port *port)
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
 static void tb_dp_resource_unavailable(struct tb *tb, struct tb_port *port)
 {
 	struct tb_port *in, *out;
@@ -2066,8 +2097,17 @@ static void tb_dp_resource_available(struct tb *tb, struct tb_port *port)
 			return;
 	}
 
-	tb_port_dbg(port, "DP %s resource available after hotplug\n",
-		    tb_port_is_dpin(port) ? "IN" : "OUT");
+	if (tb_port_is_dpin(port)) {
+		/* Verify that the resource is really available */
+		if (!tb_switch_query_dp_resource(port->sw, port)) {
+			tb_port_info(port, "got hotplug but DP IN resource not available\n");
+			return;
+		}
+		tb_port_dbg(port, "DP IN resource available after hotplug\n");
+	} else {
+		tb_port_dbg(port, "DP OUT resource available after hotplug\n");
+	}
+
 	list_add_tail(&port->list, &tcm->dp_resources);
 	tb_exit_redrive(port);
 
@@ -2873,6 +2913,7 @@ static int tb_start(struct tb *tb, bool reset)
 	tb_create_usb3_tunnels(tb->root_switch);
 	/* Add DP IN resources for the root switch */
 	tb_add_dp_resources(tb->root_switch);
+	tb_switch_enter_redrive(tb->root_switch);
 	/* Make the discovered switches available to the userspace */
 	device_for_each_child(&tb->root_switch->dev, NULL,
 			      tb_scan_finalize_switch);
@@ -2888,6 +2929,7 @@ static int tb_suspend_noirq(struct tb *tb)
 
 	tb_dbg(tb, "suspending...\n");
 	tb_disconnect_and_release_dp(tb);
+	tb_switch_exit_redrive(tb->root_switch);
 	tb_switch_suspend(tb->root_switch, false);
 	tcm->hotplug_active = false; /* signal tb_handle_hotplug to quit */
 	tb_dbg(tb, "suspend finished\n");
@@ -2980,6 +3022,7 @@ static int tb_resume_noirq(struct tb *tb)
 		tb_dbg(tb, "tunnels restarted, sleeping for 100ms\n");
 		msleep(100);
 	}
+	tb_switch_enter_redrive(tb->root_switch);
 	 /* Allow tb_handle_hotplug to progress events */
 	tcm->hotplug_active = true;
 	tb_dbg(tb, "resume finished\n");
@@ -3043,6 +3086,8 @@ static int tb_runtime_suspend(struct tb *tb)
 	struct tb_cm *tcm = tb_priv(tb);
 
 	mutex_lock(&tb->lock);
+	tb_disconnect_and_release_dp(tb);
+	tb_switch_exit_redrive(tb->root_switch);
 	tb_switch_suspend(tb->root_switch, true);
 	tcm->hotplug_active = false;
 	mutex_unlock(&tb->lock);
@@ -3074,6 +3119,7 @@ static int tb_runtime_resume(struct tb *tb)
 	tb_restore_children(tb->root_switch);
 	list_for_each_entry_safe(tunnel, n, &tcm->tunnel_list, list)
 		tb_tunnel_restart(tunnel);
+	tb_switch_enter_redrive(tb->root_switch);
 	tcm->hotplug_active = true;
 	mutex_unlock(&tb->lock);
 
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index b47f7873c847..a5d32cfe1db1 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -1427,6 +1427,7 @@ static inline bool usb4_port_device_is_offline(const struct usb4_port *usb4)
 	return usb4->offline;
 }
 
+void tb_check_drom_quirks(struct tb_switch *sw);
 void tb_check_quirks(struct tb_switch *sw);
 
 #ifdef CONFIG_ACPI

