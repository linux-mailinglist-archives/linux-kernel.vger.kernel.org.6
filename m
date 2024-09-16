Return-Path: <linux-kernel+bounces-330171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC8E979A8E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 07:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D39E1F22910
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 05:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5441D17C6C;
	Mon, 16 Sep 2024 05:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="Clr/wFIo"
Received: from out0-213.mail.aliyun.com (out0-213.mail.aliyun.com [140.205.0.213])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAD623A9
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 05:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726463134; cv=none; b=N5i/Km9LKrLdObOhfvpSulE7cC8ArLansgT23+/WwbA9QNdm+J+MONeHzMFUPGH8Hw8cSrYsMpozMhTJIXXWVGpWkJTfHiNE1xBMHzqQXKk7BT0n1TreGeb6LIEw8fT5VLE5VlbisQBysDzQTjQRXUuijx9rrldMRdNiJ3mwOMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726463134; c=relaxed/simple;
	bh=zGoiFZ/z/Sx8dq6MgXvj9Gkq5VNXp+C5J1FQyL3vMWE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VwoUZVuqeV2VTct4DfMixhZbAopXgSsMn9crhRX66jAFqtjfxfZWXcPPo+o7ae+XL1TrDvVXLLPT/051R4xYfJWbdCYqTvaxzxQ3WPWwqwjI+BIFbxuH07BYIS9dje875yZIJ8SpeqgVin8aNYC6SZmRZAJGWIvclFTwX/0MctA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=Clr/wFIo; arc=none smtp.client-ip=140.205.0.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1726463122; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=cbbIBKc7FkHrrK8qYg7r4mWInrYZd8lfitbgdnVzDr4=;
	b=Clr/wFIooIejDynfSDHbnlGZJNVfau2eHBjyIVWuBo/ad2qfdDmMfAGCnk58NJ5Xvxp4NuhFsJhXFIujPka/vLWAivqbMPpX6h/zh8kCpBiPaN9QnuzMg0MKuEYEItLTO6wGvBiUyiqcpwgWD2Ip/B+XYhz/Z84WkvnQdw7SC/U=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.ZKOkLWf_1726462804)
          by smtp.aliyun-inc.com;
          Mon, 16 Sep 2024 13:00:04 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc:  <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
   <benjamin@sipsolutions.net>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH v2 2/4] um: Fix potential integer overflow during physmem setup
Date: Mon, 16 Sep 2024 12:59:48 +0800
Message-Id: <20240916045950.508910-3-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240916045950.508910-1-tiwei.btw@antgroup.com>
References: <20240916045950.508910-1-tiwei.btw@antgroup.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This issue happens when the real map size is greater than LONG_MAX,
which can be easily triggered on UML/i386.

Fixes: fe205bdd1321 ("um: Print minimum physical memory requirement")
Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/kernel/physmem.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/um/kernel/physmem.c b/arch/um/kernel/physmem.c
index fb2adfb49945..ee693e0b2b58 100644
--- a/arch/um/kernel/physmem.c
+++ b/arch/um/kernel/physmem.c
@@ -81,10 +81,10 @@ void __init setup_physmem(unsigned long start, unsigned long reserve_end,
 			  unsigned long len, unsigned long long highmem)
 {
 	unsigned long reserve = reserve_end - start;
-	long map_size = len - reserve;
+	unsigned long map_size = len - reserve;
 	int err;
 
-	if(map_size <= 0) {
+	if (len <= reserve) {
 		os_warn("Too few physical memory! Needed=%lu, given=%lu\n",
 			reserve, len);
 		exit(1);
@@ -95,7 +95,7 @@ void __init setup_physmem(unsigned long start, unsigned long reserve_end,
 	err = os_map_memory((void *) reserve_end, physmem_fd, reserve,
 			    map_size, 1, 1, 1);
 	if (err < 0) {
-		os_warn("setup_physmem - mapping %ld bytes of memory at 0x%p "
+		os_warn("setup_physmem - mapping %lu bytes of memory at 0x%p "
 			"failed - errno = %d\n", map_size,
 			(void *) reserve_end, err);
 		exit(1);
-- 
2.34.1


