Return-Path: <linux-kernel+bounces-179397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8498C5FBD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 06:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1BC91C21D62
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 04:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378DF38FB6;
	Wed, 15 May 2024 04:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gijaTxiH"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0584C23D7;
	Wed, 15 May 2024 04:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715747068; cv=none; b=Jm66mM3V9M38SkwHPiA5jZWg+xz8OztMG09JHCxBT3oanERDiS2gKzt8AiwVOeWwc7jwR30YnspEg9bI+zbUMohHI/cRgywg7UgA0hpy2WoTioHDdI9JhSUotZhaMMfbD+L/agtf4czlrOh+VeR9xELefbrEb72/BKnUsZ6EnU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715747068; c=relaxed/simple;
	bh=n0/8MoO3v1R9tapgIO+J09N9yNjTcc9+zZ5gLC+8UOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=stYYWb5IdxZf0QilV4VSrC5/BL9XIVdNXsEIyWd8JfW5qlAw67vzl7AQWM1Tbw/rwtP02zUTkOtGpQfUJRvF9gMpoCiXwG8m3peU2y11dZvWxiR5nbPy+at+A6Oje4kivFlLt9n5AWZ8RDpSw2nua6V1uFMyYSQVYg1yfG1qSjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gijaTxiH; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5f80aa2d4a3so4992259a12.0;
        Tue, 14 May 2024 21:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715747066; x=1716351866; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q2rsm1NJsgZPzAH8gk3mncdDifRxN4sJYMQ3cyC9C7A=;
        b=gijaTxiHJPBAINl6Y4ZPnaOowUqLsNbB8oJoXvs/UL+qnvVGMW8PKt/IHTCk2kK9zU
         IGD64l1dWALfCfpQFmm+UIHkE1RHKgBuiM3u1F5DJcd+zFgw5tahMYOCWxnElwmHrsZx
         oPq1U1DHiB6+AoXbs6FyWJr9v8Vydui5Gq4YUR67ohsQW7rtlxrneGRttY8r/8TSUjl8
         2NBZyP+TOvXNCdoBWYRi44tfalg0pRx/sx+684H9p3zwrNXd/SJ4cRGbCZnI9XNLKmWA
         XFSQDeEa1L1czwHwMx/LtA6xktF576NgtwZMnyTJ3AhWXPcnhkDUUq2R0zaglxfdz9R8
         GEQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715747066; x=1716351866;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q2rsm1NJsgZPzAH8gk3mncdDifRxN4sJYMQ3cyC9C7A=;
        b=Kloa2695ZfWRz3MwN4+1c3XCzciqpdWDRB7OVrhpabCrmD0ctbEyNewAl2X3fkwfNl
         u3B0p4u1oBud1MpQCi8YmNmQtPTIh7uMOzXcwVfQTyKv7yskZKasepchu7jr76PofTdt
         VgdvMR/nuXiZFlQkMzD1KZq3gOP3QjrO6El3nsKvuOvOxaH3R2m6s0Ltp+mnQU1lGOP5
         L1bbCzDpuTOJvExI6Tzj/n0gGsfD562B/6jzrHqquUih2p7ZaSofs/gIJaEpJ56gpeWK
         8n2rdGs+FSvWqs9RlrXiWdSGf7Yt98UGPaJg3H/hGRijQSfUv8TGfMB/VV5naq44b5hV
         6NqA==
X-Forwarded-Encrypted: i=1; AJvYcCUJFoNAmiNjH7hzQ72z7mclAVl6/W/AiAnbO1e6hGfBqjd/NznbbWZuqlbHNKEOkflBV9WRHGr0b5LmntKjAHIkd2L/RkcKYrZ0VxK7MtMLgYj7ffZhVAof0ZovugtddoHR7M4Pk3dL
X-Gm-Message-State: AOJu0YwZjdayDkOsNFaab9QS5ucwEqUcOht8PsKxqurPwlwedFKPsPF7
	1ZDg606Gr/zh4P0RpcyS6TV7bOHqYxRJ1qK2dBdYDcI69GymGQ76ouZKkfbMDdA=
X-Google-Smtp-Source: AGHT+IHaEyZ9+wxWtBqCL0f0IDmOcJkLZAPTaM/9b/QIJTDWinjbIv+IjeDs28khRlNDhltJwVWekA==
X-Received: by 2002:a05:6a20:9717:b0:1af:ac6c:367f with SMTP id adf61e73a8af0-1afde19799emr12581952637.44.1715747065864;
        Tue, 14 May 2024 21:24:25 -0700 (PDT)
