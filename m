Return-Path: <linux-kernel+bounces-288092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4AC953419
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 16:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FCAC1F28A3C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 14:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE581A01BF;
	Thu, 15 Aug 2024 14:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b="IRHZXds1"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF33419E7FA
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 14:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723731748; cv=none; b=RuYfuPlCdzi/JICMhSYiqngCcLMcaT1JYLTwWlaURgRaBmS92gW/bpUDJgJmNVQhSA7TYGOS8rLFHvVfjIzEo0jYFQeH+uASMacMf+ADQKUigIM1poPXNi3jMAkE4eX9UF+4I1jHeXhxqNk0/umOX8czSe857kbDrKAT1yGywMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723731748; c=relaxed/simple;
	bh=bwPxoLGrbCPaxY4RUl84QG7RB/MKfFMxPB0oh9jgNwQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tkFNm09RKoV1rhu0j08Huaw57JS3uqgX6D/Zfi18v7qS0eFkvTfsd/48yIFRvL2Krc0b2mmMHa0D4dOn5XjeC6oOEQEhPbKkHeyXhFTMg+7hx0/NBtQiPEZimXaPTjcTrxBpDsxcCsTAczgOkIELDu8mEjmuh6vPuBUNypA1JzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b=IRHZXds1; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-428243f928cso6588275e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 07:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20230601.gappssmtp.com; s=20230601; t=1723731744; x=1724336544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G3S9SlZlCivX+9wrTGllTqwoY0HNBQ46uqVFAXjbSLE=;
        b=IRHZXds1gaEvM26klBzDQyZDBu1MXspnXX71pOKyQaSDsC7OMrVZ4EXGD0hJnp/VQQ
         3EcqtppBQ+MoPD0VePnO+JBkKKzRr/DII/ksA/J7jgaNmDeddkuV18pFr8GWidjUI616
         rbZMG8+4x79ZeFytYQKsVZxTXp2BIMLNEmMoKAGKq48QCbATxsQ9+V/kq7CxMg4Zqrbo
         KIl5Vjq0QZ5zg2xIyB/5rr4a482wjLJLFBrAE7HDlwRjTyuAp5qf5UFC039SpuoTf1ZR
         3DNN38/herDczszJiqUXMh9gDrSshVBhnsUXNqQDXzZjic4Rz4sd2cA9yCJPdr8RmVap
         MdVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723731744; x=1724336544;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G3S9SlZlCivX+9wrTGllTqwoY0HNBQ46uqVFAXjbSLE=;
        b=EKYXae3vCYrfuRZoD7noH5WrEnAPeKZtfqPcXBfYnXyrBYv5i96nmeyEYNijP8qEyn
         VojsUT+/hZiPQAH5pUVD7Rlh5hWjNVhhnQdCs2brfaa8MIn0Gsu7vSTDyi6qQWfZ067S
         rKny620RthWa8uFnSlNgMljK+Yb5HGaTFbhHMhz1zpoHREiFsz/XFRAxdxxl89BkDA4g
         Ef3WsR1EvFmSDiwuGHNgm4Oxjh5xArqWZn75PiqNyIaj2lzNUtzLEk8KDCtmMeZR7Cop
         u8sDPADSSUllVZ1bdILSerpuz4hltINcXNmBtlcRnEzLFNBa7tcmcsGaCJhhDltu7g+g
         H81g==
X-Gm-Message-State: AOJu0Yxq/Rz+qWIfMo5IGDJqfdzgHM9aDFcY6NHDujwcx9B+wQnvdIgV
	El9OLD/nfbqLWTKYdCu8yOIq0bOQmKzm8YeMP4FX0ILqRorGaDI/hG9AnHYYh2k=
X-Google-Smtp-Source: AGHT+IG1+08AvwY9H1Tzt/sARe3oMheibf53emloX1WYLJWNxi0fgE+jW7MoHtMBTCCYbqftPT0K7w==
X-Received: by 2002:adf:a315:0:b0:367:8e53:7fd7 with SMTP id ffacd0b85a97d-3717778ec82mr3712345f8f.28.1723731743650;
        Thu, 15 Aug 2024 07:22:23 -0700 (PDT)
