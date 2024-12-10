Return-Path: <linux-kernel+bounces-440333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6ED69EBBE8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 22:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C9F7188A582
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 21:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2AD2343CB;
	Tue, 10 Dec 2024 21:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bRCn6R6u"
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6CB23237E
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 21:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733866265; cv=none; b=CNnF3trlOwQGvwPPCc5gzH8d37ICr3jhsz53iNVVML5KSC+04JLpmZcfEo/o0XzXkZ7QTBSJwfGIJJAHF2iOaLU+oYmS7p4NgeUFuBOIk2zuPDnzG/+o4/fWGwKGik2jDRHgej6Gg/TZe/2nbwj0zLGR3YXjDyK7/rUF3exVO2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733866265; c=relaxed/simple;
	bh=7BtEdFWcYLngsq2PQODOD5BiLZOIKMRwRSUO9nBBYBg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=E2r1wu2lFiGHM25xP0NIyntmyTdxirYjZOcL80FJZHfDF28Kus1lnKuKj05Z8jZvJe94cFjzJLu1MntBCRcdcFcjE779co7qr1KQ7M/z/a0pDwgiaMmV06oPaP1JSdDA2LxlH5TDQULeH8pka1WQj1OhHbj2iiohR0RspgViOiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bgeffon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bRCn6R6u; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bgeffon.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-467518d8bdaso80023251cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 13:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733866263; x=1734471063; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8zF6cyo4V+yV1OddWsDU7llWFhEXM57i4QvxWba9u5g=;
        b=bRCn6R6u52WUg6LH0+J3obvVxCFUwN94ruyntEcF1gDkU5mD1jv1g/ReJbUzXuZlU6
         HwD0QM79MojHI8TkJlYlT/gItF8nvnpGdVPb/KKPXUdilblmRJJASv9hX0rlrXXzbxlH
         QyOxwNa/cV5fd8o++YK/0mGN+qnV5Xe780uu9F9QoLw5/k8QmBh/KsaiOTkdofxO0rOC
         YHTpBPcn5zigw/oAHoRP37NX0uNMu4qrADEb70B6IGq6qASldJ8hcE7XiBxj72owEBxZ
         7BR1V/3EOTJF2Xz7ZX+P3HpC6A6GDQu5Vo8MdoLjnhh90WsAhYxeuseagSjlIk2pI/bt
         MPsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733866263; x=1734471063;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8zF6cyo4V+yV1OddWsDU7llWFhEXM57i4QvxWba9u5g=;
        b=XkPp1sNlA1bourdTr21vs6Uj7jGzZ+owfOy3eaMvk+lEc7MMbRO4EB2peIs0xNB2zl
         Cd/wgVgxxeq8xlKafjpylocBnpNnPCss7dXbzTyTeSWDPABr7kFr1MG09DKbX51LiNmh
         iHUmSA5aHjaqr8eDAMFsM5GUlUihGv96H+Nd9L1zrcu3PviMhgSi0I2fQZHzeeVS/I/D
         YqLCSJ/4b9wO09fRh6KSYUaK1HC605faRNrxP28cL20St7IdT86h3EEPbhwriz5feoe4
         xu4xP0K5Lxxk98nOnbIz7sEO67/RFFphUzD5CI4J6R7cG9mIkC75MpA5pKOmXyc/1DcG
         9WSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSgNZcitSkM6KduHJ+pd18o0gRC2yl+1fxXcyCUfYJp1s3gBXTC/aFDWzMB0QuUm98QNm+zPe4lx5/MbM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw60WnZ6+JmZwCnx+D/MfURAl5AjNgmI/DVJKy7kDp9FWa39xlG
	4nmT8HSeAj+LDckQxh10jQob5B4qzZ/h/OwHhopC59uELtI8+sYIwXzEjuKYh9/uA5ILBAOt7zT
	2TDqRKA==
