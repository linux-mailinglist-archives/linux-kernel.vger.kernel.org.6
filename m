Return-Path: <linux-kernel+bounces-442901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C989F9EE3AC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 11:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10DA7188BA24
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 10:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D39211490;
	Thu, 12 Dec 2024 10:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="CMNjt9Kr"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E72C210F6A;
	Thu, 12 Dec 2024 10:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733997898; cv=none; b=RBfFMIV9jzH4MmzvCY+dUgKXdWiy86mLwJh+2NajXRJ9N9Hp/TxxH005smiNQehYpe/cFOWE4Obg2SNbF89rfN/6n86w4aWI814wWnoLUKFt0F7Dq4LQkAlsw3zjIkNCpz/YfCQaR/hd8tPwfr/Pel+LqTyFMXwSBEqvHb+ix7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733997898; c=relaxed/simple;
	bh=BJAKUmR3xWQ9qzG9ppN4jAGJ2iMpKpc+JdEgddk4Bxc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nJNwz6uLsDLLG3LbzWzltIDtyzx5K8f4n4kLsCsRSiFcFLD+OWMO5fLrtl8g1OM/ZZGbBGilq6Zr5IXsYvyV46Cu0X8V2cI8+w5sXG6WdPXoKrr9Tf2jGg4XNRyoEKTYFHq2Emhz/EbM/bsUvPXxOfJpnkVR1P7qIF0ZjHO2GgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=CMNjt9Kr; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733997894;
	bh=BJAKUmR3xWQ9qzG9ppN4jAGJ2iMpKpc+JdEgddk4Bxc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=CMNjt9KrL72tAJutKI5akwTGiPtV6M1Dw//IwYzpHNQ+Bpu+qBxRkFNBlhPrveAYa
	 rBReguwRxy/uMP6x3OxHNW1bh5QK1Yyv9GTx/OlqSaFcw36N/sYEJPFJFSuWbVqwWQ
	 m5J0utModagdtptTLzcd4OUwddtYjuqJWpOjE22FND305Zgabj/g/Dt7w+E2Oft6bX
	 wGSn5T78mWTQCPop8xryfvmYMOR02cAMaID28/TxBw8HypbfxZVuSqiStMFHdILvm4
	 dYCoo/EmQdb4uO41W6Zn+SV+9lnvEijtKbQN6uzirXuEVILHCNhU3++Em5kbNNzGCe
	 ypTIMmExhTaOA==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id BDEF517E35FA;
	Thu, 12 Dec 2024 11:04:53 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Trevor Wu <trevor.wu@mediatek.com>, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Cc: kernel@collabora.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-sound@vger.kernel.org, 
 Aary Patil <aary.patil@mediatek.com>, 
 Suhrid Subramaniam <suhrid.subramaniam@mediatek.com>, 
 parkeryang <Parker.Yang@mediatek.com>
In-Reply-To: <20241210-genio700-audio-output-v2-0-c50886ae0be2@collabora.com>
References: <20241210-genio700-audio-output-v2-0-c50886ae0be2@collabora.com>
Subject: Re: [PATCH v2 0/2] Enable audio output for Genio 700 EVK board
Message-Id: <173399789370.41280.16875335834079584278.b4-ty@collabora.com>
Date: Thu, 12 Dec 2024 11:04:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.2

On Tue, 10 Dec 2024 17:54:27 -0300, Nícolas F. R. A. Prado wrote:
> This series enables audio output support for the Genio 700 EVK board.
> Patch 1 adds the missing #sound-dai-cells property in the MT6359 node as
> a prerequisite, and patch 2 describes the audio DT nodes to get audio
> output working on the two audio jacks, Earphone and Speaker, present on
> the board.
> 
> 
> [...]

Applied to v6.13-next/dts64, thanks!

[1/2] arm64: dts: mt6359: Add #sound-dai-cells property
      commit: 9bc8353be720ca1f9cb6e03825929bc172e1157d
[2/2] arm64: dts: mediatek: mt8390-genio-700-evk: Add sound output support
      commit: b8457716eeee45ed5cb6b8fdc5a5b459f7ebe819

Cheers,
Angelo



