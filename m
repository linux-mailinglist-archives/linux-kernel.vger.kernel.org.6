Return-Path: <linux-kernel+bounces-528695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A00CFA41AE9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 11:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D5363B0F57
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489D224E4DA;
	Mon, 24 Feb 2025 10:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="g5WEDT6e"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F2924BC0D;
	Mon, 24 Feb 2025 10:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740392859; cv=none; b=PCRby4F26byfliJwCAV+nEDTpZEvWnxUeRmm0LcYEPkR77KxZB6FQCAo6iVImVyR+paXHeI7CqYYVtoCllbajLoACN409Q7SXgr5V2GTNb0vsJToyHwxAWwb0fAMPWM3p9YtGB5kCVfKr2nevlOYkg/btPayD+hHfFSJIKPgwzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740392859; c=relaxed/simple;
	bh=58mOQSEzO1TyVtwzbSqqgxMRd/iPYGw37WbmD25YxWk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dYPcHQmPx0Fhx0wuqwLyjZchLj4fRwBngYbJBmekVZG77fHNX24MflCsA2Bi9CwsXY56ZcY2VZd6YJufmoj6+9kK4fikU9uFUvtydcVOizOKfT3dhleKc7rPj200gh9rKYqkm1dD0sUZ9Q1Nk2gSxPwP04SS9hlhq9PK58um5/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=g5WEDT6e; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740392850;
	bh=58mOQSEzO1TyVtwzbSqqgxMRd/iPYGw37WbmD25YxWk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=g5WEDT6ebSXT+N7vc6Re2Ur1ATaIdAxQByD4Atsi5Wp1+AFdnuESgEbgUKJDohOeV
	 yEevjWJLx29bbZh1KIw+izJt28pYTU8Z9DGNAWAqCHNaATYhn4k9RH/I2di9KN7GlO
	 regBIXKzP0ebx7TokhwHzNp0u8a7gkJxk6xG0whoQcCok2dBIg6NUOVUro4JluBd8y
	 72FXW9i3rf89pgPPfKfpdWEBrn9/s99Ze7cP7JduMJfbsZo/dszEB8S1EqTHreC7Yc
	 OFWQ8Tg3+QFhakC59Tlc49lUUHEPT1dqdb9sr0jw/euLP1VSv9NCoRo7/yc+cmmj2p
	 NvVs6vPm4beIA==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E2BF617E019E;
	Mon, 24 Feb 2025 11:27:29 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Cc: kernel@collabora.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org
In-Reply-To: <20250221-fix-mtk8390-genio-common-dup-regulator-name-v1-1-92f7b9f7a414@collabora.com>
References: <20250221-fix-mtk8390-genio-common-dup-regulator-name-v1-1-92f7b9f7a414@collabora.com>
Subject: Re: [PATCH] arm64: dts: mediatek: mt8390-genio-common: Fix
 duplicated regulator name
Message-Id: <174039284983.36653.14029465967864965883.b4-ty@collabora.com>
Date: Mon, 24 Feb 2025 11:27:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Fri, 21 Feb 2025 09:49:52 +0100, Louis-Alexis Eyraud wrote:
> usb_p2_vbus regulator has the same regulator-name property value as
> sdio_fixed_3v3, so change it to avoid this.
> 
> 

Applied to v6.14-next/dts64, thanks!

[1/1] arm64: dts: mediatek: mt8390-genio-common: Fix duplicated regulator name
      commit: 8020b233c6f166d703ee1d3b065fee502bccb8f5

Cheers,
Angelo



