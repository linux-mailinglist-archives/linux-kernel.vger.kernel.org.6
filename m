Return-Path: <linux-kernel+bounces-449384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F3D9F4E29
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 15:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F20C1887C1D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 14:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF7D1F63CB;
	Tue, 17 Dec 2024 14:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ls2Pg/iE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606B61F2391
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 14:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734446781; cv=none; b=fpde6ZEVJ7A+Bvw2xQC9Zd7y15ycAxiwgyFWW+OWL7wSoVltcOaS8lgqlZ1FJ6dnTRcpoSEZRmsN+F6FrouH6DEbxE8fAo4qHEdP68lTT8p5ewTAl/BgmBocFEUQuuQn0azKNI8jNmTnxtimNgpVvpvNtwJ3PWA6glfiZc+OPPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734446781; c=relaxed/simple;
	bh=ZYWFGeyXQ1mkGQsqFz5HmlmiGpfux1ORE5YnV17FwwU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nB6tmRYxG0cuCKWCYBOaqBDlZcGByke3C4xydVTPXwqA8Hgew1nIY8bUJSZUasSgOTA0MH3jh8AV/X5KTsgJXPgX9sdgVlHh+W67FRwPSiPp53H0BH6a28ctxXd8210mCIF2i9Vjr7Ar7qsrZrL8qXr3Qywd7ublYIhvC5gAE/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ls2Pg/iE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734446777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eDQnbhzbULoS+W3TBQiABSNsadwzS0IORV98NaKZMJE=;
	b=Ls2Pg/iE5UIG1QQYytx0FdeygeOk1hNRQlE/HVvnOh/d7JYJ4hne2zpfvgRbtS0pJYNkYd
	pgfgmA4l/Pifv4LDXFA6t9pa+AHEWPqR5LUrJj6qwTrq8r1aGNQIvYLHJNSSC8NNBDHYEh
	bqPFrE7XiSKkCR5m2xmtsaykHeOs+lA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-b4bYC-uOP-G4Xzu2nGsNmA-1; Tue, 17 Dec 2024 09:46:16 -0500
X-MC-Unique: b4bYC-uOP-G4Xzu2nGsNmA-1
X-Mimecast-MFC-AGG-ID: b4bYC-uOP-G4Xzu2nGsNmA
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4362552ce62so29976175e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 06:46:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734446775; x=1735051575;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eDQnbhzbULoS+W3TBQiABSNsadwzS0IORV98NaKZMJE=;
        b=HG1DLy74/zHw7KjFkFXzzCs5vh5Or3nbkApScgFGtJG+k3l7z7eydtuJpWQ/KTiMm1
         he6dKs8CYquXRV71u3L3Z9hzcVjDdRlk2i7AH53SKtJ8JYzjxIl9KmBJeozgAamEX6A2
         R7ptfDxYloRQCGHiezKA0QhtQP0ksw5rClbuUzQD/pYv2hInlsuahGdJMTenWnHjXrJE
         oHtPSk2Ff6xyVDdTFqAwULx1ajDiYmxdXt7JeEgTjDijbO22mOrw+hOaM2ink8HIt1J2
         c+GpYALYWQiDHhsOH7OJx5zK4JQnwrZtnInB7Mg0534RFb4y/eEHidcRWSVrHG19NStX
         SRHw==
X-Forwarded-Encrypted: i=1; AJvYcCV2aOUm99+0OwK2sYzP+a7Z6Sq8MhhVc1Ftx4/OcXTKtr/00WRK3HNAzhyMOeGnpoN3DVwB+IYCgmky6Tc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp0xtG/VAVaT49XraFVrIKiA1aRBpQ2oHFszPPDHZ+s/FnKtSt
	AnwKmPW33T2VhYoplICzrpVNFzGqmDT30Xo2fyZMI9t0gNCqthbde5qsgqBG6TA62BsG+XsDBDc
	+5lDgDyYc1tFrda2Ruw4VUnOEqackF8kQct4OGQM8aW+EDUeZw293dI+Ykxgk8Q==
X-Gm-Gg: ASbGncsi1rdAI4bqYVXdBhA/f99kA5RHosezwU0giMe3HFWJhc3t+FKEd0x1oS9j2Hv
	BPckvXG5E5v2kRbjWbMQ+zTsy4MIIZO+BfbgFg549hLoixEjqHrAGe0CG3mEzkL9ooe1HyU59mU
	lID0khmGNucqr7zMmh4gB1d2ArahExP09XTUqEElcGSqpkLfjFNK3KxjGy7q1CPkNEQ339lXgxz
	lFm1XkUBrvr4YGp3XNlpGsfbUlAlTnkrsQnruRhRnPu8r8H6h23Dfr4lb5PxbKXEMgmd2h51HZz
	9sgewPids+EVjqgDpkVn
