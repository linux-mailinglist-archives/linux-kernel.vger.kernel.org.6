Return-Path: <linux-kernel+bounces-327111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E527977109
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 21:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 428E81F24482
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 19:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BCBA1C3311;
	Thu, 12 Sep 2024 19:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JACBFEpB"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898DC1C32EE
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 19:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726167862; cv=none; b=eWmXm/IJhCzraquUiZvQ/ytyvR+szeep6cGB3iiPdVdgejMgdD/Eq+07L3jpKrwN9MqxxYyzZMaLzTkomqU4A82rysazvULcRNMfppspfpkrPYZLls95hlQQHhVDcSnCIatjrxJAXMbjEoEANOpQAa0AHLX/lLaDA8/V2H78HO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726167862; c=relaxed/simple;
	bh=RJ5W/zYraCvAw7Bh0lRAuAFUwylWc/Oc84BXyHNcF/Q=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=nozS89m69Crz/zy1d6UODQhd91GDwaYG7glrrkiWQNKlm0ShGWuHHXMXiYkk2IR5fRs5vPvBbp3h3/MIVrpqU68qJ5EFEzEwyaCgLWRChKb/vBrjlY04XMNbaYg5HPkguTM9Q8ufT8ouALU9ZLh3/sH1RzyGCfUut2SmeaOhHrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JACBFEpB; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e02a4de4f4eso2599501276.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 12:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726167859; x=1726772659; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PrPXDAQds8GhpE0L2UtYrjlHtGIsSgYNHNY+b4ghkKA=;
        b=JACBFEpBFW5ukfyelPD/vHiLplxULCLgoL+ZG7FjnIcdYcP900G42/ZRvodmgXohFD
         A/P3RxEOBrSqGt54oX/n6hGR3uspNRZmn9IwYO82iIiNsDqbCJxEaA7gEfqio+oWEkpf
         ePHdv+u6lV8xcJcoT2IMd9XUOz2W47zTWXOtz5aCysgrASVA5iBpJ1dZ7OiOy3kasPQD
         uZyfgIMPaM+fkzb2LEvmCDZ/3erJDnEs1lCRFjyBuHt8P3XHBom6btmMfegoQE2GwrQP
         qKBnWPK/aDD31yDsA6iIHPn3qEed6qpnqPBGvM4H5hLzBfxD/ggKmMb+ecFQqLTTWQKl
         ifwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726167859; x=1726772659;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PrPXDAQds8GhpE0L2UtYrjlHtGIsSgYNHNY+b4ghkKA=;
        b=lWVT17VJvs8iizcz7A2gWskGHM0u18L8HcHmDfzNIFYegJi4owAKbWLMBVLUiQKK5t
         tSei5uGG5tPQajnAGNotcwG9X6EVpShJB+SShjTGKGXCCv3sO/pZJyqyIti243DlbCjp
         zLfwI2CWRRDOi6tozJim3x/An/ccmC12gQGkjmbts2s3uBWJ2U6Q0rp5vRAzdkIqd5S3
         tYgTlskLsoKec+GPHZWowJzdusOX/+AXfAueve377rwKfx71UJLelQVGtF5fRE2X1guE
         H8QVuy09sWxQNS+kSizzz3J+bj6EpLlznFTtK9cNvHL7KQzZ10kWW/TyOft8N8T9YoXB
         NA9A==
X-Forwarded-Encrypted: i=1; AJvYcCUZl6jo+qKANeiiusZsVlohRDL/AMhN25bt++q8GWkNAqgFoFNRw5MJ9aReDOJFeDf7IRWh3s6ScPijaCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ3XY2wcAoAleuHcB0OKAFGXbeJqk6p1kPz5+rzIRFDhK9h/9C
	t/CZh6sV6bwi4qo28+0yRbpkyrOl6PyNXv9u+nFyC3QrcpgHGFFXHwUPZW3tCRv1J2pCJY+K+3+
	zEsxJRg==
X-Google-Smtp-Source: AGHT+IHsr4g0/u3/EUs9RZtOfqnhRbYbbDoqivzh2XAZyTREatuXZND1Qt3I55ORB/+O5w6/zYZkDZX/sbon
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:cf0e:7a99:e672:3862])
 (user=irogers job=sendgmr) by 2002:a25:bfcd:0:b0:e0b:cce3:45c7 with SMTP id
 3f1490d57ef6-e1d9dc5f6bcmr4760276.9.1726167859376; Thu, 12 Sep 2024 12:04:19
 -0700 (PDT)
Date: Thu, 12 Sep 2024 12:03:40 -0700
In-Reply-To: <20240912190341.919229-1-irogers@google.com>
Message-Id: <20240912190341.919229-14-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240912190341.919229-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
Subject: [PATCH v2 13/13] perf docs: Document tool and hwmon events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Weilin Wang <weilin.wang@intel.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Sandipan Das <sandipan.das@amd.com>, Benjamin Gray <bgray@linux.ibm.com>, 
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>, Howard Chu <howardchu95@gmail.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Yang Jihong <yangjihong@bytedance.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Changbin Du <changbin.du@huawei.com>, Ze Gao <zegao2021@gmail.com>, 
	Andi Kleen <ak@linux.intel.com>, 
	"=?UTF-8?q?Cl=C3=A9ment=20Le=20Goffic?=" <clement.legoffic@foss.st.com>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Junhao He <hejunhao3@huawei.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Yicong Yang <yangyicong@hisilicon.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Add a few paragraphs on tool and hwmon events.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-list.txt | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
index dea005410ec0..7e3cd6c5e35d 100644
--- a/tools/perf/Documentation/perf-list.txt
+++ b/tools/perf/Documentation/perf-list.txt
@@ -243,6 +243,21 @@ For accessing trace point events perf needs to have read access to
 /sys/kernel/tracing, even when perf_event_paranoid is in a relaxed
 setting.
 
+TOOL/HWMON EVENTS
+-----------------
+
+Some events don't have an associated PMU instead reading values
+available to software without perf_event_open. As these events don't
+support sampling they can only really be read by tools like perf stat.
+
+Tool events provide times and certain system parameters. Examples
+include duration_time, user_time, system_time and num_cpus_online.
+
+Hwmon events provide easy access to hwmon sysfs data typically in
+/sys/class/hwmon. This information includes temperatures, fan speeds
+and energy usage.
+
+
 TRACING
 -------
 
-- 
2.46.0.662.g92d0881bb0-goog


