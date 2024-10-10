Return-Path: <linux-kernel+bounces-359989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65AFB999348
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 22:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 257641F24030
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 20:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9183B1CEAD6;
	Thu, 10 Oct 2024 20:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UNC1I7pt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012301B5325
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 20:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728590512; cv=none; b=gaKzOBg5ClkUVGLGFLua2+yCHiLzX3hC4sMt7qFuRyuxni3vhuSc9hWUupQB1J4ISoQmJLJkE5t1uptCS65pvxNfCv4wgXO1TySbpgX1QUqI3z1MlaF70gbvZsOsiRr4X2pycNP6BQX/T/2oExhGZSy2iuXQSeFt8PiJGdrGuRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728590512; c=relaxed/simple;
	bh=dHcKPbdsy7bztUIL3nQ1holZJu15pDDcGKddst8ydn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j79qBIpSyLky+6wgk8nIOGm04aTAuv5WqzYCpDzpEA1oFRpF5HMV5omMqmWVvFLl8UW07TO8X8UFzMcxacgLGT1mLVEuMjuuUxwFpM+cemSNuDWMovr2kD20+HSVfZYKUHNIixZIxEQlyDtqiQp/kfGDZ2KS5lgbFWR0DLJUniM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UNC1I7pt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD59AC4CEC5;
	Thu, 10 Oct 2024 20:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728590511;
	bh=dHcKPbdsy7bztUIL3nQ1holZJu15pDDcGKddst8ydn4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UNC1I7ptyGVcQ3iMOrP5ERKov1smya7HpiJEII4RIWdpt2wu7KsqFHgGH/t9An3qa
	 RZOgSbvk7Es5AqAIcKHdkTeKtkzsr8wbJpZf+4duPl7G8oiII15jtQLYkl7yiLSzRe
	 OPEdWoxPl9YGBcfo/6zCAsbHt+KYMVED+SO59Vvy/mmiqZRhd8WIRWEK/EOwmzyIqS
	 TT2YAWqdfJ/QTeoB4bXE++mq1K022rzezYV4+QFwR/o0jD2hPBddff+G5t2XLD+Dzx
	 7deBG6WcZ+sDxOHZLAg5YxrtQeTGT7AS5BgwnUyvXBS0uPifTBwT6UWeFEcqp1iI07
	 RdTit902ysrow==
Message-ID: <4f91147a-1284-4901-982e-29bcb1a5c41b@kernel.org>
Date: Thu, 10 Oct 2024 23:01:45 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] phy: ti: gmii-sel: Enable USXGMII mode for J7200
To: Siddharth Vadapalli <s-vadapalli@ti.com>, vkoul@kernel.org,
 kishon@kernel.org, thomas.richard@bootlin.com,
 krzysztof.kozlowski@linaro.org, florian.fainelli@broadcom.com,
 c-vankar@ti.com, afd@ti.com
Cc: linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, srk@ti.com
References: <20241010144845.2555983-1-s-vadapalli@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20241010144845.2555983-1-s-vadapalli@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/10/2024 17:48, Siddharth Vadapalli wrote:
> TI's J7200 SoC supports USXGMII mode with the CPSW5G instance's MAC Port1.
> Add USXGMII mode to the extra_modes member of J7200's SoC data.
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Reviewed-by: Roger Quadros <rogerq@kernel.org>

