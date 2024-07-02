Return-Path: <linux-kernel+bounces-237864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3FA923F15
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 15:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABD632820BD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 13:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251E91BA060;
	Tue,  2 Jul 2024 13:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BKHR4H/O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1AA1B583C
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 13:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719927359; cv=none; b=rsxpBVhd8B1piF276qPCED09JUNXAypH3AWmGVOLida1fWzA/NwNCwAOGfG/6YIc3W55Konz7zyI//fNmzrTo2yzyBxgsbGlo3Rp3LY996E0AW0oijGfxBJcZ/OzyJ4rp5KDYk2yfxosDmMyfGlp/Bc+gi2KIe4bXLEVAs0S6S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719927359; c=relaxed/simple;
	bh=ngYStSfDt3gm2V4MgO5eTyDmvV+QTyC+9v7LEeYoVSw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Y+BBgb0l9bMXAMUE/rK8qQmGYgRlMVjwo5decv59c8okjFvz1R6C1+X24aJIIwPSqLA1Q39dAAbXdAdo4CKUgdN/AEfpkEtmO3EMIVbQ+txtYwdG1viNdjI13jqAHTdMGusUfV9NwTz8BzsQFYCT+YwCMV8QsbrsYlD4WLkaxBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BKHR4H/O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA0CEC4AF0E;
	Tue,  2 Jul 2024 13:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719927359;
	bh=ngYStSfDt3gm2V4MgO5eTyDmvV+QTyC+9v7LEeYoVSw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=BKHR4H/Ovc9HcJ0QEYYKrmhje3heu2JxfYnL9E4zdGhQ/QNHqI9/JWMl/TeSrxxOK
	 nOj9+sqqg2JY9sf/YX+O5ngzn2e0l7Dg7K63T9uxPfpU5FYsMH16MgufmwC3T4qD80
	 GdrRf/j2g0ppyvvdWjfcFWDgFSWTe/wbYGIJIeObHFv4KBOhqCYJ46c4pDmZmolrMB
	 u3VI6ue76m8qsMm3RDfVFEcuBebhXjntKONIa+gssVkNAAqBWy/BXAGM27hXwWfOng
	 BNErva/l+VU6Sa8xMXoB1VHTpJhtFk13f+6lP2Kmox7YT5wPy92+bXVfDOlNbYrzvt
	 ttJw1HCp1NcNQ==
From: Vinod Koul <vkoul@kernel.org>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 linux-phy@lists.infradead.org, Sean Anderson <sean.anderson@linux.dev>
Cc: linux-arm-kernel@lists.infradead.org, 
 Kishon Vijay Abraham I <kishon@kernel.org>, linux-kernel@vger.kernel.org, 
 Michal Simek <michal.simek@amd.com>
In-Reply-To: <20240628205540.3098010-1-sean.anderson@linux.dev>
References: <20240628205540.3098010-1-sean.anderson@linux.dev>
Subject: Re: [PATCH v3 0/5] phy: zynqmp: Fixes and debugfs support
Message-Id: <171992735643.699169.10848642893790191835.b4-ty@kernel.org>
Date: Tue, 02 Jul 2024 19:05:56 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Fri, 28 Jun 2024 16:55:35 -0400, Sean Anderson wrote:
> This has a few fixes and cleanups. Additionally, the last patch adds
> useful debugfs info.
> 
> Changes in v3:
> - Remove inapplicable comments
> - Take the phy mutex in xlate
> - Use "none" to represent ICM_PROTOCOL_PD, since the lane may not
>   actually be powered-down.
> 
> [...]

Applied, thanks!

[1/5] phy: zynqmp: Enable reference clock correctly
      commit: 687d6bccb28238fcfa65f7c1badfdfeac498c428
[2/5] phy: zynqmp: Store instance instead of type
      commit: 6959d2367bc3503ac4ba3eb4ec6584a43150d6b3
[3/5] phy: zynqmp: Only wait for PLL lock "primary" instances
      commit: 235d8b663ab9e6cc13f8374abfffa559f50b57b6
[4/5] phy: zynqmp: Take the phy mutex in xlate
      commit: d79c6840917097285e03a49f709321f5fb972750
[5/5] phy: zynqmp: Add debugfs support
      commit: 04490b621ab16d09ce5b7c62b2c8cc9fdb871421

Best regards,
-- 
Vinod Koul <vkoul@kernel.org>


