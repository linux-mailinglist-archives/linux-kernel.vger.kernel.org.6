Return-Path: <linux-kernel+bounces-227573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6416291535C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 18:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A6D61C213AE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 16:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F375A19DF52;
	Mon, 24 Jun 2024 16:20:34 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABBB19D8BB;
	Mon, 24 Jun 2024 16:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719246034; cv=none; b=Izt/H44Pl+JI9QewOXcNmyq7Ao70wZM4gHiIJxzrxTgjfZo0ilPiO671JhZ0xxr0VPtas30CVVaU36rHws5jWTCnUKzBYgckaz3Cu2luDdvRTld34r7FG0GHOybjBZl1q8UeiR0JhLYRkNplYzg/ALI6avovdl22wMNJMAI+SSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719246034; c=relaxed/simple;
	bh=JsgoWkpxxFib+5mLxRHfM+q+sPT/9XjgfpB6NE/RmH8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DUZF0xNBWiNK2OZCs+k4tnKXGYqEygdhXW3i6Rs/dLRQY61r5jBjWy9dXP3jpY6tKo9fLEpJC/daWRXZdDbI8hw7dh91Gt/s7+vkf9oRV7Y/iGoA8w3TXdItyykYX0oNRWkMZez1vG/FtuDz2cJZNiPQ9fdudqDcYJnTBHF+Ck0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875b6a.versanet.de ([83.135.91.106] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sLmQY-0001wn-VT; Mon, 24 Jun 2024 18:20:23 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Conor Dooley <conor+dt@kernel.org>,
	Alexey Charkov <alchark@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Dragan Simic <dsimic@manjaro.org>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Diederik de Haas <didi.debian@cknow.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Chen-Yu Tsai <wens@kernel.org>
Subject: Re: (subset) [PATCH v5 0/8] RK3588 and Rock 5B dts additions: thermal, OPP and fan
Date: Mon, 24 Jun 2024 18:20:12 +0200
Message-Id: <171924573799.612064.3075817964360702437.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240617-rk-dts-additions-v5-0-c1f5f3267f1e@gmail.com>
References: <20240617-rk-dts-additions-v5-0-c1f5f3267f1e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 17 Jun 2024 22:28:50 +0400, Alexey Charkov wrote:
> This enables thermal monitoring and CPU DVFS on RK3588(s), as well as
> active cooling on Radxa Rock 5B via the provided PWM fan.
> 
> Some RK3588 boards use separate regulators to supply CPUs and their
> respective memory interfaces, so this is handled by coupling those
> regulators in affected boards' device trees to ensure that their
> voltage is adjusted in step.
> 
> [...]

Applied, thanks!

[5/8] arm64: dts: rockchip: Add CPU/memory regulator coupling for RK3588
      commit: 0ba0560982bc8d0c3fb3ca209fd0ed29f81402ac
[6/8] arm64: dts: rockchip: Add OPP data for CPU cores on RK3588
      commit: 276856db91b46eaa7a4c19226c096a9dc899a3e9
[7/8] arm64: dts: rockchip: Add OPP data for CPU cores on RK3588j
      commit: 667885a6865832eb0678c7e02e47a3392f177ecb
[8/8] arm64: dts: rockchip: Split GPU OPPs of RK3588 and RK3588j
      commit: a7b2070505a2a09ea65fa0c8c480c97f62d1978d

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

