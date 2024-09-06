Return-Path: <linux-kernel+bounces-318479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A70196EE8C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 10:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFE231C211AC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 08:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80F9156238;
	Fri,  6 Sep 2024 08:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZqAr5qlP"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112E613A3F4
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 08:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725612626; cv=none; b=mGQ09wGzxDbe1JFhbXbkWT9Eui9K8df7Y6lXU8MZlylWuaVdocKpXqQKs3AxvoiRf5HqdLBYjVpc9ZJJQcHz6+HIYe8hMV3OcFVgJ9dgnxn9FYq3dLJaXBf+3UM+LaomTr+IaPjglIMJaEV5hGfUuauDVAFAR/ZFkzEjlWuKpNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725612626; c=relaxed/simple;
	bh=FcgtdZB1w91g2pzRhOo2Ld5oHMx5DAhkbD8/p4RXWGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YkBs6/b1pjRHwelBrCnyZUS8TEuJzFgDDytfPkLi22Mg++7yNdrH/dD8uiQl7HwKyrsW+HheNbRpSk7/ZD/wqe0iAqfGDSYgGDJjaRnlrIYHf1matmNwfzM+sSJ6WaEP5iDHyEZ0r6ihRt+HKYZwasRqzlcW5ddejYxZRjM7Bjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZqAr5qlP; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42c7a384b18so14009995e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 01:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1725612622; x=1726217422; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SR/9jqMaY4ZkJhVpjV584ea+FY7mIMJMTafocuSMEVI=;
        b=ZqAr5qlPFeLroQ+y4WSQQQcpr1UdG2ZBPJz2hz6tCbtbOcuAmB4Licsr5stoCuZj4P
         ayyGsL9L7JPgo6u/nDzRF6sDWAMPYU7EhCNoRD+JjYK1SeZ+Hk5/dOwfpy8twXshSEH1
         9kKroB5Bcf7EpvFUj9QJ82TrNN8RgUpiBDIJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725612622; x=1726217422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SR/9jqMaY4ZkJhVpjV584ea+FY7mIMJMTafocuSMEVI=;
        b=NWjV2SJ2e2WcF7doQScE/EGkRXTebfJJjR9j9Jf4ImSyGOFlThUCkHlnlybwu/FtMk
         IIEReWKqfLrSz39zlg2glVDUmR6ngBQrVpR9K2RzdEeff7MmZ0BYxbV7JK6qblXjTzSG
         MREMLDA/VOZ85qf/EdNPjB/QKGVPkq3kOpG4XCf60jnNXXw0lNSHa7ojmlYnWDJUl1rb
         tqKlu3C1sEI2z4dJAvSkLL1q2Ew+/fOPx0ycQTuLvi2e4AoUaM+js8KqcyfmDPgLDbM1
         oV7dahhFzOtIxiZIfs4IBB53OJtvdvUP3NcfC4jaXrHeLVy8YxgPtDhbPaXSaelbUr5t
         r91w==
X-Forwarded-Encrypted: i=1; AJvYcCVnJfapGoga/CFwDwHs0ZJjAo+zEa0JiMK0Cm6pZKYwn6E4dI1SAEK6qZT5IHfErzsZ8QhShilazlZKnIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyDGLCw0a+MhgsP0Ss+nHtKhb3CZnrvUu3Es70sDqDPZcAgNGY
	+Z/yCYzAAdxGwb3PnsbhS5zU1Uv6WkHXfEXqt/40Y5MRwkVo+frTlW6FP5sDXO32ohWFB2/EVeF
	Qf9LK+HbubWX1Az26aP/r+J5czNq0ZKZ9hLuM
X-Google-Smtp-Source: AGHT+IEf3kS+J5eIcH9aoEI8sQEx7ql08PzycsM89+gtgjd5bmyXErbV7K7VP95PFXMisPnX+f8aCwG5eZm6hdTL5O8=
X-Received: by 2002:a5d:4983:0:b0:371:86b2:a7e4 with SMTP id
 ffacd0b85a97d-37889682e03mr1118424f8f.37.1725612621485; Fri, 06 Sep 2024
 01:50:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240903045809.5025-1-mukul.sikka@broadcom.com> <CADnq5_OVSD1DXgi_9f_H-uT7KSjMwz-FfhP=vRQvposSxv=BMw@mail.gmail.com>
