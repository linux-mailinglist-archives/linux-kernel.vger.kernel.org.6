Return-Path: <linux-kernel+bounces-367673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B00BD9A0537
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 11:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D51E51C23845
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 09:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251351CC8AB;
	Wed, 16 Oct 2024 09:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="OwIqEw0o"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A8318C340
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 09:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729070228; cv=none; b=she4aS1qC+dUBEuZU9pzB6REbq6Etz/w8VpucuTAKyc1Sw+54J8SgrVVaf1vVp4zxQZ+nLTT8iwIBCSnjrEzT90QX4AG4BeuPycq+W4d9vbJh1sQ0MTcHfj7wEteFZnJvk/t7+Q64mNfaxdlx1lHsy4WBvuXWuiIVwRwA5nktzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729070228; c=relaxed/simple;
	bh=IIdP8N4KQ/tEiy6MwyXh62Fj0dF3hmgc69ZxFphSU6Y=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rJi1jXw205V+aX3Zkilv3Yuq5My+QbnSSJ82et1lVy/bot18wpClSJtd3EiUizJjTJYZxmvAh1uOMshyjH1PMccHTr6gXXFuDz/qBbmuq8JhZ96mOe/xGzIeJfo8BGTwKXqN/uLxlafNmVm8qYTi0+QZk3Tdyfd+m64ym12iq6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=OwIqEw0o; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1729070223; x=1729329423;
	bh=IIdP8N4KQ/tEiy6MwyXh62Fj0dF3hmgc69ZxFphSU6Y=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=OwIqEw0oZ4t7WB0wouqU7K4VoJ1kS9XdsUiHb6CmsGeAtQ0t/BndXaxDxSSFTFN5P
	 e377u1aXIAodESsoORfYVFaY8MyueRmw30DDdBWtG3FccUYjcr6OSvtjFy0dj3QT5J
	 1AjBhywIwVL1tgrcPTIHjJLmDyqguv1dhuXFSIZHFv0ptCE3fHjiqeae9EzKblYb5r
	 rpEQ34Wh+xjppbIDuNesKcfGPmjvXT6k0BTzn+8uDpmVBVUjUsoc+LAuujDlshqZWl
	 6KCHlQ42gk5tSgG9HOJXqJd3/YKQemljPYXKD1aI+KvNj7oiY7AHSdeLsp/0SlH3iw
	 fDCAwccF0Xfow==
Date: Wed, 16 Oct 2024 09:16:56 +0000
To: Andy Yan <andyshrk@163.com>
From: Piotr Zalewski <pZ010001011111@proton.me>
Cc: hjc@rock-chips.com, heiko@sntech.de, andy.yan@rock-chips.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, Daniel Stone <daniel@fooishbar.org>, Dragan Simic <dsimic@manjaro.org>, Diederik de Haas <didi.debian@cknow.org>
Subject: Re:Re:Re:[PATCH v5] rockchip/drm: vop2: add support for gamma LUT
Message-ID: <QvjHFQ4xeCu-8Isrm_jtNRWLowVNFzC8qnHJ6LUGI2iFTTJoEK8fBrXjG9LUrn5Wt9fJ9F04ukEf-koifwCR0uH9nr0AelyiWI85KASNkOQ=@proton.me>
In-Reply-To: <1ae9f15d.e52.19292e05e73.Coremail.andyshrk@163.com>
References: <20241014222022.571819-4-pZ010001011111@proton.me> <7b45f190.452f.1928e41b746.Coremail.andyshrk@163.com> <o_Cyz_ARcHj4zNlovv75MBwslIRhn3YWlscoNrlpLVobh7eWIMEQR5bNv0yhHx2KEx_gbYi_gH-8Y-CdvRZs9lZscz3-lhAbM50GXUdtSKY=@proton.me> <30940542.b36d.19290215124.Coremail.andyshrk@163.com> <1974DYrs9gLrQrZ5VwCglFgKDDK686iyqnS_g6uPB-s9wZ_4CqfZXPjmYWihLgrkRu7ptNjpkFeqB0uTt73RFId6cL8FowQ8LFltPmaKCoI=@proton.me> <1ae9f15d.e52.19292e05e73.Coremail.andyshrk@163.com>
Feedback-ID: 53478694:user:proton
X-Pm-Message-ID: bd4fcee4497191b7dd8a0ab9b0a41400e663f077
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Wednesday, October 16th, 2024 at 3:10 AM, Andy Yan <andyshrk@163.com> wr=
ote:

