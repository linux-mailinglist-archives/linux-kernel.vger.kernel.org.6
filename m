Return-Path: <linux-kernel+bounces-439640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECA69EB21C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A64681687CB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 13:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F881AA1E5;
	Tue, 10 Dec 2024 13:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IMz40zeb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72081A76DE
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 13:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733838166; cv=none; b=uJM9xWbv92t6nuR0A6twvH3Gylq579rAFEq98nCoEStA0tksmzRq7XZGEWuty7teOjf0sVHLEMezOUz07nPtOTdsOrL2SeAk7WpmlnhcqbTw4bk8E4KhkJH/OsPH8nZvwijNMCzGsDgQo2gyuuQ/sH69mLUtQnZgq6rUJ+g7t9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733838166; c=relaxed/simple;
	bh=IqTrI4naYOAJ/t/xfI/NuIbdpbFIjG8cHuuNeO4O4fE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=C0l/wjt/L50P2NgYzpxMPmq/yS9oXJ7FM+BNAr1zlSQZcDNZ/XIpDyjYTKWv2BQ+QK6cnfT555wuJX8dIHGcCF5OqXiEdxTqLD+31asG/hGdSv6F0XbglVxUl0gdw70+zhg8R15oNsZuebQOuA+DtNs4JEyV6N++aiCx8wwPwvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IMz40zeb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733838163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K2evyBV6XmxxlV1avo/FS+rwZXLHzCz3qHmAF9H2G/I=;
	b=IMz40zebsQnAdI30VB41aRgufFrARYV7m4zI/Kn7NuS0SD6C4ERZk8//AmaE9nQDqtPifl
	+uJtdU1MzTjOhTHO4TQP7AT/vj9OAL0g2vD9G97FGJSpjls8CZVlB8XF14WD+8u/HzfhoN
	5+B/0Zb2ksn3aZOcpBQAgvp6t5ljDQQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-7OBdf41XPk2rE-wk94vBJA-1; Tue, 10 Dec 2024 08:42:42 -0500
X-MC-Unique: 7OBdf41XPk2rE-wk94vBJA-1
X-Mimecast-MFC-AGG-ID: 7OBdf41XPk2rE-wk94vBJA
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-434f0237cf7so25001775e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 05:42:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733838161; x=1734442961;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K2evyBV6XmxxlV1avo/FS+rwZXLHzCz3qHmAF9H2G/I=;
        b=ShjmQLDCZXSQfjPy/SpKF6j9zkFIiyd/4/xvWP1qwqVwe0zHpL/8l/HIFI7KzlcAnN
         ONlEWH3i/aFlgh2mS6PP3N5KHowR88Sv6DkIdRk9HHlpZEsTd29RN0O+EXhl8Rv4+kd0
         4OB8XKlJZkyL6PfW7YdhKpFsCl0x03CSttjw1L8yeHsQYBc1tLA1/bsnmPl6/vncwGkS
         04dGenH2A7RUjjAAAIwqn5v1am/2lit88UFJAOS8df3OQEDffT+8W+UCDAtFjd5MvIzL
         bcInJ4/oAM4hChLc6iurJTVQtKPf35X88BniPXVmegMN6SFVnjXMKgrEw5L5/2AsYJxm
         TRaA==
X-Forwarded-Encrypted: i=1; AJvYcCXCZWNnSOFLCu3yUGuZ+KJRrf+0Ng7I4h5M+kb9uUVMvOV1RGRdoV1oPe0uW19rwZgMcIxsYFh2AR8/DqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyidX5tw4IYUZYCa7W+LcYB74uyrcIN2cMCF4mW6bQ7BpHDN7Xo
	yTaU1bLEF6BIPJWPnw52dyT4+IwPhiw65HXj68Wy0344P4+1Tt0vzCNaZ//5I0TLhYPL+Wyt6q0
	5UQX0vANptmnLaj3bh4ic9U0yvliTn5gHeoc8sf2x0dY1NuYNxqj9PHc34+GV+QHne04Ndq07
X-Gm-Gg: ASbGncuBq9bWFSxh88C8jFkNs2wvGWLsl9jguUs5NRqSlHZ8XxxEnC3VbYIwfgrcX3H
	BnZMwyVvSNuJRaThAShPhOdaw1zG1Bgvbd0fMjs6Fv0Qvfe2sxJrn3iOA4AlIDqW6l+x2o/x/7D
	JPIGdvKvucpqO6yyVaDn4iiA7FFjQIN+cmyqeuDYb5CszGZb76OAw1ZOwMEyCFEHtlUTPPDipB3
	jMOZTWmUXqExssRQXFghEtCHBiU8Blg7kokz/xkmnGwbI2+g/vomC2AUhJo6TIFBPBOoJMRwVVm
	DQjaMQj9k1avlQ6Ucg==
X-Received: by 2002:a05:6000:4604:b0:385:d7f9:f16c with SMTP id ffacd0b85a97d-386453f9740mr4345814f8f.46.1733838161180;
        Tue, 10 Dec 2024 05:42:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG/EzS42fP8Ylhxmzy6/cZtctx2cg5XbsNOtmOhU/S0scujl/REYju6ycezW9PzMx/GLIdX/A==
X-Received: by 2002:a05:6000:4604:b0:385:d7f9:f16c with SMTP id ffacd0b85a97d-386453f9740mr4345761f8f.46.1733838160742;
        Tue, 10 Dec 2024 05:42:40 -0800 (PST)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-386221a5eadsm15742309f8f.104.2024.12.10.05.42.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 05:42:40 -0800 (PST)
