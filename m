Return-Path: <linux-kernel+bounces-381822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3349B04EE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 16:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 995371C20D9A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 14:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC467745F2;
	Fri, 25 Oct 2024 14:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wdqX+JU4"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164E77083E
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 14:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729864959; cv=none; b=Cx+hHJseWxGw3b9ja3p6LmLOSFha2/5NP3ZRo8VakoRnhAofu6rmzxpJdRSyNyTY+TJOpACWfnXs3nAvCqpajxMBS7IOIBA7Kr2Qok6Mxs1WENf46f86cmnOX21NwDX3c9qgtYZRH7K7vg4R9+Lz6h+adJgbRCyne9PNdY2cWp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729864959; c=relaxed/simple;
	bh=C8EhAFYHJmPFwg/VTuYOqiv9m1vivboI5hxsdQyRQhA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QAuyw+L+EOz1YLq/HNzGpAC0JsgQEFtVRSic3GLHCz+TmHLuI/USPYV6JX8zpvbc4egAVHjv4CIeWv36X4/cv8zqAnjDoA+RDMtsgfRFH8Cf2G6+J+FI+Zoa7u79T6A5/SUe0V9GiuZYFSQSMpcDF99gzLxWyzKWSXddZVFO0wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=wdqX+JU4; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49PE2MN1105797;
	Fri, 25 Oct 2024 09:02:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1729864942;
	bh=v5vByOCJHAiQILFVYELX1Nhfd7tzaKXTJqOTEiiXr0E=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=wdqX+JU4FYbaPEQUDLr9NwUg7xxcjI4ZefgrmcSXIsI3ze7vDj/G6DL9ZTRMpq4de
	 S2laTbqdv5YEVTR3VZcWnzEKxF4JfQe118rOoAgtJPnke9K/mAQgFFR1jLAatIhvyh
	 TMeblBNp8r0aQ8fFXyW2ivAvjwHHvIR/cmImkPcY=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49PE2Mhs060117
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 25 Oct 2024 09:02:22 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 25
 Oct 2024 09:02:22 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 25 Oct 2024 09:02:21 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49PE2MrC126993;
	Fri, 25 Oct 2024 09:02:22 -0500
From: Nishanth Menon <nm@ti.com>
To: <ssantosh@kernel.org>, Alessandro Zanni <alessandro.zanni87@gmail.com>
CC: Nishanth Menon <nm@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <skhan@linuxfoundation.org>,
        <anupnewsmail@gmail.com>
Subject: Re: [PATCH] soc: ti: knav_qmss_queue: remove useless statement
Date: Fri, 25 Oct 2024 09:02:20 -0500
Message-ID: <172986491063.176745.17597928563436598415.b4-ty@ti.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240924214612.38854-1-alessandro.zanni87@gmail.com>
References: <20240924214612.38854-1-alessandro.zanni87@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Alessandro Zanni,

On Tue, 24 Sep 2024 23:46:10 +0200, Alessandro Zanni wrote:
> Remove the statement "continue" at the end of the loop
> where it becomes useless.
> 
> Problem found with Coccinelle static analisys tool,
> using continue.cocci script
> (coccinelle.gitlabpages.inria.fr/website/rules/continue.cocci)
> 
> [...]

I have applied the following to branch ti-drivers-soc-next on [1] with some
minor fixups in commit message. Thank you!

[1/1] soc: ti: knav_qmss_queue: remove useless statement
      commit: 74280c3d73143dcb976491fc085ccb0437cb5f0e

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


