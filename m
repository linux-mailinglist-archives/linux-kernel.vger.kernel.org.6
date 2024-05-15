Return-Path: <linux-kernel+bounces-180318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 466E98C6CE2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 21:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ADE81C21CB6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 19:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562D515ADA4;
	Wed, 15 May 2024 19:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ymxpliUj"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48D53839C
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 19:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715801782; cv=none; b=CDnaaOKpnbEhuJVoc/Z+8FRz4JIS9ZAJdBitr5Q8abP0aMEzXvQmhPmN75AEHOxwQIeZoLqL1/y6jcFz3R9hYvAtzMnKzXpJ0Yyrnwc1c7pfBaTaCQwLoWpjp4M/s+Ad9MOOyNem/5IyW5im7kArmt676vd2mvinN2roYLCE2uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715801782; c=relaxed/simple;
	bh=rNcKdHemTqXp/jWokR6p4S2Gh19u1eDcI/Wkq5LI0TA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=VUO46BiON6WG3iqamjeyVvwGc7xEfJ6j9ZYD9qNPReHVFFwzjjO/aj2AZ93PHLzn61ze+GmuJpQakt9HTZpKEYiBR5r8nlsOWhx0UdB0veEFflckAHujC2+Nv+/KahRCb1a9S2xMqk4C0eWo59GTee5o0IIzw0YemJquyqvomyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yabinc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ymxpliUj; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yabinc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61bed763956so135114037b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 12:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715801780; x=1716406580; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8mo40hi9HkXQPI0hPSG3MjEbNa63l8uDo/3AAaoaXZs=;
        b=ymxpliUjau7tW/aFRnwLgbrFs8PjXmfpKYZDfIeE0ucSmv1YpIaaXAiL1kNxao/hag
         NNZfL3pQ8KP8DpGDiF0yChRSHXMVcBBN6iwTdA6YJjHIiJvF7eR3UD5IDUY9v1Ld5H+9
         EuNCBQz3xuKuOtBBBaoECw5Zcf9a6CEBH+ZJQmWX5hYGaW5ER684OQ9BZni3/d7WPzOb
         gY/u2DsMWqhAcfFu6Lt+MFM9ilealcz2kw1b91tJau04V2ty+NOE6At5XeVKcXnB6R1o
         OCywm1TjzVdJOo+fw47vcJ4r0aEMbHuX53hX2vicVRaYY1P8MSpFG+k2vMq4TaN21Yw+
         T/LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715801780; x=1716406580;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8mo40hi9HkXQPI0hPSG3MjEbNa63l8uDo/3AAaoaXZs=;
        b=rKYZdwLF19BUULPpTbUZ7EIB+/z4QLU/E3kcGrvHX0yRwIlq9/qm5P9bj+X4egqodR
         h99RSM++YeCMJzcDkCFBHVWpaTsN4wgs+hhaQhbjZERt91EwTX9Cd4JYGeTMR9OimmmF
         +FrOXQReN8n5Tk9tqZtZe6KdnCQkMqDF9CiL91BdfDuMTdf7qqGHd64hYmkqsg4LCk8p
         nOXNl8MHt/8wdWhSR47ftGUHmlZLM55/2V9ZR2Uqf37k7yOhRu8cy+4Kt14ATNVFvIKg
         naq1Mq0ymAgomXP0PV9gS4QBknRY6imgMOYAsISAjg/mBuVuO6RJaZb2kt/f5UAif+jC
         Tbpg==
X-Forwarded-Encrypted: i=1; AJvYcCWLXbYC1tVVRDg06e4jNB0dnjoePp56j/k+m4frzhTpSxQ8kijgCh82mzJPPKgfdkkmKc+Hx2AwpnGqrwSZyD6RMdDfbgSp/N77SloU
X-Gm-Message-State: AOJu0YwexLGPpJGvRBDTSeSfdxYkMD2nK7s+2mcGdjdKHCXx68JkFQwI
	bcdqAqv+oEKk/YPXVkemhmCsxZU46s5/CxVqNYtsBxR1z5ULhG9806qolRe2J9yIw8UcjRseQea
	m
X-Google-Smtp-Source: AGHT+IH0DGxH7FiS9IKB53lZ/iJkOvC68dQQh6DPRikcqpIYM9vqeJtrXJMVdVoglnHDpQsEeY8eJHhrmho=
X-Received: from yabinc-desktop.mtv.corp.google.com ([2620:15c:211:202:6e4e:954d:1e49:f87c])
 (user=yabinc job=sendgmr) by 2002:a05:690c:6f8c:b0:61b:ea12:d0b with SMTP id
 00721157ae682-622aff85f0cmr46339907b3.2.1715801779694; Wed, 15 May 2024
 12:36:19 -0700 (PDT)
Date: Wed, 15 May 2024 12:36:06 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240515193610.2350456-1-yabinc@google.com>
Subject: [PATCH v5 0/3] perf/core: Check sample_type in sample data saving
 helper functions
From: Yabin Cui <yabinc@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Yabin Cui <yabinc@google.com>
Content-Type: text/plain; charset="UTF-8"

Hello,

We use helper functions to save raw data, callchain and branch stack in
perf_sample_data. These functions update perf_sample_data->dyn_size without
checking event->attr.sample_type, which may result in unused space
allocated in sample records. To prevent this from happening, this patchset
enforces checking sample_type of an event in these helper functions.

Thanks,
Yabin


Changes since v1:
 - Check event->attr.sample_type & PERF_SAMPLE_RAW before
   calling perf_sample_save_raw_data().
 - Subject has been changed to reflect the change of solution.

Changes since v2:
 - Move sample_type check into perf_sample_save_raw_data().
 - (New patch) Move sample_type check into perf_sample_save_callchain().
 - (New patch) Move sample_type check into perf_sample_save_brstack().

Changes since v3:
 - Fix -Werror=implicit-function-declaration by moving has_branch_stack().

Changes since v4:
 - Give a warning if data->sample_flags is already set when calling the
   helper functions.

Original commit message from v1:
  perf/core: Trim dyn_size if raw data is absent

Original commit message from v2/v3:
  perf/core: Save raw sample data conditionally based on sample type


Yabin Cui (3):
  perf/core: Save raw sample data conditionally based on sample type
  perf/core: Check sample_type in perf_sample_save_callchain
  perf/core: Check sample_type in perf_sample_save_brstack

 arch/s390/kernel/perf_cpum_cf.c    |  2 +-
 arch/s390/kernel/perf_pai_crypto.c |  2 +-
 arch/s390/kernel/perf_pai_ext.c    |  2 +-
 arch/x86/events/amd/core.c         |  3 +--
 arch/x86/events/amd/ibs.c          |  5 ++---
 arch/x86/events/core.c             |  3 +--
 arch/x86/events/intel/ds.c         |  9 +++-----
 include/linux/perf_event.h         | 26 +++++++++++++++++-----
 kernel/events/core.c               | 35 +++++++++++++++---------------
 kernel/trace/bpf_trace.c           | 11 +++++-----
 10 files changed, 55 insertions(+), 43 deletions(-)

-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