Received: from server (S0106f85e42401d5e.cg.shawcable.net. [174.0.240.170])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf31420sm107061315ad.172.2024.05.14.21.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 21:24:25 -0700 (PDT)
Date: Wed, 15 May 2024 04:24:23 +0000
From: Abhinav Saxena <xandfury@gmail.com>
To: linux-sound@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH] Documentation: sound: Fix trailing whitespaces
Message-ID: <ZkQ496Y1SWSr4dDi@server>
References: <20240515034103.1010269-1-xandfury@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240515034103.1010269-1-xandfury@gmail.com>

Adding Shuah Khan<skhan@linuxfoundation.org> to cc.

-Abhinav.

On Wed, May 15, 2024 at 03:41:03AM +0000, Abhinav Saxena wrote:
> Remove trailing whitespace from sound/hd-audio/notes as reported by
> checkpatch. Removing trailing spaces improves consistency, and
> prevents Preventing potential merge conflicts due to whitespace
> differences. maintain a cleaner and more professional codebase.
> 
> Signed-off-by: Abhinav Saxena <xandfury@gmail.com>
> ---
>  Documentation/sound/hd-audio/notes.rst | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/sound/hd-audio/notes.rst b/Documentation/sound/hd-audio/notes.rst
> index a9e35b1f87bd..ef6a4513cce7 100644
> --- a/Documentation/sound/hd-audio/notes.rst
> +++ b/Documentation/sound/hd-audio/notes.rst
> @@ -15,7 +15,7 @@ problem is broken BIOS, and the rest is the driver implementation.
>  This document explains the brief trouble-shooting and debugging
>  methods for the	HD-audio hardware.
>  
> -The HD-audio component consists of two parts: the controller chip and 
> +The HD-audio component consists of two parts: the controller chip and
>  the codec chips on the HD-audio bus.  Linux provides a single driver
>  for all controllers, snd-hda-intel.  Although the driver name contains
>  a word of a well-known hardware vendor, it's not specific to it but for
> @@ -81,7 +81,7 @@ the wake-up timing.  It wakes up a few samples before actually
>  processing the data on the buffer.  This caused a lot of problems, for
>  example, with ALSA dmix or JACK.  Since 2.6.27 kernel, the driver puts
>  an artificial delay to the wake up timing.  This delay is controlled
> -via ``bdl_pos_adj`` option. 
> +via ``bdl_pos_adj`` option.
>  
>  When ``bdl_pos_adj`` is a negative value (as default), it's assigned to
>  an appropriate value depending on the controller chip.  For Intel
> @@ -144,7 +144,7 @@ see a regression wrt the sound quality (stuttering, etc) or a lock-up
>  in the recent kernel, try to pass ``enable_msi=0`` option to disable
>  MSI.  If it works, you can add the known bad device to the blacklist
>  defined in hda_intel.c.  In such a case, please report and give the
> -patch back to the upstream developer. 
> +patch back to the upstream developer.
>  
>  
>  HD-Audio Codec
> @@ -375,7 +375,7 @@ HD-Audio Reconfiguration
>  ------------------------
>  This is an experimental feature to allow you re-configure the HD-audio
>  codec dynamically without reloading the driver.  The following sysfs
> -files are available under each codec-hwdep device directory (e.g. 
> +files are available under each codec-hwdep device directory (e.g.
>  /sys/class/sound/hwC0D0):
>  
>  vendor_id
> @@ -433,7 +433,7 @@ re-configure based on that state, run like below:
>  ::
>  
>      # echo 0x14 0x9993013f > /sys/class/sound/hwC0D0/user_pin_configs
> -    # echo 1 > /sys/class/sound/hwC0D0/reconfig  
> +    # echo 1 > /sys/class/sound/hwC0D0/reconfig
>  
>  
>  Hint Strings
> @@ -494,7 +494,7 @@ indep_hp (bool)
>      mixer control, if available
>  add_stereo_mix_input (bool)
>      add the stereo mix (analog-loopback mix) to the input mux if
> -    available 
> +    available
>  add_jack_modes (bool)
>      add "xxx Jack Mode" enum controls to each I/O jack for allowing to
>      change the headphone amp and mic bias VREF capabilities
> @@ -504,7 +504,7 @@ power_save_node (bool)
>      stream states
>  power_down_unused (bool)
>      power down the unused widgets, a subset of power_save_node, and
> -    will be dropped in future 
> +    will be dropped in future
>  add_hp_mic (bool)
>      add the headphone to capture source if possible
>  hp_mic_detect (bool)
> @@ -603,7 +603,7 @@ present.
>  
>  The patch module option is specific to each card instance, and you
>  need to give one file name for each instance, separated by commas.
> -For example, if you have two cards, one for an on-board analog and one 
> +For example, if you have two cards, one for an on-board analog and one
>  for an HDMI video board, you may pass patch option like below:
>  ::
>  
> -- 
> 2.34.1
> 

