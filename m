Return-Path: <linux-kernel+bounces-385243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A61F9B3475
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 16:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B86AA282599
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 15:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C851DE4D0;
	Mon, 28 Oct 2024 15:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nga35kRe"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2FE1DE3DF;
	Mon, 28 Oct 2024 15:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730128123; cv=none; b=IXzANsGuxmkLu4YdWNu309StYd4HoTRZaIhUvagIohtGVKIqKOb20tSm19BelowGzfsYysQZpE6SlQe5JKDYDYctP247fWXGg9jieAIoYPHwb0GnDA6sbE29NcjcRP2VnToTB/VcxzsoxrolGxa/ifVAdXPJnKEYSaPBOfLeDhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730128123; c=relaxed/simple;
	bh=gGFzmyVJQl8IHPLU/G2we3vRDQ1xUegh1rlxawRMHKs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JHSC3bGyzALZFTVhrtPJjf+HwPn9/cev1XYB4/11M6KDiV4GKygp4n+vbD9NHVyOzcwDFXWrvDMeulJzsWz73cLCPBsoBOSe2UGH9OjQKtI4lO79xS8u0kNT1zT+pBxKNArNQuvzZC7oTv8K9CAhC7TL+oxYPVKar5uj9UHrY8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=nga35kRe; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49SF8SC4092306;
	Mon, 28 Oct 2024 10:08:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730128108;
	bh=uTiIAkYLCBE5cLJwTYB6jvuj3Ej/hew6+3zdpGYew1A=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=nga35kReybkopyLMv9Yn1e8LEEvRlYTv1Lxyw62VHaa+we12oBQJQcLVA/NFJEEhB
	 jLviKBi3h5uZaePFr2vvxlfgmRFyHJfCAPa272l5X32bGjbpN+hhgnm/3VJO2UCsFV
	 TBqk7+6XIAjwOZ2aYkPwyVOl109O2tV9k6Ig9Es0=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49SF8Svq057794;
	Mon, 28 Oct 2024 10:08:28 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 28
 Oct 2024 10:08:28 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 28 Oct 2024 10:08:28 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49SF5tcu129665;
	Mon, 28 Oct 2024 10:08:25 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: <nm@ti.com>, <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, Nathan Morrisson <nmorrisson@phytec.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <upstream@lists.phytec.de>,
        <w.egorov@phytec.de>
Subject: Re: [PATCH] arm64: dts: ti: k3-am62a7-phyboard-lyra-rdk: Update ethernet internal delay
Date: Mon, 28 Oct 2024 20:35:26 +0530
Message-ID: <173012710990.558239.4218886473649588688.b4-ty@ti.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241004221049.1155022-1-nmorrisson@phytec.com>
References: <20241004221049.1155022-1-nmorrisson@phytec.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Nathan Morrisson,

On Fri, 04 Oct 2024 15:10:49 -0700, Nathan Morrisson wrote:
> Update the RGMII delay to 2.5ns to improve performance. We use an
> additional mapper board for the am62a7 phyBOARD Lyra which makes this
> delay necessary.
> 
> 

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-am62a7-phyboard-lyra-rdk: Update ethernet internal delay
      commit: e6c01aeb220274b1ce7b19d1b8fdfe433984cbd2

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


