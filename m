Return-Path: <linux-kernel+bounces-531564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBE1A44203
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58FD3176030
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA6126BDA2;
	Tue, 25 Feb 2025 14:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="hMt8Tiqy"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855EF2686B3;
	Tue, 25 Feb 2025 14:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740492482; cv=none; b=a+9SKpRChuT7GRsq7ccE85aiQgljUqb8T/PaIwi8P8d0RhntItReVyePOpUD40BaUtDjfvIelLAvHjmXteKOa6ldDsBC4qNgmvnDelvhbRsOgaM04XfNa7ApgENonzngeOxmpZrJFvSWC9KkE39RrybkJ02PqK0X/ZEz5iePgyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740492482; c=relaxed/simple;
	bh=OV9F9KqPwKQyiJmD+vFaweQLR+YT46dDjh77TsIN4zI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oTuoYfHr1jb2ArMblQiI3TK5rbtl+SRiGtmhMxizbXFqi+OG5yqnuOvtJ5xeZq3ZIxq9IW7zkXKpEDjmQOSuKWNX9f6RpZv6qb0xamEeh3Tr+ANVjdEcBs+VQZSWk5oC3RdUu8lUgjCh8KhE69Ae6no3W5bcGBVp1GeOQEFXjOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=hMt8Tiqy; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740492478;
	bh=OV9F9KqPwKQyiJmD+vFaweQLR+YT46dDjh77TsIN4zI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=hMt8TiqyYmncuyjgIQjcxwYxCWnpKDcC+iLbY8xREGK5ksBPnGIm9BBUtn2GPh/h6
	 0dmf4eY6wieIZR6Hx/0SzGeH7azbu8lD7hL+usIe8VMCY5LiJ809XHyBTENCNLI7Uh
	 Gv7md7aiNzD7uehvg3K0stqu+uxr7IUTnmVDsPY+0AljivHEh7RyeB970XmngeYHbl
	 aMRT3w3hT4uIQMQIiZgqAzbApIybx71eU8gBOvCHf+/cqVZUzqq091+64BsYEL6tVl
	 2Esi2q/LastZwWcoqcL2gxAegAHK+y4W/OhSXPUP/4jkKQzKduse5/nTcs4HoTfKaE
	 sqSbJasRTvWWg==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 16CF617E087E;
	Tue, 25 Feb 2025 15:07:58 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: matthias.bgg@gmail.com, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 kernel@collabora.com, pablo.sun@mediatek.com
In-Reply-To: <20250213112008.56394-1-angelogioacchino.delregno@collabora.com>
References: <20250213112008.56394-1-angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v1 0/3] MediaTek MT8195/MT8395 Display Controller Graph
Message-Id: <174049247800.77227.18410008304398234380.b4-ty@collabora.com>
Date: Tue, 25 Feb 2025 15:07:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Thu, 13 Feb 2025 12:20:05 +0100, AngeloGioacchino Del Regno wrote:
> This series adds a full OF Graph for the Display Controller in the
> MT8195 dtsi, and configures the MT8195 Cherry devices to use it.
> 
> This was mainly done to allow different display controller paths
> for the Radxa NIO 12L board (compared to Chromebooks), and this
> series contains a preconfiguration for the DSI0 pipeline.
> 
> [...]

Applied to v6.14-next/dts64, thanks!

[1/3] arm64: dts: mediatek: mt8195: Add base display controller graph
      commit: f49708b18c7d5f3720499141eed326697afec3a9
[2/3] arm64: mediatek: mt8195-cherry: Add graph for eDP and DP displays
      commit: 44d18b4497b335b0e9044dbebd2a2371363a0d77
[3/3] arm64: dts: mediatek: mt8395-nio-12l: Preconfigure DSI0 pipeline
      commit: eb5a199a44f866d5de707f11d579b6517c060185

Cheers,
Angelo



