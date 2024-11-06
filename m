Return-Path: <linux-kernel+bounces-397311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA509BDA50
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 01:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68C371C22468
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 00:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2EC52F9B;
	Wed,  6 Nov 2024 00:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wVNsCl3e"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3909A7BAEC
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 00:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730853017; cv=none; b=p/D8Lu79N0Dhfn933F6V13oy/IFpgk3ikTEWcp5dTr6C5mU081QsAF0KbqepBX97a2AwRjVVo7mcEq27VdXHLw6ue1jADDRiebMUp1OBOpL+rHZVMzUle64mx5k61jJfqhUDKRQ9CwkVbNOvfkx0BKh0etOd1YYj6qaRm/aXCpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730853017; c=relaxed/simple;
	bh=ipcKC+Xvjs/o+uXqM0HBhCtZoSw03gVtAaqWOi3zBKY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qHPjDDUzVdYzakNkF8TXDyHq/E5cNS4odHLlyIMd1YTb+IwI5F6n6OTW2lcZIJRcEq5NLwMOZFHV65WBMkaCtkSr9Tp9U+hUK4L1n9BKVFOJbw0X7OrBhnnDVWqyJ2m02ZINa/xrF95se8Rg5GqWG/0V1BGOwWiorIN1XfFaRfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wVNsCl3e; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7ecb7d90673so6562683a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 16:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730853013; x=1731457813; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GAoTW3tUs2GtkxTfJFEZH6td7ala8u+wh1yVC3NdyWs=;
        b=wVNsCl3e541agEkvGKLitJiMNE0SB+QvzaJNZbr1N+ctQwEU3QI2pemD4l7jX/vfe8
         W33iwGNWyt6pYuYwZihtI8Gft9zF2un8qN2dghSqZschCqRPkBGAp5z2ulbNaFulTU0E
         G7Wlbi9VvR5tdTajY963+AV0diCTn0ZzJT9qfSQFgq2aLVjfwTCLk/BVx0VV69pUDQrX
         2gzJN2Q4jOtYnq21gBson4fCrInLGOxMgMdlNRe7aMy55ILbNvEdK9kGWocQ2t4SbTq0
         puOC5JNaKD74oNu0jwPfxK9KiGhriIsIErZcVNGuy0hY+SNgzswtItWuIpCKl4p2ikeX
         5D0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730853013; x=1731457813;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GAoTW3tUs2GtkxTfJFEZH6td7ala8u+wh1yVC3NdyWs=;
        b=BZwbbW252gbhyAS6/i142R9ab9YUSwEovBM0TroTlTVxi9lOe6qeTaIp/2kqad3/kq
         yL+1G81SZx6OlyyYs0DNPNlDEAoFxOJBfmXkzD4r8EcBliFUfBKdKy30AoiFzxjuYq6h
         n8aN++feFn4ZumpFSShzX9IoWE33bA7ZXsffvUJgCWXi9WXpiJeK2kSOdioZD58CRsMI
         S7cYIm5/z+7EacC1iQQt49ZFj/jrYBYnvylWRNc7EPAgHoJ9+x9HwT6B6n9GEzTvmlQw
         Dvfir+3vhBdvXduN11Y7eNF+iWvGuq4AzYp5F/17hHIPJsqha7atvcTs4Zk8Fg25ymQi
         vFmw==
X-Gm-Message-State: AOJu0Yy6aji13ESlTBRZXjfPlsqvZX5fEVTd+wOYaZhRt7jgNrCkkLYV
	A/L7nKIiuC9/erYkmv0sNFdw3NjvqutWDGcTUHFkL+N92Zi4LY+g/liCTbhDBkummw7oobwcOKi
	NHUZexvARpNC/7JnFMIUbbdEnJjNTojfcDjlB5iNGZylGn7oYLTPE3gXUavsoj6samJ2Um/rMka
	NZaLJY9Jmnh2hE9eRS34npJgDQ/g8lLl4PAUxj9VYy
X-Google-Smtp-Source: AGHT+IGyAvc3UlnyxoY/s+DSBEx42PIPHB2evs1WX6ROqJhqhRsN02w8YFLGFUPp2xXFilKc/9DOuYBKnK0=
X-Received: from colette.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:ce7])
 (user=ctshao job=sendgmr) by 2002:a63:dd4b:0:b0:7ea:3fa9:9fce with SMTP id
 41be03b00d2f7-7ee4130b465mr50558a12.7.1730853012257; Tue, 05 Nov 2024
 16:30:12 -0800 (PST)
Date: Wed,  6 Nov 2024 00:30:06 +0000
In-Reply-To: <20241106003007.2112584-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241106003007.2112584-1-ctshao@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Message-ID: <20241106003007.2112584-2-ctshao@google.com>
Subject: [PATCH v3 2/3] perf: Reveal PMU type in fdinfo
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ze Gao <zegao2021@gmail.com>, 
	Chun-Tse Shao <ctshao@google.com>, Weilin Wang <weilin.wang@intel.com>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

It gives useful info on knowing which PMUs are reserved by this process.
Also add config which would be useful.
Testing cycles:

  $ ./perf stat -e cycles &
  $ cat /proc/`pidof perf`/fdinfo/3
  pos:    0
  flags:  02000002
  mnt_id: 16
  ino:    3081
  perf_event_attr.type:   0
  perf_event_attr.config: 0

Testing L1-dcache-load-misses:

  $ ./perf stat -e L1-dcache-load-misses &
  $ cat /proc/`pidof perf`/fdinfo/3
  pos:    0
  flags:  02000002
  mnt_id: 16
  ino:    1072
  perf_event_attr.type:   3
  perf_event_attr.config: 65536

Signed-off-by: Chun-Tse Shao <ctshao@google.com>
Change-Id: Ibea5618aaf00bae6f48a9b2a6e7798ab2b7f23ce
---
 kernel/events/core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index cdd09769e6c56..398cac8b208b9 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -55,6 +55,7 @@
 #include <linux/pgtable.h>
 #include <linux/buildid.h>
 #include <linux/task_work.h>
+#include <linux/seq_file.h>
 
 #include "internal.h"
 
@@ -6820,6 +6821,14 @@ static int perf_fasync(int fd, struct file *filp, int on)
 	return 0;
 }
 
+static void perf_show_fdinfo(struct seq_file *m, struct file *f)
+{
+	struct perf_event *event = f->private_data;
+
+	seq_printf(m, "perf_event_attr.type:\t%u\n", event->orig_type);
+	seq_printf(m, "perf_event_attr.config:\t%llu\n", (unsigned long long)event->attr.config);
+}
+
 static const struct file_operations perf_fops = {
 	.release		= perf_release,
 	.read			= perf_read,
@@ -6828,6 +6837,7 @@ static const struct file_operations perf_fops = {
 	.compat_ioctl		= perf_compat_ioctl,
 	.mmap			= perf_mmap,
 	.fasync			= perf_fasync,
+	.show_fdinfo		= perf_show_fdinfo,
 };
 
 /*
-- 
2.47.0.199.ga7371fff76-goog


