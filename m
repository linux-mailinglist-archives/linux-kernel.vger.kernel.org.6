Return-Path: <linux-kernel+bounces-366626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF2F99F7F9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 22:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5EBB1F22313
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 20:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741181F76D2;
	Tue, 15 Oct 2024 20:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="N3q2vmdC"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE261F6695
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 20:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729023244; cv=none; b=J3xCZVZB2krl9AoBmaMRJGcS7OQgVDtQ3LxsLRPw3Dvx1W2Ah6aba59kXhlO67+vqPk2nuqZlxS3v9/6Mbkftj8ENTB89iPgEjgcRquYqTi9MD9Y+KhwHIo0LUPvydvSAZsrR+fb8VnRwzmKR9h4HMxgL3YQ8hHHUKgXestCPqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729023244; c=relaxed/simple;
	bh=oWZAEWmWn11pICS2WghDTqvtxTlwbis+AKwY8WLaaII=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VnSUollL4Qdi88C6ljSUNYSilijhfFTf4cpaR2h9KBSnT1MdFkkUiqRv48ZEeoCGqTWmO6/a39RKSGrf7+abeGD8oXgrnD1Hd201twSxFeyC8DARJE1I1L1jsNBx1W/QbtkmaMz0U1bT1An/+47N5EebpGCGmU7o+YVUc6p1F1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=N3q2vmdC; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1729023234; x=1729282434;
	bh=oWZAEWmWn11pICS2WghDTqvtxTlwbis+AKwY8WLaaII=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=N3q2vmdCHEAzWfagD0SM+pZXcpUTWCzquQH0AbCpxZsxZolcyASpe6qALHsApCvzz
	 fMmbnbAxPk3OpMQBg5kjZKRlUVT49Kd/Yo08Q9Ny5sUbUV0jX9/xbWDIH3tL8n291d
	 GAMWj0pFpnMrQnKbeDuJFNEUkr5rlR5ZRPux5cGyrqkeEjOoHsWKg7p+hWerSWt+iS
	 RLx/sOeAee0DWR6ZDooP1b3G1A3Obq6adcwyK8XftOREDpCrmc2x7Ylg2F9IWTRvuB
	 NE/ltpZ+2dtazvzEWM4MYLC1UXGVADuQFVyrzLmaUGomvY7xeB1oTT/xo/U4P0Btk5
	 rjcTlzl9Bso6Q==
Date: Tue, 15 Oct 2024 20:13:40 +0000
To: Andy Yan <andyshrk@163.com>
From: Piotr Zalewski <pZ010001011111@proton.me>
Cc: hjc@rock-chips.com, heiko@sntech.de, andy.yan@rock-chips.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, Daniel Stone <daniel@fooishbar.org>, Dragan Simic <dsimic@manjaro.org>, Diederik de Haas <didi.debian@cknow.org>
Subject: Re:Re:[PATCH v5] rockchip/drm: vop2: add support for gamma LUT
Message-ID: <1974DYrs9gLrQrZ5VwCglFgKDDK686iyqnS_g6uPB-s9wZ_4CqfZXPjmYWihLgrkRu7ptNjpkFeqB0uTt73RFId6cL8FowQ8LFltPmaKCoI=@proton.me>
In-Reply-To: <30940542.b36d.19290215124.Coremail.andyshrk@163.com>
References: <20241014222022.571819-4-pZ010001011111@proton.me> <7b45f190.452f.1928e41b746.Coremail.andyshrk@163.com> <o_Cyz_ARcHj4zNlovv75MBwslIRhn3YWlscoNrlpLVobh7eWIMEQR5bNv0yhHx2KEx_gbYi_gH-8Y-CdvRZs9lZscz3-lhAbM50GXUdtSKY=@proton.me> <30940542.b36d.19290215124.Coremail.andyshrk@163.com>
Feedback-ID: 53478694:user:proton
X-Pm-Message-ID: 932c22f934c19cba4c98a2e1488d80d40e7faf7a
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Andy

On Tuesday, October 15th, 2024 at 2:22 PM, Andy Yan <andyshrk@163.com> wrot=
e:

