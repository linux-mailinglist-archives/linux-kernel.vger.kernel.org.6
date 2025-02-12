Return-Path: <linux-kernel+bounces-510638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEAFBA31FE0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 08:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E7B63A17BE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 07:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1807E20458A;
	Wed, 12 Feb 2025 07:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Q5GCg+LB"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74AC2040A4
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 07:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739344789; cv=none; b=vBYIQ+P0Qk7cc6ofCD30KOLlUe2dJdkY1EAOxlQFMdueQP7hNmvEqBLNWWeoZ5AIIee9PXTrozh/6IZG6ZNEAWfs+YNSMtRkvRb0oqYSoD9VANCIBHNXCg1G7r38HqbLRnIku/jiD0MWOuV5ggyF7F5vbKxZIpl3Tg/IYHVlatY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739344789; c=relaxed/simple;
	bh=EFRhrJlUS+/UFGQVXqTEid2gUvXJR2ewIGIc8eiW0Dg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KNtidXakuJKrFOzZebsnbhkq/j2mcy1dhG4ndpEu/Tt1dFMsG69DZlymce8Pc7tXO9Y3CUQWff4cqXABgV5/WXLPrOiuRSjqeNzLh/LiGfVRWgnfe3Ztv32KSYeq149HZpr6LXXql0NK4bpb3Gti+F8WMPhg3bJO3RPq3eBQl9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Q5GCg+LB; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21f55fbb72bso83995815ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 23:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1739344787; x=1739949587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+MliVLA3kxQyQATbmQhjmjI3lg4Akr3xu9bOABtGNVU=;
        b=Q5GCg+LBftVxn/ErOe/OH49tbNOmf9m+zDC8a9Zv02KkSGkcWDd6OWoIvxUmFQmryj
         muabjpQ/9sQ1QvS57JEpObyLDy60eASexTzQAddkkJfAqEAKVJ1STJcxmfvnInxcvqg0
         izDerAHdNvkyyWoD0oY/Tq8GI3W0/R6/EhXwhz18ufdKpnGam9TrVDaBe0OGs8HhAk8l
         E3gp9lAPpRp/r/oCjF96b71QUBFDD/zs+NHw8kVSRrp4gwkn3dpk8nhlfD3ZWvcmhDg0
         8ENnKTftSDc20xzbNtoyivpUfrpjFo4VINUYN9EQk8XALuJAxgy6SyX1J5RIwEUDpL/z
         ZAmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739344787; x=1739949587;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+MliVLA3kxQyQATbmQhjmjI3lg4Akr3xu9bOABtGNVU=;
        b=eSkKh5h5vhmNIq+lMY0lhrcKPT1hEK+bM4myOyoNIWqMx5giiezOfoY0sYxiH11KlA
         JSq/4BlyrrRVAcDj2RTJR11RMV8QfV+CpcZ2Lbys4agNbRUKlIk9a0ROOhwLnhSTkgYX
         2Kv+Xu+zROfItIkMXUnTzlM014VxdRD4ASngCA5QQg+u/LH15sSrjBa0MBzNCcxdrdBT
         pnBfG0OCkrf//tzxc0udoVaBVgadBO403Xu7HnouB4Vd9IM/P4874kQiLsSafwqzLkIf
         CKbyAOCOSq33yoMW9zzAoWQYVDC06xFSaop0OGIoWsz+vbdmRJ9FXG5Y1mssc81q7Tmr
         Kuzw==
X-Gm-Message-State: AOJu0YyxngxB7pFuWeBl8khpW2fTTp3paiKAfvsm6of4CMR/d9DRbdAf
	yx9hRoBBKMo5xTZcohrDwDTSnwna5QbxvXM/kDhNLgcdzFKvZz72emy3PgHblMI=
X-Gm-Gg: ASbGnctSuSwGCf1VD2IyfeR6/cDAL785bOREZ3P6CidYdfvw3B4YZ1WOJ8nO37HBUoo
	KWwKgmbgQJOej+gQlIEnC3pxH/ZhoLXhk6JVcqgfLSZTkgzGsZELe28bkYZWZ2x1j2S6/9OqFZ7
	TIsaEO3QJovUge/HLdGbUqIHt231c6T5y+Bh4RH8mFNXETqKxZiLF0DBUVdPQPXq3wMz8uwEaVh
	ZT2J2PZVLO2qMpabxNsyTUNsOyy6vIoTCQPMlgiKbbKP6P+TQr7G//DOBtugios57W3qF4gDzWt
	sFbxWMKcbZEWU2TBuxzS1h1tc4qT+gLSPg==
X-Google-Smtp-Source: AGHT+IHADU+vj5clo8GWnsEuAkpkif1g5lEBUzZD079gYSW2w/chzgKsxZmTA1RTHvFxmp5aciNaUA==
X-Received: by 2002:a05:6a00:9099:b0:727:3cd0:1167 with SMTP id d2e1a72fcca58-7322c434a17mr3888144b3a.21.1739344785458;
        Tue, 11 Feb 2025 23:19:45 -0800 (PST)
Received: from n37-019-243.byted.org ([115.190.40.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-730aad5535fsm3659097b3a.51.2025.02.11.23.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 23:19:45 -0800 (PST)
From: Chuyi Zhou <zhouchuyi@bytedance.com>
To: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: linux-kernel@vger.kernel.org,
	Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [PATCH] sched_ext: Fix the incorrect bpf_list kfunc API in common.bpf.h.
Date: Wed, 12 Feb 2025 15:19:36 +0800
Message-Id: <20250212071936.1406029-1-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now BPF only supports bpf_list_push_{front,back}_impl kfunc, not bpf_list_
push_{front,back}.

This patch fix this issue. Without this patch, if we use bpf_list kfunc
in scx, the BPF verifier would complain:

libbpf: extern (func ksym) 'bpf_list_push_back': not found in kernel or
module BTFs
libbpf: failed to load object 'scx_foo'
libbpf: failed to load BPF skeleton 'scx_foo': -EINVAL

With this patch, the bpf list kfunc will work as expected.

Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
---
 tools/sched_ext/include/scx/common.bpf.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index d72b60a0c582..7849405614b1 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -270,8 +270,16 @@ void bpf_obj_drop_impl(void *kptr, void *meta) __ksym;
 #define bpf_obj_new(type) ((type *)bpf_obj_new_impl(bpf_core_type_id_local(type), NULL))
 #define bpf_obj_drop(kptr) bpf_obj_drop_impl(kptr, NULL)
 
-void bpf_list_push_front(struct bpf_list_head *head, struct bpf_list_node *node) __ksym;
-void bpf_list_push_back(struct bpf_list_head *head, struct bpf_list_node *node) __ksym;
+int bpf_list_push_front_impl(struct bpf_list_head *head,
+				    struct bpf_list_node *node,
+				    void *meta, __u64 off) __ksym;
+#define bpf_list_push_front(head, node) bpf_list_push_front_impl(head, node, NULL, 0)
+
+int bpf_list_push_back_impl(struct bpf_list_head *head,
+				   struct bpf_list_node *node,
+				   void *meta, __u64 off) __ksym;
+#define bpf_list_push_back(head, node) bpf_list_push_back_impl(head, node, NULL, 0)
+
 struct bpf_list_node *bpf_list_pop_front(struct bpf_list_head *head) __ksym;
 struct bpf_list_node *bpf_list_pop_back(struct bpf_list_head *head) __ksym;
 struct bpf_rb_node *bpf_rbtree_remove(struct bpf_rb_root *root,
-- 
2.20.1


