Return-Path: <linux-kernel+bounces-238875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 664F992527B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 06:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 214D228B657
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 04:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3330638DD2;
	Wed,  3 Jul 2024 04:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PK32F36f"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE732232A;
	Wed,  3 Jul 2024 04:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719981574; cv=none; b=Bqj46czmnLfBWawsJpXdy0JLJY+4w+YxANoKLyNGhMyV558pQcaeGZM7w1RAJWK8UWPXwDy29D3eu7tZNUn75rcNTtoLBxur+KOAm+XlQvFr4hXPFkxBP3wB+pL+yevY9gbLNqwJf/4TJtg/3HGd+DqJGcBMPZZu2K0gZbzwYS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719981574; c=relaxed/simple;
	bh=rXfLHCvQqVGbbaxrGRVm8ysFjS2nucIX/6ks96HT4hw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R3fJgFhrv+bmwEP79gYOd33upbN9wkwslgTEckgB70OZ00Eyl1YsVq9UVCzt7Ru6nTYA05ErOH2yQ9rqtEHeVXdRelcOHpAC+mffWmm76BW2c+S7YIVgII0fEs9xj6YJ800V17NBs4L3FJ7z1HtK1Y+zLQRdkrNJMYj6541sH6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=PK32F36f; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4634dQ8u064632;
	Tue, 2 Jul 2024 23:39:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719981566;
	bh=/1Eg8vQ4Vxi7v3m/O/uum223vtD5GjiOMiwNP9a/ys8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=PK32F36fCMVtoTIjqCU3kDX0fi2UQoCz4bg38j5k3/Nu4Go3bWe/SsFrNDTxbtX3z
	 zB1f4fllSNiyQAoFy54nlcGOsuys5/o+e4n9O+6sJ1niteS9Km3uLczkSFbPzXEmI4
	 39q11rMfaXnBb959aN6VifCYjrBnw+xonZVXcroI=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4634dQ1U028493
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 2 Jul 2024 23:39:26 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 2
 Jul 2024 23:39:26 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 2 Jul 2024 23:39:26 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4634dNHP013653;
	Tue, 2 Jul 2024 23:39:24 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Nishanth Menon <nm@ti.com>, Dhruva Gole <d-gole@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Roger Quadros <rogerq@kernel.org>,
        Andrew
 Davis <afd@ti.com>, Tero Kristo <kristo@kernel.org>
Subject: Re: [RFT][PATCH 0/2] dts: ti: Fix build warns in usb@31000000
Date: Wed, 3 Jul 2024 10:09:21 +0530
Message-ID: <171984950185.3152309.13270720287525957044.b4-ty@ti.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240626101520.1782320-1-d-gole@ti.com>
References: <20240626101520.1782320-1-d-gole@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Dhruva Gole,

On Wed, 26 Jun 2024 15:45:18 +0530, Dhruva Gole wrote:
> The series has been marked as RFT because although I was able to boot
> test, it needs to be made sure that usb features aren't affected by this
> change. Ideally, looking at the driver, I don't think it really is
> looking at port@X but incase I missed anything please feel free to point
> out.
> 
> I'm working on top of tag: next-20240625
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/2] arm64: dts: ti: k3-am62p5-sk: fix graph_child_address warnings
      commit: 28a950c404679aba602e3311c733a19b7c945ab4
[2/2] arm64: dts: ti: k3-am62x-sk-common: Fix graph_child_address warns
      commit: cf645197f045147cd0232c7a205cdfed49590756

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


