Return-Path: <linux-kernel+bounces-441002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 116C79EC7B7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 09:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EBA528702B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 08:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B25A1E9B19;
	Wed, 11 Dec 2024 08:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="uNZ1ZfwH"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928101E9B0A;
	Wed, 11 Dec 2024 08:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733907140; cv=none; b=qq2UQUI4q9uRdS2RcG81X6O1CzzRVUxp+kPrZSnDTUP4cpnip5eCqUXf6xheOutEP5xwyA8V2rkvvYOAjQVrC0pwmC59axCYBqXMByM8KWPWwSiWpc3z5B2bHbC/voJYp97aXXtcEjXe7aW9324UAVzZAJQgLcRc8QYvjwPRS8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733907140; c=relaxed/simple;
	bh=0g8KQ0cBy9cJOMUG0RDKiqYP29dhTZAP9MiHlSqGUDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=llQyRXoraADpgvKHw0Bybt5SnuWNZiUFIFyNMY/6PBvl7hzQvlpRixNidcbINVAZ/6eQLHO16lSD2r/vPbgjidn8vzT2tMQuLtLhmhHviMeyicTesp+BVdHOatMpZolCq1seREAcZ2AaZHdfO/odFgz4DH2dffbd31xqyYI+oqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=uNZ1ZfwH; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=fAWS/sRlgeB+YbEy/eqhplKSQ984OPXnrFLfa4o96GQ=; b=uNZ1ZfwHa1YAQBxuf/XLDVsosm
	nDJww0n5aeFUeUp9Rc09P1QndQ1+eKRrRp3bAuWA5+r0SijMwzsz2XOUP9lC1sehu8rhLBUOGFG2L
	qtVX314epcUUf80JvFJWZWZBS7sgubO6kS4vdZ7k3ooOTGTHpya4Ep1/B+mVpyS/HVrzc/wtiagUv
	bDO2Fy40GXvIcnckzGKB3Z+lZZAUp5rmK5P8D2N5h5G35F76m63zP3tdLkQRVeS3WG2wsO1bK1es9
	hJfThXSrAK3/LPufn8RC1HmKbzPsLRH8zCq0Ooe7jubaPHp3f11NmxrrPchNRfkGUgQNeuXycRIK7
	eYPGTFOw==;
