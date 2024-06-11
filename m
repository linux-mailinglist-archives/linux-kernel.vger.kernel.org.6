Return-Path: <linux-kernel+bounces-209195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0A5902E8D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 04:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 159761F23580
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 02:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD3F16F912;
	Tue, 11 Jun 2024 02:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mh8MjxvG"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335A416F85D
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 02:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718073924; cv=none; b=TkbTsbh73mR30XIg35zMow506ZOD044MBJWKYn7p0vdhYS1ZMlzPOqDVu17Ohv8NZez75svWbzeSa1lwwTxKDxn4jB2VpWNG9iE7KfnbkcBDQ5FvnkbWua+wOcRF8zRigKTjDVi0o261gPypWkpKzRPl9fkmqBm6eJsa2P3izfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718073924; c=relaxed/simple;
	bh=s1lLl3668ohS/zArb10DiTjhPJcDIyj3wMOKa5jJbp8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AB9K02Rf6ff8DL4h5AWhEaMtovS0BN7V0uPWFn7SLIl7hB2DMX2xkeJMzOEbXVJcplkSRHi/EK36oXQ1NYoDmJJ/4Vv6DhNb0mKNxs5Fs9d3mZ+aR/rE25pOA9sopscjxWL5mWQB6sYkQ11AuNNhalcYVB5OJOm2KO7+XoU7Zfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mh8MjxvG; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-627f43bec13so12806307b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 19:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718073922; x=1718678722; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DJ8+7Sej2fxglO9eGa2Al3jrHJVakXZUpIE0ICxQvWE=;
        b=Mh8MjxvGaD2AAiBhlvp58+JW6/PMg1Y4p02sIcju/q8N1gCtJXvUXAokt3XzombDn3
         6IGBClyzpy7a1WI01vvIYX9l/FTK6HBjUP4spMnr7Mexf7fjOaDSyPJIaNF1022Gieap
         DUfOrPVdvju/XJw4juEmTCcVysK7A3636NchWIibOaLMafvwvptb/Db8vcPdMwCIRTRo
         mZbgF0OQ7iiF8ejvtov8RU6CKRrLc8LPugb5wPvzetLO0A+QWYR0Wm/epzRIbSqPeoa+
         4X5w8mjW7MZyej/Eu+6jJhuJAmGy1OXa5OC2rFSs+gC8PUlmhsoaALs5OaISa7Gysoej
         DYRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718073922; x=1718678722;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DJ8+7Sej2fxglO9eGa2Al3jrHJVakXZUpIE0ICxQvWE=;
        b=P1DwznxK4Dp5m75pQ0RpsHFk5t0U/e+nkkjGgeZSOtJcRLz00ZA8D3VHNqbAMWnTjm
         0OhzyUnGfHAR8iYUO8+/6MW4KIcBu725JNPt8B3Vkbn0ZOBV/ES0vpmEx+o+1ss2LMK3
         OLTTUiahXh45yfvMIQ62MyBGDT3dT3yGa2y3Gd3pamnBRBjd7rgT6iHS6cRmC1Akj50C
         HX1vsHMHlEWJNXWNYTdmwlpeH/KZUlljFYmi+XiNmS5mb+E5yi10cKnOMWCvYudC0vSq
         IKS2P9+Ky/oWctsVA6lxI0jXOoJ0dinXh7UP+r0R9O7Tdk/QgNVfCy1iJoMBjYNZKHQG
         TjVA==
X-Forwarded-Encrypted: i=1; AJvYcCXebfUxR1QyjQje2Qb/isQYoGNTslG470ne7QGEhL5yhP1N6JaahnktJhtRybrD3SoBj5858aL/atFKehuZ6TfuL2KSJKOOD6KQNZ3B
X-Gm-Message-State: AOJu0Yy5isUDW+BrL+oI2VW3iex7+xKLNj7OwcRmXgDRWUqUcRDSmlwl
	e/YUCuYLkMCD3E3PhPaZ5UIyquoyf8NEUvBF9Zy10JMKyT8G6RB47Hnp0j1nxBWMK8KC1f7pIYt
	drIsrQWhqNfG+g+iJIQ==
