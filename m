Return-Path: <linux-kernel+bounces-391399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E2D9B862A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 23:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0202BB21B9A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 22:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438261D12E0;
	Thu, 31 Oct 2024 22:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mgh8OYVB"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9871991C1
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 22:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730414400; cv=none; b=r9FinBqhRyfwNlDeH6Yo37Oq1HqZ5c48geHUOuhHzyK73eKRHwVaEo8HAsZjZn5laLAzabynpW0Svpw8asRarNT2/imBo84Su1kuZxKCiodUOEFGcAJiTKb0GGUbnFoUbOuERNTKUrTRd4z8B3++XPntu0nEupnl+wmboddbIj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730414400; c=relaxed/simple;
	bh=c+kyGnOQjXWzWXgWYbsbedHp9u/10E+8KBPPSymIojw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QjB/Ppcp0gcu8oRWv3vLJjwuwUnSOTTlv8BcWDm7aAPOn8N9s+V+NIBo0gQUQWTV5+BwytkryAvwARCWFvJwcKYsMsXmDMCLUm/XWjJ6b0hVx9hZRwVKKBbs4fNO5G6XGMYw2OZ+V8hWj33cwHEplT1HYrDdIGXRaDZTGU7g4BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mgh8OYVB; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-20c7ea6b060so15513985ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 15:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730414394; x=1731019194; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DcNMbreBF88iGJ60X0h+H4EHRkeD6bUBBrLm2nStrsc=;
        b=mgh8OYVBHvRlWANsaycZrsLzHPD34jwnODKbHIb4KS4qvc5YIIwuDCmo9iYjUVGsFm
         iStdn+9tLE71y/qRO5BofEoeHQ3atF5QCulwL8Dcsg5jCZYOGqPxQoyww1kB50C9T2VZ
         YC44bZLjxAwr3CbL6wPRfOn5WGTrJajqYd0od9jnpNbsRDCUuQopufXt3s13ctdQwolR
         wRFuv7ncMV6yIYcSgJ9J57tdMhAQqANZn68rTK03EAKX5eNibdKz5OL6566YZ9cwzdCm
         L8bkV00i/ot4Q4cVcE1WOuv2rQC2nk/+rVssT5Ai6QA8wxYLa5by0A2EpQdrTyCyzYGV
         u7wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730414394; x=1731019194;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DcNMbreBF88iGJ60X0h+H4EHRkeD6bUBBrLm2nStrsc=;
        b=DFdwZBrsTurUYsg2ccrUxuigxLEmSXckAfPD599AVXmou9sCS4fDSkWw5j2kFRp0yf
         6CfmHG7xb/J6LpVhswOTCk0OQiQqQEDnoGpmNXfoBSIkIIUbT7BGbCNvq2s6V6qOLEzd
         ejUJoO+F0yWlfRL0Y9K/KIDKn4TUqL4dUrgd2LDiOk5I9KxW8cK2hGgbGUidaf/TJ6P9
         0RynWdpmmcslxWbjHMu/bsIv0TCjeIejV0Qj1njjJcQEAkQAwRt36kdGvOUipR9j+/Vl
         dER6Bek0EzVqV7UZTapzeMGcsBwuxENWP4qmAyfm4SiAZ4JxRcY9hW/W9bRHbiavUoWm
         emZQ==
X-Gm-Message-State: AOJu0Yw+Gwr58eU6H34acAlegLVQL5Ony+Wvg10Ah5vnVQqXAo+vNVAf
	7Wy2cVT1L9xKNSRCGKa6jlR2fjl4cAtwEL+HJAkrNLyJlVh4T/pnOP/Mt4EX368qrNln4m8hoJe
	ObF26XdsAnKRxdFwzVBmnYXE6ykuwTbYJbr19m4KBTmgNirQhyjBur7TnZu9TFbfqIIa16FlhTY
	TGqpgExoUQU1bK55Fge/kqMGOodipGCD+q9vCR5PVJ
X-Google-Smtp-Source: AGHT+IHUv4Rg7bODNrAba5mufnLSn1fMfdYSJPhfSRvkKug69vGP4wv91ls7ArqnPBJZtFxR1utp9W/A1Uw=
X-Received: from colette.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:ce7])
 (user=ctshao job=sendgmr) by 2002:a17:903:2493:b0:211:b02:2208 with SMTP id
 d9443c01a7336-2111af97f0amr10405ad.10.1730414393736; Thu, 31 Oct 2024
 15:39:53 -0700 (PDT)
Date: Thu, 31 Oct 2024 22:39:44 +0000
In-Reply-To: <20241031223948.4179222-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241031223948.4179222-1-ctshao@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241031223948.4179222-2-ctshao@google.com>
Subject: [PATCH 2/3] perf: Reveal PMU type in fdinfo
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Liang@google.com, 
	Kan <kan.liang@linux.intel.com>, Ze Gao <zegao2021@gmail.com>, 
	Chun-Tse Shao <ctshao@google.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Weilin Wang <weilin.wang@intel.com>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

It gives useful info on knowing which PMUs are reserved by this process.
Also add extra attributes which would be useful.

```
Testing cycles
$ ./perf stat -e cycles &
$ cat /proc/`pidof perf`/fdinfo/3
pos:    0
flags:  02000002
mnt_id: 16
ino:    3081
perf_event-orig_type:   0
perf_event-attr.config1:        0
perf_event-attr.config2:        0
perf_event-attr.config3:        0

Testing L1-dcache-load-misses//
$ ./perf stat -e L1-dcache-load-misses &
$ cat /proc/`pidof perf`/fdinfo/3
pos:    0
flags:  02000002
mnt_id: 16
ino:    1072
perf_event-attr.type:   3
perf_event-attr.config: 65536
perf_event-attr.config1:        0
perf_event-attr.config2:        0
perf_event-attr.config3:        0
```

Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
 kernel/events/core.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index cdd09769e6c56..e0891c376fd9d 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8,6 +8,7 @@
  *  Copyright  =C2=A9  2009 Paul Mackerras, IBM Corp. <paulus@au1.ibm.com>
  */

+#include "linux/seq_file.h"
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/cpu.h>
@@ -6820,6 +6821,17 @@ static int perf_fasync(int fd, struct file *filp, in=
t on)
 	return 0;
 }

+static void perf_show_fdinfo(struct seq_file *m, struct file *f)
+{
+	struct perf_event *event =3D f->private_data;
+
+	seq_printf(m, "perf_event-attr.type:\t%u\n", event->orig_type);
+	seq_printf(m, "perf_event-attr.config:\t%llu\n", event->attr.config);
+	seq_printf(m, "perf_event-attr.config1:\t%llu\n", event->attr.config1);
+	seq_printf(m, "perf_event-attr.config2:\t%llu\n", event->attr.config2);
+	seq_printf(m, "perf_event-attr.config3:\t%llu\n", event->attr.config3);
+}
+
 static const struct file_operations perf_fops =3D {
 	.release		=3D perf_release,
 	.read			=3D perf_read,
@@ -6828,6 +6840,7 @@ static const struct file_operations perf_fops =3D {
 	.compat_ioctl		=3D perf_compat_ioctl,
 	.mmap			=3D perf_mmap,
 	.fasync			=3D perf_fasync,
+	.show_fdinfo		=3D perf_show_fdinfo,
 };

 /*
--
2.47.0.163.g1226f6d8fa-goog


