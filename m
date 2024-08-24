Return-Path: <linux-kernel+bounces-300179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB2195DFE2
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 21:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD0FB1F21B07
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 19:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AAC980C04;
	Sat, 24 Aug 2024 19:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YuHlPrUD"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E13F7DA6A;
	Sat, 24 Aug 2024 19:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724529100; cv=none; b=f2XTZOncaYQq9QtEgcQRgdnNFDBHC+ORrMkRDN7Vey3Wj5JW/H1cIApDPUXQmxDiZ9X2bMxRpNJ3lGz40I2BtYuSxC75qqFUe7Z6iMhgj/GL5acvzvImj/uwuzgtHFpzUK7Nl9lAGiYDl9qRL75gFxUTpcGW1BCw180q3Mwtegc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724529100; c=relaxed/simple;
	bh=m+Ot5vptpQn5L00EhLbJ2uUhHSBIwzy47mzLKD40+V4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L/8oNv9Y7+UJmkylDJVvjyrj8Fjqe9kQmhlkSgxyR/hffmIymq/T/L9ERsD0MChXQp1ST1R9DTciUowGB10iTXm/MTSAENL42jlHgXstvI3PdZCh83StPT21SvuxOmMHOuDnF80UdhwSwhgdh5trmXNgGo/7jRbD1f8zbcpv214=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=YuHlPrUD; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47OJpWRN123741;
	Sat, 24 Aug 2024 14:51:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724529092;
	bh=1EiJhjJc157YYbfuh4R/Yh5wirvBQkUywNvyGqYkqCw=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=YuHlPrUDZuuEJycLLYk/PCqY+UnJX8FZbRLunJQr8/RRKbyoD6KXMcxMvH7Ose0I+
	 cA6KTe9YhrP1oA/cgnFk+H8DZSemBZoefB5V+lLYapJwGTBufD6rqk+HccaQCbLZ1n
	 A7NiaaDWetkfRVJ9R4ekxWupou3OpPUXcltTkAkw=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47OJpWAG023819
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 24 Aug 2024 14:51:32 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 24
 Aug 2024 14:51:32 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 24 Aug 2024 14:51:32 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47OJpWAg006224;
	Sat, 24 Aug 2024 14:51:32 -0500
From: Nishanth Menon <nm@ti.com>
To: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Jared McArthur
	<j-mcarthur@ti.com>
CC: Nishanth Menon <nm@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Tero
 Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH 0/2] arm64: dts: ti: k3-am62p/j722s: Add gpio-reserved-ranges for main_gpio1
Date: Sat, 24 Aug 2024 14:51:29 -0500
Message-ID: <172452907138.505399.8126802532403947878.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240809162828.1945821-1-j-mcarthur@ti.com>
References: <20240809162828.1945821-1-j-mcarthur@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Jared McArthur,

On Fri, 09 Aug 2024 11:28:26 -0500, Jared McArthur wrote:
> The current main_gpio1 gpio controllers for the am62p and
> j722s have holes that are not obvious to a user. Add the
> gpio-reserved-ranges property to the davinci-gpio properties list and
> add gpio-reserved-ranges to the am62p and j722s device trees. Prevents
> users from trying to access gpios that don't exist.
> 
> The holes are taken from the am62p datasheet [1] (Table 5-24) and
> am67x datasheet [2] (Table 5-27).
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/2] arm64: dts: ti: k3-am62p: Add gpio-reserved-ranges for main_gpio1
      commit: 235b5b08ea3cb2743309d7d27b85d34387ee4b54
[2/2] arm64: dts: ti: k3-j722s: Add gpio-reserved-ranges for main_gpio1
      commit: 67d820656fd87581e9ea8b27e42fbcdd0202b3b5

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
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D


