Return-Path: <linux-kernel+bounces-437388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFB99E9298
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 12:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B59E816184E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 11:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E7221C18B;
	Mon,  9 Dec 2024 11:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="hga1gDpk"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EAA21E093;
	Mon,  9 Dec 2024 11:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733744264; cv=none; b=YjxqshtzP9ZRmsN1U5IMhcpsRagTXrAZZivPyF3Et1GU5HhS+WeMHyEogHJwtbclnK81V1U8gr9J/FyxilWTuf97s+vT6r1OmLzFQBlWh3nAq5iCSGCk3RNe5tXxpFhonhgP4BYk+hCzuB4ivlFrtog7JcizanXSjca5xIGXFOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733744264; c=relaxed/simple;
	bh=bPplHq8MykZfKvlUO7uKwUjm+86UC7axUXzqSZ31mxo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CZ3jIqh+233mfG+vmkDXwISbaDBNqQwXcxGKJ9zqF9dP9Ljj+PBZ0E89Mx4FMmZQQsPZ/fm6I2XYHmih0oxLPLgWjDgd2CkEhDGZ+McdmoupOrgqo7QPxaE7G2DjvQCgmRg40LQz6oPv8bsXpIqC/UTPDtA79sMqpVbq8HK23gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=hga1gDpk; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733744260;
	bh=bPplHq8MykZfKvlUO7uKwUjm+86UC7axUXzqSZ31mxo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=hga1gDpkDqkZoSHk77663quLfcvz1TXk0qzed7jAT9S58SAgpmGPgUOzpag+EZA/W
	 xmfB/RPQVLkbTUIuXnxE7G0X5TRjRSkpz1exmsrHNsbqAefZ9JT550vdIK7pAC/aTq
	 oFgdy3p8ZzlHJQJnyUG/UIFafVbQrjKN6CHSaWTGzdsoVPzbvrurRe8j99bO9uOc2O
	 tFVX2lAgxw03LaWj9rixfe9uhlmj4uZ/bPZ+EjSQZVZ+x+CLKzlmhls/6OVt5aY/7x
	 itkuqiLetGNghbpmfvu7I3zG1gHrV5gA4ph1zblDqvNs5ZD+leVqmeyo259VKy98G8
	 6+kEHOBQydh2g==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 14E5617E362F;
	Mon,  9 Dec 2024 12:37:40 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>
In-Reply-To: <20241209112920.70060-1-krzysztof.kozlowski@linaro.org>
References: <20241209112920.70060-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [RESEND PATCH] arm64: dts: mediatek: mt8183-kukui: align
 thermal node names with bindings
Message-Id: <173374425999.50169.9722221830954876718.b4-ty@collabora.com>
Date: Mon, 09 Dec 2024 12:37:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Mon, 09 Dec 2024 12:29:20 +0100, Krzysztof Kozlowski wrote:
> Bindings expect thermal zones node name to follow certain pattern.
> This fixes dtbs_check warning:
> 
>   mt8183-kukui-jacuzzi-burnet.dtb: thermal-zones: 'tboard1', 'tboard2'
>     do not match any of the regexes: '^[a-zA-Z][a-zA-Z0-9\\-]{1,10}-thermal$', 'pinctrl-[0-9]+'
> 
> 
> [...]

Applied to v6.13-next/dts64, thanks!

[1/1] arm64: dts: mediatek: mt8183-kukui: align thermal node names with bindings
      commit: 4604c989004006cc0c08a9cfe8d80e7544b8e808

Cheers,
Angelo



