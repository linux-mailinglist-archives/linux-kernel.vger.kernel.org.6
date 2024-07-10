Return-Path: <linux-kernel+bounces-246944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5251992C937
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 05:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C579282109
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 03:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34A622F03;
	Wed, 10 Jul 2024 03:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lVpL43Kl"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7522E15CB
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 03:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720582354; cv=none; b=ecuKMB2t7a4ZgTUrQ9s5VDYmH6A0X/GZ6r9J4zMgGSVX/I4h+9U44EBOIqbuPooUppYiZ5316aZK+cPxRP5s6szax+8hZXYh1VMzxm1WhfP5a3xc/xaI3vS89DIl6DREMynrBDO7N/frSnoGNr163XAOxy0i9L6lTWpUa/SHY+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720582354; c=relaxed/simple;
	bh=ciO9GdiFIL6HbBmJjPFekxtrSBzQtFocV6TLVRpaZ4I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O4tuOaZo4dxXljeEeEpngXmgLs46aElzgJqbvlmOgb7TjXkvylcBOYg9Tf2VZrFiIgCbem/c+0dr33q+f47c8rBxhA/L/menlduKJYg6DBaaKr2+jNHIY939q9N4HIajNdmGpxnBu30tIzIUduD2o8TDkKFHuEiS8HKzs6zcVwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lVpL43Kl; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fbc09ef46aso8838115ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 20:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720582353; x=1721187153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xQVH0SfMzB2fGcavBeBUmXLxwFGQclxpF5/YP0r+ic0=;
        b=lVpL43KlncNdkDLRyJ84vrJAZ4BZ+7Hu7pjY+NLoC/LvuXtpfFR+zTqpvMVc4pfFlL
         8UQ1IKgCKOKlHq4jYEmh073fA/t+Fa2juwkF9d14Skb9iXjmIVq+O4uQbN2zYCby+5MW
         HHfVJ2YWwlBtGhlb2N/7u6Tr/3+ctp/r3KnPE8hf4Uanm3Rckf5+5gjhfb6zLf6GqKg8
         YXLq9gPhKB9i2HwPMsAmkAbC8n7abNUF2BAKIZFiu5Fb3KEDffelJtgMIdlxAzNg1N5J
         zIAUsmZ9DQC1USJZHo+FZnSbLx4ohZ+8zTZ8W2HRgdRdH9ErHNXZNDKuRws2/B89JvT1
         t8uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720582353; x=1721187153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xQVH0SfMzB2fGcavBeBUmXLxwFGQclxpF5/YP0r+ic0=;
        b=MEksdP19COF1YwUZ6Y9pRTHkIdWpm+o19TSNxKjejgtiJ8wqayxlP5JSJv9TuOnBAI
         nFfpDmjTzD6uqa3rXZVeRErc5J0PeXGSEscLGesgVZb6B/VoYA2WK7YLrMqAgL4P5Ko5
         IFH1y/T239Cxa01EiBfjiIQRf79P1Gw5mAYijw0BQtRObifyAQNe3iXQJQ4updWBvpMm
         n+H2qC8ianOkZ6scXAji5J/ZrV28N7FtwcqqvimWUn1ck+qx5JNWhzLHlu4w1OEOye5Y
         ud6oz+bIMDZKrRU1cQ79P0yI1lwIjJMlaYB64y48eaN4nFLRrciRgQ0ojrCL7+BakZMw
         7Nxw==
X-Forwarded-Encrypted: i=1; AJvYcCWNsLRBL/ukdP7CjAFkVnZffmcdu2O4K6BerV7KFl8OJuhbGKrZyCH6u0WmTn4aKUAyNb82nF1NfBsYnnW3aMB72ElDUwRL1LXQFWG7
X-Gm-Message-State: AOJu0YzmDI1vu4OmfPqlS/FzeggkYi/N2FlFZF2H+Pwr7Nm0CWOOsyoA
	yqmycNnAjpMJugxGhy/0emmuCXLef+YbEZLr6+jPsbbhK9o3HQZw
X-Google-Smtp-Source: AGHT+IHZiB3/+XMW56ClRvapdT7LlIo/fbLLW8refL2J+bDXaexjAPms3UOkv0Tm9mcGXkZb9O3ECA==
X-Received: by 2002:a05:6a21:328a:b0:1c0:f080:ed51 with SMTP id adf61e73a8af0-1c29820388dmr5084332637.2.1720582352685;
        Tue, 09 Jul 2024 20:32:32 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6a122a1sm23946845ad.45.2024.07.09.20.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 20:32:32 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org
Cc: baohua@kernel.org,
	david@redhat.com,
	justinjiang@vivo.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	opensource.kernel@vivo.com,
	willy@infradead.org
