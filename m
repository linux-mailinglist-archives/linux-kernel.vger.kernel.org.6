Return-Path: <linux-kernel+bounces-565449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FD2A66862
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 05:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 200627A4F8B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 04:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3128145B24;
	Tue, 18 Mar 2025 04:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ufCJH+zi"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4461EA73
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 04:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742272317; cv=none; b=dcAnJQcp5o/9aFBqjACeuU0jYvVwwaoFRiYjx1Ak7OXN8ygpRMmRwL8CaCa1gUzsjVEcEQP7JvxHijnnFpKNPmemS2PWqcS0oNtv8R3LoD/hNUkkk0yjLaZsp6VKUdpkLqQ6K/JfUl9bXATcCkQZpHnSfLGP83Iwvi3qrW1mrSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742272317; c=relaxed/simple;
	bh=+UkeB7YpP0OBVMmI/mJkEjigeE+kVTwIpdr350ZRFLY=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=dr0/IpQ7A6uCokISKO39k79g69enXTqZtmrS5FFROvYpZW2uXfE0BoOdV4MBnsG4oWY8+kAcMXMu+EIc8Q48AILKysYJHbkp8OWdpZBiBRh0XrY4QKXW/iJYxZY0rG3538nijlg9B/u1fo+zK9jjBFmVpx0DCYGFbQTcuuS/ygw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ufCJH+zi; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6fec94421f8so78698437b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 21:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742272315; x=1742877115; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DLgrXyVAAq0ptL7ULtEAJamCo17E8DS8LodpQQRTOTU=;
        b=ufCJH+ziZ16P9Hn6Dr6zKhgi1pzVH5YmUrEyJz0BSKSWuX8N4SXrWV7U+XXLkJaRE/
         +IYRw06Ezn3FqE2nL24h8o6LifDfXTCPaqlRd2LLLrmqGphxVht4kagnezDMONEGrof2
         nd24VjMazcqbAwBPcHR01VVnGHWrblBXben1q2nAoeOo4idMND/wV7ELsX/BiCGAoTJF
         hF721d8TL55cA6vHaGHYkuTrqEfySdWkpLlC430a8mNrrnXGjCcnvSFRwVQ12AnlZCUt
         mVFbq+6Mr6H44KRNM7FJg7i5zIO9FJjR4mRmInl4BLGkNcKBDZnPEIt6CoSs3QnyEy23
         9wHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742272315; x=1742877115;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DLgrXyVAAq0ptL7ULtEAJamCo17E8DS8LodpQQRTOTU=;
        b=KY2WmXSkL3SsPu1wYuiCsCJg77Ou6HWrYLwelsSpCjhfNy+IQDyrScep/lte9m3dbq
         DkI6rPk0B6XhNf1ngheWztpKrbCOi9vClc2oUcO/KkOgIdotdN2NsVaifKlGRZ39uTVG
         k9HarjxUAEf289RIId6t5b0EWqy8ZIjN/W3gxtdupTdGyHrnHYWym+ESD+8zgxwvuOPx
         H8koRZ2vkl8yjpLNSp5ccb010bHViGD+HV6TxUJ8WfD/SotZkgJH9dfXxDBRD4N4mSKg
         V9/Aqpj7FL6miuQekX9IrDVYa0/RJwuGtvG+dgWugjEBDVn5qSyQgI6ER/z63ivLIjZu
         2nWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjtv9oXRfe1xxto9LeN3mKs/yWO8gOB4ae+2rsflpKz9wdCgYeVWZCQzc3Piu6bESj48XJWvtvIn6tacA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2JoYeDzStoIddQo3dlhjnv0VAxCSklkaT30VC8y8bXjxtwOf3
	jEHhRSAFlZIUd6OSdfwbfSh+5RbfSWEXTvry06BbtfuF1N1PpA7IKPkBjtN1RIXrd91LKw8csDv
	wNMmkdw==
X-Google-Smtp-Source: AGHT+IEKgnscg/W60T4TaV9VDLaP6m+5M5ZZxzZN444+f2mNJwgVIaBoIcQw25QmOjtfOFXKSxSPAmw5TKz6
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:ef29:15ce:a42a:b69f])
 (user=irogers job=sendgmr) by 2002:a05:690c:6302:b0:6fd:4950:1784 with SMTP
 id 00721157ae682-6ff45e39b85mr905207b3.2.1742272314725; Mon, 17 Mar 2025
 21:31:54 -0700 (PDT)
Date: Mon, 17 Mar 2025 21:31:48 -0700
Message-Id: <20250318043151.137973-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Subject: [PATCH v2 0/3] dso__data asan and test fixes
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, James Clark <james.clark@linaro.org>, 
	Yunseong Kim <yskelg@gmail.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The dso__data logic could deadlock with itself when build with asan or
reference count checking due to trying to recurively take a
non-recursive mutex. Use clang's thread safety analysis to find/fix
the problem. Running the tests would fail with -F no-fork mode as a
file descriptor wasn't cleaned up.

v2: Remove an unnecessary if as suggested by Namhyung.

Ian Rogers (3):
  perf mutex: Add annotations for LOCKS_EXCLUDED and LOCKS_RETURNED
  perf dso: Use lock annotations to fix asan deadlock
  perf test dso-data: Correctly free test file in read test

 tools/perf/tests/dso-data.c              | 28 ++++-----
 tools/perf/util/dso.c                    | 74 +++++++++++++++---------
 tools/perf/util/dso.h                    | 15 +++--
 tools/perf/util/mutex.h                  |  8 +++
 tools/perf/util/unwind-libunwind-local.c | 16 ++---
 5 files changed, 86 insertions(+), 55 deletions(-)

-- 
2.49.0.rc1.451.g8f38331e32-goog


