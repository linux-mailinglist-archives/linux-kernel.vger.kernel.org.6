Return-Path: <linux-kernel+bounces-534807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0EFFA46B62
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 20:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00B6816C5AF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F651256C6F;
	Wed, 26 Feb 2025 19:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="tYl0Bv2P"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5142566E3;
	Wed, 26 Feb 2025 19:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740599376; cv=none; b=cBILgIOgxb9nDx2sl71CxNxAGLyvTeTyJDcYkNbdtdfbL1wbSyMiH1c5Ztases5/yEAxPwGBQTcn6OnKYXCmum4jWNS3YPY0w9EFF6KpB1M5K/gcNwRbx4cVa3U+ivglHsKuT2/xkcuDZaSqjUCh0/UayzA8h5r1k5zfEkqOgsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740599376; c=relaxed/simple;
	bh=uqDhyBVBZqMOeTL1hOmfpdfDP9S0Dy0E255c4RyiNmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mR92vP+0bKO3LM9kmXQ81pPKGGVDYH8vDcv+5k9IR1einJ+Qkc1u7BNCQJnS01HrxdoHWb9r4VpOb6ZMOR+LJxlWwvkp3bIZW40WUAAgWJiGRbTbsDDnLq+jOLZYWnMLIPJqL6Z6AOsZVY42QumsqebZtEh1q6HOQarCxKr7IaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=tYl0Bv2P; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=GLZdc6tOIF5nduifR9lrHwuFKRBnecGDrzTfzHlsOlg=; b=tYl0Bv2PGRPpK7fegZRkJEgzyn
	N6hqQI18rCeNECtz7ZuAIwrj5sh5IfSORwRKP5beUELWM/Xju/TgF/bVftDCk8Z6y3urYXgJOcW9m
	Axpu6754sDj35NWybbSk8XvUj32+E0BjlsJXhZT6+ABOXcpD2MZh7POS2i6SWykZ+j0De9GC207Uh
	+ay2sSc3dd7uOJ2SKDnEm1ZFRW5uRCxAbmIXMI4Iyt5fZYIEVQzyyhQfSOt2jnIe729giYZPhQvjG
	M+8MXaTdRZdQJOkK3cxngovLMRlxQev9pWONkgYpDCFOr43FFGRorndSZkX4+TXgVMcUsJ4/sWpLj
	JbOq7I9w==;
Received: from i53875b47.versanet.de ([83.135.91.71] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tnNPK-0002zz-9p; Wed, 26 Feb 2025 20:49:26 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Michael Riesch <michael.riesch@wolfvision.net>
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: rockchip: mark hclk_vi as critical on rk3568
Date: Wed, 26 Feb 2025 20:49:13 +0100
Message-ID: <174059933834.4008853.3726921345547930127.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250210-rk3568-hclk-vi-v1-1-9ade2626f638@wolfvision.net>
References: <20250210-rk3568-hclk-vi-v1-1-9ade2626f638@wolfvision.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 10 Feb 2025 09:29:02 +0100, Michael Riesch wrote:
> The clock 'pclk_vi_niu' has a dependency on 'hclk_vi_niu' according
> to the Technical Reference Manual section '2.8.6 NIU Clock gating
> reliance'. However, this kind of dependency cannot be addressed
> properly at the moment (until the support for linked clocks is
> implemented for the RK3568).
> As an intermediate solution, mark the hclk_vi as critical on the
> Rockchip RK3568.
> 
> [...]

Applied, thanks!

[1/1] clk: rockchip: mark hclk_vi as critical on rk3568
      commit: 83dbeca33f7422f4a30c8a91a79d6c0dba4fb6af

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

