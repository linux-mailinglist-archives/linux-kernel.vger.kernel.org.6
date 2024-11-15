Return-Path: <linux-kernel+bounces-410526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F6A9CDCCF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 11:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F48BB27CE2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 10:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53FEB1B652C;
	Fri, 15 Nov 2024 10:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xwLw/H5j"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC6D1B4F09
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 10:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731667245; cv=none; b=Vbus+r/OUM+CMf4657QhgPgOu2vGFYp4zmcGc3dQ+9ebJIw2zdUt2inMlaSldzBRCvRwHnzT/bd4QdhNVOYtrlizKBfV/7nw5xpithmnM0g03X7Uj2MuXE3vvrOqRbYj6WUxOMMBS5nFm0GNRL7aKUGKVJWdOdta1mTc8jljgxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731667245; c=relaxed/simple;
	bh=uUnLYp8k6YXeUFJlWerjeI9pIPZnbyUQ/JhJQSHL/Gc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i6pt44u7gDg1JmsDocUTRcVFTO9Oxl8M/ZgnBqUHH63HvWOVk6qSfLrwg4Wv95lcH1Ut0vHfMzlML5C+rQ1i8gHJEAx32g2EEUtetqyrlwLkqM6nIJDt4lyjsANTLJc4ysOVzuYtkF3OjA+igroMqOJe6UaijKRPwzdhAwWYYLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xwLw/H5j; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731667241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AMStQies+aoz02JsqQAmr3PddLciMAs8CVnVQcUWt+Q=;
	b=xwLw/H5jYBim3NIMBP9WRo1NodZlxIHsFvXRzbJqGoeqkBc2iOcAwTxGMl0Iegnv9nCugC
	ZrK3bkeVtpiVbtlBsGDOeNgz9Ld/71tn2+biTvXExHy3t0cTKDClqyerqZd25k0Emt6tpp
	/pCUmoXWk3Y3k5JYxyyUeNlAtDnPn6Q=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Dinh Nguyen <dinguyen@kernel.org>,
	Thorsten Blum <thorsten.blum@linux.dev>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] nios2: Use str_yes_no() helper in show_cpuinfo()
Date: Fri, 15 Nov 2024 11:40:13 +0100
Message-ID: <20241115104015.109846-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove hard-coded strings by using the str_yes_no() helper function.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/nios2/kernel/cpuinfo.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/nios2/kernel/cpuinfo.c b/arch/nios2/kernel/cpuinfo.c
index 338849c430a5..7b1e8f9128e9 100644
--- a/arch/nios2/kernel/cpuinfo.c
+++ b/arch/nios2/kernel/cpuinfo.c
@@ -143,11 +143,11 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 		   " DIV:\t\t%s\n"
 		   " BMX:\t\t%s\n"
 		   " CDX:\t\t%s\n",
-		   cpuinfo.has_mul ? "yes" : "no",
-		   cpuinfo.has_mulx ? "yes" : "no",
-		   cpuinfo.has_div ? "yes" : "no",
-		   cpuinfo.has_bmx ? "yes" : "no",
-		   cpuinfo.has_cdx ? "yes" : "no");
+		   str_yes_no(cpuinfo.has_mul),
+		   str_yes_no(cpuinfo.has_mulx),
+		   str_yes_no(cpuinfo.has_div),
+		   str_yes_no(cpuinfo.has_bmx),
+		   str_yes_no(cpuinfo.has_cdx));
 
 	seq_printf(m,
 		   "Icache:\t\t%ukB, line length: %u\n",
-- 
2.47.0


