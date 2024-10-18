Return-Path: <linux-kernel+bounces-371476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C679A3B93
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 12:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76CFD1C23A88
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 10:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53EDF20103E;
	Fri, 18 Oct 2024 10:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZRFybtYX"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFF220100F
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 10:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729247529; cv=none; b=e+6ZKys1f3VV/KPMUEvkwY491VYYtWn92CdAQhpU1yDHDxOFHgnfj3FS6L1yORuIJ1jLdsBSGoSxdrUWxugYeR2q0VRBTBtPVIxxPynUljLjoWDDR+SrTuObkrB75ArUb8CEhGFL0V6qvWRfoKYPEwTVtHIONUBvxMBLjVNBg34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729247529; c=relaxed/simple;
	bh=uRaTl+ZfVrh6lin/h/p+Zi5ZONpTUpH2uZlh5pNmF20=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ld+ApF9fiqgKtQJkwpNJ/pDu22dLwaHiljaB3OubMf9Ns14bJToz6Tv0ryvTRdxeTTVPgRmnUm6bdNidPVlP4M4x9K8XUpHmn8qc8tGlLhNzvrXX6VxILQtu9sHQx4OzjBuFI0Y2YJA3wMJjbe/LA1iMn0pFuX5p/93uxUlabQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZRFybtYX; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729247525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4tTv7zOc2n71G6HE+wtmzbGGssPfw6n3LZRNIY9OY0A=;
	b=ZRFybtYXRACrmBO3cafx7ijbwet4tzlTEH+qfjL+sgAGnYqt4P//xjBS+dcrX/d39+acpY
	Ca1w0VOGv1ChvvlIDC0gF+PamgHMXXn8gCYqdoKieZhGj4GQRCQsGJk53j6rQuHKrHfyN1
	zEbwAPV4mV1W9VZDeH24LWzBRbU28Cs=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm: Use str_on_off() helper function in report_meminit()
Date: Fri, 18 Oct 2024 12:31:51 +0200
Message-ID: <20241018103150.96824-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove hard-coded strings by using the helper function str_on_off().

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 mm/mm_init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 4ba5607aaf19..253972926183 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -2573,8 +2573,8 @@ static void __init report_meminit(void)
 		stack = "off";
 
 	pr_info("mem auto-init: stack:%s, heap alloc:%s, heap free:%s\n",
-		stack, want_init_on_alloc(GFP_KERNEL) ? "on" : "off",
-		want_init_on_free() ? "on" : "off");
+		stack, str_on_off(want_init_on_alloc(GFP_KERNEL)),
+		str_on_off(want_init_on_free()));
 	if (want_init_on_free())
 		pr_info("mem auto-init: clearing system memory may take some time...\n");
 }
-- 
2.47.0