Message-ID: <ca4485de-5463-4356-a024-fcabde45478d@redhat.com>
Date: Tue, 10 Dec 2024 14:42:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/6] drm/log: Introduce a new boot logger to draw the
 kmsg on the screen
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 John Ogness <john.ogness@linutronix.de>,
 Javier Martinez Canillas <javierm@redhat.com>,
 "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
 bluescreen_avenger@verizon.net, Caleb Connolly <caleb.connolly@linaro.org>,
 Petr Mladek <pmladek@suse.com>, Jani Nikula <jani.nikula@linux.intel.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20241204160014.1171469-1-jfalempe@redhat.com>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20241204160014.1171469-1-jfalempe@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/12/2024 16:44, Jocelyn Falempe wrote:
> drm_log is a simple logger that uses the drm_client API to print the kmsg boot log on the screen.
> This is not a full replacement to fbcon, as it will only print the kmsg.
> It will never handle user input, or a terminal because this is better done in userspace.
> 
> If you're curious on how it looks like, I've put a small demo here:
> https://people.redhat.com/jfalempe/drm_log/drm_log_draft_boot_v2.mp4

I just pushed it to drm-misc-next.

Thanks all for your reviews and comments.

Best regards,

-- 

Jocelyn
> 
> Design decisions:
>    * It uses the drm_client API, so it should work on all drm drivers from the start.
>    * It doesn't scroll the message, that way it doesn't need to redraw the whole screen for each new message.
>      It also means it doesn't have to keep drawn messages in memory, to redraw them when scrolling.
>    * It uses the new non-blocking console API, so it should work well with PREEMPT_RT
>   
> v2:
>   * Use vmap_local() api, with that change, I've tested it successfully on simpledrm, virtio-gpu, amdgpu, and nouveau.
>   * Stop drawing when the drm_master is taken. This avoid wasting CPU cycle if the buffer is not visible.
>   * Use deferred probe. Only do the probe the first time there is a log to draw. With this, if you boot with quiet, drm_log won't do any modeset.
>   * Add color support for the timestamp prefix, like what dmesg does.
>   * Add build dependency on  disabling the fbdev emulation, as they are both drm_client, and there is no way to choose which one gets the focus.
> 
> v3:
>   * Remove the work thread and circular buffer, and use the new write_thread() console API.
>   * Register a console for each drm driver.
> 
> v4:
>   * Can be built as a module, even if that's not really useful.
>   * Rebased on top of "drm: Introduce DRM client library" series from Thomas Zimmermann.
>   * Add a Kconfig menu to choose between drm client.
>   * Add suspend/resume callbacks.
>   * Add integer scaling support.
>   
> v5:
>   * Build drm_log in drm_client_lib module, to avoid circular dependency.
>   * Export drm_draw symbols, so they can be used if drm_client_lib is built as module.
>   * Change scale parameter to unsigned int (Jani Nikula)
> 
> v6:
>   * Use console_stop() and console_start() in the suspend/resume callback (Petr Mladek).
>   * rebase and solve conflict with "drm/panic: Add ABGR2101010 support"
> 
> v7:
>   * Add a patch fix a build issue due to missing DRM_CLIENT_LIB, reported by kernel test bot.
> 
> v8:
>   * Rebased after drm client moved to drivers/gpu/drm/clients/
>   * Rename DRM_LOG to DRM_CLIENT_LOG (Thomas Zimmermann)
>   * Drop "Always select DRM_CLIENT_LIB", and select only if DRM_CLIENT_LOG is set
>   * Add an info message if no clients are initialized in drm_client_setup()
> 
> v9:
>   * Rename drm_draw.h to drm_draw_internal.h (Jani Nikula)
>   * Add cflags to remove the "../" when including drm internal headers (Jani Nikula)
>   * Order select alphabetically in KConfig (Thomas Zimmermann)
>   * Replace drm_info with drm_dbg, to be less verbose (Thomas Zimmermann)
>   * Rename module parameter to drm_client_lib.active (Thomas Zimmermann)
>   * Warn if drm_client_lib.active is malformated (Thomas Zimmermann)
>   
> Jocelyn Falempe (6):
>    drm/panic: Move drawing functions to drm_draw
>    drm/log: Introduce a new boot logger to draw the kmsg on the screen
>    drm/log: Do not draw if drm_master is taken
>    drm/log: Color the timestamp, to improve readability
>    drm/log: Implement suspend/resume
>    drm/log: Add integer scaling support
> 
>   drivers/gpu/drm/Kconfig                       |   5 +
>   drivers/gpu/drm/Makefile                      |   1 +
>   drivers/gpu/drm/clients/Kconfig               |  48 ++
>   drivers/gpu/drm/clients/Makefile              |   3 +
>   drivers/gpu/drm/clients/drm_client_internal.h |   6 +
>   drivers/gpu/drm/clients/drm_client_setup.c    |  29 +-
>   drivers/gpu/drm/clients/drm_log.c             | 420 ++++++++++++++++++
>   drivers/gpu/drm/drm_draw.c                    | 233 ++++++++++
>   drivers/gpu/drm/drm_draw_internal.h           |  56 +++
>   drivers/gpu/drm/drm_panic.c                   | 257 +----------
>   10 files changed, 820 insertions(+), 238 deletions(-)
>   create mode 100644 drivers/gpu/drm/clients/drm_log.c
>   create mode 100644 drivers/gpu/drm/drm_draw.c
>   create mode 100644 drivers/gpu/drm/drm_draw_internal.h
> 
> 
> base-commit: c6eabbab359c156669e10d5dec3e71e80ff09bd2


