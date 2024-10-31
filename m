Return-Path: <linux-kernel+bounces-390689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 288719B7D5D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10C28B2156D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 14:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB741A0BD1;
	Thu, 31 Oct 2024 14:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b="pthlBIhC"
Received: from mail-io1-f68.google.com (mail-io1-f68.google.com [209.85.166.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7553919D07E
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 14:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730386574; cv=none; b=myu8ibj3o+G5M8t/VGDTdCSfRtHEU/Q/PAyL3GXZGq7CZwsQQ75J71NOES2wUDEzMJefkjFouX8MCrB/AVxlYyL0m4oNoPmn9EB7p0f8GU/wELVpGLQN9AVnUBMchSuZ9xqHNlHVYUWmUs2YAyH939iy2dKpfH28OLy0VFayu2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730386574; c=relaxed/simple;
	bh=AV0me7eMB8ikUoV6+OD/vtlfLb6IyJj7YD1WlZmoRJE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=snjAIX92UYcSWz2yKSh5eaK02E6H056Ypn0B7FGbK7kxXj7EBTlreYAypCBmKIysChL51tGNaLVN7PPRn6qF5ocP3XkK0ng0Zbt0MgH1TU2oEuPcFyH+5H7JvZRNSGcsCzlAlWauUSuGyYfYzGdq0N+84nGcsbKl97WZijM7ZjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org; spf=pass smtp.mailfrom=kfocus.org; dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b=pthlBIhC; arc=none smtp.client-ip=209.85.166.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kfocus.org
Received: by mail-io1-f68.google.com with SMTP id ca18e2360f4ac-83ab21c26f1so40124339f.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 07:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kfocus-org.20230601.gappssmtp.com; s=20230601; t=1730386551; x=1730991351; darn=vger.kernel.org;
        h=mime-version:organization:references:in-reply-to:message-id:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ff4G18oMH4lX5LoFl3kfzMemHNiyGm9wyZHektxMyJE=;
        b=pthlBIhC+6Jl2zGxa9rCKWw5OnaYWJag4skVIvmHunqMIkHdv1dSVHYlazOB8EFjA0
         JUsidWAf5h0M4OQTneeMUNeqxqFAqJrWY94rE9hEF48YXzx1su3qjIRw15w8R63fbOlu
         LvBywKWjZrS4qP5DaHDNE7MVlRxSbmq1bbA7653PfUl/ToO6cSlbqVcPOsiObrRp4OvB
         8KFnO015ZGsl/TZ45IimdclAghODf6YiP9L7f8RhVlHv//2hiunBC7/dBe0P73Ul9Msu
         MQmGAtoztrhq1Ar+0a6Kjpxba5Qit2S7XLKjZ3pBFRajaS6g7xejoCbrkpWzSjFfs00E
         Ay9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730386551; x=1730991351;
        h=mime-version:organization:references:in-reply-to:message-id:subject
         :cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ff4G18oMH4lX5LoFl3kfzMemHNiyGm9wyZHektxMyJE=;
        b=ZuHytNJWCqGZKvQZAxfW2XOTuMCxXgGIvssNoopRRAQv+dVcJZZjliKZsN89mg0q3b
         a7NvJgYHJ3k7vNpBhyuC4I09evqDt1hwjonRKCK2Qt9auH04lMweeYbysZPdnh+RcZgx
         QFgq2ufU9WgU51oDAI6tg4xATbT4+MGv+x8rBVLiXtUZ84Rv/qeEPivMYfKX+TCuQz4Q
         HPJlxBH0ZWkZDQYyB6QXx2l2/by8K60H+2KMDOiprjqiqf3OEN/sLIBc2RXMm/fQJggc
         1kvE2V90jwyo/43H0Ut8uow2+3t1b2uI+2GPLeUQOosMWVRYRNwlypl+Xabq0Im9nHTT
         tcRg==
X-Forwarded-Encrypted: i=1; AJvYcCVjhNYmhUlQPvLcLHy444Md8Ry8TIadCAnQ/jkSPG4Zz9LNUrmEDx1z+UdiSyAoAePbTPxSSet9OQ/17UM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/nMoFcQlxd2Bkoy0CIXF2s1A+njHgHwJL5PEKsXEVv4vJd4FC
	ojKmSMAZyh9kQtA4/MXir3vv7hIo7r3vWWT00KPHvHc0MYggJuO3EGpc/lEcJ5w=
X-Google-Smtp-Source: AGHT+IFbtXmw5F/NQPR2xoi11PU2uvr0h32yFSX60TjLEXUy9b9Na8LVfNdCenU0XpPM+ZGrgF+4dA==
X-Received: by 2002:a05:6602:2d8d:b0:83a:97e7:8bcf with SMTP id ca18e2360f4ac-83b5676f6c7mr905330039f.11.1730386551282;
        Thu, 31 Oct 2024 07:55:51 -0700 (PDT)
Received: from kf-ir16 ([2607:fb91:759:8d6:2b97:b5b9:e8e4:5a35])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4de048e3e8esm319421173.76.2024.10.31.07.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 07:55:50 -0700 (PDT)
Date: Thu, 31 Oct 2024 09:55:42 -0500
From: Aaron Rainbolt <arainbolt@kfocus.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: YehezkelShB@gmail.com, michael.jamet@intel.com,
 andreas.noever@gmail.com, linux-usb@vger.kernel.org, mmikowski@kfocus.org,
 linux-kernel@vger.kernel.org, Gil Fine <gil.fine@linux.intel.com>
Subject: Re: USB-C DisplayPort display failing to stay active with Intel
 Barlow Ridge USB4 controller, power-management related issue?
Message-ID: <20241031095542.587e8aa6@kf-ir16>
In-Reply-To: <20241024154341.GK275077@black.fi.intel.com>
References: <20241009220118.70bfedd0@kf-ir16>
	<20241010044919.GD275077@black.fi.intel.com>
	<20241010232656.7fc6359e@kf-ir16>
	<20241011163811.GU275077@black.fi.intel.com>
	<20241011183751.7d27c59c@kf-ir16>
	<20241023062737.GG275077@black.fi.intel.com>
	<20241023073931.GH275077@black.fi.intel.com>
	<20241023174413.451710ea@kf-ir16>
	<20241024154341.GK275077@black.fi.intel.com>
Organization: Kubuntu Focus
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/0APf0mG6H/xJK_aO4=o6w9b"

--MP_/0APf0mG6H/xJK_aO4=o6w9b
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thu, 24 Oct 2024 18:43:41 +0300
Mika Westerberg <mika.westerberg@linux.intel.com> wrote:

> Hi,
> 
> On Wed, Oct 23, 2024 at 05:44:13PM -0500, Aaron Rainbolt wrote:
> > Hey, thanks for taking a look! Our tester re-did the tests with
> > kernel 6.12~rc4, and reported the following results doing so, along
> > with another dmesg log. I think your question about xrandr is
> > answered in this report. The dmesg log is attached.
> > 
> > With the vanilla rc4 kernel plus your patch from earlier:
> > 
> > -----
> > 
> > 1. Start with Laptop powered-off
> > 2. Unplug all USB-C connectors.
> > 3. Boot Kubuntu 24.04 with patched kernel 6.12.0-rc4, add cmdline
> >    parameter thunderbolt.dyndbg=+p. All other optional parameters
> > were removed.
> > 4. Log in to normal SDDM to KDE 5.27.11.
> > 5. Open 'Display Settings KCM' to view display detection.
> > 6. Plug in one UBC-C connector attached to 4k display.
> >    * Note these work with Kernel 6.1 and non-Barlow Ridge systems
> > (TBT 4).
> >    * Display does not wake up.
> >    * Display never appears in 'Display Settings KCM.'
> >    * This is NOT desired behavior; display should show.
> >    * (Note: The test results I was given do not mention xrandr here,
> >      however as subsequent results mention it I believe that the
> >      monitor does *not* appear in xrandr here. I will double-check
> >      to be sure.)
> > Notes:
> > 
> > 1. With debug off, the recognition of screens is better, and
> > previously "just worked", at least for one screen.
> > 2. W11 updated works, as do kernels Kernels 6.1 and earlier.
> > 3. W11 from Q4 2022 (pre-update) and kernels 6.5+ do not. With both,
> >    the screens usually initially attach and then time out after
> > 15s.  
> 
> Yea, they work because we added Barlow Ridge support later and this
> problem is specific only on it. None of the integrated or Maple Ridge
> suffers from this "feature".
> 
> Below is an updated patch. This one checks if the DP resource is
> available before it adds it. I hope this covers the case where we get
> the hotplugs even when you have Type-C cable plugged (it should not
> happen, and does not happen on my test system but I have newer firmwre
> so could be firmware related). I wonder if you can try that one too
> with the same flow as above (up to step 6).
> 
> The checkerboard is unrelated issue so I would deal that separarely
> with the nouveau folks. The Thunderbolt/USB4 driver has no visibility
> what is going on with the redriven DP signaling except that it tries
> to keep the thing powered as long as it is needed.
> 
> diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
> index 07a66594e904..ee5c8ba75baa 100644
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
> @@ -2157,8 +2188,17 @@ static void tb_dp_resource_available(struct tb
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
> @@ -2987,6 +3027,7 @@ static int tb_start(struct tb *tb, bool reset)
>  	tb_create_usb3_tunnels(tb->root_switch);
>  	/* Add DP IN resources for the root switch */
>  	tb_add_dp_resources(tb->root_switch);
> +	tb_switch_enter_redrive(tb->root_switch);
>  	/* Make the discovered switches available to the userspace */
>  	device_for_each_child(&tb->root_switch->dev, NULL,
>  			      tb_scan_finalize_switch);
> @@ -3002,6 +3043,7 @@ static int tb_suspend_noirq(struct tb *tb)
>  
>  	tb_dbg(tb, "suspending...\n");
>  	tb_disconnect_and_release_dp(tb);
> +	tb_switch_exit_redrive(tb->root_switch);
>  	tb_switch_suspend(tb->root_switch, false);
>  	tcm->hotplug_active = false; /* signal tb_handle_hotplug to
> quit */ tb_dbg(tb, "suspend finished\n");
> @@ -3094,6 +3136,7 @@ static int tb_resume_noirq(struct tb *tb)
>  		tb_dbg(tb, "tunnels restarted, sleeping for
> 100ms\n"); msleep(100);
>  	}
> +	tb_switch_enter_redrive(tb->root_switch);
>  	 /* Allow tb_handle_hotplug to progress events */
>  	tcm->hotplug_active = true;
>  	tb_dbg(tb, "resume finished\n");
> @@ -3157,6 +3200,8 @@ static int tb_runtime_suspend(struct tb *tb)
>  	struct tb_cm *tcm = tb_priv(tb);
>  
>  	mutex_lock(&tb->lock);
> +	tb_disconnect_and_release_dp(tb);
> +	tb_switch_exit_redrive(tb->root_switch);
>  	tb_switch_suspend(tb->root_switch, true);
>  	tcm->hotplug_active = false;
>  	mutex_unlock(&tb->lock);
> @@ -3188,6 +3233,7 @@ static int tb_runtime_resume(struct tb *tb)
>  	tb_restore_children(tb->root_switch);
>  	list_for_each_entry_safe(tunnel, n, &tcm->tunnel_list, list)
>  		tb_tunnel_activate(tunnel);
> +	tb_switch_enter_redrive(tb->root_switch);
>  	tcm->hotplug_active = true;
>  	mutex_unlock(&tb->lock);
>  

Sorry for the delays, been working on testing the patch and had other
things taking priority.

I keep having to manually apply the patches you're sending "by hand" to
the latest mainline kernel because it doesn't apply cleanly. In
particular, I notice that in the very last "segment" of the patch (the
one that applies to tb_runtime_resume), the "list_for_each_entry_safe"
line shows that it's running "tb_tunnel_activate" in your tree, whereas
the upstream 6.12~rc5 code is running "tb_tunnel_restart" there. Would
it be too much of a hassle to ask for a patch that applies cleanly to
the 6.11.5 kernel? That would be very handy since that's the easiest
supported upstream kernel for us to test against, and would make sure
that we're not seeing any weird bugs as a result of kernel sources
mismatch.

I've attached the test results and dmesg logs from using the latest
patch with the 6.12~rc5 kernel. In summary, monitors aren't showing up
in xrandr when initially plugged in, but once "lspci -k" is run, they
are detected and remain powered on.

Thanks again for your help!

--MP_/0APf0mG6H/xJK_aO4=o6w9b
Content-Type: text/markdown
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename=2024-10-29_6.12.0-rc5_tbt-test-plan.md

## Test 01
01. [x] Build kernel 6.12.0-rc5 with patch included.
02. [x] Remove all DKMS modules: All Nvidia, keyboard, etc.
03. [x] Ensure no peripherals are plugged in, including USB-C.
04. [x] Boot with thunderbolt.dyndbg=+p kernel parameter only.
    - [x] Ensure dGPU is set in BIOS mux.
    - [x] Default to Nouveau display driver.
05. [x] Sign in to SDDM to KDE 5.27.11 desktop
06. [x] Record `cat /proc/cmdline` here.
    ```bash
    BOOT_IMAGE=/@boot/vmlinuz-6.12.0-rc5 root=UUID=aa8cb093-9cb3-4cc7-b44e-4bff76ca37fb ro rootflags=subvol=@ quiet cryptdevice=UUID=1a8d8cdb-8d8f-4689-b744-8f32d2067f56:luks-1a8d8cdb-8d8f-4689-b744-8f32d2067f56 root=/dev/mapper/luks-1a8d8cdb-8d8f-4689-b744-8f32d2067f56 splash thunderbolt.dyndbg=+p vt.handoff=7
    ```
07. [x] Record `lsmod |grep -i nouveau` here.
    ```bash
    lsmod |grep -i nouveau
    #> nouveau              2678784  41
    #> drm_gpuvm              36864  1 nouveau
    #> drm_exec               12288  2 drm_gpuvm,nouveau
    #> gpu_sched              49152  1 nouveau
    #> drm_ttm_helper         12288  1 nouveau
    #> ttm                    94208  2 drm_ttm_helper,nouveau
    #> drm_display_helper    225280  1 nouveau
    #> mxm_wmi                12288  1 nouveau
    #> i2c_algo_bit           16384  1 nouveau
    #> video                  69632  2 nvidia_wmi_ec_backlight,nouveau
    #> wmi                    24576  4 video,nvidia_wmi_ec_backlight,mxm_wmi,nouveau

    glxinfo |grep -i mesa
    #> GLX_INTEL_swap_event, GLX_MESA_copy_sub_buffer, GLX_OML_swap_method, client glx vendor string: Mesa Project and SGI
    #> GLX_MESA_copy_sub_buffer, GLX_MESA_gl_interop, GLX_MESA_query_renderer,
    #> GLX_MESA_swap_control, GLX_NV_float_buffer, GLX_OML_sync_control,
    #> GLX_MESA_copy_sub_buffer, GLX_MESA_gl_interop, GLX_MESA_query_renderer,
    #> GLX_MESA_swap_control, GLX_OML_sync_control, GLX_SGIS_multisample, Extended renderer info (GLX_MESA_query_renderer): Vendor: Mesa (0x10de) OpenGL vendor string: Mesa OpenGL core profile version string: 4.3 (Core Profile) Mesa 24.0.9-0ubuntu0.2
    #> GL_KHR_texture_compression_astc_sliced_3d, GL_MESA_framebuffer_flip_y,
    #> GL_MESA_pack_invert, GL_MESA_shader_integer_functions,
    #> GL_MESA_texture_signed_rgba, GL_NVX_gpu_memory_info, OpenGL version string: 4.3 (Compatibility Profile) Mesa 24.0.9-0ubuntu0.2
    #> GL_KHR_texture_compression_astc_sliced_3d, GL_MESA_framebuffer_flip_y,
    #> GL_MESA_pack_invert, GL_MESA_shader_integer_functions,
    #> GL_MESA_texture_signed_rgba, GL_MESA_window_pos, GL_NVX_gpu_memory_info, OpenGL ES profile version string: OpenGL ES 3.2 Mesa 24.0.9-0ubuntu0.2
    #> GL_KHR_texture_compression_astc_sliced_3d, GL_MESA_bgra,
    #> GL_MESA_framebuffer_flip_y, GL_MESA_sampler_objects,
    #> GL_MESA_shader_integer_functions, GL_NV_conditional_render,
    ```
08. [x] Open Displays KCM (graphical display manager)
09. [x] Run `xrandr --listmonitors` and `--listactivemonitors` and record here.
    ```bash
    xrandr --listmonitors
    #> Monitors: 1
    #>  0: +*eDP-1 2560/381x1440/214+0+0  eDP-1
    #>     xrandr --listactivemonitors
    xrandr --listactivemonitors
    #> Monitors: 1
    #>  0: +*eDP-1 2560/381x1440/214+0+0  eDP-1
    ```
10. [x] Attach USB-C 01 to 4k monitor
11. [!] Does display show in KCM?
12. [!] Run `xrandr --listmonitors` and `--listactivemonitors` and record here.
    ```bash
    xrandr --listmonitors
    #> Monitors: 1
    #>  0: +*eDP-1 2560/381x1440/214+0+0  eDP-1

    xrandr --listactivemonitors
    #> Monitors: 1
    #>  0: +*eDP-1 2560/381x1440/214+0+0  eDP-1
    ```
13. [x] Attach USB-C 02 to 4k monitor
14. [!] Does display show in KCM?
15. [!] Run `xrandr --listmonitors` and `--listactivemonitors` and record here.
    ```bash
    xrandr --listmonitors
    #> Monitors: 1
    #>  0: +*eDP-1 2560/381x1440/214+0+0  eDP-1

    xrandr --listactivemonitors
    #> Monitors: 1
    #>  0: +*eDP-1 2560/381x1440/214+0+0  eDP-1
    ```
16. [x] If no montors showed earlier, does `lscpi -k` wake them up? YES
17. [x] Do displays show in KCM? YES
18. [x] Run `xrandr --listmonitors` and `--listactivemonitors` and record here.
    ```bash
    xrandr --listmonitors
    #> Monitors: 3
    #>  0: +*eDP-1 2560/381x1440/214+1280+2160  eDP-1
    #>  1: +DP-1 3840/600x2160/340+0+0  DP-1
    #>  2: +DP-2 3840/600x2160/340+3840+0  DP-2

    xrandr --listactivemonitors
    #> Monitors: 3
    #>  0: +*eDP-1 2560/381x1440/214+1280+2160  eDP-1
    #>  1: +DP-1 3840/600x2160/340+0+0  DP-1
    #>  2: +DP-2 3840/600x2160/340+3840+0  DP-2
    ```
19. [x] Run `sudo dmesg > 2024-10-29_6.12.0-rc5_tbt-barlow-ridge-01.dmesg`.
20. [x] Report assessment: Screens look great after lspci -k and are solid.
    Hopefully, Nvidia will do better on wake.

## Test 02
01. [x] Build kernel 6.12.0-rc5 with patch included.
02. [x] Remove all DKMS modules: All Nvidia, keyboard, etc.
03. [x] Ensure no peripherals are plugged in, including USB-C.
04. [x] Boot WITHOUT thunderbolt.dyndbg=+p kernel parameter only.
    - [x] Ensure dGPU is set in BIOS mux.
    - [x] Default to Nouveau display driver.
05. [x] Sign in to SDDM to KDE 5.27.11 desktop
    ```bash
    #> BOOT_IMAGE=/@boot/vmlinuz-6.12.0-rc5 root=UUID=aa8cb093-9cb3-4cc7-b44e-4bff76ca37fb ro rootflags=subvol=@ quiet cryptdevice=UUID=1a8d8cdb-8d8f-4689-b744-8f32d2067f56:luks-1a8d8cdb-8d8f-4689-b744-8f32d2067f56 root=/dev/mapper/luks-1a8d8cdb-8d8f-4689-b744-8f32d2067f56 splash thunderbolt.dyndbg=+p vt.handoff=7
    ```
07. [x] Record `lsmod |grep -i nouveau` here.
    ```bash
    lsmod |grep -i nouveau
    #> nouveau              2678784  26
    #> drm_gpuvm              36864  1 nouveau
    #> drm_exec               12288  2 drm_gpuvm,nouveau
    #> gpu_sched              49152  1 nouveau
    #> drm_ttm_helper         12288  2 nouveau
    #> ttm                    94208  2 drm_ttm_helper,nouveau
    #> drm_display_helper    225280  1 nouveau
    #> mxm_wmi                12288  1 nouveau
    #> i2c_algo_bit           16384  1 nouveau
    #> video                  69632  2 nvidia_wmi_ec_backlight,nouveau
    #> wmi                    24576  4 video,nvidia_wmi_ec_backlight,mxm_wmi,nouveau

    glxinfo |grep -i mesa
    #> GLX_INTEL_swap_event, GLX_MESA_copy_sub_buffer, GLX_OML_swap_method, client glx vendor string: Mesa Project and SGI
    #> GLX_MESA_copy_sub_buffer, GLX_MESA_gl_interop, GLX_MESA_query_renderer,
    #> GLX_MESA_swap_control, GLX_NV_float_buffer, GLX_OML_sync_control,
    #> GLX_MESA_copy_sub_buffer, GLX_MESA_gl_interop, GLX_MESA_query_renderer,
    #> GLX_MESA_swap_control, GLX_OML_sync_control, GLX_SGIS_multisample, Extended renderer info (GLX_MESA_query_renderer):
    #> Vendor: Mesa (0x10de) OpenGL vendor string: Mesa OpenGL core profile version string: 4.3 (Core Profile) Mesa 24.0.9-0ubuntu0.2
    #> GL_KHR_texture_compression_astc_sliced_3d, GL_MESA_framebuffer_flip_y,
    #> GL_MESA_pack_invert, GL_MESA_shader_integer_functions,
    #> GL_MESA_texture_signed_rgba, GL_NVX_gpu_memory_info, OpenGL version string: 4.3 (Compatibility Profile) Mesa 24.0.9-0ubuntu0.2
    #> GL_KHR_texture_compression_astc_sliced_3d, GL_MESA_framebuffer_flip_y,
    #> GL_MESA_pack_invert, GL_MESA_shader_integer_functions,
    #> GL_MESA_texture_signed_rgba, GL_MESA_window_pos, GL_NVX_gpu_memory_info, OpenGL ES profile version string: OpenGL ES 3.2 Mesa 24.0.9-0ubuntu0.2
    #> GL_KHR_texture_compression_astc_sliced_3d, GL_MESA_bgra,
    #> GL_MESA_framebuffer_flip_y, GL_MESA_sampler_objects,
    #> GL_MESA_shader_integer_functions, GL_NV_conditional_render,
    ```
08. [x] Open Displays KCM (graphical display manager)
09. [!] Run `xrandr --listmonitors` and `--listactivemonitors` and record here.
    ```bash
    xrandr --listmonitors
    #> Monitors: 1
    #>  0: +*eDP-1 2560/381x1440/214+0+0  eDP-1

    xrandr --listactivemonitors
    #> Monitors: 1
    #>  0: +*eDP-1 2560/381x1440/214+0+0  eDP-1
    ```
10. [x] Attach USB-C 01 to 4k monitor
11. [!] Does display show in KCM?
12. [!] Run `xrandr --listmonitors` and `--listactivemonitors` and record here.
    ```bash
    xrandr --listmonitors
    #> Monitors: 1
    #>  0: +*eDP-1 2560/381x1440/214+0+0  eDP-1

    xrandr --listactivemonitors
    #> Monitors: 1
    #>  0: +*eDP-1 2560/381x1440/214+0+0  eDP-1
    ```
13. [x] Attach USB-C 02 to 4k monitor
14. [!] Does display show in KCM?
15. [!] Run `xrandr --listmonitors` and `--listactivemonitors` and record here.
    ```bash
    xrandr --listmonitors
    #> Monitors: 1
    #>  0: +*eDP-1 2560/381x1440/214+0+0  eDP-1

    xrandr --listactivemonitors
    #> Monitors: 1
    #>  0: +*eDP-1 2560/381x1440/214+0+0  eDP-1
    ```
16. [x] If no montors showed earlier, does `lscpi -k` wake them up? YES
17. [x] Do displays show in KCM? YES
18. [x] Run `xrandr --listmonitors` and `--listactivemonitors` and record here.
    ```bash
    xrandr --listmonitors
    #> Monitors: 3
    #>  0: +*eDP-1 2560/381x1440/214+1280+2160  eDP-1
    #>  1: +DP-1 3840/600x2160/340+0+0  DP-1
    #>  2: +DP-2 3840/600x2160/340+3840+0  DP-2

    xrandr --listactivemonitors
    #> Monitors: 3
    #>  0: +*eDP-1 2560/381x1440/214+1280+2160  eDP-1
    #>  1: +DP-1 3840/600x2160/340+0+0  DP-1
    #>  2: +DP-2 3840/600x2160/340+3840+0  DP-2
    ```
19. [x] Run `sudo dmesg > 2024-10-29_6.12.0-rc5_tbt-barlow-ridge-02.dmesg`.
20. [x] Report assessment: Screens look great after lspci -k and are solid.
    Hopefully, Nvidia proprietary drivers will do better on wake.

--MP_/0APf0mG6H/xJK_aO4=o6w9b
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename=2024-10-29_6.12.0-rc5_tbt-barlow-ridge-01-dmesg.txt

[    0.000000] Linux version 6.12.0-rc5 (qa@qa-m2) (gcc (Ubuntu 13.2.0-23ubuntu4) 13.2.0, GNU ld (GNU Binutils for Ubuntu) 2.42) #1 SMP PREEMPT_DYNAMIC Tue Oct 29 09:14:25 PDT 2024
[    0.000000] Command line: BOOT_IMAGE=/@boot/vmlinuz-6.12.0-rc5 root=UUID=aa8cb093-9cb3-4cc7-b44e-4bff76ca37fb ro rootflags=subvol=@ quiet cryptdevice=UUID=1a8d8cdb-8d8f-4689-b744-8f32d2067f56:luks-1a8d8cdb-8d8f-4689-b744-8f32d2067f56 root=/dev/mapper/luks-1a8d8cdb-8d8f-4689-b744-8f32d2067f56 splash thunderbolt.dyndbg=+p vt.handoff=7
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
[    0.000000] e820: update [mem 0x2b927018-0x2b94be57] usable ==> usable
[    0.000000] extended physical RAM map:
[    0.000000] reserve setup_data: [mem 0x0000000000000000-0x000000000009efff] usable
[    0.000000] reserve setup_data: [mem 0x000000000009f000-0x00000000000fffff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000000100000-0x000000002b927017] usable
[    0.000000] reserve setup_data: [mem 0x000000002b927018-0x000000002b94be57] usable
[    0.000000] reserve setup_data: [mem 0x000000002b94be58-0x0000000030228fff] usable
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
[    0.000008] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000011] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000021] last_pfn = 0x8c0000 max_arch_pfn = 0x400000000
[    0.000026] MTRR map: 5 entries (3 fixed + 2 variable; max 23), built from 10 variable MTRRs
[    0.000028] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.000759] last_pfn = 0x37b00 max_arch_pfn = 0x400000000
[    0.010767] esrt: Reserving ESRT space from 0x000000002ca20798 to 0x000000002ca20820.
[    0.010775] e820: update [mem 0x2ca20000-0x2ca20fff] usable ==> reserved
[    0.010799] Using GB pages for direct mapping
[    0.010800] Incomplete global flushes, disabling PCID
[    0.011477] Secure boot disabled
[    0.011478] RAMDISK: [mem 0x1af2b000-0x1f81cfff]
[    0.011562] ACPI: Early table checksum verification disabled
[    0.011567] ACPI: RSDP 0x0000000037AFE014 000024 (v02 INSYDE)
[    0.011573] ACPI: XSDT 0x0000000037A38188 00012C (v01 INSYDE ADL      00000002      01000013)
[    0.011582] ACPI: FACP 0x0000000037ADB000 000114 (v06 INSYDE ADL      00000002 ACPI 00040000)
[    0.011591] ACPI: DSDT 0x0000000037A4E000 089652 (v02 INSYDE ADL      00000002 ACPI 00040000)
[    0.011596] ACPI: FACS 0x000000003783E000 000040
[    0.011600] ACPI: UEFI 0x000000003798E000 0001CF (v01 INSYDE H2O BIOS 00000001 ACPI 00040000)
[    0.011604] ACPI: SSDT 0x0000000037AF3000 00908F (v02 DptfTb DptfTabl 00001000 INTL 20200717)
[    0.011608] ACPI: SSDT 0x0000000037AED000 005D34 (v02 CpuRef CpuSsdt  00003000 INTL 20200717)
[    0.011612] ACPI: SSDT 0x0000000037AEA000 00276F (v02 SaSsdt SaSsdt   00003000 INTL 20200717)
[    0.011616] ACPI: SSDT 0x0000000037AE6000 00328B (v02 INTEL  IgfxSsdt 00003000 INTL 20200717)
[    0.011620] ACPI: SSDT 0x0000000037AE5000 00077B (v02 INSYDE Tpm2Tabl 00001000 INTL 20200717)
[    0.011624] ACPI: TPM2 0x0000000037AE4000 00004C (v04 INSYDE ADL      00000002 ACPI 00040000)
[    0.011629] ACPI: SSDT 0x0000000037ADF000 003249 (v02 INTEL  DTbtSsdt 00001000 INTL 20200717)
[    0.011633] ACPI: SSDT 0x0000000037ADD000 0016A6 (v02 INSYDE UsbCTabl 00001000 INTL 20200717)
[    0.011637] ACPI: NHLT 0x0000000037ADC000 00002D (v00 INSYDE ADL      00000002 ACPI 00040000)
[    0.011640] ACPI: HPET 0x0000000037ADA000 000038 (v01 INSYDE ADL      00000002 ACPI 00040000)
[    0.011644] ACPI: APIC 0x0000000037AD9000 0001DC (v05 INSYDE ADL      00000002 ACPI 00040000)
[    0.011648] ACPI: MCFG 0x0000000037AD8000 00003C (v01 INSYDE ADL      00000002 ACPI 00040000)
[    0.011652] ACPI: SSDT 0x0000000037A48000 0054E4 (v02 INSYDE ADL      00000002      01000013)
[    0.011656] ACPI: WSMT 0x0000000037A47000 000028 (v01 INSYDE ADL      00000002 ACPI 00040000)
[    0.011660] ACPI: SSDT 0x0000000037A45000 0015FD (v02 INSYDE PtidDevc 00001000 INTL 20200717)
[    0.011665] ACPI: SSDT 0x0000000037A3B000 009573 (v02 INSYDE TbtTypeC 00000000 INTL 20200717)
[    0.011669] ACPI: DBGP 0x0000000037A3A000 000034 (v01 INSYDE ADL      00000002 ACPI 00040000)
[    0.011672] ACPI: DBG2 0x0000000037A39000 000054 (v00 INSYDE ADL      00000002 ACPI 00040000)
[    0.011675] ACPI: DMAR 0x0000000037AFD000 000050 (v01 INTEL  ICL      00000002 ACPI 00040000)
[    0.011678] ACPI: SSDT 0x0000000037A35000 002EE7 (v01 NvdRef NvdTabl  00001000 INTL 20200717)
[    0.011682] ACPI: SSDT 0x0000000037A34000 00020D (v01 NvdRef NvdDiscr 00001000 INTL 20200717)
[    0.011685] ACPI: SSDT 0x0000000037A33000 00064F (v01 NvdRef NvDisDds 00001000 INTL 20200717)
[    0.011688] ACPI: UEFI 0x000000003783B000 00063A (v01 INTEL  RstVmdE  00000000 ACPI 00040000)
[    0.011692] ACPI: UEFI 0x000000003783A000 00005C (v01 INTEL  RstVmdV  00000000 ACPI 00040000)
[    0.011695] ACPI: SSDT 0x0000000037A31000 001057 (v02 INTEL  xh_rplsb 00000000 INTL 20200717)
[    0.011698] ACPI: SSDT 0x0000000037A2D000 0039DA (v02 SocGpe SocGpe   00003000 INTL 20200717)
[    0.011702] ACPI: SSDT 0x0000000037A29000 0039DA (v02 SocCmn SocCmn   00003000 INTL 20200717)
[    0.011705] ACPI: SSDT 0x0000000037A28000 0000F8 (v02 INSYDE PcdTabl  00001000 INTL 20200717)
[    0.011708] ACPI: FPDT 0x0000000037A27000 000044 (v01 INSYDE ADL      00000002 ACPI 00040000)
[    0.011712] ACPI: PHAT 0x0000000037A25000 0005ED (v01 INSYDE ADL      00000005 ACPI 00040000)
[    0.011715] ACPI: BGRT 0x0000000037A26000 000038 (v01 INSYDE H2O BIOS 00000001 ACPI 00040000)
[    0.011718] ACPI: Reserving FACP table memory at [mem 0x37adb000-0x37adb113]
[    0.011719] ACPI: Reserving DSDT table memory at [mem 0x37a4e000-0x37ad7651]
[    0.011720] ACPI: Reserving FACS table memory at [mem 0x3783e000-0x3783e03f]
[    0.011721] ACPI: Reserving UEFI table memory at [mem 0x3798e000-0x3798e1ce]
[    0.011722] ACPI: Reserving SSDT table memory at [mem 0x37af3000-0x37afc08e]
[    0.011723] ACPI: Reserving SSDT table memory at [mem 0x37aed000-0x37af2d33]
[    0.011724] ACPI: Reserving SSDT table memory at [mem 0x37aea000-0x37aec76e]
[    0.011725] ACPI: Reserving SSDT table memory at [mem 0x37ae6000-0x37ae928a]
[    0.011726] ACPI: Reserving SSDT table memory at [mem 0x37ae5000-0x37ae577a]
[    0.011727] ACPI: Reserving TPM2 table memory at [mem 0x37ae4000-0x37ae404b]
[    0.011728] ACPI: Reserving SSDT table memory at [mem 0x37adf000-0x37ae2248]
[    0.011729] ACPI: Reserving SSDT table memory at [mem 0x37add000-0x37ade6a5]
[    0.011729] ACPI: Reserving NHLT table memory at [mem 0x37adc000-0x37adc02c]
[    0.011730] ACPI: Reserving HPET table memory at [mem 0x37ada000-0x37ada037]
[    0.011731] ACPI: Reserving APIC table memory at [mem 0x37ad9000-0x37ad91db]
[    0.011732] ACPI: Reserving MCFG table memory at [mem 0x37ad8000-0x37ad803b]
[    0.011733] ACPI: Reserving SSDT table memory at [mem 0x37a48000-0x37a4d4e3]
[    0.011734] ACPI: Reserving WSMT table memory at [mem 0x37a47000-0x37a47027]
[    0.011735] ACPI: Reserving SSDT table memory at [mem 0x37a45000-0x37a465fc]
[    0.011735] ACPI: Reserving SSDT table memory at [mem 0x37a3b000-0x37a44572]
[    0.011736] ACPI: Reserving DBGP table memory at [mem 0x37a3a000-0x37a3a033]
[    0.011737] ACPI: Reserving DBG2 table memory at [mem 0x37a39000-0x37a39053]
[    0.011738] ACPI: Reserving DMAR table memory at [mem 0x37afd000-0x37afd04f]
[    0.011739] ACPI: Reserving SSDT table memory at [mem 0x37a35000-0x37a37ee6]
[    0.011740] ACPI: Reserving SSDT table memory at [mem 0x37a34000-0x37a3420c]
[    0.011741] ACPI: Reserving SSDT table memory at [mem 0x37a33000-0x37a3364e]
[    0.011742] ACPI: Reserving UEFI table memory at [mem 0x3783b000-0x3783b639]
[    0.011742] ACPI: Reserving UEFI table memory at [mem 0x3783a000-0x3783a05b]
[    0.011743] ACPI: Reserving SSDT table memory at [mem 0x37a31000-0x37a32056]
[    0.011744] ACPI: Reserving SSDT table memory at [mem 0x37a2d000-0x37a309d9]
[    0.011745] ACPI: Reserving SSDT table memory at [mem 0x37a29000-0x37a2c9d9]
[    0.011746] ACPI: Reserving SSDT table memory at [mem 0x37a28000-0x37a280f7]
[    0.011747] ACPI: Reserving FPDT table memory at [mem 0x37a27000-0x37a27043]
[    0.011748] ACPI: Reserving PHAT table memory at [mem 0x37a25000-0x37a255ec]
[    0.011749] ACPI: Reserving BGRT table memory at [mem 0x37a26000-0x37a26037]
[    0.012004] No NUMA configuration found
[    0.012005] Faking a node at [mem 0x0000000000000000-0x00000008bfffffff]
[    0.012015] NODE_DATA(0) allocated [mem 0x8bffd5680-0x8bfffffff]
[    0.012276] Zone ranges:
[    0.012278]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.012280]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.012282]   Normal   [mem 0x0000000100000000-0x00000008bfffffff]
[    0.012283]   Device   empty
[    0.012284] Movable zone start for each node
[    0.012286] Early memory node ranges
[    0.012287]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.012289]   node   0: [mem 0x0000000000100000-0x0000000030228fff]
[    0.012290]   node   0: [mem 0x0000000030b29000-0x000000003293efff]
[    0.012291]   node   0: [mem 0x0000000037aff000-0x0000000037afffff]
[    0.012292]   node   0: [mem 0x0000000100000000-0x00000008bfffffff]
[    0.012295] Initmem setup node 0 [mem 0x0000000000001000-0x00000008bfffffff]
[    0.012302] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.012332] On node 0, zone DMA: 97 pages in unavailable ranges
[    0.013903] On node 0, zone DMA32: 2304 pages in unavailable ranges
[    0.014127] On node 0, zone DMA32: 20928 pages in unavailable ranges
[    0.056325] On node 0, zone Normal: 1280 pages in unavailable ranges
[    0.057010] ACPI: PM-Timer IO Port: 0x1808
[    0.057023] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.057026] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.057026] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.057027] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.057028] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
[    0.057029] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[    0.057029] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
[    0.057030] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
[    0.057030] ACPI: LAPIC_NMI (acpi_id[0x09] high edge lint[0x1])
[    0.057031] ACPI: LAPIC_NMI (acpi_id[0x0a] high edge lint[0x1])
[    0.057032] ACPI: LAPIC_NMI (acpi_id[0x0b] high edge lint[0x1])
[    0.057033] ACPI: LAPIC_NMI (acpi_id[0x0c] high edge lint[0x1])
[    0.057033] ACPI: LAPIC_NMI (acpi_id[0x0d] high edge lint[0x1])
[    0.057034] ACPI: LAPIC_NMI (acpi_id[0x0e] high edge lint[0x1])
[    0.057034] ACPI: LAPIC_NMI (acpi_id[0x0f] high edge lint[0x1])
[    0.057035] ACPI: LAPIC_NMI (acpi_id[0x10] high edge lint[0x1])
[    0.057036] ACPI: LAPIC_NMI (acpi_id[0x11] high edge lint[0x1])
[    0.057037] ACPI: LAPIC_NMI (acpi_id[0x12] high edge lint[0x1])
[    0.057037] ACPI: LAPIC_NMI (acpi_id[0x13] high edge lint[0x1])
[    0.057038] ACPI: LAPIC_NMI (acpi_id[0x14] high edge lint[0x1])
[    0.057039] ACPI: LAPIC_NMI (acpi_id[0x15] high edge lint[0x1])
[    0.057039] ACPI: LAPIC_NMI (acpi_id[0x16] high edge lint[0x1])
[    0.057040] ACPI: LAPIC_NMI (acpi_id[0x17] high edge lint[0x1])
[    0.057041] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.057081] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-119
[    0.057089] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.057091] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.057096] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.057097] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.057107] e820: update [mem 0x2b43a000-0x2b4f4fff] usable ==> reserved
[    0.057122] TSC deadline timer available
[    0.057125] CPU topo: Max. logical packages:   1
[    0.057126] CPU topo: Max. logical dies:       1
[    0.057126] CPU topo: Max. dies per package:   1
[    0.057129] CPU topo: Max. threads per core:   2
[    0.057130] CPU topo: Num. cores per package:    24
[    0.057131] CPU topo: Num. threads per package:  32
[    0.057132] CPU topo: Allowing 32 present CPUs plus 0 hotplug CPUs
[    0.057149] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.057151] PM: hibernation: Registered nosave memory: [mem 0x0009f000-0x000fffff]
[    0.057153] PM: hibernation: Registered nosave memory: [mem 0x2b43a000-0x2b4f4fff]
[    0.057154] PM: hibernation: Registered nosave memory: [mem 0x2b927000-0x2b927fff]
[    0.057156] PM: hibernation: Registered nosave memory: [mem 0x2b94b000-0x2b94bfff]
[    0.057157] PM: hibernation: Registered nosave memory: [mem 0x2ca20000-0x2ca20fff]
[    0.057159] PM: hibernation: Registered nosave memory: [mem 0x30229000-0x30b28fff]
[    0.057160] PM: hibernation: Registered nosave memory: [mem 0x3293f000-0x349defff]
[    0.057161] PM: hibernation: Registered nosave memory: [mem 0x349df000-0x3798efff]
[    0.057162] PM: hibernation: Registered nosave memory: [mem 0x3798f000-0x37afefff]
[    0.057163] PM: hibernation: Registered nosave memory: [mem 0x37b00000-0x3bffffff]
[    0.057164] PM: hibernation: Registered nosave memory: [mem 0x3c000000-0x3c7fffff]
[    0.057165] PM: hibernation: Registered nosave memory: [mem 0x3c800000-0x3cbfffff]
[    0.057165] PM: hibernation: Registered nosave memory: [mem 0x3cc00000-0x3cdfffff]
[    0.057166] PM: hibernation: Registered nosave memory: [mem 0x3ce00000-0x3fffffff]
[    0.057167] PM: hibernation: Registered nosave memory: [mem 0x40000000-0xfed1ffff]
[    0.057167] PM: hibernation: Registered nosave memory: [mem 0xfed20000-0xfed7ffff]
[    0.057168] PM: hibernation: Registered nosave memory: [mem 0xfed80000-0xffffffff]
[    0.057170] [mem 0x40000000-0xfed1ffff] available for PCI devices
[    0.057171] Booting paravirtualized kernel on bare hardware
[    0.057174] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.057189] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:32 nr_cpu_ids:32 nr_node_ids:1
[    0.059000] percpu: Embedded 88 pages/cpu s237568 r8192 d114688 u524288
[    0.059006] pcpu-alloc: s237568 r8192 d114688 u524288 alloc=1*2097152
[    0.059008] pcpu-alloc: [0] 00 01 02 03 [0] 04 05 06 07 
[    0.059013] pcpu-alloc: [0] 08 09 10 11 [0] 12 13 14 15 
[    0.059017] pcpu-alloc: [0] 16 17 18 19 [0] 20 21 22 23 
[    0.059021] pcpu-alloc: [0] 24 25 26 27 [0] 28 29 30 31 
[    0.059052] Kernel command line: BOOT_IMAGE=/@boot/vmlinuz-6.12.0-rc5 root=UUID=aa8cb093-9cb3-4cc7-b44e-4bff76ca37fb ro rootflags=subvol=@ quiet cryptdevice=UUID=1a8d8cdb-8d8f-4689-b744-8f32d2067f56:luks-1a8d8cdb-8d8f-4689-b744-8f32d2067f56 root=/dev/mapper/luks-1a8d8cdb-8d8f-4689-b744-8f32d2067f56 splash thunderbolt.dyndbg=+p vt.handoff=7
[    0.059153] Unknown kernel command line parameters "splash BOOT_IMAGE=/@boot/vmlinuz-6.12.0-rc5 cryptdevice=UUID=1a8d8cdb-8d8f-4689-b744-8f32d2067f56:luks-1a8d8cdb-8d8f-4689-b744-8f32d2067f56", will be passed to user space.
[    0.061757] Dentry cache hash table entries: 4194304 (order: 13, 33554432 bytes, linear)
[    0.063059] Inode-cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
[    0.063481] Fallback order for Node 0: 0 
[    0.063486] Built 1 zonelists, mobility grouping on.  Total pages: 8331230
[    0.063487] Policy zone: Normal
[    0.063494] mem auto-init: stack:all(zero), heap alloc:on, heap free:off
[    0.063502] software IO TLB: area num 32.
[    0.134507] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=32, Nodes=1
[    0.134587] ftrace: allocating 56189 entries in 220 pages
[    0.144543] ftrace: allocated 220 pages with 5 groups
[    0.145366] Dynamic Preempt: voluntary
[    0.145554] rcu: Preemptible hierarchical RCU implementation.
[    0.145555] rcu: 	RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=32.
[    0.145557] 	Trampoline variant of Tasks RCU enabled.
[    0.145557] 	Rude variant of Tasks RCU enabled.
[    0.145558] 	Tracing variant of Tasks RCU enabled.
[    0.145558] rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
[    0.145559] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=32
[    0.145581] RCU Tasks: Setting shift to 5 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=32.
[    0.145585] RCU Tasks Rude: Setting shift to 5 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=32.
[    0.145587] RCU Tasks Trace: Setting shift to 5 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=32.
[    0.148597] NR_IRQS: 524544, nr_irqs: 2312, preallocated irqs: 16
[    0.148954] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.149224] Console: colour dummy device 80x25
[    0.149227] printk: legacy console [tty0] enabled
[    0.149292] ACPI: Core revision 20240827
[    0.149782] hpet: HPET dysfunctional in PC10. Force disabled.
[    0.149837] APIC: Switch to symmetric I/O mode setup
[    0.149839] DMAR: Host address width 39
[    0.149840] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
[    0.149849] DMAR: dmar0: reg_base_addr fed91000 ver 5:0 cap d2008c40660462 ecap f050da
[    0.149853] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 0
[    0.149855] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
[    0.149856] DMAR-IR: Queued invalidation will be enabled to support x2apic and Intr-remapping.
[    0.151575] DMAR-IR: Enabled IRQ remapping in x2apic mode
[    0.151577] x2apic enabled
[    0.151648] APIC: Switched APIC routing to: cluster x2apic
[    0.156582] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x22df1149949, max_idle_ns: 440795312789 ns
[    0.156590] Calibrating delay loop (skipped), value calculated using timer frequency.. 4838.40 BogoMIPS (lpj=2419200)
[    0.156660] CPU0: Thermal monitoring enabled (TM1)
[    0.156662] x86/cpu: User Mode Instruction Prevention (UMIP) activated
[    0.156818] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[    0.156820] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[    0.156823] process: using mwait in idle threads
[    0.156826] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.156829] Spectre V2 : Mitigation: Enhanced / Automatic IBRS
[    0.156831] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.156832] Spectre V2 : Spectre v2 / PBRSB-eIBRS: Retire a single CALL on VMEXIT
[    0.156834] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
[    0.156836] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
[    0.156837] Register File Data Sampling: Mitigation: Clear Register File
[    0.156849] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.156850] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.156852] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.156853] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys User registers'
[    0.156854] x86/fpu: Supporting XSAVE feature 0x800: 'Control-flow User registers'
[    0.156855] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.156857] x86/fpu: xstate_offset[9]:  832, xstate_sizes[9]:    8
[    0.156858] x86/fpu: xstate_offset[11]:  840, xstate_sizes[11]:   16
[    0.156859] x86/fpu: Enabled xstate features 0xa07, context size is 856 bytes, using 'compacted' format.
[    0.157587] Freeing SMP alternatives memory: 48K
[    0.157587] pid_max: default: 32768 minimum: 301
[    0.157587] LSM: initializing lsm=lockdown,capability,landlock,yama,apparmor,ima,evm
[    0.157587] landlock: Up and running.
[    0.157587] Yama: becoming mindful.
[    0.157587] AppArmor: AppArmor initialized
[    0.157587] Mount-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.157587] Mountpoint-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.157587] smpboot: CPU0: Intel(R) Core(TM) i9-14900HX (family: 0x6, model: 0xb7, stepping: 0x1)
[    0.157587] Performance Events: XSAVE Architectural LBR, PEBS fmt4+-baseline,  AnyThread deprecated, Alderlake Hybrid events, 32-deep LBR, full-width counters, Intel PMU driver.
[    0.157587] core: cpu_core PMU driver: 
[    0.157587] ... version:                5
[    0.157587] ... bit width:              48
[    0.157587] ... generic registers:      8
[    0.157587] ... value mask:             0000ffffffffffff
[    0.157587] ... max period:             00007fffffffffff
[    0.157587] ... fixed-purpose events:   4
[    0.157587] ... event mask:             0001000f000000ff
[    0.157587] signal: max sigframe size: 3632
[    0.157587] Estimated ratio of average max frequency by base frequency (times 1024): 2218
[    0.157587] rcu: Hierarchical SRCU implementation.
[    0.157587] rcu: 	Max phase no-delay instances is 400.
[    0.157587] Timer migration: 2 hierarchy levels; 8 children per group; 2 crossnode level
[    0.159423] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    0.160602] smp: Bringing up secondary CPUs ...
[    0.160748] smpboot: x86: Booting SMP configuration:
[    0.160750] .... node  #0, CPUs:        #2  #4  #6  #8 #10 #12 #14 #16 #17 #18 #19 #20 #21 #22 #23 #24 #25 #26 #27 #28 #29 #30 #31
[    0.008452] core: cpu_atom PMU driver: PEBS-via-PT 
[    0.008452] ... version:                5
[    0.008452] ... bit width:              48
[    0.008452] ... generic registers:      6
[    0.008452] ... value mask:             0000ffffffffffff
[    0.008452] ... max period:             00007fffffffffff
[    0.008452] ... fixed-purpose events:   3
[    0.008452] ... event mask:             000000070000003f
[    0.197616]   #1  #3  #5  #7  #9 #11 #13 #15
[    0.206680] smp: Brought up 1 node, 32 CPUs
[    0.206680] smpboot: Total of 32 processors activated (154828.80 BogoMIPS)
[    0.207957] Memory: 32501920K/33324920K available (22528K kernel code, 4585K rwdata, 14292K rodata, 5064K init, 4492K bss, 776924K reserved, 0K cma-reserved)
[    0.209075] devtmpfs: initialized
[    0.209075] x86/mm: Memory block size: 128MB
[    0.212416] ACPI: PM: Registering ACPI NVS region [mem 0x349df000-0x3798efff] (50003968 bytes)
[    0.212961] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.213011] futex hash table entries: 8192 (order: 7, 524288 bytes, linear)
[    0.213133] pinctrl core: initialized pinctrl subsystem
[    0.213384] PM: RTC time: 20:08:48, date: 2024-10-29
[    0.213930] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.214463] DMA: preallocated 4096 KiB GFP_KERNEL pool for atomic allocations
[    0.214822] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[    0.215183] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[    0.215193] audit: initializing netlink subsys (disabled)
[    0.215214] audit: type=2000 audit(1730232528.058:1): state=initialized audit_enabled=0 res=1
[    0.215214] thermal_sys: Registered thermal governor 'fair_share'
[    0.215214] thermal_sys: Registered thermal governor 'bang_bang'
[    0.215214] thermal_sys: Registered thermal governor 'step_wise'
[    0.215214] thermal_sys: Registered thermal governor 'user_space'
[    0.215214] thermal_sys: Registered thermal governor 'power_allocator'
[    0.215214] EISA bus registered
[    0.215214] cpuidle: using governor ladder
[    0.215214] cpuidle: using governor menu
[    0.215621] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.215753] PCI: ECAM [mem 0xc0000000-0xce0fffff] (base 0xc0000000) for domain 0000 [bus 00-e0]
[    0.215769] PCI: Using configuration type 1 for base access
[    0.215947] kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
[    0.219674] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    0.219674] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
[    0.219674] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.219674] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.220788] ACPI: Added _OSI(Module Device)
[    0.220790] ACPI: Added _OSI(Processor Device)
[    0.220792] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.220793] ACPI: Added _OSI(Processor Aggregator Device)
[    0.363461] ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PC00.MHBR], AE_NOT_FOUND (20240827/psargs-332)
[    0.363478] ACPI: Ignoring error and continuing table load
[    0.363502] ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PTID.PBAR], AE_NOT_FOUND (20240827/dsfield-500)
[    0.371587] ACPI: 18 ACPI AML tables successfully acquired and loaded
[    0.391461] ACPI: USB4 _OSC: OS supports USB3+ DisplayPort+ PCIe+ XDomain+
[    0.391464] ACPI: USB4 _OSC: OS controls USB3+ DisplayPort+ PCIe+ XDomain+
[    0.393367] ACPI: Dynamic OEM Table Load:
[    0.393381] ACPI: SSDT 0xFFFF8F99841A7800 000394 (v02 PmRef  Cpu0Cst  00003001 INTL 20200717)
[    0.395249] ACPI: Dynamic OEM Table Load:
[    0.395258] ACPI: SSDT 0xFFFF8F99841DB800 00053F (v02 PmRef  Cpu0Ist  00003000 INTL 20200717)
[    0.397166] ACPI: Dynamic OEM Table Load:
[    0.397173] ACPI: SSDT 0xFFFF8F9984160000 0001AB (v02 PmRef  Cpu0Psd  00003000 INTL 20200717)
[    0.398967] ACPI: Dynamic OEM Table Load:
[    0.398974] ACPI: SSDT 0xFFFF8F99841D9000 0004B5 (v02 PmRef  Cpu0Hwp  00003000 INTL 20200717)
[    0.401383] ACPI: Dynamic OEM Table Load:
[    0.401403] ACPI: SSDT 0xFFFF8F99841E4000 001BAF (v02 PmRef  ApIst    00003000 INTL 20200717)
[    0.404215] ACPI: Dynamic OEM Table Load:
[    0.404223] ACPI: SSDT 0xFFFF8F99841E6000 001038 (v02 PmRef  ApHwp    00003000 INTL 20200717)
[    0.406738] ACPI: Dynamic OEM Table Load:
[    0.406747] ACPI: SSDT 0xFFFF8F99841E0000 001349 (v02 PmRef  ApPsd    00003000 INTL 20200717)
[    0.409297] ACPI: Dynamic OEM Table Load:
[    0.409306] ACPI: SSDT 0xFFFF8F99841F1000 000FBB (v02 PmRef  ApCst    00003000 INTL 20200717)
[    0.428689] ACPI: EC: EC started
[    0.428691] ACPI: EC: interrupt blocked
[    0.446056] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.446059] ACPI: \_SB_.PC00.LPCB.EC__: Boot DSDT EC used to handle transactions
[    0.446061] ACPI: Interpreter enabled
[    0.446151] ACPI: PM: (supports S0 S3 S4 S5)
[    0.446152] ACPI: Using IOAPIC for interrupt routing
[    0.448550] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.448552] PCI: Ignoring E820 reservations for host bridge windows
[    0.450408] ACPI: Enabled 11 GPEs in block 00 to 7F
[    0.452885] ACPI: \_SB_.PC00.PEG2.PG00: New power resource
[    0.483842] ACPI: \_SB_.PC00.XHCI.RHUB.HS14.BTRT: New power resource
[    0.483868] ACPI: \_SB_.PC00.XHCI.RHUB.HS14.DBTR: New power resource
[    0.494338] ACPI: \_SB_.PC00.CNVW.WRST: New power resource
[    0.500092] ACPI: \_SB_.PC00.RP09.PXP_: New power resource
[    0.526944] ACPI: \PIN_: New power resource
[    0.527840] ACPI: PCI Root Bridge [PC00] (domain 0000 [bus 00-e0])
[    0.527850] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
[    0.531696] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotplug PME AER PCIeCapability LTR DPC]
[    0.537785] PCI host bridge to bus 0000:00
[    0.537789] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.537792] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.537793] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.537795] pci_bus 0000:00: root bus resource [mem 0x40000000-0xbfffffff window]
[    0.537797] pci_bus 0000:00: root bus resource [mem 0x4000000000-0x7fffffffff window]
[    0.537799] pci_bus 0000:00: root bus resource [bus 00-e0]
[    0.537846] pci 0000:00:00.0: [8086:a702] type 00 class 0x060000 conventional PCI endpoint
[    0.537998] pci 0000:00:01.0: [8086:a70d] type 01 class 0x060400 PCIe Root Port
[    0.538015] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.538078] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    0.538104] pci 0000:00:01.0: PTM enabled (root), 4ns granularity
[    0.538910] pci 0000:00:01.1: [8086:a72d] type 01 class 0x060400 PCIe Root Port
[    0.538927] pci 0000:00:01.1: PCI bridge to [bus 02]
[    0.538931] pci 0000:00:01.1:   bridge window [io  0x3000-0x3fff]
[    0.538933] pci 0000:00:01.1:   bridge window [mem 0x4a000000-0x4b0fffff]
[    0.538940] pci 0000:00:01.1:   bridge window [mem 0x4000000000-0x4401ffffff 64bit pref]
[    0.538992] pci 0000:00:01.1: PME# supported from D0 D3hot D3cold
[    0.539016] pci 0000:00:01.1: PTM enabled (root), 4ns granularity
[    0.539797] pci 0000:00:04.0: [8086:a71d] type 00 class 0x118000 conventional PCI endpoint
[    0.539815] pci 0000:00:04.0: BAR 0 [mem 0x4404200000-0x440421ffff 64bit]
[    0.540183] pci 0000:00:08.0: [8086:a74f] type 00 class 0x088000 conventional PCI endpoint
[    0.540195] pci 0000:00:08.0: BAR 0 [mem 0x4404241000-0x4404241fff 64bit]
[    0.540309] pci 0000:00:0a.0: [8086:a77d] type 00 class 0x118000 PCIe Root Complex Integrated Endpoint
[    0.540318] pci 0000:00:0a.0: BAR 0 [mem 0x4404220000-0x4404227fff 64bit]
[    0.540338] pci 0000:00:0a.0: enabling Extended Tags
[    0.540450] pci 0000:00:0e.0: [8086:a77f] type 00 class 0x010400 PCIe Root Complex Integrated Endpoint
[    0.540465] pci 0000:00:0e.0: BAR 0 [mem 0x4402000000-0x4403ffffff 64bit]
[    0.540472] pci 0000:00:0e.0: BAR 2 [mem 0x48000000-0x49ffffff]
[    0.540488] pci 0000:00:0e.0: BAR 4 [mem 0x4404100000-0x44041fffff 64bit]
[    0.540823] pci 0000:00:14.0: [8086:7a60] type 00 class 0x0c0330 conventional PCI endpoint
[    0.540844] pci 0000:00:14.0: BAR 0 [mem 0x4b380000-0x4b38ffff 64bit]
[    0.540928] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.541545] pci 0000:00:14.2: [8086:7a27] type 00 class 0x050000 conventional PCI endpoint
[    0.541570] pci 0000:00:14.2: BAR 0 [mem 0x4404238000-0x440423bfff 64bit]
[    0.541587] pci 0000:00:14.2: BAR 2 [mem 0x4404240000-0x4404240fff 64bit]
[    0.541746] pci 0000:00:14.3: [8086:7a70] type 00 class 0x028000 PCIe Root Complex Integrated Endpoint
[    0.541793] pci 0000:00:14.3: BAR 0 [mem 0x4404234000-0x4404237fff 64bit]
[    0.541961] pci 0000:00:14.3: PME# supported from D0 D3hot D3cold
[    0.542386] pci 0000:00:15.0: [8086:7a4c] type 00 class 0x0c8000 conventional PCI endpoint
[    0.542454] pci 0000:00:15.0: BAR 0 [mem 0x00000000-0x00000fff 64bit]
[    0.543066] pci 0000:00:15.1: [8086:7a4d] type 00 class 0x0c8000 conventional PCI endpoint
[    0.543141] pci 0000:00:15.1: BAR 0 [mem 0x00000000-0x00000fff 64bit]
[    0.543646] pci 0000:00:16.0: [8086:7a68] type 00 class 0x078000 conventional PCI endpoint
[    0.543669] pci 0000:00:16.0: BAR 0 [mem 0x440423d000-0x440423dfff 64bit]
[    0.543754] pci 0000:00:16.0: PME# supported from D3hot
[    0.544338] pci 0000:00:1c.0: [8086:7a3e] type 01 class 0x060400 PCIe Root Port
[    0.544371] pci 0000:00:1c.0: PCI bridge to [bus 03]
[    0.544378] pci 0000:00:1c.0:   bridge window [mem 0x4b100000-0x4b2fffff]
[    0.544475] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.544516] pci 0000:00:1c.0: PTM enabled (root), 4ns granularity
[    0.545406] pci 0000:00:1d.0: [8086:7a30] type 01 class 0x060400 PCIe Root Port
[    0.545438] pci 0000:00:1d.0: PCI bridge to [bus 04-54]
[    0.545445] pci 0000:00:1d.0:   bridge window [mem 0x40000000-0x47ffffff]
[    0.545455] pci 0000:00:1d.0:   bridge window [mem 0x4410000000-0x54100fffff 64bit pref]
[    0.545601] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    0.546521] pci 0000:00:1f.0: [8086:7a0c] type 00 class 0x060100 conventional PCI endpoint
[    0.546962] pci 0000:00:1f.3: [8086:7a50] type 00 class 0x040300 conventional PCI endpoint
[    0.547006] pci 0000:00:1f.3: BAR 0 [mem 0x4404230000-0x4404233fff 64bit]
[    0.547061] pci 0000:00:1f.3: BAR 4 [mem 0x4404000000-0x44040fffff 64bit]
[    0.547169] pci 0000:00:1f.3: PME# supported from D3hot D3cold
[    0.547284] pci 0000:00:1f.4: [8086:7a23] type 00 class 0x0c0500 conventional PCI endpoint
[    0.547311] pci 0000:00:1f.4: BAR 0 [mem 0x440423c000-0x440423c0ff 64bit]
[    0.547342] pci 0000:00:1f.4: BAR 4 [io  0xefa0-0xefbf]
[    0.547665] pci 0000:00:1f.5: [8086:7a24] type 00 class 0x0c8000 conventional PCI endpoint
[    0.547686] pci 0000:00:1f.5: BAR 0 [mem 0xfe010000-0xfe010fff]
[    0.547839] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.547903] pci 0000:02:00.0: [10de:27e0] type 00 class 0x030000 PCIe Legacy Endpoint
[    0.547920] pci 0000:02:00.0: BAR 0 [mem 0x4a000000-0x4affffff]
[    0.547934] pci 0000:02:00.0: BAR 1 [mem 0x4000000000-0x43ffffffff 64bit pref]
[    0.547947] pci 0000:02:00.0: BAR 3 [mem 0x4400000000-0x4401ffffff 64bit pref]
[    0.547956] pci 0000:02:00.0: BAR 5 [io  0x3000-0x307f]
[    0.547966] pci 0000:02:00.0: ROM [mem 0xfff80000-0xffffffff pref]
[    0.548054] pci 0000:02:00.0: PME# supported from D0 D3hot
[    0.548178] pci 0000:02:00.0: 16.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s PCIe x8 link at 0000:00:01.1 (capable of 252.048 Gb/s with 16.0 GT/s PCIe x16 link)
[    0.548498] pci 0000:02:00.1: [10de:22bc] type 00 class 0x040300 PCIe Endpoint
[    0.548513] pci 0000:02:00.1: BAR 0 [mem 0x4b000000-0x4b003fff]
[    0.548705] pci 0000:00:01.1: PCI bridge to [bus 02]
[    0.548844] pci 0000:03:00.0: [8086:3102] type 00 class 0x020000 PCIe Endpoint
[    0.548869] pci 0000:03:00.0: BAR 0 [mem 0x4b100000-0x4b1fffff]
[    0.548908] pci 0000:03:00.0: BAR 3 [mem 0x4b200000-0x4b203fff]
[    0.549069] pci 0000:03:00.0: PME# supported from D0 D3hot D3cold
[    0.549379] pci 0000:00:1c.0: PCI bridge to [bus 03]
[    0.549488] pci 0000:04:00.0: [8086:5780] type 01 class 0x060400 PCIe Switch Upstream Port
[    0.549529] pci 0000:04:00.0: PCI bridge to [bus 05-54]
[    0.549541] pci 0000:04:00.0:   bridge window [mem 0x40000000-0x47efffff]
[    0.549555] pci 0000:04:00.0:   bridge window [mem 0x4410000000-0x54100fffff 64bit pref]
[    0.549572] pci 0000:04:00.0: enabling Extended Tags
[    0.549711] pci 0000:04:00.0: supports D1 D2
[    0.549713] pci 0000:04:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.550124] pci 0000:00:1d.0: PCI bridge to [bus 04-54]
[    0.550252] pci 0000:05:00.0: [8086:5780] type 01 class 0x060400 PCIe Switch Downstream Port
[    0.550293] pci 0000:05:00.0: PCI bridge to [bus 06]
[    0.550317] pci 0000:05:00.0:   bridge window [mem 0x5410000000-0x54100fffff 64bit pref]
[    0.550336] pci 0000:05:00.0: enabling Extended Tags
[    0.550466] pci 0000:05:00.0: supports D1 D2
[    0.550467] pci 0000:05:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.550797] pci 0000:05:01.0: [8086:5780] type 01 class 0x060400 PCIe Switch Downstream Port
[    0.550838] pci 0000:05:01.0: PCI bridge to [bus 07-2c]
[    0.550850] pci 0000:05:01.0:   bridge window [mem 0x44000000-0x47efffff]
[    0.550881] pci 0000:05:01.0: enabling Extended Tags
[    0.551020] pci 0000:05:01.0: supports D1 D2
[    0.551021] pci 0000:05:01.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.551345] pci 0000:05:02.0: [8086:5780] type 01 class 0x060400 PCIe Switch Downstream Port
[    0.551386] pci 0000:05:02.0: PCI bridge to [bus 2d]
[    0.551398] pci 0000:05:02.0:   bridge window [mem 0x43f00000-0x43ffffff]
[    0.551428] pci 0000:05:02.0: enabling Extended Tags
[    0.551559] pci 0000:05:02.0: supports D1 D2
[    0.551560] pci 0000:05:02.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.551883] pci 0000:05:03.0: [8086:5780] type 01 class 0x060400 PCIe Switch Downstream Port
[    0.551925] pci 0000:05:03.0: PCI bridge to [bus 2e-54]
[    0.551936] pci 0000:05:03.0:   bridge window [mem 0x40000000-0x43efffff]
[    0.551967] pci 0000:05:03.0: enabling Extended Tags
[    0.552106] pci 0000:05:03.0: supports D1 D2
[    0.552107] pci 0000:05:03.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.552438] pci 0000:04:00.0: PCI bridge to [bus 05-54]
[    0.552548] pci 0000:06:00.0: [8086:5781] type 00 class 0x0c0340 PCIe Endpoint
[    0.552576] pci 0000:06:00.0: BAR 0 [mem 0x5410000000-0x541003ffff 64bit pref]
[    0.552594] pci 0000:06:00.0: BAR 2 [mem 0x5410040000-0x5410040fff 64bit pref]
[    0.552636] pci 0000:06:00.0: enabling Extended Tags
[    0.552754] pci 0000:06:00.0: supports D1 D2
[    0.552755] pci 0000:06:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.553033] pci 0000:05:00.0: PCI bridge to [bus 06]
[    0.553108] pci 0000:05:01.0: PCI bridge to [bus 07-2c]
[    0.553216] pci 0000:2d:00.0: [8086:5782] type 00 class 0x0c0330 PCIe Endpoint
[    0.553240] pci 0000:2d:00.0: BAR 0 [mem 0x43f00000-0x43f0ffff 64bit]
[    0.553289] pci 0000:2d:00.0: enabling Extended Tags
[    0.553374] pci 0000:2d:00.0: PME# supported from D3hot D3cold
[    0.553413] pci 0000:2d:00.0: 8.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:05:02.0 (capable of 31.504 Gb/s with 8.0 GT/s PCIe x4 link)
[    0.553562] pci 0000:05:02.0: PCI bridge to [bus 2d]
[    0.553636] pci 0000:05:03.0: PCI bridge to [bus 2e-54]
[    0.578223] ACPI: EC: interrupt unblocked
[    0.578225] ACPI: EC: event unblocked
[    0.578240] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.578241] ACPI: EC: GPE=0x6e
[    0.578243] ACPI: \_SB_.PC00.LPCB.EC__: Boot DSDT EC initialization complete
[    0.578245] ACPI: \_SB_.PC00.LPCB.EC__: EC: Used to handle transactions and events
[    0.578663] iommu: Default domain type: Translated
[    0.578663] iommu: DMA domain TLB invalidation policy: lazy mode
[    0.578714] SCSI subsystem initialized
[    0.578731] libata version 3.00 loaded.
[    0.578731] ACPI: bus type USB registered
[    0.578731] usbcore: registered new interface driver usbfs
[    0.578731] usbcore: registered new interface driver hub
[    0.578731] usbcore: registered new device driver usb
[    0.578731] pps_core: LinuxPPS API ver. 1 registered
[    0.578731] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.578731] PTP clock support registered
[    0.578731] EDAC MC: Ver: 3.0.0
[    0.580259] efivars: Registered efivars operations
[    0.580259] NetLabel: Initializing
[    0.580259] NetLabel:  domain hash size = 128
[    0.580259] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.580259] NetLabel:  unlabeled traffic allowed by default
[    0.580603] mctp: management component transport protocol core
[    0.580603] NET: Registered PF_MCTP protocol family
[    0.580603] PCI: Using ACPI for IRQ routing
[    0.596463] PCI: pci_cache_line_size set to 64 bytes
[    0.596611] pci 0000:00:1f.5: BAR 0 [mem 0xfe010000-0xfe010fff]: can't claim; no compatible bridge window
[    0.596757] e820: reserve RAM buffer [mem 0x0009f000-0x0009ffff]
[    0.596760] e820: reserve RAM buffer [mem 0x2b43a000-0x2bffffff]
[    0.596761] e820: reserve RAM buffer [mem 0x2b927018-0x2bffffff]
[    0.596763] e820: reserve RAM buffer [mem 0x2ca20000-0x2fffffff]
[    0.596764] e820: reserve RAM buffer [mem 0x30229000-0x33ffffff]
[    0.596765] e820: reserve RAM buffer [mem 0x3293f000-0x33ffffff]
[    0.596766] e820: reserve RAM buffer [mem 0x37b00000-0x37ffffff]
[    0.596801] pci 0000:02:00.0: vgaarb: setting as boot VGA device
[    0.596801] pci 0000:02:00.0: vgaarb: bridge control possible
[    0.596801] pci 0000:02:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
[    0.596801] vgaarb: loaded
[    0.596801] clocksource: Switched to clocksource tsc-early
[    0.597236] VFS: Disk quotas dquot_6.6.0
[    0.597250] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.597389] AppArmor: AppArmor Filesystem Enabled
[    0.597427] pnp: PnP ACPI init
[    0.597729] pnp 00:00: disabling [io  0x3322-0x3323] because it overlaps 0000:00:01.1 BAR 13 [io  0x3000-0x3fff]
[    0.597953] system 00:02: [io  0x1854-0x1857] has been reserved
[    0.616252] system 00:05: [mem 0xfedc0000-0xfedc7fff] has been reserved
[    0.616256] system 00:05: [mem 0xfeda0000-0xfeda0fff] has been reserved
[    0.616258] system 00:05: [mem 0xfeda1000-0xfeda1fff] has been reserved
[    0.616260] system 00:05: [mem 0xc0000000-0xcfffffff] has been reserved
[    0.616263] system 00:05: [mem 0xfed20000-0xfed7ffff] could not be reserved
[    0.616265] system 00:05: [mem 0xfed90000-0xfed93fff] could not be reserved
[    0.616267] system 00:05: [mem 0xfed45000-0xfed8ffff] could not be reserved
[    0.616269] system 00:05: [mem 0xfee00000-0xfeefffff] has been reserved
[    0.616741] system 00:06: [io  0x2000-0x20fe] has been reserved
[    0.618202] pnp: PnP ACPI: found 8 devices
[    0.624578] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.624669] NET: Registered PF_INET protocol family
[    0.625160] IP idents hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.644629] tcp_listen_portaddr_hash hash table entries: 16384 (order: 6, 262144 bytes, linear)
[    0.644673] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    0.644928] TCP established hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.645483] TCP bind hash table entries: 65536 (order: 9, 2097152 bytes, linear)
[    0.645616] TCP: Hash tables configured (established 262144 bind 65536)
[    0.645880] MPTCP token hash table entries: 32768 (order: 7, 786432 bytes, linear)
[    0.645969] UDP hash table entries: 16384 (order: 7, 524288 bytes, linear)
[    0.646097] UDP-Lite hash table entries: 16384 (order: 7, 524288 bytes, linear)
[    0.646215] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.646223] NET: Registered PF_XDP protocol family
[    0.646226] pci 0000:02:00.0: ROM [mem 0xfff80000-0xffffffff pref]: can't claim; no compatible bridge window
[    0.646236] pci 0000:05:01.0: bridge window [io  0x1000-0x0fff] to [bus 07-2c] add_size 1000
[    0.646240] pci 0000:05:01.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 07-2c] add_size 200000 add_align 100000
[    0.646243] pci 0000:05:03.0: bridge window [io  0x1000-0x0fff] to [bus 2e-54] add_size 1000
[    0.646245] pci 0000:05:03.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 2e-54] add_size 200000 add_align 100000
[    0.646248] pci 0000:04:00.0: bridge window [io  0x1000-0x0fff] to [bus 05-54] add_size 2000
[    0.646251] pci 0000:00:1d.0: bridge window [io  0x1000-0x0fff] to [bus 04-54] add_size 3000
[    0.646260] pci 0000:00:15.0: BAR 0 [mem 0x4404228000-0x4404228fff 64bit]: assigned
[    0.646323] pci 0000:00:15.1: BAR 0 [mem 0x4404229000-0x4404229fff 64bit]: assigned
[    0.646383] pci 0000:00:1d.0: bridge window [io  0x4000-0x6fff]: assigned
[    0.646385] pci 0000:00:1f.5: BAR 0 [mem 0x4b300000-0x4b300fff]: assigned
[    0.646397] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.646405] pci 0000:02:00.0: ROM [mem 0x4b080000-0x4b0fffff pref]: assigned
[    0.646407] pci 0000:00:01.1: PCI bridge to [bus 02]
[    0.646409] pci 0000:00:01.1:   bridge window [io  0x3000-0x3fff]
[    0.646412] pci 0000:00:01.1:   bridge window [mem 0x4a000000-0x4b0fffff]
[    0.646415] pci 0000:00:01.1:   bridge window [mem 0x4000000000-0x4401ffffff 64bit pref]
[    0.646420] pci 0000:00:1c.0: PCI bridge to [bus 03]
[    0.646430] pci 0000:00:1c.0:   bridge window [mem 0x4b100000-0x4b2fffff]
[    0.646439] pci 0000:04:00.0: bridge window [io  0x4000-0x5fff]: assigned
[    0.646442] pci 0000:05:01.0: bridge window [mem 0x4410000000-0x44101fffff 64bit pref]: assigned
[    0.646444] pci 0000:05:03.0: bridge window [mem 0x4410200000-0x44103fffff 64bit pref]: assigned
[    0.646446] pci 0000:05:01.0: bridge window [io  0x4000-0x4fff]: assigned
[    0.646448] pci 0000:05:03.0: bridge window [io  0x5000-0x5fff]: assigned
[    0.646450] pci 0000:05:00.0: PCI bridge to [bus 06]
[    0.646476] pci 0000:05:00.0:   bridge window [mem 0x5410000000-0x54100fffff 64bit pref]
[    0.646484] pci 0000:05:01.0: PCI bridge to [bus 07-2c]
[    0.646487] pci 0000:05:01.0:   bridge window [io  0x4000-0x4fff]
[    0.646493] pci 0000:05:01.0:   bridge window [mem 0x44000000-0x47efffff]
[    0.646497] pci 0000:05:01.0:   bridge window [mem 0x4410000000-0x44101fffff 64bit pref]
[    0.646505] pci 0000:05:02.0: PCI bridge to [bus 2d]
[    0.646511] pci 0000:05:02.0:   bridge window [mem 0x43f00000-0x43ffffff]
[    0.646521] pci 0000:05:03.0: PCI bridge to [bus 2e-54]
[    0.646524] pci 0000:05:03.0:   bridge window [io  0x5000-0x5fff]
[    0.646529] pci 0000:05:03.0:   bridge window [mem 0x40000000-0x43efffff]
[    0.646534] pci 0000:05:03.0:   bridge window [mem 0x4410200000-0x44103fffff 64bit pref]
[    0.646541] pci 0000:04:00.0: PCI bridge to [bus 05-54]
[    0.646544] pci 0000:04:00.0:   bridge window [io  0x4000-0x5fff]
[    0.646549] pci 0000:04:00.0:   bridge window [mem 0x40000000-0x47efffff]
[    0.646554] pci 0000:04:00.0:   bridge window [mem 0x4410000000-0x54100fffff 64bit pref]
[    0.646561] pci 0000:00:1d.0: PCI bridge to [bus 04-54]
[    0.646563] pci 0000:00:1d.0:   bridge window [io  0x4000-0x6fff]
[    0.646568] pci 0000:00:1d.0:   bridge window [mem 0x40000000-0x47ffffff]
[    0.646571] pci 0000:00:1d.0:   bridge window [mem 0x4410000000-0x54100fffff 64bit pref]
[    0.646578] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.646580] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.646582] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    0.646583] pci_bus 0000:00: resource 7 [mem 0x40000000-0xbfffffff window]
[    0.646585] pci_bus 0000:00: resource 8 [mem 0x4000000000-0x7fffffffff window]
[    0.646587] pci_bus 0000:02: resource 0 [io  0x3000-0x3fff]
[    0.646588] pci_bus 0000:02: resource 1 [mem 0x4a000000-0x4b0fffff]
[    0.646590] pci_bus 0000:02: resource 2 [mem 0x4000000000-0x4401ffffff 64bit pref]
[    0.646591] pci_bus 0000:03: resource 1 [mem 0x4b100000-0x4b2fffff]
[    0.646593] pci_bus 0000:04: resource 0 [io  0x4000-0x6fff]
[    0.646594] pci_bus 0000:04: resource 1 [mem 0x40000000-0x47ffffff]
[    0.646596] pci_bus 0000:04: resource 2 [mem 0x4410000000-0x54100fffff 64bit pref]
[    0.646597] pci_bus 0000:05: resource 0 [io  0x4000-0x5fff]
[    0.646599] pci_bus 0000:05: resource 1 [mem 0x40000000-0x47efffff]
[    0.646600] pci_bus 0000:05: resource 2 [mem 0x4410000000-0x54100fffff 64bit pref]
[    0.646602] pci_bus 0000:06: resource 2 [mem 0x5410000000-0x54100fffff 64bit pref]
[    0.646604] pci_bus 0000:07: resource 0 [io  0x4000-0x4fff]
[    0.646605] pci_bus 0000:07: resource 1 [mem 0x44000000-0x47efffff]
[    0.646606] pci_bus 0000:07: resource 2 [mem 0x4410000000-0x44101fffff 64bit pref]
[    0.646608] pci_bus 0000:2d: resource 1 [mem 0x43f00000-0x43ffffff]
[    0.646609] pci_bus 0000:2e: resource 0 [io  0x5000-0x5fff]
[    0.646611] pci_bus 0000:2e: resource 1 [mem 0x40000000-0x43efffff]
[    0.646612] pci_bus 0000:2e: resource 2 [mem 0x4410200000-0x44103fffff 64bit pref]
[    0.648796] pci 0000:02:00.1: extending delay after power-on from D3hot to 20 msec
[    0.648825] pci 0000:02:00.1: D0 power state depends on 0000:02:00.0
[    0.649277] pci 0000:2d:00.0: enabling device (0000 -> 0002)
[    0.649315] PCI: CLS 64 bytes, default 64
[    0.649355] DMAR: No RMRR found
[    0.649356] DMAR: No ATSR found
[    0.649357] DMAR: No SATC found
[    0.649358] DMAR: dmar0: Using Queued invalidation
[    0.649410] Trying to unpack rootfs image as initramfs...
[    0.649438] pci 0000:00:00.0: Adding to iommu group 0
[    0.649508] pci 0000:00:01.0: Adding to iommu group 1
[    0.649524] pci 0000:00:01.1: Adding to iommu group 2
[    0.649536] pci 0000:00:04.0: Adding to iommu group 3
[    0.649546] pci 0000:00:08.0: Adding to iommu group 4
[    0.649555] pci 0000:00:0a.0: Adding to iommu group 5
[    0.649565] pci 0000:00:0e.0: Adding to iommu group 6
[    0.649586] pci 0000:00:14.0: Adding to iommu group 7
[    0.649595] pci 0000:00:14.2: Adding to iommu group 7
[    0.649605] pci 0000:00:14.3: Adding to iommu group 8
[    0.649624] pci 0000:00:15.0: Adding to iommu group 9
[    0.649635] pci 0000:00:15.1: Adding to iommu group 9
[    0.649651] pci 0000:00:16.0: Adding to iommu group 10
[    0.649663] pci 0000:00:1c.0: Adding to iommu group 11
[    0.649681] pci 0000:00:1d.0: Adding to iommu group 12
[    0.649710] pci 0000:00:1f.0: Adding to iommu group 13
[    0.649721] pci 0000:00:1f.3: Adding to iommu group 13
[    0.649731] pci 0000:00:1f.4: Adding to iommu group 13
[    0.649742] pci 0000:00:1f.5: Adding to iommu group 13
[    0.649761] pci 0000:02:00.0: Adding to iommu group 14
[    0.649773] pci 0000:02:00.1: Adding to iommu group 14
[    0.649793] pci 0000:03:00.0: Adding to iommu group 15
[    0.649809] pci 0000:04:00.0: Adding to iommu group 16
[    0.649822] pci 0000:05:00.0: Adding to iommu group 17
[    0.649840] pci 0000:05:01.0: Adding to iommu group 18
[    0.649854] pci 0000:05:02.0: Adding to iommu group 19
[    0.649870] pci 0000:05:03.0: Adding to iommu group 20
[    0.649884] pci 0000:06:00.0: Adding to iommu group 21
[    0.649906] pci 0000:2d:00.0: Adding to iommu group 22
[    0.655434] DMAR: Intel(R) Virtualization Technology for Directed I/O
[    0.655438] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.655439] software IO TLB: mapped [mem 0x0000000025ec9000-0x0000000029ec9000] (64MB)
[    0.656488] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x22df1149949, max_idle_ns: 440795312789 ns
[    0.656912] clocksource: Switched to clocksource tsc
[    0.658922] Initialise system trusted keyrings
[    0.658934] Key type blacklist registered
[    0.658993] workingset: timestamp_bits=36 max_order=23 bucket_order=0
[    0.659006] zbud: loaded
[    0.659370] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.659525] fuse: init (API version 7.41)
[    0.659716] integrity: Platform Keyring initialized
[    0.659721] integrity: Machine keyring initialized
[    0.673483] Key type asymmetric registered
[    0.673486] Asymmetric key parser 'x509' registered
[    0.673517] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 243)
[    0.673587] io scheduler mq-deadline registered
[    0.674618] ledtrig-cpu: registered to indicate activity on CPUs
[    0.674969] pcieport 0000:00:01.0: PME: Signaling with IRQ 121
[    0.675269] pcieport 0000:00:01.1: PME: Signaling with IRQ 122
[    0.675597] pcieport 0000:00:1c.0: PME: Signaling with IRQ 123
[    0.675706] pcieport 0000:00:1c.0: AER: enabled with IRQ 123
[    0.675904] pcieport 0000:00:1d.0: PME: Signaling with IRQ 124
[    0.675996] pcieport 0000:00:1d.0: AER: enabled with IRQ 124
[    0.676025] pcieport 0000:00:1d.0: pciehp: Slot #8 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
[    0.676966] pcieport 0000:05:01.0: pciehp: Slot #1 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
[    0.677632] pcieport 0000:05:03.0: pciehp: Slot #3 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
[    0.677882] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    0.678240] Monitor-Mwait will be used to enter C-1 state
[    0.678256] Monitor-Mwait will be used to enter C-2 state
[    0.678267] Monitor-Mwait will be used to enter C-3 state
[    0.681432] ACPI: AC: AC Adapter [AC] (on-line)
[    0.681519] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    0.681801] ACPI: button: Power Button [PWRB]
[    0.681867] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input1
[    0.681927] ACPI: button: Sleep Button [SLPB]
[    0.681957] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input2
[    0.681995] ACPI: button: Lid Switch [LID0]
[    0.682045] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
[    0.682141] ACPI: button: Power Button [PWRF]
[    0.756786] thermal LNXTHERM:00: registered as thermal_zone0
[    0.756791] ACPI: thermal: Thermal Zone [TZ0] (25 C)
[    0.757202] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    0.757872] ACPI: battery: Slot [BAT0] (battery present)
[    0.759678] hpet_acpi_add: no address or irqs in _CRS
[    0.759717] Linux agpgart interface v0.103
[    0.761648] tpm_tis IFX1523:00: 2.0 TPM (device-id 0x1D, rev-id 54)
[    0.878972] ACPI: bus type drm_connector registered
[    0.886052] loop: module loaded
[    0.886384] tun: Universal TUN/TAP device driver, 1.6
[    0.886417] PPP generic driver version 2.4.2
[    0.886751] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    0.886757] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
[    0.887957] xhci_hcd 0000:00:14.0: hcc params 0x20007fc1 hci version 0x120 quirks 0x0000000200009810
[    0.888395] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    0.888398] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
[    0.888401] xhci_hcd 0000:00:14.0: Host supports USB 3.2 Enhanced SuperSpeed
[    0.888456] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.12
[    0.888460] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.888461] usb usb1: Product: xHCI Host Controller
[    0.888463] usb usb1: Manufacturer: Linux 6.12.0-rc5 xhci-hcd
[    0.888464] usb usb1: SerialNumber: 0000:00:14.0
[    0.888619] hub 1-0:1.0: USB hub found
[    0.888648] hub 1-0:1.0: 16 ports detected
[    0.892386] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.12
[    0.892389] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.892390] usb usb2: Product: xHCI Host Controller
[    0.892392] usb usb2: Manufacturer: Linux 6.12.0-rc5 xhci-hcd
[    0.892393] usb usb2: SerialNumber: 0000:00:14.0
[    0.892590] hub 2-0:1.0: USB hub found
[    0.892608] hub 2-0:1.0: 10 ports detected
[    0.894737] xhci_hcd 0000:2d:00.0: xHCI Host Controller
[    0.894741] xhci_hcd 0000:2d:00.0: new USB bus registered, assigned bus number 3
[    0.895940] xhci_hcd 0000:2d:00.0: hcc params 0x20007fc1 hci version 0x120 quirks 0x0000000200009810
[    0.896332] xhci_hcd 0000:2d:00.0: xHCI Host Controller
[    0.896334] xhci_hcd 0000:2d:00.0: new USB bus registered, assigned bus number 4
[    0.896337] xhci_hcd 0000:2d:00.0: Host supports USB 3.2 Enhanced SuperSpeed
[    0.896366] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.12
[    0.896369] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.896370] usb usb3: Product: xHCI Host Controller
[    0.896372] usb usb3: Manufacturer: Linux 6.12.0-rc5 xhci-hcd
[    0.896373] usb usb3: SerialNumber: 0000:2d:00.0
[    0.896576] hub 3-0:1.0: USB hub found
[    0.896584] hub 3-0:1.0: 2 ports detected
[    0.897831] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.12
[    0.897832] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.897834] usb usb4: Product: xHCI Host Controller
[    0.897835] usb usb4: Manufacturer: Linux 6.12.0-rc5 xhci-hcd
[    0.897836] usb usb4: SerialNumber: 0000:2d:00.0
[    0.898008] hub 4-0:1.0: USB hub found
[    0.898021] hub 4-0:1.0: 2 ports detected
[    0.899837] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[    0.903228] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.903232] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.903438] mousedev: PS/2 mouse device common for all mice
[    0.903863] rtc_cmos 00:01: RTC can wake from S4
[    0.904642] rtc_cmos 00:01: registered as rtc0
[    0.904823] rtc_cmos 00:01: setting system clock to 2024-10-29T20:08:49 UTC (1730232529)
[    0.904856] rtc_cmos 00:01: alarms up to one month, y3k, 242 bytes nvram
[    0.904863] i2c_dev: i2c /dev entries driver
[    0.908197] device-mapper: core: CONFIG_IMA_DISABLE_HTABLE is disabled. Duplicate IMA measurements will not be recorded in the IMA log.
[    0.908226] device-mapper: uevent: version 1.0.3
[    0.908436] device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) initialised: dm-devel@lists.linux.dev
[    0.908489] platform eisa.0: Probing EISA bus 0
[    0.908496] platform eisa.0: EISA: Cannot allocate resource for mainboard
[    0.908498] platform eisa.0: Cannot allocate resource for EISA slot 1
[    0.908500] platform eisa.0: Cannot allocate resource for EISA slot 2
[    0.908501] platform eisa.0: Cannot allocate resource for EISA slot 3
[    0.908502] platform eisa.0: Cannot allocate resource for EISA slot 4
[    0.908503] platform eisa.0: Cannot allocate resource for EISA slot 5
[    0.908504] platform eisa.0: Cannot allocate resource for EISA slot 6
[    0.908505] platform eisa.0: Cannot allocate resource for EISA slot 7
[    0.908507] platform eisa.0: Cannot allocate resource for EISA slot 8
[    0.908508] platform eisa.0: EISA: Detected 0 cards
[    0.908511] intel_pstate: Intel P-state driver initializing
[    0.909180] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input4
[    0.912586] intel_pstate: HWP enabled
[    0.912721] [drm] Initialized simpledrm 1.0.0 for simple-framebuffer.0 on minor 0
[    0.914911] fbcon: Deferring console take-over
[    0.914913] simple-framebuffer simple-framebuffer.0: [drm] fb0: simpledrmdrmfb frame buffer device
[    0.914994] drop_monitor: Initializing network drop monitor service
[    0.915081] NET: Registered PF_INET6 protocol family
[    0.983935] Freeing initrd memory: 74696K
[    0.990287] Segment Routing with IPv6
[    0.990296] In-situ OAM (IOAM) with IPv6
[    0.990320] NET: Registered PF_PACKET protocol family
[    0.990452] Key type dns_resolver registered
[    0.994724] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.996548] microcode: Current revision: 0x00000129
[    0.998381] IPI shorthand broadcast: enabled
[    0.999286] sched_clock: Marking stable (991000794, 7452213)->(1070008272, -71555265)
[    0.999865] registered taskstats version 1
[    1.003265] Loading compiled-in X.509 certificates
[    1.003617] Loaded X.509 cert 'Build time autogenerated kernel key: b9e32a74847b4505d53d500d44fb60761632a017'
[    1.005667] Demotion targets for Node 0: null
[    1.005722] Key type .fscrypt registered
[    1.005723] Key type fscrypt-provisioning registered
[    1.005764] Key type trusted registered
[    1.010776] cryptd: module verification failed: signature and/or required key missing - tainting kernel
[    1.011263] cryptd: max_cpu_qlen set to 1000
[    1.011831] AES CTR mode by8 optimization enabled
[    1.019724] Key type encrypted registered
[    1.019731] AppArmor: AppArmor sha256 policy hashing enabled
[    1.023753] integrity: Loading X.509 certificate: UEFI:db
[    1.023781] integrity: Loaded X.509 cert 'Microsoft Windows Production PCA 2011: a92902398e16c49778cd90f99e4f9ae17c55af53'
[    1.023783] integrity: Loading X.509 certificate: UEFI:db
[    1.023799] integrity: Loaded X.509 cert 'Microsoft Corporation: Windows UEFI CA 2023: aefc5fbbbe055d8f8daa585473499417ab5a5272'
[    1.023800] integrity: Loading X.509 certificate: UEFI:db
[    1.023817] integrity: Loaded X.509 cert 'Microsoft Corporation UEFI CA 2011: 13adbf4309bd82709c8cd54f316ed522988a1bd4'
[    1.023818] integrity: Loading X.509 certificate: UEFI:db
[    1.023832] integrity: Loaded X.509 cert 'Microsoft UEFI CA 2023: 81aa6b3244c935bce0d6628af39827421e32497d'
[    1.023833] integrity: Loading X.509 certificate: UEFI:db
[    1.024059] integrity: Loaded X.509 cert 'Secure Certificate: 01dcc89619884ca147983429f8a4a1a0'
[    1.024060] integrity: Loading X.509 certificate: UEFI:db
[    1.024208] integrity: Loaded X.509 cert 'Cus CA: d6136d376b87ef934511c12ce2c3880c'
[    1.031513] Loading compiled-in module X.509 certificates
[    1.031978] Loaded X.509 cert 'Build time autogenerated kernel key: b9e32a74847b4505d53d500d44fb60761632a017'
[    1.031980] ima: Allocated hash algorithm: sha256
[    1.132582] usb 1-6: new high-speed USB device number 2 using xhci_hcd
[    1.195188] ima: No architecture policies found
[    1.195234] evm: Initialising EVM extended attributes:
[    1.195237] evm: security.selinux
[    1.195239] evm: security.SMACK64
[    1.195241] evm: security.SMACK64EXEC
[    1.195244] evm: security.SMACK64TRANSMUTE
[    1.195246] evm: security.SMACK64MMAP
[    1.195248] evm: security.apparmor
[    1.195250] evm: security.ima
[    1.195251] evm: security.capability
[    1.195253] evm: HMAC attrs: 0x1
[    1.196192] PM:   Magic number: 12:392:145
[    1.196385] acpi device:16: hash matches
[    1.203673] RAS: Correctable Errors collector initialized.
[    1.212562] clk: Disabling unused clocks
[    1.212564] PM: genpd: Disabling unused power domains
[    1.218804] Freeing unused decrypted memory: 2028K
[    1.219794] Freeing unused kernel image (initmem) memory: 5064K
[    1.219814] Write protecting the kernel read-only data: 36864k
[    1.220531] Freeing unused kernel image (rodata/data gap) memory: 44K
[    1.227703] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    1.227762] Run /init as init process
[    1.227763]   with arguments:
[    1.227764]     /init
[    1.227765]     splash
[    1.227765]   with environment:
[    1.227766]     HOME=/
[    1.227766]     TERM=linux
[    1.227767]     BOOT_IMAGE=/@boot/vmlinuz-6.12.0-rc5
[    1.227768]     cryptdevice=UUID=1a8d8cdb-8d8f-4689-b744-8f32d2067f56:luks-1a8d8cdb-8d8f-4689-b744-8f32d2067f56
[    1.287679] usb 1-6: New USB device found, idVendor=04f2, idProduct=b7e7, bcdDevice= 0.04
[    1.287693] usb 1-6: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    1.287695] usb 1-6: Product: Chicony USB2.0 Camera
[    1.287697] usb 1-6: Manufacturer: SunplusIT Inc
[    1.287698] usb 1-6: SerialNumber: 01.00.00
[    1.313619] wmi_bus wmi_bus-PNP0C14:01: [Firmware Bug]: WQ00 data block query control method not found
[    1.314588] ACPI: video: [Firmware Bug]: ACPI(PEGP) defines _DOD but not _DOS
[    1.314614] ACPI: video: Video Device [PEGP] (multi-head: yes  rom: no  post: no)
[    1.314657] hid: raw HID events driver (C) Jiri Kosina
[    1.319904] vmd 0000:00:0e.0: PCI host bridge to bus 10000:e0
[    1.319907] pci_bus 10000:e0: root bus resource [bus e0-ff]
[    1.319909] pci_bus 10000:e0: root bus resource [mem 0x48000000-0x49ffffff]
[    1.319910] pci_bus 10000:e0: root bus resource [mem 0x4404102000-0x44041fffff 64bit]
[    1.319927] pci 10000:e0:1b.0: [8086:09ab] type 00 class 0x088000 conventional PCI endpoint
[    1.319935] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:05/LNXVIDEO:00/input/input6
[    1.320543] Intel(R) 2.5G Ethernet Linux Driver
[    1.320545] Copyright(c) 2018 Intel Corporation.
[    1.321162] pci 10000:e0:1b.0: Adding to iommu group 6
[    1.321192] pci 10000:e0:1b.4: [8086:7a44] type 01 class 0x060400 PCIe Root Port
[    1.321361] pci 10000:e0:1b.4: PCI bridge to [bus e1]
[    1.321368] pci 10000:e0:1b.4:   bridge window [io  0x0000-0x0fff]
[    1.321370] pci 10000:e0:1b.4:   bridge window [mem 0x48000000-0x480fffff]
[    1.321392] igc 0000:03:00.0: PTM enabled, 4ns granularity
[    1.321492] pci 10000:e0:1b.4: PME# supported from D0 D3hot D3cold
[    1.321555] pci 10000:e0:1b.4: PTM enabled (root), 4ns granularity
[    1.321701] pci 10000:e0:1b.4: Adding to iommu group 6
[    1.321714] pci 10000:e0:1b.4: Primary bus is hard wired to 0
[    1.321779] pci 10000:e1:00.0: [144d:a808] type 00 class 0x010802 PCIe Endpoint
[    1.321810] pci 10000:e1:00.0: BAR 0 [mem 0x48000000-0x48003fff 64bit]
[    1.322191] pci 10000:e1:00.0: Adding to iommu group 6
[    1.322205] pci 10000:e0:1b.4: PCI bridge to [bus e1]
[    1.322219] pci 10000:e0:1b.4: Primary bus is hard wired to 0
[    1.327082] ACPI: bus type thunderbolt registered
[    1.327313] thunderbolt 0000:06:00.0: total paths: 12
[    1.327319] thunderbolt 0000:06:00.0: IOMMU DMA protection is enabled
[    1.332483] intel-lpss 0000:00:15.0: enabling device (0004 -> 0006)
[    1.332934] idma64 idma64.0: Found Intel integrated DMA 64-bit
[    1.373846] pps pps0: new PPS source ptp0
[    1.373893] igc 0000:03:00.0 (unnamed net_device) (uninitialized): PHC added
[    1.401853] igc 0000:03:00.0: 4.000 Gb/s available PCIe bandwidth (5.0 GT/s PCIe x1 link)
[    1.401857] igc 0000:03:00.0 eth0: MAC: d4:93:90:44:67:64
[    1.403672] igc 0000:03:00.0 enp3s0: renamed from eth0
[    1.415659] usb 1-7: new full-speed USB device number 3 using xhci_hcd
[    1.428577] thunderbolt 0000:06:00.0: host router reset successful
[    1.429252] thunderbolt 0000:06:00.0: allocating TX ring 0 of size 10
[    1.429321] thunderbolt 0000:06:00.0: allocating RX ring 0 of size 10
[    1.429358] thunderbolt 0000:06:00.0: control channel created
[    1.429363] thunderbolt 0000:06:00.0: using software connection manager
[    1.429876] thunderbolt 0000:06:00.0: device links to tunneled native ports are missing!
[    1.429879] thunderbolt 0000:06:00.0: NHI initialized, starting thunderbolt
[    1.429882] thunderbolt 0000:06:00.0: control channel starting...
[    1.429884] thunderbolt 0000:06:00.0: starting TX ring 0
[    1.429899] thunderbolt 0000:06:00.0: enabling interrupt at register 0x38200 bit 0 (0x0 -> 0x1)
[    1.429905] thunderbolt 0000:06:00.0: starting RX ring 0
[    1.429914] thunderbolt 0000:06:00.0: enabling interrupt at register 0x38200 bit 12 (0x1 -> 0x1001)
[    1.429922] thunderbolt 0000:06:00.0: security level set to user
[    1.430181] thunderbolt 0000:06:00.0: current switch config:
[    1.430184] thunderbolt 0000:06:00.0:  USB4 Switch: 8087:5781 (Revision: 131, TB Version: 64)
[    1.430189] thunderbolt 0000:06:00.0:   Max Port Number: 23
[    1.430192] thunderbolt 0000:06:00.0:   Config:
[    1.430194] thunderbolt 0000:06:00.0:    Upstream Port Number: 15 Depth: 0 Route String: 0x0 Enabled: 0, PlugEventsDelay: 10ms
[    1.430199] thunderbolt 0000:06:00.0:    unknown1: 0x0 unknown4: 0x0
[    1.433347] thunderbolt 0000:06:00.0: initializing Switch at 0x0 (depth: 0, up port: 15)
[    1.434493] thunderbolt 0000:06:00.0: 0: credit allocation parameters:
[    1.434496] thunderbolt 0000:06:00.0: 0:  USB3: 20
[    1.434499] thunderbolt 0000:06:00.0: 0:  DP AUX: 1
[    1.434501] thunderbolt 0000:06:00.0: 0:  DP main: 6
[    1.434503] thunderbolt 0000:06:00.0: 0:  PCIe: 80
[    1.434505] thunderbolt 0000:06:00.0: 0:  DMA: 40
[    1.436154] thunderbolt 0000:06:00.0: acking hot plug event on 0:13
[    1.436280] thunderbolt 0000:06:00.0: acking hot plug event on 0:14
[    1.436410] thunderbolt 0000:06:00.0: acking hot plug event on 0:16
[    1.436925] thunderbolt 0000:06:00.0: 0: DROM version: 3
[    1.436930] thunderbolt 0000:06:00.0: 0: DROM data CRC32 mismatch (expected: 0x56000000, got: 0x56473b0f), continuing
[    1.437562] thunderbolt 0000:06:00.0: 0: uid: 0xb93e650000006ecd
[    1.438844] thunderbolt 0000:06:00.0:  Port 1: 0:5780 (Revision: 0, TB Version: 1, Type: Port (0x1))
[    1.438850] thunderbolt 0000:06:00.0:   Max hop id (in/out): 31/31
[    1.438853] thunderbolt 0000:06:00.0:   Max counters: 4
[    1.438856] thunderbolt 0000:06:00.0:   NFC Credits: 0x8a000000
[    1.438858] thunderbolt 0000:06:00.0:   Credits (total/control): 160/2
[    1.439994] thunderbolt 0000:06:00.0:  Port 2: 0:5780 (Revision: 0, TB Version: 1, Type: Port (0x1))
[    1.439997] thunderbolt 0000:06:00.0:   Max hop id (in/out): 31/31
[    1.440000] thunderbolt 0000:06:00.0:   Max counters: 0
[    1.440002] thunderbolt 0000:06:00.0:   NFC Credits: 0xa000000
[    1.440004] thunderbolt 0000:06:00.0:   Credits (total/control): 160/2
[    1.441274] thunderbolt 0000:06:00.0:  Port 3: 0:5780 (Revision: 0, TB Version: 1, Type: Port (0x1))
[    1.441277] thunderbolt 0000:06:00.0:   Max hop id (in/out): 31/31
[    1.441279] thunderbolt 0000:06:00.0:   Max counters: 4
[    1.441281] thunderbolt 0000:06:00.0:   NFC Credits: 0x8a000000
[    1.441282] thunderbolt 0000:06:00.0:   Credits (total/control): 160/2
[    1.442426] thunderbolt 0000:06:00.0:  Port 4: 0:5780 (Revision: 0, TB Version: 1, Type: Port (0x1))
[    1.442429] thunderbolt 0000:06:00.0:   Max hop id (in/out): 31/31
[    1.442431] thunderbolt 0000:06:00.0:   Max counters: 0
[    1.442433] thunderbolt 0000:06:00.0:   NFC Credits: 0xa000000
[    1.442435] thunderbolt 0000:06:00.0:   Credits (total/control): 160/2
[    1.443705] thunderbolt 0000:06:00.0:  Port 5: 0:5780 (Revision: 0, TB Version: 1, Type: Inactive (0x0))
[    1.443708] thunderbolt 0000:06:00.0:   Max hop id (in/out): 31/31
[    1.443710] thunderbolt 0000:06:00.0:   Max counters: 4
[    1.443711] thunderbolt 0000:06:00.0:   NFC Credits: 0x8a000000
[    1.443713] thunderbolt 0000:06:00.0:   Credits (total/control): 160/0
[    1.444474] thunderbolt 0000:06:00.0:  Port 6: 0:5780 (Revision: 0, TB Version: 1, Type: Inactive (0x0))
[    1.444476] thunderbolt 0000:06:00.0:   Max hop id (in/out): 31/31
[    1.444478] thunderbolt 0000:06:00.0:   Max counters: 0
[    1.444480] thunderbolt 0000:06:00.0:   NFC Credits: 0xa000000
[    1.444481] thunderbolt 0000:06:00.0:   Credits (total/control): 160/0
[    1.445749] thunderbolt 0000:06:00.0:  Port 7: 0:5780 (Revision: 0, TB Version: 1, Type: Inactive (0x0))
[    1.445752] thunderbolt 0000:06:00.0:   Max hop id (in/out): 31/31
[    1.445754] thunderbolt 0000:06:00.0:   Max counters: 4
[    1.445755] thunderbolt 0000:06:00.0:   NFC Credits: 0x8a000000
[    1.445757] thunderbolt 0000:06:00.0:   Credits (total/control): 160/0
[    1.446521] thunderbolt 0000:06:00.0:  Port 8: 0:5780 (Revision: 0, TB Version: 1, Type: Inactive (0x0))
[    1.446524] thunderbolt 0000:06:00.0:   Max hop id (in/out): 31/31
[    1.446526] thunderbolt 0000:06:00.0:   Max counters: 0
[    1.446528] thunderbolt 0000:06:00.0:   NFC Credits: 0xa000000
[    1.446529] thunderbolt 0000:06:00.0:   Credits (total/control): 160/0
[    1.446776] thunderbolt 0000:06:00.0:  Port 9: 0:5780 (Revision: 0, TB Version: 1, Type: PCIe (0x100101))
[    1.446779] thunderbolt 0000:06:00.0:   Max hop id (in/out): 8/8
[    1.446781] thunderbolt 0000:06:00.0:   Max counters: 2
[    1.446783] thunderbolt 0000:06:00.0:   NFC Credits: 0x40800000
[    1.446784] thunderbolt 0000:06:00.0:   Credits (total/control): 8/0
[    1.447033] thunderbolt 0000:06:00.0:  Port 10: 0:5780 (Revision: 0, TB Version: 1, Type: PCIe (0x100101))
[    1.447037] thunderbolt 0000:06:00.0:   Max hop id (in/out): 8/8
[    1.447039] thunderbolt 0000:06:00.0:   Max counters: 2
[    1.447041] thunderbolt 0000:06:00.0:   NFC Credits: 0x40800000
[    1.447043] thunderbolt 0000:06:00.0:   Credits (total/control): 8/0
[    1.447548] thunderbolt 0000:06:00.0:  Port 11: 0:5780 (Revision: 0, TB Version: 1, Type: DP/HDMI (0xe0102))
[    1.447552] thunderbolt 0000:06:00.0:   Max hop id (in/out): 9/9
[    1.447554] thunderbolt 0000:06:00.0:   Max counters: 2
[    1.447556] thunderbolt 0000:06:00.0:   NFC Credits: 0x800000
[    1.447558] thunderbolt 0000:06:00.0:   Credits (total/control): 8/0
[    1.448058] thunderbolt 0000:06:00.0:  Port 12: 0:5780 (Revision: 0, TB Version: 1, Type: DP/HDMI (0xe0102))
[    1.448061] thunderbolt 0000:06:00.0:   Max hop id (in/out): 9/9
[    1.448063] thunderbolt 0000:06:00.0:   Max counters: 2
[    1.448065] thunderbolt 0000:06:00.0:   NFC Credits: 0x800000
[    1.448067] thunderbolt 0000:06:00.0:   Credits (total/control): 8/0
[    1.448314] thunderbolt 0000:06:00.0:  Port 13: 0:5780 (Revision: 0, TB Version: 1, Type: DP/HDMI (0xe0101))
[    1.448317] thunderbolt 0000:06:00.0:   Max hop id (in/out): 9/9
[    1.448320] thunderbolt 0000:06:00.0:   Max counters: 2
[    1.448322] thunderbolt 0000:06:00.0:   NFC Credits: 0x100000d
[    1.448324] thunderbolt 0000:06:00.0:   Credits (total/control): 16/0
[    1.448568] thunderbolt 0000:06:00.0:  Port 14: 0:5780 (Revision: 0, TB Version: 1, Type: DP/HDMI (0xe0101))
[    1.448571] thunderbolt 0000:06:00.0:   Max hop id (in/out): 9/9
[    1.448573] thunderbolt 0000:06:00.0:   Max counters: 2
[    1.448575] thunderbolt 0000:06:00.0:   NFC Credits: 0x100000d
[    1.448577] thunderbolt 0000:06:00.0:   Credits (total/control): 16/0
[    1.449335] thunderbolt 0000:06:00.0:  Port 15: 0:5780 (Revision: 0, TB Version: 1, Type: NHI (0x2))
[    1.449339] thunderbolt 0000:06:00.0:   Max hop id (in/out): 11/11
[    1.449341] thunderbolt 0000:06:00.0:   Max counters: 4
[    1.449343] thunderbolt 0000:06:00.0:   NFC Credits: 0x41c00000
[    1.449345] thunderbolt 0000:06:00.0:   Credits (total/control): 28/0
[    1.449347] thunderbolt 0000:06:00.0: 0:16: disabled by eeprom
[    1.449592] thunderbolt 0000:06:00.0:  Port 17: 0:5780 (Revision: 0, TB Version: 1, Type: Inactive (0x0))
[    1.449595] thunderbolt 0000:06:00.0:   Max hop id (in/out): 8/8
[    1.449597] thunderbolt 0000:06:00.0:   Max counters: 2
[    1.449599] thunderbolt 0000:06:00.0:   NFC Credits: 0x40800000
[    1.449601] thunderbolt 0000:06:00.0:   Credits (total/control): 8/0
[    1.449851] thunderbolt 0000:06:00.0:  Port 18: 0:5780 (Revision: 0, TB Version: 1, Type: Inactive (0x0))
[    1.449855] thunderbolt 0000:06:00.0:   Max hop id (in/out): 8/8
[    1.449857] thunderbolt 0000:06:00.0:   Max counters: 2
[    1.449859] thunderbolt 0000:06:00.0:   NFC Credits: 0x40800000
[    1.449861] thunderbolt 0000:06:00.0:   Credits (total/control): 8/0
[    1.450358] thunderbolt 0000:06:00.0:  Port 19: 0:5780 (Revision: 0, TB Version: 1, Type: DP/HDMI (0xe0102))
[    1.450361] thunderbolt 0000:06:00.0:   Max hop id (in/out): 9/9
[    1.450363] thunderbolt 0000:06:00.0:   Max counters: 2
[    1.450365] thunderbolt 0000:06:00.0:   NFC Credits: 0x800000
[    1.450367] thunderbolt 0000:06:00.0:   Credits (total/control): 8/0
[    1.450617] thunderbolt 0000:06:00.0:  Port 20: 0:5780 (Revision: 0, TB Version: 1, Type: Inactive (0x0))
[    1.450621] thunderbolt 0000:06:00.0:   Max hop id (in/out): 8/8
[    1.450623] thunderbolt 0000:06:00.0:   Max counters: 1
[    1.450625] thunderbolt 0000:06:00.0:   NFC Credits: 0x800000
[    1.450627] thunderbolt 0000:06:00.0:   Credits (total/control): 8/0
[    1.450871] thunderbolt 0000:06:00.0:  Port 21: 0:5780 (Revision: 0, TB Version: 1, Type: USB (0x200101))
[    1.450875] thunderbolt 0000:06:00.0:   Max hop id (in/out): 8/8
[    1.450877] thunderbolt 0000:06:00.0:   Max counters: 1
[    1.450879] thunderbolt 0000:06:00.0:   NFC Credits: 0x800000
[    1.450881] thunderbolt 0000:06:00.0:   Credits (total/control): 8/0
[    1.451131] thunderbolt 0000:06:00.0:  Port 22: 0:5780 (Revision: 0, TB Version: 1, Type: USB (0x200101))
[    1.451134] thunderbolt 0000:06:00.0:   Max hop id (in/out): 8/8
[    1.451137] thunderbolt 0000:06:00.0:   Max counters: 1
[    1.451139] thunderbolt 0000:06:00.0:   NFC Credits: 0x800000
[    1.451141] thunderbolt 0000:06:00.0:   Credits (total/control): 8/0
[    1.451385] thunderbolt 0000:06:00.0:  Port 23: 0:5780 (Revision: 0, TB Version: 1, Type: Inactive (0x0))
[    1.451388] thunderbolt 0000:06:00.0:   Max hop id (in/out): 8/8
[    1.451391] thunderbolt 0000:06:00.0:   Max counters: 1
[    1.451393] thunderbolt 0000:06:00.0:   NFC Credits: 0x800000
[    1.451395] thunderbolt 0000:06:00.0:   Credits (total/control): 8/0
[    1.451398] thunderbolt 0000:06:00.0: 0: running tb_retimer_remove_all [thunderbolt]
[    1.451434] thunderbolt 0000:06:00.0: 0:21: USB3 maximum bandwidth limited to 16376 Mb/s
[    1.451437] thunderbolt 0000:06:00.0: 0:22: USB3 maximum bandwidth limited to 16376 Mb/s
[    1.451440] thunderbolt 0000:06:00.0: 0: running tb_retimer_remove_all [thunderbolt]
[    1.451462] thunderbolt 0000:06:00.0: 0: preventing runtime PM in DP redrive mode
[    1.451464] thunderbolt 0000:06:00.0: 0: linked ports 1 <-> 2
[    1.451467] thunderbolt 0000:06:00.0: 0: linked ports 3 <-> 4
[    1.459702] thunderbolt 0000:06:00.0: 0: TMU: supports uni-directional mode
[    1.459704] thunderbolt 0000:06:00.0: 0: TMU: supports enhanced uni-directional mode
[    1.459832] thunderbolt 0000:06:00.0: 0: TMU: current mode: off
[    1.463836] thunderbolt 0000:06:00.0: 0: NVM version 14.86
[    1.463985] thunderbolt 0000:06:00.0: 0: TMU: mode change off -> uni-directional, LowRes requested
[    1.464401] thunderbolt 0000:06:00.0: 0: TMU: mode set to: uni-directional, LowRes
[    1.465294] thunderbolt 0000:06:00.0: 0:13: DP IN resource available
[    1.465942] thunderbolt 0000:06:00.0: 0:14: DP IN resource available
[    1.476570] intel-lpss 0000:00:15.1: enabling device (0004 -> 0006)
[    1.478935] idma64 idma64.1: Found Intel integrated DMA 64-bit
[    1.484720] pci 10000:e0:1b.4: bridge window [mem 0x48000000-0x480fffff]: assigned
[    1.484728] pci 10000:e0:1b.4: bridge window [io  size 0x1000]: can't assign; no space
[    1.484730] pci 10000:e0:1b.4: bridge window [io  size 0x1000]: failed to assign
[    1.484734] pci 10000:e1:00.0: BAR 0 [mem 0x48000000-0x48003fff 64bit]: assigned
[    1.484759] pci 10000:e0:1b.4: PCI bridge to [bus e1]
[    1.484767] pci 10000:e0:1b.4:   bridge window [mem 0x48000000-0x480fffff]
[    1.484860] pcieport 10000:e0:1b.4: can't derive routing for PCI INT A
[    1.484863] pcieport 10000:e0:1b.4: PCI INT A: no GSI
[    1.485005] pcieport 10000:e0:1b.4: PME: Signaling with IRQ 185
[    1.485381] pcieport 10000:e0:1b.4: AER: enabled with IRQ 185
[    1.485525] vmd 0000:00:0e.0: Bound to PCI domain 10000
[    1.543444] usb 1-7: New USB device found, idVendor=048d, idProduct=8910, bcdDevice= 0.01
[    1.543471] usb 1-7: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    1.543478] usb 1-7: Product: ITE Device(829x)
[    1.543482] usb 1-7: Manufacturer: ITE Tech. Inc.
[    1.660691] usb 1-14: new full-speed USB device number 4 using xhci_hcd
[    1.786851] usb 1-14: New USB device found, idVendor=8087, idProduct=0033, bcdDevice= 0.00
[    1.786869] usb 1-14: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    1.800394] usbcore: registered new interface driver usbhid
[    1.800400] usbhid: USB HID core driver
[    1.815738] hid-generic 0003:048D:8910.0001: hiddev0,hidraw0: USB HID v1.10 Device [ITE Tech. Inc. ITE Device(829x)] on usb-0000:00:14.0-7/input0
[    1.816160] input: FTCS1000:01 2808:0102 Mouse as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-0/i2c-FTCS1000:01/0018:2808:0102.0002/input/input8
[    1.816327] input: FTCS1000:01 2808:0102 Touchpad as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-0/i2c-FTCS1000:01/0018:2808:0102.0002/input/input9
[    1.816530] hid-generic 0018:2808:0102.0002: input,hidraw1: I2C HID v1.00 Mouse [FTCS1000:01 2808:0102] on i2c-FTCS1000:01
[    1.823279] nvme nvme0: pci function 10000:e1:00.0
[    1.823303] pcieport 10000:e0:1b.4: can't derive routing for PCI INT A
[    1.823306] nvme 10000:e1:00.0: PCI INT A: not connected
[    1.825945] nvme nvme0: missing or invalid SUBNQN field.
[    1.826116] nvme nvme0: D3 entry latency set to 8 seconds
[    1.846819] nvme nvme0: 18/0/0 default/read/poll queues
[    1.855807]  nvme0n1: p1 p2 p3
[    1.866048] input: FTCS1000:01 2808:0102 Mouse as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-0/i2c-FTCS1000:01/0018:2808:0102.0002/input/input11
[    1.866544] input: FTCS1000:01 2808:0102 Touchpad as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-0/i2c-FTCS1000:01/0018:2808:0102.0002/input/input12
[    1.866905] hid-multitouch 0018:2808:0102.0002: input,hidraw1: I2C HID v1.00 Mouse [FTCS1000:01 2808:0102] on i2c-FTCS1000:01
[    2.889287] input: ImPS/2 Generic Wheel Mouse as /devices/platform/i8042/serio1/input/input7
[    6.830485] ucsi_acpi USBC000:00: error -ETIMEDOUT: PPM init failed
[   20.206730] thunderbolt 0000:06:00.0: 0: suspending switch
[   20.206742] thunderbolt 0000:06:00.0: 0: enabling wakeup: 0x3f
[   20.207874] thunderbolt 0000:06:00.0: stopping RX ring 0
[   20.207889] thunderbolt 0000:06:00.0: disabling interrupt at register 0x38200 bit 12 (0x1001 -> 0x1)
[   20.207916] thunderbolt 0000:06:00.0: stopping TX ring 0
[   20.207923] thunderbolt 0000:06:00.0: disabling interrupt at register 0x38200 bit 0 (0x1 -> 0x0)
[   20.207938] thunderbolt 0000:06:00.0: control channel stopped
[  101.597464] raid6: avx2x4   gen() 27836 MB/s
[  101.614534] raid6: avx2x2   gen() 31792 MB/s
[  101.631460] raid6: avx2x1   gen() 19854 MB/s
[  101.631461] raid6: using algorithm avx2x2 gen() 31792 MB/s
[  101.648552] raid6: .... xor() 28785 MB/s, rmw enabled
[  101.648558] raid6: using avx2x2 recovery algorithm
[  101.650584] xor: automatically using best checksumming function   avx       
[  101.692616] Btrfs loaded, zoned=yes, fsverity=yes
[  101.722003] BTRFS: device label kfocus_2404 devid 1 transid 7921 /dev/mapper/luks-1a8d8cdb-8d8f-4689-b744-8f32d2067f56 (252:0) scanned by mount (746)
[  101.722570] BTRFS info (device dm-0): first mount of filesystem aa8cb093-9cb3-4cc7-b44e-4bff76ca37fb
[  101.722583] BTRFS info (device dm-0): using crc32c (crc32c-intel) checksum algorithm
[  101.722587] BTRFS info (device dm-0): using free-space-tree
[  101.879228] systemd[1]: Inserted module 'autofs4'
[  102.069259] systemd[1]: systemd 255.4-1ubuntu8.4 running in system mode (+PAM +AUDIT +SELINUX +APPARMOR +IMA +SMACK +SECCOMP +GCRYPT -GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP +LIBFDISK +PCRE2 -PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD -BPF_FRAMEWORK -XKBCOMMON +UTMP +SYSVINIT default-hierarchy=unified)
[  102.069263] systemd[1]: Detected architecture x86-64.
[  102.069969] systemd[1]: Hostname set to <qa-m2>.
[  102.149714] systemd[1]: Configuration file /run/systemd/system/netplan-ovs-cleanup.service is marked world-inaccessible. This has no effect as configuration data is accessible via APIs without restrictions. Proceeding anyway.
[  102.179148] systemd[1]: Queued start job for default target graphical.target.
[  102.205636] systemd[1]: Created slice system-modprobe.slice - Slice /system/modprobe.
[  102.205835] systemd[1]: Created slice system-systemd\x2dcryptsetup.slice - Encrypted Volume Units Service Slice.
[  102.205977] systemd[1]: Created slice system-systemd\x2dfsck.slice - Slice /system/systemd-fsck.
[  102.206071] systemd[1]: Created slice user.slice - User and Session Slice.
[  102.206098] systemd[1]: Started systemd-ask-password-wall.path - Forward Password Requests to Wall Directory Watch.
[  102.206202] systemd[1]: Set up automount proc-sys-fs-binfmt_misc.automount - Arbitrary Executable File Formats File System Automount Point.
[  102.206213] systemd[1]: Expecting device dev-disk-by\x2duuid-167A\x2d6858.device - /dev/disk/by-uuid/167A-6858...
[  102.206218] systemd[1]: Expecting device dev-disk-by\x2duuid-1a8d8cdb\x2d8d8f\x2d4689\x2db744\x2d8f32d2067f56.device - /dev/disk/by-uuid/1a8d8cdb-8d8f-4689-b744-8f32d2067f56...
[  102.206221] systemd[1]: Expecting device dev-disk-by\x2duuid-aa8cb093\x2d9cb3\x2d4cc7\x2db44e\x2d4bff76ca37fb.device - /dev/disk/by-uuid/aa8cb093-9cb3-4cc7-b44e-4bff76ca37fb...
[  102.206225] systemd[1]: Expecting device dev-disk-by\x2duuid-abbbc711\x2d9904\x2d466b\x2d8a35\x2d783f0d19bf50.device - /dev/disk/by-uuid/abbbc711-9904-466b-8a35-783f0d19bf50...
[  102.206228] systemd[1]: Expecting device dev-mapper-luks\x2d1a8d8cdb\x2d8d8f\x2d4689\x2db744\x2d8f32d2067f56.device - /dev/mapper/luks-1a8d8cdb-8d8f-4689-b744-8f32d2067f56...
[  102.206239] systemd[1]: Reached target integritysetup.target - Local Integrity Protected Volumes.
[  102.206251] systemd[1]: Reached target nss-user-lookup.target - User and Group Name Lookups.
[  102.206258] systemd[1]: Reached target remote-fs.target - Remote File Systems.
[  102.206263] systemd[1]: Reached target slices.target - Slice Units.
[  102.206270] systemd[1]: Reached target snapd.mounts-pre.target - Mounting snaps.
[  102.206284] systemd[1]: Reached target veritysetup.target - Local Verity Protected Volumes.
[  102.206319] systemd[1]: Listening on dm-event.socket - Device-mapper event daemon FIFOs.
[  102.206617] systemd[1]: Listening on lvm2-lvmpolld.socket - LVM2 poll daemon socket.
[  102.206840] systemd[1]: Listening on syslog.socket - Syslog Socket.
[  102.206876] systemd[1]: Listening on systemd-fsckd.socket - fsck to fsckd communication Socket.
[  102.206899] systemd[1]: Listening on systemd-initctl.socket - initctl Compatibility Named Pipe.
[  102.206938] systemd[1]: Listening on systemd-journald-dev-log.socket - Journal Socket (/dev/log).
[  102.206978] systemd[1]: Listening on systemd-journald.socket - Journal Socket.
[  102.207002] systemd[1]: systemd-pcrextend.socket - TPM2 PCR Extension (Varlink) was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
[  102.207316] systemd[1]: Listening on systemd-udevd-control.socket - udev Control Socket.
[  102.207350] systemd[1]: Listening on systemd-udevd-kernel.socket - udev Kernel Socket.
[  102.208693] systemd[1]: Mounting dev-hugepages.mount - Huge Pages File System...
[  102.209297] systemd[1]: Mounting dev-mqueue.mount - POSIX Message Queue File System...
[  102.209890] systemd[1]: Mounting sys-kernel-debug.mount - Kernel Debug File System...
[  102.210443] systemd[1]: Mounting sys-kernel-tracing.mount - Kernel Trace File System...
[  102.212683] systemd[1]: Starting systemd-journald.service - Journal Service...
[  102.212871] systemd[1]: Finished blk-availability.service - Availability of block devices.
[  102.215457] systemd[1]: Starting keyboard-setup.service - Set the console keyboard layout...
[  102.217455] systemd[1]: Starting kmod-static-nodes.service - Create List of Static Device Nodes...
[  102.219381] systemd[1]: Starting lvm2-monitor.service - Monitoring of LVM2 mirrors, snapshots etc. using dmeventd or progress polling...
[  102.221342] systemd[1]: Starting modprobe@configfs.service - Load Kernel Module configfs...
[  102.222687] systemd[1]: Starting modprobe@dm_mod.service - Load Kernel Module dm_mod...
[  102.223264] systemd[1]: Starting modprobe@drm.service - Load Kernel Module drm...
[  102.223775] systemd[1]: Starting modprobe@efi_pstore.service - Load Kernel Module efi_pstore...
[  102.224306] systemd[1]: Starting modprobe@fuse.service - Load Kernel Module fuse...
[  102.224724] systemd[1]: Starting modprobe@loop.service - Load Kernel Module loop...
[  102.225167] systemd[1]: Starting modprobe@nvme_fabrics.service - Load Kernel Module nvme_fabrics...
[  102.225689] systemd[1]: Starting systemd-modules-load.service - Load Kernel Modules...
[  102.225697] systemd[1]: systemd-pcrmachine.service - TPM2 PCR Machine ID Measurement was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
[  102.226104] systemd[1]: Starting systemd-remount-fs.service - Remount Root and Kernel File Systems...
[  102.226123] systemd[1]: systemd-tpm2-setup-early.service - TPM2 SRK Setup (Early) was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
[  102.226480] systemd[1]: Starting systemd-udev-trigger.service - Coldplug All udev Devices...
[  102.227009] systemd[1]: Mounted dev-hugepages.mount - Huge Pages File System.
[  102.227050] systemd[1]: Mounted dev-mqueue.mount - POSIX Message Queue File System.
[  102.227079] systemd[1]: Mounted sys-kernel-debug.mount - Kernel Debug File System.
[  102.227108] systemd[1]: Mounted sys-kernel-tracing.mount - Kernel Trace File System.
[  102.227195] systemd[1]: Finished kmod-static-nodes.service - Create List of Static Device Nodes.
[  102.227208] systemd-journald[816]: Collecting audit messages is disabled.
[  102.227293] systemd[1]: modprobe@configfs.service: Deactivated successfully.
[  102.227351] systemd[1]: Finished modprobe@configfs.service - Load Kernel Module configfs.
[  102.227455] systemd[1]: modprobe@dm_mod.service: Deactivated successfully.
[  102.227513] systemd[1]: Finished modprobe@dm_mod.service - Load Kernel Module dm_mod.
[  102.227602] systemd[1]: modprobe@drm.service: Deactivated successfully.
[  102.227651] systemd[1]: Finished modprobe@drm.service - Load Kernel Module drm.
[  102.227743] systemd[1]: modprobe@fuse.service: Deactivated successfully.
[  102.227791] pstore: Using crash dump compression: deflate
[  102.227793] systemd[1]: Finished modprobe@fuse.service - Load Kernel Module fuse.
[  102.228349] systemd[1]: Mounting sys-fs-fuse-connections.mount - FUSE Control File System...
[  102.228689] systemd[1]: Mounting sys-kernel-config.mount - Kernel Configuration File System...
[  102.229153] systemd[1]: Starting systemd-tmpfiles-setup-dev-early.service - Create Static Device Nodes in /dev gracefully...
[  102.229258] systemd[1]: modprobe@loop.service: Deactivated successfully.
[  102.229321] systemd[1]: Finished modprobe@loop.service - Load Kernel Module loop.
[  102.229378] systemd[1]: systemd-repart.service - Repartition Root Disk was skipped because no trigger condition checks were met.
[  102.231597] systemd[1]: Mounted sys-kernel-config.mount - Kernel Configuration File System.
[  102.231789] Key type psk registered
[  102.232663] BTRFS info (device dm-0 state M): turning on sync discard
[  102.232667] BTRFS info (device dm-0 state M): enabling auto defrag
[  102.232667] BTRFS info (device dm-0 state M): use lzo compression, level 0
[  102.233041] systemd[1]: Mounted sys-fs-fuse-connections.mount - FUSE Control File System.
[  102.233143] systemd[1]: Finished systemd-remount-fs.service - Remount Root and Kernel File Systems.
[  102.233873] systemd[1]: systemd-hwdb-update.service - Rebuild Hardware Database was skipped because of an unmet condition check (ConditionNeedsUpdate=/etc).
[  102.234338] systemd[1]: Starting systemd-random-seed.service - Load/Save OS Random Seed...
[  102.234348] systemd[1]: systemd-tpm2-setup.service - TPM2 SRK Setup was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
[  102.237603] systemd[1]: modprobe@nvme_fabrics.service: Deactivated successfully.
[  102.237677] systemd[1]: Finished modprobe@nvme_fabrics.service - Load Kernel Module nvme_fabrics.
[  102.241108] systemd[1]: Finished systemd-tmpfiles-setup-dev-early.service - Create Static Device Nodes in /dev gracefully.
[  102.241322] systemd[1]: systemd-sysusers.service - Create System Users was skipped because no trigger condition checks were met.
[  102.241594] lp: driver loaded but no devices found
[  102.242978] systemd[1]: Starting systemd-tmpfiles-setup-dev.service - Create Static Device Nodes in /dev...
[  102.254802] systemd[1]: Finished keyboard-setup.service - Set the console keyboard layout.
[  102.263330] systemd[1]: Finished systemd-tmpfiles-setup-dev.service - Create Static Device Nodes in /dev.
[  102.263453] ppdev: user-space parallel port driver
[  102.263991] systemd[1]: Starting systemd-udevd.service - Rule-based Manager for Device Events and Files...
[  102.264953] systemd[1]: Started systemd-journald.service - Journal Service.
[  102.281468] systemd-journald[816]: Received client request to flush runtime journal.
[  102.306730] systemd-journald[816]: /var/log/journal/86d43f3761a64806a644a560706664c5/system.journal: Journal file uses a different sequence number ID, rotating.
[  102.306734] systemd-journald[816]: Rotating system journal.
[  102.307067] pstore: Registered efi_pstore as persistent store backend
[  102.332211] loop0: detected capacity change from 0 to 152056
[  102.333111] loop1: detected capacity change from 0 to 151296
[  102.333318] loop2: detected capacity change from 0 to 22752
[  102.334013] loop3: detected capacity change from 0 to 8
[  102.334121] loop4: detected capacity change from 0 to 21952
[  102.334790] loop5: detected capacity change from 0 to 1034424
[  102.335508] loop6: detected capacity change from 0 to 187776
[  102.337216] loop7: detected capacity change from 0 to 79328
[  102.338940] loop8: detected capacity change from 0 to 79520
[  102.340879] BTRFS info: devid 1 device path /dev/mapper/luks-1a8d8cdb-8d8f-4689-b744-8f32d2067f56 changed to /dev/dm-0 scanned by (udev-worker) (917)
[  102.341340] BTRFS info: devid 1 device path /dev/dm-0 changed to /dev/mapper/luks-1a8d8cdb-8d8f-4689-b744-8f32d2067f56 scanned by (udev-worker) (917)
[  102.367923] input: Intel HID events as /devices/platform/INTC1051:00/input/input14
[  102.370265] Consider using thermal netlink events interface
[  102.390236] intel_pmc_core INT33A1:00:  initialized
[  102.433700] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[  102.433949] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[  102.434076] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c7248db18c600'
[  102.434797] intel_rapl_msr: PL4 support detected.
[  102.437426] intel_rapl_common: Found RAPL domain package
[  102.437440] intel_rapl_common: Found RAPL domain core
[  102.437453] intel_rapl_common: Found RAPL domain psys
[  102.439952] mei_me 0000:00:16.0: enabling device (0000 -> 0002)
[  102.440704] i801_smbus 0000:00:1f.4: SPD Write Disable is set
[  102.440751] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
[  102.441006] RAPL PMU: API unit is 2^-32 Joules, 3 fixed counters, 655360 ms ovfl timer
[  102.441009] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[  102.441010] RAPL PMU: hw unit of domain package 2^-14 Joules
[  102.441011] RAPL PMU: hw unit of domain psys 2^-14 Joules
[  102.442430] i2c i2c-2: Successfully instantiated SPD at 0x50
[  102.445124] Intel(R) Wireless WiFi driver for Linux
[  102.447029] iwlwifi 0000:00:14.3: Detected crf-id 0x400410, cnv-id 0x80401 wfpm id 0x80000020
[  102.447055] iwlwifi 0000:00:14.3: PCI dev 7a70/0094, rev=0x430, rfid=0x2010d000
[  102.447057] iwlwifi 0000:00:14.3: Detected Intel(R) Wi-Fi 6E AX211 160MHz
[  102.447150] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-so-a0-gf-a0-89.ucode failed with error -2
[  102.447167] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-so-a0-gf-a0-88.ucode failed with error -2
[  102.447178] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-so-a0-gf-a0-87.ucode failed with error -2
[  102.451327] iwlwifi 0000:00:14.3: TLV_FW_FSEQ_VERSION: FSEQ Version: 0.0.2.41
[  102.451597] iwlwifi 0000:00:14.3: loaded firmware version 86.fb5c9aeb.0 so-a0-gf-a0-86.ucode op_mode iwlmvm
[  102.467335] intel_rapl_common: Found RAPL domain package
[  102.473293] spd5118 2-0050: DDR5 temperature sensor: vendor 0x06:0x32 revision 1.6
[  102.490821] Bluetooth: Core ver 2.22
[  102.490908] NET: Registered PF_BLUETOOTH protocol family
[  102.490914] Bluetooth: HCI device and connection manager initialized
[  102.490935] Bluetooth: HCI socket layer initialized
[  102.490938] Bluetooth: L2CAP socket layer initialized
[  102.490958] Bluetooth: SCO socket layer initialized
[  102.500921] Creating 1 MTD partitions on "0000:00:1f.5":
[  102.500924] 0x000000000000-0x000002000000 : "BIOS"
[  102.504749] mc: Linux media interface: v0.10
[  102.508203] ite_829x: loading out-of-tree module taints kernel.
[  102.509620] ite_829x 0003:048D:8910.0001: hiddev0,hidraw0: USB HID v1.10 Device [ITE Tech. Inc. ITE Device(829x)] on usb-0000:00:14.0-7/input0
[  102.515713] videodev: Linux video capture interface: v2.00
[  102.520624] usbcore: registered new interface driver btusb
[  102.522043] Bluetooth: hci0: Device revision is 0
[  102.522047] Bluetooth: hci0: Secure boot is enabled
[  102.522049] Bluetooth: hci0: OTP lock is enabled
[  102.522050] Bluetooth: hci0: API lock is enabled
[  102.522050] Bluetooth: hci0: Debug lock is disabled
[  102.522051] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
[  102.522053] Bluetooth: hci0: Bootloader timestamp 2019.40 buildtype 1 build 38
[  102.523346] Bluetooth: hci0: DSM reset method type: 0x00
[  102.528936] Bluetooth: hci0: Found device firmware: intel/ibt-1040-0041.sfi
[  102.528948] Bluetooth: hci0: Boot Address: 0x100800
[  102.528949] Bluetooth: hci0: Firmware Version: 60-48.23
[  102.589785] MXM: GUID detected in BIOS
[  102.590001] pci 0000:02:00.0: optimus capabilities: enabled, status dynamic power, hda bios codec supported
[  102.590013] VGA switcheroo: detected Optimus DSM method \_SB_.PC00.PEG2.PEGP handle
[  102.590015] nouveau: detected PR support, will not use DSM
[  102.590603] nouveau 0000:02:00.0: NVIDIA AD104 (194000a1)
[  102.590876] usb 1-6: Found UVC 1.50 device Chicony USB2.0 Camera (04f2:b7e7)
[  102.594636] snd_hda_intel 0000:00:1f.3: enabling device (0000 -> 0002)
[  102.596192] snd_hda_intel 0000:02:00.1: enabling device (0000 -> 0002)
[  102.596506] snd_hda_intel 0000:02:00.1: Disabling MSI
[  102.596534] snd_hda_intel 0000:02:00.1: Handle vga_switcheroo audio client
[  102.600752] intel_tcc_cooling: Programmable TCC Offset detected
[  102.613513] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_1 due to name collision
[  102.613524] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_2 due to name collision
[  102.613532] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_3 due to name collision
[  102.613542] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_4 due to name collision
[  102.613555] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_5 due to name collision
[  102.613570] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_6 due to name collision
[  102.613586] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_7 due to name collision
[  102.613603] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_8 due to name collision
[  102.613620] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_9 due to name collision
[  102.613639] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_10 due to name collision
[  102.613655] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_11 due to name collision
[  102.613669] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_12 due to name collision
[  102.613691] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_13 due to name collision
[  102.613715] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_14 due to name collision
[  102.613732] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_15 due to name collision
[  102.613757] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_16 due to name collision
[  102.613781] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_17 due to name collision
[  102.613808] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_18 due to name collision
[  102.613835] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_19 due to name collision
[  102.613864] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_20 due to name collision
[  102.613893] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_21 due to name collision
[  102.613925] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_22 due to name collision
[  102.613960] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_23 due to name collision
[  102.613993] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_24 due to name collision
[  102.614028] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_25 due to name collision
[  102.614070] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_26 due to name collision
[  102.614101] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_27 due to name collision
[  102.614129] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_28 due to name collision
[  102.614157] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_29 due to name collision
[  102.614186] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_30 due to name collision
[  102.614216] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_31 due to name collision
[  102.614247] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_32 due to name collision
[  102.614279] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_33 due to name collision
[  102.614313] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_34 due to name collision
[  102.614348] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_35 due to name collision
[  102.614385] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_36 due to name collision
[  102.614424] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_37 due to name collision
[  102.614473] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_38 due to name collision
[  102.614530] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_39 due to name collision
[  102.614597] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_40 due to name collision
[  102.614656] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_41 due to name collision
[  102.614705] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_42 due to name collision
[  102.614762] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_43 due to name collision
[  102.614811] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_44 due to name collision
[  102.614879] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_45 due to name collision
[  102.614956] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_46 due to name collision
[  102.615021] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_47 due to name collision
[  102.615098] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_48 due to name collision
[  102.615176] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_49 due to name collision
[  102.615243] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_50 due to name collision
[  102.615307] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_51 due to name collision
[  102.615369] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_52 due to name collision
[  102.615435] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_53 due to name collision
[  102.615510] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_54 due to name collision
[  102.615593] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_55 due to name collision
[  102.615668] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_56 due to name collision
[  102.615739] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_57 due to name collision
[  102.615815] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_58 due to name collision
[  102.615891] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_59 due to name collision
[  102.615973] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_60 due to name collision
[  102.616051] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_61 due to name collision
[  102.616134] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_62 due to name collision
[  102.616220] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_63 due to name collision
[  102.616312] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_64 due to name collision
[  102.616409] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_65 due to name collision
[  102.616504] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_66 due to name collision
[  102.616598] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_67 due to name collision
[  102.616691] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_68 due to name collision
[  102.616803] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_69 due to name collision
[  102.616918] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC1220: line_outs=1 (0x1b/0x0/0x0/0x0/0x0) type:speaker
[  102.616927] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_70 due to name collision
[  102.616932] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[  102.616938] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=1 (0x14/0x0/0x0/0x0/0x0)
[  102.616939] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=0x0
[  102.616942] snd_hda_codec_realtek hdaudioC0D0:    dig-out=0x1e/0x0
[  102.616943] snd_hda_codec_realtek hdaudioC0D0:    inputs:
[  102.616944] snd_hda_codec_realtek hdaudioC0D0:      Mic=0x18
[  102.616945] snd_hda_codec_realtek hdaudioC0D0:      Internal Mic=0x12
[  102.617057] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_71 due to name collision
[  102.617180] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_72 due to name collision
[  102.617303] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_73 due to name collision
[  102.617423] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_74 due to name collision
[  102.617564] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_75 due to name collision
[  102.617708] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_76 due to name collision
[  102.617843] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_77 due to name collision
[  102.617991] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_78 due to name collision
[  102.618126] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_79 due to name collision
[  102.618287] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_80 due to name collision
[  102.618437] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_81 due to name collision
[  102.618629] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_82 due to name collision
[  102.619090] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_83 due to name collision
[  102.619226] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_84 due to name collision
[  102.619473] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_85 due to name collision
[  102.619629] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_86 due to name collision
[  102.619923] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_87 due to name collision
[  102.619962] input: HDA NVidia HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:01.1/0000:02:00.1/sound/card1/input15
[  102.620069] input: HDA NVidia HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:01.1/0000:02:00.1/sound/card1/input16
[  102.620108] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_88 due to name collision
[  102.620161] input: HDA NVidia HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:01.1/0000:02:00.1/sound/card1/input17
[  102.620267] input: HDA NVidia HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:01.1/0000:02:00.1/sound/card1/input18
[  102.620305] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_89 due to name collision
[  102.620507] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_90 due to name collision
[  102.620664] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_91 due to name collision
[  102.620831] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_92 due to name collision
[  102.620993] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_93 due to name collision
[  102.621178] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_94 due to name collision
[  102.622417] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_95 due to name collision
[  102.622741] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_96 due to name collision
[  102.623878] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_97 due to name collision
[  102.624201] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_98 due to name collision
[  102.624592] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_99 due to name collision
[  102.624778] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_100 due to name collision
[  102.625932] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_101 due to name collision
[  102.626616] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_102 due to name collision
[  102.627709] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_103 due to name collision
[  102.628033] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_104 due to name collision
[  102.628330] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_105 due to name collision
[  102.628660] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_106 due to name collision
[  102.628992] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_107 due to name collision
[  102.629304] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_108 due to name collision
[  102.629633] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_109 due to name collision
[  102.629897] input: HDA Intel PCH Mic as /devices/pci0000:00/0000:00:1f.3/sound/card0/input19
[  102.629912] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_110 due to name collision
[  102.629935] input: HDA Intel PCH Headphone as /devices/pci0000:00/0000:00:1f.3/sound/card0/input20
[  102.630140] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_111 due to name collision
[  102.630365] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_112 due to name collision
[  102.630592] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_113 due to name collision
[  102.630816] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_114 due to name collision
[  102.631046] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_115 due to name collision
[  102.631276] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_116 due to name collision
[  102.631515] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_117 due to name collision
[  102.631808] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_118 due to name collision
[  102.632052] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_119 due to name collision
[  102.646280] usb 1-6: Found UVC 1.50 device Chicony USB2.0 Camera (04f2:b7e7)
[  102.657018] usbcore: registered new interface driver uvcvideo
[  102.707340] iwlwifi 0000:00:14.3: WFPM_UMAC_PD_NOTIFICATION: 0x20
[  102.707395] iwlwifi 0000:00:14.3: WFPM_LMAC2_PD_NOTIFICATION: 0x1f
[  102.707454] iwlwifi 0000:00:14.3: WFPM_AUTH_KEY_0: 0x90
[  102.707496] iwlwifi 0000:00:14.3: CNVI_SCU_SEQ_DATA_DW9: 0x0
[  102.708208] iwlwifi 0000:00:14.3: loaded PNVM version e28bb9d7
[  102.708348] iwlwifi 0000:00:14.3: RFIm is deactivated, reason = 5
[  102.725141] iwlwifi 0000:00:14.3: Detected RF GF, rfid=0x2010d000
[  102.793901] iwlwifi 0000:00:14.3: base HW address: dc:97:ba:75:8a:32
[  102.825852] iwlwifi 0000:00:14.3 wlp0s20f3: renamed from wlan0
[  102.960854] nouveau 0000:02:00.0: bios: version 95.04.63.00.24
[  102.974192] nouveau 0000:02:00.0: vgaarb: deactivate vga console
[  103.255378] BTRFS: device label kfocus_boot devid 1 transid 457 /dev/nvme0n1p2 (259:2) scanned by mount (1402)
[  103.255864] BTRFS info (device nvme0n1p2): first mount of filesystem abbbc711-9904-466b-8a35-783f0d19bf50
[  103.255879] BTRFS info (device nvme0n1p2): using crc32c (crc32c-intel) checksum algorithm
[  103.255882] BTRFS info (device nvme0n1p2): using free-space-tree
[  103.267849] Adding 524284k swap on /swap/swapfile.  Priority:-2 extents:2 across:1686444k SS
[  103.292944] audit: type=1400 audit(1730232631.886:2): apparmor="STATUS" operation="profile_load" profile="unconfined" name="ch-run" pid=1469 comm="apparmor_parser"
[  103.292955] audit: type=1400 audit(1730232631.886:3): apparmor="STATUS" operation="profile_load" profile="unconfined" name="1password" pid=1458 comm="apparmor_parser"
[  103.293102] audit: type=1400 audit(1730232631.886:4): apparmor="STATUS" operation="profile_load" profile="unconfined" name="cam" pid=1467 comm="apparmor_parser"
[  103.293106] audit: type=1400 audit(1730232631.886:5): apparmor="STATUS" operation="profile_load" profile="unconfined" name="chrome" pid=1470 comm="apparmor_parser"
[  103.293131] audit: type=1400 audit(1730232631.886:6): apparmor="STATUS" operation="profile_load" profile="unconfined" name="QtWebEngineProcess" pid=1461 comm="apparmor_parser"
[  103.293193] audit: type=1400 audit(1730232631.886:7): apparmor="STATUS" operation="profile_load" profile="unconfined" name="brave" pid=1464 comm="apparmor_parser"
[  103.293206] audit: type=1400 audit(1730232631.886:8): apparmor="STATUS" operation="profile_load" profile="unconfined" name="vscode" pid=1471 comm="apparmor_parser"
[  103.293226] audit: type=1400 audit(1730232631.886:9): apparmor="STATUS" operation="profile_load" profile="unconfined" name="flatpak" pid=1479 comm="apparmor_parser"
[  103.293249] audit: type=1400 audit(1730232631.886:10): apparmor="STATUS" operation="profile_load" profile="unconfined" name=4D6F6E676F444220436F6D70617373 pid=1460 comm="apparmor_parser"
[  103.293273] audit: type=1400 audit(1730232631.886:11): apparmor="STATUS" operation="profile_load" profile="unconfined" name="crun" pid=1473 comm="apparmor_parser"
[  103.958216] Bluetooth: hci0: Waiting for firmware download to complete
[  103.959082] Bluetooth: hci0: Firmware loaded in 1396621 usecs
[  103.959217] Bluetooth: hci0: Waiting for device to boot
[  103.973202] nouveau 0000:02:00.0: drm: VRAM: 12282 MiB
[  103.973204] nouveau 0000:02:00.0: drm: GART: 536870912 MiB
[  103.975088] Bluetooth: hci0: Malformed MSFT vendor event: 0x02
[  103.975091] Bluetooth: hci0: Device booted in 15598 usecs
[  103.977282] Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-1040-0041.ddc
[  103.979171] Bluetooth: hci0: Applying Intel DDC parameters completed
[  103.982193] Bluetooth: hci0: Firmware timestamp 2023.48 buildtype 1 build 75324
[  103.982206] Bluetooth: hci0: Firmware SHA1: 0x23bac558
[  103.986164] Bluetooth: hci0: Fseq status: Success (0x00)
[  103.986175] Bluetooth: hci0: Fseq executed: 00.00.02.41
[  103.986181] Bluetooth: hci0: Fseq BT Top: 00.00.02.41
[  104.030128] nouveau 0000:02:00.0: drm: MM: using COPY for buffer copies
[  104.063230] snd_hda_intel 0000:02:00.1: bound 0000:02:00.0 (ops disp50xx_modifiers [nouveau])
[  104.067985] acpi device:06: registered as cooling_device36
[  104.068193] [drm] Initialized nouveau 1.4.0 for 0000:02:00.0 on minor 1
[  104.085906] fbcon: nouveaudrmfb (fb0) is primary device
[  104.085908] fbcon: Deferring console take-over
[  104.085909] nouveau 0000:02:00.0: [drm] fb0: nouveaudrmfb frame buffer device
[  104.115237] snd_hda_codec_hdmi hdaudioC1D0: HDMI: pin NID 0x4 not registered
[  104.373953] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[  104.373956] Bluetooth: BNEP filters: protocol multicast
[  104.373959] Bluetooth: BNEP socket layer initialized
[  104.374745] Bluetooth: MGMT ver 1.23
[  104.379260] NET: Registered PF_ALG protocol family
[  104.439179] loop9: detected capacity change from 0 to 8
[  104.442351] NET: Registered PF_QIPCRTR protocol family
[  105.131537] iwlwifi 0000:00:14.3: WFPM_UMAC_PD_NOTIFICATION: 0x20
[  105.131567] iwlwifi 0000:00:14.3: WFPM_LMAC2_PD_NOTIFICATION: 0x1f
[  105.131577] iwlwifi 0000:00:14.3: WFPM_AUTH_KEY_0: 0x90
[  105.131587] iwlwifi 0000:00:14.3: CNVI_SCU_SEQ_DATA_DW9: 0x0
[  105.132694] iwlwifi 0000:00:14.3: RFIm is deactivated, reason = 5
[  105.233077] iwlwifi 0000:00:14.3: Registered PHC clock: iwlwifi-PTP, with index: 1
[  115.523704] snd_hda_codec_hdmi hdaudioC1D0: HDMI: pin NID 0x4 not registered
[  116.709343] igc 0000:03:00.0 enp3s0: NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
[  117.466629] Bluetooth: RFCOMM TTY layer initialized
[  117.466633] Bluetooth: RFCOMM socket layer initialized
[  117.466635] Bluetooth: RFCOMM ver 1.11
[  586.745645] systemd-journald[816]: /var/log/journal/86d43f3761a64806a644a560706664c5/user-1000.journal: Journal file uses a different sequence number ID, rotating.
[  587.696757] warning: `kded5' uses wireless extensions which will stop working for Wi-Fi 7 hardware; use nl80211
[  587.946334] snd_hda_codec_hdmi hdaudioC1D0: HDMI: pin NID 0x4 not registered
[  588.667533] thunderbolt 0000:06:00.0: control channel starting...
[  588.667539] thunderbolt 0000:06:00.0: starting TX ring 0
[  588.667547] thunderbolt 0000:06:00.0: enabling interrupt at register 0x38200 bit 0 (0x0 -> 0x1)
[  588.667550] thunderbolt 0000:06:00.0: starting RX ring 0
[  588.667558] thunderbolt 0000:06:00.0: enabling interrupt at register 0x38200 bit 12 (0x1 -> 0x1001)
[  588.667558] xhci_hcd 0000:2d:00.0: xHC error in resume, USBSTS 0x401, Reinit
[  588.667564] thunderbolt 0000:06:00.0: 0: resuming switch
[  588.667565] usb usb3: root hub lost power or was reset
[  588.667567] thunderbolt 0000:06:00.0: restoring Switch at 0x0 (depth: 0, up port: 15)
[  588.667568] usb usb4: root hub lost power or was reset
[  588.667735] thunderbolt 0000:06:00.0: 0: disabling wakeup
[  588.676625] thunderbolt 0000:06:00.0: 0: TMU: supports uni-directional mode
[  588.676630] thunderbolt 0000:06:00.0: 0: TMU: supports enhanced uni-directional mode
[  588.676758] thunderbolt 0000:06:00.0: 0: TMU: current mode: off
[  588.676761] thunderbolt 0000:06:00.0: 0: TMU: mode change off -> bi-directional, HiFi requested
[  588.677270] thunderbolt 0000:06:00.0: 0: TMU: mode set to: bi-directional, HiFi
[  588.677514] thunderbolt 0000:06:00.0: acking hot plug event on 0:13
[  588.677645] thunderbolt 0000:06:00.0: acking hot plug event on 0:14
[  588.677773] thunderbolt 0000:06:00.0: acking hot plug event on 0:16
[  588.679650] thunderbolt 0000:06:00.0: 0:13: DP IN resource available after hotplug
[  588.679654] thunderbolt 0000:06:00.0: looking for DP IN <-> DP OUT pairs:
[  588.679750] thunderbolt 0000:06:00.0: 0:13: DP IN available
[  588.679752] thunderbolt 0000:06:00.0: 0:13: no suitable DP OUT adapter available, not tunneling
[  588.680518] thunderbolt 0000:06:00.0: 0:14: DP IN resource available after hotplug
[  588.680521] thunderbolt 0000:06:00.0: looking for DP IN <-> DP OUT pairs:
[  588.680644] thunderbolt 0000:06:00.0: 0:13: DP IN available
[  588.680645] thunderbolt 0000:06:00.0: 0:13: no suitable DP OUT adapter available, not tunneling
[  588.680769] thunderbolt 0000:06:00.0: 0:14: DP IN available
[  588.680770] thunderbolt 0000:06:00.0: 0:14: no suitable DP OUT adapter available, not tunneling
[  589.251306] wlp0s20f3: authenticate with a0:55:1f:2f:2c:93 (local address=dc:97:ba:75:8a:32)
[  589.252998] wlp0s20f3: send auth to a0:55:1f:2f:2c:93 (try 1/3)
[  589.288218] wlp0s20f3: authenticate with a0:55:1f:2f:2c:93 (local address=dc:97:ba:75:8a:32)
[  589.288653] wlp0s20f3: send auth to a0:55:1f:2f:2c:93 (try 1/3)
[  589.290158] wlp0s20f3: authenticated
[  589.290684] wlp0s20f3: associate with a0:55:1f:2f:2c:93 (try 1/3)
[  589.300630] wlp0s20f3: RX AssocResp from a0:55:1f:2f:2c:93 (capab=0x1011 status=0 aid=8)
[  589.306597] wlp0s20f3: associated
[  604.466379] thunderbolt 0000:06:00.0: 0: suspending switch
[  604.466396] thunderbolt 0000:06:00.0: 0: enabling wakeup: 0x3f
[  604.467418] thunderbolt 0000:06:00.0: stopping RX ring 0
[  604.467441] thunderbolt 0000:06:00.0: disabling interrupt at register 0x38200 bit 12 (0x1001 -> 0x1)
[  604.467714] thunderbolt 0000:06:00.0: stopping TX ring 0
[  604.467731] thunderbolt 0000:06:00.0: disabling interrupt at register 0x38200 bit 0 (0x1 -> 0x0)
[  604.467755] thunderbolt 0000:06:00.0: control channel stopped
[ 1410.603072] usb 1-9: new full-speed USB device number 5 using xhci_hcd
[ 1410.741493] usb 1-9: not running at top speed; connect to a high speed hub
[ 1410.756048] usb 1-9: New USB device found, idVendor=2109, idProduct=0103, bcdDevice= 2.00
[ 1410.756060] usb 1-9: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[ 1410.756064] usb 1-9: Product: USB 2.0 BILLBOARD             
[ 1410.756067] usb 1-9: Manufacturer: VIA Technologies Inc.         
[ 1410.756070] usb 1-9: SerialNumber: 0000000000000001
[ 1461.373448] snd_hda_codec_hdmi hdaudioC1D0: HDMI: pin NID 0x4 not registered
[ 1590.638802] usb 1-10: new high-speed USB device number 6 using xhci_hcd
[ 1590.780973] usb 1-10: New USB device found, idVendor=0bda, idProduct=5411, bcdDevice= 1.49
[ 1590.780986] usb 1-10: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[ 1590.780989] usb 1-10: Product: 4-Port USB 2.0 Hub
[ 1590.780992] usb 1-10: Manufacturer: Generic
[ 1590.784399] hub 1-10:1.0: USB hub found
[ 1590.785781] hub 1-10:1.0: 4 ports detected
[ 1591.576895] usb 1-10.3: new full-speed USB device number 7 using xhci_hcd
[ 1591.664653] usb 1-10.3: New USB device found, idVendor=043e, idProduct=9a39, bcdDevice= 4.11
[ 1591.664674] usb 1-10.3: New USB device strings: Mfr=1, Product=3, SerialNumber=4
[ 1591.664679] usb 1-10.3: Product: LG Monitor Controls
[ 1591.664683] usb 1-10.3: Manufacturer: LG Electronics Inc.
[ 1591.664687] usb 1-10.3: SerialNumber: 005INTX1F153
[ 1591.671591] hid-generic 0003:043E:9A39.0003: hiddev1,hidraw2: USB HID v1.11 Device [LG Electronics Inc. LG Monitor Controls] on usb-0000:00:14.0-10.3/input0
[ 1668.565788] thunderbolt 0000:06:00.0: control channel starting...
[ 1668.565803] thunderbolt 0000:06:00.0: starting TX ring 0
[ 1668.565820] thunderbolt 0000:06:00.0: enabling interrupt at register 0x38200 bit 0 (0x0 -> 0x1)
[ 1668.565828] thunderbolt 0000:06:00.0: starting RX ring 0
[ 1668.565838] thunderbolt 0000:06:00.0: enabling interrupt at register 0x38200 bit 12 (0x1 -> 0x1001)
[ 1668.565849] thunderbolt 0000:06:00.0: 0: resuming switch
[ 1668.565853] thunderbolt 0000:06:00.0: restoring Switch at 0x0 (depth: 0, up port: 15)
[ 1668.566749] xhci_hcd 0000:2d:00.0: xHC error in resume, USBSTS 0x401, Reinit
[ 1668.566755] usb usb3: root hub lost power or was reset
[ 1668.566760] usb usb4: root hub lost power or was reset
[ 1668.568827] thunderbolt 0000:06:00.0: 0: disabling wakeup
[ 1668.577180] thunderbolt 0000:06:00.0: acking hot plug event on 0:16
[ 1668.577822] thunderbolt 0000:06:00.0: 0: TMU: supports uni-directional mode
[ 1668.577829] thunderbolt 0000:06:00.0: 0: TMU: supports enhanced uni-directional mode
[ 1668.577947] thunderbolt 0000:06:00.0: 0: TMU: current mode: off
[ 1668.577952] thunderbolt 0000:06:00.0: 0: TMU: mode change off -> bi-directional, HiFi requested
[ 1668.578458] thunderbolt 0000:06:00.0: 0: TMU: mode set to: bi-directional, HiFi
[ 1668.579359] thunderbolt 0000:06:00.0: 0:13: enter redrive mode, keeping powered
[ 1668.579997] thunderbolt 0000:06:00.0: 0:14: enter redrive mode, keeping powered
[ 1751.666669] snd_hda_codec_hdmi hdaudioC1D0: HDMI: pin NID 0x4 not registered
[ 1781.122684] i2c_hid_acpi i2c-FTCS1000:01: i2c_hid_get_input: incomplete report (12/3084)

--MP_/0APf0mG6H/xJK_aO4=o6w9b
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename=2024-10-29_6.12.0-rc5_tbt-barlow-ridge-02-dmesg.txt

[    0.000000] Linux version 6.12.0-rc5 (qa@qa-m2) (gcc (Ubuntu 13.2.0-23ubuntu4) 13.2.0, GNU ld (GNU Binutils for Ubuntu) 2.42) #1 SMP PREEMPT_DYNAMIC Tue Oct 29 09:14:25 PDT 2024
[    0.000000] Command line: BOOT_IMAGE=/@boot/vmlinuz-6.12.0-rc5 root=UUID=aa8cb093-9cb3-4cc7-b44e-4bff76ca37fb ro rootflags=subvol=@ quiet cryptdevice=UUID=1a8d8cdb-8d8f-4689-b744-8f32d2067f56:luks-1a8d8cdb-8d8f-4689-b744-8f32d2067f56 root=/dev/mapper/luks-1a8d8cdb-8d8f-4689-b744-8f32d2067f56 spla vt.handoff=7
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
[    0.000000] e820: update [mem 0x2b4c3018-0x2b4e7e57] usable ==> usable
[    0.000000] extended physical RAM map:
[    0.000000] reserve setup_data: [mem 0x0000000000000000-0x000000000009efff] usable
[    0.000000] reserve setup_data: [mem 0x000000000009f000-0x00000000000fffff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000000100000-0x000000002b4c3017] usable
[    0.000000] reserve setup_data: [mem 0x000000002b4c3018-0x000000002b4e7e57] usable
[    0.000000] reserve setup_data: [mem 0x000000002b4e7e58-0x0000000030228fff] usable
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
[    0.000000] efi: ACPI=0x37afe000 ACPI 2.0=0x37afe014 TPMFinalLog=0x37866000 SMBIOS=0x32fda000 MEMATTR=0x2ba24018 ESRT=0x2ca20798 MOKvar=0x32f86000 INITRD=0x2bd95418 RNG=0x37a24018 TPMEventLog=0x37a18018 
[    0.000000] random: crng init done
[    0.000000] efi: Remove mem83: MMIO range=[0xc0000000-0xcfffffff] (256MB) from e820 map
[    0.000000] e820: remove [mem 0xc0000000-0xcfffffff] reserved
[    0.000000] efi: Remove mem85: MMIO range=[0xff000000-0xffffffff] (16MB) from e820 map
[    0.000000] e820: remove [mem 0xff000000-0xffffffff] reserved
[    0.000000] SMBIOS 3.4 present.
[    0.000000] DMI: Notebook X370SNx1/X370SNx1, BIOS 1.07.03aMIN29 09/18/2024
[    0.000000] DMI: Memory slots populated: 2/2
[    0.000000] tsc: Detected 2400.000 MHz processor
[    0.000000] tsc: Detected 2419.200 MHz TSC
[    0.000008] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000011] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000020] last_pfn = 0x8c0000 max_arch_pfn = 0x400000000
[    0.000025] MTRR map: 5 entries (3 fixed + 2 variable; max 23), built from 10 variable MTRRs
[    0.000028] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.000753] last_pfn = 0x37b00 max_arch_pfn = 0x400000000
[    0.009502] esrt: Reserving ESRT space from 0x000000002ca20798 to 0x000000002ca20820.
[    0.009511] e820: update [mem 0x2ca20000-0x2ca20fff] usable ==> reserved
[    0.009534] Using GB pages for direct mapping
[    0.009535] Incomplete global flushes, disabling PCID
[    0.010066] Secure boot disabled
[    0.010067] RAMDISK: [mem 0x1ad05000-0x1f5f6fff]
[    0.010141] ACPI: Early table checksum verification disabled
[    0.010145] ACPI: RSDP 0x0000000037AFE014 000024 (v02 INSYDE)
[    0.010151] ACPI: XSDT 0x0000000037A38188 00012C (v01 INSYDE ADL      00000002      01000013)
[    0.010159] ACPI: FACP 0x0000000037ADB000 000114 (v06 INSYDE ADL      00000002 ACPI 00040000)
[    0.010167] ACPI: DSDT 0x0000000037A4E000 089652 (v02 INSYDE ADL      00000002 ACPI 00040000)
[    0.010171] ACPI: FACS 0x000000003783E000 000040
[    0.010175] ACPI: UEFI 0x000000003798E000 0001CF (v01 INSYDE H2O BIOS 00000001 ACPI 00040000)
[    0.010179] ACPI: SSDT 0x0000000037AF3000 00908F (v02 DptfTb DptfTabl 00001000 INTL 20200717)
[    0.010183] ACPI: SSDT 0x0000000037AED000 005D34 (v02 CpuRef CpuSsdt  00003000 INTL 20200717)
[    0.010188] ACPI: SSDT 0x0000000037AEA000 00276F (v02 SaSsdt SaSsdt   00003000 INTL 20200717)
[    0.010191] ACPI: SSDT 0x0000000037AE6000 00328B (v02 INTEL  IgfxSsdt 00003000 INTL 20200717)
[    0.010194] ACPI: SSDT 0x0000000037AE5000 00077B (v02 INSYDE Tpm2Tabl 00001000 INTL 20200717)
[    0.010197] ACPI: TPM2 0x0000000037AE4000 00004C (v04 INSYDE ADL      00000002 ACPI 00040000)
[    0.010200] ACPI: SSDT 0x0000000037ADF000 003249 (v02 INTEL  DTbtSsdt 00001000 INTL 20200717)
[    0.010203] ACPI: SSDT 0x0000000037ADD000 0016A6 (v02 INSYDE UsbCTabl 00001000 INTL 20200717)
[    0.010206] ACPI: NHLT 0x0000000037ADC000 00002D (v00 INSYDE ADL      00000002 ACPI 00040000)
[    0.010210] ACPI: HPET 0x0000000037ADA000 000038 (v01 INSYDE ADL      00000002 ACPI 00040000)
[    0.010213] ACPI: APIC 0x0000000037AD9000 0001DC (v05 INSYDE ADL      00000002 ACPI 00040000)
[    0.010216] ACPI: MCFG 0x0000000037AD8000 00003C (v01 INSYDE ADL      00000002 ACPI 00040000)
[    0.010219] ACPI: SSDT 0x0000000037A48000 0054E4 (v02 INSYDE ADL      00000002      01000013)
[    0.010222] ACPI: WSMT 0x0000000037A47000 000028 (v01 INSYDE ADL      00000002 ACPI 00040000)
[    0.010225] ACPI: SSDT 0x0000000037A45000 0015FD (v02 INSYDE PtidDevc 00001000 INTL 20200717)
[    0.010228] ACPI: SSDT 0x0000000037A3B000 009573 (v02 INSYDE TbtTypeC 00000000 INTL 20200717)
[    0.010231] ACPI: DBGP 0x0000000037A3A000 000034 (v01 INSYDE ADL      00000002 ACPI 00040000)
[    0.010234] ACPI: DBG2 0x0000000037A39000 000054 (v00 INSYDE ADL      00000002 ACPI 00040000)
[    0.010238] ACPI: DMAR 0x0000000037AFD000 000050 (v01 INTEL  ICL      00000002 ACPI 00040000)
[    0.010241] ACPI: SSDT 0x0000000037A35000 002EE7 (v01 NvdRef NvdTabl  00001000 INTL 20200717)
[    0.010244] ACPI: SSDT 0x0000000037A34000 00020D (v01 NvdRef NvdDiscr 00001000 INTL 20200717)
[    0.010247] ACPI: SSDT 0x0000000037A33000 00064F (v01 NvdRef NvDisDds 00001000 INTL 20200717)
[    0.010250] ACPI: UEFI 0x000000003783B000 00063A (v01 INTEL  RstVmdE  00000000 ACPI 00040000)
[    0.010254] ACPI: UEFI 0x000000003783A000 00005C (v01 INTEL  RstVmdV  00000000 ACPI 00040000)
[    0.010257] ACPI: SSDT 0x0000000037A31000 001057 (v02 INTEL  xh_rplsb 00000000 INTL 20200717)
[    0.010260] ACPI: SSDT 0x0000000037A2D000 0039DA (v02 SocGpe SocGpe   00003000 INTL 20200717)
[    0.010263] ACPI: SSDT 0x0000000037A29000 0039DA (v02 SocCmn SocCmn   00003000 INTL 20200717)
[    0.010266] ACPI: SSDT 0x0000000037A28000 0000F8 (v02 INSYDE PcdTabl  00001000 INTL 20200717)
[    0.010269] ACPI: FPDT 0x0000000037A27000 000044 (v01 INSYDE ADL      00000002 ACPI 00040000)
[    0.010272] ACPI: PHAT 0x0000000037A25000 0005ED (v01 INSYDE ADL      00000005 ACPI 00040000)
[    0.010276] ACPI: BGRT 0x0000000037A26000 000038 (v01 INSYDE H2O BIOS 00000001 ACPI 00040000)
[    0.010278] ACPI: Reserving FACP table memory at [mem 0x37adb000-0x37adb113]
[    0.010280] ACPI: Reserving DSDT table memory at [mem 0x37a4e000-0x37ad7651]
[    0.010281] ACPI: Reserving FACS table memory at [mem 0x3783e000-0x3783e03f]
[    0.010282] ACPI: Reserving UEFI table memory at [mem 0x3798e000-0x3798e1ce]
[    0.010283] ACPI: Reserving SSDT table memory at [mem 0x37af3000-0x37afc08e]
[    0.010284] ACPI: Reserving SSDT table memory at [mem 0x37aed000-0x37af2d33]
[    0.010285] ACPI: Reserving SSDT table memory at [mem 0x37aea000-0x37aec76e]
[    0.010286] ACPI: Reserving SSDT table memory at [mem 0x37ae6000-0x37ae928a]
[    0.010287] ACPI: Reserving SSDT table memory at [mem 0x37ae5000-0x37ae577a]
[    0.010287] ACPI: Reserving TPM2 table memory at [mem 0x37ae4000-0x37ae404b]
[    0.010288] ACPI: Reserving SSDT table memory at [mem 0x37adf000-0x37ae2248]
[    0.010289] ACPI: Reserving SSDT table memory at [mem 0x37add000-0x37ade6a5]
[    0.010290] ACPI: Reserving NHLT table memory at [mem 0x37adc000-0x37adc02c]
[    0.010291] ACPI: Reserving HPET table memory at [mem 0x37ada000-0x37ada037]
[    0.010292] ACPI: Reserving APIC table memory at [mem 0x37ad9000-0x37ad91db]
[    0.010293] ACPI: Reserving MCFG table memory at [mem 0x37ad8000-0x37ad803b]
[    0.010294] ACPI: Reserving SSDT table memory at [mem 0x37a48000-0x37a4d4e3]
[    0.010294] ACPI: Reserving WSMT table memory at [mem 0x37a47000-0x37a47027]
[    0.010295] ACPI: Reserving SSDT table memory at [mem 0x37a45000-0x37a465fc]
[    0.010296] ACPI: Reserving SSDT table memory at [mem 0x37a3b000-0x37a44572]
[    0.010297] ACPI: Reserving DBGP table memory at [mem 0x37a3a000-0x37a3a033]
[    0.010298] ACPI: Reserving DBG2 table memory at [mem 0x37a39000-0x37a39053]
[    0.010299] ACPI: Reserving DMAR table memory at [mem 0x37afd000-0x37afd04f]
[    0.010300] ACPI: Reserving SSDT table memory at [mem 0x37a35000-0x37a37ee6]
[    0.010301] ACPI: Reserving SSDT table memory at [mem 0x37a34000-0x37a3420c]
[    0.010301] ACPI: Reserving SSDT table memory at [mem 0x37a33000-0x37a3364e]
[    0.010302] ACPI: Reserving UEFI table memory at [mem 0x3783b000-0x3783b639]
[    0.010303] ACPI: Reserving UEFI table memory at [mem 0x3783a000-0x3783a05b]
[    0.010304] ACPI: Reserving SSDT table memory at [mem 0x37a31000-0x37a32056]
[    0.010305] ACPI: Reserving SSDT table memory at [mem 0x37a2d000-0x37a309d9]
[    0.010306] ACPI: Reserving SSDT table memory at [mem 0x37a29000-0x37a2c9d9]
[    0.010307] ACPI: Reserving SSDT table memory at [mem 0x37a28000-0x37a280f7]
[    0.010308] ACPI: Reserving FPDT table memory at [mem 0x37a27000-0x37a27043]
[    0.010309] ACPI: Reserving PHAT table memory at [mem 0x37a25000-0x37a255ec]
[    0.010309] ACPI: Reserving BGRT table memory at [mem 0x37a26000-0x37a26037]
[    0.010559] No NUMA configuration found
[    0.010560] Faking a node at [mem 0x0000000000000000-0x00000008bfffffff]
[    0.010569] NODE_DATA(0) allocated [mem 0x8bffd5680-0x8bfffffff]
[    0.010830] Zone ranges:
[    0.010831]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.010833]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.010835]   Normal   [mem 0x0000000100000000-0x00000008bfffffff]
[    0.010836]   Device   empty
[    0.010837] Movable zone start for each node
[    0.010839] Early memory node ranges
[    0.010839]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.010841]   node   0: [mem 0x0000000000100000-0x0000000030228fff]
[    0.010843]   node   0: [mem 0x0000000030b29000-0x000000003293efff]
[    0.010844]   node   0: [mem 0x0000000037aff000-0x0000000037afffff]
[    0.010844]   node   0: [mem 0x0000000100000000-0x00000008bfffffff]
[    0.010848] Initmem setup node 0 [mem 0x0000000000001000-0x00000008bfffffff]
[    0.010854] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.010877] On node 0, zone DMA: 97 pages in unavailable ranges
[    0.012438] On node 0, zone DMA32: 2304 pages in unavailable ranges
[    0.012668] On node 0, zone DMA32: 20928 pages in unavailable ranges
[    0.055118] On node 0, zone Normal: 1280 pages in unavailable ranges
[    0.055805] ACPI: PM-Timer IO Port: 0x1808
[    0.055818] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.055820] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.055821] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.055821] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.055822] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
[    0.055823] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[    0.055823] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
[    0.055824] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
[    0.055825] ACPI: LAPIC_NMI (acpi_id[0x09] high edge lint[0x1])
[    0.055825] ACPI: LAPIC_NMI (acpi_id[0x0a] high edge lint[0x1])
[    0.055826] ACPI: LAPIC_NMI (acpi_id[0x0b] high edge lint[0x1])
[    0.055827] ACPI: LAPIC_NMI (acpi_id[0x0c] high edge lint[0x1])
[    0.055827] ACPI: LAPIC_NMI (acpi_id[0x0d] high edge lint[0x1])
[    0.055828] ACPI: LAPIC_NMI (acpi_id[0x0e] high edge lint[0x1])
[    0.055829] ACPI: LAPIC_NMI (acpi_id[0x0f] high edge lint[0x1])
[    0.055829] ACPI: LAPIC_NMI (acpi_id[0x10] high edge lint[0x1])
[    0.055830] ACPI: LAPIC_NMI (acpi_id[0x11] high edge lint[0x1])
[    0.055831] ACPI: LAPIC_NMI (acpi_id[0x12] high edge lint[0x1])
[    0.055832] ACPI: LAPIC_NMI (acpi_id[0x13] high edge lint[0x1])
[    0.055832] ACPI: LAPIC_NMI (acpi_id[0x14] high edge lint[0x1])
[    0.055833] ACPI: LAPIC_NMI (acpi_id[0x15] high edge lint[0x1])
[    0.055834] ACPI: LAPIC_NMI (acpi_id[0x16] high edge lint[0x1])
[    0.055834] ACPI: LAPIC_NMI (acpi_id[0x17] high edge lint[0x1])
[    0.055835] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.055876] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-119
[    0.055880] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.055882] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.055886] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.055888] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.055897] e820: update [mem 0x2b8a0000-0x2b95afff] usable ==> reserved
[    0.055911] TSC deadline timer available
[    0.055914] CPU topo: Max. logical packages:   1
[    0.055915] CPU topo: Max. logical dies:       1
[    0.055916] CPU topo: Max. dies per package:   1
[    0.055918] CPU topo: Max. threads per core:   2
[    0.055919] CPU topo: Num. cores per package:    24
[    0.055920] CPU topo: Num. threads per package:  32
[    0.055921] CPU topo: Allowing 32 present CPUs plus 0 hotplug CPUs
[    0.055937] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.055940] PM: hibernation: Registered nosave memory: [mem 0x0009f000-0x000fffff]
[    0.055942] PM: hibernation: Registered nosave memory: [mem 0x2b4c3000-0x2b4c3fff]
[    0.055943] PM: hibernation: Registered nosave memory: [mem 0x2b4e7000-0x2b4e7fff]
[    0.055945] PM: hibernation: Registered nosave memory: [mem 0x2b8a0000-0x2b95afff]
[    0.055946] PM: hibernation: Registered nosave memory: [mem 0x2ca20000-0x2ca20fff]
[    0.055948] PM: hibernation: Registered nosave memory: [mem 0x30229000-0x30b28fff]
[    0.055949] PM: hibernation: Registered nosave memory: [mem 0x3293f000-0x349defff]
[    0.055950] PM: hibernation: Registered nosave memory: [mem 0x349df000-0x3798efff]
[    0.055951] PM: hibernation: Registered nosave memory: [mem 0x3798f000-0x37afefff]
[    0.055952] PM: hibernation: Registered nosave memory: [mem 0x37b00000-0x3bffffff]
[    0.055953] PM: hibernation: Registered nosave memory: [mem 0x3c000000-0x3c7fffff]
[    0.055953] PM: hibernation: Registered nosave memory: [mem 0x3c800000-0x3cbfffff]
[    0.055954] PM: hibernation: Registered nosave memory: [mem 0x3cc00000-0x3cdfffff]
[    0.055955] PM: hibernation: Registered nosave memory: [mem 0x3ce00000-0x3fffffff]
[    0.055955] PM: hibernation: Registered nosave memory: [mem 0x40000000-0xfed1ffff]
[    0.055956] PM: hibernation: Registered nosave memory: [mem 0xfed20000-0xfed7ffff]
[    0.055957] PM: hibernation: Registered nosave memory: [mem 0xfed80000-0xffffffff]
[    0.055958] [mem 0x40000000-0xfed1ffff] available for PCI devices
[    0.055960] Booting paravirtualized kernel on bare hardware
[    0.055963] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.055976] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:32 nr_cpu_ids:32 nr_node_ids:1
[    0.057794] percpu: Embedded 88 pages/cpu s237568 r8192 d114688 u524288
[    0.057801] pcpu-alloc: s237568 r8192 d114688 u524288 alloc=1*2097152
[    0.057803] pcpu-alloc: [0] 00 01 02 03 [0] 04 05 06 07 
[    0.057808] pcpu-alloc: [0] 08 09 10 11 [0] 12 13 14 15 
[    0.057812] pcpu-alloc: [0] 16 17 18 19 [0] 20 21 22 23 
[    0.057816] pcpu-alloc: [0] 24 25 26 27 [0] 28 29 30 31 
[    0.057842] Kernel command line: BOOT_IMAGE=/@boot/vmlinuz-6.12.0-rc5 root=UUID=aa8cb093-9cb3-4cc7-b44e-4bff76ca37fb ro rootflags=subvol=@ quiet cryptdevice=UUID=1a8d8cdb-8d8f-4689-b744-8f32d2067f56:luks-1a8d8cdb-8d8f-4689-b744-8f32d2067f56 root=/dev/mapper/luks-1a8d8cdb-8d8f-4689-b744-8f32d2067f56 spla vt.handoff=7
[    0.057930] Unknown kernel command line parameters "spla BOOT_IMAGE=/@boot/vmlinuz-6.12.0-rc5 cryptdevice=UUID=1a8d8cdb-8d8f-4689-b744-8f32d2067f56:luks-1a8d8cdb-8d8f-4689-b744-8f32d2067f56", will be passed to user space.
[    0.060534] Dentry cache hash table entries: 4194304 (order: 13, 33554432 bytes, linear)
[    0.061813] Inode-cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
[    0.062227] Fallback order for Node 0: 0 
[    0.062232] Built 1 zonelists, mobility grouping on.  Total pages: 8331230
[    0.062233] Policy zone: Normal
[    0.062239] mem auto-init: stack:all(zero), heap alloc:on, heap free:off
[    0.062247] software IO TLB: area num 32.
[    0.133043] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=32, Nodes=1
[    0.133122] ftrace: allocating 56189 entries in 220 pages
[    0.143069] ftrace: allocated 220 pages with 5 groups
[    0.143904] Dynamic Preempt: voluntary
[    0.144104] rcu: Preemptible hierarchical RCU implementation.
[    0.144106] rcu: 	RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=32.
[    0.144108] 	Trampoline variant of Tasks RCU enabled.
[    0.144108] 	Rude variant of Tasks RCU enabled.
[    0.144109] 	Tracing variant of Tasks RCU enabled.
[    0.144110] rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
[    0.144111] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=32
[    0.144137] RCU Tasks: Setting shift to 5 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=32.
[    0.144140] RCU Tasks Rude: Setting shift to 5 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=32.
[    0.144143] RCU Tasks Trace: Setting shift to 5 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=32.
[    0.147091] NR_IRQS: 524544, nr_irqs: 2312, preallocated irqs: 16
[    0.147452] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.147722] Console: colour dummy device 80x25
[    0.147725] printk: legacy console [tty0] enabled
[    0.147797] ACPI: Core revision 20240827
[    0.148294] hpet: HPET dysfunctional in PC10. Force disabled.
[    0.148353] APIC: Switch to symmetric I/O mode setup
[    0.148355] DMAR: Host address width 39
[    0.148356] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
[    0.148365] DMAR: dmar0: reg_base_addr fed91000 ver 5:0 cap d2008c40660462 ecap f050da
[    0.148369] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 0
[    0.148370] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
[    0.148371] DMAR-IR: Queued invalidation will be enabled to support x2apic and Intr-remapping.
[    0.150200] DMAR-IR: Enabled IRQ remapping in x2apic mode
[    0.150202] x2apic enabled
[    0.150274] APIC: Switched APIC routing to: cluster x2apic
[    0.155231] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x22df1149949, max_idle_ns: 440795312789 ns
[    0.155239] Calibrating delay loop (skipped), value calculated using timer frequency.. 4838.40 BogoMIPS (lpj=2419200)
[    0.155309] CPU0: Thermal monitoring enabled (TM1)
[    0.155311] x86/cpu: User Mode Instruction Prevention (UMIP) activated
[    0.155468] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[    0.155470] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[    0.155474] process: using mwait in idle threads
[    0.155476] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.155480] Spectre V2 : Mitigation: Enhanced / Automatic IBRS
[    0.155481] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.155482] Spectre V2 : Spectre v2 / PBRSB-eIBRS: Retire a single CALL on VMEXIT
[    0.155484] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
[    0.155486] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
[    0.155487] Register File Data Sampling: Mitigation: Clear Register File
[    0.155499] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.155500] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.155501] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.155502] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys User registers'
[    0.155504] x86/fpu: Supporting XSAVE feature 0x800: 'Control-flow User registers'
[    0.155505] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.155506] x86/fpu: xstate_offset[9]:  832, xstate_sizes[9]:    8
[    0.155508] x86/fpu: xstate_offset[11]:  840, xstate_sizes[11]:   16
[    0.155509] x86/fpu: Enabled xstate features 0xa07, context size is 856 bytes, using 'compacted' format.
[    0.156236] Freeing SMP alternatives memory: 48K
[    0.156236] pid_max: default: 32768 minimum: 301
[    0.156236] LSM: initializing lsm=lockdown,capability,landlock,yama,apparmor,ima,evm
[    0.156236] landlock: Up and running.
[    0.156236] Yama: becoming mindful.
[    0.156236] AppArmor: AppArmor initialized
[    0.156236] Mount-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.156236] Mountpoint-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.156236] smpboot: CPU0: Intel(R) Core(TM) i9-14900HX (family: 0x6, model: 0xb7, stepping: 0x1)
[    0.156236] Performance Events: XSAVE Architectural LBR, PEBS fmt4+-baseline,  AnyThread deprecated, Alderlake Hybrid events, 32-deep LBR, full-width counters, Intel PMU driver.
[    0.156236] core: cpu_core PMU driver: 
[    0.156236] ... version:                5
[    0.156236] ... bit width:              48
[    0.156236] ... generic registers:      8
[    0.156236] ... value mask:             0000ffffffffffff
[    0.156236] ... max period:             00007fffffffffff
[    0.156236] ... fixed-purpose events:   4
[    0.156236] ... event mask:             0001000f000000ff
[    0.156236] signal: max sigframe size: 3632
[    0.156236] Estimated ratio of average max frequency by base frequency (times 1024): 2218
[    0.156236] rcu: Hierarchical SRCU implementation.
[    0.156236] rcu: 	Max phase no-delay instances is 400.
[    0.156236] Timer migration: 2 hierarchy levels; 8 children per group; 2 crossnode level
[    0.157989] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    0.159271] smp: Bringing up secondary CPUs ...
[    0.159393] smpboot: x86: Booting SMP configuration:
[    0.159394] .... node  #0, CPUs:        #2  #4  #6  #8 #10 #12 #14 #16 #17 #18 #19 #20 #21 #22 #23 #24 #25 #26 #27 #28 #29 #30 #31
[    0.008601] core: cpu_atom PMU driver: PEBS-via-PT 
[    0.008601] ... version:                5
[    0.008601] ... bit width:              48
[    0.008601] ... generic registers:      6
[    0.008601] ... value mask:             0000ffffffffffff
[    0.008601] ... max period:             00007fffffffffff
[    0.008601] ... fixed-purpose events:   3
[    0.008601] ... event mask:             000000070000003f
[    0.197263]   #1  #3  #5  #7  #9 #11 #13 #15
[    0.206329] smp: Brought up 1 node, 32 CPUs
[    0.206329] smpboot: Total of 32 processors activated (154828.80 BogoMIPS)
[    0.207613] Memory: 32501932K/33324920K available (22528K kernel code, 4585K rwdata, 14292K rodata, 5064K init, 4492K bss, 776940K reserved, 0K cma-reserved)
[    0.208733] devtmpfs: initialized
[    0.208733] x86/mm: Memory block size: 128MB
[    0.212056] ACPI: PM: Registering ACPI NVS region [mem 0x349df000-0x3798efff] (50003968 bytes)
[    0.212612] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.212664] futex hash table entries: 8192 (order: 7, 524288 bytes, linear)
[    0.212787] pinctrl core: initialized pinctrl subsystem
[    0.213038] PM: RTC time: 19:22:20, date: 2024-10-29
[    0.213580] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.214116] DMA: preallocated 4096 KiB GFP_KERNEL pool for atomic allocations
[    0.214473] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[    0.214829] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[    0.214840] audit: initializing netlink subsys (disabled)
[    0.214864] audit: type=2000 audit(1730229740.059:1): state=initialized audit_enabled=0 res=1
[    0.214864] thermal_sys: Registered thermal governor 'fair_share'
[    0.214864] thermal_sys: Registered thermal governor 'bang_bang'
[    0.214864] thermal_sys: Registered thermal governor 'step_wise'
[    0.214864] thermal_sys: Registered thermal governor 'user_space'
[    0.214864] thermal_sys: Registered thermal governor 'power_allocator'
[    0.214864] EISA bus registered
[    0.214864] cpuidle: using governor ladder
[    0.214864] cpuidle: using governor menu
[    0.215271] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.215402] PCI: ECAM [mem 0xc0000000-0xce0fffff] (base 0xc0000000) for domain 0000 [bus 00-e0]
[    0.215418] PCI: Using configuration type 1 for base access
[    0.215567] kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
[    0.224487] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    0.224491] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
[    0.224493] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.224494] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.225136] ACPI: Added _OSI(Module Device)
[    0.225136] ACPI: Added _OSI(Processor Device)
[    0.225136] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.225136] ACPI: Added _OSI(Processor Aggregator Device)
[    0.381940] ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PC00.MHBR], AE_NOT_FOUND (20240827/psargs-332)
[    0.381949] ACPI: Ignoring error and continuing table load
[    0.381974] ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PTID.PBAR], AE_NOT_FOUND (20240827/dsfield-500)
[    0.390022] ACPI: 18 ACPI AML tables successfully acquired and loaded
[    0.408817] ACPI: USB4 _OSC: OS supports USB3+ DisplayPort+ PCIe+ XDomain+
[    0.408820] ACPI: USB4 _OSC: OS controls USB3+ DisplayPort+ PCIe+ XDomain+
[    0.410659] ACPI: Dynamic OEM Table Load:
[    0.410671] ACPI: SSDT 0xFFFF9539841F3800 000394 (v02 PmRef  Cpu0Cst  00003001 INTL 20200717)
[    0.412530] ACPI: Dynamic OEM Table Load:
[    0.412539] ACPI: SSDT 0xFFFF9539841F9000 00053F (v02 PmRef  Cpu0Ist  00003000 INTL 20200717)
[    0.414418] ACPI: Dynamic OEM Table Load:
[    0.414426] ACPI: SSDT 0xFFFF953983A8FE00 0001AB (v02 PmRef  Cpu0Psd  00003000 INTL 20200717)
[    0.416203] ACPI: Dynamic OEM Table Load:
[    0.416210] ACPI: SSDT 0xFFFF9539841FF800 0004B5 (v02 PmRef  Cpu0Hwp  00003000 INTL 20200717)
[    0.418604] ACPI: Dynamic OEM Table Load:
[    0.418615] ACPI: SSDT 0xFFFF953984202000 001BAF (v02 PmRef  ApIst    00003000 INTL 20200717)
[    0.421381] ACPI: Dynamic OEM Table Load:
[    0.421390] ACPI: SSDT 0xFFFF953984206000 001038 (v02 PmRef  ApHwp    00003000 INTL 20200717)
[    0.423873] ACPI: Dynamic OEM Table Load:
[    0.423882] ACPI: SSDT 0xFFFF953984200000 001349 (v02 PmRef  ApPsd    00003000 INTL 20200717)
[    0.426404] ACPI: Dynamic OEM Table Load:
[    0.426412] ACPI: SSDT 0xFFFF95398420B000 000FBB (v02 PmRef  ApCst    00003000 INTL 20200717)
[    0.445766] ACPI: EC: EC started
[    0.445768] ACPI: EC: interrupt blocked
[    0.460992] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.460996] ACPI: \_SB_.PC00.LPCB.EC__: Boot DSDT EC used to handle transactions
[    0.460998] ACPI: Interpreter enabled
[    0.461088] ACPI: PM: (supports S0 S3 S4 S5)
[    0.461089] ACPI: Using IOAPIC for interrupt routing
[    0.463482] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.463483] PCI: Ignoring E820 reservations for host bridge windows
[    0.465295] ACPI: Enabled 11 GPEs in block 00 to 7F
[    0.467727] ACPI: \_SB_.PC00.PEG2.PG00: New power resource
[    0.496693] ACPI: \_SB_.PC00.XHCI.RHUB.HS14.BTRT: New power resource
[    0.496719] ACPI: \_SB_.PC00.XHCI.RHUB.HS14.DBTR: New power resource
[    0.506977] ACPI: \_SB_.PC00.CNVW.WRST: New power resource
[    0.512694] ACPI: \_SB_.PC00.RP09.PXP_: New power resource
[    0.539313] ACPI: \PIN_: New power resource
[    0.540211] ACPI: PCI Root Bridge [PC00] (domain 0000 [bus 00-e0])
[    0.540219] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
[    0.544090] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotplug PME AER PCIeCapability LTR DPC]
[    0.550181] PCI host bridge to bus 0000:00
[    0.550185] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.550188] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.550189] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.550191] pci_bus 0000:00: root bus resource [mem 0x40000000-0xbfffffff window]
[    0.550193] pci_bus 0000:00: root bus resource [mem 0x4000000000-0x7fffffffff window]
[    0.550195] pci_bus 0000:00: root bus resource [bus 00-e0]
[    0.550240] pci 0000:00:00.0: [8086:a702] type 00 class 0x060000 conventional PCI endpoint
[    0.550386] pci 0000:00:01.0: [8086:a70d] type 01 class 0x060400 PCIe Root Port
[    0.550404] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.550464] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    0.550491] pci 0000:00:01.0: PTM enabled (root), 4ns granularity
[    0.551292] pci 0000:00:01.1: [8086:a72d] type 01 class 0x060400 PCIe Root Port
[    0.551310] pci 0000:00:01.1: PCI bridge to [bus 02]
[    0.551313] pci 0000:00:01.1:   bridge window [io  0x3000-0x3fff]
[    0.551316] pci 0000:00:01.1:   bridge window [mem 0x4a000000-0x4b0fffff]
[    0.551322] pci 0000:00:01.1:   bridge window [mem 0x4000000000-0x4401ffffff 64bit pref]
[    0.551374] pci 0000:00:01.1: PME# supported from D0 D3hot D3cold
[    0.551398] pci 0000:00:01.1: PTM enabled (root), 4ns granularity
[    0.552171] pci 0000:00:04.0: [8086:a71d] type 00 class 0x118000 conventional PCI endpoint
[    0.552188] pci 0000:00:04.0: BAR 0 [mem 0x4404200000-0x440421ffff 64bit]
[    0.552553] pci 0000:00:08.0: [8086:a74f] type 00 class 0x088000 conventional PCI endpoint
[    0.552565] pci 0000:00:08.0: BAR 0 [mem 0x4404241000-0x4404241fff 64bit]
[    0.552678] pci 0000:00:0a.0: [8086:a77d] type 00 class 0x118000 PCIe Root Complex Integrated Endpoint
[    0.552687] pci 0000:00:0a.0: BAR 0 [mem 0x4404220000-0x4404227fff 64bit]
[    0.552707] pci 0000:00:0a.0: enabling Extended Tags
[    0.552818] pci 0000:00:0e.0: [8086:a77f] type 00 class 0x010400 PCIe Root Complex Integrated Endpoint
[    0.552833] pci 0000:00:0e.0: BAR 0 [mem 0x4402000000-0x4403ffffff 64bit]
[    0.552841] pci 0000:00:0e.0: BAR 2 [mem 0x48000000-0x49ffffff]
[    0.552857] pci 0000:00:0e.0: BAR 4 [mem 0x4404100000-0x44041fffff 64bit]
[    0.553192] pci 0000:00:14.0: [8086:7a60] type 00 class 0x0c0330 conventional PCI endpoint
[    0.553213] pci 0000:00:14.0: BAR 0 [mem 0x4b380000-0x4b38ffff 64bit]
[    0.553297] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.553911] pci 0000:00:14.2: [8086:7a27] type 00 class 0x050000 conventional PCI endpoint
[    0.553936] pci 0000:00:14.2: BAR 0 [mem 0x4404238000-0x440423bfff 64bit]
[    0.553953] pci 0000:00:14.2: BAR 2 [mem 0x4404240000-0x4404240fff 64bit]
[    0.554120] pci 0000:00:14.3: [8086:7a70] type 00 class 0x028000 PCIe Root Complex Integrated Endpoint
[    0.554166] pci 0000:00:14.3: BAR 0 [mem 0x4404234000-0x4404237fff 64bit]
[    0.554357] pci 0000:00:14.3: PME# supported from D0 D3hot D3cold
[    0.554778] pci 0000:00:15.0: [8086:7a4c] type 00 class 0x0c8000 conventional PCI endpoint
[    0.554853] pci 0000:00:15.0: BAR 0 [mem 0x00000000-0x00000fff 64bit]
[    0.555435] pci 0000:00:15.1: [8086:7a4d] type 00 class 0x0c8000 conventional PCI endpoint
[    0.555507] pci 0000:00:15.1: BAR 0 [mem 0x00000000-0x00000fff 64bit]
[    0.556025] pci 0000:00:16.0: [8086:7a68] type 00 class 0x078000 conventional PCI endpoint
[    0.556049] pci 0000:00:16.0: BAR 0 [mem 0x440423d000-0x440423dfff 64bit]
[    0.556133] pci 0000:00:16.0: PME# supported from D3hot
[    0.556720] pci 0000:00:1c.0: [8086:7a3e] type 01 class 0x060400 PCIe Root Port
[    0.556753] pci 0000:00:1c.0: PCI bridge to [bus 03]
[    0.556760] pci 0000:00:1c.0:   bridge window [mem 0x4b100000-0x4b2fffff]
[    0.556856] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.556897] pci 0000:00:1c.0: PTM enabled (root), 4ns granularity
[    0.557782] pci 0000:00:1d.0: [8086:7a30] type 01 class 0x060400 PCIe Root Port
[    0.557813] pci 0000:00:1d.0: PCI bridge to [bus 04-54]
[    0.557820] pci 0000:00:1d.0:   bridge window [mem 0x40000000-0x47ffffff]
[    0.557831] pci 0000:00:1d.0:   bridge window [mem 0x4410000000-0x54100fffff 64bit pref]
[    0.557975] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    0.558890] pci 0000:00:1f.0: [8086:7a0c] type 00 class 0x060100 conventional PCI endpoint
[    0.559327] pci 0000:00:1f.3: [8086:7a50] type 00 class 0x040300 conventional PCI endpoint
[    0.559371] pci 0000:00:1f.3: BAR 0 [mem 0x4404230000-0x4404233fff 64bit]
[    0.559426] pci 0000:00:1f.3: BAR 4 [mem 0x4404000000-0x44040fffff 64bit]
[    0.559535] pci 0000:00:1f.3: PME# supported from D3hot D3cold
[    0.559641] pci 0000:00:1f.4: [8086:7a23] type 00 class 0x0c0500 conventional PCI endpoint
[    0.559668] pci 0000:00:1f.4: BAR 0 [mem 0x440423c000-0x440423c0ff 64bit]
[    0.559699] pci 0000:00:1f.4: BAR 4 [io  0xefa0-0xefbf]
[    0.560020] pci 0000:00:1f.5: [8086:7a24] type 00 class 0x0c8000 conventional PCI endpoint
[    0.560040] pci 0000:00:1f.5: BAR 0 [mem 0xfe010000-0xfe010fff]
[    0.560200] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.560263] pci 0000:02:00.0: [10de:27e0] type 00 class 0x030000 PCIe Legacy Endpoint
[    0.560280] pci 0000:02:00.0: BAR 0 [mem 0x4a000000-0x4affffff]
[    0.560293] pci 0000:02:00.0: BAR 1 [mem 0x4000000000-0x43ffffffff 64bit pref]
[    0.560307] pci 0000:02:00.0: BAR 3 [mem 0x4400000000-0x4401ffffff 64bit pref]
[    0.560316] pci 0000:02:00.0: BAR 5 [io  0x3000-0x307f]
[    0.560325] pci 0000:02:00.0: ROM [mem 0xfff80000-0xffffffff pref]
[    0.560413] pci 0000:02:00.0: PME# supported from D0 D3hot
[    0.560537] pci 0000:02:00.0: 16.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s PCIe x8 link at 0000:00:01.1 (capable of 252.048 Gb/s with 16.0 GT/s PCIe x16 link)
[    0.560856] pci 0000:02:00.1: [10de:22bc] type 00 class 0x040300 PCIe Endpoint
[    0.560870] pci 0000:02:00.1: BAR 0 [mem 0x4b000000-0x4b003fff]
[    0.561061] pci 0000:00:01.1: PCI bridge to [bus 02]
[    0.561202] pci 0000:03:00.0: [8086:3102] type 00 class 0x020000 PCIe Endpoint
[    0.561227] pci 0000:03:00.0: BAR 0 [mem 0x4b100000-0x4b1fffff]
[    0.561264] pci 0000:03:00.0: BAR 3 [mem 0x4b200000-0x4b203fff]
[    0.561424] pci 0000:03:00.0: PME# supported from D0 D3hot D3cold
[    0.561730] pci 0000:00:1c.0: PCI bridge to [bus 03]
[    0.561838] pci 0000:04:00.0: [8086:5780] type 01 class 0x060400 PCIe Switch Upstream Port
[    0.561879] pci 0000:04:00.0: PCI bridge to [bus 05-54]
[    0.561891] pci 0000:04:00.0:   bridge window [mem 0x40000000-0x47efffff]
[    0.561905] pci 0000:04:00.0:   bridge window [mem 0x4410000000-0x54100fffff 64bit pref]
[    0.561921] pci 0000:04:00.0: enabling Extended Tags
[    0.562059] pci 0000:04:00.0: supports D1 D2
[    0.562060] pci 0000:04:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.562466] pci 0000:00:1d.0: PCI bridge to [bus 04-54]
[    0.562591] pci 0000:05:00.0: [8086:5780] type 01 class 0x060400 PCIe Switch Downstream Port
[    0.562632] pci 0000:05:00.0: PCI bridge to [bus 06]
[    0.562656] pci 0000:05:00.0:   bridge window [mem 0x5410000000-0x54100fffff 64bit pref]
[    0.562674] pci 0000:05:00.0: enabling Extended Tags
[    0.562803] pci 0000:05:00.0: supports D1 D2
[    0.562804] pci 0000:05:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.563133] pci 0000:05:01.0: [8086:5780] type 01 class 0x060400 PCIe Switch Downstream Port
[    0.563174] pci 0000:05:01.0: PCI bridge to [bus 07-2c]
[    0.563186] pci 0000:05:01.0:   bridge window [mem 0x44000000-0x47efffff]
[    0.563216] pci 0000:05:01.0: enabling Extended Tags
[    0.563355] pci 0000:05:01.0: supports D1 D2
[    0.563356] pci 0000:05:01.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.563677] pci 0000:05:02.0: [8086:5780] type 01 class 0x060400 PCIe Switch Downstream Port
[    0.563719] pci 0000:05:02.0: PCI bridge to [bus 2d]
[    0.563730] pci 0000:05:02.0:   bridge window [mem 0x43f00000-0x43ffffff]
[    0.563761] pci 0000:05:02.0: enabling Extended Tags
[    0.563889] pci 0000:05:02.0: supports D1 D2
[    0.563890] pci 0000:05:02.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.564211] pci 0000:05:03.0: [8086:5780] type 01 class 0x060400 PCIe Switch Downstream Port
[    0.564251] pci 0000:05:03.0: PCI bridge to [bus 2e-54]
[    0.564263] pci 0000:05:03.0:   bridge window [mem 0x40000000-0x43efffff]
[    0.564293] pci 0000:05:03.0: enabling Extended Tags
[    0.564431] pci 0000:05:03.0: supports D1 D2
[    0.564432] pci 0000:05:03.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.564761] pci 0000:04:00.0: PCI bridge to [bus 05-54]
[    0.564870] pci 0000:06:00.0: [8086:5781] type 00 class 0x0c0340 PCIe Endpoint
[    0.564898] pci 0000:06:00.0: BAR 0 [mem 0x5410000000-0x541003ffff 64bit pref]
[    0.564916] pci 0000:06:00.0: BAR 2 [mem 0x5410040000-0x5410040fff 64bit pref]
[    0.564957] pci 0000:06:00.0: enabling Extended Tags
[    0.565073] pci 0000:06:00.0: supports D1 D2
[    0.565074] pci 0000:06:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.565348] pci 0000:05:00.0: PCI bridge to [bus 06]
[    0.565423] pci 0000:05:01.0: PCI bridge to [bus 07-2c]
[    0.565533] pci 0000:2d:00.0: [8086:5782] type 00 class 0x0c0330 PCIe Endpoint
[    0.565557] pci 0000:2d:00.0: BAR 0 [mem 0x43f00000-0x43f0ffff 64bit]
[    0.565605] pci 0000:2d:00.0: enabling Extended Tags
[    0.565689] pci 0000:2d:00.0: PME# supported from D3hot D3cold
[    0.565728] pci 0000:2d:00.0: 8.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:05:02.0 (capable of 31.504 Gb/s with 8.0 GT/s PCIe x4 link)
[    0.565872] pci 0000:05:02.0: PCI bridge to [bus 2d]
[    0.565946] pci 0000:05:03.0: PCI bridge to [bus 2e-54]
[    0.589885] ACPI: EC: interrupt unblocked
[    0.589887] ACPI: EC: event unblocked
[    0.589904] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.589905] ACPI: EC: GPE=0x6e
[    0.589907] ACPI: \_SB_.PC00.LPCB.EC__: Boot DSDT EC initialization complete
[    0.589909] ACPI: \_SB_.PC00.LPCB.EC__: EC: Used to handle transactions and events
[    0.590030] iommu: Default domain type: Translated
[    0.590030] iommu: DMA domain TLB invalidation policy: lazy mode
[    0.590265] SCSI subsystem initialized
[    0.590281] libata version 3.00 loaded.
[    0.590281] ACPI: bus type USB registered
[    0.590286] usbcore: registered new interface driver usbfs
[    0.590291] usbcore: registered new interface driver hub
[    0.590305] usbcore: registered new device driver usb
[    0.590333] pps_core: LinuxPPS API ver. 1 registered
[    0.590335] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.590338] PTP clock support registered
[    0.590360] EDAC MC: Ver: 3.0.0
[    0.591245] efivars: Registered efivars operations
[    0.591607] NetLabel: Initializing
[    0.591608] NetLabel:  domain hash size = 128
[    0.591610] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.591640] NetLabel:  unlabeled traffic allowed by default
[    0.591665] mctp: management component transport protocol core
[    0.591665] NET: Registered PF_MCTP protocol family
[    0.591665] PCI: Using ACPI for IRQ routing
[    0.607895] PCI: pci_cache_line_size set to 64 bytes
[    0.608047] pci 0000:00:1f.5: BAR 0 [mem 0xfe010000-0xfe010fff]: can't claim; no compatible bridge window
[    0.608194] e820: reserve RAM buffer [mem 0x0009f000-0x0009ffff]
[    0.608196] e820: reserve RAM buffer [mem 0x2b4c3018-0x2bffffff]
[    0.608198] e820: reserve RAM buffer [mem 0x2b8a0000-0x2bffffff]
[    0.608199] e820: reserve RAM buffer [mem 0x2ca20000-0x2fffffff]
[    0.608200] e820: reserve RAM buffer [mem 0x30229000-0x33ffffff]
[    0.608201] e820: reserve RAM buffer [mem 0x3293f000-0x33ffffff]
[    0.608202] e820: reserve RAM buffer [mem 0x37b00000-0x37ffffff]
[    0.608250] pci 0000:02:00.0: vgaarb: setting as boot VGA device
[    0.608252] pci 0000:02:00.0: vgaarb: bridge control possible
[    0.608253] pci 0000:02:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
[    0.608256] vgaarb: loaded
[    0.608359] clocksource: Switched to clocksource tsc-early
[    0.608948] VFS: Disk quotas dquot_6.6.0
[    0.608961] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.609113] AppArmor: AppArmor Filesystem Enabled
[    0.609157] pnp: PnP ACPI init
[    0.609332] pnp 00:00: disabling [io  0x3322-0x3323] because it overlaps 0000:00:01.1 BAR 13 [io  0x3000-0x3fff]
[    0.609565] system 00:02: [io  0x1854-0x1857] has been reserved
[    0.628358] system 00:05: [mem 0xfedc0000-0xfedc7fff] has been reserved
[    0.628362] system 00:05: [mem 0xfeda0000-0xfeda0fff] has been reserved
[    0.628364] system 00:05: [mem 0xfeda1000-0xfeda1fff] has been reserved
[    0.628366] system 00:05: [mem 0xc0000000-0xcfffffff] has been reserved
[    0.628368] system 00:05: [mem 0xfed20000-0xfed7ffff] could not be reserved
[    0.628370] system 00:05: [mem 0xfed90000-0xfed93fff] could not be reserved
[    0.628372] system 00:05: [mem 0xfed45000-0xfed8ffff] could not be reserved
[    0.628374] system 00:05: [mem 0xfee00000-0xfeefffff] has been reserved
[    0.628838] system 00:06: [io  0x2000-0x20fe] has been reserved
[    0.630294] pnp: PnP ACPI: found 8 devices
[    0.636544] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.636637] NET: Registered PF_INET protocol family
[    0.637119] IP idents hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.656520] tcp_listen_portaddr_hash hash table entries: 16384 (order: 6, 262144 bytes, linear)
[    0.656563] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    0.656724] TCP established hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.657259] TCP bind hash table entries: 65536 (order: 9, 2097152 bytes, linear)
[    0.657389] TCP: Hash tables configured (established 262144 bind 65536)
[    0.657649] MPTCP token hash table entries: 32768 (order: 7, 786432 bytes, linear)
[    0.657778] UDP hash table entries: 16384 (order: 7, 524288 bytes, linear)
[    0.657899] UDP-Lite hash table entries: 16384 (order: 7, 524288 bytes, linear)
[    0.658013] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.658021] NET: Registered PF_XDP protocol family
[    0.658025] pci 0000:02:00.0: ROM [mem 0xfff80000-0xffffffff pref]: can't claim; no compatible bridge window
[    0.658035] pci 0000:05:01.0: bridge window [io  0x1000-0x0fff] to [bus 07-2c] add_size 1000
[    0.658038] pci 0000:05:01.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 07-2c] add_size 200000 add_align 100000
[    0.658041] pci 0000:05:03.0: bridge window [io  0x1000-0x0fff] to [bus 2e-54] add_size 1000
[    0.658043] pci 0000:05:03.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 2e-54] add_size 200000 add_align 100000
[    0.658046] pci 0000:04:00.0: bridge window [io  0x1000-0x0fff] to [bus 05-54] add_size 2000
[    0.658049] pci 0000:00:1d.0: bridge window [io  0x1000-0x0fff] to [bus 04-54] add_size 3000
[    0.658057] pci 0000:00:15.0: BAR 0 [mem 0x4404228000-0x4404228fff 64bit]: assigned
[    0.658120] pci 0000:00:15.1: BAR 0 [mem 0x4404229000-0x4404229fff 64bit]: assigned
[    0.658180] pci 0000:00:1d.0: bridge window [io  0x4000-0x6fff]: assigned
[    0.658183] pci 0000:00:1f.5: BAR 0 [mem 0x4b300000-0x4b300fff]: assigned
[    0.658194] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.658202] pci 0000:02:00.0: ROM [mem 0x4b080000-0x4b0fffff pref]: assigned
[    0.658204] pci 0000:00:01.1: PCI bridge to [bus 02]
[    0.658206] pci 0000:00:01.1:   bridge window [io  0x3000-0x3fff]
[    0.658209] pci 0000:00:01.1:   bridge window [mem 0x4a000000-0x4b0fffff]
[    0.658212] pci 0000:00:01.1:   bridge window [mem 0x4000000000-0x4401ffffff 64bit pref]
[    0.658217] pci 0000:00:1c.0: PCI bridge to [bus 03]
[    0.658227] pci 0000:00:1c.0:   bridge window [mem 0x4b100000-0x4b2fffff]
[    0.658236] pci 0000:04:00.0: bridge window [io  0x4000-0x5fff]: assigned
[    0.658239] pci 0000:05:01.0: bridge window [mem 0x4410000000-0x44101fffff 64bit pref]: assigned
[    0.658241] pci 0000:05:03.0: bridge window [mem 0x4410200000-0x44103fffff 64bit pref]: assigned
[    0.658243] pci 0000:05:01.0: bridge window [io  0x4000-0x4fff]: assigned
[    0.658244] pci 0000:05:03.0: bridge window [io  0x5000-0x5fff]: assigned
[    0.658246] pci 0000:05:00.0: PCI bridge to [bus 06]
[    0.658267] pci 0000:05:00.0:   bridge window [mem 0x5410000000-0x54100fffff 64bit pref]
[    0.658275] pci 0000:05:01.0: PCI bridge to [bus 07-2c]
[    0.658277] pci 0000:05:01.0:   bridge window [io  0x4000-0x4fff]
[    0.658283] pci 0000:05:01.0:   bridge window [mem 0x44000000-0x47efffff]
[    0.658288] pci 0000:05:01.0:   bridge window [mem 0x4410000000-0x44101fffff 64bit pref]
[    0.658295] pci 0000:05:02.0: PCI bridge to [bus 2d]
[    0.658301] pci 0000:05:02.0:   bridge window [mem 0x43f00000-0x43ffffff]
[    0.658311] pci 0000:05:03.0: PCI bridge to [bus 2e-54]
[    0.658314] pci 0000:05:03.0:   bridge window [io  0x5000-0x5fff]
[    0.658319] pci 0000:05:03.0:   bridge window [mem 0x40000000-0x43efffff]
[    0.658324] pci 0000:05:03.0:   bridge window [mem 0x4410200000-0x44103fffff 64bit pref]
[    0.658331] pci 0000:04:00.0: PCI bridge to [bus 05-54]
[    0.658334] pci 0000:04:00.0:   bridge window [io  0x4000-0x5fff]
[    0.658339] pci 0000:04:00.0:   bridge window [mem 0x40000000-0x47efffff]
[    0.658344] pci 0000:04:00.0:   bridge window [mem 0x4410000000-0x54100fffff 64bit pref]
[    0.658351] pci 0000:00:1d.0: PCI bridge to [bus 04-54]
[    0.658353] pci 0000:00:1d.0:   bridge window [io  0x4000-0x6fff]
[    0.658358] pci 0000:00:1d.0:   bridge window [mem 0x40000000-0x47ffffff]
[    0.658361] pci 0000:00:1d.0:   bridge window [mem 0x4410000000-0x54100fffff 64bit pref]
[    0.658368] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.658370] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.658371] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    0.658373] pci_bus 0000:00: resource 7 [mem 0x40000000-0xbfffffff window]
[    0.658375] pci_bus 0000:00: resource 8 [mem 0x4000000000-0x7fffffffff window]
[    0.658377] pci_bus 0000:02: resource 0 [io  0x3000-0x3fff]
[    0.658378] pci_bus 0000:02: resource 1 [mem 0x4a000000-0x4b0fffff]
[    0.658379] pci_bus 0000:02: resource 2 [mem 0x4000000000-0x4401ffffff 64bit pref]
[    0.658381] pci_bus 0000:03: resource 1 [mem 0x4b100000-0x4b2fffff]
[    0.658383] pci_bus 0000:04: resource 0 [io  0x4000-0x6fff]
[    0.658384] pci_bus 0000:04: resource 1 [mem 0x40000000-0x47ffffff]
[    0.658386] pci_bus 0000:04: resource 2 [mem 0x4410000000-0x54100fffff 64bit pref]
[    0.658387] pci_bus 0000:05: resource 0 [io  0x4000-0x5fff]
[    0.658389] pci_bus 0000:05: resource 1 [mem 0x40000000-0x47efffff]
[    0.658390] pci_bus 0000:05: resource 2 [mem 0x4410000000-0x54100fffff 64bit pref]
[    0.658392] pci_bus 0000:06: resource 2 [mem 0x5410000000-0x54100fffff 64bit pref]
[    0.658393] pci_bus 0000:07: resource 0 [io  0x4000-0x4fff]
[    0.658395] pci_bus 0000:07: resource 1 [mem 0x44000000-0x47efffff]
[    0.658396] pci_bus 0000:07: resource 2 [mem 0x4410000000-0x44101fffff 64bit pref]
[    0.658398] pci_bus 0000:2d: resource 1 [mem 0x43f00000-0x43ffffff]
[    0.658399] pci_bus 0000:2e: resource 0 [io  0x5000-0x5fff]
[    0.658400] pci_bus 0000:2e: resource 1 [mem 0x40000000-0x43efffff]
[    0.658402] pci_bus 0000:2e: resource 2 [mem 0x4410200000-0x44103fffff 64bit pref]
[    0.660548] pci 0000:02:00.1: extending delay after power-on from D3hot to 20 msec
[    0.660578] pci 0000:02:00.1: D0 power state depends on 0000:02:00.0
[    0.661086] pci 0000:2d:00.0: enabling device (0000 -> 0002)
[    0.661124] PCI: CLS 64 bytes, default 64
[    0.661161] DMAR: No RMRR found
[    0.661162] DMAR: No ATSR found
[    0.661163] DMAR: No SATC found
[    0.661165] DMAR: dmar0: Using Queued invalidation
[    0.661219] Trying to unpack rootfs image as initramfs...
[    0.661243] pci 0000:00:00.0: Adding to iommu group 0
[    0.661256] pci 0000:00:01.0: Adding to iommu group 1
[    0.661270] pci 0000:00:01.1: Adding to iommu group 2
[    0.661280] pci 0000:00:04.0: Adding to iommu group 3
[    0.661291] pci 0000:00:08.0: Adding to iommu group 4
[    0.661300] pci 0000:00:0a.0: Adding to iommu group 5
[    0.661310] pci 0000:00:0e.0: Adding to iommu group 6
[    0.661330] pci 0000:00:14.0: Adding to iommu group 7
[    0.661340] pci 0000:00:14.2: Adding to iommu group 7
[    0.661350] pci 0000:00:14.3: Adding to iommu group 8
[    0.661368] pci 0000:00:15.0: Adding to iommu group 9
[    0.661378] pci 0000:00:15.1: Adding to iommu group 9
[    0.661394] pci 0000:00:16.0: Adding to iommu group 10
[    0.661414] pci 0000:00:1c.0: Adding to iommu group 11
[    0.661433] pci 0000:00:1d.0: Adding to iommu group 12
[    0.661460] pci 0000:00:1f.0: Adding to iommu group 13
[    0.661472] pci 0000:00:1f.3: Adding to iommu group 13
[    0.661483] pci 0000:00:1f.4: Adding to iommu group 13
[    0.661493] pci 0000:00:1f.5: Adding to iommu group 13
[    0.661512] pci 0000:02:00.0: Adding to iommu group 14
[    0.661525] pci 0000:02:00.1: Adding to iommu group 14
[    0.661543] pci 0000:03:00.0: Adding to iommu group 15
[    0.661561] pci 0000:04:00.0: Adding to iommu group 16
[    0.661573] pci 0000:05:00.0: Adding to iommu group 17
[    0.661592] pci 0000:05:01.0: Adding to iommu group 18
[    0.661611] pci 0000:05:02.0: Adding to iommu group 19
[    0.661630] pci 0000:05:03.0: Adding to iommu group 20
[    0.661652] pci 0000:06:00.0: Adding to iommu group 21
[    0.661667] pci 0000:2d:00.0: Adding to iommu group 22
[    0.667053] DMAR: Intel(R) Virtualization Technology for Directed I/O
[    0.667056] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.667057] software IO TLB: mapped [mem 0x0000000025db6000-0x0000000029db6000] (64MB)
[    0.669132] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x22df1149949, max_idle_ns: 440795312789 ns
[    0.669182] clocksource: Switched to clocksource tsc
[    0.670486] Initialise system trusted keyrings
[    0.670499] Key type blacklist registered
[    0.670556] workingset: timestamp_bits=36 max_order=23 bucket_order=0
[    0.670568] zbud: loaded
[    0.670912] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.671044] fuse: init (API version 7.41)
[    0.671228] integrity: Platform Keyring initialized
[    0.671233] integrity: Machine keyring initialized
[    0.685015] Key type asymmetric registered
[    0.685017] Asymmetric key parser 'x509' registered
[    0.685049] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 243)
[    0.685133] io scheduler mq-deadline registered
[    0.685765] ledtrig-cpu: registered to indicate activity on CPUs
[    0.686099] pcieport 0000:00:01.0: PME: Signaling with IRQ 121
[    0.686390] pcieport 0000:00:01.1: PME: Signaling with IRQ 122
[    0.686719] pcieport 0000:00:1c.0: PME: Signaling with IRQ 123
[    0.686822] pcieport 0000:00:1c.0: AER: enabled with IRQ 123
[    0.687017] pcieport 0000:00:1d.0: PME: Signaling with IRQ 124
[    0.687099] pcieport 0000:00:1d.0: AER: enabled with IRQ 124
[    0.687129] pcieport 0000:00:1d.0: pciehp: Slot #8 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
[    0.688072] pcieport 0000:05:01.0: pciehp: Slot #1 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
[    0.688723] pcieport 0000:05:03.0: pciehp: Slot #3 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
[    0.688973] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    0.689320] Monitor-Mwait will be used to enter C-1 state
[    0.689342] Monitor-Mwait will be used to enter C-2 state
[    0.689358] Monitor-Mwait will be used to enter C-3 state
[    0.692862] ACPI: AC: AC Adapter [AC] (on-line)
[    0.692946] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    0.692995] ACPI: button: Power Button [PWRB]
[    0.693028] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input1
[    0.693063] ACPI: button: Sleep Button [SLPB]
[    0.693101] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input2
[    0.693133] ACPI: button: Lid Switch [LID0]
[    0.693166] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
[    0.693211] ACPI: button: Power Button [PWRF]
[    0.780666] thermal LNXTHERM:00: registered as thermal_zone0
[    0.780670] ACPI: thermal: Thermal Zone [TZ0] (25 C)
[    0.781026] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    0.781814] ACPI: battery: Slot [BAT0] (battery present)
[    0.783884] hpet_acpi_add: no address or irqs in _CRS
[    0.783916] Linux agpgart interface v0.103
[    0.785803] tpm_tis IFX1523:00: 2.0 TPM (device-id 0x1D, rev-id 54)
[    0.901220] ACPI: bus type drm_connector registered
[    0.909673] loop: module loaded
[    0.910123] tun: Universal TUN/TAP device driver, 1.6
[    0.910202] PPP generic driver version 2.4.2
[    0.910581] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    0.910589] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
[    0.911836] xhci_hcd 0000:00:14.0: hcc params 0x20007fc1 hci version 0x120 quirks 0x0000000200009810
[    0.912285] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    0.912289] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
[    0.912293] xhci_hcd 0000:00:14.0: Host supports USB 3.2 Enhanced SuperSpeed
[    0.912356] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.12
[    0.912359] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.912361] usb usb1: Product: xHCI Host Controller
[    0.912363] usb usb1: Manufacturer: Linux 6.12.0-rc5 xhci-hcd
[    0.912364] usb usb1: SerialNumber: 0000:00:14.0
[    0.912579] hub 1-0:1.0: USB hub found
[    0.912614] hub 1-0:1.0: 16 ports detected
[    0.917123] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.12
[    0.917127] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.917129] usb usb2: Product: xHCI Host Controller
[    0.917131] usb usb2: Manufacturer: Linux 6.12.0-rc5 xhci-hcd
[    0.917133] usb usb2: SerialNumber: 0000:00:14.0
[    0.917265] hub 2-0:1.0: USB hub found
[    0.917291] hub 2-0:1.0: 10 ports detected
[    0.919903] xhci_hcd 0000:2d:00.0: xHCI Host Controller
[    0.919909] xhci_hcd 0000:2d:00.0: new USB bus registered, assigned bus number 3
[    0.921159] xhci_hcd 0000:2d:00.0: hcc params 0x20007fc1 hci version 0x120 quirks 0x0000000200009810
[    0.921562] xhci_hcd 0000:2d:00.0: xHCI Host Controller
[    0.921566] xhci_hcd 0000:2d:00.0: new USB bus registered, assigned bus number 4
[    0.921569] xhci_hcd 0000:2d:00.0: Host supports USB 3.2 Enhanced SuperSpeed
[    0.921625] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.12
[    0.921628] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.921630] usb usb3: Product: xHCI Host Controller
[    0.921632] usb usb3: Manufacturer: Linux 6.12.0-rc5 xhci-hcd
[    0.921633] usb usb3: SerialNumber: 0000:2d:00.0
[    0.921742] hub 3-0:1.0: USB hub found
[    0.921762] hub 3-0:1.0: 2 ports detected
[    0.923264] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.12
[    0.923267] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.923269] usb usb4: Product: xHCI Host Controller
[    0.923271] usb usb4: Manufacturer: Linux 6.12.0-rc5 xhci-hcd
[    0.923272] usb usb4: SerialNumber: 0000:2d:00.0
[    0.923409] hub 4-0:1.0: USB hub found
[    0.923426] hub 4-0:1.0: 2 ports detected
[    0.925622] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[    0.931772] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.931779] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.932006] mousedev: PS/2 mouse device common for all mice
[    0.932249] rtc_cmos 00:01: RTC can wake from S4
[    0.933175] rtc_cmos 00:01: registered as rtc0
[    0.933361] rtc_cmos 00:01: setting system clock to 2024-10-29T19:22:21 UTC (1730229741)
[    0.933399] rtc_cmos 00:01: alarms up to one month, y3k, 242 bytes nvram
[    0.933408] i2c_dev: i2c /dev entries driver
[    0.936352] device-mapper: core: CONFIG_IMA_DISABLE_HTABLE is disabled. Duplicate IMA measurements will not be recorded in the IMA log.
[    0.936377] device-mapper: uevent: version 1.0.3
[    0.936529] device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) initialised: dm-devel@lists.linux.dev
[    0.936561] platform eisa.0: Probing EISA bus 0
[    0.936564] platform eisa.0: EISA: Cannot allocate resource for mainboard
[    0.936566] platform eisa.0: Cannot allocate resource for EISA slot 1
[    0.936567] platform eisa.0: Cannot allocate resource for EISA slot 2
[    0.936568] platform eisa.0: Cannot allocate resource for EISA slot 3
[    0.936570] platform eisa.0: Cannot allocate resource for EISA slot 4
[    0.936571] platform eisa.0: Cannot allocate resource for EISA slot 5
[    0.936572] platform eisa.0: Cannot allocate resource for EISA slot 6
[    0.936573] platform eisa.0: Cannot allocate resource for EISA slot 7
[    0.936574] platform eisa.0: Cannot allocate resource for EISA slot 8
[    0.936575] platform eisa.0: EISA: Detected 0 cards
[    0.936579] intel_pstate: Intel P-state driver initializing
[    0.936798] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input4
[    0.940629] intel_pstate: HWP enabled
[    0.940741] [drm] Initialized simpledrm 1.0.0 for simple-framebuffer.0 on minor 0
[    0.942902] fbcon: Deferring console take-over
[    0.942903] simple-framebuffer simple-framebuffer.0: [drm] fb0: simpledrmdrmfb frame buffer device
[    0.944137] drop_monitor: Initializing network drop monitor service
[    0.944238] NET: Registered PF_INET6 protocol family
[    0.971527] Freeing initrd memory: 74696K
[    0.977426] Segment Routing with IPv6
[    0.977438] In-situ OAM (IOAM) with IPv6
[    0.977459] NET: Registered PF_PACKET protocol family
[    0.977530] Key type dns_resolver registered
[    0.981858] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.983804] microcode: Current revision: 0x00000129
[    0.985627] IPI shorthand broadcast: enabled
[    0.986579] sched_clock: Marking stable (978008618, 7601660)->(1055329318, -69719040)
[    0.987246] registered taskstats version 1
[    0.990867] Loading compiled-in X.509 certificates
[    0.991295] Loaded X.509 cert 'Build time autogenerated kernel key: b9e32a74847b4505d53d500d44fb60761632a017'
[    0.994310] Demotion targets for Node 0: null
[    0.994479] Key type .fscrypt registered
[    0.994480] Key type fscrypt-provisioning registered
[    0.994534] Key type trusted registered
[    1.001388] cryptd: module verification failed: signature and/or required key missing - tainting kernel
[    1.002399] cryptd: max_cpu_qlen set to 1000
[    1.003432] AES CTR mode by8 optimization enabled
[    1.014067] Key type encrypted registered
[    1.014074] AppArmor: AppArmor sha256 policy hashing enabled
[    1.018884] integrity: Loading X.509 certificate: UEFI:db
[    1.018917] integrity: Loaded X.509 cert 'Microsoft Windows Production PCA 2011: a92902398e16c49778cd90f99e4f9ae17c55af53'
[    1.018918] integrity: Loading X.509 certificate: UEFI:db
[    1.018939] integrity: Loaded X.509 cert 'Microsoft Corporation: Windows UEFI CA 2023: aefc5fbbbe055d8f8daa585473499417ab5a5272'
[    1.018940] integrity: Loading X.509 certificate: UEFI:db
[    1.018958] integrity: Loaded X.509 cert 'Microsoft Corporation UEFI CA 2011: 13adbf4309bd82709c8cd54f316ed522988a1bd4'
[    1.018959] integrity: Loading X.509 certificate: UEFI:db
[    1.018974] integrity: Loaded X.509 cert 'Microsoft UEFI CA 2023: 81aa6b3244c935bce0d6628af39827421e32497d'
[    1.018975] integrity: Loading X.509 certificate: UEFI:db
[    1.019370] integrity: Loaded X.509 cert 'Secure Certificate: 01dcc89619884ca147983429f8a4a1a0'
[    1.019371] integrity: Loading X.509 certificate: UEFI:db
[    1.019528] integrity: Loaded X.509 cert 'Cus CA: d6136d376b87ef934511c12ce2c3880c'
[    1.027236] Loading compiled-in module X.509 certificates
[    1.027686] Loaded X.509 cert 'Build time autogenerated kernel key: b9e32a74847b4505d53d500d44fb60761632a017'
[    1.027688] ima: Allocated hash algorithm: sha256
[    1.154784] usb 1-6: new high-speed USB device number 2 using xhci_hcd
[    1.177224] ima: No architecture policies found
[    1.177273] evm: Initialising EVM extended attributes:
[    1.177275] evm: security.selinux
[    1.177278] evm: security.SMACK64
[    1.177280] evm: security.SMACK64EXEC
[    1.177282] evm: security.SMACK64TRANSMUTE
[    1.177283] evm: security.SMACK64MMAP
[    1.177285] evm: security.apparmor
[    1.177287] evm: security.ima
[    1.177288] evm: security.capability
[    1.177290] evm: HMAC attrs: 0x1
[    1.178006] PM:   Magic number: 12:45:396
[    1.185961] RAS: Correctable Errors collector initialized.
[    1.198814] clk: Disabling unused clocks
[    1.198816] PM: genpd: Disabling unused power domains
[    1.205188] Freeing unused decrypted memory: 2028K
[    1.206152] Freeing unused kernel image (initmem) memory: 5064K
[    1.206175] Write protecting the kernel read-only data: 36864k
[    1.206879] Freeing unused kernel image (rodata/data gap) memory: 44K
[    1.214120] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    1.214123] Run /init as init process
[    1.214124]   with arguments:
[    1.214125]     /init
[    1.214126]     spla
[    1.214127]   with environment:
[    1.214127]     HOME=/
[    1.214128]     TERM=linux
[    1.214128]     BOOT_IMAGE=/@boot/vmlinuz-6.12.0-rc5
[    1.214129]     cryptdevice=UUID=1a8d8cdb-8d8f-4689-b744-8f32d2067f56:luks-1a8d8cdb-8d8f-4689-b744-8f32d2067f56
[    1.304665] wmi_bus wmi_bus-PNP0C14:01: [Firmware Bug]: WQ00 data block query control method not found
[    1.305229] hid: raw HID events driver (C) Jiri Kosina
[    1.306175] ACPI: video: [Firmware Bug]: ACPI(PEGP) defines _DOD but not _DOS
[    1.306211] ACPI: video: Video Device [PEGP] (multi-head: yes  rom: no  post: no)
[    1.308293] usb 1-6: New USB device found, idVendor=04f2, idProduct=b7e7, bcdDevice= 0.04
[    1.308300] usb 1-6: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    1.308301] usb 1-6: Product: Chicony USB2.0 Camera
[    1.308302] usb 1-6: Manufacturer: SunplusIT Inc
[    1.308303] usb 1-6: SerialNumber: 01.00.00
[    1.309978] Intel(R) 2.5G Ethernet Linux Driver
[    1.309980] Copyright(c) 2018 Intel Corporation.
[    1.310563] igc 0000:03:00.0: PTM enabled, 4ns granularity
[    1.310685] vmd 0000:00:0e.0: PCI host bridge to bus 10000:e0
[    1.310690] pci_bus 10000:e0: root bus resource [bus e0-ff]
[    1.310692] pci_bus 10000:e0: root bus resource [mem 0x48000000-0x49ffffff]
[    1.310693] pci_bus 10000:e0: root bus resource [mem 0x4404102000-0x44041fffff 64bit]
[    1.310712] pci 10000:e0:1b.0: [8086:09ab] type 00 class 0x088000 conventional PCI endpoint
[    1.310961] pci 10000:e0:1b.0: Adding to iommu group 6
[    1.310998] pci 10000:e0:1b.4: [8086:7a44] type 01 class 0x060400 PCIe Root Port
[    1.311032] pci 10000:e0:1b.4: PCI bridge to [bus e1]
[    1.311039] pci 10000:e0:1b.4:   bridge window [io  0x0000-0x0fff]
[    1.311041] pci 10000:e0:1b.4:   bridge window [mem 0x48000000-0x480fffff]
[    1.311153] pci 10000:e0:1b.4: PME# supported from D0 D3hot D3cold
[    1.311211] pci 10000:e0:1b.4: PTM enabled (root), 4ns granularity
[    1.311380] pci 10000:e0:1b.4: Adding to iommu group 6
[    1.311387] pci 10000:e0:1b.4: Primary bus is hard wired to 0
[    1.311447] pci 10000:e1:00.0: [144d:a808] type 00 class 0x010802 PCIe Endpoint
[    1.311482] pci 10000:e1:00.0: BAR 0 [mem 0x48000000-0x48003fff 64bit]
[    1.311893] pci 10000:e1:00.0: Adding to iommu group 6
[    1.311906] pci 10000:e0:1b.4: PCI bridge to [bus e1]
[    1.311920] pci 10000:e0:1b.4: Primary bus is hard wired to 0
[    1.314324] ACPI: bus type thunderbolt registered
[    1.321644] intel-lpss 0000:00:15.0: enabling device (0004 -> 0006)
[    1.321984] idma64 idma64.0: Found Intel integrated DMA 64-bit
[    1.349300] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:05/LNXVIDEO:00/input/input7
[    1.361059] pps pps0: new PPS source ptp0
[    1.361104] igc 0000:03:00.0 (unnamed net_device) (uninitialized): PHC added
[    1.389215] igc 0000:03:00.0: 4.000 Gb/s available PCIe bandwidth (5.0 GT/s PCIe x1 link)
[    1.389223] igc 0000:03:00.0 eth0: MAC: d4:93:90:44:67:64
[    1.391358] igc 0000:03:00.0 enp3s0: renamed from eth0
[    1.419793] thunderbolt 0000:06:00.0: host router reset successful
[    1.421141] thunderbolt 0000:06:00.0: device links to tunneled native ports are missing!
[    1.428131] thunderbolt 0000:06:00.0: 0: DROM data CRC32 mismatch (expected: 0x56000000, got: 0x56473b0f), continuing
[    1.436622] usb 1-7: new full-speed USB device number 3 using xhci_hcd
[    1.475839] pci 10000:e0:1b.4: bridge window [mem 0x48000000-0x480fffff]: assigned
[    1.475847] pci 10000:e0:1b.4: bridge window [io  size 0x1000]: can't assign; no space
[    1.475850] pci 10000:e0:1b.4: bridge window [io  size 0x1000]: failed to assign
[    1.475854] pci 10000:e1:00.0: BAR 0 [mem 0x48000000-0x48003fff 64bit]: assigned
[    1.475879] pci 10000:e0:1b.4: PCI bridge to [bus e1]
[    1.475887] pci 10000:e0:1b.4:   bridge window [mem 0x48000000-0x480fffff]
[    1.475985] pcieport 10000:e0:1b.4: can't derive routing for PCI INT A
[    1.475988] pcieport 10000:e0:1b.4: PCI INT A: no GSI
[    1.476137] pcieport 10000:e0:1b.4: PME: Signaling with IRQ 185
[    1.476447] pcieport 10000:e0:1b.4: AER: enabled with IRQ 185
[    1.476565] vmd 0000:00:0e.0: Bound to PCI domain 10000
[    1.496412] intel-lpss 0000:00:15.1: enabling device (0004 -> 0006)
[    1.498322] idma64 idma64.1: Found Intel integrated DMA 64-bit
[    1.564985] usb 1-7: New USB device found, idVendor=048d, idProduct=8910, bcdDevice= 0.01
[    1.564999] usb 1-7: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    1.565004] usb 1-7: Product: ITE Device(829x)
[    1.565008] usb 1-7: Manufacturer: ITE Tech. Inc.
[    1.678809] usb 1-14: new full-speed USB device number 4 using xhci_hcd
[    1.805312] usb 1-14: New USB device found, idVendor=8087, idProduct=0033, bcdDevice= 0.00
[    1.805328] usb 1-14: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    1.819864] usbcore: registered new interface driver usbhid
[    1.819869] usbhid: USB HID core driver
[    1.837514] nvme nvme0: pci function 10000:e1:00.0
[    1.837544] pcieport 10000:e0:1b.4: can't derive routing for PCI INT A
[    1.837548] nvme 10000:e1:00.0: PCI INT A: not connected
[    1.837795] hid-generic 0003:048D:8910.0001: hiddev0,hidraw0: USB HID v1.10 Device [ITE Tech. Inc. ITE Device(829x)] on usb-0000:00:14.0-7/input0
[    1.838290] input: FTCS1000:01 2808:0102 Mouse as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-0/i2c-FTCS1000:01/0018:2808:0102.0002/input/input8
[    1.838444] input: FTCS1000:01 2808:0102 Touchpad as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-0/i2c-FTCS1000:01/0018:2808:0102.0002/input/input9
[    1.838596] hid-generic 0018:2808:0102.0002: input,hidraw1: I2C HID v1.00 Mouse [FTCS1000:01 2808:0102] on i2c-FTCS1000:01
[    1.840139] nvme nvme0: missing or invalid SUBNQN field.
[    1.840335] nvme nvme0: D3 entry latency set to 8 seconds
[    1.860298] nvme nvme0: 18/0/0 default/read/poll queues
[    1.870725]  nvme0n1: p1 p2 p3
[    1.935588] input: FTCS1000:01 2808:0102 Mouse as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-0/i2c-FTCS1000:01/0018:2808:0102.0002/input/input11
[    1.936136] input: FTCS1000:01 2808:0102 Touchpad as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-0/i2c-FTCS1000:01/0018:2808:0102.0002/input/input12
[    1.936881] hid-multitouch 0018:2808:0102.0002: input,hidraw1: I2C HID v1.00 Mouse [FTCS1000:01 2808:0102] on i2c-FTCS1000:01
[    2.054781] fbcon: Taking over console
[    2.065150] Console: switching to colour frame buffer device 160x45
[    2.937301] input: ImPS/2 Generic Wheel Mouse as /devices/platform/i8042/serio1/input/input6
[    7.649238] ucsi_acpi USBC000:00: error -ETIMEDOUT: PPM init failed
[   12.343604] raid6: avx2x4   gen() 28246 MB/s
[   12.360604] raid6: avx2x2   gen() 41282 MB/s
[   12.377706] raid6: avx2x1   gen() 39396 MB/s
[   12.377706] raid6: using algorithm avx2x2 gen() 41282 MB/s
[   12.394698] raid6: .... xor() 28896 MB/s, rmw enabled
[   12.394698] raid6: using avx2x2 recovery algorithm
[   12.395842] xor: automatically using best checksumming function   avx       
[   12.427526] Btrfs loaded, zoned=yes, fsverity=yes
[   12.450655] BTRFS: device label kfocus_2404 devid 1 transid 7862 /dev/mapper/luks-1a8d8cdb-8d8f-4689-b744-8f32d2067f56 (252:0) scanned by mount (740)
[   12.451088] BTRFS info (device dm-0): first mount of filesystem aa8cb093-9cb3-4cc7-b44e-4bff76ca37fb
[   12.451103] BTRFS info (device dm-0): using crc32c (crc32c-intel) checksum algorithm
[   12.451110] BTRFS info (device dm-0): using free-space-tree
[   12.609723] systemd[1]: Inserted module 'autofs4'
[   12.750784] systemd[1]: systemd 255.4-1ubuntu8.4 running in system mode (+PAM +AUDIT +SELINUX +APPARMOR +IMA +SMACK +SECCOMP +GCRYPT -GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP +LIBFDISK +PCRE2 -PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD -BPF_FRAMEWORK -XKBCOMMON +UTMP +SYSVINIT default-hierarchy=unified)
[   12.750788] systemd[1]: Detected architecture x86-64.
[   12.751541] systemd[1]: Hostname set to <qa-m2>.
[   12.856471] systemd[1]: Configuration file /run/systemd/system/netplan-ovs-cleanup.service is marked world-inaccessible. This has no effect as configuration data is accessible via APIs without restrictions. Proceeding anyway.
[   12.883930] systemd[1]: Queued start job for default target graphical.target.
[   12.904703] systemd[1]: Created slice system-modprobe.slice - Slice /system/modprobe.
[   12.904901] systemd[1]: Created slice system-systemd\x2dcryptsetup.slice - Encrypted Volume Units Service Slice.
[   12.905052] systemd[1]: Created slice system-systemd\x2dfsck.slice - Slice /system/systemd-fsck.
[   12.905157] systemd[1]: Created slice user.slice - User and Session Slice.
[   12.905185] systemd[1]: Started systemd-ask-password-wall.path - Forward Password Requests to Wall Directory Watch.
[   12.905285] systemd[1]: Set up automount proc-sys-fs-binfmt_misc.automount - Arbitrary Executable File Formats File System Automount Point.
[   12.905295] systemd[1]: Expecting device dev-disk-by\x2duuid-167A\x2d6858.device - /dev/disk/by-uuid/167A-6858...
[   12.905300] systemd[1]: Expecting device dev-disk-by\x2duuid-1a8d8cdb\x2d8d8f\x2d4689\x2db744\x2d8f32d2067f56.device - /dev/disk/by-uuid/1a8d8cdb-8d8f-4689-b744-8f32d2067f56...
[   12.905305] systemd[1]: Expecting device dev-disk-by\x2duuid-aa8cb093\x2d9cb3\x2d4cc7\x2db44e\x2d4bff76ca37fb.device - /dev/disk/by-uuid/aa8cb093-9cb3-4cc7-b44e-4bff76ca37fb...
[   12.905309] systemd[1]: Expecting device dev-disk-by\x2duuid-abbbc711\x2d9904\x2d466b\x2d8a35\x2d783f0d19bf50.device - /dev/disk/by-uuid/abbbc711-9904-466b-8a35-783f0d19bf50...
[   12.905312] systemd[1]: Expecting device dev-mapper-luks\x2d1a8d8cdb\x2d8d8f\x2d4689\x2db744\x2d8f32d2067f56.device - /dev/mapper/luks-1a8d8cdb-8d8f-4689-b744-8f32d2067f56...
[   12.905323] systemd[1]: Reached target integritysetup.target - Local Integrity Protected Volumes.
[   12.905332] systemd[1]: Reached target nss-user-lookup.target - User and Group Name Lookups.
[   12.905339] systemd[1]: Reached target remote-fs.target - Remote File Systems.
[   12.905344] systemd[1]: Reached target slices.target - Slice Units.
[   12.905351] systemd[1]: Reached target snapd.mounts-pre.target - Mounting snaps.
[   12.905365] systemd[1]: Reached target veritysetup.target - Local Verity Protected Volumes.
[   12.905402] systemd[1]: Listening on dm-event.socket - Device-mapper event daemon FIFOs.
[   12.905648] systemd[1]: Listening on lvm2-lvmpolld.socket - LVM2 poll daemon socket.
[   12.905897] systemd[1]: Listening on syslog.socket - Syslog Socket.
[   12.905931] systemd[1]: Listening on systemd-fsckd.socket - fsck to fsckd communication Socket.
[   12.905952] systemd[1]: Listening on systemd-initctl.socket - initctl Compatibility Named Pipe.
[   12.905993] systemd[1]: Listening on systemd-journald-dev-log.socket - Journal Socket (/dev/log).
[   12.906043] systemd[1]: Listening on systemd-journald.socket - Journal Socket.
[   12.906067] systemd[1]: systemd-pcrextend.socket - TPM2 PCR Extension (Varlink) was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
[   12.906407] systemd[1]: Listening on systemd-udevd-control.socket - udev Control Socket.
[   12.906441] systemd[1]: Listening on systemd-udevd-kernel.socket - udev Kernel Socket.
[   12.907860] systemd[1]: Mounting dev-hugepages.mount - Huge Pages File System...
[   12.908370] systemd[1]: Mounting dev-mqueue.mount - POSIX Message Queue File System...
[   12.908861] systemd[1]: Mounting sys-kernel-debug.mount - Kernel Debug File System...
[   12.909340] systemd[1]: Mounting sys-kernel-tracing.mount - Kernel Trace File System...
[   12.911000] systemd[1]: Starting systemd-journald.service - Journal Service...
[   12.911045] systemd[1]: Finished blk-availability.service - Availability of block devices.
[   12.911814] systemd[1]: Starting keyboard-setup.service - Set the console keyboard layout...
[   12.912343] systemd[1]: Starting kmod-static-nodes.service - Create List of Static Device Nodes...
[   12.912937] systemd[1]: Starting lvm2-monitor.service - Monitoring of LVM2 mirrors, snapshots etc. using dmeventd or progress polling...
[   12.913423] systemd[1]: Starting modprobe@configfs.service - Load Kernel Module configfs...
[   12.913927] systemd[1]: Starting modprobe@dm_mod.service - Load Kernel Module dm_mod...
[   12.914401] systemd[1]: Starting modprobe@drm.service - Load Kernel Module drm...
[   12.914881] systemd[1]: Starting modprobe@efi_pstore.service - Load Kernel Module efi_pstore...
[   12.915296] systemd[1]: Starting modprobe@fuse.service - Load Kernel Module fuse...
[   12.915830] systemd[1]: Starting modprobe@loop.service - Load Kernel Module loop...
[   12.916253] systemd[1]: Starting modprobe@nvme_fabrics.service - Load Kernel Module nvme_fabrics...
[   12.916788] systemd[1]: Starting systemd-modules-load.service - Load Kernel Modules...
[   12.916796] systemd[1]: systemd-pcrmachine.service - TPM2 PCR Machine ID Measurement was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
[   12.917328] systemd[1]: Starting systemd-remount-fs.service - Remount Root and Kernel File Systems...
[   12.917369] systemd[1]: systemd-tpm2-setup-early.service - TPM2 SRK Setup (Early) was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
[   12.917934] systemd[1]: Starting systemd-udev-trigger.service - Coldplug All udev Devices...
[   12.918326] pstore: Using crash dump compression: deflate
[   12.918467] systemd[1]: Mounted dev-hugepages.mount - Huge Pages File System.
[   12.918513] systemd[1]: Mounted dev-mqueue.mount - POSIX Message Queue File System.
[   12.918542] systemd[1]: Mounted sys-kernel-debug.mount - Kernel Debug File System.
[   12.918568] systemd[1]: Mounted sys-kernel-tracing.mount - Kernel Trace File System.
[   12.918652] systemd[1]: Finished kmod-static-nodes.service - Create List of Static Device Nodes.
[   12.918743] systemd[1]: modprobe@configfs.service: Deactivated successfully.
[   12.918799] systemd[1]: Finished modprobe@configfs.service - Load Kernel Module configfs.
[   12.918886] systemd[1]: modprobe@dm_mod.service: Deactivated successfully.
[   12.918941] systemd[1]: Finished modprobe@dm_mod.service - Load Kernel Module dm_mod.
[   12.919020] systemd[1]: modprobe@drm.service: Deactivated successfully.
[   12.919068] systemd[1]: Finished modprobe@drm.service - Load Kernel Module drm.
[   12.919153] systemd[1]: modprobe@loop.service: Deactivated successfully.
[   12.919204] systemd[1]: Finished modprobe@loop.service - Load Kernel Module loop.
[   12.919676] systemd[1]: Mounting sys-kernel-config.mount - Kernel Configuration File System...
[   12.919714] systemd[1]: systemd-repart.service - Repartition Root Disk was skipped because no trigger condition checks were met.
[   12.920057] systemd-journald[811]: Collecting audit messages is disabled.
[   12.920460] systemd[1]: Starting systemd-tmpfiles-setup-dev-early.service - Create Static Device Nodes in /dev gracefully...
[   12.920585] systemd[1]: modprobe@fuse.service: Deactivated successfully.
[   12.920658] systemd[1]: Finished modprobe@fuse.service - Load Kernel Module fuse.
[   12.921099] systemd[1]: Mounting sys-fs-fuse-connections.mount - FUSE Control File System...
[   12.921684] Key type psk registered
[   12.923160] systemd[1]: Mounted sys-kernel-config.mount - Kernel Configuration File System.
[   12.923370] BTRFS info (device dm-0 state M): turning on sync discard
[   12.923375] BTRFS info (device dm-0 state M): enabling auto defrag
[   12.923376] BTRFS info (device dm-0 state M): use lzo compression, level 0
[   12.923903] systemd[1]: Finished systemd-remount-fs.service - Remount Root and Kernel File Systems.
[   12.924140] systemd[1]: Mounted sys-fs-fuse-connections.mount - FUSE Control File System.
[   12.924978] systemd[1]: systemd-hwdb-update.service - Rebuild Hardware Database was skipped because of an unmet condition check (ConditionNeedsUpdate=/etc).
[   12.925504] systemd[1]: Starting systemd-random-seed.service - Load/Save OS Random Seed...
[   12.925517] systemd[1]: systemd-tpm2-setup.service - TPM2 SRK Setup was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
[   12.927016] systemd[1]: modprobe@nvme_fabrics.service: Deactivated successfully.
[   12.927090] systemd[1]: Finished modprobe@nvme_fabrics.service - Load Kernel Module nvme_fabrics.
[   12.929946] lp: driver loaded but no devices found
[   12.944277] systemd[1]: Finished keyboard-setup.service - Set the console keyboard layout.
[   12.944767] systemd[1]: Started systemd-journald.service - Journal Service.
[   12.953430] ppdev: user-space parallel port driver
[   12.966418] systemd-journald[811]: Received client request to flush runtime journal.
[   12.975965] pstore: Registered efi_pstore as persistent store backend
[   12.981747] systemd-journald[811]: /var/log/journal/86d43f3761a64806a644a560706664c5/system.journal: Journal file uses a different sequence number ID, rotating.
[   12.981750] systemd-journald[811]: Rotating system journal.
[   13.021536] loop0: detected capacity change from 0 to 152056
[   13.021585] loop1: detected capacity change from 0 to 1034424
[   13.021617] loop2: detected capacity change from 0 to 8
[   13.021660] loop3: detected capacity change from 0 to 151296
[   13.021715] loop4: detected capacity change from 0 to 22752
[   13.021791] loop5: detected capacity change from 0 to 21952
[   13.023281] loop6: detected capacity change from 0 to 79328
[   13.023310] loop7: detected capacity change from 0 to 187776
[   13.024936] loop8: detected capacity change from 0 to 79520
[   13.030722] BTRFS info: devid 1 device path /dev/mapper/luks-1a8d8cdb-8d8f-4689-b744-8f32d2067f56 changed to /dev/dm-0 scanned by (udev-worker) (893)
[   13.031115] BTRFS info: devid 1 device path /dev/dm-0 changed to /dev/mapper/luks-1a8d8cdb-8d8f-4689-b744-8f32d2067f56 scanned by (udev-worker) (893)
[   13.045940] input: Intel HID events as /devices/platform/INTC1051:00/input/input14
[   13.049916] Consider using thermal netlink events interface
[   13.052303] intel_pmc_core INT33A1:00:  initialized
[   13.070226] mei_me 0000:00:16.0: enabling device (0000 -> 0002)
[   13.104190] i801_smbus 0000:00:1f.4: SPD Write Disable is set
[   13.104284] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
[   13.106344] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[   13.106827] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   13.107016] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c7248db18c600'
[   13.107073] intel_rapl_msr: PL4 support detected.
[   13.108793] intel_rapl_common: Found RAPL domain package
[   13.108806] intel_rapl_common: Found RAPL domain core
[   13.108815] intel_rapl_common: Found RAPL domain psys
[   13.118123] i2c i2c-2: Successfully instantiated SPD at 0x50
[   13.124149] intel_rapl_common: Found RAPL domain package
[   13.129274] spd5118 2-0050: DDR5 temperature sensor: vendor 0x06:0x32 revision 1.6
[   13.130404] Intel(R) Wireless WiFi driver for Linux
[   13.131751] mc: Linux media interface: v0.10
[   13.132382] Creating 1 MTD partitions on "0000:00:1f.5":
[   13.132401] 0x000000000000-0x000002000000 : "BIOS"
[   13.134194] ite_829x: loading out-of-tree module taints kernel.
[   13.134924] RAPL PMU: API unit is 2^-32 Joules, 3 fixed counters, 655360 ms ovfl timer
[   13.134932] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[   13.134932] RAPL PMU: hw unit of domain package 2^-14 Joules
[   13.134933] RAPL PMU: hw unit of domain psys 2^-14 Joules
[   13.135373] iwlwifi 0000:00:14.3: Detected crf-id 0x400410, cnv-id 0x80401 wfpm id 0x80000020
[   13.135403] iwlwifi 0000:00:14.3: PCI dev 7a70/0094, rev=0x430, rfid=0x2010d000
[   13.135407] iwlwifi 0000:00:14.3: Detected Intel(R) Wi-Fi 6E AX211 160MHz
[   13.136008] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-so-a0-gf-a0-89.ucode failed with error -2
[   13.136039] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-so-a0-gf-a0-88.ucode failed with error -2
[   13.136064] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-so-a0-gf-a0-87.ucode failed with error -2
[   13.142236] Bluetooth: Core ver 2.22
[   13.142444] NET: Registered PF_BLUETOOTH protocol family
[   13.142445] Bluetooth: HCI device and connection manager initialized
[   13.142453] Bluetooth: HCI socket layer initialized
[   13.142456] Bluetooth: L2CAP socket layer initialized
[   13.142466] Bluetooth: SCO socket layer initialized
[   13.142637] iwlwifi 0000:00:14.3: TLV_FW_FSEQ_VERSION: FSEQ Version: 0.0.2.41
[   13.143437] iwlwifi 0000:00:14.3: loaded firmware version 86.fb5c9aeb.0 so-a0-gf-a0-86.ucode op_mode iwlmvm
[   13.144910] videodev: Linux video capture interface: v2.00
[   13.145832] ite_829x 0003:048D:8910.0001: hiddev0,hidraw0: USB HID v1.10 Device [ITE Tech. Inc. ITE Device(829x)] on usb-0000:00:14.0-7/input0
[   13.156066] usbcore: registered new interface driver btusb
[   13.158674] Bluetooth: hci0: Device revision is 0
[   13.158682] Bluetooth: hci0: Secure boot is enabled
[   13.158683] Bluetooth: hci0: OTP lock is enabled
[   13.158684] Bluetooth: hci0: API lock is enabled
[   13.158685] Bluetooth: hci0: Debug lock is disabled
[   13.158686] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
[   13.158688] Bluetooth: hci0: Bootloader timestamp 2019.40 buildtype 1 build 38
[   13.159246] Bluetooth: hci0: DSM reset method type: 0x00
[   13.165344] Bluetooth: hci0: Found device firmware: intel/ibt-1040-0041.sfi
[   13.165361] Bluetooth: hci0: Boot Address: 0x100800
[   13.165364] Bluetooth: hci0: Firmware Version: 60-48.23
[   13.183522] usb 1-6: Found UVC 1.50 device Chicony USB2.0 Camera (04f2:b7e7)
[   13.230365] usb 1-6: Found UVC 1.50 device Chicony USB2.0 Camera (04f2:b7e7)
[   13.241022] usbcore: registered new interface driver uvcvideo
[   13.248037] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_1 due to name collision
[   13.248049] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_2 due to name collision
[   13.248060] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_3 due to name collision
[   13.248072] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_4 due to name collision
[   13.248084] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_5 due to name collision
[   13.248096] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_6 due to name collision
[   13.248109] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_7 due to name collision
[   13.248132] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_8 due to name collision
[   13.248162] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_9 due to name collision
[   13.248200] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_10 due to name collision
[   13.248228] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_11 due to name collision
[   13.248277] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_12 due to name collision
[   13.248302] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_13 due to name collision
[   13.248323] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_14 due to name collision
[   13.248341] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_15 due to name collision
[   13.248366] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_16 due to name collision
[   13.248393] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_17 due to name collision
[   13.248420] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_18 due to name collision
[   13.248458] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_19 due to name collision
[   13.248488] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_20 due to name collision
[   13.248556] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_21 due to name collision
[   13.248646] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_22 due to name collision
[   13.248733] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_23 due to name collision
[   13.248809] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_24 due to name collision
[   13.248860] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_25 due to name collision
[   13.248904] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_26 due to name collision
[   13.248963] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_27 due to name collision
[   13.249025] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_28 due to name collision
[   13.249089] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_29 due to name collision
[   13.249121] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_30 due to name collision
[   13.249160] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_31 due to name collision
[   13.249201] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_32 due to name collision
[   13.249236] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_33 due to name collision
[   13.249277] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_34 due to name collision
[   13.249334] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_35 due to name collision
[   13.249379] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_36 due to name collision
[   13.249427] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_37 due to name collision
[   13.249477] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_38 due to name collision
[   13.249549] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_39 due to name collision
[   13.249621] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_40 due to name collision
[   13.249682] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_41 due to name collision
[   13.249745] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_42 due to name collision
[   13.249823] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_43 due to name collision
[   13.249918] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_44 due to name collision
[   13.250010] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_45 due to name collision
[   13.250017] MXM: GUID detected in BIOS
[   13.250094] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_46 due to name collision
[   13.250193] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_47 due to name collision
[   13.250289] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_48 due to name collision
[   13.250366] pci 0000:02:00.0: optimus capabilities: enabled, status dynamic power, hda bios codec supported
[   13.250372] VGA switcheroo: detected Optimus DSM method \_SB_.PC00.PEG2.PEGP handle
[   13.250374] nouveau: detected PR support, will not use DSM
[   13.250386] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_49 due to name collision
[   13.250495] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_50 due to name collision
[   13.250610] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_51 due to name collision
[   13.250616] nouveau 0000:02:00.0: NVIDIA AD104 (194000a1)
[   13.250724] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_52 due to name collision
[   13.250850] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_53 due to name collision
[   13.250983] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_54 due to name collision
[   13.251107] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_55 due to name collision
[   13.251235] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_56 due to name collision
[   13.251360] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_57 due to name collision
[   13.251503] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_58 due to name collision
[   13.251634] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_59 due to name collision
[   13.251764] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_60 due to name collision
[   13.251918] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_61 due to name collision
[   13.252061] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_62 due to name collision
[   13.252221] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_63 due to name collision
[   13.252376] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_64 due to name collision
[   13.252530] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_65 due to name collision
[   13.252678] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_66 due to name collision
[   13.252804] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_67 due to name collision
[   13.252910] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_68 due to name collision
[   13.253063] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_69 due to name collision
[   13.253260] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_70 due to name collision
[   13.253437] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_71 due to name collision
[   13.253620] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_72 due to name collision
[   13.253807] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_73 due to name collision
[   13.253986] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_74 due to name collision
[   13.254192] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_75 due to name collision
[   13.254396] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_76 due to name collision
[   13.254599] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_77 due to name collision
[   13.254816] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_78 due to name collision
[   13.255027] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_79 due to name collision
[   13.255242] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_80 due to name collision
[   13.255467] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_81 due to name collision
[   13.255688] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_82 due to name collision
[   13.255920] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_83 due to name collision
[   13.256147] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_84 due to name collision
[   13.256378] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_85 due to name collision
[   13.256621] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_86 due to name collision
[   13.256844] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_87 due to name collision
[   13.257063] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_88 due to name collision
[   13.257295] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_89 due to name collision
[   13.257508] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_90 due to name collision
[   13.257731] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_91 due to name collision
[   13.257985] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_92 due to name collision
[   13.258267] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_93 due to name collision
[   13.258497] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_94 due to name collision
[   13.258749] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_95 due to name collision
[   13.258955] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_96 due to name collision
[   13.259157] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_97 due to name collision
[   13.259369] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_98 due to name collision
[   13.259567] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_99 due to name collision
[   13.259771] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_100 due to name collision
[   13.259985] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_101 due to name collision
[   13.260231] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_102 due to name collision
[   13.260456] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_103 due to name collision
[   13.260674] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_104 due to name collision
[   13.260899] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_105 due to name collision
[   13.261116] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_106 due to name collision
[   13.261348] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_107 due to name collision
[   13.261579] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_108 due to name collision
[   13.261825] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_109 due to name collision
[   13.262077] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_110 due to name collision
[   13.262433] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_111 due to name collision
[   13.262786] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_112 due to name collision
[   13.263117] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_113 due to name collision
[   13.263440] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_114 due to name collision
[   13.263767] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_115 due to name collision
[   13.264132] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_116 due to name collision
[   13.264467] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_117 due to name collision
[   13.264810] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_118 due to name collision
[   13.265146] ite_829x 0003:048D:8910.0001: Led rgb:kbd_backlight renamed to rgb:kbd_backlight_119 due to name collision
[   13.279195] snd_hda_intel 0000:00:1f.3: enabling device (0000 -> 0002)
[   13.279398] snd_hda_intel 0000:02:00.1: enabling device (0000 -> 0002)
[   13.279448] snd_hda_intel 0000:02:00.1: Disabling MSI
[   13.279450] snd_hda_intel 0000:02:00.1: Handle vga_switcheroo audio client
[   13.295777] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC1220: line_outs=1 (0x1b/0x0/0x0/0x0/0x0) type:speaker
[   13.295783] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[   13.295785] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=1 (0x14/0x0/0x0/0x0/0x0)
[   13.295787] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=0x0
[   13.295788] snd_hda_codec_realtek hdaudioC0D0:    dig-out=0x1e/0x0
[   13.295789] snd_hda_codec_realtek hdaudioC0D0:    inputs:
[   13.295790] snd_hda_codec_realtek hdaudioC0D0:      Mic=0x18
[   13.295792] snd_hda_codec_realtek hdaudioC0D0:      Internal Mic=0x12
[   13.298770] input: HDA NVidia HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:01.1/0000:02:00.1/sound/card1/input15
[   13.298832] input: HDA NVidia HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:01.1/0000:02:00.1/sound/card1/input16
[   13.298863] input: HDA NVidia HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:01.1/0000:02:00.1/sound/card1/input17
[   13.298888] input: HDA NVidia HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:01.1/0000:02:00.1/sound/card1/input18
[   13.306091] input: HDA Intel PCH Mic as /devices/pci0000:00/0000:00:1f.3/sound/card0/input19
[   13.306152] input: HDA Intel PCH Headphone as /devices/pci0000:00/0000:00:1f.3/sound/card0/input20
[   13.312341] intel_tcc_cooling: Programmable TCC Offset detected
[   13.448390] iwlwifi 0000:00:14.3: WFPM_UMAC_PD_NOTIFICATION: 0x20
[   13.448421] iwlwifi 0000:00:14.3: WFPM_LMAC2_PD_NOTIFICATION: 0x1f
[   13.448430] iwlwifi 0000:00:14.3: WFPM_AUTH_KEY_0: 0x90
[   13.448439] iwlwifi 0000:00:14.3: CNVI_SCU_SEQ_DATA_DW9: 0x0
[   13.449187] iwlwifi 0000:00:14.3: loaded PNVM version e28bb9d7
[   13.449536] iwlwifi 0000:00:14.3: RFIm is deactivated, reason = 5
[   13.465996] iwlwifi 0000:00:14.3: Detected RF GF, rfid=0x2010d000
[   13.519846] nouveau 0000:02:00.0: bios: version 95.04.63.00.24
[   13.525018] Console: switching to colour dummy device 80x25
[   13.534821] iwlwifi 0000:00:14.3: base HW address: dc:97:ba:75:8a:32
[   13.535185] nouveau 0000:02:00.0: vgaarb: deactivate vga console
[   13.561933] iwlwifi 0000:00:14.3 wlp0s20f3: renamed from wlan0
[   13.932204] BTRFS: device label kfocus_boot devid 1 transid 455 /dev/nvme0n1p2 (259:2) scanned by mount (1412)
[   13.932695] BTRFS info (device nvme0n1p2): first mount of filesystem abbbc711-9904-466b-8a35-783f0d19bf50
[   13.932703] BTRFS info (device nvme0n1p2): using crc32c (crc32c-intel) checksum algorithm
[   13.932706] BTRFS info (device nvme0n1p2): using free-space-tree
[   13.943050] Adding 524284k swap on /swap/swapfile.  Priority:-2 extents:2 across:1686444k SS
[   13.965747] audit: type=1400 audit(1730229754.531:2): apparmor="STATUS" operation="profile_load" profile="unconfined" name="Discord" pid=1468 comm="apparmor_parser"
[   13.965762] audit: type=1400 audit(1730229754.531:3): apparmor="STATUS" operation="profile_load" profile="unconfined" name=4D6F6E676F444220436F6D70617373 pid=1469 comm="apparmor_parser"
[   13.965787] audit: type=1400 audit(1730229754.531:4): apparmor="STATUS" operation="profile_load" profile="unconfined" name="busybox" pid=1474 comm="apparmor_parser"
[   13.965992] audit: type=1400 audit(1730229754.531:5): apparmor="STATUS" operation="profile_load" profile="unconfined" name="brave" pid=1472 comm="apparmor_parser"
[   13.966017] audit: type=1400 audit(1730229754.531:6): apparmor="STATUS" operation="profile_load" profile="unconfined" name="crun" pid=1480 comm="apparmor_parser"
[   13.966092] audit: type=1400 audit(1730229754.531:7): apparmor="STATUS" operation="profile_load" profile="unconfined" name="QtWebEngineProcess" pid=1470 comm="apparmor_parser"
[   13.966265] audit: type=1400 audit(1730229754.531:8): apparmor="STATUS" operation="profile_load" profile="unconfined" name="1password" pid=1467 comm="apparmor_parser"
[   13.966309] audit: type=1400 audit(1730229754.531:9): apparmor="STATUS" operation="profile_load" profile="unconfined" name="ch-checkns" pid=1476 comm="apparmor_parser"
[   13.966351] audit: type=1400 audit(1730229754.531:10): apparmor="STATUS" operation="profile_load" profile="unconfined" name="balena-etcher" pid=1471 comm="apparmor_parser"
[   13.966451] audit: type=1400 audit(1730229754.531:11): apparmor="STATUS" operation="profile_load" profile="unconfined" name="vscode" pid=1479 comm="apparmor_parser"
[   14.538307] nouveau 0000:02:00.0: drm: VRAM: 12282 MiB
[   14.538311] nouveau 0000:02:00.0: drm: GART: 536870912 MiB
[   14.574703] Bluetooth: hci0: Waiting for firmware download to complete
[   14.575694] Bluetooth: hci0: Firmware loaded in 1377287 usecs
[   14.575716] Bluetooth: hci0: Waiting for device to boot
[   14.591683] Bluetooth: hci0: Device booted in 15601 usecs
[   14.591687] Bluetooth: hci0: Malformed MSFT vendor event: 0x02
[   14.592737] nouveau 0000:02:00.0: drm: MM: using COPY for buffer copies
[   14.593914] Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-1040-0041.ddc
[   14.595693] Bluetooth: hci0: Applying Intel DDC parameters completed
[   14.598800] Bluetooth: hci0: Firmware timestamp 2023.48 buildtype 1 build 75324
[   14.598804] Bluetooth: hci0: Firmware SHA1: 0x23bac558
[   14.602705] Bluetooth: hci0: Fseq status: Success (0x00)
[   14.602706] Bluetooth: hci0: Fseq executed: 00.00.02.41
[   14.602707] Bluetooth: hci0: Fseq BT Top: 00.00.02.41
[   14.628018] snd_hda_intel 0000:02:00.1: bound 0000:02:00.0 (ops disp50xx_modifiers [nouveau])
[   14.632656] acpi device:06: registered as cooling_device36
[   14.632908] [drm] Initialized nouveau 1.4.0 for 0000:02:00.0 on minor 0
[   14.650554] fbcon: nouveaudrmfb (fb0) is primary device
[   14.651609] snd_hda_codec_hdmi hdaudioC1D0: HDMI: pin NID 0x4 not registered
[   15.707521] Console: switching to colour frame buffer device 160x45
[   15.709377] nouveau 0000:02:00.0: [drm] fb0: nouveaudrmfb frame buffer device
[   15.902452] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   15.902455] Bluetooth: BNEP filters: protocol multicast
[   15.902458] Bluetooth: BNEP socket layer initialized
[   15.903462] Bluetooth: MGMT ver 1.23
[   15.906119] NET: Registered PF_ALG protocol family
[   15.949753] loop9: detected capacity change from 0 to 8
[   15.967008] NET: Registered PF_QIPCRTR protocol family
[   16.499986] iwlwifi 0000:00:14.3: WFPM_UMAC_PD_NOTIFICATION: 0x20
[   16.500025] iwlwifi 0000:00:14.3: WFPM_LMAC2_PD_NOTIFICATION: 0x1f
[   16.500059] iwlwifi 0000:00:14.3: WFPM_AUTH_KEY_0: 0x90
[   16.500092] iwlwifi 0000:00:14.3: CNVI_SCU_SEQ_DATA_DW9: 0x0
[   16.500965] iwlwifi 0000:00:14.3: RFIm is deactivated, reason = 5
[   16.603894] iwlwifi 0000:00:14.3: Registered PHC clock: iwlwifi-PTP, with index: 1
[   19.241597] igc 0000:03:00.0 enp3s0: NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
[   27.097644] snd_hda_codec_hdmi hdaudioC1D0: HDMI: pin NID 0x4 not registered
[   28.967758] Bluetooth: RFCOMM TTY layer initialized
[   28.967766] Bluetooth: RFCOMM socket layer initialized
[   28.967769] Bluetooth: RFCOMM ver 1.11
[   32.329528] systemd-journald[811]: /var/log/journal/86d43f3761a64806a644a560706664c5/user-1000.journal: Journal file uses a different sequence number ID, rotating.
[   33.504085] warning: `kded5' uses wireless extensions which will stop working for Wi-Fi 7 hardware; use nl80211
[   33.703721] snd_hda_codec_hdmi hdaudioC1D0: HDMI: pin NID 0x4 not registered
[   34.523314] xhci_hcd 0000:2d:00.0: xHC error in resume, USBSTS 0x401, Reinit
[   34.523318] usb usb3: root hub lost power or was reset
[   34.523319] usb usb4: root hub lost power or was reset
[   58.597171] wlp0s20f3: authenticate with a0:55:1f:2f:2c:93 (local address=dc:97:ba:75:8a:32)
[   58.599078] wlp0s20f3: send auth to a0:55:1f:2f:2c:93 (try 1/3)
[   58.642642] wlp0s20f3: authenticate with a0:55:1f:2f:2c:93 (local address=dc:97:ba:75:8a:32)
[   58.643027] wlp0s20f3: send auth to a0:55:1f:2f:2c:93 (try 1/3)
[   58.649387] wlp0s20f3: authenticated
[   58.650458] wlp0s20f3: associate with a0:55:1f:2f:2c:93 (try 1/3)
[   58.659711] wlp0s20f3: RX AssocResp from a0:55:1f:2f:2c:93 (capab=0x1011 status=0 aid=24)
[   58.678738] wlp0s20f3: associated
[ 1421.258052] usb 1-9: new full-speed USB device number 5 using xhci_hcd
[ 1421.396458] usb 1-9: not running at top speed; connect to a high speed hub
[ 1421.410532] usb 1-9: New USB device found, idVendor=2109, idProduct=0103, bcdDevice= 2.00
[ 1421.410545] usb 1-9: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[ 1421.410549] usb 1-9: Product: USB 2.0 BILLBOARD             
[ 1421.410553] usb 1-9: Manufacturer: VIA Technologies Inc.         
[ 1421.410556] usb 1-9: SerialNumber: 0000000000000001
[ 1729.921242] usb 1-10: new high-speed USB device number 6 using xhci_hcd
[ 1730.065261] usb 1-10: New USB device found, idVendor=0bda, idProduct=5411, bcdDevice= 1.49
[ 1730.065275] usb 1-10: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[ 1730.065279] usb 1-10: Product: 4-Port USB 2.0 Hub
[ 1730.065283] usb 1-10: Manufacturer: Generic
[ 1730.068045] hub 1-10:1.0: USB hub found
[ 1730.070356] hub 1-10:1.0: 4 ports detected
[ 1731.287224] usb 1-10.3: new full-speed USB device number 7 using xhci_hcd
[ 1731.373539] usb 1-10.3: New USB device found, idVendor=043e, idProduct=9a39, bcdDevice= 4.11
[ 1731.373553] usb 1-10.3: New USB device strings: Mfr=1, Product=3, SerialNumber=4
[ 1731.373558] usb 1-10.3: Product: LG Monitor Controls
[ 1731.373562] usb 1-10.3: Manufacturer: LG Electronics Inc.
[ 1731.373565] usb 1-10.3: SerialNumber: 005INTX1F153
[ 1731.380354] hid-generic 0003:043E:9A39.0003: hiddev1,hidraw2: USB HID v1.11 Device [LG Electronics Inc. LG Monitor Controls] on usb-0000:00:14.0-10.3/input0
[ 1815.428971] xhci_hcd 0000:2d:00.0: xHC error in resume, USBSTS 0x401, Reinit
[ 1815.428976] usb usb3: root hub lost power or was reset
[ 1815.428978] usb usb4: root hub lost power or was reset

--MP_/0APf0mG6H/xJK_aO4=o6w9b--

