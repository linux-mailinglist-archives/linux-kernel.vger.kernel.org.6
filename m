Return-Path: <linux-kernel+bounces-547172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A19A503C8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 16:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24BBF7A4538
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1232A1F9421;
	Wed,  5 Mar 2025 15:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5QY+apx"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD24024BBE1
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 15:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741189724; cv=none; b=bfI8yJNO4uwhozWukIN6m98PviwlS5EaU/SOVA7GKE7iy67Yyuvk+8dtRqW1x96ZP1kzD8nUUlD09S1EzyiPxYIlH9ByP/rQ2kyhQAkVCh7FH3yuIedL8qVukpPoykE8Q3Jt75sj+jURCQY/6GvZFSKseuIl9qdVF39cjyQkYm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741189724; c=relaxed/simple;
	bh=RiQuT39ZKod4vG03bKElx/YCf/LIBVAgK5U4ZfjxBcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bOpUGaqyFssDJdIXFd66ZBSUEagy2oMM15Z7AbAiF+3qHG5eXADziAn4ADc8JFjCT7pNmR9yFVn2gblNbJnQBO1tW+oLacoVwBfrShaM5KEjKhCJt/b9Bmdb4gIDi6HdDx6roQtct1RAPNMRqAsi2AMfnoEfdIZiFO4UJY9EgpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L5QY+apx; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e5491eb379so6008410a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 07:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741189721; x=1741794521; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MxiIjUA9OimPTk2Pkq/BKPlzHOLC6slmzK7kgIiusZE=;
        b=L5QY+apxZI9gO0gn3faW7lCUw49LZ053bxbG898tKeKC961pyamXvfbDlW+eNdYIPl
         iLyYh/W7GxImWaxRswqM/xjb34zXPTZGMPlmK4t5UrLTYlLUy24x9YYbueE8Vn7loYgt
         uj2j+Npg06X2qR0oivOaK780vLyZWhkzdOnxOAqjUr4OL3htWqWFUJ7rkwBEnrDSuFdw
         efv1+KyACVKyk3ywsuimKOO/4SyVRh9vRg96X/mVuZcLuL/JeC7Vzf4HnYlsjJwMRJ2M
         Wi/tf6Vfl8fQKDbAHeqou2cKidAP4NXEFZlXp0VxEXIZzop7x39m7TxUpXJQO+poHMvn
         hlug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741189721; x=1741794521;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MxiIjUA9OimPTk2Pkq/BKPlzHOLC6slmzK7kgIiusZE=;
        b=RnV/86IooOVzu0T9Rg8YY9ywcy8yJ21WzAXCgni7TNL1JC2ujjhxHRT4l17royxhPM
         b+DSHev7WY+Dx0ukp/3mjbe9iMrwM2g1UcL4IgfQCffS76ej8ZVp5SEbPLygi4cpu6Rh
         CvlHBiiwQ0DSgs7cDP+s5CdDjP6Yz9bNOZQNxPiBV40mnYV9caBuMMMpR46qR0n6b57k
         VahN09cswdnzllQD1D9yd0qdXFw8Zcs/6LWkOOg0ugXwMjPRtkpZm9haPUy7x0Qe+6zS
         orpccrhPW0t72FbA3pub17NawDRSRu2zLEjICofNnoE1SbyNTNwa3ds9bRAFbIV11bpQ
         OTaA==
X-Forwarded-Encrypted: i=1; AJvYcCUPYsjIqntOBDZaYmTRYI8AeuBhhVyBv4d27V1fZKwY6zoEDALTYLOUMF10G/5oAl3xq/eCiHiixvg4nZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPNV+M7Jr7HCKQubjjnvyhxXSe/xFttO3o6tePYm3Xgiyd6wcP
	vPLxRghyte1WdddQJ0DFIr3X1+xJoOoHs/mt+jOkEfgRU9TNGemS
X-Gm-Gg: ASbGncspX6K8WXhTzMXDOVrO+ynhDF3rcZjCQ2ILVXz0DeaADT2yRsXVjUx6eSEo3Zv
	ZVbk7ItIXa5C0NB3rgKjeBrMGIazceHdtkzuWRFn9OvUzcx3Llr6iY8g6jlekgXWK8oj1QIE74n
	xHonBQTM+pJsVebYvjPqW4V5rxnUVUq1NnabIedbDMSIPonGuJZvLVn/HHjZeJZoTLe9Yhab7DB
	W8LDzCuXG5Qw5HdCw6FpHaxZT44SaOM+OdFa/9DoEs0u9jYpMckx6tPxI6JUSDvP54WDMuKDtKF
	zmBy5Qtr8Gu7b/pXxhVnNtWvDIhccMwh8vrGjVs8pflKbaa6
