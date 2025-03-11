Return-Path: <linux-kernel+bounces-555943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B78A5BE9D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 12:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2813A1898531
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 11:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8EAD253F02;
	Tue, 11 Mar 2025 11:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="t4HOG6zp"
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9082E238D5F
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 11:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741691614; cv=none; b=piLRQt0NmPa9MAfAIjtn1Afrae7mYLDEigg+Eb2n3LgOB5fYJj82jWgz4+sdPVPaFUhcK/bNenBLlQZ0sqY6UFJg5LB3rWPOhkGnTwCb1Gyt7FwKfzGEVZlBw2WwMQ/mCAuGkMvLjMhTCTM2pUTm2kO9JgokyI0U84oGl8Jf8Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741691614; c=relaxed/simple;
	bh=ZSfnlQTOZD8O0fLofbS5GkGXGqJx98kuofJ7wgZMeTE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r1XkaB7icDvL9A26LIwPMUIk13/0di6i5TQUNQJ1CbtuXwyAq4p4woKFerTRdqG3VcjuaiUxFMLfgXM7yodJFevC3AfY5NPLSPJRx/BbG2JV+3mlGvpIhpRRHZQMx07EInb3BxT6HebJTNP+JrgXKnN9KQcfo3l7mxVtnjKh8JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=t4HOG6zp; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741691610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HfPMogj46GXj+PK6wnAMkLlFbwsd12CYKYgvhpu8sPY=;
	b=t4HOG6zpcaANRvzYUVZLQbuMvGQ0/yUxrJ2bqnY+oHDmVT0FYsg8KIRZVGeC9eekxEUWKf
	RvgymgbuzlqBFqooyjMILKTR94Z8ZezDVo/3EIzKescXENbbQwet1xHAxMJQWxqH/ZDonD
	eAptpFSq+FUwnJ7eXFyJAYWWxPTCoDE=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] bcachefs: Use max() to improve gen_after()
Date: Tue, 11 Mar 2025 12:13:11 +0100
Message-ID: <20250311111310.495922-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use max() to simplify gen_after() and improve its readability.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 fs/bcachefs/buckets.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/bcachefs/buckets.h b/fs/bcachefs/buckets.h
index a9acdd6c0c86..124ac380b22e 100644
--- a/fs/bcachefs/buckets.h
+++ b/fs/bcachefs/buckets.h
@@ -167,9 +167,7 @@ static inline int gen_cmp(u8 a, u8 b)
 
 static inline int gen_after(u8 a, u8 b)
 {
-	int r = gen_cmp(a, b);
-
-	return r > 0 ? r : 0;
+	return max(0, gen_cmp(a, b));
 }
 
 static inline int dev_ptr_stale_rcu(struct bch_dev *ca, const struct bch_extent_ptr *ptr)
-- 
2.48.1


