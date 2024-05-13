Return-Path: <linux-kernel+bounces-177836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEE18C4526
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 18:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69BE01C21927
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 16:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BCEA1B94F;
	Mon, 13 May 2024 16:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kgI9iDP/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9C21A716;
	Mon, 13 May 2024 16:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715618161; cv=none; b=kVqhb2LCzrtwPuvWtKN781/c//0dJwkv/+P0YkBdaNIZtR4Y8b3o36cYBX3LEKFgOeL5ZJ8XM2jLaLVZYtIR/rIfzENxcm6CcSPFEfjnEF16v9/bVkO3xMGACnQQAnmZkGwGsudlORA0rUF5LgRHPLAzABuLurOKj7bAsgZCGY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715618161; c=relaxed/simple;
	bh=WL4mQviCBXJXVL3QbU+lDj3cm5lbV4VfD08lc6+45kc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pz6sIZflSmyHuE4MMASjr1nqL3HBueUMwUZZDJ/+G7C1Wtvd9VYW38ShuG96xIkcWOyOHiLCV/M4UsSchN42W74DRQXUbjhF3448QM+gxii+NEtI2IiptwiRL9ZgIvkLayyg1bXgZzmpspQA2PNd723cxLFPZZqJscCpvLMzTQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kgI9iDP/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C03B5C113CC;
	Mon, 13 May 2024 16:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715618161;
	bh=WL4mQviCBXJXVL3QbU+lDj3cm5lbV4VfD08lc6+45kc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=kgI9iDP/j23MTKqJ38bXuHTYN+VYj1ybdPdblKAETl9tinCbaM8aJ9XqKwyaxCJfQ
	 MCJUksnmp3fP9iyVo5TzVTy883f3IUxpvGRvLUGr/aiVfK9tRhPouQOnpYjuyf5mfw
	 P6EafBr5vR5y9tRMbJIsrzXgKefscmgEtKGO1pOEpAHjuAZRYI9nPjDFU5kPnjC/s8
	 adafPBwFtx2PJ9W3VIE1bP7yzmSKL7o8DZBo23P0NDBA2hq6NTW8TTuRShitLSPO1C
	 EpiL16d71Dn0Bw29SEa6/NT8EMYEJxgirhhxQcmkf9+HVY9gNdDO2fL8MR1CafETNZ
	 lfEd3U22/NiKQ==
From: Robert Foss <rfoss@kernel.org>
To: Sui Jingfeng <sui.jingfeng@linux.dev>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: imx@lists.linux.dev, Maxime Ripard <mripard@kernel.org>, Liu Ying <victor.liu@nxp.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, dri-devel@lists.freedesktop.org, Douglas Anderson <dianders@chromium.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Sascha Hauer <s.hauer@pengutronix.de>, Andrzej Hajda <andrzej.hajda@intel.com>,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240513153109.46786-1-sui.jingfeng@linux.dev>
References: <20240513153109.46786-1-sui.jingfeng@linux.dev>
Subject: Re: [PATCH v2 00/12] Remove redundant checks on existence of 'bridge->encoder'
Message-Id: <171561815850.92124.10451289435632217035.b4-ty@kernel.org>
Date: Mon, 13 May 2024 18:35:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.1

On Mon, 13 May 2024 23:30:57 +0800, Sui Jingfeng wrote:
> The checks on the existence of bridge->encoder in the implementation of
> drm_bridge_funcs::attach() is not necessary, as it has already been checked
> in the drm_bridge_attach() function call by previous bridge or KMS driver.
> The drm_bridge_attach() will quit with a negative error code returned if
> it fails for some reasons, hence, it is guaranteed that the .encoder member
> of the drm_bridge instance is not NULL when various bridge attach functions
> are called.
> 
> [...]

Applied, thanks!

[01/12] drm/bridge: simple-bridge: Remove a redundant check on existence of bridge->encoder
        https://cgit.freedesktop.org/drm/drm-misc/commit/?id=f0a83a2cf9eb
[02/12] drm/bridge: tfp410: Remove a redundant check on existence of bridge->encoder
        https://cgit.freedesktop.org/drm/drm-misc/commit/?id=482ade3ec1c5
[03/12] drm/bridge: nxp-ptn3460: Remove a redundant check on existence of bridge->encoder
        https://cgit.freedesktop.org/drm/drm-misc/commit/?id=0f4bca4e1be3
[04/12] drm/bridge: panel: Remove a redundant check on existence of bridge->encoder
        https://cgit.freedesktop.org/drm/drm-misc/commit/?id=a8f856bf054a
[05/12] drm/bridge: it6505: Remove a redundant check on existence of bridge->encoder
        https://cgit.freedesktop.org/drm/drm-misc/commit/?id=8761a39e3f9d
[06/12] drm/bridge: adv7511: Remove a redundant check on existence of bridge->encoder
        https://cgit.freedesktop.org/drm/drm-misc/commit/?id=41e6ed85e457
[07/12] drm/bridge: cdns-mhdp8546: Remove a redundant check on existence of bridge->encoder
        https://cgit.freedesktop.org/drm/drm-misc/commit/?id=b24fd6e9eb66
[08/12] drm/bridge: megachips-stdpxxxx-ge-b850v3-fw: Remove a redundant check on existence of bridge->encoder
        https://cgit.freedesktop.org/drm/drm-misc/commit/?id=0a59deb2fedb
[09/12] drm/bridge: synopsys: dw-mipi-dsi: Remove a redundant check on existence of bridge->encoder
        https://cgit.freedesktop.org/drm/drm-misc/commit/?id=80221a89ff95
[10/12] drm/bridge: lt9611uxc: Remove a redundant check on existence of bridge->encoder
        https://cgit.freedesktop.org/drm/drm-misc/commit/?id=91942a37ebba
[11/12] drm/bridge: imx: Remove redundant checks on existence of bridge->encoder
        https://cgit.freedesktop.org/drm/drm-misc/commit/?id=ec74951a7507
[12/12] drm/bridge: analogix: Remove redundant checks on existence of bridge->encoder
        https://cgit.freedesktop.org/drm/drm-misc/commit/?id=591255853a37



Rob


