Return-Path: <linux-kernel+bounces-182562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B508C8CBF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 21:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B19481F23AA4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 19:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B4513FD9F;
	Fri, 17 May 2024 19:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YRUk4TGw"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9368E13DDCE
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 19:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715973766; cv=none; b=fBEf/CEIcADhyR2mm5jxXcgFrNKcJuTxiYgPR4q6SgoBz7gdjahCX8Qox034M9EwsTrSUr72n0Iw1vWrHddxljz3mRm8Xkxw/cxSCYPTI7Lpws4CnrOWoNrGXIjisSlPE0XRajf4SxnL9pC4hyOwMuHStT0M4lPyxbWYigN26gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715973766; c=relaxed/simple;
	bh=5NZhUebD+jwTapS+lCj4nfvqfbRZkD+FQvIfY19k6Qg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t6M25Dx5uEml5ys98SrGnt26YxD4vTT3qJ281hXU303F/HpJdy9pFFUNUS4nAjtGBta7OhEUp2zm5mA80JVj4ppvlTPKyK0uPahBmkefY1JXVsHlO96HtyS0kT7gyrs+MWRcH8L64p8He/4LR+Ez2mF1dVDPjBKaHVdQza1vwtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YRUk4TGw; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-51fdc9af005so1986981e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 12:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715973761; x=1716578561; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Sh8TQN24HdRct7EWlhzUHnCJ0TtfqGC3HskYLHQN1S4=;
        b=YRUk4TGwcKSSBLVBB+ruAF/3rQUD+cWnYMcYnYpF+AjX33UIuJ/9XAvNlQzSTeNMf7
         966IOE0o8ZQn0Un6DL7j04ueEKxAJ0QJfDatbF4e3jgg5g8/CbY7m0DDoDeHH8ag8WLA
         NaaknjNR59Umkvt2RSfU2SXgPtzsuEJDUB18I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715973761; x=1716578561;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sh8TQN24HdRct7EWlhzUHnCJ0TtfqGC3HskYLHQN1S4=;
        b=eC4rrd/KwVw3DIS3WE6W11ExioniN6IcJtt9sj5R7ZEnB0ifKLXON3qE9c2ODBaTDh
         L3728ZL04/7KKj8r+BBTkSBjBJskPm/tmu+vGPHPI6RkbNVxldShs0V0O39xVXUFMUht
         /lZ9FRKmfZRrhPlGUL/ueWJpGXejmxMAtljhvO3CzlqipZmG1cXalE7GNFMZT95rAfUt
         CNrzQTd6d1W+wqyVxNdbyhXmtbVBl5hnKDX24/afc7MClVSCN/7x90ljuCbFWABwFE08
         DlxEKODZlVBbKlumDcWluHBn1DimcMktDbFERoxNIVYxI+0Q94kac+ic3ys2ugeKNt6L
         jkMg==
X-Forwarded-Encrypted: i=1; AJvYcCU/4GBnxxBNWyr4wJD7APE+DFt6iIGM9/hqALTA3VgMiGQCzuEVp8Y3FLa9pDjZrhQ2LCuKNJ4qcITtBGUGPIj8MpK5oiADCaJAmYnN
X-Gm-Message-State: AOJu0Yzhf+Ezw71fAfw4QcMOywN7VeVZrWEThoVkMAjMRVFkTmXQvlo1
	AdiKNe8GM2UbFK7+J17krHroxdTug7ny6gvqB542SxPP0a3ILJzqMNSbD3dNaME7n29+nA1YRXP
	DhCHfKw==
X-Google-Smtp-Source: AGHT+IGXZBO69btvK7h4gDjvcpznyEBsqVCi1yMC5DaYs24lc11LnF+EgY3y+b81K0Hn8S0u7uRpEw==
X-Received: by 2002:a05:6512:3e17:b0:51d:605e:f0ce with SMTP id 2adb3069b0e04-52210278698mr26639876e87.50.1715973761327;
        Fri, 17 May 2024 12:22:41 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f39d2be2sm3362246e87.254.2024.05.17.12.22.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 May 2024 12:22:40 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-51fdc9af005so1986925e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 12:22:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWxtJykWPXTYCTM5pxxiH4cH7lAe2QbgLHkigAi3G7kvNWdaUXmZF6Oii0hmqWrcpawJ6/WOoSk0dEWmMMYM3eu/rOkk7SIny4l1pH+
