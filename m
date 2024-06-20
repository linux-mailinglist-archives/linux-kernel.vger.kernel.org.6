Return-Path: <linux-kernel+bounces-223463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F75911373
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 22:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B91D01C21920
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 20:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86325D8F0;
	Thu, 20 Jun 2024 20:40:14 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EF97406E;
	Thu, 20 Jun 2024 20:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718916014; cv=none; b=guDgFsm0RKQa/TdpauuHR+4hlt3jXI0dNkLjNdLvBNt1RbQXY79aefrSFQXyLOb+M+7AjeuUKMtXUtLQPxGmY0JOtUwCsETeAWATN4Bkg0fypb8WdZR5FBPlWkUsUsRsTWBN3ygM1fK/Gs4EknKieAwStqdBgWfA6fMQ3fVkSHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718916014; c=relaxed/simple;
	bh=VegozR4ZPsnRaHRwBGeSH3585GN1FpoETs/49C4QdUg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZPZd3jbQray4K5hW5EsKRqKZs3g0SULunB2Do9DMDX3vgOOp8T+wcuYvHotQFvYNu4mdSA0xf3f1QckRAKWylU6XqsH0dnSkIxaaLV0fuiWKBDqdzeRRbwxdsrB+jaxjAqbp/5llR81lIGO1HJyrczwjPDSao0tZ4EyHDA8u+lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e860cc8.versanet.de ([94.134.12.200] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sKOZb-0001mc-Uz; Thu, 20 Jun 2024 22:40:00 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Dragan Simic <dsimic@manjaro.org>,
	linux-rockchip@lists.infradead.org
Cc: Heiko Stuebner <heiko@sntech.de>,
	jonas@kwiboo.se,
	robh+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	didi.debian@cknow.org,
	alchark@gmail.com,
	krzk+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: rockchip: Prepare RK3588 SoC dtsi files for per-variant OPPs
Date: Thu, 20 Jun 2024 22:39:56 +0200
Message-Id: <171891591943.88443.4575073298967084067.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <9ffedc0e2ca7f167d9d795b2a8f43cb9f56a653b.1717923308.git.dsimic@manjaro.org>
References: <9ffedc0e2ca7f167d9d795b2a8f43cb9f56a653b.1717923308.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sun, 9 Jun 2024 10:58:19 +0200, Dragan Simic wrote:
> Rename the Rockchip RK3588 SoC dtsi files and, consequently, adjust their
> contents appropriately, to prepare them for the ability to specify different
> CPU and GPU OPPs for each of the supported RK3588 SoC variants.
> 
> As already discussed, [1][2][3][4] some of the RK3588 SoC variants require
> different OPPs, and it makes more sense to have the OPPs already defined when
> a board dts(i) file includes one of the SoC variant dtsi files (rk3588.dtsi,
> rk3588j.dtsi or rk3588s.dtsi), rather than requiring the board dts(i) file
> to also include a separate rk3588*-opp.dtsi file.  The choice of the SoC
> variant is already made by the inclusion of the SoC dtsi file into the board
> dts(i) file, and it doesn't make much sense to, effectively, allow the board
> dts(i) file to include and use an incompatible set of OPPs for the already
> selected RK3588 SoC variant.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: Prepare RK3588 SoC dtsi files for per-variant OPPs
      commit: 0866aef9b478a50a4035c90428c990485e9d2d6d

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

