Return-Path: <linux-kernel+bounces-282588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A814394E630
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 07:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD9541C20D8B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 05:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620B414D420;
	Mon, 12 Aug 2024 05:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPnYUlA1"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7653C0B
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 05:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723441016; cv=none; b=DUq87sbktPgGRyrjISgZNM7p7+Fl2GQYo/eH/z/CD+x8kXAQm5X0lCXBZRF3jWalch5qpKPTK5qxBBbfoHdWJNd+jMk+JRvJ/8zijKwfOYR10CNMfNEhiJKb413ovcY4f1A/aIUCnLbu2ii4ZJrAVb+dv9iX6Cs3V30NUjdXZy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723441016; c=relaxed/simple;
	bh=OjtUQVGraMUrucHTdAoAEOxoG0nrrZguKhnESuYTvh4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gO2JmdMYBz+e1GjuIVKMrvQxY783ZbzKY2MUQTOjP0/3ij0kd132IoMnIi2vavN+7r4jeLIp4U/cQ69mtDbzEtZ0u4ceArmiQbD3xDjKD12NbTr9sv4q6op7kZ/baUzAxei9CkHe+KwufIIhTvSspTi7GKsGzT+J1E94iTdGdkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JPnYUlA1; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2d1e3381cb1so1875963a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 22:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723441014; x=1724045814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jyZ910m1lZNBWKgHfLt3Qbj6V+WoKDjZ9MkwYi8mfBQ=;
        b=JPnYUlA1aVPEeXWxX/vk1uZEa7Ioiy9+RJUM5ECb+skibm+/O+t72xqbdc/yLEubtD
         s6G6wnLSU3gpBwuIbVGTVRDeGOx/czEg+bUoXNUU9w+1OIKExw9dSmgATClj+OMoC3l2
         VAa4DZj5yZjtHFG3DogEaulenUiqE13CmipWEaDDGAOVnDurkzGb90YKBbYWPchNu6cP
         EU4/w62Elvnh1iYTHFynhohTrlXF3AvV+4cg/MqwpBDL+8Ukr+HKRGGMcbAwgC95Bsfy
         cKhs327E7oCbESM/pXpqfrWcOLZapXawF7VEVPOszazCod4W6hSNY/ccfnx7mKl6CnRC
         JSmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723441014; x=1724045814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jyZ910m1lZNBWKgHfLt3Qbj6V+WoKDjZ9MkwYi8mfBQ=;
        b=h3WOnxZKYlT2dplykaDLlRU1XQKgtKSm6Cs36e5uafOcaz0HrgvpaEVY39yZL/A4YR
         WQgQHo7NSeCFipg1RSlriFZUPsdVhe9O2ZECW0OH2M2UxysHnNykVEKGHNRvGS50wcme
         BQJwV+IcfFigolks3i3UI4heJ9/JPj4y7jV1I8PXsNzbE76GNg/xPFCTx27+gLCZrRUq
         NYQP4dndyvdCeb66YST4HiJhFyTJst6dt6+EOtBX86euK+ZGnI+SZ60K9b233gjWGVML
         2QyzuwgGVHg4GyHnlh/7ZT1eQvNZxR44A9hOX8d9mLLT9TantuGQ0IIg2DS84oCKOXT/
         tvJA==
X-Forwarded-Encrypted: i=1; AJvYcCVgWZ/rNFYO8KUJQW3reBLKWlYOmroDc6IGwZco6pNV73K+EeU05mr/x4G/5/Km9b+YRa/SO8F8ZGuF+zU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl82K21HmwIUnYIi/6TSqnOwJ+VjFUNO73s6cdtRZW09/aPqZc
	MzCZ0XMn9JlfULD846926OCwMReeLFiEBx6sWY7Jq4imuUN7pJ2S
X-Google-Smtp-Source: AGHT+IESOwZIqsfgv5lhz7MC+AFDRnX7pQbmjVcrgC/2lAPP3zsHjQXKgsTA1XwVZcht6NuI+mabLw==
X-Received: by 2002:a17:90a:9cb:b0:2ca:8a93:a40b with SMTP id 98e67ed59e1d1-2d1e80512b7mr9080297a91.31.1723441013825;
        Sun, 11 Aug 2024 22:36:53 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1c9dc8712sm7242147a91.49.2024.08.11.22.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 22:36:53 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: david@redhat.com
Cc: akpm@linux-foundation.org,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	corbet@lwn.net,
	ioworker0@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ryan.roberts@arm.com
