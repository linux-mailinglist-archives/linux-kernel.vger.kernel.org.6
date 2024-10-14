Return-Path: <linux-kernel+bounces-364261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA59399CF3A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 16:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 726BAB24400
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 14:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4E41C174E;
	Mon, 14 Oct 2024 14:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qREM8Cps"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C501B4F14
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 14:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728917323; cv=none; b=nV48Yae/9xd25VMWHDGKJFCKwt47tOWM2JQrl2zx/Iwl5UNOBRZSADIuVkRHyZC1da/ONC+59etzSkVUe/5gqA2UHgHpvC4AzM+bxfeXYuJR2UGlnmoTWu0I+mCR8YZbrCSs7AK6+L253LHDZe/oAV5nBW45M8TIDNoTXHBsouU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728917323; c=relaxed/simple;
	bh=rIuPJ5jleDQZjCZZz+/7JWMfBr+2Tq7VGR8y3ckWi5I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gMeFRUu0pyLC0EmOSyDEwtutulkzaTQ2LCvwnWlGlgjvu1QhK9awSt6y4KaD9VZ04AxDswKBVOosrgYy3ExdQpNMJDONLepm05bOlwgN+T3QvsUEmL4S8C+xBWPrpqWSE9Ivp3uc8AQbhRELZe8a64NoHY6LSwm1Y2j7BRxGqog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qREM8Cps; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49EEmNOA061029;
	Mon, 14 Oct 2024 09:48:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1728917303;
	bh=FoC6tIu0Vkug0l+E5M1rJbidM7G5H8WHtJnPGH+txlI=;
	h=From:To:CC:Subject:Date;
	b=qREM8CpsUxaFBLz5eWT/A+dNyfYrnDnolO8oG/uPoz/FO/slQsxuol6HdTQWkhzug
	 KWD1evzLpxZyJzOU6/nDp1vifdxWMfN2gFfj7bE8qPTKez6Du33hGatoDzNgxvrBBE
	 4oA9O3Z+qERKBIWZE5O8Q2eUFC0r+6F9gL42bZkE=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49EEmNfj024990
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 14 Oct 2024 09:48:23 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 14
 Oct 2024 09:48:23 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 14 Oct 2024 09:48:23 -0500
Received: from fllvsmtp8.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49EEmMm5009566;
	Mon, 14 Oct 2024 09:48:22 -0500
From: Andrew Davis <afd@ti.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier
	<mathieu.poirier@linaro.org>,
        Martyn Welch <martyn.welch@collabora.com>,
        Hari
 Nagalla <hnagalla@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>
Subject: [PATCH 0/2] Enable compile testing of TI MSGMGR/SPROXY driver
Date: Mon, 14 Oct 2024 09:48:19 -0500
Message-ID: <20241014144821.15094-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hello all,

This driver can be compile tested on non-TI platforms. Enabling this
also allows compile testing of drivers down the dependency tree,
such as TI_SCI_PROTOCOL.

Thanks,
Andrew

Andrew Davis (2):
  mailbox: ti-msgmgr: Remove use of of_match_ptr() helper
  mailbox: ti-msgmgr: Allow building under COMPILE_TEST

 drivers/mailbox/Kconfig     | 2 +-
 drivers/mailbox/ti-msgmgr.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.39.2


