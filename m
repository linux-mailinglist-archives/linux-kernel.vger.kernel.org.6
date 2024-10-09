Return-Path: <linux-kernel+bounces-356088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBDC8995C56
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 02:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6965BB20EB9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 00:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35B81B815;
	Wed,  9 Oct 2024 00:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="MOuo0z6F"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2721799B;
	Wed,  9 Oct 2024 00:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728434158; cv=none; b=Z2ScSCTnNXd7o94IaHO7b1N+OXvvIuaJJUWjeOXuJZEzB8UelRFZ5XlwRCpEyiaGSRIHAcooUV7ZSP7iGIztJEJidqcP64uG5gqm91jnU+sHDgl2dn3ERacuuCeLMmhkyWYmV59WRj7G4XuU0XzeRVuAV0/P07oV6UVnfOao5Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728434158; c=relaxed/simple;
	bh=Eqp2TaTL1PGixvSTGuIYJ8m+VzhdOUq4BR4L1lda1F8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o4Vn/NqbnTOYGawpy0AdZUeXnp9b86LH3E3GQpuhSGV3D2BAUiPbLPpUvqOpBZjGxpPu/DPtiClSXV1l7nkLEwX3eA2di1ehPHRz+ADOC4r4IIMnVTEc8CxvVuWbgUkLpTx4YJ8SiNKvkFIIkpCdgDRf3njwtGQDkiQ1Oz4Wkn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=MOuo0z6F; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=D53qcqndZN41LdB8jmYSBPt0pULZhYP/DP0iF6Zx1rM=; b=MOuo0z6FFJCMnCKp
	CidotFhMlIsCUmpm4VAe1PqQ5ZQ5Au8GfN+XjZ9QuQ0Lnl8UNbxZnVgVkszHUDfFu+SFSHTEes2C0
	FzQUG6XfwjHKZFjWF319OQv6C/JuOu/XY+xjoKu4MU2+LZzP5a3l7cb+i29/eyAlMjAxWrJPCchWv
	xxMWTH1nyVEOv0n/tZe8bXoFFO9v32heKCtWHuXMef58D+YIANSwhYqKLrPAcO9OSXp6V77inLwme
	OgkXcIiQYWHIjto9HApnt/y0VfoE68pK5yKLKsIuQvDNPJfqCWX0W4mDjR7nM0cUFSwfgRXUvE5cE
	442F/hYMd3DsNGOXVQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1syKgD-009q2z-12;
	Wed, 09 Oct 2024 00:35:53 +0000
From: linux@treblig.org
To: mturquette@baylibre.com,
	sboyd@kernel.org,
	linux-clk@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] clk: Remove unused clk_hw_rate_is_protected
Date: Wed,  9 Oct 2024 01:35:52 +0100
Message-ID: <20241009003552.254675-1-linux@treblig.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

clk_hw_rate_is_protected() was added in 2017's commit
e55a839a7a1c ("clk: add clock protection mechanism to clk core")

but has been unused.

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/clk/clk.c            | 6 ------
 include/linux/clk-provider.h | 1 -
 2 files changed, 7 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index d02451f951cf..9b45fa005030 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -608,12 +608,6 @@ bool clk_hw_is_prepared(const struct clk_hw *hw)
 }
 EXPORT_SYMBOL_GPL(clk_hw_is_prepared);
 
-bool clk_hw_rate_is_protected(const struct clk_hw *hw)
-{
-	return clk_core_rate_is_protected(hw->core);
-}
-EXPORT_SYMBOL_GPL(clk_hw_rate_is_protected);
-
 bool clk_hw_is_enabled(const struct clk_hw *hw)
 {
 	return clk_core_is_enabled(hw->core);
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 7e43caabb54b..5cbd112d1187 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -1360,7 +1360,6 @@ unsigned long clk_hw_get_flags(const struct clk_hw *hw);
 	(clk_hw_get_flags((hw)) & CLK_SET_RATE_PARENT)
 
 bool clk_hw_is_prepared(const struct clk_hw *hw);
-bool clk_hw_rate_is_protected(const struct clk_hw *hw);
 bool clk_hw_is_enabled(const struct clk_hw *hw);
 bool __clk_is_enabled(struct clk *clk);
 struct clk *__clk_lookup(const char *name);
-- 
2.46.2


