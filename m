Return-Path: <linux-kernel+bounces-360631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D6C999D81
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 09:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E1921C22C5E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 07:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40F420967D;
	Fri, 11 Oct 2024 07:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XlqiOMzy"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C25635
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 07:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728630641; cv=none; b=bDbV/V+6UCLnKdepAg3c+XisEmnehYhN8i3XICM6b2hGkEjuuhusY81t3XirhC0jSP2jR+OeOrYkHvsSN81ag5Uez8D1SvmVHFzyIuUybVkgYDNn0gTmOELC0BazblLQarN4YZnKcjA5ujbs5amhlpPXNRGlOk/d6Fwpaa5IUd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728630641; c=relaxed/simple;
	bh=YCvX0y4LljZwwZYV3hLIaqKLO+jvW0BinH6YUl4iOLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jmtsM1TplP7uVZC9m1iKFGh9Ld6MTW2gpG5DUa1GdYg3DPkFlw429hlOd838RZOqKdIox2wxISG462qVgIT818QOsmAuBJWKzfspIefLltvar63XAAzrAlqSfBCfi7zDM4R322dCbA89QEffdNFAhcELWcrwMm/qbDzkBwLkuvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XlqiOMzy; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6db836c6bd7so16713987b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 00:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728630638; x=1729235438; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uB2R0+KR1dxPamn6OMsbEdOchTDaIEYstgkkhKz3br8=;
        b=XlqiOMzy9mbzCTmjdf1s3BMxx/VET6f0ln+bTO6FBPHjSEr2jt7oWPrqA8TsABYcZd
         TYc8OmwBNPtWS+2yGzlUmLC2zQVCRI4jDn0d4yVBifxbUtdErs+blU+gMw/cnQ6mvk1K
         hAH2cQSwZcYEWpaYksMsjML65p+fAU3v8EOzm6vpc2D7IREDWPBFMfJ6dVs1nuRIU8Oi
         VavulcLn2OZvhSVG4p/y8eptmHk+YDVSiwx4wdJoA/xwIkDGR9iMmfGmThubjVrrl8O3
         zG7GpYCned9Elbca/sR4in82AvJjQl0kCrQ6ezIS+fAXrucRy93TjvmvzUaCCkJIU2Xw
         vSZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728630638; x=1729235438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uB2R0+KR1dxPamn6OMsbEdOchTDaIEYstgkkhKz3br8=;
        b=v1B0qkIhrinjzlb1qiQafqz9lAkHSMlQWQt+UN8dIffocIVE39JW7Es4NiyIHSkFmS
         saB+mey8pGx0ZCJwz6qBXPEt98Vqv6/JXBBjW/bcC8GVTVuniXPRKM+OE5PqDROM7ICX
         SEzF16UNyo4JZd352+XPIPOBAL/D+9aSsYW4pMyUoWrhi93GNttna8eTJ/9ykFQig33l
         GS5CtMq/3zKc9yTC0AZ2rwBrKac/yCCu+DeXWg1pX4Zc91qRnWw3Jfas+196x+Bz7UI1
         dtJhDdp76gYIllwx3I2JnIe3cSFINlwa77Oxmaa7CB5IFnkFSa3fXO1+4Q9BOhS+iSF7
         x1Sg==
X-Forwarded-Encrypted: i=1; AJvYcCUm5dZ6SPB1h2zp1eyzkrKyYi+RNap2txIT4I2HEpS8e9z9nKrq304s2nhVSGWardLH1ug+mxiZKfBWqWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwswjsGrcnH/yPTxYdTK3tdD/1bHEtiCrvNlh2d0h3NsgxEa5X5
	pEw3g3Ea7a2Y/lipU3uiXb2JGc7tfB7LIqfxGHFW7dTHv7g9rXbQO4IS12zgwUIaAVgYgLewUY6
	GDNwGrkMIo4B/stcaQlhjwmtg29vH+25MRO3Klg==
X-Google-Smtp-Source: AGHT+IF9jAEIrpfJRmkjbqE3+6XONn32tvlgdwkbSh8hIVzHdxhXT8DwVd/CLfpF0z1EWGGzQ/hhjAiyk/O546QxTkM=
X-Received: by 2002:a05:690c:10d:b0:648:baba:542f with SMTP id
 00721157ae682-6e3471dd553mr12484157b3.0.1728630637737; Fri, 11 Oct 2024
 00:10:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-21-v2-0-76d4f5d413bf@linaro.org>
 <20241009-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-21-v2-5-76d4f5d413bf@linaro.org>
 <kuvbcodnbgsgetkudbce32rajy6kg3lpxhcx6cvgm6bi7ekoki@smmnpdrwhbqn> <CABymUCOFV0Ze=55Ne23nKrN_4ES6cUT3_av7Q2xxtxT3Hw7ZJg@mail.gmail.com>
