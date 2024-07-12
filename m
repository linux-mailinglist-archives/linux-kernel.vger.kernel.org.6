Return-Path: <linux-kernel+bounces-250954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C86DB92FEED
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 19:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 703AB1F227BB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 17:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DA117A5A0;
	Fri, 12 Jul 2024 17:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4FZd6+vY"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4697D17A581
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 17:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720803674; cv=none; b=eNFbWqcPr9H/+Swcm8pHiiWfse5wzvxpmTZf+VHbn1NxwPoVBffhw8gR5OfzpL77fPSuxwAet9x3b3CXQqAR/zwa8tdN/ysnKjg68WwIWDf1q6YGZAgzhF/hojp95a8kOp5cnLDMbtaniqxpfCYCHcaDhiwhjxdFV9OgsuOLWbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720803674; c=relaxed/simple;
	bh=/oJj5vwlZeyskk+GmP45ROP1br4fXDWKMm3Wo5pDy64=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bmlQEoi8RvCKCdo0SgHfJrmQDB0kaeMAdTsDEMjotK6uEvwoGLxF9lDDRI08iUmD0cW/JmrTWfHoQBS50jy4JyK8GBeldl+avV+vYOYmX2B2nKpP/wusBISiJsj4LNc67X7tiOu2ADJyQA3ElFrFCSG2jkYXXgiqEHkKoD72qLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4FZd6+vY; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-36794ef4815so1305222f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 10:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720803672; x=1721408472; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HhvK+VsrCDIF0zdCgKI0fd0HHuRdBdA78SeRsMH4q04=;
        b=4FZd6+vYdHNetqPYBVq0OPYSqiH0u4eFWuGqvPgUwr5y2oHbgd1OBwSI0/EGJlafdI
         jT4+AH/lgQe0XE0MoKDXpEx5bEgf6qfZWjvZIhFHsK6qy3PkvPi8vDUP2QPZBkDIqh6r
         uWY1eumCkH+MeDnNc1KjL7zLetrKj7s/YUfHm8NYLPNJq5UVqs4BOVL5oZtyVJ78hcAU
         J5GqG0/OtR8iAj8fesdhbofxo0Wez/hIJpHboOOUqXIXweYtkLbICeOzvZ5vPSFqRnn4
         qY0US9FYSSv2Vf106dkH4M4q2wkgIvzeCXa78ol04YEGW4n4gcv/yI99+uaLlIbQs27p
         dELQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720803672; x=1721408472;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HhvK+VsrCDIF0zdCgKI0fd0HHuRdBdA78SeRsMH4q04=;
        b=WmqHP3KZnATXmystobZ4aWVAEANqybTf6qrNkzRGdAzkUeP4+SNNuZeVF4SgDzvhjI
         WSkcTYCxPcFhAIbzu6lK8E6ueWpXV7r7XkCEn6JeSqvkqNvESvo0w22h/y//m3ZDC8AL
         SPWiwYf0kkh6lGNyCkmtx6bOicKRF4InVp1xoAI3EAcZVHONE99S3Ch7+NRBojc/MNMC
         x58vTdZPkz6UHwkWMBAHJ6iiOh/b+SjxJmyTlxkJu8B9PiKnxmX7Cui/PB84mXmSyWn1
         3hQx8eO/g+4peSBazac1ij2v9FjbDbpqKhrbpo7zyesOHN0WlRYJEOMIG1LIP7/Trdsh
         xWzg==
X-Forwarded-Encrypted: i=1; AJvYcCW0ea6mySi4zr9iNUHmZsS0J0Izh5Fh330d2wOkuDDXm0HzW/2JVzFnI7clHnkk+yooIzAq2dpQzh1QuePphrqvPqYYStydXP7JF2bR
X-Gm-Message-State: AOJu0YxiF6+XW21ykF3Y9uQdJs/390lY+AMhanSC39Uk6a+OOaQ2V0MW
	CrvIPC9g2Bmhsyp8jGYx28B6bHHgQfaBagfSxWmALzhz+oN8rf6uSG3qe8rIyJVi5hEAYraTtpD
	CoazaP3jqGA==
X-Google-Smtp-Source: AGHT+IFAPE6Abc5gQhah4PjzgMavZ5HwflkhPdDu4LbVKDPqBKd9rbMZcjfutEvjASrTYbwEe+XhPDdeyFCaUQ==
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:adf:e988:0:b0:367:9db7:d6d4 with SMTP id
 ffacd0b85a97d-367ceac39c9mr19900f8f.9.1720803671416; Fri, 12 Jul 2024
 10:01:11 -0700 (PDT)
Date: Fri, 12 Jul 2024 17:00:25 +0000
In-Reply-To: <20240712-asi-rfc-24-v1-0-144b319a40d8@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240712-asi-rfc-24-v1-0-144b319a40d8@google.com>
X-Mailer: b4 0.14-dev
Message-ID: <20240712-asi-rfc-24-v1-7-144b319a40d8@google.com>
Subject: [PATCH 07/26] mm: asi: Switch to unrestricted address space before a
 context switch
From: Brendan Jackman <jackmanb@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Alexandre Chartre <alexandre.chartre@oracle.com>, Liran Alon <liran.alon@oracle.com>, 
	Jan Setje-Eilers <jan.setjeeilers@oracle.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Mel Gorman <mgorman@suse.de>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Michal Hocko <mhocko@kernel.org>, Khalid Aziz <khalid.aziz@oracle.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Valentin Schneider <vschneid@redhat.com>, Paul Turner <pjt@google.com>, Reiji Watanabe <reijiw@google.com>, 
	Junaid Shahid <junaids@google.com>, Ofir Weisse <oweisse@google.com>, 
	Yosry Ahmed <yosryahmed@google.com>, Patrick Bellasi <derkling@google.com>, 
	KP Singh <kpsingh@google.com>, Alexandra Sandulescu <aesa@google.com>, 
	Matteo Rizzo <matteorizzo@google.com>, Jann Horn <jannh@google.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	kvm@vger.kernel.org, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

From: Junaid Shahid <junaids@google.com>

To keep things simpler for the time being, we disallow context switches
within the restricted address space. In the future, we would be able to
relax this limitation for the case of context switches to different
threads within the same process (or to the idle thread and back).

Signed-off-by: Junaid Shahid <junaids@google.com>
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 kernel/sched/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7019a40457a6..e65ac22e5a28 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -77,6 +77,7 @@
 #include <asm/irq_regs.h>
 #include <asm/switch_to.h>
 #include <asm/tlb.h>
+#include <asm/asi.h>
 
 #define CREATE_TRACE_POINTS
 #include <linux/sched/rseq_api.h>
@@ -5353,6 +5354,8 @@ static __always_inline struct rq *
 context_switch(struct rq *rq, struct task_struct *prev,
 	       struct task_struct *next, struct rq_flags *rf)
 {
+	asi_exit();
+
 	prepare_task_switch(rq, prev, next);
 
 	/*

-- 
2.45.2.993.g49e7a77208-goog


