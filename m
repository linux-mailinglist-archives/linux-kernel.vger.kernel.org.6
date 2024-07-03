Return-Path: <linux-kernel+bounces-238872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E56B92526E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 06:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7EF5B22041
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 04:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCDAF34CDE;
	Wed,  3 Jul 2024 04:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="N1X7fUDW"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDAC2232A;
	Wed,  3 Jul 2024 04:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719981346; cv=none; b=jO3KPLHVMnOcgUkly+tJrYHFwXjo1ikwfbqtkdqUWswM2xq/hnpCRTbYSXKQNB66ncbPXNXifuA3nk9fh/5GVx0tu1R9s5QpVyf4I/eSJ/wyv8YGZplLXbDnZLSV2rB150rL4FD8jH7Yh8kg6tRtKxUMLDF+mIy4Shoyk7gUkE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719981346; c=relaxed/simple;
	bh=lTjt4wOg7tX56upwDyCNJX26mSSus45Tg/NEEdUHOcI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ts3q1ul1Kt7FXTYjmgAWSaz0vyy7QqoT+oJ8yhSDasi3iuV2DkXXMS2p+OLWfFR3NXTjfXA4v4eyHh0DMlvScpQTHyY9fgSah81+hsqiicLyK9S63CB+qMd6+j84kQNs2+pJshVPbSc5Kw7JPOxMK6ITdfr3iCAaElIoNFRDOD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=N1X7fUDW; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4634ZWTp090305;
	Tue, 2 Jul 2024 23:35:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719981332;
	bh=o9ZvuFTO1AIYp36pP6+V8ZCP7f5Em5TI9MPHBD9A1Zg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=N1X7fUDWq0RWvVq0zGhmIVCMXljAuR6u9qEPlelG1/o7vdtVaoz6fQ3K2kR/RlI7g
	 fOPrMSiou0mFE3akJEle1HWXPDGEZkFqhANnHz64G+zSobeWojk+60WrFp4JCz2M8K
	 5DXF2KH50vd4gibUer7bh0H37FSBtNGXyNyDtw7Q=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4634ZW1U029834
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 2 Jul 2024 23:35:32 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 2
 Jul 2024 23:35:32 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 2 Jul 2024 23:35:32 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4634ZSrP009309;
	Tue, 2 Jul 2024 23:35:28 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Nishanth Menon
	<nm@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Tero
 Kristo <kristo@kernel.org>, Vaishnav Achath <vaishnav.a@ti.com>,
        Jared
 McArthur <j-mcarthur@ti.com>, Bryan Brattlof <bb@ti.com>,
        Dhruva Gole
	<d-gole@ti.com>
Subject: Re: [PATCH V2 0/3] arm64: dts: ti: k3-am62p/j722s: Add gpio-ranges properties
Date: Wed, 3 Jul 2024 10:05:11 +0530
Message-ID: <171984950185.3152309.941998277550954713.b4-ty@ti.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240627162539.691223-1-nm@ti.com>
References: <20240627162539.691223-1-nm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Nishanth Menon,

On Thu, 27 Jun 2024 11:25:36 -0500, Nishanth Menon wrote:
> This series was tested on BeagleY-AI[1] using the script[2].
> 
> This allows gpiod to request for a gpio that is not in the default GPIO
> mux mode and the framework controls the mux over to required GPIO mode.
> 
> The series is based off next-20240617.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/3] arm64: dts: ti: k3-pinctrl: Define a generic GPIO MUX Mode
      commit: 50d9981fa12212cdc0110c42db0411209bb5d765
[2/3] arm64: dts: ti: k3-am62p: Add gpio-ranges properties
      commit: d72d73a44c3c98109764bfb56c329cd628c518cc
[3/3] arm64: dts: ti: k3-j722s: Add gpio-ranges properties
      commit: 90d3d2eed998fef92f7bbc8557a843360516ccee

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


