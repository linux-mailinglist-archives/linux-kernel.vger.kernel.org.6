Return-Path: <linux-kernel+bounces-376373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D14509AB088
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 16:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24F3CB22CF2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 14:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC4F19F485;
	Tue, 22 Oct 2024 14:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="zpYd6N6o"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7756C126BF2;
	Tue, 22 Oct 2024 14:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729606362; cv=none; b=oqhXoNEf1JEBbLHA16Tajg7MUBcUq35Vet8uf4E+fKm+uTAzekCM0bqzIbj2XnDvuL5ARyvjsCY8whwhWS3QlI+mtEgjHRV/9jCHU9F85f7BwP38P4Pa2DgvJ+g9JETRvA6ZxwHB995DKcn1zi30rG94p3WfJk2RLov3i8fMVkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729606362; c=relaxed/simple;
	bh=ENWVpho5qJqyxs1BT1m1Dn1EL6QC5ksfn2VwHFuc86k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LxsndPmC/Fb8i8ysjAGA2YWDLIcZkbmO29KwIelZ5m1JX9Lz4aZEmQBH/LKnne4qeg9EsiAzhI271LPjt7W/fcx6/Pl1LP+zcnnSzjIv6nqJcM9zdBAiSRP6zxdQTvzixoawfI6tK9hx57urrsr2LV3ozUCOiTKQ4ML4G08GmsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=zpYd6N6o; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=LezvWnWGKGyqhDcrdClbh41XudRaVGk+oWiAlwvi5L8=; b=zpYd6N6ozETNiVEDN1prD5fmUk
	yOMqog6Cd0fFNHl7P7DPH0xULNsEnJ1JyJEI6w1qm9x5n7XBsiSWp2v6S6paCyqyDhXFni3OHB7I7
	5F3Kd4Cde3381e/gGFGonBEFeiwAzF+GOMmQ9aR79QcAK0MHA98RBpGiOpzGAqLRD75mvr9bZekFi
	YWLZIv11upJM7VhAMDoj20N3/nrFmPRc4wbHWQfdei6+dJEiXiKvn+iQ5Znb8Vu4NulWls33KJ2EF
	284V5glHAmP3z/rMLhlVQFfIR/tEBKf23j06ytpmdb/s+xwg3V0TXkj2bPNgvvvJNhILlVoh9bQ6Y
	9oaHp2Zw==;
Received: from [213.70.40.217] (helo=phil.sntech)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1t3Fck-0005eb-Tg; Tue, 22 Oct 2024 16:12:38 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Dragan Simic <dsimic@manjaro.org>,
	linux-rockchip@lists.infradead.org
Cc: Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	conor+dt@kernel.org,
	robh@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	krzk+dt@kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Convert dts files used as parents to dtsi files
Date: Tue, 22 Oct 2024 16:12:26 +0200
Message-ID: <172960632904.1476617.16706194914239388318.b4-ty@sntech.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <f3d789c14fe34a53327cac03cd3837e530e21f5c.1728937091.git.dsimic@manjaro.org>
References: <f3d789c14fe34a53327cac03cd3837e530e21f5c.1728937091.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 14 Oct 2024 22:21:57 +0200, Dragan Simic wrote:
> Including a board dts file is not the right way to represent the hierarchical
> nature of the board dts files and to create a dts file for another variant of
> an ancestor board.  However, a few boards and their variants (ab)used this
> approach, so let's clean that up by converting the common ancestors into dtsi
> files, and by adding separate board-variant dts files.
> 
> No functional changes are introduced, which was validated by decompiling and
> comparing all affected board dtb files before and after these changes.  In
> more detail, the affected dtb files have some of their blocks shuffled around
> a bit and some of their phandles have different values, as a result of the
> changes to the order in which the building blocks from the parent dtsi files
> are included, but they effectively remain the same as the originals.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: Convert dts files used as parents to dtsi files
      commit: f3c6526d6fb25b9627cb39cc63fec8f88ecf17b5

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