X-Received: by 2002:ac2:4a84:0:b0:51d:9aa7:23e with SMTP id
 2adb3069b0e04-52210475801mr17957902e87.65.1715973760408; Fri, 17 May 2024
 12:22:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPM=9tx_KS1qc8E1kUB5PPBvO9EKHNkk7hYWu-WwWJ6os=otJA@mail.gmail.com>
 <CAHk-=wjdyimk4t2C7xfqLYFX1HUH92yTRTFQXAitJJT+REvF3Q@mail.gmail.com>
 <CADnq5_NmC9bYkPFUD35gBtxsk_9jYhOTugni-q4WGXggf6=rLA@mail.gmail.com>
 <6225ecf4-f4ca-4ed7-a316-69c86f4ade7f@amd.com> <CAPM=9tyJCJ+D4h7BZ3dBpm6R33gTfwtigDtmt6g9KX25Jun9Hg@mail.gmail.com>
In-Reply-To: <CAPM=9tyJCJ+D4h7BZ3dBpm6R33gTfwtigDtmt6g9KX25Jun9Hg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 17 May 2024 12:22:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=whp9ixiDVNvSXRcVWYifXfQaZH9taHxD-i5noppY30e1w@mail.gmail.com>
Message-ID: <CAHk-=whp9ixiDVNvSXRcVWYifXfQaZH9taHxD-i5noppY30e1w@mail.gmail.com>
Subject: Re: [git pull] drm urgent for 6.10-rc1
To: Dave Airlie <airlied@gmail.com>
Cc: "Paneer Selvam, Arunpravin" <arunpravin.paneerselvam@amd.com>, Alex Deucher <alexdeucher@gmail.com>, 
	Daniel Vetter <daniel.vetter@ffwll.ch>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
	dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 16 May 2024 at 18:08, Dave Airlie <airlied@gmail.com> wrote:
>
> Linus, do you see it a boot straight away?

Ok, back at that computer now, and yes, I see those messages right
away. In fact, they seem to happen before gnome even starts up, ie I
see those messages long before the first messages from gnome-session:

    May 17 12:07:17 tr3970x kernel: WARNING: CPU: 4 PID: 1067 at
drivers/gpu/drm/drm_buddy.c:198 __force_merge+0x184/0x1b0 [drm_buddy]
    .. lots and lots and lots of them ..
    ...
    May 17 12:07:23 tr3970x systemd-cryptsetup[982]: ...
    ...
    May 17 12:07:25 tr3970x systemd[1]: Reached target basic.target
    ...
    May 17 12:07:25 tr3970x systemd[1]: Mounted sysroot.mount - /sysroot.
    ...
    May 17 12:07:25 tr3970x systemd[1]: Switching root.
    ...
    May 17 12:07:36 tr3970x gnome-session[2824]: ..
    ...
    May 17 12:07:36 tr3970x gnome-shell[2836]: Obtained a high
priority EGL context
    May 17 12:07:36 tr3970x kernel: WARNING: CPU: 31 PID: 2836 at
drivers/gpu/drm/drm_buddy.c:198 __force_merge+0x184/0x1b0 [drm_buddy]
    .. lots of warnings resume ...

IOW, it happens already during the graphical boot before I have even
typed in my disk encryption password.

Then it starts again when gnome starts.

I just checked: I have exactly 8192 warnings from the early boot
before the first gnome warning. Which sounds like too round a number
to be an accident.

I will try the patch Alex pointed at next:

    https://patchwork.freedesktop.org/patch/594539/

and see if that fixes it for me.

                 Linus

