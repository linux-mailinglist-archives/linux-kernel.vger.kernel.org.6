Return-Path: <linux-kernel+bounces-567307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD60A68461
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 06:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9488420B38
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 05:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225DC24EF6C;
	Wed, 19 Mar 2025 05:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tJXTOjg3"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDE424EA89
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 05:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742360870; cv=none; b=bi/elz02x7h6EpJ48NvEaEMayrrTcfULMLVRluu6FWvE9x4Ph4afiAaREKtSGtB4pdiURfO2bBgoDkCXa+2lgdkkBKUpKzhSJuybhOpcuihrd9soW3h2ixYqzUrsNDqijZnWbDR0P3+o0hfk+p5/dr4404pH0PqhKRhAJyndulM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742360870; c=relaxed/simple;
	bh=echg6bhB2aBWSvnzX4SOEk+Z9aELKuECpxJgQ98XvbI=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=TUrb0ZENr4ZZVvuHZfcwWoDKnFcr5Aw0Ko8yO72S9GViCuC0Hkmy2xTa2GGhXqHHDRWkHhrsFER0ImEdYYxBPx6c4RdOXU9DIbc3SjeVt9Jncw1HwFpFvtrTZ60bItOFox2iT7ZEkbdMrWYHHo29DViAHAdMNBgJ3LrdzXVaV2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tJXTOjg3; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e64124940abso5699582276.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 22:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742360867; x=1742965667; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=abYRMOxViqYMp92GMDii3ruSxpFYmB3QwrQR3Z5L6HY=;
        b=tJXTOjg3NqXLXDMfxlpZ60GRbm6iOZPGsvE+eZ0grzlRvJeJTHRaQXpg2eI5Xx8w/B
         LJ+zNG3ucifIZmuQaVPQ8zOPPAAMssR5I1rzno3oBVVePiR8mgAKpmAke2GGnGrGPuvD
         OxSjxc7byYyLCSVF0uc6lyxYHvMAlwejv0edQZ4NMNTSlF40EXBeOQiiy9IDliaXLHCH
         WlUrNKUI6+IGshec0TvWmoC7NRaYUmJ7hRR7BS12kvgvzL+fgqN8HPvVGQYk+eowyUSM
         OYas09z2wQZP94BTOEi0yawhQcpWtV2sV7IIqYuh78Umu5IS7CSYmK668JRCBnFY+iUe
         KWXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742360867; x=1742965667;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=abYRMOxViqYMp92GMDii3ruSxpFYmB3QwrQR3Z5L6HY=;
        b=T9+U9pPgAkxUeSousZDqZIJR7FASG0A3RS3mYT2RdmKDNu2gQ4dK5JKlbER1ZSPxP6
         bl8+KI63gMdw3ZVeFhQhdBz1DKbOUbzLOfnMr67qscs1FxoWclDSMNMPkd26Kli6B6Lu
         AzVCmHXkLW4MFSmC5EmdWXFAJZeVUu/b6isQlvgQNN4AjkUeer7fgsGRbHKL7mjudUIu
         aMNflswPEb6/i9RrvA23w5ENbQA1YMxhBIpeXXbmxfk17jeV9HX/Hv98vatOv2TqzH4y
         OASYrmgYMFNU9oCmlY9WxB51TqOk8FBX6Hf2DfzP4o4j7H7Qom0oDIUI3+u842jjzvz5
         HmeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVK7bBM5FqWvyQ+zFP36ns2MtvX9iupmGIlMrO8TniXdw49PsS5zSCXbTIOOHNl4qdFbhjMijLd1YbN5PA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX4dU+msL7HoWmRpM+Bku7EaN3dKngij/wku7GfIFxfBo53a5x
	+Mx2PgBSZj+QWa0DrS7GYl/QEBouFGFHN/Ge/uQjyw4cBC9ltjz8RApgwOjPUQLRkyI8RhPz0aV
	y72i33Q==
X-Google-Smtp-Source: AGHT+IGRmoWaZCuVB5ee3Iv2LzVEuNeEJLA9zgD9tzBFtuvqHm9F4Ignee+o0RWj2MTQlY6HLf9109e/Wj7N
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:8a11:10b5:af90:6031])
 (user=irogers job=sendgmr) by 2002:a25:b323:0:b0:e5b:f74:f5a with SMTP id
 3f1490d57ef6-e667b456dc4mr504276.8.1742360867177; Tue, 18 Mar 2025 22:07:47
 -0700 (PDT)
Date: Tue, 18 Mar 2025 22:07:28 -0700
In-Reply-To: <20250319050741.269828-1-irogers@google.com>
Message-Id: <20250319050741.269828-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250319050741.269828-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Subject: [PATCH v7 01/14] perf dso: Move libunwind dso_data variables into ifdef
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
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"

The variables elf_base_addr, debug_frame_offset, eh_frame_hdr_addr and
eh_frame_hdr_offset are only accessed in unwind-libunwind-local.c
which is conditionally built on having libunwind support. Make the
variables conditional on libunwind support too.

Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dso.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index 846b74510038..2cc1f6593f9e 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -155,10 +155,12 @@ struct dso_data {
 	int		 status;
 	u32		 status_seen;
 	u64		 file_size;
+#ifdef HAVE_LIBUNWIND_SUPPORT
 	u64		 elf_base_addr;
 	u64		 debug_frame_offset;
 	u64		 eh_frame_hdr_addr;
 	u64		 eh_frame_hdr_offset;
+#endif
 };
 
 struct dso_bpf_prog {
-- 
2.49.0.rc1.451.g8f38331e32-goog


