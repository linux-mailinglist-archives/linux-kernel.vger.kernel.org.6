Return-Path: <linux-kernel+bounces-385242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B52839B3473
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 16:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 441721F22850
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 15:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7061A1DE2C6;
	Mon, 28 Oct 2024 15:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hoiUXP12"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB95615E5B8;
	Mon, 28 Oct 2024 15:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730128119; cv=none; b=Dgq4iV0ui21Yz1Tw4WbGxDFKjkLUvykpHp9L66wWB6jBzXIhjNDlKm9TvCYTS++FpkPViTSClOChmiTY0ruCUF/k3nrehpzZp4l9OuI7TRXxjk9r6KIzQDFVhPPWIjLdtH+JKq1ovBWhTsIrq81yZgNkT0PM8dQ74AWp3Q0Im6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730128119; c=relaxed/simple;
	bh=26+cZqrw+8QZ80a1WVWhlt2dmB4sZlUyh6HWEMIJmDI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OC64PfqK5+BGDYcOM/08sjF6Pwj0wNDtXweLjceFFQwPOmeIVJ+GmeTxDsf1atu7/tjfNOHnDy4N9zLdqldsnzgZtLGHX89sIYGAbASFucMUvfJ463HdKGJwTFe/AS6+xVvItpaOl7ZEaev4GkBi3ghKey5XLpeOAtkztlIKaB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=hoiUXP12; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49SF8BvA005538;
	Mon, 28 Oct 2024 10:08:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730128091;
	bh=zkTdVlTW/i5WYDBFKyKCfHptSPFJOKhP2+osqRe1mCQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=hoiUXP12Iw5adaChwA91jtMELvdxpDsOM2+iSm7FSNrB+6BmQvQgoWLenokxVBWFJ
	 Rsz9I/+eR2N8zDkUna4m/SrXPlBReTmtftxvp3ye0jMS49Y82ShdKVPZ6G5KqoWukS
	 lSNx3e+A88u5EFQkul2GVUICJl5vxn268njtl4pg=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49SF8BPs057680;
	Mon, 28 Oct 2024 10:08:11 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 28
 Oct 2024 10:08:11 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 28 Oct 2024 10:08:11 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49SF5tcr129665;
	Mon, 28 Oct 2024 10:08:08 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: <nm@ti.com>, <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <w.egorov@phytec.de>, Garrett Giordano <ggiordano@phytec.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <upstream@lists.phytec.de>
Subject: Re: [PATCH v2 0/2] Reconfigure 1.4GHz in AM62 PHYCORE SoM
Date: Mon, 28 Oct 2024 20:35:23 +0530
Message-ID: <173012710988.558239.17362858553590828268.b4-ty@ti.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241001071916.1362213-1-ggiordano@phytec.com>
References: <20241001071916.1362213-1-ggiordano@phytec.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Garrett Giordano,

On Tue, 01 Oct 2024 00:19:14 -0700, Garrett Giordano wrote:
> This patch set moves our 1.4GHz opp table definition out of our overlay
> and into our som dtsi. This change goes along with our updated PMIC, which
> is now configured to output 0.85v by default.
> 
> We drop the overlay as it is no longer needed.
> 
> Changes in v2:
>   - Use git revert to revert the overlay patch
>   - Update commit message to reflect revert adding the device tree overlay
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/2] arm64: dts: ti: am62-phycore-som: Increase cpu frequency to 1.4 GHz
      commit: bc3552d675537be111148d9614f4f02f31e30de3
[2/2] Revert "arm64: dts: ti: am62-phyboard-lyra: Add overlay to increase cpu frequency to 1.4 GHz"
      commit: 151ed40a4f204e8786a2573e3f8083ffd29f3b1e

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


