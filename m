Return-Path: <linux-kernel+bounces-311267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA789686E8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF2C51F23529
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6756187335;
	Mon,  2 Sep 2024 12:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B20T7JXO"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AD618455C
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 12:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725278489; cv=none; b=mk+XYB+iCy6NR0OBMHmALvO/w99DyLVzVNpqmf9QIZs4sd6I97sRkxvELfhw1/OTZOcMspM4idAfnKbG4hJYEzeyg97ICIvRNyi44Y6CvmF6qwrDf921Ku2N7URkgbbXoLkAL+XiogLC5F8T+frXlsm4ZkjZWtaenuG2yRpRLMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725278489; c=relaxed/simple;
	bh=Fz3saM24crCHYE/RGK1KRoH8WHUwKUnos/Sbau/18Zk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HS2hSYUjvxdOKJeRayrC2sG6pa7EmuQWHlyRqLZ0xX29iAXIjX63XlGee11l5xuzsDM/iXp5HpQx3PERQ1TuU5XC1nWWChSNR6YhkyjyTK2EYSA+ptze7rOavjII701MiksdzIysUeG2ad5zQnnKZaIP3FqNVbrvQC/RY3Admhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B20T7JXO; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-714287e4083so3738623b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 05:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725278487; x=1725883287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+nuRHHUZafLxE38ll9TYEkwvvW3M7ChZMkf4+qF48X4=;
        b=B20T7JXOooYctNQjXw4nQ2XiwvP75/A5EURIybFlpCEHBHYTOx5EL2hwnQAxQwV5V5
         SeW/0K9FPoEuQMtN9g00dkdo0NHgugZCEJlNlb+8co16dJS3iNwCiUZK9b9D+DnvSkwI
         VcEnX6RqjvTFjkSRVBWdZOoEfxKv9zwrBhl3TeCC+EiP79HQKqS62Edm86KPDdRfSOHt
         IieSPIzKEYZPAMVjWt5Y7cNgJjI0tsfQAnJKoddvyivPkyoBluKnYewpQEjqWpjkDPqe
         JjYTtTHi9a0TCFQzUclqmGys3xCdQ5PDd/8OySjUXKHyaBVVp9R4RzLD+n5nwT9veG10
         GvBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725278487; x=1725883287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+nuRHHUZafLxE38ll9TYEkwvvW3M7ChZMkf4+qF48X4=;
        b=BwXbueRvXPMwpmLZ2pF9w7NpEa058E9HtyH/TrZh/GWINkvDuXoPvX/H/2ymSy2U67
         M4nA3iu+EkvACXkO1iYtbNPeox6IYczz64BVlhdb9NqzIPtTb0Euh6V+FhQHN4qQNkK9
         JaT+1iTuvvYW5/NQE346dqDbjBKOYZloMZvi8cHtHhOZ/fcpFGGVo0ZtFKwwEaFei81L
         c0lvLHWLOgI6NQTB2rLkQWmeUZn/DmwIyg17HguGimf3ooE4DubBLTiyzyorVFKgqfaR
         3WR0U3FxLhgY7PZtcbMbh1qYON1/oRyYyrwIWFsdxMsNXP4P+fBBEkvTs9QffWG05xzi
         ZFfw==
X-Forwarded-Encrypted: i=1; AJvYcCVu5iebHRkgbJp8EUKJVQeb880b6XffI9M91aKNlHn8ErSkCtgNpCl3S/2Mj2xl9C2IahmLFlOIxqjI+r4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLS9RHw6Dw92nKpqLA3yILupS/Vd617HfezGXwnnqRQJqTeJfj
	zlG29bCitb2ef5N+hZdlUo2Xbc9SrfKIx/KLUg7s6XoX7Iy+1jvR
X-Google-Smtp-Source: AGHT+IFIJaVoXRr0zOyLAI4g5pO2EXMnFNT7+UZOmEa9GhJfede9guyxDTgzjbp1STjLZCXX/4WCkw==
X-Received: by 2002:a05:6a00:178d:b0:706:31d9:9c99 with SMTP id d2e1a72fcca58-7173b399f1dmr9763962b3a.0.1725278485035;
        Mon, 02 Sep 2024 05:01:25 -0700 (PDT)
