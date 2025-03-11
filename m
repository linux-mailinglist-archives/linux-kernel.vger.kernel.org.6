Return-Path: <linux-kernel+bounces-555307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B553DA5B557
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 01:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA5431659E8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 00:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5AD81DF268;
	Tue, 11 Mar 2025 00:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QtVjT8YH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5A01DEFF3
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 00:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741654094; cv=none; b=rt74Mvv4A5CWsLZxiwaTkPOv1F7vDPsg/6D0ADR86Ape/6X+ZUnPZaqScxvTm8vnwYoYW1COn8NcoC/0IysPNJJ8HCSUq58pAg/sG6wvu7DNXZBMdNKkv74yA45oIe9TULwzuiqHCrdIjqIOHktQjPdJ1pMi91ST2MWSW33ilX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741654094; c=relaxed/simple;
	bh=5YZNUGJCJYr7l4LPbz+b90tbdzv/yRHsXo30mMOf/jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BIH5vGIXEvDNXkoNe522gB7NbGgNe0PsAX+EtCA6/gklRZ1q11hh5hmW6vEaIqFfv6na4B2zxY4eLLR97lZrkBS6hvzjhVHu3IzslzuQZlmgfX3Q56H0Eqxkbh0GXxmbaD9D8V+t5cve8+/1Xr4BsS9pjEVcjYOAedgRAPGDFSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QtVjT8YH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741654092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eE53Ah3+LX+rmJRq+jfZ6lpqQieXXNgXZwY62OeKfdE=;
	b=QtVjT8YHiNv/Xo5x3AFFGrwEEhYuA0uNO8WlLvBGAIC8oEtHuIph0SuL7e6hA7ugyUpKAr
	v43P05gpQ3vhxxLV7K92Xhr5cy+eLiBfdWkzaJ33eEWS4raVjMn0Axl5GdSJCdL3C+8stu
	xP4HChrqCnL11PANNVNF15KZT8ZJUPA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-362--IaUVPyZNbqlfswGgtIVzQ-1; Mon,
 10 Mar 2025 20:48:08 -0400
X-MC-Unique: -IaUVPyZNbqlfswGgtIVzQ-1
X-Mimecast-MFC-AGG-ID: -IaUVPyZNbqlfswGgtIVzQ_1741654087
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0B9ED180AF53;
	Tue, 11 Mar 2025 00:48:07 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.remote.csb (unknown [10.64.136.79])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8DA511800373;
	Tue, 11 Mar 2025 00:48:01 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	david@redhat.com,
	osalvador@suse.de,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	akpm@linux-foundation.org,
	shan.gavin@gmail.com
Subject: [PATCH v2 3/3] drivers/base/memory: Correct the field name in the header
Date: Tue, 11 Mar 2025 10:46:57 +1000
Message-ID: <20250311004657.82985-4-gshan@redhat.com>
In-Reply-To: <20250311004657.82985-1-gshan@redhat.com>
References: <20250311004657.82985-1-gshan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Replace @blocks with @memory_blocks to match with the definition
of struct memory_group.

Signed-off-by: Gavin Shan <gshan@redhat.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 include/linux/memory.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/memory.h b/include/linux/memory.h
index c0afee5d126e..12daa6ec7d09 100644
--- a/include/linux/memory.h
+++ b/include/linux/memory.h
@@ -25,7 +25,7 @@
 /**
  * struct memory_group - a logical group of memory blocks
  * @nid: The node id for all memory blocks inside the memory group.
- * @blocks: List of all memory blocks belonging to this memory group.
+ * @memory_blocks: List of all memory blocks belonging to this memory group.
  * @present_kernel_pages: Present (online) memory outside ZONE_MOVABLE of this
  *			  memory group.
  * @present_movable_pages: Present (online) memory in ZONE_MOVABLE of this
-- 
2.48.1


