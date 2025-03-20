Return-Path: <linux-kernel+bounces-570259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A87A6AE1B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 20:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF84318875DF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 19:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1CB227B8E;
	Thu, 20 Mar 2025 19:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U8w8P+Bf"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D78E1EC006
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 19:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742497581; cv=none; b=aSeIN1MxY0eLU5GQirI2pSVF/jylTWRfSJc5RNXXWYT5AF/lGJERboTvx+cFhX8AyutDkaFDgxmTE8j/KriZHiZ0ITwIlfmhf8cAT5OQ3whlzNa+UjjlJGa73PifpyiOZEd4PLgC2IXDrTdwxY7eXPXsonG03vyoDDFFZNPinDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742497581; c=relaxed/simple;
	bh=CVdwQRwpIJt58hAeEva9DszeJTQsrm/DOSXoQITYRMg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bl4XeLX9w/L/MiSt/pJlz+/9qC4uOvlAXEq62AUvgoNL9r+oTnwpwu0LELFjTgvMDPHfWozBbrElKsrzOhcrsVK32Q0O39Z2+J7D+MC1LB/b4D1LJD4Cdrz/rwbJDWvnYanzGPuEDFNOME2uEz0Ybcpl6sKt3s524z1Jk20heiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U8w8P+Bf; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43d0359b1fcso8079625e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 12:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742497577; x=1743102377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8lSnLMJAAQW3qdhDrBNq0M5ItBc5KdjP8sEy/s0lY0c=;
        b=U8w8P+BfyhF/qk/Zf3SIzWBAj/F6OFP6BORQotS3wwkEst+2bmlH7CpGinbAw0Crcs
         pr2FhgEc70U7cB2ZAvRlwQG10+3CSOR/Enj+7nq0AXBWzGymZs7WzHvE6cjnZwN1v9c7
         3BhPpRF8yRSPvw/reR9OARQ2ghOvxSUT/N2jiZymL5okO5htePUZwOk4nYlfahKbU3cn
         XynLgVeklhkRUMQAGpcyI7iYaZpU1yNiQHyZcrMbh3bFpAi5Tp37khAmqLGbi3gNGuPI
         RfFSOfbpydy08QTi0wyC90/lq1+FYRE22Hg28kGpEiCWJPmHMGhqQomUu0OCU+VsPV81
         lpxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742497577; x=1743102377;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8lSnLMJAAQW3qdhDrBNq0M5ItBc5KdjP8sEy/s0lY0c=;
        b=E3EQ3Qfp8r8nsi4ZU9qAFoAwCvlzksPHqmDqnEwxapDXxnYXkjxEhttdryzAZHfuJC
         WcZlfws7MXR3mq8qMygr2dTwr2kT2jcyDgKEI98vAmCDekToUsr7OC5GxE8PoBz/BwBb
         dN3uOeSRKHZYFtZPM6inwcQIEQoVNDdtM6hHi35odNQuA4m5KI9T7toMJzlhbww2I6XL
         UQATPTq8JxjzBcitO3G/9zvCIvNzu9MmFbhtpb1S1bUi3lzg7gvSqmQWGFRsLIr/04SA
         UY3vGT7PUikaSLDPmIOccREu1TFpODnjcHBmOhpmoa+ob5Y8l42jvGVT01Kknulc/vDP
         W7jA==
X-Forwarded-Encrypted: i=1; AJvYcCXasUHpZnXrUlE63alP81Ag2QOW+DIOeozVxXQBUiKEgoyx3z9C0KhhH9GBkeflxbkCxqo7LvkChsoFf9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV2tUPKjp33TlQjZbwSegXsKR3VplzLnm1sdjMsxfNHot0sjep
	SLQ8exBFIfWeraxD6wtbNhk3U0fiWcaN7nwAKZRQeT4iPFb8WIk9
X-Gm-Gg: ASbGncsMNmI1omNjo+/tS60x94kEIrz4m1HGIe+QzJMepB8wa5WJITFrpbU2P95Hhnw
	RCItaaq0RiPd6viFcJsLx2YrWPAaMEXTuphQr+/52OWhl/4Ujq0jy+KlxdHMOP0K8fGpH9AHxLX
	dHWSIbDSBxXMs48sxg52NNSCD5jOUnUs7xYEiPMjEFAJOrFeA0H9Lr/6xZ6SAPbS6uxcKVCJ3O3
	QJg7e/eJ28YtBJSDGcFwtEuQTWeNasHW/XCNsjMiMUulE/tEC5sHSRpN6Ija+pGFulZ93hjbN68
	UiRY/3AsB70e6uSC/YPkeXFYWqRRn7+GF6o1C4sNzX8D/Q444abJEuelEHVmpnAuyDdAFvw5ZQ=
	=
