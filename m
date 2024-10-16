Return-Path: <linux-kernel+bounces-368841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 320959A158B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 00:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB1781F2287E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 22:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE611D278B;
	Wed, 16 Oct 2024 22:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="YZNJi6NI"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28EA18732A
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 22:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729116302; cv=none; b=pYYjAF0CfgoqtEfl3utq7b7h6TagnN69tSZ09ARhQTOq1cjdJ0Vfh09V8RYYxeHP/jjC5v6HupcoI/eFbQedR9DCvHXVJgYYyEAJfhsaG7t9K20YPHdR0ViJ+OryVsWJzy4nGEQmNWu3NE2hvwUrbwxX94Z5hHR29hFqQ6Z4y4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729116302; c=relaxed/simple;
	bh=otJbHyZujNBalaTmidGF7B0oyofrDrA0kk+tMXiuG/s=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PMhMho8C2ZUXGCve1j0JRFwJOmxoj6dDCL0tpVdz99DEeV/zdXoxwxFZ0D7rXCKHSEO63xbK5Cd8QUCzkgCGp3zt5nlJ481yfE6ZbsonhfZ+m8kEHwam7s0EHc1CkWWitzF5Hbb9COclKytXi9XeyiDF6n8vspikoviAZkcMaUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=YZNJi6NI; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1729116291; x=1729375491;
	bh=otJbHyZujNBalaTmidGF7B0oyofrDrA0kk+tMXiuG/s=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=YZNJi6NI5uCjD1Kuu2PpS3Ieh1Zh06zEO3pEMXQfwiMmQ2rsIZQ6p7qO8nvrmfL89
	 gu2Wvgmyg34MyeWwuq6CBcJcC08bxC6J7ONvmjPq3LiYmq5M3aqw2IXgB4Sp4XRdqp
	 Vj6YeH60MTXk4pTyv7SUhxPdoErnwttSJm/FyPSNs4tM94SFKUt9q2ZngbFL8T9gt4
	 VUTZG8bdKCGY06yI7t2xQhz3I7+S5pkhd617unvm0hZoF6nWGaHpmYgR3HOctqLJLU
	 rB1eSaSWjLtjojHXuOoRRCcdZIq2oAlfPV0983dje0NqIn+0deFw2Go5wejuADSXsH
	 UwF0LeKUpu3lg==
Date: Wed, 16 Oct 2024 22:04:47 +0000
To: Andy Yan <andyshrk@163.com>
From: Piotr Zalewski <pZ010001011111@proton.me>
Cc: hjc@rock-chips.com, heiko@sntech.de, andy.yan@rock-chips.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, Daniel Stone <daniel@fooishbar.org>, Dragan Simic <dsimic@manjaro.org>, Diederik de Haas <didi.debian@cknow.org>
Subject: Re:[PATCH v5] rockchip/drm: vop2: add support for gamma LUT
Message-ID: <qQ8K1eMN92mXXKiHVEiv4sUKmuXirPwokVQJRMsoMu4SmeW5OksIhhsx7P2MCymkWJeyAqX_YSvg-iUbP3Njt7XHHDXAqIRxtKmwoBkfRYA=@proton.me>
In-Reply-To: <bDA4Uh6mp04Po1miJIueRsMNZ9W09DHEnRjG4CzWBn243gI_ExYhjwC9j-KMgOvUS5ofKsAa926IGfVGz4fNt9P_kOBpTyIOakgbB9Sqc-4=@proton.me>
References: <20241014222022.571819-4-pZ010001011111@proton.me> <13fc0084.1321.19292eec34e.Coremail.andyshrk@163.com> <bDA4Uh6mp04Po1miJIueRsMNZ9W09DHEnRjG4CzWBn243gI_ExYhjwC9j-KMgOvUS5ofKsAa926IGfVGz4fNt9P_kOBpTyIOakgbB9Sqc-4=@proton.me>
Feedback-ID: 53478694:user:proton
X-Pm-Message-ID: 9bf1c476827f42656380d0b9b801739f99b648d3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Andy

On Wednesday, October 16th, 2024 at 11:23 AM, Piotr Zalewski <pZ01000101111=
1@proton.me> wrote:

> > > static void vop2_crtc_atomic_flush(struct drm_crtc *crtc,
> > > @@ -2790,7 +2945,13 @@ static int vop2_create_crtcs(struct vop2 *vop2=
)
> > > }
> > >=20
> > > drm_crtc_helper_add(&vp->crtc, &vop2_crtc_helper_funcs);
> > > + if (vop2->lut_regs && vp->crtc.dev !=3D NULL) {
> >=20
> > There is no need to check vp->crtc.dev here, set has been set in drm_cr=
tc_init_with_planes .
>=20
>=20
> I tested it and this check must be here because trying to enable color mg=
mt
> on CRTC with no associated device, causes null ptr dereference later on i=
n
> drm_crtc_enable_color_mgmt (unless something changed in recent kernel
> versions, last time I tested was 6.10? or even 6.8).

Just tested it without the null check and it works. Next version will be wi=
thout it.

Best regards, Piotr Zalewski

