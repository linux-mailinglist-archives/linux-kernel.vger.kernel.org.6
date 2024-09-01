Return-Path: <linux-kernel+bounces-310404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9515967C48
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 23:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D64D21C2122C
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 21:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B038139D13;
	Sun,  1 Sep 2024 21:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="W2bRrR48"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C720C61FEB;
	Sun,  1 Sep 2024 21:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725225324; cv=none; b=ZwZi+pbf8E57IL93Ws+deDTTpBVlOgyV9icd1sGCOiOHT11MKoMfrQ53JCXXM226KtyDwIKoj3zYqkugrWxcMfJTHf44om2rhJWuViYN8UkX9pr9eHcevzVt/1b2jWWfrfvkilkcgpCnNisRttK5Di6XrgtX9eRFPU/BhfRqaxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725225324; c=relaxed/simple;
	bh=FmwrK/v9/kw+kqIyi79POs04aJ3NCnnl8qDbkyaQH8k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HE8hoDHpwK/jvKLvjxkgRNTm0RSwYC1LEsox8Zk7hkBGyU1OGZWryC2qZeg9IlUyDM6haqOpgFhPXtaV0/Req0o3IQaS0sH4o/4u5rOVrl2o5oa55TrlZmYqE81J2P03he77NKds90NpTt2p1MXL35TlCzAyRBp+yU0aQV4j1xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=W2bRrR48; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 481LFGpR022082;
	Sun, 1 Sep 2024 16:15:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725225316;
	bh=In491Nb3fG7n/tq4kPBIz/wi9PxANMTh1PfN6IJHmE4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=W2bRrR48eRB+0DJcgcK9/1vQ7pbDr3J7HFF1tYx+pN5fRsgxKUITZecWGBrrciTKy
	 yuUTnSzLXcQFE84a4JF6j2pYhpUb6l3Vb51C04ef2vVG51s34KHmQz6d1goff+7uae
	 H9gu3pKa7FwUwuaKl85vrsDozf9RM+MEEgnena+E=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 481LFGFY021960
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 1 Sep 2024 16:15:16 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 1
 Sep 2024 16:15:15 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 1 Sep 2024 16:15:15 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 481LFFun070686;
	Sun, 1 Sep 2024 16:15:15 -0500
From: Nishanth Menon <nm@ti.com>
To: <vigneshr@ti.com>, <krzk+dt@kernel.org>, <kristo@kernel.org>,
        <robh@kernel.org>, <conor+dt@kernel.org>,
        Prasanth Babu Mantena
	<p-mantena@ti.com>
CC: Nishanth Menon <nm@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <u-kumar1@ti.com>, <sinthu.raja@ti.com>, <m-chawdhry@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-am68-sk-som: Update Partition info for OSPI Flash
Date: Sun, 1 Sep 2024 16:15:14 -0500
Message-ID: <172522526341.1011162.18366433347986417598.b4-ty@ti.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240828060830.555733-1-p-mantena@ti.com>
References: <20240828060830.555733-1-p-mantena@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Prasanth Babu Mantena,

On Wed, 28 Aug 2024 11:38:30 +0530, Prasanth Babu Mantena wrote:
> Commit 73f1f26e2e4c ("arm64: dts: ti: k3-am68-sk-som: Add support
> for OSPI flash") introduced the flash node with discontinuous
> partitions. Updating the partition offset to be continuous from
> the previous partition to maintain linearity.
> 
> 

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-am68-sk-som: Update Partition info for OSPI Flash
      commit: ce9d793b2bbbfdd6d0ce30f94bd014ab5fb87230

NOTE: I have already mentioned this before, so wont repeat it:
https://lore.kernel.org/all/20240830112452.geyv7tecpb6ydhmz@quotable/

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


