Return-Path: <linux-kernel+bounces-559201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D5AA5F0D9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 11:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 129457A9A55
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 10:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2638E265CC3;
	Thu, 13 Mar 2025 10:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SoYFr+Kr"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1B41FBCAF
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 10:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741861625; cv=none; b=Fe2kefBVXIOpvVsawiqoia4j9eEnsdhc24jZj/tnH5ppRqIEgJe6cwhQGKzJ8fJkcyXqHG6AxvprpKG7xU6fbEvPwor9W69Si37FIUv2wGaW9rcbus1kG8EsOYZ6EwDHXHGSjwD1VkGNr5CDVeJvC09MG7sg2UdemdEUhPEBAfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741861625; c=relaxed/simple;
	bh=XvHOw187sK5JgnNUI1s30j2Z20u5H6HZ+ikNK8NxrhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IFu64SovQtyDpbhC2JaFcF9TeiFBzX/1yCj4UWEd5ImfTSGphpBBQKAv+YPe3/0YklbvWswGuE2OMM6YM61k8PJlhUtRGKbV6oMHU/EY0Ff5Fkw+utzHfzcL8v8N+D3tQivEsDDvXCHeDMeJw2tx0dvgsj6HQ2yS/uPls3RlYvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SoYFr+Kr; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e673822f76so1254786a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 03:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741861622; x=1742466422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T2/zBebSwj+3oexDo+UZogpE9e7/cIweIMxtEBULujE=;
        b=SoYFr+KrIrSSGl3cOavqsZtiMyKUuf/CVtHZpJaYftgkRrqqrjhnnh6QypxSonp6/w
         2kl5T6c4igd9HFk4QJ4jWhH8r75d+SU43+63BnvhvZb2IBnecTU78beL7GyOj20oOoCZ
         EhylzjtUpVQFPubJZ7hINuYTBQAoWypOaJRxZykAHn43mwM7S6eSTAs2nTjAAmyczDiq
         n2/n4K/xEMFC4neYTq2ILcJNHXi6frQrGACi/uBAMS99VHtR+J/eHOjumbY8VW2GfPto
         7xIQk7Ktfeo7NKSBc9Wpd9dqVDvooU3r+7sJaavsFpHKCHue9KHoyXeouSvoH9HKOjLB
         T/Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741861622; x=1742466422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T2/zBebSwj+3oexDo+UZogpE9e7/cIweIMxtEBULujE=;
        b=T4sblonNamSSyrkOTOt4RPJbDsr1SHCc7IPb1qC90jTwQ8Mf8kp7hmgEScP2tFsKtz
         lUBGEd3ujAVObH5wTwD2/qKXK45MpmoxXwIKXXfgtCJ/078+lifJ7GZJgtT5DEF2QPe5
         wjZ3YR3DYy5YYeAMcjRln3MLqRYGPc3SiyTCdYlJUVxAJeb2VNCgJizsgus3BP8SP8dh
         1gLZiwRzsWaii+yPzV68UZC++0XCho6IhQGifavVaxH9TsDfvzIWjHqZi3mlQHeSIjwc
         WZkxUc78XD/mD+VPSe94J5mmQ1U6lDnVkK+RWmOdQ5MmjIqMwQPQSMAHnEGmkkh6/C8C
         Fh9w==
X-Forwarded-Encrypted: i=1; AJvYcCXIurPG5nl3uFGTW2Cw5ryohKSraMLceSE+rrjUd95aimV8pI8ibQM8Vq3ynBGb6mzYTwKJlHdx8oQcGgE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9uPrSzGW7J9z9YwbNdjy1Yxu5vzX5jgI51oacJ8tN5ZleKAwu
	BOsYEmG4qm0wmBihhjBZMVCrtGSYKA65rsOobr1Qt/tUJdUb4IQX
X-Gm-Gg: ASbGncsRzMJXkgH6DZ/unhWMCn+7hP1xBdsC1El7ulc1bTjYc8L6q93FG1VX8vD91MA
	7Ay5Wreg8vilt29jyIL488EOleALwnwfiViP7j+ege/ByaHvAXT7Rv19ixnSqzIPDlKGgtlIEXP
	rrmb0erPxbt0VB5074fkAcX20DeGhwoykWlfCIDw65dGSAt4+W3nDkiric9QZhbCkjJHiOEzR7G
	tSowkCyTKJwnVwKZ0l1IJHcBGQ6sf75frTF2ZjdiQcCJvQDTaTD6jsI4DouZXmkTEX2o0Aayj6J
	i0trHE7vZ7kB2BAQfZxYt5ZehoQ40qmG1Fms
X-Google-Smtp-Source: AGHT+IGEoeZChkLoS325YoLsoeqtxQ7eR2P9fQSBhI3lepZ1s3jzQIWkZNdirik7foP5YPIunUY86A==
X-Received: by 2002:a17:907:2d92:b0:ac1:effd:f2ea with SMTP id a640c23a62f3a-ac252b3d95emr3260235466b.24.1741861621741;
        Thu, 13 Mar 2025 03:27:01 -0700 (PDT)
Received: from fedora.. ([193.77.86.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac31485d046sm63279866b.83.2025.03.13.03.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 03:27:01 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 2/2] x86/asm: Use asm_inline instead of asm in clwb()
Date: Thu, 13 Mar 2025 11:26:56 +0100
Message-ID: <20250313102715.333142-2-ubizjak@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250313102715.333142-1-ubizjak@gmail.com>
References: <20250313102715.333142-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use asm_inline to instruct the compiler that the size of asm()
is the minimum size of one instruction, ignoring how many instructions
the compiler thinks it is. ALTERNATIVE macro that expands to several
pseudo directives causes instruction length estimate to count
more than 20 instructions.

bloat-o-meter reports slight increase of the code size
for x86_64 defconfig object file, compiled with gcc-14.2:

add/remove: 0/2 grow/shrink: 3/0 up/down: 190/-59 (131)
Function                                     old     new   delta
__copy_user_flushcache                       166     247     +81
__memcpy_flushcache                          369     437     +68
arch_wb_cache_pmem                             6      47     +41
__pfx_clean_cache_range                       16       -     -16
clean_cache_range                             43       -     -43
Total: Before=22807167, After=22807298, chg +0.00%

The compiler now inlines and removes clean_cache_range() function.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/include/asm/special_insns.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 9b10bd102d3d..6266d6b9e0b8 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -185,7 +185,7 @@ static inline void clwb(volatile void *__p)
 {
 	volatile struct { char x[64]; } *p = __p;
 
-	asm volatile(ALTERNATIVE_2(
+	asm_inline volatile(ALTERNATIVE_2(
 		"ds clflush %0",
 		"clflushopt %0", X86_FEATURE_CLFLUSHOPT,
 		"clwb %0", X86_FEATURE_CLWB)
-- 
2.48.1


