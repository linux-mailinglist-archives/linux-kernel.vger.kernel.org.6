Return-Path: <linux-kernel+bounces-376773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C66B79AB5BA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 20:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFAF71C2313C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 18:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696AC1C9DFC;
	Tue, 22 Oct 2024 18:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lvg6ck0a"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9A71C9B8C
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 18:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729620391; cv=none; b=D9jQjidC9QGY7gsTnUI2/eRbnVguM9VegtYtOMdi1DFY/NmKMzzwIzCf0xFW8EyX1c2Kh4M2AAKcWmhWxMF5iSWwZCx2hisu/3LpG7+hupapysyKxQ9glL0Y0ndUAk0ALulfiOgEw8mAl0pdwyFuObSMY5sl7+r/JMdvKpVNVYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729620391; c=relaxed/simple;
	bh=bweGjO6oLNWqHtRm9v/TYQZ87rq8+41CpklWuS6lDx4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=ufRf3Nm/eErJhNU6C1h2K47ks/8NNB3OtTwxfRuCXBU7BRqMdQvUGcLV2/vBg5SNO1n4iYdDnpOOLS+TQjxCQbERaPN3DFj8EDz9uJsPGjQU5fO/P+In/jWFxz7BOMSrJP/vDh+lVOTMIqke421k0vToAA7FwCdUmQlCE+2Lo/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lvg6ck0a; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e297a366304so9388367276.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 11:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729620389; x=1730225189; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r1LYQ4XDiQ2MYrJtEXc2JnLlBCPdfCYTDh4HOwGTpkA=;
        b=lvg6ck0arVwGMsKj0KKoM8LRKi+Tn5XhoWTdC7OO0ZjH3JlOUdZEReb/L5HcV9FP6p
         688WBThuUkx3t5QVNIKNjJSYwLXmslUjP666WCxo6BQchYupJIdHR+G2R/Otg6seDbL0
         29SfhWKpQNE8pFtKnh9OtGxCfCpwTllTJPmO3wrkQQyDN2PFcUhkpr5bpgdPT2aoDHho
         xvKDKcIcWo5bpN5Jd/qSbG003cqxCuIwoVHN+B1eKMSS7Acq6c176cuoJPkolNEB2nmW
         WLOPZT7o/TrmMppQ+POp464ctl5/+IceiynXLNRWld/Y8zW1T0U5Vx/fgCJIzrM2GxYH
         nKSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729620389; x=1730225189;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r1LYQ4XDiQ2MYrJtEXc2JnLlBCPdfCYTDh4HOwGTpkA=;
        b=PA36tInVp3NQK8XQ+8NldikkaGr6xrAWlxFfu1iLFaPLpzOcfF/GUPVw5TfM7yZTwA
         VO/x6leFiorq4JSKmr9V8oLOUb3CpvJDPO0x2Vnr5RDY++PypH5eJx/CDcfXz11S/r9Q
         /Q+2SPyKouRTguKJsHNxLO2nRaSXmNluMJkZWu2UWMte4DXvMfJgmY9C1Mx/We1VHNxj
         FoygAu7xppA6cm8MrSxjgooGGb6AdvME54oequyZyVFm01jI2Ildo3HZ98QA0OjDROmQ
         2k9cKhjxu1OwzmpsY70NLmrp7n1W9R+q+g+5ATMU3VGDeT0spV1eBzC8EwerOdvGAyDF
         4cFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVEsstgD2WTTWomaeNVssOeJOe7pUqiRL3caK1c7rafriPHv5CDjY9Ecp9aEw7NM98xYNunLxLqe4Qa0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYeluwjDX9DJayHRAMYr9GsJ+bZvWKgKPyfaEDrAwsLqzg7aNY
	iB/A6SbhwSr+HdvBN0DBo7FS5pRBJ8MSGVfRDMKHppOYS71MuXMhPXeTuHNEzaVFPF7TI9/BCZ6
	56/igUQ==
X-Google-Smtp-Source: AGHT+IHYqPK5wSTyVxjQTNYNNDQqiXBqxM1jJkCNN3xQAoA0ajpRbBIJPrPvwnkV5A3tBEOwdvq/sL/XWAfu
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:57ba:88e0:aaf6:282])
 (user=irogers job=sendgmr) by 2002:a25:8407:0:b0:e28:e4a7:3206 with SMTP id
 3f1490d57ef6-e2bb16d434dmr67225276.8.1729620389353; Tue, 22 Oct 2024 11:06:29
 -0700 (PDT)
Date: Tue, 22 Oct 2024 11:06:19 -0700
In-Reply-To: <20241022180623.463131-1-irogers@google.com>
Message-Id: <20241022180623.463131-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241022180623.463131-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v6 1/5] tools api io: Ensure line_len_out is always initialized
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Weilin Wang <weilin.wang@intel.com>, Yoshihiro Furudera <fj5100bi@fujitsu.com>, 
	James Clark <james.clark@linaro.org>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Howard Chu <howardchu95@gmail.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Changbin Du <changbin.du@huawei.com>, Ze Gao <zegao2021@gmail.com>, 
	Junhao He <hejunhao3@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Ensure initialization to avoid compiler warnings about potential use
of uninitialized variables.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/api/io.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/api/io.h b/tools/lib/api/io.h
index d3eb04d1bc89..1731996b2c32 100644
--- a/tools/lib/api/io.h
+++ b/tools/lib/api/io.h
@@ -189,6 +189,7 @@ static inline ssize_t io__getdelim(struct io *io, char **line_out, size_t *line_
 err_out:
 	free(line);
 	*line_out = NULL;
+	*line_len_out = 0;
 	return -ENOMEM;
 }
 
-- 
2.47.0.163.g1226f6d8fa-goog


