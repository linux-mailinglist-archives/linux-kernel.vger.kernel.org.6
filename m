Return-Path: <linux-kernel+bounces-268067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6CA942001
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 20:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08BDFB2140D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 18:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FFB118A6DC;
	Tue, 30 Jul 2024 18:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MaVod01S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECA2189906
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 18:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722365457; cv=none; b=gbP3aUROlXZ9qgPn/j6eNUOlPOtmMd/ZJhVY0Bo6HE+x3yw8QqpyHXKWyj5w1XeO68Pp5SRUvBu9WAXu7V6/lx71/tqVj7pE/HKegm0rdLfwkCNMNWfZY4EiLV/2I6NkMXFUvMdEr02zORish+aRF5v13hApwwwM0MlAsGexqZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722365457; c=relaxed/simple;
	bh=B7lCvXux7f94TaAbBTbtx+OfILAdRrodvDeXA9EjfZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hx9bUmHW9HxXpZG3FeU/ep3F6n2nJBDrJuVmri8sniq45d5k+lI395ybNfDhubHfpAtTsv/IwOTtuMxZwtpl5ON1+QELblBFZB/hYxTAqLdOrqCUyP9AXCKRYiziLMOpePKB37ZWMioxrVHGnoSmvzJb3AYwY7G/6kDSgbroO4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MaVod01S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85885C4AF0B;
	Tue, 30 Jul 2024 18:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722365457;
	bh=B7lCvXux7f94TaAbBTbtx+OfILAdRrodvDeXA9EjfZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MaVod01SJZfxHuSLw4OhC4FdwSCUEEQ47Ao5XAdKEYBAi63urmfePKXZ23RqHviS5
	 mrhutwU2sUgZIg2tN/SyHx0zfVxqx0G4o0kof5Qe5uO8Y9sr+bI9FKnJgN7EojkVIs
	 /Hp6cFAR5/0dCpDgIQMcTtXtH2A8x8JeP8GzIdp3gayBj2E7Y1CtTRCeWMfTj4KYY9
	 aeZzPqkrdUN8Gl6j7iLrRJ7YpJmypGPJzR8cIzDmn1Kikt88N+GTzvZOIsxL7I2Aok
	 Z2gTQoXD5fAeVxahAeb/LeYpXEKxzQYOlBg4JYaa5mXN5VDaEpxETu2uNsmx/KIHfI
	 PLWrlUUOHwrNg==
From: Danilo Krummrich <dakr@kernel.org>
To: akpm@linux-foundation.org,
	urezki@gmail.com,
	hch@infradead.org,
	vbabka@suse.cz
Cc: mhocko@suse.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 1/4] mm: kvrealloc: disable KASAN when switching to vmalloc
Date: Tue, 30 Jul 2024 20:49:41 +0200
Message-ID: <20240730185049.6244-2-dakr@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730185049.6244-1-dakr@kernel.org>
References: <20240730185049.6244-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Disable KASAN accessibility checks when switching from a kmalloc buffer
to a vmalloc buffer.

Fixes: 923a26b4c679 ("mm: kvmalloc: align kvrealloc() with krealloc()")
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 mm/util.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/util.c b/mm/util.c
index 29ae93f6344f..bfb2d69b6434 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -753,7 +753,10 @@ void *kvrealloc_noprof(const void *p, size_t size, gfp_t flags)
 
 		if (p) {
 			/* We already know that `p` is not a vmalloc address. */
-			memcpy(n, p, ksize(p));
+			kasan_disable_current();
+			memcpy(n, kasan_reset_tag(p), ksize(p));
+			kasan_enable_current();
+
 			kfree(p);
 		}
 	}
-- 
2.45.2


