Return-Path: <linux-kernel+bounces-383113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7ED79B1776
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 13:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E588B2272D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 11:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6D81D0E24;
	Sat, 26 Oct 2024 11:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NPVa/qCp"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED2A1FC3
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 11:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729942410; cv=none; b=j5/5kgBtqXzNxQuWqkaV0/SVXvvoSL83o0dkcX2wfJ4mLmA8k16zuEy5y1cws+/0nU30k4W0Ulk/YIvG9v6Vx/ymEz/kUcGLeK0CEzQlf5oXUI1mk4N7L9x687CGD+lkPq4WBSBUorHU/L5FsR+eXUINnXTWXVxUg6iuXsee7Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729942410; c=relaxed/simple;
	bh=4EfySD8dguHXIi3sjSlBYJWgh3mjOa8JQ14gtIGYAJc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oT1B72t8fDGIjRJ5zVhdmJzdhgfWkbR3Wr+9aplRlWShFUkaU31WbLM7alxZKhpzqeKwHzCdQicZqE49GdBmNYfrYMDBPFhJBAwhWzgRCPDFc1br3rgbsaPcAlhtH4WXgmYhbiyoaWPNd4S6XhJN+6AQp3faIM0qlOcX3WD8UzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NPVa/qCp; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729942406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/mTPa+MHBPWbALI+r9PSWRLltGGqQ3ro9y/4bwffy3k=;
	b=NPVa/qCpXyyfSnhTtBqO3jiUfCTKrCm6Q4H/vLTLfAZayAHmXdOziDPVAimIr9EyIuP8dM
	sKxwBYpYtglxnI3KTiaf5HFiLlbJ0u5ics31+A6XUUqUwZA4YXmPkwtZqkXOpGHy+8VuE+
	SNF/IDaiMRP+GLGwh6jjWwEGxeBalL4=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Jarkko Sakkinen <jarkko@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-sgx@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] x86/sgx: Use vmalloc_array() instead of vmalloc()
Date: Sat, 26 Oct 2024 13:32:47 +0200
Message-ID: <20241026113248.129659-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use vmalloc_array() instead of vmalloc() to calculate the number of
bytes to allocate.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/x86/kernel/cpu/sgx/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 9ace84486499..1a59e5956f4b 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -630,7 +630,7 @@ static bool __init sgx_setup_epc_section(u64 phys_addr, u64 size,
 	if (!section->virt_addr)
 		return false;
 
-	section->pages = vmalloc(nr_pages * sizeof(struct sgx_epc_page));
+	section->pages = vmalloc_array(nr_pages, sizeof(struct sgx_epc_page));
 	if (!section->pages) {
 		memunmap(section->virt_addr);
 		return false;
-- 
2.47.0


