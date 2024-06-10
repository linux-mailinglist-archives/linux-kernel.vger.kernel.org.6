Return-Path: <linux-kernel+bounces-208375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4642790242E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 16:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C35C2B26626
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 14:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE03132136;
	Mon, 10 Jun 2024 14:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="acPil28z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3A7132121
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 14:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718030090; cv=none; b=Pj98dG0PTocBHg4+thXH1kefBa4sZf/cdYdy5i8mm8I//2+jQFR7scEBVZzXKwOLl2bP8BxKML3X8Zw+mnUCSLpLtEG8ROM7V3DlYOY28k7TFEqnpEVLdRgmbUhTl2Xvb7K3lbPeOevuUdTetDqO+p4FZJVpUyNVqLNF8dPIY/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718030090; c=relaxed/simple;
	bh=8EaYTiI7dlRaNP/ku+p78n5fiWhhP6LeJZbLbulj3oc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UvZju+1YktylRZJKBmB+Z40/WcNsi7auYsp/DFVbsm6XHk43BFhNN1/ueWhLd5fIvU/Yw7BPHROQnPNZ2moI+ER5Ut1ALwOiYgovkXJc0jY73G9FKgdK3fFaWaRvJq5Y8OWHhC3tHaqCBsyu19Y5qHmzyQsSJM2bIBoupUbjrs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=acPil28z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CFBDC2BBFC;
	Mon, 10 Jun 2024 14:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718030089;
	bh=8EaYTiI7dlRaNP/ku+p78n5fiWhhP6LeJZbLbulj3oc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=acPil28zhn/45T86ovd9G4KWdjb4/i6R8dclYk7t9IrWc+S/zGN9fOIb1ipYjBI0b
	 IeNoxSvTK3/DjDm02FMv2I1Bdb50/axmf8YkVVsz6sbzIcWQfmM7Gj5Gd3D5jb45Ar
	 9kg1KGjomoN9APoVjB3g3G3luBy/nhUdLNI+JzJMDkSPQvdMkraxT4D7VVnQbgV4Ou
	 d7Lab7e3wGhvmrLHAv4eZ2kGHopEplmysKLyvlR9QgUZxRQATeAQhULilTVlrfjLZY
	 NdhykRGmJecCVTRXs0jPxqSuWertgB9QOev31ClMei8YE5os1jsZx8NBDkbBNDZ2nO
	 /d1Tsr5bn1RAw==
From: Robert Foss <rfoss@kernel.org>
To: dri-devel@lists.freedesktop.org, Adam Ford <aford173@gmail.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>, Michael Tretter <m.tretter@pengutronix.de>,
 Thomas Zimmermann <tzimmermann@suse.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Marek Vasut <marex@denx.de>,
 Daniel Vetter <daniel@ffwll.ch>, aford@beaconembedded.com, Jonas Karlman <jonas@kwiboo.se>,
 Frieder Schrempf <frieder.schrempf@kontron.de>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Inki Dae <inki.dae@samsung.com>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, linux-kernel@vger.kernel.org,
 Neil Armstrong <neil.armstrong@linaro.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 David Airlie <airlied@gmail.com>, Maxime Ripard <mripard@kernel.org>, Marco Felsch <m.felsch@pengutronix.de>,
 Jernej Skrabec <jernej.skrabec@gmail.com>
In-Reply-To: <20240601144103.198299-1-aford173@gmail.com>
References: <20240601144103.198299-1-aford173@gmail.com>
Subject: Re: [PATCH V3 1/2] drm/bridge: samsung-dsim: Set P divider based on min/max of fin pll
Message-Id: <171803008513.465712.14703974733678728383.b4-ty@kernel.org>
Date: Mon, 10 Jun 2024 16:34:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.1

On Sat, 1 Jun 2024 09:41:01 -0500, Adam Ford wrote:
> The P divider should be set based on the min and max values of
> the fin pll which may vary between different platforms.
> These ranges are defined per platform, but hard-coded values
> were used instead which resulted in a smaller range available
> on the i.MX8M[MNP] than what was possible.
> 
> As noted by Frieder, there are descripencies between the reference
> manuals of the Mini, Nano and Plus, so I reached out to my NXP
> rep and got the following response regarding the varing notes
> in the documentation.
> 
> [...]

Applied, thanks!

[1/2] drm/bridge: samsung-dsim: Set P divider based on min/max of fin pll
      (no commit info)
[2/2] drm/bridge: samsung-dsim: Fix porch calcalcuation rounding
      (no commit info)



Rob


