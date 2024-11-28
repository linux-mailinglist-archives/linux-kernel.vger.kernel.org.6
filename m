Return-Path: <linux-kernel+bounces-424740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70ADD9DB8DB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 14:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0E9C164A9C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 13:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68E91A9B4E;
	Thu, 28 Nov 2024 13:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="LK30rqgf"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF831A29A
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 13:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732800976; cv=none; b=H8j73ZYurNaXMEyxpkbBHEbitaDaxeorV+mRbXHpUVnahtWbyPyp8XTRxNhjrrR1IT695L6WT/mBY2QNpc3p0AtKYyyZBLNvPGgY9HbqHid4H54bwgXMjqpZYwJksuRkygK+rlwkY+sDE1LNuYWSPUr0CTFgaGL2PkmAduke7Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732800976; c=relaxed/simple;
	bh=am8KzvQV7++j/3+Q2QeaU9H1RThCRw3qUauanEhn5Tk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eydxaN0rVTgT//xkTeDKT+83YlK5dmeRvQ52wig2z+JhcG4Zw1unnZrzftYBQI3dDwXSvOWquz4LxJ0J7YBazNhF3kU+uE9BGx9ZauHWvsqtPzZ78OwSHNpeUzjch7lE7q/WAs9LGhopUp5Dr3StCYB+krjGwrmp+grT8W7lZbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=LK30rqgf; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-212a3067b11so8208385ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 05:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1732800974; x=1733405774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dfGm1W+qoN+3m0lZzm/uyk6WYYumn3bZ5Am+2IS82qw=;
        b=LK30rqgfaDM+mnJpmSl2e5ud3MuwRHRsa4MgKSSoemxa1V8yO0v/gW34F41qvtGA58
         sApn/9qEblMJXlPVXzIMWczni5r9QPqSF3BN6jk62wMo6OhrKU4tTS59uj10Yrgl9HhO
         GNCyormRjBXKigrkWNZ3lQad3bjpNkQsHHdNrer6UogVw84NMlzOo/rK6Z023YYm12+W
         k0prOOctc5X/Wq4bS6/DLLzTjhZPEAjfjbwe9fL8vPK0ykExYXKuk3l5TufwHCrMrokU
         D0WxtmJlfdzvKnRbI+OSbY9GVhLf+lGpFtRpQtd6aWf+SroP/lAAbsXiXE8p/ZGyGA2c
         dJPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732800974; x=1733405774;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dfGm1W+qoN+3m0lZzm/uyk6WYYumn3bZ5Am+2IS82qw=;
        b=O+V/iDGE5/KC1e0IOVSi7mf9seM+lZru2MZz28oFGpH154Sr2YkqxOE17ZNF0GjF07
         fdy3Q/hJWjZe9QKqKsX65xQyoEg5b7BM6pmUzIOCj3+H4ulIeaC7qbZvrSoDIKGUDyrQ
         dbPqzPEQatclFEB6lsX3BjYOoRtg/AfM+AHU+TbSaCFTAGwOCUcJgGo6JX66wxUQXf/a
         MJRzNGOdj9gHM5Tk40/yFLajdwerCX2jtMsliedZmMkkabqOp5I3P1rENjrBHYX1YJAS
         6joGicMgzAyEvBODzXcapd7YSF4JqAIbzbcIsoGJKv5NKvr59j3q0PC32+7ADXeWM+pR
         4kpw==
X-Forwarded-Encrypted: i=1; AJvYcCUlHyfUWYaRLdu6QuIY0KmHaEuJzUbw8HATu+S3+iZqe9ZG/LHyDuxAf5DRkTSByQqgtFt6nyaXwyDvKOg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIUT+LTIcEFO6kOnty32+aTY9IJglpn9RGHNTPVKtR8Nea508r
	Awc2ikcNVTY25hAV01VVRrRX7IGA9h+2KKX/QWL+d4Qi5TAecbIyiKqyedAMDcM=
X-Gm-Gg: ASbGncvaW5fKeaCbBDjyTjVMXfBAilrAtdLMWDWBoCNO/eGeY3cDTSusINYKBkHhSDT
	b4zYJtH56BRoWXOSvPpXJyPkOg5u/XbmCNML9jHGCacKhB29wcwgfJ5gqAQHV9BorifkPoddCpj
	iAvyrcH86Ws+wjFq2Wdfp7UY+nhLM5o9F262BcpmjvyL1pOItrYhD2xRdi9UIHbk2ktziIJzs/b
	cRTNXzqEsryWXw7+MNyIlqcyNqP11SYKD0UyUnGi26vpv9lAHdFL2swKg==
X-Google-Smtp-Source: AGHT+IFAqmO3AibNO+ztR4NADcnXamYMn19khc0cbc8QKoORDmFIT3LCpVAf/s44bb4caWyVDDbZPA==
X-Received: by 2002:a17:902:f54e:b0:211:6b21:5a88 with SMTP id d9443c01a7336-21501099d5dmr71228745ad.20.1732800973117;
        Thu, 28 Nov 2024 05:36:13 -0800 (PST)