Received: from matt-Precision-5490.. ([2a09:bac1:2880:f0::319:81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37189897926sm1661072f8f.87.2024.08.15.07.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 07:22:23 -0700 (PDT)
From: Matt Fleming <matt@readmodwrite.com>
To: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	kernel-team@cloudflare.com,
	Ian Rogers <irogers@google.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Matt Fleming <matt@readmodwrite.com>,
	Yunzhao Li <yunzhao@cloudflare.com>,
	stable@vger.kernel.org
Subject: [PATCH] perf hist: Update hist symbol when updating maps
Date: Thu, 15 Aug 2024 15:22:12 +0100
Message-Id: <20240815142212.3834625-1-matt@readmodwrite.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AddressSanitizer found a use-after-free bug in the symbol code which
manifested as perf top segfaulting.

  ==1238389==ERROR: AddressSanitizer: heap-use-after-free on address 0x60b00c48844b at pc 0x5650d8035961 bp 0x7f751aaecc90 sp 0x7f751aaecc80
  READ of size 1 at 0x60b00c48844b thread T193
      #0 0x5650d8035960 in _sort__sym_cmp util/sort.c:310
      #1 0x5650d8043744 in hist_entry__cmp util/hist.c:1286
      #2 0x5650d8043951 in hists__findnew_entry util/hist.c:614
      #3 0x5650d804568f in __hists__add_entry util/hist.c:754
      #4 0x5650d8045bf9 in hists__add_entry util/hist.c:772
      #5 0x5650d8045df1 in iter_add_single_normal_entry util/hist.c:997
      #6 0x5650d8043326 in hist_entry_iter__add util/hist.c:1242
      #7 0x5650d7ceeefe in perf_event__process_sample /home/matt/src/linux/tools/perf/builtin-top.c:845
      #8 0x5650d7ceeefe in deliver_event /home/matt/src/linux/tools/perf/builtin-top.c:1208
      #9 0x5650d7fdb51b in do_flush util/ordered-events.c:245
      #10 0x5650d7fdb51b in __ordered_events__flush util/ordered-events.c:324
      #11 0x5650d7ced743 in process_thread /home/matt/src/linux/tools/perf/builtin-top.c:1120
      #12 0x7f757ef1f133 in start_thread nptl/pthread_create.c:442
      #13 0x7f757ef9f7db in clone3 ../sysdeps/unix/sysv/linux/x86_64/clone3.S:81

When updating hist maps it's also necessary to update the hist symbol
reference because the old one gets freed in map__put().

While this bug was probably introduced with 5c24b67aae72 ("perf tools:
Replace map->referenced & maps->removed_maps with map->refcnt"), the
symbol objects were leaked until c087e9480cf3 ("perf machine: Fix
refcount usage when processing PERF_RECORD_KSYMBOL") was merged so the
bug was masked.

Fixes: c087e9480cf3 ("perf machine: Fix refcount usage when processing PERF_RECORD_KSYMBOL")
Signed-off-by: Matt Fleming (Cloudflare) <matt@readmodwrite.com>
Reported-by: Yunzhao Li <yunzhao@cloudflare.com>
Cc: stable@vger.kernel.org # v5.13+
---
 tools/perf/util/hist.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 0f554febf9a1..0f9ce2ee2c31 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -639,6 +639,11 @@ static struct hist_entry *hists__findnew_entry(struct hists *hists,
 			 * the history counter to increment.
 			 */
 			if (he->ms.map != entry->ms.map) {
+				if (he->ms.sym) {
+					u64 addr = he->ms.sym->start;
+					he->ms.sym = map__find_symbol(entry->ms.map, addr);
+				}
+
 				map__put(he->ms.map);
 				he->ms.map = map__get(entry->ms.map);
 			}
-- 
2.34.1


