Return-Path: <linux-kernel+bounces-219226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6446290CB96
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6080E1C23087
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 12:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0F313AA47;
	Tue, 18 Jun 2024 12:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="LkPMKPiF"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A492360B96;
	Tue, 18 Jun 2024 12:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718713398; cv=none; b=owzMgeUiHwluS3RxrTQDhDIvpUKN1JreKKhcz55RI31xFyzaq0TF31g01Wpxz8ePUtqYagaHaWVEJAP94NYZR2CRHTZOkpkK5htrx6LnZUcqHZAw4Obg6TqwyYTIiYYz9MdPsTaFsQRRUMuE2IC4S9o3TaSw1iHBayWsEhvVHsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718713398; c=relaxed/simple;
	bh=sDNNMxHKly7zct6ZWmT2pOfsBogVmKdEYEa+jqhZDsM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=I+LnuEjVO6W0lcSN0sZx3J6qk8z7UivMJhtBNvaXd/nc0BRp+IQOeHcpXWN0ssUkY+63gst/nvRllEMMxt2SvyiaxRTwOVQI1qV9k2a8RqvcoT/JmMOf5zB58I+j6F9nOr/Ybw80OI3FigA8MyraIRy+STUU2iOeueqyIdpcak8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=LkPMKPiF; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718713394;
	bh=sDNNMxHKly7zct6ZWmT2pOfsBogVmKdEYEa+jqhZDsM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=LkPMKPiFHomCePvAx5JBn8CLyrLA7r0lAmXDi2iS8RF5He7N8yfqAFzuiiOZXAQEh
	 UbMejr7mdgO6TPIuwV/mQjBLr/9Ez07BLH3in8TbV3ZyXTuPtIoohRq5bRLa8XF2rM
	 nTYUPUs6HoRZ16QiDoOr9DE38UTVQ2H7ZqadAw4rohgYDCDuxWY7u1oEqpxCoZaG48
	 //suJowzjz9mU0nukHVZSFaaVo+6Y7khz+fH7qi7c/DOP1z3QCJ7qDbhEPqoEA1Cb6
	 Dlb0M9Zye08f+CLe/BMQ7rVUQlMD1nj2nLxVTQ6X8dnU81wucNDObONNuD9NTJrcgl
	 SxgmR0CExI6jg==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 06F3D3780BDB;
	Tue, 18 Jun 2024 12:23:13 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, Heiko Stuebner <heiko@sntech.de>, 
 Hsin-Te Yuan <yuanhsinte@chromium.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-rockchip@lists.infradead.org
In-Reply-To: <20240613-jack-rate-v2-0-ebc5f9f37931@chromium.org>
References: <20240613-jack-rate-v2-0-ebc5f9f37931@chromium.org>
Subject: Re: (subset) [PATCH v2 0/2] arm64: dts: Fix the value of
 `dlg,jack-det-rate` mismatch
Message-Id: <171871339394.163370.9266867043922843876.b4-ty@collabora.com>
Date: Tue, 18 Jun 2024 14:23:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Thu, 13 Jun 2024 11:58:53 +0000, Hsin-Te Yuan wrote:
> According to Documentation/devicetree/bindings/sound/dialog,da7219.yaml,
> the value of `dlg,jack-det-rate` property should be like "32_64" instead
> of "32ms_64ms".
> 
> 

Applied to v6.10-next/dts64, thanks!

[1/2] arm64: dts: mediatek: mt8183-kukui: Fix the value of `dlg,jack-det-rate` mismatch
      commit: 1b0c5a724d726e533ead9580de696bb705dd2e4e

Cheers,
Angelo



