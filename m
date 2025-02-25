Return-Path: <linux-kernel+bounces-530814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C56A438B6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0654816CD2E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C42267710;
	Tue, 25 Feb 2025 09:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="I9iwetpJ"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6414C261588;
	Tue, 25 Feb 2025 09:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740474158; cv=none; b=Z3d3Fag47BjkmHgBX1d/xnYkhucnAkW765XZIM+i4gzG5aqPbOV4uQ6ai2EXMGb43xUCW9QtXxHZ32gn3lx2IjGDelyqCvs5rSNqfaB61aTh7j0/ABpLQ1BS38gTP5Wx997ivtm9QQ9UOG6P1CV5gakZzt8bpJodUiuuI/R+g6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740474158; c=relaxed/simple;
	bh=JZ65kyyb42EYs7pE3JmcICyKoed4JwUuRQyyeLuWluo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bMpdBVX0hL+f3/+jB1yq0P+zs3Vj4MS1vr+STvC5RbKyHtsi5DLHJe+XQstX8yDj9rnbwa62wJ7K2mBTqh4ilmuk3rhR5HdAE1JPwTttLznklF8pCgEPRA/LP7NclLlCvcmZisUIh26xplYGyW44PpDRJM/ih7gDodlp+D/eY5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=I9iwetpJ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740474154;
	bh=JZ65kyyb42EYs7pE3JmcICyKoed4JwUuRQyyeLuWluo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=I9iwetpJ/xmLEUngxZav8VV48HxmV3ZZI/mpK6muc09p+Y1KOfUmNWAcmcddE7MNk
	 UBw95YeRj19GLoZRZXQatGHCQ04Aq3YQ0QMemn3IP3ajiQY9kZLl8dzfr2TkhkkxFG
	 Uxg4WV5OlM4LZ/r/NjeSZ4mGTULvyKgZpXArZBU8aV+HeLuoiQRBql+DgMCrdt3xGU
	 iXjlZoQsFHldHP9ITwaEsKr8V4hpHS3JL+A82BzY4pp0s6wTaFWfYqUsL0E6xmUEnA
	 it69Q2aT8dVEuPrfN4SAofTtXBrvug/Qw6VcTcViEz2kgqB/1ulQcyCWls6sOye09q
	 ACrj7LQyRtz3g==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 74C9417E0DD7;
	Tue, 25 Feb 2025 10:02:33 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: ChiYuan Huang <cy_huang@richtek.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 Alexandre Mergnat <amergnat@baylibre.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>
Cc: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>, 
 Macpaul Lin <macpaul@gmail.com>, 
 Project_Global_Chrome_Upstream_Group@mediatek.com, 
 linux-usb@vger.kernel.org, Chris-qj chen <chris-qj.chen@mediatek.com>, 
 Fabien Parent <fparent@baylibre.com>, 
 Yow-Shin Liou <yow-shin.liou@mediatek.com>, 
 Simon Sun <simon.sun@yunjingtech.com>
In-Reply-To: <20250224114934.3583191-1-macpaul.lin@mediatek.com>
References: <20250224114934.3583191-1-macpaul.lin@mediatek.com>
Subject: Re: [PATCH v6] arm64: dts: mediatek: mt8395-genio-1200-evk: add
 support for TCPC port
Message-Id: <174047415339.19243.12568175700223517936.b4-ty@collabora.com>
Date: Tue, 25 Feb 2025 10:02:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Mon, 24 Feb 2025 19:49:34 +0800, Macpaul Lin wrote:
> Enable USB Type-C support on MediaTek MT8395 Genio 1200 EVK by adding
> configuration for TCPC Port, USB-C connector, MUX IT5205 and related
> settings.
> 
> Configure dual role switch capability, set up PD (Power Delivery) profiles,
> and establish endpoints for SS (SuperSpeed) and HS (HighSpeed) USB.
> 
> [...]

Applied to v6.14-next/dts64, thanks!

[1/1] arm64: dts: mediatek: mt8395-genio-1200-evk: add support for TCPC port
      commit: b232a43b5c60a0c994cb486792d4f4c80199052f

Cheers,
Angelo



