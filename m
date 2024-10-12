Return-Path: <linux-kernel+bounces-362566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD6799B678
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 19:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CBA51F2251F
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 17:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF4C839EB;
	Sat, 12 Oct 2024 17:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TvBrI/oz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6253824AD
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 17:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728755433; cv=none; b=rLwZ8sBJgHgIzXehj5HHEn/JBgNk/vKq9rno86kV5AMa7M2mkisnfmdKb82pdw3/34Z/lAskVUaM1LhsUFVLMmeNod5MbYEWEGcRwKC07/zwqWViHoiv/vFVMFMRKaihONNmz/OSXlPTySZt8U0h3FJMqcTzMAOKWkG20Rw+aNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728755433; c=relaxed/simple;
	bh=q1ravRMh93gOVs4GfZliVA7ooIqV8LEnvGU+TnI3WuQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=c3X/XPKD6WaTcFLCmRe1bVtc4lfPBNYrNnfjjaNXmJH3UKCuD8vgxvDvCt7l52BxTlON6PncmaFLZIObXcSq3w+vG0JJBG9pGvFxaL1IAbyRnix4WhaZJKk5w+kaT+ahSsAoSD4/sAR42ADYeRaJASXDzRueznhXDJS+xdNnz6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TvBrI/oz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75775C4CEC6;
	Sat, 12 Oct 2024 17:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728755433;
	bh=q1ravRMh93gOVs4GfZliVA7ooIqV8LEnvGU+TnI3WuQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=TvBrI/ozI36dPm9Y8l3gPjdaC0cDl0oXV6OkhAGoDMb756m4qxTaFlWnTtEtVZCup
	 AO/o+S8hgibnYQG81OZ8N1j9eTy1gCrR3E+LMkUKX2qytbCNbBx7sZS3f6T6UrNMbg
	 BDLvizmNOSkQc99ia6C0iNeGTjNzDHaApnG/WT31lHVLpQqI8OAdr6MiY92qpBB4r+
	 qZSR96Hv6CM2bvMcol5HPrBZCz/JBNO5NtvkkTkNx68RlJX+STMz7sWt0lazPohLrs
	 SJFhYWe4PG5CrBw7bH+Eb2LuiVL0AV2Ezm+55V7JHXrWR6EycKBrAUZ3c4badXsCOi
	 tSg+qkCmFqZLA==
From: Vinod Koul <vkoul@kernel.org>
To: kishon@kernel.org, thomas.richard@bootlin.com, 
 krzysztof.kozlowski@linaro.org, rogerq@kernel.org, 
 florian.fainelli@broadcom.com, c-vankar@ti.com, afd@ti.com, 
 Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, srk@ti.com
In-Reply-To: <20241010144845.2555983-1-s-vadapalli@ti.com>
References: <20241010144845.2555983-1-s-vadapalli@ti.com>
Subject: Re: [PATCH] phy: ti: gmii-sel: Enable USXGMII mode for J7200
Message-Id: <172875542906.55946.16970034988760011848.b4-ty@kernel.org>
Date: Sat, 12 Oct 2024 23:20:29 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 10 Oct 2024 20:18:45 +0530, Siddharth Vadapalli wrote:
> TI's J7200 SoC supports USXGMII mode with the CPSW5G instance's MAC Port1.
> Add USXGMII mode to the extra_modes member of J7200's SoC data.
> 
> 

Applied, thanks!

[1/1] phy: ti: gmii-sel: Enable USXGMII mode for J7200
      commit: 9e544d46a2d11a0cb8b30d8ad4409c59bc168ce2

Best regards,
-- 
~Vinod



