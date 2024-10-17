Return-Path: <linux-kernel+bounces-370075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A56B69A2700
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 17:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AAC1280F99
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 15:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DE71DF250;
	Thu, 17 Oct 2024 15:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3yYh84E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C941DF240
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 15:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729179383; cv=none; b=KsNDh7SncU7zSGdML/tTLBfZdq1JdbZdSe/HT6+hLX2MO00LtYKXa108YoVl/T959HqYq15QRi7dwRBKwR/3u+izn0pzjszdi+m2Eo0zg0UWqF0oHNtEqo/oYnqFWM7yirXzSAuBFjAEIUtGUtrFnY9CKj8K/185kmNMsL5e0IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729179383; c=relaxed/simple;
	bh=VioDkU/PjFIM+BMA8JwIsGi2Honfh6sI28MlT1U/VzQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JyFEzffUhsRtLSquyUGhwhezFXZEXQX/XCz1/OmwEW979bi26Gh35Xrk4O8A2JMcTH9wVroOVPFazqBZU9UprhyFz09EY/50AFglGWN4rAhS0gr+rcwc/wM1Wl3oQBV1cIGpIbU/0tcMY0ryRBrGATc4gMrVtPnghaVnxmfRtbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a3yYh84E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7364FC4CEC7;
	Thu, 17 Oct 2024 15:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729179382;
	bh=VioDkU/PjFIM+BMA8JwIsGi2Honfh6sI28MlT1U/VzQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=a3yYh84EIJkVc4LkfQrgFttPMy4LcrMZeL+aThKAki8gAlyv0vCxpmxQffQVkcU6F
	 jFbUdnXJiqlRpUGYYumM6y9Ms34OxMfEXur0mifblC76BctDjlCsBMXh/m5koyIxPX
	 9A3GXxEFnFfdSnBB2l214Rqq7Vt6CNs7UscpdnXF0/0aLXCXAaumdXsoKae3KgZGJa
	 8/3Q3qjKT98Nr8G95ZqyjFzAJb484wNycwp6q0RNb23e73ykxQf+Fl8I8BGxcz2xNz
	 Xy628wguvkQPPcf6xhEm5/s8ITlDX+uruGTq6hLc7ObAnnxIJUAZ1jRuUNdXyyIqe/
	 ijtZ2mkuok5Zw==
From: Vinod Koul <vkoul@kernel.org>
To: Andy Yan <andyshrk@163.com>
Cc: kishon@kernel.org, heiko@sntech.de, linux-phy@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, cristian.ciocaltea@collabora.com, 
 Andy Yan <andy.yan@rock-chips.com>
In-Reply-To: <20240920093629.7410-1-andyshrk@163.com>
References: <20240920093629.7410-1-andyshrk@163.com>
Subject: Re: [PATCH] phy: phy-rockchip-samsung-hdptx: Don't request
 RST_PHY/RST_ROPLL/RST_LCPLL
Message-Id: <172917938011.288841.10984149232863813080.b4-ty@kernel.org>
Date: Thu, 17 Oct 2024 21:06:20 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 20 Sep 2024 17:36:28 +0800, Andy Yan wrote:
> RST_PHY/RST_ROPLL/RST_LCPLL are used for debug only on rk3588,
> and they are not exported on rk3576, no need to request it in
> driver.
> 
> 

Applied, thanks!

[1/1] phy: phy-rockchip-samsung-hdptx: Don't request RST_PHY/RST_ROPLL/RST_LCPLL
      commit: f2dbca169790ea1e436ffdd9ef37d7c3a4401c46

Best regards,
-- 
~Vinod



