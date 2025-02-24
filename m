Return-Path: <linux-kernel+bounces-529607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C33B4A428B5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1125F3BCC54
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 16:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB557266B78;
	Mon, 24 Feb 2025 16:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XYqazAkG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6FA266B41
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 16:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740416191; cv=none; b=SnNFhfSYGiYBIc/Y+fYSQSzcoY+uZuZMbuHZBQq/7tAtS43x+vu348yVZ1BgpSJNVYWe62vsXUwFFaEHRQA7+k6y+IlXf6Z8eIeDxze3WpBy9iky7EAkVX3KrY+QnYNIt6Z1LuZNbms4k2sVlpC7WoM8T6Kkapiz3929Gxyg4IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740416191; c=relaxed/simple;
	bh=OBXpWDsR7o4dKf8NkhRON4PwL/H6iQiwplPc25GckEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UWwQUGFwMKr153T5C00B5CEEwqVu6Mqa865m9RKBHSWHPgyHs6xWyBOeLTbGCZK9gEeNdcWMAAeCP206AW98hYQV/7jClromZzCO8+KgtfkyaQZlau/FlUCrvxbUFennXtSDh5VJ/kz56QeVDLD8BDE8kf7ddTfR3Mn/DhzWCHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XYqazAkG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740416188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VusPlBbKEOGpL4wS1BqoWY6CYb2f4HQ+/wIDh8p+vAo=;
	b=XYqazAkG+H8MsZ1DsDZBLAuDIk8qE2QVwewqvdVt3+9wnFjoRfUHy9ZGePLPfFwxzgYokt
	YIObUxzfFuVrQt+6ngONj9KBCDtWCAPVg3DDSobzOBoVcTUI5sGZqLV68vQOhDzxRMZPkn
	y8h2nK/2vDEBtX24uaEGJegRiFXR588=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-5j3xAji8PFGKr_GPwX6ECw-1; Mon, 24 Feb 2025 11:56:27 -0500
X-MC-Unique: 5j3xAji8PFGKr_GPwX6ECw-1
X-Mimecast-MFC-AGG-ID: 5j3xAji8PFGKr_GPwX6ECw_1740416186
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-438e180821aso23678695e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 08:56:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740416186; x=1741020986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VusPlBbKEOGpL4wS1BqoWY6CYb2f4HQ+/wIDh8p+vAo=;
        b=ba60Cb1TIAt2rK7I65I0dk05XIV1J471D8AW2DElOeKfo7OynoWoWVqI/NRkfGXBsK
         +M3cNf2PfHY0+ap0n7PZvdisC1URyLKULzdlAUKk4Pfer8r7xEJ391LNW0EUVRDg5UdN
         lsGDm26U8IuXdzJ2oSYw2k6Iw6JtBewgWib/kcAAVz4OwNJqddYQ3hDzx3Wmepmy43g9
         +H0tMtvynAcOWVzoEl++ytl6KwznhFFeJY4hXp7lDNmONmcGtiqKaR+C5ArjBuMpotkO
         G9x6BJl8Quz6h8G1etaKrrAoM2PVvZYWAU5Tgyaz+OnMzKUX4MsbCcoOFKMccRCFp8Eg
         NgBQ==
X-Gm-Message-State: AOJu0YzbknefouMP+8QgNwfr8LopDznTHPARWjdBBBYh+xINtf0VHXJH
	s1gWmj4NAm9AbV5LsNQt/mGRQqO38bZntUToNAczeJHyPllyl40cMCe0jtrO/LJXvtBf/oW5ulz
	AcCeAIB2ILbikCMhVximl6Ev2Qp8T6B+g/N0jEFbO0G+pw8NWIb2kXeb6w92E3stz4rYq9JlvaN
	PVSQ3myrGKEnbSfOrchVWBmCP9wbjJY9JeIMuiGWKRgw2+
X-Gm-Gg: ASbGncsir+S843OzRfzZ2UVRRREHtokrLZn0UqiWP+sKqLPUZDbhmhiaUap5tQEsIAe
	dhaadCTXgVYyI+qrRQqIyQKxWpwzdxAcMuAcZvNxwU/gDr2hnmhANrcltb+tGrzHBXIrY5Mz8cp
	cV+QUc2N/bMsjk9hiqotHM/l6ndOPvQHt7bBtnXC+QwImpWcInXA19f5UO3H//Z8FBF9mGcAmtM
	1S9ux1EWtXmGjZllAFomXJouQLLe1og9yDl8F4RwOA3T4z9g9g4hrTfxn7leaOOA0f5EQw2BU8p
	f0NtXE6PLh9OcGOhvNS8K2TENud6akUvzhwsoOmXew==
X-Received: by 2002:a05:600c:4f43:b0:439:9828:c425 with SMTP id 5b1f17b1804b1-43ab0f2db61mr336885e9.7.1740416186429;
        Mon, 24 Feb 2025 08:56:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHWfaIC9jLsYbcLXi3Fdeg1qCi0/sJNUC8bLA+3qaJ5mWtkIjQvv3YtNjkQQj/btQBGxQxPlw==
X-Received: by 2002:a05:600c:4f43:b0:439:9828:c425 with SMTP id 5b1f17b1804b1-43ab0f2db61mr336445e9.7.1740416185910;
        Mon, 24 Feb 2025 08:56:25 -0800 (PST)
Received: from localhost (p4ff234b6.dip0.t-ipconnect.de. [79.242.52.182])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-439b030b347sm111391345e9.26.2025.02.24.08.56.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 08:56:25 -0800 (PST)
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
Subject: [PATCH v2 10/20] bit_spinlock: __always_inline (un)lock functions
Date: Mon, 24 Feb 2025 17:55:52 +0100
Message-ID: <20250224165603.1434404-11-david@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224165603.1434404-1-david@redhat.com>
References: <20250224165603.1434404-1-david@redhat.com>
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


