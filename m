Return-Path: <linux-kernel+bounces-212742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC7290658D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 09:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B94951C237CF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 07:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0EF13C80C;
	Thu, 13 Jun 2024 07:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tD4WR9Xn"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBB45A4D5;
	Thu, 13 Jun 2024 07:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718264815; cv=none; b=H68yWd9seEsJix9UJaX8RaQh7qwjc+Ocdj45mH95GeZ62WUc14GGEKrpOEAlQ0jBSY5F7f1Ou6f7MS1wBoQoQn8vrZbXE3RK1VJZuB9xrINEnEkRcjCkuHEuqTM+QNYn/UeHEw45JV611V4hvf9WinjJUudUnZyqRwZ/HP4/gU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718264815; c=relaxed/simple;
	bh=kMezFUXCdWZ65qnFBl5Qb4ikRCdXqPPUJuPHnGGkUmU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j1U5p8fhD2BIIaw5aGII9uG3AJvOv4y6vaSueW4YYz2UZp4pweJAn3hJddKz+bGDCU4+M84cGgmCv/MklHLWY0TFkdDetydqpV6HWfiSqMShJ9y4+DQQQxoszc5qDxBpjC9UDp1ilohz1o0c2fviaofCODFnWzhQRWOimiisG38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=tD4WR9Xn; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45D7kneq087978;
	Thu, 13 Jun 2024 02:46:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718264809;
	bh=C1psUPPufdLmFYNmqU62e8tF4g/GomsS4JEzXlgHNBw=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=tD4WR9XnDLjbI3gVo73dnu29jLjLF3HMZ0wqNA6yAIQ9CWCRP23CbJ5lZdPqQirfI
	 nlcgIosOjKDX5zhGDBY2vyUf7UA7EmIz9G6UPgLFTvM5ewyjYTW8GkBIczilR7U8v7
	 YNVfeGD4cTXM0AnE2SBAe/DF3Xtm2p0f2LZypEyA=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45D7knw8058881
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 13 Jun 2024 02:46:49 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 13
 Jun 2024 02:46:48 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 13 Jun 2024 02:46:48 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45D7ki3T119048;
	Thu, 13 Jun 2024 02:46:45 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: <nm@ti.com>, <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, Vaishnav Achath <vaishnav.a@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <j-choudhary@ti.com>, <u-kumar1@ti.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] arm64: dts: ti: k3-j722s: Fix main domain GPIO count
Date: Thu, 13 Jun 2024 13:16:41 +0530
Message-ID: <171826022272.240984.17084650953206943074.b4-ty@ti.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240507103332.167928-1-vaishnav.a@ti.com>
References: <20240507103332.167928-1-vaishnav.a@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Vaishnav Achath,

On Tue, 07 May 2024 16:03:32 +0530, Vaishnav Achath wrote:
> J722S does not pin out all of the GPIO same as AM62P and have
> more number of GPIO on the main_gpio1 instance. Fix the GPIO
> count on both instances by overriding the ti,ngpio property.
> 
> Fixes: ea55b9335ad8 ("arm64: dts: ti: Introduce J722S family of SoCs")
> 
> More details at J722S/AM67 Datasheet (Section 5.3.11, GPIO):
> 	https://www.ti.com/lit/ds/symlink/am67.pdf
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-j722s: Fix main domain GPIO count
      commit: 2cdf63e73415ce6c8f6b3397cdc91d5f928855f9

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


