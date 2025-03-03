Return-Path: <linux-kernel+bounces-542263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F04A4C7D0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B66F18840E5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 16:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03FE2253B50;
	Mon,  3 Mar 2025 16:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A9OVuhzc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AE02517AF
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 16:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019461; cv=none; b=Id9nQPtQadJSsO9M0zFjRt7ShbszoGg0CVCIDakqDSjvLCrzs0Hf/qadOwAWx7zr1H+KVbA1e33RTupM1q9f85LYose/zsL5ggSIB6UTsjxcqa7hHXz77Ieq97fnMhCyF3liwZAqzZMZ/h03ItLEcEhX1Ba+qmwK0ZfsmAuOdkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019461; c=relaxed/simple;
	bh=zwBWJQNiZElGf+tnFTiOyJan5xAOzuwmBeeeOxUUAKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r53YTwX+uZVwMDbvkRuO6eR4p7jLsA/feGFva60Pt4IbAmtND+f7S/JqHOtlJ3p2dkXRRr+f7OBVgNL4KYQQu/+naIx/9BuKe8QlpiJJuUldvD/X8WYf+k33pvfupRAoI+LXQL6owxlYmnx5JOsz0gutGx1NrXb/Ci2mQA1wvk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A9OVuhzc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741019459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=azxC6HZJ9nBU2F+f5yWV4gQ6J7sT6YtNWxk4WN8FkrY=;
	b=A9OVuhzcVM6agi3kRqlbRmgmTtQnZAbWNMviaarCoBPg8KwAyORpVDXJSJk1HpXBkvsTqe
	ZZwW6xBRV8NS9MnIWfrgv6VPKDWQv/R8xCEkyW7QLmTEU3o+jiXxXgt9nK8molqYRCRRLh
	PMIH+Zefww80fyZcJ605QcXUCjnCcVo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-8sPY6Ya6PqCrRhJ2O6dnxg-1; Mon, 03 Mar 2025 11:30:53 -0500
X-MC-Unique: 8sPY6Ya6PqCrRhJ2O6dnxg-1
X-Mimecast-MFC-AGG-ID: 8sPY6Ya6PqCrRhJ2O6dnxg_1741019452
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-390df5962e1so2268868f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 08:30:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741019452; x=1741624252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=azxC6HZJ9nBU2F+f5yWV4gQ6J7sT6YtNWxk4WN8FkrY=;
        b=QvAxCim+0iIVHh5EJI7FfaD/u1J198/g69AKkdN5uaw4W+GfWgTfa5YjA3eiM8cgL3
         zGO/59BtYxlQ8c6Q9nrqViWtXgHrca1AL6eGsyfxRS1fo09F2Pm0dNzRyJYlU3N2rIbl
         z6IPrHRoGdFfQlZTRcrCOprL5MsBlpIg1qb3ddUgwcxDCnrPMlaynUyuMfj2jufNdyAa
         Gxc9vuBVLZ/pKo8kbwAZt21X/SmQqGSHGg6e30GoOeptn68VXxWh1RNvjnuS6tRLZLxS
         Eukj0SYCT7OvDiD0VTjIUiaq7xrFntnXMgIpyMBbx+rku1ZSBcH1O6DIgUywNp0lGwLt
         Usiw==
X-Gm-Message-State: AOJu0Ywn+nhmvEDWtK9bbsD7V4HkyKI3fEJYpzirw/IIAMKsRge/iJfe
	ufuLkumNeM8JoahGZiQ9Jne5x2UfEuZ8qO3B2SekT2nXFstdCjB/Zcv2x94ffDRUdEttGYJWVsc
	VQb2qt9Kz9UCu0icNTOSL9idGKmpoHoVFvRyhHmnBRoUmGHl0ETzvisy7HmxGrFX6RAU89aQL7j
	XIu0xjZUh9RtQ9iBih3fQK8kVtKb5qvyHblEfjRWt3+z96
