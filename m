Return-Path: <linux-kernel+bounces-259140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F0A9391CB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 17:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AEDE1C21717
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 15:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1743D16E897;
	Mon, 22 Jul 2024 15:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GKKMwMv2"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985E416DEDB
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 15:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721662139; cv=none; b=pDy35OPEFlvbgqcFKz+1wAp91C3oChog3fKwSGfgE9Z+uYsxdwZneBeHJISUHC8r+jdJxpMzgGd09f94KyBHp9xjl4DK64sJMrA0s+D7JKB8zCjB+OUChe/jShsSILdx8s0CTBoQ2sKsJtSp2xzUIK0bU49G0tRI+8AaWcNppf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721662139; c=relaxed/simple;
	bh=+5pv0qtz/ijrY++7RLRA+HZnVxXMRvl1jcfm/oqvyAQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hQZ08q/YH4NXlipXp8rEgui8tOCe+0+3v75c2iGLAMaId1U8Ibupt2dSHkwLED9L833DYKjqvNsn28zNSJ0YkcWoaGRt0kossKDsK+4VBGV/6r/X9HenL7CWcQFp9ApemxDbh/Cm9izW9e0sr+X6hMnxctG3Vnh8jYoEV+UAu+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GKKMwMv2; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-426636ef8c9so31391785e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 08:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721662136; x=1722266936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KRn2GZZ7rqyxxxS3W1yWD0PtlBv3YIhE78qAMXkvguI=;
        b=GKKMwMv2fzbCmq98eXX4pUo4tXLGhOx+ZAPUK+K+YM7R76Z8waCoF84uEYDiUw6Nj/
         lAm9y05HZObMLx19GDkl9ODMTavOQPI1FQesCNjULIUjJPxj3ya6mBI72C0WZxS5MPLW
         MurWB8jK6oLUcaQDh3TULcvn5pqYvzTiQjYM5/ef0aIv63J+1UZfp3ZnwBv1BrFESEq0
         3d1oMXbHnQM4MBQYo1xxLOl29UE/GErMEI8yOrqwtNN8Ex5cDcpJMpRfn25En2FHkM99
         WmDBqvwgmHf3uUbOqFgUNn0LnJmmuRjpSCO+FE+bNiEOSV1+N96ksmDF3nFJArVxpJq/
         rMSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721662136; x=1722266936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KRn2GZZ7rqyxxxS3W1yWD0PtlBv3YIhE78qAMXkvguI=;
        b=fwPGsRKAjdSCKrmzgS9EAZPCV5lcgcKxCv+pgT2Kamr2AsfXQCp9iy2dRfum2y3rcR
         SrHOFw+stR5EFaZx6+f4v6yWI18j+xIhRWmRNnhz4vZ9Jo/SKdfDLUDGdFuU09kOXFbD
         cDIntqMdhBv0y0E7tby7ofTapJAXASH4moEsWUK9DtLzTTCvvBiWj7p+6Mg4c2fFG8Mr
         qsBdh4/9zpRgsdNoBkxPwNpt5otnozAFb24E25kovo/RyAi7T3DhfvIhglQ/M7nwYbCI
         qhyvTKc3U8TzFBC33fpBAET9RcpXfgrW4WEl4tApEx3E+pDOOAjBqkTQ6bA5ba/YdYkJ
         4Vjg==
X-Forwarded-Encrypted: i=1; AJvYcCW9crCKmj3CyTFx3CDLXmi6O89FW6bkueyP6qM8b6eMoBQBQeEdkCgl37EbGoaKxavR+Gh19d/PBQKDCCSN867Bkp8d5n0Bot6JvVPA
X-Gm-Message-State: AOJu0Yy4oxsWFPwif9Wjl0C40jYxIEbeX0GOUAPxapiJf1mDqr3UAR71
	bCtiOfnWJN9l9Qyh5rDYurF6RFGv2WNCY0ubpomVVAAsVL+HD/a8hBRFvPgBJ9g=
X-Google-Smtp-Source: AGHT+IF7tKYq40uDVXznXPqhK+EAGVR7+QJEgApq+9Cj2Yd9pJFFjFsijIYOFzkudhGr0yO3VT9Q2g==
X-Received: by 2002:adf:fa0f:0:b0:366:ebd1:3bc1 with SMTP id ffacd0b85a97d-369bae23a8cmr4451255f8f.3.1721662136027;
        Mon, 22 Jul 2024 08:28:56 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a43598sm160654535e9.1.2024.07.22.08.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 08:28:55 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: coresight@lists.linaro.org,
	gankulkarni@os.amperecomputing.com,
	mike.leach@linaro.org,
	leo.yan@arm.com,
	suzuki.poulose@arm.com
Cc: James Clark <james.clark@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	James Clark <james.clark@arm.com>,
	Leo Yan <leo.yan@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] perf cs-etm: Output 0 instead of 0xdeadbeef when exception packets are flushed
Date: Mon, 22 Jul 2024 16:27:56 +0100
Message-Id: <20240722152756.59453-2-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240722152756.59453-1-james.clark@linaro.org>
References: <20240722152756.59453-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Normally exception packets don't directly output a branch sample, but
if they're the last record in a buffer then they will. Because they
don't have addresses set we'll see the placeholder value
CS_ETM_INVAL_ADDR (0xdeadbeef) in the output.

Since commit 6035b6804bdf ("perf cs-etm: Support dummy address value for
CS_ETM_TRACE_ON packet") we've used 0 as an externally visible "not set"
address value. For consistency reasons and to not make exceptions look
like an error, change them to use 0 too.

This is particularly visible when doing userspace only tracing because
trace is disabled when jumping to the kernel, causing the flush and then
forcing the last exception packet to be emitted as a branch. With kernel
trace included, there is no flush so exception packets don't generate
samples until the next range packet and they'll pick up the correct
address.

Before:

  $ perf record -e cs_etm//u -- stress -i 1 -t 1
  $ perf script -F comm,ip,addr,flags

  stress   syscall                    ffffb7eedbc0 => deadbeefdeadbeef
  stress   syscall                    ffffb7f14a14 => deadbeefdeadbeef
  stress   syscall                    ffffb7eedbc0 => deadbeefdeadbeef

After:

  stress   syscall                    ffffb7eedbc0 =>                0
  stress   syscall                    ffffb7f14a14 =>                0
  stress   syscall                    ffffb7eedbc0 =>                0

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/cs-etm.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 5e9fbcfad7d4..d3e9c64d17d4 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1267,8 +1267,12 @@ static inline int cs_etm__t32_instr_size(struct cs_etm_queue *etmq,
 
 static inline u64 cs_etm__first_executed_instr(struct cs_etm_packet *packet)
 {
-	/* Returns 0 for the CS_ETM_DISCONTINUITY packet */
-	if (packet->sample_type == CS_ETM_DISCONTINUITY)
+	/*
+	 * Return 0 for packets that have no addresses so that CS_ETM_INVAL_ADDR doesn't
+	 * appear in samples.
+	 */
+	if (packet->sample_type == CS_ETM_DISCONTINUITY ||
+	    packet->sample_type == CS_ETM_EXCEPTION)
 		return 0;
 
 	return packet->start_addr;
-- 
2.34.1


