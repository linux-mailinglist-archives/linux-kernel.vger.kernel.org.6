Return-Path: <linux-kernel+bounces-266466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C47940043
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 23:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7143B282F5B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 21:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CCE018D4A2;
	Mon, 29 Jul 2024 21:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="faQ3z3mC"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6BE80038
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 21:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722288055; cv=none; b=EJyd8zAEXG5OlR1ZJlh0McvWFPQSvhFjaHr9nd4quww95zj21ugQelrcJi9TiVQjn9k0WfM4SSuvHc1abD28u8tyjwE1YbI8oqCx8FFxcOiBxk4cA7wUcfOURQaflGzI4HBOlJQVwZ/xI3hEI71crKdk9Are7rinpfwXB6KpMNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722288055; c=relaxed/simple;
	bh=Vv1ykBNQQnPAGGtg/KXFza4yZXukf6aSfyRlDM0QQIw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bkcCcXbLsSWCvaddLhkuF8ucd2DX5BhUEePLJx9VHyFW15oukCUwvTrZzdxMyJNt9hcZZyaiP2rs37ZWFVpCa5NdBJRbki+8Gchjcd81rwqT4knMIpMEit1/H+zgMCoSwPINyeMoI6v3aPnHfTT0x0OG3CA9fSd8hbWbuvzhdPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=faQ3z3mC; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1722288051; x=1722547251;
	bh=JPubHYzdmcE9DV8QqhlyGjO/AODrdpWCvyvc9CcrJfY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=faQ3z3mC59AKTQSEqrmsGAPRQ5IFPQ6+Dv78q2NP0o1XkEm0w1LXDBSnFh/ezLqk4
	 RWJFBTMaQ13vu+yy7+4AXtApK7SZYEarCfs0t452wKZLbTCx3wAr3y94U6HPM3uStz
	 JuoRJ9IcKUapmLqcjhTypGyo6CcHsMimM8UPGcfBdv2Y6062Z4WXB+XmktIf73X9Js
	 11V1N2nGTEu28U3cvsX3MRjQYNY0NkmbEsPyyQgWFUCwwqfF9b7J86ck95f5kPjJor
	 M6qF28cagSUtJaSmfwyrrQ+mvAXpT/AzRrglslg7xSeNfedSj+sL5PxEzRc2x5Z8NP
	 /UTLEZ0HyPUcg==
Date: Mon, 29 Jul 2024 21:20:45 +0000
To: Andy Yan <andy.yan@rock-chips.com>
From: Piotr Zalewski <pZ010001011111@proton.me>
Cc: "airlied@gmail.com" <airlied@gmail.com>, "daniel@ffwll.ch" <daniel@ffwll.ch>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "heiko@sntech.de" <heiko@sntech.de>, "hjc@rock-chips.com" <hjc@rock-chips.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>, "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>, "mripard@kernel.org" <mripard@kernel.org>, "tzimmermann@suse.de" <tzimmermann@suse.de>
Subject: Re: [PATCH v3] rockchip/drm: vop2: add support for gamma LUT
Message-ID: <y_bpV0FizWkAqq0XPIKrauaZ07r_Ds-MnDr696Y1qFTLNiLsx7pL4C-Zsu-K9TzVBJ85L5cdkzDQOExcXXTf0owUYramMHdZd4erMRpJUXI=@proton.me>
In-Reply-To: <48249708-8c05-40d2-a5d8-23de960c5a77@rock-chips.com>
References: <TkgKVivuaLFLILPY-n3iZo_8KF-daKdqdu-0_e0HP-5Ar_8DALDeNWog2suwWKjX7eomcbGET0KZe7DlzdhK2YM6CbLbeKeFZr-MJzJMtw0=@proton.me> <ec283a7c-845b-4c58-8d86-cdd07862a0dc@rock-chips.com> <KbOjWzFKMM_fwDora8CjaLFBHWypRP1Mk6nPzHkwNAGxFHzJIynx3W8_jyZvbygH99lRAXDdrJmdFEQuY8M2Ao-a8F42zt8no4B1DCBiQIs=@proton.me> <48249708-8c05-40d2-a5d8-23de960c5a77@rock-chips.com>
Feedback-ID: 53478694:user:proton
X-Pm-Message-ID: 519082746c86342059362fada372d3e721229ce1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Andy

