Return-Path: <linux-kernel+bounces-552297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7892DA5780B
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 04:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF81B18931A0
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 03:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2629313B7B3;
	Sat,  8 Mar 2025 03:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="28TNrnVK"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FD517A303
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 03:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741405598; cv=none; b=Ym7x9EQYUcGSkd7lCEqT0cdqdSDedN0/kVGchC3IgGBk6a2LwG7Qm/3KDSbjojayjdTU6TIce8QDCPV++iJm+QuyRKZ2g/3fG2xU366rSCGm8SI70EJRtLtOD98mqxC6b/CpdQf5OWuvBlBX5e/NyztH2MSGSpnKSh3NaVFgK60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741405598; c=relaxed/simple;
	bh=NI9X3DgbmxaxolEB+CWeMI2e6PnbwQP48nhp90OwwL4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j7sccr92jdgMYQruTocKyWRgCCJoZJeAYpwKogj79wmSvckvC9TbcLdyksj37CJ/xB3SRjd3FL2d6YltKD0pw1vK4wQtI8rAhkisIkmwoDWiq7Jrb8pCJO2yMamSWbehtV/M55UM/Kwh2iih8s5/JogrkMuKyU8yxpt827sHSuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--liumartin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=28TNrnVK; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--liumartin.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff6943febeso4095737a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 19:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741405596; x=1742010396; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wwsW/fsMcg9hrgcDTPBIA7gFDpTcqMoDXdqlqDc9hnc=;
        b=28TNrnVKTu9M6VyNHTPFufBtewo0ym7vgZs5rk7FTTZ5PvdkvsJaE1IYAaY9XxCsvN
         63uifaSaSCZlW7bbiF6qCvYASW+GkdXznXoIjpMtvgRlDHhLRX/t1fZ1EBT69E0iAxBl
         s1ykV3KE4rDO8b5kV6s8R8yZ0QDOJj98EcUyv4MF4h8PcQ+Ta71cxEJgtVpZEG2SnTSX
         rWd0vaOhcoQ0uKYyINrPEKjPIwVZIMF+aqHdfZISA3NZK/mT2ZyPwkKa/X3qoESO4zR9
         DXpNfochfIBrEKB6MoQnvBMkQ2TkypAIxnkELg+fl/m7t/V22zrcCKSN1ZDmtF8ByNVr
         wa4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741405596; x=1742010396;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wwsW/fsMcg9hrgcDTPBIA7gFDpTcqMoDXdqlqDc9hnc=;
        b=Xk/vq9vaH/YKCblrkXGM9E7rVMCvhFqS0v1iFMEJesKPaSzpre05BzBEAHMsSV0yI5
         Q2RIVSDY0Eez2+lpeK0FXjeuAUr8bY9Jr2WH5DnsZMr6z+qxl/sn/1paApdQNT3zMj/J
         /i8eMWVhwXB/+ewiHPE/+8WjFtOcQQr8seOzcofaaDYuqAT1AfzbLDIS069gIM7UpS90
         79CQA/Hm4/hiunbFN5CSfT2V3nUkbUclSz6+4jLAwXdhAWmUdJindh3HOylX/8cg33HD
         FrjSf+AsqfGS2OsgWhL1KR52JvbrK87kazfJdPJG+pnaivjBrgCeQCOhOp2YYOqrV149
         6wYA==
X-Forwarded-Encrypted: i=1; AJvYcCVEshqxccqr/1vXM/9VgqCGrh4OzH2s9mHpskIys5yQf5e3+q8XvrDfD2AuhJ3cxap2WWcv/8PMMO4TeTE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCj6NKVvdi/wiJ+lRhK9EfaSrSp0CYWh2t6eQoApkcmxsIckGA
	BblvtoEF4E9/3C3PWhHN6pU6e88BaGKq4mk6V/3vsp5hWFtE8nc9Vg8usXIhxds6/ANiecfX/os
	K7JX4OCXR4dTimw==
X-Google-Smtp-Source: AGHT+IHRnkN6wrQOrKWkYrcoXo9vtRqSQ8tpu752H1VzwAoAmAJAj3Fmg6NgVlqukZi3r99JBHgGyN9zS8N/9j0=
X-Received: from pjur14.prod.google.com ([2002:a17:90a:d40e:b0:2fc:e37d:85dc])
 (user=liumartin job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:254b:b0:2ff:5267:e7da with SMTP id 98e67ed59e1d1-2ffbc1468f9mr3198164a91.3.1741405596445;
 Fri, 07 Mar 2025 19:46:36 -0800 (PST)
Date: Sat,  8 Mar 2025 03:46:02 +0000
In-Reply-To: <20250308034606.2036033-1-liumartin@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250308034606.2036033-1-liumartin@google.com>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Message-ID: <20250308034606.2036033-4-liumartin@google.com>
Subject: [PATCH v2 3/3] mm/page_alloc: Add trace event for totalreserve_pages calculation
From: Martin Liu <liumartin@google.com>
To: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Martin Liu <liumartin@google.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

This commit introduces a new trace event,
`mm_calculate_totalreserve_pages`, which reports the new reserve value
at the exact time when it takes effect.

The `totalreserve_pages` value represents the total amount of memory
reserved across all zones and nodes in the system. This reserved memory
is crucial for ensuring that critical kernel operations have access to
sufficient memory, even under memory pressure.

By tracing the `totalreserve_pages` value, developers can gain insights
that how the total reserved memory changes over time.

Signed-off-by: Martin Liu <liumartin@google.com>
---
 include/trace/events/kmem.h | 18 ++++++++++++++++++
 mm/page_alloc.c             |  1 +
 2 files changed, 19 insertions(+)

diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
index 9623e68d4d26..f74925a6cf69 100644
--- a/include/trace/events/kmem.h
+++ b/include/trace/events/kmem.h
@@ -402,6 +402,24 @@ TRACE_EVENT(mm_setup_per_zone_lowmem_reserve,
 		  __entry->lowmem_reserve)
 );
 
+TRACE_EVENT(mm_calculate_totalreserve_pages,
+
+	TP_PROTO(unsigned long totalreserve_pages),
+
+	TP_ARGS(totalreserve_pages),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, totalreserve_pages)
+	),
+
+	TP_fast_assign(
+		__entry->totalreserve_pages = totalreserve_pages;
+	),
+
+	TP_printk("totalreserve_pages=%lu", __entry->totalreserve_pages)
+);
+
+
 /*
  * Required for uniquely and securely identifying mm in rss_stat tracepoint.
  */
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e472b1275166..69ceab250979 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5827,6 +5827,7 @@ static void calculate_totalreserve_pages(void)
 		}
 	}
 	totalreserve_pages = reserve_pages;
+	trace_mm_calculate_totalreserve_pages(totalreserve_pages);
 }
 
 /*
-- 
2.49.0.rc0.332.g42c0ae87b1-goog


