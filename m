Return-Path: <linux-kernel+bounces-175062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 520378C19BC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 01:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CFBE284F4F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 23:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B997312D75A;
	Thu,  9 May 2024 23:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="buDMhSsB"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B520710A0D;
	Thu,  9 May 2024 23:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715295936; cv=none; b=caSD0Ew5Lh9ymS9/aXmcdFGNrvHMWRkEHn35pBOFZuX0sHpAUAoJHek/Qb4X+epuIZ8fMZ1OJ9bHifmuWy8BPBBjWTRLFD2ijyvMc9Ob4O5gk9tfJZnAJaxMfALBV802N6F1v9ooG5Ad8OIUZKy9UxZy57S0yJhj0L8Y+V5A5KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715295936; c=relaxed/simple;
	bh=PV0CNX3AG2s3C6hfW6k3CCdraITVnqHGLjTCvezs5OU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n4ql0O1XpeS5ia2Gx0aCXtrlyyVCApqIYZQJmJYE9f7ys1TC4cTn6gnp99sWiwU3v7sfPSxbpFe4QMg2jzYepoIUIYWg8cplrbAzI51mRBgBHpzbEnovZgUgG0GpQbEcR6rU0lhBB1e7p3eeRAL2Q1ezxKbEx6mr+sUX3uRGbwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=buDMhSsB; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=iew2IIPfv/BtAravNjLR5s/UcvQq4Ks2nxnimvEluNM=; b=buDMhSsBC31Z1LpN
	RUWC3gW+cb9EHvq1Z6tkTL1aUnwdVNgmAyZXJgsucvXTPrhS8xmxc5sOjYryczTErXaZAVIfEmM1u
	3dqVqlHAqTVCQXbal6EEMEnZFJ0fDRdg4EjeWKYifokSAk2zxM+M4ou1jxqQz6F8NlGEtML6V916h
	tlay1trRnNO37ZMWul1WHW5Rrsk4874xWNqSY5UZrOeodpoNe2VcZWLf4bBsOXy7sJd2VURBm5JPk
	HhRyYmybLL3NlL/Sqct5MnNBZhblA8U0OOtpBkHltETf09sQ/9Z6SdG+XSyeqxJ+5DqnxEhQg4mK5
	ZdibRmEFulLbqCmpRw==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1s5CpB-000HBS-2C;
	Thu, 09 May 2024 23:05:18 +0000
From: linux@treblig.org
To: sboyd@kernel.org,
	emilio@elopez.com.ar,
	mturquette@baylibre.com,
	wens@csie.org
Cc: linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH v2] clk: sunxi: Remove unused struct 'gates_data'
Date: Fri, 10 May 2024 00:05:16 +0100
Message-ID: <20240509230516.86023-1-linux@treblig.org>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

'gates_data' (and it's associated define) are unused since
commit ee38b2698ae2 ("clk: sunxi: Add a simple gates driver").
Remove them.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/clk/sunxi/clk-sunxi.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index 5fe7049ea693a..4999504f7e60d 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -852,17 +852,6 @@ CLK_OF_DECLARE(sun8i_axi, "allwinner,sun8i-a23-axi-clk",
 	       sun8i_axi_clk_setup);
 
 
-
-/*
- * sunxi_gates_clk_setup() - Setup function for leaf gates on clocks
- */
-
-#define SUNXI_GATES_MAX_SIZE	64
-
-struct gates_data {
-	DECLARE_BITMAP(mask, SUNXI_GATES_MAX_SIZE);
-};
-
 /*
  * sunxi_divs_clk_setup() helper data
  */
-- 
2.45.0


