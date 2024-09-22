Return-Path: <linux-kernel+bounces-335317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F2697E410
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 00:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BB57281318
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 22:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855857711B;
	Sun, 22 Sep 2024 22:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dc/z++RN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20FABA27
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 22:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727043868; cv=none; b=BLv80bQyWaihrJAauyCYH+Q6XehDY6gj2xAgMqua+oI8Y1x8PRA8kOqqwSyMtOUR0i3vyhTVI58fu1xBXFGUlr6zAHhmgvSHcbRoLAjA4TSIcUSKRzGPuMVfP5CWaQtSmcuWKkb6FWtRP06qINCb/NuMd1+BkvxmziAKUksguyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727043868; c=relaxed/simple;
	bh=358yVYEgDOI9wFLRhFZjtAsIGungvQRtLlkJutAPky4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W40DHnvHzwuKpK4B2xNBdV1hxJH5Ahic2ju21Xjalh01yie8/DMZXT31gh7AGHdJ7qfol0IAU56Vs/x6BlCLvaROypf0RqJCMjGWgAe1l0/hHiJWMaEip5FxmHFZiw6BSTkDoDzwJidV3Y0E+FCjXPdQFHjhyTLP36mD8f3AVRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dc/z++RN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C6CBC4CEC5;
	Sun, 22 Sep 2024 22:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727043867;
	bh=358yVYEgDOI9wFLRhFZjtAsIGungvQRtLlkJutAPky4=;
	h=From:To:Cc:Subject:Date:From;
	b=dc/z++RNEgiKb4DqTGcgJdF3ke+kfYiqcU/RrYH6ioy/PWj3ldPA38mA6SG8DTrmP
	 TXbXoIIp0sm70/1C62kzveq/pCB+MnSP9YrIESR8hrx4HCg4FyOUrhY5P5b2Y689YJ
	 3hdpTXUJKHBCYk5QRxxlxofdtZFO1rtFuXJoeII7v4ieIEy/sS0jHfwZTonaMAisoI
	 8poKMoWx4SP51ZxTl5uC4JsOrGYTbAgJpeI6v0iFOxTSBdqMDAor3UFB0eabVxImDK
	 uquWvJxjX4jSuRe1e9VFACh8627JUWx93d+AUaI6JPtt9O/jBOJYVwyDI4TApeo4MH
	 eGXTOSTbS0tWQ==
From: Frederic Weisbecker <frederic@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Larysa Zaremba <larysa.zaremba@intel.com>
Subject: [PATCH] ice: Unbind the workqueue
Date: Mon, 23 Sep 2024 00:24:20 +0200
Message-ID: <20240922222420.18009-1-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ice workqueue doesn't seem to rely on any CPU locality and should
therefore be able to run on any CPU. In practice this is already
happening through the unbound ice_service_timer that may fire anywhere
and queue the workqueue accordingly to any CPU.

Make this official so that the ice workqueue is only ever queued to
housekeeping CPUs on nohz_full.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index ea780d468579..70990f42ac05 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5924,7 +5924,7 @@ static int __init ice_module_init(void)
 
 	ice_adv_lnk_speed_maps_init();
 
-	ice_wq = alloc_workqueue("%s", 0, 0, KBUILD_MODNAME);
+	ice_wq = alloc_workqueue("%s", WQ_UNBOUND, 0, KBUILD_MODNAME);
 	if (!ice_wq) {
 		pr_err("Failed to create workqueue\n");
 		return status;
-- 
2.46.0


