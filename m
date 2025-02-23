Return-Path: <linux-kernel+bounces-527807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BF8A40FAE
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 17:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECCF1173821
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 16:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3BA78F24;
	Sun, 23 Feb 2025 16:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MbEqhaxx"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05DE7346D
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 16:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740327258; cv=none; b=Jgkraqnj9SCn/4AoT6wpFQffABmvSO10aLi9bQ68sA/Ats4nKreNq9GJFZ6XBehHMGfvS86WD2wEvVQIwMkF1m3WB4ceuueZntwLP6heOnJQC4iaf6aZHkmPYbeXgdbqKlB1esnQHbXldO7eT0KOTXmaFuN8ksI7xaspsSPLTa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740327258; c=relaxed/simple;
	bh=FaoKvhvOj5aOVAQyWnvwZMiPmPihK7/A0glaKILKU+M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FwPzsLD8wzXeC85I1bZQmq9P8Yak2u5EjEnUFH0rPLJaAsaf+WvJKQuMYMqXuN+k7ZwCa909T46Phhz1XxFsE+/5wFVA0PSetH6ma/6g1vSf4At/08NM4Anu0A19qA0N+jh33LhouIZl2v/7fOIm/kManrOOhyGQDKHwUXUfQ24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MbEqhaxx; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5dca468c5e4so6563492a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 08:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740327255; x=1740932055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6Lp7kFHBxXaktn+tzDM1k33dk4UGDdg0fi3PWour11g=;
        b=MbEqhaxx9D6gvOR7eHL7GaOtBJ7aKNK9oRoaYwt/HscBRGIz1oPsj3KaoGpJFOXv3a
         Wo6NqflUAnsgTAVHhDvLudlURiTQ0ZsAwkMMnwKz/FhYjid/ZWL/NgJIblP32S+1qvE+
         67n5uMH7n8tSikcBn+2kiocQF7DFQaRFFh5Y2zzzZg5Aw8JkunYKnKnqmE82Kr3zv2qp
         Zv5sbhj/dfZxMO8WzPAyRjqO7wgNs+Y+ekNsaT57oU0uEDxlSvNGP2ZyZR7Cr0tVn2zj
         kARIAt9eX0TSjX/bGhHRQFZvhGGSJP5JtTc5R3raB8Qj4O0fjr2Q2kVc8NYT+joKaaGX
         g1eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740327255; x=1740932055;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Lp7kFHBxXaktn+tzDM1k33dk4UGDdg0fi3PWour11g=;
        b=TPx59qy0vJAge/OjrQE3ziMmqLhzcksQxE1/4KxRWkc7CgaziBKv8Ezlm6Ds36cYMN
         iPAr2WfiTfTdCUutUH3nq6HWpc0KfcdcRhRcY+1aewLEP2ORlX3mSUUcdZY6A/jyExRf
         v//7xpTH8PcPkuu4bOcRO4iqKgas8X/B9B4dOZ3PPWMPbpeYgD/0nLQtqxVG8xYL5mIF
         KwjSHwJLVhNt7++mulYYkS0ZczRo6nLfxu7CNz+jhCfSIU5hLeTd5mAymNi3hn+dqlPQ
         JXvme4vDEhm8QWNcuuqjVppmAkibdI4fA2Opx02mB7sgjj7BUFH4I3HibY3+uCy0a1JI
         tpfA==
X-Forwarded-Encrypted: i=1; AJvYcCU/rO/qVB+qyjq1xBZf3T+OWEPaX0j06HyJ0Min5vFHcEwmnsZhORPaDZcn7tBg9/DZq31WEW8WfRRNng8=@vger.kernel.org
X-Gm-Message-State: AOJu0YynHWqdiWlMsH4Y74RFmKercODffp33ky/gEVKzDUNlZPdY/+/w
	M9u4jeeo1374ReqV36FDAr9JFN5pUjtyQBOsC935CuG9iplXT0E1
X-Gm-Gg: ASbGncvTp8fHV+PGM+ETrH658B0jIM6qONWreSrBPx0pM6YlnrBW1gI3UIzaStjwCAp
	NH7/wiiK6HdvitPhF0PacX4tuar4tXoy0k0DoBg+NzzGnKvWApqMMRqJwJvTQQRAZc4HWrwv4l4
	pR+K83xqCHgv4DOOwBKNZJo2bys99Jb/OQ55M7fUYErnxKZ7PK4vhxfBQQ4nEwukIhve8YmNeUX
	ZiLBHT8BMV6Ya3kv5idEJeRxD6Ueryr8b+gj9HVu7QZPwRsBUba57rY0D4UE5TGNnlwKyaPgW6u
	Ln/kVzflkg83PIMWrfU7hkA3cXup2vRYig4=
X-Google-Smtp-Source: AGHT+IFP7drcGxi7YJf88TCxTYtmu/0VFqc3kKVF/N9nkQjDbeIgDlM5zRgP9F7mDTWGCySB6Vd4eQ==
X-Received: by 2002:a05:6402:5214:b0:5e0:9f31:a27a with SMTP id 4fb4d7f45d1cf-5e0b70c8cb8mr9533712a12.5.1740327254625;
        Sun, 23 Feb 2025 08:14:14 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece2709ffsm16865576a12.60.2025.02.23.08.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 08:14:13 -0800 (PST)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH RESEND v2] x86/ioperm: Use atomic64_inc_return() in ksys_ioperm()
Date: Sun, 23 Feb 2025 17:13:38 +0100
Message-ID: <20250223161355.3607-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use atomic64_inc_return(&ref) instead of atomic64_add_return(1, &ref)
to use optimized implementation on targets that define
atomic_inc_return() and to remove now unneeded initialization of
%eax/%edx register pair before the call toatomic64_inc_return().

On x86_32 the code improves from:

 1b0:    b9 00 00 00 00           mov    $0x0,%ecx
            1b1: R_386_32    .bss
 1b5:    89 43 0c                 mov    %eax,0xc(%ebx)
 1b8:    31 d2                    xor    %edx,%edx
 1ba:    b8 01 00 00 00           mov    $0x1,%eax
 1bf:    e8 fc ff ff ff           call   1c0 <ksys_ioperm+0xa8>
            1c0: R_386_PC32    atomic64_add_return_cx8
 1c4:    89 03                    mov    %eax,(%ebx)
 1c6:    89 53 04                 mov    %edx,0x4(%ebx)

to:

 1b0:    be 00 00 00 00           mov    $0x0,%esi
            1b1: R_386_32    .bss
 1b5:    89 43 0c                 mov    %eax,0xc(%ebx)
 1b8:    e8 fc ff ff ff           call   1b9 <ksys_ioperm+0xa1>
            1b9: R_386_PC32    atomic64_inc_return_cx8
 1bd:    89 03                    mov    %eax,(%ebx)
 1bf:    89 53 04                 mov    %edx,0x4(%ebx)

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/kernel/ioport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/ioport.c b/arch/x86/kernel/ioport.c
index e2fab3ceb09f..6290dd120f5e 100644
--- a/arch/x86/kernel/ioport.c
+++ b/arch/x86/kernel/ioport.c
@@ -144,7 +144,7 @@ long ksys_ioperm(unsigned long from, unsigned long num, int turn_on)
 	 * Update the sequence number to force a TSS update on return to
 	 * user mode.
 	 */
-	iobm->sequence = atomic64_add_return(1, &io_bitmap_sequence);
+	iobm->sequence = atomic64_inc_return(&io_bitmap_sequence);
 
 	return 0;
 }
-- 
2.42.0


