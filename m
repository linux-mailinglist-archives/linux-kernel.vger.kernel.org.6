Return-Path: <linux-kernel+bounces-227054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5FC9147B1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 12:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C37381F21CDD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 10:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596FE137778;
	Mon, 24 Jun 2024 10:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="gWqpFYDC"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA831805E;
	Mon, 24 Jun 2024 10:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719225698; cv=none; b=JOEjGPkrrWSxys955eSrndrKU8un98BlQbxaaHEKmyFDMI08h8SBa57ZXBEB5tzWtZABJqrR8qtiAXzd1ZAXBiGhGXjYgw4erpDfbY70CVee6DE1lzCRekc0T8nBpW/8x9s8zfKH9vYkyEfvhRIMDKY1Zx9NlYCMZ6z3lILSnLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719225698; c=relaxed/simple;
	bh=ch79Gc4lN+MutdQw3n21VfhYB3S+xxQl2Zt4rck1GkA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=t5VhB/AkmhiJHcoJQ8xzlATIrZkTqfO/VsvnL8ReHvHr18XKd05UXifSKdKs1LdvAaltnecTaaTsRpbtfSJdIl/n84v1jb93ZUIsZ1BvqOPKHnzKvf75vqUpNhGaTftJKPO3fxEBlBgwWjI3LLIrBWPDXQy9V3Z09aRBV0YEX/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=gWqpFYDC; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1719225695;
	bh=ch79Gc4lN+MutdQw3n21VfhYB3S+xxQl2Zt4rck1GkA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=gWqpFYDCfjvsjIxpdYoqJpYMFePdYu47YNMg3K4l/AUDHd8A23uwWl64X5O4iDOHc
	 E5OYq3/6gqNItJDl5zXdTv8vv78WsCRrf9aeCN1lHYx1HVanCRNXdBF1Uu4URzdKNg
	 L7heeD4swiWxLHea7QUT2S0qFejToBON+x6JQzrm2T2o5l39Yf1QTUl0cDcCNVN6QN
	 2KMrtGHesVp3RBU9EtOVbgm0O+iqAPW5f/aF4M94Ivjel1t+ceFsi4qQbgAI/2TNVl
	 /LEPdt8wgRnN/9YRkQvo/URgo6SeXHcYQAPYBC3ELicoJpGf2V896rHW6nHy8Tz4jT
	 1U4qTlTgT2iKw==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 920BB37804C6;
	Mon, 24 Jun 2024 10:41:34 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Matthias Brugger <matthias.bgg@gmail.com>, 
 Chen-Yu Tsai <wenst@chromium.org>
Cc: devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
In-Reply-To: <20240131084043.3970576-1-wenst@chromium.org>
References: <20240131084043.3970576-1-wenst@chromium.org>
Subject: Re: [PATCH] arm64: dts: mediatek: mt8183-pico6: Fix wake-on-X
 event node names
Message-Id: <171922569452.118951.6374702543431403561.b4-ty@collabora.com>
Date: Mon, 24 Jun 2024 12:41:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Wed, 31 Jan 2024 16:40:41 +0800, Chen-Yu Tsai wrote:
> The wake-on-bt and wake-on-wlan nodes don't have a button- or event-
> prefix that the gpio-keys binding requires.
> 
> Fix up the node names to satisfy the binding. While at it, also fix up
> the GPIO overriding structure for the wake-on-wlan node. Instead of
> referencing the gpio-keys node and then open coding the node, add a
> label for the event node, and use that to reference and override the
> GPIO settings.
> 
> [...]

Applied to v6.10-next/dts64, thanks!

[1/1] arm64: dts: mediatek: mt8183-pico6: Fix wake-on-X event node names
      commit: 754e69efd5012248786c47c83d6204599feb315e

Cheers,
Angelo



