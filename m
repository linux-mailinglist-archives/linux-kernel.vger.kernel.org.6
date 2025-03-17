Return-Path: <linux-kernel+bounces-565078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80238A66074
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 22:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6537617556B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 21:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11B5202C47;
	Mon, 17 Mar 2025 21:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wnMhQeaW"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98716202984
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 21:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742246773; cv=none; b=lwnnM36MLH+QdXC0QgOE+7euztPhHnEIJpL0uLdGxosV5Nw+I4tdG4MAE2AEPOSmd8RvP5B+mgmlYOFXn7Y+of4crGBRyq6bPLvtyXAOVtwR2w9/NduulId74QxBwpLV67fYueJxEjALxQWrDfOaGMd9MgpoYKbHL/LoJybUv3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742246773; c=relaxed/simple;
	bh=QV6NeSSrSuc1N9LG/u//TUlnETuTUQO6//M4Xzp8orY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=t4UjHEEYGtOqnobc08WsYJrzkBPJVCZW0toX4S+Pfpjg1zHD4fIgpHGBP497AyRV914SR6wotfgO61Mvjt6/eZl+pf1DN3CHlqI3NU6ElP+kAqsYX4CVvBoEgoxEiKe5PU6pBb8OndC0vr23vCJa9GrkNAP1vA2iWxm7NGCJWu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wnMhQeaW; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2242ac37caeso6835ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 14:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742246771; x=1742851571; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CtcFHptsmprlxPmeOniAk13c6ZRerTHBG0RZgJHM97U=;
        b=wnMhQeaW8sQMdoVBiQfqwiBdZYdekumE9n0NqBQ7fF5tRK+IZ5O8pZZRC27TH/i+e3
         dVsQsUw1a/83cGT9g3m6hMRh0O2xl+1ax27YJ1W232MQs+Jr8rRqiMPCS+DfiaJvAepm
         hKCSupWvmNHpdFJzcgm5jZUN5Bvu+bRWmIGMgdGPktTkSbw3oZB53qHZgUboDHQvcmPc
         0liK1ZEjzD4mUJwD3AfIxBDhwu+DioT0YQQkMWI8rY0XQHLm9LDp+psYPO/5zmkU+RPl
         FGtnJQRNtz98CdnRQoNEfDj6dqqab4QxASMibKKH6t+U+m4evJvOO1BlmROvtZdo8Dc9
         jaRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742246771; x=1742851571;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CtcFHptsmprlxPmeOniAk13c6ZRerTHBG0RZgJHM97U=;
        b=pK3t3m4EqYBGEeMEgivhfot1wnaOKtFS69c6hMM8iq8c1yPczNUg1oF3H3Bsu3Rs64
         Ui0K8sFB+KL6t0tUWz5wFuij3s0/RdAS4jgR9A4/v+bfey5fWziXrJiPHr768k9e4EHX
         +ZJsRzfTqJ9Z/eukUC9PU7DUJ+LjRXGRQ/uG0Y8IC2c9pFbM7vlWfWopThjlkKU2GATF
         urYQiQOSpA7h7rFKoyphlaE/6DR1G/Z54WbMM//kHAxC3W8mKG+gML5i96APjC4k+IkE
         HvIUICA1HfE1kHTNbdyiIB/OQZ0oQZEPgiEdOE2CKiYMEUcrTekhIL8crKN70crVw3Yy
         PW5A==
X-Forwarded-Encrypted: i=1; AJvYcCXqY4b2hyppIXOIDNXySfw/YGewQw5KGRnNsndzghnjApHBQgzUYE2Pdaw8oH4Tz11NUrfrRcbj1fIAU2s=@vger.kernel.org
X-Gm-Message-State: AOJu0YztFA8QGExjUpmi08Itzgk64pqMeN9/0MuPmnKX48rYsoSeC2EB
	1XiMZBgWQ6NBTim5LfR9i0yGMoF11SbJ/8YIxBSKSOkIAx81UGq0GmXODR0Powe4TH6V4GgE9DH
	Kt19Qvpd5jGnX8/XCZuxBWO5A6O4lU3D+IlV6
