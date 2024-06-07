Return-Path: <linux-kernel+bounces-206179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEDB900531
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 15:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60C141F258DD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 13:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C9D194157;
	Fri,  7 Jun 2024 13:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xa9wyYUe"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3198193099
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 13:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717767589; cv=none; b=PTsNyhrC1Bggz3BhroEraz13hOsG7WEuqvfCDeWr6d46Bhm/7v0RQUYofL51jrIhSbU1/GGWbrWdU5zz5e3TGV5/yrrperV3Ckzv/kC8PC8TA5XRfMVt4PVv6nEaXqWtfJCMKXOSVrUUQ7p7a9azR6JlpDvj4JAf3dnW7Verg4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717767589; c=relaxed/simple;
	bh=zRUjkuu13UY0xr7996+cq6aTZrIiH+S+h1lee8kxEdQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gZ2Q15Q+He/KPDmZmSbKdgxvUnCtLNu/9CDE22sopxX+tvA2D/wHf5NIREY6XRGQNuNLcP1uXhWL9q3RYBtN2ceFVyCPxPp5rIrB3yErJZAPh0HgjEoG/gVAtclwe/mejA33emceY5gwADJcLjM6EEkJlB8vxv5JFIulwMyVm+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xa9wyYUe; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f62a628b4cso19558955ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 06:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717767587; x=1718372387; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lGjvaDk+KW6xnTzTcwYndsM82Fj+VUn371ofht0gpOk=;
        b=Xa9wyYUesWwdPtLjING9Nbne+m6SBoBMtGibvz0I5vq5v2S763i0UUkE7FwZ/JViwg
         1bxcreQ9Me0sjWbYRaaZObxVoY8dq+hTQ1t2Rk6FVfWoMcZNPCI9gG1eyZcBebXZ+oBU
         EL7uvghjpaPJjMhunu0YU+9AQg6twbUmlkBWlPQ+tnJDVg2NHCyExmeuDOfoQAlLlR7a
         3XTS86nwdawcn/pdOQgugoKfDOwKTE8c8L7ZQupuQrA9AGg7mPVgYu43JhEY1rXrFEjO
         YRYZptDl4B5XIfeQZ5hfeysy6fwG0FD5dT+oAFoAhNOyWnmoYXKHfn+1MfwToQe2Xbk/
         JkhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717767587; x=1718372387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lGjvaDk+KW6xnTzTcwYndsM82Fj+VUn371ofht0gpOk=;
        b=L/vog6qDVaMoRK2Le69O1qHffltbbdnIAdlFT81BheMwP1w3KJ2LPp3KJ2bnyiMOY1
         7kIGOthL8/jwF5224COFgBclrJI2ZJN+84ZbwOAAVUk0UtBzJDP4MI7vMhNudQ1WW5XU
         ytFOOZILpyCkP2LsV8NyTO/RJJm4a/mm1LgRJvqIzkzkY3AkWg/E/km+COJKtQ8xBX6/
         JKRxexoewi1Z6xdlQ2y6e/QF1JefdNkrsHPCpBvoT+E7INg715zUWUxuzLGjwPJ+l5HA
         VJzxVIrLtPTWHQSlRX/6xJl4WjhOZZanULqyeCrHlVVz5Fyouox17bAHq3H7oY0dFQfe
         KGsA==
X-Forwarded-Encrypted: i=1; AJvYcCWvWadxG+hsjipIbCDGyDNHNURnbM5L5vyKVfuX1dfCdlK83qby7mnbiDM7pLfE0OSKhEHnhkFfHgcz77cMT8WyW9pFWI9t37xPO2xu
X-Gm-Message-State: AOJu0YwIAk7lzLd1uEAPlssk/X7LCx6ilbTxR6aSCONdWmYs+4hoL2RU
	XRGFNUkh+GoNjwqrb7hCFAm1Nd2Wd2zqx39DWsopyhg0I7T8VzW1IKbDptqbhZ632/DA9C+WGFh
	mLuybcNbNAL9g2E/VKlQbD3ciL20=
X-Google-Smtp-Source: AGHT+IHFeYv7N9rqcrTihxXkCB6iPbA0K4xnxCMnAQk6mBUZGTI1GpzTXBWWItwFP1ZhHdtfaoxyrtoLT7oPMuSTUgc=
X-Received: by 2002:a17:902:d4c1:b0:1f6:7212:760a with SMTP id
 d9443c01a7336-1f6d021805amr29662965ad.0.1717767587019; Fri, 07 Jun 2024
 06:39:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXGCsNptxsQO=5=qi-JYiFX=rX8Ok5inK80Gn0qrUFWbtBGng@mail.gmail.com>
In-Reply-To: <CABXGCsNptxsQO=5=qi-JYiFX=rX8Ok5inK80Gn0qrUFWbtBGng@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 7 Jun 2024 09:39:35 -0400
Message-ID: <CADnq5_PDxJ8O1JUQ9RBYRFB9G1WZJos05ZAM4jUKuPBwPxjNkA@mail.gmail.com>
Subject: Re: 6.10/bisected/regression - commits bc87d666c05 and 6d4279cb99ac
 cause appearing green flashing bar on top of screen on Radeon 6900XT and 120Hz
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>, Rodrigo.Siqueira@amd.com, 
	"Deucher, Alexander" <alexander.deucher@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>, 
	dri-devel <dri-devel@lists.freedesktop.org>, 
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 26, 2024 at 10:12=E2=80=AFAM Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
>
> Hi,
> Day before yesterday I replaced 7900XTX to 6900XT for got clear in
> which kernel first time appeared warning message "DMA-API: amdgpu
> 0000:0f:00.0: cacheline tracking EEXIST, overlapping mappings aren't
> supported".
> The kernel 6.3 and older won't boot on a computer with Radeon 7900XTX.
> When I booted the system with 6900XT I saw a green flashing bar on top
> of the screen when I typed commands in the gnome terminal which was
> maximized on full screen.
> Demonstration: https://youtu.be/tTvwQ_5pRkk
> For reproduction you need Radeon 6900XT GPU connected to 120Hz OLED TV by=
 HDMI.
