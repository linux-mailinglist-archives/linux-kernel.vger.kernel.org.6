Return-Path: <linux-kernel+bounces-413583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0271C9D1B47
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 23:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A42B21F21F9A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 22:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB53D1EABC7;
	Mon, 18 Nov 2024 22:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SIPYB+Hp"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE911EABB5
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 22:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731970468; cv=none; b=L1jIAf+WHaNKNknE6m3kqIeBfqDwb1RlkQ7kJHNgL50grsOSOI34q9GC9uDeEaQ9FOpeMyMspFMuRbJ1eLMzSZBbgHvdoIo8pPde9qI2VfVhzOlHOE0PCOdfRZj6B3RTp6OB+zlRT43akbY1WkFPWh/+j8nZYne147NkWDhN+T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731970468; c=relaxed/simple;
	bh=VX9TWUF2qGeJZiWNv+7mi/FjvE3szYCNmmy+gilPg2g=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=SQu0pbkHLgCvYZ9pNBTLZjJ74EguybbrTLPgE+rUkiHW5rwE7ztTHU6FOtLwb2UtdiT6TXgwyvKSGnugzruZZr3vPRbRiJeAUoTZCsZJDVDDBNM4mgZg6YxgRuTJ6UoICvQS/dYS3INe91hxBGaUATpOjC6au/vCG+dwbPkCT3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SIPYB+Hp; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e3810bac8a7so596293276.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 14:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731970465; x=1732575265; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rQtEfOo4KPSbQdX3jmc6H31yrRxVNnjZvuIGaMQg2zI=;
        b=SIPYB+HpXzKCFxvCt8vWLeDj2M33d0jQH1lbIz9v5oQX0AH6hDggi4Y2bpae0QF4/b
         fDayX+oIYE6svke4THPe7iSSbv3CzzOzu3/Oo6r7StmRkbUDQY7SXfTHIaeWDm8Ylhd1
         ceJVZVz/3VGN3XXKa6aLXlITpDVJw+zKPCUfLq3HTeaIfOw76T1J+6MPWlpfoWqOx8Td
         WuEN/9cTDK6Mcg1Fy8iehQ3X+CALfu8KjMIBwLcmoDA+giZd0QAjj9eUG3+nFwiP68Q9
         S6FhExRbEyi8dGfxVDcdRr0F/2JiOhPt6Pec4Zids4AfDMAKtWXFdQaNcSIvWB4RGyVz
         TQLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731970465; x=1732575265;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rQtEfOo4KPSbQdX3jmc6H31yrRxVNnjZvuIGaMQg2zI=;
        b=FYGloIfuJOUZvA5WR9vT4Vw1a+HqAzkx18Tz95fwSV1zSnJdhEHfub4s6rscvM+HMq
         mowOPCFQ02eLU+CUgfjdAG7cdrNVnLV6jAZzA6YqLdz5YMRGnBHCtw7ByMrW0bu2Xu97
         fCGmVOWbbTOMH5zDlA9sxoAD/SqojJc0w1AzskOE0oS8bLLT6xrF47ZQsNo1rF5mkv+h
         nIGDAlI8JN2R8fzPphuw7AA0dnoUeH9ghAJUmyIOUOC+xhzqi/vCRsB8QICPXbFzhSvd
         vuQBLzTt/F5tfeAFN0lMJWK1zKlPoZcsTWCErk0Hq2HE4ZgdBrb2dBiHA25QFPr/Mqa9
         Evxg==
X-Forwarded-Encrypted: i=1; AJvYcCXlPPADZnqJ9ZhW06yFr8eRNpjKhOedr8rQkTtLk2uSVWLyfLrLmNyHjKHh3Oa5l47T8uvLdyxKTFnSwtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YytWHx13IG6tLUR8583TUSuwtiODGUR/G4RzNw7NlvdWFGqv5W1
	+e4IfEmZp9wTXK0Qw/2ctd8dWNaGcqav5GPjpgSAVlqBzu2zfLf2y0PJU+02hKeqSmLIE5AZol5
	lrY31Ww==
X-Google-Smtp-Source: AGHT+IESymJgcL0iR2MG+SNvIYAz+LsVdc118GWunXIeRiiyTRrJ3UvGAsXkTRV4gaFo6qBZ/eIAB/2/E+Pu
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:22a4:ded5:5c37:fcc7])
 (user=irogers job=sendgmr) by 2002:a25:c50e:0:b0:e28:eaba:356a with SMTP id
 3f1490d57ef6-e38265f8620mr96382276.9.1731970465464; Mon, 18 Nov 2024 14:54:25
 -0800 (PST)
Date: Mon, 18 Nov 2024 14:53:40 -0800
In-Reply-To: <20241118225345.889810-1-irogers@google.com>
Message-Id: <20241118225345.889810-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241118225345.889810-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Subject: [PATCH v5 2/7] tool api fs: Correctly encode errno for read/write
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
2.47.0.338.g60cca15819-goog


