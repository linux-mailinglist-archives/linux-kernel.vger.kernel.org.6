Return-Path: <linux-kernel+bounces-214359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8FB90833F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 07:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C22021C21E09
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 05:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBDC114601C;
	Fri, 14 Jun 2024 05:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fZwJGRRD"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6673712DDAF;
	Fri, 14 Jun 2024 05:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718342159; cv=none; b=m5K/TEq+D4FYFbEm6jz3x9iKRqNYROG/8YY8Q7qYqSuvPd7WJG5oTuDTNXmqovRCCToA0Dot7+Ec8MmsJClhgRcak7ljqkLXnDcYQqNnX0jL0mu37B1/v8DNj6bWh3qv/klMIu/T481doF+MayGmiNRGP5mnLaM95JhSOXv6S+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718342159; c=relaxed/simple;
	bh=JBN0FBsIYFcblnapG5ttgKPqX2VTE4H4ZR7ZnEFd+mU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R7dMBapk5N933sFstkcTsFQp1Tkc1JH1hpJHbTFztNG14alDmFoYLtORimYc0VWNiW+hBXMLheRfq302BIHVYEIvxi2YLouxTyWOR8f4Q9paTtzRDQL4Uu503JEnZ5h6WwfApHYjEQTSk7acfeznJgLkbkElQAiifkNSxwbypTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=fZwJGRRD; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45E5Fpu8063901;
	Fri, 14 Jun 2024 00:15:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718342151;
	bh=4h74MkFidbzyzHuVuO81xL19XEL8426wwAknNxGp44g=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=fZwJGRRDpemaCH5ApsnVWQq4752PswDw9JswLvpkHSoQk1fjKU+3O7GJOtf7Mpc8N
	 OaUWtXClA9GtHrvy8zGVRY/bpA5mK+uRjOxr8HjBf9OXBdi35AZfw8hLz8tVA2IUC0
	 QWmdCSrBj12ttDuVkvahq5nHBZfrHnMZYZQWGY94=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45E5Fpl4130537
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 14 Jun 2024 00:15:51 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 14
 Jun 2024 00:15:50 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 14 Jun 2024 00:15:50 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45E5FkHQ063758;
	Fri, 14 Jun 2024 00:15:47 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: <nm@ti.com>, Ravi Gunasekaran <r-gunasekaran@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <srk@ti.com>, <rogerq@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/2] Add USB 3.0 support for J784S4
Date: Fri, 14 Jun 2024 10:45:45 +0530
Message-ID: <171826022274.240984.5150753966671933401.b4-ty@ti.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240507095545.8210-1-r-gunasekaran@ti.com>
References: <20240507095545.8210-1-r-gunasekaran@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Ravi Gunasekaran,

On Tue, 07 May 2024 15:25:43 +0530, Ravi Gunasekaran wrote:
> J784S4 has one USB sub system.
> This series adds and enables support for USB 3.0 for
> J784S4 EVM.
> 
> Change log:
> 
> Changes since v2:
> -----------------
> * Used generic node names; Renamed "cdns-usb" to "usb"
> * Rebased to tip of -next
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/2] arm64: dts: ti: k3-j784s4-main: Add support for USB
      commit: 75843b63741b122711d07b8fd672485e69223419
[2/2] arm64: dts: ti: k3-j784s4-evm: Enable USB3 support
      commit: bed97e94ee2d422f54334bd509b50ae2a3577f67

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


