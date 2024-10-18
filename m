Return-Path: <linux-kernel+bounces-371041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8379A358A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 08:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F3DD283727
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 06:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB58B185B54;
	Fri, 18 Oct 2024 06:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="PCv/TW1E"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543E92BAEF
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 06:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729233444; cv=none; b=iRPkoJcCBnZmy4yPKx1oB1bSKSWNV/7B7nvn3fr0rZH0u/LtXgLC403uoCfzPlaTywzJD65JrNTyJ2TfJ7OIvy+HCwq4gikgx2WuKK5xpLZLShD5HWsvNRD06BGbUeqMAvPVrrqS5RslnG/7GW1CCcnDT/KwjunGcEuf/gyTi8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729233444; c=relaxed/simple;
	bh=jhYdxGw+rbLV/GTXUSKoq8ZBPbDKn52SOsmEf/GwK9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cFvwkigmERUe39yaAT6aZSc82MhkM+YH2ZMTo53hsbR7OgswIEjo0twoM9+juN9i8QFeI518SEX+JDAO5BzXunpVjyDeFeNuUhoC8Q2hl0KwDUGFTp0ZlXfVxbn+BbnrsWWbolXj6YNXAk0QVJ187Cka8THuMIJ0tW+U0aY33qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=PCv/TW1E; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7181a8af549so174874a34.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 23:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1729233441; x=1729838241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t1jrZ8YN24qm5CmAzCkUgGJbbjPxk1uBYoONZzHzRrw=;
        b=PCv/TW1Er5oD89UsH7GHMB9ro7MPW3g5pz3mnydQRyQh3RqZg7t+C86mu+y21r40TP
         PZmeIyv6bdCSPwBzHPDGzSndBMSDfgt5MT3BVy6PapRKKXz2MUwsogrWy8zSDiv7yrrI
         1Wwnc/FUKOukeVL1vF2ceSngf0VU3gLgP4fGtSnvKwM4ClEsX1tCKqYGxgF/MFKr3ksG
         q1nGixne4GBdef1bMUFuBpqqs2ZXQgw46EGPZLbtAIT/oj3JD7oQ4pNpTMYASOcdcrqt
         GcePINntltup9m/8eryPNlNzwhyK1ZMu8KRNmJ4cNYRxaIlpQfKl/jEckLs1nT2ThutJ
         dQoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729233441; x=1729838241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t1jrZ8YN24qm5CmAzCkUgGJbbjPxk1uBYoONZzHzRrw=;
        b=ugd9cslescvN8VwRuXEjA5zYLdW/Zk1WUpJl3AK1VkDIUiOwEQdwaAPW/uTl5klcKb
         77uvh5+5ti09Yj6mbZpq5K6BQlRSYTUJYXGmzv+r+t9UC2U48kGTLoD4ZrPMzIUWRDrn
         JWDu+P7NkUEexGl5QT1wuDNNEZ3PJ8axGOormu+Cgz1TfY7wAvlYotm+tgeHnlnHRaCq
         5PBohDJ8/QjMQH8hn82vaqDk8IqaeNU/Mzh6yZZLwUee3DR/Pipn8r7EHpj5U5W250HG
         3Ag4576hdD7obNZqhnmKoosqFkDCc7TfwX9VgXrBuQWNtSI1hpcGnYLJFPYt/4jfMw5Y
         Bb9Q==
X-Forwarded-Encrypted: i=1; AJvYcCW37wJzwwz/y9gsee7V1fIhh2ZO5OfPYwhUlHCnTkgSGWLI5nzElMpnASn/ADYxTD367Z4v4h7PR9P/xL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdQsdbqufy3CvV4vlJXntkSN9WFjUaYMF8A0xknqjamrMyfWQ5
	NeJsICwEmrweVSqGNIIcjX0f+QLeM7Wohb/w6eZpQ31y+qvcji9OV4VYdZu0JIU=
