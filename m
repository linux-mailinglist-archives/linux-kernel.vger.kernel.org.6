Return-Path: <linux-kernel+bounces-536814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6368A48466
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAF1A7A2655
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7733B26F47C;
	Thu, 27 Feb 2025 16:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="q6rO5XKk"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DFC26F467
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 16:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740672337; cv=none; b=TQTCjt707Xmn7R2t1ULr7uGskJJ3D67eJhF/3ncSRIdarJQgDom0o9xYHeInSywolYT3P4SXgvKOjGyZtigcGjir+eP0DNrKVhHVWMLyu/OITNdGijxQUHNdHQqUvyXsYpPvvMwc03+opfhq4abi48vJpmDWYZSWRiUOCWZeJyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740672337; c=relaxed/simple;
	bh=z/iLhEGp+k1GmcTgVOCkyFDFA55wz5tgmOkF6cPbfqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mJ2+wHfdlcEXa7TbzldzNlKbWZUASZan6LkdxhJsRZfPXTSd3sBR2C6YgrHLw1G3WyNIyCD6l76wTB0O+T1ia9fo9JSqRlagVa0k9APZ86UO1MUfEqZRWnlOllDeDwRoxCy0anzxBNT8uix6oEFqOimhnjEAiXd16s9Ri8xNqnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=q6rO5XKk; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-47220d28138so15194441cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 08:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1740672333; x=1741277133; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A91udeNQ6gL/fByIkH0tlUyWahWZ0cLam9LmFQEXaw4=;
        b=q6rO5XKk5kgoVg/Pc+DVbh2xhGa9Db/UJNx++NWlzkx+xPxlk1zk4D1F3MyvNwU5iG
         txccTqZd/XSgkQ+X1tznDwcsHdIRc801VH64ibFERtqWuu4XV5M5PaybVqsRmtgwLWz3
         7USTRalEUAZCZvTCRnhMdLZbuQ1UmArj3Qb0bszx158XEVhRN2jqkylMMD2XJhNf912j
         2G5t8L6eFVNYy4QYAN2ZkHGQhwbtrd5tOYs84TXqnN0HKjrhPrfCmPxiEP5oubfKZcrY
         Nyf1R82mmMxC7Pgzk2kbPvI/IrKB9XF9H7ehlrYi8s3bcNLl9vnIwVcuv7kBDrG5nblj
         3AiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740672333; x=1741277133;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A91udeNQ6gL/fByIkH0tlUyWahWZ0cLam9LmFQEXaw4=;
        b=td/qCAIxXuzuvKa2IOUfWVGPc5OWLZjRjychWvHQvXxqHmzzGd+vIsBdOCRyf3c8wG
         Mkv4LcEQQ5VWXH2KsOzrbOoF9f6V2IagVT8X1vlgzI+4R+P+f7aaB0ZrMH10szuYMpIW
         wKiqx+zSRhqOX+DvvMwtWtXR/cgTOgsFmZ/7DcYAyCZosHdOly5d19SD+DNvT8oA6zFV
         3GdfvPa9rBTmFxihVlB/I6s9E29l4m1wo9mY/h8YCxwZuw0hiVGtM/ZtEil/Un+jcHlk
         l5rhJerEmp3qnmNHUTpjZhowdckoSegvrMJoX9c3lFNpqFCfkMxYsNHSCIK2nV1TdTMr
         V0ng==
X-Forwarded-Encrypted: i=1; AJvYcCWzEA+TzSyJ85p5w9bX3sf+HPFUL4u/9+smAk6WEDu7ux2tV3tK29yLTO2MwuNVvVK7P7LSs0bd68e2XfM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuJTKDLgLkgNym8/cjmMQQNpigptmW12BTp2u0UXnmjF3M84Vj
	4EQnGrYNkF2K89Ooakhq/BwvlHntja4u3Cnvx4N+SSRTmbZG/LaZZjUakia85/g=
X-Gm-Gg: ASbGncvDEHPZHpEnj2s6a4g8ydx8yLgSHIT4/YDKu/NpzHLhEynKZYtNWjUXhsMl92o
	eUgsqEFeclGuIOANqs6KvLNEOxsibYYPHldHh1v8zE92zIkfz3KLqt+xmO1FbW2uNRNz5dIPKAw
	a1W5oojVKaOY42qiAizagLeI8e63FA14lj/0W2ikkh9zONSzmtptc6GNuh4jrRssQdfo9V7WjFX
	sEjema0fVxfVyhd6iiYLzJA3sKSjybCJRfDEt3d6/mQXCkNQAUl8f3Ba8u6ZQv0Eeas/j1sb8n2
	VdduJmEj+1OYjCLdr05EWE4h
X-Google-Smtp-Source: AGHT+IFbywb/b1rLYc2GJKkLhDLtOWo7qWH1v8OYahONUwAh6TaO7qzdAkb93JW/B9QcW7JSKSDbAA==
X-Received: by 2002:ac8:5741:0:b0:472:5f9:1f71 with SMTP id d75a77b69052e-47377116e6dmr167915131cf.2.1740672332971;
        Thu, 27 Feb 2025 08:05:32 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4746b5eed44sm12539111cf.24.2025.02.27.08.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 08:05:32 -0800 (PST)
Date: Thu, 27 Feb 2025 11:05:28 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
	chengming.zhou@linux.dev, linux-mm@kvack.org, kernel-team@meta.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] zswap: do not crash the kernel on decompression
 failure
