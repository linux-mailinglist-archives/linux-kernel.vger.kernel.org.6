Return-Path: <linux-kernel+bounces-370052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8AF09A26A5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 17:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D179E1C22462
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 15:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050F41DEFCD;
	Thu, 17 Oct 2024 15:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uswtB3Gp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6870E38FB0
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 15:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729179091; cv=none; b=tWIrCylnIk+ihowZip8rIQ36ijjjaUHai1FwOicDi76YUiCaQOi0+pRn829cS/O7/fGJ95cuBOuwm6PK0Mdzqxl/Qo3UU3bcriH/zgdRI9vdgyeO6gA79uTyfOJAbon+MBOjExymk1ecbuKWMTM2r8q3Zejlp18NPxPJhQYWqY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729179091; c=relaxed/simple;
	bh=pJlne4O+hiRoKrVESYd7ZzTl2xhLfmxtBKYXZjLxDCk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DKyHK/WKTylfqVpa31XbleIkYZEtJVI5QH6VivlO9MZXYgPLTd517oG6ti8x7yEqTiVy+HqfnnK/VzJC+Xo/vrIloF7HZBd8ltsQIW5sHv4/4qGRi0T7scUFptGJUHxUiknGvx1ocjBYfjJ07haZO7xYiFfeIwioJY6T2WJAemg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uswtB3Gp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4694C4CED2;
	Thu, 17 Oct 2024 15:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729179091;
	bh=pJlne4O+hiRoKrVESYd7ZzTl2xhLfmxtBKYXZjLxDCk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=uswtB3GptBdfN6pGrOAJEhg6ba1tcT1O253Ad0JcuDCwbiASs9bRNP5uL33TCICz9
	 47GmVcWQAWnClTugiDCFA5ORUOIIR631VWB0QZJcgkAwE0g5efGUEvzUEpzRPTLwbl
	 0Rku4XMtHc+Z9vtrwM3v8sHaZlmbxpur/54uw43pRkuJlabKizQoeE5Rhpzh5KTJoH
	 mLSg0N0Fv+vXGEGFKko09HRCWBQ4sRcHKt3ao8lv8ynMh7WfOIy23FuIwJ2DY1eayk
	 SA/mPWa0ILTZnVOoax9H6hS2XwGEnve0R75q9rTxDFQ2JAzosFs4jLzsmRWQW/TRrW
	 oxj96KDaGjPPw==
From: Vinod Koul <vkoul@kernel.org>
To: kishon@kernel.org, thomas.richard@bootlin.com, 
 krzysztof.kozlowski@linaro.org, nichen@iscas.ac.cn, rogerq@kernel.org, 
 c-vankar@ti.com, t-patil@ti.com, Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, srk@ti.com
In-Reply-To: <20241012053937.3596885-1-s-vadapalli@ti.com>
References: <20241012053937.3596885-1-s-vadapalli@ti.com>
Subject: Re: [PATCH v3] phy: ti: phy-j721e-wiz: fix usxgmii configuration
Message-Id: <172917908756.278159.7051019346885032299.b4-ty@kernel.org>
Date: Thu, 17 Oct 2024 21:01:27 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Sat, 12 Oct 2024 11:09:37 +0530, Siddharth Vadapalli wrote:
> Commit b64a85fb8f53 ("phy: ti: phy-j721e-wiz.c: Add usxgmii support in
> wiz driver") added support for USXGMII mode. In doing so, P0_REFCLK_SEL
> was set to "pcs_mac_clk_divx1_ln_0" (0x3) and P0_STANDARD_MODE was set to
> LANE_MODE_GEN1, which results in a data rate of 5.15625 Gbps. However,
> since the USXGMII mode can support up to 10.3125 Gbps data rate, the
> aforementioned fields should be set to "pcs_mac_clk_divx0_ln_0" (0x2) and
> LANE_MODE_GEN2 respectively. The signal corresponding to the USXGMII lane
> of the SERDES has been measured as 5 Gbps without the change and 10 Gbps
> with the change. Hence, fix the configuration accordingly to support
> USXGMII up to 10G.
> 
> [...]

Applied, thanks!

[1/1] phy: ti: phy-j721e-wiz: fix usxgmii configuration
      commit: b4b32423b6ee6bb96e19fd82bcfd372f6192c737

Best regards,
-- 
~Vinod



