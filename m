Return-Path: <linux-kernel+bounces-233138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BAC491B2C0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 01:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B53DD1F21C91
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 23:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C7D1A38D1;
	Thu, 27 Jun 2024 23:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="u5lbMZul"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B09E1A38C9;
	Thu, 27 Jun 2024 23:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719531067; cv=none; b=IfU4eRJSZizTbcODWi1lyaUVQGTG0Il9wTqHOU2UOWCZKddbIN+3s/wChuKMm+AiGQMUCAauWcQyJgiordttB8FSDMzoNDkI3kmN+Hrt6TihSluFYtRKz/5qMV8YNnXkFRdpe2jkpQnytPU9QvEotFUk4J66oMV6yjfGTZk2JrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719531067; c=relaxed/simple;
	bh=lP+GmlpaVR7qbZiOWsfepDjofJVd8UeMHyw2NPv8uZY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T5c+Tk7lwBh/8OOdF5NofQlFRmUqWhRgtelcXJmxACUqHljN4tl5h4AXo3mk8PLHRSnNVSnUnRIMxdfVN3ZmimXaQ02g7Yg98A3u5uufdn2UH8dbueRiI/oh49RXxRQwaEkf29GxC0f7jthvknh5wEURR0Rr40jOkgTzfNRKRnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=u5lbMZul; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45RNUsH5064759;
	Thu, 27 Jun 2024 18:30:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719531054;
	bh=DGXQzLrHQCAkjLyf8biACo5NorkjCpVPhJuLvMjrJD4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=u5lbMZul43FkCmhBN+5jnnjcF4a6ier9yc/k64aWKQmDHDaAKHJiyNUTgAPUrhgnA
	 qCR4I5T5CnJ7ibcC1QY3UbSBkH96cCgK9yagokhnGkvHa8pCTtDqlvcqnrZo+B+NE5
	 DOSB9G8iGYWikIxbUtGI2/MRyg3ArtgYDdocvXjg=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45RNUs96039799
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 27 Jun 2024 18:30:54 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 27
 Jun 2024 18:30:53 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 27 Jun 2024 18:30:53 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45RNUrEa093765;
	Thu, 27 Jun 2024 18:30:53 -0500
From: Nishanth Menon <nm@ti.com>
To: Tero Kristo <kristo@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>,
        Richard Genoud <richard.genoud@bootlin.com>
CC: Nishanth Menon <nm@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandre Belloni
	<alexandre.belloni@bootlin.com>
Subject: Re: [PATCH 0/2] fix TISCI protocol URL link
Date: Thu, 27 Jun 2024 18:30:51 -0500
Message-ID: <171953091074.1077352.7915036920327002451.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618150933.1824185-1-richard.genoud@bootlin.com>
References: <20240618150933.1824185-1-richard.genoud@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Richard Genoud,

On Tue, 18 Jun 2024 17:09:31 +0200, Richard Genoud wrote:
> As the http://processors.wiki.ti.com EOL in january 2021, this serie
> fixes the URL with a new working one.
> 
> Richard Genoud (2):
>   dt-bindings: ti: fix TISCI protocol URL link
>   firmware: ti_sci: fix TISCI protocol URL link
> 
> [...]

I have applied the following to branch ti-drivers-soc-next on [1].
Thank you!

[1/2] dt-bindings: ti: fix TISCI protocol URL link
      commit: 9040d64f58d275c9f2fc563887ec245f249b0e8f
[2/2] firmware: ti_sci: fix TISCI protocol URL link
      commit: f1de10ae7bbfbb2c443bf18f15e4b1b497868b45

With the ack, I assume this flows in through the TI SoC tree, so picking both
of the patches up. Please let me know if there are any concerns.

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


