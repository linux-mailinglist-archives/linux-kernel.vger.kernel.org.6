Return-Path: <linux-kernel+bounces-375429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 117CC9A95D5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 03:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7219C283A96
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 01:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F5713B592;
	Tue, 22 Oct 2024 01:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="cmDHRYoK"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BAC135A79
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 01:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729562363; cv=none; b=aoWKMV4+vFcHWhEuI6HL5TH0yYibsFE5x4DtmC+drMZxiFkzzPrLkvfCntYaeMWRsTPZ4VxALI5sHVn51mHMwSO3o99dEC0zk2YpuNkwPqUlcsLZRQgtp3BLu2Egz4eIM3sdzGHILy/b5HbniYTfPyxQM8ZHNGhbeblFp4QBT1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729562363; c=relaxed/simple;
	bh=S3WW3tHhxyvl0epyEFgv/DG+AYg+CTrcC41pnvrmNh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E9uC/u8DvWB+czZVJqGiQaWfjuMiS9KsQyl2R3owRzo4RN5yZHvon07bbyte8dLNTLmeQ9+vFc5YuNhx3Fsrv/ZvxCre1TRxdiH+P3o7toN8+h9sAMhnsw1XPi99DI39jh+urvMYigNm0yl3nBF7V2/K8OkcNYqUCRVsEy0JgDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=cmDHRYoK; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7ea16c7759cso2713812a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 18:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1729562362; x=1730167162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9FnCjcC1/gsDOd6L8rx/6dcUkVYp18eK0+PNRkpMvb8=;
        b=cmDHRYoK+wQdZOUDqNM2qACIEGndW8pyWy6xEH3yHVFXHVrQOuUWkhuSuPIwC2XQV9
         //8nhrEWA6U+39Co01DnfTT8a0B68jn0ubIpSWciEhrPdV/6wN7j8YaNcgfkrkMtwNjA
         P0XG1nTx/LmtDT4mU83zinqvcSJMXOOg3ibqLJpdaYI80ejslA80JBMUnKv/xtC54F3l
         2MpawZhshMKpGHB90NB+BLOBdCD4VOT7G6NHxCyRzFBSxksBoLQZwRSrSZwBppq8A9pj
         5XdskQHjU0IKCG+gPLIuUuV8YSv/3RF2qZCM37vptXmM/iVb56j8F6LjdL5RlPncc52Y
         9JoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729562362; x=1730167162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9FnCjcC1/gsDOd6L8rx/6dcUkVYp18eK0+PNRkpMvb8=;
        b=kWdTXlJNfKi+IEIXaKWhBzZ1mvrkbGjRevsapupKbUxCTTUHOjRGkN6iwiB9Wjy6ul
         lUdemTbE1oOxwbI8Xbt3c5oU4eIVKWay+BaIgKt8T0Nu2xGx1LHR6UBDiCLdYzB3A0EL
         4KlTiAqe9pZ+9vr5MryJNCW6Iy+UjF+qOarDXuBJTuNny1x7ZTbTcvwUMgail8+eHJd4
         tgahz20Bujkzeaq5gB2PWDiehONG/6zTvBaVMode/2UuraF5+T79+F9A02AfEKVnozCk
         Vtil4TA0nPJh+6OeNq1cSLYEzfN2uwCxsNidjqx6G7uKYz9kkZKHlFndAFDegWTfdZ2T
         PPAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMkhbmwu1yUBftI7Xn0TqJGq6zcz5CLFACmNHU19ldSrpJW94bk6/CKxYZ9OGnz88s4JpPrhkSULOT5T4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfuHWvvJPx91RBoaoeh2Jtr+Z+DA2pu2b/dU0EAgApkgklmcSR
	5ibqWXfL6i4WaA0w3fGn0CC6zTQiJcdFDImOHjun2hbg0mXOE9qDBuBUoXGYEfU=
X-Google-Smtp-Source: AGHT+IFrGG6oMYUOck7CBYXToXMnxG+Lx4oLmbcg4j3FeL+zQkCHcoYgP+J0xW6HIU5j3POtBJfPHg==
X-Received: by 2002:a05:6a20:43a4:b0:1cc:9f25:54d4 with SMTP id adf61e73a8af0-1d96df0ed05mr1060384637.38.1729562361689;
        Mon, 21 Oct 2024 18:59:21 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec132ffdcsm3600710b3a.46.2024.10.21.18.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 18:59:21 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	kasan-dev@googlegroups.com
Cc: llvm@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Will Deacon <will@kernel.org>,
	Evgenii Stepanov <eugenis@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-arm-kernel@lists.infradead.org,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v2 3/9] kasan: sw_tags: Support outline stack tag generation
Date: Mon, 21 Oct 2024 18:57:11 -0700
Message-ID: <20241022015913.3524425-4-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20241022015913.3524425-1-samuel.holland@sifive.com>
References: <20241022015913.3524425-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This allows stack tagging to be disabled at runtime by tagging all
stack objects with the match-all tag. This is necessary on RISC-V,
where a kernel with KASAN_SW_TAGS enabled is expected to boot on
hardware without pointer masking support.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v2:
 - Split the generic and RISC-V parts of stack tag generation control
   to avoid breaking bisectability

 mm/kasan/kasan.h   | 2 ++
 mm/kasan/sw_tags.c | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index f438a6cdc964..72da5ddcceaa 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -636,6 +636,8 @@ void *__asan_memset(void *addr, int c, ssize_t len);
 void *__asan_memmove(void *dest, const void *src, ssize_t len);
 void *__asan_memcpy(void *dest, const void *src, ssize_t len);
 
+u8 __hwasan_generate_tag(void);
+
 void __hwasan_load1_noabort(void *);
 void __hwasan_store1_noabort(void *);
 void __hwasan_load2_noabort(void *);
diff --git a/mm/kasan/sw_tags.c b/mm/kasan/sw_tags.c
index 220b5d4c6876..32435d33583a 100644
--- a/mm/kasan/sw_tags.c
+++ b/mm/kasan/sw_tags.c
@@ -70,6 +70,15 @@ u8 kasan_random_tag(void)
 	return (u8)(state % (KASAN_TAG_MAX + 1));
 }
 
+u8 __hwasan_generate_tag(void)
+{
+	if (!kasan_enabled())
+		return KASAN_TAG_KERNEL;
+
+	return kasan_random_tag();
+}
+EXPORT_SYMBOL(__hwasan_generate_tag);
+
 bool kasan_check_range(const void *addr, size_t size, bool write,
 			unsigned long ret_ip)
 {
-- 
2.45.1


