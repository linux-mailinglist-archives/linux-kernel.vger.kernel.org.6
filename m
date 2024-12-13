Return-Path: <linux-kernel+bounces-445112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8639F118A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CA881884468
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 15:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6141E3DDB;
	Fri, 13 Dec 2024 15:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="D/jkAUBB"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0F284039
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 15:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734105368; cv=none; b=IRaUCSaD23IA321QeBDrNeYJ1evp89BpzeLYCuavuIKs20BwcHata1AbrEJW+vjEiFuOvOSX79Q1bEDj1mfQmBHauz7TqwlZF5qSmbQ7GJNCOdBFQUA7jjUmMWCH6Ksewc8Gi6umjrwYrVQqNzUZlY+DC7EOO55YtmfioJpN7/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734105368; c=relaxed/simple;
	bh=JyFdzq04g2VZRCsBLSQV3qF7vB80S9FuzWtuVMfH5Ok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=esglgJthH7QpNpzOlbeMV5VbTgm5CyrQjcd3DIK6BaH7HhSEkSHrW6HrxDAXlNNL5hfunq0OxlpTkwyzTCNpc9N50LwWCSJxpMVvNqJTxEwu7/beBhiFQe6UHz5KrRq2JRunT+BopbpR4/BAZLRV/Gi/Y94kySEG1+7JBfAX3Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=D/jkAUBB; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3a8ed4c8647so12586955ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 07:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734105363; x=1734710163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=za0bLXvR2ZxwqfIp7xTCo311NzSVeVSxysS9fw8Qkds=;
        b=D/jkAUBBBPkOcyWpUqUQB9qWASXn7hujdub14I/XDlef+nYy1tYFlGpzR+K8v6w/0+
         gAmYgOqbzLnjwweWqylE8Kg3o8iogWbE6dv4q3Wwpyf6i5XtnnHRi96XmhBbjPxURcTO
         eLFkVIHjnhOewG7ao5jsq74i4Zgz6il1BMCRWE8P8DSeQPG0wugGZbFOpHMrSLDB6gaQ
         r8jY91fYnqfN/K+G+/dT9H5MOijewAwRHXqjeskjMNU/FH4ey60+tVnpUmp2TJ3eUqlz
         TUs1qRRkfivkgebaQnnXH8jOt+ekacELsYIoraxna5G7bMFP2UwBMda2+wyFjwJ0056m
         /3/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734105363; x=1734710163;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=za0bLXvR2ZxwqfIp7xTCo311NzSVeVSxysS9fw8Qkds=;
        b=AXDgMq2k33d2Om+ZLVD6XCwBPNAd7XN+IPU3bjexLwj7708oaO8P/wl0qSMCvdmEzr
         6GGyKnTUv+qAbp9/rIl91Ar0r0gyb/vYC+O7QJOvCcZfOIdVjtNEh6JG6kYelF4NyRdF
         MUZcSF/rxaGcwIAu2/1+BOvLKbrv3pEWkccb+AWrwyme5CFL+q+d3Ya8A+ywIj4wOW0i
         apEPAns37nr0H5UCvNH7YWq76v/A0uF0ZGWFyvMsEqHB8vAPUBWGM98oLwUYkSHXYmR4
         3hbkcrcIh2uN0Kwzf5T1Aior3XjQvZi12Ux3/2MJkKns2rH5nQu1s1qrjRAkMGKkT9/I
         p5UQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHvZiuIUgY2avhrlZ+Tioswx3320wM0pIBR6BgUK4ZV4HgFFfRG6S1QdaEZb4ysTqVi3t4nBcE27W+Mcs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyToi/U5bzaFF2t74iREzDEsZBwFhABf5ll5plZxGMyr2w+DKe5
	7fWxH7jPiNl8jK//q6r899QD2fQjRVUC0NUiKJTBN3ZvczvJ9ZXQXRybl4sj8pQ=
X-Gm-Gg: ASbGncvL1GhHCk86rOqAza41sHyJUHAGNEIGeXYNCfsVGSDXC9ANAJ1z5xdOCOi1CJn
	4W3zECtbo7dQNPYDkFlBDDNl1Re0s44fGiEaWsbYmk6Dh6tcBwJccyIqaGJhg6ldlov+PxFaIsY
	/epodBQ1xWVFPUmiLNKqyexqaJKk4bm6axQRJuphYZdC91rdWDP/BIqooEkliaPS1Fg2LlrA6s6
	UuFyzaHPOQiTdVLMG6HVIK1uT9J0Xn94GZsBj8J+qwSHT6a+nM6C7C+PQa0
X-Google-Smtp-Source: AGHT+IHylx/3oulFehnVhUto4Z0aFot/OVrF8JHJ3N5rc4ltn5nu/Oa1A1HwG6LLrEzas0hHyeATmg==
X-Received: by 2002:a05:6e02:1b0b:b0:3a7:8208:b843 with SMTP id e9e14a558f8ab-3aff19b7d9amr38862585ab.23.1734105363016;
        Fri, 13 Dec 2024 07:56:03 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a9ca03ae11sm35258405ab.41.2024.12.13.07.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 07:56:02 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org,
	clm@meta.com,
	linux-kernel@vger.kernel.org,
	willy@infradead.org,
	kirill@shutemov.name,
	bfoster@redhat.com
Subject: [PATCHSET v7 0/11] Uncached buffered IO
Date: Fri, 13 Dec 2024 08:55:14 -0700
Message-ID: <20241213155557.105419-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

