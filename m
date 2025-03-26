Return-Path: <linux-kernel+bounces-577233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18409A71A25
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 16:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AC7C7A3499
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 15:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CE91E521B;
	Wed, 26 Mar 2025 15:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NYbcBESR"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5264A13C8EA
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 15:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743002615; cv=none; b=Us0enKbJCTWqbGwVZhX5QT3nZpsXxrnmrcyFGsFk+3NQXol5CvvQLytTQHWnS5R8DeSagmXjY1DO+8fh01lyVI95hdQbL8EhNcj2DwMEap13RpwlSsKSOw1LvptBy0n9x/oV+dQj+/vxYcEqJhgTtQjfzLio5HG9ul1LTTVnhxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743002615; c=relaxed/simple;
	bh=hKYD7R73oolCHvjraiUeKjWLt49wqH7/On7cg1Pq7Fs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gc6L7dYUFzJrKNflNcKtUV9eZ0XZo7dz8AJdQgFkfLVL2epmMqYppeQSGcy6rj8OXh/Br/vQT1a64aFQnrrQKIOfqwKxAw3LZQc2sBBruI5mzpN9uZ8R+ExcwQExBYdJzf8RhcZWiFOTYhRHb58UsTd2i/R5qR7hOO4A41N5DYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=NYbcBESR; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52QFNL0d1598969
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Mar 2025 10:23:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1743002601;
	bh=P4QnCOX2GK7YXvkBqaJnRbYLteCrwPQwCSdaBxf6DOY=;
	h=From:To:CC:Subject:Date;
	b=NYbcBESRB3/JWd15SIxYTospyNmZY4k4ehqb9NnCFRhu+SRl0VVtqeg2SsGCb641y
	 ltY5QXBvxn/Wy7J3c3fCgETrTe3nDn77Wclr1pPhfjtrNNdn109Asem6PyCJ4NZvNC
	 RUmUQ17IOMerySfK68fD6iAcxG8/7/an3i7PVFl0=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52QFNL0l005607
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 26 Mar 2025 10:23:21 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 26
 Mar 2025 10:23:21 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 26 Mar 2025 10:23:21 -0500
Received: from localhost (ti.dhcp.ti.com [172.24.227.95] (may be forged))
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52QFNK7C076812;
	Wed, 26 Mar 2025 10:23:21 -0500
From: Devarsh Thakkar <devarsht@ti.com>
To: <vkoul@kernel.org>, <kishon@kernel.org>, <mripard@kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <sakari.ailus@linux.intel.com>, <u.kleine-koenig@baylibre.com>,
        <vigneshr@ti.com>, <aradhya.bhatia@linux.dev>, <s-jain1@ti.com>,
        <r-donadkar@ti.com>, <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH v2 0/2] Fix PLL lock timeout and calibration wait time
Date: Wed, 26 Mar 2025 20:53:18 +0530
Message-ID: <20250326152320.3835249-1-devarsht@ti.com>
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

This fixes PLL lockup and O_CMN_READY timeout by moving the polling
function after common state machine gets enabled. Also fix the
calibration wait time to optimize the polling time.

Changelog:
V1: https://lore.kernel.org/all/20241230125319.941372-1-devarsht@ti.com/

Test logs:
Link: https://gist.github.com/devarsht/89e4830e886774fcd50aa6e29cce3a79

Devarsh Thakkar (2):
  phy: cadence: cdns-dphy: Fix PLL lock and O_CMN_READY polling
  phy: cadence: cdns-dphy: Update calibration wait time for startup
    state machine

 drivers/phy/cadence/cdns-dphy.c | 60 ++++++++++++++++++++++++++++-----
 1 file changed, 52 insertions(+), 8 deletions(-)

-- 
2.39.1