X-Google-Smtp-Source: AGHT+IHZ1924mCsfRh+0nxIV+XSxlFuKLxmvXW19hSqpR+438olx78Wtep6vn7HuCeERSohDHX/QpTjD62ds
X-Received: from qtbcc14.prod.google.com ([2002:a05:622a:410e:b0:467:518e:d31b])
 (user=bgeffon job=prod-delivery.src-stubby-dispatcher) by 2002:ac8:58cd:0:b0:466:a3bf:41a7
 with SMTP id d75a77b69052e-467893c594amr7220151cf.51.1733866263282; Tue, 10
 Dec 2024 13:31:03 -0800 (PST)
Date: Tue, 10 Dec 2024 16:30:49 -0500
In-Reply-To: <20241210213050.2839638-1-bgeffon@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241210213050.2839638-1-bgeffon@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241210213050.2839638-5-bgeffon@google.com>
Subject: [RFC PATCH 4/5] selftests: mm: Add a new MREMAP_DONTUNMAP self test
From: Brian Geffon <bgeffon@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Jann Horn <jannh@google.com>, 
	Vlastimil Babka <vbabka@suse.cz>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org, 
	Marco Vanotti <mvanotti@google.com>, linux-kernel@vger.kernel.org, 
	Brian Geffon <bgeffon@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a new selftest which validates that a new_addr as a hint behaves
in the same way as mmap.

Signed-off-by: Brian Geffon <bgeffon@google.com>
---
 tools/testing/selftests/mm/mremap_dontunmap.c | 41 ++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/mremap_dontunmap.c b/tools/testing/selftests/mm/mremap_dontunmap.c
index 1d75084b9ca5..ccce97c68019 100644
--- a/tools/testing/selftests/mm/mremap_dontunmap.c
+++ b/tools/testing/selftests/mm/mremap_dontunmap.c
@@ -224,6 +224,44 @@ static void mremap_dontunmap_simple_fixed()
 	ksft_test_result_pass("%s\n", __func__);
 }
 
+// This test validates MREMAP_DONTUNMAP using a newaddr hint without
+// MREMAP_FIXED.
+static void mremap_dontunmap_simple_newaddr_hint()
+{
+	unsigned long num_pages = 5;
+
+	// This dest hint is intentionally not aligned.
+	void *new_addr_hint = (void*)0x999900010;
+
+	void *source_mapping =
+	    mmap(NULL, num_pages * page_size, PROT_READ | PROT_WRITE,
+		 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	BUG_ON(source_mapping == MAP_FAILED, "mmap");
+	memset(source_mapping, 'a', num_pages * page_size);
+
+	void *remapped_mapping =
+	    mremap(source_mapping, num_pages * page_size, num_pages * page_size,
+		   MREMAP_DONTUNMAP | MREMAP_MAYMOVE,
+		   new_addr_hint);
+	BUG_ON(remapped_mapping == MAP_FAILED, "mremap");
+
+	// And the source mapping will have had its ptes dropped.
+	BUG_ON(check_region_contains_byte
+	       (source_mapping, num_pages * page_size, 0) != 0,
+	       "source should have no ptes");
+
+	// And the remapped area will be filled with 'a's.
+	BUG_ON(check_region_contains_byte
+	       (remapped_mapping, num_pages * page_size, 'a') != 0,
+	       "dest should have remapped content");
+
+	BUG_ON(munmap(source_mapping, num_pages * page_size) == -1,
+	       "unable to unmap source mapping");
+	BUG_ON(munmap(remapped_mapping, num_pages * page_size) == -1,
+	       "unable to unmap source mapping");
+	ksft_test_result_pass("%s\n", __func__);
+}
+
 // This test validates that we can MREMAP_DONTUNMAP for a portion of an
 // existing mapping.
 static void mremap_dontunmap_partial_mapping()
@@ -348,7 +386,7 @@ int main(void)
 		ksft_finished();
 	}
 
-	ksft_set_plan(5);
+	ksft_set_plan(6);
 
 	// Keep a page sized buffer around for when we need it.
 	page_buffer =
@@ -359,6 +397,7 @@ int main(void)
 	mremap_dontunmap_simple();
 	mremap_dontunmap_simple_shmem();
 	mremap_dontunmap_simple_fixed();
+	mremap_dontunmap_simple_newaddr_hint();
 	mremap_dontunmap_partial_mapping();
 	mremap_dontunmap_partial_mapping_overwrite();
 
-- 
2.47.0.338.g60cca15819-goog


