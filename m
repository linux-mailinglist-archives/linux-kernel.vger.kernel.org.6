Return-Path: <linux-kernel+bounces-545608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A41AA4EF38
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 22:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61CC4163C50
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 21:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2A5264FBD;
	Tue,  4 Mar 2025 21:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="U4fHcHpD"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F4F1F76A8
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 21:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741122784; cv=none; b=Fcd+3NfPvWqLLBOMnld1MOK3RH7gtMtwhEoCAx3Jcprdqp3GUCv4NLsZ2d1cLwFpzNgv7PbF1nO+0RsTby3QR+iV3WZaQy9Kgj9buLE6TzJTJjwrGwQD8L3xTUm2zpYvLNWQSvJ6tm7ts9AVg3LE5KUSqHxf7eyMoGNqi7TeZM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741122784; c=relaxed/simple;
	bh=Vh+uiJL7fWwx498l/WS6yZdnOmSyNZSeEEqpAf8MX2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T/KCGFXTu3+ZhJNH0XEoHloSDgQnIE+UkMG+GIvvuQotSbaN/oNHJ2CrawYNmLZvl46rKKIedTT6eRddj5t0wubxGVKJmvbg/mAgHK+1j8a3viM4qEV7f8LLdUYb2fifIapYhwfCuTX1Vp9HaLHjqmHwu8lUEoTrtR7u+UxoO2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=U4fHcHpD; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=eqkQ8jxL06OZOj6WptzRpdH3n3jo9zyINbgB/IlYG8I=; b=U4fHcHpD4mm0027TZsBlsn8aCP
	t6vPvt66OTGQpQnQ3zUengcnEtst/6IplDjIY/XQ1pUucRlneEW57FeWxKJCNgxxSZXTggoq/URBv
	+8SPKcYHjg1SVpabIfeAB3FLWkPYT3qRfUJEb0n/U5M4C4P/hXdhocklCNksnSR1KnkOn/9diW8a/
	QXEb55JGJ94fw/co7ufVsrKjsWVzUmlmyyFf5yYyy+7RAxdPf9vTz9Jfb55qm44Vhd5yabbgSyWhZ
	GPgaw/rZk5eZlkFNaISUWJ7nZYUY/aZLF/B8gkKbcE2vVZtxjj+Ud0T4zXg/X80BahofLh/0yPVE0
	PZ/smrig==;
Received: from i53875a38.versanet.de ([83.135.90.56] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tpZZL-0006E9-C4; Tue, 04 Mar 2025 22:12:51 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Heiko Stuebner <heiko@sntech.de>
Cc: andy.yan@rock-chips.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	quentin.schulz@cherry.de
Subject: Re: [PATCH v3 0/3] drm/rockchip: lvds: probe logging improvements
Date: Tue,  4 Mar 2025 22:12:41 +0100
Message-ID: <174112269652.340957.10714067153847883727.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250304124418.111061-1-heiko@sntech.de>
References: <20250304124418.111061-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 04 Mar 2025 13:44:15 +0100, Heiko Stuebner wrote:
> Getting the panel already uses dev_err_probe to stay silent, when
> the panel just probes later, and the lvds defers.
> 
> But the phy needed on px30, also has the capability to probe after
> the lvds. So make the rest of the lvds probe/bind logic also use
> more modern logging than DRM_DEV_ERR, that is deprecated anyway.
> 
> [...]

Applied, thanks!

[1/3] drm/rockchip: lvds: move pclk preparation in with clk_get
      commit: d4f5efb9139cad34823f265053c57baf6af3c70c
[2/3] drm/rockchip: lvds: Hide scary error messages on probe deferral
      commit: 37c18639504aacbd31371f562fabafdb890bcd2e
[3/3] drm/rockchip: lvds: lower log severity for missing pinctrl settings
      commit: 4006be2f77cd26d065133b338dc51f59857d20f0


With some freedesktop.org hickup, I forgot to send the "patch applied"
mail, when I applied the series this afternoon, done now.


Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

