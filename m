Return-Path: <linux-kernel+bounces-265883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B3A93F739
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 16:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C9281F2268A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 14:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0EF149C7B;
	Mon, 29 Jul 2024 14:06:15 +0000 (UTC)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F35B548F7
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 14:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722261975; cv=none; b=QX1fzfOZD9Lp3uoTHcbxTQ2WH+lAExzbzRhXK2/7D1qVc/YRKharcTk6LyDBC/cs4b2n+ioWNPx+bPK7pbKYI+8DyLFBXMqDnysG52yThhjZXpC7b/9cV02wTczPIa3oTQySN9tNIVBlEHBD9SFS0rwg84vkniLtVQnpKO2TMqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722261975; c=relaxed/simple;
	bh=Vt/KlsYqlfzY5w+zk4qKtAzaKg3pBAlXwsSaQbwVEoc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FilQHJepGqv9eKtPeXjE1UMWixQ8hFwikT/VxME3VIcgnKlKHYC/87pmP3KF9GNMJ4Jd6B1vs5h3JX5sokKSbpU/jhR6OuRrf+8IvDWWpM0+A5i0487WqkkK27R10zbjNl/T1Z+5XB2u4sd1pk1R/SQCdzWHB+arjxDkwggl4fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5a156556fb4so5702873a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 07:06:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722261972; x=1722866772;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=owwE/MAw6I8JV49oV4oTjGC158EU/LbbStqtPHPBtTM=;
        b=qbdRf8TNjP/2M8lxTpxDsA+9rzfU1/VRw2kz5F3JmbvJXiHb+kOLiA27MIrn0Mj3mZ
         uDw+CYjMyLzHFr/JDW7Z0owfI0UJT6xyulhQYN89NC6eCriXJnij9xSHFgUovTkeFEtm
         6wib+WQVZuWmCZpRz6pBfnR5R62l8uup93PFrMJb9DnxiOG7PpotNZqTNRDG16U9voqF
         OpWI7KIORQhp+fYthM2zOVE82igFHxXq4NQdq7ve9T5cDarfnWlVgX27SFia+ejBTS/y
         fGJ9fMjP/6I7azgEUQLIm9JmjJllEqBz7pAAN2IjMGVL9q7wOUgVuqbEmPc2YvVmZGYW
         S/Kw==
X-Forwarded-Encrypted: i=1; AJvYcCX4R/rxBniYYnBiTkAX8gtSwNd88BbGWBWsFUmTN0LjChtZawgwCR3saA2VWOWtM2UFMF73Vb7Ff4SxZ7/W9OI+v1dS0CqEd7KLGFZM
X-Gm-Message-State: AOJu0YynTN5DNzsJ03lbLjxZD8lXSwxvatx3/UZT3z0EKjN7H7WdbgbG
	Bv4uusNvb031jb7g6+MaDS9oK43m7siqzmg5rXQBo3v7dGHDsoQy
X-Google-Smtp-Source: AGHT+IFyarz1U50wTNKGNnpgVwME+kJVnePgE9zm8/V1pGilDItbAsfCY4q2LXf3goYhSGr0CPbGvg==
X-Received: by 2002:a50:9f4f:0:b0:5a1:8984:977e with SMTP id 4fb4d7f45d1cf-5b0202ef5a3mr3979950a12.8.1722261971390;
        Mon, 29 Jul 2024 07:06:11 -0700 (PDT)
Received: from localhost (fwdproxy-lla-009.fbsv.net. [2a03:2880:30ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac631b03a0sm5846501a12.2.2024.07.29.07.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 07:06:11 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: leit@meta.com,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Wei Liu <wei.liu@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Adrian Huang <ahuang12@lenovo.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT))
Subject: [PATCH] x86/apic: Add retry mechanism to add_pin_to_irq_node()
Date: Mon, 29 Jul 2024 07:06:01 -0700
Message-ID: <20240729140604.2814597-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I've been running some experiments with failslab fault injector running
to detect a different problem, and the machine always crash with the
following stack:

	can not alloc irq_pin_list (-1,0,20)
	Kernel panic - not syncing: IO-APIC: failed to add irq-pin. Can not proceed

	Call Trace:
	 panic
	   _printk
	   panic_smp_self_stop
	   rcu_is_watching
	   intel_irq_remapping_free

This happens because add_pin_to_irq_node() function would panic if
adding a pin to an IRQ failed due to -ENOMEM (which was injected by
failslab fault injector).  I've been running with this patch in my test
cases in order to be able to pick real bugs, and I thought it might be a
good idea to have it upstream also, so, other people trying to find real
bugs don't stumble upon this one. Also, this makes sense in a real
world(?), when retrying a few times might be better than just panicking.

Introduce a retry mechanism that attempts to add the pin up to 3 times
before giving up and panicking. This should improve the robustness of
the IO-APIC code in the face of transient errors.

Since __add_pin_to_irq_node() only returns 0 or -ENOMEM, the retry is only
for -ENOMEM case only.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/x86/kernel/apic/io_apic.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 477b740b2f26..2846a90366f2 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -390,8 +390,14 @@ static void __remove_pin_from_irq(struct mp_chip_data *data, int apic, int pin)
 static void add_pin_to_irq_node(struct mp_chip_data *data,
 				int node, int apic, int pin)
 {
-	if (__add_pin_to_irq_node(data, node, apic, pin))
-		panic("IO-APIC: failed to add irq-pin. Can not proceed\n");
+	int ret, i;
+
+	for (i = 0; i < 3; i++) {
+		ret = __add_pin_to_irq_node(data, node, apic, pin);
+		if (!ret)
+			return;
+	}
+	panic("IO-APIC: failed to add irq-pin. Can not proceed\n");
 }
 
 /*
-- 
2.43.0


