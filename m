Return-Path: <linux-kernel+bounces-387247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CED379B4E79
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 16:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9918B287194
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 15:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B988A196D9A;
	Tue, 29 Oct 2024 15:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yIiw3GBc"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FAE198A36;
	Tue, 29 Oct 2024 15:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730216914; cv=none; b=FSJGqK5LaF4iGwOg0EWR3HXrkxCv98RDkKdmLsMOGwBf6kOinklAkZ9HIvrFJXOsNrAyJcyZQYGhA4G4OTkjk8U2aqMAv8eIX3JF+tfF+AzqgUBnOYv/3tEdtns9rmKYgz1rkdo6vuatr+23pbHdDy5KFULFNgzyLiIrXcHjhQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730216914; c=relaxed/simple;
	bh=nEFIVuMRxxzSa9o6m5KWkulUr9erVh2P3TySVgEBdxs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O1G6eFPehKbuf/zX7yGi85sA1vP8KtdlNzosT12g0LdWzLJrpkL/Cp7SChBjys15hS+6yROaD8KVTpfYt/0j9YNrk24K8ycdrNLLZFwl2aWC6/8miYGmiQ21SoWzLkVDwAxFbCdOj+Y8JkYSviOYV5jP+ajGN+S1KsK/T/DZXxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=yIiw3GBc; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49TFm1uc114777;
	Tue, 29 Oct 2024 10:48:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730216881;
	bh=5jZp44ao9GgsPKwOd2u5mw6DAfNNVFmUXvM3+52JYbo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=yIiw3GBcBipLu9dYvdDsnTgk9lHqdymFbM4a19NZb0iJKlpBCL1+AjAZlu72W50GF
	 /JQQa1L1EBviTIYZfN4dK26sVYc/ikvWJjxZuI8mDmz81pwxY6Y9Ef9LxduIqdRN4u
	 vd5Xyc1v+m1hhX8YF84VDgHW33NOsQgWjdUfKAOA=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49TFm1W0029172
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 29 Oct 2024 10:48:01 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 29
 Oct 2024 10:48:00 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 29 Oct 2024 10:48:00 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49TFlunr083726;
	Tue, 29 Oct 2024 10:47:57 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: <nm@ti.com>, <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <d.schultz@phytec.de>, <w.egorov@phytec.de>,
        John Ma
	<jma@phytec.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <upstream@lists.phytec.de>
Subject: Re: [PATCH 1/2] arm64: dts: ti: k3-am64-phycore-som: Fix bus-width property in MMC nodes
Date: Tue, 29 Oct 2024 21:17:54 +0530
Message-ID: <173021674668.3859929.796823456061016223.b4-ty@ti.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20240926184918.3342719-1-jma@phytec.com>
References: <20240926184918.3342719-1-jma@phytec.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi John Ma,

On Thu, 26 Sep 2024 11:49:17 -0700, John Ma wrote:
> The bus-width property was moved to k3-am64-main.dtsi.
> 
> See commit 0ae3113a46a6 ("arm64: dts: ti: k3-am6*: Fix bus-width property
> in MMC nodes")
> 
> 

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/2] arm64: dts: ti: k3-am64-phycore-som: Fix bus-width property in MMC nodes
      commit: 018465cd811a11d00ac4160e5c97c4549336ede4
[2/2] arm64: dts: ti: k3-am642-phyboard-electra-rdk: Fix bus-width property in MMC nodes
      commit: dc2660a603214c98994068af378a4ac124c44c57

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


