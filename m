Return-Path: <linux-kernel+bounces-209240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F86E902F6F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 06:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB430281F2B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 04:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FA916FF5B;
	Tue, 11 Jun 2024 04:10:14 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0525D63C
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 04:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718079013; cv=none; b=a1aO3C83EVmfLStbyh3WgVILvL/WgOG329DIAGmghGTLYGtnz8C6d+DgegnnVLtL8GImFBA4l9qt3lznNnPlWjwLeL6TYMKzHqbS98ZGuffrqdeamNB6VlerTcC5sWMegeAXQKidiHEZKarsKoAxqH696/QLWnje23HGnc0iSCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718079013; c=relaxed/simple;
	bh=6CKoIfbRWXYrWYdIrhyj9GZrzS2Nyta+yrXVbWijXQE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pmfFOU1wqmKmztTlovLcxJXXPnq0MzjoadimHMRlrzV/UGXoxiZvr2V9clq8CAZiA7vYLx/9ZSHncKDAPtk66iDRwP+S0WUiMUI/AGZopkxh3KKhb9iFEMY4afmfSmK0+Y0S9DDkSoQBlAtRzQfYBqgZGcfJmIiz+qr/zVoVyyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Vyw864hR9zsTpQ;
	Tue, 11 Jun 2024 12:05:58 +0800 (CST)
Received: from kwepemd100011.china.huawei.com (unknown [7.221.188.204])
	by mail.maildlp.com (Postfix) with ESMTPS id A6BD3140F84;
	Tue, 11 Jun 2024 12:10:01 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemd100011.china.huawei.com (7.221.188.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 11 Jun 2024 12:10:00 +0800
From: Changbin Du <changbin.du@huawei.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
	<palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
CC: <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Changbin Du <changbin.du@huawei.com>
Subject: [PATCH] riscv: vdso: do not strip debugging info for vdso.so.dbg
Date: Tue, 11 Jun 2024 12:09:47 +0800
Message-ID: <20240611040947.3024710-1-changbin.du@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd100011.china.huawei.com (7.221.188.204)

The vdso.so.dbg is a debug version of vdso and could be used for debugging
purpose. For example, perf-annotate requires debugging info to show source
lines. So let's keep its debugging info.

Signed-off-by: Changbin Du <changbin.du@huawei.com>
---
 arch/riscv/kernel/vdso/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
index f7ef8ad9b550..960feb1526ca 100644
--- a/arch/riscv/kernel/vdso/Makefile
+++ b/arch/riscv/kernel/vdso/Makefile
@@ -45,7 +45,7 @@ $(obj)/vdso.o: $(obj)/vdso.so
 # link rule for the .so file, .lds has to be first
 $(obj)/vdso.so.dbg: $(obj)/vdso.lds $(obj-vdso) FORCE
 	$(call if_changed,vdsold)
-LDFLAGS_vdso.so.dbg = -shared -S -soname=linux-vdso.so.1 \
+LDFLAGS_vdso.so.dbg = -shared -soname=linux-vdso.so.1 \
 	--build-id=sha1 --hash-style=both --eh-frame-hdr
 
 # strip rule for the .so file
-- 
2.34.1


