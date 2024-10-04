Return-Path: <linux-kernel+bounces-351517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9403899126D
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 00:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A00171C23301
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 22:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823E51B4F34;
	Fri,  4 Oct 2024 22:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FIrYDQDh"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1671474B9
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 22:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728081644; cv=none; b=IkX3tg/OJaCFHJlV1JB5qCRm/XNC7YcPD59C6mU0WLwu4LjTo4EBjPUdQGNB8vcPEWU29sA8Xv081XVg0ek3Vxw0axXHeruWKy5v3iMvxRU3tb4bp5KpfHB/6iszCFsCO8WWRN10ACoru506wg9dmrau0KjsXl1myXORvURbu9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728081644; c=relaxed/simple;
	bh=WsMJdDXmVMKIVhhaJSxkS8mpnIlfPxv1BivlKIGuQfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MrYn1se3ywa9t693cZQqc+fL+2zy88Jn88yKQo3wSj+V5TBL9cWsMie+I00gmlPLUnTcqYVNwFbRDpA62Uu9EcwYhoCqgpe0/IyOGA24p8tJM4KhsBqL9BFoKEvqo2XlOOtoKBlgD7TkUNDvCUxUS1zvD+h7vpfR5QLPqvNIjZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FIrYDQDh; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37cc846fbc4so1992301f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 15:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728081641; x=1728686441; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pm0SUmL0h+/zFum7zGqvM26tqKRl3o1sbbm2mcZg8yk=;
        b=FIrYDQDhuOVrdKPFx9Rw7lhzaoilXLDvcdMZiNEp3SW5TGG1uQZLlQN32o2fGquD40
         +VK1Rn6gJK+heKVA3YryGluUbZypdCc+Q4XRF754OzthCt/rPpTm+apTgX5blJQLLWVY
         FF8sJVGQNNT57eH3TVU2HqMt6yyqf5A8B7NLKPouBk1j9Z++GUc6EYM0jRn1Gzbair0R
         YhCnrRR5FK3cTMABCFfVA0lJ6rErMvybgOrZqLVIq6+ZJunNciNk6/OSilh9fzBmtEtv
         KtAi9aVK/a/Nqxiwo2rV/s4FQ4hUyuTJtUpG9h+t43+6kYAFyYRqVDf/bZks4HIBuxir
         GTmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728081641; x=1728686441;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pm0SUmL0h+/zFum7zGqvM26tqKRl3o1sbbm2mcZg8yk=;
        b=McVN1J4kGJbT4Xlou92Un0FBKrnT57nLC4T6qKz5YUco8HTRcKn41n8Mumd0aRvL58
         aSxrFX6UVSUigl0fpMCtZxi8Osov5xPFiOELsrUgOC0fbHbPnBDtreQgzz8WWL1uTsNR
         wSHzKgieHP4T6s0DcJkU274eqIHoDbLpGARCE29OiHX4Ys1IEKhM/6r4UpTNvGDcCuS2
         rRy5y6aMBLTT3lblmSuFteLLZsZchfGtn5wpoDtFxYfiHbrSk5c84ed8Ap0pKWRuJu5w
         wBHYyS70RDEbZW+bbKZ2Ex1csWArPtkeo2quR5ZL/KVcuCnlLJttPJWAjaczknMuCeLp
         w3gg==
X-Forwarded-Encrypted: i=1; AJvYcCU/k/xLD/VnH8YrYoH3/Oylm0g6P1eoJuHd77V3XUEH7RWYiyR2jPfMIBhYdIyJia0x4iIreUKGr0AiVKw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzoxgs9tMqi8p1zy0mJcSCAWbzNXJJQjbkOM4h5j12GizEcr/Va
	+Ove7z1D59vfytzw4qd1MkIXK4QbTaPeGPD7TBmgSVOvtOCjSzo5GdDpDhv1KVY=
X-Google-Smtp-Source: AGHT+IEAyWl+ECruivGYhlckYJ/sRggq+bTCKeTD26RE/A1w2YG5iYaNE6u8Y3RrX5FvA49B42jmoA==
X-Received: by 2002:adf:f741:0:b0:371:8e8b:39d4 with SMTP id ffacd0b85a97d-37d0e77eea6mr2854008f8f.28.1728081641222;
        Fri, 04 Oct 2024 15:40:41 -0700 (PDT)
Received: from [82.195.85.209] ([82.195.85.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d16920445sm544722f8f.52.2024.10.04.15.40.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2024 15:40:40 -0700 (PDT)
Message-ID: <782f6c32-73ed-4e58-ae10-ff2d486b499c@linaro.org>
Date: Sat, 5 Oct 2024 00:40:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] drm/log: Introduce a new boot logger to draw the
 kmsg on the screen
To: Jocelyn Falempe <jfalempe@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 John Ogness <john.ogness@linutronix.de>,
 Javier Martinez Canillas <javierm@redhat.com>,
 "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
 bluescreen_avenger@verizon.net, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20240910070733.156127-1-jfalempe@redhat.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240910070733.156127-1-jfalempe@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jocelyn,

On 10/09/2024 08:56, Jocelyn Falempe wrote:
> drm_log is a simple logger that uses the drm_client API to print the kmsg boot log on the screen.
> This is not a full replacement to fbcon, as it will only print the kmsg.
> It will never handle user input, or a terminal because this is better done in userspace.


I tried this out on the OnePlus 6 (Qualcomm SDM845/freedreno) and it 
looks great :D

Here's a demo for kicks:

https://people.linaro.org/~caleb.connolly/drm_log_oneplus6.mp4

Tested-by: Caleb Connolly <caleb.connolly@linaro.org> # freedreno/dsi

Kind regards,
> 
> If you're curious on how it looks like, I've put a small demo here:
> https://people.redhat.com/jfalempe/drm_log/drm_log_draft_boot_v2.mp4
> 
> Design decisions:
>    * It uses the drm_client API, so it should work on all drm drivers from the start.
>    * It doesn't scroll the message, that way it doesn't need to redraw the whole screen for each new message.
>      It also means it doesn't have to keep drawn messages in memory, to redraw them when scrolling.
>    * drm_log can only be built-in (and drm must be built-in too).
>      The reason is that, if you build it as a module, then a userspace application will be more appropriate than this module.
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
> Thanks and best regards,
> 
> Jocelyn Falempe (4):
>    drm/panic: Move drawing functions to drm_draw
>    drm/log: Introduce a new boot logger to draw the kmsg on the screen
>    drm/log: Do not draw if drm_master is taken
>    drm/log: Color the timestamp, to improve readability
> 
>   drivers/gpu/drm/Kconfig     |  19 ++
>   drivers/gpu/drm/Makefile    |   3 +
>   drivers/gpu/drm/drm_draw.c  | 216 ++++++++++++++++++++
>   drivers/gpu/drm/drm_draw.h  |  56 ++++++
>   drivers/gpu/drm/drm_drv.c   |   2 +
>   drivers/gpu/drm/drm_log.c   | 391 ++++++++++++++++++++++++++++++++++++
>   drivers/gpu/drm/drm_log.h   |  11 +
>   drivers/gpu/drm/drm_panic.c | 247 +++--------------------
>   8 files changed, 721 insertions(+), 224 deletions(-)
>   create mode 100644 drivers/gpu/drm/drm_draw.c
>   create mode 100644 drivers/gpu/drm/drm_draw.h
>   create mode 100644 drivers/gpu/drm/drm_log.c
>   create mode 100644 drivers/gpu/drm/drm_log.h
> 
> 
> base-commit: 9aaeb87ce1e966169a57f53a02ba05b30880ffb8

-- 
// Caleb (they/them)


