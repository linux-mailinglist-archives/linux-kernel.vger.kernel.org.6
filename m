Return-Path: <linux-kernel+bounces-439085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 776DD9EAAA1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 763A1165E63
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 08:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D6C2309A2;
	Tue, 10 Dec 2024 08:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QDY0w44Z"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688F717BB2E;
	Tue, 10 Dec 2024 08:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733819305; cv=none; b=Q2rW2lSOm26BFFcNG8dS/R4Mb/d/M8Y2xmzRHCAWRfQlymElFArTx88Au476gYL1ZsUk5o2c273z8bU7/lGAYvVOJqCdM0ow1lv7XH6CPkZunEbpBxz9xAW+BmIz+LvjF/jFVdd5w1yLSWqWKEEFeN/961ilpqDo1TuGbdMhbmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733819305; c=relaxed/simple;
	bh=JAJnXN8bBdhYdQ/D5sdJYu6r3kVicg6yAw2GqQbHqDA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oIB05Jba0abCqbrdRtNG4m1GQuaDem4hMpLjXuvp1SBX41iIx+Z6dZ574SQakNmG1l5vV371GErDEj42JZnw/QjN47VHnqKHv/4sPBc4ujgvdrmmIsfrOX2zI+HGM0H50SaxodTr3cfN+V7FJNd3zdA0wUMLr7qY5I+7Pg7/YZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QDY0w44Z; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733819301;
	bh=JAJnXN8bBdhYdQ/D5sdJYu6r3kVicg6yAw2GqQbHqDA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=QDY0w44Z9C66AxZcorRtoN/MyPG2BJu+TLazSwOydgVLK2cKVf/fT9TflIXAYfvR5
	 ZptBBKxr8Ke31ony/BXRVRbVBidS2M0d4ihB09VhgYx/kDZFc7K99gid6RjZC88t3U
	 POSnwhtlw5N6a2yZgBAnhVca808bwNzaEG3M1l2FOXYDCfVW4XwSlZvaDYdxhkJEaT
	 GDzteT1q77/FJ+E/i0558/1mIJcAZ2L7a6F2sRSB/FP7oqAI68yWI88O+jqtpIzi5Q
	 /rfH1TaR6gSPalkZTjaWjVpCJVLDCalKs7tl1CjYEnCuz4irIpDuFzp7frtBgPWJoh
	 gvyF7kbTSZ6hw==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0D80F17E1323;
	Tue, 10 Dec 2024 09:28:21 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Allen-KH Cheng <allen-kh.cheng@mediatek.com>, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Cc: kernel@collabora.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Wojciech Macek <wmacek@google.com>
In-Reply-To: <20241106-mt8186-suspend-with-usb-wakeup-v1-1-07734a4c8236@collabora.com>
References: <20241106-mt8186-suspend-with-usb-wakeup-v1-1-07734a4c8236@collabora.com>
Subject: Re: [PATCH] arm64: dts: mediatek: mt8186: Move wakeup to MTU3 to
 get working suspend
Message-Id: <173381930097.18469.1229889611395701191.b4-ty@collabora.com>
Date: Tue, 10 Dec 2024 09:28:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.2

On Wed, 06 Nov 2024 16:01:45 -0500, Nícolas F. R. A. Prado wrote:
> The current DT has the wakeup-source and mediatek,syscon-wakeup
> properties in the XHCI nodes, which configures USB wakeup after powering
> down the XHCI hardware block. However, since the XHCI controller is
> behind an MTU3 (USB3 DRD controller), the MTU3 only gets powered down
> after USB wakeup has been configured, causing the system to detect a
> wakeup, and results in broken suspend support as the system resumes
> immediately.
> 
> [...]

Applied to v6.13-next/dts64, thanks!

[1/1] arm64: dts: mediatek: mt8186: Move wakeup to MTU3 to get working suspend
      commit: 253b4e96f5783fddede1b82274a7b4e0aa57d761

Cheers,
Angelo



