Return-Path: <linux-kernel+bounces-375988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 263329A9E3A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 11:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D75D1C2482F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 09:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C2819B5A3;
	Tue, 22 Oct 2024 09:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="EdvnfT1u"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B6A19A292;
	Tue, 22 Oct 2024 09:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729588578; cv=none; b=fcpiNM79c8dbWgqUqDOHn/gmywa9DAm66en2s6gY7DlYlM4KhCoDPxWPZL+fXVVLpK3FxTdGgwWuA+DMyNcbJvK4PYgrofWikNquJqDAyhvk5E40gReF1DS51r/s1m2MaKconsUUqgXghY3AIBAqSGpc6ssJV07jMzKs0bhV5HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729588578; c=relaxed/simple;
	bh=WK7Q9BUHHXh2dfmzyOC4ceHjQml49UTueInTaVAVVuc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oFaxvf2V5ozHbMbOVeRoqa9bKR3uycr0pipj8vHTWUc+SPmGpwcFcO2hqT5j04rasMAWur2YpAsx8Ic3opAANfemCEqv7ES3ohhksag+k5fx+FzT3f9aVH4zlA2VxtqMS7ZuO9sAILVOi8Af3LYJBtowYRSgCBXh2VS0rFfZZsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=EdvnfT1u; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729588573;
	bh=WK7Q9BUHHXh2dfmzyOC4ceHjQml49UTueInTaVAVVuc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=EdvnfT1uX8a/GhmvQ0G/2JiRwCTIX7JqJIx+csY8BP+vUU2KQ8mneX/cGkW61yeS5
	 AMQdE6OrUVfPvduAB9no+O4ph88nG7KCZ2r/shTaUoCBIRfWZl6t2vo5jNcTFYvDkH
	 uXbxCfGeB4KJMJUlsfVKmczxQ4h/3RwkN8MuWthUeeWTKJ0gpq27XjsSw9oujGWeU1
	 bEyZgJTE7s9ZPmM7ENSO+dH0IE3IqFjHh+DDU5/DD6vDnPpBbgTxrDHzrzOTdfFjSl
	 oR43sqSZlg0FbuLKdXtYrD+zxvVa6R62zcVfvE5TZoh4LgesktKUisO/WAIyxLBJnR
	 isJQiA/HZfgvA==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B834D17E139E;
	Tue, 22 Oct 2024 11:16:12 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: chunkuang.hu@kernel.org, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
 p.zabel@pengutronix.de, airlied@gmail.com, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
 matthias.bgg@gmail.com, shawn.sung@mediatek.com, yu-chang.lee@mediatek.com, 
 ck.hu@mediatek.com, jitao.shi@mediatek.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 wenst@chromium.org, kernel@collabora.com, sui.jingfeng@linux.dev, 
 michael@walle.cc, sjoerd@collabora.com, 
 Simona Vetter <simona.vetter@ffwll.ch>
In-Reply-To: <20241017103809.156056-1-angelogioacchino.delregno@collabora.com>
References: <20241017103809.156056-1-angelogioacchino.delregno@collabora.com>
Subject: Re: (subset) [PATCH v13 0/3] drm/mediatek: Add support for OF
 graphs
Message-Id: <172958857271.72613.71247328907828550.b4-ty@collabora.com>
Date: Tue, 22 Oct 2024 11:16:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Thu, 17 Oct 2024 12:38:06 +0200, AngeloGioacchino Del Regno wrote:
> Changes in v13:
>  - Added comment in commit description of patch [1/3] to warn about
>    new port scheme.
>  - The series is now fully reviewed, tested, hence *ready*.
> 
> Changes in v12:
>  - Added comment to describe graph for OVL_ADAPTOR in patch [3/3]
>    as suggested by CK Hu.
> 
> [...]

Applied to v6.12-next/dts64, thanks!

[2/3] dt-bindings: arm: mediatek: mmsys: Add OF graph support for board path
      commit: 713a20e598f8f8fb6660b6c38eb5071aa3fc85c6

Cheers,
Angelo



