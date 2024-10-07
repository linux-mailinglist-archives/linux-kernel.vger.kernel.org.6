Return-Path: <linux-kernel+bounces-353877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5A49933ED
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 18:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 753BE2858A6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10671DD541;
	Mon,  7 Oct 2024 16:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xeKJzp0J";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TsI2GUa9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88A31DCB30
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 16:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728319803; cv=none; b=uDdyMMkGwKdnsp8uoGKFXyNcArOJGvpW5slDoKo7YIrfKq3znHxPzgnfauSOkyHw9Zse2yuYU005TOxL3q3WbmtHnVQ5F1oE/adBiB1qvaqQY70Gy3dPNngOLM6fjCmCswh/u9fvBrjxb/VLdN0RhkywjthGO2N2BSI+37QEz8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728319803; c=relaxed/simple;
	bh=aEu6hJ9U7PO6szkgs96fkDOHN4VNXLaykYx7x//6BQ8=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=FF83TLZXyiXJ1Zv3JZN0FHBun8T162H4bJRSTGAbPJ5KMlK4heIL3sXZlKnyKBIB9fAysoLePfvuUMYcYa5MtTxsQ2p6Nzcn5f29icTp9o4ZXs55uq3e85hwcb3I3J6m1oXp5xihv8KWXS/m4EFe0wCqmM2sujuRVTYEY9qdY54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xeKJzp0J; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TsI2GUa9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241007164913.390511021@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728319800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=ogJg4brbf+ZHDcbh3aDpvZl7gvfFvI3DSNAZrNum05Y=;
	b=xeKJzp0JjdX+cqCjLkFcbdnon6N04WRSupArA1ZolC1VlD5PD7nhT7zY2UADaObguz3KGG
	fFJdyNhRH5+tZn451ho2AfnqWCeQA0e0RZ5AiOaPaiVJhSN2tnEsrdpQBVM3OUI+m4RanO
	E/Tvf1kRR41ezIyAwsHVTSoHO9ZYa+AVRDu5yjfXXsjbGI6Luzc/mYrKM8LXW9jtrXJGjg
	MqKEPVjQOmVe8/dnQlOXuIAxySfmOvftt+eQeoFmDKMz+W/CIBdGeUtarrsVFatGmu1Vuw
	JzGcx0faD+e3sKEjh1b2MdNiJcQGdF+w41pqkQ8p5Li8qi0Kamu/B8u7OiP80A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728319800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=ogJg4brbf+ZHDcbh3aDpvZl7gvfFvI3DSNAZrNum05Y=;
	b=TsI2GUa9/51zEpBk+eorG65abOheUyI4yniE4ffXL+tEqu0LNfJedtzxDuVF9daDIZ6R1E
	83nd6TjBi48TuxAg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Zhen Lei <thunder.leizhen@huawei.com>,
 Waiman Long <longman@redhat.com>
Subject: [patch 07/25] debugobjects: Remove pointless debug printk
References: <20241007163507.647617031@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon,  7 Oct 2024 18:49:59 +0200 (CEST)

It has zero value.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 lib/debugobjects.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -1303,7 +1303,7 @@ static bool __init debug_objects_replace
 	struct debug_obj *obj, *new;
 	struct hlist_node *tmp;
 	HLIST_HEAD(objects);
-	int i, cnt = 0;
+	int i;
 
 	for (i = 0; i < ODEBUG_POOL_SIZE; i++) {
 		obj = kmem_cache_zalloc(cache, GFP_KERNEL);
@@ -1330,11 +1330,8 @@ static bool __init debug_objects_replace
 			/* copy object data */
 			*new = *obj;
 			hlist_add_head(&new->node, &db->list);
-			cnt++;
 		}
 	}
-
-	pr_debug("%d of %d active objects replaced\n", cnt, obj_pool_used);
 	return true;
 free:
 	hlist_for_each_entry_safe(obj, tmp, &objects, node) {


