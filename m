Return-Path: <linux-kernel+bounces-227062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6599147D1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 12:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1B17B23279
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 10:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214616EB55;
	Mon, 24 Jun 2024 10:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="3VUGTKEL"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F6F1805E;
	Mon, 24 Jun 2024 10:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719226021; cv=none; b=ntKPwa3ezIHQn8zClPMUCsM9yNzmFskysAN2Id7M8+WDass9+yAlXouOWg4R4sPv9AJIFDsGA4jqf/E/1crQkv7wA4NvCFXKjsDC0MEfqYa3H9E3/Y9jFW8c3PweJV0nOnOpue/zWgEuno1G+oIZ5KIUny3wDORJggWQJqZqkOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719226021; c=relaxed/simple;
	bh=N7etgN4r7YuHpbryZAGdUzymvIiOw4YteMinJ/UaOK4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PvisfCE13yo2y+6R08rYD1lYj/HUmQfTCqg+H3MieY49RP57BXw0yHH7njWBWLV9zeh0zkLty/9bbwA31LYj6RMBbxa+HFFj36grptqWwZpZFrI5PyjYQ645hr32W40njYD/S2amnQCRIORzDkKAxHpLbicQTS7mUBvgY7rAdqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=3VUGTKEL; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1719226018;
	bh=N7etgN4r7YuHpbryZAGdUzymvIiOw4YteMinJ/UaOK4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=3VUGTKELcesK7vW3Vfh9zckFAGkd1lPhlvMXAzyUaUP2SpDveHFMeXilidTM6mXux
	 YlCDs1eIqQCfD3+Q9a8T0FB/n7ayVJ4Vf/j7JNmAXJ1M/1u27jWiFCrWGgy0iCfcPK
	 TJotqDfSaL8F1zuzbf6T7iVgBj6EbC4CSQ7Q1w4mzLHjkRqcdSPW3ytbdPdaYNYQ8T
	 gPvTlrbbqmsa/wpSbIt0VkgydO49vXCw9BQmEkl5zJCCRWNFOO1HLm6J9Nvwfqe187
	 TaAyMu+na7LRWI3kXWMoMnrazYAaGLjugbgi6cAe5xBc4gJIHewb7jieqmhkiaP80o
	 d+vsdCy46/nQQ==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2D54C37804C6;
	Mon, 24 Jun 2024 10:46:57 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: krzk+dt@kernel.org, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, 
 conor+dt@kernel.org, matthias.bgg@gmail.com, jassisinghbrar@gmail.com, 
 garmin.chang@mediatek.com, houlong.wei@mediatek.com, 
 Jason-ch.Chen@mediatek.com, amergnat@baylibre.com, Elvis.Wang@mediatek.com, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, kernel@collabora.com
In-Reply-To: <20240619085322.66716-1-angelogioacchino.delregno@collabora.com>
References: <20240619085322.66716-1-angelogioacchino.delregno@collabora.com>
Subject: Re: (subset) [PATCH 1/3] arm64: dts: mediatek: mt8188: Fix
 VPPSYS0/1 node name/compatibles
Message-Id: <171922601711.121709.12074465182183603791.b4-ty@collabora.com>
Date: Mon, 24 Jun 2024 12:46:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Wed, 19 Jun 2024 10:53:20 +0200, AngeloGioacchino Del Regno wrote:
> Like VDOSYS0/1, the VPPSYS0 and VPPSYS1 are syscon nodes, as
> described by the mediatek,mmsys binding: fix the node name to
> be syscon@address and add "syscon" to the list of compatible
> strings for both VPPSYS0 and VPPSYS1.
> 
> 

Applied to for-next, thanks!

[1/3] arm64: dts: mediatek: mt8188: Fix VPPSYS0/1 node name/compatibles
      commit: 013b7ab4080af0dccae16c6ea8a1e88ad530114c

Cheers,
Angelo