> Hi Piotr,
>=20
> At 2024-10-16 04:13:40, "Piotr Zalewski" pZ010001011111@proton.me wrote:
>=20
> > Hi Andy
> >=20
> > On Tuesday, October 15th, 2024 at 2:22 PM, Andy Yan andyshrk@163.com wr=
ote:
> >=20
> > > > > > + struct vop2_video_port *vp,
> > > > > > + struct drm_crtc *crtc,
> > > > > > + struct drm_crtc_state *crtc_state)
> > > > > > +{
> > > > > > +
> > > > > > + if (vop2->lut_regs && crtc_state->color_mgmt_changed) {
> > > > > > + if (!crtc_state->gamma_lut) {
> > > > > > + vop2_vp_dsp_lut_disable(vp);
> > > > > > + return;
> > > > > > + }
> > > > > > +
> > > > > > + if (vop2_supports_seamless_gamma_lut_update(vop2)) {
> > > > >=20
> > > > > I think it's bettery to check for rk3568/rk3566 here, the newer s=
oc will all follow
> > > > > rk3588 support seamless gamma lut update.
> > > >=20
> > > > I will change in the next version.
> > > >=20
> > > > > > + vop2_writel(vop2, RK3568_LUT_PORT_SEL, FIELD_PREP(
> > > > > > + RK3588_LUT_PORT_SEL__GAMMA_AHB_WRITE_SEL,
> > > > > > + vp->id));
> > > > > > + vop2_crtc_write_gamma_lut(vop2, crtc);
> > > > > > + vop2_vp_dsp_lut_enable(vp);
> > > > > > + vop2_vp_dsp_lut_update_enable(vp);
> > > > > > + } else {
> > > > >=20
> > > > > As for rk3566/68, we should do exclusive check here, because ther=
e is only
> > > > > one gamma , only one VP can use it at a time. See my comments in =
V3:
> > > >=20
> > > > What do you mean exactly by exclusive check in this case.It's true =
that
> > > > gamma LUT is shared across video ports in rk356x but, if I correctl=
y
> > > > understand, this doesn't forbid to reprogram LUT port sel and allow=
 other
> > > > VP to use gamma LUT.
> > >=20
> > > Yes, we can reprogram LUT port sel, but we need to make sure the the =
dsp_lut_en bit in VPx is cleared if we
> > > want reprogram LUT port sel form VPx to VPy.
> >=20
> > Ok I get it now. Is such rework correct? - when gamma LUT for rk356x is
> > being set, instead of disabling the LUT before the gamma LUT write for =
the
> > current CRTC's video port, active video port is selected. Selection is
> > based on if DSP LUT EN bit is set for particular video port. eg:
>=20
>=20
> If the userspace want to set gamma for CRTCx, then that is indeed where t=
hey want to set the
> gamma on=E3=80=82The driver silently sets the gamma on another CRTC, whic=
h is not what the user wants.
>=20
> I think there are two options=EF=BC=9A
> =EF=BC=881=EF=BC=89return a error if gamma is enable on other CRTC=
=EF=BC=8C this is what we done in our BSP code[1]
> (2) disable the dsp_lut on privious CRTC, then switch to the current CRTC=
 which userspace wants.
>=20
> [1]https://github.com/armbian/linux-rockchip/blob/rk3576-6.1-dev-2024_04_=
19/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c#L3666

When I think about it, userspace tools set gamma LUT for all
active CRTCs with gamma LUT support[2] so essentially when there is only=20
one which can be active implicitly (like in the case of rk356x) in BSP code=
=20
you provided[1], it will go with the first one and in the second approach=
=20
it will end up setting second one in the end. I think this=20
solution[1] is better if assumed that first CRTC is always "main" one.

I will rework it to[1] and test it. (Have to check if hdmi out on pt2 works=
).

[2] https://gitlab.com/chinstrap/gammastep/-/blob/master/src/gamma-drm.c?re=
f_type=3Dheads#L261

> > ```
> > static struct vop2_video_port *vop2_vp_dsp_lut_get_active_vp(struct vop=
2 *vop2)
> > {
> > struct vop2_video_port *vp;
> > int i;
> > for (i =3D 0; i < vop2->data->nr_vps; i++) {
> > vp =3D &vop2->vps[i];
> >=20
> > if (vp->crtc.dev !=3D NULL && vop2_vp_dsp_lut_is_enabled(vp)) {
> > return vp;
> > }
> > }
> > return NULL;
> > }
> >=20
> > (...)
> >=20
> > struct vop2_video_port *active_vp =3D vop2_vp_dsp_lut_get_active_vp(vop=
2);
> >=20
> > if (active_vp) {
> > vop2_vp_dsp_lut_disable(active_vp);
> > vop2_cfg_done(active_vp);
> > if (!vop2_vp_dsp_lut_poll_disable(active_vp))
> > return;
> > }
> >=20
> > vop2_writel(vop2, RK3568_LUT_PORT_SEL, vp->id);
> > vop2_crtc_write_gamma_lut(vop2, crtc);
> > vop2_vp_dsp_lut_enable(vp);
> > ```

Best regards, Piotr Zalewski

