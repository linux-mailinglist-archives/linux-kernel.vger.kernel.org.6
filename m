Return-Path: <linux-kernel+bounces-358511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 861D6998041
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 10:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 307DC1F217FC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 08:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3302E1C6880;
	Thu, 10 Oct 2024 08:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jtzO/oUr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D79F1C3F00;
	Thu, 10 Oct 2024 08:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728548299; cv=none; b=rv6cEjyg4cbKX7s69Ld0++WeftauB5adlQ7zB0HQqqpSfW3Am/0f2CKjNQ6mhRlrnMcNHSGKFykpfIMcli5X5YuqC9Hx2NaFzDo3sOnhEkhoRwwqrqog3+zH+43KI2eTfC8BofCsPIPbUFaAb2zLGoENXnhYwBEuDISZBH8DJlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728548299; c=relaxed/simple;
	bh=AVattL+Jk3iSC5PSLuDU03CTMio8BerpFM7lRB9AtYY=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=MXr9NaFX462jH3kZ9IVGksNgstgb0l7hknnD/qRCEuW97ZsTAyWTf5NEJy+B8vatfZXaNr/dQWYZ7hwmQZBs/FIIlsky5BSup2VSFWjnBTvy0w6iFrrWxL324uR/8ELeSKfrAqXe8VYMzs/MNiv/NiCxc8ifcPNp7UZdNu2qRCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jtzO/oUr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B0D2C4CEC5;
	Thu, 10 Oct 2024 08:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728548298;
	bh=AVattL+Jk3iSC5PSLuDU03CTMio8BerpFM7lRB9AtYY=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=jtzO/oUrbPtPSnL//FZnH0DGE8a7bGnlrI5r/6BnsviZyEYdBA8oMwXZDbjOZA4dP
	 mpsZXGdxoomFDgMGS0N9QtTbOD2HZLZPU1tgx0cQg8nSgo7meRNCCSwqh5N6cB9KBt
	 6DhlkCLcfxCLSP/g8SH+hV/VSyVKgXdnCoBqFuAtrUHdAdWb2ZLr91q+gT5Mm1xHDl
	 P05zqRFma5nUfxuMnBO3LVPRSTVa0AX7TQHcjerOK/1865Ew3QhMQCE3flkcr3LDp+
	 nScxH7BQ1+ZPYiI+BjRyxAB0nPotqlga0fsUz+8rC8LNBqE0teKBK25UF9xn3j8Rqp
	 eyIBcFSNw3jNg==
Message-ID: <c9380ad4bffc044e014b3a9b276b474a@kernel.org>
Date: Thu, 10 Oct 2024 08:18:15 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH v9 1/3] drm/bridge: synopsys: Add DW HDMI QP TX
 Controller support library
In-Reply-To: <20241010-b4-rk3588-bridge-upstream-v9-1-68c47dde0410@collabora.com>
References: <20241010-b4-rk3588-bridge-upstream-v9-1-68c47dde0410@collabora.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, kernel@collabora.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, "Alexandre
 ARNOUD" <aarnoud@me.com>, "Algea Cao" <algea.cao@rock-chips.com>, "Andrzej
 Hajda" <andrzej.hajda@intel.com>, "Andy Yan" <andy.yan@rock-chips.com>, "Conor
 Dooley" <conor+dt@kernel.org>, "David Airlie" <airlied@gmail.com>,
 =?utf-8?b?SGVpa28gU3TDvGJuZXI=?= <heiko@sntech.de>, "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Jonas
 Karlman" <jonas@kwiboo.se>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Laurent
 Pinchart" <Laurent.pinchart@ideasonboard.com>, "Luis de Arquer" <ldearquer@gmail.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Mark Yao" <markyao0591@gmail.com>, "Maxime
 Ripard" <mripard@kernel.org>, "Neil Armstrong" <neil.armstrong@linaro.org>, "Rob
 Herring" <robh@kernel.org>, "Robert Foss" <rfoss@kernel.org>, "Sandy Huang" <hjc@rock-chips.com>, "Sascha
 Hauer" <s.hauer@pengutronix.de>, "Simona Vetter" <simona.vetter@ffwll.ch>, "Simona
 Vetter" <simona@ffwll.ch>, "Thomas Zimmermann" <tzimmermann@suse.de>
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Thu, 10 Oct 2024 01:40:49 +0300, Cristian Ciocaltea wrote:
> The Synopsys DesignWare HDMI 2.1 Quad-Pixel (QP) TX Controller IP
> supports the following features, among others:
> 
> * Fixed Rate Link (FRL)
> * Display Stream Compression (DSC)
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