X-Google-Smtp-Source: AGHT+IFw+dgtyCKPZWyNw61eZQmtqhvfaa6INsUTXDhhy225m/6x0MHjdx6ANj8V2/hmibGCruVpIA==
X-Received: by 2002:a05:600c:3586:b0:43d:1bf6:15e1 with SMTP id 5b1f17b1804b1-43d502d87a0mr6171965e9.1.1742497577175;
        Thu, 20 Mar 2025 12:06:17 -0700 (PDT)
Received: from f.. (cst-prg-67-174.cust.vodafone.cz. [46.135.67.174])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f332adsm56954255e9.3.2025.03.20.12.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 12:06:16 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: torvalds@linux-foundation.org,
	x86@kernel.org
Cc: hkrzesin@redhat.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	olichtne@redhat.com,
	atomasov@redhat.com,
	aokuliar@redhat.com,
	linux-kernel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] x86: handle the tail in rep_movs_alternative() with an overlapping store
Date: Thu, 20 Mar 2025 20:05:14 +0100
Message-ID: <20250320190514.1961144-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sizes ranged <8,64> are copied 8 bytes at a time with a jump out to a
1 byte at a time loop to handle the tail.

This is trivially avoidable with overlapping stores, which is the
standard technique for these kind of routines (in fact memcpy() is
already using it in a more extensive form).

I traced calls in this range during a kernel build and found that 65% of
all of them had tail to take care of.

Distribution of size & 7 in that range is as follows:
@:
[0, 1)           3282178 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[1, 2)            949627 |@@@@@@@@@@@@@@@                                     |
[2, 3)           1078842 |@@@@@@@@@@@@@@@@@                                   |
[3, 4)            998995 |@@@@@@@@@@@@@@@                                     |
[4, 5)            744515 |@@@@@@@@@@@                                         |
[5, 6)            925437 |@@@@@@@@@@@@@@                                      |
[6, 7)            663305 |@@@@@@@@@@                                          |
[7, ...)          786007 |@@@@@@@@@@@@                                        |

@stats[notail]: 3282178
@stats[tail]: 6146728

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

I added a call to a custom copy_user_probe() routine to
copy_user_generic so that I can attach to it with bpftrace. Available
upon request. The one-liner is:

bpftrace -e 'kprobe:copy_user_probe /arg2 >= 8 && arg2 <= 64/ \
{ @ = lhist(arg2 & 7, 0, 7, 1); @stats[arg2 & 7 ? "tail" : "notail"] = count(); }'

Anyhow, I don't have any means to benchmark this at the moment as the
only hw I have access to is in fact a little too modern (FSRM), but this
being the standard technique I think wont require much convincing. If
anything the question is why this differs from memcpy which *does* use
overlapping stores.

Tested by forcing the kernel to use the routine, did the kernel build
just fine with the change.

That said, absent own bench results I'm not going to strongly argue for
the change but I do think it is an ok tidy-up until someone(tm) puts
more effort here.

 arch/x86/lib/copy_user_64.S | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/lib/copy_user_64.S b/arch/x86/lib/copy_user_64.S
index aa8c341b2441..2d5f42c521b5 100644
--- a/arch/x86/lib/copy_user_64.S
+++ b/arch/x86/lib/copy_user_64.S
@@ -65,10 +65,15 @@ SYM_FUNC_START(rep_movs_alternative)
 	je .Lexit
 	cmp $8,%ecx
 	jae .Lword
-	jmp .Lcopy_user_tail
+4:	movq -8(%rsi,%rcx),%rax
+5:	movq %rax,-8(%rdi,%rcx)
+	xorl %ecx,%ecx
+	RET
 
 	_ASM_EXTABLE_UA( 2b, .Lcopy_user_tail)
 	_ASM_EXTABLE_UA( 3b, .Lcopy_user_tail)
+	_ASM_EXTABLE_UA( 4b, .Lcopy_user_tail)
+	_ASM_EXTABLE_UA( 5b, .Lcopy_user_tail)
 
 .Llarge:
 0:	ALTERNATIVE "jmp .Llarge_movsq", "rep movsb", X86_FEATURE_ERMS
-- 
2.43.0