>
> I bisected the issue and the first commit which I found was 6d4279cb99ac.
> commit 6d4279cb99ac4f51d10409501d29969f687ac8dc (HEAD)
> Author: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Date:   Tue Mar 26 10:42:05 2024 -0600
>
>     drm/amd/display: Drop legacy code
>
>     This commit removes code that are not used by display anymore.
>
>     Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
>     Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
>     Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>
>  drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h         |  4 ----
>  drivers/gpu/drm/amd/display/dc/inc/resource.h                  |  7 ----=
---
>  drivers/gpu/drm/amd/display/dc/optc/dcn20/dcn20_optc.c         | 10 ----=
------
>  drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c | 33
> +--------------------------------
>  4 files changed, 1 insertion(+), 53 deletions(-)
>
> Every time after bisecting I usually make sure that I found the right
> commit and build the kernel with revert of the bad commit.
> But this time I again observed an issue after running a kernel builded
> without commit 6d4279cb99ac.
> And I decided to find a second bad commit.
> The second bad commit has been bc87d666c05.
> commit bc87d666c05a13e6d4ae1ddce41fc43d2567b9a2 (HEAD)
> Author: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Date:   Tue Mar 26 11:55:19 2024 -0600
>
>     drm/amd/display: Add fallback configuration for set DRR in DCN10
>
>     Set OTG/OPTC parameters to 0 if something goes wrong on DCN10.
>
>     Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
>     Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
>     Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>
>  drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c | 15 ++++++++++++=
---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> After reverting both these commits on top of 54f71b0369c9 the issue is go=
ne.
>
> I also attach the build config.
>
> My hardware specs: https://linux-hardware.org/?probe=3Df25a873c5e
>
> Rodrigo or anyone else from the AMD team can you look please.

@Siqueira, Rodrigo can you take a look?  The two patches change the
programming of OTG_V_TOTAL_CONTROL.  The first patch removes this
code:

diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn20/dcn20_optc.c
b/drivers/gpu/drm/amd/display/dc/optc/dcn20/dcn20_optc.c
index 58bdbd859bf9..d6f095b4555d 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn20/dcn20_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn20/dcn20_optc.c
@@ -462,16 +462,6 @@ void optc2_setup_manual_trigger(struct
timing_generator *optc)
 {
        struct optc *optc1 =3D DCN10TG_FROM_TG(optc);

-       /* Set the min/max selectors unconditionally so that
-        * DMCUB fw may change OTG timings when necessary
-        * TODO: Remove the w/a after fixing the issue in DMCUB firmware
-        */
-       REG_UPDATE_4(OTG_V_TOTAL_CONTROL,
-                                OTG_V_TOTAL_MIN_SEL, 1,
-                                OTG_V_TOTAL_MAX_SEL, 1,
-                                OTG_FORCE_LOCK_ON_EVENT, 0,
-                                OTG_SET_V_TOTAL_MIN_MASK, (1 << 1));
/* TRIGA */
-
        REG_SET_8(OTG_TRIGA_CNTL, 0,
                        OTG_TRIGA_SOURCE_SELECT, 21,
                        OTG_TRIGA_SOURCE_PIPE_SELECT, optc->inst,

and the second patch adds this hunk:

diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c
b/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c
index f109a101d84f..5574bc628053 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c
@@ -945,10 +945,19 @@ void optc1_set_drr(
                                OTG_FORCE_LOCK_ON_EVENT, 0,
                                OTG_SET_V_TOTAL_MIN_MASK_EN, 0,
                                OTG_SET_V_TOTAL_MIN_MASK, 0);
-       }

-       // Setup manual flow control for EOF via TRIG_A
-       optc->funcs->setup_manual_trigger(optc);
+               // Setup manual flow control for EOF via TRIG_A
+               optc->funcs->setup_manual_trigger(optc);
+
+       } else {
+               REG_UPDATE_4(OTG_V_TOTAL_CONTROL,
+                               OTG_SET_V_TOTAL_MIN_MASK, 0,
+                               OTG_V_TOTAL_MIN_SEL, 0,
+                               OTG_V_TOTAL_MAX_SEL, 0,
+                               OTG_FORCE_LOCK_ON_EVENT, 0);
+
+               optc->funcs->set_vtotal_min_max(optc, 0, 0);
+       }
 }


Looks like both the if and the else side paths end up programming
OTG_V_TOTAL_CONTROL differently after the change.  Perhaps
OTG_SET_V_TOTAL_MIN_MASK needs to be set differently depending on the
DMCUB firmware version? @Mikhail Gavrilov does this patch fix it?

diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c
b/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c
index 336488c0574e..933c7a342936 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c
@@ -944,7 +944,7 @@ void optc1_set_drr(
                                OTG_V_TOTAL_MAX_SEL, 1,
                                OTG_FORCE_LOCK_ON_EVENT, 0,
                                OTG_SET_V_TOTAL_MIN_MASK_EN, 0,
-                               OTG_SET_V_TOTAL_MIN_MASK, 0);
+                               OTG_SET_V_TOTAL_MIN_MASK, (1 << 1)); /* TRI=
GA */

                // Setup manual flow control for EOF via TRIG_A
                optc->funcs->setup_manual_trigger(optc);


Thanks,

Alex

>
> --
> Best Regards,
> Mike Gavrilov.