In-Reply-To: <CADnq5_OVSD1DXgi_9f_H-uT7KSjMwz-FfhP=vRQvposSxv=BMw@mail.gmail.com>
From: Mukul Sikka <mukul.sikka@broadcom.com>
Date: Fri, 6 Sep 2024 14:20:09 +0530
Message-ID: <CAG99D9Jss=h5aVLDq0tkDjfZgGUbrNV1gqwcw631RbwCiPVqNg@mail.gmail.com>
Subject: Re: [PATCH v5.15-v5.10] drm/amd/pm: Fix the null pointer dereference
 for vega10_hwmgr
To: Alex Deucher <alexdeucher@gmail.com>
Cc: stable@vger.kernel.org, gregkh@linuxfoundation.org, evan.quan@amd.com, 
	alexander.deucher@amd.com, christian.koenig@amd.com, airlied@linux.ie, 
	daniel@ffwll.ch, Jun.Ma2@amd.com, kevinyang.wang@amd.com, sashal@kernel.org, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, ajay.kaher@broadcom.com, 
	alexey.makhalov@broadcom.com, vasavi.sirnapalli@broadcom.com, 
	Bob Zhou <bob.zhou@amd.com>, Tim Huang <Tim.Huang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 12:05=E2=80=AFAM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> On Tue, Sep 3, 2024 at 5:53=E2=80=AFAM sikkamukul <mukul.sikka@broadcom.c=
om> wrote:
> >
> > From: Bob Zhou <bob.zhou@amd.com>
> >
> > [ Upstream commit 50151b7f1c79a09117837eb95b76c2de76841dab ]
> >
> > Check return value and conduct null pointer handling to avoid null poin=
ter dereference.
> >
> > Signed-off-by: Bob Zhou <bob.zhou@amd.com>
> > Reviewed-by: Tim Huang <Tim.Huang@amd.com>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > Signed-off-by: Mukul Sikka <mukul.sikka@broadcom.com>
>
> Just out of curiosity, are you actually seeing an issue?  This and a
> lot of the other recent NULL check patches are just static checker
> fixes.  They don't actually fix a known issue.
>
No, according to the description of this patch and CVE-2024-43905.
It seems to be applicable to LTS.

- Mukul

