Return-Path: <linux-kernel+bounces-212631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF1F906416
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 08:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 012AD2814C0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 06:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CA4136E3A;
	Thu, 13 Jun 2024 06:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Bc/ogHSX"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632F8136E09;
	Thu, 13 Jun 2024 06:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718260304; cv=none; b=Mp8TIxcVPEHbGIW+sO17tiIKrK2M13WcRW8Ts0jyb3ZB+2ltn6Cusn6kng284iImexOVchgk3yTEGa+WTio1YiaLkod3VWRJmJ2zeHO82nlqa7myh4DRo8PBI+4kFtwIsCyixFFuux7Ua6jg9cA2hmdIhbz2vF23g7YOteZSL44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718260304; c=relaxed/simple;
	bh=0t2/j3bOURPTFVJG/v7j6RxyjHqbymExqoWlsb+TMrs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lOkyFJszS0DO65ZD3HKOENurP1OoKVToQhVkXR2zvJRNnFJgWZuCvHzNuLnXFApf8ZmB70hwdk+csyx4n5pd2XMlecCJE0vq5IXRhWCGi267fYd/BrRsyDjHTdF8aA7N8uWAuU06RfluUPtKMme1rLiv7Kd6R0c09jbcu6vJ/Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Bc/ogHSX; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45D6VaqA114508;
	Thu, 13 Jun 2024 01:31:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718260296;
	bh=JcKIb3dZL9EXmDk8Yn0PIxa9lP2X7H8mA4i+eHiIHWs=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Bc/ogHSX/IKLlmBIZNcGXS9D2SnqPjDf0+FJRiQqniggOTtnJY01IPjgRraOPveR2
	 UYxvWj144yESBvkNAyGSd0HXYzHiEkFdcuLLwrh4m08n8Sh2UI+7oIAlr7OM0CePuM
	 cGTu9U+EKfi9P6NaIkFFzvtHcl2JyC3wvbhEk728=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45D6VaHu019151
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 13 Jun 2024 01:31:36 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 13
 Jun 2024 01:31:36 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 13 Jun 2024 01:31:36 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45D6VW7g008990;
	Thu, 13 Jun 2024 01:31:32 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: <nm@ti.com>, <u-kumar1@ti.com>, <bb@ti.com>, <devicetree@vger.kernel.org>,
        Jayesh Choudhary <j-choudhary@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 0/3] Fix reg ranges for main_pktdma dma-controller node
Date: Thu, 13 Jun 2024 12:01:22 +0530
Message-ID: <171826022269.240984.5184847581978215208.b4-ty@ti.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240430105253.203750-1-j-choudhary@ti.com>
References: <20240430105253.203750-1-j-choudhary@ti.com>
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

On Tue, 30 Apr 2024 16:22:50 +0530, Jayesh Choudhary wrote:
> The dma-controller node 'main_pktdma' has few memory regions with
> wrong sizes.
> 
> DMASS0_PKTDMA_RINGRT is marked as 4MB region when it is actually a 2MB
> region. Similarly, DMASS0_PKTDMA_TCHANRT is marked as 256KB region but
> the actual size is 128KB as shown in TRM in the section for Main Memory
> Map (Table 2-1)
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/3] arm64: dts: ti: k3-am62-main: Fix the reg-range for main_pktdma
      commit: 6edad223553c7f1680fcaca25ded59eba7c6d82d
[2/3] arm64: dts: ti: k3-am62a-main: Fix the reg-range for main_pktdma
      commit: d007a883a61f55b9b195c4c18bbe29de5b802822
[3/3] arm64: dts: ti: k3-am62p-main: Fix the reg-range for main_pktdma
      commit: a6e6604c600aeedf9700de4a55255850391bc3fc

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


