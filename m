Return-Path: <linux-kernel+bounces-542274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A14A4C7F7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8024E188489D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 16:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476D125DAF2;
	Mon,  3 Mar 2025 16:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cKP4i4qZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22EB257431
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 16:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019472; cv=none; b=NhmX/6y+pwLDQP8MfndGf/egQLRNpE2pStH/2UZgrjsPZ41QtWQBZLqzAqzbOOu4azuvzT9WIw3SFXIfTN2JIUVWs2KkwTJO7iAuykddq4RevC2J1SlabW/h3NIhfL/dLDiJniST8fBexvi+8aRapmbYgJIsyZaoVTBHbvErAjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019472; c=relaxed/simple;
	bh=OBXpWDsR7o4dKf8NkhRON4PwL/H6iQiwplPc25GckEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NcWF9ZFyQB5RtW6tOdnXfc9FjaBhqfZao5ulGM0aHaaoI/710o6fvTww0RQl7Ya4RIGUUmIQnFvXd/oWr0Z0MZ+dC5L6BzK5XeVaULlCUt4aT8RUZlzPEyMqE0te4sz3iutH9Nff8swzhhZUk3b6Rs/C3CNclCYVXQKYRlOlcYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cKP4i4qZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741019466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VusPlBbKEOGpL4wS1BqoWY6CYb2f4HQ+/wIDh8p+vAo=;
	b=cKP4i4qZAaPbMsxQZ1wf4q2xZu5qQz+V8Bjc8frHlO3r4raPPg0p56omcLgCjdfuW1fVGD
	CptUMqf689LiyhMuZPDK/t6bq8rnuU+4OK6SfMRhE63JJxJ+rcwgY1oRpxF8B4KEadF/1C
	iXZeXzoPKfZjm4/y6UKPYP+y4HI8tOk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-2ijQkRzXNHWsiHE96RqzLg-1; Mon, 03 Mar 2025 11:30:42 -0500
X-MC-Unique: 2ijQkRzXNHWsiHE96RqzLg-1
X-Mimecast-MFC-AGG-ID: 2ijQkRzXNHWsiHE96RqzLg_1741019441
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4399d2a1331so22758185e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 08:30:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741019441; x=1741624241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VusPlBbKEOGpL4wS1BqoWY6CYb2f4HQ+/wIDh8p+vAo=;
        b=oZRuG2Mi6Y37J0EVdffi62U492806Mp7rkZo/01h+Ux3gXGy5lrZF5GYzmHw6R1Ut+
         Io46stNLQy+Jmh7F0/4H3CAhtZy1iZVmEcGLKSqYIFTWUTiWPdy2NlFOBsw79U9nrL1S
         gCFU1bulMep0HAa0a3qpCLY6sNUj0vgxuqAQ8Nu34Oc0wEJYDyMhelOLLDugAZZxv2D4
         6HrIbgJwZ/iMfzLdmDiR/QFILamVqlaYAL0/Lw1ifWsRdhK4T+c3GkI/trIdjUygRpp8
         yCa0eRd1BrrfgqNjS0YwW9PR3wtyNp8zUCkiiCTxjmw0QdzYPmNnK+yknxre9adaJdgK
         2XCA==
X-Gm-Message-State: AOJu0YwkmJiIB8RnXsDHjC8RX1RXecGYuR/zrE8k7qHE5ldOsXlqqdkL
	Emm/LK9wIyLT6yvkPkdLC4fP2hCY2s6wTGNJ2rqF2U3FTKbT61UoQ1NJEZ3WFXlihjNgG46nFrr
	m1t//JSdNOshexFSTMHIVCOsKap7fBlsVBvE+ufyzQd3s0rXOQP+qNZeGVwCB6Zo9Q13OXQDJOo
	gwyxE2/6I8w3nh6YPdEBjMm0L9JGOh3GyxA2SPl5DY2Vlt
X-Gm-Gg: ASbGncu2Jl1JNheOQWR49qPOSuhoVjClw4Rcp60WDEQ3XLbexEaG112oW66C0zzG+3+
	wnTcDKswz7cYc0sBfQ1xhD52qXdO2sWRtSaqUdCvoDd8h5O11/Q/YSuNME0Kjk6MfcylIxFNehz
	tZhrd98qioDkSr02g1V4ektAWmYc3J6A/8F7Fr0ui3uSmbvc2D1iTSPhnjYgnVnJRiy020UebkI
	PP+fjDDSsTJJXTRgGoGFzEsnWUG0TRRUGzYUAAo/t5aFkXDuDkC7n/ldO71c8NGN6Z/CQJei8Vn
	NQV8eKrMHtJJsEWX+joWpfYLzpuksb56WyKas/1mGw2MfUgt/1b5AwcExXSKYnIZG8L42ByEs9P
	b
