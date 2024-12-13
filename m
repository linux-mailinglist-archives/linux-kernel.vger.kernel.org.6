Return-Path: <linux-kernel+bounces-445573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 541B29F17CC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 22:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DAD316C5CB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 21:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF871A8F9C;
	Fri, 13 Dec 2024 21:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fVw56T1W"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439B21A76CC
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 21:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734123885; cv=none; b=HKgEIWn/Vd9PcJCuBgO+yYvF6i0bEUofuPWdXz54z8sjN/0OtsTzYrctSRQ8RcCcHBS/Mw+XyZjTPCFVtwCi0DxEGxJAZO+v1m8YBILcJa+6gpE9Yqg4HpdL4NAHEQmqPqA7DZLgJgjzcMx5sV1+k1jaNk95j9NPEDw79fgr7DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734123885; c=relaxed/simple;
	bh=9WsK29GipO9NFsc3hIC2PewS3A5xwy+nUOe36/bHbco=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=iLhfYa9rkPs1NN2+MYU1MOczEFHrfkH4ekWP76C2tEn6Yo7OP4xMW+NNDht+mZ4rwQ+Dy72jx4dFfzEUE6OPQRQYxpDf10nZbl1TR+FZ6AywR909Hy/FE1rTGUz59uwzVeZdd1MeWz6duvjOxMQPeGUOJcZmfENKVAQWqA1NaCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fVw56T1W; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6f013249180so42998557b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 13:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734123883; x=1734728683; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZmmTceEXI49vAlTZsXzZ0kDXlU3YmEJweJHtvtDSTLk=;
        b=fVw56T1Wn/gfOSCeDetmk4e6M794RU3h6CkdCEk7SKpqbgtdChuB2kX7kwrwz58hlg
         NzAkhu/v4G96mrxYwcMMgSBeW05ZY5neAnmIZhDfyshBywal8jcbz18eGy2xT1q6VbYK
         SY0w9Nf6g6l4hvQGqv8QWmP0Pt2dWPBlUr+dfM41LJ1aGOUH6x4rnDQxHYwax8KPgi6t
         5JQ7bNYd1+JwF4O6HpbAxSzszpK/P/L8eDpvit2n9+ggh230OgR4ZvBQMX8UwKywLbPH
         E5YmxEc5w9HxE34WxeyRTW5rIXm3YlLrCErRc5Cj/KBs2l3ReMTzbiuP8hn8tuGnaGKg
         9ecQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734123883; x=1734728683;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZmmTceEXI49vAlTZsXzZ0kDXlU3YmEJweJHtvtDSTLk=;
        b=J/PpVAde/6vcEm5gVKQR6hqZm+obAYlb2wJlGoi8I/xNrnpX8blTl3KtLHtbtNFDb+
         cYRnX3IrDNDp42bHyozuJeD9RDpnSs73Iav1iaN8mDjqBkDLKf+l69bohMScPu52zgUB
         00Xen8LGiPjxaZXFUcm3h0eyBbPVjGDoXl/894NXun7xICPoNjYPJ/iZvaSUL0OGBCy7
         AX9r/Mr15GZoWNLCKPod3lih3neY01NgSADQDzx6Tz8PBuMbSM/qYtctEEE2P3EwZ61l
         toCPoI05i6cIidKuHUPHJZZBLmMCFLvDIQjwkNZv5WIWdwoiMBfzJdkJ1Nr4wEd1mEDH
         t60w==
X-Forwarded-Encrypted: i=1; AJvYcCWmA/s+5kZaVWzu8VvkAIURDkCrerHP0hw8vqcrc188pxXRPat+4s/os+jJQMqDt6tyvYHhNxOeS4bu77U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRL4lI/l0DghoAuUXDSsABfiPLWNGe9F8lwuQoYO1fvWiA1z9s
	oRU5NSmlg8BgVsme0TM98MGnWLxKO8LiB3pWZBOFoC4Vz4rJQCBgwjPz2YtCq046fowJwEzXak6
	JlAn9xA==
X-Google-Smtp-Source: AGHT+IHpiKviovMECOth7u4kOhfEglD8RAZ2s+tFKqdgpPkBwtpkcy8GbhxAXictuSVtrav/UTjOTS2cR59l
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:9a50:5183:644a:3472])
 (user=irogers job=sendgmr) by 2002:a05:690c:26ca:b0:6ee:61ea:a40e with SMTP
 id 00721157ae682-6f275c1849amr58497b3.2.1734123883146; Fri, 13 Dec 2024
 13:04:43 -0800 (PST)
Date: Fri, 13 Dec 2024 13:04:22 -0800
In-Reply-To: <20241213210425.526512-1-irogers@google.com>
Message-Id: <20241213210425.526512-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241213210425.526512-1-irogers@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v1 5/8] tools headers: Add non-NULL assert to container_of
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, "Mike Rapoport (IBM)" <rppt@kernel.org>, 
	Wei Yang <richard.weiyang@gmail.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

container_of on a NULL may yield a non-NULL, confusion and errors.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/include/linux/kernel.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/include/linux/kernel.h b/tools/include/linux/kernel.h
index 10f74f021d55..8d617467c5c5 100644
--- a/tools/include/linux/kernel.h
+++ b/tools/include/linux/kernel.h
@@ -38,6 +38,7 @@
 	static_assert(__same_type(*(ptr), ((type *)0)->member) ||	\
 		      __same_type(*(ptr), void),			\
 		      "pointer type mismatch in container_of()");	\
+	assert(ptr != NULL);						\
 	((type *)(__mptr - offsetof(type, member))); })
 #endif
 
-- 
2.47.1.613.gc27f4b7a9f-goog


