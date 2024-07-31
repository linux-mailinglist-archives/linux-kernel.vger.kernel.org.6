Return-Path: <linux-kernel+bounces-269469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9CD94331C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 17:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC5021F27860
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 15:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C46179A7;
	Wed, 31 Jul 2024 15:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="EA3BU7Lz"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC851642B;
	Wed, 31 Jul 2024 15:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722439333; cv=none; b=e84m61kk4jt8sep4WbY2dxh3PCGduaXM/Z7pKyzDqp2P4lXSmJa9Tj+vST5dslzOGKfvafxK9ap1w0+wNKASKQlhwTTwfsYyaP4M8VD16SI12BgXYoGhowRtWJta6N2C6s25QSF347uPlnCcUTFkof8dtETUzoErXypmfUl01Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722439333; c=relaxed/simple;
	bh=YzEa6FGT7ABDZ3+gWE/js4cARAJAN6TZ1fzD+Z4N4uc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TVv9ZUPxAQStxmgtaH4aEtG89Xia2YGmdyU4NCKjj6zGzC3Atz+05w66pEmPCcMPQZJp+oVzWi6yNYdCfNbw8o6j6ocbk1+DH+YWKnDdhUe/3c8+cKDkUWuhm450fNFpeXD5FL7m+LiIxm2Imfof+S430UfnZWZwfjMAGRYfa7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=EA3BU7Lz; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1722439329;
	bh=YzEa6FGT7ABDZ3+gWE/js4cARAJAN6TZ1fzD+Z4N4uc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=EA3BU7LzdrSaqzYT9gSMJ7IyGj4nHujPOtkgcDenrn8eZWpLWaAvzO9Jd+xEiA0zM
	 NRSkn1IMiGP8Uh4DwkkEbzQ/AsoJ99drqw1dixRMAXeufcWoAP2v93uvgHePcqKEMI
	 GZV9HkAfPPAaYpc9jJZPPR9W8/E3ft2SbnIJCVT65xfw+uvVI3eLP8siCx6uZOIK64
	 QyQFdx0XV45IATyvotdiTFgS71Ev2m9dSH8L7Aw2xSPuDn9WJhuxYmvAOzrmChJXOD
	 3oduXZJyehDxJgyonhGi51R2/ZeNzEsT9LXY6LTEX0WAANDR+PMcRkfLmjBH4EMR+I
	 GDqIqcR8u1pIw==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 9A72D3782039;
	Wed, 31 Jul 2024 15:22:08 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Sean Wang <sean.wang@mediatek.com>, Hsin-Te Yuan <yuanhsinte@chromium.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
In-Reply-To: <20240731-jacuzzi_dt-v3-0-1c4314e8962f@chromium.org>
References: <20240731-jacuzzi_dt-v3-0-1c4314e8962f@chromium.org>
Subject: Re: [PATCH v3 0/2] Add kukui-jacuzzi-cerise and
 kukui-jacuzzi-stern DT and dt-binding
Message-Id: <172243932855.488108.1466847928167694223.b4-ty@collabora.com>
Date: Wed, 31 Jul 2024 17:22:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Wed, 31 Jul 2024 10:47:24 +0000, Hsin-Te Yuan wrote:
> Cerise is known as ASUS Chromebook CZ1.
> Stern is known as ASUS Chromebook Flip CZ1.
> 
> They are almost identical. The only difference is that Cerise is a
> clamshell device without touchscreen and Stern is a convertible device.
> 
> 
> [...]

Applied to v6.11-next/dts64, thanks!

[1/2] arm64: dts: mt8183: Add kukui-jacuzzi-cerise series boards
      commit: 4ba6d1539fdd709ea8e8478c37b014e663cd6894
[2/2] dt-bindings: arm64: mediatek: Add kukui-jacuzzi-cerise board
      commit: ac90896833b52ff58c81727f57ed3cf9ffb9db86

Cheers,
Angelo