Message-ID: <20250227160528.GF110982@cmpxchg.org>
References: <20250227001445.1099203-1-nphamcs@gmail.com>
 <Z7-9o81kBfw4tFSz@google.com>
 <20250227043141.GB110982@cmpxchg.org>
 <Z7_7vah_U1JzmpCX@google.com>
 <20250227061616.GD110982@cmpxchg.org>
 <Z8AQPyY7Qpux0mO0@google.com>
 <Z8AUaQamubA9lWae@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8AUaQamubA9lWae@google.com>

On Thu, Feb 27, 2025 at 07:29:45AM +0000, Yosry Ahmed wrote:
> Maybe we can do something like this:
> 
> /* Returns true if the folio was in the zeromap or zswap */
> bool swap_read_folio_in_memory(struct folio *folio)
> {
> 	int ret;
> 
> 	ret = swap_read_folio_zeromap(folio);
> 	if (ret == -ENOENT)
> 		ret = zswap_load(folio);
> 
> 	if (ret == 0) {
> 		folio_mark_uptodate(folio);
> 		folio_unlock(folio);
> 		return true;
> 	} else if (ret != -ENOENT) {
> 		folio_unlock(folio);
> 		return true;
> 	} else {
> 		return false;
> 	}
> }

Eh, I think we're getting colder again.

This looks repetitive, zswap_load() is kind of awkward in that error
leg, and combining the two into one function is a bit of a stretch.

There is also something to be said about folio_mark_uptodate() and
folio_unlock() ususally being done by the backend implementation - in
what the page cache would call the "filler" method - to signal when
it's done reading, and what the outcome was.

E.g. for fs it's always in the specific ->read implementation:

static int simple_read_folio(struct file *file, struct folio *folio)
{
	folio_zero_range(folio, 0, folio_size(folio));
	flush_dcache_folio(folio);
	folio_mark_uptodate(folio);
	folio_unlock(folio);
	return 0;
}

and not in the generic manifold:

$ grep -c folio_mark_uptodate mm/filemap.c 
0

I'd actually rather push those down into zeromap and zswap as well to
follow that pattern more closely:

diff --git a/mm/page_io.c b/mm/page_io.c
index 9b983de351f9..1fb5ce1884bd 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -538,6 +538,7 @@ static bool swap_read_folio_zeromap(struct folio *folio)
 
 	folio_zero_range(folio, 0, folio_size(folio));
 	folio_mark_uptodate(folio);
+	folio_unlock(folio);
 	return true;
 }
 
@@ -635,13 +636,11 @@ void swap_read_folio(struct folio *folio, struct swap_iocb **plug)
 	}
 	delayacct_swapin_start();
 
-	if (swap_read_folio_zeromap(folio)) {
-		folio_unlock(folio);
+	if (swap_read_folio_zeromap(folio))
 		goto finish;
-	} else if (zswap_load(folio)) {
-		folio_unlock(folio);
+
+	if (zswap_load(folio) != -ENOENT)
 		goto finish;
-	}
 
 	/* We have to read from slower devices. Increase zswap protection. */
 	zswap_folio_swapin(folio);
diff --git a/mm/zswap.c b/mm/zswap.c
index 6dbf31bd2218..76b2a964b0cd 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1620,7 +1620,7 @@ bool zswap_store(struct folio *folio)
 	return ret;
 }
 
-bool zswap_load(struct folio *folio)
+int zswap_load(struct folio *folio)
 {
 	swp_entry_t swp = folio->swap;
 	pgoff_t offset = swp_offset(swp);
@@ -1631,7 +1631,7 @@ bool zswap_load(struct folio *folio)
 	VM_WARN_ON_ONCE(!folio_test_locked(folio));
 
 	if (zswap_never_enabled())
-		return false;
+		return -ENOENT;
 
 	/*
 	 * Large folios should not be swapped in while zswap is being used, as
@@ -1641,8 +1641,25 @@ bool zswap_load(struct folio *folio)
 	 * Return true without marking the folio uptodate so that an IO error is
 	 * emitted (e.g. do_swap_page() will sigbus).
 	 */
-	if (WARN_ON_ONCE(folio_test_large(folio)))
-		return true;
+	if (WARN_ON_ONCE(folio_test_large(folio))) {
+		folio_unlock(folio);
+		return -EINVAL;
+	}
+
+	entry = xa_load(tree, offset);
+	if (!entry)
+		return -ENOENT;
+
+	if (!zswap_decompress(entry, folio)) {
+		folio_unlock(folio);
+		return -EIO;
+	}
+
+	folio_mark_uptodate(folio);
+
+	count_vm_event(ZSWPIN);
+	if (entry->objcg)
+		count_objcg_events(entry->objcg, ZSWPIN, 1);
 
 	/*
 	 * When reading into the swapcache, invalidate our entry. The
@@ -1656,27 +1673,14 @@ bool zswap_load(struct folio *folio)
 	 * files, which reads into a private page and may free it if
 	 * the fault fails. We remain the primary owner of the entry.)
 	 */
-	if (swapcache)
-		entry = xa_erase(tree, offset);
-	else
-		entry = xa_load(tree, offset);
-
-	if (!entry)
-		return false;
-
-	zswap_decompress(entry, folio);
-
-	count_vm_event(ZSWPIN);
-	if (entry->objcg)
-		count_objcg_events(entry->objcg, ZSWPIN, 1);
-
 	if (swapcache) {
-		zswap_entry_free(entry);
 		folio_mark_dirty(folio);
+		xa_erase(tree, offset);
+		zswap_entry_free(entry);
 	}
 
-	folio_mark_uptodate(folio);
-	return true;
+	folio_unlock(folio);
+	return 0;
 }
 
 void zswap_invalidate(swp_entry_t swp)

