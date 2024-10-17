Return-Path: <linux-kernel+bounces-369242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5FE9A1ABD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 08:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F5002873DF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 06:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065CE192D99;
	Thu, 17 Oct 2024 06:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mYo/WKx7"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B62B2F36
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 06:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729146967; cv=none; b=VmDZCbaCSAY6FiHQ5cD/PNLmIAWuRNo3CRhVsIx6+8B1pKNiIEIpOEXlqocsCWH+1RG9B6M1hRlE0nr9HxnIPj5Bghq9Tg4XLPGJOImadtksZqFmbmudBzlK8OfvHApcxOYNOuxmR4zEWpfyzZAYFVCRBfpf78PYEOGYncgSkho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729146967; c=relaxed/simple;
	bh=UZxFlv7Wbh48yYOEZRihECZBjQeatmsIoMNyRLNwtEo=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=aQ0Hxyd0rMgJJxzQPni6a+UuXUjG/9v22/jrh1N8v82+mJ2GbPp5u+wEn/gwSm1quEqgDrnwJ8inkUD5iL0LPLzw5y4m6zuwEaqgMWf6ViI90pOLTFqspkUwk6nma0qN6WP3TmIX69FU8CUOB9RpkCnFrqtro7XsajYk5GeMYzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mYo/WKx7; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e390b164c7so11943117b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 23:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729146965; x=1729751765; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h7GW1eQklKySTp+dOjr8wiuaU6Yze5XmZBYV8OINt5I=;
        b=mYo/WKx7YXoOaAGIdhUnOVoof7ry09ptdcGGpUs0jYddQR4m2NxuYZvh4laVCcBAqd
         49v+y5KjsZNT7HCnh5E5airaE0X0kFL7BM8SI2Vsg+oJRAky/JNOVOpuUeZYQyy894oo
         sWKl0A/lbWgji3WOZyo8cHr03vOe4IVU7+6dSFUz5KC2pJ+eUt7GTLKG3I0qoGsAT7cy
         sLc8UXzQbUs7In8utZbNf6XAKwoYLGtMJeSQaM8WUsdHvqJKRVl7ZaXwYKAuLHBeqjV/
         9goq2Y2vaVg7CclZlipI8jteob2hqXfWJ81pBBhB9n7rr+KU1FaXBEvQlsUNg3Gfj1PG
         dGDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729146965; x=1729751765;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h7GW1eQklKySTp+dOjr8wiuaU6Yze5XmZBYV8OINt5I=;
        b=QYWT084MJRVKZSRpTOfoXdokhjAmV+s8DrQ8MY0ohw1oPP9q5KOTc22skoOw00Y0uP
         LPe1pKK+fxq1WJExwP49REsw9/gGmjDl9LH/vimV5h2SXaRA4r1i9dnDiDH/epWj7yW+
         WsU1S42VWoSp2ogw/VA0TwLAxkT3AUHpjIZE2dQVTQNwpYJ1rp6qSMH+ZoEfTatvrkgc
         6BajozGgFhuSaNczcXl6oKfF8mF9eH13PAfidL8n8gi4YNLHJq3RmEGZAV318JPpiT/n
         MlV97CAFJVfMFLS2EOL/wGiQEZjNFCCalrDBvcI0Zg9c8uMX3xE/um4zr97omi3bE+5E
         48Xg==
X-Forwarded-Encrypted: i=1; AJvYcCUPjpKlxKPVWjBLswVd+4boPhqBeFiHNFjUoS/92jR9CRCohEOLBno2rAhjj4a4zmz5vciCbQAW251FVDk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5fq7N1XNnqHXK31hLF4ufh+u3mHzDTQDF4mKU6OC/2ksrGU5Y
	HJjOR05hhUe+Ure0jBhhZIERndqzojpAee3ARcELQpPSs5ZWbvzGERXl5OYgX9TobozWKA7m04U
	RgmjR6Q==
X-Google-Smtp-Source: AGHT+IEcdJa5UVv1eVKpTFGesNHv9d2XL0B7hT3B0R31fQH+7/ATODeYafpxjIDzuui8OctpbTv9II/gNUkx
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:98a5:142e:8c2e:e9e5])
 (user=irogers job=sendgmr) by 2002:a05:690c:6504:b0:6db:b2ed:7625 with SMTP
 id 00721157ae682-6e3d3bdfc62mr1002657b3.0.1729146964829; Wed, 16 Oct 2024
 23:36:04 -0700 (PDT)
Date: Wed, 16 Oct 2024 23:35:51 -0700
In-Reply-To: <20241017063555.366065-1-irogers@google.com>
Message-Id: <20241017063555.366065-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241017063555.366065-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH v5 1/5] tools api io: Ensure line_len_out is always initialized
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
2.47.0.105.g07ac214952-goog