5 years ago I posted patches adding support for RWF_UNCACHED, as a way
to do buffered IO that isn't page cache persistent. The approach back
then was to have private pages for IO, and then get rid of them once IO
was done. But that then runs into all the issues that O_DIRECT has, in
terms of synchronizing with the page cache.

So here's a new approach to the same concent, but using the page cache
as synchronization. Due to excessive bike shedding on the naming, this
is now named RWF_DONTCACHE, and is less special in that it's just page
cache IO, except it prunes the ranges once IO is completed.

Why do this, you may ask? The tldr is that device speeds are only
getting faster, while reclaim is not. Doing normal buffered IO can be
very unpredictable, and suck up a lot of resources on the reclaim side.
This leads people to use O_DIRECT as a work-around, which has its own
set of restrictions in terms of size, offset, and length of IO. It's
also inherently synchronous, and now you need async IO as well. While
the latter isn't necessarily a big problem as we have good options
available there, it also should not be a requirement when all you want
to do is read or write some data without caching.

Even on desktop type systems, a normal NVMe device can fill the entire
page cache in seconds. On the big system I used for testing, there's a
lot more RAM, but also a lot more devices. As can be seen in some of the
results in the following patches, you can still fill RAM in seconds even
when there's 1TB of it. Hence this problem isn't solely a "big
hyperscaler system" issue, it's common across the board.

Common for both reads and writes with RWF_DONTCACHE is that they use the
page cache for IO. Reads work just like a normal buffered read would,
with the only exception being that the touched ranges will get pruned
after data has been copied. For writes, the ranges will get writeback
kicked off before the syscall returns, and then writeback completion
will prune the range. Hence writes aren't synchronous, and it's easy to
pipeline writes using RWF_DONTCACHE. Folios that aren't instantiated by
RWF_DONTCACHE IO are left untouched. This means you that uncached IO
will take advantage of the page cache for uptodate data, but not leave
anything it instantiated/created in cache.

File systems need to support this. This patchset adds support for the
generic read path, which covers file systems like ext4. Patches exist to
add support for iomap/XFS and btrfs as well, which sit on top of this
series. If RWF_DONTCACHE IO is attempted on a file system that doesn't
support it, -EOPNOTSUPP is returned. Hence the user can rely on it
either working as designed, or flagging and error if that's not the
case. The intent here is to give the application a sensible fallback
path - eg, it may fall back to O_DIRECT if appropriate, or just live
with the fact that uncached IO isn't available and do normal buffered
IO.

Adding "support" to other file systems should be trivial, most of the
time just a one-liner adding FOP_DONTCACHE to the fop_flags in the
file_operations struct.

Performance results are in patch 8 for reads, and you can find the write
side results in the XFS patch adding support for DONTCACHE writes for
XFS:

://git.kernel.dk/cgit/linux/commit/?h=buffered-uncached.9&id=edd7b1c910c5251941c6ba179f44b4c81a089019

with the tldr being that I see about a 65% improvement in performance
for both, with fully predictable IO times. CPU reduction is substantial
as well, with no kswapd activity at all for reclaim when using
uncached IO.

Using it from applications is trivial - just set RWF_DONTCACHE for the
read or write, using pwritev2(2) or preadv2(2). For io_uring, same
thing, just set RWF_DONTCACHE in sqe->rw_flags for a buffered read/write
operation. And that's it.

Patches 1..7 are just prep patches, and should have no functional
changes at all. Patch 8 adds support for the filemap path for
RWF_DONTCACHE reads, and patches 9..11 are just prep patches for
supporting the write side of uncached writes. In the below mentioned
branch, there are then patches to adopt uncached reads and writes for
xfs, btrfs, and ext4. The latter currently relies on bit of a hack for
passing whether this is an uncached write or not through
->write_begin(), which can hopefully go away once ext4 adopts iomap for
buffered writes. I say this is a hack as it's not the prettiest way to
do it, however it is fully solid and will work just fine.

Passes full xfstests and fsx overnight runs, no issues observed. That
includes the vm running the testing also using RWF_DONTCACHE on the
host. I'll post fsstress and fsx patches for RWF_DONTCACHE separately.
As far as I'm concerned, no further work needs doing here.

And git tree for the patches is here:

https://git.kernel.dk/cgit/linux/log/?h=buffered-uncached.9

 include/linux/fs.h             | 21 +++++++-
 include/linux/page-flags.h     |  5 ++
 include/linux/pagemap.h        |  1 +
 include/trace/events/mmflags.h |  3 +-
 include/uapi/linux/fs.h        |  6 ++-
 mm/filemap.c                   | 97 +++++++++++++++++++++++++++++-----
 mm/internal.h                  |  2 +
 mm/readahead.c                 | 22 ++++++--
 mm/swap.c                      |  2 +
 mm/truncate.c                  | 54 ++++++++++---------
 10 files changed, 166 insertions(+), 47 deletions(-)

Since v6
- Rename the PG_uncached flag to PG_dropbehind
- Shuffle patches around a bit, most notably so the foliop_uncached
  patch goes with the ext4 support
- Get rid of foliop_uncached hack for btrfs (Christoph)
- Get rid of passing in struct address_space to filemap_create_folio()
- Inline invalidate_complete_folio2() in folio_unmap_invalidate() rather
  than keep it as a separate helper
- Rebase on top of current master

-- 
Jens Axboe


