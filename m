Return-Path: <linux-kernel+bounces-446706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 554CA9F2837
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 02:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F6021637AB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 01:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDAFF1B813;
	Mon, 16 Dec 2024 01:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LbKCUYq9"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815FB17991
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 01:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734313611; cv=none; b=C4elsdMqMiCj8JPZ4VlJHY4nsnWVBB22JS9QBLFr+XIi5ivDKMjWqAN8nD+o/H1O9+H5ugaHXwcnR9rvg6fsYG8fT3adCwzfU5AoX60UzUZzfu93dsv5MkrqOshzizeqyFTu3QryaeR/OGfTE+jlnNJlwsT6mENMwls6LYTqZHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734313611; c=relaxed/simple;
	bh=yJpYZGOXHq4VARxKkRiZQwJlC97N+gKPnvN4RxqmM5k=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=B08R8J1J/hs1MkyALfz57BtRcHJPBXNNYcfviZtlEJDFfJ+htXZuYHsxj+uj4Gr5kzicL0BkNrB2e9dU/3Gb8sk6t2YqIRit0dQD784QtBlpKqIJlMY81De5UOKVuYGPBcuZ/59L8m0RRJOYRjFXx/jk2EBTPc9m3suhV1oZPYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LbKCUYq9; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6f2737d115eso42212967b3.2
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 17:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734313607; x=1734918407; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vurgNUDFdScpRn1TdwGFyPhlbG8QwsO+PcyluWaJkUA=;
        b=LbKCUYq97zMEvu8ZbUZD9ddCvzVfJlv+durNGi7hbejs6jFMfib7wGr7fkUsNuAi8w
         KzmFz68KUjGcP5sf3DMcjrtH+sWV7auwwCiDTla2XVDPNMLkdcicmQRpLgLzss4k8R5I
         yNoCDhAy/CVjK9XuuW5Euod9qHIRBhvv+ixNnoj/mpyJfR/41b14BeuGx01TMaEJJlCc
         leCOQXkRNjB2+mGsQdOp2383kt+ttGQh0d/vYIguCLgtNQL2K4PXXkmMEcMqG1bBagsL
         Z/mK92A1Y2QpVS5W7NAsXVHWOdqoMK2D20eSajzm/ooIY7XJcMgRVt6IWZhhHIZS8mer
         3MfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734313607; x=1734918407;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vurgNUDFdScpRn1TdwGFyPhlbG8QwsO+PcyluWaJkUA=;
        b=KKgkfs3ti8VNlS6faPGYf7vxvYX67C/LRHAyDCSsgUcMRntVpLFG0jVyu5sVhq4oAa
         1b7XTLuBxvFJs+WXUvBy6aY+KfTFb9npLzluxjY/BySXiFpkhri+xkSeewtZuzmuixRb
         PcYc6JAVa3WEXLaFEwABci8JxGPzs5NhIdJopuQ9iLGYlijX29MeN3tSCP+HYAC52zZu
         qVs3a4j8d5Je5Z1mooY14xhetTfedekWObj3yMayEtCH/ojJLAV7a18szYBabEH1G/7t
         /V4c2tw4lx/ZEeqpRCzbaiMx02v4iDcV+Ji95hgVAHm7dFjOKXNP6dL0vbgje6dDDELi
         Ksgw==
X-Forwarded-Encrypted: i=1; AJvYcCU2LFwog+L07BWd4WrZvIruSIwVpgKfp3S/ssyetuvcEGoqM2G+ZH08722y0ihASgcFp5qgoWypQJa+elA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNG6snljuGZ6n846ZnFS0d0yoEw9hai93j8pPUMBfiU6W/JLMB
	KWeFRsImbgKEFOZ8FNH2AMvHXfB23StbXbH0Y/rFpU1epNYB9FnOTtUbCfWrbaAzBnIjz0Oq3Lm
	J4ijGcg==
X-Google-Smtp-Source: AGHT+IFmAlVoXvHPrxiHPIjRrV3D22hGqmGSknS7ig9MfnLEFSQ4AjnOdberj0uqKxJzkSNTokeHTGDsfByZ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:175d:4db2:deb4:d450])
 (user=irogers job=sendgmr) by 2002:a0d:d142:0:b0:6e7:e493:2db6 with SMTP id
 00721157ae682-6f279b7db76mr69787b3.3.1734313607540; Sun, 15 Dec 2024 17:46:47
 -0800 (PST)
Date: Sun, 15 Dec 2024 17:46:33 -0800
Message-Id: <20241216014637.304761-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v2 0/4] perf file align features, avoid UB
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Yanteng Si <siyanteng@loongson.cn>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Features like hostname may not be 8-byte aligned. Add padding to make
the feature aligned to avoid undefined behavior (UB). Modify the
writing of the CPU topology features to always write die_cpus_list
even if empty, as the size could have been aligned and not allow the
missing list to be detected. Avoid UB also in machine where a NULL
may be incremented.

v2: Fix CPU topology as described in replies to v1.
v1: https://lore.kernel.org/lkml/20241212080530.1329601-1-irogers@google.com/

Ian Rogers (4):
  perf header: Write out even empty die_cpus_list
  perf synthetic-events: Ensure features are aligned
  perf machine: Avoid UB by delaying computing branch entries
  perf record: Assert synthesized events are 8-byte aligned

 tools/perf/builtin-record.c        |  5 ++++-
 tools/perf/util/header.c           | 10 ++++------
 tools/perf/util/machine.c          |  2 +-
 tools/perf/util/synthetic-events.c |  2 ++
 4 files changed, 11 insertions(+), 8 deletions(-)

-- 
2.47.1.613.gc27f4b7a9f-goog