X-Gm-Gg: ASbGnctl3u9jN1NvQ8CuL+GzOoLGrJD729zi/vzzjLtmB+hRIo4PrYUBUCGXSNenM3U
	dfzhRvPWpYrTjKMKZTQ3N6Sh7JWU5LRGeQ6j28oW8DIgExxOzHoclAuHiJ5QVWqqSBon+B3FFdS
	Y2pHMQjoq54os9tv6U7l1lC5VjyPNTerAP+E95iPezwBkg7AV7nV5VvQ4=
X-Google-Smtp-Source: AGHT+IGIchyGjZ/inrviM0LUA3al8hizGh73RtGe6gUpvsgk8pAeBXPh8SETEHrVpJdH+kJyF8I9ZH4nKIs7ZG1cmGs=
X-Received: by 2002:a17:903:40c9:b0:224:6c8:8d84 with SMTP id
 d9443c01a7336-22631018660mr106935ad.4.1742246770603; Mon, 17 Mar 2025
 14:26:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ian Rogers <irogers@google.com>
Date: Mon, 17 Mar 2025 14:25:59 -0700
X-Gm-Features: AQ5f1Jqwcxj8BNxx3Vc7N1w_2aDIUnPEv8jRsk7v8wJCPx94S2CeHFS7o1XaXfc
Message-ID: <CAP-5=fV-t6j9SOSUHLO8H8LWEmB1E4KZtKa3fQWiMx7y12gjhQ@mail.gmail.com>
Subject: Remove the "perf" hard lock up detector (watchdog) from the kernel?
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	linux-perf-users <linux-perf-users@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Doug Anderson <dianders@chromium.org>
Cc: "Liang, Kan" <kan.liang@linux.intel.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Namhyung Kim <namhyung@kernel.org>, 
	Stephane Eranian <eranian@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Leo Yan <leo.yan@arm.com>, 
	James Clark <james.clark@linaro.org>, Will Deacon <will@kernel.org>, 
	Thomas Richter <tmricht@linux.ibm.com>, Vince Weaver <vincent.weaver@maine.edu>
Content-Type: text/plain; charset="UTF-8"

Hi,

The kernel tree has two hard lockup detectors. The perf one uses a
perf counter to generate NMI interrupts and detect a lack of forward
progress, whereas the buddy approach uses the soft lockup hrtimer to
check the next CPU is progressing. Doug Anderson
<dianders@chromium.org> recently questioned:

https://lore.kernel.org/all/CAD=FV=WfB6inJPuwfhbw4mtFBYpr+3ot2J+SJAZ3pT3t4fW7cw@mail.gmail.com/
  ...but I'd also have to ask: is there a reason you're using the "perf"
  hard-lockup detector instead of the buddy one? In my mind, the "buddy"
  watchdog is better in almost all ways (I believe it's lower power,
  doesn't waste a "perf" controller, and doesn't suffer from frequency
  issues). It's even crossed my mind whether the "perf" lockup detector
  should be deprecated. ;-)

In the perf tool there are warnings associated with the NMI watchdog.
The metric code also has a flag on metrics where events aren't grouped
when the NMI watchdog is enabled. For example:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json?h=perf-tools-next#n1916

The warning and breaking of groups is currently inaccurate for the
buddy hard lockup detector as /proc/sys/kernel/nmi_watchdog is still
present to enable or disable the buddy detector. That is the perf tool
is currently warning and breaking event groups stating the NMI
watchdog is a problem but the kernel is configured to use the buddy
watchdog.

I'm unaware of a way to determine if the buddy or "perf" counter based
approach is in use and to correct perf's behavior. A patch adding such
an ability (say a new file in /proc/sys/kernel), and perhaps new
abilities to switch watchdog at runtime, seem less desirable than just
deleting the "perf" counter based hard lock up detector. The perf tool
could make the NMI warnings and breaking of event groups conditional
on the running kernel version then.

Are there objections to just deleting the "perf" hard lock up detector
(watchdog) from the kernel tree? Are there reasons to keep it around
but just not default?

Thanks,
Ian

