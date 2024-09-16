Return-Path: <linux-kernel+bounces-331114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5C997A89E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 23:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A120284359
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 21:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C0015D5B9;
	Mon, 16 Sep 2024 21:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ER5Uj9jc"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8796E1311A7
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 21:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726521154; cv=none; b=Y0TTQJRv6oLgYt3awQXEwRrgEzDW1zWlzC8BtnzRcKUelBDlhVgqGmqH3ufP0HAU27chUaE3yeU1I2ExlvQfGkgVAc9gaShH7OX6CQvuk2plcvBqI3GnJtEklnmwYEb1Hn4NHgyksGxHn2g7RbNeekI0wtuIDOXNRpkbg/UtuG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726521154; c=relaxed/simple;
	bh=RALBZAAdd84UkjI6i9jvlky6CJXw7MIcuj+pLaTR/t8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pm6ertJfz6pEdpaemjaDKzaAJOC9No/ipleCGNmrlnffwovMHSCDPLd+gReFl9xZMhEjWfa2lT7dWHZQW1OiF76aI9g//GV7c+1Ddv9jpuoAAgb8gwP0ZtNx/OuL94/ZlFJYIO8jzSZ1C/HX9dSjv5jaSnF91QfkOcYt2aAdR0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ER5Uj9jc; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2dbde420d15so127051a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 14:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726521151; x=1727125951; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xAbP4b2QjvrKLx9SqOhnM4gtxKV8osDm1elhFRlMK3w=;
        b=ER5Uj9jc85Dic6v+yLfvmLWHYpVWGUUFH518M3k+QFlevxpru4Se2pYNsKfTMhmO/m
         CRfNNvqxjnm+vtMJCIqx/lLGMvhoIqzMkeGQnpTmHqZ14TAbE4vetRvUMYqDXkw59X1R
         Os8KINfBYurzhEovXYnrbGby+vzdnu76OpGyNT80G5S8X3EVsnCfRNmr2WL97DoxHqC5
         2JZ0kFAmFQPZuon84PeCP5gvk/mXzlFkTgt+Iwaun8RhAtMlkiBs0O/cOV/zt6bcmi6a
         Qjit2fGymmmKsykijBXuhDSDnoiB373U/K+kos7qY0pfab58ixRKjVcK0POY2ddSiTZq
         23BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726521151; x=1727125951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xAbP4b2QjvrKLx9SqOhnM4gtxKV8osDm1elhFRlMK3w=;
        b=BzL4xf6Km2Fwp+OYwW3k59HA1rXBiPwX7dtPlf05mctynY/dP7EhuFJ0BDfCjWP9Uu
         03QQecp0XswHVMvgnnMJWC/gFTR1yAOfA3B+JlOf3W4PZDDcltuBxpGr/lmfxWii9JZ1
         JkFQ63lBpeWuIX7BCek8bUNGCgUiqvJ0WAvDvRTNZZ/VbA0N4QeGhAfXUnDtmBnPYjQt
         MPSkNpi1Hog502xRCMyyF9xo9Aa/HpwJ8ikyCjBJptOVk/nrmc4BJmcVYFVltAPW2CoV
         ZBUf7hUEVaBcf1JLOys6BeUN3sgaXqP/9LczDkhsQH3/vQk2tkU6wAb5wbmeVdEjd7Wu
         /ayw==
X-Forwarded-Encrypted: i=1; AJvYcCVf1keJtpkBgVgQlkULDogDwa8Nuzi1Wgpmsq2MSb+HY7ncnTx2qchQDgxdSJa67dRN0B5x1X5yFL4jDwk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5akx1IyHCMeBv9Xn+3Un0GFwhfxyMCVOarPha1ykcqzapJmGW
	nFteZnkw55Sl4wUssityXfVS1iSZH3cfXMVD9KPbE+DlE/ycl/tUJ5o/ywapoGZCC7IjdE5IE0t
	Wru1xAlqS6J8yOtwLwi4TW1ofPdRkr2Fo
X-Google-Smtp-Source: AGHT+IFRrNEmKtbJ19RItAc5lDSWsHbDbxi/uYfqJjYD4JxA1G6o1DQn01TL1PPolbqBg/Dhpyu2JdwgHzd6trRYmE4=
X-Received: by 2002:a17:902:e845:b0:207:d98:52ec with SMTP id
 d9443c01a7336-2076e448080mr105306865ad.14.1726521150347; Mon, 16 Sep 2024
 14:12:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1726490926.git.tjakobi@math.uni-bielefeld.de> <24dcaa14eba59e211355d4798df02ccb64d460ba.1726490926.git.tjakobi@math.uni-bielefeld.de>
In-Reply-To: <24dcaa14eba59e211355d4798df02ccb64d460ba.1726490926.git.tjakobi@math.uni-bielefeld.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 16 Sep 2024 17:12:18 -0400
Message-ID: <CADnq5_OxGp6AH+H3igpZNs_OK1wN=hu5AkQK9EBwfrJ2T2etLw@mail.gmail.com>
Subject: Re: [PATCH 1/1] drm/amd/display: handle nulled pipe context in
 DCE110's set_drr()
To: tjakobi@math.uni-bielefeld.de
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	"Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Mario Limonciello <mario.limonciello@amd.com>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Acked-by: Alex Deucher <alexander.deucher@amd.com>

And applied.

Thanks!

On Mon, Sep 16, 2024 at 9:03=E2=80=AFAM <tjakobi@math.uni-bielefeld.de> wro=
te:
>
> From: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
>
> As set_drr() is called from IRQ context, it can happen that the
> pipe context has been nulled by dc_state_destruct().
>
> Apply the same protection here that is already present for
> dcn35_set_drr() and dcn10_set_drr(). I.e. fetch the tg pointer
> first (to avoid a race with dc_state_destruct()), and then
> check the local copy before using it.
>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3142
> Fixes: 06ad7e164256 ("drm/amd/display: Destroy DC context while keeping D=
ML and DML2")
> Signed-off-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
> ---
>  .../amd/display/dc/hwss/dce110/dce110_hwseq.c | 21 ++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/=
drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
> index 0d3ea291eeee..666dfc6d192e 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
> @@ -1970,13 +1970,20 @@ static void set_drr(struct pipe_ctx **pipe_ctx,
>          * as well.
>          */
>         for (i =3D 0; i < num_pipes; i++) {
> -               pipe_ctx[i]->stream_res.tg->funcs->set_drr(
> -                       pipe_ctx[i]->stream_res.tg, &params);
> -
> -               if (adjust.v_total_max !=3D 0 && adjust.v_total_min !=3D =
0)
> -                       pipe_ctx[i]->stream_res.tg->funcs->set_static_scr=
een_control(
> -                                       pipe_ctx[i]->stream_res.tg,
> -                                       event_triggers, num_frames);
> +               /* dc_state_destruct() might null the stream resources, s=
o fetch tg
> +                * here first to avoid a race condition. The lifetime of =
the pointee
> +                * itself (the timing_generator object) is not a problem =
here.
> +                */
> +               struct timing_generator *tg =3D pipe_ctx[i]->stream_res.t=
g;
> +
> +               if ((tg !=3D NULL) && tg->funcs) {
> +                       if (tg->funcs->set_drr)
> +                               tg->funcs->set_drr(tg, &params);
> +                       if (adjust.v_total_max !=3D 0 && adjust.v_total_m=
in !=3D 0)
> +                               if (tg->funcs->set_static_screen_control)
> +                                       tg->funcs->set_static_screen_cont=
rol(
> +                                               tg, event_triggers, num_f=
rames);
> +               }
>         }
>  }
>
> --
> 2.44.2
>

