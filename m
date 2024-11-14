Return-Path: <linux-kernel+bounces-409955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B23079C9424
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 22:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77395284563
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 21:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62351AF0AC;
	Thu, 14 Nov 2024 21:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHIg/DEC"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C920E1AF0A9
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 21:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731619273; cv=none; b=kwsYWgscpAZ00YuwrAtmpg28siqiB6IglLCihuG6wNNJ8TjuWgXWWi730vxLrAMZCDTvdiZeuOlfAid/GCx52iG4sSlwI+pcog5PK2IjqaspXHp+lBvnc0kZdF4N6WC2YFkVBMDtdCu4UPg1C19fBZCeZoo3L4SxkqI1VlyO4L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731619273; c=relaxed/simple;
	bh=pBLBe0pmz/V3NrbYeQFwIPiQTbcbpVswc5O0bEqGKTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IY2Cp5uNqjkq/+2z6+/I3rPSlNJDri/lT+D7ynTZo4C14UHw4hZCqSoELDwlRg6duXKewyY90P5goSiPhnw8XTu/yr0DnEYKvWyt8nAsOVFlCTT1lyosMLybDaIiqoqSIAv8F/Dojy7NLD1Ojgl1WjPF5fau52FYt1eYHTNWZQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nHIg/DEC; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ea1218604fso63466a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 13:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731619271; x=1732224071; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ehv9+ANQ0CX7cBCrQKPwSvObASpaH6zmEsFRtLhvwIU=;
        b=nHIg/DECAf3WJ0YOFk2L/Tg22rbhydvXpV8jkHtPYKUG+qG4y88RNeft74yYkOeLdv
         LMap2doRQrRB9FYnxnzUegPpfsbQ1HUeZ4IbwCxYS/srXf4e6NyLG1v7Mt3AzglKejSv
         txJrERM/OiKCz9u98vaxuSmnyPqs6Az4ID+MvzbzcHcFymP9iZjsd0Vgk+X8Ldz9GK8G
         JuWA0R/C8ijCIma69xtNky3kK3WuCdCOFK/ZYsAbcaaxbgugXOQvUHLjo88x5q9v7pN2
         VbyuArlgH60nYmO20tY59DywiYkqp88U0AlSLH4iOgN3CIvV/240M4tJ72QOlQp9fbkO
         KnOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731619271; x=1732224071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ehv9+ANQ0CX7cBCrQKPwSvObASpaH6zmEsFRtLhvwIU=;
        b=ZEYLgJqc6kAv6SNhXGc7EtXovaeAV9yV62EApkVFWNGUDRXNY8hqO0exc69AEkfFda
         XUaESs00EYV4Lru2UM43+XGWX3/kXL2NTr6k57Hbs3hIHClUMmIPwbL2f+akLhMB+Mja
         otw3M15cOY0oFEZtARzHF5ddg9P+gYpVQcfzUVygduUVJyBcou9iKbysHQfHQY+vmsR0
         BbVPlkTMkBc22jhvyNtm8gOH8TVU/z2yoGgtujDsxpzDI4XTb3sYHzPQc9ka1dN7FOCh
         3aYM2BG43eKFC9AhPX15CeZ9ZrDi4/UwwxibIRqaW1WRK2e4wjoGEpFHVEot9LQlz/js
         irYw==
X-Forwarded-Encrypted: i=1; AJvYcCVTkV2tKjZqPJOnIbFeIruTBN46Rk60A6PC9kCQb4PMr4sZFTNuPoHYFI8S9VqlX04crdOus++msuqaXqk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye73f2EUijp5k6Hj0M8oO9zkRoc6fkqjkQokmNq5LZs5Wdt2FX
	vakzQ1OEQi+RySfyPnyAa6QJcZRNXt481TSc/Ias4OwuV2wwJnJ+Uhiqtzx+QC8hecL6qjK4fmz
	s4ybhplPkQ21kLWIDnhlq7D++ZGQ=
X-Google-Smtp-Source: AGHT+IHDIpTlD9Hg0BD/QZgrCLws+o4es7hQuErrVlLnU6RrTSYgLmuXZPYuQ2EJoVeAT7M0UfqpLaHszXenEXyI9f0=
X-Received: by 2002:a17:90b:17c2:b0:2db:60b:eec with SMTP id
 98e67ed59e1d1-2ea15591de6mr185724a91.7.1731619270954; Thu, 14 Nov 2024
 13:21:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114151150.19576-1-bhavin.sharma@siliconsignals.io>
 <20241114151150.19576-2-bhavin.sharma@siliconsignals.io> <511539bb-bc1d-459e-bfd1-10ad8e9d1435@amd.com>
In-Reply-To: <511539bb-bc1d-459e-bfd1-10ad8e9d1435@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 14 Nov 2024 16:20:59 -0500
Message-ID: <CADnq5_MXiOYYLKii4UiziDoKhefiPFy28++NxY5Ss_jp9ob9BA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm/amd/display: remove redundant is_dsc_possible check
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Bhavin Sharma <bhavin.sharma@siliconsignals.io>, alexander.deucher@amd.com, 
	alex.hung@amd.com, Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Xinhui Pan <Xinhui.Pan@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Kenneth Feng <kenneth.feng@amd.com>, 
	Wenjing Liu <wenjing.liu@amd.com>, Chris Park <chris.park@amd.com>, Roman Li <roman.li@amd.com>, 
	Leo Ma <hanghong.ma@amd.com>, Ryan Seto <ryanseto@amd.com>, 
	Jose Fernandez <josef@netflix.com>, Ilya Bakoulin <ilya.bakoulin@amd.com>, 
	Aurabindo Pillai <aurabindo.pillai@amd.com>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 10:21=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 14.11.24 um 16:11 schrieb Bhavin Sharma:
> > Since is_dsc_possible is already checked just above, there's no need to
> > check it again before filling out the DSC settings.
> >
> > Signed-off-by: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
> > ---
> >   drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c | 13 +++++--------
> >   1 file changed, 5 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c b/drivers/gpu/=
drm/amd/display/dc/dsc/dc_dsc.c
> > index ebd5df1a36e8..85f6f8e43947 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
> > @@ -1093,14 +1093,11 @@ static bool setup_dsc_config(
> >       if (!is_dsc_possible)
> >               goto done;
> >
> > -     // Final decission: can we do DSC or not?
> > -     if (is_dsc_possible) {
> > -             // Fill out the rest of DSC settings
> > -             dsc_cfg->block_pred_enable =3D dsc_common_caps.is_block_p=
red_supported;
> > -             dsc_cfg->linebuf_depth =3D dsc_common_caps.lb_bit_depth;
> > -             dsc_cfg->version_minor =3D (dsc_common_caps.dsc_version &=
 0xf0) >> 4;
> > -             dsc_cfg->is_dp =3D dsc_sink_caps->is_dp;
> > -     }
> > +     // Fill out the rest of DSC settings
>
> While at it you should probably replace the // style comment with /* */.
>
> Apart from that looks good to me.

Fixed up locally and applied.

Thanks,

Alex

>
> Christian.
>
> > +     dsc_cfg->block_pred_enable =3D dsc_common_caps.is_block_pred_supp=
orted;
> > +     dsc_cfg->linebuf_depth =3D dsc_common_caps.lb_bit_depth;
> > +     dsc_cfg->version_minor =3D (dsc_common_caps.dsc_version & 0xf0) >=
> 4;
> > +     dsc_cfg->is_dp =3D dsc_sink_caps->is_dp;
> >
> >   done:
> >       if (!is_dsc_possible)
>

