Return-Path: <linux-kernel+bounces-215794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA3B90970F
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 10:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B7C31C220E5
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 08:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF271C68E;
	Sat, 15 Jun 2024 08:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M+/XbC17"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177BF1BDD3
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 08:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718441256; cv=none; b=n5pUQXa17m7YnedfRu22Ce1QLLdSfgzLc36K71oy5h8fGSf0goarLjfst11gp39/SluPedwZFhS7pV8OXa40O/ETYPnAqYPB68Q7wHi3SO/oGO5nUtJ6IEuvTw6xz8/FR+BjH2tvPOW/wlGoe8bAcLbq5PeRQey76TysfbKfmxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718441256; c=relaxed/simple;
	bh=TlLx1YhkRPoUdmpe6zy1ZS72i6j1pEZpupGcib1Tyco=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PF4+Hm8VIutC4AQdzGpva7tNujGXw7t4k7OxbvLdAB/ey9TQtwG/kx61pDkmx81jReIFK5FXOffXWeFq17ywPrTqIMxi0OJb85O8PZ13a682PX4pOiprFAV+gl9RRBx4yqrHqb56Oa9cARpAsq4NTnShb51QQznJEslUaC2yVzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M+/XbC17; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f32a3b9491so25714205ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 01:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718441253; x=1719046053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X/FFH4DtgR/iU8j21RXF19uzJ8Kwf6pM9uHnslWRNYs=;
        b=M+/XbC17wsbjGiBsfHgsPHNEPDiYK0fqCjGAWeOSrVQ5lCnVtNrqasDqhhaf2AEtrn
         osuygVO2R1c4A4gtdSJsMprs5ox0tLiXYdatvYquXUv/7FvVGRGQtMgpf5Psg7VB7QSh
         lJ56G51SYvBO09HRKjPiaq7/N1y3g/JZmRUi6SmnWoAKxwysIqTKM/2Gy9I/TxYmxnhQ
         RqzDRZvt6grNcz8uBx+hUK8ebNYszuDh6iO0AHtxWABVwmlvlILAXp6LCWSuPJ4yBfIl
         qgTI9CgqHrOqEKQ7sC6zpKCEDdEn27xxWM1fe7k+73fNeB/1TmM3SRSaUMPyvBBoYJKU
         pNTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718441253; x=1719046053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X/FFH4DtgR/iU8j21RXF19uzJ8Kwf6pM9uHnslWRNYs=;
        b=e4CX05UwH8+qKl4KWJ4+6FMFJvcgRtpVUMJqu2pQJQx5MeslglTZagZqxAAcIC2rvk
         TSDyYFRO6xDfknpy59zJbJz897JbIun7mVeWAB4PVxSmpfN74zihyOUzkBNZda1jKAjQ
         8tfQoIjMZ2qtJSEh2sTBaPK/0sxMDIe8reYk6ttcB6r3Guv6LtdTl7hyTjRYeT6gwcba
         vpefeYg3lHCcAmkDrHcvWwNzztKY3bpS1WqEduCXJP4I+XeBmeYIrs1dJCY4zKo2hELr
         RQk0JTFxXIQ/bPkmzVaekJVossFSPmlHec9P828us9Qu6LlUQjSbzbHihUVQVzBgodRv
         VWqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhaJXPzrTeiTqj+my1vaL250WtNVhyBO4N0FGBR+nkU8bjXduqELj9A3MR3ClVZiq85ZYaNVZ8CnTlicqtozclsw8SFNW7MQoes6db
X-Gm-Message-State: AOJu0YxgU5zJwF4nANY/jPSXllOcMoI06wDsl3V1y5iC4aDVNAccA6HX
	6iv1BG2LrY/JzgMMRkQsBMeoWqgLv1KjHs5b7Maj5MoaePD62ixQ
X-Google-Smtp-Source: AGHT+IGTgGS25IoN+YUev3TiNK/skfdkLXWyXILUghdCXWCv3UNd/GrOP2ij/UpTX283gS5dk1Skjw==
X-Received: by 2002:a17:902:ea05:b0:1f8:6993:5186 with SMTP id d9443c01a7336-1f8699354a9mr36315005ad.11.1718441253035;
        Sat, 15 Jun 2024 01:47:33 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f3028fsm45043585ad.256.2024.06.15.01.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jun 2024 01:47:32 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	chrisl@kernel.org
Cc: baohua@kernel.org,
	kaleshsingh@google.com,
	kasong@tencent.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ryan.roberts@arm.com,
	ying.huang@intel.com
