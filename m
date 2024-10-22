Return-Path: <linux-kernel+bounces-376372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8199AB087
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 16:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78ABA284224
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 14:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD131A00D1;
	Tue, 22 Oct 2024 14:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="wioUGu6K"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAA819F406;
	Tue, 22 Oct 2024 14:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729606362; cv=none; b=qTA4QTdGpbLWnr3phfVqX2iRytc1rYyafNBEEXsVL73vHehiksJEgtwk3xq8sKqu45lG0SYQPzBcOjjiSITHOORIoGtmVSoCRFha6uQcVux/mMM8WLpK1nuCJz2dXm4dDkrs0SnigFdVq65v7oPlFYVRgcgqdGeltNTBZyuxquo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729606362; c=relaxed/simple;
	bh=cr1hS+MUMjyQooaMGxvm+cX282VjxnTOPUG3u5rYB68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VbwCBjfl5eKU+SivynQA0ox5RTv3C1Kve1U416F8ztxBvEUaoOeENA6iy7iu/NQPCZxGpR9eBjSDZqBJZle3keS+LXDX7bxVuEbIkEAT++qbQaiFtzp/x684YySJ4GODDAqLZNSeoJxNozu7EOuTDcJKBGZ/WwH1cKVQlDxB+2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=wioUGu6K; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=AtDTx7gh226L3gyLWuov/P6JpdQOVKyrZd5OdMDGECQ=; b=wioUGu6KhNdPAfcj59KOc6TF2D
	k+Cf/zRLRMvyLB8jvxUYyrRJtCgN7aFf+et4zaUrgni5tXYtwQUcWxT1gfZPerHzNGBTUIAAXTc8O
	5ugTdnsrhDJ7qN6+ntaDrZAX9htoyyueUCdsIjfXQJsd9Fg9ziFB3LeGJMT9IYDIhRVMHAVAvP73d
	8viI+pjHZjaqfu7/OUVTFV0ZY3n4rbBaQewMu5bkSSX0ygTDolxY1Ic2ylNtswo6bMz/n4N6Zgcgv
	bgog+JhdsyB+PhWegf2LiV0iiUE+aYuQ66xWu+YDb9sKqCJ6kGIVzD+Dt6g7JqcRtPhiSH7YNfkVk
	gmzLVoCA==;
Received: from [213.70.40.217] (helo=phil.sntech)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1t3Fcl-0005eb-6D; Tue, 22 Oct 2024 16:12:39 +0200
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
Subject: Re: [PATCH v2] arm64: dts: rockchip: Add dtsi file for RK3399S SoC variant
Date: Tue, 22 Oct 2024 16:12:27 +0200
Message-ID: <172960632904.1476617.9930861128544928291.b4-ty@sntech.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <c32622e4a6897378d9df81c8c3eda1bdb9211e0b.1728632052.git.dsimic@manjaro.org>
References: <c32622e4a6897378d9df81c8c3eda1bdb9211e0b.1728632052.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 11 Oct 2024 09:40:51 +0200, Dragan Simic wrote:
> Following the hierarchical representation of the SoC data that's been already
> established in the commit 296602b8e5f7 ("arm64: dts: rockchip: Move RK3399
> OPPs to dtsi files for SoC variants"), add new SoC dtsi file for the Rockchip
> RK3399S SoC, which is yet another variant of the Rockchip RK3399 SoC.
> 
> The only perceivable differences between the RK3399S and the RK3399 are in
> the supported CPU DVFS OPPs, which result from the RK3399S being binned for
> lower maximum CPU frequencies than the regular RK3399 variant.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: Add dtsi file for RK3399S SoC variant
      commit: f7f8ec7d8cef4cf62ee13b526d59438c23bbb34f

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

