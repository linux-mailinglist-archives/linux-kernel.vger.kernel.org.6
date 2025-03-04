Return-Path: <linux-kernel+bounces-543208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2802AA4D2D1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 06:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A768F3AE3D7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 05:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28C41F4CA7;
	Tue,  4 Mar 2025 05:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0RL2eoUX"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9841F891D
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 05:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741064690; cv=none; b=hLgStJFCDKt51fWxO30S9xJWoexHsEqoN+SFnIYqb3WMo301/ErcCIZeDybDpvo6m4xbt3Sq86mfNos6912TLajxy+47ghAdGdcZZ0ooGAhwzfoHEHm5ihDB+TQB/jKslgmuJc5/zp+5lQRmLYIA03yz03TQ0MI2BL/tZv08EFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741064690; c=relaxed/simple;
	bh=nhCPtbgEZDkd1Kvn3UPUrTlm5xI1UpW+IfGhCPsfYms=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=M7258C3cvuZ9u9TUirEX9cXh3CgUcEksrK0cVYEcoSKvYpwsB/JdMno8fqGTZVHWw91cSkk+DgXq43In9cwRLzVqkKdKlKq8IxR/jeA+lHlvuLNx/8uZTnLnURzQMuosSiy9K3VGL0Z1dpfe4Q6NlzBmlME4AYZOCCrm11qtdMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0RL2eoUX; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6f27dd44f86so73664577b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 21:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741064688; x=1741669488; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tzAqyNBDcatrD/dNYr5THRvvcwinanMOXL+SW4MgEks=;
        b=0RL2eoUX7RIfqZXCSjM5SQhU/z4TknpBx6tfJnMTpIjku5f9aHfQIGDExbZKHZSzQH
         zuNtG8qkuxoM+tLl+A5zLimPhqq74v4XiBT9AFpPR//UQkAnMcUL3W8x6FkJkVZWUYez
         rJu1rucnNPFRjJPZ6nc8XaINgE7XOCp0abzB0wNYqG47Rs03cNW34m9TzjXbmlze1cSv
         EysktXmM3R3eALOHxbj5WkaEBpsGKfK+IO+Tv+WZ0cjR+ZdFszFHxgnsNIlZNiJVr3Up
         qHRo7bMI4+xCFSZKIcGX0qgOKdBvIwrXSm5Dvynm19ifKhLjGYtBBcn81kh6upR/Ey7e
         976Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741064688; x=1741669488;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tzAqyNBDcatrD/dNYr5THRvvcwinanMOXL+SW4MgEks=;
        b=pA47IyeuJQOKlztfndGdPQEtr9WXUMKm4+nQnX/zTCdMDDAKZN5wFmh68DyL4S3Axe
         nPsnVywWhKLhe7b6AUQWy1aAJSutwkrMVEbhmihtc16By0j44Xm68a1Fv/Uhj/co9asN
         ksOaF3RUJAfsTrEWJG6nsR1nfgMTXvK3wqFWzXxBV8FA5G2JjL511sAn9RPVltkLiwib
         7N0xtW3sOj3qiuo1W8JacZ8fDtXmTG+6NYiHqM1jlZkjOxCMuTo0xsNAoorlRcfY9SUK
         ridjW7exCv1sTjO+HZ1vRKH06FXyg882Tag0RewKIWX2bhxiJETTvDLbq9ZNNBF+mZFN
         Y6Wg==
X-Forwarded-Encrypted: i=1; AJvYcCWDSiofh8j0NMtqlB7kJ87MjEjAMPefirsao5dE1k6NTYHEPxRQh1ouNv8Y5rTfPtCRAhl/zFWcKX6cpts=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD/y1AWoH8kFqexpq5pB0t/MT2ikjl5AoEAqh794idpSWI3BgG
	MkFgZ0stKbI5M5sRWo3P3kTH+EsOgTy4VWudZnVutMt/7LwN2u9T/UZ0ZRGurx+OQl2ChbeU7kG
	eqQuN3w==
X-Google-Smtp-Source: AGHT+IGcXI4xtcRg7TZCt539wnaKT0i5MXbKrcmjSAdt+8/cOoexhcuHk6pVgzO15AtSpOO1xbrgGJNcQRci
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:8af9:d1f7:bca9:da2])
 (user=irogers job=sendgmr) by 2002:a05:690c:2a81:b0:6f9:ad6e:5945 with SMTP
 id 00721157ae682-6fd49e2336dmr19606227b3.0.1741064687649; Mon, 03 Mar 2025
 21:04:47 -0800 (PST)
Date: Mon,  3 Mar 2025 21:03:05 -0800
In-Reply-To: <20250304050305.901167-1-irogers@google.com>
Message-Id: <20250304050305.901167-12-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250304050305.901167-1-irogers@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Subject: [PATCH v4 11/11] perf syscalltbl: Mask off ABI type for MIPS system calls
From: Ian Rogers <irogers@google.com>
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, guoren <guoren@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Charlie Jenkins <charlie@rivosinc.com>, 
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Jiri Slaby <jirislaby@kernel.org>, 
	"=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?=" <bjorn@rivosinc.com>, Howard Chu <howardchu95@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, linux-riscv@lists.infradead.org, 
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

Arnd Bergmann described that MIPS system calls don't necessarily start
from 0 as an ABI prefix is applied:
https://lore.kernel.org/lkml/8ed7dfb2-1e4d-4aa4-a04b-0397a89365d1@app.fastmail.com/
When decoding the "id" (aka system call number) for MIPS ignore values
greater-than 1000.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/syscalltbl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/util/syscalltbl.c b/tools/perf/util/syscalltbl.c
index db0d2b81aed1..ace66e69c1bc 100644
--- a/tools/perf/util/syscalltbl.c
+++ b/tools/perf/util/syscalltbl.c
@@ -46,6 +46,14 @@ const char *syscalltbl__name(int e_machine, int id)
 {
 	const struct syscalltbl *table = find_table(e_machine);
 
+	if (e_machine == EM_MIPS && id > 1000) {
+		/*
+		 * MIPS may encode the N32/64/O32 type in the high part of
+		 * syscall number. Mask this off if present. See the values of
+		 * __NR_N32_Linux, __NR_64_Linux, __NR_O32_Linux and __NR_Linux.
+		 */
+		id = id % 1000;
+	}
 	if (table && id >= 0 && id < table->num_to_name_len)
 		return table->num_to_name[id];
 	return NULL;
-- 
2.48.1.711.g2feabab25a-goog


