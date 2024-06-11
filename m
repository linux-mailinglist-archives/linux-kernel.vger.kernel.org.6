Return-Path: <linux-kernel+bounces-209421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FFB903457
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 09:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39BFA2823E8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 07:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF1C17554C;
	Tue, 11 Jun 2024 07:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gjLfzdl5"
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F71175543
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 07:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718092258; cv=none; b=mdXtCKQMcwQTscGaEKk5skiovFzMN84nQdKGmaVJi996HyW8mIGHXnnXiJhxKNw/itoRPGcevMhnF77ngXpDUsss1tj+5PZHRYhOrQBpnGKMze68LtBjGNHNydp0qxvmrf+xUyfd8Ee9yw6aBetumSUoqfdSDuhfM4J8tszj6Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718092258; c=relaxed/simple;
	bh=XA6TxpJwG4PvZtHmcUtWg9j+X9JctRACICEBTlJHGpw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EfXDSCzPnVhnn8usWJAUL1TZ+yjefMtHHhk3XaAEOW4HGioFkaozSZfsT2RrtNuamGbDHpSOZIM0EbJlegHbv5o26L12z7lU5zMB6srtHkRPGamh1NKAOpoc2P+qbSGoOIA72XXrxSYCqYjVQLemz70Y4+4wS3sWGI7smz0fOro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gjLfzdl5; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-57c80b0d1c7so387159a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 00:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718092255; x=1718697055; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KJ1zyFICdy5qqRC7FAeNtn1bVJ8F8bJSOBOHZzBToA4=;
        b=gjLfzdl5+LUCC1ZZB4Ha7DmD6fx52l5i4e+f5EcxjOq9IjipOCL0ApKUck1y4w7CjO
         /JAnnC+aWQoeRGxMOdDkJw8GINO09S+z9YBz58fqZW0B1jetQ3dgbDY83VwrijuhNsXC
         hFESLe2o587cEGg+eomXArmB68kR7o4gBOzcVB8FiF178oNrfurrDv1px1xSmACN+qte
         tN4Vq6Jvu2ZNYjn3Sqa1GNGYKE12mPTmwbBhTqBdo/7uWnVsxSD4p/osWn6QFBY8fpGm
         lcrQXj/2hGQWVeLELwXdJ2Osc3OYQccyTOZQ1nGQnuBzFrPFdMk3f5uZ1+W2/UtDw72U
         Tp8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718092255; x=1718697055;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KJ1zyFICdy5qqRC7FAeNtn1bVJ8F8bJSOBOHZzBToA4=;
        b=nRkSDh/32sJss4Z03YkE6SJ7wvfVDmhpRE8WJZKzFc7sQHtCgdVSur/FELcftAl4ke
         ADV+rqvN+aXQltTmyx3LDcjUCYQr+eolVG5Tery9tmi4kp6vW4C1fbyKeRoqTGqCsgnc
         VbG1TmLynhpHPdk/v5nO9z6YMMHXEnq9TSQh0BV/cEL2lemGfskbCvnJm7iw8mjSi99Q
         5+1bjmer8ail3WLO3FbTu3h0nxrY1VgsnBEDIhuiwl/MYZEIdzlj0nbUXqKfB9sAI/iy
         +qHOe4Hus0JMDXoRUO3aL6hsyuwO9sl9UL0hWbK9M/xAvqk8N7YwW0UfQpEPlD5bWGCC
         k2Rw==
X-Gm-Message-State: AOJu0Yw7FIVodoxybMAykdVePROFh/H1sTCfjkmjr6gxVrQfgP78/Oys
	/xr3coKaw2auIndRGQQC/kpSnG8KCRmXrZhAa+OHodnoC38LlHS15DjBC3EKuLMrTBrBmq1WO4x
	ddJK5IA==
X-Google-Smtp-Source: AGHT+IGJJKwfA8KHq/ehZGxXBnsy8ol4aDTYkjUd2Q5SfKYFKqYpga3FUafEhpFt0lpekDAn4m8qAO4eL7fj
X-Received: from dvyukov-desk.muc.corp.google.com ([2a00:79e0:9c:201:ecf:76a8:5d44:6e8b])
 (user=dvyukov job=sendgmr) by 2002:a05:6402:5418:b0:57c:7f32:312c with SMTP
 id 4fb4d7f45d1cf-57c7f32333bmr7090a12.2.1718092255002; Tue, 11 Jun 2024
 00:50:55 -0700 (PDT)
Date: Tue, 11 Jun 2024 09:50:33 +0200
In-Reply-To: <cover.1718092070.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1718092070.git.dvyukov@google.com>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <eaf54b8634970b73552dcd38bf9be6ef55238c10.1718092070.git.dvyukov@google.com>
Subject: [PATCH v2 4/4] x86: Ignore stack unwinding in KCOV
From: Dmitry Vyukov <dvyukov@google.com>
To: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, syzkaller@googlegroups.com, elver@google.com, 
	glider@google.com, nogikh@google.com, tarasmadan@google.com, 
	Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"

Stack unwinding produces large amounts of uninteresting coverage.
It's called from KASAN kmalloc/kfree hooks, fault injection, etc.
It's not particularly useful and is not a function of system call args.
Ignore that code.

Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
Reviewed-by: Marco Elver <elver@google.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: syzkaller@googlegroups.com
---
 arch/x86/kernel/Makefile | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 20a0dd51700a..cd49ebfae984 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -39,6 +39,14 @@ KMSAN_SANITIZE_sev.o					:= n
 # first second.
 KCOV_INSTRUMENT_head$(BITS).o				:= n
 KCOV_INSTRUMENT_sev.o					:= n
+# These are called from save_stack_trace() on debug paths,
+# and produce large amounts of uninteresting coverage.
+KCOV_INSTRUMENT_stacktrace.o				:= n
+KCOV_INSTRUMENT_dumpstack.o				:= n
+KCOV_INSTRUMENT_dumpstack_$(BITS).o			:= n
+KCOV_INSTRUMENT_unwind_orc.o				:= n
+KCOV_INSTRUMENT_unwind_frame.o				:= n
+KCOV_INSTRUMENT_unwind_guess.o				:= n
 
 CFLAGS_irq.o := -I $(src)/../include/asm/trace
 
-- 
2.45.2.505.gda0bf45e8d-goog


