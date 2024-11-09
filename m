Return-Path: <linux-kernel+bounces-402544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D83539C28E9
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 01:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D90C2838BE
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 00:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C8F1DFFC;
	Sat,  9 Nov 2024 00:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lz9ouNdV"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5C78C07
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 00:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731112688; cv=none; b=rO1JmPjXtslZdMiGOSOe6mYs0P3jDEL1xQBY0nB2Xav4NFAXde2U5D240P4H2iy4AN/Mx59g2ZfrctZ5ow4/Z2Sc+Lec928GZNw6qidTsRDfhzwvugx73qkfejA/PubJGlrObeRUYphi1mKAcRslqAke9tCrJS3o7c9HBCJn0Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731112688; c=relaxed/simple;
	bh=JR2W9BY58B7KI+DPucllOVM9yijzERRopT+DlqMeLCU=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=AlFtPdQTsC7b4JJdNlpnDw+Pq5Nfl1f64PlgTz44BMo92U13VaZBICePPqGBNosvjwc31hmGsdhO/vAH90cvnfqfLdGrj6XSptDgkVts5pky5uqwHm+U9X/25qXG9mDOBiE3096OsfufGtV8VHWElplNksF+/VCK6WZWBtZhzkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lz9ouNdV; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e3314237b86so4872768276.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 16:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731112686; x=1731717486; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3SPWlc2lPTGFJEvFedKLB5LrjZb1UnFHbKvI0m+mSBo=;
        b=lz9ouNdVZcv2MhAZ2AalIAGKOMsk4P9C4qOkUYbkkITWMJQ1P+rSia7kf7ZH24/6zJ
         /VsQIDeyGzgxX5iyDYFjJAUHMehpEZ4W3HckFPZKN4ubOmmDWc8Q8LlocSrrd/9Mtz/Y
         +vzNYknawpOTxAbknjOOSTYBYIXQwpqqm4b92o47WuakiSGTZ09He5HP95J9sWzHynKZ
         /i99YdMn9tCNyhyJX8TGMNEFTYBkZPVQy7L3sxXYqY3j9B0AiIsfMjPWlTr4bGqt1+Ak
         +xAi3FdVYZUS0u84QQLlO0Z7S+WLlOYG6ZKeTIAniSngVm6Xj4dzVm3MgLskv/IwLS+d
         Jmzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731112686; x=1731717486;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3SPWlc2lPTGFJEvFedKLB5LrjZb1UnFHbKvI0m+mSBo=;
        b=fYVlecEbaHyQ0ffOll4AMLARwnqKTyb86wLq6UAoz6fKrMLIUmB0szBZZihvy6fL1L
         5PwpY/xgfR3/uaME1WLNduYyD5Q3kH9+qjlVXQqCshd/iF4XNPnLb7LEVi8IUk/bhscF
         WZcF6tVizT/2oxnF3a8dBtpS7NTzj2cUpFczEE3PZVTYpbUUskYTGYGOE2SGYsfO9HyM
         p/N0FU50U3ZGxjSJ1iI2eBeVPysVNeNHsMU2Ig3JxWAUEJ+n/4pLOXkWanfSY8Aoc39+
         kCj9OQdU+vtRNpwIAlqskNpNJUyPOM8haYtVsespmlz5so005uQD5Z01K9TKW+60N/ZU
         Xahw==
X-Forwarded-Encrypted: i=1; AJvYcCVEZsB3d2SSpFmJHsnipOUgATP2qqAD656grRhuWUe/AZRIX6TuTRZYqj81I8i9RB1G/cyq8+0mmMsdcaE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1Fj5A1Y/u8xfVI3BtNWZp51UoPujodY8Tqec4UT2Z+lczLnr7
	aiqe36lXJjL4JdxEB1635zJm0Pote3zCLO7xi9O8YjNeNsYCfq651TE5tfE2wH3q/31lB+QNFxN
	jwB5LkQ==
X-Google-Smtp-Source: AGHT+IEbCvuNzznHJpTzjrrAOjr0V/uUsjUwc1//TkW/1cqMa3tVVHph1FyNI7oYtDyjF4CBOn/7+dGxx9S/
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:6fd2:1e36:6d8c:7c49])
 (user=irogers job=sendgmr) by 2002:a25:dc4a:0:b0:e25:5cb1:77d8 with SMTP id
 3f1490d57ef6-e337f8ed8bbmr2910276.6.1731112686450; Fri, 08 Nov 2024 16:38:06
 -0800 (PST)
Date: Fri,  8 Nov 2024 16:37:53 -0800
In-Reply-To: <20241109003759.473460-1-irogers@google.com>
Message-Id: <20241109003759.473460-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241109003759.473460-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Subject: [PATCH v9 1/7] tools api io: Ensure line_len_out is always initialized
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
2.47.0.277.g8800431eea-goog