Subject: Re: [PATCH v2 0/2] mm: swap: mTHP swap allocator base on swap cluster order
Date: Sat, 15 Jun 2024 20:47:14 +1200
Message-Id: <20240615084714.37499-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240614195921.a20f1766a78b27339a2a3128@linux-foundation.org>
References: <20240614195921.a20f1766a78b27339a2a3128@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, Jun 15, 2024 at 2:59 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Fri, 14 Jun 2024 19:51:11 -0700 Chris Li <chrisl@kernel.org> wrote:
>
> > > I'm having trouble understanding the overall impact of this on users.
> > > We fail the mTHP swap allocation and fall back, but things continue to
> > > operate OK?
> >
> > Continue to operate OK in the sense that the mTHP will have to split
> > into 4K pages before the swap out, aka the fall back. The swap out and
> > swap in can continue to work as 4K pages, not as the mTHP. Due to the
> > fallback, the mTHP based zsmalloc compression with 64K buffer will not
> > happen. That is the effect of the fallback. But mTHP swap out and swap
> > in is relatively new, it is not really a regression.
>
> Sure, but it's pretty bad to merge a new feature only to have it
> ineffective after a few hours use.
>
> > >
> > > > There is some test number in the V1 thread of this series:
> > > > https://lore.kernel.org/r/20240524-swap-allocator-v1-0-47861b423b26@kernel.org
> > >
> > > Well, please let's get the latest numbers into the latest patchset.
> > > Along with a higher-level (and quantitative) description of the user impact.
> >
> > I will need Barray's help to collect the number. I don't have the
> > setup to reproduce his test result.
> > Maybe a follow up commit message amendment for the test number when I get it?

Although the issue may seem complex at a systemic level, even a small program can
demonstrate the problem and highlight how Chris's patch has improved the
situation.

To demonstrate this, I designed a basic test program that maximally allocates
two memory blocks:

 *   A memory block of up to 60MB, recommended for HUGEPAGE usage
 *   A memory block of up to 1MB, recommended for NOHUGEPAGE usage

In the system configuration, I enabled 64KB mTHP and 64MB zRAM, providing more than
enough space for both the 60MB and 1MB allocations in the worst case. This setup
allows us to assess two effects:

1.  When we don't enable mem2 (small folios), we consistently allocate and free
    swap slots aligned with 64KB.  whether there is a risk of failure to obtain
    swap slots even though the zRAM has sufficient free space?
2.  When we enable mem2 (small folios), the presence of small folios may lead
    to fragmentation of clusters, potentially impacting the swapout process for
    large folios negatively.

(2) can be enabled by "-s", without -s, small folios are disabled.

The script to configure zRAM and mTHP:

echo lzo > /sys/block/zram0/comp_algorithm
echo 64M > /sys/block/zram0/disksize
echo never > /sys/kernel/mm/transparent_hugepage/hugepages-2048kB/enabled
echo always > /sys/kernel/mm/transparent_hugepage/hugepages-64kB/enabled
mkswap /dev/zram0
swapon /dev/zram0

The test program I made today after receiving Chris' patchset v2

(Andrew, Please let me know if you want this small test program to
be committed into kernel/tools/ folder. If yes, please let me know,
and I will cleanup and prepare a patch):

#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/mman.h>
#include <errno.h>
#include <time.h>

#define MEMSIZE_MTHP (60 * 1024 * 1024)
#define MEMSIZE_SMALLFOLIO (1 * 1024 * 1024)
#define ALIGNMENT_MTHP (64 * 1024)
#define ALIGNMENT_SMALLFOLIO (4 * 1024)
#define TOTAL_DONTNEED_MTHP (16 * 1024 * 1024)
#define TOTAL_DONTNEED_SMALLFOLIO (256 * 1024)
#define MTHP_FOLIO_SIZE (64 * 1024)

#define SWPOUT_PATH \
    "/sys/kernel/mm/transparent_hugepage/hugepages-64kB/stats/swpout"
#define SWPOUT_FALLBACK_PATH \
    "/sys/kernel/mm/transparent_hugepage/hugepages-64kB/stats/swpout_fallback"

static void *aligned_alloc_mem(size_t size, size_t alignment)
{
    void *mem = NULL;
    if (posix_memalign(&mem, alignment, size) != 0) {
        perror("posix_memalign");
        return NULL;
    }
    return mem;
}

static void random_madvise_dontneed(void *mem, size_t mem_size,
                                     size_t align_size, size_t total_dontneed_size)
{
    size_t num_pages = total_dontneed_size / align_size;
    size_t i;
    size_t offset;
    void *addr;

    for (i = 0; i < num_pages; ++i) {
        offset = (rand() % (mem_size / align_size)) * align_size;
        addr = (char *)mem + offset;
        if (madvise(addr, align_size, MADV_DONTNEED) != 0) {
            perror("madvise dontneed");
        }
        memset(addr, 0x11, align_size);
    }
}

static unsigned long read_stat(const char *path)
{
    FILE *file;
    unsigned long value;

    file = fopen(path, "r");
    if (!file) {
        perror("fopen");
        return 0;
    }

    if (fscanf(file, "%lu", &value) != 1) {
        perror("fscanf");
        fclose(file);
        return 0;
    }

    fclose(file);
    return value;
}

