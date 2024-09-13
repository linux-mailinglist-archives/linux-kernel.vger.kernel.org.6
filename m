Return-Path: <linux-kernel+bounces-328361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8075E97826E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 16:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D770528971E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 14:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36CFBA2E;
	Fri, 13 Sep 2024 14:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="k7MwAqmR"
Received: from out0-200.mail.aliyun.com (out0-200.mail.aliyun.com [140.205.0.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D804FC08
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 14:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726237312; cv=none; b=PSm6AR6Y7yVqu5pmRUWOIZV2bVb3/5/qu8x5U+CqBnUp7EQhVlMNnC1UAX8zQhfWJTOe32oxROBTAHlE7JwhpfUYut8GiZCzvWsNDduXCq3CZXBuLx9sT+Aai7TM7ijt5L50isVCMLHXKiq1n87VAi+aWOWC9SmNfX6OgTfx6ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726237312; c=relaxed/simple;
	bh=mSH6M9cARGi/4U8gWkJ/5L0xMNj6Gr5rXJEMqQfsui4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WFGkHPkvfWQsg7jd10PqnBkCXYPpc54OdAkWKIYcZG74Q9g/bGU9rglh2Nil+Sdqu+9gG/lFRdxuJQIEPG3hCh2/X82BGBtfSJNLVFE/+QRQn9eCNAW9ZMh7UovsCJ1JZWfShLAZu/coXipH642RfSyXP11RuUoquriwElyKDwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=k7MwAqmR; arc=none smtp.client-ip=140.205.0.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1726237306; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=ICwDMhjJ7dbADtxlBSbI8KnsxD7naRbiR1HvDVegF5k=;
	b=k7MwAqmRqJfw6mhmo5bi+3xPV/mozpFCsbs+oJch4mzmUkLgRYG4WUQoyjrjQrSvvGFzK1rh+H3BY862KraU3qmKGvP+8N5DrnBGTZU472bvMapCJRRqlc2iIg5qJgeXr5cWAi4ol66W7HbG+soH+qUxUpFjEq99rnHReWj6D3Y=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.ZIP7E7j_1726237303)
          by smtp.aliyun-inc.com;
          Fri, 13 Sep 2024 22:21:45 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc:  <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 1/3] um: Remove the redundant declaration of high_physmem
Date: Fri, 13 Sep 2024 22:21:35 +0800
Message-Id: <20240913142137.248245-2-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240913142137.248245-1-tiwei.btw@antgroup.com>
References: <20240913142137.248245-1-tiwei.btw@antgroup.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

high_physmem has already been declared in as-layout.h, so there is
no need to declare it explicitly in the .c file again.

While at it, group the declarations of __real_malloc and __real_free
together to make the code slightly more readable.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/os-Linux/main.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/um/os-Linux/main.c b/arch/um/os-Linux/main.c
index f98ff79cdbf7..cf1179ed1aec 100644
--- a/arch/um/os-Linux/main.c
+++ b/arch/um/os-Linux/main.c
@@ -182,6 +182,7 @@ int __init main(int argc, char **argv, char **envp)
 }
 
 extern void *__real_malloc(int);
+extern void __real_free(void *);
 
 /* workaround for -Wmissing-prototypes warnings */
 void *__wrap_malloc(int size);
@@ -219,10 +220,6 @@ void *__wrap_calloc(int n, int size)
 	return ptr;
 }
 
-extern void __real_free(void *);
-
-extern unsigned long high_physmem;
-
 void __wrap_free(void *ptr)
 {
 	unsigned long addr = (unsigned long) ptr;
-- 
2.34.1


