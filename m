Return-Path: <linux-kernel+bounces-284062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D4694FC84
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 06:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90B531F22BDE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 04:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065461F95E;
	Tue, 13 Aug 2024 04:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p9okfl7U"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41921CAA4
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 04:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723521986; cv=none; b=h5lpX/EjT8YqEmtQ6N3ebkdOjSrHF+D+EtF/fQJ+osr7oXDMIQ1afFZ6Utt5omOsNiaM6P96+rg9m+Qko4wuYmjAP+moiwfVBHTeSnYOTaAOPTlXihZpSJSPteIfh8r/01kUNsEBJzkCq720EHREfWm8yYtWBA2dLAKLGvd4SGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723521986; c=relaxed/simple;
	bh=neaj+BZFnlcZdgqAbPmFYuTkXjlGXCUDtmdBZZPPDbA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=t2Rc/gTgYt5NKS3cb/Pu/+GddtxIm7M6WomZMODP4eUGrv9+1lnAOxk76qxQpSPoQtJBh4JaHeZbmP/Sz/EyquVB2+PY7mfm+F/rNf4nY+5BG5qdzTXK0S9przvWTdl8bjWRsN4H6dJEMNy7ysxVt2i5M+YSIOogLd0zNEkjI+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p9okfl7U; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-690404fd34eso124062407b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 21:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723521984; x=1724126784; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sKwxKcZkqeeMfXaZWBRGgFNrCXTfi2cZUnlO1Xgga80=;
        b=p9okfl7UANK49ivsoHI2XczU3oZxc1ancZ/B+AAKXMTmw9a1R/ZltwgRErKSYL4iwt
         dlzH0ir4OiV7Bj41MrByBKXqW9Q440It3lHZQSqNWoXzRSiULHiYZmGO1jLFGdLiE4CZ
         Y+tbHhIunyDgRwmsP416yeVQhXTpH+KOjht7Mxv8mlqNM+Q1kcZc9xiqz9t7WSkSs9Mb
         1XuiP/SKvagN5mBqIf9S1QJJLAJvd9zpueGFQ5Wk8182w6m4xRFdCu+QS08bTSltz3hO
         cXqlJb3PqU3rDqHcyU/0P7K+m59NILRpiRJzUAuCtZfCTcnNioiq15+cJGeP6nT4f+4t
         lqvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723521984; x=1724126784;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sKwxKcZkqeeMfXaZWBRGgFNrCXTfi2cZUnlO1Xgga80=;
        b=czyU/IHOickeEqGxvfrxeoTRKvmImbnBxjtSzlFolJvL2948PZo6amSwzPmkmyvI5S
         SpmlcEvUjkVcmbJnuxKW/VTse+KgTBBZeXgqb9OwsKVuSFOmaweIQ/96JdYaAIUbOPXj
         fHFDxPBLUt9a4iZDxCxwYNVqWsb+odnPJ+i2aOnakuyo9ioVecsq1r8qhWlNB0O128fr
         JbgzNtaKnh/VMQGeWf5dCjfnKLYUho1QZ3UPbnQ/xVoYFGFZ2OdYwUsX6Pvc8PzoBG7A
         4GLEXGZwi1b9vNYDzeqyGtPUHgEg+80vnGNuuam0eMtqjscz1vbL2D9boYmtZ6u2p1NK
         hGdw==
X-Forwarded-Encrypted: i=1; AJvYcCVgcvrnRg0iRPoaELwqtWldZqy4puorRrjrS/dxFLyaNjtrIbITvOt9N/sW+TYYnCuM10LphBHiA7y03lPnfA6rt2/Ur/Y/gfUu5xAC
X-Gm-Message-State: AOJu0YwFE2Y751ucy2QSdgdHOORxIB+j/aMQBzUz3FLV2w+Y9iaZriYm
	/bhyTgMPCDd5KTllGgc8iEv+O5s5C/3EklG2729lK9l0yztOCzCjMd6rndhQdVqztiBfot1USVc
	l2L0DIQ==
X-Google-Smtp-Source: AGHT+IFIcXhCmfpggkMHHGEM3FMuNfVtr00W1dlSBczuTDLPO4/z6gG/iTxgIFLSnngjcay0smyRRbwRKsHK
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:ae34:31b6:7154:c399])
 (user=irogers job=sendgmr) by 2002:a05:690c:2846:b0:680:cd2b:90ed with SMTP
 id 00721157ae682-6a9722978b8mr571897b3.3.1723521983800; Mon, 12 Aug 2024
 21:06:23 -0700 (PDT)
Date: Mon, 12 Aug 2024 21:06:13 -0700
In-Reply-To: <20240813040613.882075-1-irogers@google.com>
Message-Id: <20240813040613.882075-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240813040613.882075-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Subject: [PATCH v1 2/2] perf test annotate: Dump trapping test in trap handler
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Help to better identify the location of test failures but dumping the
failing test in the trap handler.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/annotate.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/annotate.sh b/tools/perf/tests/shell/annotate.sh
index b072d9b97387..2ccf4f1d46b6 100755
--- a/tools/perf/tests/shell/annotate.sh
+++ b/tools/perf/tests/shell/annotate.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # perf annotate basic tests
 # SPDX-License-Identifier: GPL-2.0
 
@@ -28,6 +28,7 @@ cleanup() {
 }
 
 trap_cleanup() {
+  echo "Unexpected signal in ${FUNCNAME[1]}"
   cleanup
   exit 1
 }
-- 
2.46.0.76.ge559c4bf1a-goog


