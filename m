Return-Path: <linux-kernel+bounces-515466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44737A3652A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 19:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DD7C3AA424
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 18:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68AFB2686B4;
	Fri, 14 Feb 2025 18:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FvV47Q/t"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC0B186E54
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 18:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739556148; cv=none; b=ZZ2lGNpMcZBW40XpmakIqtJs1moVVga83Y3s3ZSMLyMSeODM82ROl9JcyncbnA00BJxceB8BIsD5nOXtJz44iu2ZVFdVLqDG5qOG48dr6zX96zSa4hXao1s43nMOdjfct2aLSywgnrHXXK6twVSF/LOx73NXJlKB9L5g4HJIqCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739556148; c=relaxed/simple;
	bh=etqL7V7nrXBSQqvhsurbEg8PBIPMtF+lODvRJts82Qk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GHF1GiJOqhFm4vayjGhpODvqi4tRmjTcl6TWPgQFk+7jY5UFzxqeneb5XepZg3WUJyihrOXyFTfHAhPPbuiYLfIHlEhj5nQ8xg1YxL/R14KzAcP0mme1/UrRR75AC9+OG6vzVUa20poJmEPbb97MM8vjEBqcQAM4sQH6oNQB6+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FvV47Q/t; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21f78b1fb7dso41739045ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 10:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739556147; x=1740160947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nBQH5VHol9Sdy2GzM8vx3OvDWRGPw+FY6f/YuiHtKWE=;
        b=FvV47Q/thv3z/PaCAIg9WUkJS8rTUZ+h2v3evhpkO85x3rNgrWKfB2OLvIUnuvvd9b
         ch/YK+NmNzIQHoy06sNxPlOho6lCRovaplGoedF2phcG2diwnX4rShMiDZPcgllxIhOE
         Oqa8ElSb+P1/JwPEc//LonKAjnI7f18x67DnwJcDpoTemIPv903DsT9j34Yi1Okujib7
         4B/BPJn3Ett+PtutJ07adhd54ZvTL65ftW3Ze9yNofgc7iLFyu9hoyw8Tf2m2f5stQ5i
         dpCeoFDP2yEu7C5RUHdRhBJnwzkKXEgkGmVlBbwClqKBEXkE7rDfWHddBS0dPYhiZk0T
         TlOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739556147; x=1740160947;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nBQH5VHol9Sdy2GzM8vx3OvDWRGPw+FY6f/YuiHtKWE=;
        b=FNW7dtFSaO/zsMtx45BDOcH7BcKoEIhQR2vWGMnSsfwCH6i8R3fmNW4t8JrIZH4TYL
         gKsWUz8N9iH2tnzrwwboGByr0BY/VQCshSq5SccKu1lsi8jTxZZzGQE+lBQRDpOgVT+t
         fRPtYiv0FlDslO+BnedHp3ucdF1VRLeGmQ7aOi0XuV7QD2DC/k2sY6uKo97kiE8f/wqZ
         y07xlEQI6paFvB8PYy3vFlUvg2xme0zADKC7KoKobHJirpTyXbUy4KFNxt7tusTHlgfz
         DSgvQiwASaBvTXHT3YvgppSdjxATap5/bXGoQqbVy7kZ1sSPmwv5G5MtO5TaSi9+Jzzr
         sffQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJZaZGflFutEDKY4p2m1ZNmSBl+CDvoqWiImTkG+WTAwF35rf9rygftFoZor/G2dwiNsgi1J3ZWFZczDI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye6cY0+I7w8AzsVptqf6vswDEgCCYym9LcpuU5VUaBjjVANqRF
	2RiwI1rjgpPFcyswwwvkx0W6ltfCdFBhCmi8oiEOokexmEUOYh62EtxZiCrI
X-Gm-Gg: ASbGncsiBvtpNgdBT9le29AhwsO6wIjTzqAM1/XhDiAWsc5Rhpv12GfSZQy2VuMNVwr
	fpiYAb+GJAUW4ufcrypw4AqCstbmlsenHKdBNVFndls0NB76UEmq5Hfmi49CJ9VQ4C8MyZKxH84
	DnAogboe0KvrlRkFaP7QiUhEnC0lu1WkoDU0016jC8eV1tM5LA0HuH9xeUYJZqP3vGJ3LvasrTN
	TLo7sKq2bVE2/MAQtOtyzYA9yk+e0osIYteSYhAysl8IOAwLQVRLR3IQfuv4HMWLsPSQObe8uvz
	R8l/QOeANomYHyDqRyMPCLTdV3f49dUjUMAijs8Id+PU
X-Google-Smtp-Source: AGHT+IEcGatS8pZQbY70jYbOTPwZaM1+8LGbomVwjepju1SgOpwsjAln6GB7YoY92sOxZ2TKDIfUXA==
X-Received: by 2002:a17:903:440d:b0:220:d272:5343 with SMTP id d9443c01a7336-22104062cc8mr2446735ad.27.1739556146523;
        Fri, 14 Feb 2025 10:02:26 -0800 (PST)
Received: from localhost.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5591e97sm31514855ad.244.2025.02.14.10.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 10:02:26 -0800 (PST)
From: Jeongjun Park <aha310510@gmail.com>
To: akpm@linux-foundation.org
Cc: Liam.Howlett@Oracle.com,
	brauner@kernel.org,
	lorenzo.stoakes@oracle.com,
	willy@infradead.org,
	davidlohr.bueso@hp.com,
	linux-kernel@vger.kernel.org,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH] ipc: fix to protect IPCS lookups using RCU instead of semaphore
Date: Sat, 15 Feb 2025 03:01:57 +0900
Message-ID: <20250214180157.10288-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In shm_destroy_orphaned(), we are not performing updates to the IPCS and are
only calling idr_for_each(), which can be protected by the RCU read-critical
section.

And if idr_for_each() is not protected by the RCU read-critical section,
then when radix_tree_node_free() is called to free the struct radix_tree_node
through call_rcu(), the node will be freed immediately, and when reading the
next node in radix_tree_for_each_slot(), the memory that has already been
freed may be read. 

Therefore, I think it is appropriate to use RCU instead of semaphore to
protect it.

Fixes: d9a605e40b13 ("ipc: rename ids->rw_mutex")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 ipc/shm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ipc/shm.c b/ipc/shm.c
index 99564c870084..8fd87c4e5dc8 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -430,10 +430,10 @@ static int shm_try_destroy_orphaned(int id, void *p, void *data)
 
 void shm_destroy_orphaned(struct ipc_namespace *ns)
 {
-	down_write(&shm_ids(ns).rwsem);
+	rcu_read_lock();
 	if (shm_ids(ns).in_use)
 		idr_for_each(&shm_ids(ns).ipcs_idr, &shm_try_destroy_orphaned, ns);
-	up_write(&shm_ids(ns).rwsem);
+	rcu_read_unlock();
 }
 
 /* Locking assumes this will only be called with task == current */
--

