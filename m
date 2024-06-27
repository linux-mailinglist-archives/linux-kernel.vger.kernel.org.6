Return-Path: <linux-kernel+bounces-233140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5518E91B2C5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 01:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11BD9284744
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 23:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346951A2FC9;
	Thu, 27 Jun 2024 23:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BWT1nzSk"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D0913B58F;
	Thu, 27 Jun 2024 23:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719531108; cv=none; b=NMzwBvbkJSAT/tyIxU48jx4NDI18D/3saUdHanAcNu6kbLJPbFVq3cWYtQRQ3lwwQ5H8h1YFVIRMW8BIpAcr/uePnOipiJayAd7cEaLj++SSxq+WGEd4EvE3/hQS+TdWhoss4IDnuUQjIwViTMzg2010YyGupk/qRPKH98HGE5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719531108; c=relaxed/simple;
	bh=Y2C58iMS1rC7jBjERQJ70o8iJaPYnqApBKqtWa1Ubl4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ETCIBuhZBJuDmY33gYUC4dWayclGqxJtc5Z2XmoNYkLQU49bTbCYlg8GIzKOWIm/2znQ5Bmh56mcxSrBglbgy8e9DlBsc/07EQlGxBoPeYCtt8EhB0drwWBkwGvCDLMBshpos87pcFyGZCwgd05yOOltuXQmdDE1a6ZUj8GuPIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=BWT1nzSk; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45RNVfeh064861;
	Thu, 27 Jun 2024 18:31:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719531101;
	bh=viBH8xEHWs7bGKbHzAD1OeDH+PahwuZmOpzT/pNStZA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=BWT1nzSk+QG7aXWdGOhMOHsDYtksU3qxbpkNv06fe3U7ewV/bbkRP9z52kZDp3R9b
	 oMIwK1TVQaWlqOTP0NYMQVsO4Xu90pbNHMAiSsG/zKliwkZKrG08nxgV9siWxCw49e
	 bfRWS3iUKuX2PNyhLdZ9Q2ZFlYDZ76S6fO17WODA=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45RNVfAh006999
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 27 Jun 2024 18:31:41 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 27
 Jun 2024 18:31:41 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 27 Jun 2024 18:31:41 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45RNVfCH094607;
	Thu, 27 Jun 2024 18:31:41 -0500
From: Nishanth Menon <nm@ti.com>
To: Santosh Shilimkar <ssantosh@kernel.org>,
        Christophe JAILLET
	<christophe.jaillet@wanadoo.fr>
CC: Nishanth Menon <nm@ti.com>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] soc: ti: knav_qmss: Constify struct knav_range_ops
Date: Thu, 27 Jun 2024 18:31:36 -0500
Message-ID: <171953106048.1077699.4550001367312717108.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <a8b4b428f97fc584f38bf45100aa9da241aeb935.1719159074.git.christophe.jaillet@wanadoo.fr>
References: <a8b4b428f97fc584f38bf45100aa9da241aeb935.1719159074.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Christophe JAILLET,

On Sun, 23 Jun 2024 18:11:31 +0200, Christophe JAILLET wrote:
> 'struct knav_range_ops' is not modified in these drivers.
> 
> Constifying this structure moves some data to a read-only section, so
> increase overall security.
> 
> On a x86_64, with allmodconfig:
> Before:
> ======
>    text	   data	    bss	    dec	    hex	filename
>    7498	   1193	      0	   8691	   21f3	drivers/soc/ti/knav_qmss_acc.o
> 
> [...]

I have applied the following to branch ti-drivers-soc-next on [1].
Thank you!

[1/1] soc: ti: knav_qmss: Constify struct knav_range_ops
      commit: ca16cb2b9073e2f2a968a04c794275aa21ee1aa3

Seems to work fine in the limited testing I did.

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


