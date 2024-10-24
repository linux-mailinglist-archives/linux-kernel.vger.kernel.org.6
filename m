Return-Path: <linux-kernel+bounces-379476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4349ADF22
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 10:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C93ED1F234C1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 08:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0481B0F32;
	Thu, 24 Oct 2024 08:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="bcBOvzQt"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A8318784C;
	Thu, 24 Oct 2024 08:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729758666; cv=none; b=pRx2qyfj7tj3SwqiYOX778l6Lu9aU+GQwH4+C1HrRTg5sgBbiYjt/sl5Jk6PWTkITgE76oqGkRmMVCpS7YFWxMYueH6BbZcdNucL0E7uRp08MC9TmQoxJ8ymMKlHY/FwUnIGv3AGmwTlbFPD+SVE+VTuzblJ/3p47gx23FcMWTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729758666; c=relaxed/simple;
	bh=xZnglYVaXPiK7EeFt6m7022rywQpmwEk/etdTOTgLts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hvAypZv1lVKRl7DRLrguhdxxaVkK0atf9mhZxNpBQXviZfft4L/7w2x4WSIOrv1JwCmdD4LbR38VwvvcmkYqm3m6Nt3oruzVkBMxMI0mSukAZK6wP+rtTGKd82Da3PDJ6NNuwMkxr6yROBVCMHVtebOUZAwSVOH/TEgPbuiKUKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=bcBOvzQt; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=pN3rG0YbC7h5EHabK5W8IM1Nvv/GoxCMWjU2r6UAVgQ=; b=bcBOvzQtDWVKk6sxrdZW51ClBX
	0bDhIDiDBidFW7F8pPDQkhLfOMsQNC9/Lu7SrI8web1ruJHMrFU3XKNC5QKC7/snRoFnEV2Rcbgh6
	oWQgIb2G1vsjUFIgb5WnbaQZiyZKpOmiDmkOLN3mUgfF+xbKqrqLfAqQwDVrRl/7fscA2oY92Hwg2
	m4wIrz2lAD9a98SJujHN8YH2xtNcRTgkBZMS6+56QKRhIJs3BGBSdUQSbHMmkFitI2sPUJNZZEOqi
	DjGlv6f979Nsq2l5zIuqUfsgeSBct7JKs4d+/UrT8CU+DY1NQ11gZtGaBPB9NEqIQ8UGsa+Wo6Xcs
	zqsC5b/g==;
Received: from i53875b34.versanet.de ([83.135.91.52] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1t3tF5-0002iS-5G; Thu, 24 Oct 2024 10:30:51 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Tianling Shen <cnsztl@gmail.com>,
	Andy Yan <andyshrk@163.com>,
	Rob Herring <robh@kernel.org>,
	Jagan Teki <jagan@edgeble.ai>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Jonas Karlman <jonas@kwiboo.se>,
	Conor Dooley <conor+dt@kernel.org>,
	Chris Morgan <macromorgan@hotmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] arm64: dts: rockchip: several fixes for the nanopi r3s
Date: Thu, 24 Oct 2024 10:30:44 +0200
Message-ID: <172975863602.1671562.17971165767179395195.b4-ty@sntech.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241022193537.1117919-1-cnsztl@gmail.com>
References: <20241022193537.1117919-1-cnsztl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 23 Oct 2024 03:35:25 +0800, Tianling Shen wrote:
> * Enable eMMC HS200 mode to allow it boot from eMMC
> * Sort properties in pmu_io_domains node
> * Reorder mmc aliases
> * Replace deprecated snps,reset properties
> * Use the marketing name for the model name
> * Update the website url in copyright
> 
> [...]

Applied, thanks!

[1/5] arm64: dts: rockchip: fix model name for FriendlyElec NanoPi R3S
      commit: b5bf84206a5c77528f9dd4cbca4e72caa063c102
[2/5] arm64: dts: rockchip: replace deprecated snps,reset props for NanoPi R3S
      commit: 82b2868937883b65732da498b26366d34db61510
[3/5] arm64: dts: rockchip: sort props in pmu_io_domains node for NanoPi R3S
      commit: 17e150fdd983c7e59b9240e34a166285f3c3fb39
[4/5] arm64: dts: rockchip: enable eMMC HS200 mode for NanoPi R3S
      commit: 1b5365034410f1ca21adadadd492b99bdf4f2c55
[5/5] arm64: dts: rockchip: reorder mmc aliases for NanoPi R3S
      commit: b7cd1115456d312f8c5e60c80fdc35fd35ea6eab

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

