Return-Path: <linux-kernel+bounces-552296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6298DA57809
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 04:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C29F16C4F8
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 03:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D23B17A2E9;
	Sat,  8 Mar 2025 03:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DaqW5zSc"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7514117A2E5
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 03:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741405593; cv=none; b=ApfLs+oU2ATuZgR5JxuBRBS7wBJmquLnhQfZihh9gsfXsnP/jmUJFVY2Bjyl1VJ31zRCWCvojeTnr7sPxRWdKIZE1lBKqNHS+v5bjQ+Vf7mnhEo7TBbXRUGohPp9m0WGkr/Ed6UXJt2HH6s5P325AVZ4O+c8U01tOLnEBwNeonM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741405593; c=relaxed/simple;
	bh=vJHy2IUPEgEsBBHwQ9JzIOPIFYSSfIpFmAIUuojoxHc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kNw/cp0v9AZBkTYCi3XpWCWXTXek5vV17RR3r8gfLawj3RAgirTiswpjTF+2DxLE02rBR6CCgPBW+rZThrpQIGzHPio77g8g4EK8pxp06tmtTXK04IuTQWTGWRReK097as86jwzRzBOWwb6GUNityuarN0sv7lDKC0Wrqq6smro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--liumartin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DaqW5zSc; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--liumartin.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2242ca2a4a5so14855285ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 19:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741405592; x=1742010392; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jRUF2A0NjVDGv1OExSsTFIcZcGSpPPHCJXmqzE/QHcg=;
        b=DaqW5zSc9R3bIT7BZaJw70JB1mkltx5vN+rL8w5f2XV1Fmu40DPZdx8VLECQnKagJF
         P5WSkkNWUTYcQBzDZ8EFJK7TKUlkcAxkF5V21hnUkGKK3b2EFGtFfoklJbkFZMBoQriE
         6EshK1fBLVCF6lnAI0kOr9hzFMlQ2Yi3sKJsjZ+jkDCHDTOTJs0Acrcx67jLeK7nPiML
         Q8tV3B67ussWvvU/IGJZJI2KJX59w7DaHnV6jLzD/gkgYeFDB4a29x9o4aH8s0w4dDNC
         FCnY/PppoxFFwAMaxcJRknrv/7Qm+qcASEoUNxHCxTvnUujDg7RwKec/eOvqrL+rtkb4
         2wkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741405592; x=1742010392;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jRUF2A0NjVDGv1OExSsTFIcZcGSpPPHCJXmqzE/QHcg=;
        b=kyO7jDpbHNKCdL6njX9cIxOd/Av/2gpDvLcPpx9UfXQqcgpslHShv/76B2Ke0RZ35u
         AE0YAYTQa2omleqKCTzXWeOvlCJqzuD00m6tIl0b8ylVrIu0tSf9OnVcHdXBangPDN4H
         ttLQkw9Ju+knrddQpPheBf+ieUpCAz8opx657x+dtg+DgH7KMWa9PsenOpsOxTNq9QLI
         WlX00mLmjb0fIQ1+tuhgEZTbZf6NI5886p/aSGeObFAm+3CI9zitkT26Z7LGzSLrhUIn
         lFgWddyzD9Y+q2gkHovy/pvPGtK3e3Fr8xpAuflfkAhStHNaNjdNUojBVvBECU+6Zp/i
         8muw==
X-Forwarded-Encrypted: i=1; AJvYcCVtGIyMRXISUY0uuuu8iaHpXE+MrhrIKbB7QK43BT4ImkPliTeDr5/loWgmXPDUJk5vhIE9jEyBJSP85qI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCa666s09c87rMR1P+zcL3WgpNgJZzs6xvjfbOlnF78KUwyhbp
	3agKZSh8JUVdYtCl7dBDR4jb2AEOTA11ViXQdwuVoyWQYAVDdqzNx09Yw/33aLqe5xN51Tvryg8
	4lisGIwseuFQGYw==
X-Google-Smtp-Source: AGHT+IFHishigmPJTfF8nas6Rd2GTRrOt9x7gCcp0cLHMvtmvYE/TqBCRKvb0jMyKWRCKVmYvNm/YWfbFyHQFC4=
X-Received: from pfqr27.prod.google.com ([2002:aa7:9edb:0:b0:736:56a2:99ac])
 (user=liumartin job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3c92:b0:735:d89c:4b9f with SMTP id d2e1a72fcca58-736aa312be5mr8792595b3a.0.1741405591656;
 Fri, 07 Mar 2025 19:46:31 -0800 (PST)
Date: Sat,  8 Mar 2025 03:46:01 +0000
In-Reply-To: <20250308034606.2036033-1-liumartin@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250308034606.2036033-1-liumartin@google.com>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Message-ID: <20250308034606.2036033-3-liumartin@google.com>
Subject: [PATCH v2 2/3] mm/page_alloc: Add trace event for per-zone lowmem
 reserve setup
From: Martin Liu <liumartin@google.com>
To: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Martin Liu <liumartin@google.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

This commit introduces the `mm_setup_per_zone_lowmem_reserve` trace
event,which provides detailed insights into the kernel's per-zone lowmem
reserve configuration.

The trace event provides precise timestamps, allowing developers to

1. Correlate lowmem reserve changes with specific kernel events and
able to diagnose unexpected kswapd or direct reclaim behavior
triggered by dynamic changes in lowmem reserve.

2. know memory allocation failures that occur due to insufficient lowmem
reserve, by precisely correlating allocation attempts with reserve
adjustments.

Signed-off-by: Martin Liu <liumartin@google.com>
---
 include/trace/events/kmem.h | 27 +++++++++++++++++++++++++++
 mm/page_alloc.c             |  2 ++
 2 files changed, 29 insertions(+)

diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
index 5fd392dae503..9623e68d4d26 100644
--- a/include/trace/events/kmem.h
+++ b/include/trace/events/kmem.h
@@ -375,6 +375,33 @@ TRACE_EVENT(mm_setup_per_zone_wmarks,
 		  __entry->watermark_promo)
 );
 
+TRACE_EVENT(mm_setup_per_zone_lowmem_reserve,
+
+	TP_PROTO(struct zone *zone, struct zone *upper_zone, long lowmem_reserve),
+
+	TP_ARGS(zone, upper_zone, lowmem_reserve),
+
+	TP_STRUCT__entry(
+		__field(int, node_id)
+		__string(name, zone->name)
+		__string(upper_name, upper_zone->name)
+		__field(long, lowmem_reserve)
+	),
+
+	TP_fast_assign(
+		__entry->node_id = zone->zone_pgdat->node_id;
+		__assign_str(name);
+		__assign_str(upper_name);
+		__entry->lowmem_reserve = lowmem_reserve;
+	),
+
+	TP_printk("node_id=%d zone name=%s upper_zone name=%s lowmem_reserve_pages=%ld",
+		  __entry->node_id,
+		  __get_str(name),
+		  __get_str(upper_name),
+		  __entry->lowmem_reserve)
+);
+
 /*
  * Required for uniquely and securely identifying mm in rss_stat tracepoint.
  */
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 50893061db66..e472b1275166 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5857,6 +5857,8 @@ static void setup_per_zone_lowmem_reserve(void)
 					zone->lowmem_reserve[j] = 0;
 				else
 					zone->lowmem_reserve[j] = managed_pages / ratio;
+				trace_mm_setup_per_zone_lowmem_reserve(zone, upper_zone,
+								       zone->lowmem_reserve[j]);
 			}
 		}
 	}
-- 
2.49.0.rc0.332.g42c0ae87b1-goog