X-Received: by 2002:a05:600c:4e88:b0:434:a929:42bb with SMTP id 5b1f17b1804b1-4364769b321mr39642475e9.18.1734446775079;
        Tue, 17 Dec 2024 06:46:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEb7FOvU3aK3NlCVSo7lhvRfjnfY6sZdz6YbmqcryV9O2xsfMlBv61Xb0L2X14JUy9wFlLD9Q==
X-Received: by 2002:a05:600c:4e88:b0:434:a929:42bb with SMTP id 5b1f17b1804b1-4364769b321mr39642125e9.18.1734446774667;
        Tue, 17 Dec 2024 06:46:14 -0800 (PST)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c8012249sm11244064f8f.10.2024.12.17.06.46.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 06:46:14 -0800 (PST)
Message-ID: <301714d8-0723-4881-83e8-24523c121bfe@redhat.com>
Date: Tue, 17 Dec 2024 15:46:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/6] drm/log: Introduce a new boot logger to draw the
 kmsg on the screen
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 John Ogness <john.ogness@linutronix.de>,
 Javier Martinez Canillas <javierm@redhat.com>,
 "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
 bluescreen_avenger@verizon.net, Caleb Connolly <caleb.connolly@linaro.org>,
 Petr Mladek <pmladek@suse.com>, Jani Nikula <jani.nikula@linux.intel.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>
References: <20241204160014.1171469-1-jfalempe@redhat.com>
 <CAMuHMdU925NiJDy4fOcQhA=jp8=79rZ3h5-TYxCjzkGwqQdKOg@mail.gmail.com>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <CAMuHMdU925NiJDy4fOcQhA=jp8=79rZ3h5-TYxCjzkGwqQdKOg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 17/12/2024 15:19, Geert Uytterhoeven wrote:
> Hi Jocelyn,
> 
> On Wed, Dec 4, 2024 at 6:41 PM Jocelyn Falempe <jfalempe@redhat.com> wrote:
>> drm_log is a simple logger that uses the drm_client API to print the kmsg boot log on the screen.
>> This is not a full replacement to fbcon, as it will only print the kmsg.
>> It will never handle user input, or a terminal because this is better done in userspace.
>>
>> If you're curious on how it looks like, I've put a small demo here:
>> https://people.redhat.com/jfalempe/drm_log/drm_log_draft_boot_v2.mp4
>>
>> Design decisions:
>>    * It uses the drm_client API, so it should work on all drm drivers from the start.
>>    * It doesn't scroll the message, that way it doesn't need to redraw the whole screen for each new message.
>>      It also means it doesn't have to keep drawn messages in memory, to redraw them when scrolling.
>>    * It uses the new non-blocking console API, so it should work well with PREEMPT_RT
> 
> I gave this a try on Koelsch (R-Car M2-W), using rcar-du.
> Unfortunately I don't see any kernel messages, and my monitor complains
> about no signal. Does this require special support from the driver?

It doesn't require a special support from the driver. But as it is the 
first drm client other than fbdev emulation, I'm not surprised it's 
broken on some driver.
I know it works on virtio-gpu, nouveau, amdgpu, and even on a OnePlus 6 
(Qualcomm SDM845/freedreno), without requiring driver changes.

Do you have a serial console on this device, to check if there is 
something in kmsg?

Best regards,

-- 

Jocelyn

> 
>      CONFIG_DRM_CLIENT=y
>      CONFIG_DRM_CLIENT_LIB=y
>      CONFIG_DRM_CLIENT_SELECTION=y
>      CONFIG_DRM_CLIENT_SETUP=y
>      CONFIG_DRM_CLIENT_LOG=y
>      # CONFIG_DRM_CLIENT_DEFAULT_FBDEV is not set
>      CONFIG_DRM_CLIENT_DEFAULT_LOG=y
>      CONFIG_DRM_CLIENT_DEFAULT="log"
> 
> Switching to fbdev gives a working display, as before:
> 
>      CONFIG_DRM_CLIENT_DEFAULT_FBDEV=y
>      # CONFIG_DRM_CLIENT_DEFAULT_LOG is not set
>      CONFIG_DRM_CLIENT_DEFAULT="fbdev"
> 
> Thanks!
> 
> Gr{oetje,eeting}s,
> 
>                          Geert
> 


