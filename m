Return-Path: <linux-kernel+bounces-366688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE1899F8B0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 23:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED3D01C20D33
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 21:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340FD1FC7F5;
	Tue, 15 Oct 2024 21:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZUlhLEkv"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312C41FBF64
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 21:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729026396; cv=none; b=sw6xjdljiwZ+p/JcfHs7MB83Yik+brAi6AOA+fCWwZ6lp4j6aNyr5n/bOpi9Ie9SUgw+UtaJ95E3v0xIV/f0WqTRT64V5Pvx5Ph4sR41HzbMLVJhhfYMr3whOHo4IDNcfjIRhHWNozdNwGx9v/+M3DZNcrHXd9W7VPtCgjqnRRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729026396; c=relaxed/simple;
	bh=nL+nx8eM+rqkUV8ew1DRUX2aLO3Wr1hJhbV2g6JzRys=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=RV9BF8fc4RVqog8DvIsApFU/YioBT1H4kl2/gT8RXRO0UcQ1NXqAYyXxsmVm1UNc3BtpG4Gj4Jt6DXQ1DlrsjNcIln8/5YUiGS+WrhhEB5o6ZLDoc4JcefejmcVICFF8OJm8NKsGfJgr/f5XTuSCw7NLWYDDZexJndlKLKGiptQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZUlhLEkv; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e32e8436adso72878457b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 14:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729026394; x=1729631194; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3kpHcRKhB/eDsIrUXvJFBqC7jgWe4ELBkz9BuIOGSn0=;
        b=ZUlhLEkvPoKBXjITJWmYAFrRrYOgmCb0K6vxR6KMb0gvEGddhyD6+/T42/kYekO163
         DOornIrfv2gCwIiyVXMTBFsweM4wC3CxhIzIFhhL66WL7Qd1Y30sx9lARn/hsrEw+FZm
         nU45greFwjimdYSx216Q7pR3e77Q3Jepa5FVA+ggkzAxYW1654ugjYU2s5XJTog+qAd/
         QVjA54RNyQJiDJxkluT/mBP5CvorYiydjvaRBubP+gF3l1c14Cj1RmYRCv9jukFbNngQ
         rR1KZcrZbYCaMVoa6xKBKSL9iaHJUINjaI3E4l2LruVKzupiceJuqVxyoNGo2XKIAqCO
         UriQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729026394; x=1729631194;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3kpHcRKhB/eDsIrUXvJFBqC7jgWe4ELBkz9BuIOGSn0=;
        b=ZTkiBI3kBizUGeykRSMKAjnoieOKaQM5LlwvwwWDgahcxMq8p10ngEfafihzaZIH3C
         K0qqZqT6ZvdeXyCyorFIQxLMpXIovaquuBSMyyR1CKPU9HZfiu5ePqCXDvzpmWgV08no
         ZtnC6sAmscL9vu+uuBVwvpLi+fQS8D5IpX6O/SfcY1ozbhI6vaySbaMj+PvPcsIPdVye
         hXE5q4SfNs4snX30W/f8s+uMZzr/YYdWJeFf0ELo1PXiKoQWgoa7f2A038NtstLNHT71
         BSTavaZ/GVTK9MhbFMLavMt5rhuI73IqWiXeeibBPwehIQVxUVDWNOJ07PCrlopSoDxf
         ZxZg==
X-Forwarded-Encrypted: i=1; AJvYcCVpHuJSz1TGiCrZUqayzPJVeRN8OhQ7cEJ5o4mvIuJloPMUEkGwAeEgnm7ovEIhfuecHxSi+nFYunTVcbA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC63S2N09vCRbNqxcvgYhkoXf+/s3EdVEH06RkuNQcQZAbIDZL
	Pipsk5qyzbHB89aFuI9KPmRiKaPByJw5rBDNeZyZ9o29FL8lDpuNmzLR7uTga3Rh4IdO7/unV4V
	YO5mNQw==
X-Google-Smtp-Source: AGHT+IFJmgM3oL2Y1D8peANHPNTTxEWz1kxzSiZ0kcULhqmZppAMW6tFZZeMMS1KVAg5svVLJkuReCmayMp5
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:61a1:4d9d:aca1:ada])
 (user=irogers job=sendgmr) by 2002:a05:690c:6e0a:b0:6e3:14c3:379a with SMTP
 id 00721157ae682-6e3d3bdb366mr261977b3.0.1729026394060; Tue, 15 Oct 2024
 14:06:34 -0700 (PDT)
Date: Tue, 15 Oct 2024 14:06:24 -0700
In-Reply-To: <20241015210629.1150428-1-irogers@google.com>
Message-Id: <20241015210629.1150428-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241015210629.1150428-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Subject: [PATCH v4 1/5] tools api io: Ensure line_len_out is always initialized
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
	Yang Jihong <yangjihong1@huawei.com>, Junhao He <hejunhao3@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
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
2.47.0.rc1.288.g06298d1525-goog


