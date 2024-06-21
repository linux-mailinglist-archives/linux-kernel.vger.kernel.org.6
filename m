Return-Path: <linux-kernel+bounces-224967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A741291293E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 17:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB07B1C23B85
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 15:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C95955C3E;
	Fri, 21 Jun 2024 15:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="utQPc8xh"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F74374D1;
	Fri, 21 Jun 2024 15:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718983030; cv=none; b=J8TGeiGOvskxTG9L/2eCecOMSt1l7AuYlaNeNdv3MuDL8ZYty6VMsZ9plWKDIP21ofPMmp99N6FcDmlIPAUSjO0yDgYBzga7XFE6qyQg0KV0YmwP2Cdv4iWvLRLk29qLXND7HWGsZAoo2QbH+SIonycTeqBCBzfQqCIChFsz0BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718983030; c=relaxed/simple;
	bh=37+hd08I1T6GodrRhAnd9tk9oBcSMZ+kDvs1tu6eI3E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dCv+7TaNORsHXKLV6VwOvjJfOVotMp5Y+QAOtO9jNOg37dbH+jblwoO7mfaBfRxFZDje3feKKlkvjretKzEwfnqgXRihAS+TduVB8DRXAx4ScN+Md7kHMRlk2BC5/DHmi/6gZEmYvCth3S9GeBwAYCixyuTprwAVu4JO/wNKf48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=utQPc8xh; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45LFGomn080374;
	Fri, 21 Jun 2024 10:16:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718983010;
	bh=XbBF79bZTa5YI1QbHJEUN+iBpddUT0rwSMM8ISbB17s=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=utQPc8xh2RcR2tpF/ZIteGFEL2hsroDOB2qGeIhcAhqXq0rRVoQYsth7/xnzpG4WU
	 jYz21n5cMAKn5Xlq1A5w+CtSFvGqVic57Tsb2mqHaLikuYyndrLe1pNCrvq9SN4N2D
	 He6U0eqywPSJhbaUjUmiKG6/m6uYgBFoabmS7V3s=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45LFGoot040538
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 21 Jun 2024 10:16:50 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 21
 Jun 2024 10:16:49 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 21 Jun 2024 10:16:49 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45LFGjB7066628;
	Fri, 21 Jun 2024 10:16:46 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Roger Quadros <rogerq@kernel.org>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <afd@ti.com>, <srk@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5] arm64: dts: ti: am642-evm: Add overlay for NAND expansion card
Date: Fri, 21 Jun 2024 20:46:44 +0530
Message-ID: <171898028153.2272421.3051817978263340632.b4-ty@ti.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240614-am642-evm-nand-v5-1-acf760896239@kernel.org>
References: <20240614-am642-evm-nand-v5-1-acf760896239@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Roger Quadros,

On Fri, 14 Jun 2024 18:06:42 +0300, Roger Quadros wrote:
> The NAND expansion card plugs in over the HSE (High Speed Expansion)
> connector. Add support for it.
> 
> We add the ranges property to the GPMC node instead of the NAND
> overlay file to prevent below warnings.
> 
> /fragment@3/__overlay__: Relying on default #address-cells value
> /fragment@3/__overlay__: Relying on default #size-cells value
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: am642-evm: Add overlay for NAND expansion card
      commit: 117937ff2fbf1f67e6e7cbe1635bbe1cc72dbee2

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


