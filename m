Return-Path: <linux-kernel+bounces-171984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 461788BEB83
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 20:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77C001C21FA0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 18:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C6316D9BA;
	Tue,  7 May 2024 18:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K0A7M5f3"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC3A16D4DA
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 18:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715106968; cv=none; b=kPgxguy5mdTHrfMmN8y35OduftL7GVyiuOxvMPqqY1SorV6XujRT1E64F5ExxN9i98qqNPSH8mUH+q46cfvywylhD4qbgEp49qvaJaOunL7HAPqA5WRFPSX7UQLY7VmE7//1+TFlHlS5qAFGjW9CencIzt0FDK17lL1KJxyGV2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715106968; c=relaxed/simple;
	bh=9HuNi58CVXO3IUVCTHfvsKQGxGInbQe5AluYnPVppJE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=QE7nZDC9ygYxB2vzcbBPizcaOpnCWaMpXfaFJ6oM9gT6VFeBRo+UetQpcMXIhzziAYonzt/esrxKLOysZ58fAlT5Upr7qN/zUckvGEetgXqc/xgVeDBEzN55O9jmj4tKjiaaEhBjA6ADjFtPPLqh/IbJ2xaT6WaWnP3oSF9JqNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K0A7M5f3; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61beaa137acso61888467b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 11:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715106966; x=1715711766; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A1AQvN6jvvxnFiXuFjevdmwJtIquwWKLlnmIOD84P5w=;
        b=K0A7M5f3fh92ljKD5TmLn7OQJh3155ttieC/tNXUHnZ5b1KxlRmsgIemIaAXzd5Q7g
         Av608r1PmyJPDI15yc5hRxdSqX+/sYH7S3hCTgEvPvGZkoCER0/Uz9xorXPHHPx85L2g
         1Xi8hkVqZ3PMZL4w1IqExZ1ji2hgndIBHtBluWDDzI84ZqxTyXf1eR+OxlCrS7u3meVj
         1kzQXLGglv5dEOq2P0Rca+p6fnoXPP7VEvB0r51ADv/Vz9kYiSKHT+tF6eQTwJRcceXe
         FbP9eAmmcYiGr2Egqa0lHO99ZfnQGcL8Rm45BMpVyJaA6kGcLglfeyoLaIz3wvj8pYM0
         1adQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715106966; x=1715711766;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A1AQvN6jvvxnFiXuFjevdmwJtIquwWKLlnmIOD84P5w=;
        b=tGrCIgvbMtAa0GYinv51fcqltiQB+8U9Vi4nUDu6Me+RxwUI1Sg9JzAqeAX65Gz0SZ
         iQ9Pce8fe8zz+syQqCW0u69rFtsdq218a2MMz30qSTzpmVbHpWI1phhyEU+VbA+eHU77
         i7m0KwRmqJOLC/MxfsRY3mPX/WgJ2b9apJVZmiduVReBwuoEybFYkFmYaoRGsBxAz8If
         LjRqLYvcEq4EZklyI5FVFQ/1ccXf1gQgyO4mGFiClxKlOzM0/JigURCWK9GoiCwdc5UU
         7zMU06C/xbPgpjoSOzDtNHATpUx7QlB3qfO/fCgHY8rXXXx+SCn0rF1qtIvEd/ENYq1r
         3vLA==
X-Forwarded-Encrypted: i=1; AJvYcCWMRTRUWeoaz2jrCN3AebSkVtKxMc4rjlwGN8zsa/hlxBHAZVDzIS8k1/jG2d7PO4ScsD6W5HCuutIaOCcXPSRmkIpt7cVLMvkD66kG
X-Gm-Message-State: AOJu0Yy6Whr/HUsn69NJCZJPWsc3ENMYI7iLUHr0/84/dvx3rfIpCYqb
	QBMwd5MJlqV9B4jDycPH1AKDAoKS57hKrPhzlQD2CSahmP+D24EIEETKZtgRfvmahZRHLr8nyVL
	776Gr+w==
X-Google-Smtp-Source: AGHT+IGed/Y+GDst8JT+LvB/MbmpsU6swCAmc9AG+SfItDHq2erYw18Mb6CqYUAWqsNpndsK5G3uDW4aq8/Z
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8095:fd7:9773:b1df])
 (user=irogers job=sendgmr) by 2002:a0d:e249:0:b0:61a:d161:ff8a with SMTP id
 00721157ae682-62085a37c0amr1273937b3.1.1715106965862; Tue, 07 May 2024
 11:36:05 -0700 (PDT)
Date: Tue,  7 May 2024 11:35:38 -0700
In-Reply-To: <20240507183545.1236093-1-irogers@google.com>
Message-Id: <20240507183545.1236093-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240507183545.1236093-1-irogers@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v1 1/8] perf ui browser: Don't save pointer to stack memory
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	James Clark <james.clark@arm.com>, Tim Chen <tim.c.chen@linux.intel.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Yanteng Si <siyanteng@loongson.cn>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Kajol Jain <kjain@linux.ibm.com>, Ravi Bangoria <ravi.bangoria@amd.com>, Li Dong <lidong@vivo.com>, 
	Paran Lee <p4ranlee@gmail.com>, Ben Gainey <ben.gainey@arm.com>, Andi Kleen <ak@linux.intel.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

ui_browser__show is capturing the input title that is stack allocated
memory in hist_browser__run. Avoid a use after return by strdup-ing
the string.

Fixes: 05e8b0804ec4 ("perf ui browser: Stop using 'self'")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/ui/browser.c | 4 +++-
 tools/perf/ui/browser.h | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/ui/browser.c b/tools/perf/ui/browser.c
index 603d11283cbd..c4cdf2ea69b7 100644
--- a/tools/perf/ui/browser.c
+++ b/tools/perf/ui/browser.c
@@ -287,7 +287,8 @@ int ui_browser__show(struct ui_browser *browser, const char *title,
 	mutex_lock(&ui__lock);
 	__ui_browser__show_title(browser, title);
 
-	browser->title = title;
+	free(browser->title);
+	browser->title = strdup(title);
 	zfree(&browser->helpline);
 
 	va_start(ap, helpline);
@@ -304,6 +305,7 @@ void ui_browser__hide(struct ui_browser *browser)
 	mutex_lock(&ui__lock);
 	ui_helpline__pop();
 	zfree(&browser->helpline);
+	zfree(&browser->title);
 	mutex_unlock(&ui__lock);
 }
 
diff --git a/tools/perf/ui/browser.h b/tools/perf/ui/browser.h
index 510ce4554050..6e98d5f8f71c 100644
--- a/tools/perf/ui/browser.h
+++ b/tools/perf/ui/browser.h
@@ -21,7 +21,7 @@ struct ui_browser {
 	u8	      extra_title_lines;
 	int	      current_color;
 	void	      *priv;
-	const char    *title;
+	char	      *title;
 	char	      *helpline;
 	const char    *no_samples_msg;
 	void 	      (*refresh_dimensions)(struct ui_browser *browser);
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


