Return-Path: <linux-kernel+bounces-436502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1659E86D5
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 18:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BF002814BA
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 17:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5A315ECDF;
	Sun,  8 Dec 2024 17:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJAKPGEb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2948B13AD03
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 17:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733677364; cv=none; b=YzEdth8zcUV1jGZP4GvtQgJTdUjD0LDXVOHJcgvAiNhXR6aXUuBVnWhGzevyHCOy6isYGBmqljnIBcP0rzc8eNhTQFjJHLqqE8Yy0cJY09DBDcH7DsOJ9zm7wJBvR/FU7yj75GnBSvdW/PqMlPsA4BADQ6H2npvigeCrsQ4Ag5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733677364; c=relaxed/simple;
	bh=IQCzJX9mzqFx0k8wCqsYT0do0fUE/zPwysTrpnz5vb0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PkReFHatA2igHxYqLkMxmzkIn4x0Ssa9EBuAbwDmpD/2S87AUo9te+z+MgrmKfGpSfVU0jC/diTXSip+rX9w1PQPNEQBILgoZ0CPd5KjkJ6RvRYiDdUmz7ZQtsa66vNvgYdu4nDEv9YE+1UCPZngqj4BIY1Qc3AUTj4zDsno7Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iJAKPGEb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B46F1C4CED2;
	Sun,  8 Dec 2024 17:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733677363;
	bh=IQCzJX9mzqFx0k8wCqsYT0do0fUE/zPwysTrpnz5vb0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=iJAKPGEbZzt4UwPydnM0avSvGXaRy6T1hLicejUhXPu3YuBoPGosCRX2Ad1RH0y+5
	 8AzrKuD7p5StOgU2d6lfkcXv90XQjaSUAHnakt85jEy4DC6qPlHiykaMK7YxplNJF1
	 ETWQAp/OK5umo+T+z4ChoRCKg/5PzDwdmQ6uR4noIlpYBKzUgpkAK34SCo7iL22HIv
	 ndJWgudL2sEQfEXeGGW+4ktgRDpgK8TI00cUPO4oAKYSwt+6DK+VVN6oPUTYhyW6vR
	 YhpfA5AVnaEwkpGhskVrQDt568Iiqm57U2VBGJu9ZQnVkdkdo+kvRDrEBO4NtLbted
	 jVWPc52Lc6VZg==
From: Vinod Koul <vkoul@kernel.org>
To: Kishon Vijay Abraham I <kishon@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, Philipp Zabel <p.zabel@pengutronix.de>, 
 linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Anand Moon <linux.amoon@gmail.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>
In-Reply-To: <20241012071919.3726-1-linux.amoon@gmail.com>
References: <20241012071919.3726-1-linux.amoon@gmail.com>
Subject: Re: [PATCH v3 0/6] RK3399: PCie Phy using new helper function
Message-Id: <173367736033.1042266.11057456243557400488.b4-ty@kernel.org>
Date: Sun, 08 Dec 2024 22:32:40 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Sat, 12 Oct 2024 12:49:02 +0530, Anand Moon wrote:
> Few clean of the phy change and Using guard notation makes the code
> more compact and error handling for mutex_lock/mutex_unlock.
> 
> Plz review te code changes, I tend to do silly mistake.
> 
> v1:
> [1] https://lore.kernel.org/all/20240901183221.240361-5-linux.amoon@gmail.com/
> v2: Fix some typo in the subjects.
> [2] https://lore.kernel.org/all/20241006182445.3713-1-linux.amoon@gmail.com/
> 
> [...]

Applied, thanks!

[1/6] phy: rockchip-pcie: Simplify error handling with dev_err_probe()
      commit: 84de918083d09500d93d991d8989addfaae1611e
[2/6] phy: rockchip-pcie: Use devm_clk_get_enabled() helper
      commit: e96397db55e5fbe290ff1462ddf6c24ed94eb7df
[3/6] phy: rockchip-pcie: Use regmap_read_poll_timeout() for PCIe reference clk PLL status
      commit: cb0ba26ad09398d3d0d10f518af4ccae69c8b64e
[4/6] phy: rockchip-pcie: Refactor mutex handling in rockchip_pcie_phy_power_off()
      commit: bb70d1aae565fd52e6a50e643d1ad6e7d419c2a5
[5/6] phy: rockchip-pcie: Refactor mutex handling in rockchip_pcie_phy_power_on()
      commit: 96522eeb8735449957272e9c6f8ea3b72dcbdeb8
[6/6] phy: rockchip-pcie: Use guard notation when acquiring mutex
      commit: c90a7a685a5d90228cedf7a5068f50b3da23ddfc

Best regards,
-- 
~Vinod