X-Google-Smtp-Source: AGHT+IFn9uKAYqxeIHcBhEtVAzeVdVtGgLCawnaOi087//SWtVli/uKCehKFYsPaoX8aH6BzIlqxLA==
X-Received: by 2002:a05:6830:f8c:b0:713:ba39:641c with SMTP id 46e09a7af769-7181a5de231mr712381a34.6.1729233441232;
        Thu, 17 Oct 2024 23:37:21 -0700 (PDT)
Received: from GQ6QX3JCW2.bytedance.net ([203.208.189.10])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eacc28b881sm638650a12.57.2024.10.17.23.37.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 17 Oct 2024 23:37:20 -0700 (PDT)
From: lizhe.67@bytedance.com
To: willy@infradead.org
Cc: akpm@linux-foundation.org,
	boqun.feng@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lizhe.67@bytedance.com,
	longman@redhat.com,
	mingo@redhat.com,
	peterz@infradead.org,
	will@kernel.org
Subject: Re: [RFC 2/2] khugepaged: use upgrade_read() to optimize collapse_huge_page
Date: Fri, 18 Oct 2024 14:37:12 +0800
Message-ID: <20241018063712.44028-1-lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <ZxEPDMUnYlAy3r3_@casper.infradead.org>
References: <ZxEPDMUnYlAy3r3_@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 17 Oct 2024 14:20:12 +0100, willy@infradead.org wrote:

> On Thu, Oct 17, 2024 at 02:18:41PM +0800, lizhe.67@bytedance.com wrote:
> > On Wed, 16 Oct 2024 12:53:15 +0100, willy@infradead.org wrote:
> > 
> > >On Wed, Oct 16, 2024 at 12:36:00PM +0800, lizhe.67@bytedance.com wrote:
> > >> From: Li Zhe <lizhe.67@bytedance.com>
> > >> 
> > >> In function collapse_huge_page(), we drop mmap read lock and get
> > >> mmap write lock to prevent most accesses to pagetables. There is
> > >> a small time window to allow other tasks to acquire the mmap lock.
> > >> With the use of upgrade_read(), we don't need to check vma and pmd
> > >> again in most cases.
> > >
> > >This is clearly a performance optimisation.  So you must have some
> > >numebrs that justify this, please include them.
> > 
> > Yes, I will add the relevant data to v2 patch.
> 
> How about telling us all now so we know whether to continue discussing
> this?

In my test environment, function collapse_huge_page() only achieved a 0.25%
performance improvement. I use ftrace to get the execution time of
collapse_huge_page(). The test code and test command are as follows.

(1) Test result:

			average execution time of collapse_huge_page()
before this patch: 		1611.06283 us
after this patch:               1597.01474 us

(2) Test code:

#define MMAP_SIZE (2ul*1024*1024)
#define ALIGN(x, mask)  (((x) + ((mask)-1)) & ~((mask)-1))
int main(void)
{
	int num = 100;
	size_t page_sz = getpagesize();
	while (num--) {
		size_t index;
		unsigned char *p_map;
		unsigned char *p_map_real;
		p_map = (unsigned char *)mmap(0, 2 * MMAP_SIZE, PROT_READ | PROT_WRITE, MAP_PRIVATE|MAP_ANON, -1, 0); 
		if (p_map == MAP_FAILED) { 
			printf("mmap fail\n"); 
			return -1;
		} else {
			p_map_real = (char *)ALIGN((unsigned long)p_map, MMAP_SIZE);
			printf("mmap get %p, align to %p\n", p_map, p_map_real);
		}
		for(index = 0; index < MMAP_SIZE; index += page_sz)
			p_map_real[index] = 6;
		int ret = madvise(p_map_real, MMAP_SIZE, 25);
		printf("ret is %d\n", ret);
		munmap(p_map, 2 * MMAP_SIZE); 
	}
	return 0;
}

(3) Test command:
echo never > /sys/kernel/mm/transparent_hugepage/enabled
gcc test.c -o test
trace-cmd record -p function_graph -g collapse_huge_page --max-graph-depth 1 ./test

The optimization of the function collapse_huge_page() seems insignificant.
I am not sure whether it will have a more obvious optimization effect in
other scenarios.

