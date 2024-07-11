Return-Path: <linux-kernel+bounces-249179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D41C92E817
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 14:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44FBFB26443
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 12:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D6A15B971;
	Thu, 11 Jul 2024 12:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Rxc7LXqc"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9548515821D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 12:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720700211; cv=none; b=Vd7MFIwNRGRjjc5wGpx9sOaUCfy+aZWI8NaDsBKVdsN5HUIP9iYM4fXDJHkWeP6+N8BoHsvMH4RuvZlpREAB5JCdviQNhHVaiCAuQpk/olNEwhwzOSHS9XHOEgsGcx1zzkvQCFUGa9Hg/FEjmqWxxUhCjqnbtK9psPwn+cJ1uKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720700211; c=relaxed/simple;
	bh=ZfAsVuNJJ62xC1bcTIbeqw1Vf7WWhi/N/16QxvOY3I4=;
	h=From:To:Cc:Subject:Date:Message-Id; b=nItSKvh2wItSps3vOj13ZqAw+lS++Wt3zBxEl4ZVla6RxFaYtrum8IaDoT88BH9oLr3RKq6e5tVo8CIdF0lH00ZkgQiMqsCmKw5Bcr1DqpfW7yPiCo7u/1XtngJAkZTxeQDKIuQgyvRH5XIXbmjnhw8VjPhcL5AGOAwlz09xExM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Rxc7LXqc; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fb1c69e936so4808275ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 05:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1720700209; x=1721305009; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=69MGJS0GUVdmuIBER5VAis30J1V0mIU5m8y/mihdUGU=;
        b=Rxc7LXqcImPXtzlReoUWe2u3/h7I5ldHejElBDtJSWHjXr0tFTmLR2c71qFdEbRW2Y
         ppLFQQI9DfUmYNAzDMLCbHXzwMJsSXEuqW7G5mB4pQmyIblVCq+hFrWsgbRuLjp5spHE
         BMWMBPbwo7pk61Y1Jmh70uMdu4gI8e3/xFXiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720700209; x=1721305009;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=69MGJS0GUVdmuIBER5VAis30J1V0mIU5m8y/mihdUGU=;
        b=SrQ2FVakm7elrL2Brj5m10wnt8o5tpZIYk1MMfcudNbLNg68CfCs8m742VQHjwr+Ek
         8+OLq1Em3kK2lf+HKqJFM48hFDCxtszFObWrFvLMKmXxcXAG+xQKJY4nMr+6D7KOrxDB
         EMjb4HY3qBikBelZJH3dp1uPsM8o/Bs51oinMeipH7i2ZscgK+ue+6LihabgWLA5WYSl
         e1/HCbrACgej+KOtI4wZ5L/4rPhmnnoFor+7ta3CB2jCeT5qb6T6AUgAB5c7DuvPvZqJ
         ZNBIaXOfZsnWvHbWiHzwSVm/PYaCTZd/CweDkgJb4zliAlh7UjgmZ4hpcGkXbX/Wtnwy
         VI+A==
X-Forwarded-Encrypted: i=1; AJvYcCWmqZmGwwYIB8VBpNGfKaXcvmstA5kW7TJiDW/7H7y6mv9kN472ptFruXd5pkG/HqCi3P5eDJy25YDuf/Izu00edmG9jhgj9dipyQJp
X-Gm-Message-State: AOJu0YzHswAZcUout7QlQamNBTIQswCoJCkas0H4xuuwqfzlgsT1mOZY
	YqaDIFd66/5+o81ROfqA+x6ogaT5O/elPSdt07fXuSVEUQYJxky2baX5LiuM6Q==
X-Google-Smtp-Source: AGHT+IHG9vlr1+SQHRmtirHN1TlrG6AYVNhO0rfLZ1Mq7oWk5uGx3JJBpdgpM2ugZa414Zhlj2sbKg==
X-Received: by 2002:a17:902:e852:b0:1fb:67e0:2e0a with SMTP id d9443c01a7336-1fbb6ec3f7emr74346465ad.48.1720700208757;
        Thu, 11 Jul 2024 05:16:48 -0700 (PDT)
Received: from akaher-virtual-machine.eng.vmware.com ([66.170.99.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6a10111sm49211985ad.20.2024.07.11.05.16.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jul 2024 05:16:48 -0700 (PDT)
From: Ajay Kaher <ajay.kaher@broadcom.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org
Cc: mark.rutland@arm.com,
	rostedt@goodmis.org,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	yangjihong1@huawei.com,
	zegao2021@gmail.com,
	leo.yan@linux.dev,
	asmadeus@codewreck.org,
	siyanteng@loongson.cn,
	sunhaiyong@loongson.cn,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com
Subject: [PATCH RFC 0/3] perf: add logic to collect off-cpu samples
Date: Thu, 11 Jul 2024 17:46:16 +0530
Message-Id: <1720700179-22839-1-git-send-email-ajay.kaher@broadcom.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add --off-cpu-kernel option to capture off-cpu sample alongwith on-cpu
samples.

off-cpu samples represent time spent by task when it was on wait queue
(schedule out to waiting for events, blocked on I/O, locks, timers,
paging/swapping, etc)

Refer following links for more details:
https://lpc.events/event/17/contributions/1556/
https://www.youtube.com/watch?v=sF2faKGRnjs

Ajay Kaher (3):
  perf/core: add logic to collect off-cpu sample
  perf/record: add options --off-cpu-kernel
  perf/report: add off-cpu samples

 include/linux/perf_event.h            | 16 ++++++++++++++
 include/uapi/linux/perf_event.h       |  3 ++-
 kernel/events/core.c                  | 27 ++++++++++++++++++-----
 tools/include/uapi/linux/perf_event.h |  3 ++-
 tools/perf/builtin-record.c           |  2 ++
 tools/perf/util/events_stats.h        |  2 ++
 tools/perf/util/evsel.c               |  4 ++++
 tools/perf/util/hist.c                | 31 ++++++++++++++++++++++++---
 tools/perf/util/hist.h                |  1 +
 tools/perf/util/record.h              |  1 +
 tools/perf/util/sample.h              |  1 +
 11 files changed, 81 insertions(+), 10 deletions(-)

-- 
2.39.0


