Return-Path: <linux-kernel+bounces-550901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0E2A56588
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 11:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 725443B5A0E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E332520E33F;
	Fri,  7 Mar 2025 10:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XT4wEqAv"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98CA20B7FD;
	Fri,  7 Mar 2025 10:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741343795; cv=none; b=iBX0H2JcvwcYuSdOjh7N0IyTmrYZWX0KqfdLCT5FkuXcsMhpSrNY0l5wKh7Rf+3XorOk/Gvmidifq03mDx7xWBC7raIIhl0oi/cKcf35m06+mkxj/wuX8+D+yyaCC4Tkd0L4ZjNXt2pex3JsHZWVqIfRJdB07FcNlY9y7/Rz7Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741343795; c=relaxed/simple;
	bh=IoATmkm/Rjb3OeLxwhR108Qn/R1lDRmF3eQ5DLhG/Yk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nu/+5HATLcPtcBJXqfs5UntCK2vQynC3MVANC7LraDMyX1mV+vektC+Z2k6smOt5vjcP5OkcWkUm0mwQ1b7O6FKMquOfvOp9TzE1p6pDZICK+yFgIPsg+8unAV5fxqzX1m4DxnguqBpVEYgc9oY9q4HyIODQazfPq0xh1TQsRyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=XT4wEqAv; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 527AaLnA344561
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 7 Mar 2025 04:36:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1741343781;
	bh=Gv5g3lJSEQAWXZM3XwaU06yz84+apKewnJfFnIBLU0s=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=XT4wEqAvYJ83Njy8ZFvObjrXbTRKqkZcg9fsmzPXtw9k9ZGe2iayo+Tv9VDDtajmK
	 u4udPtHZP0dCjwMdsksZLqgE+kOJLhgYNQyWjgJFk1c19VisxZpnMykEVmRYJG/oI4
	 pCWzcH2EU8DXFXneMjK4bTYMjU9PxugKErgok/YA=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 527AaLNs029394;
	Fri, 7 Mar 2025 04:36:21 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 7
 Mar 2025 04:36:21 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 7 Mar 2025 04:36:21 -0600
Received: from uda0132425.dhcp.ti.com (dhcp-10-24-69-250.dhcp.ti.com [10.24.69.250])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 527AaH3S021509;
	Fri, 7 Mar 2025 04:36:18 -0600
From: Vignesh Raghavendra <vigneshr@ti.com>
To: <nm@ti.com>, <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Vaishnav Achath <vaishnav.a@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <linux-kernel@vger.kernel.org>,
        <jai.luthra@linux.dev>, <y-abhilashchandra@ti.com>
Subject: Re: [PATCH 0/5] Add J722S CSI support
Date: Fri, 7 Mar 2025 16:06:15 +0530
Message-ID: <174133309362.1072814.5440404016847301624.b4-ty@ti.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250218185452.600797-1-vaishnav.a@ti.com>
References: <20250218185452.600797-1-vaishnav.a@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Vaishnav Achath,

On Wed, 19 Feb 2025 00:24:47 +0530, Vaishnav Achath wrote:
> This series adds support for CSI2RX capture on J722S EVM
> and enables IMX219 and OV5640 overlays to enables
> 4 sensors on EVM, this provides a reference for a user to
> enable a different sensor on any of the ports.
> 
> Test logs:
> IMX219: https://gist.github.com/vaishnavachath/60cc2ef257601f27f28a315f8cf669c4
> OV5640: https://gist.github.com/vaishnavachath/648202286d4d34d4d25f7c8c9db8b8bd
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/5] arm64: dts: ti: k3-j722s-main: Add BCDMA CSI overrides
      commit: fb1b230bf9c45f5d6579dc329c2aafcd1263b70a
[2/5] arm64: dts: ti: k3-j722s-main: Add CSI2RX nodes
      commit: 8fea4519f625e6c1b05078f2ecea252b7b28b06e
[3/5] arm64: dts: ti: k3-j722s-evm: Add camera peripherals
      commit: ce553288ad2368f0d27e47b39a23121a825a2b33
[4/5] arm64: dts: ti: k3-j722s-evm: Add overlay for quad IMX219
      commit: c24ccb1cd77fb44087b2f7008d99626796b33ca4
[5/5] arm64: dts: ti: k3-j722s-evm: Add overlay for TEVI OV5640
      commit: 938806652b0a3c90d67e7137c91708d06940b03d

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


