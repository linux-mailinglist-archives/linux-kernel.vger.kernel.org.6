Return-Path: <linux-kernel+bounces-184293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E848CA4F2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 01:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E7E71F22C84
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 23:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978604AEEA;
	Mon, 20 May 2024 23:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jkk4oy/N"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD873D3BC
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 23:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716247253; cv=none; b=b+ZJiTTsCro++tkrGgVYxAEY28cPbsWyzDyXgSDj5e92l+cM1yMDHk/URrYN0I/t5CnQ3GC3KdPHq8V8HZPen9h+l7y2/bIiUK9iEzKr3IIG2MTr4Dclwx0/4/s+S8d8dKUHHwrA71Db0L3h9lJ3V987iO1tCY5+xCWK8va0G1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716247253; c=relaxed/simple;
	bh=Da/CBR16or4UGo0B9Fv7lCV3lekLur2+eQ/p/ipcOog=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=KVYpCLjf/kk4SddYhpnMhXc23p+q/PLuPn01iGo4Ww3Ia/zyVcKQeaBEtEaZEI0xNRIlY4U3pZ4R5SrTcDHEOnJxJKdKGTspnuvhwUdsFbEnsl8s1id1VXNo9bhVMoM7AD6gjOneh5HmCLZ2iP3/D+xXQgnTHFZq6nq5z4DRMLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jkk4oy/N; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716247250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IeLkwEBul/z5hvAYOR5ch/FucXPvNElvTMYwlJONjiY=;
	b=Jkk4oy/NrMWPG9+kT1+obEjTwP9A9ORwZAyEvosIL1cckCgz+VtbCHBolR5nnnxRr2whwo
	drU6zNClyyo83qObf4ppfs35lBi3b39Wqj6hAoK04bnfa7nsVE5hAqJtTjxux8FJ5TIa83
	H0oxF5FSTKuUqwgkki0GbH0Q4LwXH14=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-hoz3_hr3NuiVDhQ86QM5Bg-1; Mon, 20 May 2024 19:20:48 -0400
X-MC-Unique: hoz3_hr3NuiVDhQ86QM5Bg-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-792bd1dc658so2272253585a.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 16:20:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716247247; x=1716852047;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IeLkwEBul/z5hvAYOR5ch/FucXPvNElvTMYwlJONjiY=;
        b=WuO6C9X0NcYThNhyCzK9aUvdhWwRGgFN86TfzscM+nZdwnBTz+9b3scWbs2NsWWz2m
         D3tWp4yhW66ccq/DEmWE35GF0qJtaYqiCqOriYqpztx4aludso7Th7UDQryVQjdRCb2o
         iR45I5TpogcUcts0b4BUcTNIag1NQLj8ZFJmH7p48bNSxsU/nCn8tAL1IzmTcwBSjb0h
         sjQ3c6B5ShKmFsg1nIGpykC4UcbnTZ4DeYkTzbX6lgNI4X941/jGiHiGbeEOFW79gdwN
         iyCUL1eajNLMbf5m8v/J9U4LM77FPt9fbmuwZa5jyHIilmqtA0SvHPYFhIts9494jHL0
         gMZg==
X-Forwarded-Encrypted: i=1; AJvYcCWMKtZ9A4dp2xoQQiqZ61STuBk8wuyNB33ljG8+MGBOvj1l0kjdbvkIm3nF2V9kZx1KzyJKZ0sL786gUlOb2he5qXi2GTTlsOLy2aMF
X-Gm-Message-State: AOJu0Yx4k8YbhqZt8hSqq5kXU8w52eTceksCBelHLXlpftg3K7RPCCZA
	rM2Q8CWlWtJYOEhLTqY8iWO9y59ECj/idCsOqnyo8wUbbI4uLhXZsRPrcM4lVHbd+Id1jRG5Fzt
	lQqZMKBT7FGacpB7FRrnEWY5nQOmiRemYUxOKtl6auMZOjjt9v1yoKRDI6DL4tG4VV2Q6Kg==
X-Received: by 2002:a05:620a:378a:b0:790:9e84:9b75 with SMTP id af79cd13be357-79470ee35b9mr1220333685a.12.1716247247095;
        Mon, 20 May 2024 16:20:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWpismoPVZlLN0ErtG17dDj9o0/D4AFXwHCL0aHduFKzUmTiJonT5jwHLii4qs5WVn6WTX9A==
X-Received: by 2002:a05:620a:378a:b0:790:9e84:9b75 with SMTP id af79cd13be357-79470ee35b9mr1220330485a.12.1716247246505;
        Mon, 20 May 2024 16:20:46 -0700 (PDT)
Received: from localhost (pool-71-184-142-128.bstnma.fios.verizon.net. [71.184.142.128])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf2fc3dbsm1232517385a.96.2024.05.20.16.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 16:20:46 -0700 (PDT)
From: Eric Chanudet <echanude@redhat.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Zhen Lei <thunder.leizhen@huawei.com>,
	Yajun Deng <yajun.deng@linux.dev>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Zhang Jianhua <chris.zjh@huawei.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Eric Chanudet <echanude@redhat.com>
Subject: [PATCH] arm64: init: override deferred_page_init_max_threads
Date: Mon, 20 May 2024 19:15:59 -0400
Message-ID: <20240520231555.395979-5-echanude@redhat.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit

This was the behavior prior to making the function arch-specific with
commit ecd096506922 ("mm: make deferred init's max threads
arch-specific")

Architectures can override the generic implementation that uses only one
CPU. Setting DEFERRED_STRUCT_PAGE_INIT and testing on a few arm64
platforms shows faster deferred_init_memmap completions:

|         | x13s        | SA8775p-ride | Ampere R137-P31 | Ampere HR330 |
|         | Metal, 32GB | VM, 36GB     | VM, 58GB        | Metal, 128GB |
|         | 8cpus       | 8cpus        | 8cpus           | 32cpus       |
|---------|-------------|--------------|-----------------|--------------|
| threads |  ms     (%) | ms       (%) |  ms         (%) |  ms      (%) |
|---------|-------------|--------------|-----------------|--------------|
| 1       | 108    (0%) | 72      (0%) | 224        (0%) | 324     (0%) |
| cpus    |  24  (-77%) | 36    (-50%) |  40      (-82%) |  56   (-82%) |

Signed-off-by: Eric Chanudet <echanude@redhat.com>
---
 arch/arm64/mm/init.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 9b5ab6818f7f..71f5188fe63d 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -158,6 +158,13 @@ static void __init zone_sizes_init(void)
 	free_area_init(max_zone_pfns);
 }
 
+#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
+int __init deferred_page_init_max_threads(const struct cpumask *node_cpumask)
+{
+	return max_t(int, cpumask_weight(node_cpumask), 1);
+}
+#endif
+
 int pfn_is_map_memory(unsigned long pfn)
 {
 	phys_addr_t addr = PFN_PHYS(pfn);
-- 
2.44.0


