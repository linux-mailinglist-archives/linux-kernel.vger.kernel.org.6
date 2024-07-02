Return-Path: <linux-kernel+bounces-237863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC96923F14
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 15:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81A141F21E18
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 13:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B24D1B5824;
	Tue,  2 Jul 2024 13:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JAhqTkdW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CF51B581A
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 13:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719927356; cv=none; b=Zsue/NVOcS2u/bSBmQxkPlAoxxW0Qjh7i2B8W3SWo+EDej7rqCEiTM43nAsgyYtcJQI5Ea9t/24tFsh8pyeE5j1JVUj0+Dw6U7CpLzKMMUje8yGbE/ZU5a6DJROkB+YYb5YWhgCfN0Dh3uk+tXX7TSg7TxClj8dMwMgolCeLKnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719927356; c=relaxed/simple;
	bh=48PkDyDUvZMMR6IBtDoMchEdpn2pXQqKeNjxhWItlj0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dWUCVKYJIeCapH+yP00Et5GlT3a0qaxxbArFLcugX8+BS0ZLrbbvGoT8yjtylmQvXjUJYGb0twq1yHxvzB0W/ZWXa+xS+1CxtlDRKLhPiRn9vblbvXs31czSYlma9wwDrDurRUauRrEePTnvrTGxuLFaCW0ctZzXAvdjRal+R8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JAhqTkdW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBC7AC116B1;
	Tue,  2 Jul 2024 13:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719927356;
	bh=48PkDyDUvZMMR6IBtDoMchEdpn2pXQqKeNjxhWItlj0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=JAhqTkdWuky9Hus31OP2zR0HpcxU8nasg5c8iAitECspRvUQSUH+W3OxbyW8VBOWw
	 EhLe1CXEPDIwHp5QhxyfH/XRILmKmdKh7akA9qEteQ/QMLq6onyjN73bMwflHGG9eu
	 XAmKPhyLFK0MAP70t+iwytSu6JmFT88ODo4ox3SmMWzgIZqkf/49yeTM7SOHxpa2JY
	 QDgb0BozC+S79VuKCBm3EZ6SYukiLNMVsffNTEUiwCCncvVz+alNezljLq38Yt8iqn
	 W4TMD/PAt9MT6r9NmJrjmnLRGwlWEhycP99Zvh7OsgsnQp5KzWT3j5znGeo71JntsC
	 s+46OvUHxyX/g==
From: Vinod Koul <vkoul@kernel.org>
To: kishon@kernel.org, rogerq@kernel.org, sjakhade@cadence.com, 
 sergio.paracuellos@gmail.com, robh@kernel.org, Ma Ke <make24@iscas.ac.cn>
Cc: linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240702032042.3993031-1-make24@iscas.ac.cn>
References: <20240702032042.3993031-1-make24@iscas.ac.cn>
Subject: Re: [PATCH] phy: cadence-torrent: Check return value on register
 read
Message-Id: <171992735350.699169.6447434833645425767.b4-ty@kernel.org>
Date: Tue, 02 Jul 2024 19:05:53 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Tue, 02 Jul 2024 11:20:42 +0800, Ma Ke wrote:
> cdns_torrent_dp_set_power_state() does not consider that ret might be
> overwritten. Add return value check of regmap_read_poll_timeout() after
> register read in cdns_torrent_dp_set_power_state().
> 
> 

Applied, thanks!

[1/1] phy: cadence-torrent: Check return value on register read
      commit: 967969cf594ed3c1678a9918d6e9bb2d1591cbe9

Best regards,
-- 
Vinod Koul <vkoul@kernel.org>


