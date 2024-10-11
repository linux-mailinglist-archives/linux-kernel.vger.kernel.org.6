Return-Path: <linux-kernel+bounces-361644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 257B199AACD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 20:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CF4A1F2451C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 18:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491711BE854;
	Fri, 11 Oct 2024 18:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b="gw8uBxt9"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CBD18787F
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 18:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728669773; cv=none; b=AqiMKZGaJo41/GAkgwMUVA06MtdJJgZJqUZvYSxnw8ORmRpYKXsqv7jtBQHncn9OkZ1IjLGKrYiuBRiCqVfIsZDqRcjofvEZecKGTXh++c6bEtUfvRxxOkoiJcrlOeWIA3NDmLMnCrJg+0E6BdwDLiYxRI9BcgasxX2WQgFAu6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728669773; c=relaxed/simple;
	bh=2tArKpkGxRE5rK5oKWjfHXAVkMI5Qd73dmAKgEbLPnM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NzQ5N3w+rO2BL6cSqxGxBDOYhK3y5+b7y0qsTOeRrepXEyWWeG4BLdypgXbKEXmrMANW3rbxePgF5lw99O0pkHy8cfGdtCpJ4sCGyl+GKZWJlqean0He19Qe4w08SIFLcYhAzZTJwauAdzQf/XCzXMdGeb9ekdg53o7NH3w4pq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org; spf=pass smtp.mailfrom=kfocus.org; dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b=gw8uBxt9; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kfocus.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-8354cc1ab0cso78926139f.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 11:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kfocus-org.20230601.gappssmtp.com; s=20230601; t=1728669771; x=1729274571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pMcYkWpWyeivAbqZtP5UVS1GNqQj2sCC24l0/oqkyqw=;
        b=gw8uBxt9aQ5hvtDDr4eykgJrGlGcxT295HcZpW5jnEx6z8hJA4ps26MrXBd0DEbGzN
         3NXXqr6RS4wC7r2VAK/z8oGH3C6JlTHAPO8O94EJkMOpPZDdvray9+ycS9CIgm9Qa3b/
         OmH0k2sa4hL8Atj/VqGU14l/SenMkDDe20feXF+ry95o+ANxvZlO6ZBzk/2J51qnxdV8
         B1JTxnuPq6CE1GsZcgfNMw2RvM6au2wdTKR5JNSmbwC/3ZzUlvg6DekkgfJJIbeZYqCO
         dZa9N2UCPfH/Wg1d+2njsciKUKSxTKEfTJQDUVmuCP8t4rewdJpeLVwthWeZJf8Kg+0e
         yPyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728669771; x=1729274571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pMcYkWpWyeivAbqZtP5UVS1GNqQj2sCC24l0/oqkyqw=;
        b=hGW5+xyKjUW0cNeBRh9XlA4a6aVsvv1JL5inla6svTb92A4bNxnt2OkCChcVOHL3Wn
         +tEguw5JxvhhqDBW8lXzEcHqtEHJdBmiascRl5Rmsd8CDARlG78xAm5Oge8Q6W8rUKfm
         AXWK5OIIb+/t1u1DqD/W1IhKkpW55nng30Eg/5v8EhVFR6UtqvI8fp+OLIoqa3k1mgxl
         sCvWagt+GSC+K4WwS9w6mIuSg3d3EL1dQO881RCX+pYH6SHHTiK6TkFIQz5R272IKU5N
         PiFB8Wrpi4VeACiA6TYyKeh0ufetYiervRJ/AeFgUxAxD6iQrD/td16xyh3u+B5NqmIB
         MTlg==
X-Forwarded-Encrypted: i=1; AJvYcCUitewbftm6Z1p9+QlF9/gQ1VGuLiTkHc0rWWWdiB5HRYTGt8/ujah5fTljseOl7AkknPIs0zLOKG+un+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQXVueUGF+eJXZSoRe5qfnVwbRacJcPZy0invEqHhwJbA1kHp8
	qcmks8FmbIfYfAFqABhoR+5EScTuzQeNwwe+OmQJR58KH9FvXETy1iI7EXWS74w=
X-Google-Smtp-Source: AGHT+IEvpIPXGIzRQMNxeQzv+bllsHSO8I28ATmLkyTfJ1qdrsOYd4bmRd3IJXHaNWBjb0h5DG/K+Q==
X-Received: by 2002:a05:6e02:1809:b0:3a3:b593:83a4 with SMTP id e9e14a558f8ab-3a3b5f9e4e3mr27520305ab.14.1728669770445;
        Fri, 11 Oct 2024 11:02:50 -0700 (PDT)
Received: from localhost ([172.59.225.52])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dbad9f13cbsm729879173.75.2024.10.11.11.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 11:02:50 -0700 (PDT)
Date: Fri, 11 Oct 2024 14:02:45 -0400
From: Aaron Rainbolt <arainbolt@kfocus.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: YehezkelShB@gmail.com, michael.jamet@intel.com,
 andreas.noever@gmail.com, linux-usb@vger.kernel.org, mmikowski@kfocus.org,
 linux-kernel@vger.kernel.org, Gil Fine <gil.fine@linux.intel.com>
Subject: Re: USB-C DisplayPort display failing to stay active with Intel
 Barlow Ridge USB4 controller, power-management related issue?
Message-ID: <20241011140245.3d86e79b@kfocus.org>
In-Reply-To: <20241011163811.GU275077@black.fi.intel.com>
References: <20241009220118.70bfedd0@kf-ir16>
	<20241010044919.GD275077@black.fi.intel.com>
	<20241010232656.7fc6359e@kf-ir16>
	<20241011163811.GU275077@black.fi.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

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

Thank you so much! We have applied the patch to our kernel and are
recompiling now. I'll report back the results when testing is complete.

> Couple of notes about the dmesg you shared. They don't affect this
> issue but may cause other issues:
> 
> > [    1.382718] thunderbolt 0000:06:00.0: device links to tunneled
> > native ports are missing!  
> 
> This is means the BIOS does not implement the USB4 power contract
> which means that USB 3.x and PCIe tunnels will not work as expected
> after power transition.

Good to know, thank you.

> > [    1.416488] thunderbolt 0000:06:00.0: 0: NVM version 14.86  
> 
> This is really old firmware version. My development system for example
> has 56.x so yours might have a bunch of issues that are solved in the
> later versions.

Ah, ok. The machine used for reproducing the issue for generating the
dmesg log was *not* the same machine as the one we did our initial
testing on, though it was the exact same model. We used Windows to fully
update the firmware on the machine where we did the bulk of our
testing, and the exact same symptoms were observed with the latest
firmware. We'll try to update the firmware on any machines we use for
future log gathering.

Thanks again for your help with this!

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


