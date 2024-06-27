Return-Path: <linux-kernel+bounces-232006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3AD491A178
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 10:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DD13282B53
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 08:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5432F811E0;
	Thu, 27 Jun 2024 08:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rg5x8Nd6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988B0134B1;
	Thu, 27 Jun 2024 08:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719477023; cv=none; b=Sn/VSuv+DBU97gB36Y/bl2KoI3cFFvTSHiQ3K0Fsd1/LHQhXY8s+XT/kaNydlCPx92OiozSgofjAEwhIjNQ5pw8Jh27eCCxDN8w5coIxvP4UdoavFceNFq0KOrc/QI2rXoVQHHpwjbdJr9V/wxLE46p3wTgBN6Z/UF4rvh2CXjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719477023; c=relaxed/simple;
	bh=SRxQT/BRSRJL3CvUyHc3/7UJ6jrwQN+2sL5nddh4M/I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gTeEb94Pp1eTMYl+cabbuJIRwVfL9oLLOP+1aCaY48USiAP3ID5D367oFYVJ5OtNCL4frHtOwu4R2pHKWrnEPspCYkrGgI8oNo6GNgcMYOpYh/wH1uqHhIpcKBQjzmaEoexLmCrGFHOTONEWYq445fP7FUVRFIRdDpqLKeRU8uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rg5x8Nd6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01AF3C2BBFC;
	Thu, 27 Jun 2024 08:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719477023;
	bh=SRxQT/BRSRJL3CvUyHc3/7UJ6jrwQN+2sL5nddh4M/I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=rg5x8Nd6UWeYUBb6FkNWA5keSE8TJsuZxeHL9Q3U7uAsWo8N1aL9a+CYwKUhNvzrz
	 LWpiPif8Z2J02kZFHc3FhKfq9kDgMqBW1YfyB6aUIuJzJ88zP0Z5LDkwpRTd1T99Xx
	 xHJHXQlmsOELFzkDquwJ7zKVD3lzzpnHtANS4V7bTHR3PqM3zJpYwVcA4FJHQP3ztN
	 Z+8QMXHbX8jNiJzSJLDjikWrdfzBXxzA5qq23V8PVxspeLI/nNHkS/ek+CHBnkuzGk
	 PPx0ke3bL+3hVpECvan4jciv9OxGuy7O8+ka9/jRNfTvXAGwTXOj8xl8HgTSlLWUQL
	 8ucNcKNSuJYWA==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Chris Zhong <zyw@rock-chips.com>, Zhang Qing <zhangqing@rock-chips.com>, 
 Chris Morgan <macromorgan@hotmail.com>, 
 Furkan Kardame <f.kardame@manjaro.org>, 
 Michael Riesch <michael.riesch@wolfvision.net>, 
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: kernel@collabora.com, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20240622-rk809-fixes-v2-0-c0db420d3639@collabora.com>
References: <20240622-rk809-fixes-v2-0-c0db420d3639@collabora.com>
Subject: Re: (subset) [PATCH v2 0/5] DT fixes for Rockchip RK809 audio
 codec support
Message-Id: <171947701973.2892686.10620287501091714886.b4-ty@kernel.org>
Date: Thu, 27 Jun 2024 09:30:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Sat, 22 Jun 2024 00:57:17 +0300, Cristian Ciocaltea wrote:
> Rockchip RK809 MFD provides a RK817 compatible audio codec, supported by
> the rk817_codec driver.
> 
> This patch series fixes a few issues identified by dtbs_check for the
> boards making use of the codec: rk3566-quartz64-b, k3566-roc-pc,
> rk3568-evb1-v10, rk3568-lubancat-2, rk3568-odroid-m1, rk3568-rock-3a.
> 
> [...]

Applied, thanks!

[1/5] dt-bindings: mfd: rk817: Fixup clocks and reference dai-common
      commit: e472369bd5624fa899d0d1dfbe69b594fd7e6e7d
[2/5] dt-bindings: mfd: rk817: Merge support for RK809
      commit: ae61fa9ee01049abfca7a954a7c62e1274858d10

--
Lee Jones [李琼斯]


