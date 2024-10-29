Return-Path: <linux-kernel+bounces-387228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8411D9B4E3C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 16:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A51BB239E7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 15:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C794F194ACF;
	Tue, 29 Oct 2024 15:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tGJEk60n"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5492BAF9
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 15:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730216407; cv=none; b=n8QJEAjObmFVWDPO99wextTFGAVNnfcKeJLlBgqwpBZtFgIK5iTdt0b50MA1gM8d21KXFi6a9D3ZV5asJnygaxzl7ywtWxYsGMz76a8fMrllfs7YcWeHzgfnAVhF3LYPHdeZ8NiGvZ2NG/N1hyJufqIuYyy4dUPM1JPdJlMNe+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730216407; c=relaxed/simple;
	bh=ONMB/g0wQUdlCgza/1G2IhsNeWG/Ri6vETD0mt6PMj4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dXFEKvp0csqAUmUzD59opkL1K8GwmJ93c5fLVJWYn3gjoCasYstX7nNZHqdrQu2/2uSukpyYyPigpU3+i271ImEYrDISbjQKB5UqcBkAdUmYQiSzaTy4vGxZa7a9aZ8bJrIOfSlapYfzLyAtuowOGNCz7BQUIdk1n9ooAbldKWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=tGJEk60n; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49TFdbqb015864;
	Tue, 29 Oct 2024 10:39:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730216377;
	bh=tfxRcEl6yujaoJeBe/6KC02FQAg8zOwmpFzGDqZ1dbc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=tGJEk60nkEi1Xj5urMOa2cgwRrLMH45WFwXUx/n0DjvqjZMoKUD9B67maQJE+c3FJ
	 zATcVg2BigwW8JmWnIKYeRJ6VuEiBD/i73ZoNXO/XIHYGuvxa1zeFgCtmyuczNg9bp
	 IafzDaTljI5dG0NCYLMo+JDRVfigX+T01/LtTLLw=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49TFdbkd001965;
	Tue, 29 Oct 2024 10:39:37 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 29
 Oct 2024 10:39:36 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 29 Oct 2024 10:39:36 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49TFdWIu073456;
	Tue, 29 Oct 2024 10:39:33 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>,
        Wadim Egorov
	<w.egorov@phytec.de>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <quic_bjorande@quicinc.com>,
        <geert+renesas@glider.be>, <dmitry.baryshkov@linaro.org>,
        <krzysztof.kozlowski@linaro.org>, <neil.armstrong@linaro.org>,
        <arnd@arndb.de>, <nfraprado@collabora.com>, <nm@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <upstream@lists.phytec.de>
Subject: Re: [PATCH v2] arm64: defconfig: Enable PCF857X GPIO expander
Date: Tue, 29 Oct 2024 21:09:30 +0530
Message-ID: <173021636094.3847953.6331486710052708801.b4-ty@ti.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241003063642.2710384-1-w.egorov@phytec.de>
References: <20241003063642.2710384-1-w.egorov@phytec.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Wadim Egorov,

On Thu, 03 Oct 2024 08:36:42 +0200, Wadim Egorov wrote:
> Enable the PCF857X GPIO expander which is equipped on
> the PHYTEC phyBOARD-Lyra AM625.
> 
> 

I have applied the following to branch ti-k3-config-next on [1].
Thank you!

[1/1] arm64: defconfig: Enable PCF857X GPIO expander
      commit: 8461bcf0a3d9d39ff9d858c06c2c820f711a8182

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


