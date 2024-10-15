Return-Path: <linux-kernel+bounces-366765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2C299FA1E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 23:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20A80284530
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 21:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B6B202630;
	Tue, 15 Oct 2024 21:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RDMb4mK9"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BD61CBE8A
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 21:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729028023; cv=none; b=Su//ALENaSQdzlSwDKBsa+SIcW7hQy7aYBQnNVo49IZmt3qnHdx4eAL6kNima548ozZKQQTPigYEBK7u99ZcR5nAOKj04dvzLRqTiN0Tq8iVCytdXZiaVaRDNrC7iVOrSEuPwPhLCocshvPUh+Fztv7R5lHWfyFc0koZIMLrJ78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729028023; c=relaxed/simple;
	bh=CPyLIaV34YZPzMxnPpftzTJR2H7ROYSAI6CiTEI9xh8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uy6keSfrYkygLSy3bZFxyDNKbTugXh7JKGcTvUz9FKgbQUtVm+fZ80ztrDrrjYVcLfnhjEYpVlgD2ewS/5/qLi5XUO0WHi0Yyh7g6vFQ9ceLYFIF4e8Mw/OBQmz73+tIk0QjAHaCFCq4I5aPHRNAh84aGfKEPvkUnvj4zw9KaeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=RDMb4mK9; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49FLXOnf010878;
	Tue, 15 Oct 2024 16:33:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1729028004;
	bh=lTnBqCX1ErOiDGkI61Rzvpz5a5zbtrkHn1eJPq5CxY0=;
	h=From:To:CC:Subject:Date;
	b=RDMb4mK93ytBccq0o75/V9zvCdgBWVpUUi7+RLeplFwTohAvHEY1awnXBg25zdbcd
	 oCvGa72YXETodrIZjaHKP9NrPzcuWn/50YaZQCcAleJzsQ7jmHrOl6hgvUL5+rK8YF
	 tdmgvbtvK3cFsiPbEji4NkNZ8YWOkqMKfDUcuQcI=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49FLXOCJ086607
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 15 Oct 2024 16:33:24 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 15
 Oct 2024 16:33:24 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 15 Oct 2024 16:33:24 -0500
Received: from fllvsmtp7.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49FLXNBb038888;
	Tue, 15 Oct 2024 16:33:23 -0500
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
Subject: [PATCH v2 0/3] Enable compile testing of TI MSGMGR/SPROXY driver
Date: Tue, 15 Oct 2024 16:33:19 -0500
Message-ID: <20241015213322.2649011-1-afd@ti.com>
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

Changes for v2:
 - Add patch fixing compile test warning in ti_sci.c that
   is exposed by this series
 - Add acks/review tags

Andrew Davis (3):
  firmware: ti_sci: Remove use of of_match_ptr() helper
  mailbox: ti-msgmgr: Remove use of of_match_ptr() helper
  mailbox: ti-msgmgr: Allow building under COMPILE_TEST

 drivers/firmware/ti_sci.c   | 2 +-
 drivers/mailbox/Kconfig     | 2 +-
 drivers/mailbox/ti-msgmgr.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.39.2


