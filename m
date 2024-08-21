Return-Path: <linux-kernel+bounces-296241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DFA95A80D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 01:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA0381F22BDE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 23:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1D717C9FB;
	Wed, 21 Aug 2024 23:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFOuBSPL"
Received: from mail-oa1-f65.google.com (mail-oa1-f65.google.com [209.85.160.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2AE17C9EA
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 23:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724281593; cv=none; b=k55iI5eeleXrw0Qd2NLI9Vmwu6BLX8Td9CtUJnfTB2qAWMSoaGdOerYPXPkSCvdL9kIxbQmLAbiFQ2FRd7mX5g969DDZ9mKbENlDkA9s9HgH/0H3CVwx/3Lvi9mjVdTrS6ilgsgW2Gq2PEytgOiBi76j0YxJa4FiG110Dx7mad8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724281593; c=relaxed/simple;
	bh=Vkd90pptKLQx4ViwZfakrmJMkdGWpS2Kbx0GQlsRk7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WUPmUDD5BgGk5UAOr1mn7bV75kMOQaEIH+k9HNkEMg4F8Rg+oWF/zx6/6PxfqNjCdmrs3CBo28RBi8HYqxFEZH2DrtkWi40i52OrDLpCUMx3Bqzl1FHnPGKU1n5bLPmJQq9KfFozkISDPK2uwZwjImPOg35T45lZ5slmJedsTKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CFOuBSPL; arc=none smtp.client-ip=209.85.160.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f65.google.com with SMTP id 586e51a60fabf-27018df4ff3so135706fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 16:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724281590; x=1724886390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bMobP6ENMIF18aN0lwW15eW325zdEEMUYT1+nFph7nc=;
        b=CFOuBSPLVuFbY1rxE6KvSdBa5RM/S3949uwFYUFMBJ2WlBgYToTv29NhGmGZzQ0EBM
         KUyWd7ZhkSxkOwWvvOG+MDSsXjFxZgCUMY7KoAwkwcZsChTh/f4+gGuIjRJOUMwqG0Tm
         9MjG+uq+5Gx3nHX/0zISlTa033+8w/L/dW9XIByIPKXsJFOkimWfW8OqS+vx5WN0oglC
         308PKOwbvsvza5jv4uzl/AHqaqpUDBU/awxFPHcvR4N4zVDSV6vNEyHJggCySZOzG63d
         VOG+HFyRJ19aVCzeQiQX8Z9IOzmxek9OGzjSxoPktsA8KniKwqTytYCk1BR2dkHIMcj3
         WFdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724281590; x=1724886390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bMobP6ENMIF18aN0lwW15eW325zdEEMUYT1+nFph7nc=;
        b=tfcSPoXsY9m8HKXkg7NZ/6kjHKytmYDvJghIAhDo5nXEK+CAs3tmy3I+UXcLWQpG0Z
         XMQjguh/y9o/dHXC7hzDyVNSCltkUiUygwbTUzR/mviZaSrpayrQzbOP8hJYqdg1K8Pm
         wK1Vma5aJUVKjPOfcbHjVItXAwdThi4qMM5Iqmr+Ad56ES4iiHpbxXy+Kg10UqsA+GSt
         SvRjoILcw27aAHlrDT0VzTnJlJDVRGhHwu3CEAmL4ckiBwWpCKU6HqEWFfcbrfduWo3f
         2ojWz/jSEWba/dAwlKlzOb/oR+Ok4eqaRU9bJZn3x3UEh8Aue0BBmAWQRPBFffEjS3Gy
         nJ5g==
X-Gm-Message-State: AOJu0YwdU57LO1fMIZk8Q9x315hQo+WtypQOjAnWwRxMPvurkRbHwDVT
	I0BUDF3QzIu6mPlqyenBAXUHx330hqzLgx2nOzkFHEEK2BoGVilC
X-Google-Smtp-Source: AGHT+IFAs+iNBIXDAB45Avh+la8ZO7s3H2bqsrk2GdeLbH9coOTybgO/Jil0qiCzBKLvps72K2SBNg==
X-Received: by 2002:a05:6870:9127:b0:25e:d62:f297 with SMTP id 586e51a60fabf-273cff95d3amr154177fac.45.1724281590546;
        Wed, 21 Aug 2024 16:06:30 -0700 (PDT)
Received: from localhost (192.243.127.228.16clouds.com. [192.243.127.228])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71434235f77sm184096b3a.13.2024.08.21.16.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 16:06:30 -0700 (PDT)
From: Woody Zhang <woodyzhang666@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	Woody Zhang <woodyzhang666@gmail.com>
Subject: [PATCH 4/5] list_bl: add hlist_bl_move_list and two macros
Date: Thu, 22 Aug 2024 07:05:38 +0800
Message-ID: <20240821230539.168107-5-woodyzhang666@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240821230539.168107-1-woodyzhang666@gmail.com>
References: <20240821230539.168107-1-woodyzhang666@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hlist_bl_move_list is similar to hlist_move_list. Caller should decide
whether bit locking is required for old and new hash list.

Signed-off-by: Woody Zhang <woodyzhang666@gmail.com>
---
 include/linux/list_bl.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/list_bl.h b/include/linux/list_bl.h
index d25c659f6635..928048354e04 100644
--- a/include/linux/list_bl.h
+++ b/include/linux/list_bl.h
@@ -38,6 +38,8 @@ struct hlist_bl_head {
 struct hlist_bl_node {
 	struct hlist_bl_node *next, **pprev;
 };
+#define HLIST_BL_HEAD_INIT { .first = NULL }
+#define HLIST_BL_HEAD(name) struct hlist_bl_head name = {  .first = NULL }
 #define INIT_HLIST_BL_HEAD(ptr) \
 	((ptr)->first = NULL)
 
@@ -142,6 +144,17 @@ static inline void hlist_bl_del_init(struct hlist_bl_node *n)
 	}
 }
 
+static inline void hlist_bl_move_list(struct hlist_bl_head *old,
+				   struct hlist_bl_head *new)
+{
+	struct hlist_bl_node *n = hlist_bl_first(old);
+
+	hlist_bl_set_first(new, n);
+	if (n)
+		n->pprev = &new->first;
+	hlist_bl_set_first(old, NULL);
+}
+
 static inline void hlist_bl_lock(struct hlist_bl_head *b)
 {
 	bit_spin_lock(0, (unsigned long *)b);
-- 
2.45.2


