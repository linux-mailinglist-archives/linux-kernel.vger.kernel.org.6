Return-Path: <linux-kernel+bounces-402226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CD29C2533
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 19:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0ED51C226F6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 18:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DEA1A9B55;
	Fri,  8 Nov 2024 18:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="ug4AraFi"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E485233D96;
	Fri,  8 Nov 2024 18:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731092201; cv=none; b=K/irq2g3Yqg5WFxjDIJ6raWY/1AUHcbZbSHNuxqtLmr/cWVQNriMCnzOCKeaWDAhLfbSn1bqNHDwdmsFDN8TcCY1sDXcs95+PdbWMxjeCKxqeaRLtNF6BiFO9zjn4180p805PP0XiwFPmJhQJ1TOMWuS//+X748zuLVSssu+NXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731092201; c=relaxed/simple;
	bh=tlaxmeotAbOLfm/Y0TS4cXdKMYmrhrn4HNUPBxvZpCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=riSwRySY65Ygsbq2uEy0yBnPrGL2oWoPFmnhS5L6MaWT06elZZ9flWruDmycLuHmqUU/NvgqlOG8q8DPjubYFiYShdcpHXJ5N5Njj75E7vdegsn0HqpUcyWbxhiL3YNbr4QVOvWB6KP4YKWPyaxLk9ZxkPdd2ZQ/NmsxMniV1hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=ug4AraFi; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5ZyQm5LHQ7qaqkJe4rbzzejbyBxQj/F4IZoyO1Km+6Y=; b=ug4AraFizxch/gjn7NGcYmmfn6
	DAFUoHbNK05VP75BwTUGGyzf2EMoNndnP8sbJiEPNjDtVavUfiQqUzfn3hMAFNwB9olI9l2KEq7C4
	vKoLl+a/ICGem4ZG5nnpqkX790t86ndfUiQQ/LPVJvaB+bsqgsCrG40KbLNd4zQqmFhgGzxn4rRN+
	ksvnQeXygwP2VKxfeDMtr7Y9pxRNCly+PkQvHudTqZvtO8zhnOpCM20gqgUnX3a1dcKDqdu8mBemZ
	OdCU3CHBbnTrbh1Ie36SzRh78ckJ5zwatlEnsx9XL2vj6mwqpgsvvsB53WdeyROwmNG75AU5bvlEQ
	VeOxX+gQ==;
Received: from i53875b28.versanet.de ([83.135.91.40] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1t9U9a-0008D2-Ds; Fri, 08 Nov 2024 19:56:18 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: linux-kernel@vger.kernel.org,
 Detlev Casanova <detlev.casanova@collabora.com>
Cc: Sandy Huang <hjc@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Heiko Stuebner <heiko.stuebner@cherry.de>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Dragan Simic <dsimic@manjaro.org>, Alexey Charkov <alchark@gmail.com>,
 Jianfeng Liu <liujianfeng1994@gmail.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, kernel@collabora.com,
 Detlev Casanova <detlev.casanova@collabora.com>
Subject: Re: [PATCH v3 0/3] drm: rockchip: vop2: Add VP clock resets support
Date: Fri, 08 Nov 2024 19:56:17 +0100
Message-ID: <1808477.VLH7GnMWUR@diego>
In-Reply-To: <20241108185212.198603-1-detlev.casanova@collabora.com>
References: <20241108185212.198603-1-detlev.casanova@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Detlev,

Am Freitag, 8. November 2024, 19:50:38 CET schrieb Detlev Casanova:
> Detlev Casanova (3):
>   vop2: Add clock resets support
>   arm64: dts: rockchip: Add VOP clock resets for rk3588s
>   dt-bindings: display: vop2: Add VP clock resets

while it isn't that important for this short series, please try to
order things like:
- dt-binding-change
- driver implementing that binding
- dts-file change

because generally, dt-binding + driver changes go through one tree
while the dts-file changes go through another.


Heiko



