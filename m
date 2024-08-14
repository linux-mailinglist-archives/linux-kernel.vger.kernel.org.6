Return-Path: <linux-kernel+bounces-286211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD01D951810
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 11:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E496F284868
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 09:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34EB1A00D2;
	Wed, 14 Aug 2024 09:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="abD175Gq"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D1513E8A5
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 09:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723629056; cv=none; b=EP3vXf+98D+sSUqyazRc+P0JKzZMKQQwWdrqg1i9wqgJOUB8dzVa1aH+x9crX9sUjNiXhpCFD7dYVYpY54J3HACTh6j74Pi3XUS5Es9r6f71N4//Zu1duoHGyYp73GiUf58SSj+Ioy0NnbMEbzmlmr8utETH5XW0M09VSThrbpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723629056; c=relaxed/simple;
	bh=tvP+ymsnDMznZtXYdqtZp4WFdN7ZA4422EzK5EWIjIw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qJrN5Vviu7jdzyFULo4T7eG80qguBMZzcg1qB49hthSxrPFEDnDqWi6d9uPqV5FRsqdK7qs9FgpLWDR47KaRROlD4V5hrNghAC2fq1FTWMMqRwfl2Tn36ZuiEgrY9HR4Rc26x+tUeKnpc0ic8k2fRKghDLjbkMHI5ydfIlYEhQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=abD175Gq; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fd66cddd07so45206645ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 02:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1723629053; x=1724233853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B5EPTuGtOAwR22klO2g+2qxnDn7zedpJJVEUqzrIeGY=;
        b=abD175GqyMY0t5QRmLXMLxzDWEYVa+ZKtd3tiq2ZEKf3bAgQ6ZXrcADxQNHiLSN3AZ
         TvoWSCv1KdFXbvBXu7slzOr8yJwl28twFO8/ZRc8MFabibKWzF/S+HYs75rFo22+blbt
         /nF5ePo5OKe74eFewLG6U2Xyx/TDMUa/6Zf0LbpRFGKgopMofzuwP24h+kd00M/gFVF8
         1oN/pmkEWytauuOvlN67dqGTzamEeceYsrSIKVXbEY7cdAXYP/NYcE7bmJTVXC4hhPXT
         Mhp9AzSumgeG1lIbVD9N1qCSgwhqZW+BIXsS5b3mFJYTGqNiT2f/9/lOKAiNV7xNB4Q2
         rRFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723629053; x=1724233853;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B5EPTuGtOAwR22klO2g+2qxnDn7zedpJJVEUqzrIeGY=;
        b=PNR0mgklhTuKfHtJHIXvgh0nKlvS1XNOy4bKu5XVdhMMqZQKf+fontwPzNvWlqnJU3
         160wJp82lx4ZY8WvDCyXb0rkab3TFrCiu7QC/bm9ukopfFCZnxsiLmL6IHFijmPCdYXC
         09OKms2eZbum4phKV7AZJiohnT7qkE9hejjAmiO0crRwKJo2C+I6GFK5CHtBT7JPDWb5
         TY5Dd6bUbWQBOKex+EH/0/zFueZCrbt0dYrLaVnCg1zZzZjLd59AB1R8Xf31KlzNvYie
         ZC7h4xGekQAlb/6Pue4gXHwZZwEAEmkRtsXZZt5yqmTRIhvkvWJArEaTRvi+rDhYyFLh
         71Ew==
X-Forwarded-Encrypted: i=1; AJvYcCXOsy3c/EdOT42dKiAXwn0/uZY59Hz6SzFq3QvjVMjTzIB0TQ/5JTTXGiOKU9vrZxGjfUw8UzL1ahVHqTRL0QjOshMuW5tW0ZO15stL
X-Gm-Message-State: AOJu0YxQWMpi3bynT6T/2nmHbynldYaZpF4QgeSYSg7jGWX++nM4XD6S
	1O28BlTb6Tj97swZzT2mY4AVSw6AsPmgkTTYD9yNgqCgSXUcpEmjQPmHBX7zXqs=
X-Google-Smtp-Source: AGHT+IGdZ9rws4GdM8SkTmW55HmU3KkZji+5J9etE7Vjg5UV/L+knVs1Dc9ulbn1Et86Fu/3Q6RnMA==
X-Received: by 2002:a17:903:234b:b0:201:df0b:2b5d with SMTP id d9443c01a7336-201df0b2f82mr5404845ad.64.1723629052914;
        Wed, 14 Aug 2024 02:50:52 -0700 (PDT)
Received: from C02F52LSML85.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201e24b6a77sm3487765ad.92.2024.08.14.02.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 02:50:52 -0700 (PDT)
From: Feng zhou <zhoufeng.zf@bytedance.com>
To: martin.lau@linux.dev,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	yangzhenze@bytedance.com,
	wangdongdong.6@bytedance.com,
	zhoufeng.zf@bytedance.com
Subject: [PATCH] bpf: cg_skb add get classid helper
Date: Wed, 14 Aug 2024 17:50:38 +0800
Message-Id: <20240814095038.64523-1-zhoufeng.zf@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Feng Zhou <zhoufeng.zf@bytedance.com>

At cg_skb hook point, can get classid for v1 or v2, allowing
users to do more functions such as acl.

Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
---
 net/core/filter.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 78a6f746ea0b..d69ba589882f 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -8111,6 +8111,12 @@ cg_skb_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_get_listener_sock_proto;
 	case BPF_FUNC_skb_ecn_set_ce:
 		return &bpf_skb_ecn_set_ce_proto;
+	case BPF_FUNC_get_cgroup_classid:
+		return &bpf_get_cgroup_classid_proto;
+#endif
+#ifdef CONFIG_CGROUP_NET_CLASSID
+	case BPF_FUNC_skb_cgroup_classid:
+		return &bpf_skb_cgroup_classid_proto;
 #endif
 	default:
 		return sk_filter_func_proto(func_id, prog);
-- 
2.30.2