X-Google-Smtp-Source: AGHT+IHtYmI8LX2B/xV/AC9td52B03t1CfMg6KtVozISqQ0BN5dfCT/e0kwwihIlshNhQ0RkMgS6l3jwEeA+wlLO
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:690c:10:b0:61d:4701:5e66 with SMTP
 id 00721157ae682-62cd5570599mr43233527b3.2.1718073922123; Mon, 10 Jun 2024
 19:45:22 -0700 (PDT)
Date: Tue, 11 Jun 2024 02:45:16 +0000
In-Reply-To: <20240611024516.1375191-1-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240611024516.1375191-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <20240611024516.1375191-3-yosryahmed@google.com>
Subject: [PATCH v3 3/3] mm: zswap: handle incorrect attempts to load large folios
From: Yosry Ahmed <yosryahmed@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Barry Song <21cnbao@gmail.com>, 
	Chris Li <chrisl@kernel.org>, David Hildenbrand <david@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"

Zswap does not support storing or loading large folios. Until proper
support is added, attempts to load large folios from zswap are a bug.

For example, if a swapin fault observes that contiguous PTEs are
pointing to contiguous swap entries and tries to swap them in as a large
folio, swap_read_folio() will pass in a large folio to zswap_load(), but
zswap_load() will only effectively load the first page in the folio. If
the first page is not in zswap, the folio will be read from disk, even
though other pages may be in zswap.

In both cases, this will lead to silent data corruption. Proper support
needs to be added before large folio swapins and zswap can work
together.

Looking at callers of swap_read_folio(), it seems like they are either
allocated from __read_swap_cache_async() or do_swap_page() in the
SWP_SYNCHRONOUS_IO path. Both of which allocate order-0 folios, so
everything is fine for now.

However, there is ongoing work to add to support large folio swapins
[1]. To make sure new development does not break zswap (or get broken by
zswap), add minimal handling of incorrect loads of large folios to
zswap.

First, move the call folio_mark_uptodate() inside zswap_load().

If a large folio load is attempted, and zswap was ever enabled on the
system, return 'true' without calling folio_mark_uptodate(). This will
prevent the folio from being read from disk, and will emit an IO error
because the folio is not uptodate (e.g. do_swap_fault() will return
VM_FAULT_SIGBUS). It may not be reliable recovery in all cases, but it
is better than nothing.

This was tested by hacking the allocation in __read_swap_cache_async()
to use order 2 and __GFP_COMP.

In the future, to handle this correctly, the swapin code should:
(a) Fallback to order-0 swapins if zswap was ever used on the machine,
because compressed pages remain in zswap after it is disabled.
(b) Add proper support to swapin large folios from zswap (fully or
partially).

Probably start with (a) then followup with (b).

[1]https://lore.kernel.org/linux-mm/20240304081348.197341-6-21cnbao@gmail.com/

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 mm/page_io.c |  1 -
 mm/zswap.c   | 12 ++++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/mm/page_io.c b/mm/page_io.c
index f1a9cfab6e748..8f441dd8e109f 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -517,7 +517,6 @@ void swap_read_folio(struct folio *folio, struct swap_iocb **plug)
 	delayacct_swapin_start();
 
 	if (zswap_load(folio)) {
-		folio_mark_uptodate(folio);
 		folio_unlock(folio);
 	} else if (data_race(sis->flags & SWP_FS_OPS)) {
 		swap_read_folio_fs(folio, plug);
diff --git a/mm/zswap.c b/mm/zswap.c
index 7fcd751e847d6..505f4b9812891 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1566,6 +1566,17 @@ bool zswap_load(struct folio *folio)
 	if (zswap_never_enabled())
 		return false;
 
+	/*
+	 * Large folios should not be swapped in while zswap is being used, as
+	 * they are not properly handled. Zswap does not properly load large
+	 * folios, and a large folio may only be partially in zswap.
+	 *
+	 * Return true without marking the folio uptodate so that an IO error is
+	 * emitted (e.g. do_swap_page() will sigbus).
+	 */
+	if (WARN_ON_ONCE(folio_test_large(folio)))
+		return true;
+
 	/*
 	 * When reading into the swapcache, invalidate our entry. The
 	 * swapcache can be the authoritative owner of the page and
@@ -1600,6 +1611,7 @@ bool zswap_load(struct folio *folio)
 		folio_mark_dirty(folio);
 	}
 
+	folio_mark_uptodate(folio);
 	return true;
 }
 
-- 
2.45.2.505.gda0bf45e8d-goog


