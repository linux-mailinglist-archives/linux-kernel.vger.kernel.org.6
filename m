Return-Path: <linux-kernel+bounces-250962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E44B92FEFD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 19:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F7A21F22A1D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 17:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA10F17C7A4;
	Fri, 12 Jul 2024 17:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2TVNbVZw"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F72617C21C
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 17:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720803699; cv=none; b=As4oPHjoWzZwuO4VaJWhrLhBVaWCnJuv4ZCraCWet3zGqPg0I73WEql9zOkMO79A1pfzYrJ6YQxbN29RfutfSp77zGh8HCmYUWTWtLrr1SicSK1ReGbO09Dw0IOemQ3o/sPYFm6cjhjwq9Xx3TpZjcNXRXBBMSK83QgXC9wYXrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720803699; c=relaxed/simple;
	bh=tWN6TTu143KggvbB+U0oNB1aBXCL6xSZoNTP9ZhwMws=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oj1v7EJs+YrMKeSHg9z2J+Myjeaq7d2GlbmZzOz+aXVy+p8eMqqEOaMpZ0YkYrvq8OSPhkkGYBVtgIJHJiAbZIE6lwthUdk7wMPRjwPSA7/Voz1K3eo5Qy5AD1sB6SnYnnIlIGs78GcXooQFm8uDsCyZ9S+YfHkxPI17FzDbTZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2TVNbVZw; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-367988464ceso1772475f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 10:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720803696; x=1721408496; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wVrvdlJuWkiD+fWXDk/FgNJ7m+hI0zlwjZ1uzkGuBuA=;
        b=2TVNbVZwLPkJRaZKBJjPxXXA10SyuhSb3GYjLyl62vvBnrkmnwrhv2eRrV0n0oHMcZ
         Z+EPcYP+0kmlzENohsivYVchqjeYhrLHRVGBMGmxRjozhpVd/4CAXMOX+tyuVTfjm6iq
         Cl5+bYe8upVb3tTbXaDIa1lU5paqTsYjsinPV13kT5yi9z1bv5BBnpZebaj/MkKOr0bU
         HuT/7zAdQNQt78ioFkP8MwGTzRK2YuE5gRCx6QQPpwiSrG2wrvqeyZd8ShAHqzQ/BQDr
         HZilBQJVUHH6P4MhVfTausRkfZLiD/Udrj9SBfgfmYRKZQqYs+rDU69KMdcdGNGCuiDh
         fkrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720803696; x=1721408496;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wVrvdlJuWkiD+fWXDk/FgNJ7m+hI0zlwjZ1uzkGuBuA=;
        b=d8Cwjc93MhrOHHrdi2YGkSStJYdD3bVSXBKuU/YJoTqq0D/cfTlyDXrUEw6kAs3gRu
         qALKzTy3IqvxtNUdJkm/ig+EDZhMFicr0ONNNfzjxf9eJ35Doky0hblxrF3EDiUueJJb
         J4hJpgaJN86J+m3kLI2kZ1FvsqGxdeM6gSv90ztxB2/GYZtn8pqQscs4NXTULe90+9/g
         FQNMPp/ZDS9LjYbsTsbz3F5ogJIwAVaO7CSrIR6GSjUA0CyfxHgtzW82r1hBoB3rWH9h
         CbkA5D7mDqZJDm+KqO1FiOINBk/8NXrOqjnruywzGhdfSJuhNUzjHgL66CgW+vKId8e8
         OgUg==
X-Forwarded-Encrypted: i=1; AJvYcCUXBx2+3i1OOjPqLWjETfJoq+cztoSCBJQukFbp/0RLy+N/sVmmCr/onAMPOg1cvmmgns5G6+y4JauHivNUsSDK8IRvGWvVZ6zqbfAw
X-Gm-Message-State: AOJu0YyLYU8IoRYyDhx+U648v9R1vuymdkaumzfJAwRUR7JkMSvX983T
	uZDqTktM32MZVfgEZ1Br/K5hQMrrCOCUJsN1atAO0cCPyxPqrJTwzFbuurstpqz5eFlyecSB4BJ
	sSY6SKIH1WA==