X-Gm-Gg: ASbGnctEbXnPpA/vG+LFyIaK0s0UASQD/xVh4ToCRYRBfwYZjsySg5SVPscv6AzXWzH
	Opf9UVUpuB8QwEoaKUuU2Njx58CKP5+AhHE8Tq4jMTb9UwNf7qSDORt8paEJKJetrUnVotEZLNG
	iiHSONjqeGtAu0DBI9ohFD2W3TOo6yQlijeDQM8KsekflgMO5CMF/TKA54FQ1KcWE8/gfhxjj1j
	syi0gLXDKBuvc1Jx/ekQqOdTMIRX7jvl3XTpok76HtZhYSSxynRaTtMi0Q1V4EoPQn+IwrBMEx3
	cc868PLpeS1eVasQFdBGVjRUGXtjZZBa5eiYagzDjxQfo/2Bt8nqYz2XMkVhi3/XcfqJGxaUCLA
	T
X-Received: by 2002:a05:600c:5585:b0:43b:bedc:fcf6 with SMTP id 5b1f17b1804b1-43bbedcfe47mr44358665e9.1.1741019451794;
        Mon, 03 Mar 2025 08:30:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFzQb6PWhSpsnKcZbPTy2ai+36EkVbTPhZ8phSQIWx5xoPi2ki+HFSKpKKxfbHb4k7pKztumg==
X-Received: by 2002:a05:600c:5585:b0:43b:bedc:fcf6 with SMTP id 5b1f17b1804b1-43bbedcfe47mr44358005e9.1.1741019451351;
        Mon, 03 Mar 2025 08:30:51 -0800 (PST)
Received: from localhost (p200300cbc7349600af274326a2162bfb.dip0.t-ipconnect.de. [2003:cb:c734:9600:af27:4326:a216:2bfb])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43b736f74e8sm172202265e9.7.2025.03.03.08.30.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 08:30:50 -0800 (PST)
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
Subject: [PATCH v3 15/20] mm: CONFIG_NO_PAGE_MAPCOUNT to prepare for not maintain per-page mapcounts in large folios
Date: Mon,  3 Mar 2025 17:30:08 +0100
Message-ID: <20250303163014.1128035-16-david@redhat.com>
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

We're close to the finishing line: let's introduce a new
CONFIG_NO_PAGE_MAPCOUNT config option where we will incrementally remove
any dependencies on per-page mapcounts in large folios. Once that's
done, we'll stop maintaining the per-page mapcounts with this
config option enabled.

CONFIG_NO_PAGE_MAPCOUNT will be EXPERIMENTAL for now, as we'll have to
learn about some of the real world impact of some of the implications.

As writing "!CONFIG_NO_PAGE_MAPCOUNT" is really nasty, let's introduce
a helper config option "CONFIG_PAGE_MAPCOUNT" that expresses the
negation.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/Kconfig | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/mm/Kconfig b/mm/Kconfig
index 4034a0441f650..e4bdcf11d1b86 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -881,8 +881,25 @@ config READ_ONLY_THP_FOR_FS
 	  support of file THPs will be developed in the next few release
 	  cycles.
 
+config NO_PAGE_MAPCOUNT
+	bool "No per-page mapcount (EXPERIMENTAL)"
+	help
+	  Do not maintain per-page mapcounts for pages part of larger
+	  allocations, such as transparent huge pages.
+
+	  When this config option is enabled, some interfaces that relied on
+	  this information will rely on less-precise per-allocation information
+	  instead: for example, using the average per-page mapcount in such
+	  a large allocation instead of the per-page mapcount.
+
+	  EXPERIMENTAL because the impact of some changes is still unclear.
+
 endif # TRANSPARENT_HUGEPAGE
 
+# simple helper to make the code a bit easier to read
+config PAGE_MAPCOUNT
+	def_bool !NO_PAGE_MAPCOUNT
+
 #
 # The architecture supports pgtable leaves that is larger than PAGE_SIZE
 #
-- 
2.48.1