On Monday, July 29th, 2024 at 4:35 AM, Andy Yan <andy.yan@rock-chips.com> w=
rote:

> > > > +
> > > > +static void vop2_crtc_gamma_set(struct vop2 *vop2, struct drm_crtc=
 *crtc,
> > > > + struct drm_crtc_state *old_state)
> > > > +{
> > > > + struct drm_crtc_state *state =3D crtc->state;
> > > > + struct vop2_video_port *vp =3D to_vop2_video_port(crtc);
> > > > + u32 dsp_ctrl;
> > > > + int ret;
> > > > +
> > > > + if (!vop2->lut_regs)
> > > > + return;
> > > > +
> > > > + if (!state->gamma_lut) {
> > >
> > > What's the purpose of checking !state->gamma_lut here,
> > >
> > > and you check it again at the end for return.
> > > This makes me very confused.
> >
> > I understood it this way - since the vop2 lock is unlocked after disabl=
ing
> > gamma LUT, the CRTC state can change while waiting for DSP_LUT_EN bit t=
o
> > be unset. With the change I sent in response to Daniel's reply, gamma L=
UT
> > state modification should now be fully atomic so there shouldn't be a n=
eed
> > for the second state check there anymore (if my logic is incorrect plea=
se
> > explain).
>
>
> After reading the commit message for adding gamma control for rk3399[0] i=
 understand
> what is going on here:
>
> we should run into the if block in two cases:
>
> (1) if the state->gamma_lut is null, we just need to disable dsp_lut and =
return,
>
> this is why vop1 code check !state->gamma_lut again at the end.
>
> (2) for platform unlinke rk3399(rk3566/8), we also need to disable dsp_lu=
t befor we
> write gamma_lut data, for platform like rk3399(rk3588), we don't need do =
the disable,
> this is why vop1 code also has a !VOP_HAS_REG(vop, common, update_gamma_l=
ut) check.
>
> so we also need a similary check here:
> (1) if the state->gamma_lut is null, disable dsp lut and return directly.
>
> (1) if the state has a gamma_lut, we shoud dsiable dsp_lut than write gam=
ma lut data on rk3566/8,
> buf for rk3588, we should not disable dsp_lut before write gamma
>
>
> [0]https://lists.infradead.org/pipermail/linux-rockchip/2021-October/0281=
32.html
>

Ok I see it. So In my patch it doesn't make sense at all to check it again
(forgot about that extra if statement condition there, which I cut out=20
when porting to VOP2). I reworked my patch further for it to handle RK3588=
=20
case and to better utilize DRM atomic updates. It's contained in the=20
response to Daniel's review [1]. I experienced some problems so I'm waiting=
=20
for his response/comment on that.

Regarding RK3588, I checked RK3588 TRM v1.0 part2. In its VOP2 section I=20
found:
  - SYS_CTRL_LUT_PORT_SEL: gamma_ahb_write_sel (seems to represent the=20
    same concept as LUT_PORT_SEL in case of RK356x)
  - VOP2_POST0_DSP_CTRL: gamma_update_en (seems to represent the same=20
    concept as in VOP1 in case of RK3399)
  - I also found dsp_lut_en but I presume it is a bug in documentation.

Should RK3588 be handled as RK3399? (gamma LUT can be written directly but=
=20
gamma_update_en bit has to be set before). What about gamma_ahb_write_sel?
=20
[1] https://lkml.org/lkml/2024/7/27/293

Best Regards, Piotr Zalewski

