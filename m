Return-Path: <linux-kernel+bounces-439510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C25469EB04B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 12:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEFBC282A5A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 11:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9089519F47E;
	Tue, 10 Dec 2024 11:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="RuEz1aVQ"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F02119F11F;
	Tue, 10 Dec 2024 11:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733831878; cv=none; b=VzoJKk1t8e0tUqUL/N7zsS2i+l2wTHcRcH3Mn8hW5SyZM4Br6IcSFi+x7hCxmQPJ2WZF5J2PY+I9FiAs8aqsWHy88hnFMxPQ1LesMeA8HpfTsgwmkUVeNjsnf+eD6pioHU6Z/JgQwrqROGL0yB0IsQeCEBp1i/UUei+efjbMQwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733831878; c=relaxed/simple;
	bh=LdEVmKKOlhCEmtz28en4sZeWOgFsqPYHNRhee3lIzsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dZIqF7oAMv9S37KQFJOYmvWceA0cUyJ/yv3/9iDs3E/cpm3fVf1cO1hIhqbY2lDhU4OSDxgRBhHBRxUuILfFwVXdaJvUYT+m4etSoMb9sr8/wTvFsmS69oQ0a75mydqUI9BysuUkJw+3E9Wcozov+bLBSqFQjGcWcI7+WCk74Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=RuEz1aVQ; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=KbVJw5J4GWJ01T8kGIEWydEYZvhCAGIPzpK/iHXKbT8=; b=RuEz1aVQq20Lt9i1RM6zkuMFJP
	E7gWUPReBqKH8hpAFsniOi4v/LpHXv3Huxx0sfQy6a6Wv4J8NoiuKlL56oJ3qoVXx8FhEKY6PMtJN
	ZlEeAarE6zVUMWD2bArovq74ytqUrvtYhvxy66Wh7mwUtEnrz0Sz1Iqu5xioV064XpTb4dBa3HR2l
	LL3z9/hSMcy+0EdyOgpDFDzVLZ0qHW7r4Rn4bBa4SO0AtawcKWHheuFdCZHHYXM2p/E2Ucn2vedyZ
	C7JA5VBytM4DCLM+U8MgACvIs57uqQXQFYUli/U7BKzTLVA0bNP3xs9OQFSM8Jbttbyl1OFEz0VDU
	e+IKUKqA==;
Received: from i53875bc4.versanet.de ([83.135.91.196] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tKys5-00058v-Pm; Tue, 10 Dec 2024 12:57:45 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Andy Yan <andyshrk@163.com>
Cc: hjc@rock-chips.com, krzk+dt@kernel.org, s.hauer@pengutronix.de,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, derek.foreman@collabora.com,
 detlev.casanova@collabora.com, Andy Yan <andy.yan@rock-chips.com>,
 Michael Riesch <michael.riesch@wolfvision.net>
Subject: Re: [PATCH v5 01/18] drm/rockchip: vop2: Add debugfs support
Date: Tue, 10 Dec 2024 12:57:44 +0100
Message-ID: <4471861.MSiuQNM8U4@diego>
In-Reply-To: <20241209122943.2781431-4-andyshrk@163.com>
References:
 <20241209122943.2781431-1-andyshrk@163.com>
 <20241209122943.2781431-4-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Andy,

Am Montag, 9. Dezember 2024, 13:29:13 CET schrieb Andy Yan:
> From: Andy Yan <andy.yan@rock-chips.com>
> 
> /sys/kernel/debug/dri/vop2/summary:  dump vop display state
> /sys/kernel/debug/dri/vop2/regs: dump whole vop registers
> /sys/kernel/debug/dri/vop2/active_regs: only dump the registers of
> activated modules
> 
> Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> Tested-by: Michael Riesch <michael.riesch@wolfvision.net> # on RK3568
> Tested-by: Detlev Casanova <detlev.casanova@collabora.com>
> ---

> +static void __vop2_regs_dump(struct seq_file *s, bool active_only)
> +{
> +	struct drm_info_node *node = s->private;
> +	struct vop2 *vop2 = node->info_ent->data;
> +	struct drm_minor *minor = node->minor;
> +	struct drm_device *drm_dev = minor->dev;
> +	const struct vop2_regs_dump *dump;
> +	unsigned int i;
> +
> +	drm_modeset_lock_all(drm_dev);
> +
> +	regcache_drop_region(vop2->map, 0, vop2_regmap_config.max_register);
> +
> +	if (vop2->enable_count) {
> +		for (i = 0; i < vop2->data->regs_dump_size; i++) {
> +			dump = &vop2->data->regs_dump[i];
> +			vop2_regs_print(vop2, s, dump, active_only);
> +		}
> +	} else {
> +		seq_printf(s, "VOP disabled\n");
> +	}
> +	drm_modeset_unlock_all(drm_dev);
> +

nit: not needed empty line at the end of the function

> +}
> +

> +static void vop2_debugfs_init(struct vop2 *vop2, struct drm_minor *minor)
> +{
> +	struct dentry *root;
> +	unsigned int i;
> +
> +	root = debugfs_create_dir("vop2", minor->debugfs_root);
> +	if (!IS_ERR(root)) {
> +		for (i = 0; i < ARRAY_SIZE(vop2_debugfs_list); i++)
> +			vop2_debugfs_list[i].data = vop2;
> +
> +		drm_debugfs_create_files(vop2_debugfs_list,
> +					 ARRAY_SIZE(vop2_debugfs_list),
> +					 root, minor);
> +	}
> +}
> +
> +static int vop2_crtc_late_register(struct drm_crtc *crtc)
> +{
> +	struct vop2_video_port *vp = to_vop2_video_port(crtc);
> +	struct vop2 *vop2 = vp->vop2;
> +
> +	if (drm_crtc_index(crtc) == 0)
> +		vop2_debugfs_init(vop2, crtc->dev->primary);
> +
> +	return 0;
> +}

I'm wondering about, shoudln't there be an unregister step too?
I.e. the late_register callback says:
"should be unregistered in the early_unregister callback" [0].

And there exists drm_debugfs_remove_files(), though it doesn't
seem t be used much - just by tegra.

I haven't managed to find drm code handling that automatically though?


Heiko


[0] https://elixir.bootlin.com/linux/v6.12.4/source/include/drm/drm_crtc.h#L737
[1] https://elixir.bootlin.com/linux/v6.12.4/source/drivers/gpu/drm/drm_debugfs.c#L265



