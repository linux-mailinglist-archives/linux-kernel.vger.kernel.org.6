Return-Path: <linux-kernel+bounces-168872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BA58BBF18
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 05:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ADE31F2175D
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 03:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B650184F;
	Sun,  5 May 2024 03:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hwa6VxAv"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3321370
	for <linux-kernel@vger.kernel.org>; Sun,  5 May 2024 03:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714878990; cv=none; b=u0xAQIIy0dDcwJUxCeReTiPwsapX8qOfvweOrSfLjRpLoPfF4PAZFvSg+qybxeEH14P3auCVIhWS0NpUU6NjAK6CvHrfvxTH5lZGTZnmPGZurP90SLDnMZQ/kcLs00wgF8K4uRiC9zmuW7P0OAnvEkMUT9yDHqE9gJaBXNGmWhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714878990; c=relaxed/simple;
	bh=Z8j5CRrOLdlJCjGWI4GvBp9N/S6N1gw7if+g2FTj0jw=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=EMeoQLnzMbDxLRqyFtLTJx+exlH8l5q8Y+PM6xYOZCq1K2aRt3BQ6TvjNSUGqXkwW9xj/A5uP3vza8Py+y5yLAZ08OIVpuULT0RistqQrLN8oFCOc5FJFAlIq3INcaIOeKxqIDdtnRn8OJfD9/4KgyJQ6vPZtB3KDErl5DTuYU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hwa6VxAv; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61d21cf3d3bso15854907b3.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2024 20:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714878988; x=1715483788; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9uiYYye9ZD+jb2gb5x6Dw5C7UWM8eKydBAksThATf1k=;
        b=Hwa6VxAvym+QmxF6OALkVWIM0+7IvoJ52CF6w8n3T91AdgcVte6GDk/Xy9751QkJCs
         cjPPfMcUSdd+k6FiKpLlKVEtM+vtmQ4QJ6lmMgIoUSKCchIQYfrc3ZgS3eUa7fwFOLcc
         K5xLGk/ddPbbXgLu2cFvyFS/oL+Bujih+giHOFDfxlc+D9zdwWh93O1FiUjpjnO1FVFx
         w5uMcfe2rmEsa9Uqp8dxuQHDfveqisNtsLeU36vMcW0dsXtT6uMLwSt7EWe09r1gui47
         cCtTsurGjF5vqmC6tD74Nhht8HZb2zU40Vg6oDXQOx8HppsD95O6SwoyS2EkVs56jM5H
         cUdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714878988; x=1715483788;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9uiYYye9ZD+jb2gb5x6Dw5C7UWM8eKydBAksThATf1k=;
        b=CfLz8cTvOlbNGgOlQQ8FPHVSYRu3S/7Js9z2jaUUWcEG3dOg7HIrP/5vdtBstyFqLl
         Fz6qsX8S9bPzyjNUVn62o1LL6H5rSFEWYhB8Exp6OUyrUIsX3PHamrdi4xmXrj5KtSGa
         Ky/jUVq01YhkYfK1sJKFI8nR3DzwbqSMqY4n1iJvEZiq6uKCazCT2M9Jlkk7G8/Vzo/z
         TkdYoW0OC69F2alCdyHd0lvdYXEsRRPLrpjarg2haegIRqUlFvJe31xEukbPxYXz4Lf8
         UclG0QOz9JSehY1/93WJnpvWZDYptUbbbsKHVzjZxgoV3A6R+GQ9PVR6p4mRJt8woWyB
         irCg==
X-Forwarded-Encrypted: i=1; AJvYcCVxpn53kYJzliwydnTOT1K0D7pDTsVA+y6IRA+ufooWSDE/vVMD7eY57PHE950JS6bVuB+EWSOn3pP1LG0ZPchJcEtxYxiQRcljGRPI
X-Gm-Message-State: AOJu0YznEInjlauS4n89uuGSeZpSAHG/oaZ24LTVTCP0YQb/FnNYCEJy
	lgnHesB2oJQQMMLykI1ykmAy2cNQOca/22ig2c4Dl5zFaE4Fa4/Rx7hvIvjiEoId3NonSfktVck
	2V6ZHig==
X-Google-Smtp-Source: AGHT+IGu0Hu57WV3E0cZzcFCwREdxLNwrUq64n4z3CSgqpW9W9N8ZRmk/Uydox4zou9vFjG62TyC16YGXhYI
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:566d:1f52:f5f5:c8ec])
 (user=irogers job=sendgmr) by 2002:a81:4804:0:b0:61b:1d66:61c4 with SMTP id
 v4-20020a814804000000b0061b1d6661c4mr1512634ywa.10.1714878988379; Sat, 04 May
 2024 20:16:28 -0700 (PDT)
Date: Sat,  4 May 2024 20:16:22 -0700
Message-Id: <20240505031624.299361-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v3 0/2] perf pmus: Sort/merge/aggregate PMUs like mrvl_ddr_pmu
From: Ian Rogers <irogers@google.com>
To: Thomas Richter <tmricht@linux.ibm.com>, Bhaskara Budiredla <bbudiredla@marvell.com>, 
	Bharat Bhushan <bbhushan2@marvell.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

The mrvl_ddr_pmu is uncore and has a hexadecimal address
suffix. Current PMU sorting/merging code assumes uncore PMU names
start with uncore_ and have a decimal suffix. Add support for
hexadecimal suffixes and add tests.

v3. Rebase and move tests from pmus.c to the existing pmu.c.

Ian Rogers (2):
  perf pmus: Sort/merge/aggregate PMUs like mrvl_ddr_pmu
  perf tests: Add some pmu core functionality tests

 tools/perf/tests/pmu.c | 95 ++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/pmu.c  |  4 +-
 tools/perf/util/pmus.c | 53 ++++++++++++-----------
 tools/perf/util/pmus.h |  7 +++-
 4 files changed, 131 insertions(+), 28 deletions(-)

-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


