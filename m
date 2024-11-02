Return-Path: <linux-kernel+bounces-393505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 737999BA188
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 17:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E0AB1F21923
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 16:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52681AAE08;
	Sat,  2 Nov 2024 16:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K83sUV/5"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2ABD1A7273
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 16:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730566454; cv=none; b=HkrCVHxAilLhIPWtobP/3iqSIpKVZuE/OIWmuy1+LhVEC7t8yn9r7+08uLOtLUMVRv3ksT/gb8jFpSr+JQYIAq9SFrC13Vr4UtCCchYvxRwz34Pa8t/DZrLdESKVX+VY2pEblPFe63znZ5B/pWAtJ8uBvwdMk95oMRe41J2zEiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730566454; c=relaxed/simple;
	bh=0UelXkPPHtu3Lbgh81jbZ3m39fj7o+Lntdf2ZlzEBXE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=YE4iK0iAQDyX/+jCa1NkVcQSs8R69FdTsU1owxuXGHaH30WAbXvExz4NQ81wfCv6arKzTDqpCDBmgTI1ihiXWXYf8OXtGW23lWDSbtQOG5IOJRfFvHXxmcYPgW+YqM4ylDBrzKKjVle1tSfVdxTTN7qOfwT52h904GmNKQ0qaQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K83sUV/5; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e30c7a38bd7so3768021276.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Nov 2024 09:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730566451; x=1731171251; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zD1HnzB3QtGTgZf1hSToxgFVkHLaqYNzGE0Bj2UaIas=;
        b=K83sUV/53EN9py7s+1GIoYlS/izWgZOovbQve2fdQEYY81AwAIe6uHTCvu9/Ygtrs9
         1I3GAeXO9e84wGTD0BPPxkDX958bzz99dzKeARQLrjrmDudOE8lpIGp3tSTnYmvk1aIL
         kvNETdZYckBGIjtGliJ24EKEXmTuxbrjqqK6lBt8FbI0Tl25bxdFAoBdxVx5BYyCHbTf
         9m8yXMzXZ3qAJ6/QmVtooQylwxNFlOx18pS0iiOghJjRuL0pauQQTyG4oEN/AmkETF7J
         tuYCGE0G8+UDQYq5Kck3OqHRQHBxC/wbNFj6mRlB26StdM4wU38ztmc5hUZkAJQrtjjV
         amDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730566451; x=1731171251;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zD1HnzB3QtGTgZf1hSToxgFVkHLaqYNzGE0Bj2UaIas=;
        b=JrxXvyQHLQf/pDjSW5XvABgKoQuMqTdsmBt42QaOn2htf+anRZz+6nH+QiSkakMAfx
         Jn8kG04v0A1qXu0ZeXZSXsKktAgypO/EOcbiHxjOc8mhUhVnhcunqLThtw3x97Nh8co/
         16JzB3OS2WlQ6gTtVJDATwCv+bCf+g7Rdp3OFJzy2V9MqcwtSC9hX6RGsbA+hln5Pce3
         QuMjOgTfhxtDKZxEanX8VT8pf1nNkjFU+Au5qACmHVsdeEYayAtnySprhE9+xQKo+3jj
         s0pYVJToLjStyOWimwtUDcthkDLuy0lEa/Chcui86HoRzMWKl+UScHKXh098F0sts5rN
         zkJA==
X-Forwarded-Encrypted: i=1; AJvYcCXjTifKBKdKojiM7dduE+vuoW73sTIYGOn2icxf2G9wYfa334+Q2Rl+oPYLbIMuU0wd3WYjM/Bw3rBtonM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmNxLXoUzv6dBQYEgK2BTK9q943QJ+QQf1woyA8ZKuUXnfbkhx
	GvZcQI5CX5i3QYW8AZFTIflKusQ8AVq0nHK/7LYqww02uEU0z6Dr7h0NOtzlj5PSEEmORBQe6HS
	h1+NRNA==
X-Google-Smtp-Source: AGHT+IFBaTryzrPh+JXnXKZudoEn30+nNMTh+mTSHhYqrA3l+SHSN0vPByNNg0cmbh4sAu9o+ZzPLiReolI1
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:26a5:cdb5:356c:64a4])
 (user=irogers job=sendgmr) by 2002:a05:6902:1801:b0:e30:b89f:e3d with SMTP id
 3f1490d57ef6-e3328a15f4emr1543276.1.1730566451619; Sat, 02 Nov 2024 09:54:11
 -0700 (PDT)
Date: Sat,  2 Nov 2024 09:53:55 -0700
In-Reply-To: <20241102165400.75785-1-irogers@google.com>
Message-Id: <20241102165400.75785-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241102165400.75785-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Subject: [PATCH v2 1/6] tool api fs: Correctly encode errno for read/write
 open failures
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	James Clark <james.clark@linaro.org>, Dominique Martinet <asmadeus@codewreck.org>, 
	Yang Li <yang.lee@linux.alibaba.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Yang Jihong <yangjihong@bytedance.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	Ze Gao <zegao2021@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Ben Gainey <ben.gainey@arm.com>, zhaimingbing <zhaimingbing@cmss.chinamobile.com>, 
	Zixian Cai <fzczx123@gmail.com>, Andi Kleen <ak@linux.intel.com>, Paran Lee <p4ranlee@gmail.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, 
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"

Switch from returning -1 to -errno so that callers can determine types
of failure.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/api/fs/fs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/lib/api/fs/fs.c b/tools/lib/api/fs/fs.c
index 337fde770e45..edec23406dbc 100644
--- a/tools/lib/api/fs/fs.c
+++ b/tools/lib/api/fs/fs.c
@@ -296,7 +296,7 @@ int filename__read_int(const char *filename, int *value)
 	int fd = open(filename, O_RDONLY), err = -1;
 
 	if (fd < 0)
-		return -1;
+		return -errno;
 
 	if (read(fd, line, sizeof(line)) > 0) {
 		*value = atoi(line);
@@ -314,7 +314,7 @@ static int filename__read_ull_base(const char *filename,
 	int fd = open(filename, O_RDONLY), err = -1;
 
 	if (fd < 0)
-		return -1;
+		return -errno;
 
 	if (read(fd, line, sizeof(line)) > 0) {
 		*value = strtoull(line, NULL, base);
@@ -372,7 +372,7 @@ int filename__write_int(const char *filename, int value)
 	char buf[64];
 
 	if (fd < 0)
-		return err;
+		return -errno;
 
 	sprintf(buf, "%d", value);
 	if (write(fd, buf, sizeof(buf)) == sizeof(buf))
-- 
2.47.0.199.ga7371fff76-goog


