Return-Path: <linux-kernel+bounces-198725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 421148D7C96
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 09:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73A541C21F08
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 07:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F27482E2;
	Mon,  3 Jun 2024 07:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="OHfCVhR1"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807E357CAA;
	Mon,  3 Jun 2024 07:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717400305; cv=none; b=lhbuzfW3WzhrvUjIoR+Q4R4RXVe75/Y/IlVK2JDlJWKEgkiglrwD2PrdlAzXMWw4y7S4fzrxKo3yhSoOXD/Y4T66OSSFX1KgSbhu5qLIMeQTUo50molDKInxl5IhYSLDk1kTxtOA3Z1FScc5tUGvx3lEcLyYjqKzkP6Qv9m+5Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717400305; c=relaxed/simple;
	bh=MO/bg2lUysHDnzNR2PasarKRJ1k3eMDsfB4gIHLqeU0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pbMZ0gvNuqKchujZR/J0ZkSSnrMpTWe2ztlCtQgLNJj84qKuuz205D1jaj72G3vw9RHhaxV5y8Dj5yE3kMaHyVuv+tZ3gWQSzrCVg52PeK4cKimF6fbSrFivIm7Ns7lDORPGArmQgtkPqyYkGMsVHRkG2Jv9eV/c+TkQTHaGyBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=OHfCVhR1; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717400303;
	bh=MO/bg2lUysHDnzNR2PasarKRJ1k3eMDsfB4gIHLqeU0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=OHfCVhR1MDLQeVGUMvEwKtcbPbte26pJT4mSbfqrp2JjfFf4i0JAY16G8DBVbaSzt
	 KZup/Xr/CJX/d6zND+2HE80bOwtML+RApq3Olg68cKeHis4w2gCiwSvoZsHptwKFUE
	 wP0pFRTFFOvpvRLjOHu8pP0Nw8OPv6tlH9Lj1yjiQNhZJCfWzEMECoaPLhjdXKwnD3
	 LCXP1M7tEYUhFiZVUbc7rL1AOWvMya2QYc2dmarXPknL+FCV3RF3+Kmc8j5slvWSxb
	 KHmnNUzpSNXKlCGGu9W5qrlwqFCi7WKs6JSNM/+og8CPbJlOOJRL9EyUA1wZvkcX5+
	 0duIqufejkB8A==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4702537813CA;
	Mon,  3 Jun 2024 07:38:22 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Matthias Brugger <matthias.bgg@gmail.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
In-Reply-To: <20240405105030.24559-1-zajec5@gmail.com>
References: <20240405105030.24559-1-zajec5@gmail.com>
Subject: Re: [PATCH] arm64: dts: mediatek: mt7981: fix code alignment for
 PWM clocks
Message-Id: <171740030220.40780.11151270257229150635.b4-ty@collabora.com>
Date: Mon, 03 Jun 2024 09:38:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Fri, 05 Apr 2024 12:50:30 +0200, Rafał Miłecki wrote:
> Align "clocks" array entries to start at the same column.
> 
> 

Applied to v6.10-next/dts64, thanks!

[1/1] arm64: dts: mediatek: mt7981: fix code alignment for PWM clocks
      commit: 8e062a6ccab30ee3775efe5c291d61ed7786b761

Cheers,
Angelo