> > > > + struct vop2_video_port *vp,
> > > > + struct drm_crtc *crtc,
> > > > + struct drm_crtc_state *crtc_state)
> > > > +{
> > > > +
> > > > + if (vop2->lut_regs && crtc_state->color_mgmt_changed) {
> > > > + if (!crtc_state->gamma_lut) {
> > > > + vop2_vp_dsp_lut_disable(vp);
> > > > + return;
> > > > + }
> > > > +
> > > > + if (vop2_supports_seamless_gamma_lut_update(vop2)) {
> > >=20
> > > I think it's bettery to check for rk3568/rk3566 here, the newer soc w=
ill all follow
> > > rk3588 support seamless gamma lut update.
> >=20
> > I will change in the next version.
> >=20
> > > > + vop2_writel(vop2, RK3568_LUT_PORT_SEL, FIELD_PREP(
> > > > + RK3588_LUT_PORT_SEL__GAMMA_AHB_WRITE_SEL,
> > > > + vp->id));
> > > > + vop2_crtc_write_gamma_lut(vop2, crtc);
> > > > + vop2_vp_dsp_lut_enable(vp);
> > > > + vop2_vp_dsp_lut_update_enable(vp);
> > > > + } else {
> > >=20
> > > As for rk3566/68, we should do exclusive check here, because there is=
 only
> > > one gamma , only one VP can use it at a time. See my comments in V3:
> >=20
> > What do you mean exactly by exclusive check in this case.It's true that
> > gamma LUT is shared across video ports in rk356x but, if I correctly
> > understand, this doesn't forbid to reprogram LUT port sel and allow oth=
er
> > VP to use gamma LUT.
>=20
>=20
> Yes, we can reprogram LUT port sel, but we need to make sure the the dsp_=
lut_en bit in VPx is cleared if we
> want reprogram LUT port sel form VPx to VPy.
>=20

Ok I get it now. Is such rework correct? - when gamma LUT for rk356x is
being set, instead of disabling the LUT before the gamma LUT write for the
current CRTC's video port, active video port is selected. Selection is=20
based on if DSP LUT EN bit is set for particular video port. eg:
```
static struct vop2_video_port *vop2_vp_dsp_lut_get_active_vp(struct vop2 *v=
op2)
{
=09struct vop2_video_port *vp;
=09int i;
=09for (i =3D 0; i < vop2->data->nr_vps; i++) {
=09=09vp =3D &vop2->vps[i];

=09=09if (vp->crtc.dev !=3D NULL && vop2_vp_dsp_lut_is_enabled(vp)) {
=09=09=09return vp;
=09=09}
=09}
=09return NULL;
}

(...)

struct vop2_video_port *active_vp =3D vop2_vp_dsp_lut_get_active_vp(vop2);

if (active_vp) {
=09vop2_vp_dsp_lut_disable(active_vp);
=09vop2_cfg_done(active_vp);
=09if (!vop2_vp_dsp_lut_poll_disable(active_vp))
=09=09return;
}

vop2_writel(vop2, RK3568_LUT_PORT_SEL, vp->id);
vop2_crtc_write_gamma_lut(vop2, crtc);
vop2_vp_dsp_lut_enable(vp);
```


> > > >=20
> > > > drm_crtc_helper_add(&vp->crtc, &vop2_crtc_helper_funcs);
> > > > + if (vop2->lut_regs && vp->crtc.dev !=3D NULL) {
> > > > + const struct vop2_video_port_data *vp_data =3D &vop2_data->vp[vp-=
>id];
> > > >=20
> > > > + drm_mode_crtc_set_gamma_size(&vp->crtc, vp_data->gamma_lut_len);
> > > > + drm_crtc_enable_color_mgmt(&vp->crtc, 0, false,
> > > > + vp_data->gamma_lut_len);
> > >=20
> > > It seems that we can keep it in one line, the default limit of linux =
kernel coding style is 100 characters now.
> >=20
> > Thanks. I didn't know, I will amend it.
>=20
>=20
> See bdc48fa11e46("checkpatch/coding-style: deprecate 80-column warning")
>=20

Interesting.

Best regards, Piotr Zalewski