In-Reply-To: <CABymUCOFV0Ze=55Ne23nKrN_4ES6cUT3_av7Q2xxtxT3Hw7ZJg@mail.gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 11 Oct 2024 10:10:26 +0300
Message-ID: <CAA8EJpqZ0X_DezzVPnWswwWoZCL8ZZJ4M-DHvUSo4qJXK6mQnQ@mail.gmail.com>
Subject: Re: [PATCH v2 05/14] drm/msm/dpu: handle pipes as array
To: Jun Nie <jun.nie@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 11 Oct 2024 at 09:49, Jun Nie <jun.nie@linaro.org> wrote:
>
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org> =E4=BA=8E2024=E5=B9=B410=
=E6=9C=8810=E6=97=A5=E5=91=A8=E5=9B=9B 21:08=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Wed, Oct 09, 2024 at 04:50:18PM GMT, Jun Nie wrote:
> > > Store pipes in array with removing dedicated r_pipe. There are
> > > 2 pipes in a drm plane at most currently. While 4 pipes are
> > > needed for new usage case. This change generalize the handling
> > > to pipe pair and ease handling to another pipe pair later.
> > >
> > > Signed-off-by: Jun Nie <jun.nie@linaro.org>
> > > ---
> > >  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c  |  34 +++---
> > >  drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 167 ++++++++++++++++----=
----------
> > >  drivers/gpu/drm/msm/disp/dpu1/dpu_plane.h |  12 +--
> > >  drivers/gpu/drm/msm/disp/dpu1/dpu_trace.h |  10 +-
> > >  4 files changed, 111 insertions(+), 112 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/d=
rm/msm/disp/dpu1/dpu_crtc.c
> > > index 3e0e6e9757da5..9656b1df0f122 100644
> > > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> > > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> > > @@ -411,7 +411,7 @@ static void _dpu_crtc_blend_setup_pipe(struct drm=
_crtc *crtc,
> > >
> > >       trace_dpu_crtc_setup_mixer(DRMID(crtc), DRMID(plane),
> > >                                  state, to_dpu_plane_state(state), st=
age_idx,
> > > -                                format->pixel_format,
> > > +                                format->pixel_format, pipe,
> > >                                  modifier);
> >
> > Doesn't seem to be related.
>
> There is building error when converting r_pipe into pipe array. So I
> need to change trace code
> accordingly in the same patch. Otherwise, the error happens just after
> this patch is applied.

No. It is related to your changes that add pipe argument to
trace_dpu_crtc_setup_mixer(). Please split that part.

> >
> > >
> > >       DRM_DEBUG_ATOMIC("crtc %d stage:%d - plane %d sspp %d fb %d mul=
tirect_idx %d\n",
> > > @@ -442,7 +442,7 @@ static void _dpu_crtc_blend_setup_mixer(struct dr=
m_crtc *crtc,
> > >       const struct msm_format *format;
> > >       struct dpu_hw_ctl *ctl =3D mixer->lm_ctl;
> > >
> > > -     uint32_t lm_idx;
> > > +     uint32_t lm_idx, i;
> > >       bool bg_alpha_enable =3D false;
> > >       DECLARE_BITMAP(fetch_active, SSPP_MAX);
> > >
> > > @@ -463,20 +463,15 @@ static void _dpu_crtc_blend_setup_mixer(struct =
drm_crtc *crtc,
> > >               if (pstate->stage =3D=3D DPU_STAGE_BASE && format->alph=
a_enable)
> > >                       bg_alpha_enable =3D true;
> > >
> > > -             set_bit(pstate->pipe.sspp->idx, fetch_active);
> > > -             _dpu_crtc_blend_setup_pipe(crtc, plane,
> > > -                                        mixer, cstate->num_mixers,
> > > -                                        pstate->stage,
> > > -                                        format, fb ? fb->modifier : =
0,
> > > -                                        &pstate->pipe, 0, stage_cfg)=
;
> > > -
> > > -             if (pstate->r_pipe.sspp) {
> > > -                     set_bit(pstate->r_pipe.sspp->idx, fetch_active)=
;
> > > +             for (i =3D 0; i < PIPES_PER_STAGE; i++) {
> > > +                     if (!pstate->pipe[i].sspp)
> > > +                             continue;
> > > +                     set_bit(pstate->pipe[i].sspp->idx, fetch_active=
);
> > >                       _dpu_crtc_blend_setup_pipe(crtc, plane,
> > >                                                  mixer, cstate->num_m=
ixers,
> > >                                                  pstate->stage,
> > >                                                  format, fb ? fb->mod=
ifier : 0,
> > > -                                                &pstate->r_pipe, 1, =
stage_cfg);
> > > +                                                &pstate->pipe[i], i,=
 stage_cfg);
> > >               }
> > >
> > >               /* blend config update */
> > > @@ -1387,15 +1382,12 @@ static int _dpu_debugfs_status_show(struct se=
q_file *s, void *data)
> > >               seq_printf(s, "\tdst x:%4d dst_y:%4d dst_w:%4d dst_h:%4=
d\n",
> > >                       state->crtc_x, state->crtc_y, state->crtc_w,
> > >                       state->crtc_h);
> > > -             seq_printf(s, "\tsspp[0]:%s\n",
> > > -                        pstate->pipe.sspp->cap->name);
> > > -             seq_printf(s, "\tmultirect[0]: mode: %d index: %d\n",
> > > -                     pstate->pipe.multirect_mode, pstate->pipe.multi=
rect_index);
> > > -             if (pstate->r_pipe.sspp) {
> > > -                     seq_printf(s, "\tsspp[1]:%s\n",
> > > -                                pstate->r_pipe.sspp->cap->name);
> > > -                     seq_printf(s, "\tmultirect[1]: mode: %d index: =
%d\n",
> > > -                                pstate->r_pipe.multirect_mode, pstat=
e->r_pipe.multirect_index);
> > > +             if (pstate->pipe[i].sspp) {
> > > +                     seq_printf(s, "\tsspp[%d]:%s\n",
> > > +                                i, pstate->pipe[i].sspp->cap->name);
> > > +                     seq_printf(s, "\tmultirect[%d]: mode: %d index:=
 %d\n",
> > > +                                i, pstate->pipe[i].multirect_mode,
> > > +                                pstate->pipe[i].multirect_index);
> > >               }
> >
> > I don't expect that this will work.
>
> Yes, the loop is missed. Will add it.
> >
> > >
> > >               seq_puts(s, "\n");
> > > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/=
drm/msm/disp/dpu1/dpu_plane.c
> > > index 4df7cfed4d230..e7006fb8c7734 100644
> > > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> > > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> > > @@ -429,7 +429,7 @@ static void _dpu_plane_setup_scaler3(struct dpu_h=
w_sspp *pipe_hw,
> > >               uint32_t chroma_subsmpl_h, uint32_t chroma_subsmpl_v,
> > >               unsigned int rotation)
> > >  {
> > > -     uint32_t i;
> > > +     int i;
> >
> > Why?
>
> No need actually. It is a typo when converting type of many i.
>
> >
> > >       bool inline_rotation =3D rotation & DRM_MODE_ROTATE_90;
> > >
> > >       /*
> > > @@ -619,6 +619,7 @@ static void _dpu_plane_color_fill(struct dpu_plan=
e *pdpu,
> > >       struct msm_drm_private *priv =3D plane->dev->dev_private;
> > >       struct dpu_plane_state *pstate =3D to_dpu_plane_state(plane->st=
ate);
> > >       u32 fill_color =3D (color & 0xFFFFFF) | ((alpha & 0xFF) << 24);
> > > +     int i;
> > >
> > >       DPU_DEBUG_PLANE(pdpu, "\n");
> > >
> > > @@ -632,12 +633,12 @@ static void _dpu_plane_color_fill(struct dpu_pl=
ane *pdpu,
> > >               return;
> > >
> > >       /* update sspp */
> > > -     _dpu_plane_color_fill_pipe(pstate, &pstate->pipe, &pstate->pipe=
_cfg.dst_rect,
> > > -                                fill_color, fmt);
> > > -
> > > -     if (pstate->r_pipe.sspp)
> > > -             _dpu_plane_color_fill_pipe(pstate, &pstate->r_pipe, &ps=
tate->r_pipe_cfg.dst_rect,
> > > -                                        fill_color, fmt);
> > > +     for (i =3D 0; i < PIPES_PER_STAGE; i++) {
> > > +             if (pstate->pipe[i].sspp)
> > > +                     _dpu_plane_color_fill_pipe(pstate, &pstate->pip=
e[i],
> > > +                                                &pstate->pipe_cfg[i]=
.dst_rect,
> > > +                                                fill_color, fmt);
> > > +     }
> > >  }
> > >
> > >  static int dpu_plane_prepare_fb(struct drm_plane *plane,
> > > @@ -808,8 +809,8 @@ static int dpu_plane_atomic_check_nopipe(struct d=
rm_plane *plane,
> > >       struct dpu_kms *kms =3D _dpu_plane_get_kms(&pdpu->base);
> > >       u64 max_mdp_clk_rate =3D kms->perf.max_core_clk_rate;
> > >       struct dpu_plane_state *pstate =3D to_dpu_plane_state(new_plane=
_state);
> > > -     struct dpu_sw_pipe_cfg *pipe_cfg =3D &pstate->pipe_cfg;
> > > -     struct dpu_sw_pipe_cfg *r_pipe_cfg =3D &pstate->r_pipe_cfg;
> > > +     struct dpu_sw_pipe_cfg *pipe_cfg;
> > > +     struct dpu_sw_pipe_cfg *r_pipe_cfg;
> > >       struct drm_rect fb_rect =3D { 0 };
> > >       uint32_t max_linewidth;
> > >
> > > @@ -834,6 +835,9 @@ static int dpu_plane_atomic_check_nopipe(struct d=
rm_plane *plane,
> > >               return -EINVAL;
> > >       }
> > >
> > > +     /* move the assignment here, to ease handling to another pairs =
later */
> > > +     pipe_cfg =3D &pstate->pipe_cfg[0];
> > > +     r_pipe_cfg =3D &pstate->pipe_cfg[1];
> > >       /* state->src is 16.16, src_rect is not */
> > >       drm_rect_fp_to_int(&pipe_cfg->src_rect, &new_plane_state->src);
> > >
> > > @@ -916,11 +920,11 @@ static int dpu_plane_atomic_check_pipes(struct =
drm_plane *plane,
> > >               drm_atomic_get_new_plane_state(state, plane);
> > >       struct dpu_plane *pdpu =3D to_dpu_plane(plane);
> > >       struct dpu_plane_state *pstate =3D to_dpu_plane_state(new_plane=
_state);
> > > -     struct dpu_sw_pipe *pipe =3D &pstate->pipe;
> > > -     struct dpu_sw_pipe *r_pipe =3D &pstate->r_pipe;
> > >       const struct msm_format *fmt;
> > > -     struct dpu_sw_pipe_cfg *pipe_cfg =3D &pstate->pipe_cfg;
> > > -     struct dpu_sw_pipe_cfg *r_pipe_cfg =3D &pstate->r_pipe_cfg;
> > > +     struct dpu_sw_pipe *pipe =3D &pstate->pipe[0];
> > > +     struct dpu_sw_pipe *r_pipe =3D &pstate->pipe[1];
> > > +     struct dpu_sw_pipe_cfg *pipe_cfg =3D &pstate->pipe_cfg[0];
> > > +     struct dpu_sw_pipe_cfg *r_pipe_cfg =3D &pstate->pipe_cfg[1];
> > >       uint32_t supported_rotations;
> > >       const struct dpu_sspp_cfg *pipe_hw_caps;
> > >       const struct dpu_sspp_sub_blks *sblk;
> > > @@ -975,10 +979,10 @@ static int dpu_plane_atomic_check(struct drm_pl=
ane *plane,
> > >       struct dpu_plane *pdpu =3D to_dpu_plane(plane);
> > >       struct dpu_plane_state *pstate =3D to_dpu_plane_state(new_plane=
_state);
> > >       struct dpu_kms *dpu_kms =3D _dpu_plane_get_kms(plane);
> > > -     struct dpu_sw_pipe *pipe =3D &pstate->pipe;
> > > -     struct dpu_sw_pipe *r_pipe =3D &pstate->r_pipe;
> > > -     struct dpu_sw_pipe_cfg *pipe_cfg =3D &pstate->pipe_cfg;
> > > -     struct dpu_sw_pipe_cfg *r_pipe_cfg =3D &pstate->r_pipe_cfg;
> > > +     struct dpu_sw_pipe *pipe =3D &pstate->pipe[0];
> > > +     struct dpu_sw_pipe *r_pipe =3D &pstate->pipe[1];
> > > +     struct dpu_sw_pipe_cfg *pipe_cfg =3D &pstate->pipe_cfg[0];
> > > +     struct dpu_sw_pipe_cfg *r_pipe_cfg =3D &pstate->pipe_cfg[1];
> > >       const struct drm_crtc_state *crtc_state =3D NULL;
> > >
> > >       if (new_plane_state->crtc)
> > > @@ -1056,7 +1060,7 @@ static int dpu_plane_virtual_atomic_check(struc=
t drm_plane *plane,
> > >               drm_atomic_get_old_plane_state(state, plane);
> > >       struct dpu_plane_state *pstate =3D to_dpu_plane_state(plane_sta=
te);
> > >       struct drm_crtc_state *crtc_state;
> > > -     int ret;
> > > +     int ret, i;
> > >
> > >       if (plane_state->crtc)
> > >               crtc_state =3D drm_atomic_get_new_crtc_state(state,
> > > @@ -1071,8 +1075,8 @@ static int dpu_plane_virtual_atomic_check(struc=
t drm_plane *plane,
> > >                * resources are freed by dpu_crtc_assign_plane_resourc=
es(),
> > >                * but clean them here.
> > >                */
> > > -             pstate->pipe.sspp =3D NULL;
> > > -             pstate->r_pipe.sspp =3D NULL;
> > > +             for (i =3D 0; i < PIPES_PER_STAGE; i++)
> > > +                     pstate->pipe[i].sspp =3D NULL;
> > >
> > >               return 0;
> > >       }
> > > @@ -1110,19 +1114,22 @@ static int dpu_plane_virtual_assign_resources=
(struct drm_crtc *crtc,
> > >       struct dpu_sw_pipe_cfg *r_pipe_cfg;
> > >       const struct msm_format *fmt;
> > >       uint32_t max_linewidth;
> > > +     int i;
> > >
> > >       if (plane_state->crtc)
> > >               crtc_state =3D drm_atomic_get_new_crtc_state(state,
> > >                                                          plane_state-=
>crtc);
> > >
> > >       pstate =3D to_dpu_plane_state(plane_state);
> > > -     pipe =3D &pstate->pipe;
> > > -     r_pipe =3D &pstate->r_pipe;
> > > -     pipe_cfg =3D &pstate->pipe_cfg;
> > > -     r_pipe_cfg =3D &pstate->r_pipe_cfg;
> > >
> > > -     pipe->sspp =3D NULL;
> > > -     r_pipe->sspp =3D NULL;
> > > +     /* loop below code for another pair later */
> >
> > ??
>
> A marker for TODO. The first pair are handled in this patch. A loop will =
be
> added later to loop the handing to the pair.

A marker for TODO is 'TODO: foo bar'.

> >
> > > +     pipe =3D &pstate->pipe[0];
> > > +     r_pipe =3D &pstate->pipe[1];
> > > +     pipe_cfg =3D &pstate->pipe_cfg[0];
> > > +     r_pipe_cfg =3D &pstate->pipe_cfg[1];
> > > +
> > > +     for (i =3D 0; i < PIPES_PER_STAGE; i++)
> > > +             pstate->pipe[i].sspp =3D NULL;
> > >
> > >       if (!plane_state->fb)
> > >               return -EINVAL;
> > > @@ -1228,6 +1235,7 @@ void dpu_plane_flush(struct drm_plane *plane)
> > >  {
> > >       struct dpu_plane *pdpu;
> > >       struct dpu_plane_state *pstate;
> > > +     int i;
> > >
> > >       if (!plane || !plane->state) {
> > >               DPU_ERROR("invalid plane\n");
> > > @@ -1248,8 +1256,8 @@ void dpu_plane_flush(struct drm_plane *plane)
> > >               /* force 100% alpha */
> > >               _dpu_plane_color_fill(pdpu, pdpu->color_fill, 0xFF);
> > >       else {
> > > -             dpu_plane_flush_csc(pdpu, &pstate->pipe);
> > > -             dpu_plane_flush_csc(pdpu, &pstate->r_pipe);
> > > +             for (i =3D 0; i < PIPES_PER_STAGE; i++)
> > > +                     dpu_plane_flush_csc(pdpu, &pstate->pipe[i]);
> > >       }
> > >
> > >       /* flag h/w flush complete */
> > > @@ -1349,20 +1357,16 @@ static void dpu_plane_sspp_atomic_update(stru=
ct drm_plane *plane)
> > >       struct dpu_plane *pdpu =3D to_dpu_plane(plane);
> > >       struct drm_plane_state *state =3D plane->state;
> > >       struct dpu_plane_state *pstate =3D to_dpu_plane_state(state);
> > > -     struct dpu_sw_pipe *pipe =3D &pstate->pipe;
> > > -     struct dpu_sw_pipe *r_pipe =3D &pstate->r_pipe;
> > >       struct drm_crtc *crtc =3D state->crtc;
> > >       struct drm_framebuffer *fb =3D state->fb;
> > >       bool is_rt_pipe;
> > >       const struct msm_format *fmt =3D
> > >               msm_framebuffer_format(fb);
> > > -     struct dpu_sw_pipe_cfg *pipe_cfg =3D &pstate->pipe_cfg;
> > > -     struct dpu_sw_pipe_cfg *r_pipe_cfg =3D &pstate->r_pipe_cfg;
> > >       struct dpu_kms *kms =3D _dpu_plane_get_kms(&pdpu->base);
> > >       struct msm_gem_address_space *aspace =3D kms->base.aspace;
> > >       struct dpu_hw_fmt_layout layout;
> > >       bool layout_valid =3D false;
> > > -     int ret;
> > > +     int ret, i;
> > >
> > >       ret =3D dpu_format_populate_layout(aspace, fb, &layout);
> > >       if (ret)
> > > @@ -1381,12 +1385,12 @@ static void dpu_plane_sspp_atomic_update(stru=
ct drm_plane *plane)
> > >                       crtc->base.id, DRM_RECT_ARG(&state->dst),
> > >                       &fmt->pixel_format, MSM_FORMAT_IS_UBWC(fmt));
> > >
> > > -     dpu_plane_sspp_update_pipe(plane, pipe, pipe_cfg, fmt,
> > > -                                drm_mode_vrefresh(&crtc->mode),
> > > -                                layout_valid ? &layout : NULL);
> > > -
> > > -     if (r_pipe->sspp) {
> > > -             dpu_plane_sspp_update_pipe(plane, r_pipe, r_pipe_cfg, f=
mt,
> > > +     /* move the assignment here, to ease handling to another pairs =
later */
> > > +     for (i =3D 0; i < PIPES_PER_STAGE; i++) {
> > > +             if (!pstate->pipe[i].sspp)
> > > +                     continue;
> > > +             dpu_plane_sspp_update_pipe(plane, &pstate->pipe[i],
> > > +                                        &pstate->pipe_cfg[i], fmt,
> > >                                          drm_mode_vrefresh(&crtc->mod=
e),
> > >                                          layout_valid ? &layout : NUL=
L);
> > >       }
> > > @@ -1394,15 +1398,17 @@ static void dpu_plane_sspp_atomic_update(stru=
ct drm_plane *plane)
> > >       if (pstate->needs_qos_remap)
> > >               pstate->needs_qos_remap =3D false;
> > >
> > > -     pstate->plane_fetch_bw =3D _dpu_plane_calc_bw(pdpu->catalog, fm=
t,
> > > -                                                 &crtc->mode, pipe_c=
fg);
> > > -
> > > -     pstate->plane_clk =3D _dpu_plane_calc_clk(&crtc->mode, pipe_cfg=
);
> > > -
> > > -     if (r_pipe->sspp) {
> > > -             pstate->plane_fetch_bw +=3D _dpu_plane_calc_bw(pdpu->ca=
talog, fmt, &crtc->mode, r_pipe_cfg);
> > > +     pstate->plane_fetch_bw =3D 0;
> > > +     pstate->plane_clk =3D 0;
> > > +     for (i =3D 0; i < PIPES_PER_STAGE; i++) {
> > > +             if (!pstate->pipe[i].sspp)
> > > +                     continue;
> > > +             pstate->plane_fetch_bw +=3D _dpu_plane_calc_bw(pdpu->ca=
talog, fmt,
> > > +                                                     &crtc->mode, &p=
state->pipe_cfg[i]);
> >
> > Wrong indentation
>
> Could you help elaborate it? I assume it is a bandwidth audit.

Indent to the opening bracket please.

> >
> > >
> > > -             pstate->plane_clk =3D max(pstate->plane_clk, _dpu_plane=
_calc_clk(&crtc->mode, r_pipe_cfg));
> > > +             pstate->plane_clk =3D max(pstate->plane_clk,
> > > +                                     _dpu_plane_calc_clk(&crtc->mode=
,
> > > +                                                         &pstate->pi=
pe_cfg[i]));
> > >       }
> > >  }
> > >
> > > @@ -1410,17 +1416,24 @@ static void _dpu_plane_atomic_disable(struct =
drm_plane *plane)
> > >  {
> > >       struct drm_plane_state *state =3D plane->state;
> > >       struct dpu_plane_state *pstate =3D to_dpu_plane_state(state);
> > > -     struct dpu_sw_pipe *r_pipe =3D &pstate->r_pipe;
> > > +     struct dpu_sw_pipe *pipe;
> > > +     int i;
> > > +
> > > +     for (i =3D 0; i < PIPES_PER_STAGE; i +=3D 1) {
> > > +             pipe =3D &pstate->pipe[i];
> > > +             if (!pipe->sspp)
> > > +                     continue;
> > >
> > > -     trace_dpu_plane_disable(DRMID(plane), false,
> > > -                             pstate->pipe.multirect_mode);
> > > +             trace_dpu_plane_disable(DRMID(plane), false,
> > > +                                     pstate->pipe[i].multirect_mode)=
;
> > >
> > > -     if (r_pipe->sspp) {
> > > -             r_pipe->multirect_index =3D DPU_SSPP_RECT_SOLO;
> > > -             r_pipe->multirect_mode =3D DPU_SSPP_MULTIRECT_NONE;
> > > +             if (pipe->sspp && pipe->multirect_index =3D=3D DPU_SSPP=
_RECT_1) {
> >
> > if (i > 1)
>
> Is there any case that pipe->multirect_index =3D=3D DPU_SSPP_RECT_1 and i=
 =3D=3D 0 ?

You are converting the code. Please don't change the logic. Original
code had separate handling for r_pipe. After your conversion it should
be if (i =3D=3D 1) or if (i > 0), which means a typo in my review comment.

> >
> > > +                     pipe->multirect_index =3D DPU_SSPP_RECT_SOLO;
> > > +                     pipe->multirect_mode =3D DPU_SSPP_MULTIRECT_NON=
E;
> > >
> > > -             if (r_pipe->sspp->ops.setup_multirect)
> > > -                     r_pipe->sspp->ops.setup_multirect(r_pipe);
> > > +                     if (pipe->sspp->ops.setup_multirect)
> > > +                             pipe->sspp->ops.setup_multirect(pipe);
> > > +             }
> > >       }
> > >
> > >       pstate->pending =3D true;
> > > @@ -1515,30 +1528,26 @@ static void dpu_plane_atomic_print_state(stru=
ct drm_printer *p,
> > >               const struct drm_plane_state *state)
> > >  {
> > >       const struct dpu_plane_state *pstate =3D to_dpu_plane_state(sta=
te);
> > > -     const struct dpu_sw_pipe *pipe =3D &pstate->pipe;
> > > -     const struct dpu_sw_pipe_cfg *pipe_cfg =3D &pstate->pipe_cfg;
> > > -     const struct dpu_sw_pipe *r_pipe =3D &pstate->r_pipe;
> > > -     const struct dpu_sw_pipe_cfg *r_pipe_cfg =3D &pstate->r_pipe_cf=
g;
> > > +     const struct dpu_sw_pipe *pipe;
> > > +     const struct dpu_sw_pipe_cfg *pipe_cfg;
> > > +     int i;
> > >
> > >       drm_printf(p, "\tstage=3D%d\n", pstate->stage);
> > >
> > > -     if (pipe->sspp) {
> > > -             drm_printf(p, "\tsspp[0]=3D%s\n", pipe->sspp->cap->name=
);
> > > -             drm_printf(p, "\tmultirect_mode[0]=3D%s\n", dpu_get_mul=
tirect_mode(pipe->multirect_mode));
> > > -             drm_printf(p, "\tmultirect_index[0]=3D%s\n",
> > > +     for (i =3D 0; i < PIPES_PER_STAGE; i++) {
> > > +             pipe =3D &pstate->pipe[i];
> > > +             if (!pipe->sspp)
> > > +                     continue;
> > > +             pipe_cfg =3D &pstate->pipe_cfg[i];
> > > +             drm_printf(p, "\tsspp[%d]=3D%s\n", i, pipe->sspp->cap->=
name);
> > > +             drm_printf(p, "\tmultirect_mode[%d]=3D%s\n", i,
> > > +                        dpu_get_multirect_mode(pipe->multirect_mode)=
);
> > > +             drm_printf(p, "\tmultirect_index[%d]=3D%s\n", i,
> > >                          dpu_get_multirect_index(pipe->multirect_inde=
x));
> > > -             drm_printf(p, "\tsrc[0]=3D" DRM_RECT_FMT "\n", DRM_RECT=
_ARG(&pipe_cfg->src_rect));
> > > -             drm_printf(p, "\tdst[0]=3D" DRM_RECT_FMT "\n", DRM_RECT=
_ARG(&pipe_cfg->dst_rect));
> > > -     }
> > > -
> > > -     if (r_pipe->sspp) {
> > > -             drm_printf(p, "\tsspp[1]=3D%s\n", r_pipe->sspp->cap->na=
me);
> > > -             drm_printf(p, "\tmultirect_mode[1]=3D%s\n",
> > > -                        dpu_get_multirect_mode(r_pipe->multirect_mod=
e));
> > > -             drm_printf(p, "\tmultirect_index[1]=3D%s\n",
> > > -                        dpu_get_multirect_index(r_pipe->multirect_in=
dex));
> > > -             drm_printf(p, "\tsrc[1]=3D" DRM_RECT_FMT "\n", DRM_RECT=
_ARG(&r_pipe_cfg->src_rect));
> > > -             drm_printf(p, "\tdst[1]=3D" DRM_RECT_FMT "\n", DRM_RECT=
_ARG(&r_pipe_cfg->dst_rect));
> > > +             drm_printf(p, "\tsrc[%d]=3D" DRM_RECT_FMT "\n", i,
> > > +                        DRM_RECT_ARG(&pipe_cfg->src_rect));
> > > +             drm_printf(p, "\tdst[%d]=3D" DRM_RECT_FMT "\n", i,
> > > +                        DRM_RECT_ARG(&pipe_cfg->dst_rect));
> > >       }
> > >  }
> > >
> > > @@ -1576,14 +1585,16 @@ void dpu_plane_danger_signal_ctrl(struct drm_=
plane *plane, bool enable)
> > >       struct dpu_plane *pdpu =3D to_dpu_plane(plane);
> > >       struct dpu_plane_state *pstate =3D to_dpu_plane_state(plane->st=
ate);
> > >       struct dpu_kms *dpu_kms =3D _dpu_plane_get_kms(plane);
> > > +     int i;
> > >
> > >       if (!pdpu->is_rt_pipe)
> > >               return;
> > >
> > >       pm_runtime_get_sync(&dpu_kms->pdev->dev);
> > > -     _dpu_plane_set_qos_ctrl(plane, &pstate->pipe, enable);
> > > -     if (pstate->r_pipe.sspp)
> > > -             _dpu_plane_set_qos_ctrl(plane, &pstate->r_pipe, enable)=
;
> > > +     for (i =3D 0; i < PIPES_PER_STAGE; i++) {
> > > +             if (pstate->pipe[i].sspp)
> > > +                     _dpu_plane_set_qos_ctrl(plane, &pstate->pipe[i]=
, enable);
> > > +     }
> > >       pm_runtime_put_sync(&dpu_kms->pdev->dev);
> > >  }
> > >  #endif
> > > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.h b/drivers/gpu/=
drm/msm/disp/dpu1/dpu_plane.h
> > > index e225d5baceb09..39945e0d1b851 100644
> > > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.h
> > > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.h
> > > @@ -18,10 +18,8 @@
> > >   * struct dpu_plane_state: Define dpu extension of drm plane state o=
bject
> > >   * @base:    base drm plane state object
> > >   * @aspace:  pointer to address space for input/output buffers
> > > - * @pipe:    software pipe description
> > > - * @r_pipe:  software pipe description of the second pipe
> > > - * @pipe_cfg:        software pipe configuration
> > > - * @r_pipe_cfg:      software pipe configuration for the second pipe
> > > + * @pipe:    software pipe description array
> > > + * @pipe_cfg:        software pipe configuration array
> > >   * @stage:   assigned by crtc blender
> > >   * @needs_qos_remap: qos remap settings need to be updated
> > >   * @multirect_index: index of the rectangle of SSPP
> > > @@ -34,10 +32,8 @@
> > >  struct dpu_plane_state {
> > >       struct drm_plane_state base;
> > >       struct msm_gem_address_space *aspace;
> > > -     struct dpu_sw_pipe pipe;
> > > -     struct dpu_sw_pipe r_pipe;
> > > -     struct dpu_sw_pipe_cfg pipe_cfg;
> > > -     struct dpu_sw_pipe_cfg r_pipe_cfg;
> > > +     struct dpu_sw_pipe pipe[PIPES_PER_STAGE];
> > > +     struct dpu_sw_pipe_cfg pipe_cfg[PIPES_PER_STAGE];
> > >       enum dpu_stage stage;
> > >       bool needs_qos_remap;
> > >       bool pending;
> > > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_trace.h b/drivers/gpu/=
drm/msm/disp/dpu1/dpu_trace.h
> > > index 5307cbc2007c5..cb24ad2a6d8d3 100644
> > > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_trace.h
> > > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_trace.h
> > > @@ -651,9 +651,9 @@ TRACE_EVENT(dpu_crtc_setup_mixer,
> > >       TP_PROTO(uint32_t crtc_id, uint32_t plane_id,
> > >                struct drm_plane_state *state, struct dpu_plane_state =
*pstate,
> > >                uint32_t stage_idx, uint32_t pixel_format,
> > > -              uint64_t modifier),
> > > +              struct dpu_sw_pipe *pipe, uint64_t modifier),
> > >       TP_ARGS(crtc_id, plane_id, state, pstate, stage_idx,
> > > -             pixel_format, modifier),
> > > +             pixel_format, pipe, modifier),
> > >       TP_STRUCT__entry(
> > >               __field(        uint32_t,               crtc_id        =
 )
> > >               __field(        uint32_t,               plane_id       =
 )
> > > @@ -676,9 +676,9 @@ TRACE_EVENT(dpu_crtc_setup_mixer,
> > >               __entry->dst_rect =3D drm_plane_state_dest(state);
> > >               __entry->stage_idx =3D stage_idx;
> > >               __entry->stage =3D pstate->stage;
> > > -             __entry->sspp =3D pstate->pipe.sspp->idx;
> > > -             __entry->multirect_idx =3D pstate->pipe.multirect_index=
;
> > > -             __entry->multirect_mode =3D pstate->pipe.multirect_mode=
;
> > > +             __entry->sspp =3D pipe->sspp->idx;
> > > +             __entry->multirect_idx =3D pipe->multirect_index;
> > > +             __entry->multirect_mode =3D pipe->multirect_mode;
> > >               __entry->pixel_format =3D pixel_format;
> > >               __entry->modifier =3D modifier;
> > >       ),
> > >
> > > --
> > > 2.34.1
> > >
> >
> > --
> > With best wishes
> > Dmitry



--=20
With best wishes
Dmitry

