Return-Path: <linux-kernel+bounces-267320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B96A94101C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 13:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 224531F242C9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 11:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B68619CCF2;
	Tue, 30 Jul 2024 10:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DRGoe7jK"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AE019580B
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 10:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722337192; cv=none; b=ah83NU3Q4Uq1d7SE28tk8+Dic7FSIkaUngK2LB5TxZeZqlyHEp90ffJmC2gkQPTEnuMXxHzjcEo/qSq0pB9IGMCu+MYVhh4NU0E9Jy6zSVpC9gMPBc5z14yzK+/F2Gm3LIl9wNQlR6N5N6Zgn+/TSOkDKHT4kH/KDSRPnNn9dIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722337192; c=relaxed/simple;
	bh=S4TKs36zuyYQhQC2wNo65S9DbOgKoxAMU4qhwPg6ZC0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W+JSLlV7SWAiU6XATdJw2D5mMDXjtm+xIHBR/feOUzLI9WAkdpvU2zv7kEGEwGdH8R2IrzRHvrNZfmm//EyN2Cd8s1Zvw5t2Zqjc4eoE9mdaMRXG34lg06XSMgtaWHruDd1sUlYciC3wZp8lqUoF+0QeH1+V4XUEfeG4cq312a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=DRGoe7jK; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46UAxNdt007163;
	Tue, 30 Jul 2024 05:59:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722337163;
	bh=S4TKs36zuyYQhQC2wNo65S9DbOgKoxAMU4qhwPg6ZC0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=DRGoe7jKXTG+0vpSFv46vZ0XAtzs/e8IZ4vj7YQ8NCMFawEj8PxHEu4BOVegSmwnI
	 RJQnJI8asevu6QgxWmHceCp1RQ5p9oDKhYLEYqE0YSitIEwfIXd4ltf4I1cm5EkoyN
	 0/orT05a8NzXl1mFbCCRAVdn6lIJ9aiWG0Y6YkxI=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46UAxN3S122728
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 30 Jul 2024 05:59:23 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 Jul 2024 05:59:23 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 Jul 2024 05:59:23 -0500
Received: from localhost (nightbug.dhcp.ti.com [10.24.68.118])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46UAxMmB042060;
	Tue, 30 Jul 2024 05:59:23 -0500
From: Amneesh Singh <a-singh21@ti.com>
To: <sstabellini@kernel.org>
CC: <boris.ostrovsky@oracle.com>, <hch@infradead.org>,
        <iommu@lists.linux-foundation.org>, <jasowang@redhat.com>,
        <jgross@suse.com>, <konrad.wilk@oracle.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-imx@nxp.com>,
        <linux-kernel@vger.kernel.org>, <mst@redhat.com>, <peng.fan@nxp.com>,
        <virtualization@lists.linux-foundation.org>, <x86@kernel.org>,
        <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH] xen: introduce xen_vring_use_dma
Date: Tue, 30 Jul 2024 16:29:10 +0530
Message-ID: <20240730105910.443753-1-a-singh21@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <alpine.DEB.2.21.2007151001140.4124@sstabellini-ThinkPad-T480s>
References: <alpine.DEB.2.21.2007151001140.4124@sstabellini-ThinkPad-T480s>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Stefano,

First off, apologies for bumping this dead thread.

I came across this patch signed off by you recently
https://github.com/Xilinx/linux-xlnx/commit/72cb5514953be3aa2ac00c57c9eaa100ecc67176

and was wondering if a patch replacing xen_domain() with xen_pv_domain() in
vring_use_dma_api() can be sent upstream? If not, is there a reason why?

Regards
Amneesh

