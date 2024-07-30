Return-Path: <linux-kernel+bounces-267700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5904C941487
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 16:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 025FE1F23DD3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 14:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ADC81A256C;
	Tue, 30 Jul 2024 14:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="oSSybwPz"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAEF18FC75;
	Tue, 30 Jul 2024 14:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722350238; cv=none; b=AT+onqjVYf7UwI/6XNw2I2Qe+waWYFWTcAos5wbQXB6vU8Lpuz3SfKz87xm2a0D7//D/zpkFegISvK0yg7tHnk6kKvOC5WAHeUK358N6uka8OqD9rhl62RCoj/4yTL3T1kVP9GAs6PcxBfrwPchUFGDdArRFgTGJMDejTCXIlNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722350238; c=relaxed/simple;
	bh=Plzyk1Dywd7+rQj/2Gc3nMT3tnqW4USmHzptYCMZn88=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=haofQB9uTTaFBsPXJxSW+qB36/hDqL6YwpJZ7Hjs3qDrQ+rvaK64i2QKQp8ujJxUHqMxH5y4K3470FV+nbaNgwCthHu7Veu/32AZfbBNqqOg7goUrZlvFpty3XCvtJmk/Yg79ovRixrfP5GUDfS8AutPH9v7wn/WzsSY6uvJqTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=oSSybwPz; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1722350235;
	bh=Plzyk1Dywd7+rQj/2Gc3nMT3tnqW4USmHzptYCMZn88=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=oSSybwPzTP7cjwwrw8p/b/yO/+l/aAXl4poombyE4M7wubfRY4cM2fsnieUL8UKIz
	 0hmi5Zvcwuy75qdKbqwOrOe+5RR4//Gt5djQP8Rd0Dh92M3O+eNmVveS5TZc8nbQkQ
	 wng0JjFNjTGFuqjqtPWqlAD49sREALW6s+Q6k8AZXyh40bil1icTQSG419b7QyQhsc
	 o9vHjDyHDRJ0qLdFYn+2Js0NZtQAImKguIvwH7xUaWyB6Mrbwny9hxYYfak7YD/lkC
	 +eK9ngdeSQIn57XLs8GEO7kcjeR/9LfdPt7jKYsyYabFPUkoVEUCccDmwl+XeHPS/h
	 w/DHreYBqzHYA==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 9232037809B0;
	Tue, 30 Jul 2024 14:37:14 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, Moudy Ho <moudy.ho@mediatek.com>, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Cc: kernel@collabora.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org
In-Reply-To: <20240606-mt8195-dma-scp-node-err-v2-1-e14702e9d3f2@collabora.com>
References: <20240606-mt8195-dma-scp-node-err-v2-1-e14702e9d3f2@collabora.com>
Subject: Re: [PATCH v2] arm64: dts: mediatek: mt8195: Add SCP phandle to
 MDP3 DMA controller
Message-Id: <172235023450.223861.8133527009930724710.b4-ty@collabora.com>
Date: Tue, 30 Jul 2024 16:37:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Thu, 06 Jun 2024 17:12:04 -0400, Nícolas F. R. A. Prado wrote:
> While the MDP3 DMA controller can look for the SCP node based on
> compatible, it's best practice to supply the MDP3 node with a phandle to
> the SCP since that allows supporting dual core SCP as well. Besides,
> relying on the compatible search causes an error to be printed, since
> the phandle is tried first:
> 
>   mtk-mdp3 14001000.dma-controller: can't get SCP node
> 
> [...]

Applied to v6.11-next/dts64, thanks!

[1/1] arm64: dts: mediatek: mt8195: Add SCP phandle to MDP3 DMA controller
      commit: 587c945c933364f24d132918d7703997fd1e2cd6

Cheers,
Angelo