int main(int argc, char *argv[])
{
    int use_small_folio = 0;
    int i;
    void *mem1 = aligned_alloc_mem(MEMSIZE_MTHP, ALIGNMENT_MTHP);
    if (mem1 == NULL) {
        fprintf(stderr, "Failed to allocate 60MB memory\n");
        return EXIT_FAILURE;
    }

    if (madvise(mem1, MEMSIZE_MTHP, MADV_HUGEPAGE) != 0) {
        perror("madvise hugepage for mem1");
        free(mem1);
        return EXIT_FAILURE;
    }

    for (i = 1; i < argc; ++i) {
        if (strcmp(argv[i], "-s") == 0) {
            use_small_folio = 1;
        }
    }

    void *mem2 = NULL;
    if (use_small_folio) {
        mem2 = aligned_alloc_mem(MEMSIZE_SMALLFOLIO, ALIGNMENT_MTHP);
        if (mem2 == NULL) {
            fprintf(stderr, "Failed to allocate 1MB memory\n");
            free(mem1);
            return EXIT_FAILURE;
        }

        if (madvise(mem2, MEMSIZE_SMALLFOLIO, MADV_NOHUGEPAGE) != 0) {
            perror("madvise nohugepage for mem2");
            free(mem1);
            free(mem2);
            return EXIT_FAILURE;
        }
    }

    for (i = 0; i < 100; ++i) {
        unsigned long initial_swpout;
        unsigned long initial_swpout_fallback;
        unsigned long final_swpout;
        unsigned long final_swpout_fallback;
        unsigned long swpout_inc;
        unsigned long swpout_fallback_inc;
        double fallback_percentage;

        initial_swpout = read_stat(SWPOUT_PATH);
        initial_swpout_fallback = read_stat(SWPOUT_FALLBACK_PATH);

        random_madvise_dontneed(mem1, MEMSIZE_MTHP, ALIGNMENT_MTHP,
                                 TOTAL_DONTNEED_MTHP);

        if (use_small_folio) {
            random_madvise_dontneed(mem2, MEMSIZE_SMALLFOLIO,
                                     ALIGNMENT_SMALLFOLIO,
                                     TOTAL_DONTNEED_SMALLFOLIO);
        }

        if (madvise(mem1, MEMSIZE_MTHP, MADV_PAGEOUT) != 0) {
            perror("madvise pageout for mem1");
            free(mem1);
            if (mem2 != NULL) {
                free(mem2);
            }
            return EXIT_FAILURE;
        }

        if (use_small_folio) {
            if (madvise(mem2, MEMSIZE_SMALLFOLIO, MADV_PAGEOUT) != 0) {
                perror("madvise pageout for mem2");
                free(mem1);
                free(mem2);
                return EXIT_FAILURE;
            }
        }

        final_swpout = read_stat(SWPOUT_PATH);
        final_swpout_fallback = read_stat(SWPOUT_FALLBACK_PATH);

        swpout_inc = final_swpout - initial_swpout;
        swpout_fallback_inc = final_swpout_fallback - initial_swpout_fallback;

        fallback_percentage = (double)swpout_fallback_inc /
                              (swpout_fallback_inc + swpout_inc) * 100;

        printf("Iteration %d: swpout inc: %lu, swpout fallback inc: %lu, Fallback percentage: %.2f%%\n",
               i + 1, swpout_inc, swpout_fallback_inc, fallback_percentage);
    }

    free(mem1);
    if (mem2 != NULL) {
        free(mem2);
    }

    return EXIT_SUCCESS;
}

w/o Chris' patchset:

Test A. without small folios

$ /home/barry/develop/linux/mthp_swpout_test

Iteration 1: swpout inc: 226, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 2: swpout inc: 224, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 3: swpout inc: 221, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 4: swpout inc: 189, swpout fallback inc: 42, Fallback percentage: 18.18%
Iteration 5: swpout inc: 6, swpout fallback inc: 212, Fallback percentage: 97.25%
Iteration 6: swpout inc: 0, swpout fallback inc: 227, Fallback percentage: 100.00%
Iteration 7: swpout inc: 0, swpout fallback inc: 224, Fallback percentage: 100.00%
Iteration 8: swpout inc: 0, swpout fallback inc: 222, Fallback percentage: 100.00%
Iteration 9: swpout inc: 0, swpout fallback inc: 217, Fallback percentage: 100.00%
Iteration 10: swpout inc: 1, swpout fallback inc: 226, Fallback percentage: 99.56%
Iteration 11: swpout inc: 0, swpout fallback inc: 226, Fallback percentage: 100.00%
Iteration 12: swpout inc: 0, swpout fallback inc: 227, Fallback percentage: 100.00%
Iteration 13: swpout inc: 0, swpout fallback inc: 231, Fallback percentage: 100.00%
...

mthp swpout fallback ratio immediately goes up to 100%!!!

Test B. with small folios

$ /home/barry/develop/linux/mthp_swpout_test -s

Iteration 1: swpout inc: 226, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 2: swpout inc: 229, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 3: swpout inc: 229, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 4: swpout inc: 20, swpout fallback inc: 206, Fallback percentage: 91.15%
Iteration 5: swpout inc: 26, swpout fallback inc: 201, Fallback percentage: 88.55%
Iteration 6: swpout inc: 2, swpout fallback inc: 216, Fallback percentage: 99.08%
Iteration 7: swpout inc: 16, swpout fallback inc: 209, Fallback percentage: 92.89%
Iteration 8: swpout inc: 5, swpout fallback inc: 222, Fallback percentage: 97.80%
Iteration 9: swpout inc: 0, swpout fallback inc: 226, Fallback percentage: 100.00%
Iteration 10: swpout inc: 0, swpout fallback inc: 224, Fallback percentage: 100.00%
Iteration 11: swpout inc: 0, swpout fallback inc: 228, Fallback percentage: 100.00%
Iteration 12: swpout inc: 0, swpout fallback inc: 227, Fallback percentage: 100.00%
Iteration 13: swpout inc: 0, swpout fallback inc: 226, Fallback percentage: 100.00%
Iteration 14: swpout inc: 0, swpout fallback inc: 234, Fallback percentage: 100.00%
...

