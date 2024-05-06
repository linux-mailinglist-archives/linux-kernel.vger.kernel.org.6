Return-Path: <linux-kernel+bounces-169558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DED8BCA60
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 11:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 120F3283FCD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 09:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553E2142640;
	Mon,  6 May 2024 09:18:35 +0000 (UTC)
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A901422B4;
	Mon,  6 May 2024 09:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.201.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714987114; cv=none; b=NCdd3sVN6tbOdW38Qpp5xBSy1WkOLrZQ45QT9IhHlCvqfPwDpn6Z28FT42xoOjfWcXx+6lQrUZe91Le+DgNtJ8qyFTIz8kTU2LQedxlHbv+26BZD8QsP02DwEv9Fxwp7VmvnePC2lFT3cl6QuAAGAXj7bWE00PyId9gImQ4d7co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714987114; c=relaxed/simple;
	bh=qvhpFsiuxtwTgo/nq/ldiVZ2ZyxtSiiBfzQN/m6jid8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:From:To:Subject:
	 References:In-Reply-To; b=juB/A88YglBukwnsNGrPKQ0QrC0W677KXewmQcT6FKd7GlJJFtnUJ7Q7Z1x9fExlAjjJUiUuB4+Jd28M9ApimkCOgHfXMZ9XAbSlGEZhy4riupD1EwaicVlOiWYMbliCiQYjNnVzLTN02/EsEQLcBu0jB2MJWkilVP5bMZT9Kck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=walle.cc; arc=none smtp.client-ip=159.69.201.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Received: from localhost (unknown [IPv6:2a02:810b:4340:6430:4685:ff:fe12:5967])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id 782101B1;
	Mon,  6 May 2024 11:11:36 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 May 2024 11:11:36 +0200
Message-Id: <D12G1NPU2H06.3LBLR19XYUAA6@kernel.org>
Cc: <robh@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
 <conor+dt@kernel.org>, <p.zabel@pengutronix.de>, <airlied@gmail.com>,
 <daniel@ffwll.ch>, <maarten.lankhorst@linux.intel.com>,
 <mripard@kernel.org>, <tzimmermann@suse.de>, <matthias.bgg@gmail.com>,
 <shawn.sung@mediatek.com>, <yu-chang.lee@mediatek.com>,
 <ck.hu@mediatek.com>, <jitao.shi@mediatek.com>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-mediatek@lists.infradead.org>,
 <linux-arm-kernel@lists.infradead.org>, <wenst@chromium.org>,
 <kernel@collabora.com>
From: "Michael Walle" <mwalle@kernel.org>
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>,
 <chunkuang.hu@kernel.org>
Subject: Re: [PATCH v2 3/3] drm/mediatek: Implement OF graphs support for
 display paths
X-Mailer: aerc 0.16.0
References: <20240409120211.321153-1-angelogioacchino.delregno@collabora.com> <20240409120211.321153-4-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240409120211.321153-4-angelogioacchino.delregno@collabora.com>

Hi Angelo,

On Tue Apr 9, 2024 at 2:02 PM CEST, AngeloGioacchino Del Regno wrote:
> +static int mtk_drm_of_get_ddp_ep_cid(struct device_node *node,
> +				     int output_port, enum mtk_drm_crtc_path crtc_path,

Not sure what's your base branch is, but "enum mtk_drm_crtc_path"
was renamed to "enum mtk_crtc_path" in commit 9e149879038f5
('drm/mediatek: Rename "mtk_drm_crtc" to "mtk_crtc"').

> +/**
> + * mtk_drm_of_ddp_path_build_one - Build a Display HW Pipeline for a CRT=
C Path
> + * @dev:          The mediatek-drm device
> + * @cpath:        CRTC Path relative to a VDO or MMSYS
> + * @out_path:     Pointer to an array that will contain the new pipeline
> + * @out_path_len: Number of entries in the pipeline array
> + *
> + * MediaTek SoCs can use different DDP hardware pipelines (or paths) dep=
ending
> + * on the board-specific desired display configuration; this function wa=
lks
> + * through all of the output endpoints starting from a VDO or MMSYS hard=
ware
> + * instance and builds the right pipeline as specified in device trees.
> + *
> + * Return:
> + * * %0       - Display HW Pipeline successfully built and validated
> + * * %-ENOENT - Display pipeline was not specified in device tree
> + * * %-EINVAL - Display pipeline built but validation failed
> + * * %-ENOMEM - Failure to allocate pipeline array to pass to the caller
> + */
> +static int mtk_drm_of_ddp_path_build_one(struct device *dev, enum mtk_dr=
m_crtc_path cpath,

likewise

> +					 const unsigned int **out_path,
> +					 unsigned int *out_path_len)

-michael

