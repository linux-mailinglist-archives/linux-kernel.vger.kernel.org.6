Return-Path: <linux-kernel+bounces-362509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB81299B5C6
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 17:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 761691F222ED
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 15:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CEA1991C2;
	Sat, 12 Oct 2024 15:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ut1lcEb3"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97C711CA0
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 15:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728745669; cv=none; b=VvKreAu2sDLKqgeSCESLFQFJGiccIC61Tl8OD3dJyo3yBgO3A5xruZvrVndvXp5RtSR3UVXuuLO/aaXZwKGBY0nY+X9E+0BLTwzGnZ9Wq1lCxb9oJYFA6qo/uhop6Qt2sGTvtGGaehkEhtQbvSn70psDodGhA8EEoRTJ0J5wiKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728745669; c=relaxed/simple;
	bh=wmfrl+cR+f07w+FAijslV5DdlnEMgln6aQc4ZCIREAA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SbK0UMR+e6XBvq8HwfZm/tn71/q5vGPMb3CnhLtIKJMHOMbLHcbyfl0Ux39CTnGLJX7peZAfzQ2xymfwepq/1oU2Y8qVc5/sRYak/ufAGQIEY2jE6sh5ZXcNDs0f8eYH3yCkTiX/QYeaX5S1DGukA/67uusRqxHx9TbJS6m/0UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ut1lcEb3; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49CF7C6G027028;
	Sat, 12 Oct 2024 10:07:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1728745632;
	bh=lJnqkgu2ok6exxc6zBrcXWh7XNo6vxYHtyLPQ+SH2MI=;
	h=From:To:CC:Subject:Date;
	b=ut1lcEb3HwFK+k3HQbJicxJzWpcZvyoTzU21DGU9RbW5UPPpfmtvMV1BxdrmR9Gm0
	 RmksDdNGAgcZ8ueILLZAZ43azvq0FJrRmNm3YmiI8uzeJriqw/rBgzr9ciFNkkq14g
	 WUj8NpPzrEgVMbV+CseZiWre5P+Uj5xjPj/4QMlw=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49CF7CVO020063;
	Sat, 12 Oct 2024 10:07:12 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 12
 Oct 2024 10:07:11 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 12 Oct 2024 10:07:11 -0500
Received: from localhost (ti.dhcp.ti.com [172.24.227.95] (may be forged))
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49CF7BUk114694;
	Sat, 12 Oct 2024 10:07:11 -0500
From: Devarsh Thakkar <devarsht@ti.com>
To: <jyri.sarha@iki.fi>, <tomi.valkeinen@ideasonboard.com>,
        <airlied@gmail.com>, <maarten.lankhorst@linux.intel.com>,
        <mripard@kernel.org>, <tzimmermann@suse.de>,
        <dri-devel@lists.freedesktop.org>, <simona@ffwll.ch>,
        <linux-kernel@vger.kernel.org>
CC: <praneeth@ti.com>, <vigneshr@ti.com>, <aradhya.bhatia@linux.dev>,
        <s-jain1@ti.com>, <r-donadkar@ti.com>, <sam@ravnborg.org>,
        <bparrot@ti.com>, <jcormier@criticallink.com>, <devarsht@ti.com>
Subject: [PATCH 0/2] DSS interrupt related bug fixes
Date: Sat, 12 Oct 2024 20:37:08 +0530
Message-ID: <20241012150710.261767-1-devarsht@ti.com>
X-Mailer: git-send-email 2.39.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

While reviewing the interrupt related code and register dump, we found couple
of issues related to interrupt related register programming. Firstly, the
function enabling/disabling the interrupts was trying to clear the
interrupts which were not enabled in first place and secondly there is a
potential race scenario between interrupt subroutine and interrupt
enable/disable related functions as they both access interrupt registers
without a common lock. This series addresses the aforementioned problems.

Devarsh Thakkar (2):
  drm/tidss: Clear the interrupt status for interrupts being disabled
  drm/tidss: Avoid race condition while handling interrupt registers

 drivers/gpu/drm/tidss/tidss_dispc.c | 12 ++++++++----
 drivers/gpu/drm/tidss/tidss_irq.c   |  2 ++
 2 files changed, 10 insertions(+), 4 deletions(-)

-- 
2.39.1


