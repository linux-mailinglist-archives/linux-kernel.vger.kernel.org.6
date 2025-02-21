Return-Path: <linux-kernel+bounces-525937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 566D7A3F796
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 15:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3B9E19C0DF9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 14:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20F920FAB7;
	Fri, 21 Feb 2025 14:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b="Oqd6dpyx"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7256A20D51D;
	Fri, 21 Feb 2025 14:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740149087; cv=pass; b=KW8EvX+cfrAsvSqKnYav1jWNpGpEFdqawV7Yo7Tx7ArdbA6toKXJVSgHIZpTRm6wCOLMyPD6eXT2FExDs+LwVDGay5091wlgrvZv+a2xkZqwPOxJBlZ79fMcTjyXRrM6EcCGEJ8c7JcEZ3QvAHJqssldlKkbTZSW7TLCFnPhr0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740149087; c=relaxed/simple;
	bh=OpXQbIwdry+KWlb0cihUCK41OtZVFuebRon28vjN7XA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SJg3+1TObytLssd05QtG34t5V8DIrRF4//KpX6vk5dLvK1NbQOp5q6tLnQ/vifIP3f+BelQ75tsfLzlLojrhMiGF0By1uitu42ITe/PH3O5xVLnjwWGNrLnep3t7ZwC7C31IwTOthjHuj8+v0vlxCWjscUufjRc9740YICfh6hU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b=Oqd6dpyx; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1740149018; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=LlJGyGMRQMGa7d1hiq5ol+5x17hrNEGOITinBxi2RfLVUmuqWFvWwvZraOoEpi4OYi1YoOLNyqvnuoBhJv5NjSBAknykKoIDBYOOujNCSffFzetkfrbLL99wcmnReve0li94vUEnRp/md2vSGDu2zRk6o3mUwB3ZXFwJScQUKxg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740149018; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=gA8mn4fOHoGECCHqYXtlx2zwyQnjDL6NNJx/mEGL37k=; 
	b=SS5CeWfivsYuXpFsx/0MPvpuxMWFRxte1/ddDomWFSwswVstzSnzPNvljfY4htomab7qaxtT3qI+cXo+9mA4ytBNiy2AqaiXhG+Y0rBgX6bKYRLZeo5xmTxEYemz2Kg0vt+8tTa5BgxPqXvk6GWwPr1ADZQqOXGt1rrKGMkXUmQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=detlev.casanova@collabora.com;
	dmarc=pass header.from=<detlev.casanova@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740149018;
	s=zohomail; d=collabora.com; i=detlev.casanova@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=gA8mn4fOHoGECCHqYXtlx2zwyQnjDL6NNJx/mEGL37k=;
	b=Oqd6dpyxZY9ouCf7T8Ku9XIIh2lKIO7kgmqL3aRYfciczdjFa77sxZ12CaQ/izzJ
	3eUDdaUsKGpAhc87xv6+Ln8RjEH0POVBgunMSnnqLqqH0XNLvDk09FnQIz0S1CHOx2t
	l0fX5qeyonfxOLsyVYaCaZsUIY5ALfsn9B5l3MNg=
Received: by mx.zohomail.com with SMTPS id 1740149014815682.0553532876535;
	Fri, 21 Feb 2025 06:43:34 -0800 (PST)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: Piotr Oniszczuk <piotr.oniszczuk@gmail.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: linux-kernel@vger.kernel.org, Algea Cao <algea.cao@rock-chips.com>,
 Heiko Stuebner <heiko@sntech.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 dri-devel@lists.freedesktop.org, Niklas Cassel <cassel@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>, kernel@collabora.com,
 David Airlie <airlied@gmail.com>, Dragan Simic <dsimic@manjaro.org>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Robert Foss <rfoss@kernel.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Sugar Zhang <sugar.zhang@rock-chips.com>, linux-rockchip@lists.infradead.org,
 Chen-Yu Tsai <wens@csie.org>, FUKAUMI Naoki <naoki@radxa.com>,
 devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
 Jonas Karlman <jonas@kwiboo.se>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>, linux-arm-kernel@lists.infradead.org,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Charkov <alchark@gmail.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH v7 0/3] Add HDMI audio on the rk3588 SoC
Date: Fri, 21 Feb 2025 09:43:31 -0500
Message-ID: <4988041.31r3eYUQgx@trenzalore>
In-Reply-To: <5E535D58-AEFF-45A4-A1EA-1FA282F366AE@gmail.com>
References:
 <20250217215641.372723-1-detlev.casanova@collabora.com>
 <BA73C4A1-C680-4748-9CE1-4B3B19A14261@gmail.com>
 <5E535D58-AEFF-45A4-A1EA-1FA282F366AE@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ZohoMailClient: External

On Friday, 21 February 2025 06:42:31 EST Piotr Oniszczuk wrote:
> Small data point: on rock5b switching in dts analog audio: from
> audio-graph-card to simple-audio-card (so dts is:
> https://gist.github.com/warpme/349b27e49bc6f617ef1041047e75adab ) makes
> kernel oops go away with analog audio still working=E2=80=A6
>=20
> so maybe issue is in audio-graph-card code (or its dts fragments)?

I can reproduce with your config (I guess that removing the driver for anal=
og=20
audio hides the issue)

I'm really feel like simple_util_clean_reference(card) in simple_probe()=20
errors path should not be called anymore, since
https://lore.kernel.org/all/87zfk4o5l2.wl-kuninori.morimoto.gx@renesas.com/

I'm adding Kuninori Morimoto in the to list of this thread for extra input=
=20
(See thread at https://lore.kernel.org/all/B8EF5196-55FB-44EC-B93C-E327C791=
225B@gmail.com/) as they made that change.
Especially those commits:
      ASoC: audio-graph-card2: use __free(device_node) for device node
      ASoC: audio-graph-card: use __free(device_node) for device node
      ASoC: simple-card: use __free(device_node) for device node

Detlev.



