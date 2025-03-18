Return-Path: <linux-kernel+bounces-567070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1540A680AE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 00:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BC6419C6E4F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 23:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD58D211710;
	Tue, 18 Mar 2025 23:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="wLAnBgKq"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE887207A0F;
	Tue, 18 Mar 2025 23:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742340305; cv=none; b=rMndIxm3OXrKShyjUSu75zLDliW0mgzPttgJCgeN7ujOAEyU5t5rGtRhObgF/YiEB1YDeRpvoxm2R8qC4HajivHVQiJ1maemKeTSWWx09iOmWnVU/3YxY9FZkPFjdNGbVEcd583wscFUGcX2fqRkgp2PFiKU6+TKUYfwnutbN0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742340305; c=relaxed/simple;
	bh=RILpFtxYN6MlwdpMfT4T0Vzg7jFopae2SqKvYWLRV9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CkTsjJi4mdI+IhEeCL5CC3XmD5jC9TpRTIwLocKFze3yby/l09esD08j1ObKqDNmIg6et3qYJK21mzCw9YMqOxuUIQMeWBB9lXiNvbDmeI4cgmOMfxgShP6of5SaLk4KUGWVfwgq9xeP9Y7ew5cerBsQTHlxD0YA221rvQdbnzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=wLAnBgKq; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=1hJklCrqpGSVlV2NvA/25kazNO3qOwA+/saPAYFTsoE=; b=wLAnBgKqHED21WT6XjMrhnXKBX
	uCL/df03qRP30+8Sh81jR2I6nyiuwAJmAKsOxer+twO52bMh+x4a/HJmG7AlziZjTSHRjEztiy6Wp
	mHhAgE8rtWwuIjAA5fds296cbyArHgQLRRhVAv9CWqOs23gQACutQb64nEhXIXNbFdvZVibHBvryP
	MSx8qIFSnSaM+Vh8W/1z7njom4+m4o8lIU/cgdVm/xRqi9kBSx3rt2+Z+95nNKXMGTeBmSLfxbQly
	e2K+tBtStJObxHuDaaN49peT4hiKTuhLI0mLUlW8sLNYV1FT8auRM/6V0lDf9uI/Af8Cb1igzFYq2
	685H4FKw==;
Received: from i53875bc6.versanet.de ([83.135.91.198] helo=phil.fritz.box)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tugIg-0004Fw-3Q; Wed, 19 Mar 2025 00:24:46 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	kernel@collabora.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: remove ethm0_clk0_25m_out from Sige5 gmac0
Date: Wed, 19 Mar 2025 00:24:42 +0100
Message-ID: <174234022086.1144821.10038416716073358190.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250314-rk3576-sige5-eth-clk-begone-v1-1-2858338fc555@collabora.com>
References: <20250314-rk3576-sige5-eth-clk-begone-v1-1-2858338fc555@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 14 Mar 2025 16:35:50 +0100, Nicolas Frattaroli wrote:
> The GPIO3 A4 pin on the ArmSoM Sige5 is routed to the 40-pin GPIO
> header. This pin can serve a variety of functions, including ones of
> questionable use to us on a GPIO header such as the 25MHz clock of the
> ethernet controller.
> 
> Unfortunately, this is the precise function that it is being claimed for
> by the gmac0 node in the Sige5 board dts, meaning it can't be used for
> anything else despite serving no useful function in this role. Since it
> goes through a RS0108 bidirectional voltage level translator with a
> maximum data rate of 24Mbit/s in push-pull mode and 2Mbit/s data rate in
> open-drain mode, it's doubtful as to whether the 25MHz clock signal
> would even survive to the actual user-accessible pin it terminates in.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: remove ethm0_clk0_25m_out from Sige5 gmac0
      commit: 73d246b4402c3356f6b3d13665de3a51eea7b555

Actually applied this some days ago, but b4 is of the opinion,
I didn't sent out an applied-message yet, so doing that now :-) .


Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

