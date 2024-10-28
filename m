Return-Path: <linux-kernel+bounces-385148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A339B3328
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 15:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C457C1C21077
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 14:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C23C1DDA39;
	Mon, 28 Oct 2024 14:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TX5VTTHr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95AC1DA631
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 14:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730125103; cv=none; b=T4Rw/UihHaVHPfuQv0bC0m+YC1pQ14+VnLjDmmCN4RH7CZmOWD1fKcluj4KRWup3KywP8n4HcyFWvCOdUu42zFF+cAPeFTU5AxdtgB6v9YGoYXJuEtm7r0W3icqfq5JdwcKNTi9zjSSSJPaLbWO5jJFtOkNM44sl5wQwGCkUNj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730125103; c=relaxed/simple;
	bh=mBpXWXxLTTeSoq4/zHpXkTzNWRmP/T91PZm9hTMvR5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qomjfeKLY5h5FCA9qHnUjDPetW7Ymq+ZnrU7uxDH/F+KYx5LU03qgDhexTkiTpTLVyHLw9jRFktxdnbNSucyxMb6emiTnongEPb2gSWSV84sGht1REY8tB5Lku+QZ5nMXhmAQjR1WJpoAzARgKnN8bsMma42toW9WuwNM7FBg0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TX5VTTHr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 350D2C4CECD;
	Mon, 28 Oct 2024 14:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730125103;
	bh=mBpXWXxLTTeSoq4/zHpXkTzNWRmP/T91PZm9hTMvR5Y=;
	h=From:To:Cc:Subject:Date:From;
	b=TX5VTTHrj/S3bZq59zkXs5KsRejQfiRD+lUTwopzolVO+Jb8R21LmVsbCw02m1DT0
	 ScBOY/323X9N++YYfw4catzZ+yrFixcORLTlBL+2RmQ5xvKX/h2te3Pe/hzrM1qmbG
	 ST8CqcN1ZAlcWVKNQ3H8VXi8bCFg2zRbLBvm45QzYXNQX3OrCOJfqS9a7aes5WazML
	 jckrgpNpv0GgYRro7mpbbBw07uMDmess/tGs72UVxw+4RG96pesXHbtIgi8bUnygdi
	 VNOpX/vPBmsBZ30pSCQkosfOdCi6N9DvN5agai8CXHWHdLtDYPGGuyyIus23/m75Ln
	 Tx8YnK/yHIZlg==
From: Arnd Bergmann <arnd@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Song Liu <song@kernel.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] alloc_tag: hide execmem_vmap() on !MMU
Date: Mon, 28 Oct 2024 14:18:09 +0000
Message-Id: <20241028141818.622917-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The newly added function fails to link on nommu kernels, but is also
not needed there:

ld.lld-20: error: undefined symbol: __get_vm_area_node
>>> referenced by execmem.c
>>>               mm/execmem.o:(execmem_vmap) in archive vmlinux.a
>>> referenced by execmem.c
>>>               mm/execmem.o:(execmem_vmap) in archive vmlinux.a

Fixes: 57bc3834fb6f ("alloc_tag: populate memory for module tags as needed")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 mm/execmem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/execmem.c b/mm/execmem.c
index 5c0f9f2d6f83..b04cfece7356 100644
--- a/mm/execmem.c
+++ b/mm/execmem.c
@@ -368,6 +368,7 @@ void execmem_free(void *ptr)
 		vfree(ptr);
 }
 
+#ifdef CONFIG_MMU
 struct vm_struct *execmem_vmap(size_t size)
 {
 	struct execmem_range *range = &execmem_info->ranges[EXECMEM_MODULE_DATA];
@@ -383,6 +384,7 @@ struct vm_struct *execmem_vmap(size_t size)
 
 	return area;
 }
+#endif
 
 void *execmem_update_copy(void *dst, const void *src, size_t size)
 {
-- 
2.39.5


