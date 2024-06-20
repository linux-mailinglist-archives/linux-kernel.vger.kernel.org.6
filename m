Return-Path: <linux-kernel+bounces-223462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3389B911371
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 22:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 588811F23AFA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 20:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE6874432;
	Thu, 20 Jun 2024 20:40:13 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31CB5820E;
	Thu, 20 Jun 2024 20:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718916013; cv=none; b=A/BV+S93/e0nA1oS7SJkec0RwkuPiDvsczqKL6mG7EhA3gdO8F+z4QlVjcT3rrqC/hyHYTHGTU91wZ3eeTPO4YgE1pNlVhVnHJ9pbARVCoIUNZ1wroCtaM54I03J0VPMF3r2VHRboGgXgZ9Vss7vpbNEqJOhCbTLG7PbSgxCXeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718916013; c=relaxed/simple;
	bh=vOHDcuwH3nby98440sRcZScWkY5AVQNOHJhIam7uaA8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FJFhsP5JQeFQyQGT9tpFdGjY+R+UaWY/On8k1BTp6mePI1bAwcB4PZ6XZXyQ60uC4GwkJRdRrMHPwgFthAarOQLvP8Hh9jx01HjOUpCdakPRxlTQri3rrcWrB0mCgc+PCrpYt3k36gYkQ+XSFUuTT/m58OaW6WWs6J/3z6t7bM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e860cc8.versanet.de ([94.134.12.200] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sKOZb-0001mc-Cv; Thu, 20 Jun 2024 22:39:59 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Alexey Charkov <alchark@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Diederik de Haas <didi.debian@cknow.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	devicetree@vger.kernel.org,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	linux-rockchip@lists.infradead.org,
	Dragan Simic <dsimic@manjaro.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: (subset) [PATCH v5 0/8] RK3588 and Rock 5B dts additions: thermal, OPP and fan
Date: Thu, 20 Jun 2024 22:39:55 +0200
Message-Id: <171891591945.88443.14666251613914983261.b4-ty@sntech.de>
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

[1/8] arm64: dts: rockchip: add thermal zones information on RK3588
      commit: 97d61227d6bb0023a325ab2f87e4438a858207a2
[2/8] arm64: dts: rockchip: enable thermal management on all RK3588 boards
      commit: 4afa9056ed9e3d9ff036f3576cb137a011448295
[3/8] arm64: dts: rockchip: add passive GPU cooling on RK3588
      commit: d64d337f1856bd0e5cbfc60b6f0458ad4951d05e
[4/8] arm64: dts: rockchip: enable automatic fan control on Rock 5B
      commit: 2aab8905a843aef624565c014a34d155f8702135


Don't worry, I'll look at the other patches too.
Was just easier on my mind to this in blocks ;-) .


Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