Subject: Re: [PATCH v2] mm: Override mTHP "enabled" defaults at kernel cmdline
Date: Mon, 12 Aug 2024 17:36:36 +1200
Message-Id: <20240812053636.97700-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <8258bf4c-ecec-4e06-ada0-da9fb99b1219@redhat.com>
References: <8258bf4c-ecec-4e06-ada0-da9fb99b1219@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, Aug 10, 2024 at 1:15 AM David Hildenbrand <david@redhat.com> wrote:
>
> >>>>> -You can change the sysfs boot time defaults of Transparent Hugepage
> >>>>> -Support by passing the parameter ``transparent_hugepage=always`` or
> >>>>> -``transparent_hugepage=madvise`` or ``transparent_hugepage=never``
> >>>>> -to the kernel command line.
> >>>>> +You can change the sysfs boot time default for the top-level "enabled"
> >>>>> +control by passing the parameter ``transparent_hugepage=always`` or
> >>>>> +``transparent_hugepage=madvise`` or ``transparent_hugepage=never`` to the
> >>>>> +kernel command line.
> >>>>> +
> >>>>> +Alternatively, each supported anonymous THP size can be controlled by
> >>>>> +passing ``thp_anon=<size>[KMG]:<state>``, where ``<size>`` is the THP size
> >>>>> +and ``<state>`` is one of ``always``, ``madvise``, ``never`` or
> >>>>> +``inherit``.
> >>>>> +
> >>>>> +For example, the following will set 64K THP to ``always``::
> >>>>> +
> >>>>> +     thp_anon=64K:always
> >>>>> +
> >>>>> +``thp_anon=`` may be specified multiple times to configure all THP sizes as
> >>>>> +required. If ``thp_anon=`` is specified at least once, any anon THP sizes
> >>>>> +not explicitly configured on the command line are implicitly set to
> >>>>> +``never``.
> >>>>
> >>>> I suggest documenting that "thp_anon=" will not effect the value of
> >>>> "transparent_hugepage=", or any configured default.
> >
> > Did you see the previous conversation with Barry about whether or not to honour
> > configured defaults when any thp_anon= is provided [1]? Sounds like you also
> > think we should honour the PMD "inherit" default if not explicitly provided on
> > the command line? (see link for justification for the approach I'm currently
> > taking).
>
> I primarily think that we should document it :)
>
> What if someone passes "transparent_hugepage=always" and "thp_anon=..."?
> I would assume that transparent_hugepage would only affect the global
> toggle then?
>
> >
> > [1]
> > https://lore.kernel.org/linux-mm/CAGsJ_4x8ruPspuk_FQVggJMWcXLbRuZFq44gg-Dt7Ewt3ExqTw@mail.gmail.com/
> >
> >>>>
> >>>> Wondering if a syntax like
> >>>>
> >>>> thp_anon=16K,32K,64K:always;1048K,2048K:madvise
> >
> > Are there examples of that syntax already or have you just made it up? I found
> > examples with the colon (:) but nothing this fancy. I guess that's not a reason
> > not to do it though (other than the risk of screwing up the parser in a subtle way).
>
> I made it up -- mostly ;) I think we are quite flexible on what we can
> do. As always, maybe we can keep it bit consistent with existing stuff.
>
> For hugetlb_cma we have things like
>         "<node>:nn[KMGTPE|[,<node>:nn[KMGTPE]]
>
> "memmap=" options are more ... advanced, including memory ranges. There
> are a bunch more documented in kernel-parameters.txt that have more
> elaborate formats.
>
> Ranges would probably be the most valuable addition. So maybe we should
> start with:
>
>         thp_anon=16K-64K:always,1048K-2048K:madvise
>
> So to enable all THPs it would simply be
>
>         thp_anon=16K-2M:always
>
> Interesting question what would happen if someone passes:
>
>         thp_anon=8K-2M:always
>
> Likely we simply would apply it to any size in the range, even if
> start/end is not a THP size.
>
> But we would want to complain to the user if someone only specifies a
> single one (or a range does not even select a single one) that does not
> exist:
>
>         thp_anon=8K:always

How about rejecting settings with any illegal size or policy? 

I found there are too many corner cases to say "yes" or "no". It seems
the code could be much cleaner if we simply reject illegal settings.
On the other hand, we should rely on smart users to provide correct
settings, shouldn’t we? While working one the code, I felt that
extracting partial correct settings from incorrect ones and supporting
them might be a bit of over-design.

I have tested the below code by

"thp_anon=16K-64K:always;128K,512K:inherit;256K:madvise;1M-2M:never"

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 1a12c011e2df..6a1f54cff7f9 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -81,6 +81,7 @@ unsigned long huge_zero_pfn __read_mostly = ~0UL;
 unsigned long huge_anon_orders_always __read_mostly;
 unsigned long huge_anon_orders_madvise __read_mostly;
 unsigned long huge_anon_orders_inherit __read_mostly;
+static bool anon_orders_configured;
 
 unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
 					 unsigned long vm_flags,
@@ -737,7 +738,10 @@ static int __init hugepage_init_sysfs(struct kobject **hugepage_kobj)
 	 * disable all other sizes. powerpc's PMD_ORDER isn't a compile-time
 	 * constant so we have to do this here.
 	 */
-	huge_anon_orders_inherit = BIT(PMD_ORDER);
+	if (!anon_orders_configured) {
+		huge_anon_orders_inherit = BIT(PMD_ORDER);
+		anon_orders_configured = true;
+	}
 
 	*hugepage_kobj = kobject_create_and_add("transparent_hugepage", mm_kobj);
 	if (unlikely(!*hugepage_kobj)) {
@@ -922,6 +926,103 @@ static int __init setup_transparent_hugepage(char *str)
 }
 __setup("transparent_hugepage=", setup_transparent_hugepage);
 
