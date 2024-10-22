Return-Path: <linux-kernel+bounces-375985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 576B79A9E34
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 11:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E020F2816B8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 09:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F84199E9A;
	Tue, 22 Oct 2024 09:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SO8kGZtP"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A2817BED2;
	Tue, 22 Oct 2024 09:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729588575; cv=none; b=ZMerCkU9r8bIBpnRFYLXXC9KirB8kSION2HhdePga7INa2WdBw04fCJBald4faaSAtrUI7FDY9kZWmseOultuMQi2qNfqGGdPrh20CNfzJPOn0c7dyNHkVUtadG6e45BKo/1hTNDi1y0nfBZrrwsIGEk6JJoJUCqIvl615vN7vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729588575; c=relaxed/simple;
	bh=Nx4K4qHhijgkkN36huYLT2ycTLY7lXkDiYfysKifHAg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=twGGnQgN6SPimpcemh8E0nnzIj2EJEmNT+3M5Jgh3efFnCM7gZxdajSVHKgBtfviSzWRrK0ksTZl1pqE4vG1Ax2BJ8XM4SPWOLgsVW2DQkRAgWGFiIkGzu6ytIHikg7/EMutVHZNz4+Hj/uuNmd1y5HpUB95dAEo2imjGkVLz58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=SO8kGZtP; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729588571;
	bh=Nx4K4qHhijgkkN36huYLT2ycTLY7lXkDiYfysKifHAg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=SO8kGZtPX+MyHyxdiQqp0nQPXAE17o02MF1xL8Vf3WOvCHf1rRS8SjtKDsuHkSe2k
	 7O9JO4WPXAdy1WnX6VqU71/EehHrUJkZvaa4HDwB8g4CzpHALAwy3TQYw8zZCwnu44
	 QevXoLw2UzyktMYd/xn0mJG1S8fWzd/rS1z6GZjuXxIvOrt04h8Jh7jJncb/ZA6Ci2
	 cel7ctySV33J/PXAtZVBAWaFVDItIZfecJAwEyMenhqddqLpjUsx63SngpTktC2nXU
	 hlofxSohgPqN1/HkOzJYMNe2MvkjPhAJZLMG1oWwAj7R9tTGC8m+0fPAiE4Wf7MznI
	 keRmUz8HDpJgA==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8CEF317E137D;
	Tue, 22 Oct 2024 11:16:11 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Matthias Brugger <matthias.bgg@gmail.com>, 
 Fei Shao <fshao@chromium.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
In-Reply-To: <20241021081311.543625-1-fshao@chromium.org>
References: <20241021081311.543625-1-fshao@chromium.org>
Subject: Re: [PATCH] arm64: dts: mediatek: mt8188: Fix USB3 PHY port
 default status
Message-Id: <172958857153.72613.8539161640798181554.b4-ty@collabora.com>
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

On Mon, 21 Oct 2024 16:10:47 +0800, Fei Shao wrote:
> The T-PHY controller at 0x11e40000 controls two underlying USB2 and USB3
> PHY ports. The USB3 port works normally just like the others, so there's
> no point in disabling it separately. Otherwise, board DTs would have to
> enable both the T-PHY controller and one of its sub-nodes in particular,
> which is slightly redundant and confusing.
> 
> Remove the status line in the u3port1 node, so it's ready to be used
> once the T-PHY controller is enabled.
> 
> [...]

Applied to v6.12-next/dts64, thanks!

[1/1] arm64: dts: mediatek: mt8188: Fix USB3 PHY port default status
      commit: 6bb64877a41561bc78e0f4e9e04d524a0155d6aa

Cheers,
Angelo



