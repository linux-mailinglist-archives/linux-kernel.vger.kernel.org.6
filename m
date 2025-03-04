Return-Path: <linux-kernel+bounces-544482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80EC6A4E176
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBA227A8E13
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D47F25DAE1;
	Tue,  4 Mar 2025 14:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Wf4K4wtZ"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD61206F1F;
	Tue,  4 Mar 2025 14:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741099423; cv=none; b=ur2aXS5qMcCSqGrPczHUiE/sN5n0oDk/E8u1+wbzo0iKF5n7v8/xUq+uakholEYMFsHxU/eLWSoOX2LFMoNtqzJnkualsUDMtl4rTYMeSy/3yCCp6k0EkQl/Q3czt0GyVQFsl7/JtPhkKWpCG09AAo2cnZxR0vIivXE2laP+29M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741099423; c=relaxed/simple;
	bh=/wlsvCjXB/lXANM/QCjInlVw2O2/9Yak7eLwi5z4EBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZioRhYlGYq8xc+Ox/1zBvA8D0GXj/VAMo927N3kLJKNH9GpfpfkEIRzMUlWDHusRsyh8l49I8/KQ7oY6zMtfP4+8fqESi0vTFrMxxmgNsgmA5TbkFEp7QSUSXoalTQ8km7ZX4fsaHhOgHTLih7offHvjBYKQR375QKm4NF6T84M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Wf4K4wtZ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741099419;
	bh=/wlsvCjXB/lXANM/QCjInlVw2O2/9Yak7eLwi5z4EBw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wf4K4wtZ6/3lqk900g5ki5m7Y+8HU/IS9qxC2UQGt8wMZ7x+NgukZ8NRShY6/h+Dw
	 aVo64/sgVCm1cctLK8IMqlZv6EbFEtOE6YMVY06RMSjBM8vrLoEVjiTh0BCqe7AB2X
	 aXQXIZQt50BVUG9kdWPz8k/4EXzAgXU7D2M6XfF3XYp/htUbBnsP2cp5zVGAlcR4Ii
	 sl4LUj5/SSYBiUDPOA/Zyz6T6tzPw0Uf6nAnpim4DIMaCTrl6G6n8kUmH5MpDQFg/i
	 Zac3XAZHAoYteGZfxxrnsRcndspGwJZ7n2w97ayuz9dWKxI0FCuc2qd0wsC6M4RuId
	 KVGj0R4e43x2w==
Received: from notapiano (unknown [IPv6:2804:14c:1a9:53ee::1001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7279817E0E8E;
	Tue,  4 Mar 2025 15:43:35 +0100 (CET)
Date: Tue, 4 Mar 2025 11:43:32 -0300
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: neil.armstrong@linaro.org, quic_jesszhan@quicinc.com, airlied@gmail.com,
	simona@ffwll.ch, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@collabora.com,
	pablo.sun@mediatek.com, christophe.jaillet@wanadoo.fr
Subject: Re: [PATCH v2 0/2] Add driver for Himax HX8279 DriverIC panels
Message-ID: <93076513-3bda-46f3-baa1-51d7e02f24c3@notapiano>
References: <20250218143952.84261-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250218143952.84261-1-angelogioacchino.delregno@collabora.com>

On Tue, Feb 18, 2025 at 03:39:50PM +0100, AngeloGioacchino Del Regno wrote:
> Changes in v2:
>  - Removed unneeded mipi_dsi_device_unregister() call for secondary
>    DSI: as the driver is using devm, that's not necessary (CJ)
>  - Removed superfluous if branch as pointed out by CJ
> 
> This series adds a driver for DSI panels using the Himax HX8279 and
> HX8279-D DriverICs, and introduces one panel using such a configuration,
> the Startek KX070FHFID078.
> 
> This panel is found on the latest hardware revisions of some MediaTek
> Genio Evaluation Kits, and specifically, at least:
>  - Genio 510 EVK
>  - Genio 700 EVK
>  - Genio 1200 EVK
> 
> This driver was tested on all of the aforementioned boards.
> 
> AngeloGioacchino Del Regno (2):
>   dt-bindings: display: panel: Add Himax HX8279/HX8279-D
>   drm: panel: Add driver for Himax HX8279 and Startek KD070FHFID078

For Genio 700 EVK:

Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Thanks,
Nícolas

