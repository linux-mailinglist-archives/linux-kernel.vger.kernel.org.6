Return-Path: <linux-kernel+bounces-537179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F96A488EA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 20:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 806AB3ACA89
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 19:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E3D26E944;
	Thu, 27 Feb 2025 19:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="tOzOhZUc"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45842270054;
	Thu, 27 Feb 2025 19:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740684139; cv=none; b=uHQhWGlnKGvy3XcLfcp+JnHyBd/g56kNvoFFA7MNj7GPEYtIwI2671hlA5nAFAmlNJ05a2z8xVZY9i098Z4BQitw48Eoc2Tp7WYtgjyXIl+10e6hz9xvNotRywIr1mUGh12XV/+tSadhoW7eXTP6y3E9kzLWtUg3O2fASdKy04o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740684139; c=relaxed/simple;
	bh=2UHfEMBCWfxVZv7xXzvOUQzTvEVZ2+VcIsiwp9V9EGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dOe6kflP4+33zPUWSJYP2NwZGZlXE4615T2vC9chx/xru3d537S+ZFec8Bq9W8dbNWn9953NJ22f18LOB0wJqsDr99u1ZMhmX2s2phnenGmeNrMWHWh7Wv8WkssD17RqDxNx8yamrChgYIreNVEmWKg18Sc1aAoj2E0XBSHseIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=tOzOhZUc; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=V4lez11SJeGvJGWTRQrriGcYKPO/Eo25CyAOjTjCEWY=; b=tOzOhZUc6AWzL93bODAJ/5ilCB
	5MN8XqQdKRZqlvhRDDGgpxmM8jB2qLXfSjugOgFV89/afCAbBNaJe4weASEfHh5eI/7d5h7NAwGIf
	9rIQAZqCYGvYKjgYt0JUyd+5TudCqs7Tk6Fzy/K8OKo3DNuUO+QMDyLzfPyJ/9NoJ84YD5aF0irg9
	Rw2KLFXJ0CskQBnsWC4ZWfp/TKY8xYVlXlUasGidIytokO27flsOeTJWXvHs1MywegwSYrbp7JbG5
	7xHs0+M8NbDRhtTnWftmY9EdHw6FB6jjDDzYwfq5yMMSv3B3nQjujFJ6fAC9559ymltRbEF1hqk53
	kYOr/A7Q==;
Received: from i53875b47.versanet.de ([83.135.91.71] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tnjSX-0003dX-8j; Thu, 27 Feb 2025 20:22:13 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Yao Zi <ziyao@disroot.org>,
	Jonas Karlman <jonas@kwiboo.se>
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] clk: rockchip: Add reset lookup table for RK3528
Date: Thu, 27 Feb 2025 20:22:03 +0100
Message-ID: <174068411735.106118.14972067490193651658.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250227175302.2950788-1-jonas@kwiboo.se>
References: <20250227175302.2950788-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 27 Feb 2025 17:52:57 +0000, Jonas Karlman wrote:
> In the commit 5d0eb375e685 ("clk: rockchip: Add clock controller driver
> for RK3528 SoC") only the dt-binding header was added for the reset
> controller for the RK3528 SoC.
> 
> Add a reset lookup table generated from the SRST symbols used by vendor
> linux-6.1-stan-rkr5 kernel to complete support for the reset controller.
> 
> [...]

Applied, thanks!

[1/1] clk: rockchip: Add reset lookup table for RK3528
      commit: 5738362a5ee7e3417312e7fc03bcb0ffb12ba4f3

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

