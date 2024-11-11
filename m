Return-Path: <linux-kernel+bounces-404747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B60DF9C4802
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 22:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33416B256D5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 21:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CECC1EBA03;
	Mon, 11 Nov 2024 20:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kAvGE5Qw"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E521E9060
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 20:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731358512; cv=none; b=cyszM1FepapUsFLcAdNv+KweiXwqKKGswsUr2Lpq3a6Qyi2kvvOg5DC27aK6ozFbeIqnEJW93Io1ihhg8rdurdhNwBmdtrQtqYzk/mjrMU+um9nc5waj1Wgu3VHboosM6ihUjLFS37inEVihD0hPCvqnw6FTOP661rWOKyeaUG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731358512; c=relaxed/simple;
	bh=/843rvSVp64ub5KwdEW9t5Mo++sK7i8m9eZu/NNp2Xk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=kLO8E08SSAB4x7Seb32OwKPaV2NwGh7/332rvd6oaXAACgIriHobQRjacHhX6zxsNDdMqzv1XWYFyjhXxOhqdt/FkBaYZNdRja/9IyYRvQaXoPjKSz+UOMWR2Y9w4XFt7E1VVBjqymdGTIJ2Usqftxs8cYHXBHymz408kda4KBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kAvGE5Qw; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6eae6aba72fso52868217b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 12:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731358510; x=1731963310; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YmP4q8GO3tnMB8ElYnP0I9LFxs+1Dml5N/4bHnS7ye8=;
        b=kAvGE5QwnSxL8++g+0E7Z2eMCV77dydiw379tIsauumD5/gAs6ypOZOIePAYJJHU0/
         kZS3rz1YqXU3ZUAnYOEtNGIfPmLGW4mrm8OJWi37R8p0anmvz6ZnHs7Bf5Xf+09sOMDX
         0MF5sDd++IdtcxSmvbOmToqS03q0qsWjCCIjGsTozHXon+TCtnf468g26sXXIm19vNfl
         6NpjlXZafb3kvSoKJXZZCoN5vfI+ra4I5E+LogcHmb8ib8g/tesugtvGP3uiasXvTpyn
         IAzYVl80nIzdUHT19v6uehV8i5G/yOzGGFqqskmNjVFrbh2DUxuFxjLZjkdLPByUCPxM
         LItQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731358510; x=1731963310;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YmP4q8GO3tnMB8ElYnP0I9LFxs+1Dml5N/4bHnS7ye8=;
        b=Gd8rIWbr9EH/yTimUGJjhnaEKzKDP+8avlo8OLgNGTxnQ+mEpYzpjcKHEmV4xdLFOv
         YcgkMc8kshtcyAXCWARV5Gh3PK2UDN2+A8cHvz2T9otCCYf0bogIkLoxXy5h8l23rMcT
         ac/xcw70VejemGuR8VJ1r7eQAvbT3bJhdgHIYsrEqIPCeldkEjVurw2/+QNbL5p0biGR
         js7pwnvNJbt1Bscy0X853eYZPWFQlX4n2wwKb9+Y9YkJj9nbRgAI+tum2srR//+t/QiB
         Zz00+3Rzlp0ScINsfMS9gtBXQn3ZAQcM9vICVCegnA/sPVoujVQ4Fqh6PNG5I8WfyBUX
         BnAg==
X-Forwarded-Encrypted: i=1; AJvYcCW7relIsgAsp326GOyAp0SNwBYGLkZUixUNltsDW+/EpbPvAA1u1uw6VKZ7iBqHue94wcFmXWg4vwdxuNM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy94/46+P0rskBr6jT9fXsXzT86hHhjWv35lzBeiAAYhnKo7+mU
	8vBE1Q+BCcdO+qJKzFme5AQEMKhD+5tQGV5TYzMOtZw03HR/TxomT+UKMQaFjiYlXTLerZNVfis
	Vkg==
X-Google-Smtp-Source: AGHT+IE8wqP80TXUer3yViZvMPgjxLtInm9y/wNhiXq5ErcsTHmSfYSHmgVvG+YL2RzGuqwNIra/g+r9+7k=
X-Received: from surenb-desktop.mtv.corp.google.com ([2a00:79e0:2e3f:8:53af:d9fa:522d:99b1])
 (user=surenb job=sendgmr) by 2002:a25:dc4a:0:b0:e25:5cb1:77d8 with SMTP id
 3f1490d57ef6-e337f8ed8bbmr10011276.6.1731358509875; Mon, 11 Nov 2024 12:55:09
 -0800 (PST)
Date: Mon, 11 Nov 2024 12:55:02 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241111205506.3404479-1-surenb@google.com>
Subject: [PATCH 0/4] move per-vma lock into vm_area_struct
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: willy@infradead.org, liam.howlett@oracle.com, lorenzo.stoakes@oracle.com, 
	mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org, mjguzik@gmail.com, 
	oliver.sang@intel.com, mgorman@techsingularity.net, david@redhat.com, 
	peterx@redhat.com, oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org, 
	brauner@kernel.org, dhowells@redhat.com, hdanton@sina.com, hughd@google.com, 
	minchan@google.com, jannh@google.com, shakeel.butt@linux.dev, 
	souravpanda@google.com, pasha.tatashin@soleen.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@android.com, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

