Return-Path: <linux-kernel+bounces-190868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B98B8D03AC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 16:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01A1B1F22CE0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 14:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A489A181332;
	Mon, 27 May 2024 14:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bMn+Ayea"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AD61802A1
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 14:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819319; cv=none; b=WSk61iEtp4C17mt/qz3iNynxJ3C8cfuhMs+ZaCdoIxCylfcykJMnGVMOY0ekWQX7hxFXYNvcZc8l7/E6oVhiVVjvKtIqnIfHY0xJyNT8R/G7ZdSUfVSQF++b4eHbHjezY7a/56msJHtTJe12htZMLOkHEwVEqpNj8rlYGsrdVSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819319; c=relaxed/simple;
	bh=xD3et00YAXffq85hFqADbpg70st5gD0nJKk0msmLk+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V0+h0iwHFTYE9T7r8nLzKC/2pdn54Tpt/NvuIA0yiOcaaskFo+vF1gMRD8qkAT+erMBJ1A1WsAzKugCAgUxxYudWNmN3KqD3JV2aHnLjDReYfxeAmMGRsyP+5h/IO3ERe0J2kJYnN/ppIWkrnLWak7YHswl9JVA5N5Fv37NeQTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bMn+Ayea; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716819317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1jgAtxlgpKD5tttWASyjS08Kd902IxQGps+U4uBLOWU=;
	b=bMn+AyeaD5L8WymgmUKnAleoiUSrswxSd+eJWZsVUGjGaATjYs5UyDi9x4towPopVS9cB6
	AphePwtK0+5hAqbPcS8H4OGdmXoHFQG9o0G+hrMWqbLdo9fk0bFVjPct4an0rjDiSDd8TE
	WDh9EbWztLr+Hy+A62Y5BykVUvihAlc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-PvG6X_TONr6hv4V8Z_f-EA-1; Mon, 27 May 2024 10:15:11 -0400
X-MC-Unique: PvG6X_TONr6hv4V8Z_f-EA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 641568025FC;
	Mon, 27 May 2024 14:15:11 +0000 (UTC)
Received: from t490s.redhat.com (unknown [10.39.192.209])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 89ADF1C00A8E;
	Mon, 27 May 2024 14:15:09 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: [PATCH v1 5/6] mm/filemap: reinitialize folio->_mapcount directly
Date: Mon, 27 May 2024 16:14:53 +0200
Message-ID: <20240527141454.113132-6-david@redhat.com>
In-Reply-To: <20240527141454.113132-1-david@redhat.com>
References: <20240527141454.113132-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Let's get rid of the page_mapcount_reset() call and simply reinitialize
folio->_mapcount directly.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/filemap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 382c3d06bfb1..c4ac7289e88a 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -177,7 +177,7 @@ static void filemap_unaccount_folio(struct address_space *mapping,
 				 * and we'd rather not leak it: if we're wrong,
 				 * another bad page check should catch it later.
 				 */
-				page_mapcount_reset(&folio->page);
+				atomic_set(&folio->_mapcount, -1);
 				folio_ref_sub(folio, mapcount);
 			}
 		}
-- 
2.45.1