Received: from ubuntu20.04 ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21521985632sm12952975ad.206.2024.11.28.05.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 05:36:12 -0800 (PST)
From: Yang Jihong <yangjihong@bytedance.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	james.clark@arm.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yangjihong@bytedance.com
Subject: [RFC 00/12] perf record: Add event action support
Date: Thu, 28 Nov 2024 21:35:41 +0800
Message-Id: <20241128133553.823722-1-yangjihong@bytedance.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In perf-record, when an event is triggered, default behavior is to
save sample data to perf.data. Sometimes, we may just want to do
some lightweight actions, such as printing a log.
    
Based on this requirement, add the --action option to the event to
specify the behavior when the event occurs.

This patchset uses bpf prog to attach to tracepoint event, and save sample
to bpf perf_event ringbuffer in handler. perf-tool read the data and run actions.

Currently only one call is supported, that is, print(),
and some commonly used builtin variables are also supported.

For example:

  # perf record -e sched:sched_switch --action 'print("[%03d][%llu]comm=%s, pid=%d, tid=%d\n", cpu, time, comm, pid, tid)' true
  [003][795464100275136]comm=perf, pid=141580, tid=141580
  [003][795464100278234]comm=swapper/3, pid=0, tid=0
  [003][795464100288984]comm=perf, pid=141580, tid=141580
  [003][795464100457865]comm=swapper/3, pid=0, tid=0
  [003][795464100485547]comm=perf, pid=141580, tid=141580
  [003][795464100491398]comm=kworker/u36:1, pid=139834, tid=139834
  [003][795464100493647]comm=perf, pid=141580, tid=141580
  [003][795464100494967]comm=kworker/u36:1, pid=139834, tid=139834
  [003][795464100498146]comm=perf, pid=141580, tid=141580
  ...

  # perf record -e cycles --action 'print("test\n");' true
  bpf record action only supports specifying for tracepoint tracer

  # perf record -e sched:sched_switch --action 'print("[%llu]comm=%s, cpu=%d, pid=%d, tid=%d\n", time, comm, cpu, pid)' true
  print() arguments number for format string mismatch: 5 expected, 4 provided
  parse action option failed

   Usage: perf record [<options>] [<command>]
      or: perf record [<options>] -- <command> [<options>]

          --action <action>
                            event action

  # perf record -e sched:sched_switch --action 'print("test\n");' true
  test
  test
  test
  test
  test
  test
  test
  test
  test
  test
  ...

This patchset implements simple features and can be extended as needed.

TODO LIST:
1. Support common operations such as logical operations and bit operations
2. Support other calls such as dumpstack(), count()
3. Support specify actions for kprobe events
4. For builds that disable bpf_skel, support real-time parsing of perf record mmap ringbuffer data (similar to perf top)
5. Link libllvm to support dynamic generation of bpf progs

Yang Jihong (12):
  perf record: Add event action support
  perf event action: Add parsing const expr support
  perf event action: Add parsing const integer expr support
  perf event action: Add parsing const string expr support
  perf event action: Add parsing call expr support
  perf event action: Add parsing print() call expr support
  perf event action: Add parsing builtin expr support
  perf event action: Add parsing builtin cpu expr support
  perf event action: Add parsing builtin pid expr support
  perf event action: Add parsing builtin tid expr support
  perf event action: Add parsing builtin comm expr support
  perf event action: Add parsing builtin time expr support

 tools/perf/Documentation/perf-record.txt     |   8 +
 tools/perf/Makefile.perf                     |   1 +
 tools/perf/builtin-record.c                  |  31 +
 tools/perf/util/Build                        |  18 +
 tools/perf/util/bpf_skel/bpf_record_action.h |  24 +
 tools/perf/util/bpf_skel/record_action.bpf.c | 151 ++++
 tools/perf/util/parse-action.c               | 729 +++++++++++++++++++
 tools/perf/util/parse-action.h               |  98 +++
 tools/perf/util/parse-action.l               | 190 +++++
 tools/perf/util/parse-action.y               | 156 ++++
 tools/perf/util/record_action.c              | 380 ++++++++++
 tools/perf/util/record_action.h              |  30 +
 12 files changed, 1816 insertions(+)
 create mode 100644 tools/perf/util/bpf_skel/bpf_record_action.h
 create mode 100644 tools/perf/util/bpf_skel/record_action.bpf.c
 create mode 100644 tools/perf/util/parse-action.c
 create mode 100644 tools/perf/util/parse-action.h
 create mode 100644 tools/perf/util/parse-action.l
 create mode 100644 tools/perf/util/parse-action.y
 create mode 100644 tools/perf/util/record_action.c
 create mode 100644 tools/perf/util/record_action.h

-- 
2.25.1