mthp swpout fallback ratio immediately goes up to 100%!!!


w/ Chris' patchset:

Test C. without small folios
$ /home/barry/develop/linux/mthp_swpout_test

Iteration 1: swpout inc: 226, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 2: swpout inc: 224, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 3: swpout inc: 221, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 4: swpout inc: 231, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 5: swpout inc: 218, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 6: swpout inc: 227, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 7: swpout inc: 224, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 8: swpout inc: 222, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 9: swpout inc: 217, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 10: swpout inc: 227, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 11: swpout inc: 226, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 12: swpout inc: 210, swpout fallback inc: 17, Fallback percentage: 7.49%
Iteration 13: swpout inc: 230, swpout fallback inc: 1, Fallback percentage: 0.43%
Iteration 14: swpout inc: 209, swpout fallback inc: 13, Fallback percentage: 5.86%
Iteration 15: swpout inc: 214, swpout fallback inc: 16, Fallback percentage: 6.96%
Iteration 16: swpout inc: 214, swpout fallback inc: 12, Fallback percentage: 5.31%
Iteration 17: swpout inc: 227, swpout fallback inc: 6, Fallback percentage: 2.58%
Iteration 18: swpout inc: 203, swpout fallback inc: 24, Fallback percentage: 10.57%
Iteration 19: swpout inc: 229, swpout fallback inc: 1, Fallback percentage: 0.43%
Iteration 20: swpout inc: 224, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 21: swpout inc: 217, swpout fallback inc: 13, Fallback percentage: 5.65%
Iteration 22: swpout inc: 205, swpout fallback inc: 17, Fallback percentage: 7.66%
Iteration 23: swpout inc: 213, swpout fallback inc: 15, Fallback percentage: 6.58%
Iteration 24: swpout inc: 234, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 25: swpout inc: 205, swpout fallback inc: 18, Fallback percentage: 8.07%
Iteration 26: swpout inc: 217, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 27: swpout inc: 219, swpout fallback inc: 6, Fallback percentage: 2.67%
Iteration 28: swpout inc: 215, swpout fallback inc: 14, Fallback percentage: 6.11%
Iteration 29: swpout inc: 227, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 30: swpout inc: 208, swpout fallback inc: 13, Fallback percentage: 5.88%
Iteration 31: swpout inc: 219, swpout fallback inc: 6, Fallback percentage: 2.67%
Iteration 32: swpout inc: 216, swpout fallback inc: 7, Fallback percentage: 3.14%
Iteration 33: swpout inc: 201, swpout fallback inc: 28, Fallback percentage: 12.23%
Iteration 34: swpout inc: 232, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 35: swpout inc: 215, swpout fallback inc: 17, Fallback percentage: 7.33%
Iteration 36: swpout inc: 209, swpout fallback inc: 16, Fallback percentage: 7.11%
Iteration 37: swpout inc: 202, swpout fallback inc: 29, Fallback percentage: 12.55%
Iteration 38: swpout inc: 200, swpout fallback inc: 18, Fallback percentage: 8.26%
Iteration 39: swpout inc: 219, swpout fallback inc: 12, Fallback percentage: 5.19%
Iteration 40: swpout inc: 218, swpout fallback inc: 9, Fallback percentage: 3.96%
Iteration 41: swpout inc: 212, swpout fallback inc: 14, Fallback percentage: 6.19%
Iteration 42: swpout inc: 204, swpout fallback inc: 15, Fallback percentage: 6.85%
Iteration 43: swpout inc: 222, swpout fallback inc: 5, Fallback percentage: 2.20%
Iteration 44: swpout inc: 205, swpout fallback inc: 20, Fallback percentage: 8.89%
Iteration 45: swpout inc: 217, swpout fallback inc: 6, Fallback percentage: 2.69%
Iteration 46: swpout inc: 209, swpout fallback inc: 19, Fallback percentage: 8.33%
Iteration 47: swpout inc: 205, swpout fallback inc: 13, Fallback percentage: 5.96%
Iteration 48: swpout inc: 223, swpout fallback inc: 4, Fallback percentage: 1.76%
Iteration 49: swpout inc: 203, swpout fallback inc: 21, Fallback percentage: 9.38%
Iteration 50: swpout inc: 193, swpout fallback inc: 19, Fallback percentage: 8.96%
Iteration 51: swpout inc: 197, swpout fallback inc: 29, Fallback percentage: 12.83%
Iteration 52: swpout inc: 195, swpout fallback inc: 29, Fallback percentage: 12.95%
Iteration 53: swpout inc: 217, swpout fallback inc: 17, Fallback percentage: 7.26%
Iteration 54: swpout inc: 207, swpout fallback inc: 11, Fallback percentage: 5.05%
Iteration 55: swpout inc: 213, swpout fallback inc: 10, Fallback percentage: 4.48%
Iteration 56: swpout inc: 203, swpout fallback inc: 23, Fallback percentage: 10.18%
Iteration 57: swpout inc: 197, swpout fallback inc: 34, Fallback percentage: 14.72%
Iteration 58: swpout inc: 209, swpout fallback inc: 13, Fallback percentage: 5.86%
Iteration 59: swpout inc: 212, swpout fallback inc: 19, Fallback percentage: 8.23%
Iteration 60: swpout inc: 196, swpout fallback inc: 24, Fallback percentage: 10.91%
Iteration 61: swpout inc: 203, swpout fallback inc: 13, Fallback percentage: 6.02%
Iteration 62: swpout inc: 221, swpout fallback inc: 7, Fallback percentage: 3.07%
Iteration 63: swpout inc: 207, swpout fallback inc: 17, Fallback percentage: 7.59%
Iteration 64: swpout inc: 205, swpout fallback inc: 15, Fallback percentage: 6.82%
Iteration 65: swpout inc: 223, swpout fallback inc: 3, Fallback percentage: 1.33%
Iteration 66: swpout inc: 215, swpout fallback inc: 13, Fallback percentage: 5.70%
Iteration 67: swpout inc: 225, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 68: swpout inc: 215, swpout fallback inc: 8, Fallback percentage: 3.59%
Iteration 69: swpout inc: 222, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 70: swpout inc: 204, swpout fallback inc: 17, Fallback percentage: 7.69%
Iteration 71: swpout inc: 227, swpout fallback inc: 6, Fallback percentage: 2.58%
Iteration 72: swpout inc: 207, swpout fallback inc: 16, Fallback percentage: 7.17%
Iteration 73: swpout inc: 217, swpout fallback inc: 9, Fallback percentage: 3.98%
Iteration 74: swpout inc: 206, swpout fallback inc: 9, Fallback percentage: 4.19%
Iteration 75: swpout inc: 193, swpout fallback inc: 26, Fallback percentage: 11.87%
Iteration 76: swpout inc: 225, swpout fallback inc: 3, Fallback percentage: 1.32%
Iteration 77: swpout inc: 205, swpout fallback inc: 25, Fallback percentage: 10.87%
Iteration 78: swpout inc: 213, swpout fallback inc: 12, Fallback percentage: 5.33%
Iteration 79: swpout inc: 212, swpout fallback inc: 10, Fallback percentage: 4.50%
Iteration 80: swpout inc: 210, swpout fallback inc: 9, Fallback percentage: 4.11%
Iteration 81: swpout inc: 225, swpout fallback inc: 4, Fallback percentage: 1.75%
Iteration 82: swpout inc: 211, swpout fallback inc: 3, Fallback percentage: 1.40%
Iteration 83: swpout inc: 216, swpout fallback inc: 10, Fallback percentage: 4.42%
Iteration 84: swpout inc: 226, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 85: swpout inc: 213, swpout fallback inc: 13, Fallback percentage: 5.75%
Iteration 86: swpout inc: 225, swpout fallback inc: 3, Fallback percentage: 1.32%
Iteration 87: swpout inc: 204, swpout fallback inc: 22, Fallback percentage: 9.73%
Iteration 88: swpout inc: 225, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 89: swpout inc: 225, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 90: swpout inc: 221, swpout fallback inc: 8, Fallback percentage: 3.49%
Iteration 91: swpout inc: 212, swpout fallback inc: 13, Fallback percentage: 5.78%
Iteration 92: swpout inc: 207, swpout fallback inc: 18, Fallback percentage: 8.00%
Iteration 93: swpout inc: 209, swpout fallback inc: 25, Fallback percentage: 10.68%
Iteration 94: swpout inc: 213, swpout fallback inc: 13, Fallback percentage: 5.75%
Iteration 95: swpout inc: 206, swpout fallback inc: 18, Fallback percentage: 8.04%
Iteration 96: swpout inc: 206, swpout fallback inc: 17, Fallback percentage: 7.62%
Iteration 97: swpout inc: 216, swpout fallback inc: 11, Fallback percentage: 4.85%
Iteration 98: swpout inc: 210, swpout fallback inc: 13, Fallback percentage: 5.83%
Iteration 99: swpout inc: 223, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 100: swpout inc: 205, swpout fallback inc: 21, Fallback percentage: 9.29%
...