X-Received: by 2002:a05:600c:26c6:b0:43b:bb72:1dce with SMTP id 5b1f17b1804b1-43bbb721f8fmr44417515e9.5.1741019441249;
        Mon, 03 Mar 2025 08:30:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6XV9dtRCnC9UYnKtk79gh146334CB5ZefECKJp7wi6xxTybGeqstnFZTU3vfWQysm8+TPqw==
X-Received: by 2002:a05:600c:26c6:b0:43b:bb72:1dce with SMTP id 5b1f17b1804b1-43bbb721f8fmr44417035e9.5.1741019440886;
        Mon, 03 Mar 2025 08:30:40 -0800 (PST)
Received: from localhost (p200300cbc7349600af274326a2162bfb.dip0.t-ipconnect.de. [2003:cb:c734:9600:af27:4326:a216:2bfb])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43bc1b5db02sm42954325e9.19.2025.03.03.08.30.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 08:30:40 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Muchun Song <muchun.song@linux.dev>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Jann Horn <jannh@google.com>
Subject: [PATCH v3 10/20] bit_spinlock: __always_inline (un)lock functions
Date: Mon,  3 Mar 2025 17:30:03 +0100
Message-ID: <20250303163014.1128035-11-david@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250303163014.1128035-1-david@redhat.com>
References: <20250303163014.1128035-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The compiler might decide that it is a smart idea to not inline
bit_spin_lock(), primarily when a couple of functions in the same file end
up calling it. Especially when used in RMAP map/unmap code next, the
compiler sometimes decides to not inline, which is then observable in
some micro-benchmarks.

Let's simply flag all lock/unlock functions as __always_inline;
arch_test_and_set_bit_lock() and friends are already tagged like that
(but not test_and_set_bit_lock() for some reason).

If ever a problem, we could split it into a fast and a slow path, and
only force the fast path to be inlined. But there is nothing
particularly "big" here.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/bit_spinlock.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/bit_spinlock.h b/include/linux/bit_spinlock.h
index bbc4730a6505c..c0989b5b0407f 100644
--- a/include/linux/bit_spinlock.h
+++ b/include/linux/bit_spinlock.h
@@ -13,7 +13,7 @@
  * Don't use this unless you really need to: spin_lock() and spin_unlock()
  * are significantly faster.
  */
-static inline void bit_spin_lock(int bitnum, unsigned long *addr)
+static __always_inline void bit_spin_lock(int bitnum, unsigned long *addr)
 {
 	/*
 	 * Assuming the lock is uncontended, this never enters
@@ -38,7 +38,7 @@ static inline void bit_spin_lock(int bitnum, unsigned long *addr)
 /*
  * Return true if it was acquired
  */
-static inline int bit_spin_trylock(int bitnum, unsigned long *addr)
+static __always_inline int bit_spin_trylock(int bitnum, unsigned long *addr)
 {
 	preempt_disable();
 #if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
@@ -54,7 +54,7 @@ static inline int bit_spin_trylock(int bitnum, unsigned long *addr)
 /*
  *  bit-based spin_unlock()
  */
-static inline void bit_spin_unlock(int bitnum, unsigned long *addr)
+static __always_inline void bit_spin_unlock(int bitnum, unsigned long *addr)
 {
 #ifdef CONFIG_DEBUG_SPINLOCK
 	BUG_ON(!test_bit(bitnum, addr));
@@ -71,7 +71,7 @@ static inline void bit_spin_unlock(int bitnum, unsigned long *addr)
  *  non-atomic version, which can be used eg. if the bit lock itself is
  *  protecting the rest of the flags in the word.
  */
-static inline void __bit_spin_unlock(int bitnum, unsigned long *addr)
+static __always_inline void __bit_spin_unlock(int bitnum, unsigned long *addr)
 {
 #ifdef CONFIG_DEBUG_SPINLOCK
 	BUG_ON(!test_bit(bitnum, addr));
-- 
2.48.1


