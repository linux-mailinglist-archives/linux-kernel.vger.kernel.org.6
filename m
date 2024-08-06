Return-Path: <linux-kernel+bounces-276942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F49E949A3D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 23:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF9D41F2294F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 21:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C9F16B75B;
	Tue,  6 Aug 2024 21:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sHHdGeqV"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AB0374C4
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 21:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722980043; cv=none; b=j8QinvPDaNCVkdOQDjZsLFlYIw5LrdGrjOt9mtTtqucL7EWqeTRVpsh/06/4zvPYB79hmixirtn+PItHWTEVRWRwzAE6AP/UGdwTyQW0nGxegz+BfZl9vXAAOJeu/uy1IJY6+/Pm2lkCfHeqWrS/E8b7DxnwRUQnT7IgRvp/A+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722980043; c=relaxed/simple;
	bh=tN/nGcQ/slCJqVNWYJDBFdjIqo27ReErHeJO6LP4wvQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W/t7mvyPqwowURKpirxZvY9Ba1gLNO8p49Qu9lxlrFhDwVtlr4Yj8YcdQWZo27PQUdev9du4FLAzLANKF0HdrryxfU6SOIRmEapnEnRzka92nBjADekJ6zgcu+vvv44tFqT1hsvN7/w4JxoZJOfg9ba16aI2wHhcEHkop0QIBc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=sHHdGeqV; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 476LXuLB026320;
	Tue, 6 Aug 2024 16:33:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722980036;
	bh=7wdxyUjqbROVGIZtndJZgKukOjAd6bkCN4Je4ftYbEw=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=sHHdGeqV9d4/Jbda9yUCrBYBz4zFqesZ9vPi1lQEmn6LZCxNyAZnny5XJ04783Jj3
	 gOalWfRTehCBGLSy8VVkdcIVTNH+yq/7ncMR6HY2bKq4c4aMpkZrBaNolYPZbbjygK
	 vbiLu9MWhtActBFJXShNMRbeaGw+fAA99kS1R3vk=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 476LXuYD121217
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 6 Aug 2024 16:33:56 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Aug 2024 16:33:55 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Aug 2024 16:33:56 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 476LXtA2084102;
	Tue, 6 Aug 2024 16:33:55 -0500
From: Nishanth Menon <nm@ti.com>
To: Santosh Shilimkar <ssantosh@kernel.org>,
        "Rob Herring (Arm)"
	<robh@kernel.org>
CC: Nishanth Menon <nm@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] soc: ti: knav: Use of_property_read_variable_u32_array()
Date: Tue, 6 Aug 2024 16:33:54 -0500
Message-ID: <172298002363.488077.12540845709383955564.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240731201407.1838385-3-robh@kernel.org>
References: <20240731201407.1838385-3-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Rob Herring (Arm),

On Wed, 31 Jul 2024 14:13:58 -0600, Rob Herring (Arm) wrote:
> There's no need to get the length of an DT array property before
> parsing the array. of_property_read_variable_u32_array() takes a minimum
> and maximum length and returns the actual length (or error code).
> 
> This is part of a larger effort to remove callers of of_find_property()
> and similar functions. of_find_property() leaks the DT struct property
> and data pointers which is a problem for dynamically allocated nodes
> which may be freed.
> 
> [...]

I have applied the following to branch ti-drivers-soc-next on [1].
Thank you!

[1/1] soc: ti: knav: Use of_property_read_variable_u32_array()
      commit: b2a0176620db7aa0aa77109d7a8b894755441079

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


