Return-Path: <linux-kernel+bounces-530825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2504BA438E9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CE7117C1E2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B768266B43;
	Tue, 25 Feb 2025 09:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="oStsbuEz"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8797B265CA3
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740474322; cv=none; b=IOnDofxdrhgpsHMf8N4meTALSLoW23IATE+1ur4ghlsScPBZU04/w69uV209czwFOOfGRZDuCk5E2TYrzToxO17Gnk95PuyAbzPQ5ajg4ubQ2BWT0g3u8M9f4NihLShvd047RphjgIbhTDvPUYyH5I3DvDvHUq0yNnVJ5AJC5+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740474322; c=relaxed/simple;
	bh=lk3BYwntCJ0BLjT+Ae8fo9enQLjePlvLMz51aun1oIU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=E/DbYg1y2mop401bQrATxnQkKbAMmqxQn9fwTkDcOniqQn8/1Lt/C+6U+/u58QVVupRZJW+Gt4chl97NR8C+htQ5/B9NJHz+obGX9bJ8hFDfPC71xI5xe2MuzyODfvRBBMRKqRAIJHd9+jzqh8i/iHpD4fnUmI+ZHgsMnWCvH+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=oStsbuEz; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740474318;
	bh=lk3BYwntCJ0BLjT+Ae8fo9enQLjePlvLMz51aun1oIU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=oStsbuEznWGEwvh/4VTuaJefqJvEOLhoa75payzjQos2CcGGHrnoqoah18V2Si9Fc
	 u5BAfEEjtkp0Ftuhn+E4uzHhmSEe+lxR4RgicBWZ+X5C4NLwE1/z0rDw/jbnqyr6Tw
	 WhnmD6g4vjFD+dOCu+nTz5jJ4GLihvtMV/cvmmeOfZah5wJanP3pHMZB5gNz9VtPrM
	 lULALHwDk1jfwh9/bKI8JH5AgDT1qDiT316nPE2IlE5GSnRlOHxXrwX3ttVzcADP3k
	 VPie5t4RgpiLxhXZzexwXNxkmqNp+MB0qAn2kDCBYtMv3w1P638ErLRSb6uU9F3Tk3
	 RUAdqOV5HWX2g==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4FF7517E0B13;
	Tue, 25 Feb 2025 10:05:18 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Matthias Brugger <matthias.bgg@gmail.com>, 
 Fei Shao <fshao@chromium.org>, 
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
In-Reply-To: <20250221-mtk-socinfo-fix-print-v1-1-20500f30ef66@collabora.com>
References: <20250221-mtk-socinfo-fix-print-v1-1-20500f30ef66@collabora.com>
Subject: Re: [PATCH] soc: mediatek: mtk-socinfo: Avoid using machine
 attribute in SoC detection log
Message-Id: <174047431824.20024.2432870807445431455.b4-ty@collabora.com>
Date: Tue, 25 Feb 2025 10:05:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Fri, 21 Feb 2025 12:04:02 +0100, Louis-Alexis Eyraud wrote:
> The recently introduced SoC attribute info rework avoided modifying the
> machine attribut but still used it in the log message on successful SoC
> matching. It leads to print a confusing log about a board-related info
> (read from devicetree) and not about the matched SoC:
> ```
> mtk-socinfo mtk-socinfo.0.auto: MediaTek MediaTek Genio-510 EVK SoC
>   detected
> ```
> 
> [...]

Applied to v6.14-next/soc, thanks!

[1/1] soc: mediatek: mtk-socinfo: Avoid using machine attribute in SoC detection log
      commit: 02b916592319fdb336925df75415d98481dca300

Cheers,
Angelo



