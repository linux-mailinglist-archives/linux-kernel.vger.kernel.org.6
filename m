Return-Path: <linux-kernel+bounces-284061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C33E94FC83
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 06:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58F202832EA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 04:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B941CAA2;
	Tue, 13 Aug 2024 04:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SGMrBUvI"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B609829A5
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 04:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723521984; cv=none; b=ovsWPvDYjKIjF3U77Iiq4XIvr50MCH8i7nVgE181+GNoio8H1XLGcXMZLb1+mZoXsHRJblynEZkvyHQBLfNCgfMUM9bL7hWpPhcNk618Tg38TT72pjbcYR1Iv2AoKpaI7vAoQmmPej30Cr66nUkPqsw9VBBKfzwYdGbra7RlTX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723521984; c=relaxed/simple;
	bh=r7VLecbvEUYJZiNB7TVZd9Y4ujlIzmSV6v7MT/SSs8g=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=jWHy/DcSlUqIfCwEX/XsWUgfbC27x99lWDyYJcLmEErNfMyVxw7Wfuw/zopnWNo6Xe5vIDycyw7dIRJ0ACKvujY32QZ77TYpqgvYmACHu2M+83SVFmonu4uW9Xd3ILrUQIQGGV/hbBxMEwcWhtJn/8+51kOh+ll9Sbpa9rONhYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SGMrBUvI; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6902dc6d3ffso127054267b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 21:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723521982; x=1724126782; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=N5G8ycQLaD3nMVPTOXPScjjttSakw9EtQa3FEUmBo6I=;
        b=SGMrBUvIcUAef7dnNvuhb1B97BfqY3vyk689NTPyNSwE/5mFGR111rcUGM+YLhNxOR
         4cTA06GOKR99P0B7xE1YautXPHDOuB0137bxf0HtvZLEHv0qD2fENIb3JqMmvO8tOJwa
         ueXGWqfAs24NGv/vRmWyRYE4LcQykIo0uIil9juc1Vtw/xSgZ4DcKL1PKJjYv8WbWFK8
         k0HwuKLiNi+ObTJp1jHIogubJqtXdZHJ4XT5iTY8x09zARED2ipw8LpxBroyOQQtajcM
         y0IuHPzShHc31EJnapA59NAv5bFBJeLdvG4edU42TiDxYQ5uP3B6mqxAXCenKISCxthL
         IcFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723521982; x=1724126782;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N5G8ycQLaD3nMVPTOXPScjjttSakw9EtQa3FEUmBo6I=;
        b=p+pMe6nJ94KVyX4Z9nS4SWwLl8F3GAY0TMaBn6W2h4063ctncF7470MHcNprCEGpIX
         jOWBMpQORyGzXBwOY3x3ZUYxiEimqSMis9e7drqZWKrgzclpJb9a0NZC1bLzAnJhI6Bm
         YXihYVpHxaBrwpcSsgfeMF+DdL8LhH/hMmgWP1B1EeydDvn2ug7X6tgjenbDHfiE5cc4
         1J66lroQG37pORsAGrE1NxVlg1nZzNEpLNuHAZdnv4K3EPSmao3vGLJu9CXAMneUErgk
         HkUzCJ4cttCJXFr3W15znvglp0ub1ZOEIcrs9nx0mncj6/te6QKkTLZIdVpVMjbj3SJY
         XoRw==
X-Forwarded-Encrypted: i=1; AJvYcCUd5VsdFL76mxxO4DPFQnxwegaKn+CWCjXy+a9xHi7iPgH8RJuNQ+DuzTklHymCUBYzs0QRYHnpdcNu7Sv8BBINNfa2jfZoT0mvXpaQ
X-Gm-Message-State: AOJu0YwxAFQ6o2GysCPIxqOH3WyoKejyAaB8RwF/j0+dyNCw9BcJm6zM
	sB6s7mouluapzAQKVjZ6e3cohaI0k1Ps4jZO1ExMWsx2MIbpieDw2EQVVxrs9RYnr/+QpO6AwoR
	35ELO5Q==
X-Google-Smtp-Source: AGHT+IHk5ugUWyyThW7pxKGjaf9kqmY9IFupwIrVuW8y8MBzmDy6CjYnNOFMda07TvzD1c+Cdw29uEdYt2JJ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:ae34:31b6:7154:c399])
 (user=irogers job=sendgmr) by 2002:a0d:e706:0:b0:699:fc36:65ad with SMTP id
 00721157ae682-6a97238e489mr851317b3.3.1723521981709; Mon, 12 Aug 2024
 21:06:21 -0700 (PDT)
Date: Mon, 12 Aug 2024 21:06:12 -0700
Message-Id: <20240813040613.882075-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Subject: [PATCH v1 1/2] perf disasm: Fix memory leak for locked operations
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

lock__parse calls disasm_line__parse passing
&ops->locked.ins.name. Ensure ops->locked.ins.name is freed in
lock__delete.

Found with lock/leak sanitizer.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/disasm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index 22289003e16d..226d2181f694 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -566,6 +566,7 @@ static void lock__delete(struct ins_operands *ops)
 		ins_ops__delete(ops->locked.ops);
 
 	zfree(&ops->locked.ops);
+	zfree(&ops->locked.ins.name);
 	zfree(&ops->target.raw);
 	zfree(&ops->target.name);
 }
-- 
2.46.0.76.ge559c4bf1a-goog