Received: from AHUANG12-3ZHH9X.lenovo.com (220-143-210-230.dynamic-ip.hinet.net. [220.143.210.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e55b9d11sm6909196b3a.90.2024.09.02.05.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 05:01:24 -0700 (PDT)
From: Adrian Huang <adrianhuang0701@gmail.com>
X-Google-Original-From: Adrian Huang <ahuang12@lenovo.com>
To: urezki@gmail.com
Cc: adrianhuang0701@gmail.com,
	ahuang12@lenovo.com,
	akpm@linux-foundation.org,
	hch@infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 1/1] mm: vmalloc: Optimize vmap_lazy_nr arithmetic when purging each vmap_area
Date: Mon,  2 Sep 2024 20:00:46 +0800
Message-Id: <20240902120046.26478-1-ahuang12@lenovo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ZtDFQHGHMq6TfbKA@pc636>
References: <ZtDFQHGHMq6TfbKA@pc636>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, Aug 30, 2024 at 3:00 AM Uladzislau Rezki <urezki@gmail.com> wrote:
> atomic_long_add_return() might also introduce a high contention. We can
> optimize by splitting into more light atomics. Can you check it on your
> 448-cores system?

Interestingly, the following result shows the latency of
free_vmap_area_noflush() is just 26 usecs (The worst case is 16ms-32ms).

/home/git-repo/bcc/tools/funclatency.py -u free_vmap_area_noflush & pid1=$! && sleep 8 && modprobe test_vmalloc nr_threads=$(nproc) run_test_mask=0x7; kill -SIGINT $pid1

         usecs       : count     distribution
         0 -> 1      : 18166     |                                        |
         2 -> 3      : 41929818  |**                                      |
         4 -> 7      : 181203439 |***********                             |
         8 -> 15     : 464242836 |*****************************           |
        16 -> 31     : 620077545 |****************************************|
        32 -> 63     : 442133041 |****************************            |
        64 -> 127    : 111432597 |*******                                 |
       128 -> 255    : 3441649   |                                        |
       256 -> 511    : 302655    |                                        |
       512 -> 1023   : 738       |                                        |
      1024 -> 2047   : 73        |                                        |
      2048 -> 4095   : 0         |                                        |
      4096 -> 8191   : 0         |                                        |
      8192 -> 16383  : 0         |                                        |
     16384 -> 32767  : 196       |                                        |

   avg = 26 usecs, total: 49415657269 usecs, count: 1864782753


free_vmap_area_noflush() just executes the lock prefix one time, so the
wrost case might be just about a hundred clock cycles.

The problem of purge_vmap_node() is that some cores are busy on purging
each vmap_area of the *long* purge_list and executing atomic_long_sub()
for each vmap_area, while other cores free vmalloc allocations and execute
atomic_long_add_return() in free_vmap_area_noflush(). The following crash
log shows the 22 cores are busy on purging vmap_area structs [1]:

  crash> bt -a | grep "purge_vmap_node+291" | wc -l
  22

So, the latency of purge_vmap_node() dramatically increases becase it
excutes the lock prefix over 600,0000 times. The issue can be easier
to reproduce if more cores execute purge_vmap_node() simultaneously.

[1] https://gist.github.com/AdrianHuang/c0030dd7755e673ed00cb197b76ce0a7


Tested the following patch with the light atomics. However, nothing improved 
(But, the worst case is improved):

         usecs        : count     distribution
         0 -> 1       : 7146      |                                        |
         2 -> 3       : 31734187  |**                                      |
         4 -> 7       : 161408609 |***********                             |
         8 -> 15      : 461411377 |*********************************       |
        16 -> 31      : 557005293 |****************************************|
        32 -> 63      : 435518485 |*******************************         |
        64 -> 127     : 175033097 |************                            |
       128 -> 255     : 42265379  |***                                     |
       256 -> 511     : 399112    |                                        |
       512 -> 1023    : 734       |                                        |
      1024 -> 2047    : 72        |                                        |

avg = 32 usecs, total: 59952713176 usecs, count: 1864783491

[free_vmap_area_noflush() assembly instructions wo/ the test patch]
ffffffff813e6e90 <free_vmap_area_noflush>:
...
ffffffff813e6ed4:       4c 8b 65 08             mov    0x8(%rbp),%r12
ffffffff813e6ed8:       4c 2b 65 00             sub    0x0(%rbp),%r12
ffffffff813e6edc:       49 c1 ec 0c             shr    $0xc,%r12
ffffffff813e6ee0:       4c 89 e2                mov    %r12,%rdx
ffffffff813e6ee3:       f0 48 0f c1 15 f4 2a    lock xadd %rdx,0x2bb2af4(%rip)        # ffffffff83f999e0 <vmap_lazy_nr>
ffffffff813e6eea:       bb 02
ffffffff813e6eec:       8b 0d 0e b1 a5 01       mov    0x1a5b10e(%rip),%ecx        # ffffffff82e42000 <nr_vmap_nodes>
ffffffff813e6ef2:       49 01 d4                add    %rdx,%r12
ffffffff813e6ef5:       39 c8                   cmp    %ecx,%eax
...

[free_vmap_area_noflush() assembly instructions w/ the test patch: no lock prefix]
ffffffff813e6e90 <free_vmap_area_noflush>:
...
ffffffff813e6edb:       48 8b 5d 08             mov    0x8(%rbp),%rbx
ffffffff813e6edf:       48 2b 5d 00             sub    0x0(%rbp),%rbx
ffffffff813e6ee3:       8b 0d d7 b0 a5 01       mov    0x1a5b0d7(%rip),%ecx        # ffffffff82e41fc0 <nr_vmap_nodes>
ffffffff813e6ee9:       48 c1 eb 0c             shr    $0xc,%rbx
ffffffff813e6eed:       4c 8b 25 b4 f1 92 01    mov    0x192f1b4(%rip),%r12        # ffffffff82d160a8 <vmap_nodes>
ffffffff813e6ef4:       48 01 d3                add    %rdx,%rbx
ffffffff813e6ef7:       48 89 1d e2 2a bb 02    mov    %rbx,0x2bb2ae2(%rip)        # ffffffff83f999e0 <vmap_lazy_nr>
ffffffff813e6efe:       39 c8                   cmp    %ecx,%eax
...


diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 3f9b6bd707d2..3927c541440b 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2357,8 +2357,9 @@ static void free_vmap_area_noflush(struct vmap_area *va)
 	if (WARN_ON_ONCE(!list_empty(&va->list)))
 		return;
 
-	nr_lazy = atomic_long_add_return((va->va_end - va->va_start) >>
-				PAGE_SHIFT, &vmap_lazy_nr);
+	nr_lazy = atomic_long_read(&vmap_lazy_nr);
+	nr_lazy += (va->va_end - va->va_start) >> PAGE_SHIFT;
+	atomic_long_set(&vmap_lazy_nr, nr_lazy);
 
 	/*
 	 * If it was request by a certain node we would like to