mthp swpout fallback ratio is stable and low in 100 iterations!!!
Though the number is very good, I wonder why it is not 0% since 64MB is larger
than 60MB? Chris, do you have any idea?

Test D. with small folios
$ /home/barry/develop/linux/mthp_swpout_test -s

[ 1013.535798] ------------[ cut here ]------------
[ 1013.538886] expecting order 4 got 0
[ 1013.540622] WARNING: CPU: 3 PID: 104 at mm/swapfile.c:600 scan_swap_map_try_ssd_cluster+0x340/0x370
[ 1013.544460] Modules linked in:
[ 1013.545411] CPU: 3 PID: 104 Comm: mthp_swpout_tes Not tainted 6.10.0-rc3-ga12328d9fb85-dirty #285
[ 1013.545990] Hardware name: linux,dummy-virt (DT)
[ 1013.546585] pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
[ 1013.547136] pc : scan_swap_map_try_ssd_cluster+0x340/0x370
[ 1013.547768] lr : scan_swap_map_try_ssd_cluster+0x340/0x370
[ 1013.548263] sp : ffff8000863e32e0
[ 1013.548723] x29: ffff8000863e32e0 x28: 0000000000000670 x27: 0000000000000660
[ 1013.549626] x26: 0000000000000010 x25: ffff0000c1692108 x24: ffff0000c27c4800
[ 1013.550470] x23: 2e8ba2e8ba2e8ba3 x22: fffffdffbf7df2c0 x21: ffff0000c27c48b0
[ 1013.551285] x20: ffff800083a946d0 x19: 0000000000000004 x18: ffffffffffffffff
[ 1013.552263] x17: 0000000000000000 x16: 0000000000000000 x15: ffff800084b13568
[ 1013.553292] x14: ffffffffffffffff x13: ffff800084b13566 x12: 6e69746365707865
[ 1013.554423] x11: fffffffffffe0000 x10: ffff800083b18b68 x9 : ffff80008014c874
[ 1013.555231] x8 : 00000000ffffefff x7 : ffff800083b16318 x6 : 0000000000002850
[ 1013.555965] x5 : 40000000fffff1ae x4 : 0000000000000fff x3 : 0000000000000000
[ 1013.556779] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0000c24a1bc0
[ 1013.557627] Call trace:
[ 1013.557960]  scan_swap_map_try_ssd_cluster+0x340/0x370
[ 1013.558498]  get_swap_pages+0x23c/0xc20
[ 1013.558899]  folio_alloc_swap+0x5c/0x248
[ 1013.559544]  add_to_swap+0x40/0xf0
[ 1013.559904]  shrink_folio_list+0x6dc/0xf20
[ 1013.560289]  reclaim_folio_list+0x8c/0x168
[ 1013.560710]  reclaim_pages+0xfc/0x178
[ 1013.561079]  madvise_cold_or_pageout_pte_range+0x8d8/0xf28
[ 1013.561524]  walk_pgd_range+0x390/0x808
[ 1013.561920]  __walk_page_range+0x1e0/0x1f0
[ 1013.562370]  walk_page_range+0x1f0/0x2c8
[ 1013.562888]  madvise_pageout+0xf8/0x280
[ 1013.563388]  madvise_vma_behavior+0x314/0xa20
[ 1013.563982]  madvise_walk_vmas+0xc0/0x128
[ 1013.564386]  do_madvise.part.0+0x110/0x558
[ 1013.564792]  __arm64_sys_madvise+0x68/0x88
[ 1013.565333]  invoke_syscall+0x50/0x128
[ 1013.565737]  el0_svc_common.constprop.0+0x48/0xf8
[ 1013.566285]  do_el0_svc+0x28/0x40
[ 1013.566667]  el0_svc+0x50/0x150
[ 1013.567094]  el0t_64_sync_handler+0x13c/0x158
[ 1013.567501]  el0t_64_sync+0x1a4/0x1a8
[ 1013.568058] irq event stamp: 0
[ 1013.568661] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[ 1013.569560] hardirqs last disabled at (0): [<ffff8000800add44>] copy_process+0x654/0x19a8
[ 1013.570167] softirqs last  enabled at (0): [<ffff8000800add44>] copy_process+0x654/0x19a8
[ 1013.570846] softirqs last disabled at (0): [<0000000000000000>] 0x0
[ 1013.571330] ---[ end trace 0000000000000000 ]---
Iteration 1: swpout inc: 226, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 2: swpout inc: 229, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 3: swpout inc: 229, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 4: swpout inc: 226, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 5: swpout inc: 227, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 6: swpout inc: 218, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 7: swpout inc: 225, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 8: swpout inc: 227, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 9: swpout inc: 224, swpout fallback inc: 2, Fallback percentage: 0.88%
Iteration 10: swpout inc: 213, swpout fallback inc: 11, Fallback percentage: 4.91%
Iteration 11: swpout inc: 219, swpout fallback inc: 9, Fallback percentage: 3.95%
Iteration 12: swpout inc: 207, swpout fallback inc: 20, Fallback percentage: 8.81%
Iteration 13: swpout inc: 193, swpout fallback inc: 33, Fallback percentage: 14.60%
Iteration 14: swpout inc: 215, swpout fallback inc: 19, Fallback percentage: 8.12%
Iteration 15: swpout inc: 217, swpout fallback inc: 12, Fallback percentage: 5.24%
Iteration 16: swpout inc: 207, swpout fallback inc: 15, Fallback percentage: 6.76%
Iteration 17: swpout inc: 207, swpout fallback inc: 23, Fallback percentage: 10.00%
Iteration 18: swpout inc: 198, swpout fallback inc: 30, Fallback percentage: 13.16%
Iteration 19: swpout inc: 199, swpout fallback inc: 26, Fallback percentage: 11.56%
Iteration 20: swpout inc: 197, swpout fallback inc: 27, Fallback percentage: 12.05%
Iteration 21: swpout inc: 192, swpout fallback inc: 25, Fallback percentage: 11.52%
Iteration 22: swpout inc: 190, swpout fallback inc: 30, Fallback percentage: 13.64%
Iteration 23: swpout inc: 203, swpout fallback inc: 27, Fallback percentage: 11.74%
Iteration 24: swpout inc: 197, swpout fallback inc: 32, Fallback percentage: 13.97%
Iteration 25: swpout inc: 184, swpout fallback inc: 41, Fallback percentage: 18.22%
Iteration 26: swpout inc: 203, swpout fallback inc: 28, Fallback percentage: 12.12%
Iteration 27: swpout inc: 193, swpout fallback inc: 31, Fallback percentage: 13.84%
Iteration 28: swpout inc: 191, swpout fallback inc: 43, Fallback percentage: 18.38%
Iteration 29: swpout inc: 194, swpout fallback inc: 31, Fallback percentage: 13.78%
Iteration 30: swpout inc: 180, swpout fallback inc: 50, Fallback percentage: 21.74%
Iteration 31: swpout inc: 205, swpout fallback inc: 22, Fallback percentage: 9.69%
Iteration 32: swpout inc: 199, swpout fallback inc: 24, Fallback percentage: 10.76%
Iteration 33: swpout inc: 192, swpout fallback inc: 34, Fallback percentage: 15.04%
Iteration 34: swpout inc: 186, swpout fallback inc: 38, Fallback percentage: 16.96%
Iteration 35: swpout inc: 190, swpout fallback inc: 32, Fallback percentage: 14.41%
Iteration 36: swpout inc: 181, swpout fallback inc: 41, Fallback percentage: 18.47%
Iteration 37: swpout inc: 181, swpout fallback inc: 47, Fallback percentage: 20.61%
Iteration 38: swpout inc: 173, swpout fallback inc: 45, Fallback percentage: 20.64%
Iteration 39: swpout inc: 196, swpout fallback inc: 27, Fallback percentage: 12.11%
Iteration 40: swpout inc: 195, swpout fallback inc: 27, Fallback percentage: 12.16%
Iteration 41: swpout inc: 195, swpout fallback inc: 31, Fallback percentage: 13.72%
Iteration 42: swpout inc: 189, swpout fallback inc: 34, Fallback percentage: 15.25%
Iteration 43: swpout inc: 185, swpout fallback inc: 41, Fallback percentage: 18.14%
Iteration 44: swpout inc: 189, swpout fallback inc: 34, Fallback percentage: 15.25%
Iteration 45: swpout inc: 177, swpout fallback inc: 49, Fallback percentage: 21.68%
Iteration 46: swpout inc: 193, swpout fallback inc: 36, Fallback percentage: 15.72%
Iteration 47: swpout inc: 197, swpout fallback inc: 30, Fallback percentage: 13.22%
Iteration 48: swpout inc: 188, swpout fallback inc: 24, Fallback percentage: 11.32%
Iteration 49: swpout inc: 187, swpout fallback inc: 29, Fallback percentage: 13.43%
Iteration 50: swpout inc: 181, swpout fallback inc: 48, Fallback percentage: 20.96%
Iteration 51: swpout inc: 191, swpout fallback inc: 28, Fallback percentage: 12.79%
Iteration 52: swpout inc: 184, swpout fallback inc: 43, Fallback percentage: 18.94%
Iteration 53: swpout inc: 184, swpout fallback inc: 44, Fallback percentage: 19.30%
Iteration 54: swpout inc: 173, swpout fallback inc: 49, Fallback percentage: 22.07%
Iteration 55: swpout inc: 170, swpout fallback inc: 47, Fallback percentage: 21.66%
Iteration 56: swpout inc: 185, swpout fallback inc: 43, Fallback percentage: 18.86%
Iteration 57: swpout inc: 178, swpout fallback inc: 55, Fallback percentage: 23.61%
Iteration 58: swpout inc: 178, swpout fallback inc: 50, Fallback percentage: 21.93%
Iteration 59: swpout inc: 181, swpout fallback inc: 45, Fallback percentage: 19.91%
Iteration 60: swpout inc: 180, swpout fallback inc: 45, Fallback percentage: 20.00%
Iteration 61: swpout inc: 172, swpout fallback inc: 56, Fallback percentage: 24.56%
Iteration 62: swpout inc: 184, swpout fallback inc: 44, Fallback percentage: 19.30%
Iteration 63: swpout inc: 174, swpout fallback inc: 42, Fallback percentage: 19.44%
Iteration 64: swpout inc: 166, swpout fallback inc: 51, Fallback percentage: 23.50%
Iteration 65: swpout inc: 172, swpout fallback inc: 57, Fallback percentage: 24.89%
Iteration 66: swpout inc: 180, swpout fallback inc: 40, Fallback percentage: 18.18%
Iteration 67: swpout inc: 173, swpout fallback inc: 63, Fallback percentage: 26.69%
Iteration 68: swpout inc: 186, swpout fallback inc: 43, Fallback percentage: 18.78%
Iteration 69: swpout inc: 175, swpout fallback inc: 53, Fallback percentage: 23.25%
Iteration 70: swpout inc: 170, swpout fallback inc: 54, Fallback percentage: 24.11%
Iteration 71: swpout inc: 166, swpout fallback inc: 62, Fallback percentage: 27.19%
Iteration 72: swpout inc: 169, swpout fallback inc: 54, Fallback percentage: 24.22%
Iteration 73: swpout inc: 175, swpout fallback inc: 50, Fallback percentage: 22.22%
Iteration 74: swpout inc: 160, swpout fallback inc: 60, Fallback percentage: 27.27%
Iteration 75: swpout inc: 173, swpout fallback inc: 45, Fallback percentage: 20.64%
Iteration 76: swpout inc: 172, swpout fallback inc: 61, Fallback percentage: 26.18%
Iteration 77: swpout inc: 173, swpout fallback inc: 50, Fallback percentage: 22.42%
Iteration 78: swpout inc: 160, swpout fallback inc: 65, Fallback percentage: 28.89%
Iteration 79: swpout inc: 165, swpout fallback inc: 61, Fallback percentage: 26.99%
Iteration 80: swpout inc: 183, swpout fallback inc: 43, Fallback percentage: 19.03%
Iteration 81: swpout inc: 206, swpout fallback inc: 22, Fallback percentage: 9.65%
Iteration 82: swpout inc: 176, swpout fallback inc: 49, Fallback percentage: 21.78%
Iteration 83: swpout inc: 184, swpout fallback inc: 45, Fallback percentage: 19.65%
Iteration 84: swpout inc: 181, swpout fallback inc: 45, Fallback percentage: 19.91%
Iteration 85: swpout inc: 175, swpout fallback inc: 56, Fallback percentage: 24.24%
Iteration 86: swpout inc: 157, swpout fallback inc: 59, Fallback percentage: 27.31%
Iteration 87: swpout inc: 171, swpout fallback inc: 54, Fallback percentage: 24.00%
Iteration 88: swpout inc: 189, swpout fallback inc: 34, Fallback percentage: 15.25%
Iteration 89: swpout inc: 185, swpout fallback inc: 45, Fallback percentage: 19.57%
Iteration 90: swpout inc: 173, swpout fallback inc: 49, Fallback percentage: 22.07%
Iteration 91: swpout inc: 170, swpout fallback inc: 58, Fallback percentage: 25.44%
Iteration 92: swpout inc: 184, swpout fallback inc: 44, Fallback percentage: 19.30%
Iteration 93: swpout inc: 193, swpout fallback inc: 37, Fallback percentage: 16.09%
Iteration 94: swpout inc: 181, swpout fallback inc: 38, Fallback percentage: 17.35%
Iteration 95: swpout inc: 205, swpout fallback inc: 25, Fallback percentage: 10.87%
Iteration 96: swpout inc: 164, swpout fallback inc: 49, Fallback percentage: 23.00%
Iteration 97: swpout inc: 158, swpout fallback inc: 65, Fallback percentage: 29.15%
Iteration 98: swpout inc: 168, swpout fallback inc: 57, Fallback percentage: 25.33%
Iteration 99: swpout inc: 163, swpout fallback inc: 56, Fallback percentage: 25.57%
Iteration 100: swpout inc: 180, swpout fallback inc: 44, Fallback percentage: 19.64%

