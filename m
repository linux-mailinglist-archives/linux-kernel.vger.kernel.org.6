Return-Path: <linux-kernel+bounces-329687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2659D9794B9
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 08:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 599A11C212C8
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 06:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DED1A270;
	Sun, 15 Sep 2024 06:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="DER2PoBD"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100C21B85D6;
	Sun, 15 Sep 2024 06:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726380896; cv=none; b=igcYfGc4vwHfjIZNdJdoL1ha8g9j4feKTyvRbIzjLao0FHLc4SxqV7Fdcn+lHSJojNDLTHlcBiz6qJtFU9Su6fjgP6mp1pHLU0LjuXg/x2CscNTJW1YPd+kJ+6+HlRBSfCPIgtC8gLvlawR/LtwuNAeVaMpM8Zz451AtPe5RtLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726380896; c=relaxed/simple;
	bh=QFcX13p8OW5CrGZzXg3ZbeocYkXwmHrZHAM9iVL4z2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GNi4PTtqb2MKobjfUWDS8vwQd+BXf7IenBMJlIbLgW2DGcXaeFo6sCaxHKZ7EwJNnFLxnIYCQrJ6OFQ4aBW94Va2mSyltxpPV+/EgW+ECKhVtBJ78YXBkrPZHXXahWcUxt6Z3nwGxd/5LScCG8zzCFJzPkAOORVXqTx96yunIcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=DER2PoBD; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=f+4XgwVGxJeOjUz5ZvQCVWlV8A1nJn2/v5ZCP+iqPbM=; b=DER2PoBDYhRvbzjwgZnsh1iREo
	m3QYH/xlflR6I9HxIc99+Vl1nBuJBnIuWf9hFYtFnNYq7A1B5q/rf+KMKyFf2xyPScBLmkS7byTpv
	0O4WSDqQ1LM1xbyoatxdmo5mu9C3OJ/eSNMNb3lABEqxtnLFyzPvbo8p6kxcy2wRqe+O9ucH6s0d4
	+oFbx3NFjhBTqcKhfPl7NobNfhFG7Aj04+DmkdcmiBLMfpNicSSeU8ZpGcQO+6ZJM/xA/50YaQ1Tq
	Ek+GjfTq8e3sGBMZXuEUjVacGdqeniNoqbdFDYEYwjh0iVv4FX456PTyBZheaIzeTEcxrLW6Q34pm
	NVMtw74Q==;
Received: from [213.235.133.41] (helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1spiWX-0008L4-NC; Sun, 15 Sep 2024 08:14:18 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Sandy Huang <hjc@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Mark Yao <markyao0591@gmail.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, kernel@collabora.com,
 Alexandre ARNOUD <aarnoud@me.com>, Luis de Arquer <ldearquer@gmail.com>,
 Algea Cao <algea.cao@rock-chips.com>
Subject: Re: [PATCH v6 3/3] drm/rockchip: Add basic RK3588 HDMI output support
Date: Sun, 15 Sep 2024 08:13:53 +0200
Message-ID: <2748376.mvXUDI8C0e@phil>
In-Reply-To: <4766d230-c9c3-414d-a954-3b0c890e7e08@collabora.com>
References:
 <20240906-b4-rk3588-bridge-upstream-v6-0-a3128fb103eb@collabora.com>
 <2376712.1SvkZsmPdQ@diego>
 <4766d230-c9c3-414d-a954-3b0c890e7e08@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Am Samstag, 14. September 2024, 20:28:59 CEST schrieb Cristian Ciocaltea:
> On 9/10/24 10:08 PM, Heiko St=FCbner wrote:
> > Am Freitag, 6. September 2024, 03:17:42 CEST schrieb Cristian Ciocaltea:

> > That hdmi->ref_clk just accidentially falls out of that loop at the end
> > looks somewhat strange, so getting and keeping that refclk
> > separately would make this look cleaner.
>=20
> I've added /* keep "ref" last */ comment above, but I agree it's not real=
ly
> the best approach.
>=20
> I'm going to submit v7 in the meantime, as this was the last remaining op=
en
> topic on my list.  I guess we can figure this out afterwards.

yep, that is fine to figure out later, as it's mainly a style thing.



