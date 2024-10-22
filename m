Return-Path: <linux-kernel+bounces-375986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E779A9E37
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 11:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 172DD1C24223
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 09:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C510199FDD;
	Tue, 22 Oct 2024 09:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="hrv773sf"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D69146A97
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 09:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729588575; cv=none; b=TReRHCKY565Y7VbvhyuRgd2lxWmbL9DxGWYB3flJ7ekCK1mCWK+x67q9IyBHWQ10NdVVBFj1vsXZRMKo/z57fy/8bK28RDmSAgCSKb6vu4obsUo4Ewub5Ot+VdbfgXm86NPfgr9jje4XWTIGlAqC8SvnGpnV9bD1J2WTjoJugJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729588575; c=relaxed/simple;
	bh=dKnWBCt7LzZ5FtFGlHAJYJJx3XRxPgfuRNhgjoZdFnw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cC4uUw481XRstwoqG0SOrkvnkQkoRvJrFyrr0+SHmEol6Z2qLA71UiRxeR/BfUvlYMERJ0TB8ruOv5Pmis4cuRp/Jia8useDARnR7Ns2mueqQkukMav5EXBzFIzzwmWt+ufqo81IVwQbYNYte8xn1S3d24Lnj+09TNEplZz6jws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=hrv773sf; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729588572;
	bh=dKnWBCt7LzZ5FtFGlHAJYJJx3XRxPgfuRNhgjoZdFnw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=hrv773sfMTS9T2djR2/3Emq3wlCozUAckSYY9L5rgzXDnsO9FA/4EGyHu36554z9w
	 tDdsknD92cfSmtRou0ZrQ6X2rTKCggn5Q0YdiAGIHqO3k2Hxd5AsF0T/NzVDMTAKoD
	 hh+i4zeBWuxv+4uIlAMILWtm8EEPhmDCN6rMCJVn0mdA5jWZ9V8KSWPBheMlnS7aF7
	 NZeZFTpk9a91Yqv3iCVi9aXt0+CTVwQmNo6Eu9PibNP0ZadLiGxGeUeu0y/aMqPN5h
	 GRZLGSXbugWEKep9dKJtvykC0PutjSIgIXCyuERzNJ3CWy/IhhD5Nn6/lHSQnxhrP8
	 o7iY7T17XTBcw==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id EB2BC17E1394;
	Tue, 22 Oct 2024 11:16:11 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Matthias Brugger <matthias.bgg@gmail.com>, 
 Fei Shao <fshao@chromium.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-mediatek@lists.infradead.org
In-Reply-To: <20241021114318.1358681-1-fshao@chromium.org>
References: <20241021114318.1358681-1-fshao@chromium.org>
Subject: Re: [PATCH] arm64: dts: mediatek: mt8195-cherry: Use correct audio
 codec DAI
Message-Id: <172958857191.72613.13695952777293754508.b4-ty@collabora.com>
Date: Tue, 22 Oct 2024 11:16:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Mon, 21 Oct 2024 19:39:33 +0800, Fei Shao wrote:
> The RT5682i and RT5682s drivers describe two DAIs: AIF1 supports both
> playback and capture, while AIF2 supports capture only.
> 
> Cherry doesn't specify which DAI to use. Although this doesn't cause
> real issues because AIF1 happens to be the first DAI, it should be
> corrected:
>     codec@1a: #sound-dai-cells: 1 was expected
> 
> [...]

Applied to v6.12-next/dts64, thanks!

[1/1] arm64: dts: mediatek: mt8195-cherry: Use correct audio codec DAI
      commit: 7d5794e6d964940e46286fadbe69a3245fa51e44

Cheers,
Angelo