Subject: Re: [PATCH v7] mm: shrink skip folio mapped by an exiting process
Date: Wed, 10 Jul 2024 15:32:12 +1200
Message-Id: <20240710033212.36497-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240709142312.372b20d49c6a97ecd2cd9904@linux-foundation.org>
References: <20240709142312.372b20d49c6a97ecd2cd9904@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, Jul 10, 2024 at 9:23 AM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Tue,  9 Jul 2024 20:31:15 +0800 Zhiguo Jiang <justinjiang@vivo.com> wrote:
>
> > The releasing process of the non-shared anonymous folio mapped solely by
> > an exiting process may go through two flows: 1) the anonymous folio is
> > firstly is swaped-out into swapspace and transformed into a swp_entry
> > in shrink_folio_list; 2) then the swp_entry is released in the process
> > exiting flow. This will result in the high cpu load of releasing a
> > non-shared anonymous folio mapped solely by an exiting process.
> >
> > When the low system memory and the exiting process exist at the same
> > time, it will be likely to happen, because the non-shared anonymous
> > folio mapped solely by an exiting process may be reclaimed by
> > shrink_folio_list.
> >
> > This patch is that shrink skips the non-shared anonymous folio solely
> > mapped by an exting process and this folio is only released directly in
> > the process exiting flow, which will save swap-out time and alleviate
> > the load of the process exiting.
>
> It would be helpful to provide some before-and-after runtime
> measurements, please.  It's a performance optimization so please let's
> see what effect it has.

Hi Andrew,

This was something I was curious about too, so I created a small test program
that allocates and continuously writes to 256MB of memory. Using QEMU, I set
up a small machine with only 300MB of RAM to trigger kswapd.

qemu-system-aarch64 -M virt,gic-version=3,mte=off -nographic \
 -smp cpus=4 -cpu max \
 -m 300M -kernel arch/arm64/boot/Image
 
The test program will be randomly terminated by its subprocess to trigger
the use case of this patch.

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <time.h>
#include <signal.h>

#define MEMORY_SIZE (256 * 1024 * 1024)

unsigned char *memory;

void allocate_and_write_memory()
{
    memory = (unsigned char *)malloc(MEMORY_SIZE);
    if (memory == NULL) {
        perror("malloc");
        exit(EXIT_FAILURE);
    }

    while (1)
        memset(memory, 0x11, MEMORY_SIZE);
}

int main()
{
    pid_t pid;
    srand(time(NULL));

    pid = fork();

    if (pid < 0) {
        perror("fork");
        exit(EXIT_FAILURE);
    }

    if (pid == 0) {
        int delay = (rand() % 10000) + 10000;
        usleep(delay * 1000);

	/* kill parent when it is busy on swapping */
        kill(getppid(), SIGKILL);
        _exit(0);
    } else {
        allocate_and_write_memory();

        wait(NULL);

        free(memory);
    }

    return 0;
}

I tracked the number of folios that could be redundantly
swapped out by adding a simple counter as shown below:

@@ -879,6 +880,9 @@ static bool folio_referenced_one(struct folio *folio,
                    check_stable_address_space(vma->vm_mm)) &&
                    folio_test_swapbacked(folio) &&
                    !folio_likely_mapped_shared(folio)) {
+                       static long i, size;
+                       size += folio_size(folio);
+                       pr_err("index: %d skipped folio:%lx total size:%d\n", i++, (unsigned long)folio, size);
                        pra->referenced = -1;
                        page_vma_mapped_walk_done(&pvmw);
                        return false;


This is what I have observed:

/ # /home/barry/develop/linux/skip_swap_out_test
[   82.925645] index: 0 skipped folio:fffffdffc0425400 total size:65536
[   82.925960] index: 1 skipped folio:fffffdffc0425800 total size:131072
[   82.927524] index: 2 skipped folio:fffffdffc0425c00 total size:196608
[   82.928649] index: 3 skipped folio:fffffdffc0426000 total size:262144
[   82.929383] index: 4 skipped folio:fffffdffc0426400 total size:327680
[   82.929995] index: 5 skipped folio:fffffdffc0426800 total size:393216
...
[   88.469130] index: 6112 skipped folio:fffffdffc0390080 total size:97230848
[   88.469966] index: 6113 skipped folio:fffffdffc038d000 total size:97296384
[   89.023414] index: 6114 skipped folio:fffffdffc0366cc0 total size:97300480

I observed that this patch effectively skipped 6114 folios (either 4KB or 64KB
mTHP), potentially reducing the swap-out by up to 92MB (97,300,480 bytes) during
the process exit.

Despite the numerous mistakes Zhiguo made in sending this patch, it is still
quite valuable. Please consider pulling his v9 into the mm tree for testing.

Thanks
Barry

