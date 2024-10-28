Return-Path: <linux-kernel+bounces-385244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 853CE9B3478
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 16:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6A0A1C21FB8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 15:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24BF11DE4E7;
	Mon, 28 Oct 2024 15:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SlColhrz"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F871DE3C5;
	Mon, 28 Oct 2024 15:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730128129; cv=none; b=FeKZMuRCqvtMYBOjKPrjkfM7DNxpfF7ZQTin8DPqLnuepVWqqVXI8aV78JVIUE2DRQ6aXDPhxB4F85GQhY+tiW7EjfzmbJ+Euxkl/x49l14OyzEvEIGtFdhq5WKqxzFhLGw7eYzX3sQTiTwrXoX5zVf1hcT2F/JPBQ/d0PR5G0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730128129; c=relaxed/simple;
	bh=SifQlyZ7KikgP1IQCzpuW3tmcYNWYp20rVd/HUkpN0A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AlE7RlpKe/uadlLwVxY42+nPZvYiXZJqMNHHaDtozr1fiODs6z/s+q+3cr+VaLyzQyuXbbV9LPpUR+3g9a6fk3sMqtNy+IoG6FKzM0fn0rcCJNZ8BKs47evsYY+kQ2WoVXZJlYbB7v8La99jEWFJ++Ry43nkHAIjVGXmnVfiUC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=SlColhrz; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49SF8Xuc005602;
	Mon, 28 Oct 2024 10:08:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730128113;
	bh=b96FhIf/5C/V7LXfZZc3vpon5alrJPDglX3GKmrmGOg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=SlColhrzavdXadcC4OHy0lcvheX5cmsXanoTknJyygvCmoZUfkEYIjvIPma7O/lUN
	 TXR8q26q2K6lDAOz7qPmCGjhbkAsSn8TW9awFgsaHBhFBxV3NYkSNaibRvV4H3pQsB
	 01gQemWotwB1CDF3vu8FpqkpKemdsxe+OVvjYYGM=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49SF8XnE057827;
	Mon, 28 Oct 2024 10:08:33 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 28
 Oct 2024 10:08:32 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 28 Oct 2024 10:08:32 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49SF5tcv129665;
	Mon, 28 Oct 2024 10:08:29 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: <nm@ti.com>, <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <j-luthra@ti.com>,
        Nathan Morrisson
	<nmorrisson@phytec.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <upstream@lists.phytec.de>,
        <w.egorov@phytec.de>
Subject: Re: [PATCH] arm64: dts: ti: k3-am62x-phyboard-lyra: Drop unnecessary McASP AFIFOs
Date: Mon, 28 Oct 2024 20:35:27 +0530
Message-ID: <173012710989.558239.9145851807780794840.b4-ty@ti.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241002224754.2917895-1-nmorrisson@phytec.com>
References: <20241002224754.2917895-1-nmorrisson@phytec.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Nathan Morrisson,

On Wed, 02 Oct 2024 15:47:54 -0700, Nathan Morrisson wrote:
> Drop the McASP AFIFOs for better audio latency. This adds back a
> change that was lost while refactoring the device tree.
> 
> 

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-am62x-phyboard-lyra: Drop unnecessary McASP AFIFOs
      commit: c33a0a02a29bde53a85407f86f332ac4bbc5ab87

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


