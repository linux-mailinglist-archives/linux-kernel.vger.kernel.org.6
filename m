Return-Path: <linux-kernel+bounces-261557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8383093B8F3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 00:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49DFD284AC9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 22:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4240313C820;
	Wed, 24 Jul 2024 22:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="ObyB5NXq"
Received: from mail-4027.protonmail.ch (mail-4027.protonmail.ch [185.70.40.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A113273440
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 22:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721858761; cv=none; b=Qx1qGQHdbbzaxDhLAoA+hececOqdNrLQOPthUBJHugWOaYP1ZL6Fjy60eBxvTwOEm/GsKKSsWml87RwVQ1uJMDvCmXjHDKwFLqD1PgvFyb2GGPd4Pc+E3i9XzVhP10iFakxmjzPiuCtFk3mbFzaWfNSyCC3hpAvfhEALhRe0hx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721858761; c=relaxed/simple;
	bh=crJA1OFpEuMLwju473bEThyxLq5AYQWHFQzciw/cp2U=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=e8P2HHb/uJVYVLSGMcluhNPQYNUxdRg2ORQ9FtPmbaGNsfu4IGJRX8Jle19ljcZjataob4juctKSuceQp/gaXQBrOWYscW/XS7d51yrtfe9jmysoI2WQMW2C7WgMJMdxFqfDBAOr6YM5CD4lYcY/Ehdt92Xv5gy6LhsWcg/FXWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=ObyB5NXq; arc=none smtp.client-ip=185.70.40.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1721858752; x=1722117952;
	bh=Ku5Kinv0bXpfAM8rUKfhniDPyYb2+o88Wn2r102s25A=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=ObyB5NXqc46rnOvEGYig8HGw2rHLfsPjEAVJCq7OCPyMc59iGA9a9olTCmQTnIE8V
	 MVEFq8zFfLlfojcYx9uh81FBphki0kZW6fC/snh2Y70SssM/dFemQfgNj8PHVyZgVf
	 F3x4iuQMg2hJTkpkmZ/FbiOONQhDpBF4j7QGiZPRFvuul9JX3m1boVNYpRKVuU2y8f
	 fOp3gO3nM/47YbPwPy+VlrYXf0eiIbhm965uDzzJb38huBPWQvgrjX3cRoHNqwvYkv
	 sN0fCFeZO8V7MQ8qReSDVnzqTkrjUMFMKtGMiMUVnL+SHZaODg/Wp56POKXY/rofOh
	 GN4mUjbMA/O1w==
Date: Wed, 24 Jul 2024 22:05:45 +0000
To: "airlied@gmail.com" <airlied@gmail.com>, "andy.yan@rock-chips.com" <andy.yan@rock-chips.com>, "daniel@ffwll.ch" <daniel@ffwll.ch>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "heiko@sntech.de" <heiko@sntech.de>, "hjc@rock-chips.com" <hjc@rock-chips.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>, "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>, "mripard@kernel.org" <mripard@kernel.org>, "tzimmermann@suse.de" <tzimmermann@suse.de>
From: Piotr Zalewski <pZ010001011111@proton.me>
Subject: [PATCH v3] rockchip/drm: vop2: add support for gamma LUT
Message-ID: <TkgKVivuaLFLILPY-n3iZo_8KF-daKdqdu-0_e0HP-5Ar_8DALDeNWog2suwWKjX7eomcbGET0KZe7DlzdhK2YM6CbLbeKeFZr-MJzJMtw0=@proton.me>
Feedback-ID: 53478694:user:proton
X-Pm-Message-ID: 569d9fa073fa2aff17121429bca20eed88154b0f
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Add support for gamma LUT in VOP2 driver. The implementation is based on
the one found in VOP driver and modified to be compatible with VOP2. Blue
and red channels in gamma LUT register write were swapped with respect to
how gamma LUT values are written in VOP. Write of the current video port id
to VOP2_SYS_LUT_PORT_SEL register was added before the write of DSP_LUT_EN
bit. Gamma size is set and drm color management is enabled for each video
port's CRTC except ones which have no associated device. Tested on RK3566
(Pinetab2).

Helped-by: Dragan Simic <dsimic@manjaro.org>
Signed-off-by: Piotr Zalewski <pZ010001011111@proton.me>
---

Notes:
    Changes in v3:
        - v3 is patch v2 "resend", by mistake the incremental patch were
        sent in v2

    Changes in v2:
        - Apply code styling corrections [1]
        - Move gamma LUT write inside the vop2 lock

    Link to v2: https://lore.kernel.org/linux-rockchip/Hk03HDb6wSSHWtEFZHUy=
e06HR0-9YzP5nCHx9A8_kHzWSZawDrU1o1pjEGkCOJFoRg0nTB4BWEv6V0XBOjF4-0Mj44lp2Tr=
jaQfnytzp-Pk=3D@proton.me/T/#u
    Link to v1: https://lore.kernel.org/linux-rockchip/9736eadf6a9d8e97eef9=
19c6b3d88828@manjaro.org/T/#t

    [1] https://lore.kernel.org/linux-rockchip/d019761504b540600d9fc7a585d6=
f95f@manjaro.org/

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm=
/rockchip/rockchip_drm_vop2.c
index 9873172e3fd3..37fcf544a5fd 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -278,6 +278,15 @@ static u32 vop2_readl(struct vop2 *vop2, u32 offset)
 =09return val;
 }

+static u32 vop2_vp_read(struct vop2_video_port *vp, u32 offset)
+{
+=09u32 val;
+
+=09regmap_read(vp->vop2->map, vp->data->offset + offset, &val);
+
+=09return val;
+}
+
 static void vop2_win_write(const struct vop2_win *win, unsigned int reg, u=
32 v)
 {
 =09regmap_field_write(win->reg[reg], v);
@@ -1482,6 +1491,95 @@ static bool vop2_crtc_mode_fixup(struct drm_crtc *cr=
tc,
 =09return true;
 }

+static bool vop2_vp_dsp_lut_is_enabled(struct vop2_video_port *vp)
+{
+=09return (u32) (vop2_vp_read(vp, RK3568_VP_DSP_CTRL) & RK3568_VP_DSP_CTRL=
__DSP_LUT_EN) >
+=09    0;
+}
+
+static void vop2_vp_dsp_lut_enable(struct vop2_video_port *vp)
+{
+=09u32 dsp_ctrl =3D vop2_vp_read(vp, RK3568_VP_DSP_CTRL);
+
+=09dsp_ctrl |=3D RK3568_VP_DSP_CTRL__DSP_LUT_EN;
+=09vop2_vp_write(vp, RK3568_VP_DSP_CTRL, dsp_ctrl);
+}
+
+static void vop2_vp_dsp_lut_disable(struct vop2_video_port *vp)
+{
+=09u32 dsp_ctrl =3D vop2_vp_read(vp, RK3568_VP_DSP_CTRL);
+
+=09dsp_ctrl &=3D ~RK3568_VP_DSP_CTRL__DSP_LUT_EN;
+=09vop2_vp_write(vp, RK3568_VP_DSP_CTRL, dsp_ctrl);
+}
+
+static void vop2_crtc_write_gamma_lut(struct vop2 *vop2, struct drm_crtc *=
crtc)
+{
+=09const struct vop2_video_port *vp =3D to_vop2_video_port(crtc);
+=09const struct vop2_video_port_data *vp_data =3D &vop2->data->vp[vp->id];
+
+=09struct drm_color_lut *lut =3D crtc->state->gamma_lut->data;
+=09unsigned int i, bpc =3D ilog2(vp_data->gamma_lut_len);
+=09u32 word;
+
+=09for (i =3D 0; i < crtc->gamma_size; i++) {
+=09=09word =3D (drm_color_lut_extract(lut[i].blue, bpc) << (2 * bpc)) |
+=09=09    (drm_color_lut_extract(lut[i].green, bpc) << bpc) |
+=09=09    drm_color_lut_extract(lut[i].red, bpc);
+
+=09=09writel(word, vop2->lut_regs + i * 4);
+=09}
+}
+
+static void vop2_crtc_gamma_set(struct vop2 *vop2, struct drm_crtc *crtc,
+=09=09=09=09struct drm_crtc_state *old_state)
+{
+=09struct drm_crtc_state *state =3D crtc->state;
+=09struct vop2_video_port *vp =3D to_vop2_video_port(crtc);
+=09u32 dsp_ctrl;
+=09int ret;
+
+=09if (!vop2->lut_regs)
+=09=09return;
+
+=09if (!state->gamma_lut) {
+=09=09/*
+=09=09 * To disable gamma (gamma_lut is null) or to write
+=09=09 * an update to the LUT, clear dsp_lut_en.
+=09=09 */
+=09=09vop2_lock(vop2);
+
+=09=09vop2_vp_dsp_lut_disable(vp);
+
+=09=09vop2_cfg_done(vp);
+=09=09vop2_unlock(vop2);
+=09=09/*
+=09=09 * In order to write the LUT to the internal memory,
+=09=09 * we need to first make sure the dsp_lut_en bit is cleared.
+=09=09 */
+=09=09ret =3D readx_poll_timeout(vop2_vp_dsp_lut_is_enabled, vp, dsp_ctrl,
+=09=09=09=09!dsp_ctrl, 5, 30 * 1000);
+
+=09=09if (ret) {
+=09=09=09DRM_DEV_ERROR(vop2->dev, "display LUT RAM enable timeout!\n");
+=09=09=09return;
+=09=09}
+
+=09=09if (!state->gamma_lut)
+=09=09=09return;
+=09}
+
+
+=09vop2_lock(vop2);
+=09vop2_crtc_write_gamma_lut(vop2, crtc);
+=09vop2_writel(vp->vop2, RK3568_LUT_PORT_SEL, vp->id);
+
+=09vop2_vp_dsp_lut_enable(vp);
+
+=09vop2_cfg_done(vp);
+=09vop2_unlock(vop2);
+}
+
 static void vop2_dither_setup(struct drm_crtc *crtc, u32 *dsp_ctrl)
 {
 =09struct rockchip_crtc_state *vcstate =3D to_rockchip_crtc_state(crtc->st=
ate);
@@ -1925,6 +2023,7 @@ static void vop2_crtc_atomic_enable(struct drm_crtc *=
crtc,
 =09const struct vop2_data *vop2_data =3D vop2->data;
 =09const struct vop2_video_port_data *vp_data =3D &vop2_data->vp[vp->id];
 =09struct drm_crtc_state *crtc_state =3D drm_atomic_get_new_crtc_state(sta=
te, crtc);
+=09struct drm_crtc_state *old_state =3D drm_atomic_get_old_crtc_state(stat=
e, crtc);
 =09struct rockchip_crtc_state *vcstate =3D to_rockchip_crtc_state(crtc->st=
ate);
 =09struct drm_display_mode *mode =3D &crtc->state->adjusted_mode;
 =09unsigned long clock =3D mode->crtc_clock * 1000;
@@ -2060,6 +2159,9 @@ static void vop2_crtc_atomic_enable(struct drm_crtc *=
crtc,
 =09drm_crtc_vblank_on(crtc);

 =09vop2_unlock(vop2);
+
+=09if (crtc->state->gamma_lut)
+=09=09vop2_crtc_gamma_set(vop2, crtc, old_state);
 }

 static int vop2_crtc_atomic_check(struct drm_crtc *crtc,
@@ -2070,6 +2172,16 @@ static int vop2_crtc_atomic_check(struct drm_crtc *c=
rtc,
 =09int nplanes =3D 0;
 =09struct drm_crtc_state *crtc_state =3D drm_atomic_get_new_crtc_state(sta=
te, crtc);

+=09if (vp->vop2->lut_regs && crtc_state->color_mgmt_changed && crtc_state-=
>gamma_lut) {
+=09=09unsigned int len =3D drm_color_lut_size(crtc_state->gamma_lut);
+
+=09=09if (len !=3D crtc->gamma_size) {
+=09=09=09DRM_DEBUG_KMS("Invalid LUT size; got %d, expected %d\n",
+=09=09=09=09      len, crtc->gamma_size);
+=09=09=09return -EINVAL;
+=09=09}
+=09}
+
 =09drm_atomic_crtc_state_for_each_plane(plane, crtc_state)
 =09=09nplanes++;

@@ -2459,6 +2571,10 @@ static void vop2_setup_dly_for_windows(struct vop2 *=
vop2)
 static void vop2_crtc_atomic_begin(struct drm_crtc *crtc,
 =09=09=09=09   struct drm_atomic_state *state)
 {
+=09struct drm_crtc_state *crtc_state =3D drm_atomic_get_new_crtc_state(sta=
te,
+=09=09=09=09=09=09=09=09=09  crtc);
+=09struct drm_crtc_state *old_crtc_state =3D drm_atomic_get_old_crtc_state=
(state,
+=09=09=09=09=09=09=09=09=09      crtc);
 =09struct vop2_video_port *vp =3D to_vop2_video_port(crtc);
 =09struct vop2 *vop2 =3D vp->vop2;
 =09struct drm_plane *plane;
@@ -2482,6 +2598,9 @@ static void vop2_crtc_atomic_begin(struct drm_crtc *c=
rtc,
 =09vop2_setup_layer_mixer(vp);
 =09vop2_setup_alpha(vp);
 =09vop2_setup_dly_for_windows(vop2);
+
+=09if (crtc_state->color_mgmt_changed && !crtc_state->active_changed)
+=09=09vop2_crtc_gamma_set(vop2, crtc, old_crtc_state);
 }

 static void vop2_crtc_atomic_flush(struct drm_crtc *crtc,
@@ -2791,6 +2910,14 @@ static int vop2_create_crtcs(struct vop2 *vop2)

 =09=09drm_crtc_helper_add(&vp->crtc, &vop2_crtc_helper_funcs);

+=09=09if (vop2->lut_regs && vp->crtc.dev !=3D NULL) {
+=09=09=09const struct vop2_video_port_data *vp_data =3D &vop2_data->vp[vp-=
>id];
+
+=09=09=09drm_mode_crtc_set_gamma_size(&vp->crtc, vp_data->gamma_lut_len);
+=09=09=09drm_crtc_enable_color_mgmt(&vp->crtc, 0, false,
+=09=09=09=09=09=09   vp_data->gamma_lut_len);
+=09=09}
+
 =09=09init_completion(&vp->dsp_hold_completion);
 =09}

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h b/drivers/gpu/drm=
/rockchip/rockchip_drm_vop2.h
index 615a16196aff..3a58b73fa876 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
@@ -394,6 +394,7 @@ enum dst_factor_mode {
 #define RK3568_REG_CFG_DONE__GLB_CFG_DONE_EN=09=09BIT(15)

 #define RK3568_VP_DSP_CTRL__STANDBY=09=09=09BIT(31)
+#define RK3568_VP_DSP_CTRL__DSP_LUT_EN=09=09=09BIT(28)
 #define RK3568_VP_DSP_CTRL__DITHER_DOWN_MODE=09=09BIT(20)
 #define RK3568_VP_DSP_CTRL__DITHER_DOWN_SEL=09=09GENMASK(19, 18)
 #define RK3568_VP_DSP_CTRL__DITHER_DOWN_EN=09=09BIT(17)