X-Google-Smtp-Source: AGHT+IFTpN42W5iVtwDVv9aQ5SZTvzIdHD7UXJOGvGkpahPYVyoEEkyG4ojm5UJN8gosd1EHejJvPQ==
X-Received: by 2002:a17:906:7315:b0:ac1:dfab:d38e with SMTP id a640c23a62f3a-ac20d8bc960mr378119766b.15.1741189720516;
        Wed, 05 Mar 2025 07:48:40 -0800 (PST)
Received: from localhost ([2a02:587:860f:c4f3:54ce:f1b0:3c3b:52dd])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-abf64165f73sm684611466b.152.2025.03.05.07.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 07:48:40 -0800 (PST)
Date: Wed, 5 Mar 2025 17:48:39 +0200
From: Lilith Gkini <lilithpgkini@gmail.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, harry.yoo@oracle.com
Subject: [PATCH] slub: Adds a way to handle freelist cycle in on_freelist()
Message-ID: <Z8hyV4sROVDtwRDE@Arch>
References: <Z8Sc4DEIVs-lDV1J@Arch>
 <b951acd4-5510-4d03-8f1e-accf38d909b6@suse.cz>
 <Z8XbomV9WCabATIM@Arch>
 <8cabcf70-d887-471d-9277-ef29aca1216b@suse.cz>
 <Z8a4r2mnIzTD2cZa@Arch>
 <714d353a-49c8-4cbd-88d6-e24ae8f78aaa@suse.cz>
 <Z8benEHigCNjqqQp@Arch>
 <c736fbe1-f3f4-49a0-b230-41f9da545fad@suse.cz>
 <Z8bvfiyLelfXskNw@Arch>
 <c99235b8-3859-42dc-988b-250b3f042d00@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c99235b8-3859-42dc-988b-250b3f042d00@suse.cz>

The on_freelist() doesn't have a way to handle the edgecase of having a
full freelist that doesn't end in NULL and instead has another valid
pointer in the slab as a result of a Use-After-Free or anything similar.

This case won't get caught by check_valid_pointer() and it will result in
nr incrementing to `slab->objects + 1`, corrupting the slab->inuse entry
later in the code by setting it to -1.

The Patch adds an if check to detect that case, notifies us and handles
the freelist and slab appropriately, as is the standard process in these
situations.

Furthermore the Patch changes the return type of the function from
int to bool as per codying style guidelines.

It also moves the `break;` line inside the `if (object) {` to make it more
obvious that the code breaks the while loop in that branch.

Signed-off-by: Lilith Persefoni Gkini <lilithgkini@proton.me>
---
 mm/slub.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 1f50129dcfb3..95e54ffd5330 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1427,7 +1427,7 @@ static int check_slab(struct kmem_cache *s, struct slab *slab)
  * Determine if a certain object in a slab is on the freelist. Must hold the
  * slab lock to guarantee that the chains are in a consistent state.
  */
-static int on_freelist(struct kmem_cache *s, struct slab *slab, void *search)
+static bool on_freelist(struct kmem_cache *s, struct slab *slab, void *search)
 {
 	int nr = 0;
 	void *fp;
@@ -1437,26 +1437,34 @@ static int on_freelist(struct kmem_cache *s, struct slab *slab, void *search)
 	fp = slab->freelist;
 	while (fp && nr <= slab->objects) {
 		if (fp == search)
-			return 1;
+			return true;
 		if (!check_valid_pointer(s, slab, fp)) {
 			if (object) {
 				object_err(s, slab, object,
 					"Freechain corrupt");
 				set_freepointer(s, object, NULL);
+				break;
 			} else {
 				slab_err(s, slab, "Freepointer corrupt");
 				slab->freelist = NULL;
 				slab->inuse = slab->objects;
 				slab_fix(s, "Freelist cleared");
-				return 0;
+				return false;
 			}
-			break;
 		}
 		object = fp;
 		fp = get_freepointer(s, object);
 		nr++;
 	}
 
+	if (nr > slab->objects) {
+		slab_err(s, slab, "Freelist cycle detected");
+		slab->freelist = NULL;
+		slab->inuse = slab->objects;
+		slab_fix(s, "Freelist cleared");
+		return false;
+	}
+
 	max_objects = order_objects(slab_order(slab), s->size);
 	if (max_objects > MAX_OBJS_PER_PAGE)
 		max_objects = MAX_OBJS_PER_PAGE;
-- 
2.48.1


