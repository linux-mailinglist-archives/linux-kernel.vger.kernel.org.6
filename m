Return-Path: <linux-kernel+bounces-238863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D454F925247
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 06:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FDA928423D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 04:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823F539AC3;
	Wed,  3 Jul 2024 04:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ezZOOk4+"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BBD2E646;
	Wed,  3 Jul 2024 04:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719980912; cv=none; b=D13SDfzi9dANS5mIsnx1pQUTqHZ7Li90UgultAKVGshtxpS+7eLdGKzgGMDem24UMAg2KQfZVa8lVflp9u6W+QBA2rzzPAon2xpXEmZw7ryFZ5/bGBK7x0znAbEWFwVH66FmuOxe3/rf1oXbls8ZFLUFP5arwgTJYcZb8b9mD9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719980912; c=relaxed/simple;
	bh=Fkm5sdPkA6UYATDj0u0i/yFW61gUyzpjf3ngn0JwNgs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DaKFCyACfreHgs6HOo/r5pAgo2g1nGYVyK3ANrak9FzZGgfQwn0CqaKeLV0oE5SHcj6XYkA2JL1l8jeRyeQbRGLUZ1fhaDLHkje2WIyFNXJgvf/62CtWks9XV7pQHqglEFvMzffe7YzIl5LebugsOlB9Ap1O5CYt3T7jZ4kJa0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ezZOOk4+; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4634SCus060488;
	Tue, 2 Jul 2024 23:28:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719980892;
	bh=BTV7hM111key7GH2Su926BtfNkjbH/jr+oyyFeTWu74=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=ezZOOk4+vjUJqsT80/tFQFsLcv6ylzM4pJGte2pbEBBKSAcvJ1hqSEMdm8l160cQY
	 vqpbcREIzmk29xxSwve3l0HSX7x2uB4yhu1N4w+Vtr43Ds3CV9vaXJ3iTIk/hU2KVy
	 Yg5Rkl6+1gTKSoEMybbMP4/rbkp3o7HmabvPNyEw=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4634SCfZ126645
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 2 Jul 2024 23:28:12 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 2
 Jul 2024 23:28:12 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 2 Jul 2024 23:28:12 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4634S8CR041726;
	Tue, 2 Jul 2024 23:28:09 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andrejs Cainikovs
	<andrejs.cainikovs@gmail.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>,
        Andrejs Cainikovs
	<andrejs.cainikovs@toradex.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] arm64: dts: k3-am625-verdin: enable nau8822 pll
Date: Wed, 3 Jul 2024 09:58:06 +0530
Message-ID: <171984950179.3152309.9767144134155266216.b4-ty@ti.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240418105730.120913-1-andrejs.cainikovs@gmail.com>
References: <20240418105730.120913-1-andrejs.cainikovs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Andrejs Cainikovs,

On Thu, 18 Apr 2024 12:57:30 +0200, Andrejs Cainikovs wrote:
> In current configuration, nau8822 codec on development carrier board
> provides distorted audio output. This happens due to reference clock
> is fixed to 25MHz and no PLL is enabled. Following is the calculation
> of deviation error for different frequencies:
> 
> 44100Hz:
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: k3-am625-verdin: enable nau8822 pll
      commit: feebfe95a6654e991befca7dee45788979fd7f72

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


