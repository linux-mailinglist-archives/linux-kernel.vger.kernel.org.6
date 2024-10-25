Return-Path: <linux-kernel+bounces-382324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A9A9B0C5E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 19:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0859B22CA1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 17:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101F618F2F6;
	Fri, 25 Oct 2024 17:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Q13IfKNk"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BBF189F45
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 17:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729879185; cv=none; b=Ga/TUi57G4EXOVrBu9wmnWj7p6JngbgXfRg6zzPjL19SbaEkvUC4nXqtB5z+PvnGC/RteOSKQBvhNNmknZbSTiP92gl0Dl8luqEFfS9AGoCsxthwoVZYq/GHEf6Xn7dX7Cmbo2MPImKj7RcDCjTLS1iKri7jqDbMk5cQs4nrTGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729879185; c=relaxed/simple;
	bh=sDClj3F2zVDw8HHKQa1Rcc7mMEGGNOUgcwk/dqrRQWw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XzqI/t8qzu+ZzjJXqJuCb59xRYD0kPF5XRXdnW/6mCVuv8kK8fsS+iKur5x2e3eNgl0iqbeo1ErkfknvzjBwpyXwKQoddUXfMnMDSWBVbGVpGzerslfX1MwDOV1OmlDDido+BUPH4wFm+pxvr83J4bvtFPPErEFwseZioA3f3ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Q13IfKNk; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49PHxQJc007560;
	Fri, 25 Oct 2024 12:59:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1729879166;
	bh=jcNoOZBJJBSwyMBSITJGawjX8pnb6pPwRpawRlbsCqY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Q13IfKNkSh86qp67RzR7TTIpltxw0DFWl2zM7lReqzU42HCSKehglIAkCDUsJBApv
	 xzLuShuzQ4tHry8PXhASC/bVmgACOA8VycY7Y/kb8oE0xEWIBEmHDz6gJu7PoTDNTJ
	 RQr1z3PgEr34bF4uqPVlb2InWdI0+Q6sFp8MLc5k=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49PHxQ9i027961
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 25 Oct 2024 12:59:26 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 25
 Oct 2024 12:59:26 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 25 Oct 2024 12:59:25 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49PHxPXl128559;
	Fri, 25 Oct 2024 12:59:25 -0500
From: Nishanth Menon <nm@ti.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier
	<mathieu.poirier@linaro.org>,
        Martyn Welch <martyn.welch@collabora.com>,
        Hari
 Nagalla <hnagalla@ti.com>, Andrew Davis <afd@ti.com>
CC: Nishanth Menon <nm@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: (subset) [PATCH v2 0/3] Enable compile testing of TI MSGMGR/SPROXY driver
Date: Fri, 25 Oct 2024 12:59:24 -0500
Message-ID: <172987914538.477005.11816962264560040485.b4-ty@ti.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241015213322.2649011-1-afd@ti.com>
References: <20241015213322.2649011-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Andrew Davis,

On Tue, 15 Oct 2024 16:33:19 -0500, Andrew Davis wrote:
> This driver can be compile tested on non-TI platforms. Enabling this
> also allows compile testing of drivers down the dependency tree,
> such as TI_SCI_PROTOCOL.
> 
> Thanks,
> Andrew
> 
> [...]

I have applied the following to branch ti-drivers-soc-next on [1].
Thank you!

[1/3] firmware: ti_sci: Remove use of of_match_ptr() helper
      commit: a4c14f509509a6a24f25edb7619f55f204a8433f

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