Received: from i53875bc4.versanet.de ([83.135.91.196] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tLIS3-0000HG-JO; Wed, 11 Dec 2024 09:52:11 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Andy Yan <andyshrk@163.com>
Cc: hjc@rock-chips.com, krzk+dt@kernel.org, s.hauer@pengutronix.de,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, derek.foreman@collabora.com,
 detlev.casanova@collabora.com, Andy Yan <andy.yan@rock-chips.com>,
 Michael Riesch <michael.riesch@wolfvision.net>
Subject: Re: [PATCH v5 01/18] drm/rockchip: vop2: Add debugfs support
Date: Wed, 11 Dec 2024 09:52:10 +0100
Message-ID: <3527424.cLl3JjQhRp@diego>
In-Reply-To: <121ab3c0.68d0.193b48b32ed.Coremail.andyshrk@163.com>
References:
 <20241209122943.2781431-1-andyshrk@163.com> <4471861.MSiuQNM8U4@diego>
 <121ab3c0.68d0.193b48b32ed.Coremail.andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Hi Andy,

Am Mittwoch, 11. Dezember 2024, 08:07:21 CET schrieb Andy Yan:
> At 2024-12-10 19:57:44, "Heiko St=C3=BCbner" <heiko@sntech.de> wrote:
> >Am Montag, 9. Dezember 2024, 13:29:13 CET schrieb Andy Yan:
> >> From: Andy Yan <andy.yan@rock-chips.com>
> >>=20
> >> /sys/kernel/debug/dri/vop2/summary:  dump vop display state
> >> /sys/kernel/debug/dri/vop2/regs: dump whole vop registers
> >> /sys/kernel/debug/dri/vop2/active_regs: only dump the registers of
> >> activated modules
> >>=20
> >> Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
> >> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> >> Tested-by: Michael Riesch <michael.riesch@wolfvision.net> # on RK3568
> >> Tested-by: Detlev Casanova <detlev.casanova@collabora.com>
> >> ---
> >
> >> +static void __vop2_regs_dump(struct seq_file *s, bool active_only)
> >> +{
> >> +	struct drm_info_node *node =3D s->private;
> >> +	struct vop2 *vop2 =3D node->info_ent->data;
> >> +	struct drm_minor *minor =3D node->minor;
> >> +	struct drm_device *drm_dev =3D minor->dev;
> >> +	const struct vop2_regs_dump *dump;
> >> +	unsigned int i;
> >> +
> >> +	drm_modeset_lock_all(drm_dev);
> >> +
> >> +	regcache_drop_region(vop2->map, 0, vop2_regmap_config.max_register);
> >> +
> >> +	if (vop2->enable_count) {
> >> +		for (i =3D 0; i < vop2->data->regs_dump_size; i++) {
> >> +			dump =3D &vop2->data->regs_dump[i];
> >> +			vop2_regs_print(vop2, s, dump, active_only);
> >> +		}
> >> +	} else {
> >> +		seq_printf(s, "VOP disabled\n");
> >> +	}
> >> +	drm_modeset_unlock_all(drm_dev);
> >> +
> >
> >nit: not needed empty line at the end of the function
>=20
> Will fixed in V6.
>=20
> >
> >> +}
> >> +
> >
> >> +static void vop2_debugfs_init(struct vop2 *vop2, struct drm_minor *mi=
nor)
> >> +{
> >> +	struct dentry *root;
> >> +	unsigned int i;
> >> +
> >> +	root =3D debugfs_create_dir("vop2", minor->debugfs_root);
> >> +	if (!IS_ERR(root)) {
> >> +		for (i =3D 0; i < ARRAY_SIZE(vop2_debugfs_list); i++)
> >> +			vop2_debugfs_list[i].data =3D vop2;
> >> +
> >> +		drm_debugfs_create_files(vop2_debugfs_list,
> >> +					 ARRAY_SIZE(vop2_debugfs_list),
> >> +					 root, minor);
> >> +	}
> >> +}
> >> +
> >> +static int vop2_crtc_late_register(struct drm_crtc *crtc)
> >> +{
> >> +	struct vop2_video_port *vp =3D to_vop2_video_port(crtc);
> >> +	struct vop2 *vop2 =3D vp->vop2;
> >> +
> >> +	if (drm_crtc_index(crtc) =3D=3D 0)
> >> +		vop2_debugfs_init(vop2, crtc->dev->primary);
> >> +
> >> +	return 0;
> >> +}
> >
> >I'm wondering about, shoudln't there be an unregister step too?
> >I.e. the late_register callback says:
> >"should be unregistered in the early_unregister callback" [0].
> >
> >And there exists drm_debugfs_remove_files(), though it doesn't
> >seem t be used much - just by tegra.
> >
> >I haven't managed to find drm code handling that automatically though?
>=20
> Did a little digging=EF=BC=9A
>  rockchip_drm_unbind --=E3=80=8Bdrm_dev_unregister(drm_dev)--=E3=80=8Bdrm=
_debugfs_dev_fini
> --=E3=80=8Bdebugfs_remove_recursive(dev->debugfs_root);
> This will remove all the debugfs file under /dri/0-->display-subsystem  w=
hen we
> remove rockchipdrm when it build as module.

thanks a lot for finding this. And yes, that covers all possible cases.

> If it is builtin, whether we remove them seems to make no difference when=
 we
> reboot or thutdown the system ?
> I also searched for other platforms using similar late register hook, and=
 it seems they haven't remove debugfs  either.

unbind can be called even if the driver is builtin - i.e. a driver
does not need to be a module to be unbount/rebound again.

But the drm_debugfs_dev_fini() function you found, solves that
in all cases, so this patch can stay as it is - minus the empty line.

Thanks a lot
Heiko