X-Google-Smtp-Source: AGHT+IErU4rdmgQiGRDTef2HJjYT1+igKTiETpi6GcIgcGxVKuf8GnSM5HDh2rVJ+wSRQZ9KiIWprZFuMKIHlA==
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a05:6000:400c:b0:368:5d2:9e5f with SMTP
 id ffacd0b85a97d-36805d29fa3mr5077f8f.0.1720803695788; Fri, 12 Jul 2024
 10:01:35 -0700 (PDT)
Date: Fri, 12 Jul 2024 17:00:33 +0000
In-Reply-To: <20240712-asi-rfc-24-v1-0-144b319a40d8@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240712-asi-rfc-24-v1-0-144b319a40d8@google.com>
X-Mailer: b4 0.14-dev
Message-ID: <20240712-asi-rfc-24-v1-15-144b319a40d8@google.com>
Subject: [PATCH 15/26] mm: Add __PAGEFLAG_FALSE
From: Brendan Jackman <jackmanb@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Alexandre Chartre <alexandre.chartre@oracle.com>, Liran Alon <liran.alon@oracle.com>, 
	Jan Setje-Eilers <jan.setjeeilers@oracle.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Mel Gorman <mgorman@suse.de>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Michal Hocko <mhocko@kernel.org>, Khalid Aziz <khalid.aziz@oracle.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Valentin Schneider <vschneid@redhat.com>, Paul Turner <pjt@google.com>, Reiji Watanabe <reijiw@google.com>, 
	Junaid Shahid <junaids@google.com>, Ofir Weisse <oweisse@google.com>, 
	Yosry Ahmed <yosryahmed@google.com>, Patrick Bellasi <derkling@google.com>, 
	KP Singh <kpsingh@google.com>, Alexandra Sandulescu <aesa@google.com>, 
	Matteo Rizzo <matteorizzo@google.com>, Jann Horn <jannh@google.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	kvm@vger.kernel.org, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

__PAGEFLAG_FALSE is a non-atomic equivalent of PAGEFLAG_FALSE.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 include/linux/page-flags.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 4bf1c25fd1dc5..57fa58899a661 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -488,6 +488,10 @@ static inline int Page##uname(const struct page *page) { return 0; }
 FOLIO_SET_FLAG_NOOP(lname)						\
 static inline void SetPage##uname(struct page *page) {  }
 
+#define __SETPAGEFLAG_NOOP(uname, lname)					\
+static inline void __folio_set_##lname(struct folio *folio) { }		\
+static inline void __SetPage##uname(struct page *page) {  }
+
 #define CLEARPAGEFLAG_NOOP(uname, lname)				\
 FOLIO_CLEAR_FLAG_NOOP(lname)						\
 static inline void ClearPage##uname(struct page *page) {  }
@@ -510,6 +514,9 @@ static inline int TestClearPage##uname(struct page *page) { return 0; }
 #define TESTSCFLAG_FALSE(uname, lname)					\
 	TESTSETFLAG_FALSE(uname, lname) TESTCLEARFLAG_FALSE(uname, lname)
 
+#define __PAGEFLAG_FALSE(uname, lname) TESTPAGEFLAG_FALSE(uname, lname)		\
+	__SETPAGEFLAG_NOOP(uname, lname) __CLEARPAGEFLAG_NOOP(uname, lname)
+
 __PAGEFLAG(Locked, locked, PF_NO_TAIL)
 FOLIO_FLAG(waiters, FOLIO_HEAD_PAGE)
 PAGEFLAG(Error, error, PF_NO_TAIL) TESTCLEARFLAG(Error, error, PF_NO_TAIL)

-- 
2.45.2.993.g49e7a77208-goog


