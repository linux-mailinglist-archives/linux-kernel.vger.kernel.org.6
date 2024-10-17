Return-Path: <linux-kernel+bounces-369618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 167D09A1FA5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 12:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCFC9282263
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 10:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037251DA2FD;
	Thu, 17 Oct 2024 10:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="cpLgd7qz"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2395879FD
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 10:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729160592; cv=none; b=cP3SzRIeLqcF3X5lGywRgHDEKFLEA1Rbp3f63sm8aAKTtZ+osGtwOu1oHDjzJ0wbrMyPqQF0hfbT7Sn+sVHwa5Hq8WWGw2EqdpkHVQxQ85gZ1dEIsLfBaNpgO++YHMSXBUvLc5aEQqJPoI/6k9EnLA1uGSUlc9oH8xJyQgiWuds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729160592; c=relaxed/simple;
	bh=bbr35+9isQ8wofNh6ZDkD37Ju3+OeAOdl24bZU3TErQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gOM+mU9XFYO+WN2FQ/nq/2/kdgWU3RyK6dQTxLH/zsIbq8E0kcrp2p/h4/Ts9tVKrTPdTXk9g+jxOFsSrxt1c7caKy/EWn6y4fErcvtuXuXxAE9dMdlbvlX/sJVfOog1ZHUgGfZp2ePRrgsoMi3tyJ7Ih9A0URwM1ENu1sHxK68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=cpLgd7qz; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D94323F5E4
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 10:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1729160578;
	bh=kCvd0dMyZkfoCLYD8bJ+IFh9dnrt8COhHjyrZcYmQRk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=cpLgd7qz0rhO6hyEYHdTAPNTNJF1+iXU1pBQp2i1MABrxo4yYqrwqhodCY4r25HUV
	 4+M3VHOPzwEEyGhMInDncxHEikRVDDqv2W0tm5SN8D6a3KfOIDJxdtpVa2xqpCK84c
	 VAfOLwx2+yQMkKFpFHpkVZWAGsyi1hG1tU03vAmB5qCfdxciA9k5OoflKGOM9mTUj9
	 2Wj5DBDpT5WxBQV+cva8XtL+UjuDnSpzRtPEN2AsA8YWFXlwPKFDAT0XXRoTfWyTKX
	 qIe4dlAaZajC+UAhPEBEJh8jHhYWN0LP9JXPqTHeSxiTByZzyXMA94TWi8NUWjDB77
	 yFc6Ta4UuiVSQ==
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a99fa9f0c25so42592566b.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 03:22:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729160577; x=1729765377;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kCvd0dMyZkfoCLYD8bJ+IFh9dnrt8COhHjyrZcYmQRk=;
        b=o1QQRvmLK4MIT7npv/hnUJIAYSe3NwQOZ4e4jSscsqFlIuFWO1CkiwKLUbOpCSiJpL
         Uf+QtGvLTKcdo4LU1+Ar+QiuJ3j0rDjfix7ub1S+jVJxE54QYIdeI9RDLM8vFMW+DZwi
         PId29eJLL3tHraOKjDWROmR2tvGv77QAuO8LhX095ykcU/BSYmB9TdqhwIdLemsR/LLo
         0RAurCj6Qt3hCiXR1XAqaWS1bT7buKEvPq8P0JpTNOinvAuDcW2Z7Lmw9+hcgoj+3TAv
         Y1eWYOhTWz2wKbaDr8EkH6sNvrnxuLfw32x8PdfsjPjN/MkrmQFgwWj7fJ3uyAYc4+8J
         Vicw==
X-Forwarded-Encrypted: i=1; AJvYcCU+o9XpMIBY6lV9CSrPTuFvVjFXGodomZ7mkCf//FXnDkixNFOLGgjNY6qz8CXGs8CaQZpBAL7wA0/tTZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSzHYThfc7uI1TjW8OaoYTNOo4FvFvK+Qnhb+Uwx23aqKCFMh9
	9RRFIABsRXw2WvnzW3EuCiFtlO/EJg5zFiSaEUUw7pZy17VviX5mk0Z/YbF7GKMIH9Bt59lYswt
	60U46sfbPvS/EoNvAzM5w+iMqDm1pSODmyRmOmtcolBQOLCXkJT4rz+CZ77ErS1BNPH3AfPeU6N
	2pYQ==
X-Received: by 2002:a17:907:1c82:b0:a9a:55dd:4d52 with SMTP id a640c23a62f3a-a9a55dd4dfdmr149778166b.63.1729160577499;
        Thu, 17 Oct 2024 03:22:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGM6S4XX/EPCEoCC/ZA+2uXsarMGgV9RZEl4NFKueBEeHiFveaPmhxtEq4aAeIRbLvDffWUYw==
X-Received: by 2002:a17:907:1c82:b0:a9a:55dd:4d52 with SMTP id a640c23a62f3a-a9a55dd4dfdmr149774066b.63.1729160576975;
        Thu, 17 Oct 2024 03:22:56 -0700 (PDT)
Received: from amikhalitsyn.lan ([188.192.113.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a2981702bsm280022366b.112.2024.10.17.03.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 03:22:56 -0700 (PDT)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: mingo@redhat.com
Cc: James Morse <james.morse@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Gavin Shan <gshan@redhat.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Thomas Gleixner <tglx@linutronix.de>,
	Simon Deziel <simon.deziel@canonical.com>,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sched/cpuacct: show only present CPUs to userspace
Date: Thu, 17 Oct 2024 12:21:38 +0200
Message-Id: <20241017102138.92504-1-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After commit b0c69e1214bc ("drivers: base: Use present CPUs in GENERIC_CPU_DEVICES")
changed which CPUs are shown in /sys/devices/system/cpu/ (only "present" ones)
it also makes sense to change cpuacct cgroupv1 code not to report CPUs
which are not present in the system as it confuses userspace.
Let's make it consistent.

A configuration when #(present CPUs) < #(possible CPUs) is easy to get with:
qemu-system-x86_64
	-smp 3,maxcpus=12 \
	...

Cc: James Morse <james.morse@arm.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Gavin Shan <gshan@redhat.com>
Cc: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Thomas Gleixner <tglx@linutronix.de>
Reported-by: Simon Deziel <simon.deziel@canonical.com>
Closes: https://github.com/canonical/lxd/issues/13324
Co-developed-by: Simon Deziel <simon.deziel@canonical.com>
Signed-off-by: Simon Deziel <simon.deziel@canonical.com>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 kernel/sched/cpuacct.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/cpuacct.c b/kernel/sched/cpuacct.c
index 0de9dda09949..0f07fbfdb20e 100644
--- a/kernel/sched/cpuacct.c
+++ b/kernel/sched/cpuacct.c
@@ -213,7 +213,7 @@ static int __cpuacct_percpu_seq_show(struct seq_file *m,
 	u64 percpu;
 	int i;
 
-	for_each_possible_cpu(i) {
+	for_each_present_cpu(i) {
 		percpu = cpuacct_cpuusage_read(ca, i, index);
 		seq_printf(m, "%llu ", (unsigned long long) percpu);
 	}
@@ -247,7 +247,7 @@ static int cpuacct_all_seq_show(struct seq_file *m, void *V)
 		seq_printf(m, " %s", cpuacct_stat_desc[index]);
 	seq_puts(m, "\n");
 
-	for_each_possible_cpu(cpu) {
+	for_each_present_cpu(cpu) {
 		seq_printf(m, "%d", cpu);
 		for (index = 0; index < CPUACCT_STAT_NSTATS; index++)
 			seq_printf(m, " %llu",
-- 
2.34.1


