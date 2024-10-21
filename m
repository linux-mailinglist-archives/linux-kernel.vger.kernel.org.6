Return-Path: <linux-kernel+bounces-373953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D269A5FC3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 11:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FCD9B21E2D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 09:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CFB91E32A4;
	Mon, 21 Oct 2024 09:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rdAj9ZT7"
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993231E25E6
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 09:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729502065; cv=none; b=I6H516hcgEoyUR71N+C045Wj2kwGyfeSEs/jWyap2VnAZWWwYKIw3yc5fnoReTWjHjo6IFETsLbCgGGKI+BqHCrbW7sf80yiwPW/w6eiDn7xFxLWUrMjnhxC8CrkicK0MrNng4JfUP6DanLuvZe3XYliMRi0UJ1PhtUY1gTCz0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729502065; c=relaxed/simple;
	bh=r72VYBhQohT11BWpxAbyyQ8tZ0NxKp9JjzHQ+0PQcds=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LbLMfZvvtzgIqzLXoQ0zEZVY3Gyf9dagoT1pm9K3/b7Xb4bvHGliQCT3bIr20PLNYyzG3caw5aTVewJugHY12ruKjKMhv4dQRI3jEckH6aePXeeFUAEDQ0N1vFlMCU+fhKVcigJ5K8KovVS2OQuDTZQhbqrXGcSNAHr5BgrIogE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rdAj9ZT7; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729502059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Wlq+3bW4+TRGvbmu1pjeIeW38H6q6bepbBN1pV11OEU=;
	b=rdAj9ZT7rjK4bLOiSJ8iG8k/loXlDfy2JDlV4T/hM930LE2b1bVKcQg3SHK7EcUfCAdWNR
	5L7hU7++bSA4Kia1LaxPZghbA59KQJI4n9pgR1J0Uj/usjFsJAo2q7phFV8a82u8lNfp+j
	B8pb+uvECcTBLPg/TWz3Nib5IhDVw2o=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm/page_alloc: Use str_off_on() helper in build_all_zonelists()
Date: Mon, 21 Oct 2024 11:13:40 +0200
Message-ID: <20241021091340.5243-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove hard-coded strings by using the str_off_on() helper function.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 mm/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 8afab64814dc..11d3fa3587db 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5495,7 +5495,7 @@ void __ref build_all_zonelists(pg_data_t *pgdat)
 
 	pr_info("Built %u zonelists, mobility grouping %s.  Total pages: %ld\n",
 		nr_online_nodes,
-		page_group_by_mobility_disabled ? "off" : "on",
+		str_off_on(page_group_by_mobility_disabled),
 		vm_total_pages);
 #ifdef CONFIG_NUMA
 	pr_info("Policy zone: %s\n", zone_names[policy_zone]);
-- 
2.47.0


