Return-Path: <linux-kernel+bounces-228566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD569161B3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 10:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF566B2447B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 08:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E949148850;
	Tue, 25 Jun 2024 08:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="M8EM7sP0"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442A71B7E4
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 08:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719305625; cv=none; b=B51eC0l1QrAHq4KpvYWOi3pmok7pOASp16bvTiqEaq+jj4RMMsea0/2uGR+ScYIK8aMVPMiYve65G85gvOwibpyiaTG/YERyVSQmjLql2E3JDvsEUz0BeDqX++agwLElJWmI+HWoj8aTzRSmBphBkTZRMHd9MYqKMwSiWCB1A1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719305625; c=relaxed/simple;
	bh=YOcm1zlwyhTPzTPr2aOMlF90PGWT5yQusFLpand5ZQQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=V/WKv3t9UimPSoLsuJSLEBQOk+JUcF4dJT/dK9E7qu/+rT8CivhPA1GU0Su3Eo689KYyoQpnmYWi8AMD/bI5ue8gCJZkn2f4zIjQRl5JTlMt0WME+q/urSR0NT8vEK01hX16luIuL+vBB2AB9bopSYAU6o9zZAi+MY9UlqhR2PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=M8EM7sP0; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1719305622;
	bh=YOcm1zlwyhTPzTPr2aOMlF90PGWT5yQusFLpand5ZQQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=M8EM7sP0e1l+Ih25lsmcb4ouFivJMXzeUEW+DSQOY7uLm1GtNaMD2V8zEwThXHwKC
	 g7FCPFDClmDki5YldWeBeA/F7tlsiBqP/fG0Zcrx2qlYZ327Uki2Kp3CWAUN3fb199
	 C5dbJBvN/Upofbnz5tZMSjKc/D2xdfo/Z9cm1UUo0tIMHvamGjwkZfK1Wldgo5YmGY
	 gcb1SpFEK1oNIhVPEqrYiPsyurixYKFhj9KwbhvPPShRxW5IJvjiZNOlozp8WaveED
	 4cZYL4BvTnE+8Jl7MFtUsNmYakWlcooa0ZFI0mfMHqD0MhnMFPRtPXlg5gf7/xcmGf
	 BeadAbRL4a9gQ==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id AA357378045F;
	Tue, 25 Jun 2024 08:53:41 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 "Jason-JH.Lin" <jason-jh.lin@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Jason-ch Chen <jason-ch.chen@mediatek.com>, 
 Singo Chang <singo.chang@mediatek.com>, Nancy Lin <nancy.lin@mediatek.com>, 
 Project_Global_Chrome_Upstream_Group@mediatek.com, 
 Hsiao Chien Sung <shawn.sung@mediatek.com>
In-Reply-To: <20240625083957.3540-1-jason-jh.lin@mediatek.com>
References: <20240625083957.3540-1-jason-jh.lin@mediatek.com>
Subject: Re: [PATCH] soc: mtk-cmdq: Add cmdq_pkt_logic_command to support
 math operation
Message-Id: <171930562162.73186.3438008106670002170.b4-ty@collabora.com>
Date: Tue, 25 Jun 2024 10:53:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Tue, 25 Jun 2024 16:39:57 +0800, Jason-JH.Lin wrote:
> Add cmdq_pkt_logic_command to support math operation.
> 
> cmdq_pkt_logic_command can append logic command to the CMDQ packet,
> ask GCE to execute a arithmetic calculate instruction,
> such as add, subtract, multiply, AND, OR and NOT, etc.
> 
> Note that all arithmetic instructions are unsigned calculations.
> If there are any overflows, GCE will sent the invalid IRQ to notify
> CMDQ driver.
> 
> [...]

Applied to v6.10-next/soc, thanks!

[1/1] soc: mtk-cmdq: Add cmdq_pkt_logic_command to support math operation
      commit: c1c028b8d5e6ef00a13bfc340fc60a9c27135017

Cheers,
Angelo



