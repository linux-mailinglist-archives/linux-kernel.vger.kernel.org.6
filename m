Return-Path: <linux-kernel+bounces-240685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEC29270FE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 09:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6106B21CC0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 07:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A031A38DE;
	Thu,  4 Jul 2024 07:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YeBeMj5w"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58610FC02;
	Thu,  4 Jul 2024 07:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720079757; cv=none; b=U8Sk+F7d2eRoT3+RGMD7EWckYidDlAiCl243YJooTbuHooUp2XBdswsuBxvFCEKmEUcDKqQZMzLsWXxcscbRPJQXhSVsNVsYcvf6BeCcBHj1VycSfQs5lFa1GWhsTModQUxin2lueETmFqCzJQBI57ReBlJ2vMgQKYenvueJUL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720079757; c=relaxed/simple;
	bh=hjCpRoltlgqohI/BAnQn3IDnQGTnuNH84vw40iv7jtM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o3yExa8qbMa1AX5YxF1pazkJPHgjX675EFYaNVbDGRhnsxbluHjkSwACLx56MZOGQIaon9VQmAwWZn7SNft/E5qVdQJpuxpHGf04WAIkgvr7Xw2gR1QAWy1xEbet988IlBJGXEJgHBWRtCYiJ1hjlBRkcNWA5pmel876DtFMnBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=YeBeMj5w; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4647tppT106320;
	Thu, 4 Jul 2024 02:55:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1720079751;
	bh=YZuxeGF3GdY/dlHGqX/6qpAicX07ZBtugn0l33LKaRw=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=YeBeMj5w3RWmE6hvcHQ6yLtXAI8FAiIbKBEl9R616KFXj0B0Oq9n0NFwiIElsqryx
	 gHKYQAyfjEt0mzHW5EA4ooqS03C8kjbWj9WB44mvHVxbQhBPT1PylCFAocBQuPfpSX
	 zwRj94WAaZKjP8CQrckDpy9hrPUNmX2TFjDJVCvE=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4647tpIO116698
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 4 Jul 2024 02:55:51 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 4
 Jul 2024 02:55:50 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 4 Jul 2024 02:55:50 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4647tkPT055890;
	Thu, 4 Jul 2024 02:55:47 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: <linux-kernel@vger.kernel.org>, <nm@ti.com>, <j-luthra@ti.com>,
        Jayesh
 Choudhary <j-choudhary@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <u-kumar1@ti.com>
Subject: Re: [PATCH v2 0/3] Enable audio for J784S4-EVM platform
Date: Thu, 4 Jul 2024 13:25:41 +0530
Message-ID: <171984950182.3152309.11906676054269729748.b4-ty@ti.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240626101645.36764-1-j-choudhary@ti.com>
References: <20240626101645.36764-1-j-choudhary@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Jayesh Choudhary,

On Wed, 26 Jun 2024 15:46:42 +0530, Jayesh Choudhary wrote:
> These three patches enable audio on J784S4-EVM platform.
> - First patch adds the McASP nodes.
> - Second patch adds the audio_refclk1 node that is required
>   to configure the CTRL_MMR register for the external clock
> - Third patch enables the analog audio
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/3] arm64: dts: ti: k3-j784s4-main: Add McASP nodes
      commit: 5095ec4aa1ea3d253c09486eaab42fa1a8b48c9a
[2/3] arm64: dts: ti: k3-j784s4-main: Add audio_refclk node
      commit: 3ea5142a97346653ed797438495503025062ec02
[3/3] arm64: dts: ti: k3-j784s4-evm: Enable analog audio support
      commit: 479112c9f5315604b5a96e10efddcd375a0e56a3

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent up the chain during
the next merge window (or sooner if it is a relevant bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git
--
Vignesh