It is getting worse than test C but still way better than test
A and B.

I previously observed a 100% fallback ratio in test v1 on an actual phone, especially
when order-0 and mthp were combined within one zRAM. This likely triggered a scenario
where order-0 had to scan swap to locate free slots, resulting in fragmentation
across all clusters.

Not quite sure if this still happens in v2. Will arrange a phone test next week. If
yes, I am still eager to see some approach to prevent order-0 from spreading across
all clusters.

BTW, Chris,

Is the warning "expecting order 4 got 0" normal in the above test?

>
> Yep, I alter changelogs all the time.
>
> > >
> > > I'll add this into mm-unstable now for some exposure, but at this point
> > > I'm not able to determine whether it should go in as a hotfix for
> > > 6.10-rcX.
> >
> > Maybe not need to be a hotfix. Not all Barry's mTHP swap out and swap
> > in patch got merged yet.

This could be a hotfix, considering swapping out a mTHP is slower than
swapping nr_pages small folios with the overhead of splitting folio
if we have to fallback. Ryan had the regression data before[1]

"
| alloc size |                baseline |           + this series |
|            | mm-unstable (~v6.9-rc1) |                         |
|:-----------|------------------------:|------------------------:|
| 4K Page    |                    0.0% |                    1.3% |
| 64K THP    |                  -13.6% |                   46.3% |
| 2M THP     |                   91.4% |                   89.6% |

So with this change, the 64K swap performance goes from a 14% regression to a
46% improvement. While 2M shows a small regression I'm confident that this is
just noise."

Ryan reported a 14% regression if mthp can not be swapped out as a whole
comparing to only using small folios.

[1] https://lore.kernel.org/all/20240408183946.2991168-1-ryan.roberts@arm.com/

>
> OK, well please let's give appropriate consideration to what we should
> add to 6.10-rcX in order to have this feature working well.

Thanks
Barry


