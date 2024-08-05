Return-Path: <linux-kernel+bounces-274986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD3E947F34
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 18:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBD5A281F72
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 16:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC8315C128;
	Mon,  5 Aug 2024 16:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bgS5W+Jg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C1F1547DC
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 16:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722874962; cv=none; b=KgV152TWTGbQ0HOj/syH2EyVhu7BheTQ7BZWP5aT789fJjRyoOvXNZayFiPYpJ+CPkBnpWin/J+Tb7OC4Xo/LOdJ6JBXZ4rj7wklw24mYdcSro8plYU71TKGMESTTJgopVPkkkknvVfmdHxvT0sbr4QTtPa6OMY7L4wcXG16/uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722874962; c=relaxed/simple;
	bh=kJb9Nzn4L3q5iErkH+R1wHzptQi551rfi29AY5g9hFo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Ict3MCwjVNJplue4w8I8eXiiyvT5QmaP28Utrlde4C2Xggs2Q8E0vQduKGY4m51bseUn6fYPFtQYOwYHVLBFdBYWfxTwHKg1P4odB2FGKDs7kFGNzz0ptEUZMj2rXWeU9FvDhOPauJbOv9ammKtK9LZHR3upcVnmCIct+WTa1yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bgS5W+Jg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32207C32782;
	Mon,  5 Aug 2024 16:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722874962;
	bh=kJb9Nzn4L3q5iErkH+R1wHzptQi551rfi29AY5g9hFo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=bgS5W+JgYgSLChirLf/lB4w6vLA0M8TDiLMUksd6MFNPvpOyWySiVXrJgwAwx+F64
	 FAra/5OWjPyClmRAYo0rx0w/DVMadMYWisUTqxO0Igv0aN4nV1CDOolB2IgoNHK6YL
	 znnpNa3gEd8R5kZrXza/YiVAmK7rHA6Ui+V7f+DGzZBYV39BhVg9MzbpPpRB4JEc4Z
	 VcGqwP/wxqpb4qoMF4SjMTcelSH/qMHwVEZYKO6AkEFtS13ohjM2+gqtUPSpYCxHy7
	 Y6kRopIz1SANjwFQm8APUx7VzGIF9lolOcllgwmAyIyhZt+wARaAo7bMC3/QFrJWQN
	 mmMWIuzB1K0iQ==
From: Vinod Koul <vkoul@kernel.org>
To: laurent.pinchart@ideasonboard.com, kishon@kernel.org, 
 michal.simek@amd.com, Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, git@amd.com
In-Reply-To: <1722837547-2578381-1-git-send-email-radhey.shyam.pandey@amd.com>
References: <1722837547-2578381-1-git-send-email-radhey.shyam.pandey@amd.com>
Subject: Re: [PATCH v2] phy: xilinx: phy-zynqmp: Fix SGMII linkup failure
 on resume
Message-Id: <172287495984.454961.1953933716423263529.b4-ty@kernel.org>
Date: Mon, 05 Aug 2024 21:52:39 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Mon, 05 Aug 2024 11:29:07 +0530, Radhey Shyam Pandey wrote:
> On a few Kria KR260 Robotics Starter Kit the PS-GEM SGMII linkup is not
> happening after the resume. This is because serdes registers are reset
> when FPD is off (in suspend state) and needs to be reprogrammed in the
> resume path with the same default initialization as done in the first
> stage bootloader psu_init routine.
> 
> To address the failure introduce a set of serdes registers to be saved in
> the suspend path and then restore it on resume.
> 
> [...]

Applied, thanks!

[1/1] phy: xilinx: phy-zynqmp: Fix SGMII linkup failure on resume
      commit: 5af9b304bc6010723c02f74de0bfd24ff19b1a10

Best regards,
-- 
Vinod Koul <vkoul@kernel.org>


