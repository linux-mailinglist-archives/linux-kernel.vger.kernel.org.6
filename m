Return-Path: <linux-kernel+bounces-291386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F407956172
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 05:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16A7428269E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 03:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC3728373;
	Mon, 19 Aug 2024 03:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="CL8Cit2Q"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843A4610D
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 03:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724038238; cv=none; b=mUjBqBsYjBmtUP+CjxFYDh+Lvj4M3OwdoTemKV/gUzAA/aT1w0/QHI+F5ycjLx9lbRzVl8tEeb/vJPmKR5/Asqsx4d87PRuZBW2Vx57aw1y6YeV6ftAdm695qRCbo7ylYYEaqs4AH7eJ2FnaTVDz8JjFn/0rihWFZlkEsRU1ypk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724038238; c=relaxed/simple;
	bh=smeT7btf6vic+0qDBBQF/BAOYLJRLwA5COk3VUkS1+4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lse5PGInp154E1sjrijBOE54TbESIaaXe05Jw4LpA8zhdrxfcM2dNXjsCOfTgCZXSp5V/NOL+mnJMNVTLiw2XmQNgRnGH6ZOWV2YH0vZfjwdN2u07d3Q9evCe+5p0WBoT42jw8Z5RyZHUboLKLAzpQhylsE2ttzKJDwilq8F1gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=CL8Cit2Q; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-70cb1b959a6so1182247a34.3
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 20:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724038235; x=1724643035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BQfYQdhZ8IPGBzuFqvB5A5WRRXptMp84Fb1B8wo1jYM=;
        b=CL8Cit2QdILMRvPsSnb+V9GG5qWTn7zZoAcJEDJVuDH2tlc9HxutaSJK5TeXjOGFV6
         74vLlSsJdb2nr66vXoLvw+6JTcxXxuMcvqzTwX13pxAdsigughM77ntA/lfeclGSBQ5Y
         gD7cXiYrwkvbL9hzSTLJ5jM9z+ZS80A7JlvkHizQ+dwp3q1GJkevz6lHyaiEjXUD+EEA
         QCmnT3qSlbSAkAAUhnVJUj69QlUXjapENz7XsTAsfyM8xiiibfafknxEfgWmOg+/D5su
         tW95yX5sT8ifI7CZHAxqhVuSS/cdyy3rlM548b4POEngMfcUg+Ax8qxSTJ1P61zBwgWz
         F7kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724038235; x=1724643035;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BQfYQdhZ8IPGBzuFqvB5A5WRRXptMp84Fb1B8wo1jYM=;
        b=CM+w2CtvUk1tm/tB9CI6wEWcCghodjFlewmr+4niPY1uywn822hcN9fBKR0vRftXQd
         33gh9IPXRABSlYPdL2eqcq+UqaGFb06IkXRVCHg/buXLiIKpSv5ivz2Z6FF3ZZ5Mofxq
         GMoPpLFVQQ0eLouEwsVBXHoQDAsnoI0MFmaHrF362BTNao7XlPAZK+8uIaU5LILz8eHD
         hoS3qLwr3Z4NEKJ3Y+0iPHgGaj9Ov2Tzeb3GpzZEoZZzmxvd8px9IIzb2tpplP+K1QqC
         fFwQ+u1pU4v5g6YWuRKcw66EjEyWEIxtix4habv6WDIx2fY1SCP7/hH/roDLXcHFmN9T
         YRPA==
X-Forwarded-Encrypted: i=1; AJvYcCVNAjeK/D88BasP9MFMZv909OjxiV7tKe4vled2COr7yEa8GOHcD7lh/7R2DPUG+MP9R+ujaQc3q/T7LmyPGY62iHuhMrHYK75BsYLL
X-Gm-Message-State: AOJu0YyrJCwsQ9BenE3MPpC5FnJzwJmm234d28+G6aWe3aC51lu0BDz6
	/maaaMQCcIuJ/VN8dMFifSQIUZoJ6jenT8goZbSUA2AMTLRKIgbP/0ZrKvuPAao=
X-Google-Smtp-Source: AGHT+IFHiz8Kjr1wxrSI5Chm3QImFdtCFeaiOJOKmwCFkK1n/m0rAeva4T/VwtVCfeJrGbD5OlqibA==
X-Received: by 2002:a05:6870:3911:b0:261:12a8:5b69 with SMTP id 586e51a60fabf-2701c38ab1cmr10113833fac.18.1724038235353;
        Sun, 18 Aug 2024 20:30:35 -0700 (PDT)
Received: from ubuntu20.04 ([203.208.189.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127add83bdsm5816397b3a.3.2024.08.18.20.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 20:30:34 -0700 (PDT)
From: Yang Jihong <yangjihong@bytedance.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	james.clark@arm.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yangjihong@bytedance.com
Subject: [PATCH v2 0/2] perf sched timehist: Add --show-prio & --prio option
Date: Mon, 19 Aug 2024 11:30:14 +0800
Message-Id: <20240819033016.2427235-1-yangjihong@bytedance.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch set adds --show-prio and --prio to show and filter task priorities.
Sometimes may only be interested in the scheduling of certain tasks
(such as RT tasks). Support for analyzing events of tasks with given priority(ies)
only.

Both options are disabled by default, consistent with the original behavior.

Changes since v1:
 - Rebase based on the latest perf-tools-next branch.
 - Enhance documentation's --prio entry, add a description of how to use multiple priorities. (suggested-by Namhyung)

Yang Jihong (2):
  perf sched timehist: Add --show-prio option
  perf sched timehist: Add --prio option

 tools/perf/Documentation/perf-sched.txt |   9 ++
 tools/perf/builtin-sched.c              | 163 +++++++++++++++++++++++-
 2 files changed, 165 insertions(+), 7 deletions(-)

-- 
2.25.1


