Return-Path: <linux-kernel+bounces-402212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 093DC9C250E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 19:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D37D1C22DA3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 18:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CCC1AA1DC;
	Fri,  8 Nov 2024 18:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i3rzw5I9"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB70192D7F
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 18:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731091678; cv=none; b=VBjgalab/LiEmJFnSiVdrrjuK6jAUDmeARUzFGXMURfdh3SnbK9lT2orcSU75uVVAtIs6lkRx+ILcT6Zfsd//CXieTDKn03pIczdpbwhr58SPLeeOOWFjaX0aKhMtc2EmWPKzTP41E81eMdvw+X8YN725i6v2Oi3+6bODG1cIUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731091678; c=relaxed/simple;
	bh=dniWuxuylHQooe/+O9kS+u+5yRkbVYD7nCVtuNvJa6Q=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=NSL6VsixMaXd6eRPPKFkWNm+d34Qkc1LZljvTvJEYzIMnVbVkmKFRKafOoN5c5DGSL1DXVGXn1mdgtvugao0GM26egqrVSj+7wlu40S2eMVLWp9tJdtBzJD6rd5j2UMMOnNmsF4QxnbOyJ7PSg9fgSiazPhhsuTFA3xlxCRV2Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i3rzw5I9; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e33152c8225so5189928276.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 10:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731091676; x=1731696476; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rfQP4ZowKoUcMreOGn+KjRxwFgZW88CzOPZZCNSZnMI=;
        b=i3rzw5I9cOgZzJf6jVId1Gi8pFfonDCIq1su10GHG0s8xAKzocyZfJMNgGUvAbBJLs
         8ONnvl8yPjVLcQ2t8/BzbJ/fWQan+vb3mdmozzqLpqzQEnDVtY8Et9mALAlp0wjvo7V9
         1cjtSuHUZD+USaqI9Fv4A30OS4kXdgbyTbGowTWINi9goEhNXI5fwLCB8S6l6oYP11x5
         phzty9neXDeZSQano7HWZTjGTzMSsRDZ2UXKNjcgTkSrbqxQakmXmj2X5NQ2arya99m+
         WPQqX+YRm7OsQlyDYvAHowT3Q036ytjXY1yF0GHdsKWK2D4cdNdJXv8uaNaEMnWcREX2
         yGLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731091676; x=1731696476;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rfQP4ZowKoUcMreOGn+KjRxwFgZW88CzOPZZCNSZnMI=;
        b=YRNzQvl7xf+6KCFB8f0qvzLjI2MLN6hdDOY7ivtJ6cNZYiP3dRwnieAFrg6PafUmzX
         lqdlkeFG1U2/bLy8JNoUx461L5feLaFvQ4s2PEL/edQoqDtwNlW3S7igRr6pZtmBfiYS
         0On5PDgna718XKqgUY00IW8A+ZdEZKjrd/208xymt6zz/Dd3xwu6UQq3utcLvqcorbQV
         3+aJ+VUF3o3uQzmxp92sK5bfoFn0onIlszYQ7YQPtZsseC6pT3M2UL6Fiws5AwRk8Ghp
         5G5uuDwb/yS72sw5odr0Tqmol6OVXk6zzCMG49QRQTtW8bYhTXz5Bjy6/qaRKUzaC4Hc
         V7Hg==
X-Forwarded-Encrypted: i=1; AJvYcCU5Kj+0aqNH49XPDhCVS1jh6dLpRs8wgX8HX7Nqf5p96hcErzyQpsRcIcEmOsEwhy5mPqyFodDrfXkVMZU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbb5I0OFe2D3njamNTNuZQDH6DzsaYUQZ+pqfdkczYYY1kMY/p
	ZIVLux0NnVd5EFvp/mBA011SfYo3lvpTPcQtnrXNKl9pUXZPSYMuD5GUuuTNR1AAXo7URYX840N
	//9sSrA==
X-Google-Smtp-Source: AGHT+IHSUecJfqyP6yo6pYHHwXlmFb3TtyJAgM28FJPeh82MRvOLqxptoEEBE92c8/yyBMaC2YcowXN+ItIJ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:6fd2:1e36:6d8c:7c49])
 (user=irogers job=sendgmr) by 2002:a25:dc4a:0:b0:e25:5cb1:77d8 with SMTP id
 3f1490d57ef6-e337f8ed8bbmr2368276.6.1731091676429; Fri, 08 Nov 2024 10:47:56
 -0800 (PST)
Date: Fri,  8 Nov 2024 10:47:46 -0800
In-Reply-To: <20241108184751.359237-1-irogers@google.com>
Message-Id: <20241108184751.359237-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241108184751.359237-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Subject: [PATCH v4 1/6] tool api fs: Correctly encode errno for read/write
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
2.47.0.277.g8800431eea-goog


