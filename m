Return-Path: <linux-kernel+bounces-306548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB710964058
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 11:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B4B02821A6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 09:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C31218DF9F;
	Thu, 29 Aug 2024 09:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="TtWb0uEK"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776FA18CC01;
	Thu, 29 Aug 2024 09:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724924227; cv=none; b=SwB/7S3YzSi6vQ3cro3ZE8LYkmICps9X9X4guqJjboMP4fML8mZAwP8vr1uu/+6LvnLl56bukKRnGlYMKPc5TQ5PzEsYFEDFQLbBL9ihtjz2dWCO4HmFPyeTGZiOXJwLN8tJTpN32o9OSUh24/PNexoHv31LmJ0VRzbrcWZbAUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724924227; c=relaxed/simple;
	bh=82dXXvsSl7nPh9Mffs92ox5LvO9dlBIZwoU8wTP4E+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n7wtxXtvWkDbEaDjFHwoUel460JDv/rjgEGpJ8ks9FpDS+bqTD6d5d2mpxdXKfwPa7DerxWT1TWjecFSzX7So1Uki88XmGi9SF/Zo3fGA4X38yAFOTluSCWz4m2GIySXuFKTUIx4c4LygYO9Hxy7abiLFp7TIXm04PrU0mcwzn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=TtWb0uEK; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jcqQxRHrqDjRY4a9TzNalCHQ68bmxc540U58wjv9teQ=; b=TtWb0uEKIw0Mj8XzbE3gO9QHuR
	g9vDx2FiuikCPQTi7W4x2rSeoOAD6AA5v9w74JPY3znHo47/Ies6n2PtD8Hwjfe1A8GSoIoMCxJgQ
	CjF51T9+/dwHsNyi+ONAtiHTfdYuP+e2fiASStiQsXynvBKMjANLLwBMjx15LeEe7m1PX7PuMlCQE
	PfXFuu1+09cMOgQQiTBv3QnMbxwokOyp7pSV1JsZLIxANUusFkt7It/FEXtOVmkvO9wIh/7SEIAyU
	kQ+z3MSy/mKbBaWdpkvJwnu5nC44lZjCk+nQwy+OHvd7dlehZIC6cfFXwcF90LGSFoEgjEEQSDPUb
	TBh9deTQ==;
Received: from i5e861916.versanet.de ([94.134.25.22] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sjbaG-0002nq-Mv; Thu, 29 Aug 2024 11:36:52 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Detlev Casanova <detlev.casanova@collabora.com>,
	linux-kernel@vger.kernel.org
Cc: Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Elaine Zhang <zhangqing@rock-chips.com>,
	Sugar Zhang <sugar.zhang@rock-chips.com>,
	linux-rockchip@lists.infradead.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	kernel@collabora.com,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v7 1/3] dt-bindings: clock, reset: Add support for rk3576
Date: Thu, 29 Aug 2024 11:36:47 +0200
Message-ID: <172492351370.1695089.7443506809997782331.b4-ty@sntech.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0102019199a76766-f3a2b53f-d063-458b-b0d1-dfbc2ea1893c-000000@eu-west-1.amazonses.com>
References: <20240828154243.57286-1-detlev.casanova@collabora.com> <0102019199a76766-f3a2b53f-d063-458b-b0d1-dfbc2ea1893c-000000@eu-west-1.amazonses.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 28 Aug 2024 15:42:50 +0000, Detlev Casanova wrote:
> Add clock and reset ID defines for rk3576.
> 
> Compared to the downstream bindings written by Elaine, this uses
> continous gapless IDs starting at 0. Thus all numbers are
> different between downstream and upstream, but names are kept
> exactly the same.
> 
> [...]

Applied, thanks!

[1/3] dt-bindings: clock, reset: Add support for rk3576
      commit: 49c04453db81fc806906e26ef9fc53bdb635ff39
[2/3] clk: rockchip: Add new pll type pll_rk3588_ddr
      commit: e781bffc296766b55dbd048890d558655031e8d1
[3/3] clk: rockchip: Add clock controller for the RK3576
      commit: cc40f5baa91bb7b031f5622e11a4e443cb771527


general remark, please take a look at your mail setup.
Amazon seems to break the generated message-ids.

Your cover-letter is
  0102019199a75f9b-aab57db6-806a-474b-8295-e5be5a99d424-000000@eu-west-1.amazonses.com

while the patch (1-3) mails say
  In-Reply-To: <20240828154243.57286-1-detlev.casanova@collabora.com>

So that amazon thing somehow broke the message-ids in your mails.


I've also dropped the whole module part.

As always that Android GKI madness was cause for issues.
The driver claims to be buildable as module, but it looks like nobody
tried that:

First build-failure:
--------------------

../drivers/clk/rockchip/clk-rk3576.c:1800:36: warning: ‘struct platform_device’ declared inside parameter list will not be visible outside of this definition or declaration
 1800 | static int clk_rk3576_probe(struct platform_device *pdev)
      |                                    ^~~~~~~~~~~~~~~
../drivers/clk/rockchip/clk-rk3576.c: In function ‘clk_rk3576_probe’:
../drivers/clk/rockchip/clk-rk3576.c:1802:38: error: invalid use of undefined type ‘struct platform_device’
 1802 |         struct device_node *np = pdev->dev.of_node;
      |                                      ^~

...

missing platform_device header

Second build-failure, after fixing the whole module madnes:
-----------------------------------------------------------

  MODPOST Module.symvers
ERROR: modpost: missing MODULE_LICENSE() in drivers/clk/rockchip/rst-rk3576.o
ERROR: modpost: "rk3576_rst_init" [drivers/clk/rockchip/clk-rk3576.ko] undefined!
make[3]: *** [../scripts/Makefile.modpost:145: Module.symvers] Fehler 1



So when applying the series, I simply removed the whole module-part and made
the init look like rk3588 for now.


Somehow I always get the impression the whole "clock as a module" thing
is just there so Rockchip can ship something completely out of tree on
Android devices.



Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

