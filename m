Return-Path: <linux-kernel+bounces-253001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C16F9931B0C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 21:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A32C1F21B35
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 19:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B213112B143;
	Mon, 15 Jul 2024 19:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fUELPPQm"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC51179BD
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 19:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721071985; cv=none; b=GavJCqJJuJoK3oW5742nVZSwKXH26M2b2sdhyEbY8ESo/ULu9RPKmCHjKhW3HXaYslBGPXD4ejEOdzarZmGd8x9pfmpJImjb64XpmbNLAYSJeXfvu5LO5CmZRyerC8ThlVFylGrferDNRyHLyn/pjy6rYKvU9ZKvVsRayWNhcro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721071985; c=relaxed/simple;
	bh=GFaV9BV7YR+i2gxGnV/UWYI/2XgJoSuqpoWhzjmf8OE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=funA/UFlFBym3Im1KjMka2mS8qDZ9GLF+oOA4IMprmv8bCFGmt5hvxvs6PHp+wqBZRITY3TTIWPFMFmuk97kRaAYEGkWQMonJSxpPj0NePRHY0+AFCKZKKAxKvzmBFi2428le0CIAK8rM58KWof8CM+IjDIOsGeJstubIEiA55k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fUELPPQm; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-65fa21206b5so19720037b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 12:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1721071981; x=1721676781; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wX6VVF5zo6QpIl0GNcjuj6SmcU0Q6kPt3Zxz4lR//To=;
        b=fUELPPQmWoaCBr4l5LmeRx5+spfc4WoKcdadsfDXcIW8S/QU/PUO+Ag1YH578PaEHl
         /XQX8/GJr+sy3/Mk+MIgPpDGwDfQcFzXZiSIyhjq9otVgpx3UuRo+SZMNVNqz9bYa0HU
         iGFPc81MNjF8DeTsDEABtUA933VQ1o8jP368g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721071981; x=1721676781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wX6VVF5zo6QpIl0GNcjuj6SmcU0Q6kPt3Zxz4lR//To=;
        b=TsiK4oIxd43QYfVXMwk+D650uRqRnlBRWk5sN3IEhgMiCpCT3WGxoXnGbhAkJOT2v3
         cOm9gfeLV+psoIWOwUIVyB740Vg6pSCoy6Cv25JvAAUvqZ9oVG+ZD7wBuaVFvOd9FvfA
         JO1JbikxbBgOGbdnUKG7zSRI7YV7np/LCNAoEKeSxSDzOYHZBJ4Qy3n7i342Ku6E8/6F
         7zsDc4VUSlYceCq3kv+sPIz5XK+fCGe8TwR8tCHdR5CB7lgfRrnKNbzDkYnbZ5kMIrWr
         wiUzXW92H/43Xlt+9m2n2Add+m7ZpczNEzPnhzWTO1hUj7XYQMbDevnQEZqgc7m9Qb8q
         vZ/A==
X-Forwarded-Encrypted: i=1; AJvYcCV6urSRqpr9FEuHJRA7rCbQ2E9G9e46XLA8aZyTfvB6USsaxQNdMMciDO56fT5W0ix2Bdcm6u8XFCkJsu0FqaWO2k9QBfK475FhNbLo
X-Gm-Message-State: AOJu0Yx1K6e21BOZ9dwCIExdy9vMPUhfF8RYuFfFdag1K8JhbCpRhlpw
	7zoAgkRBCdLNnWjZH7n807R1zdQgyux9aLl5q9Ms6et6ZgbrCnta/nXFFWLWzemBA9WHZaxPDMJ
	JQ16dtVTyagWfiD8BYRevTCoBRkXWbjlWucFH
X-Google-Smtp-Source: AGHT+IFGwqsnaPAj7mqNI8+vo6+/u0K0j2UFb+UYDBq3/3ucIPqVmkkyljDrQrw6oWynXU33+vEOIFDTYxIYzTAJHRs=
X-Received: by 2002:a0d:c183:0:b0:65f:ca0b:5ad9 with SMTP id
 00721157ae682-66354d75631mr5659897b3.25.1721071980901; Mon, 15 Jul 2024
 12:33:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bd9cb3c7-90e8-435d-bc28-0e38fee58977@schmorgal.com>
