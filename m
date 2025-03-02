Return-Path: <linux-kernel+bounces-540532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 199C3A4B1E1
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 14:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 793A8166279
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 13:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF921E5B72;
	Sun,  2 Mar 2025 13:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="l4XjVN0u"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B345A1DF735;
	Sun,  2 Mar 2025 13:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740921674; cv=none; b=WtXLuCPK60Bo9NwFpJ5y14LH6qlQ2MhTwxsToKhO0NNV11CPzWUI8W+XPs35pCsCB/DXRc6RN0ZCBV2Snms+Qm3uDxkAs0zvu8k/6IfS7wNiHUB0+9eDXhdJrfzo2Rv3K+Gm+D6LnknZS36fCo8rXEw3uTPLPiO6/cJuzOcR/6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740921674; c=relaxed/simple;
	bh=FBwLect7tkHnU9NRM/QJrdozjaNfIlcDX2+CLibzE6g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fTDae90ZKiMPtGTGFIyPd54hD4aD7+AbcrOSme8vI6KnlnaWXXHxxG5d/Ywgff4uHZzHm5khLM5VGJi2W15Iazgja3aJHJM5zEHwiUAn2/dr2/9gwH9pKEZsCiE7LTgRXsv5YcKWbB3xt12PSoOw8/DcIr4wY7pU+korBs9bPTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=l4XjVN0u; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 522DKovK3080964
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 2 Mar 2025 07:20:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1740921650;
	bh=82ZzxMwz66wTm/Q8WAcyNS4waCVr3h4rwS5RxEI/cOI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=l4XjVN0uL46iXAx/TgrKXb3lgX+7w4gEKxz8SEgcNP2ub6m5vFAOCRjF8XcBRHbq0
	 x4dmz4DzDVX2MmliICdbQDhWUVxUkU4i9ox8vi/Z6AxUFQTHVc0p0oSb2Mw/jEK2eu
	 B0tmPTwO2It4ByGTEWQC+lVJH6nYO2JyCNOW62jA=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 522DKoOU018374
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 2 Mar 2025 07:20:50 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 2
 Mar 2025 07:20:49 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 2 Mar 2025 07:20:49 -0600
Received: from uda0132425.dhcp.ti.com (dhcp-10-24-69-250.dhcp.ti.com [10.24.69.250])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 522DKj8E070180;
	Sun, 2 Mar 2025 07:20:46 -0600
From: Vignesh Raghavendra <vigneshr@ti.com>
To: <nm@ti.com>, <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <jai.luthra@linux.dev>,
        <francesco.dolcini@toradex.com>,
        Stefan Eichenberger <eichest@gmail.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Stefan Eichenberger
	<stefan.eichenberger@toradex.com>
Subject: Re: [PATCH v1] arm64: dts: ti: k3-am62-verdin-dahlia: add Microphone Jack to sound card
Date: Sun, 2 Mar 2025 18:50:35 +0530
Message-ID: <174092143355.3272913.9537150435807250847.b4-ty@ti.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250217144643.178222-1-eichest@gmail.com>
References: <20250217144643.178222-1-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Stefan Eichenberger,

On Mon, 17 Feb 2025 15:46:04 +0100, Stefan Eichenberger wrote:
> The simple-audio-card's microphone widget currently connects to the
> headphone jack. Routing the microphone input to the microphone jack
> allows for independent operation of the microphone and headphones.
> 
> This resolves the following boot-time kernel log message, which
> indicated a conflict when the microphone and headphone functions were
> not separated:
>   debugfs: File 'Headphone Jack' in directory 'dapm' already present!
> 
> [...]

I have applied the following to branch ti-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-am62-verdin-dahlia: add Microphone Jack to sound card
      commit: 7139df64e7c13c079b754476355c62b490213055

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


