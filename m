Return-Path: <linux-kernel+bounces-288850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBE7953F80
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 04:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37AD4284A10
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 02:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3B4487A5;
	Fri, 16 Aug 2024 02:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="Q0KZTjce"
Received: from out0-199.mail.aliyun.com (out0-199.mail.aliyun.com [140.205.0.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476357F9
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 02:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723775151; cv=none; b=LfL1E7Hq6RoewzffBebaJpIE1yeullbzqNnIIfMqSOa42YJxy0ff+O6dspOQJ8W//InbzAAhkkdIFD4iBoawPACWi9eUFP42TsObx9E8MybXN5nSUFF4SrqqmiiuQifkWGviYwXtTgtb7e55qEkHmbcKj9zFlZOK0RPg+j7NXPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723775151; c=relaxed/simple;
	bh=hwIxujJVTJ2TIFlwoL2yBzxaVoHwkKMMlQZLaJFTYVs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KVxGpsEAAWNSKJGazr4OWwsTGuHkugxLJIG1gtXsn98w/STlI+Vxaw+boQ+G6/reP269ozpZ1JNfzSkz4eFj76q7qd/tPW+pAwvgeeW7TyME40z+Yc8gCWUUSoLKsZTuluENkxAxQG++PqKmjicQ4amiL205pYI0c/Tn+4cYhN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=Q0KZTjce; arc=none smtp.client-ip=140.205.0.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1723775145; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=djYu62jVoool1PS6r9/4jk3+WjmBSJsC3CBExq2h60g=;
	b=Q0KZTjcecuySBRM3bdGBlCw5gcejivYj4In8HIyHvtt4SWB5I/qWaDY689Nl2RFlvj90hIHhfRXA5MJKpLOaD1LW2o1V91L42t7lmw421Mc+BzcWjQWWn7BwrR9ZoaFEVRVoHAgeJILVqOSK1CRALoraOgk0kX1Hzypfrk3P+e0=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.YtEBok._1723773296)
          by smtp.aliyun-inc.com;
          Fri, 16 Aug 2024 09:54:56 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc:  <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 4/6] um: Remove unused mm_fd field from mm_id
Date: Fri, 16 Aug 2024 09:54:45 +0800
Message-Id: <20240816015447.320394-5-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240816015447.320394-1-tiwei.btw@antgroup.com>
References: <20240816015447.320394-1-tiwei.btw@antgroup.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's no longer used since the removal of the SKAS3/4 support.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/include/shared/skas/mm_id.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/um/include/shared/skas/mm_id.h b/arch/um/include/shared/skas/mm_id.h
index 1e76ba40feba..b3571a8afec9 100644
--- a/arch/um/include/shared/skas/mm_id.h
+++ b/arch/um/include/shared/skas/mm_id.h
@@ -8,7 +8,6 @@
 
 struct mm_id {
 	union {
-		int mm_fd;
 		int pid;
 	} u;
 	unsigned long stack;
-- 
2.34.1