Back when per-vma locks were introduces, vm_lock was moved out of
vm_area_struct in [1] because of the performance regression caused by
false cacheline sharing. Recent investigation [2] revealed that the
regressions is limited to a rather old Broadwell microarchitecture and
even there it can be mitigated by disabling adjacent cacheline
prefetching, see [3].
This patchset moves vm_lock back into vm_area_struct, aligning it at the
cacheline boundary and changing the cache to be cache-aligned as well.
This causes VMA memory consumption to grow from 160 (vm_area_struct) + 40
(vm_lock) bytes to 256 bytes:

    slabinfo before:
     <name>           ... <objsize> <objperslab> <pagesperslab> : ...
     vma_lock         ...     40  102    1 : ...
     vm_area_struct   ...    160   51    2 : ...

    slabinfo after moving vm_lock:
     <name>           ... <objsize> <objperslab> <pagesperslab> : ...
     vm_area_struct   ...    256   32    2 : ...

Aggregate VMA memory consumption per 1000 VMAs grows from 50 to 64 pages,
which is 5.5MB per 100000 VMAs.
To minimize memory overhead, vm_lock implementation is changed from
using rw_semaphore (40 bytes) to an atomic (8 bytes) and several
vm_area_struct members are moved into the last cacheline, resulting
in a less fragmented structure:

struct vm_area_struct {
	union {
		struct {
			long unsigned int vm_start;      /*     0     8 */
			long unsigned int vm_end;        /*     8     8 */
		};                                       /*     0    16 */
		struct callback_head vm_rcu ;            /*     0    16 */
	} __attribute__((__aligned__(8)));               /*     0    16 */
	struct mm_struct *         vm_mm;                /*    16     8 */
	pgprot_t                   vm_page_prot;         /*    24     8 */
	union {
		const vm_flags_t   vm_flags;             /*    32     8 */
		vm_flags_t         __vm_flags;           /*    32     8 */
	};                                               /*    32     8 */
	bool                       detached;             /*    40     1 */

	/* XXX 3 bytes hole, try to pack */

	unsigned int               vm_lock_seq;          /*    44     4 */
	struct list_head           anon_vma_chain;       /*    48    16 */
	/* --- cacheline 1 boundary (64 bytes) --- */
	struct anon_vma *          anon_vma;             /*    64     8 */
	const struct vm_operations_struct  * vm_ops;     /*    72     8 */
	long unsigned int          vm_pgoff;             /*    80     8 */
	struct file *              vm_file;              /*    88     8 */
	void *                     vm_private_data;      /*    96     8 */
	atomic_long_t              swap_readahead_info;  /*   104     8 */
	struct mempolicy *         vm_policy;            /*   112     8 */

	/* XXX 8 bytes hole, try to pack */

	/* --- cacheline 2 boundary (128 bytes) --- */
	struct vma_lock       vm_lock (__aligned__(64)); /*   128     4 */

	/* XXX 4 bytes hole, try to pack */

	struct {
		struct rb_node     rb (__aligned__(8));  /*   136    24 */
		long unsigned int  rb_subtree_last;      /*   160     8 */
	} __attribute__((__aligned__(8))) shared;        /*   136    32 */
	struct vm_userfaultfd_ctx  vm_userfaultfd_ctx;   /*   168     0 */

	/* size: 192, cachelines: 3, members: 17 */
	/* sum members: 153, holes: 3, sum holes: 15 */
	/* padding: 24 */
	/* forced alignments: 3, forced holes: 2, sum forced holes: 12 */
} __attribute__((__aligned__(64)));

Memory consumption per 1000 VMAs becomes 48 pages, saving 2 pages compared
to the 50 pages in the baseline:

    slabinfo after vm_area_struct changes:
     <name>           ... <objsize> <objperslab> <pagesperslab> : ...
     vm_area_struct   ...    192   42    2 : ...

Performance measurements using pft test on x86 do not show considerable
difference, on Pixel 6 running Android it results in 3-5% improvement in
faults per second.

[1] https://lore.kernel.org/all/20230227173632.3292573-34-surenb@google.com/
[2] https://lore.kernel.org/all/ZsQyI%2F087V34JoIt@xsang-OptiPlex-9020/
[3] https://lore.kernel.org/all/CAJuCfpEisU8Lfe96AYJDZ+OM4NoPmnw9bP53cT_kbfP_pR+-2g@mail.gmail.com/

Suren Baghdasaryan (4):
  mm: introduce vma_start_read_locked{_nested} helpers
  mm: move per-vma lock into vm_area_struct
  mm: replace rw_semaphore with atomic_t in vma_lock
  mm: move lesser used vma_area_struct members into the last cacheline

 include/linux/mm.h        | 163 +++++++++++++++++++++++++++++++++++---
 include/linux/mm_types.h  |  59 +++++++++-----
 include/linux/mmap_lock.h |   3 +
 kernel/fork.c             |  50 ++----------
 mm/init-mm.c              |   2 +
 mm/userfaultfd.c          |  14 ++--
 6 files changed, 205 insertions(+), 86 deletions(-)


base-commit: 931086f2a88086319afb57cd3925607e8cda0a9f
-- 
2.47.0.277.g8800431eea-goog