> > ---
> >  .../drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 30 ++++++++++++++++---
> >  1 file changed, 26 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/dr=
ivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> > index 10678b519..304874cba 100644
> > --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> > +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> > @@ -3391,13 +3391,17 @@ static int vega10_find_dpm_states_clocks_in_dpm=
_table(struct pp_hwmgr *hwmgr, co
> >         const struct vega10_power_state *vega10_ps =3D
> >                         cast_const_phw_vega10_power_state(states->pnew_=
state);
> >         struct vega10_single_dpm_table *sclk_table =3D &(data->dpm_tabl=
e.gfx_table);
> > -       uint32_t sclk =3D vega10_ps->performance_levels
> > -                       [vega10_ps->performance_level_count - 1].gfx_cl=
ock;
> >         struct vega10_single_dpm_table *mclk_table =3D &(data->dpm_tabl=
e.mem_table);
> > -       uint32_t mclk =3D vega10_ps->performance_levels
> > -                       [vega10_ps->performance_level_count - 1].mem_cl=
ock;
> > +       uint32_t sclk, mclk;
> >         uint32_t i;
> >
> > +       if (vega10_ps =3D=3D NULL)
> > +               return -EINVAL;
> > +       sclk =3D vega10_ps->performance_levels
> > +                       [vega10_ps->performance_level_count - 1].gfx_cl=
ock;
> > +       mclk =3D vega10_ps->performance_levels
> > +                       [vega10_ps->performance_level_count - 1].mem_cl=
ock;
> > +
> >         for (i =3D 0; i < sclk_table->count; i++) {
> >                 if (sclk =3D=3D sclk_table->dpm_levels[i].value)
> >                         break;
> > @@ -3704,6 +3708,9 @@ static int vega10_generate_dpm_level_enable_mask(
> >                         cast_const_phw_vega10_power_state(states->pnew_=
state);
> >         int i;
> >
> > +       if (vega10_ps =3D=3D NULL)
> > +               return -EINVAL;
> > +
> >         PP_ASSERT_WITH_CODE(!vega10_trim_dpm_states(hwmgr, vega10_ps),
> >                         "Attempt to Trim DPM States Failed!",
> >                         return -1);
> > @@ -4828,6 +4835,9 @@ static int vega10_check_states_equal(struct pp_hw=
mgr *hwmgr,
> >
> >         psa =3D cast_const_phw_vega10_power_state(pstate1);
> >         psb =3D cast_const_phw_vega10_power_state(pstate2);
> > +       if (psa =3D=3D NULL || psb =3D=3D NULL)
> > +               return -EINVAL;
> > +
> >         /* If the two states don't even have the same number of perform=
ance levels they cannot be the same state. */
> >         if (psa->performance_level_count !=3D psb->performance_level_co=
unt) {
> >                 *equal =3D false;
> > @@ -4953,6 +4963,8 @@ static int vega10_set_sclk_od(struct pp_hwmgr *hw=
mgr, uint32_t value)
> >                 return -EINVAL;
> >
> >         vega10_ps =3D cast_phw_vega10_power_state(&ps->hardware);
> > +       if (vega10_ps =3D=3D NULL)
> > +               return -EINVAL;
> >
> >         vega10_ps->performance_levels
> >         [vega10_ps->performance_level_count - 1].gfx_clock =3D
> > @@ -5004,6 +5016,8 @@ static int vega10_set_mclk_od(struct pp_hwmgr *hw=
mgr, uint32_t value)
> >                 return -EINVAL;
> >
> >         vega10_ps =3D cast_phw_vega10_power_state(&ps->hardware);
> > +       if (vega10_ps =3D=3D NULL)
> > +               return -EINVAL;
> >
> >         vega10_ps->performance_levels
> >         [vega10_ps->performance_level_count - 1].mem_clock =3D
> > @@ -5239,6 +5253,9 @@ static void vega10_odn_update_power_state(struct =
pp_hwmgr *hwmgr)
> >                 return;
> >
> >         vega10_ps =3D cast_phw_vega10_power_state(&ps->hardware);
> > +       if (vega10_ps =3D=3D NULL)
> > +               return;
> > +
> >         max_level =3D vega10_ps->performance_level_count - 1;
> >
> >         if (vega10_ps->performance_levels[max_level].gfx_clock !=3D
> > @@ -5261,6 +5278,9 @@ static void vega10_odn_update_power_state(struct =
pp_hwmgr *hwmgr)
> >
> >         ps =3D (struct pp_power_state *)((unsigned long)(hwmgr->ps) + h=
wmgr->ps_size * (hwmgr->num_ps - 1));
> >         vega10_ps =3D cast_phw_vega10_power_state(&ps->hardware);
> > +       if (vega10_ps =3D=3D NULL)
> > +               return;
> > +
> >         max_level =3D vega10_ps->performance_level_count - 1;
> >
> >         if (vega10_ps->performance_levels[max_level].gfx_clock !=3D
> > @@ -5451,6 +5471,8 @@ static int vega10_get_performance_level(struct pp=
_hwmgr *hwmgr, const struct pp_
> >                 return -EINVAL;
> >
> >         ps =3D cast_const_phw_vega10_power_state(state);
> > +       if (ps =3D=3D NULL)
> > +               return -EINVAL;
> >
> >         i =3D index > ps->performance_level_count - 1 ?
> >                         ps->performance_level_count - 1 : index;
> > --
> > 2.39.4
> >

