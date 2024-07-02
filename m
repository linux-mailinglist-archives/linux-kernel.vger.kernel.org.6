Return-Path: <linux-kernel+bounces-237210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E50391ED7C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 05:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 679DAB221A1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 03:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7768422F14;
	Tue,  2 Jul 2024 03:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ea+DiHhS"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314C31758E
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 03:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719891476; cv=none; b=ikm3VBxYCVV7jX7dUEn5Bi7RAb1tcNxh1kmH7QKXMGhP3XKt+4KgTOutXCnY3Txm5Kv26HqlS6G2IMaODi6hrnLhCM5SAwrUwiRDdN68ON2ZbpJuWNwvurvUlAyPfNfzjH1Czp/OX5IOFvnworyG4fZOYpplpQbtzJs9zOvfIW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719891476; c=relaxed/simple;
	bh=Ylxlhu8pitiJMGoNLtEeZ4/PG8OkC1k5mKTmQNdXJ/k=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=qx6ezn57zLcqxnq0o/+qX9W0ycOLoZ81UJsGGgFqZp6jiFJpDifh5R0TIFDgiPlkttdIo1hxwIFQzSbOJxr7avVfAyE+3udKGoQncsr7crkOfwxQ2DKejxU7Dl9zJLeTlUubfuZcWGbsb91NlgtVV95GtiARpQDCQWWs4fR9/kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ea+DiHhS; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-701b0b0be38so3010454b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 20:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1719891473; x=1720496273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=bBV6I+MqJPgMEAtSd8jBWBXMlcHc0d1F6+6qwZyHh5A=;
        b=ea+DiHhSUPjHV/72SSjZK3h2udTGb4tOe7W7nsCA7EOebRE2eK8XOyDG8uWnfC83W7
         bqQdztb6LdQM9Fpsanlr3II5JjKxOuzVTToALsf7QXEOuSkztWeOlwZN2F9TuDtEqdwf
         D9uZ7INBSTMHRHHxWU96vFq1Jl9Fs2FgJRFXt6cGAwgbR3bbidC0yEmGpdgSbGln6iLP
         oEXMP3hs+NBKORdNMlxJYjIkmKTdGGIAHm3NwOLm4u+MiFYyMKK2TpuIb2UzsclfkEjY
         CYWyuzhL/6O5jUSkzr2GDqKNoK8HlP+d83E00Z9IXEVUkjwP8RWleLt6TH6k97ET5f0L
         UqNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719891473; x=1720496273;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bBV6I+MqJPgMEAtSd8jBWBXMlcHc0d1F6+6qwZyHh5A=;
        b=kMAJwQy4L/Y6O0KFWPXU3WCvemCmNxgngdH5SzdcSnEYGV/UNKQp510rhPZlEdWe3n
         0Pc1QfgU5dOCmbzy7LChcMyJU+4fBnDLujjOFPcvyFfixAYBNl0siKGePT+rgJEC4/qb
         KmDJCEFdp1siIFJp8/JO74HBnFTINJ2r29W4MiktTNV83nkEriY+LmgQWh8LWWxatCzl
         GIfqq4dDMwyXyamGwtvEEQqdiIP65WUCvWHbqIGqskVJinKA1lF8oVJ6otx6m5ALed1J
         FdJ0e801/57ThfIW7/t+fibSZSoLMtUTr/2NI6M/d2Lz4vKqip2EA+tLtI7IYoZK4nrR
         /ndA==
X-Forwarded-Encrypted: i=1; AJvYcCVY4aEsss0628dS6d0Ls/yhNwb/EJZOg8JSvMBasOpo3AIlwADLh9aqEiHSL2eTF4lZNZ52KKKJBN/JPn0xfi4MykzCK5ieMUywkCF1
X-Gm-Message-State: AOJu0Yxj2WIhLloDu0vcOxtmTQup7BKSk9OvAIXKiriNL4GG6+lqq2Em
	uXiTmF+f5WRaXsZYBooYj9f2Ccm61oYX5XX8V7C8N9ENsqNSfn+JbH59m8TUebg=
X-Google-Smtp-Source: AGHT+IFk5RP5dXJvyMBaQp4ZKscBjgf9M2xCAF4MEw8fIURDOrxvHlRLQdBn0ujX5vkXejd2l0qxRQ==
X-Received: by 2002:a05:6a00:218e:b0:705:9fc7:9133 with SMTP id d2e1a72fcca58-70aaaf08df3mr8800144b3a.23.1719891473506;
        Mon, 01 Jul 2024 20:37:53 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-708045aac85sm7537263b3a.174.2024.07.01.20.37.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 01 Jul 2024 20:37:53 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: punit.agrawal@bytedance.com,
	sunilvl@ventanamicro.com,
	jesse@rivosinc.com,
	jrtc27@jrtc27.com,
	corbet@lwn.net,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	cleger@rivosinc.com,
	evan@rivosinc.com,
	conor.dooley@microchip.com,
	cuiyunhui@bytedance.com,
	costa.shul@redhat.com,
	andy.chiu@sifive.com,
	samitolvanen@google.com,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/1] Provide the frequency of time CSR via hwprobe
Date: Tue,  2 Jul 2024 11:37:30 +0800
Message-Id: <20240702033731.71955-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some applications (e.g., DPDK) use the time counter for basic performance
analysis as well as fine grained time-keeping. So we need export the time CSR
frequency to userspace by hwporbe syscall.

Changes:
v1->v2:
Modify "mtime" to "time CSR".

v2->v3:
Rebase "RISCV_HWPROBE_MAX_KEY 7" to "RISCV_HWPROBE_MAX_KEY 8" from
Jesse.

v3->v4:
1. Update the commit log from Punit.

2. Because RISCV_HWPROBE_MAX_KEY in
https://git.kernel.org/pub/scm/linux/kernel/git/palmer/linux.git/tree/arch/riscv/include/asm/hwprobe.h?h=for-next is 6,
so keep RISCV_HWPROBE_MAX_KEY to 7

Palmer Dabbelt (1):
  RISC-V: Provide the frequency of time CSR via hwprobe

 Documentation/arch/riscv/hwprobe.rst  | 2 ++
 arch/riscv/include/asm/hwprobe.h      | 2 +-
 arch/riscv/include/uapi/asm/hwprobe.h | 1 +
 arch/riscv/kernel/sys_hwprobe.c       | 5 +++++
 4 files changed, 9 insertions(+), 1 deletion(-)

-- 
2.20.1


