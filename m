Return-Path: <linux-kernel+bounces-393028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E7F9B9B20
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 00:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAB431C21068
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 23:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9771E571D;
	Fri,  1 Nov 2024 23:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b="D1rtFvim"
Received: from mail-il1-f194.google.com (mail-il1-f194.google.com [209.85.166.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD961607B4
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 23:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730502838; cv=none; b=tIu71e7MOGxXg9wEc1L3fwK/vtQ6TzoYatNyV4c8HTxOTBuYv08h4XxQCdXuck6Jp62FV5gi0PpPNp2LrG2vDucAV9GutbEUGYO8KP8k9UcTZ9jM+9id3edUCLLeetgJIPlBWCNGoYKmmX0+e8+mjL6xYFQYkSEB++lR/HWKrfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730502838; c=relaxed/simple;
	bh=l5hPNttrAHczb2XfRBvu0xr4v39ZCUqEa9DdPG7refA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m9e20L5JLOmx5a2TMVqxqfyqguoamYF1iLYagesBLuE2ubUqfCmuuzgkQVdny1azFFiWcgpOsY2JrRUY0HR7S19k6RBGME9wmqfuD/U3eCqbFUYSSk8A/Uhr4D2edu1zcfM2t5h5MAhEyMlaDU16u5nihUVZydr4Guu120SC/yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org; spf=pass smtp.mailfrom=kfocus.org; dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b=D1rtFvim; arc=none smtp.client-ip=209.85.166.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kfocus.org
Received: by mail-il1-f194.google.com with SMTP id e9e14a558f8ab-3a4c303206eso9027145ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 16:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kfocus-org.20230601.gappssmtp.com; s=20230601; t=1730502822; x=1731107622; darn=vger.kernel.org;
        h=mime-version:organization:references:in-reply-to:message-id:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QmpPw24DdY//Wh6/TXFfRRZsZGZbROotxhJNgOI2/0E=;
        b=D1rtFvimO8F71li994ak/9/Rxs+s63R+QcYWU74Pk8s2l8eFk4xh1xJJDD8evwEhlp
         s/XXR+dhdqjGtFutz8vsWv1NYyrNmVBEAdhkTcl4GrLAkzYak8DhKwqh8xFkTKUI+1lH
         i2dgw6pa9OUGCwrR1emn0wvWf2tZRgEr7S6lcx1F/IJV9+P2vOWmCG5CfrExtQQ70Kz0
         yXL3odZeQa20lVM1I2h9iK44SbITWDhx8H+sajVL0ftyNdoT3Soh8E1/k/8n9PgRiDaX
         DsvFzFFN1fcGGkE8CxMDhEgqF9dd237ESQHYTt+ItaVOl46iIeOA5Ie/PCOLeiY9nfrS
         fYRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730502822; x=1731107622;
        h=mime-version:organization:references:in-reply-to:message-id:subject
         :cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QmpPw24DdY//Wh6/TXFfRRZsZGZbROotxhJNgOI2/0E=;
        b=C8yJqYtbQnfAYiuIx8nh5kzQyK9s3LZ6CPWWnHDoNbThPkPzU1EJtTme74SHcTdvzc
         2j8KfpIFHIuUhPfWTGE8cIi4tfKThMOIHSuAZ+/Obqg8zlPLRBY5ukHwgCTx1tRGjdhs
         34G+CzfWfVNV8iE4WfoOiwQWohSXqJyvgBySI3qWrJN/+o1j3J5YrpMAliTxUO/m/rEN
         XPXet6XzjE2W3gVJqH3H0fybRCldMziWqCjpZEt89bHMQV8zBJxObpcviqovAPuaLvu0
         FF/MNaWBMXS9Wgz5Z9jgWd+Yg/2WE33zInDKwZHCDknOxX3ZODi11F2FblolxSNoba2F
         Z86w==
X-Forwarded-Encrypted: i=1; AJvYcCXndPgZYb24W6QoLoZBY867ckDR0kWFvAHCr7L9jyTDJd8zoy+HlLZdV11DOGUphdBWCwzVXuBAWzsQdhE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGp0MMqLAPleU/GkVxFQC8F4nxqHPdeuMwy3ats47JYbOFum3G
	u99qD7/kBP4CL1j2L8NcCBqn0bYtpupi58W9CzPgyDxC2JxOmY4ZYVjK2vdsluU=
X-Google-Smtp-Source: AGHT+IHtOfdCy1jIL6b+nkO8DIv/2mOkOhY70VRUSApZySd+v+VFfdHU8EdSbmQCTLsTe/013F3b6Q==
X-Received: by 2002:a05:6e02:160b:b0:3a4:d94f:5b53 with SMTP id e9e14a558f8ab-3a6b0384ea3mr64520955ab.19.1730502821964;
        Fri, 01 Nov 2024 16:13:41 -0700 (PDT)
Received: from kf-ir16 ([2607:fb91:759:8d6:94c3:6b6e:3d44:6666])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4de04acacb5sm925404173.174.2024.11.01.16.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 16:13:41 -0700 (PDT)
Date: Fri, 1 Nov 2024 18:13:34 -0500
From: Aaron Rainbolt <arainbolt@kfocus.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: YehezkelShB@gmail.com, michael.jamet@intel.com,
 andreas.noever@gmail.com, linux-usb@vger.kernel.org, mmikowski@kfocus.org,
 linux-kernel@vger.kernel.org, Gil Fine <gil.fine@linux.intel.com>
Subject: Re: USB-C DisplayPort display failing to stay active with Intel
 Barlow Ridge USB4 controller, power-management related issue?
Message-ID: <20241101181334.25724aff@kf-ir16>
In-Reply-To: <20241101072155.GW275077@black.fi.intel.com>
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
	<20241101072155.GW275077@black.fi.intel.com>
Organization: Kubuntu Focus
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/WuIuDckOYZDBcFRp6AX3mk1"

--MP_/WuIuDckOYZDBcFRp6AX3mk1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Fri, 1 Nov 2024 09:21:55 +0200
Mika Westerberg <mika.westerberg@linux.intel.com> wrote:

> Hi Aaron,
> 
> On Thu, Oct 31, 2024 at 09:55:42AM -0500, Aaron Rainbolt wrote:
> > Sorry for the delays, been working on testing the patch and had
> > other things taking priority.
> > 
> > I keep having to manually apply the patches you're sending "by
> > hand" to the latest mainline kernel because it doesn't apply
> > cleanly. In particular, I notice that in the very last "segment" of
> > the patch (the one that applies to tb_runtime_resume), the
> > "list_for_each_entry_safe" line shows that it's running
> > "tb_tunnel_activate" in your tree, whereas the upstream 6.12~rc5
> > code is running "tb_tunnel_restart" there. Would it be too much of
> > a hassle to ask for a patch that applies cleanly to the 6.11.5
> > kernel? That would be very handy since that's the easiest supported
> > upstream kernel for us to test against, and would make sure that
> > we're not seeing any weird bugs as a result of kernel sources
> > mismatch.  
> 
> Sorry about that. I did not realize that it might not apply. It indeed
> was on top of my local changes. The patch below applies cleanly to
> v6.11 but let me know if it does not.
> 
> > [    1.429876] thunderbolt 0000:06:00.0: device links to tunneled
> > native ports are missing!  
> 
> I keep worrying about this one, althought not related to your issue. I
> wonder if you reported this to the manufacturer? If this is missing
> PCIe/USB tunneling will not work as expected over sleep cycles.
> 
> Anyways, I realized now another oddity:
> 
> > [    1.436154] thunderbolt 0000:06:00.0: acking hot plug event on
> > 0:13 [    1.436280] thunderbolt 0000:06:00.0: acking hot plug event
> > on 0:14 [    1.436410] thunderbolt 0000:06:00.0: acking hot plug
> > event on 0:16  
> ...
> > [    1.449347] thunderbolt 0000:06:00.0: 0:16: disabled by eeprom  
> 
> The DROM claims the adapter to be disabled. This is most likely not
> the intention. Can you try the below patch? It includes the redrive
> changes and also quirk for this thing.
> 
> It is enough to do these steps so no need to do the full cycle:
> 
>   1. Boot the system up, nothing connected.
>   2. Wait for Barlow Ridge to enter runtime suspend. This takes ~15
>      seconds so waiting for > 15 seconds should be enough.
>   3. Plug in USB-C monitor to the USB-C port of the Barlow Ridge.
> 
> This is essentially the same as you do in the first steps and this is
> where it fails (and you "fixed" it by running lspci -k). I'm hoping
> that the quirk would make the DP IN adapter 16 to enter redrive mode
> too and keep the domain powered. Alternative is that you only have two
> connections from the dGPU to the Barlow Ridge in which case disabling
> the adapter might actually be correct. However, in that case we should
> not be getting plug events to the adapters that are not available for
> tunneling.
> 
> diff --git a/drivers/thunderbolt/eeprom.c
> b/drivers/thunderbolt/eeprom.c index eb241b270f79..22a41e524b21 100644
> --- a/drivers/thunderbolt/eeprom.c
> +++ b/drivers/thunderbolt/eeprom.c
> @@ -703,10 +703,18 @@ static int tb_drom_device_read(struct tb_switch
> *sw) */
>  int tb_drom_read(struct tb_switch *sw)
>  {
> +	int ret;
> +
>  	if (sw->drom)
>  		return 0;
>  
> -	if (!tb_route(sw))
> -		return tb_drom_host_read(sw);
> -	return tb_drom_device_read(sw);
> +	if (tb_route(sw))
> +		ret = tb_drom_device_read(sw);
> +	else
> +		ret = tb_drom_host_read(sw);
> +	if (ret)
> +		return ret;
> +
> +	tb_check_drom_quirks(sw);
> +	return 0;
>  }
> diff --git a/drivers/thunderbolt/quirks.c
> b/drivers/thunderbolt/quirks.c index e81de9c30eac..5f7eec97cfb9 100644
> --- a/drivers/thunderbolt/quirks.c
> +++ b/drivers/thunderbolt/quirks.c
> @@ -49,66 +49,105 @@ static void quirk_block_rpm_in_redrive(struct
> tb_switch *sw) tb_sw_dbg(sw, "preventing runtime PM in DP redrive
> mode\n"); }
>  
> +static void quirk_enable_drom_dp_in(struct tb_switch *sw)
> +{
> +	if (sw->ports[16].disabled) {
> +		tb_port_dbg(&sw->ports[16], "re-enabling adapter\n");
> +		sw->ports[16].disabled = false;
> +	}
> +}
> +
>  struct tb_quirk {
>  	u16 hw_vendor_id;
>  	u16 hw_device_id;
>  	u16 vendor;
>  	u16 device;
> +	void (*drom_hook)(struct tb_switch *sw);
>  	void (*hook)(struct tb_switch *sw);
>  };
>  
>  static const struct tb_quirk tb_quirks[] = {
>  	/* Dell WD19TB supports self-authentication on unplug */
> -	{ 0x0000, 0x0000, 0x00d4, 0xb070, quirk_force_power_link },
> -	{ 0x0000, 0x0000, 0x00d4, 0xb071, quirk_force_power_link },
> +	{ 0x0000, 0x0000, 0x00d4, 0xb070, quirk_force_power_link,
> NULL },
> +	{ 0x0000, 0x0000, 0x00d4, 0xb071, quirk_force_power_link,
> NULL }, /*
>  	 * Intel Goshen Ridge NVM 27 and before report wrong number
> of
>  	 * DP buffers.
>  	 */
> -	{ 0x8087, 0x0b26, 0x0000, 0x0000, quirk_dp_credit_allocation
> },
> +	{ 0x8087, 0x0b26, 0x0000, 0x0000,
> quirk_dp_credit_allocation, NULL }, /*
>  	 * Limit the maximum USB3 bandwidth for the following Intel
> USB4
>  	 * host routers due to a hardware issue.
>  	 */
>  	{ 0x8087, PCI_DEVICE_ID_INTEL_ADL_NHI0, 0x0000, 0x0000,
> -		  quirk_usb3_maximum_bandwidth },
> +		  quirk_usb3_maximum_bandwidth, NULL },
>  	{ 0x8087, PCI_DEVICE_ID_INTEL_ADL_NHI1, 0x0000, 0x0000,
> -		  quirk_usb3_maximum_bandwidth },
> +		  quirk_usb3_maximum_bandwidth, NULL },
>  	{ 0x8087, PCI_DEVICE_ID_INTEL_RPL_NHI0, 0x0000, 0x0000,
> -		  quirk_usb3_maximum_bandwidth },
> +		  quirk_usb3_maximum_bandwidth, NULL },
>  	{ 0x8087, PCI_DEVICE_ID_INTEL_RPL_NHI1, 0x0000, 0x0000,
> -		  quirk_usb3_maximum_bandwidth },
> +		  quirk_usb3_maximum_bandwidth, NULL },
>  	{ 0x8087, PCI_DEVICE_ID_INTEL_MTL_M_NHI0, 0x0000, 0x0000,
> -		  quirk_usb3_maximum_bandwidth },
> +		  quirk_usb3_maximum_bandwidth, NULL },
>  	{ 0x8087, PCI_DEVICE_ID_INTEL_MTL_P_NHI0, 0x0000, 0x0000,
> -		  quirk_usb3_maximum_bandwidth },
> +		  quirk_usb3_maximum_bandwidth, NULL },
>  	{ 0x8087, PCI_DEVICE_ID_INTEL_MTL_P_NHI1, 0x0000, 0x0000,
> -		  quirk_usb3_maximum_bandwidth },
> +		  quirk_usb3_maximum_bandwidth, NULL },
>  	{ 0x8087, PCI_DEVICE_ID_INTEL_BARLOW_RIDGE_HOST_80G_NHI,
> 0x0000, 0x0000,
> -		  quirk_usb3_maximum_bandwidth },
> +		  quirk_usb3_maximum_bandwidth, NULL },
>  	{ 0x8087, PCI_DEVICE_ID_INTEL_BARLOW_RIDGE_HOST_40G_NHI,
> 0x0000, 0x0000,
> -		  quirk_usb3_maximum_bandwidth },
> +		  quirk_usb3_maximum_bandwidth, NULL },
>  	{ 0x8087, PCI_DEVICE_ID_INTEL_BARLOW_RIDGE_HUB_80G_BRIDGE,
> 0x0000, 0x0000,
> -		  quirk_usb3_maximum_bandwidth },
> +		  quirk_usb3_maximum_bandwidth, NULL },
>  	{ 0x8087, PCI_DEVICE_ID_INTEL_BARLOW_RIDGE_HUB_40G_BRIDGE,
> 0x0000, 0x0000,
> -		  quirk_usb3_maximum_bandwidth },
> +		  quirk_usb3_maximum_bandwidth, NULL },
>  	/*
>  	 * Block Runtime PM in DP redrive mode for Intel Barlow
> Ridge host
>  	 * controllers.
> +	 *
> +	 * Re-enable DP IN adapter 16 which is marked as disabled in
> +	 * some Clevo systems.
>  	 */
>  	{ 0x8087, PCI_DEVICE_ID_INTEL_BARLOW_RIDGE_HOST_80G_NHI,
> 0x0000, 0x0000,
> -		  quirk_block_rpm_in_redrive },
> +		  quirk_block_rpm_in_redrive,
> quirk_enable_drom_dp_in }, { 0x8087,
> PCI_DEVICE_ID_INTEL_BARLOW_RIDGE_HOST_40G_NHI, 0x0000, 0x0000,
> -		  quirk_block_rpm_in_redrive },
> +		  quirk_block_rpm_in_redrive, NULL },
>  	/*
>  	 * CLx is not supported on AMD USB4 Yellow Carp and Pink
> Sardine platforms. */
> -	{ 0x0438, 0x0208, 0x0000, 0x0000, quirk_clx_disable },
> -	{ 0x0438, 0x0209, 0x0000, 0x0000, quirk_clx_disable },
> -	{ 0x0438, 0x020a, 0x0000, 0x0000, quirk_clx_disable },
> -	{ 0x0438, 0x020b, 0x0000, 0x0000, quirk_clx_disable },
> +	{ 0x0438, 0x0208, 0x0000, 0x0000, quirk_clx_disable, NULL },
> +	{ 0x0438, 0x0209, 0x0000, 0x0000, quirk_clx_disable, NULL },
> +	{ 0x0438, 0x020a, 0x0000, 0x0000, quirk_clx_disable, NULL },
> +	{ 0x0438, 0x020b, 0x0000, 0x0000, quirk_clx_disable, NULL },
>  };
>  
> +static bool match(const struct tb_switch *sw, const struct tb_quirk
> *q) +{
> +	if (q->hw_vendor_id && q->hw_vendor_id !=
> sw->config.vendor_id)
> +		return false;
> +	if (q->hw_device_id && q->hw_device_id !=
> sw->config.device_id)
> +		return false;
> +	if (q->vendor && q->vendor != sw->vendor)
> +		return false;
> +	if (q->device && q->device != sw->device)
> +		return false;
> +	return true;
> +}
> +
> +void tb_check_drom_quirks(struct tb_switch *sw)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(tb_quirks); i++) {
> +		const struct tb_quirk *q = &tb_quirks[i];
> +
> +		if (match(sw, q) && q->drom_hook) {
> +			tb_sw_dbg(sw, "running %ps\n", q->drom_hook);
> +			q->drom_hook(sw);
> +		}
> +	}
> +}
> +
>  /**
>   * tb_check_quirks() - Check for quirks to apply
>   * @sw: Thunderbolt switch
> @@ -122,16 +161,9 @@ void tb_check_quirks(struct tb_switch *sw)
>  	for (i = 0; i < ARRAY_SIZE(tb_quirks); i++) {
>  		const struct tb_quirk *q = &tb_quirks[i];
>  
> -		if (q->hw_vendor_id && q->hw_vendor_id !=
> sw->config.vendor_id)
> -			continue;
> -		if (q->hw_device_id && q->hw_device_id !=
> sw->config.device_id)
> -			continue;
> -		if (q->vendor && q->vendor != sw->vendor)
> -			continue;
> -		if (q->device && q->device != sw->device)
> -			continue;
> -
> -		tb_sw_dbg(sw, "running %ps\n", q->hook);
> -		q->hook(sw);
> +		if (match(sw, q) && q->hook) {
> +			tb_sw_dbg(sw, "running %ps\n", q->hook);
> +			q->hook(sw);
> +		}
>  	}
>  }
> diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
> index 10e719dd837c..633aaf9e0574 100644
> --- a/drivers/thunderbolt/tb.c
> +++ b/drivers/thunderbolt/tb.c
> @@ -2023,6 +2023,37 @@ static void tb_exit_redrive(struct tb_port
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
> *port) {
>  	struct tb_port *in, *out;
> @@ -2066,8 +2097,17 @@ static void tb_dp_resource_available(struct tb
> *tb, struct tb_port *port) return;
>  	}
>  
> -	tb_port_dbg(port, "DP %s resource available after hotplug\n",
> -		    tb_port_is_dpin(port) ? "IN" : "OUT");
> +	if (tb_port_is_dpin(port)) {
> +		/* Verify that the resource is really available */
> +		if (!tb_switch_query_dp_resource(port->sw, port)) {
> +			tb_port_info(port, "got hotplug but DP IN
> resource not available\n");
> +			return;
> +		}
> +		tb_port_dbg(port, "DP IN resource available after
> hotplug\n");
> +	} else {
> +		tb_port_dbg(port, "DP OUT resource available after
> hotplug\n");
> +	}
> +
>  	list_add_tail(&port->list, &tcm->dp_resources);
>  	tb_exit_redrive(port);
>  
> @@ -2873,6 +2913,7 @@ static int tb_start(struct tb *tb, bool reset)
>  	tb_create_usb3_tunnels(tb->root_switch);
>  	/* Add DP IN resources for the root switch */
>  	tb_add_dp_resources(tb->root_switch);
> +	tb_switch_enter_redrive(tb->root_switch);
>  	/* Make the discovered switches available to the userspace */
>  	device_for_each_child(&tb->root_switch->dev, NULL,
>  			      tb_scan_finalize_switch);
> @@ -2888,6 +2929,7 @@ static int tb_suspend_noirq(struct tb *tb)
>  
>  	tb_dbg(tb, "suspending...\n");
>  	tb_disconnect_and_release_dp(tb);
> +	tb_switch_exit_redrive(tb->root_switch);
>  	tb_switch_suspend(tb->root_switch, false);
>  	tcm->hotplug_active = false; /* signal tb_handle_hotplug to
> quit */ tb_dbg(tb, "suspend finished\n");
> @@ -2980,6 +3022,7 @@ static int tb_resume_noirq(struct tb *tb)
>  		tb_dbg(tb, "tunnels restarted, sleeping for
> 100ms\n"); msleep(100);
>  	}
> +	tb_switch_enter_redrive(tb->root_switch);
>  	 /* Allow tb_handle_hotplug to progress events */
>  	tcm->hotplug_active = true;
>  	tb_dbg(tb, "resume finished\n");
> @@ -3043,6 +3086,8 @@ static int tb_runtime_suspend(struct tb *tb)
>  	struct tb_cm *tcm = tb_priv(tb);
>  
>  	mutex_lock(&tb->lock);
> +	tb_disconnect_and_release_dp(tb);
> +	tb_switch_exit_redrive(tb->root_switch);
>  	tb_switch_suspend(tb->root_switch, true);
>  	tcm->hotplug_active = false;
>  	mutex_unlock(&tb->lock);
> @@ -3074,6 +3119,7 @@ static int tb_runtime_resume(struct tb *tb)
>  	tb_restore_children(tb->root_switch);
>  	list_for_each_entry_safe(tunnel, n, &tcm->tunnel_list, list)
>  		tb_tunnel_restart(tunnel);
> +	tb_switch_enter_redrive(tb->root_switch);
>  	tcm->hotplug_active = true;
>  	mutex_unlock(&tb->lock);
>  
> diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
> index b47f7873c847..a5d32cfe1db1 100644
> --- a/drivers/thunderbolt/tb.h
> +++ b/drivers/thunderbolt/tb.h
> @@ -1427,6 +1427,7 @@ static inline bool
> usb4_port_device_is_offline(const struct usb4_port *usb4) return
> usb4->offline; }
>  
> +void tb_check_drom_quirks(struct tb_switch *sw);
>  void tb_check_quirks(struct tb_switch *sw);
>  
>  #ifdef CONFIG_ACPI

Thanks! We have tested the 6.11.5 kernel with this patch. Here's the
report from our testing team. dmesg logs are attached.

-----

1. Created 2024-11-01_6.11.5_tbt-barlow-ridge-01.dmesg,
  2024-11-01_6.11.5_tbt-barlow-ridge-02.dmesg.
  Version 01 is with nouveau. Version 02 is with Nivida (rebuilt); could
  NOT build keyboard module (complained did not support 6.11 kernel).
2. In both cases, hot-plug does not wake display. However, after lspci
  -k, displays wake and are reliable.
* Boot the system up, nothing connected.
* Wait for Barlow Ridge to enter runtime suspend. This takes ~15
  seconds so waiting for > 15 seconds should be enough.
* Plug in USB-C monitor to the USB-C port of the Barlow Ridge.
  Screen shows in log, screen wakes, but then no signal is received, and
  no image ever appears. Screen then sleeps after its timeout.
* Run lspci -k to wake up the monitors. Once this is run, the display
  shows correctly and is stable. Adding another USB-C display after this
  also works correctly: It is recognized and lights up in seconds to
  show the desktop background, and remains stable.

Notice that pre-6.5 kernels work fine with Barlow Ridge, which implies
that new code is causing this. It may be new support code for tbt
capability (and therefore pretty much required). But regardless, it's
still new code. With the current patch, we can run a udev rule that
enables hot plugging that likely always work, or (worst case) at least
empowers the customer to refresh monitors by clicking a button.

-----

To my awareness, we have not yet reported the "device links to tunneled
native ports are missing" error to the hardware manufacturer. I'll see
if we can get that reported. Thanks for the heads-up!

--MP_/WuIuDckOYZDBcFRp6AX3mk1
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename=2024-11-01_6.11.5_tbt-barlow-ridge-01-dmesg.txt

[    0.000000] Linux version 6.11.5 (qa@qa-m2) (gcc (Ubuntu 13.2.0-23ubuntu4) 13.2.0, GNU ld (GNU Binutils for Ubuntu) 2.42) #1 SMP PREEMPT_DYNAMIC Fri Nov  1 08:59:18 PDT 2024
[    0.000000] Command line: BOOT_IMAGE=/@boot/vmlinuz-6.11.5 root=UUID=aa8cb093-9cb3-4cc7-b44e-4bff76ca37fb ro rootflags=subvol=@ quiet cryptdevice=UUID=1a8d8cdb-8d8f-4689-b744-8f32d2067f56:luks-1a8d8cdb-8d8f-4689-b744-8f32d2067f56 root=/dev/mapper/luks-1a8d8cdb-8d8f-4689-b744-8f32d2067f56 splash thunderbolt.dyndbg=+p vt.handoff=7
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
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000030228fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000030229000-0x0000000030b28fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000030b29000-0x000000003293efff] usable
[    0.000000] BIOS-e820: [mem 0x000000003293f000-0x00000000349defff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000349df000-0x000000003798efff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000003798f000-0x0000000037afefff] ACPI data
[    0.000000] BIOS-e820: [mem 0x0000000037aff000-0x0000000037afffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000037b00000-0x000000003bffffff] reserved
[    0.000000] BIOS-e820: [mem 0x000000003c800000-0x000000003cbfffff] reserved
[    0.000000] BIOS-e820: [mem 0x000000003ce00000-0x000000003fffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000c0000000-0x00000000cfffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed20000-0x00000000fed7ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x00000008bfffffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] APIC: Static calls initialized
[    0.000000] e820: update [mem 0x2b925018-0x2b949e57] usable ==> usable
[    0.000000] extended physical RAM map:
[    0.000000] reserve setup_data: [mem 0x0000000000000000-0x000000000009efff] usable
[    0.000000] reserve setup_data: [mem 0x000000000009f000-0x00000000000fffff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000000100000-0x000000002b925017] usable
[    0.000000] reserve setup_data: [mem 0x000000002b925018-0x000000002b949e57] usable
[    0.000000] reserve setup_data: [mem 0x000000002b949e58-0x0000000030228fff] usable
[    0.000000] reserve setup_data: [mem 0x0000000030229000-0x0000000030b28fff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000030b29000-0x000000003293efff] usable
[    0.000000] reserve setup_data: [mem 0x000000003293f000-0x00000000349defff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000349df000-0x000000003798efff] ACPI NVS
[    0.000000] reserve setup_data: [mem 0x000000003798f000-0x0000000037afefff] ACPI data
[    0.000000] reserve setup_data: [mem 0x0000000037aff000-0x0000000037afffff] usable
[    0.000000] reserve setup_data: [mem 0x0000000037b00000-0x000000003bffffff] reserved
[    0.000000] reserve setup_data: [mem 0x000000003c800000-0x000000003cbfffff] reserved
[    0.000000] reserve setup_data: [mem 0x000000003ce00000-0x000000003fffffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000c0000000-0x00000000cfffffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fed20000-0x00000000fed7ffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000100000000-0x00000008bfffffff] usable
[    0.000000] efi: EFI v2.8 by INSYDE Corp.
[    0.000000] efi: ACPI=0x37afe000 ACPI 2.0=0x37afe014 TPMFinalLog=0x37866000 SMBIOS=0x32fda000 MEMATTR=0x2ba43518 ESRT=0x2ca20798 MOKvar=0x32f86000 INITRD=0x2bd96398 RNG=0x37a24018 TPMEventLog=0x37a18018 
[    0.000000] random: crng init done
[    0.000000] efi: Remove mem88: MMIO range=[0xc0000000-0xcfffffff] (256MB) from e820 map
[    0.000000] e820: remove [mem 0xc0000000-0xcfffffff] reserved
[    0.000000] efi: Remove mem90: MMIO range=[0xff000000-0xffffffff] (16MB) from e820 map
[    0.000000] e820: remove [mem 0xff000000-0xffffffff] reserved
[    0.000000] SMBIOS 3.4 present.
[    0.000000] DMI: Notebook X370SNx1/X370SNx1, BIOS 1.07.03aMIN29 09/18/2024
[    0.000000] DMI: Memory slots populated: 2/2
[    0.000000] tsc: Detected 2400.000 MHz processor
[    0.000000] tsc: Detected 2419.200 MHz TSC
[    0.000009] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000013] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000028] last_pfn = 0x8c0000 max_arch_pfn = 0x400000000
[    0.000034] MTRR map: 5 entries (3 fixed + 2 variable; max 23), built from 10 variable MTRRs
[    0.000036] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.000750] last_pfn = 0x37b00 max_arch_pfn = 0x400000000
[    0.010260] esrt: Reserving ESRT space from 0x000000002ca20798 to 0x000000002ca20820.
[    0.010269] e820: update [mem 0x2ca20000-0x2ca20fff] usable ==> reserved
[    0.010294] Using GB pages for direct mapping
[    0.010296] Incomplete global flushes, disabling PCID
[    0.010701] Secure boot disabled
[    0.010702] RAMDISK: [mem 0x1af63000-0x1f87afff]
[    0.011316] ACPI: Early table checksum verification disabled
[    0.011321] ACPI: RSDP 0x0000000037AFE014 000024 (v02 INSYDE)
[    0.011328] ACPI: XSDT 0x0000000037A38188 00012C (v01 INSYDE ADL      00000002      01000013)
[    0.011336] ACPI: FACP 0x0000000037ADB000 000114 (v06 INSYDE ADL      00000002 ACPI 00040000)
[    0.011344] ACPI: DSDT 0x0000000037A4E000 089652 (v02 INSYDE ADL      00000002 ACPI 00040000)
[    0.011348] ACPI: FACS 0x000000003783E000 000040
[    0.011352] ACPI: UEFI 0x000000003798E000 0001CF (v01 INSYDE H2O BIOS 00000001 ACPI 00040000)
[    0.011356] ACPI: SSDT 0x0000000037AF3000 00908F (v02 DptfTb DptfTabl 00001000 INTL 20200717)
[    0.011360] ACPI: SSDT 0x0000000037AED000 005D34 (v02 CpuRef CpuSsdt  00003000 INTL 20200717)
[    0.011364] ACPI: SSDT 0x0000000037AEA000 00276F (v02 SaSsdt SaSsdt   00003000 INTL 20200717)
[    0.011367] ACPI: SSDT 0x0000000037AE6000 00328B (v02 INTEL  IgfxSsdt 00003000 INTL 20200717)
[    0.011371] ACPI: SSDT 0x0000000037AE5000 00077B (v02 INSYDE Tpm2Tabl 00001000 INTL 20200717)
[    0.011375] ACPI: TPM2 0x0000000037AE4000 00004C (v04 INSYDE ADL      00000002 ACPI 00040000)
[    0.011378] ACPI: SSDT 0x0000000037ADF000 003249 (v02 INTEL  DTbtSsdt 00001000 INTL 20200717)
[    0.011382] ACPI: SSDT 0x0000000037ADD000 0016A6 (v02 INSYDE UsbCTabl 00001000 INTL 20200717)
[    0.011386] ACPI: NHLT 0x0000000037ADC000 00002D (v00 INSYDE ADL      00000002 ACPI 00040000)
[    0.011389] ACPI: HPET 0x0000000037ADA000 000038 (v01 INSYDE ADL      00000002 ACPI 00040000)
[    0.011393] ACPI: APIC 0x0000000037AD9000 0001DC (v05 INSYDE ADL      00000002 ACPI 00040000)
[    0.011396] ACPI: MCFG 0x0000000037AD8000 00003C (v01 INSYDE ADL      00000002 ACPI 00040000)
[    0.011400] ACPI: SSDT 0x0000000037A48000 0054E4 (v02 INSYDE ADL      00000002      01000013)
[    0.011404] ACPI: WSMT 0x0000000037A47000 000028 (v01 INSYDE ADL      00000002 ACPI 00040000)
[    0.011408] ACPI: SSDT 0x0000000037A45000 0015FD (v02 INSYDE PtidDevc 00001000 INTL 20200717)
[    0.011411] ACPI: SSDT 0x0000000037A3B000 009573 (v02 INSYDE TbtTypeC 00000000 INTL 20200717)
[    0.011415] ACPI: DBGP 0x0000000037A3A000 000034 (v01 INSYDE ADL      00000002 ACPI 00040000)
[    0.011418] ACPI: DBG2 0x0000000037A39000 000054 (v00 INSYDE ADL      00000002 ACPI 00040000)
[    0.011422] ACPI: DMAR 0x0000000037AFD000 000050 (v01 INTEL  ICL      00000002 ACPI 00040000)
[    0.011427] ACPI: SSDT 0x0000000037A35000 002EE7 (v01 NvdRef NvdTabl  00001000 INTL 20200717)
[    0.011431] ACPI: SSDT 0x0000000037A34000 00020D (v01 NvdRef NvdDiscr 00001000 INTL 20200717)
[    0.011435] ACPI: SSDT 0x0000000037A33000 00064F (v01 NvdRef NvDisDds 00001000 INTL 20200717)
[    0.011438] ACPI: UEFI 0x000000003783B000 00063A (v01 INTEL  RstVmdE  00000000 ACPI 00040000)
[    0.011442] ACPI: UEFI 0x000000003783A000 00005C (v01 INTEL  RstVmdV  00000000 ACPI 00040000)
[    0.011446] ACPI: SSDT 0x0000000037A31000 001057 (v02 INTEL  xh_rplsb 00000000 INTL 20200717)
[    0.011450] ACPI: SSDT 0x0000000037A2D000 0039DA (v02 SocGpe SocGpe   00003000 INTL 20200717)
[    0.011453] ACPI: SSDT 0x0000000037A29000 0039DA (v02 SocCmn SocCmn   00003000 INTL 20200717)
[    0.011457] ACPI: SSDT 0x0000000037A28000 0000F8 (v02 INSYDE PcdTabl  00001000 INTL 20200717)
[    0.011461] ACPI: FPDT 0x0000000037A27000 000044 (v01 INSYDE ADL      00000002 ACPI 00040000)
[    0.011464] ACPI: PHAT 0x0000000037A25000 0005ED (v01 INSYDE ADL      00000005 ACPI 00040000)
[    0.011468] ACPI: BGRT 0x0000000037A26000 000038 (v01 INSYDE H2O BIOS 00000001 ACPI 00040000)
[    0.011471] ACPI: Reserving FACP table memory at [mem 0x37adb000-0x37adb113]
[    0.011473] ACPI: Reserving DSDT table memory at [mem 0x37a4e000-0x37ad7651]
[    0.011474] ACPI: Reserving FACS table memory at [mem 0x3783e000-0x3783e03f]
[    0.011475] ACPI: Reserving UEFI table memory at [mem 0x3798e000-0x3798e1ce]
[    0.011476] ACPI: Reserving SSDT table memory at [mem 0x37af3000-0x37afc08e]
[    0.011477] ACPI: Reserving SSDT table memory at [mem 0x37aed000-0x37af2d33]
[    0.011478] ACPI: Reserving SSDT table memory at [mem 0x37aea000-0x37aec76e]
[    0.011479] ACPI: Reserving SSDT table memory at [mem 0x37ae6000-0x37ae928a]
[    0.011480] ACPI: Reserving SSDT table memory at [mem 0x37ae5000-0x37ae577a]
[    0.011481] ACPI: Reserving TPM2 table memory at [mem 0x37ae4000-0x37ae404b]
[    0.011482] ACPI: Reserving SSDT table memory at [mem 0x37adf000-0x37ae2248]
[    0.011483] ACPI: Reserving SSDT table memory at [mem 0x37add000-0x37ade6a5]
[    0.011484] ACPI: Reserving NHLT table memory at [mem 0x37adc000-0x37adc02c]
[    0.011485] ACPI: Reserving HPET table memory at [mem 0x37ada000-0x37ada037]
[    0.011486] ACPI: Reserving APIC table memory at [mem 0x37ad9000-0x37ad91db]
[    0.011487] ACPI: Reserving MCFG table memory at [mem 0x37ad8000-0x37ad803b]
[    0.011488] ACPI: Reserving SSDT table memory at [mem 0x37a48000-0x37a4d4e3]
[    0.011489] ACPI: Reserving WSMT table memory at [mem 0x37a47000-0x37a47027]
[    0.011490] ACPI: Reserving SSDT table memory at [mem 0x37a45000-0x37a465fc]
[    0.011491] ACPI: Reserving SSDT table memory at [mem 0x37a3b000-0x37a44572]
[    0.011492] ACPI: Reserving DBGP table memory at [mem 0x37a3a000-0x37a3a033]
[    0.011493] ACPI: Reserving DBG2 table memory at [mem 0x37a39000-0x37a39053]
[    0.011494] ACPI: Reserving DMAR table memory at [mem 0x37afd000-0x37afd04f]
[    0.011495] ACPI: Reserving SSDT table memory at [mem 0x37a35000-0x37a37ee6]
[    0.011496] ACPI: Reserving SSDT table memory at [mem 0x37a34000-0x37a3420c]
[    0.011497] ACPI: Reserving SSDT table memory at [mem 0x37a33000-0x37a3364e]
[    0.011497] ACPI: Reserving UEFI table memory at [mem 0x3783b000-0x3783b639]
[    0.011498] ACPI: Reserving UEFI table memory at [mem 0x3783a000-0x3783a05b]
[    0.011499] ACPI: Reserving SSDT table memory at [mem 0x37a31000-0x37a32056]
[    0.011501] ACPI: Reserving SSDT table memory at [mem 0x37a2d000-0x37a309d9]
[    0.011502] ACPI: Reserving SSDT table memory at [mem 0x37a29000-0x37a2c9d9]
[    0.011502] ACPI: Reserving SSDT table memory at [mem 0x37a28000-0x37a280f7]
[    0.011503] ACPI: Reserving FPDT table memory at [mem 0x37a27000-0x37a27043]
[    0.011504] ACPI: Reserving PHAT table memory at [mem 0x37a25000-0x37a255ec]
[    0.011505] ACPI: Reserving BGRT table memory at [mem 0x37a26000-0x37a26037]
[    0.011760] No NUMA configuration found
[    0.011762] Faking a node at [mem 0x0000000000000000-0x00000008bfffffff]
[    0.011770] NODE_DATA(0) allocated [mem 0x8bffd5000-0x8bfffffff]
[    0.012024] Zone ranges:
[    0.012025]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.012028]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.012030]   Normal   [mem 0x0000000100000000-0x00000008bfffffff]
[    0.012032]   Device   empty
[    0.012033] Movable zone start for each node
[    0.012035] Early memory node ranges
[    0.012036]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.012038]   node   0: [mem 0x0000000000100000-0x0000000030228fff]
[    0.012039]   node   0: [mem 0x0000000030b29000-0x000000003293efff]
[    0.012040]   node   0: [mem 0x0000000037aff000-0x0000000037afffff]
[    0.012041]   node   0: [mem 0x0000000100000000-0x00000008bfffffff]
[    0.012045] Initmem setup node 0 [mem 0x0000000000001000-0x00000008bfffffff]
[    0.012052] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.012084] On node 0, zone DMA: 97 pages in unavailable ranges
[    0.013522] On node 0, zone DMA32: 2304 pages in unavailable ranges
[    0.013711] On node 0, zone DMA32: 20928 pages in unavailable ranges
[    0.056442] On node 0, zone Normal: 1280 pages in unavailable ranges
[    0.057134] ACPI: PM-Timer IO Port: 0x1808
[    0.057146] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.057148] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.057149] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.057150] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.057151] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
[    0.057152] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[    0.057152] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
[    0.057153] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
[    0.057154] ACPI: LAPIC_NMI (acpi_id[0x09] high edge lint[0x1])
[    0.057155] ACPI: LAPIC_NMI (acpi_id[0x0a] high edge lint[0x1])
[    0.057156] ACPI: LAPIC_NMI (acpi_id[0x0b] high edge lint[0x1])
[    0.057156] ACPI: LAPIC_NMI (acpi_id[0x0c] high edge lint[0x1])
[    0.057157] ACPI: LAPIC_NMI (acpi_id[0x0d] high edge lint[0x1])
[    0.057158] ACPI: LAPIC_NMI (acpi_id[0x0e] high edge lint[0x1])
[    0.057159] ACPI: LAPIC_NMI (acpi_id[0x0f] high edge lint[0x1])
[    0.057160] ACPI: LAPIC_NMI (acpi_id[0x10] high edge lint[0x1])
[    0.057160] ACPI: LAPIC_NMI (acpi_id[0x11] high edge lint[0x1])
[    0.057161] ACPI: LAPIC_NMI (acpi_id[0x12] high edge lint[0x1])
[    0.057162] ACPI: LAPIC_NMI (acpi_id[0x13] high edge lint[0x1])
[    0.057163] ACPI: LAPIC_NMI (acpi_id[0x14] high edge lint[0x1])
[    0.057164] ACPI: LAPIC_NMI (acpi_id[0x15] high edge lint[0x1])
[    0.057164] ACPI: LAPIC_NMI (acpi_id[0x16] high edge lint[0x1])
[    0.057165] ACPI: LAPIC_NMI (acpi_id[0x17] high edge lint[0x1])
[    0.057166] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.057206] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-119
[    0.057209] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.057211] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.057215] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.057216] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.057224] e820: update [mem 0x2b43a000-0x2b4f4fff] usable ==> reserved
[    0.057237] TSC deadline timer available
[    0.057240] CPU topo: Max. logical packages:   1
[    0.057241] CPU topo: Max. logical dies:       1
[    0.057242] CPU topo: Max. dies per package:   1
[    0.057245] CPU topo: Max. threads per core:   2
[    0.057246] CPU topo: Num. cores per package:    24
[    0.057247] CPU topo: Num. threads per package:  32
[    0.057248] CPU topo: Allowing 32 present CPUs plus 0 hotplug CPUs
[    0.057265] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.057267] PM: hibernation: Registered nosave memory: [mem 0x0009f000-0x000fffff]
[    0.057269] PM: hibernation: Registered nosave memory: [mem 0x2b43a000-0x2b4f4fff]
[    0.057270] PM: hibernation: Registered nosave memory: [mem 0x2b925000-0x2b925fff]
[    0.057272] PM: hibernation: Registered nosave memory: [mem 0x2b949000-0x2b949fff]
[    0.057274] PM: hibernation: Registered nosave memory: [mem 0x2ca20000-0x2ca20fff]
[    0.057275] PM: hibernation: Registered nosave memory: [mem 0x30229000-0x30b28fff]
[    0.057277] PM: hibernation: Registered nosave memory: [mem 0x3293f000-0x349defff]
[    0.057278] PM: hibernation: Registered nosave memory: [mem 0x349df000-0x3798efff]
[    0.057278] PM: hibernation: Registered nosave memory: [mem 0x3798f000-0x37afefff]
[    0.057280] PM: hibernation: Registered nosave memory: [mem 0x37b00000-0x3bffffff]
[    0.057281] PM: hibernation: Registered nosave memory: [mem 0x3c000000-0x3c7fffff]
[    0.057282] PM: hibernation: Registered nosave memory: [mem 0x3c800000-0x3cbfffff]
[    0.057282] PM: hibernation: Registered nosave memory: [mem 0x3cc00000-0x3cdfffff]
[    0.057283] PM: hibernation: Registered nosave memory: [mem 0x3ce00000-0x3fffffff]
[    0.057284] PM: hibernation: Registered nosave memory: [mem 0x40000000-0xfed1ffff]
[    0.057284] PM: hibernation: Registered nosave memory: [mem 0xfed20000-0xfed7ffff]
[    0.057285] PM: hibernation: Registered nosave memory: [mem 0xfed80000-0xffffffff]
[    0.057287] [mem 0x40000000-0xfed1ffff] available for PCI devices
[    0.057288] Booting paravirtualized kernel on bare hardware
[    0.057291] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.057299] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:32 nr_cpu_ids:32 nr_node_ids:1
[    0.059115] percpu: Embedded 88 pages/cpu s237568 r8192 d114688 u524288
[    0.059122] pcpu-alloc: s237568 r8192 d114688 u524288 alloc=1*2097152
[    0.059125] pcpu-alloc: [0] 00 01 02 03 [0] 04 05 06 07 
[    0.059131] pcpu-alloc: [0] 08 09 10 11 [0] 12 13 14 15 
[    0.059136] pcpu-alloc: [0] 16 17 18 19 [0] 20 21 22 23 
[    0.059141] pcpu-alloc: [0] 24 25 26 27 [0] 28 29 30 31 
[    0.059168] Kernel command line: BOOT_IMAGE=/@boot/vmlinuz-6.11.5 root=UUID=aa8cb093-9cb3-4cc7-b44e-4bff76ca37fb ro rootflags=subvol=@ quiet cryptdevice=UUID=1a8d8cdb-8d8f-4689-b744-8f32d2067f56:luks-1a8d8cdb-8d8f-4689-b744-8f32d2067f56 root=/dev/mapper/luks-1a8d8cdb-8d8f-4689-b744-8f32d2067f56 splash thunderbolt.dyndbg=+p vt.handoff=7
[    0.059269] Unknown kernel command line parameters "splash BOOT_IMAGE=/@boot/vmlinuz-6.11.5 cryptdevice=UUID=1a8d8cdb-8d8f-4689-b744-8f32d2067f56:luks-1a8d8cdb-8d8f-4689-b744-8f32d2067f56", will be passed to user space.
[    0.061881] Dentry cache hash table entries: 4194304 (order: 13, 33554432 bytes, linear)
[    0.063186] Inode-cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
[    0.063608] Fallback order for Node 0: 0 
[    0.063613] Built 1 zonelists, mobility grouping on.  Total pages: 8331230
[    0.063614] Policy zone: Normal
[    0.063625] mem auto-init: stack:all(zero), heap alloc:on, heap free:off
[    0.063632] software IO TLB: area num 32.
[    0.134622] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=32, Nodes=1
[    0.134702] ftrace: allocating 55948 entries in 219 pages
[    0.144662] ftrace: allocated 219 pages with 6 groups
[    0.145484] Dynamic Preempt: voluntary
[    0.145675] rcu: Preemptible hierarchical RCU implementation.
[    0.145676] rcu: 	RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=32.
[    0.145678] 	Trampoline variant of Tasks RCU enabled.
[    0.145678] 	Rude variant of Tasks RCU enabled.
[    0.145679] 	Tracing variant of Tasks RCU enabled.
[    0.145680] rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
[    0.145681] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=32
[    0.145705] RCU Tasks: Setting shift to 5 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=32.
[    0.145708] RCU Tasks Rude: Setting shift to 5 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=32.
[    0.145711] RCU Tasks Trace: Setting shift to 5 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=32.
[    0.148658] NR_IRQS: 524544, nr_irqs: 2312, preallocated irqs: 16
[    0.149018] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.149289] Console: colour dummy device 80x25
[    0.149292] printk: legacy console [tty0] enabled
[    0.149357] ACPI: Core revision 20240322
[    0.149849] hpet: HPET dysfunctional in PC10. Force disabled.
[    0.149850] APIC: Switch to symmetric I/O mode setup
[    0.149853] DMAR: Host address width 39
[    0.149854] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
[    0.149865] DMAR: dmar0: reg_base_addr fed91000 ver 5:0 cap d2008c40660462 ecap f050da
[    0.149869] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 0
[    0.149871] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
[    0.149872] DMAR-IR: Queued invalidation will be enabled to support x2apic and Intr-remapping.
[    0.151597] DMAR-IR: Enabled IRQ remapping in x2apic mode
[    0.151599] x2apic enabled
[    0.151667] APIC: Switched APIC routing to: cluster x2apic
[    0.156427] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x22df1149949, max_idle_ns: 440795312789 ns
[    0.156435] Calibrating delay loop (skipped), value calculated using timer frequency.. 4838.40 BogoMIPS (lpj=2419200)
[    0.156504] CPU0: Thermal monitoring enabled (TM1)
[    0.156507] x86/cpu: User Mode Instruction Prevention (UMIP) activated
[    0.156671] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[    0.156673] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[    0.156676] process: using mwait in idle threads
[    0.156679] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.156683] Spectre V2 : Mitigation: Enhanced / Automatic IBRS
[    0.156684] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.156684] Spectre V2 : Spectre v2 / PBRSB-eIBRS: Retire a single CALL on VMEXIT
[    0.156686] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
[    0.156689] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
[    0.156690] Register File Data Sampling: Mitigation: Clear Register File
[    0.156702] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.156703] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.156704] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.156705] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys User registers'
[    0.156706] x86/fpu: Supporting XSAVE feature 0x800: 'Control-flow User registers'
[    0.156707] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.156709] x86/fpu: xstate_offset[9]:  832, xstate_sizes[9]:    8
[    0.156710] x86/fpu: xstate_offset[11]:  840, xstate_sizes[11]:   16
[    0.156712] x86/fpu: Enabled xstate features 0xa07, context size is 856 bytes, using 'compacted' format.
[    0.157432] Freeing SMP alternatives memory: 48K
[    0.157432] pid_max: default: 32768 minimum: 301
[    0.157432] LSM: initializing lsm=lockdown,capability,landlock,yama,apparmor,ima,evm
[    0.157432] landlock: Up and running.
[    0.157432] Yama: becoming mindful.
[    0.157432] AppArmor: AppArmor initialized
[    0.157432] Mount-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.157432] Mountpoint-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.157432] smpboot: CPU0: Intel(R) Core(TM) i9-14900HX (family: 0x6, model: 0xb7, stepping: 0x1)
[    0.157432] Performance Events: XSAVE Architectural LBR, PEBS fmt4+-baseline,  AnyThread deprecated, Alderlake Hybrid events, 32-deep LBR, full-width counters, Intel PMU driver.
[    0.157432] core: cpu_core PMU driver: 
[    0.157432] ... version:                5
[    0.157432] ... bit width:              48
[    0.157432] ... generic registers:      8
[    0.157432] ... value mask:             0000ffffffffffff
[    0.157432] ... max period:             00007fffffffffff
[    0.157432] ... fixed-purpose events:   4
[    0.157432] ... event mask:             0001000f000000ff
[    0.157432] signal: max sigframe size: 3632
[    0.157432] Estimated ratio of average max frequency by base frequency (times 1024): 2218
[    0.157432] rcu: Hierarchical SRCU implementation.
[    0.157432] rcu: 	Max phase no-delay instances is 400.
[    0.157432] Timer migration: 2 hierarchy levels; 8 children per group; 2 crossnode level
[    0.159215] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    0.159494] smp: Bringing up secondary CPUs ...
[    0.159593] smpboot: x86: Booting SMP configuration:
[    0.159594] .... node  #0, CPUs:        #2  #4  #6  #8 #10 #12 #14 #16 #17 #18 #19 #20 #21 #22 #23 #24 #25 #26 #27 #28 #29 #30 #31
[    0.008231] core: cpu_atom PMU driver: PEBS-via-PT 
[    0.008231] ... version:                5
[    0.008231] ... bit width:              48
[    0.008231] ... generic registers:      6
[    0.008231] ... value mask:             0000ffffffffffff
[    0.008231] ... max period:             00007fffffffffff
[    0.008231] ... fixed-purpose events:   3
[    0.008231] ... event mask:             000000070000003f
[    0.173568]   #1  #3  #5  #7  #9 #11 #13 #15
[    0.182518] smp: Brought up 1 node, 32 CPUs
[    0.182518] smpboot: Total of 32 processors activated (154828.80 BogoMIPS)
[    0.183818] Memory: 32501348K/33324920K available (22528K kernel code, 4519K rwdata, 13792K rodata, 4996K init, 4628K bss, 777092K reserved, 0K cma-reserved)
[    0.184933] devtmpfs: initialized
[    0.184933] x86/mm: Memory block size: 128MB
[    0.188210] ACPI: PM: Registering ACPI NVS region [mem 0x349df000-0x3798efff] (50003968 bytes)
[    0.188754] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.188806] futex hash table entries: 8192 (order: 7, 524288 bytes, linear)
[    0.188931] pinctrl core: initialized pinctrl subsystem
[    0.189171] PM: RTC time: 17:25:25, date: 2024-11-01
[    0.189764] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.190289] DMA: preallocated 4096 KiB GFP_KERNEL pool for atomic allocations
[    0.190716] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[    0.191105] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[    0.191116] audit: initializing netlink subsys (disabled)
[    0.191124] audit: type=2000 audit(1730481925.034:1): state=initialized audit_enabled=0 res=1
[    0.191124] thermal_sys: Registered thermal governor 'fair_share'
[    0.191124] thermal_sys: Registered thermal governor 'bang_bang'
[    0.191124] thermal_sys: Registered thermal governor 'step_wise'
[    0.191124] thermal_sys: Registered thermal governor 'user_space'
[    0.191124] thermal_sys: Registered thermal governor 'power_allocator'
[    0.191124] EISA bus registered
[    0.191124] cpuidle: using governor ladder
[    0.191124] cpuidle: using governor menu
[    0.191459] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.191591] PCI: ECAM [mem 0xc0000000-0xce0fffff] (base 0xc0000000) for domain 0000 [bus 00-e0]
[    0.191607] PCI: Using configuration type 1 for base access
[    0.191751] kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
[    0.191756] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    0.191756] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
[    0.191756] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.191756] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.192648] ACPI: Added _OSI(Module Device)
[    0.192648] ACPI: Added _OSI(Processor Device)
[    0.192648] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.192648] ACPI: Added _OSI(Processor Aggregator Device)
[    0.335567] ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PC00.MHBR], AE_NOT_FOUND (20240322/psargs-332)
[    0.335585] ACPI: Ignoring error and continuing table load
[    0.335609] ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PTID.PBAR], AE_NOT_FOUND (20240322/dsfield-500)
[    0.343727] ACPI: 18 ACPI AML tables successfully acquired and loaded
[    0.363305] ACPI: USB4 _OSC: OS supports USB3+ DisplayPort+ PCIe+ XDomain+
[    0.363308] ACPI: USB4 _OSC: OS controls USB3+ DisplayPort+ PCIe+ XDomain+
[    0.365237] ACPI: Dynamic OEM Table Load:
[    0.365251] ACPI: SSDT 0xFFFF9500C1FC5800 000394 (v02 PmRef  Cpu0Cst  00003001 INTL 20200717)
[    0.367157] ACPI: Dynamic OEM Table Load:
[    0.367165] ACPI: SSDT 0xFFFF9500C4020000 00053F (v02 PmRef  Cpu0Ist  00003000 INTL 20200717)
[    0.369062] ACPI: Dynamic OEM Table Load:
[    0.369069] ACPI: SSDT 0xFFFF9500C405B400 0001AB (v02 PmRef  Cpu0Psd  00003000 INTL 20200717)
[    0.370855] ACPI: Dynamic OEM Table Load:
[    0.370861] ACPI: SSDT 0xFFFF9500C4026000 0004B5 (v02 PmRef  Cpu0Hwp  00003000 INTL 20200717)
[    0.373248] ACPI: Dynamic OEM Table Load:
[    0.373267] ACPI: SSDT 0xFFFF9500C402A000 001BAF (v02 PmRef  ApIst    00003000 INTL 20200717)
[    0.376049] ACPI: Dynamic OEM Table Load:
[    0.376058] ACPI: SSDT 0xFFFF9500C4028000 001038 (v02 PmRef  ApHwp    00003000 INTL 20200717)
[    0.378545] ACPI: Dynamic OEM Table Load:
[    0.378553] ACPI: SSDT 0xFFFF9500C402C000 001349 (v02 PmRef  ApPsd    00003000 INTL 20200717)
[    0.381109] ACPI: Dynamic OEM Table Load:
[    0.381117] ACPI: SSDT 0xFFFF9500C403D000 000FBB (v02 PmRef  ApCst    00003000 INTL 20200717)
[    0.400970] ACPI: EC: EC started
[    0.400972] ACPI: EC: interrupt blocked
[    0.420095] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.420098] ACPI: \_SB_.PC00.LPCB.EC__: Boot DSDT EC used to handle transactions
[    0.420100] ACPI: Interpreter enabled
[    0.420193] ACPI: PM: (supports S0 S3 S4 S5)
[    0.420194] ACPI: Using IOAPIC for interrupt routing
[    0.422627] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.422629] PCI: Ignoring E820 reservations for host bridge windows
[    0.424465] ACPI: Enabled 11 GPEs in block 00 to 7F
[    0.426949] ACPI: \_SB_.PC00.PEG2.PG00: New power resource
[    0.452248] ACPI: \_SB_.PC00.XHCI.RHUB.HS14.BTRT: New power resource
[    0.452274] ACPI: \_SB_.PC00.XHCI.RHUB.HS14.DBTR: New power resource
[    0.462607] ACPI: \_SB_.PC00.CNVW.WRST: New power resource
[    0.468421] ACPI: \_SB_.PC00.RP09.PXP_: New power resource
[    0.495411] ACPI: \PIN_: New power resource
[    0.496297] ACPI: PCI Root Bridge [PC00] (domain 0000 [bus 00-e0])
[    0.496305] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
[    0.500181] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotplug PME AER PCIeCapability LTR DPC]
[    0.506396] PCI host bridge to bus 0000:00
[    0.506399] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.506402] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.506404] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.506406] pci_bus 0000:00: root bus resource [mem 0x40000000-0xbfffffff window]
[    0.506407] pci_bus 0000:00: root bus resource [mem 0x4000000000-0x7fffffffff window]
[    0.506409] pci_bus 0000:00: root bus resource [bus 00-e0]
[    0.506454] pci 0000:00:00.0: [8086:a702] type 00 class 0x060000 conventional PCI endpoint
[    0.506596] pci 0000:00:01.0: [8086:a70d] type 01 class 0x060400 PCIe Root Port
[    0.506614] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.506678] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    0.506704] pci 0000:00:01.0: PTM enabled (root), 4ns granularity
[    0.507515] pci 0000:00:01.1: [8086:a72d] type 01 class 0x060400 PCIe Root Port
[    0.507533] pci 0000:00:01.1: PCI bridge to [bus 02]
[    0.507536] pci 0000:00:01.1:   bridge window [io  0x3000-0x3fff]
[    0.507539] pci 0000:00:01.1:   bridge window [mem 0x4a000000-0x4b0fffff]
[    0.507545] pci 0000:00:01.1:   bridge window [mem 0x4000000000-0x4401ffffff 64bit pref]
[    0.507597] pci 0000:00:01.1: PME# supported from D0 D3hot D3cold
[    0.507621] pci 0000:00:01.1: PTM enabled (root), 4ns granularity
[    0.508396] pci 0000:00:04.0: [8086:a71d] type 00 class 0x118000 conventional PCI endpoint
[    0.508413] pci 0000:00:04.0: BAR 0 [mem 0x4404200000-0x440421ffff 64bit]
[    0.508781] pci 0000:00:08.0: [8086:a74f] type 00 class 0x088000 conventional PCI endpoint
[    0.508792] pci 0000:00:08.0: BAR 0 [mem 0x4404241000-0x4404241fff 64bit]
[    0.508904] pci 0000:00:0a.0: [8086:a77d] type 00 class 0x118000 PCIe Root Complex Integrated Endpoint
[    0.508912] pci 0000:00:0a.0: BAR 0 [mem 0x4404220000-0x4404227fff 64bit]
[    0.508932] pci 0000:00:0a.0: enabling Extended Tags
[    0.509045] pci 0000:00:0e.0: [8086:a77f] type 00 class 0x010400 PCIe Root Complex Integrated Endpoint
[    0.509060] pci 0000:00:0e.0: BAR 0 [mem 0x4402000000-0x4403ffffff 64bit]
[    0.509067] pci 0000:00:0e.0: BAR 2 [mem 0x48000000-0x49ffffff]
[    0.509083] pci 0000:00:0e.0: BAR 4 [mem 0x4404100000-0x44041fffff 64bit]
[    0.509413] pci 0000:00:14.0: [8086:7a60] type 00 class 0x0c0330 conventional PCI endpoint
[    0.509434] pci 0000:00:14.0: BAR 0 [mem 0x4b380000-0x4b38ffff 64bit]
[    0.509519] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.510139] pci 0000:00:14.2: [8086:7a27] type 00 class 0x050000 conventional PCI endpoint
[    0.510164] pci 0000:00:14.2: BAR 0 [mem 0x4404238000-0x440423bfff 64bit]
[    0.510181] pci 0000:00:14.2: BAR 2 [mem 0x4404240000-0x4404240fff 64bit]
[    0.510337] pci 0000:00:14.3: [8086:7a70] type 00 class 0x028000 PCIe Root Complex Integrated Endpoint
[    0.510384] pci 0000:00:14.3: BAR 0 [mem 0x4404234000-0x4404237fff 64bit]
[    0.510575] pci 0000:00:14.3: PME# supported from D0 D3hot D3cold
[    0.510999] pci 0000:00:15.0: [8086:7a4c] type 00 class 0x0c8000 conventional PCI endpoint
[    0.511074] pci 0000:00:15.0: BAR 0 [mem 0x00000000-0x00000fff 64bit]
[    0.511647] pci 0000:00:15.1: [8086:7a4d] type 00 class 0x0c8000 conventional PCI endpoint
[    0.511714] pci 0000:00:15.1: BAR 0 [mem 0x00000000-0x00000fff 64bit]
[    0.512230] pci 0000:00:16.0: [8086:7a68] type 00 class 0x078000 conventional PCI endpoint
[    0.512254] pci 0000:00:16.0: BAR 0 [mem 0x440423d000-0x440423dfff 64bit]
[    0.512338] pci 0000:00:16.0: PME# supported from D3hot
[    0.512931] pci 0000:00:1c.0: [8086:7a3e] type 01 class 0x060400 PCIe Root Port
[    0.512963] pci 0000:00:1c.0: PCI bridge to [bus 03]
[    0.512970] pci 0000:00:1c.0:   bridge window [mem 0x4b100000-0x4b2fffff]
[    0.513066] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.513107] pci 0000:00:1c.0: PTM enabled (root), 4ns granularity
[    0.513987] pci 0000:00:1d.0: [8086:7a30] type 01 class 0x060400 PCIe Root Port
[    0.514018] pci 0000:00:1d.0: PCI bridge to [bus 04-54]
[    0.514025] pci 0000:00:1d.0:   bridge window [mem 0x40000000-0x47ffffff]
[    0.514036] pci 0000:00:1d.0:   bridge window [mem 0x4410000000-0x54100fffff 64bit pref]
[    0.514181] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    0.515098] pci 0000:00:1f.0: [8086:7a0c] type 00 class 0x060100 conventional PCI endpoint
[    0.515540] pci 0000:00:1f.3: [8086:7a50] type 00 class 0x040300 conventional PCI endpoint
[    0.515584] pci 0000:00:1f.3: BAR 0 [mem 0x4404230000-0x4404233fff 64bit]
[    0.515638] pci 0000:00:1f.3: BAR 4 [mem 0x4404000000-0x44040fffff 64bit]
[    0.515747] pci 0000:00:1f.3: PME# supported from D3hot D3cold
[    0.515855] pci 0000:00:1f.4: [8086:7a23] type 00 class 0x0c0500 conventional PCI endpoint
[    0.515882] pci 0000:00:1f.4: BAR 0 [mem 0x440423c000-0x440423c0ff 64bit]
[    0.515913] pci 0000:00:1f.4: BAR 4 [io  0xefa0-0xefbf]
[    0.516235] pci 0000:00:1f.5: [8086:7a24] type 00 class 0x0c8000 conventional PCI endpoint
[    0.516255] pci 0000:00:1f.5: BAR 0 [mem 0xfe010000-0xfe010fff]
[    0.516412] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.516475] pci 0000:02:00.0: [10de:27e0] type 00 class 0x030000 PCIe Legacy Endpoint
[    0.516491] pci 0000:02:00.0: BAR 0 [mem 0x4a000000-0x4affffff]
[    0.516505] pci 0000:02:00.0: BAR 1 [mem 0x4000000000-0x43ffffffff 64bit pref]
[    0.516519] pci 0000:02:00.0: BAR 3 [mem 0x4400000000-0x4401ffffff 64bit pref]
[    0.516528] pci 0000:02:00.0: BAR 5 [io  0x3000-0x307f]
[    0.516537] pci 0000:02:00.0: ROM [mem 0xfff80000-0xffffffff pref]
[    0.516624] pci 0000:02:00.0: PME# supported from D0 D3hot
[    0.516748] pci 0000:02:00.0: 16.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s PCIe x8 link at 0000:00:01.1 (capable of 252.048 Gb/s with 16.0 GT/s PCIe x16 link)
[    0.517062] pci 0000:02:00.1: [10de:22bc] type 00 class 0x040300 PCIe Endpoint
[    0.517077] pci 0000:02:00.1: BAR 0 [mem 0x4b000000-0x4b003fff]
[    0.517267] pci 0000:00:01.1: PCI bridge to [bus 02]
[    0.517405] pci 0000:03:00.0: [8086:3102] type 00 class 0x020000 PCIe Endpoint
[    0.517430] pci 0000:03:00.0: BAR 0 [mem 0x4b100000-0x4b1fffff]
[    0.517468] pci 0000:03:00.0: BAR 3 [mem 0x4b200000-0x4b203fff]
[    0.517628] pci 0000:03:00.0: PME# supported from D0 D3hot D3cold
[    0.517936] pci 0000:00:1c.0: PCI bridge to [bus 03]
[    0.518043] pci 0000:04:00.0: [8086:5780] type 01 class 0x060400 PCIe Switch Upstream Port
[    0.518085] pci 0000:04:00.0: PCI bridge to [bus 05-54]
[    0.518096] pci 0000:04:00.0:   bridge window [mem 0x40000000-0x47efffff]
[    0.518110] pci 0000:04:00.0:   bridge window [mem 0x4410000000-0x54100fffff 64bit pref]
[    0.518127] pci 0000:04:00.0: enabling Extended Tags
[    0.518265] pci 0000:04:00.0: supports D1 D2
[    0.518266] pci 0000:04:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.518672] pci 0000:00:1d.0: PCI bridge to [bus 04-54]
[    0.518798] pci 0000:05:00.0: [8086:5780] type 01 class 0x060400 PCIe Switch Downstream Port
[    0.518839] pci 0000:05:00.0: PCI bridge to [bus 06]
[    0.518863] pci 0000:05:00.0:   bridge window [mem 0x5410000000-0x54100fffff 64bit pref]
[    0.518881] pci 0000:05:00.0: enabling Extended Tags
[    0.519010] pci 0000:05:00.0: supports D1 D2
[    0.519011] pci 0000:05:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.519341] pci 0000:05:01.0: [8086:5780] type 01 class 0x060400 PCIe Switch Downstream Port
[    0.519382] pci 0000:05:01.0: PCI bridge to [bus 07-2c]
[    0.519393] pci 0000:05:01.0:   bridge window [mem 0x44000000-0x47efffff]
[    0.519424] pci 0000:05:01.0: enabling Extended Tags
[    0.519562] pci 0000:05:01.0: supports D1 D2
[    0.519564] pci 0000:05:01.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.519882] pci 0000:05:02.0: [8086:5780] type 01 class 0x060400 PCIe Switch Downstream Port
[    0.519924] pci 0000:05:02.0: PCI bridge to [bus 2d]
[    0.519935] pci 0000:05:02.0:   bridge window [mem 0x43f00000-0x43ffffff]
[    0.519965] pci 0000:05:02.0: enabling Extended Tags
[    0.520094] pci 0000:05:02.0: supports D1 D2
[    0.520095] pci 0000:05:02.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.520416] pci 0000:05:03.0: [8086:5780] type 01 class 0x060400 PCIe Switch Downstream Port
[    0.520457] pci 0000:05:03.0: PCI bridge to [bus 2e-54]
[    0.520468] pci 0000:05:03.0:   bridge window [mem 0x40000000-0x43efffff]
[    0.520499] pci 0000:05:03.0: enabling Extended Tags
[    0.520637] pci 0000:05:03.0: supports D1 D2
[    0.520638] pci 0000:05:03.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.520968] pci 0000:04:00.0: PCI bridge to [bus 05-54]
[    0.521086] pci 0000:06:00.0: [8086:5781] type 00 class 0x0c0340 PCIe Endpoint
[    0.521113] pci 0000:06:00.0: BAR 0 [mem 0x5410000000-0x541003ffff 64bit pref]
[    0.521131] pci 0000:06:00.0: BAR 2 [mem 0x5410040000-0x5410040fff 64bit pref]
[    0.521173] pci 0000:06:00.0: enabling Extended Tags
[    0.521289] pci 0000:06:00.0: supports D1 D2
[    0.521290] pci 0000:06:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.521565] pci 0000:05:00.0: PCI bridge to [bus 06]
[    0.521627] pci 0000:05:01.0: PCI bridge to [bus 07-2c]
[    0.521736] pci 0000:2d:00.0: [8086:5782] type 00 class 0x0c0330 PCIe Endpoint
[    0.521760] pci 0000:2d:00.0: BAR 0 [mem 0x43f00000-0x43f0ffff 64bit]
[    0.521809] pci 0000:2d:00.0: enabling Extended Tags
[    0.521893] pci 0000:2d:00.0: PME# supported from D3hot D3cold
[    0.521931] pci 0000:2d:00.0: 8.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:05:02.0 (capable of 31.504 Gb/s with 8.0 GT/s PCIe x4 link)
[    0.522075] pci 0000:05:02.0: PCI bridge to [bus 2d]
[    0.522149] pci 0000:05:03.0: PCI bridge to [bus 2e-54]
[    0.548935] ACPI: EC: interrupt unblocked
[    0.548936] ACPI: EC: event unblocked
[    0.548953] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.548954] ACPI: EC: GPE=0x6e
[    0.548955] ACPI: \_SB_.PC00.LPCB.EC__: Boot DSDT EC initialization complete
[    0.548957] ACPI: \_SB_.PC00.LPCB.EC__: EC: Used to handle transactions and events
[    0.549444] iommu: Default domain type: Translated
[    0.549444] iommu: DMA domain TLB invalidation policy: lazy mode
[    0.549657] SCSI subsystem initialized
[    0.549673] libata version 3.00 loaded.
[    0.549673] ACPI: bus type USB registered
[    0.549673] usbcore: registered new interface driver usbfs
[    0.549673] usbcore: registered new interface driver hub
[    0.549673] usbcore: registered new device driver usb
[    0.549673] pps_core: LinuxPPS API ver. 1 registered
[    0.549673] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.549673] PTP clock support registered
[    0.549673] EDAC MC: Ver: 3.0.0
[    0.550434] efivars: Registered efivars operations
[    0.551511] NetLabel: Initializing
[    0.551513] NetLabel:  domain hash size = 128
[    0.551514] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.551545] NetLabel:  unlabeled traffic allowed by default
[    0.551567] mctp: management component transport protocol core
[    0.551567] NET: Registered PF_MCTP protocol family
[    0.551567] PCI: Using ACPI for IRQ routing
[    0.565432] PCI: pci_cache_line_size set to 64 bytes
[    0.566547] pci 0000:00:1f.5: BAR 0 [mem 0xfe010000-0xfe010fff]: can't claim; no compatible bridge window
[    0.566692] e820: reserve RAM buffer [mem 0x0009f000-0x0009ffff]
[    0.566694] e820: reserve RAM buffer [mem 0x2b43a000-0x2bffffff]
[    0.566696] e820: reserve RAM buffer [mem 0x2b925018-0x2bffffff]
[    0.566697] e820: reserve RAM buffer [mem 0x2ca20000-0x2fffffff]
[    0.566698] e820: reserve RAM buffer [mem 0x30229000-0x33ffffff]
[    0.566699] e820: reserve RAM buffer [mem 0x3293f000-0x33ffffff]
[    0.566700] e820: reserve RAM buffer [mem 0x37b00000-0x37ffffff]
[    0.567447] pci 0000:02:00.0: vgaarb: setting as boot VGA device
[    0.567447] pci 0000:02:00.0: vgaarb: bridge control possible
[    0.567447] pci 0000:02:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
[    0.567447] vgaarb: loaded
[    0.567584] clocksource: Switched to clocksource tsc-early
[    0.568014] VFS: Disk quotas dquot_6.6.0
[    0.568027] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.568168] AppArmor: AppArmor Filesystem Enabled
[    0.568204] pnp: PnP ACPI init
[    0.568494] pnp 00:00: disabling [io  0x3322-0x3323] because it overlaps 0000:00:01.1 BAR 13 [io  0x3000-0x3fff]
[    0.568723] system 00:02: [io  0x1854-0x1857] has been reserved
[    0.584666] system 00:05: [mem 0xfedc0000-0xfedc7fff] has been reserved
[    0.584671] system 00:05: [mem 0xfeda0000-0xfeda0fff] has been reserved
[    0.584673] system 00:05: [mem 0xfeda1000-0xfeda1fff] has been reserved
[    0.584675] system 00:05: [mem 0xc0000000-0xcfffffff] has been reserved
[    0.584677] system 00:05: [mem 0xfed20000-0xfed7ffff] could not be reserved
[    0.584679] system 00:05: [mem 0xfed90000-0xfed93fff] could not be reserved
[    0.584681] system 00:05: [mem 0xfed45000-0xfed8ffff] could not be reserved
[    0.584683] system 00:05: [mem 0xfee00000-0xfeefffff] has been reserved
[    0.585143] system 00:06: [io  0x2000-0x20fe] has been reserved
[    0.586625] pnp: PnP ACPI: found 8 devices
[    0.592985] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.593076] NET: Registered PF_INET protocol family
[    0.593565] IP idents hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.612582] tcp_listen_portaddr_hash hash table entries: 16384 (order: 6, 262144 bytes, linear)
[    0.612625] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    0.612897] TCP established hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.613549] TCP bind hash table entries: 65536 (order: 9, 2097152 bytes, linear)
[    0.613685] TCP: Hash tables configured (established 262144 bind 65536)
[    0.614001] MPTCP token hash table entries: 32768 (order: 7, 786432 bytes, linear)
[    0.614167] UDP hash table entries: 16384 (order: 7, 524288 bytes, linear)
[    0.614359] UDP-Lite hash table entries: 16384 (order: 7, 524288 bytes, linear)
[    0.614511] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.614519] NET: Registered PF_XDP protocol family
[    0.614523] pci 0000:02:00.0: ROM [mem 0xfff80000-0xffffffff pref]: can't claim; no compatible bridge window
[    0.614548] pci 0000:05:01.0: bridge window [io  0x1000-0x0fff] to [bus 07-2c] add_size 1000
[    0.614552] pci 0000:05:01.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 07-2c] add_size 200000 add_align 100000
[    0.614557] pci 0000:05:03.0: bridge window [io  0x1000-0x0fff] to [bus 2e-54] add_size 1000
[    0.614559] pci 0000:05:03.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 2e-54] add_size 200000 add_align 100000
[    0.614562] pci 0000:04:00.0: bridge window [io  0x1000-0x0fff] to [bus 05-54] add_size 2000
[    0.614564] pci 0000:00:1d.0: bridge window [io  0x1000-0x0fff] to [bus 04-54] add_size 3000
[    0.614573] pci 0000:00:15.0: BAR 0 [mem 0x4404228000-0x4404228fff 64bit]: assigned
[    0.614636] pci 0000:00:15.1: BAR 0 [mem 0x4404229000-0x4404229fff 64bit]: assigned
[    0.614693] pci 0000:00:1d.0: bridge window [io  0x4000-0x6fff]: assigned
[    0.614695] pci 0000:00:1f.5: BAR 0 [mem 0x4b300000-0x4b300fff]: assigned
[    0.614707] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.614715] pci 0000:02:00.0: ROM [mem 0x4b080000-0x4b0fffff pref]: assigned
[    0.614717] pci 0000:00:01.1: PCI bridge to [bus 02]
[    0.614719] pci 0000:00:01.1:   bridge window [io  0x3000-0x3fff]
[    0.614722] pci 0000:00:01.1:   bridge window [mem 0x4a000000-0x4b0fffff]
[    0.614725] pci 0000:00:01.1:   bridge window [mem 0x4000000000-0x4401ffffff 64bit pref]
[    0.614730] pci 0000:00:1c.0: PCI bridge to [bus 03]
[    0.614740] pci 0000:00:1c.0:   bridge window [mem 0x4b100000-0x4b2fffff]
[    0.614749] pci 0000:04:00.0: bridge window [io  0x4000-0x5fff]: assigned
[    0.614752] pci 0000:05:01.0: bridge window [mem 0x4410000000-0x44101fffff 64bit pref]: assigned
[    0.614754] pci 0000:05:03.0: bridge window [mem 0x4410200000-0x44103fffff 64bit pref]: assigned
[    0.614756] pci 0000:05:01.0: bridge window [io  0x4000-0x4fff]: assigned
[    0.614757] pci 0000:05:03.0: bridge window [io  0x5000-0x5fff]: assigned
[    0.614760] pci 0000:05:00.0: PCI bridge to [bus 06]
[    0.614781] pci 0000:05:00.0:   bridge window [mem 0x5410000000-0x54100fffff 64bit pref]
[    0.614788] pci 0000:05:01.0: PCI bridge to [bus 07-2c]
[    0.614791] pci 0000:05:01.0:   bridge window [io  0x4000-0x4fff]
[    0.614797] pci 0000:05:01.0:   bridge window [mem 0x44000000-0x47efffff]
[    0.614801] pci 0000:05:01.0:   bridge window [mem 0x4410000000-0x44101fffff 64bit pref]
[    0.614808] pci 0000:05:02.0: PCI bridge to [bus 2d]
[    0.614814] pci 0000:05:02.0:   bridge window [mem 0x43f00000-0x43ffffff]
[    0.614824] pci 0000:05:03.0: PCI bridge to [bus 2e-54]
[    0.614827] pci 0000:05:03.0:   bridge window [io  0x5000-0x5fff]
[    0.614833] pci 0000:05:03.0:   bridge window [mem 0x40000000-0x43efffff]
[    0.614837] pci 0000:05:03.0:   bridge window [mem 0x4410200000-0x44103fffff 64bit pref]
[    0.614844] pci 0000:04:00.0: PCI bridge to [bus 05-54]
[    0.614847] pci 0000:04:00.0:   bridge window [io  0x4000-0x5fff]
[    0.614853] pci 0000:04:00.0:   bridge window [mem 0x40000000-0x47efffff]
[    0.614857] pci 0000:04:00.0:   bridge window [mem 0x4410000000-0x54100fffff 64bit pref]
[    0.614864] pci 0000:00:1d.0: PCI bridge to [bus 04-54]
[    0.614866] pci 0000:00:1d.0:   bridge window [io  0x4000-0x6fff]
[    0.614871] pci 0000:00:1d.0:   bridge window [mem 0x40000000-0x47ffffff]
[    0.614874] pci 0000:00:1d.0:   bridge window [mem 0x4410000000-0x54100fffff 64bit pref]
[    0.614881] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.614883] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.614884] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    0.614886] pci_bus 0000:00: resource 7 [mem 0x40000000-0xbfffffff window]
[    0.614888] pci_bus 0000:00: resource 8 [mem 0x4000000000-0x7fffffffff window]
[    0.614890] pci_bus 0000:02: resource 0 [io  0x3000-0x3fff]
[    0.614891] pci_bus 0000:02: resource 1 [mem 0x4a000000-0x4b0fffff]
[    0.614892] pci_bus 0000:02: resource 2 [mem 0x4000000000-0x4401ffffff 64bit pref]
[    0.614894] pci_bus 0000:03: resource 1 [mem 0x4b100000-0x4b2fffff]
[    0.614896] pci_bus 0000:04: resource 0 [io  0x4000-0x6fff]
[    0.614897] pci_bus 0000:04: resource 1 [mem 0x40000000-0x47ffffff]
[    0.614898] pci_bus 0000:04: resource 2 [mem 0x4410000000-0x54100fffff 64bit pref]
[    0.614900] pci_bus 0000:05: resource 0 [io  0x4000-0x5fff]
[    0.614901] pci_bus 0000:05: resource 1 [mem 0x40000000-0x47efffff]
[    0.614903] pci_bus 0000:05: resource 2 [mem 0x4410000000-0x54100fffff 64bit pref]
[    0.614904] pci_bus 0000:06: resource 2 [mem 0x5410000000-0x54100fffff 64bit pref]
[    0.614906] pci_bus 0000:07: resource 0 [io  0x4000-0x4fff]
[    0.614907] pci_bus 0000:07: resource 1 [mem 0x44000000-0x47efffff]
[    0.614909] pci_bus 0000:07: resource 2 [mem 0x4410000000-0x44101fffff 64bit pref]
[    0.614910] pci_bus 0000:2d: resource 1 [mem 0x43f00000-0x43ffffff]
[    0.614912] pci_bus 0000:2e: resource 0 [io  0x5000-0x5fff]
[    0.614913] pci_bus 0000:2e: resource 1 [mem 0x40000000-0x43efffff]
[    0.614914] pci_bus 0000:2e: resource 2 [mem 0x4410200000-0x44103fffff 64bit pref]
[    0.617124] pci 0000:02:00.1: extending delay after power-on from D3hot to 20 msec
[    0.617155] pci 0000:02:00.1: D0 power state depends on 0000:02:00.0
[    0.617680] pci 0000:2d:00.0: enabling device (0000 -> 0002)
[    0.617718] PCI: CLS 64 bytes, default 64
[    0.617765] DMAR: No RMRR found
[    0.617766] DMAR: No ATSR found
[    0.617766] DMAR: No SATC found
[    0.617768] DMAR: dmar0: Using Queued invalidation
[    0.617825] Trying to unpack rootfs image as initramfs...
[    0.617854] pci 0000:00:00.0: Adding to iommu group 0
[    0.617868] pci 0000:00:01.0: Adding to iommu group 1
[    0.617880] pci 0000:00:01.1: Adding to iommu group 2
[    0.617890] pci 0000:00:04.0: Adding to iommu group 3
[    0.617899] pci 0000:00:08.0: Adding to iommu group 4
[    0.617909] pci 0000:00:0a.0: Adding to iommu group 5
[    0.617920] pci 0000:00:0e.0: Adding to iommu group 6
[    0.617938] pci 0000:00:14.0: Adding to iommu group 7
[    0.617947] pci 0000:00:14.2: Adding to iommu group 7
[    0.617957] pci 0000:00:14.3: Adding to iommu group 8
[    0.617976] pci 0000:00:15.0: Adding to iommu group 9
[    0.617986] pci 0000:00:15.1: Adding to iommu group 9
[    0.618000] pci 0000:00:16.0: Adding to iommu group 10
[    0.618019] pci 0000:00:1c.0: Adding to iommu group 11
[    0.618033] pci 0000:00:1d.0: Adding to iommu group 12
[    0.618060] pci 0000:00:1f.0: Adding to iommu group 13
[    0.618070] pci 0000:00:1f.3: Adding to iommu group 13
[    0.618080] pci 0000:00:1f.4: Adding to iommu group 13
[    0.618090] pci 0000:00:1f.5: Adding to iommu group 13
[    0.618110] pci 0000:02:00.0: Adding to iommu group 14
[    0.618125] pci 0000:02:00.1: Adding to iommu group 14
[    0.618143] pci 0000:03:00.0: Adding to iommu group 15
[    0.618161] pci 0000:04:00.0: Adding to iommu group 16
[    0.618173] pci 0000:05:00.0: Adding to iommu group 17
[    0.618198] pci 0000:05:01.0: Adding to iommu group 18
[    0.618217] pci 0000:05:02.0: Adding to iommu group 19
[    0.618229] pci 0000:05:03.0: Adding to iommu group 20
[    0.618253] pci 0000:06:00.0: Adding to iommu group 21
[    0.618276] pci 0000:2d:00.0: Adding to iommu group 22
[    0.623571] DMAR: Intel(R) Virtualization Technology for Directed I/O
[    0.623574] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.623575] software IO TLB: mapped [mem 0x0000000025ec9000-0x0000000029ec9000] (64MB)
[    0.625995] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x22df1149949, max_idle_ns: 440795312789 ns
[    0.626047] clocksource: Switched to clocksource tsc
[    0.627320] Initialise system trusted keyrings
[    0.627331] Key type blacklist registered
[    0.627399] workingset: timestamp_bits=36 max_order=23 bucket_order=0
[    0.627409] zbud: loaded
[    0.627749] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.627872] fuse: init (API version 7.40)
[    0.628078] integrity: Platform Keyring initialized
[    0.628083] integrity: Machine keyring initialized
[    0.641860] Key type asymmetric registered
[    0.641862] Asymmetric key parser 'x509' registered
[    0.641896] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 243)
[    0.641980] io scheduler mq-deadline registered
[    0.642713] pcieport 0000:00:01.0: PME: Signaling with IRQ 121
[    0.643017] pcieport 0000:00:01.1: PME: Signaling with IRQ 122
[    0.643345] pcieport 0000:00:1c.0: PME: Signaling with IRQ 123
[    0.643459] pcieport 0000:00:1c.0: AER: enabled with IRQ 123
[    0.643654] pcieport 0000:00:1d.0: PME: Signaling with IRQ 124
[    0.643733] pcieport 0000:00:1d.0: AER: enabled with IRQ 124
[    0.643761] pcieport 0000:00:1d.0: pciehp: Slot #8 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
[    0.644705] pcieport 0000:05:01.0: pciehp: Slot #1 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
[    0.645356] pcieport 0000:05:03.0: pciehp: Slot #3 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
[    0.645582] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    0.645969] Monitor-Mwait will be used to enter C-1 state
[    0.645988] Monitor-Mwait will be used to enter C-2 state
[    0.645999] Monitor-Mwait will be used to enter C-3 state
[    0.646005] ACPI: \_SB_.PR00: Found 3 idle states
[    0.649161] ACPI: AC: AC Adapter [AC] (on-line)
[    0.649250] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    0.649326] ACPI: button: Power Button [PWRB]
[    0.649360] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input1
[    0.649395] ACPI: button: Sleep Button [SLPB]
[    0.649429] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input2
[    0.649463] ACPI: button: Lid Switch [LID0]
[    0.649497] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
[    0.649540] ACPI: button: Power Button [PWRF]
[    0.735940] thermal LNXTHERM:00: registered as thermal_zone0
[    0.735943] ACPI: thermal: Thermal Zone [TZ0] (25 C)
[    0.736287] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    0.736998] ACPI: battery: Slot [BAT0] (battery present)
[    0.738678] hpet_acpi_add: no address or irqs in _CRS
[    0.738719] Linux agpgart interface v0.103
[    0.740425] tpm_tis IFX1523:00: 2.0 TPM (device-id 0x1D, rev-id 54)
[    0.766188] Freeing initrd memory: 74848K
[    0.856055] ACPI: bus type drm_connector registered
[    0.863903] loop: module loaded
[    0.864403] tun: Universal TUN/TAP device driver, 1.6
[    0.864534] PPP generic driver version 2.4.2
[    0.864696] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[    0.870749] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.870757] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.870989] mousedev: PS/2 mouse device common for all mice
[    0.871151] rtc_cmos 00:01: RTC can wake from S4
[    0.871995] rtc_cmos 00:01: registered as rtc0
[    0.872167] rtc_cmos 00:01: setting system clock to 2024-11-01T17:25:26 UTC (1730481926)
[    0.872211] rtc_cmos 00:01: alarms up to one month, y3k, 242 bytes nvram
[    0.872219] i2c_dev: i2c /dev entries driver
[    0.872661] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input4
[    0.874255] device-mapper: core: CONFIG_IMA_DISABLE_HTABLE is disabled. Duplicate IMA measurements will not be recorded in the IMA log.
[    0.874272] device-mapper: uevent: version 1.0.3
[    0.874315] device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) initialised: dm-devel@lists.linux.dev
[    0.874332] platform eisa.0: Probing EISA bus 0
[    0.874333] platform eisa.0: EISA: Cannot allocate resource for mainboard
[    0.874335] platform eisa.0: Cannot allocate resource for EISA slot 1
[    0.874336] platform eisa.0: Cannot allocate resource for EISA slot 2
[    0.874337] platform eisa.0: Cannot allocate resource for EISA slot 3
[    0.874338] platform eisa.0: Cannot allocate resource for EISA slot 4
[    0.874339] platform eisa.0: Cannot allocate resource for EISA slot 5
[    0.874340] platform eisa.0: Cannot allocate resource for EISA slot 6
[    0.874340] platform eisa.0: Cannot allocate resource for EISA slot 7
[    0.874341] platform eisa.0: Cannot allocate resource for EISA slot 8
[    0.874342] platform eisa.0: EISA: Detected 0 cards
[    0.874346] intel_pstate: Intel P-state driver initializing
[    0.878014] intel_pstate: HWP enabled
[    0.880777] ledtrig-cpu: registered to indicate activity on CPUs
[    0.880974] [drm] Initialized simpledrm 1.0.0 for simple-framebuffer.0 on minor 0
[    0.885206] fbcon: Deferring console take-over
[    0.885209] simple-framebuffer simple-framebuffer.0: [drm] fb0: simpledrmdrmfb frame buffer device
[    0.887040] drop_monitor: Initializing network drop monitor service
[    0.887194] NET: Registered PF_INET6 protocol family
[    0.894065] Segment Routing with IPv6
[    0.894084] In-situ OAM (IOAM) with IPv6
[    0.894129] NET: Registered PF_PACKET protocol family
[    0.894169] Key type dns_resolver registered
[    0.898470] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.900368] microcode: Current revision: 0x00000129
[    0.902094] IPI shorthand broadcast: enabled
[    0.904260] sched_clock: Marking stable (897001390, 7231455)->(973542124, -69309279)
[    0.904843] registered taskstats version 1
[    0.908617] Loading compiled-in X.509 certificates
[    0.909394] Loaded X.509 cert 'Build time autogenerated kernel key: c84cfb4445ce6cac0f85ce5a38eaad0b7990afa9'
[    0.913507] Demotion targets for Node 0: null
[    0.913638] Key type .fscrypt registered
[    0.913640] Key type fscrypt-provisioning registered
[    0.913698] Key type trusted registered
[    0.919566] cryptd: module verification failed: signature and/or required key missing - tainting kernel
[    0.920466] cryptd: max_cpu_qlen set to 1000
[    0.922228] AES CTR mode by8 optimization enabled
[    0.933940] Key type encrypted registered
[    0.933944] AppArmor: AppArmor sha256 policy hashing enabled
[    0.938671] integrity: Loading X.509 certificate: UEFI:db
[    0.938701] integrity: Loaded X.509 cert 'Microsoft Windows Production PCA 2011: a92902398e16c49778cd90f99e4f9ae17c55af53'
[    0.938702] integrity: Loading X.509 certificate: UEFI:db
[    0.938718] integrity: Loaded X.509 cert 'Microsoft Corporation: Windows UEFI CA 2023: aefc5fbbbe055d8f8daa585473499417ab5a5272'
[    0.938719] integrity: Loading X.509 certificate: UEFI:db
[    0.938735] integrity: Loaded X.509 cert 'Microsoft Corporation UEFI CA 2011: 13adbf4309bd82709c8cd54f316ed522988a1bd4'
[    0.938736] integrity: Loading X.509 certificate: UEFI:db
[    0.938750] integrity: Loaded X.509 cert 'Microsoft UEFI CA 2023: 81aa6b3244c935bce0d6628af39827421e32497d'
[    0.938750] integrity: Loading X.509 certificate: UEFI:db
[    0.939051] integrity: Loaded X.509 cert 'Secure Certificate: 01dcc89619884ca147983429f8a4a1a0'
[    0.939052] integrity: Loading X.509 certificate: UEFI:db
[    0.939201] integrity: Loaded X.509 cert 'Cus CA: d6136d376b87ef934511c12ce2c3880c'
[    0.946389] Loading compiled-in module X.509 certificates
[    0.946824] Loaded X.509 cert 'Build time autogenerated kernel key: c84cfb4445ce6cac0f85ce5a38eaad0b7990afa9'
[    0.946827] ima: Allocated hash algorithm: sha256
[    1.088698] ima: No architecture policies found
[    1.088745] evm: Initialising EVM extended attributes:
[    1.088749] evm: security.selinux
[    1.088752] evm: security.SMACK64
[    1.088754] evm: security.SMACK64EXEC
[    1.088757] evm: security.SMACK64TRANSMUTE
[    1.088759] evm: security.SMACK64MMAP
[    1.088761] evm: security.apparmor
[    1.088763] evm: security.ima
[    1.088765] evm: security.capability
[    1.088767] evm: HMAC attrs: 0x1
[    1.089525] PM:   Magic number: 0:284:440
[    1.089590] clockevents broadcast: hash matches
[    1.089649] acpi INT3519:00: hash matches
[    1.096898] RAS: Correctable Errors collector initialized.
[    1.109180] clk: Disabling unused clocks
[    1.109182] PM: genpd: Disabling unused power domains
[    1.115064] Freeing unused decrypted memory: 2028K
[    1.116040] Freeing unused kernel image (initmem) memory: 4996K
[    1.116056] Write protecting the kernel read-only data: 36864k
[    1.116982] Freeing unused kernel image (rodata/data gap) memory: 544K
[    1.124237] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    1.124240] Run /init as init process
[    1.124241]   with arguments:
[    1.124242]     /init
[    1.124243]     splash
[    1.124243]   with environment:
[    1.124244]     HOME=/
[    1.124245]     TERM=linux
[    1.124245]     BOOT_IMAGE=/@boot/vmlinuz-6.11.5
[    1.124246]     cryptdevice=UUID=1a8d8cdb-8d8f-4689-b744-8f32d2067f56:luks-1a8d8cdb-8d8f-4689-b744-8f32d2067f56
[    1.224644] hid: raw HID events driver (C) Jiri Kosina
[    1.225881] wmi_bus wmi_bus-PNP0C14:01: [Firmware Bug]: WQ00 data block query control method not found
[    1.226759] ACPI: video: [Firmware Bug]: ACPI(PEGP) defines _DOD but not _DOS
[    1.226789] ACPI: video: Video Device [PEGP] (multi-head: yes  rom: no  post: no)
[    1.228848] vmd 0000:00:0e.0: PCI host bridge to bus 10000:e0
[    1.228852] pci_bus 10000:e0: root bus resource [bus e0-ff]
[    1.228853] pci_bus 10000:e0: root bus resource [mem 0x48000000-0x49ffffff]
[    1.228854] pci_bus 10000:e0: root bus resource [mem 0x4404102000-0x44041fffff 64bit]
[    1.228880] pci 10000:e0:1b.0: [8086:09ab] type 00 class 0x088000 conventional PCI endpoint
[    1.229134] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    1.229143] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
[    1.229177] pci 10000:e0:1b.0: Adding to iommu group 6
[    1.229235] pci 10000:e0:1b.4: [8086:7a44] type 01 class 0x060400 PCIe Root Port
[    1.229275] pci 10000:e0:1b.4: PCI bridge to [bus e1]
[    1.229284] pci 10000:e0:1b.4:   bridge window [io  0x0000-0x0fff]
[    1.229287] pci 10000:e0:1b.4:   bridge window [mem 0x48000000-0x480fffff]
[    1.229382] pci 10000:e0:1b.4: PME# supported from D0 D3hot D3cold
[    1.229429] pci 10000:e0:1b.4: PTM enabled (root), 4ns granularity
[    1.229580] Intel(R) 2.5G Ethernet Linux Driver
[    1.229582] Copyright(c) 2018 Intel Corporation.
[    1.229713] pci 10000:e0:1b.4: Adding to iommu group 6
[    1.229732] pci 10000:e0:1b.4: Primary bus is hard wired to 0
[    1.229800] igc 0000:03:00.0: PTM enabled, 4ns granularity
[    1.229873] pci 10000:e1:00.0: [144d:a808] type 00 class 0x010802 PCIe Endpoint
[    1.229904] pci 10000:e1:00.0: BAR 0 [mem 0x48000000-0x48003fff 64bit]
[    1.230349] xhci_hcd 0000:00:14.0: hcc params 0x20007fc1 hci version 0x120 quirks 0x0000000200009810
[    1.230373] pci 10000:e1:00.0: Adding to iommu group 6
[    1.230394] pci 10000:e0:1b.4: PCI bridge to [bus e1]
[    1.230406] pci 10000:e0:1b.4: Primary bus is hard wired to 0
[    1.230855] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    1.230858] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
[    1.230863] xhci_hcd 0000:00:14.0: Host supports USB 3.2 Enhanced SuperSpeed
[    1.230965] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.11
[    1.230969] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.230971] usb usb1: Product: xHCI Host Controller
[    1.230972] usb usb1: Manufacturer: Linux 6.11.5 xhci-hcd
[    1.230974] usb usb1: SerialNumber: 0000:00:14.0
[    1.231188] hub 1-0:1.0: USB hub found
[    1.231219] hub 1-0:1.0: 16 ports detected
[    1.237516] ACPI: bus type thunderbolt registered
[    1.237646] thunderbolt 0000:06:00.0: total paths: 12
[    1.237652] thunderbolt 0000:06:00.0: IOMMU DMA protection is enabled
[    1.241280] intel-lpss 0000:00:15.0: enabling device (0004 -> 0006)
[    1.241581] idma64 idma64.0: Found Intel integrated DMA 64-bit
[    1.265881] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:05/LNXVIDEO:00/input/input7
[    1.281781] pps pps0: new PPS source ptp0
[    1.281824] igc 0000:03:00.0 (unnamed net_device) (uninitialized): PHC added
[    1.310751] igc 0000:03:00.0: 4.000 Gb/s available PCIe bandwidth (5.0 GT/s PCIe x1 link)
[    1.310758] igc 0000:03:00.0 eth0: MAC: d4:93:90:44:67:64
[    1.312891] igc 0000:03:00.0 enp3s0: renamed from eth0
[    1.314074] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.11
[    1.314080] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.314082] usb usb2: Product: xHCI Host Controller
[    1.314084] usb usb2: Manufacturer: Linux 6.11.5 xhci-hcd
[    1.314086] usb usb2: SerialNumber: 0000:00:14.0
[    1.314412] hub 2-0:1.0: USB hub found
[    1.314467] hub 2-0:1.0: 10 ports detected
[    1.318416] xhci_hcd 0000:2d:00.0: xHCI Host Controller
[    1.318426] xhci_hcd 0000:2d:00.0: new USB bus registered, assigned bus number 3
[    1.319681] xhci_hcd 0000:2d:00.0: hcc params 0x20007fc1 hci version 0x120 quirks 0x0000000200009810
[    1.320183] xhci_hcd 0000:2d:00.0: xHCI Host Controller
[    1.320187] xhci_hcd 0000:2d:00.0: new USB bus registered, assigned bus number 4
[    1.320190] xhci_hcd 0000:2d:00.0: Host supports USB 3.2 Enhanced SuperSpeed
[    1.320751] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.11
[    1.320757] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.320759] usb usb3: Product: xHCI Host Controller
[    1.320761] usb usb3: Manufacturer: Linux 6.11.5 xhci-hcd
[    1.320763] usb usb3: SerialNumber: 0000:2d:00.0
[    1.320929] hub 3-0:1.0: USB hub found
[    1.320951] hub 3-0:1.0: 2 ports detected
[    1.341343] thunderbolt 0000:06:00.0: host router reset successful
[    1.342047] thunderbolt 0000:06:00.0: allocating TX ring 0 of size 10
[    1.342118] thunderbolt 0000:06:00.0: allocating RX ring 0 of size 10
[    1.342162] thunderbolt 0000:06:00.0: control channel created
[    1.342168] thunderbolt 0000:06:00.0: using software connection manager
[    1.342716] thunderbolt 0000:06:00.0: device links to tunneled native ports are missing!
[    1.342719] thunderbolt 0000:06:00.0: NHI initialized, starting thunderbolt
[    1.342722] thunderbolt 0000:06:00.0: control channel starting...
[    1.342725] thunderbolt 0000:06:00.0: starting TX ring 0
[    1.342740] thunderbolt 0000:06:00.0: enabling interrupt at register 0x38200 bit 0 (0x0 -> 0x1)
[    1.342747] thunderbolt 0000:06:00.0: starting RX ring 0
[    1.342756] thunderbolt 0000:06:00.0: enabling interrupt at register 0x38200 bit 12 (0x1 -> 0x1001)
[    1.342765] thunderbolt 0000:06:00.0: security level set to user
[    1.342991] thunderbolt 0000:06:00.0: current switch config:
[    1.342994] thunderbolt 0000:06:00.0:  USB4 Switch: 8087:5781 (Revision: 131, TB Version: 64)
[    1.343000] thunderbolt 0000:06:00.0:   Max Port Number: 23
[    1.343003] thunderbolt 0000:06:00.0:   Config:
[    1.343005] thunderbolt 0000:06:00.0:    Upstream Port Number: 15 Depth: 0 Route String: 0x0 Enabled: 0, PlugEventsDelay: 10ms
[    1.343011] thunderbolt 0000:06:00.0:    unknown1: 0x0 unknown4: 0x0
[    1.346115] thunderbolt 0000:06:00.0: initializing Switch at 0x0 (depth: 0, up port: 15)
[    1.346487] thunderbolt 0000:06:00.0: acking hot plug event on 0:13
[    1.346613] thunderbolt 0000:06:00.0: acking hot plug event on 0:14
[    1.346741] thunderbolt 0000:06:00.0: acking hot plug event on 0:16
[    1.347270] thunderbolt 0000:06:00.0: 0: credit allocation parameters:
[    1.347275] thunderbolt 0000:06:00.0: 0:  USB3: 20
[    1.347277] thunderbolt 0000:06:00.0: 0:  DP AUX: 1
[    1.347280] thunderbolt 0000:06:00.0: 0:  DP main: 6
[    1.347282] thunderbolt 0000:06:00.0: 0:  PCIe: 80
[    1.347284] thunderbolt 0000:06:00.0: 0:  DMA: 40
[    1.349693] thunderbolt 0000:06:00.0: 0: DROM version: 3
[    1.349697] thunderbolt 0000:06:00.0: 0: DROM data CRC32 mismatch (expected: 0x56000000, got: 0x56473b0f), continuing
[    1.350337] thunderbolt 0000:06:00.0: 0: running tb_retimer_remove_all [thunderbolt]
[    1.350374] thunderbolt 0000:06:00.0: 0: running tb_retimer_remove_all [thunderbolt]
[    1.350387] thunderbolt 0000:06:00.0: 0: preventing runtime PM in DP redrive mode
[    1.350390] thunderbolt 0000:06:00.0: 0: uid: 0xb93e650000006ecd
[    1.351620] thunderbolt 0000:06:00.0:  Port 1: 0:5780 (Revision: 0, TB Version: 1, Type: Port (0x1))
[    1.351625] thunderbolt 0000:06:00.0:   Max hop id (in/out): 31/31
[    1.351628] thunderbolt 0000:06:00.0:   Max counters: 4
[    1.351630] thunderbolt 0000:06:00.0:   NFC Credits: 0x8a000000
[    1.351632] thunderbolt 0000:06:00.0:   Credits (total/control): 160/2
[    1.352764] thunderbolt 0000:06:00.0:  Port 2: 0:5780 (Revision: 0, TB Version: 1, Type: Port (0x1))
[    1.352768] thunderbolt 0000:06:00.0:   Max hop id (in/out): 31/31
[    1.352771] thunderbolt 0000:06:00.0:   Max counters: 0
[    1.352773] thunderbolt 0000:06:00.0:   NFC Credits: 0xa000000
[    1.352775] thunderbolt 0000:06:00.0:   Credits (total/control): 160/2
[    1.354040] thunderbolt 0000:06:00.0:  Port 3: 0:5780 (Revision: 0, TB Version: 1, Type: Port (0x1))
[    1.354047] thunderbolt 0000:06:00.0:   Max hop id (in/out): 31/31
[    1.354052] thunderbolt 0000:06:00.0:   Max counters: 4
[    1.354057] thunderbolt 0000:06:00.0:   NFC Credits: 0x8a000000
[    1.354061] thunderbolt 0000:06:00.0:   Credits (total/control): 160/2
[    1.355196] thunderbolt 0000:06:00.0:  Port 4: 0:5780 (Revision: 0, TB Version: 1, Type: Port (0x1))
[    1.355200] thunderbolt 0000:06:00.0:   Max hop id (in/out): 31/31
[    1.355203] thunderbolt 0000:06:00.0:   Max counters: 0
[    1.355205] thunderbolt 0000:06:00.0:   NFC Credits: 0xa000000
[    1.355210] thunderbolt 0000:06:00.0:   Credits (total/control): 160/2
[    1.356476] thunderbolt 0000:06:00.0:  Port 5: 0:5780 (Revision: 0, TB Version: 1, Type: Inactive (0x0))
[    1.356481] thunderbolt 0000:06:00.0:   Max hop id (in/out): 31/31
[    1.356483] thunderbolt 0000:06:00.0:   Max counters: 4
[    1.356485] thunderbolt 0000:06:00.0:   NFC Credits: 0x8a000000
[    1.356488] thunderbolt 0000:06:00.0:   Credits (total/control): 160/0
[    1.357248] thunderbolt 0000:06:00.0:  Port 6: 0:5780 (Revision: 0, TB Version: 1, Type: Inactive (0x0))
[    1.357252] thunderbolt 0000:06:00.0:   Max hop id (in/out): 31/31
[    1.357255] thunderbolt 0000:06:00.0:   Max counters: 0
[    1.357257] thunderbolt 0000:06:00.0:   NFC Credits: 0xa000000
[    1.357260] thunderbolt 0000:06:00.0:   Credits (total/control): 160/0
[    1.358527] thunderbolt 0000:06:00.0:  Port 7: 0:5780 (Revision: 0, TB Version: 1, Type: Inactive (0x0))
[    1.358531] thunderbolt 0000:06:00.0:   Max hop id (in/out): 31/31
[    1.358533] thunderbolt 0000:06:00.0:   Max counters: 4
[    1.358536] thunderbolt 0000:06:00.0:   NFC Credits: 0x8a000000
[    1.358538] thunderbolt 0000:06:00.0:   Credits (total/control): 160/0
[    1.359295] thunderbolt 0000:06:00.0:  Port 8: 0:5780 (Revision: 0, TB Version: 1, Type: Inactive (0x0))
[    1.359299] thunderbolt 0000:06:00.0:   Max hop id (in/out): 31/31
[    1.359302] thunderbolt 0000:06:00.0:   Max counters: 0
[    1.359304] thunderbolt 0000:06:00.0:   NFC Credits: 0xa000000
[    1.359306] thunderbolt 0000:06:00.0:   Credits (total/control): 160/0
[    1.359549] thunderbolt 0000:06:00.0:  Port 9: 0:5780 (Revision: 0, TB Version: 1, Type: PCIe (0x100101))
[    1.359554] thunderbolt 0000:06:00.0:   Max hop id (in/out): 8/8
[    1.359557] thunderbolt 0000:06:00.0:   Max counters: 2
[    1.359559] thunderbolt 0000:06:00.0:   NFC Credits: 0x40800000
[    1.359562] thunderbolt 0000:06:00.0:   Credits (total/control): 8/0
[    1.359805] thunderbolt 0000:06:00.0:  Port 10: 0:5780 (Revision: 0, TB Version: 1, Type: PCIe (0x100101))
[    1.359810] thunderbolt 0000:06:00.0:   Max hop id (in/out): 8/8
[    1.359813] thunderbolt 0000:06:00.0:   Max counters: 2
[    1.359815] thunderbolt 0000:06:00.0:   NFC Credits: 0x40800000
[    1.359817] thunderbolt 0000:06:00.0:   Credits (total/control): 8/0
[    1.360319] thunderbolt 0000:06:00.0:  Port 11: 0:5780 (Revision: 0, TB Version: 1, Type: DP/HDMI (0xe0102))
[    1.360324] thunderbolt 0000:06:00.0:   Max hop id (in/out): 9/9
[    1.360326] thunderbolt 0000:06:00.0:   Max counters: 2
[    1.360329] thunderbolt 0000:06:00.0:   NFC Credits: 0x800000
[    1.360331] thunderbolt 0000:06:00.0:   Credits (total/control): 8/0
[    1.360827] thunderbolt 0000:06:00.0:  Port 12: 0:5780 (Revision: 0, TB Version: 1, Type: DP/HDMI (0xe0102))
[    1.360832] thunderbolt 0000:06:00.0:   Max hop id (in/out): 9/9
[    1.360835] thunderbolt 0000:06:00.0:   Max counters: 2
[    1.360837] thunderbolt 0000:06:00.0:   NFC Credits: 0x800000
[    1.360839] thunderbolt 0000:06:00.0:   Credits (total/control): 8/0
[    1.361085] thunderbolt 0000:06:00.0:  Port 13: 0:5780 (Revision: 0, TB Version: 1, Type: DP/HDMI (0xe0101))
[    1.361089] thunderbolt 0000:06:00.0:   Max hop id (in/out): 9/9
[    1.361091] thunderbolt 0000:06:00.0:   Max counters: 2
[    1.361094] thunderbolt 0000:06:00.0:   NFC Credits: 0x100000d
[    1.361096] thunderbolt 0000:06:00.0:   Credits (total/control): 16/0
[    1.361344] thunderbolt 0000:06:00.0:  Port 14: 0:5780 (Revision: 0, TB Version: 1, Type: DP/HDMI (0xe0101))
[    1.361348] thunderbolt 0000:06:00.0:   Max hop id (in/out): 9/9
[    1.361351] thunderbolt 0000:06:00.0:   Max counters: 2
[    1.361353] thunderbolt 0000:06:00.0:   NFC Credits: 0x100000d
[    1.361355] thunderbolt 0000:06:00.0:   Credits (total/control): 16/0
[    1.362108] thunderbolt 0000:06:00.0:  Port 15: 0:5780 (Revision: 0, TB Version: 1, Type: NHI (0x2))
[    1.362113] thunderbolt 0000:06:00.0:   Max hop id (in/out): 11/11
[    1.362116] thunderbolt 0000:06:00.0:   Max counters: 4
[    1.362118] thunderbolt 0000:06:00.0:   NFC Credits: 0x41c00000
[    1.362121] thunderbolt 0000:06:00.0:   Credits (total/control): 28/0
[    1.362124] thunderbolt 0000:06:00.0: 0:16: disabled by eeprom
[    1.362366] thunderbolt 0000:06:00.0:  Port 17: 0:5780 (Revision: 0, TB Version: 1, Type: Inactive (0x0))
[    1.362370] thunderbolt 0000:06:00.0:   Max hop id (in/out): 8/8
[    1.362373] thunderbolt 0000:06:00.0:   Max counters: 2
[    1.362375] thunderbolt 0000:06:00.0:   NFC Credits: 0x40800000
[    1.362377] thunderbolt 0000:06:00.0:   Credits (total/control): 8/0
[    1.362623] thunderbolt 0000:06:00.0:  Port 18: 0:5780 (Revision: 0, TB Version: 1, Type: Inactive (0x0))
[    1.362627] thunderbolt 0000:06:00.0:   Max hop id (in/out): 8/8
[    1.362629] thunderbolt 0000:06:00.0:   Max counters: 2
[    1.362632] thunderbolt 0000:06:00.0:   NFC Credits: 0x40800000
[    1.362634] thunderbolt 0000:06:00.0:   Credits (total/control): 8/0
[    1.363132] thunderbolt 0000:06:00.0:  Port 19: 0:5780 (Revision: 0, TB Version: 1, Type: DP/HDMI (0xe0102))
[    1.363137] thunderbolt 0000:06:00.0:   Max hop id (in/out): 9/9
[    1.363139] thunderbolt 0000:06:00.0:   Max counters: 2
[    1.363142] thunderbolt 0000:06:00.0:   NFC Credits: 0x800000
[    1.363144] thunderbolt 0000:06:00.0:   Credits (total/control): 8/0
[    1.363389] thunderbolt 0000:06:00.0:  Port 20: 0:5780 (Revision: 0, TB Version: 1, Type: Inactive (0x0))
[    1.363393] thunderbolt 0000:06:00.0:   Max hop id (in/out): 8/8
[    1.363396] thunderbolt 0000:06:00.0:   Max counters: 1
[    1.363398] thunderbolt 0000:06:00.0:   NFC Credits: 0x800000
[    1.363401] thunderbolt 0000:06:00.0:   Credits (total/control): 8/0
[    1.363646] thunderbolt 0000:06:00.0:  Port 21: 0:5780 (Revision: 0, TB Version: 1, Type: USB (0x200101))
[    1.363650] thunderbolt 0000:06:00.0:   Max hop id (in/out): 8/8
[    1.363653] thunderbolt 0000:06:00.0:   Max counters: 1
[    1.363655] thunderbolt 0000:06:00.0:   NFC Credits: 0x800000
[    1.363658] thunderbolt 0000:06:00.0:   Credits (total/control): 8/0
[    1.363902] thunderbolt 0000:06:00.0:  Port 22: 0:5780 (Revision: 0, TB Version: 1, Type: USB (0x200101))
[    1.363906] thunderbolt 0000:06:00.0:   Max hop id (in/out): 8/8
[    1.363909] thunderbolt 0000:06:00.0:   Max counters: 1
[    1.363911] thunderbolt 0000:06:00.0:   NFC Credits: 0x800000
[    1.363913] thunderbolt 0000:06:00.0:   Credits (total/control): 8/0
[    1.364160] thunderbolt 0000:06:00.0:  Port 23: 0:5780 (Revision: 0, TB Version: 1, Type: Inactive (0x0))
[    1.364164] thunderbolt 0000:06:00.0:   Max hop id (in/out): 8/8
[    1.364166] thunderbolt 0000:06:00.0:   Max counters: 1
[    1.364169] thunderbolt 0000:06:00.0:   NFC Credits: 0x800000
[    1.364171] thunderbolt 0000:06:00.0:   Credits (total/control): 8/0
[    1.364175] thunderbolt 0000:06:00.0: 0: running tb_retimer_remove_all [thunderbolt]
[    1.364196] thunderbolt 0000:06:00.0: 0:16: re-enabling adapter
[    1.364199] thunderbolt 0000:06:00.0: 0: linked ports 1 <-> 2
[    1.364202] thunderbolt 0000:06:00.0: 0: linked ports 3 <-> 4
[    1.372470] thunderbolt 0000:06:00.0: 0: TMU: supports uni-directional mode
[    1.372473] thunderbolt 0000:06:00.0: 0: TMU: supports enhanced uni-directional mode
[    1.372597] thunderbolt 0000:06:00.0: 0: TMU: current mode: off
[    1.376612] thunderbolt 0000:06:00.0: 0: NVM version 14.86
[    1.376771] thunderbolt 0000:06:00.0: 0: TMU: mode change off -> uni-directional, LowRes requested
[    1.377199] thunderbolt 0000:06:00.0: 0: TMU: mode set to: uni-directional, LowRes
[    1.378095] thunderbolt 0000:06:00.0: 0:13: DP IN resource available
[    1.378731] thunderbolt 0000:06:00.0: 0:14: DP IN resource available
[    1.396483] pci 10000:e0:1b.4: bridge window [mem 0x48000000-0x480fffff]: assigned
[    1.396492] pci 10000:e0:1b.4: bridge window [io  size 0x1000]: can't assign; no space
[    1.396496] pci 10000:e0:1b.4: bridge window [io  size 0x1000]: failed to assign
[    1.396501] pci 10000:e1:00.0: BAR 0 [mem 0x48000000-0x48003fff 64bit]: assigned
[    1.396527] pci 10000:e0:1b.4: PCI bridge to [bus e1]
[    1.396535] pci 10000:e0:1b.4:   bridge window [mem 0x48000000-0x480fffff]
[    1.396648] pcieport 10000:e0:1b.4: can't derive routing for PCI INT A
[    1.396652] pcieport 10000:e0:1b.4: PCI INT A: no GSI
[    1.396815] pcieport 10000:e0:1b.4: PME: Signaling with IRQ 185
[    1.397106] pcieport 10000:e0:1b.4: AER: enabled with IRQ 185
[    1.397260] vmd 0000:00:0e.0: Bound to PCI domain 10000
[    1.406976] nvme nvme0: pci function 10000:e1:00.0
[    1.406996] pcieport 10000:e0:1b.4: can't derive routing for PCI INT A
[    1.406999] nvme 10000:e1:00.0: PCI INT A: not connected
[    1.408670] nvme nvme0: missing or invalid SUBNQN field.
[    1.408845] nvme nvme0: D3 entry latency set to 8 seconds
[    1.422459] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.11
[    1.422467] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.422470] usb usb4: Product: xHCI Host Controller
[    1.422473] usb usb4: Manufacturer: Linux 6.11.5 xhci-hcd
[    1.422474] usb usb4: SerialNumber: 0000:2d:00.0
[    1.422664] hub 4-0:1.0: USB hub found
[    1.422698] hub 4-0:1.0: 2 ports detected
[    1.429090] nvme nvme0: 18/0/0 default/read/poll queues
[    1.437987]  nvme0n1: p1 p2 p3
[    1.464263] intel-lpss 0000:00:15.1: enabling device (0004 -> 0006)
[    1.465322] idma64 idma64.1: Found Intel integrated DMA 64-bit
[    1.550519] usb 1-6: new high-speed USB device number 2 using xhci_hcd
[    1.710389] usb 1-6: New USB device found, idVendor=04f2, idProduct=b7e7, bcdDevice= 0.04
[    1.710406] usb 1-6: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    1.710412] usb 1-6: Product: Chicony USB2.0 Camera
[    1.710417] usb 1-6: Manufacturer: SunplusIT Inc
[    1.710421] usb 1-6: SerialNumber: 01.00.00
[    1.812001] input: FTCS1000:01 2808:0102 Mouse as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-0/i2c-FTCS1000:01/0018:2808:0102.0001/input/input8
[    1.812376] input: FTCS1000:01 2808:0102 Touchpad as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-0/i2c-FTCS1000:01/0018:2808:0102.0001/input/input9
[    1.812922] hid-generic 0018:2808:0102.0001: input,hidraw0: I2C HID v1.00 Mouse [FTCS1000:01 2808:0102] on i2c-FTCS1000:01
[    1.843479] usb 1-7: new full-speed USB device number 3 using xhci_hcd
[    1.870383] input: FTCS1000:01 2808:0102 Mouse as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-0/i2c-FTCS1000:01/0018:2808:0102.0001/input/input11
[    1.870958] input: FTCS1000:01 2808:0102 Touchpad as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-0/i2c-FTCS1000:01/0018:2808:0102.0001/input/input12
[    1.871192] hid-multitouch 0018:2808:0102.0001: input,hidraw0: I2C HID v1.00 Mouse [FTCS1000:01 2808:0102] on i2c-FTCS1000:01
[    1.974918] usb 1-7: New USB device found, idVendor=048d, idProduct=8910, bcdDevice= 0.01
[    1.974936] usb 1-7: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    1.974942] usb 1-7: Product: ITE Device(829x)
[    1.974946] usb 1-7: Manufacturer: ITE Tech. Inc.
[    2.091463] usb 1-14: new full-speed USB device number 4 using xhci_hcd
[    2.220713] usb 1-14: New USB device found, idVendor=8087, idProduct=0033, bcdDevice= 0.00
[    2.220730] usb 1-14: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    2.235787] hid-generic 0003:048D:8910.0002: hiddev0,hidraw1: USB HID v1.10 Device [ITE Tech. Inc. ITE Device(829x)] on usb-0000:00:14.0-7/input0
[    2.235831] usbcore: registered new interface driver usbhid
[    2.235833] usbhid: USB HID core driver
[    2.723950] input: ImPS/2 Generic Wheel Mouse as /devices/platform/i8042/serio1/input/input6
[    6.835700] ucsi_acpi USBC000:00: error -ETIMEDOUT: PPM init failed
[    9.824234] raid6: avx2x4   gen() 35520 MB/s
[    9.841322] raid6: avx2x2   gen() 21517 MB/s
[    9.858348] raid6: avx2x1   gen() 28886 MB/s
[    9.858350] raid6: using algorithm avx2x4 gen() 35520 MB/s
[    9.875353] raid6: .... xor() 7067 MB/s, rmw enabled
[    9.875354] raid6: using avx2x2 recovery algorithm
[    9.876878] xor: automatically using best checksumming function   avx       
[    9.924113] Btrfs loaded, zoned=yes, fsverity=yes
[    9.960573] BTRFS: device label kfocus_2404 devid 1 transid 9312 /dev/mapper/luks-1a8d8cdb-8d8f-4689-b744-8f32d2067f56 (252:0) scanned by mount (751)
[    9.961714] BTRFS info (device dm-0): first mount of filesystem aa8cb093-9cb3-4cc7-b44e-4bff76ca37fb
[    9.961764] BTRFS info (device dm-0): using crc32c (crc32c-intel) checksum algorithm
[    9.961776] BTRFS info (device dm-0): using free-space-tree
[   10.157353] systemd[1]: Inserted module 'autofs4'
[   10.377451] systemd[1]: systemd 255.4-1ubuntu8.4 running in system mode (+PAM +AUDIT +SELINUX +APPARMOR +IMA +SMACK +SECCOMP +GCRYPT -GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP +LIBFDISK +PCRE2 -PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD -BPF_FRAMEWORK -XKBCOMMON +UTMP +SYSVINIT default-hierarchy=unified)
[   10.377456] systemd[1]: Detected architecture x86-64.
[   10.378622] systemd[1]: Hostname set to <qa-m2>.
[   10.487199] systemd[1]: Configuration file /run/systemd/system/netplan-ovs-cleanup.service is marked world-inaccessible. This has no effect as configuration data is accessible via APIs without restrictions. Proceeding anyway.
[   10.516899] systemd[1]: Queued start job for default target graphical.target.
[   10.539294] systemd[1]: Created slice system-modprobe.slice - Slice /system/modprobe.
[   10.539473] systemd[1]: Created slice system-systemd\x2dcryptsetup.slice - Encrypted Volume Units Service Slice.
[   10.539614] systemd[1]: Created slice system-systemd\x2dfsck.slice - Slice /system/systemd-fsck.
[   10.539707] systemd[1]: Created slice user.slice - User and Session Slice.
[   10.539734] systemd[1]: Started systemd-ask-password-wall.path - Forward Password Requests to Wall Directory Watch.
[   10.539838] systemd[1]: Set up automount proc-sys-fs-binfmt_misc.automount - Arbitrary Executable File Formats File System Automount Point.
[   10.539847] systemd[1]: Expecting device dev-disk-by\x2duuid-167A\x2d6858.device - /dev/disk/by-uuid/167A-6858...
[   10.539852] systemd[1]: Expecting device dev-disk-by\x2duuid-1a8d8cdb\x2d8d8f\x2d4689\x2db744\x2d8f32d2067f56.device - /dev/disk/by-uuid/1a8d8cdb-8d8f-4689-b744-8f32d2067f56...
[   10.539856] systemd[1]: Expecting device dev-disk-by\x2duuid-aa8cb093\x2d9cb3\x2d4cc7\x2db44e\x2d4bff76ca37fb.device - /dev/disk/by-uuid/aa8cb093-9cb3-4cc7-b44e-4bff76ca37fb...
[   10.539860] systemd[1]: Expecting device dev-disk-by\x2duuid-abbbc711\x2d9904\x2d466b\x2d8a35\x2d783f0d19bf50.device - /dev/disk/by-uuid/abbbc711-9904-466b-8a35-783f0d19bf50...
[   10.539863] systemd[1]: Expecting device dev-mapper-luks\x2d1a8d8cdb\x2d8d8f\x2d4689\x2db744\x2d8f32d2067f56.device - /dev/mapper/luks-1a8d8cdb-8d8f-4689-b744-8f32d2067f56...
[   10.539874] systemd[1]: Reached target integritysetup.target - Local Integrity Protected Volumes.
[   10.539883] systemd[1]: Reached target nss-user-lookup.target - User and Group Name Lookups.
[   10.539890] systemd[1]: Reached target remote-fs.target - Remote File Systems.
[   10.539895] systemd[1]: Reached target slices.target - Slice Units.
[   10.539902] systemd[1]: Reached target snapd.mounts-pre.target - Mounting snaps.
[   10.539915] systemd[1]: Reached target veritysetup.target - Local Verity Protected Volumes.
[   10.539950] systemd[1]: Listening on dm-event.socket - Device-mapper event daemon FIFOs.
[   10.540264] systemd[1]: Listening on lvm2-lvmpolld.socket - LVM2 poll daemon socket.
[   10.540557] systemd[1]: Listening on syslog.socket - Syslog Socket.
[   10.540589] systemd[1]: Listening on systemd-fsckd.socket - fsck to fsckd communication Socket.
[   10.540609] systemd[1]: Listening on systemd-initctl.socket - initctl Compatibility Named Pipe.
[   10.540647] systemd[1]: Listening on systemd-journald-dev-log.socket - Journal Socket (/dev/log).
[   10.540690] systemd[1]: Listening on systemd-journald.socket - Journal Socket.
[   10.540711] systemd[1]: systemd-pcrextend.socket - TPM2 PCR Extension (Varlink) was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
[   10.540991] systemd[1]: Listening on systemd-udevd-control.socket - udev Control Socket.
[   10.541024] systemd[1]: Listening on systemd-udevd-kernel.socket - udev Kernel Socket.
[   10.542454] systemd[1]: Mounting dev-hugepages.mount - Huge Pages File System...
[   10.542955] systemd[1]: Mounting dev-mqueue.mount - POSIX Message Queue File System...
[   10.543556] systemd[1]: Mounting sys-kernel-debug.mount - Kernel Debug File System...
[   10.544002] systemd[1]: Mounting sys-kernel-tracing.mount - Kernel Trace File System...
[   10.545864] systemd[1]: Starting systemd-journald.service - Journal Service...
[   10.545912] systemd[1]: Finished blk-availability.service - Availability of block devices.
[   10.546677] systemd[1]: Starting keyboard-setup.service - Set the console keyboard layout...
[   10.547108] systemd[1]: Starting kmod-static-nodes.service - Create List of Static Device Nodes...
[   10.547877] systemd[1]: Starting lvm2-monitor.service - Monitoring of LVM2 mirrors, snapshots etc. using dmeventd or progress polling...
[   10.548632] systemd[1]: Starting modprobe@configfs.service - Load Kernel Module configfs...
[   10.549214] systemd[1]: Starting modprobe@dm_mod.service - Load Kernel Module dm_mod...
[   10.549787] systemd[1]: Starting modprobe@drm.service - Load Kernel Module drm...
[   10.550352] systemd[1]: Starting modprobe@efi_pstore.service - Load Kernel Module efi_pstore...
[   10.550800] systemd[1]: Starting modprobe@fuse.service - Load Kernel Module fuse...
[   10.551221] systemd[1]: Starting modprobe@loop.service - Load Kernel Module loop...
[   10.551639] systemd[1]: Starting modprobe@nvme_fabrics.service - Load Kernel Module nvme_fabrics...
[   10.552211] systemd[1]: Starting systemd-modules-load.service - Load Kernel Modules...
[   10.552226] systemd[1]: systemd-pcrmachine.service - TPM2 PCR Machine ID Measurement was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
[   10.552717] systemd[1]: Starting systemd-remount-fs.service - Remount Root and Kernel File Systems...
[   10.552741] systemd[1]: systemd-tpm2-setup-early.service - TPM2 SRK Setup (Early) was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
[   10.553252] systemd[1]: Starting systemd-udev-trigger.service - Coldplug All udev Devices...
[   10.554084] systemd[1]: Mounted dev-hugepages.mount - Huge Pages File System.
[   10.554218] systemd[1]: Mounted dev-mqueue.mount - POSIX Message Queue File System.
[   10.554307] systemd[1]: Mounted sys-kernel-debug.mount - Kernel Debug File System.
[   10.554366] systemd[1]: Mounted sys-kernel-tracing.mount - Kernel Trace File System.
[   10.554609] systemd[1]: Finished kmod-static-nodes.service - Create List of Static Device Nodes.
[   10.554763] pstore: Using crash dump compression: deflate
[   10.554813] systemd[1]: modprobe@configfs.service: Deactivated successfully.
[   10.554934] systemd[1]: Finished modprobe@configfs.service - Load Kernel Module configfs.
[   10.555124] systemd[1]: modprobe@dm_mod.service: Deactivated successfully.
[   10.555251] systemd[1]: Finished modprobe@dm_mod.service - Load Kernel Module dm_mod.
[   10.555379] systemd[1]: modprobe@drm.service: Deactivated successfully.
[   10.555463] systemd[1]: Finished modprobe@drm.service - Load Kernel Module drm.
[   10.555585] systemd[1]: modprobe@loop.service: Deactivated successfully.
[   10.555673] systemd[1]: Finished modprobe@loop.service - Load Kernel Module loop.
[   10.556973] systemd[1]: Mounting sys-kernel-config.mount - Kernel Configuration File System...
[   10.557079] systemd[1]: systemd-repart.service - Repartition Root Disk was skipped because no trigger condition checks were met.
[   10.558415] systemd-journald[823]: Collecting audit messages is disabled.
[   10.558990] systemd[1]: Starting systemd-tmpfiles-setup-dev-early.service - Create Static Device Nodes in /dev gracefully...
[   10.559508] systemd[1]: modprobe@fuse.service: Deactivated successfully.
[   10.559706] systemd[1]: Finished modprobe@fuse.service - Load Kernel Module fuse.
[   10.561164] systemd[1]: Mounting sys-fs-fuse-connections.mount - FUSE Control File System...
[   10.563828] Key type psk registered
[   10.564032] BTRFS info (device dm-0 state M): turning on sync discard
[   10.564034] BTRFS info (device dm-0 state M): enabling auto defrag
[   10.564035] BTRFS info (device dm-0 state M): use lzo compression, level 0
[   10.564757] systemd[1]: Finished systemd-remount-fs.service - Remount Root and Kernel File Systems.
[   10.564819] systemd[1]: Mounted sys-kernel-config.mount - Kernel Configuration File System.
[   10.565695] systemd[1]: systemd-hwdb-update.service - Rebuild Hardware Database was skipped because of an unmet condition check (ConditionNeedsUpdate=/etc).
[   10.566771] systemd[1]: Starting systemd-random-seed.service - Load/Save OS Random Seed...
[   10.566786] systemd[1]: systemd-tpm2-setup.service - TPM2 SRK Setup was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
[   10.567105] systemd[1]: Mounted sys-fs-fuse-connections.mount - FUSE Control File System.
[   10.568455] systemd[1]: modprobe@nvme_fabrics.service: Deactivated successfully.
[   10.568529] systemd[1]: Finished modprobe@nvme_fabrics.service - Load Kernel Module nvme_fabrics.
[   10.589655] systemd[1]: Finished keyboard-setup.service - Set the console keyboard layout.
[   10.600303] systemd[1]: Finished systemd-tmpfiles-setup-dev-early.service - Create Static Device Nodes in /dev gracefully.
[   10.600376] systemd[1]: systemd-sysusers.service - Create System Users was skipped because no trigger condition checks were met.
[   10.600449] lp: driver loaded but no devices found
[   10.600932] systemd[1]: Starting systemd-tmpfiles-setup-dev.service - Create Static Device Nodes in /dev...
[   10.601103] systemd[1]: Started systemd-journald.service - Journal Service.
[   10.605943] systemd-journald[823]: Received client request to flush runtime journal.
[   10.606229] ppdev: user-space parallel port driver
[   10.625120] systemd-journald[823]: /var/log/journal/86d43f3761a64806a644a560706664c5/system.journal: Journal file uses a different sequence number ID, rotating.
[   10.625123] systemd-journald[823]: Rotating system journal.
[   10.639113] pstore: Registered efi_pstore as persistent store backend
[   10.676156] loop0: detected capacity change from 0 to 151296
[   10.676212] loop1: detected capacity change from 0 to 152056
[   10.676257] loop2: detected capacity change from 0 to 8
[   10.676329] loop3: detected capacity change from 0 to 21952
[   10.676769] loop4: detected capacity change from 0 to 22752
[   10.676983] loop5: detected capacity change from 0 to 1034424
[   10.677502] loop6: detected capacity change from 0 to 187776
[   10.677577] loop7: detected capacity change from 0 to 79328
[   10.679199] loop8: detected capacity change from 0 to 79520
[   10.685228] BTRFS info: devid 1 device path /dev/mapper/luks-1a8d8cdb-8d8f-4689-b744-8f32d2067f56 changed to /dev/dm-0 scanned by (udev-worker) (931)
[   10.685987] BTRFS info: devid 1 device path /dev/dm-0 changed to /dev/mapper/luks-1a8d8cdb-8d8f-4689-b744-8f32d2067f56 scanned by (udev-worker) (931)
[   10.707436] input: Intel HID events as /devices/platform/INTC1051:00/input/input14
[   10.712492] Consider using thermal netlink events interface
[   10.727847] intel_pmc_core INT33A1:00:  initialized
[   10.767324] i801_smbus 0000:00:1f.4: SPD Write Disable is set
[   10.767380] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
[   10.767985] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[   10.768171] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   10.768235] mei_me 0000:00:16.0: enabling device (0000 -> 0002)
[   10.768295] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c7248db18c600'
[   10.768333] intel_rapl_msr: PL4 support detected.
[   10.768917] intel_rapl_common: Found RAPL domain package
[   10.768919] intel_rapl_common: Found RAPL domain core
[   10.768921] intel_rapl_common: Found RAPL domain psys
[   10.768946] RAPL PMU: API unit is 2^-32 Joules, 3 fixed counters, 655360 ms ovfl timer
[   10.768949] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[   10.768950] RAPL PMU: hw unit of domain package 2^-14 Joules
[   10.768951] RAPL PMU: hw unit of domain psys 2^-14 Joules
[   10.769770] i2c i2c-2: Successfully instantiated SPD at 0x50
[   10.793896] Creating 1 MTD partitions on "0000:00:1f.5":
[   10.793902] 0x000000000000-0x000002000000 : "BIOS"
[   10.794055] intel_rapl_common: Found RAPL domain package
[   10.795626] spd5118 2-0050: DDR5 temperature sensor: vendor 0x06:0x32 revision 1.6
[   10.806555] Intel(R) Wireless WiFi driver for Linux
[   10.809042] iwlwifi 0000:00:14.3: Detected crf-id 0x400410, cnv-id 0x80401 wfpm id 0x80000020
[   10.809068] iwlwifi 0000:00:14.3: PCI dev 7a70/0094, rev=0x430, rfid=0x2010d000
[   10.809071] iwlwifi 0000:00:14.3: Detected Intel(R) Wi-Fi 6E AX211 160MHz
[   10.809579] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-so-a0-gf-a0-89.ucode failed with error -2
[   10.809597] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-so-a0-gf-a0-88.ucode failed with error -2
[   10.809611] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-so-a0-gf-a0-87.ucode failed with error -2
[   10.813472] iwlwifi 0000:00:14.3: TLV_FW_FSEQ_VERSION: FSEQ Version: 0.0.2.41
[   10.813678] iwlwifi 0000:00:14.3: loaded firmware version 86.fb5c9aeb.0 so-a0-gf-a0-86.ucode op_mode iwlmvm
[   10.816161] ite_829x: loading out-of-tree module taints kernel.
[   10.821035] mc: Linux media interface: v0.10
[   10.821235] Bluetooth: Core ver 2.22
[   10.821254] NET: Registered PF_BLUETOOTH protocol family
[   10.821254] Bluetooth: HCI device and connection manager initialized
[   10.821257] Bluetooth: HCI socket layer initialized
[   10.821259] Bluetooth: L2CAP socket layer initialized
[   10.821262] Bluetooth: SCO socket layer initialized
[   10.821504] ite_829x 0003:048D:8910.0002: hiddev0,hidraw1: USB HID v1.10 Device [ITE Tech. Inc. ITE Device(829x)] on usb-0000:00:14.0-7/input0
[   10.835356] videodev: Linux video capture interface: v2.00
[   10.857103] usbcore: registered new interface driver btusb
[   10.859468] Bluetooth: hci0: Device revision is 0
[   10.859494] Bluetooth: hci0: Secure boot is enabled
[   10.859499] Bluetooth: hci0: OTP lock is enabled
[   10.859501] Bluetooth: hci0: API lock is enabled
[   10.859502] Bluetooth: hci0: Debug lock is disabled
[   10.859503] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
[   10.859506] Bluetooth: hci0: Bootloader timestamp 2019.40 buildtype 1 build 38
[   10.860323] ACPI Warning: \_SB.PC00.XHCI.RHUB.HS14._DSM: Argument #4 type mismatch - Found [Integer], ACPI requires [Package] (20240322/nsarguments-61)
[   10.860415] Bluetooth: hci0: DSM reset method type: 0x00
[   10.863356] Bluetooth: hci0: Found device firmware: intel/ibt-1040-0041.sfi
[   10.863364] Bluetooth: hci0: Boot Address: 0x100800
[   10.863365] Bluetooth: hci0: Firmware Version: 60-48.23
[   10.909858] MXM: GUID detected in BIOS
[   10.910049] ACPI Warning: \_SB.PC00.PEG2.PEGP._DSM: Argument #4 type mismatch - Found [Buffer], ACPI requires [Package] (20240322/nsarguments-61)
[   10.910245] pci 0000:02:00.0: optimus capabilities: enabled, status dynamic power, hda bios codec supported
[   10.910258] VGA switcheroo: detected Optimus DSM method \_SB_.PC00.PEG2.PEGP handle
[   10.910260] nouveau: detected PR support, will not use DSM
[   10.916249] intel_tcc_cooling: Programmable TCC Offset detected
[   10.917046] usb 1-6: Found UVC 1.50 device Chicony USB2.0 Camera (04f2:b7e7)
[   10.923080] snd_hda_intel 0000:00:1f.3: enabling device (0000 -> 0002)
[   10.926862] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_1 due to name collision
[   10.926872] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_2 due to name collision
[   10.926880] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_3 due to name collision
[   10.926889] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_4 due to name collision
[   10.926897] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_5 due to name collision
[   10.926907] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_6 due to name collision
[   10.926916] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_7 due to name collision
[   10.926926] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_8 due to name collision
[   10.926937] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_9 due to name collision
[   10.926949] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_10 due to name collision
[   10.926961] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_11 due to name collision
[   10.926974] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_12 due to name collision
[   10.926989] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_13 due to name collision
[   10.927003] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_14 due to name collision
[   10.927019] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_15 due to name collision
[   10.927035] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_16 due to name collision
[   10.927052] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_17 due to name collision
[   10.927070] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_18 due to name collision
[   10.927095] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_19 due to name collision
[   10.927115] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_20 due to name collision
[   10.927135] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_21 due to name collision
[   10.927157] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_22 due to name collision
[   10.927180] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_23 due to name collision
[   10.927211] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_24 due to name collision
[   10.927242] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_25 due to name collision
[   10.927269] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_26 due to name collision
[   10.927304] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_27 due to name collision
[   10.927340] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_28 due to name collision
[   10.927370] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_29 due to name collision
[   10.927401] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_30 due to name collision
[   10.927433] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_31 due to name collision
[   10.927466] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_32 due to name collision
[   10.927508] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_33 due to name collision
[   10.927545] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_34 due to name collision
[   10.927581] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_35 due to name collision
[   10.927627] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_36 due to name collision
[   10.927674] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_37 due to name collision
[   10.927715] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_38 due to name collision
[   10.927766] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_39 due to name collision
[   10.927817] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_40 due to name collision
[   10.927912] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_41 due to name collision
[   10.927966] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_42 due to name collision
[   10.928017] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_43 due to name collision
[   10.928068] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_44 due to name collision
[   10.928121] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_45 due to name collision
[   10.928193] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_46 due to name collision
[   10.928265] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_47 due to name collision
[   10.928330] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_48 due to name collision
[   10.928391] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_49 due to name collision
[   10.928439] snd_hda_intel 0000:02:00.1: enabling device (0000 -> 0002)
[   10.928457] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_50 due to name collision
[   10.928543] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_51 due to name collision
[   10.928575] snd_hda_intel 0000:02:00.1: Disabling MSI
[   10.928580] snd_hda_intel 0000:02:00.1: Handle vga_switcheroo audio client
[   10.928616] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_52 due to name collision
[   10.928691] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_53 due to name collision
[   10.928759] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_54 due to name collision
[   10.928842] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_55 due to name collision
[   10.928935] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_56 due to name collision
[   10.929020] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_57 due to name collision
[   10.929100] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_58 due to name collision
[   10.929183] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_59 due to name collision
[   10.929284] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_60 due to name collision
[   10.929371] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_61 due to name collision
[   10.929472] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_62 due to name collision
[   10.929566] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_63 due to name collision
[   10.929664] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_64 due to name collision
[   10.929766] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_65 due to name collision
[   10.929870] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_66 due to name collision
[   10.929964] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_67 due to name collision
[   10.930080] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_68 due to name collision
[   10.930188] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_69 due to name collision
[   10.930297] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_70 due to name collision
[   10.930433] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_71 due to name collision
[   10.930542] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_72 due to name collision
[   10.930664] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_73 due to name collision
[   10.930784] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_74 due to name collision
[   10.930905] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_75 due to name collision
[   10.931031] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_76 due to name collision
[   10.931159] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_77 due to name collision
[   10.931300] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_78 due to name collision
[   10.931431] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_79 due to name collision
[   10.931558] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_80 due to name collision
[   10.931695] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_81 due to name collision
[   10.931835] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_82 due to name collision
[   10.931969] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_83 due to name collision
[   10.932117] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_84 due to name collision
[   10.932280] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_85 due to name collision
[   10.932424] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_86 due to name collision
[   10.932588] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_87 due to name collision
[   10.932758] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_88 due to name collision
[   10.932909] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_89 due to name collision
[   10.933079] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_90 due to name collision
[   10.933155] nouveau 0000:02:00.0: vgaarb: deactivate vga console
[   10.933239] nouveau 0000:02:00.0: NVIDIA AD104 (194000a1)
[   10.933252] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_91 due to name collision
[   10.933411] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_92 due to name collision
[   10.933596] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_93 due to name collision
[   10.933763] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_94 due to name collision
[   10.933949] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_95 due to name collision
[   10.934120] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_96 due to name collision
[   10.934311] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_97 due to name collision
[   10.934504] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_98 due to name collision
[   10.934687] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_99 due to name collision
[   10.934885] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_100 due to name collision
[   10.935075] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_101 due to name collision
[   10.935280] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_102 due to name collision
[   10.935529] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_103 due to name collision
[   10.935770] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_104 due to name collision
[   10.935980] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_105 due to name collision
[   10.936199] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_106 due to name collision
[   10.936453] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_107 due to name collision
[   10.936683] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_108 due to name collision
[   10.936909] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_109 due to name collision
[   10.937135] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_110 due to name collision
[   10.937369] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_111 due to name collision
[   10.937606] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_112 due to name collision
[   10.937841] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_113 due to name collision
[   10.938089] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_114 due to name collision
[   10.938333] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_115 due to name collision
[   10.938581] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_116 due to name collision
[   10.938843] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_117 due to name collision
[   10.939104] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_118 due to name collision
[   10.939377] ite_829x 0003:048D:8910.0002: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_119 due to name collision
[   10.958491] input: HDA NVidia HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:01.1/0000:02:00.1/sound/card1/input15
[   10.958554] input: HDA NVidia HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:01.1/0000:02:00.1/sound/card1/input16
[   10.958621] input: HDA NVidia HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:01.1/0000:02:00.1/sound/card1/input17
[   10.958682] input: HDA NVidia HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:01.1/0000:02:00.1/sound/card1/input18
[   10.961969] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC1220: line_outs=1 (0x1b/0x0/0x0/0x0/0x0) type:speaker
[   10.961976] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[   10.961979] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=1 (0x14/0x0/0x0/0x0/0x0)
[   10.961981] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=0x0
[   10.961983] snd_hda_codec_realtek hdaudioC0D0:    dig-out=0x1e/0x0
[   10.961985] snd_hda_codec_realtek hdaudioC0D0:    inputs:
[   10.961987] snd_hda_codec_realtek hdaudioC0D0:      Mic=0x18
[   10.961989] snd_hda_codec_realtek hdaudioC0D0:      Internal Mic=0x12
[   10.968428] usb 1-6: Found UVC 1.50 device Chicony USB2.0 Camera (04f2:b7e7)
[   10.972073] input: HDA Intel PCH Mic as /devices/pci0000:00/0000:00:1f.3/sound/card0/input19
[   10.972117] input: HDA Intel PCH Headphone as /devices/pci0000:00/0000:00:1f.3/sound/card0/input20
[   10.979192] usbcore: registered new interface driver uvcvideo
[   11.103069] iwlwifi 0000:00:14.3: WFPM_UMAC_PD_NOTIFICATION: 0x20
[   11.103100] iwlwifi 0000:00:14.3: WFPM_LMAC2_PD_NOTIFICATION: 0x1f
[   11.103110] iwlwifi 0000:00:14.3: WFPM_AUTH_KEY_0: 0x90
[   11.103120] iwlwifi 0000:00:14.3: CNVI_SCU_SEQ_DATA_DW9: 0x0
[   11.103844] iwlwifi 0000:00:14.3: loaded PNVM version e28bb9d7
[   11.104242] iwlwifi 0000:00:14.3: RFIm is deactivated, reason = 5
[   11.120653] iwlwifi 0000:00:14.3: Detected RF GF, rfid=0x2010d000
[   11.189253] iwlwifi 0000:00:14.3: base HW address: dc:97:ba:75:8a:32
[   11.202264] nouveau 0000:02:00.0: bios: version 95.04.63.00.24
[   11.228461] iwlwifi 0000:00:14.3 wlp0s20f3: renamed from wlan0
[   11.580201] BTRFS: device label kfocus_boot devid 1 transid 548 /dev/nvme0n1p2 (259:2) scanned by mount (1397)
[   11.580802] BTRFS info (device nvme0n1p2): first mount of filesystem abbbc711-9904-466b-8a35-783f0d19bf50
[   11.580824] BTRFS info (device nvme0n1p2): using crc32c (crc32c-intel) checksum algorithm
[   11.580830] BTRFS info (device nvme0n1p2): using free-space-tree
[   11.589444] Adding 524284k swap on /swap/swapfile.  Priority:-2 extents:2 across:1686444k 
[   11.615045] audit: type=1400 audit(1730481937.241:2): apparmor="STATUS" operation="profile_load" profile="unconfined" name="vscode" pid=1465 comm="apparmor_parser"
[   11.615058] audit: type=1400 audit(1730481937.241:3): apparmor="STATUS" operation="profile_load" profile="unconfined" name="geary" pid=1474 comm="apparmor_parser"
[   11.615074] audit: type=1400 audit(1730481937.241:4): apparmor="STATUS" operation="profile_load" profile="unconfined" name="Discord" pid=1453 comm="apparmor_parser"
[   11.615094] audit: type=1400 audit(1730481937.241:5): apparmor="STATUS" operation="profile_load" profile="unconfined" name="QtWebEngineProcess" pid=1455 comm="apparmor_parser"
[   11.615111] audit: type=1400 audit(1730481937.241:6): apparmor="STATUS" operation="profile_load" profile="unconfined" name="busybox" pid=1459 comm="apparmor_parser"
[   11.615148] audit: type=1400 audit(1730481937.241:7): apparmor="STATUS" operation="profile_load" profile="unconfined" name="balena-etcher" pid=1456 comm="apparmor_parser"
[   11.615170] audit: type=1400 audit(1730481937.241:8): apparmor="STATUS" operation="profile_load" profile="unconfined" name="devhelp" pid=1467 comm="apparmor_parser"
[   11.615201] audit: type=1400 audit(1730481937.241:9): apparmor="STATUS" operation="profile_load" profile="unconfined" name="buildah" pid=1458 comm="apparmor_parser"
[   11.615230] audit: type=1400 audit(1730481937.241:10): apparmor="STATUS" operation="profile_load" profile="unconfined" name="ch-run" pid=1463 comm="apparmor_parser"
[   11.615327] audit: type=1400 audit(1730481937.242:11): apparmor="STATUS" operation="profile_load" profile="unconfined" name="brave" pid=1457 comm="apparmor_parser"
[   12.198560] nouveau 0000:02:00.0: DRM: VRAM: 12282 MiB
[   12.198563] nouveau 0000:02:00.0: DRM: GART: 536870912 MiB
[   12.254575] nouveau 0000:02:00.0: DRM: MM: using COPY for buffer copies
[   12.281822] Bluetooth: hci0: Waiting for firmware download to complete
[   12.282474] Bluetooth: hci0: Firmware loaded in 1385854 usecs
[   12.282583] Bluetooth: hci0: Waiting for device to boot
[   12.289868] snd_hda_intel 0000:02:00.1: bound 0000:02:00.0 (ops disp50xx_modifiers [nouveau])
[   12.294260] acpi device:06: registered as cooling_device36
[   12.294614] [drm] Initialized nouveau 1.4.0 for 0000:02:00.0 on minor 1
[   12.298421] Bluetooth: hci0: Malformed MSFT vendor event: 0x02
[   12.298456] Bluetooth: hci0: Device booted in 15572 usecs
[   12.300487] Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-1040-0041.ddc
[   12.302368] Bluetooth: hci0: Applying Intel DDC parameters completed
[   12.305510] Bluetooth: hci0: Firmware timestamp 2023.48 buildtype 1 build 75324
[   12.305513] Bluetooth: hci0: Firmware SHA1: 0x23bac558
[   12.309488] Bluetooth: hci0: Fseq status: Success (0x00)
[   12.309491] Bluetooth: hci0: Fseq executed: 00.00.02.41
[   12.309492] Bluetooth: hci0: Fseq BT Top: 00.00.02.41
[   12.312967] fbcon: nouveaudrmfb (fb0) is primary device
[   12.312970] fbcon: Deferring console take-over
[   12.312971] nouveau 0000:02:00.0: [drm] fb0: nouveaudrmfb frame buffer device
[   12.325466] snd_hda_codec_hdmi hdaudioC1D0: HDMI: pin NID 0x4 not registered
[   12.754904] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   12.754907] Bluetooth: BNEP filters: protocol multicast
[   12.754911] Bluetooth: BNEP socket layer initialized
[   12.756339] Bluetooth: MGMT ver 1.23
[   12.758329] NET: Registered PF_ALG protocol family
[   12.805440] loop9: detected capacity change from 0 to 8
[   12.860621] NET: Registered PF_QIPCRTR protocol family
[   13.511667] iwlwifi 0000:00:14.3: WFPM_UMAC_PD_NOTIFICATION: 0x20
[   13.511712] iwlwifi 0000:00:14.3: WFPM_LMAC2_PD_NOTIFICATION: 0x1f
[   13.511721] iwlwifi 0000:00:14.3: WFPM_AUTH_KEY_0: 0x90
[   13.511730] iwlwifi 0000:00:14.3: CNVI_SCU_SEQ_DATA_DW9: 0x0
[   13.512636] iwlwifi 0000:00:14.3: RFIm is deactivated, reason = 5
[   13.613925] iwlwifi 0000:00:14.3: Registered PHC clock: iwlwifi-PTP, with index: 1
[   16.321153] igc 0000:03:00.0 enp3s0: NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
[   16.483260] thunderbolt 0000:06:00.0: 0: suspending switch
[   16.483268] thunderbolt 0000:06:00.0: 0: enabling wakeup: 0x3f
[   16.484522] thunderbolt 0000:06:00.0: stopping RX ring 0
[   16.484540] thunderbolt 0000:06:00.0: disabling interrupt at register 0x38200 bit 12 (0x1001 -> 0x1)
[   16.484561] thunderbolt 0000:06:00.0: stopping TX ring 0
[   16.484572] thunderbolt 0000:06:00.0: disabling interrupt at register 0x38200 bit 0 (0x1 -> 0x0)
[   16.484582] thunderbolt 0000:06:00.0: control channel stopped
[   23.968715] snd_hda_codec_hdmi hdaudioC1D0: HDMI: pin NID 0x4 not registered
[   25.918258] Bluetooth: RFCOMM TTY layer initialized
[   25.918263] Bluetooth: RFCOMM socket layer initialized
[   25.918267] Bluetooth: RFCOMM ver 1.11
[   29.148667] systemd-journald[823]: /var/log/journal/86d43f3761a64806a644a560706664c5/user-1000.journal: Journal file uses a different sequence number ID, rotating.
[   30.269637] warning: `kded5' uses wireless extensions which will stop working for Wi-Fi 7 hardware; use nl80211
[   30.504027] snd_hda_codec_hdmi hdaudioC1D0: HDMI: pin NID 0x4 not registered
[   31.406806] thunderbolt 0000:06:00.0: control channel starting...
[   31.406814] thunderbolt 0000:06:00.0: starting TX ring 0
[   31.406817] xhci_hcd 0000:2d:00.0: xHC error in resume, USBSTS 0x401, Reinit
[   31.406824] usb usb3: root hub lost power or was reset
[   31.406823] thunderbolt 0000:06:00.0: enabling interrupt at register 0x38200 bit 0 (0x0 -> 0x1)
[   31.406827] usb usb4: root hub lost power or was reset
[   31.406830] thunderbolt 0000:06:00.0: starting RX ring 0
[   31.406839] thunderbolt 0000:06:00.0: enabling interrupt at register 0x38200 bit 12 (0x1 -> 0x1001)
[   31.406847] thunderbolt 0000:06:00.0: 0: resuming switch
[   31.406850] thunderbolt 0000:06:00.0: restoring Switch at 0x0 (depth: 0, up port: 15)
[   31.407014] thunderbolt 0000:06:00.0: 0: disabling wakeup
[   31.416242] thunderbolt 0000:06:00.0: acking hot plug event on 0:13
[   31.416262] thunderbolt 0000:06:00.0: 0: TMU: supports uni-directional mode
[   31.416268] thunderbolt 0000:06:00.0: 0: TMU: supports enhanced uni-directional mode
[   31.416366] thunderbolt 0000:06:00.0: acking hot plug event on 0:14
[   31.416378] thunderbolt 0000:06:00.0: 0: TMU: current mode: off
[   31.416383] thunderbolt 0000:06:00.0: 0: TMU: mode change off -> bi-directional, HiFi requested
[   31.416493] thunderbolt 0000:06:00.0: acking hot plug event on 0:16
[   31.416883] thunderbolt 0000:06:00.0: 0: TMU: mode set to: bi-directional, HiFi
[   31.419188] thunderbolt 0000:06:00.0: 0:13: DP IN resource available after hotplug
[   31.419194] thunderbolt 0000:06:00.0: looking for DP IN <-> DP OUT pairs:
[   31.419316] thunderbolt 0000:06:00.0: 0:13: DP IN available
[   31.419320] thunderbolt 0000:06:00.0: 0:13: no suitable DP OUT adapter available, not tunneling
[   31.420084] thunderbolt 0000:06:00.0: 0:14: DP IN resource available after hotplug
[   31.420087] thunderbolt 0000:06:00.0: looking for DP IN <-> DP OUT pairs:
[   31.420205] thunderbolt 0000:06:00.0: 0:13: DP IN available
[   31.420207] thunderbolt 0000:06:00.0: 0:13: no suitable DP OUT adapter available, not tunneling
[   31.420342] thunderbolt 0000:06:00.0: 0:14: DP IN available
[   31.420346] thunderbolt 0000:06:00.0: 0:14: no suitable DP OUT adapter available, not tunneling
[   48.067126] thunderbolt 0000:06:00.0: 0: suspending switch
[   48.067142] thunderbolt 0000:06:00.0: 0: enabling wakeup: 0x3f
[   48.068294] thunderbolt 0000:06:00.0: stopping RX ring 0
[   48.068313] thunderbolt 0000:06:00.0: disabling interrupt at register 0x38200 bit 12 (0x1001 -> 0x1)
[   48.068340] thunderbolt 0000:06:00.0: stopping TX ring 0
[   48.068354] thunderbolt 0000:06:00.0: disabling interrupt at register 0x38200 bit 0 (0x1 -> 0x0)
[   48.068372] thunderbolt 0000:06:00.0: control channel stopped
[   74.672411] wlp0s20f3: authenticate with a0:55:1f:2f:2c:93 (local address=dc:97:ba:75:8a:32)
[   74.674290] wlp0s20f3: send auth to a0:55:1f:2f:2c:93 (try 1/3)
[   74.709306] wlp0s20f3: authenticate with a0:55:1f:2f:2c:93 (local address=dc:97:ba:75:8a:32)
[   74.709820] wlp0s20f3: send auth to a0:55:1f:2f:2c:93 (try 1/3)
[   74.711066] wlp0s20f3: authenticated
[   74.713477] wlp0s20f3: associate with a0:55:1f:2f:2c:93 (try 1/3)
[   74.723013] wlp0s20f3: RX AssocResp from a0:55:1f:2f:2c:93 (capab=0x1011 status=0 aid=23)
[   74.732008] wlp0s20f3: associated
[   91.154234] usb 1-9: new high-speed USB device number 5 using xhci_hcd
[   91.301556] usb 1-9: New USB device found, idVendor=0bda, idProduct=5411, bcdDevice= 1.49
[   91.301569] usb 1-9: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[   91.301574] usb 1-9: Product: 4-Port USB 2.0 Hub
[   91.301578] usb 1-9: Manufacturer: Generic
[   91.305500] hub 1-9:1.0: USB hub found
[   91.307895] hub 1-9:1.0: 4 ports detected
[   91.599042] usb 1-9.3: new full-speed USB device number 6 using xhci_hcd
[   91.693409] usb 1-9.3: New USB device found, idVendor=043e, idProduct=9a39, bcdDevice= 4.11
[   91.693424] usb 1-9.3: New USB device strings: Mfr=1, Product=3, SerialNumber=4
[   91.693430] usb 1-9.3: Product: LG Monitor Controls
[   91.693435] usb 1-9.3: Manufacturer: LG Electronics Inc.
[   91.693438] usb 1-9.3: SerialNumber: 005INTX1F153
[   91.700128] hid-generic 0003:043E:9A39.0003: hiddev1,hidraw2: USB HID v1.11 Device [LG Electronics Inc. LG Monitor Controls] on usb-0000:00:14.0-9.3/input0

# Display successfully activated HERE using `lscpi -k`

[  157.749523] xhci_hcd 0000:2d:00.0: xHC error in resume, USBSTS 0x401, Reinit
[  157.749537] usb usb3: root hub lost power or was reset
[  157.749541] usb usb4: root hub lost power or was reset
[  157.749976] thunderbolt 0000:06:00.0: control channel starting...
[  157.749988] thunderbolt 0000:06:00.0: starting TX ring 0
[  157.750005] thunderbolt 0000:06:00.0: enabling interrupt at register 0x38200 bit 0 (0x0 -> 0x1)
[  157.750067] thunderbolt 0000:06:00.0: starting RX ring 0
[  157.750084] thunderbolt 0000:06:00.0: enabling interrupt at register 0x38200 bit 12 (0x1 -> 0x1001)
[  157.750099] thunderbolt 0000:06:00.0: 0: resuming switch
[  157.750106] thunderbolt 0000:06:00.0: restoring Switch at 0x0 (depth: 0, up port: 15)
[  157.750438] thunderbolt 0000:06:00.0: 0: disabling wakeup
[  157.752800] thunderbolt 0000:06:00.0: acking hot plug event on 0:14
[  157.752927] thunderbolt 0000:06:00.0: acking hot plug event on 0:16
[  157.759334] thunderbolt 0000:06:00.0: 0: TMU: supports uni-directional mode
[  157.759341] thunderbolt 0000:06:00.0: 0: TMU: supports enhanced uni-directional mode
[  157.759459] thunderbolt 0000:06:00.0: 0: TMU: current mode: off
[  157.759465] thunderbolt 0000:06:00.0: 0: TMU: mode change off -> bi-directional, HiFi requested
[  157.759971] thunderbolt 0000:06:00.0: 0: TMU: mode set to: bi-directional, HiFi
[  157.760872] thunderbolt 0000:06:00.0: 0:13: enter redrive mode, keeping powered
[  157.762276] thunderbolt 0000:06:00.0: 0:14: DP IN resource available after hotplug
[  157.762283] thunderbolt 0000:06:00.0: looking for DP IN <-> DP OUT pairs:
[  157.762405] thunderbolt 0000:06:00.0: 0:14: DP IN available
[  157.762408] thunderbolt 0000:06:00.0: 0:14: no suitable DP OUT adapter available, not tunneling

--MP_/WuIuDckOYZDBcFRp6AX3mk1
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename=2024-11-01_6.11.5_tbt-barlow-ridge-02-dmesg.txt

[   47.296472]  snd_hda_intel(E) snd_intel_dspcfg(E) snd_intel_sdw_acpi(E) snd_hda_codec(E) snd_hda_core(E) snd_hwdep(E) snd_pcm(E) uvcvideo(E) videobuf2_vmalloc(E) iwlmvm(E) btusb(E) snd_seq_midi(E) uvc(E) coretemp(E) btrtl(E) videobuf2_memops(E) i915(E) snd_seq_midi_event(E) btintel(E) videobuf2_v4l2(E) mac80211(E) kvm_intel(E) snd_rawmidi(E) btbcm(E) videodev(E) btmtk(E) videobuf2_common(E) ite_829x(OE) snd_seq(E) libarc4(E) drm_buddy(E) mc(E) led_class_multicolor(E) processor_thermal_device_pci(E) bluetooth(E) kvm(E) snd_seq_device(E) spd5118(E) processor_thermal_device(E) drm_display_helper(E) cmdlinepart(E) iwlwifi(E) mei_hdcp(E) mei_pxp(E) snd_timer(E) processor_thermal_wt_hint(E) processor_thermal_rfim(E) cec(E) spi_nor(E) rapl(E) processor_thermal_rapl(E) mtd(E) intel_rapl_msr(E) i2c_i801(E) snd(E) drm_ttm_helper(E) nvidia_wmi_ec_backlight(E) mxm_wmi(E) intel_cstate(E) intel_rapl_common(E) rc_core(E) i2c_mux(E) mei_me(E) processor_thermal_wt_req(E) soundcore(E) spi_intel_pci
 (E) cfg80211(E) ttm(E) i2c_smbus(E)
[   47.296487]  i2c_algo_bit(E) processor_thermal_power_floor(E) spi_intel(E) mei(E) processor_thermal_mbox(E) intel_pmc_core(E) int3403_thermal(E) int340x_thermal_zone(E) intel_vsec(E) int3400_thermal(E) pmt_telemetry(E) intel_hid(E) pmt_class(E) acpi_thermal_rel(E) joydev(E) sparse_keymap(E) acpi_pad(E) input_leds(E) mac_hid(E) serio_raw(E) sch_fq_codel(E) msr(E) parport_pc(E) ppdev(E) lp(E) nvme_fabrics(E) parport(E) nvme_keyring(E) efi_pstore(E) nfnetlink(E) dmi_sysfs(E) ip_tables(E) x_tables(E) autofs4(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) libcrc32c(E) dm_crypt(E) dm_mirror(E) dm_region_hash(E) dm_log(E) usbhid(E) nvme(E) hid_multitouch(E) hid_generic(E) nvme_core(E) nvme_auth(E) crct10dif_pclmul(E) crc32_pclmul(E) polyval_clmulni(E) polyval_generic(E) ghash_clmulni_intel(E) sha256_ssse3(E) thunderbolt(E) sha1_ssse3(E) ucsi_acpi(E) psmouse(E) intel_lpss_pci(E) typec_ucsi(E) igc(E) xhci_pci(E) intel_lpss(E) xhci_pci_renesas(E) vmd(E) idma64(E) typec(E) i2c_hid_acpi(E)
  i2c_hid(E) hid(E) video(E) wmi(E)
[   47.296503]  pinctrl_alderlake(E) aesni_intel(E) crypto_simd(E) cryptd(E)
[   47.296504] CPU: 2 UID: 0 PID: 1141 Comm: nv_queue Tainted: P        W  OE      6.11.5 #1
[   47.296505] Tainted: [P]=PROPRIETARY_MODULE, [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[   47.296506] Hardware name: Notebook X370SNx1/X370SNx1, BIOS 1.07.03aMIN29 09/18/2024
[   47.296506] RIP: 0010:follow_pte+0x220/0x230
[   47.296508] Code: 15 75 33 8c 01 48 81 e2 00 00 00 c0 e9 7b ff ff ff 48 8b 45 d0 48 8b 38 e8 8d e9 e1 00 e8 18 e6 da ff 41 bc ea ff ff ff eb 9f <0f> 0b e9 0d fe ff ff 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
[   47.296508] RSP: 0018:ffff99cac101bb10 EFLAGS: 00010246
[   47.296509] RAX: 0000000000000000 RBX: 000077ed8e920000 RCX: ffff99cac101bb60
[   47.296509] RDX: ffff99cac101bb58 RSI: 000077ed8e920000 RDI: ffff89230b259a98
[   47.296510] RBP: ffff99cac101bb48 R08: ffff99cac101bd18 R09: 0000000000000000
[   47.296510] R10: 0000000000000000 R11: 0000000000000000 R12: ffff99cac101bba8
[   47.296511] R13: 0000000000000000 R14: ffff99cac101bb58 R15: ffff892310d70580
[   47.296511] FS:  0000000000000000(0000) GS:ffff892a9e900000(0000) knlGS:0000000000000000
[   47.296512] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   47.296512] CR2: 000070e8b04ee200 CR3: 000000012aa3e000 CR4: 0000000000f50ef0
[   47.296513] PKRU: 55555554
[   47.296513] Call Trace:
[   47.296513]  <TASK>
[   47.296514]  ? show_regs+0x6c/0x80
[   47.296515]  ? __warn+0x88/0x140
[   47.296516]  ? follow_pte+0x220/0x230
[   47.296518]  ? report_bug+0x182/0x1b0
[   47.296519]  ? handle_bug+0x51/0xa0
[   47.296520]  ? exc_invalid_op+0x18/0x80
[   47.296522]  ? asm_exc_invalid_op+0x1b/0x20
[   47.296523]  ? follow_pte+0x220/0x230
[   47.296525]  follow_phys+0x4e/0x110
[   47.296526]  untrack_pfn+0x57/0x130
[   47.296528]  unmap_single_vma+0xbc/0xf0
[   47.296529]  zap_page_range_single+0x138/0x210
[   47.296530]  unmap_mapping_range+0x11b/0x140
[   47.296531]  nv_revoke_gpu_mappings+0x68/0xc0 [nvidia]
[   47.296644]  _nv000741rm+0x35/0xf6 [nvidia]
[   47.296814]  ? rm_execute_work_item+0x141/0x1f0 [nvidia]
[   47.296988]  ? os_execute_work_item+0x6c/0x90 [nvidia]
[   47.297107]  ? _main_loop+0x7e/0x140 [nvidia]
[   47.297228]  ? __pfx__main_loop+0x10/0x10 [nvidia]
[   47.297348]  ? kthread+0xe1/0x110
[   47.297349]  ? __pfx_kthread+0x10/0x10
[   47.297350]  ? ret_from_fork+0x44/0x70
[   47.297351]  ? __pfx_kthread+0x10/0x10
[   47.297351]  ? ret_from_fork_asm+0x1a/0x30
[   47.297353]  </TASK>
[   47.297353] ---[ end trace 0000000000000000 ]---
[   47.297358] ------------[ cut here ]------------
[   47.297358] WARNING: CPU: 2 PID: 1141 at include/linux/rwsem.h:80 follow_pte+0x220/0x230
[   47.297360] Modules linked in: nvidia_uvm(POE) ccm(E) rfcomm(E) snd_seq_dummy(E) snd_hrtimer(E) qrtr(E) cmac(E) algif_hash(E) algif_skcipher(E) af_alg(E) bnep(E) xe(E) snd_hda_codec_realtek(E) drm_gpuvm(E) drm_exec(E) snd_hda_codec_generic(E) gpu_sched(E) drm_suballoc_helper(E) snd_hda_scodec_component(E) binfmt_misc(E) nls_iso8859_1(E) nvidia_drm(POE) nvidia_modeset(POE) nvidia(POE) intel_uncore_frequency(E) intel_uncore_frequency_common(E) intel_tcc_cooling(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) snd_hda_codec_hdmi(E) snd_sof_pci_intel_tgl(E) snd_sof_pci_intel_cnl(E) snd_sof_intel_hda_generic(E) soundwire_intel(E) soundwire_cadence(E) snd_sof_intel_hda_common(E) snd_sof_intel_hda_mlink(E) snd_sof_intel_hda(E) snd_sof_pci(E) snd_sof_xtensa_dsp(E) snd_sof(E) snd_sof_utils(E) snd_soc_hdac_hda(E) snd_soc_acpi_intel_match(E) soundwire_generic_allocation(E) snd_soc_acpi(E) soundwire_bus(E) snd_soc_avs(E) snd_soc_hda_codec(E) snd_hda_ext_core(E) snd_soc_core(E) snd_compress(E) a
 c97_bus(E) snd_pcm_dmaengine(E)
[   47.297373]  snd_hda_intel(E) snd_intel_dspcfg(E) snd_intel_sdw_acpi(E) snd_hda_codec(E) snd_hda_core(E) snd_hwdep(E) snd_pcm(E) uvcvideo(E) videobuf2_vmalloc(E) iwlmvm(E) btusb(E) snd_seq_midi(E) uvc(E) coretemp(E) btrtl(E) videobuf2_memops(E) i915(E) snd_seq_midi_event(E) btintel(E) videobuf2_v4l2(E) mac80211(E) kvm_intel(E) snd_rawmidi(E) btbcm(E) videodev(E) btmtk(E) videobuf2_common(E) ite_829x(OE) snd_seq(E) libarc4(E) drm_buddy(E) mc(E) led_class_multicolor(E) processor_thermal_device_pci(E) bluetooth(E) kvm(E) snd_seq_device(E) spd5118(E) processor_thermal_device(E) drm_display_helper(E) cmdlinepart(E) iwlwifi(E) mei_hdcp(E) mei_pxp(E) snd_timer(E) processor_thermal_wt_hint(E) processor_thermal_rfim(E) cec(E) spi_nor(E) rapl(E) processor_thermal_rapl(E) mtd(E) intel_rapl_msr(E) i2c_i801(E) snd(E) drm_ttm_helper(E) nvidia_wmi_ec_backlight(E) mxm_wmi(E) intel_cstate(E) intel_rapl_common(E) rc_core(E) i2c_mux(E) mei_me(E) processor_thermal_wt_req(E) soundcore(E) spi_intel_pci
 (E) cfg80211(E) ttm(E) i2c_smbus(E)
[   47.297388]  i2c_algo_bit(E) processor_thermal_power_floor(E) spi_intel(E) mei(E) processor_thermal_mbox(E) intel_pmc_core(E) int3403_thermal(E) int340x_thermal_zone(E) intel_vsec(E) int3400_thermal(E) pmt_telemetry(E) intel_hid(E) pmt_class(E) acpi_thermal_rel(E) joydev(E) sparse_keymap(E) acpi_pad(E) input_leds(E) mac_hid(E) serio_raw(E) sch_fq_codel(E) msr(E) parport_pc(E) ppdev(E) lp(E) nvme_fabrics(E) parport(E) nvme_keyring(E) efi_pstore(E) nfnetlink(E) dmi_sysfs(E) ip_tables(E) x_tables(E) autofs4(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) libcrc32c(E) dm_crypt(E) dm_mirror(E) dm_region_hash(E) dm_log(E) usbhid(E) nvme(E) hid_multitouch(E) hid_generic(E) nvme_core(E) nvme_auth(E) crct10dif_pclmul(E) crc32_pclmul(E) polyval_clmulni(E) polyval_generic(E) ghash_clmulni_intel(E) sha256_ssse3(E) thunderbolt(E) sha1_ssse3(E) ucsi_acpi(E) psmouse(E) intel_lpss_pci(E) typec_ucsi(E) igc(E) xhci_pci(E) intel_lpss(E) xhci_pci_renesas(E) vmd(E) idma64(E) typec(E) i2c_hid_acpi(E)
  i2c_hid(E) hid(E) video(E) wmi(E)
[   47.297404]  pinctrl_alderlake(E) aesni_intel(E) crypto_simd(E) cryptd(E)
[   47.297405] CPU: 2 UID: 0 PID: 1141 Comm: nv_queue Tainted: P        W  OE      6.11.5 #1
[   47.297407] Tainted: [P]=PROPRIETARY_MODULE, [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[   47.297407] Hardware name: Notebook X370SNx1/X370SNx1, BIOS 1.07.03aMIN29 09/18/2024
[   47.297407] RIP: 0010:follow_pte+0x220/0x230
[   47.297409] Code: 15 75 33 8c 01 48 81 e2 00 00 00 c0 e9 7b ff ff ff 48 8b 45 d0 48 8b 38 e8 8d e9 e1 00 e8 18 e6 da ff 41 bc ea ff ff ff eb 9f <0f> 0b e9 0d fe ff ff 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
[   47.297409] RSP: 0018:ffff99cac101bb10 EFLAGS: 00010246
[   47.297410] RAX: 0000000000000000 RBX: 000077ed8f93b000 RCX: ffff99cac101bb60
[   47.297411] RDX: ffff99cac101bb58 RSI: 000077ed8f93b000 RDI: ffff8923b90f0450
[   47.297411] RBP: ffff99cac101bb48 R08: ffff99cac101bd18 R09: 0000000000000000
[   47.297411] R10: 0000000000000000 R11: 0000000000000000 R12: ffff99cac101bba8
[   47.297412] R13: 0000000000000000 R14: ffff99cac101bb58 R15: ffff892310d70580
[   47.297412] FS:  0000000000000000(0000) GS:ffff892a9e900000(0000) knlGS:0000000000000000
[   47.297413] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   47.297413] CR2: 000070e8b04ee200 CR3: 000000012aa3e000 CR4: 0000000000f50ef0
[   47.297414] PKRU: 55555554
[   47.297414] Call Trace:
[   47.297415]  <TASK>
[   47.297415]  ? show_regs+0x6c/0x80
[   47.297416]  ? __warn+0x88/0x140
[   47.297417]  ? follow_pte+0x220/0x230
[   47.297419]  ? report_bug+0x182/0x1b0
[   47.297420]  ? handle_bug+0x51/0xa0
[   47.297421]  ? exc_invalid_op+0x18/0x80
[   47.297423]  ? asm_exc_invalid_op+0x1b/0x20
[   47.297424]  ? follow_pte+0x220/0x230
[   47.297426]  follow_phys+0x4e/0x110
[   47.297427]  untrack_pfn+0x57/0x130
[   47.297429]  unmap_single_vma+0xbc/0xf0
[   47.297430]  zap_page_range_single+0x138/0x210
[   47.297431]  unmap_mapping_range+0x11b/0x140
[   47.297432]  nv_revoke_gpu_mappings+0x68/0xc0 [nvidia]
[   47.297551]  _nv000741rm+0x35/0xf6 [nvidia]
[   47.297731]  ? rm_execute_work_item+0x141/0x1f0 [nvidia]
[   47.297919]  ? os_execute_work_item+0x6c/0x90 [nvidia]
[   47.298040]  ? _main_loop+0x7e/0x140 [nvidia]
[   47.298161]  ? __pfx__main_loop+0x10/0x10 [nvidia]
[   47.298280]  ? kthread+0xe1/0x110
[   47.298281]  ? __pfx_kthread+0x10/0x10
[   47.298282]  ? ret_from_fork+0x44/0x70
[   47.298283]  ? __pfx_kthread+0x10/0x10
[   47.298283]  ? ret_from_fork_asm+0x1a/0x30
[   47.298285]  </TASK>
[   47.298285] ---[ end trace 0000000000000000 ]---
[   47.298290] ------------[ cut here ]------------
[   47.298290] WARNING: CPU: 2 PID: 1141 at include/linux/rwsem.h:80 follow_pte+0x220/0x230
[   47.298292] Modules linked in: nvidia_uvm(POE) ccm(E) rfcomm(E) snd_seq_dummy(E) snd_hrtimer(E) qrtr(E) cmac(E) algif_hash(E) algif_skcipher(E) af_alg(E) bnep(E) xe(E) snd_hda_codec_realtek(E) drm_gpuvm(E) drm_exec(E) snd_hda_codec_generic(E) gpu_sched(E) drm_suballoc_helper(E) snd_hda_scodec_component(E) binfmt_misc(E) nls_iso8859_1(E) nvidia_drm(POE) nvidia_modeset(POE) nvidia(POE) intel_uncore_frequency(E) intel_uncore_frequency_common(E) intel_tcc_cooling(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) snd_hda_codec_hdmi(E) snd_sof_pci_intel_tgl(E) snd_sof_pci_intel_cnl(E) snd_sof_intel_hda_generic(E) soundwire_intel(E) soundwire_cadence(E) snd_sof_intel_hda_common(E) snd_sof_intel_hda_mlink(E) snd_sof_intel_hda(E) snd_sof_pci(E) snd_sof_xtensa_dsp(E) snd_sof(E) snd_sof_utils(E) snd_soc_hdac_hda(E) snd_soc_acpi_intel_match(E) soundwire_generic_allocation(E) snd_soc_acpi(E) soundwire_bus(E) snd_soc_avs(E) snd_soc_hda_codec(E) snd_hda_ext_core(E) snd_soc_core(E) snd_compress(E) a
 c97_bus(E) snd_pcm_dmaengine(E)
[   47.298305]  snd_hda_intel(E) snd_intel_dspcfg(E) snd_intel_sdw_acpi(E) snd_hda_codec(E) snd_hda_core(E) snd_hwdep(E) snd_pcm(E) uvcvideo(E) videobuf2_vmalloc(E) iwlmvm(E) btusb(E) snd_seq_midi(E) uvc(E) coretemp(E) btrtl(E) videobuf2_memops(E) i915(E) snd_seq_midi_event(E) btintel(E) videobuf2_v4l2(E) mac80211(E) kvm_intel(E) snd_rawmidi(E) btbcm(E) videodev(E) btmtk(E) videobuf2_common(E) ite_829x(OE) snd_seq(E) libarc4(E) drm_buddy(E) mc(E) led_class_multicolor(E) processor_thermal_device_pci(E) bluetooth(E) kvm(E) snd_seq_device(E) spd5118(E) processor_thermal_device(E) drm_display_helper(E) cmdlinepart(E) iwlwifi(E) mei_hdcp(E) mei_pxp(E) snd_timer(E) processor_thermal_wt_hint(E) processor_thermal_rfim(E) cec(E) spi_nor(E) rapl(E) processor_thermal_rapl(E) mtd(E) intel_rapl_msr(E) i2c_i801(E) snd(E) drm_ttm_helper(E) nvidia_wmi_ec_backlight(E) mxm_wmi(E) intel_cstate(E) intel_rapl_common(E) rc_core(E) i2c_mux(E) mei_me(E) processor_thermal_wt_req(E) soundcore(E) spi_intel_pci
 (E) cfg80211(E) ttm(E) i2c_smbus(E)
[   47.298320]  i2c_algo_bit(E) processor_thermal_power_floor(E) spi_intel(E) mei(E) processor_thermal_mbox(E) intel_pmc_core(E) int3403_thermal(E) int340x_thermal_zone(E) intel_vsec(E) int3400_thermal(E) pmt_telemetry(E) intel_hid(E) pmt_class(E) acpi_thermal_rel(E) joydev(E) sparse_keymap(E) acpi_pad(E) input_leds(E) mac_hid(E) serio_raw(E) sch_fq_codel(E) msr(E) parport_pc(E) ppdev(E) lp(E) nvme_fabrics(E) parport(E) nvme_keyring(E) efi_pstore(E) nfnetlink(E) dmi_sysfs(E) ip_tables(E) x_tables(E) autofs4(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) libcrc32c(E) dm_crypt(E) dm_mirror(E) dm_region_hash(E) dm_log(E) usbhid(E) nvme(E) hid_multitouch(E) hid_generic(E) nvme_core(E) nvme_auth(E) crct10dif_pclmul(E) crc32_pclmul(E) polyval_clmulni(E) polyval_generic(E) ghash_clmulni_intel(E) sha256_ssse3(E) thunderbolt(E) sha1_ssse3(E) ucsi_acpi(E) psmouse(E) intel_lpss_pci(E) typec_ucsi(E) igc(E) xhci_pci(E) intel_lpss(E) xhci_pci_renesas(E) vmd(E) idma64(E) typec(E) i2c_hid_acpi(E)
  i2c_hid(E) hid(E) video(E) wmi(E)
[   47.298335]  pinctrl_alderlake(E) aesni_intel(E) crypto_simd(E) cryptd(E)
[   47.298337] CPU: 2 UID: 0 PID: 1141 Comm: nv_queue Tainted: P        W  OE      6.11.5 #1
[   47.298338] Tainted: [P]=PROPRIETARY_MODULE, [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[   47.298338] Hardware name: Notebook X370SNx1/X370SNx1, BIOS 1.07.03aMIN29 09/18/2024
[   47.298339] RIP: 0010:follow_pte+0x220/0x230
[   47.298340] Code: 15 75 33 8c 01 48 81 e2 00 00 00 c0 e9 7b ff ff ff 48 8b 45 d0 48 8b 38 e8 8d e9 e1 00 e8 18 e6 da ff 41 bc ea ff ff ff eb 9f <0f> 0b e9 0d fe ff ff 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
[   47.298341] RSP: 0018:ffff99cac101bb10 EFLAGS: 00010246
[   47.298341] RAX: 0000000000000000 RBX: 0000774200000000 RCX: ffff99cac101bb60
[   47.298342] RDX: ffff99cac101bb58 RSI: 0000774200000000 RDI: ffff89231b519870
[   47.298342] RBP: ffff99cac101bb48 R08: ffff99cac101bd18 R09: 0000000000000000
[   47.298343] R10: 0000000000000000 R11: 0000000000000000 R12: ffff99cac101bba8
[   47.298343] R13: 0000000000000000 R14: ffff99cac101bb58 R15: ffff892316d19080
[   47.298344] FS:  0000000000000000(0000) GS:ffff892a9e900000(0000) knlGS:0000000000000000
[   47.298344] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   47.298345] CR2: 000070e8b04ee200 CR3: 000000012aa3e000 CR4: 0000000000f50ef0
[   47.298345] PKRU: 55555554
[   47.298345] Call Trace:
[   47.298346]  <TASK>
[   47.298346]  ? show_regs+0x6c/0x80
[   47.298347]  ? __warn+0x88/0x140
[   47.298349]  ? follow_pte+0x220/0x230
[   47.298350]  ? report_bug+0x182/0x1b0
[   47.298351]  ? handle_bug+0x51/0xa0
[   47.298353]  ? exc_invalid_op+0x18/0x80
[   47.298354]  ? asm_exc_invalid_op+0x1b/0x20
[   47.298355]  ? follow_pte+0x220/0x230
[   47.298357]  follow_phys+0x4e/0x110
[   47.298359]  untrack_pfn+0x57/0x130
[   47.298360]  unmap_single_vma+0xbc/0xf0
[   47.298361]  zap_page_range_single+0x138/0x210
[   47.298363]  unmap_mapping_range+0x11b/0x140
[   47.298364]  nv_revoke_gpu_mappings+0x68/0xc0 [nvidia]
[   47.298473]  _nv000741rm+0x35/0xf6 [nvidia]
[   47.298634]  ? rm_execute_work_item+0x141/0x1f0 [nvidia]
[   47.298795]  ? os_execute_work_item+0x6c/0x90 [nvidia]
[   47.298964]  ? _main_loop+0x7e/0x140 [nvidia]
[   47.299085]  ? __pfx__main_loop+0x10/0x10 [nvidia]
[   47.299204]  ? kthread+0xe1/0x110
[   47.299205]  ? __pfx_kthread+0x10/0x10
[   47.299206]  ? ret_from_fork+0x44/0x70
[   47.299207]  ? __pfx_kthread+0x10/0x10
[   47.299208]  ? ret_from_fork_asm+0x1a/0x30
[   47.299209]  </TASK>
[   47.299210] ---[ end trace 0000000000000000 ]---
[   47.299224] ------------[ cut here ]------------
[   47.299225] WARNING: CPU: 2 PID: 1141 at include/linux/rwsem.h:80 follow_pte+0x220/0x230
[   47.299227] Modules linked in: nvidia_uvm(POE) ccm(E) rfcomm(E) snd_seq_dummy(E) snd_hrtimer(E) qrtr(E) cmac(E) algif_hash(E) algif_skcipher(E) af_alg(E) bnep(E) xe(E) snd_hda_codec_realtek(E) drm_gpuvm(E) drm_exec(E) snd_hda_codec_generic(E) gpu_sched(E) drm_suballoc_helper(E) snd_hda_scodec_component(E) binfmt_misc(E) nls_iso8859_1(E) nvidia_drm(POE) nvidia_modeset(POE) nvidia(POE) intel_uncore_frequency(E) intel_uncore_frequency_common(E) intel_tcc_cooling(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) snd_hda_codec_hdmi(E) snd_sof_pci_intel_tgl(E) snd_sof_pci_intel_cnl(E) snd_sof_intel_hda_generic(E) soundwire_intel(E) soundwire_cadence(E) snd_sof_intel_hda_common(E) snd_sof_intel_hda_mlink(E) snd_sof_intel_hda(E) snd_sof_pci(E) snd_sof_xtensa_dsp(E) snd_sof(E) snd_sof_utils(E) snd_soc_hdac_hda(E) snd_soc_acpi_intel_match(E) soundwire_generic_allocation(E) snd_soc_acpi(E) soundwire_bus(E) snd_soc_avs(E) snd_soc_hda_codec(E) snd_hda_ext_core(E) snd_soc_core(E) snd_compress(E) a
 c97_bus(E) snd_pcm_dmaengine(E)
[   47.299239]  snd_hda_intel(E) snd_intel_dspcfg(E) snd_intel_sdw_acpi(E) snd_hda_codec(E) snd_hda_core(E) snd_hwdep(E) snd_pcm(E) uvcvideo(E) videobuf2_vmalloc(E) iwlmvm(E) btusb(E) snd_seq_midi(E) uvc(E) coretemp(E) btrtl(E) videobuf2_memops(E) i915(E) snd_seq_midi_event(E) btintel(E) videobuf2_v4l2(E) mac80211(E) kvm_intel(E) snd_rawmidi(E) btbcm(E) videodev(E) btmtk(E) videobuf2_common(E) ite_829x(OE) snd_seq(E) libarc4(E) drm_buddy(E) mc(E) led_class_multicolor(E) processor_thermal_device_pci(E) bluetooth(E) kvm(E) snd_seq_device(E) spd5118(E) processor_thermal_device(E) drm_display_helper(E) cmdlinepart(E) iwlwifi(E) mei_hdcp(E) mei_pxp(E) snd_timer(E) processor_thermal_wt_hint(E) processor_thermal_rfim(E) cec(E) spi_nor(E) rapl(E) processor_thermal_rapl(E) mtd(E) intel_rapl_msr(E) i2c_i801(E) snd(E) drm_ttm_helper(E) nvidia_wmi_ec_backlight(E) mxm_wmi(E) intel_cstate(E) intel_rapl_common(E) rc_core(E) i2c_mux(E) mei_me(E) processor_thermal_wt_req(E) soundcore(E) spi_intel_pci
 (E) cfg80211(E) ttm(E) i2c_smbus(E)
[   47.299254]  i2c_algo_bit(E) processor_thermal_power_floor(E) spi_intel(E) mei(E) processor_thermal_mbox(E) intel_pmc_core(E) int3403_thermal(E) int340x_thermal_zone(E) intel_vsec(E) int3400_thermal(E) pmt_telemetry(E) intel_hid(E) pmt_class(E) acpi_thermal_rel(E) joydev(E) sparse_keymap(E) acpi_pad(E) input_leds(E) mac_hid(E) serio_raw(E) sch_fq_codel(E) msr(E) parport_pc(E) ppdev(E) lp(E) nvme_fabrics(E) parport(E) nvme_keyring(E) efi_pstore(E) nfnetlink(E) dmi_sysfs(E) ip_tables(E) x_tables(E) autofs4(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) libcrc32c(E) dm_crypt(E) dm_mirror(E) dm_region_hash(E) dm_log(E) usbhid(E) nvme(E) hid_multitouch(E) hid_generic(E) nvme_core(E) nvme_auth(E) crct10dif_pclmul(E) crc32_pclmul(E) polyval_clmulni(E) polyval_generic(E) ghash_clmulni_intel(E) sha256_ssse3(E) thunderbolt(E) sha1_ssse3(E) ucsi_acpi(E) psmouse(E) intel_lpss_pci(E) typec_ucsi(E) igc(E) xhci_pci(E) intel_lpss(E) xhci_pci_renesas(E) vmd(E) idma64(E) typec(E) i2c_hid_acpi(E)
  i2c_hid(E) hid(E) video(E) wmi(E)
[   47.299270]  pinctrl_alderlake(E) aesni_intel(E) crypto_simd(E) cryptd(E)
[   47.299272] CPU: 2 UID: 0 PID: 1141 Comm: nv_queue Tainted: P        W  OE      6.11.5 #1
[   47.299273] Tainted: [P]=PROPRIETARY_MODULE, [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[   47.299273] Hardware name: Notebook X370SNx1/X370SNx1, BIOS 1.07.03aMIN29 09/18/2024
[   47.299273] RIP: 0010:follow_pte+0x220/0x230
[   47.299275] Code: 15 75 33 8c 01 48 81 e2 00 00 00 c0 e9 7b ff ff ff 48 8b 45 d0 48 8b 38 e8 8d e9 e1 00 e8 18 e6 da ff 41 bc ea ff ff ff eb 9f <0f> 0b e9 0d fe ff ff 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
[   47.299276] RSP: 0018:ffff99cac101bb10 EFLAGS: 00010246
[   47.299276] RAX: 0000000000000000 RBX: 00007d5c20801000 RCX: ffff99cac101bb60
[   47.299277] RDX: ffff99cac101bb58 RSI: 00007d5c20801000 RDI: ffff89231b519b50
[   47.299277] RBP: ffff99cac101bb48 R08: ffff99cac101bd18 R09: 0000000000000000
[   47.299278] R10: 0000000000000000 R11: 0000000000000000 R12: ffff99cac101bba8
[   47.299278] R13: 0000000000000000 R14: ffff99cac101bb58 R15: ffff89230d400b00
[   47.299279] FS:  0000000000000000(0000) GS:ffff892a9e900000(0000) knlGS:0000000000000000
[   47.299279] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   47.299280] CR2: 000070e8b04ee200 CR3: 000000012aa3e000 CR4: 0000000000f50ef0
[   47.299280] PKRU: 55555554
[   47.299281] Call Trace:
[   47.299281]  <TASK>
[   47.299281]  ? show_regs+0x6c/0x80
[   47.299283]  ? __warn+0x88/0x140
[   47.299284]  ? follow_pte+0x220/0x230
[   47.299286]  ? report_bug+0x182/0x1b0
[   47.299287]  ? handle_bug+0x51/0xa0
[   47.299288]  ? exc_invalid_op+0x18/0x80
[   47.299290]  ? asm_exc_invalid_op+0x1b/0x20
[   47.299291]  ? follow_pte+0x220/0x230
[   47.299293]  follow_phys+0x4e/0x110
[   47.299294]  untrack_pfn+0x57/0x130
[   47.299296]  unmap_single_vma+0xbc/0xf0
[   47.299297]  zap_page_range_single+0x138/0x210
[   47.299298]  unmap_mapping_range+0x11b/0x140
[   47.299299]  nv_revoke_gpu_mappings+0x68/0xc0 [nvidia]
[   47.299418]  _nv000741rm+0x35/0xf6 [nvidia]
[   47.299595]  ? rm_execute_work_item+0x141/0x1f0 [nvidia]
[   47.299771]  ? os_execute_work_item+0x6c/0x90 [nvidia]
[   47.299936]  ? _main_loop+0x7e/0x140 [nvidia]
[   47.300059]  ? __pfx__main_loop+0x10/0x10 [nvidia]
[   47.300178]  ? kthread+0xe1/0x110
[   47.300179]  ? __pfx_kthread+0x10/0x10
[   47.300180]  ? ret_from_fork+0x44/0x70
[   47.300181]  ? __pfx_kthread+0x10/0x10
[   47.300182]  ? ret_from_fork_asm+0x1a/0x30
[   47.300183]  </TASK>
[   47.300184] ---[ end trace 0000000000000000 ]---
[   47.300189] ------------[ cut here ]------------
[   47.300189] WARNING: CPU: 2 PID: 1141 at include/linux/rwsem.h:80 follow_pte+0x220/0x230
[   47.300191] Modules linked in: nvidia_uvm(POE) ccm(E) rfcomm(E) snd_seq_dummy(E) snd_hrtimer(E) qrtr(E) cmac(E) algif_hash(E) algif_skcipher(E) af_alg(E) bnep(E) xe(E) snd_hda_codec_realtek(E) drm_gpuvm(E) drm_exec(E) snd_hda_codec_generic(E) gpu_sched(E) drm_suballoc_helper(E) snd_hda_scodec_component(E) binfmt_misc(E) nls_iso8859_1(E) nvidia_drm(POE) nvidia_modeset(POE) nvidia(POE) intel_uncore_frequency(E) intel_uncore_frequency_common(E) intel_tcc_cooling(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) snd_hda_codec_hdmi(E) snd_sof_pci_intel_tgl(E) snd_sof_pci_intel_cnl(E) snd_sof_intel_hda_generic(E) soundwire_intel(E) soundwire_cadence(E) snd_sof_intel_hda_common(E) snd_sof_intel_hda_mlink(E) snd_sof_intel_hda(E) snd_sof_pci(E) snd_sof_xtensa_dsp(E) snd_sof(E) snd_sof_utils(E) snd_soc_hdac_hda(E) snd_soc_acpi_intel_match(E) soundwire_generic_allocation(E) snd_soc_acpi(E) soundwire_bus(E) snd_soc_avs(E) snd_soc_hda_codec(E) snd_hda_ext_core(E) snd_soc_core(E) snd_compress(E) a
 c97_bus(E) snd_pcm_dmaengine(E)
[   47.300204]  snd_hda_intel(E) snd_intel_dspcfg(E) snd_intel_sdw_acpi(E) snd_hda_codec(E) snd_hda_core(E) snd_hwdep(E) snd_pcm(E) uvcvideo(E) videobuf2_vmalloc(E) iwlmvm(E) btusb(E) snd_seq_midi(E) uvc(E) coretemp(E) btrtl(E) videobuf2_memops(E) i915(E) snd_seq_midi_event(E) btintel(E) videobuf2_v4l2(E) mac80211(E) kvm_intel(E) snd_rawmidi(E) btbcm(E) videodev(E) btmtk(E) videobuf2_common(E) ite_829x(OE) snd_seq(E) libarc4(E) drm_buddy(E) mc(E) led_class_multicolor(E) processor_thermal_device_pci(E) bluetooth(E) kvm(E) snd_seq_device(E) spd5118(E) processor_thermal_device(E) drm_display_helper(E) cmdlinepart(E) iwlwifi(E) mei_hdcp(E) mei_pxp(E) snd_timer(E) processor_thermal_wt_hint(E) processor_thermal_rfim(E) cec(E) spi_nor(E) rapl(E) processor_thermal_rapl(E) mtd(E) intel_rapl_msr(E) i2c_i801(E) snd(E) drm_ttm_helper(E) nvidia_wmi_ec_backlight(E) mxm_wmi(E) intel_cstate(E) intel_rapl_common(E) rc_core(E) i2c_mux(E) mei_me(E) processor_thermal_wt_req(E) soundcore(E) spi_intel_pci
 (E) cfg80211(E) ttm(E) i2c_smbus(E)
[   47.300219]  i2c_algo_bit(E) processor_thermal_power_floor(E) spi_intel(E) mei(E) processor_thermal_mbox(E) intel_pmc_core(E) int3403_thermal(E) int340x_thermal_zone(E) intel_vsec(E) int3400_thermal(E) pmt_telemetry(E) intel_hid(E) pmt_class(E) acpi_thermal_rel(E) joydev(E) sparse_keymap(E) acpi_pad(E) input_leds(E) mac_hid(E) serio_raw(E) sch_fq_codel(E) msr(E) parport_pc(E) ppdev(E) lp(E) nvme_fabrics(E) parport(E) nvme_keyring(E) efi_pstore(E) nfnetlink(E) dmi_sysfs(E) ip_tables(E) x_tables(E) autofs4(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) libcrc32c(E) dm_crypt(E) dm_mirror(E) dm_region_hash(E) dm_log(E) usbhid(E) nvme(E) hid_multitouch(E) hid_generic(E) nvme_core(E) nvme_auth(E) crct10dif_pclmul(E) crc32_pclmul(E) polyval_clmulni(E) polyval_generic(E) ghash_clmulni_intel(E) sha256_ssse3(E) thunderbolt(E) sha1_ssse3(E) ucsi_acpi(E) psmouse(E) intel_lpss_pci(E) typec_ucsi(E) igc(E) xhci_pci(E) intel_lpss(E) xhci_pci_renesas(E) vmd(E) idma64(E) typec(E) i2c_hid_acpi(E)
  i2c_hid(E) hid(E) video(E) wmi(E)
[   47.300235]  pinctrl_alderlake(E) aesni_intel(E) crypto_simd(E) cryptd(E)
[   47.300237] CPU: 2 UID: 0 PID: 1141 Comm: nv_queue Tainted: P        W  OE      6.11.5 #1
[   47.300238] Tainted: [P]=PROPRIETARY_MODULE, [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[   47.300238] Hardware name: Notebook X370SNx1/X370SNx1, BIOS 1.07.03aMIN29 09/18/2024
[   47.300239] RIP: 0010:follow_pte+0x220/0x230
[   47.300240] Code: 15 75 33 8c 01 48 81 e2 00 00 00 c0 e9 7b ff ff ff 48 8b 45 d0 48 8b 38 e8 8d e9 e1 00 e8 18 e6 da ff 41 bc ea ff ff ff eb 9f <0f> 0b e9 0d fe ff ff 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
[   47.300241] RSP: 0018:ffff99cac101bb10 EFLAGS: 00010246
[   47.300241] RAX: 0000000000000000 RBX: 00007741f92a5000 RCX: ffff99cac101bb60
[   47.300242] RDX: ffff99cac101bb58 RSI: 00007741f92a5000 RDI: ffff892326f5f9e0
[   47.300242] RBP: ffff99cac101bb48 R08: ffff99cac101bd18 R09: 0000000000000000
[   47.300243] R10: 0000000000000000 R11: 0000000000000000 R12: ffff99cac101bba8
[   47.300243] R13: 0000000000000000 R14: ffff99cac101bb58 R15: ffff892316d19080
[   47.300244] FS:  0000000000000000(0000) GS:ffff892a9e900000(0000) knlGS:0000000000000000
[   47.300244] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   47.300245] CR2: 000070e8b04ee200 CR3: 000000012aa3e000 CR4: 0000000000f50ef0
[   47.300245] PKRU: 55555554
[   47.300246] Call Trace:
[   47.300246]  <TASK>
[   47.300246]  ? show_regs+0x6c/0x80
[   47.300247]  ? __warn+0x88/0x140
[   47.300249]  ? follow_pte+0x220/0x230
[   47.300251]  ? report_bug+0x182/0x1b0
[   47.300252]  ? handle_bug+0x51/0xa0
[   47.300253]  ? exc_invalid_op+0x18/0x80
[   47.300254]  ? asm_exc_invalid_op+0x1b/0x20
[   47.300256]  ? follow_pte+0x220/0x230
[   47.300257]  follow_phys+0x4e/0x110
[   47.300259]  untrack_pfn+0x57/0x130
[   47.300261]  unmap_single_vma+0xbc/0xf0
[   47.300261]  zap_page_range_single+0x138/0x210
[   47.300263]  unmap_mapping_range+0x11b/0x140
[   47.300264]  nv_revoke_gpu_mappings+0x68/0xc0 [nvidia]
[   47.300381]  _nv000741rm+0x35/0xf6 [nvidia]
[   47.300539]  ? rm_execute_work_item+0x141/0x1f0 [nvidia]
[   47.300699]  ? os_execute_work_item+0x6c/0x90 [nvidia]
[   47.300806]  ? _main_loop+0x7e/0x140 [nvidia]
[   47.300977]  ? __pfx__main_loop+0x10/0x10 [nvidia]
[   47.301098]  ? kthread+0xe1/0x110
[   47.301099]  ? __pfx_kthread+0x10/0x10
[   47.301100]  ? ret_from_fork+0x44/0x70
[   47.301101]  ? __pfx_kthread+0x10/0x10
[   47.301102]  ? ret_from_fork_asm+0x1a/0x30
[   47.301103]  </TASK>
[   47.301103] ---[ end trace 0000000000000000 ]---
[   47.301109] ------------[ cut here ]------------
[   47.301110] WARNING: CPU: 2 PID: 1141 at include/linux/rwsem.h:80 follow_pte+0x220/0x230
[   47.301112] Modules linked in: nvidia_uvm(POE) ccm(E) rfcomm(E) snd_seq_dummy(E) snd_hrtimer(E) qrtr(E) cmac(E) algif_hash(E) algif_skcipher(E) af_alg(E) bnep(E) xe(E) snd_hda_codec_realtek(E) drm_gpuvm(E) drm_exec(E) snd_hda_codec_generic(E) gpu_sched(E) drm_suballoc_helper(E) snd_hda_scodec_component(E) binfmt_misc(E) nls_iso8859_1(E) nvidia_drm(POE) nvidia_modeset(POE) nvidia(POE) intel_uncore_frequency(E) intel_uncore_frequency_common(E) intel_tcc_cooling(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) snd_hda_codec_hdmi(E) snd_sof_pci_intel_tgl(E) snd_sof_pci_intel_cnl(E) snd_sof_intel_hda_generic(E) soundwire_intel(E) soundwire_cadence(E) snd_sof_intel_hda_common(E) snd_sof_intel_hda_mlink(E) snd_sof_intel_hda(E) snd_sof_pci(E) snd_sof_xtensa_dsp(E) snd_sof(E) snd_sof_utils(E) snd_soc_hdac_hda(E) snd_soc_acpi_intel_match(E) soundwire_generic_allocation(E) snd_soc_acpi(E) soundwire_bus(E) snd_soc_avs(E) snd_soc_hda_codec(E) snd_hda_ext_core(E) snd_soc_core(E) snd_compress(E) a
 c97_bus(E) snd_pcm_dmaengine(E)
[   47.301125]  snd_hda_intel(E) snd_intel_dspcfg(E) snd_intel_sdw_acpi(E) snd_hda_codec(E) snd_hda_core(E) snd_hwdep(E) snd_pcm(E) uvcvideo(E) videobuf2_vmalloc(E) iwlmvm(E) btusb(E) snd_seq_midi(E) uvc(E) coretemp(E) btrtl(E) videobuf2_memops(E) i915(E) snd_seq_midi_event(E) btintel(E) videobuf2_v4l2(E) mac80211(E) kvm_intel(E) snd_rawmidi(E) btbcm(E) videodev(E) btmtk(E) videobuf2_common(E) ite_829x(OE) snd_seq(E) libarc4(E) drm_buddy(E) mc(E) led_class_multicolor(E) processor_thermal_device_pci(E) bluetooth(E) kvm(E) snd_seq_device(E) spd5118(E) processor_thermal_device(E) drm_display_helper(E) cmdlinepart(E) iwlwifi(E) mei_hdcp(E) mei_pxp(E) snd_timer(E) processor_thermal_wt_hint(E) processor_thermal_rfim(E) cec(E) spi_nor(E) rapl(E) processor_thermal_rapl(E) mtd(E) intel_rapl_msr(E) i2c_i801(E) snd(E) drm_ttm_helper(E) nvidia_wmi_ec_backlight(E) mxm_wmi(E) intel_cstate(E) intel_rapl_common(E) rc_core(E) i2c_mux(E) mei_me(E) processor_thermal_wt_req(E) soundcore(E) spi_intel_pci
 (E) cfg80211(E) ttm(E) i2c_smbus(E)
[   47.301140]  i2c_algo_bit(E) processor_thermal_power_floor(E) spi_intel(E) mei(E) processor_thermal_mbox(E) intel_pmc_core(E) int3403_thermal(E) int340x_thermal_zone(E) intel_vsec(E) int3400_thermal(E) pmt_telemetry(E) intel_hid(E) pmt_class(E) acpi_thermal_rel(E) joydev(E) sparse_keymap(E) acpi_pad(E) input_leds(E) mac_hid(E) serio_raw(E) sch_fq_codel(E) msr(E) parport_pc(E) ppdev(E) lp(E) nvme_fabrics(E) parport(E) nvme_keyring(E) efi_pstore(E) nfnetlink(E) dmi_sysfs(E) ip_tables(E) x_tables(E) autofs4(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) libcrc32c(E) dm_crypt(E) dm_mirror(E) dm_region_hash(E) dm_log(E) usbhid(E) nvme(E) hid_multitouch(E) hid_generic(E) nvme_core(E) nvme_auth(E) crct10dif_pclmul(E) crc32_pclmul(E) polyval_clmulni(E) polyval_generic(E) ghash_clmulni_intel(E) sha256_ssse3(E) thunderbolt(E) sha1_ssse3(E) ucsi_acpi(E) psmouse(E) intel_lpss_pci(E) typec_ucsi(E) igc(E) xhci_pci(E) intel_lpss(E) xhci_pci_renesas(E) vmd(E) idma64(E) typec(E) i2c_hid_acpi(E)
  i2c_hid(E) hid(E) video(E) wmi(E)
[   47.301156]  pinctrl_alderlake(E) aesni_intel(E) crypto_simd(E) cryptd(E)
[   47.301158] CPU: 2 UID: 0 PID: 1141 Comm: nv_queue Tainted: P        W  OE      6.11.5 #1
[   47.301159] Tainted: [P]=PROPRIETARY_MODULE, [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[   47.301159] Hardware name: Notebook X370SNx1/X370SNx1, BIOS 1.07.03aMIN29 09/18/2024
[   47.301160] RIP: 0010:follow_pte+0x220/0x230
[   47.301161] Code: 15 75 33 8c 01 48 81 e2 00 00 00 c0 e9 7b ff ff ff 48 8b 45 d0 48 8b 38 e8 8d e9 e1 00 e8 18 e6 da ff 41 bc ea ff ff ff eb 9f <0f> 0b e9 0d fe ff ff 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
[   47.301162] RSP: 0018:ffff99cac101bb10 EFLAGS: 00010246
[   47.301162] RAX: 0000000000000000 RBX: 00007d5c1d661000 RCX: ffff99cac101bb60
[   47.301163] RDX: ffff99cac101bb58 RSI: 00007d5c1d661000 RDI: ffff89239fd7a7e8
[   47.301163] RBP: ffff99cac101bb48 R08: ffff99cac101bd18 R09: 0000000000000000
[   47.301164] R10: 0000000000000000 R11: 0000000000000000 R12: ffff99cac101bba8
[   47.301164] R13: 0000000000000000 R14: ffff99cac101bb58 R15: ffff89230d400b00
[   47.301165] FS:  0000000000000000(0000) GS:ffff892a9e900000(0000) knlGS:0000000000000000
[   47.301165] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   47.301166] CR2: 000070e8b04ee200 CR3: 000000012aa3e000 CR4: 0000000000f50ef0
[   47.301166] PKRU: 55555554
[   47.301167] Call Trace:
[   47.301167]  <TASK>
[   47.301167]  ? show_regs+0x6c/0x80
[   47.301168]  ? __warn+0x88/0x140
[   47.301170]  ? follow_pte+0x220/0x230
[   47.301171]  ? report_bug+0x182/0x1b0
[   47.301173]  ? handle_bug+0x51/0xa0
[   47.301174]  ? exc_invalid_op+0x18/0x80
[   47.301175]  ? asm_exc_invalid_op+0x1b/0x20
[   47.301177]  ? follow_pte+0x220/0x230
[   47.301178]  follow_phys+0x4e/0x110
[   47.301180]  untrack_pfn+0x57/0x130
[   47.301182]  unmap_single_vma+0xbc/0xf0
[   47.301182]  zap_page_range_single+0x138/0x210
[   47.301184]  unmap_mapping_range+0x11b/0x140
[   47.301185]  nv_revoke_gpu_mappings+0x68/0xc0 [nvidia]
[   47.301304]  _nv000741rm+0x35/0xf6 [nvidia]
[   47.301481]  ? rm_execute_work_item+0x141/0x1f0 [nvidia]
[   47.301646]  ? os_execute_work_item+0x6c/0x90 [nvidia]
[   47.301754]  ? _main_loop+0x7e/0x140 [nvidia]
[   47.301890]  ? __pfx__main_loop+0x10/0x10 [nvidia]
[   47.302008]  ? kthread+0xe1/0x110
[   47.302009]  ? __pfx_kthread+0x10/0x10
[   47.302009]  ? ret_from_fork+0x44/0x70
[   47.302010]  ? __pfx_kthread+0x10/0x10
[   47.302011]  ? ret_from_fork_asm+0x1a/0x30
[   47.302013]  </TASK>
[   47.302013] ---[ end trace 0000000000000000 ]---
[   47.302019] ------------[ cut here ]------------
[   47.302019] WARNING: CPU: 2 PID: 1141 at include/linux/rwsem.h:80 follow_pte+0x220/0x230
[   47.302021] Modules linked in: nvidia_uvm(POE) ccm(E) rfcomm(E) snd_seq_dummy(E) snd_hrtimer(E) qrtr(E) cmac(E) algif_hash(E) algif_skcipher(E) af_alg(E) bnep(E) xe(E) snd_hda_codec_realtek(E) drm_gpuvm(E) drm_exec(E) snd_hda_codec_generic(E) gpu_sched(E) drm_suballoc_helper(E) snd_hda_scodec_component(E) binfmt_misc(E) nls_iso8859_1(E) nvidia_drm(POE) nvidia_modeset(POE) nvidia(POE) intel_uncore_frequency(E) intel_uncore_frequency_common(E) intel_tcc_cooling(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) snd_hda_codec_hdmi(E) snd_sof_pci_intel_tgl(E) snd_sof_pci_intel_cnl(E) snd_sof_intel_hda_generic(E) soundwire_intel(E) soundwire_cadence(E) snd_sof_intel_hda_common(E) snd_sof_intel_hda_mlink(E) snd_sof_intel_hda(E) snd_sof_pci(E) snd_sof_xtensa_dsp(E) snd_sof(E) snd_sof_utils(E) snd_soc_hdac_hda(E) snd_soc_acpi_intel_match(E) soundwire_generic_allocation(E) snd_soc_acpi(E) soundwire_bus(E) snd_soc_avs(E) snd_soc_hda_codec(E) snd_hda_ext_core(E) snd_soc_core(E) snd_compress(E) a
 c97_bus(E) snd_pcm_dmaengine(E)
[   47.302034]  snd_hda_intel(E) snd_intel_dspcfg(E) snd_intel_sdw_acpi(E) snd_hda_codec(E) snd_hda_core(E) snd_hwdep(E) snd_pcm(E) uvcvideo(E) videobuf2_vmalloc(E) iwlmvm(E) btusb(E) snd_seq_midi(E) uvc(E) coretemp(E) btrtl(E) videobuf2_memops(E) i915(E) snd_seq_midi_event(E) btintel(E) videobuf2_v4l2(E) mac80211(E) kvm_intel(E) snd_rawmidi(E) btbcm(E) videodev(E) btmtk(E) videobuf2_common(E) ite_829x(OE) snd_seq(E) libarc4(E) drm_buddy(E) mc(E) led_class_multicolor(E) processor_thermal_device_pci(E) bluetooth(E) kvm(E) snd_seq_device(E) spd5118(E) processor_thermal_device(E) drm_display_helper(E) cmdlinepart(E) iwlwifi(E) mei_hdcp(E) mei_pxp(E) snd_timer(E) processor_thermal_wt_hint(E) processor_thermal_rfim(E) cec(E) spi_nor(E) rapl(E) processor_thermal_rapl(E) mtd(E) intel_rapl_msr(E) i2c_i801(E) snd(E) drm_ttm_helper(E) nvidia_wmi_ec_backlight(E) mxm_wmi(E) intel_cstate(E) intel_rapl_common(E) rc_core(E) i2c_mux(E) mei_me(E) processor_thermal_wt_req(E) soundcore(E) spi_intel_pci
 (E) cfg80211(E) ttm(E) i2c_smbus(E)
[   47.302049]  i2c_algo_bit(E) processor_thermal_power_floor(E) spi_intel(E) mei(E) processor_thermal_mbox(E) intel_pmc_core(E) int3403_thermal(E) int340x_thermal_zone(E) intel_vsec(E) int3400_thermal(E) pmt_telemetry(E) intel_hid(E) pmt_class(E) acpi_thermal_rel(E) joydev(E) sparse_keymap(E) acpi_pad(E) input_leds(E) mac_hid(E) serio_raw(E) sch_fq_codel(E) msr(E) parport_pc(E) ppdev(E) lp(E) nvme_fabrics(E) parport(E) nvme_keyring(E) efi_pstore(E) nfnetlink(E) dmi_sysfs(E) ip_tables(E) x_tables(E) autofs4(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) libcrc32c(E) dm_crypt(E) dm_mirror(E) dm_region_hash(E) dm_log(E) usbhid(E) nvme(E) hid_multitouch(E) hid_generic(E) nvme_core(E) nvme_auth(E) crct10dif_pclmul(E) crc32_pclmul(E) polyval_clmulni(E) polyval_generic(E) ghash_clmulni_intel(E) sha256_ssse3(E) thunderbolt(E) sha1_ssse3(E) ucsi_acpi(E) psmouse(E) intel_lpss_pci(E) typec_ucsi(E) igc(E) xhci_pci(E) intel_lpss(E) xhci_pci_renesas(E) vmd(E) idma64(E) typec(E) i2c_hid_acpi(E)
  i2c_hid(E) hid(E) video(E) wmi(E)
[   47.302064]  pinctrl_alderlake(E) aesni_intel(E) crypto_simd(E) cryptd(E)
[   47.302066] CPU: 2 UID: 0 PID: 1141 Comm: nv_queue Tainted: P        W  OE      6.11.5 #1
[   47.302067] Tainted: [P]=PROPRIETARY_MODULE, [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[   47.302067] Hardware name: Notebook X370SNx1/X370SNx1, BIOS 1.07.03aMIN29 09/18/2024
[   47.302067] RIP: 0010:follow_pte+0x220/0x230
[   47.302069] Code: 15 75 33 8c 01 48 81 e2 00 00 00 c0 e9 7b ff ff ff 48 8b 45 d0 48 8b 38 e8 8d e9 e1 00 e8 18 e6 da ff 41 bc ea ff ff ff eb 9f <0f> 0b e9 0d fe ff ff 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
[   47.302070] RSP: 0018:ffff99cac101bb10 EFLAGS: 00010246
[   47.302070] RAX: 0000000000000000 RBX: 00007012c6116000 RCX: ffff99cac101bb60
[   47.302071] RDX: ffff99cac101bb58 RSI: 00007012c6116000 RDI: ffff8923b71d0da8
[   47.302071] RBP: ffff99cac101bb48 R08: ffff99cac101bd18 R09: 0000000000000000
[   47.302072] R10: 0000000000000000 R11: 0000000000000000 R12: ffff99cac101bba8
[   47.302072] R13: 0000000000000000 R14: ffff99cac101bb58 R15: ffff892312bdee00
[   47.302073] FS:  0000000000000000(0000) GS:ffff892a9e900000(0000) knlGS:0000000000000000
[   47.302073] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   47.302074] CR2: 000070e8b04ee200 CR3: 000000012aa3e000 CR4: 0000000000f50ef0
[   47.302074] PKRU: 55555554
[   47.302074] Call Trace:
[   47.302075]  <TASK>
[   47.302075]  ? show_regs+0x6c/0x80
[   47.302076]  ? __warn+0x88/0x140
[   47.302078]  ? follow_pte+0x220/0x230
[   47.302079]  ? report_bug+0x182/0x1b0
[   47.302080]  ? handle_bug+0x51/0xa0
[   47.302082]  ? exc_invalid_op+0x18/0x80
[   47.302083]  ? asm_exc_invalid_op+0x1b/0x20
[   47.302084]  ? follow_pte+0x220/0x230
[   47.302086]  follow_phys+0x4e/0x110
[   47.302087]  untrack_pfn+0x57/0x130
[   47.302089]  unmap_single_vma+0xbc/0xf0
[   47.302090]  zap_page_range_single+0x138/0x210
[   47.302091]  unmap_mapping_range+0x11b/0x140
[   47.302092]  nv_revoke_gpu_mappings+0x68/0xc0 [nvidia]
[   47.302211]  _nv000741rm+0x35/0xf6 [nvidia]
[   47.302383]  ? rm_execute_work_item+0x141/0x1f0 [nvidia]
[   47.302541]  ? os_execute_work_item+0x6c/0x90 [nvidia]
[   47.302648]  ? _main_loop+0x7e/0x140 [nvidia]
[   47.302757]  ? __pfx__main_loop+0x10/0x10 [nvidia]
[   47.302891]  ? kthread+0xe1/0x110
[   47.302892]  ? __pfx_kthread+0x10/0x10
[   47.302893]  ? ret_from_fork+0x44/0x70
[   47.302894]  ? __pfx_kthread+0x10/0x10
[   47.302895]  ? ret_from_fork_asm+0x1a/0x30
[   47.302897]  </TASK>
[   47.302897] ---[ end trace 0000000000000000 ]---
[   47.302902] ------------[ cut here ]------------
[   47.302902] WARNING: CPU: 2 PID: 1141 at include/linux/rwsem.h:80 follow_pte+0x220/0x230
[   47.302904] Modules linked in: nvidia_uvm(POE) ccm(E) rfcomm(E) snd_seq_dummy(E) snd_hrtimer(E) qrtr(E) cmac(E) algif_hash(E) algif_skcipher(E) af_alg(E) bnep(E) xe(E) snd_hda_codec_realtek(E) drm_gpuvm(E) drm_exec(E) snd_hda_codec_generic(E) gpu_sched(E) drm_suballoc_helper(E) snd_hda_scodec_component(E) binfmt_misc(E) nls_iso8859_1(E) nvidia_drm(POE) nvidia_modeset(POE) nvidia(POE) intel_uncore_frequency(E) intel_uncore_frequency_common(E) intel_tcc_cooling(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) snd_hda_codec_hdmi(E) snd_sof_pci_intel_tgl(E) snd_sof_pci_intel_cnl(E) snd_sof_intel_hda_generic(E) soundwire_intel(E) soundwire_cadence(E) snd_sof_intel_hda_common(E) snd_sof_intel_hda_mlink(E) snd_sof_intel_hda(E) snd_sof_pci(E) snd_sof_xtensa_dsp(E) snd_sof(E) snd_sof_utils(E) snd_soc_hdac_hda(E) snd_soc_acpi_intel_match(E) soundwire_generic_allocation(E) snd_soc_acpi(E) soundwire_bus(E) snd_soc_avs(E) snd_soc_hda_codec(E) snd_hda_ext_core(E) snd_soc_core(E) snd_compress(E) a
 c97_bus(E) snd_pcm_dmaengine(E)
[   47.302917]  snd_hda_intel(E) snd_intel_dspcfg(E) snd_intel_sdw_acpi(E) snd_hda_codec(E) snd_hda_core(E) snd_hwdep(E) snd_pcm(E) uvcvideo(E) videobuf2_vmalloc(E) iwlmvm(E) btusb(E) snd_seq_midi(E) uvc(E) coretemp(E) btrtl(E) videobuf2_memops(E) i915(E) snd_seq_midi_event(E) btintel(E) videobuf2_v4l2(E) mac80211(E) kvm_intel(E) snd_rawmidi(E) btbcm(E) videodev(E) btmtk(E) videobuf2_common(E) ite_829x(OE) snd_seq(E) libarc4(E) drm_buddy(E) mc(E) led_class_multicolor(E) processor_thermal_device_pci(E) bluetooth(E) kvm(E) snd_seq_device(E) spd5118(E) processor_thermal_device(E) drm_display_helper(E) cmdlinepart(E) iwlwifi(E) mei_hdcp(E) mei_pxp(E) snd_timer(E) processor_thermal_wt_hint(E) processor_thermal_rfim(E) cec(E) spi_nor(E) rapl(E) processor_thermal_rapl(E) mtd(E) intel_rapl_msr(E) i2c_i801(E) snd(E) drm_ttm_helper(E) nvidia_wmi_ec_backlight(E) mxm_wmi(E) intel_cstate(E) intel_rapl_common(E) rc_core(E) i2c_mux(E) mei_me(E) processor_thermal_wt_req(E) soundcore(E) spi_intel_pci
 (E) cfg80211(E) ttm(E) i2c_smbus(E)
[   47.302936]  i2c_algo_bit(E) processor_thermal_power_floor(E) spi_intel(E) mei(E) processor_thermal_mbox(E) intel_pmc_core(E) int3403_thermal(E) int340x_thermal_zone(E) intel_vsec(E) int3400_thermal(E) pmt_telemetry(E) intel_hid(E) pmt_class(E) acpi_thermal_rel(E) joydev(E) sparse_keymap(E) acpi_pad(E) input_leds(E) mac_hid(E) serio_raw(E) sch_fq_codel(E) msr(E) parport_pc(E) ppdev(E) lp(E) nvme_fabrics(E) parport(E) nvme_keyring(E) efi_pstore(E) nfnetlink(E) dmi_sysfs(E) ip_tables(E) x_tables(E) autofs4(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) libcrc32c(E) dm_crypt(E) dm_mirror(E) dm_region_hash(E) dm_log(E) usbhid(E) nvme(E) hid_multitouch(E) hid_generic(E) nvme_core(E) nvme_auth(E) crct10dif_pclmul(E) crc32_pclmul(E) polyval_clmulni(E) polyval_generic(E) ghash_clmulni_intel(E) sha256_ssse3(E) thunderbolt(E) sha1_ssse3(E) ucsi_acpi(E) psmouse(E) intel_lpss_pci(E) typec_ucsi(E) igc(E) xhci_pci(E) intel_lpss(E) xhci_pci_renesas(E) vmd(E) idma64(E) typec(E) i2c_hid_acpi(E)
  i2c_hid(E) hid(E) video(E) wmi(E)
[   47.302952]  pinctrl_alderlake(E) aesni_intel(E) crypto_simd(E) cryptd(E)
[   47.302954] CPU: 2 UID: 0 PID: 1141 Comm: nv_queue Tainted: P        W  OE      6.11.5 #1
[   47.302955] Tainted: [P]=PROPRIETARY_MODULE, [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[   47.302955] Hardware name: Notebook X370SNx1/X370SNx1, BIOS 1.07.03aMIN29 09/18/2024
[   47.302955] RIP: 0010:follow_pte+0x220/0x230
[   47.302957] Code: 15 75 33 8c 01 48 81 e2 00 00 00 c0 e9 7b ff ff ff 48 8b 45 d0 48 8b 38 e8 8d e9 e1 00 e8 18 e6 da ff 41 bc ea ff ff ff eb 9f <0f> 0b e9 0d fe ff ff 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
[   47.302958] RSP: 0018:ffff99cac101bb10 EFLAGS: 00010246
[   47.302958] RAX: 0000000000000000 RBX: 00007741fa530000 RCX: ffff99cac101bb60
[   47.302959] RDX: ffff99cac101bb58 RSI: 00007741fa530000 RDI: ffff89239728a8a0
[   47.302959] RBP: ffff99cac101bb48 R08: ffff99cac101bd18 R09: 0000000000000000
[   47.302960] R10: 0000000000000000 R11: 0000000000000000 R12: ffff99cac101bba8
[   47.302960] R13: 0000000000000000 R14: ffff99cac101bb58 R15: ffff892316d19080
[   47.302960] FS:  0000000000000000(0000) GS:ffff892a9e900000(0000) knlGS:0000000000000000
[   47.302961] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   47.302962] CR2: 000070e8b04ee200 CR3: 000000012aa3e000 CR4: 0000000000f50ef0
[   47.302962] PKRU: 55555554
[   47.302962] Call Trace:
[   47.302963]  <TASK>
[   47.302963]  ? show_regs+0x6c/0x80
[   47.302964]  ? __warn+0x88/0x140
[   47.302966]  ? follow_pte+0x220/0x230
[   47.302967]  ? report_bug+0x182/0x1b0
[   47.302968]  ? handle_bug+0x51/0xa0
[   47.302970]  ? exc_invalid_op+0x18/0x80
[   47.302971]  ? asm_exc_invalid_op+0x1b/0x20
[   47.302973]  ? follow_pte+0x220/0x230
[   47.302975]  follow_phys+0x4e/0x110
[   47.302976]  untrack_pfn+0x57/0x130
[   47.302978]  unmap_single_vma+0xbc/0xf0
[   47.302979]  zap_page_range_single+0x138/0x210
[   47.302980]  unmap_mapping_range+0x11b/0x140
[   47.302982]  nv_revoke_gpu_mappings+0x68/0xc0 [nvidia]
[   47.303100]  _nv000741rm+0x35/0xf6 [nvidia]
[   47.303282]  ? rm_execute_work_item+0x141/0x1f0 [nvidia]
[   47.303454]  ? os_execute_work_item+0x6c/0x90 [nvidia]
[   47.303562]  ? _main_loop+0x7e/0x140 [nvidia]
[   47.303670]  ? __pfx__main_loop+0x10/0x10 [nvidia]
[   47.303778]  ? kthread+0xe1/0x110
[   47.303779]  ? __pfx_kthread+0x10/0x10
[   47.303779]  ? ret_from_fork+0x44/0x70
[   47.303780]  ? __pfx_kthread+0x10/0x10
[   47.303781]  ? ret_from_fork_asm+0x1a/0x30
[   47.303782]  </TASK>
[   47.303783] ---[ end trace 0000000000000000 ]---
[   47.303786] ------------[ cut here ]------------
[   47.303787] WARNING: CPU: 2 PID: 1141 at include/linux/rwsem.h:80 follow_pte+0x220/0x230
[   47.303788] Modules linked in: nvidia_uvm(POE) ccm(E) rfcomm(E) snd_seq_dummy(E) snd_hrtimer(E) qrtr(E) cmac(E) algif_hash(E) algif_skcipher(E) af_alg(E) bnep(E) xe(E) snd_hda_codec_realtek(E) drm_gpuvm(E) drm_exec(E) snd_hda_codec_generic(E) gpu_sched(E) drm_suballoc_helper(E) snd_hda_scodec_component(E) binfmt_misc(E) nls_iso8859_1(E) nvidia_drm(POE) nvidia_modeset(POE) nvidia(POE) intel_uncore_frequency(E) intel_uncore_frequency_common(E) intel_tcc_cooling(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) snd_hda_codec_hdmi(E) snd_sof_pci_intel_tgl(E) snd_sof_pci_intel_cnl(E) snd_sof_intel_hda_generic(E) soundwire_intel(E) soundwire_cadence(E) snd_sof_intel_hda_common(E) snd_sof_intel_hda_mlink(E) snd_sof_intel_hda(E) snd_sof_pci(E) snd_sof_xtensa_dsp(E) snd_sof(E) snd_sof_utils(E) snd_soc_hdac_hda(E) snd_soc_acpi_intel_match(E) soundwire_generic_allocation(E) snd_soc_acpi(E) soundwire_bus(E) snd_soc_avs(E) snd_soc_hda_codec(E) snd_hda_ext_core(E) snd_soc_core(E) snd_compress(E) a
 c97_bus(E) snd_pcm_dmaengine(E)
[   47.303800]  snd_hda_intel(E) snd_intel_dspcfg(E) snd_intel_sdw_acpi(E) snd_hda_codec(E) snd_hda_core(E) snd_hwdep(E) snd_pcm(E) uvcvideo(E) videobuf2_vmalloc(E) iwlmvm(E) btusb(E) snd_seq_midi(E) uvc(E) coretemp(E) btrtl(E) videobuf2_memops(E) i915(E) snd_seq_midi_event(E) btintel(E) videobuf2_v4l2(E) mac80211(E) kvm_intel(E) snd_rawmidi(E) btbcm(E) videodev(E) btmtk(E) videobuf2_common(E) ite_829x(OE) snd_seq(E) libarc4(E) drm_buddy(E) mc(E) led_class_multicolor(E) processor_thermal_device_pci(E) bluetooth(E) kvm(E) snd_seq_device(E) spd5118(E) processor_thermal_device(E) drm_display_helper(E) cmdlinepart(E) iwlwifi(E) mei_hdcp(E) mei_pxp(E) snd_timer(E) processor_thermal_wt_hint(E) processor_thermal_rfim(E) cec(E) spi_nor(E) rapl(E) processor_thermal_rapl(E) mtd(E) intel_rapl_msr(E) i2c_i801(E) snd(E) drm_ttm_helper(E) nvidia_wmi_ec_backlight(E) mxm_wmi(E) intel_cstate(E) intel_rapl_common(E) rc_core(E) i2c_mux(E) mei_me(E) processor_thermal_wt_req(E) soundcore(E) spi_intel_pci
 (E) cfg80211(E) ttm(E) i2c_smbus(E)
[   47.303814]  i2c_algo_bit(E) processor_thermal_power_floor(E) spi_intel(E) mei(E) processor_thermal_mbox(E) intel_pmc_core(E) int3403_thermal(E) int340x_thermal_zone(E) intel_vsec(E) int3400_thermal(E) pmt_telemetry(E) intel_hid(E) pmt_class(E) acpi_thermal_rel(E) joydev(E) sparse_keymap(E) acpi_pad(E) input_leds(E) mac_hid(E) serio_raw(E) sch_fq_codel(E) msr(E) parport_pc(E) ppdev(E) lp(E) nvme_fabrics(E) parport(E) nvme_keyring(E) efi_pstore(E) nfnetlink(E) dmi_sysfs(E) ip_tables(E) x_tables(E) autofs4(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) libcrc32c(E) dm_crypt(E) dm_mirror(E) dm_region_hash(E) dm_log(E) usbhid(E) nvme(E) hid_multitouch(E) hid_generic(E) nvme_core(E) nvme_auth(E) crct10dif_pclmul(E) crc32_pclmul(E) polyval_clmulni(E) polyval_generic(E) ghash_clmulni_intel(E) sha256_ssse3(E) thunderbolt(E) sha1_ssse3(E) ucsi_acpi(E) psmouse(E) intel_lpss_pci(E) typec_ucsi(E) igc(E) xhci_pci(E) intel_lpss(E) xhci_pci_renesas(E) vmd(E) idma64(E) typec(E) i2c_hid_acpi(E)
  i2c_hid(E) hid(E) video(E) wmi(E)
[   47.303828]  pinctrl_alderlake(E) aesni_intel(E) crypto_simd(E) cryptd(E)
[   47.303829] CPU: 2 UID: 0 PID: 1141 Comm: nv_queue Tainted: P        W  OE      6.11.5 #1
[   47.303831] Tainted: [P]=PROPRIETARY_MODULE, [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[   47.303831] Hardware name: Notebook X370SNx1/X370SNx1, BIOS 1.07.03aMIN29 09/18/2024
[   47.303831] RIP: 0010:follow_pte+0x220/0x230
[   47.303833] Code: 15 75 33 8c 01 48 81 e2 00 00 00 c0 e9 7b ff ff ff 48 8b 45 d0 48 8b 38 e8 8d e9 e1 00 e8 18 e6 da ff 41 bc ea ff ff ff eb 9f <0f> 0b e9 0d fe ff ff 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
[   47.303833] RSP: 0018:ffff99cac101bb10 EFLAGS: 00010246
[   47.303838] RAX: 0000000000000000 RBX: 00007d5c1e3b4000 RCX: ffff99cac101bb60
[   47.303838] RDX: ffff99cac101bb58 RSI: 00007d5c1e3b4000 RDI: ffff8923b71f52b0
[   47.303839] RBP: ffff99cac101bb48 R08: ffff99cac101bd18 R09: 0000000000000000
[   47.303840] R10: 0000000000000000 R11: 0000000000000000 R12: ffff99cac101bba8
[   47.303840] R13: 0000000000000000 R14: ffff99cac101bb58 R15: ffff89230d400b00
[   47.303841] FS:  0000000000000000(0000) GS:ffff892a9e900000(0000) knlGS:0000000000000000
[   47.303842] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   47.303843] CR2: 000070e8b04ee200 CR3: 000000012aa3e000 CR4: 0000000000f50ef0
[   47.303843] PKRU: 55555554
[   47.303844] Call Trace:
[   47.303844]  <TASK>
[   47.303844]  ? show_regs+0x6c/0x80
[   47.303845]  ? __warn+0x88/0x140
[   47.303847]  ? follow_pte+0x220/0x230
[   47.303849]  ? report_bug+0x182/0x1b0
[   47.303850]  ? handle_bug+0x51/0xa0
[   47.303851]  ? exc_invalid_op+0x18/0x80
[   47.303853]  ? asm_exc_invalid_op+0x1b/0x20
[   47.303854]  ? follow_pte+0x220/0x230
[   47.303856]  follow_phys+0x4e/0x110
[   47.303857]  untrack_pfn+0x57/0x130
[   47.303859]  unmap_single_vma+0xbc/0xf0
[   47.303860]  zap_page_range_single+0x138/0x210
[   47.303861]  unmap_mapping_range+0x11b/0x140
[   47.303862]  nv_revoke_gpu_mappings+0x68/0xc0 [nvidia]
[   47.303975]  _nv000741rm+0x35/0xf6 [nvidia]
[   47.304149]  ? rm_execute_work_item+0x141/0x1f0 [nvidia]
[   47.304326]  ? os_execute_work_item+0x6c/0x90 [nvidia]
[   47.304446]  ? _main_loop+0x7e/0x140 [nvidia]
[   47.304563]  ? __pfx__main_loop+0x10/0x10 [nvidia]
[   47.304670]  ? kthread+0xe1/0x110
[   47.304671]  ? __pfx_kthread+0x10/0x10
[   47.304672]  ? ret_from_fork+0x44/0x70
[   47.304672]  ? __pfx_kthread+0x10/0x10
[   47.304673]  ? ret_from_fork_asm+0x1a/0x30
[   47.304674]  </TASK>
[   47.304675] ---[ end trace 0000000000000000 ]---
[   47.304678] ------------[ cut here ]------------
[   47.304678] WARNING: CPU: 2 PID: 1141 at include/linux/rwsem.h:80 follow_pte+0x220/0x230
[   47.304680] Modules linked in: nvidia_uvm(POE) ccm(E) rfcomm(E) snd_seq_dummy(E) snd_hrtimer(E) qrtr(E) cmac(E) algif_hash(E) algif_skcipher(E) af_alg(E) bnep(E) xe(E) snd_hda_codec_realtek(E) drm_gpuvm(E) drm_exec(E) snd_hda_codec_generic(E) gpu_sched(E) drm_suballoc_helper(E) snd_hda_scodec_component(E) binfmt_misc(E) nls_iso8859_1(E) nvidia_drm(POE) nvidia_modeset(POE) nvidia(POE) intel_uncore_frequency(E) intel_uncore_frequency_common(E) intel_tcc_cooling(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) snd_hda_codec_hdmi(E) snd_sof_pci_intel_tgl(E) snd_sof_pci_intel_cnl(E) snd_sof_intel_hda_generic(E) soundwire_intel(E) soundwire_cadence(E) snd_sof_intel_hda_common(E) snd_sof_intel_hda_mlink(E) snd_sof_intel_hda(E) snd_sof_pci(E) snd_sof_xtensa_dsp(E) snd_sof(E) snd_sof_utils(E) snd_soc_hdac_hda(E) snd_soc_acpi_intel_match(E) soundwire_generic_allocation(E) snd_soc_acpi(E) soundwire_bus(E) snd_soc_avs(E) snd_soc_hda_codec(E) snd_hda_ext_core(E) snd_soc_core(E) snd_compress(E) a
 c97_bus(E) snd_pcm_dmaengine(E)
[   47.304692]  snd_hda_intel(E) snd_intel_dspcfg(E) snd_intel_sdw_acpi(E) snd_hda_codec(E) snd_hda_core(E) snd_hwdep(E) snd_pcm(E) uvcvideo(E) videobuf2_vmalloc(E) iwlmvm(E) btusb(E) snd_seq_midi(E) uvc(E) coretemp(E) btrtl(E) videobuf2_memops(E) i915(E) snd_seq_midi_event(E) btintel(E) videobuf2_v4l2(E) mac80211(E) kvm_intel(E) snd_rawmidi(E) btbcm(E) videodev(E) btmtk(E) videobuf2_common(E) ite_829x(OE) snd_seq(E) libarc4(E) drm_buddy(E) mc(E) led_class_multicolor(E) processor_thermal_device_pci(E) bluetooth(E) kvm(E) snd_seq_device(E) spd5118(E) processor_thermal_device(E) drm_display_helper(E) cmdlinepart(E) iwlwifi(E) mei_hdcp(E) mei_pxp(E) snd_timer(E) processor_thermal_wt_hint(E) processor_thermal_rfim(E) cec(E) spi_nor(E) rapl(E) processor_thermal_rapl(E) mtd(E) intel_rapl_msr(E) i2c_i801(E) snd(E) drm_ttm_helper(E) nvidia_wmi_ec_backlight(E) mxm_wmi(E) intel_cstate(E) intel_rapl_common(E) rc_core(E) i2c_mux(E) mei_me(E) processor_thermal_wt_req(E) soundcore(E) spi_intel_pci
 (E) cfg80211(E) ttm(E) i2c_smbus(E)
[   47.304705]  i2c_algo_bit(E) processor_thermal_power_floor(E) spi_intel(E) mei(E) processor_thermal_mbox(E) intel_pmc_core(E) int3403_thermal(E) int340x_thermal_zone(E) intel_vsec(E) int3400_thermal(E) pmt_telemetry(E) intel_hid(E) pmt_class(E) acpi_thermal_rel(E) joydev(E) sparse_keymap(E) acpi_pad(E) input_leds(E) mac_hid(E) serio_raw(E) sch_fq_codel(E) msr(E) parport_pc(E) ppdev(E) lp(E) nvme_fabrics(E) parport(E) nvme_keyring(E) efi_pstore(E) nfnetlink(E) dmi_sysfs(E) ip_tables(E) x_tables(E) autofs4(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) libcrc32c(E) dm_crypt(E) dm_mirror(E) dm_region_hash(E) dm_log(E) usbhid(E) nvme(E) hid_multitouch(E) hid_generic(E) nvme_core(E) nvme_auth(E) crct10dif_pclmul(E) crc32_pclmul(E) polyval_clmulni(E) polyval_generic(E) ghash_clmulni_intel(E) sha256_ssse3(E) thunderbolt(E) sha1_ssse3(E) ucsi_acpi(E) psmouse(E) intel_lpss_pci(E) typec_ucsi(E) igc(E) xhci_pci(E) intel_lpss(E) xhci_pci_renesas(E) vmd(E) idma64(E) typec(E) i2c_hid_acpi(E)
  i2c_hid(E) hid(E) video(E) wmi(E)
[   47.304719]  pinctrl_alderlake(E) aesni_intel(E) crypto_simd(E) cryptd(E)
[   47.304720] CPU: 2 UID: 0 PID: 1141 Comm: nv_queue Tainted: P        W  OE      6.11.5 #1
[   47.304721] Tainted: [P]=PROPRIETARY_MODULE, [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[   47.304722] Hardware name: Notebook X370SNx1/X370SNx1, BIOS 1.07.03aMIN29 09/18/2024
[   47.304722] RIP: 0010:follow_pte+0x220/0x230
[   47.304723] Code: 15 75 33 8c 01 48 81 e2 00 00 00 c0 e9 7b ff ff ff 48 8b 45 d0 48 8b 38 e8 8d e9 e1 00 e8 18 e6 da ff 41 bc ea ff ff ff eb 9f <0f> 0b e9 0d fe ff ff 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
[   47.304724] RSP: 0018:ffff99cac101bb10 EFLAGS: 00010246
[   47.304724] RAX: 0000000000000000 RBX: 00007012c4edb000 RCX: ffff99cac101bb60
[   47.304725] RDX: ffff99cac101bb58 RSI: 00007012c4edb000 RDI: ffff8923b926bc08
[   47.304725] RBP: ffff99cac101bb48 R08: ffff99cac101bd18 R09: 0000000000000000
[   47.304726] R10: 0000000000000000 R11: 0000000000000000 R12: ffff99cac101bba8
[   47.304726] R13: 0000000000000000 R14: ffff99cac101bb58 R15: ffff892312bdee00
[   47.304726] FS:  0000000000000000(0000) GS:ffff892a9e900000(0000) knlGS:0000000000000000
[   47.304727] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   47.304727] CR2: 000070e8b04ee200 CR3: 000000012aa3e000 CR4: 0000000000f50ef0
[   47.304728] PKRU: 55555554
[   47.304728] Call Trace:
[   47.304728]  <TASK>
[   47.304729]  ? show_regs+0x6c/0x80
[   47.304730]  ? __warn+0x88/0x140
[   47.304731]  ? follow_pte+0x220/0x230
[   47.304732]  ? report_bug+0x182/0x1b0
[   47.304733]  ? handle_bug+0x51/0xa0
[   47.304735]  ? exc_invalid_op+0x18/0x80
[   47.304736]  ? asm_exc_invalid_op+0x1b/0x20
[   47.304737]  ? follow_pte+0x220/0x230
[   47.304738]  follow_phys+0x4e/0x110
[   47.304740]  untrack_pfn+0x57/0x130
[   47.304741]  unmap_single_vma+0xbc/0xf0
[   47.304742]  zap_page_range_single+0x138/0x210
[   47.304743]  unmap_mapping_range+0x11b/0x140
[   47.304744]  nv_revoke_gpu_mappings+0x68/0xc0 [nvidia]
[   47.304864]  _nv000741rm+0x35/0xf6 [nvidia]
[   47.305038]  ? rm_execute_work_item+0x141/0x1f0 [nvidia]
[   47.305217]  ? os_execute_work_item+0x6c/0x90 [nvidia]
[   47.305337]  ? _main_loop+0x7e/0x140 [nvidia]
[   47.305459]  ? __pfx__main_loop+0x10/0x10 [nvidia]
[   47.305579]  ? kthread+0xe1/0x110
[   47.305580]  ? __pfx_kthread+0x10/0x10
[   47.305581]  ? ret_from_fork+0x44/0x70
[   47.305582]  ? __pfx_kthread+0x10/0x10
[   47.305583]  ? ret_from_fork_asm+0x1a/0x30
[   47.305584]  </TASK>
[   47.305584] ---[ end trace 0000000000000000 ]---
[   47.305591] ------------[ cut here ]------------
[   47.305592] WARNING: CPU: 2 PID: 1141 at include/linux/rwsem.h:80 follow_pte+0x220/0x230
[   47.305594] Modules linked in: nvidia_uvm(POE) ccm(E) rfcomm(E) snd_seq_dummy(E) snd_hrtimer(E) qrtr(E) cmac(E) algif_hash(E) algif_skcipher(E) af_alg(E) bnep(E) xe(E) snd_hda_codec_realtek(E) drm_gpuvm(E) drm_exec(E) snd_hda_codec_generic(E) gpu_sched(E) drm_suballoc_helper(E) snd_hda_scodec_component(E) binfmt_misc(E) nls_iso8859_1(E) nvidia_drm(POE) nvidia_modeset(POE) nvidia(POE) intel_uncore_frequency(E) intel_uncore_frequency_common(E) intel_tcc_cooling(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) snd_hda_codec_hdmi(E) snd_sof_pci_intel_tgl(E) snd_sof_pci_intel_cnl(E) snd_sof_intel_hda_generic(E) soundwire_intel(E) soundwire_cadence(E) snd_sof_intel_hda_common(E) snd_sof_intel_hda_mlink(E) snd_sof_intel_hda(E) snd_sof_pci(E) snd_sof_xtensa_dsp(E) snd_sof(E) snd_sof_utils(E) snd_soc_hdac_hda(E) snd_soc_acpi_intel_match(E) soundwire_generic_allocation(E) snd_soc_acpi(E) soundwire_bus(E) snd_soc_avs(E) snd_soc_hda_codec(E) snd_hda_ext_core(E) snd_soc_core(E) snd_compress(E) a
 c97_bus(E) snd_pcm_dmaengine(E)
[   47.305607]  snd_hda_intel(E) snd_intel_dspcfg(E) snd_intel_sdw_acpi(E) snd_hda_codec(E) snd_hda_core(E) snd_hwdep(E) snd_pcm(E) uvcvideo(E) videobuf2_vmalloc(E) iwlmvm(E) btusb(E) snd_seq_midi(E) uvc(E) coretemp(E) btrtl(E) videobuf2_memops(E) i915(E) snd_seq_midi_event(E) btintel(E) videobuf2_v4l2(E) mac80211(E) kvm_intel(E) snd_rawmidi(E) btbcm(E) videodev(E) btmtk(E) videobuf2_common(E) ite_829x(OE) snd_seq(E) libarc4(E) drm_buddy(E) mc(E) led_class_multicolor(E) processor_thermal_device_pci(E) bluetooth(E) kvm(E) snd_seq_device(E) spd5118(E) processor_thermal_device(E) drm_display_helper(E) cmdlinepart(E) iwlwifi(E) mei_hdcp(E) mei_pxp(E) snd_timer(E) processor_thermal_wt_hint(E) processor_thermal_rfim(E) cec(E) spi_nor(E) rapl(E) processor_thermal_rapl(E) mtd(E) intel_rapl_msr(E) i2c_i801(E) snd(E) drm_ttm_helper(E) nvidia_wmi_ec_backlight(E) mxm_wmi(E) intel_cstate(E) intel_rapl_common(E) rc_core(E) i2c_mux(E) mei_me(E) processor_thermal_wt_req(E) soundcore(E) spi_intel_pci
 (E) cfg80211(E) ttm(E) i2c_smbus(E)
[   47.305622]  i2c_algo_bit(E) processor_thermal_power_floor(E) spi_intel(E) mei(E) processor_thermal_mbox(E) intel_pmc_core(E) int3403_thermal(E) int340x_thermal_zone(E) intel_vsec(E) int3400_thermal(E) pmt_telemetry(E) intel_hid(E) pmt_class(E) acpi_thermal_rel(E) joydev(E) sparse_keymap(E) acpi_pad(E) input_leds(E) mac_hid(E) serio_raw(E) sch_fq_codel(E) msr(E) parport_pc(E) ppdev(E) lp(E) nvme_fabrics(E) parport(E) nvme_keyring(E) efi_pstore(E) nfnetlink(E) dmi_sysfs(E) ip_tables(E) x_tables(E) autofs4(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) libcrc32c(E) dm_crypt(E) dm_mirror(E) dm_region_hash(E) dm_log(E) usbhid(E) nvme(E) hid_multitouch(E) hid_generic(E) nvme_core(E) nvme_auth(E) crct10dif_pclmul(E) crc32_pclmul(E) polyval_clmulni(E) polyval_generic(E) ghash_clmulni_intel(E) sha256_ssse3(E) thunderbolt(E) sha1_ssse3(E) ucsi_acpi(E) psmouse(E) intel_lpss_pci(E) typec_ucsi(E) igc(E) xhci_pci(E) intel_lpss(E) xhci_pci_renesas(E) vmd(E) idma64(E) typec(E) i2c_hid_acpi(E)
  i2c_hid(E) hid(E) video(E) wmi(E)
[   47.305638]  pinctrl_alderlake(E) aesni_intel(E) crypto_simd(E) cryptd(E)
[   47.305639] CPU: 2 UID: 0 PID: 1141 Comm: nv_queue Tainted: P        W  OE      6.11.5 #1
[   47.305641] Tainted: [P]=PROPRIETARY_MODULE, [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[   47.305641] Hardware name: Notebook X370SNx1/X370SNx1, BIOS 1.07.03aMIN29 09/18/2024
[   47.305641] RIP: 0010:follow_pte+0x220/0x230
[   47.305643] Code: 15 75 33 8c 01 48 81 e2 00 00 00 c0 e9 7b ff ff ff 48 8b 45 d0 48 8b 38 e8 8d e9 e1 00 e8 18 e6 da ff 41 bc ea ff ff ff eb 9f <0f> 0b e9 0d fe ff ff 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
[   47.305643] RSP: 0018:ffff99cac101bb10 EFLAGS: 00010246
[   47.305644] RAX: 0000000000000000 RBX: 00007012c612e000 RCX: ffff99cac101bb60
[   47.305645] RDX: ffff99cac101bb58 RSI: 00007012c612e000 RDI: ffff8923a00f9928
[   47.305645] RBP: ffff99cac101bb48 R08: ffff99cac101bd18 R09: 0000000000000000
[   47.305646] R10: 0000000000000000 R11: 0000000000000000 R12: ffff99cac101bba8
[   47.305646] R13: 0000000000000000 R14: ffff99cac101bb58 R15: ffff892312bdee00
[   47.305647] FS:  0000000000000000(0000) GS:ffff892a9e900000(0000) knlGS:0000000000000000
[   47.305647] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   47.305648] CR2: 000070e8b04ee200 CR3: 000000012aa3e000 CR4: 0000000000f50ef0
[   47.305648] PKRU: 55555554
[   47.305648] Call Trace:
[   47.305649]  <TASK>
[   47.305649]  ? show_regs+0x6c/0x80
[   47.305650]  ? __warn+0x88/0x140
[   47.305652]  ? follow_pte+0x220/0x230
[   47.305653]  ? report_bug+0x182/0x1b0
[   47.305654]  ? handle_bug+0x51/0xa0
[   47.305656]  ? exc_invalid_op+0x18/0x80
[   47.305657]  ? asm_exc_invalid_op+0x1b/0x20
[   47.305658]  ? follow_pte+0x220/0x230
[   47.305660]  follow_phys+0x4e/0x110
[   47.305662]  untrack_pfn+0x57/0x130
[   47.305663]  unmap_single_vma+0xbc/0xf0
[   47.305664]  zap_page_range_single+0x138/0x210
[   47.305665]  unmap_mapping_range+0x11b/0x140
[   47.305667]  nv_revoke_gpu_mappings+0x68/0xc0 [nvidia]
[   47.305786]  _nv000741rm+0x35/0xf6 [nvidia]
[   47.305981]  ? rm_execute_work_item+0x141/0x1f0 [nvidia]
[   47.306162]  ? os_execute_work_item+0x6c/0x90 [nvidia]
[   47.306281]  ? _main_loop+0x7e/0x140 [nvidia]
[   47.306402]  ? __pfx__main_loop+0x10/0x10 [nvidia]
[   47.306512]  ? kthread+0xe1/0x110
[   47.306513]  ? __pfx_kthread+0x10/0x10
[   47.306514]  ? ret_from_fork+0x44/0x70
[   47.306515]  ? __pfx_kthread+0x10/0x10
[   47.306516]  ? ret_from_fork_asm+0x1a/0x30
[   47.306517]  </TASK>
[   47.306517] ---[ end trace 0000000000000000 ]---
[   47.306522] ------------[ cut here ]------------
[   47.306522] WARNING: CPU: 2 PID: 1141 at include/linux/rwsem.h:80 follow_pte+0x220/0x230
[   47.306524] Modules linked in: nvidia_uvm(POE) ccm(E) rfcomm(E) snd_seq_dummy(E) snd_hrtimer(E) qrtr(E) cmac(E) algif_hash(E) algif_skcipher(E) af_alg(E) bnep(E) xe(E) snd_hda_codec_realtek(E) drm_gpuvm(E) drm_exec(E) snd_hda_codec_generic(E) gpu_sched(E) drm_suballoc_helper(E) snd_hda_scodec_component(E) binfmt_misc(E) nls_iso8859_1(E) nvidia_drm(POE) nvidia_modeset(POE) nvidia(POE) intel_uncore_frequency(E) intel_uncore_frequency_common(E) intel_tcc_cooling(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) snd_hda_codec_hdmi(E) snd_sof_pci_intel_tgl(E) snd_sof_pci_intel_cnl(E) snd_sof_intel_hda_generic(E) soundwire_intel(E) soundwire_cadence(E) snd_sof_intel_hda_common(E) snd_sof_intel_hda_mlink(E) snd_sof_intel_hda(E) snd_sof_pci(E) snd_sof_xtensa_dsp(E) snd_sof(E) snd_sof_utils(E) snd_soc_hdac_hda(E) snd_soc_acpi_intel_match(E) soundwire_generic_allocation(E) snd_soc_acpi(E) soundwire_bus(E) snd_soc_avs(E) snd_soc_hda_codec(E) snd_hda_ext_core(E) snd_soc_core(E) snd_compress(E) a
 c97_bus(E) snd_pcm_dmaengine(E)
[   47.306535]  snd_hda_intel(E) snd_intel_dspcfg(E) snd_intel_sdw_acpi(E) snd_hda_codec(E) snd_hda_core(E) snd_hwdep(E) snd_pcm(E) uvcvideo(E) videobuf2_vmalloc(E) iwlmvm(E) btusb(E) snd_seq_midi(E) uvc(E) coretemp(E) btrtl(E) videobuf2_memops(E) i915(E) snd_seq_midi_event(E) btintel(E) videobuf2_v4l2(E) mac80211(E) kvm_intel(E) snd_rawmidi(E) btbcm(E) videodev(E) btmtk(E) videobuf2_common(E) ite_829x(OE) snd_seq(E) libarc4(E) drm_buddy(E) mc(E) led_class_multicolor(E) processor_thermal_device_pci(E) bluetooth(E) kvm(E) snd_seq_device(E) spd5118(E) processor_thermal_device(E) drm_display_helper(E) cmdlinepart(E) iwlwifi(E) mei_hdcp(E) mei_pxp(E) snd_timer(E) processor_thermal_wt_hint(E) processor_thermal_rfim(E) cec(E) spi_nor(E) rapl(E) processor_thermal_rapl(E) mtd(E) intel_rapl_msr(E) i2c_i801(E) snd(E) drm_ttm_helper(E) nvidia_wmi_ec_backlight(E) mxm_wmi(E) intel_cstate(E) intel_rapl_common(E) rc_core(E) i2c_mux(E) mei_me(E) processor_thermal_wt_req(E) soundcore(E) spi_intel_pci
 (E) cfg80211(E) ttm(E) i2c_smbus(E)
[   47.306549]  i2c_algo_bit(E) processor_thermal_power_floor(E) spi_intel(E) mei(E) processor_thermal_mbox(E) intel_pmc_core(E) int3403_thermal(E) int340x_thermal_zone(E) intel_vsec(E) int3400_thermal(E) pmt_telemetry(E) intel_hid(E) pmt_class(E) acpi_thermal_rel(E) joydev(E) sparse_keymap(E) acpi_pad(E) input_leds(E) mac_hid(E) serio_raw(E) sch_fq_codel(E) msr(E) parport_pc(E) ppdev(E) lp(E) nvme_fabrics(E) parport(E) nvme_keyring(E) efi_pstore(E) nfnetlink(E) dmi_sysfs(E) ip_tables(E) x_tables(E) autofs4(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) libcrc32c(E) dm_crypt(E) dm_mirror(E) dm_region_hash(E) dm_log(E) usbhid(E) nvme(E) hid_multitouch(E) hid_generic(E) nvme_core(E) nvme_auth(E) crct10dif_pclmul(E) crc32_pclmul(E) polyval_clmulni(E) polyval_generic(E) ghash_clmulni_intel(E) sha256_ssse3(E) thunderbolt(E) sha1_ssse3(E) ucsi_acpi(E) psmouse(E) intel_lpss_pci(E) typec_ucsi(E) igc(E) xhci_pci(E) intel_lpss(E) xhci_pci_renesas(E) vmd(E) idma64(E) typec(E) i2c_hid_acpi(E)
  i2c_hid(E) hid(E) video(E) wmi(E)
[   47.306563]  pinctrl_alderlake(E) aesni_intel(E) crypto_simd(E) cryptd(E)
[   47.306564] CPU: 2 UID: 0 PID: 1141 Comm: nv_queue Tainted: P        W  OE      6.11.5 #1
[   47.306565] Tainted: [P]=PROPRIETARY_MODULE, [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[   47.306566] Hardware name: Notebook X370SNx1/X370SNx1, BIOS 1.07.03aMIN29 09/18/2024
[   47.306566] RIP: 0010:follow_pte+0x220/0x230
[   47.306567] Code: 15 75 33 8c 01 48 81 e2 00 00 00 c0 e9 7b ff ff ff 48 8b 45 d0 48 8b 38 e8 8d e9 e1 00 e8 18 e6 da ff 41 bc ea ff ff ff eb 9f <0f> 0b e9 0d fe ff ff 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
[   47.306568] RSP: 0018:ffff99cac101bb10 EFLAGS: 00010246
[   47.306569] RAX: 0000000000000000 RBX: 00007f65e7606000 RCX: ffff99cac101bb60
[   47.306569] RDX: ffff99cac101bb58 RSI: 00007f65e7606000 RDI: ffff8923357c1420
[   47.306569] RBP: ffff99cac101bb48 R08: ffff99cac101bd18 R09: 0000000000000000
[   47.306570] R10: 0000000000000000 R11: 0000000000000000 R12: ffff99cac101bba8
[   47.306570] R13: 0000000000000000 R14: ffff99cac101bb58 R15: ffff89230c1dc200
[   47.306571] FS:  0000000000000000(0000) GS:ffff892a9e900000(0000) knlGS:0000000000000000
[   47.306571] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   47.306571] CR2: 000070e8b04ee200 CR3: 000000012aa3e000 CR4: 0000000000f50ef0
[   47.306572] PKRU: 55555554
[   47.306572] Call Trace:
[   47.306572]  <TASK>
[   47.306573]  ? show_regs+0x6c/0x80
[   47.306574]  ? __warn+0x88/0x140
[   47.306575]  ? follow_pte+0x220/0x230
[   47.306577]  ? report_bug+0x182/0x1b0
[   47.306578]  ? handle_bug+0x51/0xa0
[   47.306579]  ? exc_invalid_op+0x18/0x80
[   47.306580]  ? asm_exc_invalid_op+0x1b/0x20
[   47.306581]  ? follow_pte+0x220/0x230
[   47.306583]  follow_phys+0x4e/0x110
[   47.306584]  untrack_pfn+0x57/0x130
[   47.306585]  unmap_single_vma+0xbc/0xf0
[   47.306586]  zap_page_range_single+0x138/0x210
[   47.306587]  unmap_mapping_range+0x11b/0x140
[   47.306589]  nv_revoke_gpu_mappings+0x68/0xc0 [nvidia]
[   47.306695]  _nv000741rm+0x35/0xf6 [nvidia]
[   47.306861]  ? rm_execute_work_item+0x141/0x1f0 [nvidia]
[   47.307032]  ? os_execute_work_item+0x6c/0x90 [nvidia]
[   47.307151]  ? _main_loop+0x7e/0x140 [nvidia]
[   47.307272]  ? __pfx__main_loop+0x10/0x10 [nvidia]
[   47.307392]  ? kthread+0xe1/0x110
[   47.307392]  ? __pfx_kthread+0x10/0x10
[   47.307393]  ? ret_from_fork+0x44/0x70
[   47.307394]  ? __pfx_kthread+0x10/0x10
[   47.307395]  ? ret_from_fork_asm+0x1a/0x30
[   47.307397]  </TASK>
[   47.307397] ---[ end trace 0000000000000000 ]---
[   47.307401] ------------[ cut here ]------------
[   47.307402] WARNING: CPU: 2 PID: 1141 at include/linux/rwsem.h:80 follow_pte+0x220/0x230
[   47.307404] Modules linked in: nvidia_uvm(POE) ccm(E) rfcomm(E) snd_seq_dummy(E) snd_hrtimer(E) qrtr(E) cmac(E) algif_hash(E) algif_skcipher(E) af_alg(E) bnep(E) xe(E) snd_hda_codec_realtek(E) drm_gpuvm(E) drm_exec(E) snd_hda_codec_generic(E) gpu_sched(E) drm_suballoc_helper(E) snd_hda_scodec_component(E) binfmt_misc(E) nls_iso8859_1(E) nvidia_drm(POE) nvidia_modeset(POE) nvidia(POE) intel_uncore_frequency(E) intel_uncore_frequency_common(E) intel_tcc_cooling(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) snd_hda_codec_hdmi(E) snd_sof_pci_intel_tgl(E) snd_sof_pci_intel_cnl(E) snd_sof_intel_hda_generic(E) soundwire_intel(E) soundwire_cadence(E) snd_sof_intel_hda_common(E) snd_sof_intel_hda_mlink(E) snd_sof_intel_hda(E) snd_sof_pci(E) snd_sof_xtensa_dsp(E) snd_sof(E) snd_sof_utils(E) snd_soc_hdac_hda(E) snd_soc_acpi_intel_match(E) soundwire_generic_allocation(E) snd_soc_acpi(E) soundwire_bus(E) snd_soc_avs(E) snd_soc_hda_codec(E) snd_hda_ext_core(E) snd_soc_core(E) snd_compress(E) a
 c97_bus(E) snd_pcm_dmaengine(E)
[   47.307416]  snd_hda_intel(E) snd_intel_dspcfg(E) snd_intel_sdw_acpi(E) snd_hda_codec(E) snd_hda_core(E) snd_hwdep(E) snd_pcm(E) uvcvideo(E) videobuf2_vmalloc(E) iwlmvm(E) btusb(E) snd_seq_midi(E) uvc(E) coretemp(E) btrtl(E) videobuf2_memops(E) i915(E) snd_seq_midi_event(E) btintel(E) videobuf2_v4l2(E) mac80211(E) kvm_intel(E) snd_rawmidi(E) btbcm(E) videodev(E) btmtk(E) videobuf2_common(E) ite_829x(OE) snd_seq(E) libarc4(E) drm_buddy(E) mc(E) led_class_multicolor(E) processor_thermal_device_pci(E) bluetooth(E) kvm(E) snd_seq_device(E) spd5118(E) processor_thermal_device(E) drm_display_helper(E) cmdlinepart(E) iwlwifi(E) mei_hdcp(E) mei_pxp(E) snd_timer(E) processor_thermal_wt_hint(E) processor_thermal_rfim(E) cec(E) spi_nor(E) rapl(E) processor_thermal_rapl(E) mtd(E) intel_rapl_msr(E) i2c_i801(E) snd(E) drm_ttm_helper(E) nvidia_wmi_ec_backlight(E) mxm_wmi(E) intel_cstate(E) intel_rapl_common(E) rc_core(E) i2c_mux(E) mei_me(E) processor_thermal_wt_req(E) soundcore(E) spi_intel_pci
 (E) cfg80211(E) ttm(E) i2c_smbus(E)
[   47.307432]  i2c_algo_bit(E) processor_thermal_power_floor(E) spi_intel(E) mei(E) processor_thermal_mbox(E) intel_pmc_core(E) int3403_thermal(E) int340x_thermal_zone(E) intel_vsec(E) int3400_thermal(E) pmt_telemetry(E) intel_hid(E) pmt_class(E) acpi_thermal_rel(E) joydev(E) sparse_keymap(E) acpi_pad(E) input_leds(E) mac_hid(E) serio_raw(E) sch_fq_codel(E) msr(E) parport_pc(E) ppdev(E) lp(E) nvme_fabrics(E) parport(E) nvme_keyring(E) efi_pstore(E) nfnetlink(E) dmi_sysfs(E) ip_tables(E) x_tables(E) autofs4(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) libcrc32c(E) dm_crypt(E) dm_mirror(E) dm_region_hash(E) dm_log(E) usbhid(E) nvme(E) hid_multitouch(E) hid_generic(E) nvme_core(E) nvme_auth(E) crct10dif_pclmul(E) crc32_pclmul(E) polyval_clmulni(E) polyval_generic(E) ghash_clmulni_intel(E) sha256_ssse3(E) thunderbolt(E) sha1_ssse3(E) ucsi_acpi(E) psmouse(E) intel_lpss_pci(E) typec_ucsi(E) igc(E) xhci_pci(E) intel_lpss(E) xhci_pci_renesas(E) vmd(E) idma64(E) typec(E) i2c_hid_acpi(E)
  i2c_hid(E) hid(E) video(E) wmi(E)
[   47.307447]  pinctrl_alderlake(E) aesni_intel(E) crypto_simd(E) cryptd(E)
[   47.307449] CPU: 2 UID: 0 PID: 1141 Comm: nv_queue Tainted: P        W  OE      6.11.5 #1
[   47.307450] Tainted: [P]=PROPRIETARY_MODULE, [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[   47.307450] Hardware name: Notebook X370SNx1/X370SNx1, BIOS 1.07.03aMIN29 09/18/2024
[   47.307451] RIP: 0010:follow_pte+0x220/0x230
[   47.307452] Code: 15 75 33 8c 01 48 81 e2 00 00 00 c0 e9 7b ff ff ff 48 8b 45 d0 48 8b 38 e8 8d e9 e1 00 e8 18 e6 da ff 41 bc ea ff ff ff eb 9f <0f> 0b e9 0d fe ff ff 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
[   47.307453] RSP: 0018:ffff99cac101bb10 EFLAGS: 00010246
[   47.307453] RAX: 0000000000000000 RBX: 00007981b3cf8000 RCX: ffff99cac101bb60
[   47.307454] RDX: ffff99cac101bb58 RSI: 00007981b3cf8000 RDI: ffff89231b5bcac8
[   47.307454] RBP: ffff99cac101bb48 R08: ffff99cac101bd18 R09: 0000000000000000
[   47.307455] R10: 0000000000000000 R11: 0000000000000000 R12: ffff99cac101bba8
[   47.307455] R13: 0000000000000000 R14: ffff99cac101bb58 R15: ffff8923086a5d80
[   47.307456] FS:  0000000000000000(0000) GS:ffff892a9e900000(0000) knlGS:0000000000000000
[   47.307456] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   47.307457] CR2: 000070e8b04ee200 CR3: 000000012aa3e000 CR4: 0000000000f50ef0
[   47.307457] PKRU: 55555554
[   47.307457] Call Trace:
[   47.307458]  <TASK>
[   47.307458]  ? show_regs+0x6c/0x80
[   47.307459]  ? __warn+0x88/0x140
[   47.307461]  ? follow_pte+0x220/0x230
[   47.307462]  ? report_bug+0x182/0x1b0
[   47.307463]  ? handle_bug+0x51/0xa0
[   47.307465]  ? exc_invalid_op+0x18/0x80
[   47.307466]  ? asm_exc_invalid_op+0x1b/0x20
[   47.307467]  ? follow_pte+0x220/0x230
[   47.307469]  follow_phys+0x4e/0x110
[   47.307470]  untrack_pfn+0x57/0x130
[   47.307472]  unmap_single_vma+0xbc/0xf0
[   47.307473]  zap_page_range_single+0x138/0x210
[   47.307474]  unmap_mapping_range+0x11b/0x140
[   47.307475]  nv_revoke_gpu_mappings+0x68/0xc0 [nvidia]
[   47.307594]  _nv000741rm+0x35/0xf6 [nvidia]
[   47.307774]  ? rm_execute_work_item+0x141/0x1f0 [nvidia]
[   47.307968]  ? os_execute_work_item+0x6c/0x90 [nvidia]
[   47.308089]  ? _main_loop+0x7e/0x140 [nvidia]
[   47.308210]  ? __pfx__main_loop+0x10/0x10 [nvidia]
[   47.308329]  ? kthread+0xe1/0x110
[   47.308329]  ? __pfx_kthread+0x10/0x10
[   47.308330]  ? ret_from_fork+0x44/0x70
[   47.308331]  ? __pfx_kthread+0x10/0x10
[   47.308332]  ? ret_from_fork_asm+0x1a/0x30
[   47.308334]  </TASK>
[   47.308334] ---[ end trace 0000000000000000 ]---
[   47.308341] ------------[ cut here ]------------
[   47.308341] WARNING: CPU: 2 PID: 1141 at include/linux/rwsem.h:80 follow_pte+0x220/0x230
[   47.308343] Modules linked in: nvidia_uvm(POE) ccm(E) rfcomm(E) snd_seq_dummy(E) snd_hrtimer(E) qrtr(E) cmac(E) algif_hash(E) algif_skcipher(E) af_alg(E) bnep(E) xe(E) snd_hda_codec_realtek(E) drm_gpuvm(E) drm_exec(E) snd_hda_codec_generic(E) gpu_sched(E) drm_suballoc_helper(E) snd_hda_scodec_component(E) binfmt_misc(E) nls_iso8859_1(E) nvidia_drm(POE) nvidia_modeset(POE) nvidia(POE) intel_uncore_frequency(E) intel_uncore_frequency_common(E) intel_tcc_cooling(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) snd_hda_codec_hdmi(E) snd_sof_pci_intel_tgl(E) snd_sof_pci_intel_cnl(E) snd_sof_intel_hda_generic(E) soundwire_intel(E) soundwire_cadence(E) snd_sof_intel_hda_common(E) snd_sof_intel_hda_mlink(E) snd_sof_intel_hda(E) snd_sof_pci(E) snd_sof_xtensa_dsp(E) snd_sof(E) snd_sof_utils(E) snd_soc_hdac_hda(E) snd_soc_acpi_intel_match(E) soundwire_generic_allocation(E) snd_soc_acpi(E) soundwire_bus(E) snd_soc_avs(E) snd_soc_hda_codec(E) snd_hda_ext_core(E) snd_soc_core(E) snd_compress(E) a
 c97_bus(E) snd_pcm_dmaengine(E)
[   47.308356]  snd_hda_intel(E) snd_intel_dspcfg(E) snd_intel_sdw_acpi(E) snd_hda_codec(E) snd_hda_core(E) snd_hwdep(E) snd_pcm(E) uvcvideo(E) videobuf2_vmalloc(E) iwlmvm(E) btusb(E) snd_seq_midi(E) uvc(E) coretemp(E) btrtl(E) videobuf2_memops(E) i915(E) snd_seq_midi_event(E) btintel(E) videobuf2_v4l2(E) mac80211(E) kvm_intel(E) snd_rawmidi(E) btbcm(E) videodev(E) btmtk(E) videobuf2_common(E) ite_829x(OE) snd_seq(E) libarc4(E) drm_buddy(E) mc(E) led_class_multicolor(E) processor_thermal_device_pci(E) bluetooth(E) kvm(E) snd_seq_device(E) spd5118(E) processor_thermal_device(E) drm_display_helper(E) cmdlinepart(E) iwlwifi(E) mei_hdcp(E) mei_pxp(E) snd_timer(E) processor_thermal_wt_hint(E) processor_thermal_rfim(E) cec(E) spi_nor(E) rapl(E) processor_thermal_rapl(E) mtd(E) intel_rapl_msr(E) i2c_i801(E) snd(E) drm_ttm_helper(E) nvidia_wmi_ec_backlight(E) mxm_wmi(E) intel_cstate(E) intel_rapl_common(E) rc_core(E) i2c_mux(E) mei_me(E) processor_thermal_wt_req(E) soundcore(E) spi_intel_pci
 (E) cfg80211(E) ttm(E) i2c_smbus(E)
[   47.308371]  i2c_algo_bit(E) processor_thermal_power_floor(E) spi_intel(E) mei(E) processor_thermal_mbox(E) intel_pmc_core(E) int3403_thermal(E) int340x_thermal_zone(E) intel_vsec(E) int3400_thermal(E) pmt_telemetry(E) intel_hid(E) pmt_class(E) acpi_thermal_rel(E) joydev(E) sparse_keymap(E) acpi_pad(E) input_leds(E) mac_hid(E) serio_raw(E) sch_fq_codel(E) msr(E) parport_pc(E) ppdev(E) lp(E) nvme_fabrics(E) parport(E) nvme_keyring(E) efi_pstore(E) nfnetlink(E) dmi_sysfs(E) ip_tables(E) x_tables(E) autofs4(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) libcrc32c(E) dm_crypt(E) dm_mirror(E) dm_region_hash(E) dm_log(E) usbhid(E) nvme(E) hid_multitouch(E) hid_generic(E) nvme_core(E) nvme_auth(E) crct10dif_pclmul(E) crc32_pclmul(E) polyval_clmulni(E) polyval_generic(E) ghash_clmulni_intel(E) sha256_ssse3(E) thunderbolt(E) sha1_ssse3(E) ucsi_acpi(E) psmouse(E) intel_lpss_pci(E) typec_ucsi(E) igc(E) xhci_pci(E) intel_lpss(E) xhci_pci_renesas(E) vmd(E) idma64(E) typec(E) i2c_hid_acpi(E)
  i2c_hid(E) hid(E) video(E) wmi(E)
[   47.308387]  pinctrl_alderlake(E) aesni_intel(E) crypto_simd(E) cryptd(E)
[   47.308388] CPU: 2 UID: 0 PID: 1141 Comm: nv_queue Tainted: P        W  OE      6.11.5 #1
[   47.308389] Tainted: [P]=PROPRIETARY_MODULE, [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[   47.308389] Hardware name: Notebook X370SNx1/X370SNx1, BIOS 1.07.03aMIN29 09/18/2024
[   47.308390] RIP: 0010:follow_pte+0x220/0x230
[   47.308391] Code: 15 75 33 8c 01 48 81 e2 00 00 00 c0 e9 7b ff ff ff 48 8b 45 d0 48 8b 38 e8 8d e9 e1 00 e8 18 e6 da ff 41 bc ea ff ff ff eb 9f <0f> 0b e9 0d fe ff ff 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
[   47.308392] RSP: 0018:ffff99cac101bb10 EFLAGS: 00010246
[   47.308393] RAX: 0000000000000000 RBX: 000070aaf76b6000 RCX: ffff99cac101bb60
[   47.308393] RDX: ffff99cac101bb58 RSI: 000070aaf76b6000 RDI: ffff89231b71b648
[   47.308393] RBP: ffff99cac101bb48 R08: ffff99cac101bd18 R09: 0000000000000000
[   47.308394] R10: 0000000000000000 R11: 0000000000000000 R12: ffff99cac101bba8
[   47.308394] R13: 0000000000000000 R14: ffff99cac101bb58 R15: ffff892315d30b00
[   47.308395] FS:  0000000000000000(0000) GS:ffff892a9e900000(0000) knlGS:0000000000000000
[   47.308395] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   47.308396] CR2: 000070e8b04ee200 CR3: 000000012aa3e000 CR4: 0000000000f50ef0
[   47.308396] PKRU: 55555554
[   47.308397] Call Trace:
[   47.308397]  <TASK>
[   47.308397]  ? show_regs+0x6c/0x80
[   47.308398]  ? __warn+0x88/0x140
[   47.308400]  ? follow_pte+0x220/0x230
[   47.308401]  ? report_bug+0x182/0x1b0
[   47.308402]  ? handle_bug+0x51/0xa0
[   47.308404]  ? exc_invalid_op+0x18/0x80
[   47.308405]  ? asm_exc_invalid_op+0x1b/0x20
[   47.308406]  ? follow_pte+0x220/0x230
[   47.308408]  follow_phys+0x4e/0x110
[   47.308410]  untrack_pfn+0x57/0x130
[   47.308411]  unmap_single_vma+0xbc/0xf0
[   47.308412]  zap_page_range_single+0x138/0x210
[   47.308413]  unmap_mapping_range+0x11b/0x140
[   47.308415]  nv_revoke_gpu_mappings+0x68/0xc0 [nvidia]
[   47.308534]  _nv000741rm+0x35/0xf6 [nvidia]
[   47.308706]  ? rm_execute_work_item+0x141/0x1f0 [nvidia]
[   47.308872]  ? os_execute_work_item+0x6c/0x90 [nvidia]
[   47.308985]  ? _main_loop+0x7e/0x140 [nvidia]
[   47.309107]  ? __pfx__main_loop+0x10/0x10 [nvidia]
[   47.309226]  ? kthread+0xe1/0x110
[   47.309227]  ? __pfx_kthread+0x10/0x10
[   47.309228]  ? ret_from_fork+0x44/0x70
[   47.309229]  ? __pfx_kthread+0x10/0x10
[   47.309230]  ? ret_from_fork_asm+0x1a/0x30
[   47.309231]  </TASK>
[   47.309232] ---[ end trace 0000000000000000 ]---
[   47.309236] ------------[ cut here ]------------
[   47.309236] WARNING: CPU: 2 PID: 1141 at include/linux/rwsem.h:80 follow_pte+0x220/0x230
[   47.309238] Modules linked in: nvidia_uvm(POE) ccm(E) rfcomm(E) snd_seq_dummy(E) snd_hrtimer(E) qrtr(E) cmac(E) algif_hash(E) algif_skcipher(E) af_alg(E) bnep(E) xe(E) snd_hda_codec_realtek(E) drm_gpuvm(E) drm_exec(E) snd_hda_codec_generic(E) gpu_sched(E) drm_suballoc_helper(E) snd_hda_scodec_component(E) binfmt_misc(E) nls_iso8859_1(E) nvidia_drm(POE) nvidia_modeset(POE) nvidia(POE) intel_uncore_frequency(E) intel_uncore_frequency_common(E) intel_tcc_cooling(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) snd_hda_codec_hdmi(E) snd_sof_pci_intel_tgl(E) snd_sof_pci_intel_cnl(E) snd_sof_intel_hda_generic(E) soundwire_intel(E) soundwire_cadence(E) snd_sof_intel_hda_common(E) snd_sof_intel_hda_mlink(E) snd_sof_intel_hda(E) snd_sof_pci(E) snd_sof_xtensa_dsp(E) snd_sof(E) snd_sof_utils(E) snd_soc_hdac_hda(E) snd_soc_acpi_intel_match(E) soundwire_generic_allocation(E) snd_soc_acpi(E) soundwire_bus(E) snd_soc_avs(E) snd_soc_hda_codec(E) snd_hda_ext_core(E) snd_soc_core(E) snd_compress(E) a
 c97_bus(E) snd_pcm_dmaengine(E)
[   47.309251]  snd_hda_intel(E) snd_intel_dspcfg(E) snd_intel_sdw_acpi(E) snd_hda_codec(E) snd_hda_core(E) snd_hwdep(E) snd_pcm(E) uvcvideo(E) videobuf2_vmalloc(E) iwlmvm(E) btusb(E) snd_seq_midi(E) uvc(E) coretemp(E) btrtl(E) videobuf2_memops(E) i915(E) snd_seq_midi_event(E) btintel(E) videobuf2_v4l2(E) mac80211(E) kvm_intel(E) snd_rawmidi(E) btbcm(E) videodev(E) btmtk(E) videobuf2_common(E) ite_829x(OE) snd_seq(E) libarc4(E) drm_buddy(E) mc(E) led_class_multicolor(E) processor_thermal_device_pci(E) bluetooth(E) kvm(E) snd_seq_device(E) spd5118(E) processor_thermal_device(E) drm_display_helper(E) cmdlinepart(E) iwlwifi(E) mei_hdcp(E) mei_pxp(E) snd_timer(E) processor_thermal_wt_hint(E) processor_thermal_rfim(E) cec(E) spi_nor(E) rapl(E) processor_thermal_rapl(E) mtd(E) intel_rapl_msr(E) i2c_i801(E) snd(E) drm_ttm_helper(E) nvidia_wmi_ec_backlight(E) mxm_wmi(E) intel_cstate(E) intel_rapl_common(E) rc_core(E) i2c_mux(E) mei_me(E) processor_thermal_wt_req(E) soundcore(E) spi_intel_pci
 (E) cfg80211(E) ttm(E) i2c_smbus(E)
[   47.309266]  i2c_algo_bit(E) processor_thermal_power_floor(E) spi_intel(E) mei(E) processor_thermal_mbox(E) intel_pmc_core(E) int3403_thermal(E) int340x_thermal_zone(E) intel_vsec(E) int3400_thermal(E) pmt_telemetry(E) intel_hid(E) pmt_class(E) acpi_thermal_rel(E) joydev(E) sparse_keymap(E) acpi_pad(E) input_leds(E) mac_hid(E) serio_raw(E) sch_fq_codel(E) msr(E) parport_pc(E) ppdev(E) lp(E) nvme_fabrics(E) parport(E) nvme_keyring(E) efi_pstore(E) nfnetlink(E) dmi_sysfs(E) ip_tables(E) x_tables(E) autofs4(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) libcrc32c(E) dm_crypt(E) dm_mirror(E) dm_region_hash(E) dm_log(E) usbhid(E) nvme(E) hid_multitouch(E) hid_generic(E) nvme_core(E) nvme_auth(E) crct10dif_pclmul(E) crc32_pclmul(E) polyval_clmulni(E) polyval_generic(E) ghash_clmulni_intel(E) sha256_ssse3(E) thunderbolt(E) sha1_ssse3(E) ucsi_acpi(E) psmouse(E) intel_lpss_pci(E) typec_ucsi(E) igc(E) xhci_pci(E) intel_lpss(E) xhci_pci_renesas(E) vmd(E) idma64(E) typec(E) i2c_hid_acpi(E)
  i2c_hid(E) hid(E) video(E) wmi(E)
[   47.309282]  pinctrl_alderlake(E) aesni_intel(E) crypto_simd(E) cryptd(E)
[   47.309284] CPU: 2 UID: 0 PID: 1141 Comm: nv_queue Tainted: P        W  OE      6.11.5 #1
[   47.309285] Tainted: [P]=PROPRIETARY_MODULE, [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[   47.309285] Hardware name: Notebook X370SNx1/X370SNx1, BIOS 1.07.03aMIN29 09/18/2024
[   47.309286] RIP: 0010:follow_pte+0x220/0x230
[   47.309287] Code: 15 75 33 8c 01 48 81 e2 00 00 00 c0 e9 7b ff ff ff 48 8b 45 d0 48 8b 38 e8 8d e9 e1 00 e8 18 e6 da ff 41 bc ea ff ff ff eb 9f <0f> 0b e9 0d fe ff ff 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
[   47.309288] RSP: 0018:ffff99cac101bb10 EFLAGS: 00010246
[   47.309288] RAX: 0000000000000000 RBX: 000077a51077a000 RCX: ffff99cac101bb60
[   47.309289] RDX: ffff99cac101bb58 RSI: 000077a51077a000 RDI: ffff892397288b80
[   47.309289] RBP: ffff99cac101bb48 R08: ffff99cac101bd18 R09: 0000000000000000
[   47.309290] R10: 0000000000000000 R11: 0000000000000000 R12: ffff99cac101bba8
[   47.309290] R13: 0000000000000000 R14: ffff99cac101bb58 R15: ffff892308031600
[   47.309291] FS:  0000000000000000(0000) GS:ffff892a9e900000(0000) knlGS:0000000000000000
[   47.309291] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   47.309292] CR2: 000070e8b04ee200 CR3: 000000012aa3e000 CR4: 0000000000f50ef0
[   47.309292] PKRU: 55555554
[   47.309293] Call Trace:
[   47.309293]  <TASK>
[   47.309293]  ? show_regs+0x6c/0x80
[   47.309294]  ? __warn+0x88/0x140
[   47.309296]  ? follow_pte+0x220/0x230
[   47.309297]  ? report_bug+0x182/0x1b0
[   47.309298]  ? handle_bug+0x51/0xa0
[   47.309300]  ? exc_invalid_op+0x18/0x80
[   47.309301]  ? asm_exc_invalid_op+0x1b/0x20
[   47.309302]  ? follow_pte+0x220/0x230
[   47.309304]  follow_phys+0x4e/0x110
[   47.309306]  untrack_pfn+0x57/0x130
[   47.309307]  unmap_single_vma+0xbc/0xf0
[   47.309308]  zap_page_range_single+0x138/0x210
[   47.309309]  unmap_mapping_range+0x11b/0x140
[   47.309311]  nv_revoke_gpu_mappings+0x68/0xc0 [nvidia]
[   47.309423]  _nv000741rm+0x35/0xf6 [nvidia]
[   47.309585]  ? rm_execute_work_item+0x141/0x1f0 [nvidia]
[   47.309744]  ? os_execute_work_item+0x6c/0x90 [nvidia]
[   47.309851]  ? _main_loop+0x7e/0x140 [nvidia]
[   47.310032]  ? __pfx__main_loop+0x10/0x10 [nvidia]
[   47.310154]  ? kthread+0xe1/0x110
[   47.310155]  ? __pfx_kthread+0x10/0x10
[   47.310156]  ? ret_from_fork+0x44/0x70
[   47.310157]  ? __pfx_kthread+0x10/0x10
[   47.310158]  ? ret_from_fork_asm+0x1a/0x30
[   47.310159]  </TASK>
[   47.310160] ---[ end trace 0000000000000000 ]---
[   47.310166] ------------[ cut here ]------------
[   47.310166] WARNING: CPU: 2 PID: 1141 at include/linux/rwsem.h:80 follow_pte+0x220/0x230
[   47.310168] Modules linked in: nvidia_uvm(POE) ccm(E) rfcomm(E) snd_seq_dummy(E) snd_hrtimer(E) qrtr(E) cmac(E) algif_hash(E) algif_skcipher(E) af_alg(E) bnep(E) xe(E) snd_hda_codec_realtek(E) drm_gpuvm(E) drm_exec(E) snd_hda_codec_generic(E) gpu_sched(E) drm_suballoc_helper(E) snd_hda_scodec_component(E) binfmt_misc(E) nls_iso8859_1(E) nvidia_drm(POE) nvidia_modeset(POE) nvidia(POE) intel_uncore_frequency(E) intel_uncore_frequency_common(E) intel_tcc_cooling(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) snd_hda_codec_hdmi(E) snd_sof_pci_intel_tgl(E) snd_sof_pci_intel_cnl(E) snd_sof_intel_hda_generic(E) soundwire_intel(E) soundwire_cadence(E) snd_sof_intel_hda_common(E) snd_sof_intel_hda_mlink(E) snd_sof_intel_hda(E) snd_sof_pci(E) snd_sof_xtensa_dsp(E) snd_sof(E) snd_sof_utils(E) snd_soc_hdac_hda(E) snd_soc_acpi_intel_match(E) soundwire_generic_allocation(E) snd_soc_acpi(E) soundwire_bus(E) snd_soc_avs(E) snd_soc_hda_codec(E) snd_hda_ext_core(E) snd_soc_core(E) snd_compress(E) a
 c97_bus(E) snd_pcm_dmaengine(E)
[   47.310181]  snd_hda_intel(E) snd_intel_dspcfg(E) snd_intel_sdw_acpi(E) snd_hda_codec(E) snd_hda_core(E) snd_hwdep(E) snd_pcm(E) uvcvideo(E) videobuf2_vmalloc(E) iwlmvm(E) btusb(E) snd_seq_midi(E) uvc(E) coretemp(E) btrtl(E) videobuf2_memops(E) i915(E) snd_seq_midi_event(E) btintel(E) videobuf2_v4l2(E) mac80211(E) kvm_intel(E) snd_rawmidi(E) btbcm(E) videodev(E) btmtk(E) videobuf2_common(E) ite_829x(OE) snd_seq(E) libarc4(E) drm_buddy(E) mc(E) led_class_multicolor(E) processor_thermal_device_pci(E) bluetooth(E) kvm(E) snd_seq_device(E) spd5118(E) processor_thermal_device(E) drm_display_helper(E) cmdlinepart(E) iwlwifi(E) mei_hdcp(E) mei_pxp(E) snd_timer(E) processor_thermal_wt_hint(E) processor_thermal_rfim(E) cec(E) spi_nor(E) rapl(E) processor_thermal_rapl(E) mtd(E) intel_rapl_msr(E) i2c_i801(E) snd(E) drm_ttm_helper(E) nvidia_wmi_ec_backlight(E) mxm_wmi(E) intel_cstate(E) intel_rapl_common(E) rc_core(E) i2c_mux(E) mei_me(E) processor_thermal_wt_req(E) soundcore(E) spi_intel_pci
 (E) cfg80211(E) ttm(E) i2c_smbus(E)
[   47.310196]  i2c_algo_bit(E) processor_thermal_power_floor(E) spi_intel(E) mei(E) processor_thermal_mbox(E) intel_pmc_core(E) int3403_thermal(E) int340x_thermal_zone(E) intel_vsec(E) int3400_thermal(E) pmt_telemetry(E) intel_hid(E) pmt_class(E) acpi_thermal_rel(E) joydev(E) sparse_keymap(E) acpi_pad(E) input_leds(E) mac_hid(E) serio_raw(E) sch_fq_codel(E) msr(E) parport_pc(E) ppdev(E) lp(E) nvme_fabrics(E) parport(E) nvme_keyring(E) efi_pstore(E) nfnetlink(E) dmi_sysfs(E) ip_tables(E) x_tables(E) autofs4(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) libcrc32c(E) dm_crypt(E) dm_mirror(E) dm_region_hash(E) dm_log(E) usbhid(E) nvme(E) hid_multitouch(E) hid_generic(E) nvme_core(E) nvme_auth(E) crct10dif_pclmul(E) crc32_pclmul(E) polyval_clmulni(E) polyval_generic(E) ghash_clmulni_intel(E) sha256_ssse3(E) thunderbolt(E) sha1_ssse3(E) ucsi_acpi(E) psmouse(E) intel_lpss_pci(E) typec_ucsi(E) igc(E) xhci_pci(E) intel_lpss(E) xhci_pci_renesas(E) vmd(E) idma64(E) typec(E) i2c_hid_acpi(E)
  i2c_hid(E) hid(E) video(E) wmi(E)
[   47.310211]  pinctrl_alderlake(E) aesni_intel(E) crypto_simd(E) cryptd(E)
[   47.310213] CPU: 2 UID: 0 PID: 1141 Comm: nv_queue Tainted: P        W  OE      6.11.5 #1
[   47.310214] Tainted: [P]=PROPRIETARY_MODULE, [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[   47.310214] Hardware name: Notebook X370SNx1/X370SNx1, BIOS 1.07.03aMIN29 09/18/2024
[   47.310215] RIP: 0010:follow_pte+0x220/0x230
[   47.310216] Code: 15 75 33 8c 01 48 81 e2 00 00 00 c0 e9 7b ff ff ff 48 8b 45 d0 48 8b 38 e8 8d e9 e1 00 e8 18 e6 da ff 41 bc ea ff ff ff eb 9f <0f> 0b e9 0d fe ff ff 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
[   47.310217] RSP: 0018:ffff99cac101bb10 EFLAGS: 00010246
[   47.310217] RAX: 0000000000000000 RBX: 000077a509f17000 RCX: ffff99cac101bb60
[   47.310218] RDX: ffff99cac101bb58 RSI: 000077a509f17000 RDI: ffff89233f07f700
[   47.310218] RBP: ffff99cac101bb48 R08: ffff99cac101bd18 R09: 0000000000000000
[   47.310219] R10: 0000000000000000 R11: 0000000000000000 R12: ffff99cac101bba8
[   47.310219] R13: 0000000000000000 R14: ffff99cac101bb58 R15: ffff892308031600
[   47.310220] FS:  0000000000000000(0000) GS:ffff892a9e900000(0000) knlGS:0000000000000000
[   47.310220] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   47.310221] CR2: 000070e8b04ee200 CR3: 000000012aa3e000 CR4: 0000000000f50ef0
[   47.310221] PKRU: 55555554
[   47.310222] Call Trace:
[   47.310222]  <TASK>
[   47.310222]  ? show_regs+0x6c/0x80
[   47.310223]  ? __warn+0x88/0x140
[   47.310225]  ? follow_pte+0x220/0x230
[   47.310226]  ? report_bug+0x182/0x1b0
[   47.310228]  ? handle_bug+0x51/0xa0
[   47.310229]  ? exc_invalid_op+0x18/0x80
[   47.310230]  ? asm_exc_invalid_op+0x1b/0x20
[   47.310232]  ? follow_pte+0x220/0x230
[   47.310233]  follow_phys+0x4e/0x110
[   47.310235]  untrack_pfn+0x57/0x130
[   47.310237]  unmap_single_vma+0xbc/0xf0
[   47.310237]  zap_page_range_single+0x138/0x210
[   47.310239]  unmap_mapping_range+0x11b/0x140
[   47.310240]  nv_revoke_gpu_mappings+0x68/0xc0 [nvidia]
[   47.310359]  _nv000741rm+0x35/0xf6 [nvidia]
[   47.310533]  ? rm_execute_work_item+0x141/0x1f0 [nvidia]
[   47.310693]  ? os_execute_work_item+0x6c/0x90 [nvidia]
[   47.310800]  ? _main_loop+0x7e/0x140 [nvidia]
[   47.310943]  ? __pfx__main_loop+0x10/0x10 [nvidia]
[   47.311058]  ? kthread+0xe1/0x110
[   47.311059]  ? __pfx_kthread+0x10/0x10
[   47.311060]  ? ret_from_fork+0x44/0x70
[   47.311061]  ? __pfx_kthread+0x10/0x10
[   47.311061]  ? ret_from_fork_asm+0x1a/0x30
[   47.311063]  </TASK>
[   47.311063] ---[ end trace 0000000000000000 ]---
[   47.311068] ------------[ cut here ]------------
[   47.311069] WARNING: CPU: 2 PID: 1141 at include/linux/rwsem.h:80 follow_pte+0x220/0x230
[   47.311071] Modules linked in: nvidia_uvm(POE) ccm(E) rfcomm(E) snd_seq_dummy(E) snd_hrtimer(E) qrtr(E) cmac(E) algif_hash(E) algif_skcipher(E) af_alg(E) bnep(E) xe(E) snd_hda_codec_realtek(E) drm_gpuvm(E) drm_exec(E) snd_hda_codec_generic(E) gpu_sched(E) drm_suballoc_helper(E) snd_hda_scodec_component(E) binfmt_misc(E) nls_iso8859_1(E) nvidia_drm(POE) nvidia_modeset(POE) nvidia(POE) intel_uncore_frequency(E) intel_uncore_frequency_common(E) intel_tcc_cooling(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) snd_hda_codec_hdmi(E) snd_sof_pci_intel_tgl(E) snd_sof_pci_intel_cnl(E) snd_sof_intel_hda_generic(E) soundwire_intel(E) soundwire_cadence(E) snd_sof_intel_hda_common(E) snd_sof_intel_hda_mlink(E) snd_sof_intel_hda(E) snd_sof_pci(E) snd_sof_xtensa_dsp(E) snd_sof(E) snd_sof_utils(E) snd_soc_hdac_hda(E) snd_soc_acpi_intel_match(E) soundwire_generic_allocation(E) snd_soc_acpi(E) soundwire_bus(E) snd_soc_avs(E) snd_soc_hda_codec(E) snd_hda_ext_core(E) snd_soc_core(E) snd_compress(E) a
 c97_bus(E) snd_pcm_dmaengine(E)
[   47.311083]  snd_hda_intel(E) snd_intel_dspcfg(E) snd_intel_sdw_acpi(E) snd_hda_codec(E) snd_hda_core(E) snd_hwdep(E) snd_pcm(E) uvcvideo(E) videobuf2_vmalloc(E) iwlmvm(E) btusb(E) snd_seq_midi(E) uvc(E) coretemp(E) btrtl(E) videobuf2_memops(E) i915(E) snd_seq_midi_event(E) btintel(E) videobuf2_v4l2(E) mac80211(E) kvm_intel(E) snd_rawmidi(E) btbcm(E) videodev(E) btmtk(E) videobuf2_common(E) ite_829x(OE) snd_seq(E) libarc4(E) drm_buddy(E) mc(E) led_class_multicolor(E) processor_thermal_device_pci(E) bluetooth(E) kvm(E) snd_seq_device(E) spd5118(E) processor_thermal_device(E) drm_display_helper(E) cmdlinepart(E) iwlwifi(E) mei_hdcp(E) mei_pxp(E) snd_timer(E) processor_thermal_wt_hint(E) processor_thermal_rfim(E) cec(E) spi_nor(E) rapl(E) processor_thermal_rapl(E) mtd(E) intel_rapl_msr(E) i2c_i801(E) snd(E) drm_ttm_helper(E) nvidia_wmi_ec_backlight(E) mxm_wmi(E) intel_cstate(E) intel_rapl_common(E) rc_core(E) i2c_mux(E) mei_me(E) processor_thermal_wt_req(E) soundcore(E) spi_intel_pci
 (E) cfg80211(E) ttm(E) i2c_smbus(E)
[   47.311098]  i2c_algo_bit(E) processor_thermal_power_floor(E) spi_intel(E) mei(E) processor_thermal_mbox(E) intel_pmc_core(E) int3403_thermal(E) int340x_thermal_zone(E) intel_vsec(E) int3400_thermal(E) pmt_telemetry(E) intel_hid(E) pmt_class(E) acpi_thermal_rel(E) joydev(E) sparse_keymap(E) acpi_pad(E) input_leds(E) mac_hid(E) serio_raw(E) sch_fq_codel(E) msr(E) parport_pc(E) ppdev(E) lp(E) nvme_fabrics(E) parport(E) nvme_keyring(E) efi_pstore(E) nfnetlink(E) dmi_sysfs(E) ip_tables(E) x_tables(E) autofs4(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) libcrc32c(E) dm_crypt(E) dm_mirror(E) dm_region_hash(E) dm_log(E) usbhid(E) nvme(E) hid_multitouch(E) hid_generic(E) nvme_core(E) nvme_auth(E) crct10dif_pclmul(E) crc32_pclmul(E) polyval_clmulni(E) polyval_generic(E) ghash_clmulni_intel(E) sha256_ssse3(E) thunderbolt(E) sha1_ssse3(E) ucsi_acpi(E) psmouse(E) intel_lpss_pci(E) typec_ucsi(E) igc(E) xhci_pci(E) intel_lpss(E) xhci_pci_renesas(E) vmd(E) idma64(E) typec(E) i2c_hid_acpi(E)
  i2c_hid(E) hid(E) video(E) wmi(E)
[   47.311114]  pinctrl_alderlake(E) aesni_intel(E) crypto_simd(E) cryptd(E)
[   47.311115] CPU: 2 UID: 0 PID: 1141 Comm: nv_queue Tainted: P        W  OE      6.11.5 #1
[   47.311116] Tainted: [P]=PROPRIETARY_MODULE, [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[   47.311117] Hardware name: Notebook X370SNx1/X370SNx1, BIOS 1.07.03aMIN29 09/18/2024
[   47.311117] RIP: 0010:follow_pte+0x220/0x230
[   47.311118] Code: 15 75 33 8c 01 48 81 e2 00 00 00 c0 e9 7b ff ff ff 48 8b 45 d0 48 8b 38 e8 8d e9 e1 00 e8 18 e6 da ff 41 bc ea ff ff ff eb 9f <0f> 0b e9 0d fe ff ff 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
[   47.311119] RSP: 0018:ffff99cac101bb10 EFLAGS: 00010246
[   47.311120] RAX: 0000000000000000 RBX: 000070aaf61bc000 RCX: ffff99cac101bb60
[   47.311120] RDX: ffff99cac101bb58 RSI: 000070aaf61bc000 RDI: ffff89233696f1f8
[   47.311121] RBP: ffff99cac101bb48 R08: ffff99cac101bd18 R09: 0000000000000000
[   47.311121] R10: 0000000000000000 R11: 0000000000000000 R12: ffff99cac101bba8
[   47.311122] R13: 0000000000000000 R14: ffff99cac101bb58 R15: ffff892315d30b00
[   47.311122] FS:  0000000000000000(0000) GS:ffff892a9e900000(0000) knlGS:0000000000000000
[   47.311123] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   47.311123] CR2: 000070e8b04ee200 CR3: 000000012aa3e000 CR4: 0000000000f50ef0
[   47.311124] PKRU: 55555554
[   47.311124] Call Trace:
[   47.311124]  <TASK>
[   47.311125]  ? show_regs+0x6c/0x80
[   47.311126]  ? __warn+0x88/0x140
[   47.311127]  ? follow_pte+0x220/0x230
[   47.311129]  ? report_bug+0x182/0x1b0
[   47.311130]  ? handle_bug+0x51/0xa0
[   47.311131]  ? exc_invalid_op+0x18/0x80
[   47.311132]  ? asm_exc_invalid_op+0x1b/0x20
[   47.311134]  ? follow_pte+0x220/0x230
[   47.311135]  follow_phys+0x4e/0x110
[   47.311137]  untrack_pfn+0x57/0x130
[   47.311138]  unmap_single_vma+0xbc/0xf0
[   47.311139]  zap_page_range_single+0x138/0x210
[   47.311141]  unmap_mapping_range+0x11b/0x140
[   47.311142]  nv_revoke_gpu_mappings+0x68/0xc0 [nvidia]
[   47.311261]  _nv000741rm+0x35/0xf6 [nvidia]
[   47.311433]  ? rm_execute_work_item+0x141/0x1f0 [nvidia]
[   47.311603]  ? os_execute_work_item+0x6c/0x90 [nvidia]
[   47.311722]  ? _main_loop+0x7e/0x140 [nvidia]
[   47.311843]  ? __pfx__main_loop+0x10/0x10 [nvidia]
[   47.312011]  ? kthread+0xe1/0x110
[   47.312013]  ? __pfx_kthread+0x10/0x10
[   47.312014]  ? ret_from_fork+0x44/0x70
[   47.312015]  ? __pfx_kthread+0x10/0x10
[   47.312016]  ? ret_from_fork_asm+0x1a/0x30
[   47.312018]  </TASK>
[   47.312018] ---[ end trace 0000000000000000 ]---
[   47.312024] ------------[ cut here ]------------
[   47.312024] WARNING: CPU: 2 PID: 1141 at include/linux/rwsem.h:80 follow_pte+0x220/0x230
[   47.312026] Modules linked in: nvidia_uvm(POE) ccm(E) rfcomm(E) snd_seq_dummy(E) snd_hrtimer(E) qrtr(E) cmac(E) algif_hash(E) algif_skcipher(E) af_alg(E) bnep(E) xe(E) snd_hda_codec_realtek(E) drm_gpuvm(E) drm_exec(E) snd_hda_codec_generic(E) gpu_sched(E) drm_suballoc_helper(E) snd_hda_scodec_component(E) binfmt_misc(E) nls_iso8859_1(E) nvidia_drm(POE) nvidia_modeset(POE) nvidia(POE) intel_uncore_frequency(E) intel_uncore_frequency_common(E) intel_tcc_cooling(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) snd_hda_codec_hdmi(E) snd_sof_pci_intel_tgl(E) snd_sof_pci_intel_cnl(E) snd_sof_intel_hda_generic(E) soundwire_intel(E) soundwire_cadence(E) snd_sof_intel_hda_common(E) snd_sof_intel_hda_mlink(E) snd_sof_intel_hda(E) snd_sof_pci(E) snd_sof_xtensa_dsp(E) snd_sof(E) snd_sof_utils(E) snd_soc_hdac_hda(E) snd_soc_acpi_intel_match(E) soundwire_generic_allocation(E) snd_soc_acpi(E) soundwire_bus(E) snd_soc_avs(E) snd_soc_hda_codec(E) snd_hda_ext_core(E) snd_soc_core(E) snd_compress(E) a
 c97_bus(E) snd_pcm_dmaengine(E)
[   47.312040]  snd_hda_intel(E) snd_intel_dspcfg(E) snd_intel_sdw_acpi(E) snd_hda_codec(E) snd_hda_core(E) snd_hwdep(E) snd_pcm(E) uvcvideo(E) videobuf2_vmalloc(E) iwlmvm(E) btusb(E) snd_seq_midi(E) uvc(E) coretemp(E) btrtl(E) videobuf2_memops(E) i915(E) snd_seq_midi_event(E) btintel(E) videobuf2_v4l2(E) mac80211(E) kvm_intel(E) snd_rawmidi(E) btbcm(E) videodev(E) btmtk(E) videobuf2_common(E) ite_829x(OE) snd_seq(E) libarc4(E) drm_buddy(E) mc(E) led_class_multicolor(E) processor_thermal_device_pci(E) bluetooth(E) kvm(E) snd_seq_device(E) spd5118(E) processor_thermal_device(E) drm_display_helper(E) cmdlinepart(E) iwlwifi(E) mei_hdcp(E) mei_pxp(E) snd_timer(E) processor_thermal_wt_hint(E) processor_thermal_rfim(E) cec(E) spi_nor(E) rapl(E) processor_thermal_rapl(E) mtd(E) intel_rapl_msr(E) i2c_i801(E) snd(E) drm_ttm_helper(E) nvidia_wmi_ec_backlight(E) mxm_wmi(E) intel_cstate(E) intel_rapl_common(E) rc_core(E) i2c_mux(E) mei_me(E) processor_thermal_wt_req(E) soundcore(E) spi_intel_pci
 (E) cfg80211(E) ttm(E) i2c_smbus(E)
[   47.312055]  i2c_algo_bit(E) processor_thermal_power_floor(E) spi_intel(E) mei(E) processor_thermal_mbox(E) intel_pmc_core(E) int3403_thermal(E) int340x_thermal_zone(E) intel_vsec(E) int3400_thermal(E) pmt_telemetry(E) intel_hid(E) pmt_class(E) acpi_thermal_rel(E) joydev(E) sparse_keymap(E) acpi_pad(E) input_leds(E) mac_hid(E) serio_raw(E) sch_fq_codel(E) msr(E) parport_pc(E) ppdev(E) lp(E) nvme_fabrics(E) parport(E) nvme_keyring(E) efi_pstore(E) nfnetlink(E) dmi_sysfs(E) ip_tables(E) x_tables(E) autofs4(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) libcrc32c(E) dm_crypt(E) dm_mirror(E) dm_region_hash(E) dm_log(E) usbhid(E) nvme(E) hid_multitouch(E) hid_generic(E) nvme_core(E) nvme_auth(E) crct10dif_pclmul(E) crc32_pclmul(E) polyval_clmulni(E) polyval_generic(E) ghash_clmulni_intel(E) sha256_ssse3(E) thunderbolt(E) sha1_ssse3(E) ucsi_acpi(E) psmouse(E) intel_lpss_pci(E) typec_ucsi(E) igc(E) xhci_pci(E) intel_lpss(E) xhci_pci_renesas(E) vmd(E) idma64(E) typec(E) i2c_hid_acpi(E)
  i2c_hid(E) hid(E) video(E) wmi(E)
[   47.312071]  pinctrl_alderlake(E) aesni_intel(E) crypto_simd(E) cryptd(E)
[   47.312072] CPU: 2 UID: 0 PID: 1141 Comm: nv_queue Tainted: P        W  OE      6.11.5 #1
[   47.312073] Tainted: [P]=PROPRIETARY_MODULE, [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[   47.312074] Hardware name: Notebook X370SNx1/X370SNx1, BIOS 1.07.03aMIN29 09/18/2024
[   47.312074] RIP: 0010:follow_pte+0x220/0x230
[   47.312076] Code: 15 75 33 8c 01 48 81 e2 00 00 00 c0 e9 7b ff ff ff 48 8b 45 d0 48 8b 38 e8 8d e9 e1 00 e8 18 e6 da ff 41 bc ea ff ff ff eb 9f <0f> 0b e9 0d fe ff ff 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
[   47.312077] RSP: 0018:ffff99cac101bb10 EFLAGS: 00010246
[   47.312077] RAX: 0000000000000000 RBX: 000070aaf76bd000 RCX: ffff99cac101bb60
[   47.312078] RDX: ffff99cac101bb58 RSI: 000070aaf76bd000 RDI: ffff8923a0b091f8
[   47.312079] RBP: ffff99cac101bb48 R08: ffff99cac101bd18 R09: 0000000000000000
[   47.312079] R10: 0000000000000000 R11: 0000000000000000 R12: ffff99cac101bba8
[   47.312080] R13: 0000000000000000 R14: ffff99cac101bb58 R15: ffff892315d30b00
[   47.312080] FS:  0000000000000000(0000) GS:ffff892a9e900000(0000) knlGS:0000000000000000
[   47.312081] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   47.312081] CR2: 000070e8b04ee200 CR3: 000000012aa3e000 CR4: 0000000000f50ef0
[   47.312082] PKRU: 55555554
[   47.312082] Call Trace:
[   47.312083]  <TASK>
[   47.312083]  ? show_regs+0x6c/0x80
[   47.312084]  ? __warn+0x88/0x140
[   47.312086]  ? follow_pte+0x220/0x230
[   47.312087]  ? report_bug+0x182/0x1b0
[   47.312088]  ? handle_bug+0x51/0xa0
[   47.312090]  ? exc_invalid_op+0x18/0x80
[   47.312091]  ? asm_exc_invalid_op+0x1b/0x20
[   47.312092]  ? follow_pte+0x220/0x230
[   47.312094]  follow_phys+0x4e/0x110
[   47.312096]  untrack_pfn+0x57/0x130
[   47.312097]  unmap_single_vma+0xbc/0xf0
[   47.312098]  zap_page_range_single+0x138/0x210
[   47.312100]  unmap_mapping_range+0x11b/0x140
[   47.312101]  nv_revoke_gpu_mappings+0x68/0xc0 [nvidia]
[   47.312220]  _nv000741rm+0x35/0xf6 [nvidia]
[   47.312398]  ? rm_execute_work_item+0x141/0x1f0 [nvidia]
[   47.312572]  ? os_execute_work_item+0x6c/0x90 [nvidia]
[   47.312679]  ? _main_loop+0x7e/0x140 [nvidia]
[   47.312786]  ? __pfx__main_loop+0x10/0x10 [nvidia]
[   47.312911]  ? kthread+0xe1/0x110
[   47.312912]  ? __pfx_kthread+0x10/0x10
[   47.312913]  ? ret_from_fork+0x44/0x70
[   47.312914]  ? __pfx_kthread+0x10/0x10
[   47.312915]  ? ret_from_fork_asm+0x1a/0x30
[   47.312917]  </TASK>
[   47.312917] ---[ end trace 0000000000000000 ]---
[   47.312921] ------------[ cut here ]------------
[   47.312921] WARNING: CPU: 2 PID: 1141 at include/linux/rwsem.h:80 follow_pte+0x220/0x230
[   47.312923] Modules linked in: nvidia_uvm(POE) ccm(E) rfcomm(E) snd_seq_dummy(E) snd_hrtimer(E) qrtr(E) cmac(E) algif_hash(E) algif_skcipher(E) af_alg(E) bnep(E) xe(E) snd_hda_codec_realtek(E) drm_gpuvm(E) drm_exec(E) snd_hda_codec_generic(E) gpu_sched(E) drm_suballoc_helper(E) snd_hda_scodec_component(E) binfmt_misc(E) nls_iso8859_1(E) nvidia_drm(POE) nvidia_modeset(POE) nvidia(POE) intel_uncore_frequency(E) intel_uncore_frequency_common(E) intel_tcc_cooling(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) snd_hda_codec_hdmi(E) snd_sof_pci_intel_tgl(E) snd_sof_pci_intel_cnl(E) snd_sof_intel_hda_generic(E) soundwire_intel(E) soundwire_cadence(E) snd_sof_intel_hda_common(E) snd_sof_intel_hda_mlink(E) snd_sof_intel_hda(E) snd_sof_pci(E) snd_sof_xtensa_dsp(E) snd_sof(E) snd_sof_utils(E) snd_soc_hdac_hda(E) snd_soc_acpi_intel_match(E) soundwire_generic_allocation(E) snd_soc_acpi(E) soundwire_bus(E) snd_soc_avs(E) snd_soc_hda_codec(E) snd_hda_ext_core(E) snd_soc_core(E) snd_compress(E) a
 c97_bus(E) snd_pcm_dmaengine(E)
[   47.312937]  snd_hda_intel(E) snd_intel_dspcfg(E) snd_intel_sdw_acpi(E) snd_hda_codec(E) snd_hda_core(E) snd_hwdep(E) snd_pcm(E) uvcvideo(E) videobuf2_vmalloc(E) iwlmvm(E) btusb(E) snd_seq_midi(E) uvc(E) coretemp(E) btrtl(E) videobuf2_memops(E) i915(E) snd_seq_midi_event(E) btintel(E) videobuf2_v4l2(E) mac80211(E) kvm_intel(E) snd_rawmidi(E) btbcm(E) videodev(E) btmtk(E) videobuf2_common(E) ite_829x(OE) snd_seq(E) libarc4(E) drm_buddy(E) mc(E) led_class_multicolor(E) processor_thermal_device_pci(E) bluetooth(E) kvm(E) snd_seq_device(E) spd5118(E) processor_thermal_device(E) drm_display_helper(E) cmdlinepart(E) iwlwifi(E) mei_hdcp(E) mei_pxp(E) snd_timer(E) processor_thermal_wt_hint(E) processor_thermal_rfim(E) cec(E) spi_nor(E) rapl(E) processor_thermal_rapl(E) mtd(E) intel_rapl_msr(E) i2c_i801(E) snd(E) drm_ttm_helper(E) nvidia_wmi_ec_backlight(E) mxm_wmi(E) intel_cstate(E) intel_rapl_common(E) rc_core(E) i2c_mux(E) mei_me(E) processor_thermal_wt_req(E) soundcore(E) spi_intel_pci
 (E) cfg80211(E) ttm(E) i2c_smbus(E)
[   47.312952]  i2c_algo_bit(E) processor_thermal_power_floor(E) spi_intel(E) mei(E) processor_thermal_mbox(E) intel_pmc_core(E) int3403_thermal(E) int340x_thermal_zone(E) intel_vsec(E) int3400_thermal(E) pmt_telemetry(E) intel_hid(E) pmt_class(E) acpi_thermal_rel(E) joydev(E) sparse_keymap(E) acpi_pad(E) input_leds(E) mac_hid(E) serio_raw(E) sch_fq_codel(E) msr(E) parport_pc(E) ppdev(E) lp(E) nvme_fabrics(E) parport(E) nvme_keyring(E) efi_pstore(E) nfnetlink(E) dmi_sysfs(E) ip_tables(E) x_tables(E) autofs4(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) libcrc32c(E) dm_crypt(E) dm_mirror(E) dm_region_hash(E) dm_log(E) usbhid(E) nvme(E) hid_multitouch(E) hid_generic(E) nvme_core(E) nvme_auth(E) crct10dif_pclmul(E) crc32_pclmul(E) polyval_clmulni(E) polyval_generic(E) ghash_clmulni_intel(E) sha256_ssse3(E) thunderbolt(E) sha1_ssse3(E) ucsi_acpi(E) psmouse(E) intel_lpss_pci(E) typec_ucsi(E) igc(E) xhci_pci(E) intel_lpss(E) xhci_pci_renesas(E) vmd(E) idma64(E) typec(E) i2c_hid_acpi(E)
  i2c_hid(E) hid(E) video(E) wmi(E)
[   47.312968]  pinctrl_alderlake(E) aesni_intel(E) crypto_simd(E) cryptd(E)
[   47.312969] CPU: 2 UID: 0 PID: 1141 Comm: nv_queue Tainted: P        W  OE      6.11.5 #1
[   47.312971] Tainted: [P]=PROPRIETARY_MODULE, [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[   47.312971] Hardware name: Notebook X370SNx1/X370SNx1, BIOS 1.07.03aMIN29 09/18/2024
[   47.312971] RIP: 0010:follow_pte+0x220/0x230
[   47.312973] Code: 15 75 33 8c 01 48 81 e2 00 00 00 c0 e9 7b ff ff ff 48 8b 45 d0 48 8b 38 e8 8d e9 e1 00 e8 18 e6 da ff 41 bc ea ff ff ff eb 9f <0f> 0b e9 0d fe ff ff 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
[   47.312974] RSP: 0018:ffff99cac101bb10 EFLAGS: 00010246
[   47.312974] RAX: 0000000000000000 RBX: 000077a50ac6b000 RCX: ffff99cac101bb60
[   47.312975] RDX: ffff99cac101bb58 RSI: 000077a50ac6b000 RDI: ffff89230c7a92b0
[   47.312975] RBP: ffff99cac101bb48 R08: ffff99cac101bd18 R09: 0000000000000000
[   47.312976] R10: 0000000000000000 R11: 0000000000000000 R12: ffff99cac101bba8
[   47.312976] R13: 0000000000000000 R14: ffff99cac101bb58 R15: ffff892308031600
[   47.312977] FS:  0000000000000000(0000) GS:ffff892a9e900000(0000) knlGS:0000000000000000
[   47.312977] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   47.312978] CR2: 000070e8b04ee200 CR3: 000000012aa3e000 CR4: 0000000000f50ef0
[   47.312978] PKRU: 55555554
[   47.312979] Call Trace:
[   47.312979]  <TASK>
[   47.312979]  ? show_regs+0x6c/0x80
[   47.312980]  ? __warn+0x88/0x140
[   47.312982]  ? follow_pte+0x220/0x230
[   47.312983]  ? report_bug+0x182/0x1b0
[   47.312984]  ? handle_bug+0x51/0xa0
[   47.312986]  ? exc_invalid_op+0x18/0x80
[   47.312987]  ? asm_exc_invalid_op+0x1b/0x20
[   47.312988]  ? follow_pte+0x220/0x230
[   47.312990]  follow_phys+0x4e/0x110
[   47.312992]  untrack_pfn+0x57/0x130
[   47.312993]  unmap_single_vma+0xbc/0xf0
[   47.312994]  zap_page_range_single+0x138/0x210
[   47.312996]  unmap_mapping_range+0x11b/0x140
[   47.312997]  nv_revoke_gpu_mappings+0x68/0xc0 [nvidia]
[   47.313117]  _nv000741rm+0x35/0xf6 [nvidia]
[   47.313294]  ? rm_execute_work_item+0x141/0x1f0 [nvidia]
[   47.313472]  ? os_execute_work_item+0x6c/0x90 [nvidia]
[   47.313592]  ? _main_loop+0x7e/0x140 [nvidia]
[   47.313701]  ? __pfx__main_loop+0x10/0x10 [nvidia]
[   47.313808]  ? kthread+0xe1/0x110
[   47.313809]  ? __pfx_kthread+0x10/0x10
[   47.313809]  ? ret_from_fork+0x44/0x70
[   47.313810]  ? __pfx_kthread+0x10/0x10
[   47.313811]  ? ret_from_fork_asm+0x1a/0x30
[   47.313813]  </TASK>
[   47.313813] ---[ end trace 0000000000000000 ]---
[   47.313817] ------------[ cut here ]------------
[   47.313817] WARNING: CPU: 2 PID: 1141 at include/linux/rwsem.h:80 follow_pte+0x220/0x230
[   47.313819] Modules linked in: nvidia_uvm(POE) ccm(E) rfcomm(E) snd_seq_dummy(E) snd_hrtimer(E) qrtr(E) cmac(E) algif_hash(E) algif_skcipher(E) af_alg(E) bnep(E) xe(E) snd_hda_codec_realtek(E) drm_gpuvm(E) drm_exec(E) snd_hda_codec_generic(E) gpu_sched(E) drm_suballoc_helper(E) snd_hda_scodec_component(E) binfmt_misc(E) nls_iso8859_1(E) nvidia_drm(POE) nvidia_modeset(POE) nvidia(POE) intel_uncore_frequency(E) intel_uncore_frequency_common(E) intel_tcc_cooling(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) snd_hda_codec_hdmi(E) snd_sof_pci_intel_tgl(E) snd_sof_pci_intel_cnl(E) snd_sof_intel_hda_generic(E) soundwire_intel(E) soundwire_cadence(E) snd_sof_intel_hda_common(E) snd_sof_intel_hda_mlink(E) snd_sof_intel_hda(E) snd_sof_pci(E) snd_sof_xtensa_dsp(E) snd_sof(E) snd_sof_utils(E) snd_soc_hdac_hda(E) snd_soc_acpi_intel_match(E) soundwire_generic_allocation(E) snd_soc_acpi(E) soundwire_bus(E) snd_soc_avs(E) snd_soc_hda_codec(E) snd_hda_ext_core(E) snd_soc_core(E) snd_compress(E) a
 c97_bus(E) snd_pcm_dmaengine(E)
[   47.313831]  snd_hda_intel(E) snd_intel_dspcfg(E) snd_intel_sdw_acpi(E) snd_hda_codec(E) snd_hda_core(E) snd_hwdep(E) snd_pcm(E) uvcvideo(E) videobuf2_vmalloc(E) iwlmvm(E) btusb(E) snd_seq_midi(E) uvc(E) coretemp(E) btrtl(E) videobuf2_memops(E) i915(E) snd_seq_midi_event(E) btintel(E) videobuf2_v4l2(E) mac80211(E) kvm_intel(E) snd_rawmidi(E) btbcm(E) videodev(E) btmtk(E) videobuf2_common(E) ite_829x(OE) snd_seq(E) libarc4(E) drm_buddy(E) mc(E) led_class_multicolor(E) processor_thermal_device_pci(E) bluetooth(E) kvm(E) snd_seq_device(E) spd5118(E) processor_thermal_device(E) drm_display_helper(E) cmdlinepart(E) iwlwifi(E) mei_hdcp(E) mei_pxp(E) snd_timer(E) processor_thermal_wt_hint(E) processor_thermal_rfim(E) cec(E) spi_nor(E) rapl(E) processor_thermal_rapl(E) mtd(E) intel_rapl_msr(E) i2c_i801(E) snd(E) drm_ttm_helper(E) nvidia_wmi_ec_backlight(E) mxm_wmi(E) intel_cstate(E) intel_rapl_common(E) rc_core(E) i2c_mux(E) mei_me(E) processor_thermal_wt_req(E) soundcore(E) spi_intel_pci
 (E) cfg80211(E) ttm(E) i2c_smbus(E)
[   47.313845]  i2c_algo_bit(E) processor_thermal_power_floor(E) spi_intel(E) mei(E) processor_thermal_mbox(E) intel_pmc_core(E) int3403_thermal(E) int340x_thermal_zone(E) intel_vsec(E) int3400_thermal(E) pmt_telemetry(E) intel_hid(E) pmt_class(E) acpi_thermal_rel(E) joydev(E) sparse_keymap(E) acpi_pad(E) input_leds(E) mac_hid(E) serio_raw(E) sch_fq_codel(E) msr(E) parport_pc(E) ppdev(E) lp(E) nvme_fabrics(E) parport(E) nvme_keyring(E) efi_pstore(E) nfnetlink(E) dmi_sysfs(E) ip_tables(E) x_tables(E) autofs4(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) libcrc32c(E) dm_crypt(E) dm_mirror(E) dm_region_hash(E) dm_log(E) usbhid(E) nvme(E) hid_multitouch(E) hid_generic(E) nvme_core(E) nvme_auth(E) crct10dif_pclmul(E) crc32_pclmul(E) polyval_clmulni(E) polyval_generic(E) ghash_clmulni_intel(E) sha256_ssse3(E) thunderbolt(E) sha1_ssse3(E) ucsi_acpi(E) psmouse(E) intel_lpss_pci(E) typec_ucsi(E) igc(E) xhci_pci(E) intel_lpss(E) xhci_pci_renesas(E) vmd(E) idma64(E) typec(E) i2c_hid_acpi(E)
  i2c_hid(E) hid(E) video(E) wmi(E)
[   47.313859]  pinctrl_alderlake(E) aesni_intel(E) crypto_simd(E) cryptd(E)
[   47.313860] CPU: 2 UID: 0 PID: 1141 Comm: nv_queue Tainted: P        W  OE      6.11.5 #1
[   47.313861] Tainted: [P]=PROPRIETARY_MODULE, [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[   47.313861] Hardware name: Notebook X370SNx1/X370SNx1, BIOS 1.07.03aMIN29 09/18/2024
[   47.313862] RIP: 0010:follow_pte+0x220/0x230
[   47.313863] Code: 15 75 33 8c 01 48 81 e2 00 00 00 c0 e9 7b ff ff ff 48 8b 45 d0 48 8b 38 e8 8d e9 e1 00 e8 18 e6 da ff 41 bc ea ff ff ff eb 9f <0f> 0b e9 0d fe ff ff 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
[   47.313864] RSP: 0018:ffff99cac101bb10 EFLAGS: 00010246
[   47.313864] RAX: 0000000000000000 RBX: 00007f65f0007000 RCX: ffff99cac101bb60
[   47.313865] RDX: ffff99cac101bb58 RSI: 00007f65f0007000 RDI: ffff89239994a000
[   47.313865] RBP: ffff99cac101bb48 R08: ffff99cac101bd18 R09: 0000000000000000
[   47.313865] R10: 0000000000000000 R11: 0000000000000000 R12: ffff99cac101bba8
[   47.313866] R13: 0000000000000000 R14: ffff99cac101bb58 R15: ffff89230c1dc200
[   47.313866] FS:  0000000000000000(0000) GS:ffff892a9e900000(0000) knlGS:0000000000000000
[   47.313867] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   47.313867] CR2: 000070e8b04ee200 CR3: 000000012aa3e000 CR4: 0000000000f50ef0
[   47.313868] PKRU: 55555554
[   47.313868] Call Trace:
[   47.313868]  <TASK>
[   47.313869]  ? show_regs+0x6c/0x80
[   47.313870]  ? __warn+0x88/0x140
[   47.313871]  ? follow_pte+0x220/0x230
[   47.313876]  ? report_bug+0x182/0x1b0
[   47.313877]  ? handle_bug+0x51/0xa0
[   47.313879]  ? exc_invalid_op+0x18/0x80
[   47.313880]  ? asm_exc_invalid_op+0x1b/0x20
[   47.313881]  ? follow_pte+0x220/0x230
[   47.313883]  follow_phys+0x4e/0x110
[   47.313884]  untrack_pfn+0x57/0x130
[   47.313886]  unmap_single_vma+0xbc/0xf0
[   47.313887]  zap_page_range_single+0x138/0x210
[   47.313888]  unmap_mapping_range+0x11b/0x140
[   47.313889]  nv_revoke_gpu_mappings+0x68/0xc0 [nvidia]
[   47.313998]  _nv000741rm+0x35/0xf6 [nvidia]
[   47.314175]  ? rm_execute_work_item+0x141/0x1f0 [nvidia]
[   47.314356]  ? os_execute_work_item+0x6c/0x90 [nvidia]
[   47.314475]  ? _main_loop+0x7e/0x140 [nvidia]
[   47.314596]  ? __pfx__main_loop+0x10/0x10 [nvidia]
[   47.314705]  ? kthread+0xe1/0x110
[   47.314705]  ? __pfx_kthread+0x10/0x10
[   47.314706]  ? ret_from_fork+0x44/0x70
[   47.314707]  ? __pfx_kthread+0x10/0x10
[   47.314708]  ? ret_from_fork_asm+0x1a/0x30
[   47.314709]  </TASK>
[   47.314709] ---[ end trace 0000000000000000 ]---
[   47.314714] ------------[ cut here ]------------
[   47.314714] WARNING: CPU: 2 PID: 1141 at include/linux/rwsem.h:80 follow_pte+0x220/0x230
[   47.314716] Modules linked in: nvidia_uvm(POE) ccm(E) rfcomm(E) snd_seq_dummy(E) snd_hrtimer(E) qrtr(E) cmac(E) algif_hash(E) algif_skcipher(E) af_alg(E) bnep(E) xe(E) snd_hda_codec_realtek(E) drm_gpuvm(E) drm_exec(E) snd_hda_codec_generic(E) gpu_sched(E) drm_suballoc_helper(E) snd_hda_scodec_component(E) binfmt_misc(E) nls_iso8859_1(E) nvidia_drm(POE) nvidia_modeset(POE) nvidia(POE) intel_uncore_frequency(E) intel_uncore_frequency_common(E) intel_tcc_cooling(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) snd_hda_codec_hdmi(E) snd_sof_pci_intel_tgl(E) snd_sof_pci_intel_cnl(E) snd_sof_intel_hda_generic(E) soundwire_intel(E) soundwire_cadence(E) snd_sof_intel_hda_common(E) snd_sof_intel_hda_mlink(E) snd_sof_intel_hda(E) snd_sof_pci(E) snd_sof_xtensa_dsp(E) snd_sof(E) snd_sof_utils(E) snd_soc_hdac_hda(E) snd_soc_acpi_intel_match(E) soundwire_generic_allocation(E) snd_soc_acpi(E) soundwire_bus(E) snd_soc_avs(E) snd_soc_hda_codec(E) snd_hda_ext_core(E) snd_soc_core(E) snd_compress(E) a
 c97_bus(E) snd_pcm_dmaengine(E)
[   47.314727]  snd_hda_intel(E) snd_intel_dspcfg(E) snd_intel_sdw_acpi(E) snd_hda_codec(E) snd_hda_core(E) snd_hwdep(E) snd_pcm(E) uvcvideo(E) videobuf2_vmalloc(E) iwlmvm(E) btusb(E) snd_seq_midi(E) uvc(E) coretemp(E) btrtl(E) videobuf2_memops(E) i915(E) snd_seq_midi_event(E) btintel(E) videobuf2_v4l2(E) mac80211(E) kvm_intel(E) snd_rawmidi(E) btbcm(E) videodev(E) btmtk(E) videobuf2_common(E) ite_829x(OE) snd_seq(E) libarc4(E) drm_buddy(E) mc(E) led_class_multicolor(E) processor_thermal_device_pci(E) bluetooth(E) kvm(E) snd_seq_device(E) spd5118(E) processor_thermal_device(E) drm_display_helper(E) cmdlinepart(E) iwlwifi(E) mei_hdcp(E) mei_pxp(E) snd_timer(E) processor_thermal_wt_hint(E) processor_thermal_rfim(E) cec(E) spi_nor(E) rapl(E) processor_thermal_rapl(E) mtd(E) intel_rapl_msr(E) i2c_i801(E) snd(E) drm_ttm_helper(E) nvidia_wmi_ec_backlight(E) mxm_wmi(E) intel_cstate(E) intel_rapl_common(E) rc_core(E) i2c_mux(E) mei_me(E) processor_thermal_wt_req(E) soundcore(E) spi_intel_pci
 (E) cfg80211(E) ttm(E) i2c_smbus(E)
[   47.314741]  i2c_algo_bit(E) processor_thermal_power_floor(E) spi_intel(E) mei(E) processor_thermal_mbox(E) intel_pmc_core(E) int3403_thermal(E) int340x_thermal_zone(E) intel_vsec(E) int3400_thermal(E) pmt_telemetry(E) intel_hid(E) pmt_class(E) acpi_thermal_rel(E) joydev(E) sparse_keymap(E) acpi_pad(E) input_leds(E) mac_hid(E) serio_raw(E) sch_fq_codel(E) msr(E) parport_pc(E) ppdev(E) lp(E) nvme_fabrics(E) parport(E) nvme_keyring(E) efi_pstore(E) nfnetlink(E) dmi_sysfs(E) ip_tables(E) x_tables(E) autofs4(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) libcrc32c(E) dm_crypt(E) dm_mirror(E) dm_region_hash(E) dm_log(E) usbhid(E) nvme(E) hid_multitouch(E) hid_generic(E) nvme_core(E) nvme_auth(E) crct10dif_pclmul(E) crc32_pclmul(E) polyval_clmulni(E) polyval_generic(E) ghash_clmulni_intel(E) sha256_ssse3(E) thunderbolt(E) sha1_ssse3(E) ucsi_acpi(E) psmouse(E) intel_lpss_pci(E) typec_ucsi(E) igc(E) xhci_pci(E) intel_lpss(E) xhci_pci_renesas(E) vmd(E) idma64(E) typec(E) i2c_hid_acpi(E)
  i2c_hid(E) hid(E) video(E) wmi(E)
[   47.314756]  pinctrl_alderlake(E) aesni_intel(E) crypto_simd(E) cryptd(E)
[   47.314757] CPU: 2 UID: 0 PID: 1141 Comm: nv_queue Tainted: P        W  OE      6.11.5 #1
[   47.314758] Tainted: [P]=PROPRIETARY_MODULE, [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[   47.314758] Hardware name: Notebook X370SNx1/X370SNx1, BIOS 1.07.03aMIN29 09/18/2024
[   47.314758] RIP: 0010:follow_pte+0x220/0x230
[   47.314760] Code: 15 75 33 8c 01 48 81 e2 00 00 00 c0 e9 7b ff ff ff 48 8b 45 d0 48 8b 38 e8 8d e9 e1 00 e8 18 e6 da ff 41 bc ea ff ff ff eb 9f <0f> 0b e9 0d fe ff ff 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
[   47.314760] RSP: 0018:ffff99cac101bb10 EFLAGS: 00010246
[   47.314761] RAX: 0000000000000000 RBX: 00007f65f0012000 RCX: ffff99cac101bb60
[   47.314761] RDX: ffff99cac101bb58 RSI: 00007f65f0012000 RDI: ffff8923085b7e30
[   47.314762] RBP: ffff99cac101bb48 R08: ffff99cac101bd18 R09: 0000000000000000
[   47.314762] R10: 0000000000000000 R11: 0000000000000000 R12: ffff99cac101bba8
[   47.314762] R13: 0000000000000000 R14: ffff99cac101bb58 R15: ffff89230c1dc200
[   47.314763] FS:  0000000000000000(0000) GS:ffff892a9e900000(0000) knlGS:0000000000000000
[   47.314763] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   47.314764] CR2: 000070e8b04ee200 CR3: 000000012aa3e000 CR4: 0000000000f50ef0
[   47.314764] PKRU: 55555554
[   47.314764] Call Trace:
[   47.314765]  <TASK>
[   47.314765]  ? show_regs+0x6c/0x80
[   47.314766]  ? __warn+0x88/0x140
[   47.314767]  ? follow_pte+0x220/0x230
[   47.314769]  ? report_bug+0x182/0x1b0
[   47.314770]  ? handle_bug+0x51/0xa0
[   47.314771]  ? exc_invalid_op+0x18/0x80
[   47.314772]  ? asm_exc_invalid_op+0x1b/0x20
[   47.314773]  ? follow_pte+0x220/0x230
[   47.314775]  follow_phys+0x4e/0x110
[   47.314776]  untrack_pfn+0x57/0x130
[   47.314778]  unmap_single_vma+0xbc/0xf0
[   47.314779]  zap_page_range_single+0x138/0x210
[   47.314780]  unmap_mapping_range+0x11b/0x140
[   47.314781]  nv_revoke_gpu_mappings+0x68/0xc0 [nvidia]
[   47.314901]  _nv000741rm+0x35/0xf6 [nvidia]
[   47.315078]  ? rm_execute_work_item+0x141/0x1f0 [nvidia]
[   47.315263]  ? os_execute_work_item+0x6c/0x90 [nvidia]
[   47.315384]  ? _main_loop+0x7e/0x140 [nvidia]
[   47.315506]  ? __pfx__main_loop+0x10/0x10 [nvidia]
[   47.315624]  ? kthread+0xe1/0x110
[   47.315625]  ? __pfx_kthread+0x10/0x10
[   47.315626]  ? ret_from_fork+0x44/0x70
[   47.315627]  ? __pfx_kthread+0x10/0x10
[   47.315627]  ? ret_from_fork_asm+0x1a/0x30
[   47.315629]  </TASK>
[   47.315629] ---[ end trace 0000000000000000 ]---
[   47.315633] ------------[ cut here ]------------
[   47.315634] WARNING: CPU: 2 PID: 1141 at include/linux/rwsem.h:80 follow_pte+0x220/0x230
[   47.315636] Modules linked in: nvidia_uvm(POE) ccm(E) rfcomm(E) snd_seq_dummy(E) snd_hrtimer(E) qrtr(E) cmac(E) algif_hash(E) algif_skcipher(E) af_alg(E) bnep(E) xe(E) snd_hda_codec_realtek(E) drm_gpuvm(E) drm_exec(E) snd_hda_codec_generic(E) gpu_sched(E) drm_suballoc_helper(E) snd_hda_scodec_component(E) binfmt_misc(E) nls_iso8859_1(E) nvidia_drm(POE) nvidia_modeset(POE) nvidia(POE) intel_uncore_frequency(E) intel_uncore_frequency_common(E) intel_tcc_cooling(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) snd_hda_codec_hdmi(E) snd_sof_pci_intel_tgl(E) snd_sof_pci_intel_cnl(E) snd_sof_intel_hda_generic(E) soundwire_intel(E) soundwire_cadence(E) snd_sof_intel_hda_common(E) snd_sof_intel_hda_mlink(E) snd_sof_intel_hda(E) snd_sof_pci(E) snd_sof_xtensa_dsp(E) snd_sof(E) snd_sof_utils(E) snd_soc_hdac_hda(E) snd_soc_acpi_intel_match(E) soundwire_generic_allocation(E) snd_soc_acpi(E) soundwire_bus(E) snd_soc_avs(E) snd_soc_hda_codec(E) snd_hda_ext_core(E) snd_soc_core(E) snd_compress(E) a
 c97_bus(E) snd_pcm_dmaengine(E)
[   47.315647]  snd_hda_intel(E) snd_intel_dspcfg(E) snd_intel_sdw_acpi(E) snd_hda_codec(E) snd_hda_core(E) snd_hwdep(E) snd_pcm(E) uvcvideo(E) videobuf2_vmalloc(E) iwlmvm(E) btusb(E) snd_seq_midi(E) uvc(E) coretemp(E) btrtl(E) videobuf2_memops(E) i915(E) snd_seq_midi_event(E) btintel(E) videobuf2_v4l2(E) mac80211(E) kvm_intel(E) snd_rawmidi(E) btbcm(E) videodev(E) btmtk(E) videobuf2_common(E) ite_829x(OE) snd_seq(E) libarc4(E) drm_buddy(E) mc(E) led_class_multicolor(E) processor_thermal_device_pci(E) bluetooth(E) kvm(E) snd_seq_device(E) spd5118(E) processor_thermal_device(E) drm_display_helper(E) cmdlinepart(E) iwlwifi(E) mei_hdcp(E) mei_pxp(E) snd_timer(E) processor_thermal_wt_hint(E) processor_thermal_rfim(E) cec(E) spi_nor(E) rapl(E) processor_thermal_rapl(E) mtd(E) intel_rapl_msr(E) i2c_i801(E) snd(E) drm_ttm_helper(E) nvidia_wmi_ec_backlight(E) mxm_wmi(E) intel_cstate(E) intel_rapl_common(E) rc_core(E) i2c_mux(E) mei_me(E) processor_thermal_wt_req(E) soundcore(E) spi_intel_pci
 (E) cfg80211(E) ttm(E) i2c_smbus(E)
[   47.315661]  i2c_algo_bit(E) processor_thermal_power_floor(E) spi_intel(E) mei(E) processor_thermal_mbox(E) intel_pmc_core(E) int3403_thermal(E) int340x_thermal_zone(E) intel_vsec(E) int3400_thermal(E) pmt_telemetry(E) intel_hid(E) pmt_class(E) acpi_thermal_rel(E) joydev(E) sparse_keymap(E) acpi_pad(E) input_leds(E) mac_hid(E) serio_raw(E) sch_fq_codel(E) msr(E) parport_pc(E) ppdev(E) lp(E) nvme_fabrics(E) parport(E) nvme_keyring(E) efi_pstore(E) nfnetlink(E) dmi_sysfs(E) ip_tables(E) x_tables(E) autofs4(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) libcrc32c(E) dm_crypt(E) dm_mirror(E) dm_region_hash(E) dm_log(E) usbhid(E) nvme(E) hid_multitouch(E) hid_generic(E) nvme_core(E) nvme_auth(E) crct10dif_pclmul(E) crc32_pclmul(E) polyval_clmulni(E) polyval_generic(E) ghash_clmulni_intel(E) sha256_ssse3(E) thunderbolt(E) sha1_ssse3(E) ucsi_acpi(E) psmouse(E) intel_lpss_pci(E) typec_ucsi(E) igc(E) xhci_pci(E) intel_lpss(E) xhci_pci_renesas(E) vmd(E) idma64(E) typec(E) i2c_hid_acpi(E)
  i2c_hid(E) hid(E) video(E) wmi(E)
[   47.315675]  pinctrl_alderlake(E) aesni_intel(E) crypto_simd(E) cryptd(E)
[   47.315676] CPU: 2 UID: 0 PID: 1141 Comm: nv_queue Tainted: P        W  OE      6.11.5 #1
[   47.315677] Tainted: [P]=PROPRIETARY_MODULE, [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[   47.315678] Hardware name: Notebook X370SNx1/X370SNx1, BIOS 1.07.03aMIN29 09/18/2024
[   47.315678] RIP: 0010:follow_pte+0x220/0x230
[   47.315679] Code: 15 75 33 8c 01 48 81 e2 00 00 00 c0 e9 7b ff ff ff 48 8b 45 d0 48 8b 38 e8 8d e9 e1 00 e8 18 e6 da ff 41 bc ea ff ff ff eb 9f <0f> 0b e9 0d fe ff ff 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
[   47.315680] RSP: 0018:ffff99cac101bb10 EFLAGS: 00010246
[   47.315681] RAX: 0000000000000000 RBX: 00007e67d3c12000 RCX: ffff99cac101bb60
[   47.315681] RDX: ffff99cac101bb58 RSI: 00007e67d3c12000 RDI: ffff892394dc8b80
[   47.315681] RBP: ffff99cac101bb48 R08: ffff99cac101bd18 R09: 0000000000000000
[   47.315682] R10: 0000000000000000 R11: 0000000000000000 R12: ffff99cac101bba8
[   47.315682] R13: 0000000000000000 R14: ffff99cac101bb58 R15: ffff89234047f900
[   47.315683] FS:  0000000000000000(0000) GS:ffff892a9e900000(0000) knlGS:0000000000000000
[   47.315683] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   47.315684] CR2: 000070e8b04ee200 CR3: 000000012aa3e000 CR4: 0000000000f50ef0
[   47.315684] PKRU: 55555554
[   47.315685] Call Trace:
[   47.315685]  <TASK>
[   47.315685]  ? show_regs+0x6c/0x80
[   47.315686]  ? __warn+0x88/0x140
[   47.315688]  ? follow_pte+0x220/0x230
[   47.315689]  ? report_bug+0x182/0x1b0
[   47.315690]  ? handle_bug+0x51/0xa0
[   47.315691]  ? exc_invalid_op+0x18/0x80
[   47.315692]  ? asm_exc_invalid_op+0x1b/0x20
[   47.315694]  ? follow_pte+0x220/0x230
[   47.315695]  follow_phys+0x4e/0x110
[   47.315696]  untrack_pfn+0x57/0x130
[   47.315698]  unmap_single_vma+0xbc/0xf0
[   47.315699]  zap_page_range_single+0x138/0x210
[   47.315700]  unmap_mapping_range+0x11b/0x140
[   47.315701]  nv_revoke_gpu_mappings+0x68/0xc0 [nvidia]
[   47.315808]  _nv000741rm+0x35/0xf6 [nvidia]
[   47.315978]  ? rm_execute_work_item+0x141/0x1f0 [nvidia]
[   47.316156]  ? os_execute_work_item+0x6c/0x90 [nvidia]
[   47.316276]  ? _main_loop+0x7e/0x140 [nvidia]
[   47.316397]  ? __pfx__main_loop+0x10/0x10 [nvidia]
[   47.316516]  ? kthread+0xe1/0x110
[   47.316517]  ? __pfx_kthread+0x10/0x10
[   47.316518]  ? ret_from_fork+0x44/0x70
[   47.316519]  ? __pfx_kthread+0x10/0x10
[   47.316520]  ? ret_from_fork_asm+0x1a/0x30
[   47.316522]  </TASK>
[   47.316522] ---[ end trace 0000000000000000 ]---
[   47.316527] ------------[ cut here ]------------
[   47.316527] WARNING: CPU: 2 PID: 1141 at include/linux/rwsem.h:80 follow_pte+0x220/0x230
[   47.316529] Modules linked in: nvidia_uvm(POE) ccm(E) rfcomm(E) snd_seq_dummy(E) snd_hrtimer(E) qrtr(E) cmac(E) algif_hash(E) algif_skcipher(E) af_alg(E) bnep(E) xe(E) snd_hda_codec_realtek(E) drm_gpuvm(E) drm_exec(E) snd_hda_codec_generic(E) gpu_sched(E) drm_suballoc_helper(E) snd_hda_scodec_component(E) binfmt_misc(E) nls_iso8859_1(E) nvidia_drm(POE) nvidia_modeset(POE) nvidia(POE) intel_uncore_frequency(E) intel_uncore_frequency_common(E) intel_tcc_cooling(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) snd_hda_codec_hdmi(E) snd_sof_pci_intel_tgl(E) snd_sof_pci_intel_cnl(E) snd_sof_intel_hda_generic(E) soundwire_intel(E) soundwire_cadence(E) snd_sof_intel_hda_common(E) snd_sof_intel_hda_mlink(E) snd_sof_intel_hda(E) snd_sof_pci(E) snd_sof_xtensa_dsp(E) snd_sof(E) snd_sof_utils(E) snd_soc_hdac_hda(E) snd_soc_acpi_intel_match(E) soundwire_generic_allocation(E) snd_soc_acpi(E) soundwire_bus(E) snd_soc_avs(E) snd_soc_hda_codec(E) snd_hda_ext_core(E) snd_soc_core(E) snd_compress(E) a
 c97_bus(E) snd_pcm_dmaengine(E)
[   47.316542]  snd_hda_intel(E) snd_intel_dspcfg(E) snd_intel_sdw_acpi(E) snd_hda_codec(E) snd_hda_core(E) snd_hwdep(E) snd_pcm(E) uvcvideo(E) videobuf2_vmalloc(E) iwlmvm(E) btusb(E) snd_seq_midi(E) uvc(E) coretemp(E) btrtl(E) videobuf2_memops(E) i915(E) snd_seq_midi_event(E) btintel(E) videobuf2_v4l2(E) mac80211(E) kvm_intel(E) snd_rawmidi(E) btbcm(E) videodev(E) btmtk(E) videobuf2_common(E) ite_829x(OE) snd_seq(E) libarc4(E) drm_buddy(E) mc(E) led_class_multicolor(E) processor_thermal_device_pci(E) bluetooth(E) kvm(E) snd_seq_device(E) spd5118(E) processor_thermal_device(E) drm_display_helper(E) cmdlinepart(E) iwlwifi(E) mei_hdcp(E) mei_pxp(E) snd_timer(E) processor_thermal_wt_hint(E) processor_thermal_rfim(E) cec(E) spi_nor(E) rapl(E) processor_thermal_rapl(E) mtd(E) intel_rapl_msr(E) i2c_i801(E) snd(E) drm_ttm_helper(E) nvidia_wmi_ec_backlight(E) mxm_wmi(E) intel_cstate(E) intel_rapl_common(E) rc_core(E) i2c_mux(E) mei_me(E) processor_thermal_wt_req(E) soundcore(E) spi_intel_pci
 (E) cfg80211(E) ttm(E) i2c_smbus(E)
[   47.316557]  i2c_algo_bit(E) processor_thermal_power_floor(E) spi_intel(E) mei(E) processor_thermal_mbox(E) intel_pmc_core(E) int3403_thermal(E) int340x_thermal_zone(E) intel_vsec(E) int3400_thermal(E) pmt_telemetry(E) intel_hid(E) pmt_class(E) acpi_thermal_rel(E) joydev(E) sparse_keymap(E) acpi_pad(E) input_leds(E) mac_hid(E) serio_raw(E) sch_fq_codel(E) msr(E) parport_pc(E) ppdev(E) lp(E) nvme_fabrics(E) parport(E) nvme_keyring(E) efi_pstore(E) nfnetlink(E) dmi_sysfs(E) ip_tables(E) x_tables(E) autofs4(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) libcrc32c(E) dm_crypt(E) dm_mirror(E) dm_region_hash(E) dm_log(E) usbhid(E) nvme(E) hid_multitouch(E) hid_generic(E) nvme_core(E) nvme_auth(E) crct10dif_pclmul(E) crc32_pclmul(E) polyval_clmulni(E) polyval_generic(E) ghash_clmulni_intel(E) sha256_ssse3(E) thunderbolt(E) sha1_ssse3(E) ucsi_acpi(E) psmouse(E) intel_lpss_pci(E) typec_ucsi(E) igc(E) xhci_pci(E) intel_lpss(E) xhci_pci_renesas(E) vmd(E) idma64(E) typec(E) i2c_hid_acpi(E)
  i2c_hid(E) hid(E) video(E) wmi(E)
[   47.316573]  pinctrl_alderlake(E) aesni_intel(E) crypto_simd(E) cryptd(E)
[   47.316574] CPU: 2 UID: 0 PID: 1141 Comm: nv_queue Tainted: P        W  OE      6.11.5 #1
[   47.316575] Tainted: [P]=PROPRIETARY_MODULE, [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[   47.316576] Hardware name: Notebook X370SNx1/X370SNx1, BIOS 1.07.03aMIN29 09/18/2024
[   47.316576] RIP: 0010:follow_pte+0x220/0x230
[   47.316578] Code: 15 75 33 8c 01 48 81 e2 00 00 00 c0 e9 7b ff ff ff 48 8b 45 d0 48 8b 38 e8 8d e9 e1 00 e8 18 e6 da ff 41 bc ea ff ff ff eb 9f <0f> 0b e9 0d fe ff ff 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
[   47.316578] RSP: 0018:ffff99cac101bb10 EFLAGS: 00010246
[   47.316579] RAX: 0000000000000000 RBX: 00007e67cd920000 RCX: ffff99cac101bb60
[   47.316579] RDX: ffff99cac101bb58 RSI: 00007e67cd920000 RDI: ffff892311626cf0
[   47.316580] RBP: ffff99cac101bb48 R08: ffff99cac101bd18 R09: 0000000000000000
[   47.316580] R10: 0000000000000000 R11: 0000000000000000 R12: ffff99cac101bba8
[   47.316581] R13: 0000000000000000 R14: ffff99cac101bb58 R15: ffff89234047f900
[   47.316581] FS:  0000000000000000(0000) GS:ffff892a9e900000(0000) knlGS:0000000000000000
[   47.316582] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   47.316582] CR2: 000070e8b04ee200 CR3: 000000012aa3e000 CR4: 0000000000f50ef0
[   47.316583] PKRU: 55555554
[   47.316583] Call Trace:
[   47.316583]  <TASK>
[   47.316584]  ? show_regs+0x6c/0x80
[   47.316585]  ? __warn+0x88/0x140
[   47.316586]  ? follow_pte+0x220/0x230
[   47.316588]  ? report_bug+0x182/0x1b0
[   47.316589]  ? handle_bug+0x51/0xa0
[   47.316590]  ? exc_invalid_op+0x18/0x80
[   47.316592]  ? asm_exc_invalid_op+0x1b/0x20
[   47.316593]  ? follow_pte+0x220/0x230
[   47.316594]  follow_phys+0x4e/0x110
[   47.316596]  untrack_pfn+0x57/0x130
[   47.316598]  unmap_single_vma+0xbc/0xf0
[   47.316599]  zap_page_range_single+0x138/0x210
[   47.316600]  unmap_mapping_range+0x11b/0x140
[   47.316601]  nv_revoke_gpu_mappings+0x68/0xc0 [nvidia]
[   47.316715]  _nv000741rm+0x35/0xf6 [nvidia]
[   47.316873]  ? rm_execute_work_item+0x141/0x1f0 [nvidia]
[   47.317055]  ? os_execute_work_item+0x6c/0x90 [nvidia]
[   47.317175]  ? _main_loop+0x7e/0x140 [nvidia]
[   47.317297]  ? __pfx__main_loop+0x10/0x10 [nvidia]
[   47.317417]  ? kthread+0xe1/0x110
[   47.317418]  ? __pfx_kthread+0x10/0x10
[   47.317419]  ? ret_from_fork+0x44/0x70
[   47.317420]  ? __pfx_kthread+0x10/0x10
[   47.317420]  ? ret_from_fork_asm+0x1a/0x30
[   47.317422]  </TASK>
[   47.317422] ---[ end trace 0000000000000000 ]---
[   47.317427] ------------[ cut here ]------------
[   47.317428] WARNING: CPU: 2 PID: 1141 at include/linux/rwsem.h:80 follow_pte+0x220/0x230
[   47.317429] Modules linked in: nvidia_uvm(POE) ccm(E) rfcomm(E) snd_seq_dummy(E) snd_hrtimer(E) qrtr(E) cmac(E) algif_hash(E) algif_skcipher(E) af_alg(E) bnep(E) xe(E) snd_hda_codec_realtek(E) drm_gpuvm(E) drm_exec(E) snd_hda_codec_generic(E) gpu_sched(E) drm_suballoc_helper(E) snd_hda_scodec_component(E) binfmt_misc(E) nls_iso8859_1(E) nvidia_drm(POE) nvidia_modeset(POE) nvidia(POE) intel_uncore_frequency(E) intel_uncore_frequency_common(E) intel_tcc_cooling(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) snd_hda_codec_hdmi(E) snd_sof_pci_intel_tgl(E) snd_sof_pci_intel_cnl(E) snd_sof_intel_hda_generic(E) soundwire_intel(E) soundwire_cadence(E) snd_sof_intel_hda_common(E) snd_sof_intel_hda_mlink(E) snd_sof_intel_hda(E) snd_sof_pci(E) snd_sof_xtensa_dsp(E) snd_sof(E) snd_sof_utils(E) snd_soc_hdac_hda(E) snd_soc_acpi_intel_match(E) soundwire_generic_allocation(E) snd_soc_acpi(E) soundwire_bus(E) snd_soc_avs(E) snd_soc_hda_codec(E) snd_hda_ext_core(E) snd_soc_core(E) snd_compress(E) a
 c97_bus(E) snd_pcm_dmaengine(E)
[   47.317443]  snd_hda_intel(E) snd_intel_dspcfg(E) snd_intel_sdw_acpi(E) snd_hda_codec(E) snd_hda_core(E) snd_hwdep(E) snd_pcm(E) uvcvideo(E) videobuf2_vmalloc(E) iwlmvm(E) btusb(E) snd_seq_midi(E) uvc(E) coretemp(E) btrtl(E) videobuf2_memops(E) i915(E) snd_seq_midi_event(E) btintel(E) videobuf2_v4l2(E) mac80211(E) kvm_intel(E) snd_rawmidi(E) btbcm(E) videodev(E) btmtk(E) videobuf2_common(E) ite_829x(OE) snd_seq(E) libarc4(E) drm_buddy(E) mc(E) led_class_multicolor(E) processor_thermal_device_pci(E) bluetooth(E) kvm(E) snd_seq_device(E) spd5118(E) processor_thermal_device(E) drm_display_helper(E) cmdlinepart(E) iwlwifi(E) mei_hdcp(E) mei_pxp(E) snd_timer(E) processor_thermal_wt_hint(E) processor_thermal_rfim(E) cec(E) spi_nor(E) rapl(E) processor_thermal_rapl(E) mtd(E) intel_rapl_msr(E) i2c_i801(E) snd(E) drm_ttm_helper(E) nvidia_wmi_ec_backlight(E) mxm_wmi(E) intel_cstate(E) intel_rapl_common(E) rc_core(E) i2c_mux(E) mei_me(E) processor_thermal_wt_req(E) soundcore(E) spi_intel_pci
 (E) cfg80211(E) ttm(E) i2c_smbus(E)
[   47.317458]  i2c_algo_bit(E) processor_thermal_power_floor(E) spi_intel(E) mei(E) processor_thermal_mbox(E) intel_pmc_core(E) int3403_thermal(E) int340x_thermal_zone(E) intel_vsec(E) int3400_thermal(E) pmt_telemetry(E) intel_hid(E) pmt_class(E) acpi_thermal_rel(E) joydev(E) sparse_keymap(E) acpi_pad(E) input_leds(E) mac_hid(E) serio_raw(E) sch_fq_codel(E) msr(E) parport_pc(E) ppdev(E) lp(E) nvme_fabrics(E) parport(E) nvme_keyring(E) efi_pstore(E) nfnetlink(E) dmi_sysfs(E) ip_tables(E) x_tables(E) autofs4(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) libcrc32c(E) dm_crypt(E) dm_mirror(E) dm_region_hash(E) dm_log(E) usbhid(E) nvme(E) hid_multitouch(E) hid_generic(E) nvme_core(E) nvme_auth(E) crct10dif_pclmul(E) crc32_pclmul(E) polyval_clmulni(E) polyval_generic(E) ghash_clmulni_intel(E) sha256_ssse3(E) thunderbolt(E) sha1_ssse3(E) ucsi_acpi(E) psmouse(E) intel_lpss_pci(E) typec_ucsi(E) igc(E) xhci_pci(E) intel_lpss(E) xhci_pci_renesas(E) vmd(E) idma64(E) typec(E) i2c_hid_acpi(E)
  i2c_hid(E) hid(E) video(E) wmi(E)
[   47.317474]  pinctrl_alderlake(E) aesni_intel(E) crypto_simd(E) cryptd(E)
[   47.317475] CPU: 2 UID: 0 PID: 1141 Comm: nv_queue Tainted: P        W  OE      6.11.5 #1
[   47.317476] Tainted: [P]=PROPRIETARY_MODULE, [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[   47.317476] Hardware name: Notebook X370SNx1/X370SNx1, BIOS 1.07.03aMIN29 09/18/2024
[   47.317477] RIP: 0010:follow_pte+0x220/0x230
[   47.317478] Code: 15 75 33 8c 01 48 81 e2 00 00 00 c0 e9 7b ff ff ff 48 8b 45 d0 48 8b 38 e8 8d e9 e1 00 e8 18 e6 da ff 41 bc ea ff ff ff eb 9f <0f> 0b e9 0d fe ff ff 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
[   47.317479] RSP: 0018:ffff99cac101bb10 EFLAGS: 00010246
[   47.317480] RAX: 0000000000000000 RBX: 00007e67cf212000 RCX: ffff99cac101bb60
[   47.317480] RDX: ffff99cac101bb58 RSI: 00007e67cf212000 RDI: ffff89230c7a99e0
[   47.317480] RBP: ffff99cac101bb48 R08: ffff99cac101bd18 R09: 0000000000000000
[   47.317481] R10: 0000000000000000 R11: 0000000000000000 R12: ffff99cac101bba8
[   47.317481] R13: 0000000000000000 R14: ffff99cac101bb58 R15: ffff89234047f900
[   47.317482] FS:  0000000000000000(0000) GS:ffff892a9e900000(0000) knlGS:0000000000000000
[   47.317482] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   47.317483] CR2: 000070e8b04ee200 CR3: 000000012aa3e000 CR4: 0000000000f50ef0
[   47.317483] PKRU: 55555554
[   47.317484] Call Trace:
[   47.317484]  <TASK>
[   47.317484]  ? show_regs+0x6c/0x80
[   47.317485]  ? __warn+0x88/0x140
[   47.317487]  ? follow_pte+0x220/0x230
[   47.317488]  ? report_bug+0x182/0x1b0
[   47.317490]  ? handle_bug+0x51/0xa0
[   47.317491]  ? exc_invalid_op+0x18/0x80
[   47.317492]  ? asm_exc_invalid_op+0x1b/0x20
[   47.317494]  ? follow_pte+0x220/0x230
[   47.317495]  follow_phys+0x4e/0x110
[   47.317497]  untrack_pfn+0x57/0x130
[   47.317498]  unmap_single_vma+0xbc/0xf0
[   47.317499]  zap_page_range_single+0x138/0x210
[   47.317501]  unmap_mapping_range+0x11b/0x140
[   47.317502]  nv_revoke_gpu_mappings+0x68/0xc0 [nvidia]
[   47.317622]  _nv000741rm+0x35/0xf6 [nvidia]
[   47.317799]  ? rm_execute_work_item+0x141/0x1f0 [nvidia]
[   47.317990]  ? os_execute_work_item+0x6c/0x90 [nvidia]
[   47.318110]  ? _main_loop+0x7e/0x140 [nvidia]
[   47.318231]  ? __pfx__main_loop+0x10/0x10 [nvidia]
[   47.318351]  ? kthread+0xe1/0x110
[   47.318351]  ? __pfx_kthread+0x10/0x10
[   47.318352]  ? ret_from_fork+0x44/0x70
[   47.318353]  ? __pfx_kthread+0x10/0x10
[   47.318354]  ? ret_from_fork_asm+0x1a/0x30
[   47.318356]  </TASK>
[   47.318356] ---[ end trace 0000000000000000 ]---
[   47.318360] ------------[ cut here ]------------
[   47.318360] WARNING: CPU: 2 PID: 1141 at include/linux/rwsem.h:80 follow_pte+0x220/0x230
[   47.318362] Modules linked in: nvidia_uvm(POE) ccm(E) rfcomm(E) snd_seq_dummy(E) snd_hrtimer(E) qrtr(E) cmac(E) algif_hash(E) algif_skcipher(E) af_alg(E) bnep(E) xe(E) snd_hda_codec_realtek(E) drm_gpuvm(E) drm_exec(E) snd_hda_codec_generic(E) gpu_sched(E) drm_suballoc_helper(E) snd_hda_scodec_component(E) binfmt_misc(E) nls_iso8859_1(E) nvidia_drm(POE) nvidia_modeset(POE) nvidia(POE) intel_uncore_frequency(E) intel_uncore_frequency_common(E) intel_tcc_cooling(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) snd_hda_codec_hdmi(E) snd_sof_pci_intel_tgl(E) snd_sof_pci_intel_cnl(E) snd_sof_intel_hda_generic(E) soundwire_intel(E) soundwire_cadence(E) snd_sof_intel_hda_common(E) snd_sof_intel_hda_mlink(E) snd_sof_intel_hda(E) snd_sof_pci(E) snd_sof_xtensa_dsp(E) snd_sof(E) snd_sof_utils(E) snd_soc_hdac_hda(E) snd_soc_acpi_intel_match(E) soundwire_generic_allocation(E) snd_soc_acpi(E) soundwire_bus(E) snd_soc_avs(E) snd_soc_hda_codec(E) snd_hda_ext_core(E) snd_soc_core(E) snd_compress(E) a
 c97_bus(E) snd_pcm_dmaengine(E)
[   47.318375]  snd_hda_intel(E) snd_intel_dspcfg(E) snd_intel_sdw_acpi(E) snd_hda_codec(E) snd_hda_core(E) snd_hwdep(E) snd_pcm(E) uvcvideo(E) videobuf2_vmalloc(E) iwlmvm(E) btusb(E) snd_seq_midi(E) uvc(E) coretemp(E) btrtl(E) videobuf2_memops(E) i915(E) snd_seq_midi_event(E) btintel(E) videobuf2_v4l2(E) mac80211(E) kvm_intel(E) snd_rawmidi(E) btbcm(E) videodev(E) btmtk(E) videobuf2_common(E) ite_829x(OE) snd_seq(E) libarc4(E) drm_buddy(E) mc(E) led_class_multicolor(E) processor_thermal_device_pci(E) bluetooth(E) kvm(E) snd_seq_device(E) spd5118(E) processor_thermal_device(E) drm_display_helper(E) cmdlinepart(E) iwlwifi(E) mei_hdcp(E) mei_pxp(E) snd_timer(E) processor_thermal_wt_hint(E) processor_thermal_rfim(E) cec(E) spi_nor(E) rapl(E) processor_thermal_rapl(E) mtd(E) intel_rapl_msr(E) i2c_i801(E) snd(E) drm_ttm_helper(E) nvidia_wmi_ec_backlight(E) mxm_wmi(E) intel_cstate(E) intel_rapl_common(E) rc_core(E) i2c_mux(E) mei_me(E) processor_thermal_wt_req(E) soundcore(E) spi_intel_pci
 (E) cfg80211(E) ttm(E) i2c_smbus(E)
[   47.318389]  i2c_algo_bit(E) processor_thermal_power_floor(E) spi_intel(E) mei(E) processor_thermal_mbox(E) intel_pmc_core(E) int3403_thermal(E) int340x_thermal_zone(E) intel_vsec(E) int3400_thermal(E) pmt_telemetry(E) intel_hid(E) pmt_class(E) acpi_thermal_rel(E) joydev(E) sparse_keymap(E) acpi_pad(E) input_leds(E) mac_hid(E) serio_raw(E) sch_fq_codel(E) msr(E) parport_pc(E) ppdev(E) lp(E) nvme_fabrics(E) parport(E) nvme_keyring(E) efi_pstore(E) nfnetlink(E) dmi_sysfs(E) ip_tables(E) x_tables(E) autofs4(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) libcrc32c(E) dm_crypt(E) dm_mirror(E) dm_region_hash(E) dm_log(E) usbhid(E) nvme(E) hid_multitouch(E) hid_generic(E) nvme_core(E) nvme_auth(E) crct10dif_pclmul(E) crc32_pclmul(E) polyval_clmulni(E) polyval_generic(E) ghash_clmulni_intel(E) sha256_ssse3(E) thunderbolt(E) sha1_ssse3(E) ucsi_acpi(E) psmouse(E) intel_lpss_pci(E) typec_ucsi(E) igc(E) xhci_pci(E) intel_lpss(E) xhci_pci_renesas(E) vmd(E) idma64(E) typec(E) i2c_hid_acpi(E)
  i2c_hid(E) hid(E) video(E) wmi(E)
[   47.318405]  pinctrl_alderlake(E) aesni_intel(E) crypto_simd(E) cryptd(E)
[   47.318406] CPU: 2 UID: 0 PID: 1141 Comm: nv_queue Tainted: P        W  OE      6.11.5 #1
[   47.318408] Tainted: [P]=PROPRIETARY_MODULE, [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[   47.318408] Hardware name: Notebook X370SNx1/X370SNx1, BIOS 1.07.03aMIN29 09/18/2024
[   47.318408] RIP: 0010:follow_pte+0x220/0x230
[   47.318410] Code: 15 75 33 8c 01 48 81 e2 00 00 00 c0 e9 7b ff ff ff 48 8b 45 d0 48 8b 38 e8 8d e9 e1 00 e8 18 e6 da ff 41 bc ea ff ff ff eb 9f <0f> 0b e9 0d fe ff ff 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
[   47.318410] RSP: 0018:ffff99cac101bb10 EFLAGS: 00010246
[   47.318411] RAX: 0000000000000000 RBX: 00007f65f8140000 RCX: ffff99cac101bb60
[   47.318412] RDX: ffff99cac101bb58 RSI: 00007f65f8140000 RDI: ffff8923351df928
[   47.318412] RBP: ffff99cac101bb48 R08: ffff99cac101bd18 R09: 0000000000000000
[   47.318413] R10: 0000000000000000 R11: 0000000000000000 R12: ffff99cac101bba8
[   47.318413] R13: 0000000000000000 R14: ffff99cac101bb58 R15: ffff89230c1dc200
[   47.318414] FS:  0000000000000000(0000) GS:ffff892a9e900000(0000) knlGS:0000000000000000
[   47.318414] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   47.318415] CR2: 000070e8b04ee200 CR3: 000000012aa3e000 CR4: 0000000000f50ef0
[   47.318415] PKRU: 55555554
[   47.318416] Call Trace:
[   47.318416]  <TASK>
[   47.318416]  ? show_regs+0x6c/0x80
[   47.318417]  ? __warn+0x88/0x140
[   47.318419]  ? follow_pte+0x220/0x230
[   47.318420]  ? report_bug+0x182/0x1b0
[   47.318421]  ? handle_bug+0x51/0xa0
[   47.318423]  ? exc_invalid_op+0x18/0x80
[   47.318424]  ? asm_exc_invalid_op+0x1b/0x20
[   47.318426]  ? follow_pte+0x220/0x230
[   47.318427]  follow_phys+0x4e/0x110
[   47.318429]  untrack_pfn+0x57/0x130
[   47.318430]  unmap_single_vma+0xbc/0xf0
[   47.318431]  zap_page_range_single+0x138/0x210
[   47.318433]  unmap_mapping_range+0x11b/0x140
[   47.318434]  nv_revoke_gpu_mappings+0x68/0xc0 [nvidia]
[   47.318552]  _nv000741rm+0x35/0xf6 [nvidia]
[   47.318721]  ? rm_execute_work_item+0x141/0x1f0 [nvidia]
[   47.318883]  ? os_execute_work_item+0x6c/0x90 [nvidia]
[   47.319052]  ? _main_loop+0x7e/0x140 [nvidia]
[   47.319173]  ? __pfx__main_loop+0x10/0x10 [nvidia]
[   47.319292]  ? kthread+0xe1/0x110
[   47.319293]  ? __pfx_kthread+0x10/0x10
[   47.319294]  ? ret_from_fork+0x44/0x70
[   47.319295]  ? __pfx_kthread+0x10/0x10
[   47.319296]  ? ret_from_fork_asm+0x1a/0x30
[   47.319298]  </TASK>
[   47.319298] ---[ end trace 0000000000000000 ]---
[   47.319302] ------------[ cut here ]------------
[   47.319302] WARNING: CPU: 2 PID: 1141 at include/linux/rwsem.h:80 follow_pte+0x220/0x230
[   47.319304] Modules linked in: nvidia_uvm(POE) ccm(E) rfcomm(E) snd_seq_dummy(E) snd_hrtimer(E) qrtr(E) cmac(E) algif_hash(E) algif_skcipher(E) af_alg(E) bnep(E) xe(E) snd_hda_codec_realtek(E) drm_gpuvm(E) drm_exec(E) snd_hda_codec_generic(E) gpu_sched(E) drm_suballoc_helper(E) snd_hda_scodec_component(E) binfmt_misc(E) nls_iso8859_1(E) nvidia_drm(POE) nvidia_modeset(POE) nvidia(POE) intel_uncore_frequency(E) intel_uncore_frequency_common(E) intel_tcc_cooling(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) snd_hda_codec_hdmi(E) snd_sof_pci_intel_tgl(E) snd_sof_pci_intel_cnl(E) snd_sof_intel_hda_generic(E) soundwire_intel(E) soundwire_cadence(E) snd_sof_intel_hda_common(E) snd_sof_intel_hda_mlink(E) snd_sof_intel_hda(E) snd_sof_pci(E) snd_sof_xtensa_dsp(E) snd_sof(E) snd_sof_utils(E) snd_soc_hdac_hda(E) snd_soc_acpi_intel_match(E) soundwire_generic_allocation(E) snd_soc_acpi(E) soundwire_bus(E) snd_soc_avs(E) snd_soc_hda_codec(E) snd_hda_ext_core(E) snd_soc_core(E) snd_compress(E) a
 c97_bus(E) snd_pcm_dmaengine(E)
[   47.319316]  snd_hda_intel(E) snd_intel_dspcfg(E) snd_intel_sdw_acpi(E) snd_hda_codec(E) snd_hda_core(E) snd_hwdep(E) snd_pcm(E) uvcvideo(E) videobuf2_vmalloc(E) iwlmvm(E) btusb(E) snd_seq_midi(E) uvc(E) coretemp(E) btrtl(E) videobuf2_memops(E) i915(E) snd_seq_midi_event(E) btintel(E) videobuf2_v4l2(E) mac80211(E) kvm_intel(E) snd_rawmidi(E) btbcm(E) videodev(E) btmtk(E) videobuf2_common(E) ite_829x(OE) snd_seq(E) libarc4(E) drm_buddy(E) mc(E) led_class_multicolor(E) processor_thermal_device_pci(E) bluetooth(E) kvm(E) snd_seq_device(E) spd5118(E) processor_thermal_device(E) drm_display_helper(E) cmdlinepart(E) iwlwifi(E) mei_hdcp(E) mei_pxp(E) snd_timer(E) processor_thermal_wt_hint(E) processor_thermal_rfim(E) cec(E) spi_nor(E) rapl(E) processor_thermal_rapl(E) mtd(E) intel_rapl_msr(E) i2c_i801(E) snd(E) drm_ttm_helper(E) nvidia_wmi_ec_backlight(E) mxm_wmi(E) intel_cstate(E) intel_rapl_common(E) rc_core(E) i2c_mux(E) mei_me(E) processor_thermal_wt_req(E) soundcore(E) spi_intel_pci
 (E) cfg80211(E) ttm(E) i2c_smbus(E)
[   47.319331]  i2c_algo_bit(E) processor_thermal_power_floor(E) spi_intel(E) mei(E) processor_thermal_mbox(E) intel_pmc_core(E) int3403_thermal(E) int340x_thermal_zone(E) intel_vsec(E) int3400_thermal(E) pmt_telemetry(E) intel_hid(E) pmt_class(E) acpi_thermal_rel(E) joydev(E) sparse_keymap(E) acpi_pad(E) input_leds(E) mac_hid(E) serio_raw(E) sch_fq_codel(E) msr(E) parport_pc(E) ppdev(E) lp(E) nvme_fabrics(E) parport(E) nvme_keyring(E) efi_pstore(E) nfnetlink(E) dmi_sysfs(E) ip_tables(E) x_tables(E) autofs4(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) libcrc32c(E) dm_crypt(E) dm_mirror(E) dm_region_hash(E) dm_log(E) usbhid(E) nvme(E) hid_multitouch(E) hid_generic(E) nvme_core(E) nvme_auth(E) crct10dif_pclmul(E) crc32_pclmul(E) polyval_clmulni(E) polyval_generic(E) ghash_clmulni_intel(E) sha256_ssse3(E) thunderbolt(E) sha1_ssse3(E) ucsi_acpi(E) psmouse(E) intel_lpss_pci(E) typec_ucsi(E) igc(E) xhci_pci(E) intel_lpss(E) xhci_pci_renesas(E) vmd(E) idma64(E) typec(E) i2c_hid_acpi(E)
  i2c_hid(E) hid(E) video(E) wmi(E)
[   47.319347]  pinctrl_alderlake(E) aesni_intel(E) crypto_simd(E) cryptd(E)
[   47.319348] CPU: 2 UID: 0 PID: 1141 Comm: nv_queue Tainted: P        W  OE      6.11.5 #1
[   47.319349] Tainted: [P]=PROPRIETARY_MODULE, [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[   47.319350] Hardware name: Notebook X370SNx1/X370SNx1, BIOS 1.07.03aMIN29 09/18/2024
[   47.319350] RIP: 0010:follow_pte+0x220/0x230
[   47.319351] Code: 15 75 33 8c 01 48 81 e2 00 00 00 c0 e9 7b ff ff ff 48 8b 45 d0 48 8b 38 e8 8d e9 e1 00 e8 18 e6 da ff 41 bc ea ff ff ff eb 9f <0f> 0b e9 0d fe ff ff 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
[   47.319352] RSP: 0018:ffff99cac101bb10 EFLAGS: 00010246
[   47.319353] RAX: 0000000000000000 RBX: 00007f65f2f40000 RCX: ffff99cac101bb60
[   47.319353] RDX: ffff99cac101bb58 RSI: 00007f65f2f40000 RDI: ffff89233dd43590
[   47.319354] RBP: ffff99cac101bb48 R08: ffff99cac101bd18 R09: 0000000000000000
[   47.319354] R10: 0000000000000000 R11: 0000000000000000 R12: ffff99cac101bba8
[   47.319355] R13: 0000000000000000 R14: ffff99cac101bb58 R15: ffff89230c1dc200
[   47.319355] FS:  0000000000000000(0000) GS:ffff892a9e900000(0000) knlGS:0000000000000000
[   47.319356] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   47.319356] CR2: 000070e8b04ee200 CR3: 000000012aa3e000 CR4: 0000000000f50ef0
[   47.319357] PKRU: 55555554
[   47.319357] Call Trace:
[   47.319357]  <TASK>
[   47.319358]  ? show_regs+0x6c/0x80
[   47.319359]  ? __warn+0x88/0x140
[   47.319360]  ? follow_pte+0x220/0x230
[   47.319362]  ? report_bug+0x182/0x1b0
[   47.319363]  ? handle_bug+0x51/0xa0
[   47.319364]  ? exc_invalid_op+0x18/0x80
[   47.319366]  ? asm_exc_invalid_op+0x1b/0x20
[   47.319367]  ? follow_pte+0x220/0x230
[   47.319369]  follow_phys+0x4e/0x110
[   47.319370]  untrack_pfn+0x57/0x130
[   47.319372]  unmap_single_vma+0xbc/0xf0
[   47.319373]  zap_page_range_single+0x138/0x210
[   47.319374]  unmap_mapping_range+0x11b/0x140
[   47.319375]  nv_revoke_gpu_mappings+0x68/0xc0 [nvidia]
[   47.319495]  _nv000741rm+0x35/0xf6 [nvidia]
[   47.319666]  ? rm_execute_work_item+0x141/0x1f0 [nvidia]
[   47.319826]  ? os_execute_work_item+0x6c/0x90 [nvidia]
[   47.319976]  ? _main_loop+0x7e/0x140 [nvidia]
[   47.320092]  ? __pfx__main_loop+0x10/0x10 [nvidia]
[   47.320210]  ? kthread+0xe1/0x110
[   47.320211]  ? __pfx_kthread+0x10/0x10
[   47.320212]  ? ret_from_fork+0x44/0x70
[   47.320213]  ? __pfx_kthread+0x10/0x10
[   47.320214]  ? ret_from_fork_asm+0x1a/0x30
[   47.320215]  </TASK>
[   47.320216] ---[ end trace 0000000000000000 ]---
[   47.320222] ------------[ cut here ]------------
[   47.320223] WARNING: CPU: 2 PID: 1141 at include/linux/rwsem.h:80 follow_pte+0x220/0x230
[   47.320225] Modules linked in: nvidia_uvm(POE) ccm(E) rfcomm(E) snd_seq_dummy(E) snd_hrtimer(E) qrtr(E) cmac(E) algif_hash(E) algif_skcipher(E) af_alg(E) bnep(E) xe(E) snd_hda_codec_realtek(E) drm_gpuvm(E) drm_exec(E) snd_hda_codec_generic(E) gpu_sched(E) drm_suballoc_helper(E) snd_hda_scodec_component(E) binfmt_misc(E) nls_iso8859_1(E) nvidia_drm(POE) nvidia_modeset(POE) nvidia(POE) intel_uncore_frequency(E) intel_uncore_frequency_common(E) intel_tcc_cooling(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) snd_hda_codec_hdmi(E) snd_sof_pci_intel_tgl(E) snd_sof_pci_intel_cnl(E) snd_sof_intel_hda_generic(E) soundwire_intel(E) soundwire_cadence(E) snd_sof_intel_hda_common(E) snd_sof_intel_hda_mlink(E) snd_sof_intel_hda(E) snd_sof_pci(E) snd_sof_xtensa_dsp(E) snd_sof(E) snd_sof_utils(E) snd_soc_hdac_hda(E) snd_soc_acpi_intel_match(E) soundwire_generic_allocation(E) snd_soc_acpi(E) soundwire_bus(E) snd_soc_avs(E) snd_soc_hda_codec(E) snd_hda_ext_core(E) snd_soc_core(E) snd_compress(E) a
 c97_bus(E) snd_pcm_dmaengine(E)
[   47.320237]  snd_hda_intel(E) snd_intel_dspcfg(E) snd_intel_sdw_acpi(E) snd_hda_codec(E) snd_hda_core(E) snd_hwdep(E) snd_pcm(E) uvcvideo(E) videobuf2_vmalloc(E) iwlmvm(E) btusb(E) snd_seq_midi(E) uvc(E) coretemp(E) btrtl(E) videobuf2_memops(E) i915(E) snd_seq_midi_event(E) btintel(E) videobuf2_v4l2(E) mac80211(E) kvm_intel(E) snd_rawmidi(E) btbcm(E) videodev(E) btmtk(E) videobuf2_common(E) ite_829x(OE) snd_seq(E) libarc4(E) drm_buddy(E) mc(E) led_class_multicolor(E) processor_thermal_device_pci(E) bluetooth(E) kvm(E) snd_seq_device(E) spd5118(E) processor_thermal_device(E) drm_display_helper(E) cmdlinepart(E) iwlwifi(E) mei_hdcp(E) mei_pxp(E) snd_timer(E) processor_thermal_wt_hint(E) processor_thermal_rfim(E) cec(E) spi_nor(E) rapl(E) processor_thermal_rapl(E) mtd(E) intel_rapl_msr(E) i2c_i801(E) snd(E) drm_ttm_helper(E) nvidia_wmi_ec_backlight(E) mxm_wmi(E) intel_cstate(E) intel_rapl_common(E) rc_core(E) i2c_mux(E) mei_me(E) processor_thermal_wt_req(E) soundcore(E) spi_intel_pci
 (E) cfg80211(E) ttm(E) i2c_smbus(E)
[   47.320252]  i2c_algo_bit(E) processor_thermal_power_floor(E) spi_intel(E) mei(E) processor_thermal_mbox(E) intel_pmc_core(E) int3403_thermal(E) int340x_thermal_zone(E) intel_vsec(E) int3400_thermal(E) pmt_telemetry(E) intel_hid(E) pmt_class(E) acpi_thermal_rel(E) joydev(E) sparse_keymap(E) acpi_pad(E) input_leds(E) mac_hid(E) serio_raw(E) sch_fq_codel(E) msr(E) parport_pc(E) ppdev(E) lp(E) nvme_fabrics(E) parport(E) nvme_keyring(E) efi_pstore(E) nfnetlink(E) dmi_sysfs(E) ip_tables(E) x_tables(E) autofs4(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) libcrc32c(E) dm_crypt(E) dm_mirror(E) dm_region_hash(E) dm_log(E) usbhid(E) nvme(E) hid_multitouch(E) hid_generic(E) nvme_core(E) nvme_auth(E) crct10dif_pclmul(E) crc32_pclmul(E) polyval_clmulni(E) polyval_generic(E) ghash_clmulni_intel(E) sha256_ssse3(E) thunderbolt(E) sha1_ssse3(E) ucsi_acpi(E) psmouse(E) intel_lpss_pci(E) typec_ucsi(E) igc(E) xhci_pci(E) intel_lpss(E) xhci_pci_renesas(E) vmd(E) idma64(E) typec(E) i2c_hid_acpi(E)
  i2c_hid(E) hid(E) video(E) wmi(E)
[   47.320268]  pinctrl_alderlake(E) aesni_intel(E) crypto_simd(E) cryptd(E)
[   47.320269] CPU: 2 UID: 0 PID: 1141 Comm: nv_queue Tainted: P        W  OE      6.11.5 #1
[   47.320270] Tainted: [P]=PROPRIETARY_MODULE, [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[   47.320271] Hardware name: Notebook X370SNx1/X370SNx1, BIOS 1.07.03aMIN29 09/18/2024
[   47.320271] RIP: 0010:follow_pte+0x220/0x230
[   47.320272] Code: 15 75 33 8c 01 48 81 e2 00 00 00 c0 e9 7b ff ff ff 48 8b 45 d0 48 8b 38 e8 8d e9 e1 00 e8 18 e6 da ff 41 bc ea ff ff ff eb 9f <0f> 0b e9 0d fe ff ff 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
[   47.320273] RSP: 0018:ffff99cac101bb10 EFLAGS: 00010246
[   47.320274] RAX: 0000000000000000 RBX: 000078725f401000 RCX: ffff99cac101bb60
[   47.320274] RDX: ffff99cac101bb58 RSI: 000078725f401000 RDI: ffff89235cebc450
[   47.320275] RBP: ffff99cac101bb48 R08: ffff99cac101bd18 R09: 0000000000000000
[   47.320275] R10: 0000000000000000 R11: 0000000000000000 R12: ffff99cac101bba8
[   47.320276] R13: 0000000000000000 R14: ffff99cac101bb58 R15: ffff892308036880
[   47.320276] FS:  0000000000000000(0000) GS:ffff892a9e900000(0000) knlGS:0000000000000000
[   47.320277] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   47.320277] CR2: 000070e8b04ee200 CR3: 000000012aa3e000 CR4: 0000000000f50ef0
[   47.320278] PKRU: 55555554
[   47.320278] Call Trace:
[   47.320278]  <TASK>
[   47.320279]  ? show_regs+0x6c/0x80
[   47.320280]  ? __warn+0x88/0x140
[   47.320281]  ? follow_pte+0x220/0x230
[   47.320283]  ? report_bug+0x182/0x1b0
[   47.320284]  ? handle_bug+0x51/0xa0
[   47.320285]  ? exc_invalid_op+0x18/0x80
[   47.320287]  ? asm_exc_invalid_op+0x1b/0x20
[   47.320288]  ? follow_pte+0x220/0x230
[   47.320289]  follow_phys+0x4e/0x110
[   47.320291]  untrack_pfn+0x57/0x130
[   47.320293]  unmap_single_vma+0xbc/0xf0
[   47.320293]  zap_page_range_single+0x138/0x210
[   47.320295]  unmap_mapping_range+0x11b/0x140
[   47.320296]  nv_revoke_gpu_mappings+0x68/0xc0 [nvidia]
[   47.320415]  _nv000741rm+0x35/0xf6 [nvidia]
[   47.320578]  ? rm_execute_work_item+0x141/0x1f0 [nvidia]
[   47.320737]  ? os_execute_work_item+0x6c/0x90 [nvidia]
[   47.320845]  ? _main_loop+0x7e/0x140 [nvidia]
[   47.320987]  ? __pfx__main_loop+0x10/0x10 [nvidia]
[   47.321103]  ? kthread+0xe1/0x110
[   47.321104]  ? __pfx_kthread+0x10/0x10
[   47.321105]  ? ret_from_fork+0x44/0x70
[   47.321106]  ? __pfx_kthread+0x10/0x10
[   47.321107]  ? ret_from_fork_asm+0x1a/0x30
[   47.321108]  </TASK>
[   47.321109] ---[ end trace 0000000000000000 ]---
[   47.321115] ------------[ cut here ]------------
[   47.321116] WARNING: CPU: 2 PID: 1141 at include/linux/rwsem.h:80 follow_pte+0x220/0x230
[   47.321118] Modules linked in: nvidia_uvm(POE) ccm(E) rfcomm(E) snd_seq_dummy(E) snd_hrtimer(E) qrtr(E) cmac(E) algif_hash(E) algif_skcipher(E) af_alg(E) bnep(E) xe(E) snd_hda_codec_realtek(E) drm_gpuvm(E) drm_exec(E) snd_hda_codec_generic(E) gpu_sched(E) drm_suballoc_helper(E) snd_hda_scodec_component(E) binfmt_misc(E) nls_iso8859_1(E) nvidia_drm(POE) nvidia_modeset(POE) nvidia(POE) intel_uncore_frequency(E) intel_uncore_frequency_common(E) intel_tcc_cooling(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) snd_hda_codec_hdmi(E) snd_sof_pci_intel_tgl(E) snd_sof_pci_intel_cnl(E) snd_sof_intel_hda_generic(E) soundwire_intel(E) soundwire_cadence(E) snd_sof_intel_hda_common(E) snd_sof_intel_hda_mlink(E) snd_sof_intel_hda(E) snd_sof_pci(E) snd_sof_xtensa_dsp(E) snd_sof(E) snd_sof_utils(E) snd_soc_hdac_hda(E) snd_soc_acpi_intel_match(E) soundwire_generic_allocation(E) snd_soc_acpi(E) soundwire_bus(E) snd_soc_avs(E) snd_soc_hda_codec(E) snd_hda_ext_core(E) snd_soc_core(E) snd_compress(E) a
 c97_bus(E) snd_pcm_dmaengine(E)
[   47.321130]  snd_hda_intel(E) snd_intel_dspcfg(E) snd_intel_sdw_acpi(E) snd_hda_codec(E) snd_hda_core(E) snd_hwdep(E) snd_pcm(E) uvcvideo(E) videobuf2_vmalloc(E) iwlmvm(E) btusb(E) snd_seq_midi(E) uvc(E) coretemp(E) btrtl(E) videobuf2_memops(E) i915(E) snd_seq_midi_event(E) btintel(E) videobuf2_v4l2(E) mac80211(E) kvm_intel(E) snd_rawmidi(E) btbcm(E) videodev(E) btmtk(E) videobuf2_common(E) ite_829x(OE) snd_seq(E) libarc4(E) drm_buddy(E) mc(E) led_class_multicolor(E) processor_thermal_device_pci(E) bluetooth(E) kvm(E) snd_seq_device(E) spd5118(E) processor_thermal_device(E) drm_display_helper(E) cmdlinepart(E) iwlwifi(E) mei_hdcp(E) mei_pxp(E) snd_timer(E) processor_thermal_wt_hint(E) processor_thermal_rfim(E) cec(E) spi_nor(E) rapl(E) processor_thermal_rapl(E) mtd(E) intel_rapl_msr(E) i2c_i801(E) snd(E) drm_ttm_helper(E) nvidia_wmi_ec_backlight(E) mxm_wmi(E) intel_cstate(E) intel_rapl_common(E) rc_core(E) i2c_mux(E) mei_me(E) processor_thermal_wt_req(E) soundcore(E) spi_intel_pci
 (E) cfg80211(E) ttm(E) i2c_smbus(E)
[   47.321145]  i2c_algo_bit(E) processor_thermal_power_floor(E) spi_intel(E) mei(E) processor_thermal_mbox(E) intel_pmc_core(E) int3403_thermal(E) int340x_thermal_zone(E) intel_vsec(E) int3400_thermal(E) pmt_telemetry(E) intel_hid(E) pmt_class(E) acpi_thermal_rel(E) joydev(E) sparse_keymap(E) acpi_pad(E) input_leds(E) mac_hid(E) serio_raw(E) sch_fq_codel(E) msr(E) parport_pc(E) ppdev(E) lp(E) nvme_fabrics(E) parport(E) nvme_keyring(E) efi_pstore(E) nfnetlink(E) dmi_sysfs(E) ip_tables(E) x_tables(E) autofs4(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) libcrc32c(E) dm_crypt(E) dm_mirror(E) dm_region_hash(E) dm_log(E) usbhid(E) nvme(E) hid_multitouch(E) hid_generic(E) nvme_core(E) nvme_auth(E) crct10dif_pclmul(E) crc32_pclmul(E) polyval_clmulni(E) polyval_generic(E) ghash_clmulni_intel(E) sha256_ssse3(E) thunderbolt(E) sha1_ssse3(E) ucsi_acpi(E) psmouse(E) intel_lpss_pci(E) typec_ucsi(E) igc(E) xhci_pci(E) intel_lpss(E) xhci_pci_renesas(E) vmd(E) idma64(E) typec(E) i2c_hid_acpi(E)
  i2c_hid(E) hid(E) video(E) wmi(E)
[   47.321160]  pinctrl_alderlake(E) aesni_intel(E) crypto_simd(E) cryptd(E)
[   47.321162] CPU: 2 UID: 0 PID: 1141 Comm: nv_queue Tainted: P        W  OE      6.11.5 #1
[   47.321163] Tainted: [P]=PROPRIETARY_MODULE, [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[   47.321163] Hardware name: Notebook X370SNx1/X370SNx1, BIOS 1.07.03aMIN29 09/18/2024
[   47.321164] RIP: 0010:follow_pte+0x220/0x230
[   47.321165] Code: 15 75 33 8c 01 48 81 e2 00 00 00 c0 e9 7b ff ff ff 48 8b 45 d0 48 8b 38 e8 8d e9 e1 00 e8 18 e6 da ff 41 bc ea ff ff ff eb 9f <0f> 0b e9 0d fe ff ff 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
[   47.321166] RSP: 0018:ffff99cac101bb10 EFLAGS: 00010246
[   47.321166] RAX: 0000000000000000 RBX: 000075167a777000 RCX: ffff99cac101bb60
[   47.321167] RDX: ffff99cac101bb58 RSI: 000075167a777000 RDI: ffff89231b199368
[   47.321167] RBP: ffff99cac101bb48 R08: ffff99cac101bd18 R09: 0000000000000000
[   47.321168] R10: 0000000000000000 R11: 0000000000000000 R12: ffff99cac101bba8
[   47.321168] R13: 0000000000000000 R14: ffff99cac101bb58 R15: ffff892315d34780
[   47.321169] FS:  0000000000000000(0000) GS:ffff892a9e900000(0000) knlGS:0000000000000000
[   47.321169] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   47.321170] CR2: 000070e8b04ee200 CR3: 000000012aa3e000 CR4: 0000000000f50ef0
[   47.321170] PKRU: 55555554
[   47.321171] Call Trace:
[   47.321171]  <TASK>
[   47.321171]  ? show_regs+0x6c/0x80
[   47.321172]  ? __warn+0x88/0x140
[   47.321174]  ? follow_pte+0x220/0x230
[   47.321175]  ? report_bug+0x182/0x1b0
[   47.321177]  ? handle_bug+0x51/0xa0
[   47.321178]  ? exc_invalid_op+0x18/0x80
[   47.321179]  ? asm_exc_invalid_op+0x1b/0x20
[   47.321181]  ? follow_pte+0x220/0x230
[   47.321182]  follow_phys+0x4e/0x110
[   47.321184]  untrack_pfn+0x57/0x130
[   47.321185]  unmap_single_vma+0xbc/0xf0
[   47.321186]  zap_page_range_single+0x138/0x210
[   47.321188]  unmap_mapping_range+0x11b/0x140
[   47.321189]  nv_revoke_gpu_mappings+0x68/0xc0 [nvidia]
[   47.321308]  _nv000741rm+0x35/0xf6 [nvidia]
[   47.321485]  ? rm_execute_work_item+0x141/0x1f0 [nvidia]
[   47.321662]  ? os_execute_work_item+0x6c/0x90 [nvidia]
[   47.321771]  ? _main_loop+0x7e/0x140 [nvidia]
[   47.321879]  ? __pfx__main_loop+0x10/0x10 [nvidia]
[   47.322042]  ? kthread+0xe1/0x110
[   47.322043]  ? __pfx_kthread+0x10/0x10
[   47.322044]  ? ret_from_fork+0x44/0x70
[   47.322045]  ? __pfx_kthread+0x10/0x10
[   47.322046]  ? ret_from_fork_asm+0x1a/0x30
[   47.322048]  </TASK>
[   47.322048] ---[ end trace 0000000000000000 ]---
[   47.322053] ------------[ cut here ]------------
[   47.322054] WARNING: CPU: 2 PID: 1141 at include/linux/rwsem.h:80 follow_pte+0x220/0x230
[   47.322056] Modules linked in: nvidia_uvm(POE) ccm(E) rfcomm(E) snd_seq_dummy(E) snd_hrtimer(E) qrtr(E) cmac(E) algif_hash(E) algif_skcipher(E) af_alg(E) bnep(E) xe(E) snd_hda_codec_realtek(E) drm_gpuvm(E) drm_exec(E) snd_hda_codec_generic(E) gpu_sched(E) drm_suballoc_helper(E) snd_hda_scodec_component(E) binfmt_misc(E) nls_iso8859_1(E) nvidia_drm(POE) nvidia_modeset(POE) nvidia(POE) intel_uncore_frequency(E) intel_uncore_frequency_common(E) intel_tcc_cooling(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) snd_hda_codec_hdmi(E) snd_sof_pci_intel_tgl(E) snd_sof_pci_intel_cnl(E) snd_sof_intel_hda_generic(E) soundwire_intel(E) soundwire_cadence(E) snd_sof_intel_hda_common(E) snd_sof_intel_hda_mlink(E) snd_sof_intel_hda(E) snd_sof_pci(E) snd_sof_xtensa_dsp(E) snd_sof(E) snd_sof_utils(E) snd_soc_hdac_hda(E) snd_soc_acpi_intel_match(E) soundwire_generic_allocation(E) snd_soc_acpi(E) soundwire_bus(E) snd_soc_avs(E) snd_soc_hda_codec(E) snd_hda_ext_core(E) snd_soc_core(E) snd_compress(E) a
 c97_bus(E) snd_pcm_dmaengine(E)
[   47.322069]  snd_hda_intel(E) snd_intel_dspcfg(E) snd_intel_sdw_acpi(E) snd_hda_codec(E) snd_hda_core(E) snd_hwdep(E) snd_pcm(E) uvcvideo(E) videobuf2_vmalloc(E) iwlmvm(E) btusb(E) snd_seq_midi(E) uvc(E) coretemp(E) btrtl(E) videobuf2_memops(E) i915(E) snd_seq_midi_event(E) btintel(E) videobuf2_v4l2(E) mac80211(E) kvm_intel(E) snd_rawmidi(E) btbcm(E) videodev(E) btmtk(E) videobuf2_common(E) ite_829x(OE) snd_seq(E) libarc4(E) drm_buddy(E) mc(E) led_class_multicolor(E) processor_thermal_device_pci(E) bluetooth(E) kvm(E) snd_seq_device(E) spd5118(E) processor_thermal_device(E) drm_display_helper(E) cmdlinepart(E) iwlwifi(E) mei_hdcp(E) mei_pxp(E) snd_timer(E) processor_thermal_wt_hint(E) processor_thermal_rfim(E) cec(E) spi_nor(E) rapl(E) processor_thermal_rapl(E) mtd(E) intel_rapl_msr(E) i2c_i801(E) snd(E) drm_ttm_helper(E) nvidia_wmi_ec_backlight(E) mxm_wmi(E) intel_cstate(E) intel_rapl_common(E) rc_core(E) i2c_mux(E) mei_me(E) processor_thermal_wt_req(E) soundcore(E) spi_intel_pci
 (E) cfg80211(E) ttm(E) i2c_smbus(E)
[   47.322085]  i2c_algo_bit(E) processor_thermal_power_floor(E) spi_intel(E) mei(E) processor_thermal_mbox(E) intel_pmc_core(E) int3403_thermal(E) int340x_thermal_zone(E) intel_vsec(E) int3400_thermal(E) pmt_telemetry(E) intel_hid(E) pmt_class(E) acpi_thermal_rel(E) joydev(E) sparse_keymap(E) acpi_pad(E) input_leds(E) mac_hid(E) serio_raw(E) sch_fq_codel(E) msr(E) parport_pc(E) ppdev(E) lp(E) nvme_fabrics(E) parport(E) nvme_keyring(E) efi_pstore(E) nfnetlink(E) dmi_sysfs(E) ip_tables(E) x_tables(E) autofs4(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) libcrc32c(E) dm_crypt(E) dm_mirror(E) dm_region_hash(E) dm_log(E) usbhid(E) nvme(E) hid_multitouch(E) hid_generic(E) nvme_core(E) nvme_auth(E) crct10dif_pclmul(E) crc32_pclmul(E) polyval_clmulni(E) polyval_generic(E) ghash_clmulni_intel(E) sha256_ssse3(E) thunderbolt(E) sha1_ssse3(E) ucsi_acpi(E) psmouse(E) intel_lpss_pci(E) typec_ucsi(E) igc(E) xhci_pci(E) intel_lpss(E) xhci_pci_renesas(E) vmd(E) idma64(E) typec(E) i2c_hid_acpi(E)
  i2c_hid(E) hid(E) video(E) wmi(E)
[   47.322104]  pinctrl_alderlake(E) aesni_intel(E) crypto_simd(E) cryptd(E)
[   47.322107] CPU: 2 UID: 0 PID: 1141 Comm: nv_queue Tainted: P        W  OE      6.11.5 #1
[   47.322108] Tainted: [P]=PROPRIETARY_MODULE, [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[   47.322109] Hardware name: Notebook X370SNx1/X370SNx1, BIOS 1.07.03aMIN29 09/18/2024
[   47.322109] RIP: 0010:follow_pte+0x220/0x230
[   47.322111] Code: 15 75 33 8c 01 48 81 e2 00 00 00 c0 e9 7b ff ff ff 48 8b 45 d0 48 8b 38 e8 8d e9 e1 00 e8 18 e6 da ff 41 bc ea ff ff ff eb 9f <0f> 0b e9 0d fe ff ff 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
[   47.322111] RSP: 0018:ffff99cac101bb10 EFLAGS: 00010246
[   47.322112] RAX: 0000000000000000 RBX: 000078725c20d000 RCX: ffff99cac101bb60
[   47.322112] RDX: ffff99cac101bb58 RSI: 000078725c20d000 RDI: ffff892394dadcc0
[   47.322113] RBP: ffff99cac101bb48 R08: ffff99cac101bd18 R09: 0000000000000000
[   47.322113] R10: 0000000000000000 R11: 0000000000000000 R12: ffff99cac101bba8
[   47.322114] R13: 0000000000000000 R14: ffff99cac101bb58 R15: ffff892308036880
[   47.322114] FS:  0000000000000000(0000) GS:ffff892a9e900000(0000) knlGS:0000000000000000
[   47.322115] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   47.322115] CR2: 000070e8b04ee200 CR3: 000000012aa3e000 CR4: 0000000000f50ef0
[   47.322116] PKRU: 55555554
[   47.322116] Call Trace:
[   47.322117]  <TASK>
[   47.322117]  ? show_regs+0x6c/0x80
[   47.322118]  ? __warn+0x88/0x140
[   47.322120]  ? follow_pte+0x220/0x230
[   47.322121]  ? report_bug+0x182/0x1b0
[   47.322122]  ? handle_bug+0x51/0xa0
[   47.322124]  ? exc_invalid_op+0x18/0x80
[   47.322125]  ? asm_exc_invalid_op+0x1b/0x20
[   47.322126]  ? follow_pte+0x220/0x230
[   47.322128]  follow_phys+0x4e/0x110
[   47.322129]  untrack_pfn+0x57/0x130
[   47.322131]  unmap_single_vma+0xbc/0xf0
[   47.322132]  zap_page_range_single+0x138/0x210
[   47.322133]  unmap_mapping_range+0x11b/0x140
[   47.322134]  nv_revoke_gpu_mappings+0x68/0xc0 [nvidia]
[   47.322254]  _nv000741rm+0x35/0xf6 [nvidia]
[   47.322431]  ? rm_execute_work_item+0x141/0x1f0 [nvidia]
[   47.322600]  ? os_execute_work_item+0x6c/0x90 [nvidia]
[   47.322707]  ? _main_loop+0x7e/0x140 [nvidia]
[   47.322816]  ? __pfx__main_loop+0x10/0x10 [nvidia]
[   47.322939]  ? kthread+0xe1/0x110
[   47.322940]  ? __pfx_kthread+0x10/0x10
[   47.322941]  ? ret_from_fork+0x44/0x70
[   47.322942]  ? __pfx_kthread+0x10/0x10
[   47.322943]  ? ret_from_fork_asm+0x1a/0x30
[   47.322944]  </TASK>
[   47.322945] ---[ end trace 0000000000000000 ]---
[   47.322950] ------------[ cut here ]------------
[   47.322950] WARNING: CPU: 2 PID: 1141 at include/linux/rwsem.h:80 follow_pte+0x220/0x230
[   47.322952] Modules linked in: nvidia_uvm(POE) ccm(E) rfcomm(E) snd_seq_dummy(E) snd_hrtimer(E) qrtr(E) cmac(E) algif_hash(E) algif_skcipher(E) af_alg(E) bnep(E) xe(E) snd_hda_codec_realtek(E) drm_gpuvm(E) drm_exec(E) snd_hda_codec_generic(E) gpu_sched(E) drm_suballoc_helper(E) snd_hda_scodec_component(E) binfmt_misc(E) nls_iso8859_1(E) nvidia_drm(POE) nvidia_modeset(POE) nvidia(POE) intel_uncore_frequency(E) intel_uncore_frequency_common(E) intel_tcc_cooling(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) snd_hda_codec_hdmi(E) snd_sof_pci_intel_tgl(E) snd_sof_pci_intel_cnl(E) snd_sof_intel_hda_generic(E) soundwire_intel(E) soundwire_cadence(E) snd_sof_intel_hda_common(E) snd_sof_intel_hda_mlink(E) snd_sof_intel_hda(E) snd_sof_pci(E) snd_sof_xtensa_dsp(E) snd_sof(E) snd_sof_utils(E) snd_soc_hdac_hda(E) snd_soc_acpi_intel_match(E) soundwire_generic_allocation(E) snd_soc_acpi(E) soundwire_bus(E) snd_soc_avs(E) snd_soc_hda_codec(E) snd_hda_ext_core(E) snd_soc_core(E) snd_compress(E) a
 c97_bus(E) snd_pcm_dmaengine(E)
[   47.322966]  snd_hda_intel(E) snd_intel_dspcfg(E) snd_intel_sdw_acpi(E) snd_hda_codec(E) snd_hda_core(E) snd_hwdep(E) snd_pcm(E) uvcvideo(E) videobuf2_vmalloc(E) iwlmvm(E) btusb(E) snd_seq_midi(E) uvc(E) coretemp(E) btrtl(E) videobuf2_memops(E) i915(E) snd_seq_midi_event(E) btintel(E) videobuf2_v4l2(E) mac80211(E) kvm_intel(E) snd_rawmidi(E) btbcm(E) videodev(E) btmtk(E) videobuf2_common(E) ite_829x(OE) snd_seq(E) libarc4(E) drm_buddy(E) mc(E) led_class_multicolor(E) processor_thermal_device_pci(E) bluetooth(E) kvm(E) snd_seq_device(E) spd5118(E) processor_thermal_device(E) drm_display_helper(E) cmdlinepart(E) iwlwifi(E) mei_hdcp(E) mei_pxp(E) snd_timer(E) processor_thermal_wt_hint(E) processor_thermal_rfim(E) cec(E) spi_nor(E) rapl(E) processor_thermal_rapl(E) mtd(E) intel_rapl_msr(E) i2c_i801(E) snd(E) drm_ttm_helper(E) nvidia_wmi_ec_backlight(E) mxm_wmi(E) intel_cstate(E) intel_rapl_common(E) rc_core(E) i2c_mux(E) mei_me(E) processor_thermal_wt_req(E) soundcore(E) spi_intel_pci
 (E) cfg80211(E) ttm(E) i2c_smbus(E)
[   47.322983]  i2c_algo_bit(E) processor_thermal_power_floor(E) spi_intel(E) mei(E) processor_thermal_mbox(E) intel_pmc_core(E) int3403_thermal(E) int340x_thermal_zone(E) intel_vsec(E) int3400_thermal(E) pmt_telemetry(E) intel_hid(E) pmt_class(E) acpi_thermal_rel(E) joydev(E) sparse_keymap(E) acpi_pad(E) input_leds(E) mac_hid(E) serio_raw(E) sch_fq_codel(E) msr(E) parport_pc(E) ppdev(E) lp(E) nvme_fabrics(E) parport(E) nvme_keyring(E) efi_pstore(E) nfnetlink(E) dmi_sysfs(E) ip_tables(E) x_tables(E) autofs4(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) libcrc32c(E) dm_crypt(E) dm_mirror(E) dm_region_hash(E) dm_log(E) usbhid(E) nvme(E) hid_multitouch(E) hid_generic(E) nvme_core(E) nvme_auth(E) crct10dif_pclmul(E) crc32_pclmul(E) polyval_clmulni(E) polyval_generic(E) ghash_clmulni_intel(E) sha256_ssse3(E) thunderbolt(E) sha1_ssse3(E) ucsi_acpi(E) psmouse(E) intel_lpss_pci(E) typec_ucsi(E) igc(E) xhci_pci(E) intel_lpss(E) xhci_pci_renesas(E) vmd(E) idma64(E) typec(E) i2c_hid_acpi(E)
  i2c_hid(E) hid(E) video(E) wmi(E)
[   47.322999]  pinctrl_alderlake(E) aesni_intel(E) crypto_simd(E) cryptd(E)
[   47.323000] CPU: 2 UID: 0 PID: 1141 Comm: nv_queue Tainted: P        W  OE      6.11.5 #1
[   47.323001] Tainted: [P]=PROPRIETARY_MODULE, [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[   47.323001] Hardware name: Notebook X370SNx1/X370SNx1, BIOS 1.07.03aMIN29 09/18/2024
[   47.323002] RIP: 0010:follow_pte+0x220/0x230
[   47.323003] Code: 15 75 33 8c 01 48 81 e2 00 00 00 c0 e9 7b ff ff ff 48 8b 45 d0 48 8b 38 e8 8d e9 e1 00 e8 18 e6 da ff 41 bc ea ff ff ff eb 9f <0f> 0b e9 0d fe ff ff 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
[   47.323004] RSP: 0018:ffff99cac101bb10 EFLAGS: 00010246
[   47.323004] RAX: 0000000000000000 RBX: 00007a4958175000 RCX: ffff99cac101bb60
[   47.323005] RDX: ffff99cac101bb58 RSI: 00007a4958175000 RDI: ffff8923975880b8
[   47.323005] RBP: ffff99cac101bb48 R08: ffff99cac101bd18 R09: 0000000000000000
[   47.323006] R10: 0000000000000000 R11: 0000000000000000 R12: ffff99cac101bba8
[   47.323006] R13: 0000000000000000 R14: ffff99cac101bb58 R15: ffff89231877b700
[   47.323007] FS:  0000000000000000(0000) GS:ffff892a9e900000(0000) knlGS:0000000000000000
[   47.323007] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   47.323008] CR2: 000070e8b04ee200 CR3: 000000012aa3e000 CR4: 0000000000f50ef0
[   47.323008] PKRU: 55555554
[   47.323009] Call Trace:
[   47.323009]  <TASK>
[   47.323009]  ? show_regs+0x6c/0x80
[   47.323011]  ? __warn+0x88/0x140
[   47.323012]  ? follow_pte+0x220/0x230
[   47.323014]  ? report_bug+0x182/0x1b0
[   47.323015]  ? handle_bug+0x51/0xa0
[   47.323016]  ? exc_invalid_op+0x18/0x80
[   47.323018]  ? asm_exc_invalid_op+0x1b/0x20
[   47.323019]  ? follow_pte+0x220/0x230
[   47.323021]  follow_phys+0x4e/0x110
[   47.323023]  untrack_pfn+0x57/0x130
[   47.323024]  unmap_single_vma+0xbc/0xf0
[   47.323025]  zap_page_range_single+0x138/0x210
[   47.323027]  unmap_mapping_range+0x11b/0x140
[   47.323028]  nv_revoke_gpu_mappings+0x68/0xc0 [nvidia]
[   47.323147]  _nv000741rm+0x35/0xf6 [nvidia]
[   47.323323]  ? rm_execute_work_item+0x141/0x1f0 [nvidia]
[   47.323493]  ? os_execute_work_item+0x6c/0x90 [nvidia]
[   47.323601]  ? _main_loop+0x7e/0x140 [nvidia]
[   47.323711]  ? __pfx__main_loop+0x10/0x10 [nvidia]
[   47.323821]  ? kthread+0xe1/0x110
[   47.323822]  ? __pfx_kthread+0x10/0x10
[   47.323822]  ? ret_from_fork+0x44/0x70
[   47.323823]  ? __pfx_kthread+0x10/0x10
[   47.323824]  ? ret_from_fork_asm+0x1a/0x30
[   47.323825]  </TASK>
[   47.323826] ---[ end trace 0000000000000000 ]---
[   47.323830] ------------[ cut here ]------------
[   47.323831] WARNING: CPU: 2 PID: 1141 at include/linux/rwsem.h:80 follow_pte+0x220/0x230
[   47.323832] Modules linked in: nvidia_uvm(POE) ccm(E) rfcomm(E) snd_seq_dummy(E) snd_hrtimer(E) qrtr(E) cmac(E) algif_hash(E) algif_skcipher(E) af_alg(E) bnep(E) xe(E) snd_hda_codec_realtek(E) drm_gpuvm(E) drm_exec(E) snd_hda_codec_generic(E) gpu_sched(E) drm_suballoc_helper(E) snd_hda_scodec_component(E) binfmt_misc(E) nls_iso8859_1(E) nvidia_drm(POE) nvidia_modeset(POE) nvidia(POE) intel_uncore_frequency(E) intel_uncore_frequency_common(E) intel_tcc_cooling(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) snd_hda_codec_hdmi(E) snd_sof_pci_intel_tgl(E) snd_sof_pci_intel_cnl(E) snd_sof_intel_hda_generic(E) soundwire_intel(E) soundwire_cadence(E) snd_sof_intel_hda_common(E) snd_sof_intel_hda_mlink(E) snd_sof_intel_hda(E) snd_sof_pci(E) snd_sof_xtensa_dsp(E) snd_sof(E) snd_sof_utils(E) snd_soc_hdac_hda(E) snd_soc_acpi_intel_match(E) soundwire_generic_allocation(E) snd_soc_acpi(E) soundwire_bus(E) snd_soc_avs(E) snd_soc_hda_codec(E) snd_hda_ext_core(E) snd_soc_core(E) snd_compress(E) a
 c97_bus(E) snd_pcm_dmaengine(E)
[   47.323844]  snd_hda_intel(E) snd_intel_dspcfg(E) snd_intel_sdw_acpi(E) snd_hda_codec(E) snd_hda_core(E) snd_hwdep(E) snd_pcm(E) uvcvideo(E) videobuf2_vmalloc(E) iwlmvm(E) btusb(E) snd_seq_midi(E) uvc(E) coretemp(E) btrtl(E) videobuf2_memops(E) i915(E) snd_seq_midi_event(E) btintel(E) videobuf2_v4l2(E) mac80211(E) kvm_intel(E) snd_rawmidi(E) btbcm(E) videodev(E) btmtk(E) videobuf2_common(E) ite_829x(OE) snd_seq(E) libarc4(E) drm_buddy(E) mc(E) led_class_multicolor(E) processor_thermal_device_pci(E) bluetooth(E) kvm(E) snd_seq_device(E) spd5118(E) processor_thermal_device(E) drm_display_helper(E) cmdlinepart(E) iwlwifi(E) mei_hdcp(E) mei_pxp(E) snd_timer(E) processor_thermal_wt_hint(E) processor_thermal_rfim(E) cec(E) spi_nor(E) rapl(E) processor_thermal_rapl(E) mtd(E) intel_rapl_msr(E) i2c_i801(E) snd(E) drm_ttm_helper(E) nvidia_wmi_ec_backlight(E) mxm_wmi(E) intel_cstate(E) intel_rapl_common(E) rc_core(E) i2c_mux(E) mei_me(E) processor_thermal_wt_req(E) soundcore(E) spi_intel_pci
 (E) cfg80211(E) ttm(E) i2c_smbus(E)
[   47.323857]  i2c_algo_bit(E) processor_thermal_power_floor(E) spi_intel(E) mei(E) processor_thermal_mbox(E) intel_pmc_core(E) int3403_thermal(E) int340x_thermal_zone(E) intel_vsec(E) int3400_thermal(E) pmt_telemetry(E) intel_hid(E) pmt_class(E) acpi_thermal_rel(E) joydev(E) sparse_keymap(E) acpi_pad(E) input_leds(E) mac_hid(E) serio_raw(E) sch_fq_codel(E) msr(E) parport_pc(E) ppdev(E) lp(E) nvme_fabrics(E) parport(E) nvme_keyring(E) efi_pstore(E) nfnetlink(E) dmi_sysfs(E) ip_tables(E) x_tables(E) autofs4(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) libcrc32c(E) dm_crypt(E) dm_mirror(E) dm_region_hash(E) dm_log(E) usbhid(E) nvme(E) hid_multitouch(E) hid_generic(E) nvme_core(E) nvme_auth(E) crct10dif_pclmul(E) crc32_pclmul(E) polyval_clmulni(E) polyval_generic(E) ghash_clmulni_intel(E) sha256_ssse3(E) thunderbolt(E) sha1_ssse3(E) ucsi_acpi(E) psmouse(E) intel_lpss_pci(E) typec_ucsi(E) igc(E) xhci_pci(E) intel_lpss(E) xhci_pci_renesas(E) vmd(E) idma64(E) typec(E) i2c_hid_acpi(E)
  i2c_hid(E) hid(E) video(E) wmi(E)
[   47.323871]  pinctrl_alderlake(E) aesni_intel(E) crypto_simd(E) cryptd(E)
[   47.323872] CPU: 2 UID: 0 PID: 1141 Comm: nv_queue Tainted: P        W  OE      6.11.5 #1
[   47.323873] Tainted: [P]=PROPRIETARY_MODULE, [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[   47.323874] Hardware name: Notebook X370SNx1/X370SNx1, BIOS 1.07.03aMIN29 09/18/2024
[   47.323874] RIP: 0010:follow_pte+0x220/0x230
[   47.323875] Code: 15 75 33 8c 01 48 81 e2 00 00 00 c0 e9 7b ff ff ff 48 8b 45 d0 48 8b 38 e8 8d e9 e1 00 e8 18 e6 da ff 41 bc ea ff ff ff eb 9f <0f> 0b e9 0d fe ff ff 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
[   47.323876] RSP: 0018:ffff99cac101bb10 EFLAGS: 00010246
[   47.323877] RAX: 0000000000000000 RBX: 00007516794db000 RCX: ffff99cac101bb60
[   47.323877] RDX: ffff99cac101bb58 RSI: 00007516794db000 RDI: ffff89230fa8a2e0
[   47.323877] RBP: ffff99cac101bb48 R08: ffff99cac101bd18 R09: 0000000000000000
[   47.323878] R10: 0000000000000000 R11: 0000000000000000 R12: ffff99cac101bba8
[   47.323878] R13: 0000000000000000 R14: ffff99cac101bb58 R15: ffff892315d34780
[   47.323879] FS:  0000000000000000(0000) GS:ffff892a9e900000(0000) knlGS:0000000000000000
[   47.323879] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   47.323880] CR2: 000070e8b04ee200 CR3: 000000012aa3e000 CR4: 0000000000f50ef0
[   47.323880] PKRU: 55555554
[   47.323880] Call Trace:
[   47.323881]  <TASK>
[   47.323881]  ? show_regs+0x6c/0x80
[   47.323882]  ? __warn+0x88/0x140
[   47.323883]  ? follow_pte+0x220/0x230
[   47.323885]  ? report_bug+0x182/0x1b0
[   47.323886]  ? handle_bug+0x51/0xa0
[   47.323887]  ? exc_invalid_op+0x18/0x80
[   47.323888]  ? asm_exc_invalid_op+0x1b/0x20
[   47.323889]  ? follow_pte+0x220/0x230
[   47.323891]  follow_phys+0x4e/0x110
[   47.323892]  untrack_pfn+0x57/0x130
[   47.323894]  unmap_single_vma+0xbc/0xf0
[   47.323895]  zap_page_range_single+0x138/0x210
[   47.323896]  unmap_mapping_range+0x11b/0x140
[   47.323897]  nv_revoke_gpu_mappings+0x68/0xc0 [nvidia]
[   47.324070]  _nv000741rm+0x35/0xf6 [nvidia]
[   47.324252]  ? rm_execute_work_item+0x141/0x1f0 [nvidia]
[   47.324431]  ? os_execute_work_item+0x6c/0x90 [nvidia]
[   47.324550]  ? _main_loop+0x7e/0x140 [nvidia]
[   47.324670]  ? __pfx__main_loop+0x10/0x10 [nvidia]
[   47.324789]  ? kthread+0xe1/0x110
[   47.324790]  ? __pfx_kthread+0x10/0x10
[   47.324791]  ? ret_from_fork+0x44/0x70
[   47.324792]  ? __pfx_kthread+0x10/0x10
[   47.324793]  ? ret_from_fork_asm+0x1a/0x30
[   47.324794]  </TASK>
[   47.324795] ---[ end trace 0000000000000000 ]---
[   47.324800] ------------[ cut here ]------------
[   47.324800] WARNING: CPU: 2 PID: 1141 at include/linux/rwsem.h:80 follow_pte+0x220/0x230
[   47.324802] Modules linked in: nvidia_uvm(POE) ccm(E) rfcomm(E) snd_seq_dummy(E) snd_hrtimer(E) qrtr(E) cmac(E) algif_hash(E) algif_skcipher(E) af_alg(E) bnep(E) xe(E) snd_hda_codec_realtek(E) drm_gpuvm(E) drm_exec(E) snd_hda_codec_generic(E) gpu_sched(E) drm_suballoc_helper(E) snd_hda_scodec_component(E) binfmt_misc(E) nls_iso8859_1(E) nvidia_drm(POE) nvidia_modeset(POE) nvidia(POE) intel_uncore_frequency(E) intel_uncore_frequency_common(E) intel_tcc_cooling(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) snd_hda_codec_hdmi(E) snd_sof_pci_intel_tgl(E) snd_sof_pci_intel_cnl(E) snd_sof_intel_hda_generic(E) soundwire_intel(E) soundwire_cadence(E) snd_sof_intel_hda_common(E) snd_sof_intel_hda_mlink(E) snd_sof_intel_hda(E) snd_sof_pci(E) snd_sof_xtensa_dsp(E) snd_sof(E) snd_sof_utils(E) snd_soc_hdac_hda(E) snd_soc_acpi_intel_match(E) soundwire_generic_allocation(E) snd_soc_acpi(E) soundwire_bus(E) snd_soc_avs(E) snd_soc_hda_codec(E) snd_hda_ext_core(E) snd_soc_core(E) snd_compress(E) a
 c97_bus(E) snd_pcm_dmaengine(E)
[   47.324814]  snd_hda_intel(E) snd_intel_dspcfg(E) snd_intel_sdw_acpi(E) snd_hda_codec(E) snd_hda_core(E) snd_hwdep(E) snd_pcm(E) uvcvideo(E) videobuf2_vmalloc(E) iwlmvm(E) btusb(E) snd_seq_midi(E) uvc(E) coretemp(E) btrtl(E) videobuf2_memops(E) i915(E) snd_seq_midi_event(E) btintel(E) videobuf2_v4l2(E) mac80211(E) kvm_intel(E) snd_rawmidi(E) btbcm(E) videodev(E) btmtk(E) videobuf2_common(E) ite_829x(OE) snd_seq(E) libarc4(E) drm_buddy(E) mc(E) led_class_multicolor(E) processor_thermal_device_pci(E) bluetooth(E) kvm(E) snd_seq_device(E) spd5118(E) processor_thermal_device(E) drm_display_helper(E) cmdlinepart(E) iwlwifi(E) mei_hdcp(E) mei_pxp(E) snd_timer(E) processor_thermal_wt_hint(E) processor_thermal_rfim(E) cec(E) spi_nor(E) rapl(E) processor_thermal_rapl(E) mtd(E) intel_rapl_msr(E) i2c_i801(E) snd(E) drm_ttm_helper(E) nvidia_wmi_ec_backlight(E) mxm_wmi(E) intel_cstate(E) intel_rapl_common(E) rc_core(E) i2c_mux(E) mei_me(E) processor_thermal_wt_req(E) soundcore(E) spi_intel_pci
 (E) cfg80211(E) ttm(E) i2c_smbus(E)
[   47.324829]  i2c_algo_bit(E) processor_thermal_power_floor(E) spi_intel(E) mei(E) processor_thermal_mbox(E) intel_pmc_core(E) int3403_thermal(E) int340x_thermal_zone(E) intel_vsec(E) int3400_thermal(E) pmt_telemetry(E) intel_hid(E) pmt_class(E) acpi_thermal_rel(E) joydev(E) sparse_keymap(E) acpi_pad(E) input_leds(E) mac_hid(E) serio_raw(E) sch_fq_codel(E) msr(E) parport_pc(E) ppdev(E) lp(E) nvme_fabrics(E) parport(E) nvme_keyring(E) efi_pstore(E) nfnetlink(E) dmi_sysfs(E) ip_tables(E) x_tables(E) autofs4(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) libcrc32c(E) dm_crypt(E) dm_mirror(E) dm_region_hash(E) dm_log(E) usbhid(E) nvme(E) hid_multitouch(E) hid_generic(E) nvme_core(E) nvme_auth(E) crct10dif_pclmul(E) crc32_pclmul(E) polyval_clmulni(E) polyval_generic(E) ghash_clmulni_intel(E) sha256_ssse3(E) thunderbolt(E) sha1_ssse3(E) ucsi_acpi(E) psmouse(E) intel_lpss_pci(E) typec_ucsi(E) igc(E) xhci_pci(E) intel_lpss(E) xhci_pci_renesas(E) vmd(E) idma64(E) typec(E) i2c_hid_acpi(E)
  i2c_hid(E) hid(E) video(E) wmi(E)
[   47.324845]  pinctrl_alderlake(E) aesni_intel(E) crypto_simd(E) cryptd(E)
[   47.324846] CPU: 2 UID: 0 PID: 1141 Comm: nv_queue Tainted: P        W  OE      6.11.5 #1
[   47.324847] Tainted: [P]=PROPRIETARY_MODULE, [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[   47.324848] Hardware name: Notebook X370SNx1/X370SNx1, BIOS 1.07.03aMIN29 09/18/2024
[   47.324848] RIP: 0010:follow_pte+0x220/0x230
[   47.324850] Code: 15 75 33 8c 01 48 81 e2 00 00 00 c0 e9 7b ff ff ff 48 8b 45 d0 48 8b 38 e8 8d e9 e1 00 e8 18 e6 da ff 41 bc ea ff ff ff eb 9f <0f> 0b e9 0d fe ff ff 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
[   47.324850] RSP: 0018:ffff99cac101bb10 EFLAGS: 00010246
[   47.324851] RAX: 0000000000000000 RBX: 00007f65f814d000 RCX: ffff99cac101bb60
[   47.324851] RDX: ffff99cac101bb58 RSI: 00007f65f814d000 RDI: ffff89231b381cc0
[   47.324852] RBP: ffff99cac101bb48 R08: ffff99cac101bd18 R09: 0000000000000000
[   47.324852] R10: 0000000000000000 R11: 0000000000000000 R12: ffff99cac101bba8
[   47.324853] R13: 0000000000000000 R14: ffff99cac101bb58 R15: ffff89230c1dc200
[   47.324853] FS:  0000000000000000(0000) GS:ffff892a9e900000(0000) knlGS:0000000000000000
[   47.324854] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   47.324854] CR2: 000070e8b04ee200 CR3: 000000012aa3e000 CR4: 0000000000f50ef0
[   47.324855] PKRU: 55555554
[   47.324855] Call Trace:
[   47.324855]  <TASK>
[   47.324855]  ? show_regs+0x6c/0x80
[   47.324857]  ? __warn+0x88/0x140
[   47.324858]  ? follow_pte+0x220/0x230
[   47.324860]  ? report_bug+0x182/0x1b0
[   47.324861]  ? handle_bug+0x51/0xa0
[   47.324862]  ? exc_invalid_op+0x18/0x80
[   47.324863]  ? asm_exc_invalid_op+0x1b/0x20
[   47.324865]  ? follow_pte+0x220/0x230
[   47.324866]  follow_phys+0x4e/0x110
[   47.324868]  untrack_pfn+0x57/0x130
[   47.324869]  unmap_single_vma+0xbc/0xf0
[   47.324870]  zap_page_range_single+0x138/0x210
[   47.324872]  unmap_mapping_range+0x11b/0x140
[   47.324873]  nv_revoke_gpu_mappings+0x68/0xc0 [nvidia]
[   47.325039]  _nv000741rm+0x35/0xf6 [nvidia]
[   47.325220]  ? rm_execute_work_item+0x141/0x1f0 [nvidia]
[   47.325409]  ? os_execute_work_item+0x6c/0x90 [nvidia]
[   47.325529]  ? _main_loop+0x7e/0x140 [nvidia]
[   47.325649]  ? __pfx__main_loop+0x10/0x10 [nvidia]
[   47.325763]  ? kthread+0xe1/0x110
[   47.325764]  ? __pfx_kthread+0x10/0x10
[   47.325764]  ? ret_from_fork+0x44/0x70
[   47.325765]  ? __pfx_kthread+0x10/0x10
[   47.325766]  ? ret_from_fork_asm+0x1a/0x30
[   47.325767]  </TASK>
[   47.325768] ---[ end trace 0000000000000000 ]---
[   47.325771] ------------[ cut here ]------------
[   47.325771] WARNING: CPU: 2 PID: 1141 at include/linux/rwsem.h:80 follow_pte+0x220/0x230
[   47.325773] Modules linked in: nvidia_uvm(POE) ccm(E) rfcomm(E) snd_seq_dummy(E) snd_hrtimer(E) qrtr(E) cmac(E) algif_hash(E) algif_skcipher(E) af_alg(E) bnep(E) xe(E) snd_hda_codec_realtek(E) drm_gpuvm(E) drm_exec(E) snd_hda_codec_generic(E) gpu_sched(E) drm_suballoc_helper(E) snd_hda_scodec_component(E) binfmt_misc(E) nls_iso8859_1(E) nvidia_drm(POE) nvidia_modeset(POE) nvidia(POE) intel_uncore_frequency(E) intel_uncore_frequency_common(E) intel_tcc_cooling(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) snd_hda_codec_hdmi(E) snd_sof_pci_intel_tgl(E) snd_sof_pci_intel_cnl(E) snd_sof_intel_hda_generic(E) soundwire_intel(E) soundwire_cadence(E) snd_sof_intel_hda_common(E) snd_sof_intel_hda_mlink(E) snd_sof_intel_hda(E) snd_sof_pci(E) snd_sof_xtensa_dsp(E) snd_sof(E) snd_sof_utils(E) snd_soc_hdac_hda(E) snd_soc_acpi_intel_match(E) soundwire_generic_allocation(E) snd_soc_acpi(E) soundwire_bus(E) snd_soc_avs(E) snd_soc_hda_codec(E) snd_hda_ext_core(E) snd_soc_core(E) snd_compress(E) a
 c97_bus(E) snd_pcm_dmaengine(E)
[   47.325785]  snd_hda_intel(E) snd_intel_dspcfg(E) snd_intel_sdw_acpi(E) snd_hda_codec(E) snd_hda_core(E) snd_hwdep(E) snd_pcm(E) uvcvideo(E) videobuf2_vmalloc(E) iwlmvm(E) btusb(E) snd_seq_midi(E) uvc(E) coretemp(E) btrtl(E) videobuf2_memops(E) i915(E) snd_seq_midi_event(E) btintel(E) videobuf2_v4l2(E) mac80211(E) kvm_intel(E) snd_rawmidi(E) btbcm(E) videodev(E) btmtk(E) videobuf2_common(E) ite_829x(OE) snd_seq(E) libarc4(E) drm_buddy(E) mc(E) led_class_multicolor(E) processor_thermal_device_pci(E) bluetooth(E) kvm(E) snd_seq_device(E) spd5118(E) processor_thermal_device(E) drm_display_helper(E) cmdlinepart(E) iwlwifi(E) mei_hdcp(E) mei_pxp(E) snd_timer(E) processor_thermal_wt_hint(E) processor_thermal_rfim(E) cec(E) spi_nor(E) rapl(E) processor_thermal_rapl(E) mtd(E) intel_rapl_msr(E) i2c_i801(E) snd(E) drm_ttm_helper(E) nvidia_wmi_ec_backlight(E) mxm_wmi(E) intel_cstate(E) intel_rapl_common(E) rc_core(E) i2c_mux(E) mei_me(E) processor_thermal_wt_req(E) soundcore(E) spi_intel_pci
 (E) cfg80211(E) ttm(E) i2c_smbus(E)
[   47.325798]  i2c_algo_bit(E) processor_thermal_power_floor(E) spi_intel(E) mei(E) processor_thermal_mbox(E) intel_pmc_core(E) int3403_thermal(E) int340x_thermal_zone(E) intel_vsec(E) int3400_thermal(E) pmt_telemetry(E) intel_hid(E) pmt_class(E) acpi_thermal_rel(E) joydev(E) sparse_keymap(E) acpi_pad(E) input_leds(E) mac_hid(E) serio_raw(E) sch_fq_codel(E) msr(E) parport_pc(E) ppdev(E) lp(E) nvme_fabrics(E) parport(E) nvme_keyring(E) efi_pstore(E) nfnetlink(E) dmi_sysfs(E) ip_tables(E) x_tables(E) autofs4(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) libcrc32c(E) dm_crypt(E) dm_mirror(E) dm_region_hash(E) dm_log(E) usbhid(E) nvme(E) hid_multitouch(E) hid_generic(E) nvme_core(E) nvme_auth(E) crct10dif_pclmul(E) crc32_pclmul(E) polyval_clmulni(E) polyval_generic(E) ghash_clmulni_intel(E) sha256_ssse3(E) thunderbolt(E) sha1_ssse3(E) ucsi_acpi(E) psmouse(E) intel_lpss_pci(E) typec_ucsi(E) igc(E) xhci_pci(E) intel_lpss(E) xhci_pci_renesas(E) vmd(E) idma64(E) typec(E) i2c_hid_acpi(E)
  i2c_hid(E) hid(E) video(E) wmi(E)
[   47.325812]  pinctrl_alderlake(E) aesni_intel(E) crypto_simd(E) cryptd(E)
[   47.325814] CPU: 2 UID: 0 PID: 1141 Comm: nv_queue Tainted: P        W  OE      6.11.5 #1
[   47.325815] Tainted: [P]=PROPRIETARY_MODULE, [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[   47.325815] Hardware name: Notebook X370SNx1/X370SNx1, BIOS 1.07.03aMIN29 09/18/2024
[   47.325815] RIP: 0010:follow_pte+0x220/0x230
[   47.325817] Code: 15 75 33 8c 01 48 81 e2 00 00 00 c0 e9 7b ff ff ff 48 8b 45 d0 48 8b 38 e8 8d e9 e1 00 e8 18 e6 da ff 41 bc ea ff ff ff eb 9f <0f> 0b e9 0d fe ff ff 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
[   47.325817] RSP: 0018:ffff99cac101bb10 EFLAGS: 00010246
[   47.325818] RAX: 0000000000000000 RBX: 00007a4954340000 RCX: ffff99cac101bb60
[   47.325818] RDX: ffff99cac101bb58 RSI: 00007a4954340000 RDI: ffff892320924cf0
[   47.325819] RBP: ffff99cac101bb48 R08: ffff99cac101bd18 R09: 0000000000000000
[   47.325819] R10: 0000000000000000 R11: 0000000000000000 R12: ffff99cac101bba8
[   47.325819] R13: 0000000000000000 R14: ffff99cac101bb58 R15: ffff89231877b700
[   47.325820] FS:  0000000000000000(0000) GS:ffff892a9e900000(0000) knlGS:0000000000000000
[   47.325820] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   47.325821] CR2: 000070e8b04ee200 CR3: 000000012aa3e000 CR4: 0000000000f50ef0
[   47.325821] PKRU: 55555554
[   47.325822] Call Trace:
[   47.325822]  <TASK>
[   47.325822]  ? show_regs+0x6c/0x80
[   47.325823]  ? __warn+0x88/0x140
[   47.325825]  ? follow_pte+0x220/0x230
[   47.325826]  ? report_bug+0x182/0x1b0
[   47.325827]  ? handle_bug+0x51/0xa0
[   47.325828]  ? exc_invalid_op+0x18/0x80
[   47.325829]  ? asm_exc_invalid_op+0x1b/0x20
[   47.325831]  ? follow_pte+0x220/0x230
[   47.325832]  follow_phys+0x4e/0x110
[   47.325833]  untrack_pfn+0x57/0x130
[   47.325835]  unmap_single_vma+0xbc/0xf0
[   47.325836]  zap_page_range_single+0x138/0x210
[   47.325837]  unmap_mapping_range+0x11b/0x140
[   47.325838]  nv_revoke_gpu_mappings+0x68/0xc0 [nvidia]
[   47.325967]  _nv000741rm+0x35/0xf6 [nvidia]
[   47.326142]  ? rm_execute_work_item+0x141/0x1f0 [nvidia]
[   47.326319]  ? os_execute_work_item+0x6c/0x90 [nvidia]
[   47.326440]  ? _main_loop+0x7e/0x140 [nvidia]
[   47.326557]  ? __pfx__main_loop+0x10/0x10 [nvidia]
[   47.326666]  ? kthread+0xe1/0x110
[   47.326667]  ? __pfx_kthread+0x10/0x10
[   47.326667]  ? ret_from_fork+0x44/0x70
[   47.326668]  ? __pfx_kthread+0x10/0x10
[   47.326669]  ? ret_from_fork_asm+0x1a/0x30
[   47.326670]  </TASK>
[   47.326671] ---[ end trace 0000000000000000 ]---
[   47.326676] ------------[ cut here ]------------
[   47.326676] WARNING: CPU: 2 PID: 1141 at include/linux/rwsem.h:80 follow_pte+0x220/0x230
[   47.326678] Modules linked in: nvidia_uvm(POE) ccm(E) rfcomm(E) snd_seq_dummy(E) snd_hrtimer(E) qrtr(E) cmac(E) algif_hash(E) algif_skcipher(E) af_alg(E) bnep(E) xe(E) snd_hda_codec_realtek(E) drm_gpuvm(E) drm_exec(E) snd_hda_codec_generic(E) gpu_sched(E) drm_suballoc_helper(E) snd_hda_scodec_component(E) binfmt_misc(E) nls_iso8859_1(E) nvidia_drm(POE) nvidia_modeset(POE) nvidia(POE) intel_uncore_frequency(E) intel_uncore_frequency_common(E) intel_tcc_cooling(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) snd_hda_codec_hdmi(E) snd_sof_pci_intel_tgl(E) snd_sof_pci_intel_cnl(E) snd_sof_intel_hda_generic(E) soundwire_intel(E) soundwire_cadence(E) snd_sof_intel_hda_common(E) snd_sof_intel_hda_mlink(E) snd_sof_intel_hda(E) snd_sof_pci(E) snd_sof_xtensa_dsp(E) snd_sof(E) snd_sof_utils(E) snd_soc_hdac_hda(E) snd_soc_acpi_intel_match(E) soundwire_generic_allocation(E) snd_soc_acpi(E) soundwire_bus(E) snd_soc_avs(E) snd_soc_hda_codec(E) snd_hda_ext_core(E) snd_soc_core(E) snd_compress(E) a
 c97_bus(E) snd_pcm_dmaengine(E)
[   47.326690]  snd_hda_intel(E) snd_intel_dspcfg(E) snd_intel_sdw_acpi(E) snd_hda_codec(E) snd_hda_core(E) snd_hwdep(E) snd_pcm(E) uvcvideo(E) videobuf2_vmalloc(E) iwlmvm(E) btusb(E) snd_seq_midi(E) uvc(E) coretemp(E) btrtl(E) videobuf2_memops(E) i915(E) snd_seq_midi_event(E) btintel(E) videobuf2_v4l2(E) mac80211(E) kvm_intel(E) snd_rawmidi(E) btbcm(E) videodev(E) btmtk(E) videobuf2_common(E) ite_829x(OE) snd_seq(E) libarc4(E) drm_buddy(E) mc(E) led_class_multicolor(E) processor_thermal_device_pci(E) bluetooth(E) kvm(E) snd_seq_device(E) spd5118(E) processor_thermal_device(E) drm_display_helper(E) cmdlinepart(E) iwlwifi(E) mei_hdcp(E) mei_pxp(E) snd_timer(E) processor_thermal_wt_hint(E) processor_thermal_rfim(E) cec(E) spi_nor(E) rapl(E) processor_thermal_rapl(E) mtd(E) intel_rapl_msr(E) i2c_i801(E) snd(E) drm_ttm_helper(E) nvidia_wmi_ec_backlight(E) mxm_wmi(E) intel_cstate(E) intel_rapl_common(E) rc_core(E) i2c_mux(E) mei_me(E) processor_thermal_wt_req(E) soundcore(E) spi_intel_pci
 (E) cfg80211(E) ttm(E) i2c_smbus(E)
[   47.326703]  i2c_algo_bit(E) processor_thermal_power_floor(E) spi_intel(E) mei(E) processor_thermal_mbox(E) intel_pmc_core(E) int3403_thermal(E) int340x_thermal_zone(E) intel_vsec(E) int3400_thermal(E) pmt_telemetry(E) intel_hid(E) pmt_class(E) acpi_thermal_rel(E) joydev(E) sparse_keymap(E) acpi_pad(E) input_leds(E) mac_hid(E) serio_raw(E) sch_fq_codel(E) msr(E) parport_pc(E) ppdev(E) lp(E) nvme_fabrics(E) parport(E) nvme_keyring(E) efi_pstore(E) nfnetlink(E) dmi_sysfs(E) ip_tables(E) x_tables(E) autofs4(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) libcrc32c(E) dm_crypt(E) dm_mirror(E) dm_region_hash(E) dm_log(E) usbhid(E) nvme(E) hid_multitouch(E) hid_generic(E) nvme_core(E) nvme_auth(E) crct10dif_pclmul(E) crc32_pclmul(E) polyval_clmulni(E) polyval_generic(E) ghash_clmulni_intel(E) sha256_ssse3(E) thunderbolt(E) sha1_ssse3(E) ucsi_acpi(E) psmouse(E) intel_lpss_pci(E) typec_ucsi(E) igc(E) xhci_pci(E) intel_lpss(E) xhci_pci_renesas(E) vmd(E) idma64(E) typec(E) i2c_hid_acpi(E)
  i2c_hid(E) hid(E) video(E) wmi(E)
[   47.326717]  pinctrl_alderlake(E) aesni_intel(E) crypto_simd(E) cryptd(E)
[   47.326719] CPU: 2 UID: 0 PID: 1141 Comm: nv_queue Tainted: P        W  OE      6.11.5 #1
[   47.326720] Tainted: [P]=PROPRIETARY_MODULE, [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[   47.326720] Hardware name: Notebook X370SNx1/X370SNx1, BIOS 1.07.03aMIN29 09/18/2024
[   47.326720] RIP: 0010:follow_pte+0x220/0x230
[   47.326722] Code: 15 75 33 8c 01 48 81 e2 00 00 00 c0 e9 7b ff ff ff 48 8b 45 d0 48 8b 38 e8 8d e9 e1 00 e8 18 e6 da ff 41 bc ea ff ff ff eb 9f <0f> 0b e9 0d fe ff ff 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
[   47.326722] RSP: 0018:ffff99cac101bb10 EFLAGS: 00010246
[   47.326723] RAX: 0000000000000000 RBX: 000078725c775000 RCX: ffff99cac101bb60
[   47.326723] RDX: ffff99cac101bb58 RSI: 000078725c775000 RDI: ffff89230897b700
[   47.326724] RBP: ffff99cac101bb48 R08: ffff99cac101bd18 R09: 0000000000000000
[   47.326724] R10: 0000000000000000 R11: 0000000000000000 R12: ffff99cac101bba8
[   47.326725] R13: 0000000000000000 R14: ffff99cac101bb58 R15: ffff892308036880
[   47.326725] FS:  0000000000000000(0000) GS:ffff892a9e900000(0000) knlGS:0000000000000000
[   47.326726] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   47.326726] CR2: 000070e8b04ee200 CR3: 000000012aa3e000 CR4: 0000000000f50ef0
[   47.326727] PKRU: 55555554
[   47.326727] Call Trace:
[   47.326727]  <TASK>
[   47.326727]  ? show_regs+0x6c/0x80
[   47.326728]  ? __warn+0x88/0x140
[   47.326730]  ? follow_pte+0x220/0x230
[   47.326731]  ? report_bug+0x182/0x1b0
[   47.326732]  ? handle_bug+0x51/0xa0
[   47.326733]  ? exc_invalid_op+0x18/0x80
[   47.326735]  ? asm_exc_invalid_op+0x1b/0x20
[   47.326736]  ? follow_pte+0x220/0x230
[   47.326737]  follow_phys+0x4e/0x110
[   47.326739]  untrack_pfn+0x57/0x130
[   47.326740]  unmap_single_vma+0xbc/0xf0
[   47.326741]  zap_page_range_single+0x138/0x210
[   47.326742]  unmap_mapping_range+0x11b/0x140
[   47.326743]  nv_revoke_gpu_mappings+0x68/0xc0 [nvidia]
[   47.326852]  _nv000741rm+0x35/0xf6 [nvidia]
[   47.327026]  ? rm_execute_work_item+0x141/0x1f0 [nvidia]
[   47.327205]  ? os_execute_work_item+0x6c/0x90 [nvidia]
[   47.327326]  ? _main_loop+0x7e/0x140 [nvidia]
[   47.327446]  ? __pfx__main_loop+0x10/0x10 [nvidia]
[   47.327566]  ? kthread+0xe1/0x110
[   47.327567]  ? __pfx_kthread+0x10/0x10
[   47.327568]  ? ret_from_fork+0x44/0x70
[   47.327569]  ? __pfx_kthread+0x10/0x10
[   47.327569]  ? ret_from_fork_asm+0x1a/0x30
[   47.327571]  </TASK>
[   47.327571] ---[ end trace 0000000000000000 ]---
[   47.327576] ------------[ cut here ]------------
[   47.327577] WARNING: CPU: 2 PID: 1141 at include/linux/rwsem.h:80 follow_pte+0x220/0x230
[   47.327579] Modules linked in: nvidia_uvm(POE) ccm(E) rfcomm(E) snd_seq_dummy(E) snd_hrtimer(E) qrtr(E) cmac(E) algif_hash(E) algif_skcipher(E) af_alg(E) bnep(E) xe(E) snd_hda_codec_realtek(E) drm_gpuvm(E) drm_exec(E) snd_hda_codec_generic(E) gpu_sched(E) drm_suballoc_helper(E) snd_hda_scodec_component(E) binfmt_misc(E) nls_iso8859_1(E) nvidia_drm(POE) nvidia_modeset(POE) nvidia(POE) intel_uncore_frequency(E) intel_uncore_frequency_common(E) intel_tcc_cooling(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) snd_hda_codec_hdmi(E) snd_sof_pci_intel_tgl(E) snd_sof_pci_intel_cnl(E) snd_sof_intel_hda_generic(E) soundwire_intel(E) soundwire_cadence(E) snd_sof_intel_hda_common(E) snd_sof_intel_hda_mlink(E) snd_sof_intel_hda(E) snd_sof_pci(E) snd_sof_xtensa_dsp(E) snd_sof(E) snd_sof_utils(E) snd_soc_hdac_hda(E) snd_soc_acpi_intel_match(E) soundwire_generic_allocation(E) snd_soc_acpi(E) soundwire_bus(E) snd_soc_avs(E) snd_soc_hda_codec(E) snd_hda_ext_core(E) snd_soc_core(E) snd_compress(E) a
 c97_bus(E) snd_pcm_dmaengine(E)
[   47.327591]  snd_hda_intel(E) snd_intel_dspcfg(E) snd_intel_sdw_acpi(E) snd_hda_codec(E) snd_hda_core(E) snd_hwdep(E) snd_pcm(E) uvcvideo(E) videobuf2_vmalloc(E) iwlmvm(E) btusb(E) snd_seq_midi(E) uvc(E) coretemp(E) btrtl(E) videobuf2_memops(E) i915(E) snd_seq_midi_event(E) btintel(E) videobuf2_v4l2(E) mac80211(E) kvm_intel(E) snd_rawmidi(E) btbcm(E) videodev(E) btmtk(E) videobuf2_common(E) ite_829x(OE) snd_seq(E) libarc4(E) drm_buddy(E) mc(E) led_class_multicolor(E) processor_thermal_device_pci(E) bluetooth(E) kvm(E) snd_seq_device(E) spd5118(E) processor_thermal_device(E) drm_display_helper(E) cmdlinepart(E) iwlwifi(E) mei_hdcp(E) mei_pxp(E) snd_timer(E) processor_thermal_wt_hint(E) processor_thermal_rfim(E) cec(E) spi_nor(E) rapl(E) processor_thermal_rapl(E) mtd(E) intel_rapl_msr(E) i2c_i801(E) snd(E) drm_ttm_helper(E) nvidia_wmi_ec_backlight(E) mxm_wmi(E) intel_cstate(E) intel_rapl_common(E) rc_core(E) i2c_mux(E) mei_me(E) processor_thermal_wt_req(E) soundcore(E) spi_intel_pci
 (E) cfg80211(E) ttm(E) i2c_smbus(E)
[   47.327606]  i2c_algo_bit(E) processor_thermal_power_floor(E) spi_intel(E) mei(E) processor_thermal_mbox(E) intel_pmc_core(E) int3403_thermal(E) int340x_thermal_zone(E) intel_vsec(E) int3400_thermal(E) pmt_telemetry(E) intel_hid(E) pmt_class(E) acpi_thermal_rel(E) joydev(E) sparse_keymap(E) acpi_pad(E) input_leds(E) mac_hid(E) serio_raw(E) sch_fq_codel(E) msr(E) parport_pc(E) ppdev(E) lp(E) nvme_fabrics(E) parport(E) nvme_keyring(E) efi_pstore(E) nfnetlink(E) dmi_sysfs(E) ip_tables(E) x_tables(E) autofs4(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) libcrc32c(E) dm_crypt(E) dm_mirror(E) dm_region_hash(E) dm_log(E) usbhid(E) nvme(E) hid_multitouch(E) hid_generic(E) nvme_core(E) nvme_auth(E) crct10dif_pclmul(E) crc32_pclmul(E) polyval_clmulni(E) polyval_generic(E) ghash_clmulni_intel(E) sha256_ssse3(E) thunderbolt(E) sha1_ssse3(E) ucsi_acpi(E) psmouse(E) intel_lpss_pci(E) typec_ucsi(E) igc(E) xhci_pci(E) intel_lpss(E) xhci_pci_renesas(E) vmd(E) idma64(E) typec(E) i2c_hid_acpi(E)
  i2c_hid(E) hid(E) video(E) wmi(E)
[   47.327622]  pinctrl_alderlake(E) aesni_intel(E) crypto_simd(E) cryptd(E)
[   47.327623] CPU: 2 UID: 0 PID: 1141 Comm: nv_queue Tainted: P        W  OE      6.11.5 #1
[   47.327624] Tainted: [P]=PROPRIETARY_MODULE, [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[   47.327624] Hardware name: Notebook X370SNx1/X370SNx1, BIOS 1.07.03aMIN29 09/18/2024
[   47.327625] RIP: 0010:follow_pte+0x220/0x230
[   47.327626] Code: 15 75 33 8c 01 48 81 e2 00 00 00 c0 e9 7b ff ff ff 48 8b 45 d0 48 8b 38 e8 8d e9 e1 00 e8 18 e6 da ff 41 bc ea ff ff ff eb 9f <0f> 0b e9 0d fe ff ff 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
[   47.327627] RSP: 0018:ffff99cac101bb10 EFLAGS: 00010246
[   47.327628] RAX: 0000000000000000 RBX: 000075167a77e000 RCX: ffff99cac101bb60
[   47.327628] RDX: ffff99cac101bb58 RSI: 000075167a77e000 RDI: ffff892352e1e398
[   47.327629] RBP: ffff99cac101bb48 R08: ffff99cac101bd18 R09: 0000000000000000
[   47.327629] R10: 0000000000000000 R11: 0000000000000000 R12: ffff99cac101bba8
[   47.327629] R13: 0000000000000000 R14: ffff99cac101bb58 R15: ffff892315d34780
[   47.327630] FS:  0000000000000000(0000) GS:ffff892a9e900000(0000) knlGS:0000000000000000
[   47.327631] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   47.327631] CR2: 000070e8b04ee200 CR3: 000000012aa3e000 CR4: 0000000000f50ef0
[   47.327632] PKRU: 55555554
[   47.327632] Call Trace:
[   47.327632]  <TASK>
[   47.327633]  ? show_regs+0x6c/0x80
[   47.327634]  ? __warn+0x88/0x140
[   47.327635]  ? follow_pte+0x220/0x230
[   47.327637]  ? report_bug+0x182/0x1b0
[   47.327638]  ? handle_bug+0x51/0xa0
[   47.327639]  ? exc_invalid_op+0x18/0x80
[   47.327640]  ? asm_exc_invalid_op+0x1b/0x20
[   47.327642]  ? follow_pte+0x220/0x230
[   47.327643]  follow_phys+0x4e/0x110
[   47.327645]  untrack_pfn+0x57/0x130
[   47.327646]  unmap_single_vma+0xbc/0xf0
[   47.327647]  zap_page_range_single+0x138/0x210
[   47.327649]  unmap_mapping_range+0x11b/0x140
[   47.327650]  nv_revoke_gpu_mappings+0x68/0xc0 [nvidia]
[   47.327769]  _nv000741rm+0x35/0xf6 [nvidia]
[   47.327947]  ? rm_execute_work_item+0x141/0x1f0 [nvidia]
[   47.328118]  ? os_execute_work_item+0x6c/0x90 [nvidia]
[   47.328238]  ? _main_loop+0x7e/0x140 [nvidia]
[   47.328358]  ? __pfx__main_loop+0x10/0x10 [nvidia]
[   47.328477]  ? kthread+0xe1/0x110
[   47.328478]  ? __pfx_kthread+0x10/0x10
[   47.328479]  ? ret_from_fork+0x44/0x70
[   47.328480]  ? __pfx_kthread+0x10/0x10
[   47.328481]  ? ret_from_fork_asm+0x1a/0x30
[   47.328483]  </TASK>
[   47.328484] ---[ end trace 0000000000000000 ]---
[   47.328488] ------------[ cut here ]------------
[   47.328488] WARNING: CPU: 2 PID: 1141 at include/linux/rwsem.h:80 follow_pte+0x220/0x230
[   47.328490] Modules linked in: nvidia_uvm(POE) ccm(E) rfcomm(E) snd_seq_dummy(E) snd_hrtimer(E) qrtr(E) cmac(E) algif_hash(E) algif_skcipher(E) af_alg(E) bnep(E) xe(E) snd_hda_codec_realtek(E) drm_gpuvm(E) drm_exec(E) snd_hda_codec_generic(E) gpu_sched(E) drm_suballoc_helper(E) snd_hda_scodec_component(E) binfmt_misc(E) nls_iso8859_1(E) nvidia_drm(POE) nvidia_modeset(POE) nvidia(POE) intel_uncore_frequency(E) intel_uncore_frequency_common(E) intel_tcc_cooling(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) snd_hda_codec_hdmi(E) snd_sof_pci_intel_tgl(E) snd_sof_pci_intel_cnl(E) snd_sof_intel_hda_generic(E) soundwire_intel(E) soundwire_cadence(E) snd_sof_intel_hda_common(E) snd_sof_intel_hda_mlink(E) snd_sof_intel_hda(E) snd_sof_pci(E) snd_sof_xtensa_dsp(E) snd_sof(E) snd_sof_utils(E) snd_soc_hdac_hda(E) snd_soc_acpi_intel_match(E) soundwire_generic_allocation(E) snd_soc_acpi(E) soundwire_bus(E) snd_soc_avs(E) snd_soc_hda_codec(E) snd_hda_ext_core(E) snd_soc_core(E) snd_compress(E) a
 c97_bus(E) snd_pcm_dmaengine(E)
[   47.328501]  snd_hda_intel(E) snd_intel_dspcfg(E) snd_intel_sdw_acpi(E) snd_hda_codec(E) snd_hda_core(E) snd_hwdep(E) snd_pcm(E) uvcvideo(E) videobuf2_vmalloc(E) iwlmvm(E) btusb(E) snd_seq_midi(E) uvc(E) coretemp(E) btrtl(E) videobuf2_memops(E) i915(E) snd_seq_midi_event(E) btintel(E) videobuf2_v4l2(E) mac80211(E) kvm_intel(E) snd_rawmidi(E) btbcm(E) videodev(E) btmtk(E) videobuf2_common(E) ite_829x(OE) snd_seq(E) libarc4(E) drm_buddy(E) mc(E) led_class_multicolor(E) processor_thermal_device_pci(E) bluetooth(E) kvm(E) snd_seq_device(E) spd5118(E) processor_thermal_device(E) drm_display_helper(E) cmdlinepart(E) iwlwifi(E) mei_hdcp(E) mei_pxp(E) snd_timer(E) processor_thermal_wt_hint(E) processor_thermal_rfim(E) cec(E) spi_nor(E) rapl(E) processor_thermal_rapl(E) mtd(E) intel_rapl_msr(E) i2c_i801(E) snd(E) drm_ttm_helper(E) nvidia_wmi_ec_backlight(E) mxm_wmi(E) intel_cstate(E) intel_rapl_common(E) rc_core(E) i2c_mux(E) mei_me(E) processor_thermal_wt_req(E) soundcore(E) spi_intel_pci
 (E) cfg80211(E) ttm(E) i2c_smbus(E)
[   47.328515]  i2c_algo_bit(E) processor_thermal_power_floor(E) spi_intel(E) mei(E) processor_thermal_mbox(E) intel_pmc_core(E) int3403_thermal(E) int340x_thermal_zone(E) intel_vsec(E) int3400_thermal(E) pmt_telemetry(E) intel_hid(E) pmt_class(E) acpi_thermal_rel(E) joydev(E) sparse_keymap(E) acpi_pad(E) input_leds(E) mac_hid(E) serio_raw(E) sch_fq_codel(E) msr(E) parport_pc(E) ppdev(E) lp(E) nvme_fabrics(E) parport(E) nvme_keyring(E) efi_pstore(E) nfnetlink(E) dmi_sysfs(E) ip_tables(E) x_tables(E) autofs4(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) libcrc32c(E) dm_crypt(E) dm_mirror(E) dm_region_hash(E) dm_log(E) usbhid(E) nvme(E) hid_multitouch(E) hid_generic(E) nvme_core(E) nvme_auth(E) crct10dif_pclmul(E) crc32_pclmul(E) polyval_clmulni(E) polyval_generic(E) ghash_clmulni_intel(E) sha256_ssse3(E) thunderbolt(E) sha1_ssse3(E) ucsi_acpi(E) psmouse(E) intel_lpss_pci(E) typec_ucsi(E) igc(E) xhci_pci(E) intel_lpss(E) xhci_pci_renesas(E) vmd(E) idma64(E) typec(E) i2c_hid_acpi(E)
  i2c_hid(E) hid(E) video(E) wmi(E)
[   47.328529]  pinctrl_alderlake(E) aesni_intel(E) crypto_simd(E) cryptd(E)
[   47.328531] CPU: 2 UID: 0 PID: 1141 Comm: nv_queue Tainted: P        W  OE      6.11.5 #1
[   47.328532] Tainted: [P]=PROPRIETARY_MODULE, [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[   47.328532] Hardware name: Notebook X370SNx1/X370SNx1, BIOS 1.07.03aMIN29 09/18/2024
[   47.328532] RIP: 0010:follow_pte+0x220/0x230
[   47.328534] Code: 15 75 33 8c 01 48 81 e2 00 00 00 c0 e9 7b ff ff ff 48 8b 45 d0 48 8b 38 e8 8d e9 e1 00 e8 18 e6 da ff 41 bc ea ff ff ff eb 9f <0f> 0b e9 0d fe ff ff 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
[   47.328534] RSP: 0018:ffff99cac101bb10 EFLAGS: 00010246
[   47.328535] RAX: 0000000000000000 RBX: 00007a4955938000 RCX: ffff99cac101bb60
[   47.328535] RDX: ffff99cac101bb58 RSI: 00007a4955938000 RDI: ffff89230fa431f8
[   47.328536] RBP: ffff99cac101bb48 R08: ffff99cac101bd18 R09: 0000000000000000
[   47.328536] R10: 0000000000000000 R11: 0000000000000000 R12: ffff99cac101bba8
[   47.328536] R13: 0000000000000000 R14: ffff99cac101bb58 R15: ffff89231877b700
[   47.328537] FS:  0000000000000000(0000) GS:ffff892a9e900000(0000) knlGS:0000000000000000
[   47.328537] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   47.328538] CR2: 000070e8b04ee200 CR3: 000000012aa3e000 CR4: 0000000000f50ef0
[   47.328538] PKRU: 55555554
[   47.328538] Call Trace:
[   47.328539]  <TASK>
[   47.328539]  ? show_regs+0x6c/0x80
[   47.328540]  ? __warn+0x88/0x140
[   47.328541]  ? follow_pte+0x220/0x230
[   47.328543]  ? report_bug+0x182/0x1b0
[   47.328544]  ? handle_bug+0x51/0xa0
[   47.328545]  ? exc_invalid_op+0x18/0x80
[   47.328546]  ? asm_exc_invalid_op+0x1b/0x20
[   47.328548]  ? follow_pte+0x220/0x230
[   47.328549]  follow_phys+0x4e/0x110
[   47.328550]  untrack_pfn+0x57/0x130
[   47.328552]  unmap_single_vma+0xbc/0xf0
[   47.328553]  zap_page_range_single+0x138/0x210
[   47.328554]  unmap_mapping_range+0x11b/0x140
[   47.328555]  nv_revoke_gpu_mappings+0x68/0xc0 [nvidia]
[   47.328664]  _nv000741rm+0x35/0xf6 [nvidia]
[   47.328824]  ? rm_execute_work_item+0x141/0x1f0 [nvidia]
[   47.328998]  ? os_execute_work_item+0x6c/0x90 [nvidia]
[   47.329112]  ? _main_loop+0x7e/0x140 [nvidia]
[   47.329233]  ? __pfx__main_loop+0x10/0x10 [nvidia]
[   47.329352]  ? kthread+0xe1/0x110
[   47.329352]  ? __pfx_kthread+0x10/0x10
[   47.329353]  ? ret_from_fork+0x44/0x70
[   47.329354]  ? __pfx_kthread+0x10/0x10
[   47.329355]  ? ret_from_fork_asm+0x1a/0x30
[   47.329357]  </TASK>
[   47.329357] ---[ end trace 0000000000000000 ]---
[   47.329360] ------------[ cut here ]------------
[   47.329361] WARNING: CPU: 2 PID: 1141 at include/linux/rwsem.h:80 follow_pte+0x220/0x230
[   47.329363] Modules linked in: nvidia_uvm(POE) ccm(E) rfcomm(E) snd_seq_dummy(E) snd_hrtimer(E) qrtr(E) cmac(E) algif_hash(E) algif_skcipher(E) af_alg(E) bnep(E) xe(E) snd_hda_codec_realtek(E) drm_gpuvm(E) drm_exec(E) snd_hda_codec_generic(E) gpu_sched(E) drm_suballoc_helper(E) snd_hda_scodec_component(E) binfmt_misc(E) nls_iso8859_1(E) nvidia_drm(POE) nvidia_modeset(POE) nvidia(POE) intel_uncore_frequency(E) intel_uncore_frequency_common(E) intel_tcc_cooling(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) snd_hda_codec_hdmi(E) snd_sof_pci_intel_tgl(E) snd_sof_pci_intel_cnl(E) snd_sof_intel_hda_generic(E) soundwire_intel(E) soundwire_cadence(E) snd_sof_intel_hda_common(E) snd_sof_intel_hda_mlink(E) snd_sof_intel_hda(E) snd_sof_pci(E) snd_sof_xtensa_dsp(E) snd_sof(E) snd_sof_utils(E) snd_soc_hdac_hda(E) snd_soc_acpi_intel_match(E) soundwire_generic_allocation(E) snd_soc_acpi(E) soundwire_bus(E) snd_soc_avs(E) snd_soc_hda_codec(E) snd_hda_ext_core(E) snd_soc_core(E) snd_compress(E) a
 c97_bus(E) snd_pcm_dmaengine(E)
[   47.329375]  snd_hda_intel(E) snd_intel_dspcfg(E) snd_intel_sdw_acpi(E) snd_hda_codec(E) snd_hda_core(E) snd_hwdep(E) snd_pcm(E) uvcvideo(E) videobuf2_vmalloc(E) iwlmvm(E) btusb(E) snd_seq_midi(E) uvc(E) coretemp(E) btrtl(E) videobuf2_memops(E) i915(E) snd_seq_midi_event(E) btintel(E) videobuf2_v4l2(E) mac80211(E) kvm_intel(E) snd_rawmidi(E) btbcm(E) videodev(E) btmtk(E) videobuf2_common(E) ite_829x(OE) snd_seq(E) libarc4(E) drm_buddy(E) mc(E) led_class_multicolor(E) processor_thermal_device_pci(E) bluetooth(E) kvm(E) snd_seq_device(E) spd5118(E) processor_thermal_device(E) drm_display_helper(E) cmdlinepart(E) iwlwifi(E) mei_hdcp(E) mei_pxp(E) snd_timer(E) processor_thermal_wt_hint(E) processor_thermal_rfim(E) cec(E) spi_nor(E) rapl(E) processor_thermal_rapl(E) mtd(E) intel_rapl_msr(E) i2c_i801(E) snd(E) drm_ttm_helper(E) nvidia_wmi_ec_backlight(E) mxm_wmi(E) intel_cstate(E) intel_rapl_common(E) rc_core(E) i2c_mux(E) mei_me(E) processor_thermal_wt_req(E) soundcore(E) spi_intel_pci
 (E) cfg80211(E) ttm(E) i2c_smbus(E)
[   47.329390]  i2c_algo_bit(E) processor_thermal_power_floor(E) spi_intel(E) mei(E) processor_thermal_mbox(E) intel_pmc_core(E) int3403_thermal(E) int340x_thermal_zone(E) intel_vsec(E) int3400_thermal(E) pmt_telemetry(E) intel_hid(E) pmt_class(E) acpi_thermal_rel(E) joydev(E) sparse_keymap(E) acpi_pad(E) input_leds(E) mac_hid(E) serio_raw(E) sch_fq_codel(E) msr(E) parport_pc(E) ppdev(E) lp(E) nvme_fabrics(E) parport(E) nvme_keyring(E) efi_pstore(E) nfnetlink(E) dmi_sysfs(E) ip_tables(E) x_tables(E) autofs4(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) libcrc32c(E) dm_crypt(E) dm_mirror(E) dm_region_hash(E) dm_log(E) usbhid(E) nvme(E) hid_multitouch(E) hid_generic(E) nvme_core(E) nvme_auth(E) crct10dif_pclmul(E) crc32_pclmul(E) polyval_clmulni(E) polyval_generic(E) ghash_clmulni_intel(E) sha256_ssse3(E) thunderbolt(E) sha1_ssse3(E) ucsi_acpi(E) psmouse(E) intel_lpss_pci(E) typec_ucsi(E) igc(E) xhci_pci(E) intel_lpss(E) xhci_pci_renesas(E) vmd(E) idma64(E) typec(E) i2c_hid_acpi(E)
  i2c_hid(E) hid(E) video(E) wmi(E)
[   47.329405]  pinctrl_alderlake(E) aesni_intel(E) crypto_simd(E) cryptd(E)
[   47.329407] CPU: 2 UID: 0 PID: 1141 Comm: nv_queue Tainted: P        W  OE      6.11.5 #1
[   47.329408] Tainted: [P]=PROPRIETARY_MODULE, [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[   47.329408] Hardware name: Notebook X370SNx1/X370SNx1, BIOS 1.07.03aMIN29 09/18/2024
[   47.329408] RIP: 0010:follow_pte+0x220/0x230
[   47.329410] Code: 15 75 33 8c 01 48 81 e2 00 00 00 c0 e9 7b ff ff ff 48 8b 45 d0 48 8b 38 e8 8d e9 e1 00 e8 18 e6 da ff 41 bc ea ff ff ff eb 9f <0f> 0b e9 0d fe ff ff 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
[   47.329410] RSP: 0018:ffff99cac101bb10 EFLAGS: 00010246
[   47.329411] RAX: 0000000000000000 RBX: 00007981aae8f000 RCX: ffff99cac101bb60
[   47.329412] RDX: ffff99cac101bb58 RSI: 00007981aae8f000 RDI: ffff892307180da8
[   47.329412] RBP: ffff99cac101bb48 R08: ffff99cac101bd18 R09: 0000000000000000
[   47.329412] R10: 0000000000000000 R11: 0000000000000000 R12: ffff99cac101bba8
[   47.329413] R13: 0000000000000000 R14: ffff99cac101bb58 R15: ffff8923086a5d80
[   47.329413] FS:  0000000000000000(0000) GS:ffff892a9e900000(0000) knlGS:0000000000000000
[   47.329414] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   47.329414] CR2: 000070e8b04ee200 CR3: 000000012aa3e000 CR4: 0000000000f50ef0
[   47.329415] PKRU: 55555554
[   47.329415] Call Trace:
[   47.329415]  <TASK>
[   47.329416]  ? show_regs+0x6c/0x80
[   47.329417]  ? __warn+0x88/0x140
[   47.329418]  ? follow_pte+0x220/0x230
[   47.329420]  ? report_bug+0x182/0x1b0
[   47.329421]  ? handle_bug+0x51/0xa0
[   47.329422]  ? exc_invalid_op+0x18/0x80
[   47.329424]  ? asm_exc_invalid_op+0x1b/0x20
[   47.329425]  ? follow_pte+0x220/0x230
[   47.329427]  follow_phys+0x4e/0x110
[   47.329428]  untrack_pfn+0x57/0x130
[   47.329430]  unmap_single_vma+0xbc/0xf0
[   47.329431]  zap_page_range_single+0x138/0x210
[   47.329432]  unmap_mapping_range+0x11b/0x140
[   47.329433]  nv_revoke_gpu_mappings+0x68/0xc0 [nvidia]
[   47.329549]  _nv000741rm+0x35/0xf6 [nvidia]
[   47.329733]  ? rm_execute_work_item+0x141/0x1f0 [nvidia]
[   47.329916]  ? os_execute_work_item+0x6c/0x90 [nvidia]
[   47.330097]  ? _main_loop+0x7e/0x140 [nvidia]
[   47.330218]  ? __pfx__main_loop+0x10/0x10 [nvidia]
[   47.330337]  ? kthread+0xe1/0x110
[   47.330338]  ? __pfx_kthread+0x10/0x10
[   47.330339]  ? ret_from_fork+0x44/0x70
[   47.330340]  ? __pfx_kthread+0x10/0x10
[   47.330340]  ? ret_from_fork_asm+0x1a/0x30
[   47.330342]  </TASK>
[   47.330342] ---[ end trace 0000000000000000 ]---
[   47.330346] ------------[ cut here ]------------
[   47.330346] WARNING: CPU: 2 PID: 1141 at include/linux/rwsem.h:80 follow_pte+0x220/0x230
[   47.330348] Modules linked in: nvidia_uvm(POE) ccm(E) rfcomm(E) snd_seq_dummy(E) snd_hrtimer(E) qrtr(E) cmac(E) algif_hash(E) algif_skcipher(E) af_alg(E) bnep(E) xe(E) snd_hda_codec_realtek(E) drm_gpuvm(E) drm_exec(E) snd_hda_codec_generic(E) gpu_sched(E) drm_suballoc_helper(E) snd_hda_scodec_component(E) binfmt_misc(E) nls_iso8859_1(E) nvidia_drm(POE) nvidia_modeset(POE) nvidia(POE) intel_uncore_frequency(E) intel_uncore_frequency_common(E) intel_tcc_cooling(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) snd_hda_codec_hdmi(E) snd_sof_pci_intel_tgl(E) snd_sof_pci_intel_cnl(E) snd_sof_intel_hda_generic(E) soundwire_intel(E) soundwire_cadence(E) snd_sof_intel_hda_common(E) snd_sof_intel_hda_mlink(E) snd_sof_intel_hda(E) snd_sof_pci(E) snd_sof_xtensa_dsp(E) snd_sof(E) snd_sof_utils(E) snd_soc_hdac_hda(E) snd_soc_acpi_intel_match(E) soundwire_generic_allocation(E) snd_soc_acpi(E) soundwire_bus(E) snd_soc_avs(E) snd_soc_hda_codec(E) snd_hda_ext_core(E) snd_soc_core(E) snd_compress(E) a
 c97_bus(E) snd_pcm_dmaengine(E)
[   47.330360]  snd_hda_intel(E) snd_intel_dspcfg(E) snd_intel_sdw_acpi(E) snd_hda_codec(E) snd_hda_core(E) snd_hwdep(E) snd_pcm(E) uvcvideo(E) videobuf2_vmalloc(E) iwlmvm(E) btusb(E) snd_seq_midi(E) uvc(E) coretemp(E) btrtl(E) videobuf2_memops(E) i915(E) snd_seq_midi_event(E) btintel(E) videobuf2_v4l2(E) mac80211(E) kvm_intel(E) snd_rawmidi(E) btbcm(E) videodev(E) btmtk(E) videobuf2_common(E) ite_829x(OE) snd_seq(E) libarc4(E) drm_buddy(E) mc(E) led_class_multicolor(E) processor_thermal_device_pci(E) bluetooth(E) kvm(E) snd_seq_device(E) spd5118(E) processor_thermal_device(E) drm_display_helper(E) cmdlinepart(E) iwlwifi(E) mei_hdcp(E) mei_pxp(E) snd_timer(E) processor_thermal_wt_hint(E) processor_thermal_rfim(E) cec(E) spi_nor(E) rapl(E) processor_thermal_rapl(E) mtd(E) intel_rapl_msr(E) i2c_i801(E) snd(E) drm_ttm_helper(E) nvidia_wmi_ec_backlight(E) mxm_wmi(E) intel_cstate(E) intel_rapl_common(E) rc_core(E) i2c_mux(E) mei_me(E) processor_thermal_wt_req(E) soundcore(E) spi_intel_pci
 (E) cfg80211(E) ttm(E) i2c_smbus(E)
[   47.330375]  i2c_algo_bit(E) processor_thermal_power_floor(E) spi_intel(E) mei(E) processor_thermal_mbox(E) intel_pmc_core(E) int3403_thermal(E) int340x_thermal_zone(E) intel_vsec(E) int3400_thermal(E) pmt_telemetry(E) intel_hid(E) pmt_class(E) acpi_thermal_rel(E) joydev(E) sparse_keymap(E) acpi_pad(E) input_leds(E) mac_hid(E) serio_raw(E) sch_fq_codel(E) msr(E) parport_pc(E) ppdev(E) lp(E) nvme_fabrics(E) parport(E) nvme_keyring(E) efi_pstore(E) nfnetlink(E) dmi_sysfs(E) ip_tables(E) x_tables(E) autofs4(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) libcrc32c(E) dm_crypt(E) dm_mirror(E) dm_region_hash(E) dm_log(E) usbhid(E) nvme(E) hid_multitouch(E) hid_generic(E) nvme_core(E) nvme_auth(E) crct10dif_pclmul(E) crc32_pclmul(E) polyval_clmulni(E) polyval_generic(E) ghash_clmulni_intel(E) sha256_ssse3(E) thunderbolt(E) sha1_ssse3(E) ucsi_acpi(E) psmouse(E) intel_lpss_pci(E) typec_ucsi(E) igc(E) xhci_pci(E) intel_lpss(E) xhci_pci_renesas(E) vmd(E) idma64(E) typec(E) i2c_hid_acpi(E)
  i2c_hid(E) hid(E) video(E) wmi(E)
[   47.330391]  pinctrl_alderlake(E) aesni_intel(E) crypto_simd(E) cryptd(E)
[   47.330392] CPU: 2 UID: 0 PID: 1141 Comm: nv_queue Tainted: P        W  OE      6.11.5 #1
[   47.330393] Tainted: [P]=PROPRIETARY_MODULE, [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[   47.330394] Hardware name: Notebook X370SNx1/X370SNx1, BIOS 1.07.03aMIN29 09/18/2024
[   47.330394] RIP: 0010:follow_pte+0x220/0x230
[   47.330396] Code: 15 75 33 8c 01 48 81 e2 00 00 00 c0 e9 7b ff ff ff 48 8b 45 d0 48 8b 38 e8 8d e9 e1 00 e8 18 e6 da ff 41 bc ea ff ff ff eb 9f <0f> 0b e9 0d fe ff ff 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
[   47.330396] RSP: 0018:ffff99cac101bb10 EFLAGS: 00010246
[   47.330397] RAX: 0000000000000000 RBX: 00007981b4bbc000 RCX: ffff99cac101bb60
[   47.330397] RDX: ffff99cac101bb58 RSI: 00007981b4bbc000 RDI: ffff8923030d1088
[   47.330398] RBP: ffff99cac101bb48 R08: ffff99cac101bd18 R09: 0000000000000000
[   47.330398] R10: 0000000000000000 R11: 0000000000000000 R12: ffff99cac101bba8
[   47.330399] R13: 0000000000000000 R14: ffff99cac101bb58 R15: ffff8923086a5d80
[   47.330399] FS:  0000000000000000(0000) GS:ffff892a9e900000(0000) knlGS:0000000000000000
[   47.330400] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   47.330400] CR2: 000070e8b04ee200 CR3: 000000012aa3e000 CR4: 0000000000f50ef0
[   47.330401] PKRU: 55555554
[   47.330401] Call Trace:
[   47.330401]  <TASK>
[   47.330402]  ? show_regs+0x6c/0x80
[   47.330403]  ? __warn+0x88/0x140
[   47.330404]  ? follow_pte+0x220/0x230
[   47.330406]  ? report_bug+0x182/0x1b0
[   47.330407]  ? handle_bug+0x51/0xa0
[   47.330408]  ? exc_invalid_op+0x18/0x80
[   47.330410]  ? asm_exc_invalid_op+0x1b/0x20
[   47.330411]  ? follow_pte+0x220/0x230
[   47.330413]  follow_phys+0x4e/0x110
[   47.330414]  untrack_pfn+0x57/0x130
[   47.330416]  unmap_single_vma+0xbc/0xf0
[   47.330417]  zap_page_range_single+0x138/0x210
[   47.330418]  unmap_mapping_range+0x11b/0x140
[   47.330419]  nv_revoke_gpu_mappings+0x68/0xc0 [nvidia]
[   47.330538]  _nv000741rm+0x35/0xf6 [nvidia]
[   47.330713]  ? rm_execute_work_item+0x141/0x1f0 [nvidia]
[   47.330910]  ? os_execute_work_item+0x6c/0x90 [nvidia]
[   47.331083]  ? _main_loop+0x7e/0x140 [nvidia]
[   47.331205]  ? __pfx__main_loop+0x10/0x10 [nvidia]
[   47.331325]  ? kthread+0xe1/0x110
[   47.331326]  ? __pfx_kthread+0x10/0x10
[   47.331327]  ? ret_from_fork+0x44/0x70
[   47.331328]  ? __pfx_kthread+0x10/0x10
[   47.331329]  ? ret_from_fork_asm+0x1a/0x30
[   47.331330]  </TASK>
[   47.331331] ---[ end trace 0000000000000000 ]---
[   47.331335] ------------[ cut here ]------------
[   47.331335] WARNING: CPU: 2 PID: 1141 at include/linux/rwsem.h:80 follow_pte+0x220/0x230
[   47.331337] Modules linked in: nvidia_uvm(POE) ccm(E) rfcomm(E) snd_seq_dummy(E) snd_hrtimer(E) qrtr(E) cmac(E) algif_hash(E) algif_skcipher(E) af_alg(E) bnep(E) xe(E) snd_hda_codec_realtek(E) drm_gpuvm(E) drm_exec(E) snd_hda_codec_generic(E) gpu_sched(E) drm_suballoc_helper(E) snd_hda_scodec_component(E) binfmt_misc(E) nls_iso8859_1(E) nvidia_drm(POE) nvidia_modeset(POE) nvidia(POE) intel_uncore_frequency(E) intel_uncore_frequency_common(E) intel_tcc_cooling(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) snd_hda_codec_hdmi(E) snd_sof_pci_intel_tgl(E) snd_sof_pci_intel_cnl(E) snd_sof_intel_hda_generic(E) soundwire_intel(E) soundwire_cadence(E) snd_sof_intel_hda_common(E) snd_sof_intel_hda_mlink(E) snd_sof_intel_hda(E) snd_sof_pci(E) snd_sof_xtensa_dsp(E) snd_sof(E) snd_sof_utils(E) snd_soc_hdac_hda(E) snd_soc_acpi_intel_match(E) soundwire_generic_allocation(E) snd_soc_acpi(E) soundwire_bus(E) snd_soc_avs(E) snd_soc_hda_codec(E) snd_hda_ext_core(E) snd_soc_core(E) snd_compress(E) a
 c97_bus(E) snd_pcm_dmaengine(E)
[   47.331349]  snd_hda_intel(E) snd_intel_dspcfg(E) snd_intel_sdw_acpi(E) snd_hda_codec(E) snd_hda_core(E) snd_hwdep(E) snd_pcm(E) uvcvideo(E) videobuf2_vmalloc(E) iwlmvm(E) btusb(E) snd_seq_midi(E) uvc(E) coretemp(E) btrtl(E) videobuf2_memops(E) i915(E) snd_seq_midi_event(E) btintel(E) videobuf2_v4l2(E) mac80211(E) kvm_intel(E) snd_rawmidi(E) btbcm(E) videodev(E) btmtk(E) videobuf2_common(E) ite_829x(OE) snd_seq(E) libarc4(E) drm_buddy(E) mc(E) led_class_multicolor(E) processor_thermal_device_pci(E) bluetooth(E) kvm(E) snd_seq_device(E) spd5118(E) processor_thermal_device(E) drm_display_helper(E) cmdlinepart(E) iwlwifi(E) mei_hdcp(E) mei_pxp(E) snd_timer(E) processor_thermal_wt_hint(E) processor_thermal_rfim(E) cec(E) spi_nor(E) rapl(E) processor_thermal_rapl(E) mtd(E) intel_rapl_msr(E) i2c_i801(E) snd(E) drm_ttm_helper(E) nvidia_wmi_ec_backlight(E) mxm_wmi(E) intel_cstate(E) intel_rapl_common(E) rc_core(E) i2c_mux(E) mei_me(E) processor_thermal_wt_req(E) soundcore(E) spi_intel_pci
 (E) cfg80211(E) ttm(E) i2c_smbus(E)
[   47.331364]  i2c_algo_bit(E) processor_thermal_power_floor(E) spi_intel(E) mei(E) processor_thermal_mbox(E) intel_pmc_core(E) int3403_thermal(E) int340x_thermal_zone(E) intel_vsec(E) int3400_thermal(E) pmt_telemetry(E) intel_hid(E) pmt_class(E) acpi_thermal_rel(E) joydev(E) sparse_keymap(E) acpi_pad(E) input_leds(E) mac_hid(E) serio_raw(E) sch_fq_codel(E) msr(E) parport_pc(E) ppdev(E) lp(E) nvme_fabrics(E) parport(E) nvme_keyring(E) efi_pstore(E) nfnetlink(E) dmi_sysfs(E) ip_tables(E) x_tables(E) autofs4(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) libcrc32c(E) dm_crypt(E) dm_mirror(E) dm_region_hash(E) dm_log(E) usbhid(E) nvme(E) hid_multitouch(E) hid_generic(E) nvme_core(E) nvme_auth(E) crct10dif_pclmul(E) crc32_pclmul(E) polyval_clmulni(E) polyval_generic(E) ghash_clmulni_intel(E) sha256_ssse3(E) thunderbolt(E) sha1_ssse3(E) ucsi_acpi(E) psmouse(E) intel_lpss_pci(E) typec_ucsi(E) igc(E) xhci_pci(E) intel_lpss(E) xhci_pci_renesas(E) vmd(E) idma64(E) typec(E) i2c_hid_acpi(E)
  i2c_hid(E) hid(E) video(E) wmi(E)
[   47.331379]  pinctrl_alderlake(E) aesni_intel(E) crypto_simd(E) cryptd(E)
[   47.331381] CPU: 2 UID: 0 PID: 1141 Comm: nv_queue Tainted: P        W  OE      6.11.5 #1
[   47.331382] Tainted: [P]=PROPRIETARY_MODULE, [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[   47.331382] Hardware name: Notebook X370SNx1/X370SNx1, BIOS 1.07.03aMIN29 09/18/2024
[   47.331383] RIP: 0010:follow_pte+0x220/0x230
[   47.331384] Code: 15 75 33 8c 01 48 81 e2 00 00 00 c0 e9 7b ff ff ff 48 8b 45 d0 48 8b 38 e8 8d e9 e1 00 e8 18 e6 da ff 41 bc ea ff ff ff eb 9f <0f> 0b e9 0d fe ff ff 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
[   47.331385] RSP: 0018:ffff99cac101bb10 EFLAGS: 00010246
[   47.331385] RAX: 0000000000000000 RBX: 00007981b3d12000 RCX: ffff99cac101bb60
[   47.331386] RDX: ffff99cac101bb58 RSI: 00007981b3d12000 RDI: ffff8923030d1ee8
[   47.331386] RBP: ffff99cac101bb48 R08: ffff99cac101bd18 R09: 0000000000000000
[   47.331387] R10: 0000000000000000 R11: 0000000000000000 R12: ffff99cac101bba8
[   47.331387] R13: 0000000000000000 R14: ffff99cac101bb58 R15: ffff8923086a5d80
[   47.331388] FS:  0000000000000000(0000) GS:ffff892a9e900000(0000) knlGS:0000000000000000
[   47.331388] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   47.331389] CR2: 000070e8b04ee200 CR3: 000000012aa3e000 CR4: 0000000000f50ef0
[   47.331389] PKRU: 55555554
[   47.331390] Call Trace:
[   47.331390]  <TASK>
[   47.331390]  ? show_regs+0x6c/0x80
[   47.331391]  ? __warn+0x88/0x140
[   47.331393]  ? follow_pte+0x220/0x230
[   47.331394]  ? report_bug+0x182/0x1b0
[   47.331395]  ? handle_bug+0x51/0xa0
[   47.331397]  ? exc_invalid_op+0x18/0x80
[   47.331398]  ? asm_exc_invalid_op+0x1b/0x20
[   47.331399]  ? follow_pte+0x220/0x230
[   47.331401]  follow_phys+0x4e/0x110
[   47.331402]  untrack_pfn+0x57/0x130
[   47.331404]  unmap_single_vma+0xbc/0xf0
[   47.331405]  zap_page_range_single+0x138/0x210
[   47.331406]  unmap_mapping_range+0x11b/0x140
[   47.331407]  nv_revoke_gpu_mappings+0x68/0xc0 [nvidia]
[   47.331527]  _nv000741rm+0x35/0xf6 [nvidia]
[   47.331690]  ? rm_execute_work_item+0x141/0x1f0 [nvidia]
[   47.331852]  ? os_execute_work_item+0x6c/0x90 [nvidia]
[   47.331976]  ? _main_loop+0x7e/0x140 [nvidia]
[   47.332087]  ? __pfx__main_loop+0x10/0x10 [nvidia]
[   47.332207]  ? kthread+0xe1/0x110
[   47.332208]  ? __pfx_kthread+0x10/0x10
[   47.332209]  ? ret_from_fork+0x44/0x70
[   47.332210]  ? __pfx_kthread+0x10/0x10
[   47.332210]  ? ret_from_fork_asm+0x1a/0x30
[   47.332212]  </TASK>
[   47.332212] ---[ end trace 0000000000000000 ]---
[   47.332215] ------------[ cut here ]------------
[   47.332216] WARNING: CPU: 2 PID: 1141 at include/linux/rwsem.h:80 follow_pte+0x220/0x230
[   47.332218] Modules linked in: nvidia_uvm(POE) ccm(E) rfcomm(E) snd_seq_dummy(E) snd_hrtimer(E) qrtr(E) cmac(E) algif_hash(E) algif_skcipher(E) af_alg(E) bnep(E) xe(E) snd_hda_codec_realtek(E) drm_gpuvm(E) drm_exec(E) snd_hda_codec_generic(E) gpu_sched(E) drm_suballoc_helper(E) snd_hda_scodec_component(E) binfmt_misc(E) nls_iso8859_1(E) nvidia_drm(POE) nvidia_modeset(POE) nvidia(POE) intel_uncore_frequency(E) intel_uncore_frequency_common(E) intel_tcc_cooling(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) snd_hda_codec_hdmi(E) snd_sof_pci_intel_tgl(E) snd_sof_pci_intel_cnl(E) snd_sof_intel_hda_generic(E) soundwire_intel(E) soundwire_cadence(E) snd_sof_intel_hda_common(E) snd_sof_intel_hda_mlink(E) snd_sof_intel_hda(E) snd_sof_pci(E) snd_sof_xtensa_dsp(E) snd_sof(E) snd_sof_utils(E) snd_soc_hdac_hda(E) snd_soc_acpi_intel_match(E) soundwire_generic_allocation(E) snd_soc_acpi(E) soundwire_bus(E) snd_soc_avs(E) snd_soc_hda_codec(E) snd_hda_ext_core(E) snd_soc_core(E) snd_compress(E) a
 c97_bus(E) snd_pcm_dmaengine(E)
[   47.332230]  snd_hda_intel(E) snd_intel_dspcfg(E) snd_intel_sdw_acpi(E) snd_hda_codec(E) snd_hda_core(E) snd_hwdep(E) snd_pcm(E) uvcvideo(E) videobuf2_vmalloc(E) iwlmvm(E) btusb(E) snd_seq_midi(E) uvc(E) coretemp(E) btrtl(E) videobuf2_memops(E) i915(E) snd_seq_midi_event(E) btintel(E) videobuf2_v4l2(E) mac80211(E) kvm_intel(E) snd_rawmidi(E) btbcm(E) videodev(E) btmtk(E) videobuf2_common(E) ite_829x(OE) snd_seq(E) libarc4(E) drm_buddy(E) mc(E) led_class_multicolor(E) processor_thermal_device_pci(E) bluetooth(E) kvm(E) snd_seq_device(E) spd5118(E) processor_thermal_device(E) drm_display_helper(E) cmdlinepart(E) iwlwifi(E) mei_hdcp(E) mei_pxp(E) snd_timer(E) processor_thermal_wt_hint(E) processor_thermal_rfim(E) cec(E) spi_nor(E) rapl(E) processor_thermal_rapl(E) mtd(E) intel_rapl_msr(E) i2c_i801(E) snd(E) drm_ttm_helper(E) nvidia_wmi_ec_backlight(E) mxm_wmi(E) intel_cstate(E) intel_rapl_common(E) rc_core(E) i2c_mux(E) mei_me(E) processor_thermal_wt_req(E) soundcore(E) spi_intel_pci
 (E) cfg80211(E) ttm(E) i2c_smbus(E)
[   47.332245]  i2c_algo_bit(E) processor_thermal_power_floor(E) spi_intel(E) mei(E) processor_thermal_mbox(E) intel_pmc_core(E) int3403_thermal(E) int340x_thermal_zone(E) intel_vsec(E) int3400_thermal(E) pmt_telemetry(E) intel_hid(E) pmt_class(E) acpi_thermal_rel(E) joydev(E) sparse_keymap(E) acpi_pad(E) input_leds(E) mac_hid(E) serio_raw(E) sch_fq_codel(E) msr(E) parport_pc(E) ppdev(E) lp(E) nvme_fabrics(E) parport(E) nvme_keyring(E) efi_pstore(E) nfnetlink(E) dmi_sysfs(E) ip_tables(E) x_tables(E) autofs4(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) libcrc32c(E) dm_crypt(E) dm_mirror(E) dm_region_hash(E) dm_log(E) usbhid(E) nvme(E) hid_multitouch(E) hid_generic(E) nvme_core(E) nvme_auth(E) crct10dif_pclmul(E) crc32_pclmul(E) polyval_clmulni(E) polyval_generic(E) ghash_clmulni_intel(E) sha256_ssse3(E) thunderbolt(E) sha1_ssse3(E) ucsi_acpi(E) psmouse(E) intel_lpss_pci(E) typec_ucsi(E) igc(E) xhci_pci(E) intel_lpss(E) xhci_pci_renesas(E) vmd(E) idma64(E) typec(E) i2c_hid_acpi(E)
  i2c_hid(E) hid(E) video(E) wmi(E)
[   47.332261]  pinctrl_alderlake(E) aesni_intel(E) crypto_simd(E) cryptd(E)
[   47.332262] CPU: 2 UID: 0 PID: 1141 Comm: nv_queue Tainted: P        W  OE      6.11.5 #1
[   47.332264] Tainted: [P]=PROPRIETARY_MODULE, [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[   47.332264] Hardware name: Notebook X370SNx1/X370SNx1, BIOS 1.07.03aMIN29 09/18/2024
[   47.332264] RIP: 0010:follow_pte+0x220/0x230
[   47.332266] Code: 15 75 33 8c 01 48 81 e2 00 00 00 c0 e9 7b ff ff ff 48 8b 45 d0 48 8b 38 e8 8d e9 e1 00 e8 18 e6 da ff 41 bc ea ff ff ff eb 9f <0f> 0b e9 0d fe ff ff 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
[   47.332267] RSP: 0018:ffff99cac101bb10 EFLAGS: 00010246
[   47.332267] RAX: 0000000000000000 RBX: 00007981b4bbd000 RCX: ffff99cac101bb60
[   47.332268] RDX: ffff99cac101bb58 RSI: 00007981b4bbd000 RDI: ffff8923030d0b80
[   47.332268] RBP: ffff99cac101bb48 R08: ffff99cac101bd18 R09: 0000000000000000
[   47.332269] R10: 0000000000000000 R11: 0000000000000000 R12: ffff99cac101bba8
[   47.332269] R13: 0000000000000000 R14: ffff99cac101bb58 R15: ffff8923086a5d80
[   47.332270] FS:  0000000000000000(0000) GS:ffff892a9e900000(0000) knlGS:0000000000000000
[   47.332270] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   47.332271] CR2: 000070e8b04ee200 CR3: 000000012aa3e000 CR4: 0000000000f50ef0
[   47.332271] PKRU: 55555554
[   47.332272] Call Trace:
[   47.332272]  <TASK>
[   47.332272]  ? show_regs+0x6c/0x80
[   47.332273]  ? __warn+0x88/0x140
[   47.332275]  ? follow_pte+0x220/0x230
[   47.332276]  ? report_bug+0x182/0x1b0
[   47.332277]  ? handle_bug+0x51/0xa0
[   47.332279]  ? exc_invalid_op+0x18/0x80
[   47.332280]  ? asm_exc_invalid_op+0x1b/0x20
[   47.332282]  ? follow_pte+0x220/0x230
[   47.332283]  follow_phys+0x4e/0x110
[   47.332285]  untrack_pfn+0x57/0x130
[   47.332286]  unmap_single_vma+0xbc/0xf0
[   47.332287]  zap_page_range_single+0x138/0x210
[   47.332289]  unmap_mapping_range+0x11b/0x140
[   47.332290]  nv_revoke_gpu_mappings+0x68/0xc0 [nvidia]
[   47.332410]  _nv000741rm+0x35/0xf6 [nvidia]
[   47.332592]  ? rm_execute_work_item+0x141/0x1f0 [nvidia]
[   47.332783]  ? os_execute_work_item+0x6c/0x90 [nvidia]
[   47.332893]  ? _main_loop+0x7e/0x140 [nvidia]
[   47.333037]  ? __pfx__main_loop+0x10/0x10 [nvidia]
[   47.333149]  ? kthread+0xe1/0x110
[   47.333150]  ? __pfx_kthread+0x10/0x10
[   47.333151]  ? ret_from_fork+0x44/0x70
[   47.333152]  ? __pfx_kthread+0x10/0x10
[   47.333153]  ? ret_from_fork_asm+0x1a/0x30
[   47.333154]  </TASK>
[   47.333155] ---[ end trace 0000000000000000 ]---
[   47.333162] ------------[ cut here ]------------
[   47.333162] WARNING: CPU: 2 PID: 1141 at include/linux/rwsem.h:80 follow_pte+0x220/0x230
[   47.333164] Modules linked in: nvidia_uvm(POE) ccm(E) rfcomm(E) snd_seq_dummy(E) snd_hrtimer(E) qrtr(E) cmac(E) algif_hash(E) algif_skcipher(E) af_alg(E) bnep(E) xe(E) snd_hda_codec_realtek(E) drm_gpuvm(E) drm_exec(E) snd_hda_codec_generic(E) gpu_sched(E) drm_suballoc_helper(E) snd_hda_scodec_component(E) binfmt_misc(E) nls_iso8859_1(E) nvidia_drm(POE) nvidia_modeset(POE) nvidia(POE) intel_uncore_frequency(E) intel_uncore_frequency_common(E) intel_tcc_cooling(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) snd_hda_codec_hdmi(E) snd_sof_pci_intel_tgl(E) snd_sof_pci_intel_cnl(E) snd_sof_intel_hda_generic(E) soundwire_intel(E) soundwire_cadence(E) snd_sof_intel_hda_common(E) snd_sof_intel_hda_mlink(E) snd_sof_intel_hda(E) snd_sof_pci(E) snd_sof_xtensa_dsp(E) snd_sof(E) snd_sof_utils(E) snd_soc_hdac_hda(E) snd_soc_acpi_intel_match(E) soundwire_generic_allocation(E) snd_soc_acpi(E) soundwire_bus(E) snd_soc_avs(E) snd_soc_hda_codec(E) snd_hda_ext_core(E) snd_soc_core(E) snd_compress(E) a
 c97_bus(E) snd_pcm_dmaengine(E)
[   47.333176]  snd_hda_intel(E) snd_intel_dspcfg(E) snd_intel_sdw_acpi(E) snd_hda_codec(E) snd_hda_core(E) snd_hwdep(E) snd_pcm(E) uvcvideo(E) videobuf2_vmalloc(E) iwlmvm(E) btusb(E) snd_seq_midi(E) uvc(E) coretemp(E) btrtl(E) videobuf2_memops(E) i915(E) snd_seq_midi_event(E) btintel(E) videobuf2_v4l2(E) mac80211(E) kvm_intel(E) snd_rawmidi(E) btbcm(E) videodev(E) btmtk(E) videobuf2_common(E) ite_829x(OE) snd_seq(E) libarc4(E) drm_buddy(E) mc(E) led_class_multicolor(E) processor_thermal_device_pci(E) bluetooth(E) kvm(E) snd_seq_device(E) spd5118(E) processor_thermal_device(E) drm_display_helper(E) cmdlinepart(E) iwlwifi(E) mei_hdcp(E) mei_pxp(E) snd_timer(E) processor_thermal_wt_hint(E) processor_thermal_rfim(E) cec(E) spi_nor(E) rapl(E) processor_thermal_rapl(E) mtd(E) intel_rapl_msr(E) i2c_i801(E) snd(E) drm_ttm_helper(E) nvidia_wmi_ec_backlight(E) mxm_wmi(E) intel_cstate(E) intel_rapl_common(E) rc_core(E) i2c_mux(E) mei_me(E) processor_thermal_wt_req(E) soundcore(E) spi_intel_pci
 (E) cfg80211(E) ttm(E) i2c_smbus(E)
[   47.333191]  i2c_algo_bit(E) processor_thermal_power_floor(E) spi_intel(E) mei(E) processor_thermal_mbox(E) intel_pmc_core(E) int3403_thermal(E) int340x_thermal_zone(E) intel_vsec(E) int3400_thermal(E) pmt_telemetry(E) intel_hid(E) pmt_class(E) acpi_thermal_rel(E) joydev(E) sparse_keymap(E) acpi_pad(E) input_leds(E) mac_hid(E) serio_raw(E) sch_fq_codel(E) msr(E) parport_pc(E) ppdev(E) lp(E) nvme_fabrics(E) parport(E) nvme_keyring(E) efi_pstore(E) nfnetlink(E) dmi_sysfs(E) ip_tables(E) x_tables(E) autofs4(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) libcrc32c(E) dm_crypt(E) dm_mirror(E) dm_region_hash(E) dm_log(E) usbhid(E) nvme(E) hid_multitouch(E) hid_generic(E) nvme_core(E) nvme_auth(E) crct10dif_pclmul(E) crc32_pclmul(E) polyval_clmulni(E) polyval_generic(E) ghash_clmulni_intel(E) sha256_ssse3(E) thunderbolt(E) sha1_ssse3(E) ucsi_acpi(E) psmouse(E) intel_lpss_pci(E) typec_ucsi(E) igc(E) xhci_pci(E) intel_lpss(E) xhci_pci_renesas(E) vmd(E) idma64(E) typec(E) i2c_hid_acpi(E)
  i2c_hid(E) hid(E) video(E) wmi(E)
[   47.333207]  pinctrl_alderlake(E) aesni_intel(E) crypto_simd(E) cryptd(E)
[   47.333208] CPU: 2 UID: 0 PID: 1141 Comm: nv_queue Tainted: P        W  OE      6.11.5 #1
[   47.333209] Tainted: [P]=PROPRIETARY_MODULE, [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[   47.333209] Hardware name: Notebook X370SNx1/X370SNx1, BIOS 1.07.03aMIN29 09/18/2024
[   47.333210] RIP: 0010:follow_pte+0x220/0x230
[   47.333211] Code: 15 75 33 8c 01 48 81 e2 00 00 00 c0 e9 7b ff ff ff 48 8b 45 d0 48 8b 38 e8 8d e9 e1 00 e8 18 e6 da ff 41 bc ea ff ff ff eb 9f <0f> 0b e9 0d fe ff ff 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
[   47.333212] RSP: 0018:ffff99cac101bb10 EFLAGS: 00010246
[   47.333212] RAX: 0000000000000000 RBX: 00007981a2fc0000 RCX: ffff99cac101bb60
[   47.333213] RDX: ffff99cac101bb58 RSI: 00007981a2fc0000 RDI: ffff892305d02170
[   47.333213] RBP: ffff99cac101bb48 R08: ffff99cac101bd18 R09: 0000000000000000
[   47.333214] R10: 0000000000000000 R11: 0000000000000000 R12: ffff99cac101bba8
[   47.333214] R13: 0000000000000000 R14: ffff99cac101bb58 R15: ffff8923086a5d80
[   47.333215] FS:  0000000000000000(0000) GS:ffff892a9e900000(0000) knlGS:0000000000000000
[   47.333215] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   47.333216] CR2: 000070e8b04ee200 CR3: 000000012aa3e000 CR4: 0000000000f50ef0
[   47.333216] PKRU: 55555554
[   47.333217] Call Trace:
[   47.333217]  <TASK>
[   47.333217]  ? show_regs+0x6c/0x80
[   47.333218]  ? __warn+0x88/0x140
[   47.333220]  ? follow_pte+0x220/0x230
[   47.333221]  ? report_bug+0x182/0x1b0
[   47.333222]  ? handle_bug+0x51/0xa0
[   47.333224]  ? exc_invalid_op+0x18/0x80
[   47.333225]  ? asm_exc_invalid_op+0x1b/0x20
[   47.333226]  ? follow_pte+0x220/0x230
[   47.333228]  follow_phys+0x4e/0x110
[   47.333230]  untrack_pfn+0x57/0x130
[   47.333231]  unmap_single_vma+0xbc/0xf0
[   47.333232]  zap_page_range_single+0x138/0x210
[   47.333234]  unmap_mapping_range+0x11b/0x140
[   47.333235]  nv_revoke_gpu_mappings+0x68/0xc0 [nvidia]
[   47.333356]  _nv000741rm+0x35/0xf6 [nvidia]
[   47.333540]  ? rm_execute_work_item+0x141/0x1f0 [nvidia]
[   47.333708]  ? os_execute_work_item+0x6c/0x90 [nvidia]
[   47.333817]  ? _main_loop+0x7e/0x140 [nvidia]
[   47.333927]  ? __pfx__main_loop+0x10/0x10 [nvidia]
[   47.334089]  ? kthread+0xe1/0x110
[   47.334090]  ? __pfx_kthread+0x10/0x10
[   47.334091]  ? ret_from_fork+0x44/0x70
[   47.334092]  ? __pfx_kthread+0x10/0x10
[   47.334093]  ? ret_from_fork_asm+0x1a/0x30
[   47.334095]  </TASK>
[   47.334095] ---[ end trace 0000000000000000 ]---
[   47.334100] ------------[ cut here ]------------
[   47.334100] WARNING: CPU: 2 PID: 1141 at include/linux/rwsem.h:80 follow_pte+0x220/0x230
[   47.334102] Modules linked in: nvidia_uvm(POE) ccm(E) rfcomm(E) snd_seq_dummy(E) snd_hrtimer(E) qrtr(E) cmac(E) algif_hash(E) algif_skcipher(E) af_alg(E) bnep(E) xe(E) snd_hda_codec_realtek(E) drm_gpuvm(E) drm_exec(E) snd_hda_codec_generic(E) gpu_sched(E) drm_suballoc_helper(E) snd_hda_scodec_component(E) binfmt_misc(E) nls_iso8859_1(E) nvidia_drm(POE) nvidia_modeset(POE) nvidia(POE) intel_uncore_frequency(E) intel_uncore_frequency_common(E) intel_tcc_cooling(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) snd_hda_codec_hdmi(E) snd_sof_pci_intel_tgl(E) snd_sof_pci_intel_cnl(E) snd_sof_intel_hda_generic(E) soundwire_intel(E) soundwire_cadence(E) snd_sof_intel_hda_common(E) snd_sof_intel_hda_mlink(E) snd_sof_intel_hda(E) snd_sof_pci(E) snd_sof_xtensa_dsp(E) snd_sof(E) snd_sof_utils(E) snd_soc_hdac_hda(E) snd_soc_acpi_intel_match(E) soundwire_generic_allocation(E) snd_soc_acpi(E) soundwire_bus(E) snd_soc_avs(E) snd_soc_hda_codec(E) snd_hda_ext_core(E) snd_soc_core(E) snd_compress(E) a
 c97_bus(E) snd_pcm_dmaengine(E)
[   47.334115]  snd_hda_intel(E) snd_intel_dspcfg(E) snd_intel_sdw_acpi(E) snd_hda_codec(E) snd_hda_core(E) snd_hwdep(E) snd_pcm(E) uvcvideo(E) videobuf2_vmalloc(E) iwlmvm(E) btusb(E) snd_seq_midi(E) uvc(E) coretemp(E) btrtl(E) videobuf2_memops(E) i915(E) snd_seq_midi_event(E) btintel(E) videobuf2_v4l2(E) mac80211(E) kvm_intel(E) snd_rawmidi(E) btbcm(E) videodev(E) btmtk(E) videobuf2_common(E) ite_829x(OE) snd_seq(E) libarc4(E) drm_buddy(E) mc(E) led_class_multicolor(E) processor_thermal_device_pci(E) bluetooth(E) kvm(E) snd_seq_device(E) spd5118(E) processor_thermal_device(E) drm_display_helper(E) cmdlinepart(E) iwlwifi(E) mei_hdcp(E) mei_pxp(E) snd_timer(E) processor_thermal_wt_hint(E) processor_thermal_rfim(E) cec(E) spi_nor(E) rapl(E) processor_thermal_rapl(E) mtd(E) intel_rapl_msr(E) i2c_i801(E) snd(E) drm_ttm_helper(E) nvidia_wmi_ec_backlight(E) mxm_wmi(E) intel_cstate(E) intel_rapl_common(E) rc_core(E) i2c_mux(E) mei_me(E) processor_thermal_wt_req(E) soundcore(E) spi_intel_pci
 (E) cfg80211(E) ttm(E) i2c_smbus(E)
[   47.334130]  i2c_algo_bit(E) processor_thermal_power_floor(E) spi_intel(E) mei(E) processor_thermal_mbox(E) intel_pmc_core(E) int3403_thermal(E) int340x_thermal_zone(E) intel_vsec(E) int3400_thermal(E) pmt_telemetry(E) intel_hid(E) pmt_class(E) acpi_thermal_rel(E) joydev(E) sparse_keymap(E) acpi_pad(E) input_leds(E) mac_hid(E) serio_raw(E) sch_fq_codel(E) msr(E) parport_pc(E) ppdev(E) lp(E) nvme_fabrics(E) parport(E) nvme_keyring(E) efi_pstore(E) nfnetlink(E) dmi_sysfs(E) ip_tables(E) x_tables(E) autofs4(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) libcrc32c(E) dm_crypt(E) dm_mirror(E) dm_region_hash(E) dm_log(E) usbhid(E) nvme(E) hid_multitouch(E) hid_generic(E) nvme_core(E) nvme_auth(E) crct10dif_pclmul(E) crc32_pclmul(E) polyval_clmulni(E) polyval_generic(E) ghash_clmulni_intel(E) sha256_ssse3(E) thunderbolt(E) sha1_ssse3(E) ucsi_acpi(E) psmouse(E) intel_lpss_pci(E) typec_ucsi(E) igc(E) xhci_pci(E) intel_lpss(E) xhci_pci_renesas(E) vmd(E) idma64(E) typec(E) i2c_hid_acpi(E)
  i2c_hid(E) hid(E) video(E) wmi(E)
[   47.334146]  pinctrl_alderlake(E) aesni_intel(E) crypto_simd(E) cryptd(E)
[   47.334147] CPU: 2 UID: 0 PID: 1141 Comm: nv_queue Tainted: P        W  OE      6.11.5 #1
[   47.334148] Tainted: [P]=PROPRIETARY_MODULE, [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[   47.334149] Hardware name: Notebook X370SNx1/X370SNx1, BIOS 1.07.03aMIN29 09/18/2024
[   47.334149] RIP: 0010:follow_pte+0x220/0x230
[   47.334151] Code: 15 75 33 8c 01 48 81 e2 00 00 00 c0 e9 7b ff ff ff 48 8b 45 d0 48 8b 38 e8 8d e9 e1 00 e8 18 e6 da ff 41 bc ea ff ff ff eb 9f <0f> 0b e9 0d fe ff ff 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
[   47.334151] RSP: 0018:ffff99cac101bb10 EFLAGS: 00010246
[   47.334152] RAX: 0000000000000000 RBX: 00007981b4bc2000 RCX: ffff99cac101bb60
[   47.334152] RDX: ffff99cac101bb58 RSI: 00007981b4bc2000 RDI: ffff89232bf6b140
[   47.334153] RBP: ffff99cac101bb48 R08: ffff99cac101bd18 R09: 0000000000000000
[   47.334153] R10: 0000000000000000 R11: 0000000000000000 R12: ffff99cac101bba8
[   47.334154] R13: 0000000000000000 R14: ffff99cac101bb58 R15: ffff8923086a5d80
[   47.334154] FS:  0000000000000000(0000) GS:ffff892a9e900000(0000) knlGS:0000000000000000
[   47.334155] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   47.334155] CR2: 000070e8b04ee200 CR3: 000000012aa3e000 CR4: 0000000000f50ef0
[   47.334156] PKRU: 55555554
[   47.334156] Call Trace:
[   47.334156]  <TASK>
[   47.334157]  ? show_regs+0x6c/0x80
[   47.334158]  ? __warn+0x88/0x140
[   47.334159]  ? follow_pte+0x220/0x230
[   47.334161]  ? report_bug+0x182/0x1b0
[   47.334162]  ? handle_bug+0x51/0xa0
[   47.334163]  ? exc_invalid_op+0x18/0x80
[   47.334165]  ? asm_exc_invalid_op+0x1b/0x20
[   47.334166]  ? follow_pte+0x220/0x230
[   47.334168]  follow_phys+0x4e/0x110
[   47.334169]  untrack_pfn+0x57/0x130
[   47.334171]  unmap_single_vma+0xbc/0xf0
[   47.334172]  zap_page_range_single+0x138/0x210
[   47.334173]  unmap_mapping_range+0x11b/0x140
[   47.334174]  nv_revoke_gpu_mappings+0x68/0xc0 [nvidia]
[   47.334294]  _nv000741rm+0x35/0xf6 [nvidia]
[   47.334483]  ? rm_execute_work_item+0x141/0x1f0 [nvidia]
[   47.334669]  ? os_execute_work_item+0x6c/0x90 [nvidia]
[   47.334786]  ? _main_loop+0x7e/0x140 [nvidia]
[   47.334896]  ? __pfx__main_loop+0x10/0x10 [nvidia]
[   47.335037]  ? kthread+0xe1/0x110
[   47.335038]  ? __pfx_kthread+0x10/0x10
[   47.335039]  ? ret_from_fork+0x44/0x70
[   47.335040]  ? __pfx_kthread+0x10/0x10
[   47.335041]  ? ret_from_fork_asm+0x1a/0x30
[   47.335042]  </TASK>
[   47.335043] ---[ end trace 0000000000000000 ]---
[   47.335046] ------------[ cut here ]------------
[   47.335047] WARNING: CPU: 2 PID: 1141 at include/linux/rwsem.h:80 follow_pte+0x220/0x230
[   47.335049] Modules linked in: nvidia_uvm(POE) ccm(E) rfcomm(E) snd_seq_dummy(E) snd_hrtimer(E) qrtr(E) cmac(E) algif_hash(E) algif_skcipher(E) af_alg(E) bnep(E) xe(E) snd_hda_codec_realtek(E) drm_gpuvm(E) drm_exec(E) snd_hda_codec_generic(E) gpu_sched(E) drm_suballoc_helper(E) snd_hda_scodec_component(E) binfmt_misc(E) nls_iso8859_1(E) nvidia_drm(POE) nvidia_modeset(POE) nvidia(POE) intel_uncore_frequency(E) intel_uncore_frequency_common(E) intel_tcc_cooling(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) snd_hda_codec_hdmi(E) snd_sof_pci_intel_tgl(E) snd_sof_pci_intel_cnl(E) snd_sof_intel_hda_generic(E) soundwire_intel(E) soundwire_cadence(E) snd_sof_intel_hda_common(E) snd_sof_intel_hda_mlink(E) snd_sof_intel_hda(E) snd_sof_pci(E) snd_sof_xtensa_dsp(E) snd_sof(E) snd_sof_utils(E) snd_soc_hdac_hda(E) snd_soc_acpi_intel_match(E) soundwire_generic_allocation(E) snd_soc_acpi(E) soundwire_bus(E) snd_soc_avs(E) snd_soc_hda_codec(E) snd_hda_ext_core(E) snd_soc_core(E) snd_compress(E) a
 c97_bus(E) snd_pcm_dmaengine(E)
[   47.335063]  snd_hda_intel(E) snd_intel_dspcfg(E) snd_intel_sdw_acpi(E) snd_hda_codec(E) snd_hda_core(E) snd_hwdep(E) snd_pcm(E) uvcvideo(E) videobuf2_vmalloc(E) iwlmvm(E) btusb(E) snd_seq_midi(E) uvc(E) coretemp(E) btrtl(E) videobuf2_memops(E) i915(E) snd_seq_midi_event(E) btintel(E) videobuf2_v4l2(E) mac80211(E) kvm_intel(E) snd_rawmidi(E) btbcm(E) videodev(E) btmtk(E) videobuf2_common(E) ite_829x(OE) snd_seq(E) libarc4(E) drm_buddy(E) mc(E) led_class_multicolor(E) processor_thermal_device_pci(E) bluetooth(E) kvm(E) snd_seq_device(E) spd5118(E) processor_thermal_device(E) drm_display_helper(E) cmdlinepart(E) iwlwifi(E) mei_hdcp(E) mei_pxp(E) snd_timer(E) processor_thermal_wt_hint(E) processor_thermal_rfim(E) cec(E) spi_nor(E) rapl(E) processor_thermal_rapl(E) mtd(E) intel_rapl_msr(E) i2c_i801(E) snd(E) drm_ttm_helper(E) nvidia_wmi_ec_backlight(E) mxm_wmi(E) intel_cstate(E) intel_rapl_common(E) rc_core(E) i2c_mux(E) mei_me(E) processor_thermal_wt_req(E) soundcore(E) spi_intel_pci
 (E) cfg80211(E) ttm(E) i2c_smbus(E)
[   47.335076]  i2c_algo_bit(E) processor_thermal_power_floor(E) spi_intel(E) mei(E) processor_thermal_mbox(E) intel_pmc_core(E) int3403_thermal(E) int340x_thermal_zone(E) intel_vsec(E) int3400_thermal(E) pmt_telemetry(E) intel_hid(E) pmt_class(E) acpi_thermal_rel(E) joydev(E) sparse_keymap(E) acpi_pad(E) input_leds(E) mac_hid(E) serio_raw(E) sch_fq_codel(E) msr(E) parport_pc(E) ppdev(E) lp(E) nvme_fabrics(E) parport(E) nvme_keyring(E) efi_pstore(E) nfnetlink(E) dmi_sysfs(E) ip_tables(E) x_tables(E) autofs4(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) libcrc32c(E) dm_crypt(E) dm_mirror(E) dm_region_hash(E) dm_log(E) usbhid(E) nvme(E) hid_multitouch(E) hid_generic(E) nvme_core(E) nvme_auth(E) crct10dif_pclmul(E) crc32_pclmul(E) polyval_clmulni(E) polyval_generic(E) ghash_clmulni_intel(E) sha256_ssse3(E) thunderbolt(E) sha1_ssse3(E) ucsi_acpi(E) psmouse(E) intel_lpss_pci(E) typec_ucsi(E) igc(E) xhci_pci(E) intel_lpss(E) xhci_pci_renesas(E) vmd(E) idma64(E) typec(E) i2c_hid_acpi(E)
  i2c_hid(E) hid(E) video(E) wmi(E)
[   47.335091]  pinctrl_alderlake(E) aesni_intel(E) crypto_simd(E) cryptd(E)
[   47.335092] CPU: 2 UID: 0 PID: 1141 Comm: nv_queue Tainted: P        W  OE      6.11.5 #1
[   47.335093] Tainted: [P]=PROPRIETARY_MODULE, [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[   47.335093] Hardware name: Notebook X370SNx1/X370SNx1, BIOS 1.07.03aMIN29 09/18/2024
[   47.335094] RIP: 0010:follow_pte+0x220/0x230
[   47.335095] Code: 15 75 33 8c 01 48 81 e2 00 00 00 c0 e9 7b ff ff ff 48 8b 45 d0 48 8b 38 e8 8d e9 e1 00 e8 18 e6 da ff 41 bc ea ff ff ff eb 9f <0f> 0b e9 0d fe ff ff 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
[   47.335096] RSP: 0018:ffff99cac101bb10 EFLAGS: 00010246
[   47.335096] RAX: 0000000000000000 RBX: 00007981b3cb9000 RCX: ffff99cac101bb60
[   47.335097] RDX: ffff99cac101bb58 RSI: 00007981b3cb9000 RDI: ffff89230ccdf088
[   47.335097] RBP: ffff99cac101bb48 R08: ffff99cac101bd18 R09: 0000000000000000
[   47.335098] R10: 0000000000000000 R11: 0000000000000000 R12: ffff99cac101bba8
[   47.335098] R13: 0000000000000000 R14: ffff99cac101bb58 R15: ffff8923086a5d80
[   47.335099] FS:  0000000000000000(0000) GS:ffff892a9e900000(0000) knlGS:0000000000000000
[   47.335099] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   47.335100] CR2: 000070e8b04ee200 CR3: 000000012aa3e000 CR4: 0000000000f50ef0
[   47.335100] PKRU: 55555554
[   47.335100] Call Trace:
[   47.335101]  <TASK>
[   47.335101]  ? show_regs+0x6c/0x80
[   47.335102]  ? __warn+0x88/0x140
[   47.335104]  ? follow_pte+0x220/0x230
[   47.335105]  ? report_bug+0x182/0x1b0
[   47.335107]  ? handle_bug+0x51/0xa0
[   47.335108]  ? exc_invalid_op+0x18/0x80
[   47.335109]  ? asm_exc_invalid_op+0x1b/0x20
[   47.335111]  ? follow_pte+0x220/0x230
[   47.335113]  follow_phys+0x4e/0x110
[   47.335114]  untrack_pfn+0x57/0x130
[   47.335116]  unmap_single_vma+0xbc/0xf0
[   47.335117]  zap_page_range_single+0x138/0x210
[   47.335118]  unmap_mapping_range+0x11b/0x140
[   47.335119]  nv_revoke_gpu_mappings+0x68/0xc0 [nvidia]
[   47.335239]  _nv000741rm+0x35/0xf6 [nvidia]
[   47.335423]  ? rm_execute_work_item+0x141/0x1f0 [nvidia]
[   47.335594]  ? os_execute_work_item+0x6c/0x90 [nvidia]
[   47.335702]  ? _main_loop+0x7e/0x140 [nvidia]
[   47.335811]  ? __pfx__main_loop+0x10/0x10 [nvidia]
[   47.335920]  ? kthread+0xe1/0x110
[   47.335920]  ? __pfx_kthread+0x10/0x10
[   47.335921]  ? ret_from_fork+0x44/0x70
[   47.335922]  ? __pfx_kthread+0x10/0x10
[   47.335923]  ? ret_from_fork_asm+0x1a/0x30
[   47.335924]  </TASK>
[   47.335924] ---[ end trace 0000000000000000 ]---
[   47.335927] ------------[ cut here ]------------
[   47.335928] WARNING: CPU: 2 PID: 1141 at include/linux/rwsem.h:80 follow_pte+0x220/0x230
[   47.335929] Modules linked in: nvidia_uvm(POE) ccm(E) rfcomm(E) snd_seq_dummy(E) snd_hrtimer(E) qrtr(E) cmac(E) algif_hash(E) algif_skcipher(E) af_alg(E) bnep(E) xe(E) snd_hda_codec_realtek(E) drm_gpuvm(E) drm_exec(E) snd_hda_codec_generic(E) gpu_sched(E) drm_suballoc_helper(E) snd_hda_scodec_component(E) binfmt_misc(E) nls_iso8859_1(E) nvidia_drm(POE) nvidia_modeset(POE) nvidia(POE) intel_uncore_frequency(E) intel_uncore_frequency_common(E) intel_tcc_cooling(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) snd_hda_codec_hdmi(E) snd_sof_pci_intel_tgl(E) snd_sof_pci_intel_cnl(E) snd_sof_intel_hda_generic(E) soundwire_intel(E) soundwire_cadence(E) snd_sof_intel_hda_common(E) snd_sof_intel_hda_mlink(E) snd_sof_intel_hda(E) snd_sof_pci(E) snd_sof_xtensa_dsp(E) snd_sof(E) snd_sof_utils(E) snd_soc_hdac_hda(E) snd_soc_acpi_intel_match(E) soundwire_generic_allocation(E) snd_soc_acpi(E) soundwire_bus(E) snd_soc_avs(E) snd_soc_hda_codec(E) snd_hda_ext_core(E) snd_soc_core(E) snd_compress(E) a
 c97_bus(E) snd_pcm_dmaengine(E)
[   47.335940]  snd_hda_intel(E) snd_intel_dspcfg(E) snd_intel_sdw_acpi(E) snd_hda_codec(E) snd_hda_core(E) snd_hwdep(E) snd_pcm(E) uvcvideo(E) videobuf2_vmalloc(E) iwlmvm(E) btusb(E) snd_seq_midi(E) uvc(E) coretemp(E) btrtl(E) videobuf2_memops(E) i915(E) snd_seq_midi_event(E) btintel(E) videobuf2_v4l2(E) mac80211(E) kvm_intel(E) snd_rawmidi(E) btbcm(E) videodev(E) btmtk(E) videobuf2_common(E) ite_829x(OE) snd_seq(E) libarc4(E) drm_buddy(E) mc(E) led_class_multicolor(E) processor_thermal_device_pci(E) bluetooth(E) kvm(E) snd_seq_device(E) spd5118(E) processor_thermal_device(E) drm_display_helper(E) cmdlinepart(E) iwlwifi(E) mei_hdcp(E) mei_pxp(E) snd_timer(E) processor_thermal_wt_hint(E) processor_thermal_rfim(E) cec(E) spi_nor(E) rapl(E) processor_thermal_rapl(E) mtd(E) intel_rapl_msr(E) i2c_i801(E) snd(E) drm_ttm_helper(E) nvidia_wmi_ec_backlight(E) mxm_wmi(E) intel_cstate(E) intel_rapl_common(E) rc_core(E) i2c_mux(E) mei_me(E) processor_thermal_wt_req(E) soundcore(E) spi_intel_pci
 (E) cfg80211(E) ttm(E) i2c_smbus(E)
[   47.335954]  i2c_algo_bit(E) processor_thermal_power_floor(E) spi_intel(E) mei(E) processor_thermal_mbox(E) intel_pmc_core(E) int3403_thermal(E) int340x_thermal_zone(E) intel_vsec(E) int3400_thermal(E) pmt_telemetry(E) intel_hid(E) pmt_class(E) acpi_thermal_rel(E) joydev(E) sparse_keymap(E) acpi_pad(E) input_leds(E) mac_hid(E) serio_raw(E) sch_fq_codel(E) msr(E) parport_pc(E) ppdev(E) lp(E) nvme_fabrics(E) parport(E) nvme_keyring(E) efi_pstore(E) nfnetlink(E) dmi_sysfs(E) ip_tables(E) x_tables(E) autofs4(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) libcrc32c(E) dm_crypt(E) dm_mirror(E) dm_region_hash(E) dm_log(E) usbhid(E) nvme(E) hid_multitouch(E) hid_generic(E) nvme_core(E) nvme_auth(E) crct10dif_pclmul(E) crc32_pclmul(E) polyval_clmulni(E) polyval_generic(E) ghash_clmulni_intel(E) sha256_ssse3(E) thunderbolt(E) sha1_ssse3(E) ucsi_acpi(E) psmouse(E) intel_lpss_pci(E) typec_ucsi(E) igc(E) xhci_pci(E) intel_lpss(E) xhci_pci_renesas(E) vmd(E) idma64(E) typec(E) i2c_hid_acpi(E)
  i2c_hid(E) hid(E) video(E) wmi(E)
[   47.335974]  pinctrl_alderlake(E) aesni_intel(E) crypto_simd(E) cryptd(E)
[   47.335976] CPU: 2 UID: 0 PID: 1141 Comm: nv_queue Tainted: P        W  OE      6.11.5 #1
[   47.335977] Tainted: [P]=PROPRIETARY_MODULE, [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[   47.335978] Hardware name: Notebook X370SNx1/X370SNx1, BIOS 1.07.03aMIN29 09/18/2024
[   47.335978] RIP: 0010:follow_pte+0x220/0x230
[   47.335980] Code: 15 75 33 8c 01 48 81 e2 00 00 00 c0 e9 7b ff ff ff 48 8b 45 d0 48 8b 38 e8 8d e9 e1 00 e8 18 e6 da ff 41 bc ea ff ff ff eb 9f <0f> 0b e9 0d fe ff ff 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
[   47.335980] RSP: 0018:ffff99cac101bb10 EFLAGS: 00010246
[   47.335981] RAX: 0000000000000000 RBX: 00007981b400a000 RCX: ffff99cac101bb60
[   47.335981] RDX: ffff99cac101bb58 RSI: 00007981b400a000 RDI: ffff89230ccdfa98
[   47.335982] RBP: ffff99cac101bb48 R08: ffff99cac101bd18 R09: 0000000000000000
[   47.335983] R10: 0000000000000000 R11: 0000000000000000 R12: ffff99cac101bba8
[   47.335983] R13: 0000000000000000 R14: ffff99cac101bb58 R15: ffff8923086a5d80
[   47.335983] FS:  0000000000000000(0000) GS:ffff892a9e900000(0000) knlGS:0000000000000000
[   47.335984] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   47.335985] CR2: 000070e8b04ee200 CR3: 000000012aa3e000 CR4: 0000000000f50ef0
[   47.335985] PKRU: 55555554
[   47.335985] Call Trace:
[   47.335986]  <TASK>
[   47.335986]  ? show_regs+0x6c/0x80
[   47.335987]  ? __warn+0x88/0x140
[   47.335989]  ? follow_pte+0x220/0x230
[   47.335990]  ? report_bug+0x182/0x1b0
[   47.335992]  ? handle_bug+0x51/0xa0
[   47.335993]  ? exc_invalid_op+0x18/0x80
[   47.335995]  ? asm_exc_invalid_op+0x1b/0x20
[   47.335996]  ? follow_pte+0x220/0x230
[   47.335997]  follow_phys+0x4e/0x110
[   47.335999]  untrack_pfn+0x57/0x130
[   47.336001]  unmap_single_vma+0xbc/0xf0
[   47.336002]  zap_page_range_single+0x138/0x210
[   47.336003]  unmap_mapping_range+0x11b/0x140
[   47.336004]  nv_revoke_gpu_mappings+0x68/0xc0 [nvidia]
[   47.336115]  _nv000741rm+0x35/0xf6 [nvidia]
[   47.336291]  ? rm_execute_work_item+0x141/0x1f0 [nvidia]
[   47.336479]  ? os_execute_work_item+0x6c/0x90 [nvidia]
[   47.336600]  ? _main_loop+0x7e/0x140 [nvidia]
[   47.336720]  ? __pfx__main_loop+0x10/0x10 [nvidia]
[   47.336831]  ? kthread+0xe1/0x110
[   47.336832]  ? __pfx_kthread+0x10/0x10
[   47.336832]  ? ret_from_fork+0x44/0x70
[   47.336833]  ? __pfx_kthread+0x10/0x10
[   47.336834]  ? ret_from_fork_asm+0x1a/0x30
[   47.336835]  </TASK>
[   47.336836] ---[ end trace 0000000000000000 ]---
[   73.396392] ------------[ cut here ]------------
[   73.396400] WARNING: CPU: 0 PID: 1141 at include/linux/rwsem.h:80 follow_pte+0x220/0x230
[   73.396420] Modules linked in: nvidia_uvm(POE) ccm(E) rfcomm(E) snd_seq_dummy(E) snd_hrtimer(E) qrtr(E) cmac(E) algif_hash(E) algif_skcipher(E) af_alg(E) bnep(E) xe(E) snd_hda_codec_realtek(E) drm_gpuvm(E) drm_exec(E) snd_hda_codec_generic(E) gpu_sched(E) drm_suballoc_helper(E) snd_hda_scodec_component(E) binfmt_misc(E) nls_iso8859_1(E) nvidia_drm(POE) nvidia_modeset(POE) nvidia(POE) intel_uncore_frequency(E) intel_uncore_frequency_common(E) intel_tcc_cooling(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) snd_hda_codec_hdmi(E) snd_sof_pci_intel_tgl(E) snd_sof_pci_intel_cnl(E) snd_sof_intel_hda_generic(E) soundwire_intel(E) soundwire_cadence(E) snd_sof_intel_hda_common(E) snd_sof_intel_hda_mlink(E) snd_sof_intel_hda(E) snd_sof_pci(E) snd_sof_xtensa_dsp(E) snd_sof(E) snd_sof_utils(E) snd_soc_hdac_hda(E) snd_soc_acpi_intel_match(E) soundwire_generic_allocation(E) snd_soc_acpi(E) soundwire_bus(E) snd_soc_avs(E) snd_soc_hda_codec(E) snd_hda_ext_core(E) snd_soc_core(E) snd_compress(E) a
 c97_bus(E) snd_pcm_dmaengine(E)
[   73.396509]  snd_hda_intel(E) snd_intel_dspcfg(E) snd_intel_sdw_acpi(E) snd_hda_codec(E) snd_hda_core(E) snd_hwdep(E) snd_pcm(E) uvcvideo(E) videobuf2_vmalloc(E) iwlmvm(E) btusb(E) snd_seq_midi(E) uvc(E) coretemp(E) btrtl(E) videobuf2_memops(E) i915(E) snd_seq_midi_event(E) btintel(E) videobuf2_v4l2(E) mac80211(E) kvm_intel(E) snd_rawmidi(E) btbcm(E) videodev(E) btmtk(E) videobuf2_common(E) ite_829x(OE) snd_seq(E) libarc4(E) drm_buddy(E) mc(E) led_class_multicolor(E) processor_thermal_device_pci(E) bluetooth(E) kvm(E) snd_seq_device(E) spd5118(E) processor_thermal_device(E) drm_display_helper(E) cmdlinepart(E) iwlwifi(E) mei_hdcp(E) mei_pxp(E) snd_timer(E) processor_thermal_wt_hint(E) processor_thermal_rfim(E) cec(E) spi_nor(E) rapl(E) processor_thermal_rapl(E) mtd(E) intel_rapl_msr(E) i2c_i801(E) snd(E) drm_ttm_helper(E) nvidia_wmi_ec_backlight(E) mxm_wmi(E) intel_cstate(E) intel_rapl_common(E) rc_core(E) i2c_mux(E) mei_me(E) processor_thermal_wt_req(E) soundcore(E) spi_intel_pci
 (E) cfg80211(E) ttm(E) i2c_smbus(E)
[   73.396606]  i2c_algo_bit(E) processor_thermal_power_floor(E) spi_intel(E) mei(E) processor_thermal_mbox(E) intel_pmc_core(E) int3403_thermal(E) int340x_thermal_zone(E) intel_vsec(E) int3400_thermal(E) pmt_telemetry(E) intel_hid(E) pmt_class(E) acpi_thermal_rel(E) joydev(E) sparse_keymap(E) acpi_pad(E) input_leds(E) mac_hid(E) serio_raw(E) sch_fq_codel(E) msr(E) parport_pc(E) ppdev(E) lp(E) nvme_fabrics(E) parport(E) nvme_keyring(E) efi_pstore(E) nfnetlink(E) dmi_sysfs(E) ip_tables(E) x_tables(E) autofs4(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) libcrc32c(E) dm_crypt(E) dm_mirror(E) dm_region_hash(E) dm_log(E) usbhid(E) nvme(E) hid_multitouch(E) hid_generic(E) nvme_core(E) nvme_auth(E) crct10dif_pclmul(E) crc32_pclmul(E) polyval_clmulni(E) polyval_generic(E) ghash_clmulni_intel(E) sha256_ssse3(E) thunderbolt(E) sha1_ssse3(E) ucsi_acpi(E) psmouse(E) intel_lpss_pci(E) typec_ucsi(E) igc(E) xhci_pci(E) intel_lpss(E) xhci_pci_renesas(E) vmd(E) idma64(E) typec(E) i2c_hid_acpi(E)
  i2c_hid(E) hid(E) video(E) wmi(E)
[   73.396708]  pinctrl_alderlake(E) aesni_intel(E) crypto_simd(E) cryptd(E)
[   73.396719] CPU: 0 UID: 0 PID: 1141 Comm: nv_queue Tainted: P        W  OE      6.11.5 #1
[   73.396729] Tainted: [P]=PROPRIETARY_MODULE, [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[   73.396732] Hardware name: Notebook X370SNx1/X370SNx1, BIOS 1.07.03aMIN29 09/18/2024
[   73.396735] RIP: 0010:follow_pte+0x220/0x230
[   73.396745] Code: 15 75 33 8c 01 48 81 e2 00 00 00 c0 e9 7b ff ff ff 48 8b 45 d0 48 8b 38 e8 8d e9 e1 00 e8 18 e6 da ff 41 bc ea ff ff ff eb 9f <0f> 0b e9 0d fe ff ff 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
[   73.396750] RSP: 0018:ffff99cac101bb10 EFLAGS: 00010246
[   73.396755] RAX: 0000000000000000 RBX: 00007f65bdc00000 RCX: ffff99cac101bb60
[   73.396759] RDX: ffff99cac101bb58 RSI: 00007f65bdc00000 RDI: ffff89230f28b7b8
[   73.396761] RBP: ffff99cac101bb48 R08: ffff99cac101bd18 R09: 0000000000000000
[   73.396764] R10: 0000000000000000 R11: 0000000000000000 R12: ffff99cac101bba8
[   73.396767] R13: 0000000000000000 R14: ffff99cac101bb58 R15: ffff89230c1dc200
[   73.396769] FS:  0000000000000000(0000) GS:ffff892a9e800000(0000) knlGS:0000000000000000
[   73.396773] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   73.396776] CR2: 0000648dba8370b8 CR3: 000000012aa3e000 CR4: 0000000000f50ef0
[   73.396780] PKRU: 55555554
[   73.396782] Call Trace:
[   73.396785]  <TASK>
[   73.396792]  ? show_regs+0x6c/0x80
[   73.396801]  ? __warn+0x88/0x140
[   73.396810]  ? follow_pte+0x220/0x230
[   73.396818]  ? report_bug+0x182/0x1b0
[   73.396826]  ? handle_bug+0x51/0xa0
[   73.396836]  ? exc_invalid_op+0x18/0x80
[   73.396843]  ? asm_exc_invalid_op+0x1b/0x20
[   73.396852]  ? follow_pte+0x220/0x230
[   73.396861]  follow_phys+0x4e/0x110
[   73.396870]  untrack_pfn+0x57/0x130
[   73.396881]  ? _nv013031rm+0x21/0x80 [nvidia]
[   73.398671]  unmap_single_vma+0xbc/0xf0
[   73.398678]  zap_page_range_single+0x138/0x210
[   73.398686]  unmap_mapping_range+0x11b/0x140
[   73.398692]  nv_revoke_gpu_mappings+0x68/0xc0 [nvidia]
[   73.399362]  _nv000741rm+0x35/0xf6 [nvidia]
[   73.400153]  ? rm_execute_work_item+0x141/0x1f0 [nvidia]
[   73.400917]  ? os_execute_work_item+0x6c/0x90 [nvidia]
[   73.401587]  ? _main_loop+0x7e/0x140 [nvidia]
[   73.402059]  ? __pfx__main_loop+0x10/0x10 [nvidia]
[   73.402497]  ? kthread+0xe1/0x110
[   73.402501]  ? __pfx_kthread+0x10/0x10
[   73.402505]  ? ret_from_fork+0x44/0x70
[   73.402508]  ? __pfx_kthread+0x10/0x10
[   73.402511]  ? ret_from_fork_asm+0x1a/0x30
[   73.402518]  </TASK>
[   73.402519] ---[ end trace 0000000000000000 ]---
[   73.402569] ------------[ cut here ]------------
[   73.402571] WARNING: CPU: 0 PID: 1141 at include/linux/rwsem.h:80 follow_pte+0x220/0x230
[   73.402581] Modules linked in: nvidia_uvm(POE) ccm(E) rfcomm(E) snd_seq_dummy(E) snd_hrtimer(E) qrtr(E) cmac(E) algif_hash(E) algif_skcipher(E) af_alg(E) bnep(E) xe(E) snd_hda_codec_realtek(E) drm_gpuvm(E) drm_exec(E) snd_hda_codec_generic(E) gpu_sched(E) drm_suballoc_helper(E) snd_hda_scodec_component(E) binfmt_misc(E) nls_iso8859_1(E) nvidia_drm(POE) nvidia_modeset(POE) nvidia(POE) intel_uncore_frequency(E) intel_uncore_frequency_common(E) intel_tcc_cooling(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) snd_hda_codec_hdmi(E) snd_sof_pci_intel_tgl(E) snd_sof_pci_intel_cnl(E) snd_sof_intel_hda_generic(E) soundwire_intel(E) soundwire_cadence(E) snd_sof_intel_hda_common(E) snd_sof_intel_hda_mlink(E) snd_sof_intel_hda(E) snd_sof_pci(E) snd_sof_xtensa_dsp(E) snd_sof(E) snd_sof_utils(E) snd_soc_hdac_hda(E) snd_soc_acpi_intel_match(E) soundwire_generic_allocation(E) snd_soc_acpi(E) soundwire_bus(E) snd_soc_avs(E) snd_soc_hda_codec(E) snd_hda_ext_core(E) snd_soc_core(E) snd_compress(E) a
 c97_bus(E) snd_pcm_dmaengine(E)
[   73.402639]  snd_hda_intel(E) snd_intel_dspcfg(E) snd_intel_sdw_acpi(E) snd_hda_codec(E) snd_hda_core(E) snd_hwdep(E) snd_pcm(E) uvcvideo(E) videobuf2_vmalloc(E) iwlmvm(E) btusb(E) snd_seq_midi(E) uvc(E) coretemp(E) btrtl(E) videobuf2_memops(E) i915(E) snd_seq_midi_event(E) btintel(E) videobuf2_v4l2(E) mac80211(E) kvm_intel(E) snd_rawmidi(E) btbcm(E) videodev(E) btmtk(E) videobuf2_common(E) ite_829x(OE) snd_seq(E) libarc4(E) drm_buddy(E) mc(E) led_class_multicolor(E) processor_thermal_device_pci(E) bluetooth(E) kvm(E) snd_seq_device(E) spd5118(E) processor_thermal_device(E) drm_display_helper(E) cmdlinepart(E) iwlwifi(E) mei_hdcp(E) mei_pxp(E) snd_timer(E) processor_thermal_wt_hint(E) processor_thermal_rfim(E) cec(E) spi_nor(E) rapl(E) processor_thermal_rapl(E) mtd(E) intel_rapl_msr(E) i2c_i801(E) snd(E) drm_ttm_helper(E) nvidia_wmi_ec_backlight(E) mxm_wmi(E) intel_cstate(E) intel_rapl_common(E) rc_core(E) i2c_mux(E) mei_me(E) processor_thermal_wt_req(E) soundcore(E) spi_intel_pci
 (E) cfg80211(E) ttm(E) i2c_smbus(E)
[   73.402703]  i2c_algo_bit(E) processor_thermal_power_floor(E) spi_intel(E) mei(E) processor_thermal_mbox(E) intel_pmc_core(E) int3403_thermal(E) int340x_thermal_zone(E) intel_vsec(E) int3400_thermal(E) pmt_telemetry(E) intel_hid(E) pmt_class(E) acpi_thermal_rel(E) joydev(E) sparse_keymap(E) acpi_pad(E) input_leds(E) mac_hid(E) serio_raw(E) sch_fq_codel(E) msr(E) parport_pc(E) ppdev(E) lp(E) nvme_fabrics(E) parport(E) nvme_keyring(E) efi_pstore(E) nfnetlink(E) dmi_sysfs(E) ip_tables(E) x_tables(E) autofs4(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) libcrc32c(E) dm_crypt(E) dm_mirror(E) dm_region_hash(E) dm_log(E) usbhid(E) nvme(E) hid_multitouch(E) hid_generic(E) nvme_core(E) nvme_auth(E) crct10dif_pclmul(E) crc32_pclmul(E) polyval_clmulni(E) polyval_generic(E) ghash_clmulni_intel(E) sha256_ssse3(E) thunderbolt(E) sha1_ssse3(E) ucsi_acpi(E) psmouse(E) intel_lpss_pci(E) typec_ucsi(E) igc(E) xhci_pci(E) intel_lpss(E) xhci_pci_renesas(E) vmd(E) idma64(E) typec(E) i2c_hid_acpi(E)
  i2c_hid(E) hid(E) video(E) wmi(E)
[   73.402770]  pinctrl_alderlake(E) aesni_intel(E) crypto_simd(E) cryptd(E)
[   73.402778] CPU: 0 UID: 0 PID: 1141 Comm: nv_queue Tainted: P        W  OE      6.11.5 #1
[   73.402784] Tainted: [P]=PROPRIETARY_MODULE, [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[   73.402786] Hardware name: Notebook X370SNx1/X370SNx1, BIOS 1.07.03aMIN29 09/18/2024
[   73.402787] RIP: 0010:follow_pte+0x220/0x230
[   73.402793] Code: 15 75 33 8c 01 48 81 e2 00 00 00 c0 e9 7b ff ff ff 48 8b 45 d0 48 8b 38 e8 8d e9 e1 00 e8 18 e6 da ff 41 bc ea ff ff ff eb 9f <0f> 0b e9 0d fe ff ff 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
[   73.402795] RSP: 0018:ffff99cac101bb10 EFLAGS: 00010246
[   73.402798] RAX: 0000000000000000 RBX: 00007f65e8c2e000 RCX: ffff99cac101bb60
[   73.402800] RDX: ffff99cac101bb58 RSI: 00007f65e8c2e000 RDI: ffff8923bbc08fd0
[   73.402802] RBP: ffff99cac101bb48 R08: ffff99cac101bd18 R09: 0000000000000000
[   73.402803] R10: 0000000000000000 R11: 0000000000000000 R12: ffff99cac101bba8
[   73.402805] R13: 0000000000000000 R14: ffff99cac101bb58 R15: ffff89230c1dc200
[   73.402807] FS:  0000000000000000(0000) GS:ffff892a9e800000(0000) knlGS:0000000000000000
[   73.402809] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   73.402811] CR2: 0000648dba8370b8 CR3: 000000012aa3e000 CR4: 0000000000f50ef0
[   73.402813] PKRU: 55555554
[   73.402814] Call Trace:
[   73.402815]  <TASK>
[   73.402816]  ? show_regs+0x6c/0x80
[   73.402821]  ? __warn+0x88/0x140
[   73.402826]  ? follow_pte+0x220/0x230
[   73.402831]  ? report_bug+0x182/0x1b0
[   73.402835]  ? handle_bug+0x51/0xa0
[   73.402840]  ? exc_invalid_op+0x18/0x80
[   73.402845]  ? asm_exc_invalid_op+0x1b/0x20
[   73.402849]  ? follow_pte+0x220/0x230
[   73.402855]  follow_phys+0x4e/0x110
[   73.402860]  untrack_pfn+0x57/0x130
[   73.402866]  unmap_single_vma+0xbc/0xf0
[   73.402869]  zap_page_range_single+0x138/0x210
[   73.402874]  unmap_mapping_range+0x11b/0x140
[   73.402878]  nv_revoke_gpu_mappings+0x68/0xc0 [nvidia]
[   73.403429]  _nv000741rm+0x35/0xf6 [nvidia]
[   73.404063]  ? rm_execute_work_item+0x141/0x1f0 [nvidia]
[   73.404623]  ? os_execute_work_item+0x6c/0x90 [nvidia]
[   73.404964]  ? _main_loop+0x7e/0x140 [nvidia]
[   73.405207]  ? __pfx__main_loop+0x10/0x10 [nvidia]
[   73.405394]  ? kthread+0xe1/0x110
[   73.405395]  ? __pfx_kthread+0x10/0x10
[   73.405396]  ? ret_from_fork+0x44/0x70
[   73.405398]  ? __pfx_kthread+0x10/0x10
[   73.405399]  ? ret_from_fork_asm+0x1a/0x30
[   73.405401]  </TASK>
[   73.405401] ---[ end trace 0000000000000000 ]---
[   73.410280] usb 1-9: new full-speed USB device number 5 using xhci_hcd
[   73.551116] usb 1-9: not running at top speed; connect to a high speed hub
[   73.565330] usb 1-9: New USB device found, idVendor=2109, idProduct=0103, bcdDevice= 2.00
[   73.565341] usb 1-9: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[   73.565346] usb 1-9: Product: USB 2.0 BILLBOARD             
[   73.565349] usb 1-9: Manufacturer: VIA Technologies Inc.         
[   73.565352] usb 1-9: SerialNumber: 0000000000000001

# lspci -k run here. USB-C-attached 4k display is then discovered and works as excpected.

[  174.857360] thunderbolt 0000:06:00.0: control channel starting...
[  174.857374] thunderbolt 0000:06:00.0: starting TX ring 0
[  174.857393] thunderbolt 0000:06:00.0: enabling interrupt at register 0x38200 bit 0 (0x0 -> 0x1)
[  174.857404] thunderbolt 0000:06:00.0: starting RX ring 0
[  174.857419] thunderbolt 0000:06:00.0: enabling interrupt at register 0x38200 bit 12 (0x1 -> 0x1001)
[  174.857434] thunderbolt 0000:06:00.0: 0: resuming switch
[  174.857439] thunderbolt 0000:06:00.0: restoring Switch at 0x0 (depth: 0, up port: 15)
[  174.858449] xhci_hcd 0000:2d:00.0: xHC error in resume, USBSTS 0x401, Reinit
[  174.858458] usb usb3: root hub lost power or was reset
[  174.858464] usb usb4: root hub lost power or was reset
[  174.860572] thunderbolt 0000:06:00.0: 0: disabling wakeup
[  174.861510] thunderbolt 0000:06:00.0: acking hot plug event on 0:14
[  174.861553] thunderbolt 0000:06:00.0: acking hot plug event on 0:16
[  174.869557] thunderbolt 0000:06:00.0: 0: TMU: supports uni-directional mode
[  174.869567] thunderbolt 0000:06:00.0: 0: TMU: supports enhanced uni-directional mode
[  174.869734] thunderbolt 0000:06:00.0: 0: TMU: current mode: off
[  174.869741] thunderbolt 0000:06:00.0: 0: TMU: mode change off -> bi-directional, HiFi requested
[  174.870197] thunderbolt 0000:06:00.0: 0: TMU: mode set to: bi-directional, HiFi
[  174.871097] thunderbolt 0000:06:00.0: 0:13: enter redrive mode, keeping powered
[  174.872621] thunderbolt 0000:06:00.0: 0:14: DP IN resource available after hotplug
[  174.872634] thunderbolt 0000:06:00.0: looking for DP IN <-> DP OUT pairs:
[  174.872765] thunderbolt 0000:06:00.0: 0:14: DP IN available
[  174.872778] thunderbolt 0000:06:00.0: 0:14: no suitable DP OUT adapter available, not tunneling
[  210.068848] fbcon: Taking over console
[  211.771738] Console: switching to colour frame buffer device 160x45

# Another 4k display is attached here over USB-C. It is discovered and works as expected.

[  356.122241] usb 1-10: new high-speed USB device number 6 using xhci_hcd
[  356.127314] thunderbolt 0000:06:00.0: acking hot unplug event on 0:14
[  356.127460] thunderbolt 0000:06:00.0: 0:14: DP IN resource unavailable
[  356.128854] thunderbolt 0000:06:00.0: 0:14: enter redrive mode, keeping powered
[  356.128864] thunderbolt 0000:06:00.0: bandwidth consumption changed, re-calculating estimated bandwidth
[  356.128867] thunderbolt 0000:06:00.0: bandwidth re-calculation done
[  356.128869] thunderbolt 0000:06:00.0: looking for DP IN <-> DP OUT pairs:
[  356.128871] thunderbolt 0000:06:00.0: no suitable DP IN adapter available, not tunneling
[  356.269964] usb 1-10: New USB device found, idVendor=0bda, idProduct=5411, bcdDevice= 1.49
[  356.269977] usb 1-10: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[  356.269982] usb 1-10: Product: 4-Port USB 2.0 Hub
[  356.269985] usb 1-10: Manufacturer: Generic
[  356.274729] hub 1-10:1.0: USB hub found
[  356.276212] hub 1-10:1.0: 4 ports detected
[  357.494135] usb 1-10.3: new full-speed USB device number 7 using xhci_hcd
[  357.586181] usb 1-10.3: New USB device found, idVendor=043e, idProduct=9a39, bcdDevice= 4.11
[  357.586188] usb 1-10.3: New USB device strings: Mfr=1, Product=3, SerialNumber=4
[  357.586191] usb 1-10.3: Product: LG Monitor Controls
[  357.586193] usb 1-10.3: Manufacturer: LG Electronics Inc.
[  357.586195] usb 1-10.3: SerialNumber: 005INTX1F153
[  357.593972] hid-generic 0003:043E:9A39.0003: hiddev1,hidraw2: USB HID v1.11 Device [LG Electronics Inc. LG Monitor Controls] on usb-0000:00:14.0-10.3/input0

--MP_/WuIuDckOYZDBcFRp6AX3mk1--