In-Reply-To: <bd9cb3c7-90e8-435d-bc28-0e38fee58977@schmorgal.com>
From: Ian Forbes <ian.forbes@broadcom.com>
Date: Mon, 15 Jul 2024 14:32:50 -0500
Message-ID: <CAO6MGtjxnm3Hc=T8jv-upP46XBzAc0ZNmLVF3=KNN8buGBwg1w@mail.gmail.com>
Subject: Re: [REGRESSION] drm/vmwgfx shows green Xv instead of actual video
 (bisected I think)
To: Doug Brown <doug@schmorgal.com>
Cc: Zack Rusin <zack.rusin@broadcom.com>, dri-devel@lists.freedesktop.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Doug,

Can you try this patch with 6.10.

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c
b/drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c
index c45b4724e414..e20f64b67b26 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c
@@ -92,7 +92,7 @@ static int vmw_overlay_send_put(struct vmw_private *dev_p=
riv,
 {
        struct vmw_escape_video_flush *flush;
        size_t fifo_size;
-       bool have_so =3D (dev_priv->active_display_unit =3D=3D vmw_du_scree=
n_object);
+       bool have_so =3D (dev_priv->active_display_unit !=3D vmw_du_legacy)=
;
        int i, num_items;
        SVGAGuestPtr ptr;


On Thu, Jul 11, 2024 at 3:37=E2=80=AFPM Doug Brown <doug@schmorgal.com> wro=
te:
>
> Hello,
>
> I have discovered a problem in vmwgfx that caused Xv playback to break
> between v6.3 and v6.4-rc1. In v6.3, inside of an Ubuntu 24.04 VMware VM
> with 3D acceleration disabled, I can run the following GStreamer command
> ("sudo apt install gstreamer1.0-tools" if you don't already have it):
>
> gst-launch-1.0 videotestsrc !
> video/x-raw,format=3DYV12,width=3D640,height=3D480 ! xvimagesink
>
> And it works fine, showing a test pattern.
>
> In v6.4-rc1 and all the way up to a build I just made today of Linus's
> latest master branch and also including Zack's latest patchset [1]:
>
> Linux doug-Ubuntu-MATE-2404 6.10.0-rc7+ #55 SMP PREEMPT_DYNAMIC Thu Jul
> 11 12:46:06 PDT 2024 x86_64 x86_64 x86_64 GNU/Linux
>
> ...if I run the same command, the GStreamer window shows up containing
> solid green rather than the test pattern.
>
> I believe I have bisected the problem to commit:
>
> 39985eea5a6d ("drm/vmwgfx: Abstract placement selection")
>
> However, the bisect process was complicated because two earlier commits
> temporarily broke vmwgfx so I had to undo them during bisection, which
> also required some conflict resolution:
>
> 180253782038 ("drm/ttm: stop allocating dummy resources during BO
> creation") and
> f87c1f0b7b79 ("drm/ttm: prevent moving of pinned BOs")
>
> Note that if you have gstreamer1.0-vaapi installed, you should
> temporarily remove it first before testing because there is a separate
> Xorg bug that causes Xorg to crash when you run the above command if
> gstreamer1.0-vaapi is installed.
>
> I'm happy to do any further testing as needed. I've reproduced this
> problem across several different machines and distros. A fully-updated
> Arch Linux is also affected.
>
> As a side note, that same gst-launch-1.0 command is also currently
> broken with 3D acceleration enabled, but that's a separate issue in mesa
> that I've submitted a patch for [2].
>
> Thanks,
> Doug
>
> [1]
> https://lore.kernel.org/all/20240702021254.1610188-1-zack.rusin@broadcom.=
com/#t
> [2] https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/30116
>
> #regzbot introduced: v6.3..v6.4-rc1