+static inline int get_order_from_str(const char *size_str)
+{
+	unsigned long size;
+	char *endptr;
+	int order;
+
+	size = memparse(size_str, &endptr);
+	order = fls(size >> PAGE_SHIFT) - 1;
+	if (order & ~THP_ORDERS_ALL_ANON) {
+		pr_err("invalid size in thp_anon= %ld\n", size);
+		return -EINVAL;
+	}
+
+	return order;
+}
+
+static inline void set_bits(unsigned long *var, int start, int end)
+{
+	int i;
+
+	for (i = start; i <= end; i++)
+		set_bit(i, var);
+}
+
+static inline void clear_bits(unsigned long *var, int start, int end)
+{
+	int i;
+
+	for (i = start; i <= end; i++)
+		clear_bit(i, var);
+}
+
+static char str_dup[PAGE_SIZE] __meminitdata;
+static int __init setup_thp_anon(char *str)
+{
+	char *token, *range, *policy, *subtoken;
+	char *start_size, *end_size;
+	int start, end;
+	char *p;
+
+	if (!str || strlen(str) + 1 > PAGE_SIZE)
+		goto err;
+	strcpy(str_dup, str);
+
+	p = str_dup;
+	while ((token = strsep(&p, ";")) != NULL) {
+		range = strsep(&token, ":");
+		policy = token;
+
+		if (!policy)
+			goto err;
+
+		while ((subtoken = strsep(&range, ",")) != NULL) {
+			if (strchr(subtoken, '-')) {
+				start_size = strsep(&subtoken, "-");
+				end_size = subtoken;
+
+				start = get_order_from_str(start_size);
+				end = get_order_from_str(end_size);
+			} else {
+				start = end = get_order_from_str(subtoken);
+			}
+
+			if (start < 0 || end < 0 || start > end)
+				goto err;
+
+			if (!strcmp(policy, "always")) {
+				set_bits(&huge_anon_orders_always, start, end);
+				clear_bits(&huge_anon_orders_inherit, start, end);
+				clear_bits(&huge_anon_orders_madvise, start, end);
+			} else if (!strcmp(policy, "madvise")) {
+				set_bits(&huge_anon_orders_madvise, start, end);
+				clear_bits(&huge_anon_orders_inherit, start, end);
+				clear_bits(&huge_anon_orders_always, start, end);
+			} else if (!strcmp(policy, "inherit")) {
+				set_bits(&huge_anon_orders_inherit, start, end);
+				clear_bits(&huge_anon_orders_madvise, start, end);
+				clear_bits(&huge_anon_orders_always, start, end);
+			} else if (!strcmp(policy, "never")) {
+				clear_bits(&huge_anon_orders_inherit, start, end);
+				clear_bits(&huge_anon_orders_madvise, start, end);
+				clear_bits(&huge_anon_orders_always, start, end);
+			} else {
+				goto err;
+			}
+		}
+	}
+
+	anon_orders_configured = true;
+	return 1;
+
+err:
+	pr_warn("thp_anon=%s: cannot parse(invalid size or policy), ignored\n", str);
+	return 0;
+}
+__setup("thp_anon=", setup_thp_anon);
+
 pmd_t maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
 {
 	if (likely(vma->vm_flags & VM_WRITE))
-- 
2.34.1

Everything seems to be correct:

/ # cat /sys/kernel/mm/transparent_hugepage/hugepages-16kB/enabled 
[always] inherit madvise never
/ # cat /sys/kernel/mm/transparent_hugepage/hugepages-32kB/enabled 
[always] inherit madvise never
/ # cat /sys/kernel/mm/transparent_hugepage/hugepages-64kB/enabled 
[always] inherit madvise never
/ # cat /sys/kernel/mm/transparent_hugepage/hugepages-128kB/enabled 
always [inherit] madvise never
/ # cat /sys/kernel/mm/transparent_hugepage/hugepages-256kB/enabled 
always inherit [madvise] never
/ # cat /sys/kernel/mm/transparent_hugepage/hugepages-512kB/enabled 
always [inherit] madvise never
/ # cat /sys/kernel/mm/transparent_hugepage/hugepages-1024kB/enabled 
always inherit madvise [never]
/ # cat /sys/kernel/mm/transparent_hugepage/hugepages-2048kB/enabled 
always inherit madvise [never]

>
> >
> >>>>
> >>>> (one could also support ranges, like "16K-64K")
> >>>>
> >>>> Would be even better. Then, maybe only allow a single instance.
> >>>>
> >>>> Maybe consider it if it's not too crazy to parse ;)
> > I'll take a look. I'm going to be out for 3 weeks from end of Monday though, so
>
> Oh, lucky you! Enjoy!
>
> > probably won't get around to that until I'm back. I know Barry is keen to get
> > this merged, so Barry, if you'd like to take it over that's fine by me (I'm sure
> > you have enough on your plate though).
>
>
> --
> Cheers,
>
> David / dhildenb
>

Thanks
Barry


