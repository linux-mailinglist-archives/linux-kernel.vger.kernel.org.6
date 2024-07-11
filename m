Return-Path: <linux-kernel+bounces-249780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A847992EFB6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 21:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54E111F23428
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 19:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C0A16F826;
	Thu, 11 Jul 2024 19:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="G4FCmE10"
Received: from msa.smtpout.orange.fr (msa-211.smtpout.orange.fr [193.252.23.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6D616F0E9
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 19:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.23.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720726506; cv=none; b=a6AmLV8rUoiiq64bK0MnzhU1YRV6kIUNoi2i+LendAd1NO5rOaC5rcRMMhT/vuQTLD6DMaBgrCVJ6RWbF72TuaH95+OmyPcrBbY5GxEwDyuo2rc8k8uaUJN3A/jpEMjSYQq/eWXrU2Jg1TI/2W8J9rDhKNAtRMB0iRr02epLM4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720726506; c=relaxed/simple;
	bh=x68ESisQH80WW9Hmoe5cxe8M7THJVffjZhGe8eKvGQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FAHd6m71jGkd18WJyJUXEyAlejWzW0YUgQnQGpO1xbq6apKMTqomlyIL3OkOCVcpG5KgCkJbYr/eg2HrwwVkRkM2/Q92fOjGhMWu4JHJj87/ZsHcOUrrxjeShcsmWbWQze/P0ZV+W8dNDC1qxmFFY90+iUAGta4ZiMFihlEFR+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=G4FCmE10; arc=none smtp.client-ip=193.252.23.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.. ([77.131.3.214])
	by smtp.orange.fr with ESMTPA
	id RzZBsCMFrj4pfRzZHsIiSB; Thu, 11 Jul 2024 21:35:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1720726503;
	bh=+R7FMy9AXoamPmQBHl0PouZlAVVAloz2ln5nMlCPFco=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=G4FCmE10keN47ZT0oy7vcEVw+P05COp971q569t5kqgym7lD3ENBPU+VwI9cntx/z
	 8dSrndaG7iv76mVM2IFztFqCb2qAkQxgXmkP4zqZVUAIeEufn8LHOKY7roFiDPX8cr
	 zPjaAm3PLkMLfkHAH3XnOLIgptNnUnIv0BkilwdDbOVmaT5eQQx1MxFzDu+0CrEfKI
	 3ophi6NDVNA9LE02ljoqzR2wTMy+rbdO79oU5RB+06pGlNFUDN1ioCU5p/fjoXYmdh
	 LuQgx9ZgX2eK+x9d40YpbLS9p8SyhhG/1dgwZqNY3FfttuZr8FXZTesBvHN1JQp3be
	 I+aJFk5GhtzRw==
X-ME-Helo: fedora..
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 11 Jul 2024 21:35:03 +0200
X-ME-IP: 77.131.3.214
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: vkoul@kernel.org,
	kishon@kernel.org
Cc: linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 3/3] phy: cadence: Sierra: Constify a u32[]
Date: Thu, 11 Jul 2024 21:34:54 +0200
Message-ID: <43d881d52e3c1632ad197d4c2c18b6c481a13b24.1720723132.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1720723132.git.christophe.jaillet@wanadoo.fr>
References: <cover.1720723132.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'cdns_sierra_pll_mux_table' is not modified in this driver.
And it is only used as a "const u32 *".

Constifying this structure moves some data to a read-only section, so
increase overall security.

On a x86_64, with allmodconfig:
Before:
======
   text	   data	    bss	    dec	    hex	filename
  60937	   3894	     16	  64847	   fd4f	drivers/phy/cadence/phy-cadence-sierra.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
  60897	   3878	     16	  64791	   fd17	drivers/phy/cadence/phy-cadence-sierra.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested-only.
---
 drivers/phy/cadence/phy-cadence-sierra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index 947492c8f381..3010c9f24136 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -310,7 +310,7 @@ static const struct clk_parent_data pll_mux_parent_data[][SIERRA_NUM_CMN_PLLC_PA
 	},
 };
 
-static u32 cdns_sierra_pll_mux_table[][SIERRA_NUM_CMN_PLLC_PARENTS] = {
+static const u32 cdns_sierra_pll_mux_table[][SIERRA_NUM_CMN_PLLC_PARENTS] = {
 	[CMN_PLLLC] = { 0, 1 },
 	[CMN_PLLLC1] = { 1, 0 },
 };
-- 
2.45.2


