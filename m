Return-Path: <linux-kernel+bounces-382486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 816869B0EE0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 21:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04A1D1F2204F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 19:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A0021746D;
	Fri, 25 Oct 2024 19:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vwTg0X2D"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBB9216DF4
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 19:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729884086; cv=none; b=YHyJR3IwHr6izCqVWAVvKyJZtPbL+njIf8RU3Vp/NcaOeCMnGIS8q0DGuyMad9wtlyntFeIKAs1h/+UhzYrJlicY0RNorcskK7cR7i8GTEJe27M42G0isRaLzYMdFlxwbKp0TrXPIMbPVuCnj6WmN5Hv0LZpgbRXZY8NQDGIdHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729884086; c=relaxed/simple;
	bh=0odQGceZNBTkUJ7F9d7VELVpW9gytwTlwU17UG1a/+U=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=L1tNzQIVjBHWlJBY6p5F7kyA0qmcXPExQ3ecFUYxPZbbto3JFlKqS34V0EcdP1g+TZ647OfpNauAXx8VdyCPdHFulyPZgOHjREaDIdjufBAw751TAYlpEW+1Bp2/xNAfQKF3tRluudt9QGsqeLP/fixyuSqE50CPteW9Acpj18E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vwTg0X2D; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e35bdb6a31so49412307b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 12:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729884083; x=1730488883; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6iAkrxns4o/btTyHCpeR4AXaTsboqF9Bu2tTm7l0wyc=;
        b=vwTg0X2Dx3kM3d7SEgo5910+l38O/XPJLu6TpS9i6hs8RfN+PTGQ4DkfdvmFSG2gxG
         tSAt/AHShbJ3mrMQah6U/B+M59GnW8q0RcQqnNqaU0qEnl/SBWU/ZniOS5Dsyzb+cpna
         g/q5MEEdehEih/lHTAdJSc3Hi32DzW7yv5OS/2XiOUjuy1B5eTz9JHZQR76LzHQpGaiq
         SkQ2pWA+se+LJ8B51pyT3zkFYWf+Gy2GL1MiCuVCSDzV+B9+SLaxeyDP4NSvM/PcDC3g
         xrPtje/eUNW+TINVQvlxymwaOVwT/OI6pWitTY1ZJLdcGBvkAe4o0qNxsq+0/UW/Smm2
         JDbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729884083; x=1730488883;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6iAkrxns4o/btTyHCpeR4AXaTsboqF9Bu2tTm7l0wyc=;
        b=Ua0xz0iwi8pP1qEYra77P+XcuRh+KH4nxQosf+TXRDpaePpJoc/BAcy7fTdB8PnqfP
         9hFg6iTuZ8Et+L0me9epCFS33gx5WV4ogEn/osioVq7xVN/4zr/zigY2k5fEvDm8mITq
         EchYp20Ley3YDZ3sF4meElNMHa90L0T5s7X1Kons5IbchJY65LS0mHn6MMgqbovhx9g2
         C60tvgHEFOqQLKlvW57zmgzMqTYP9hRZEtbl19pW1gWLN/jb1RV2MatvR7m4UeI6Ys+a
         xmV/D9xd4ubX+759CNLLl9CR6d4EBfif2AnlrRiFuYRUMhcPhNiXeQMfZwF/o3/QCVwO
         HNDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBYTSlW+CzN2qgNezHcC/t9GGZRopOz/xRV+73tGRAXUw/zUuMaK1QMAPqee/HOFDCTemkUQg6TrsgPk0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMRnixsqhGbBP66UI903jGHWCnt/mdDiw53L67zk7lsaKL6OnG
	2xhOFkE5D5fYqagcoqaLb3EdQbKiYHcE6rUiH4FS//lRliK7RUtbdhuBzZFgPOjhn+z2UaJvBBf
	JMiKkVQ==
X-Google-Smtp-Source: AGHT+IEDZ37DkMt6s0xwoVnx5Qc3MmUwVj3yXC0V3R7p+RMPNg9WUZHCFkp1OfqIxCh3LV7U3y3jFq6pf9fH
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:5d42:c43e:5e08:3a85])
 (user=irogers job=sendgmr) by 2002:a25:b311:0:b0:e2e:2c0c:d02b with SMTP id
 3f1490d57ef6-e3087c261c6mr223276.11.1729884083287; Fri, 25 Oct 2024 12:21:23
 -0700 (PDT)
Date: Fri, 25 Oct 2024 12:21:03 -0700
In-Reply-To: <20241025192109.132482-1-irogers@google.com>
Message-Id: <20241025192109.132482-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241025192109.132482-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v5 04/10] perf test: Avoid list test blocking on writing to stdout
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Michael Petlan <mpetlan@redhat.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Python's json.tool will output the input json to stdout. Redirect to
/dev/null to avoid blocking on stdout writes.

Tested-by: James Clark <james.clark@linaro.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/list.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/list.sh b/tools/perf/tests/shell/list.sh
index 8a868ae64560..76a9846cff22 100755
--- a/tools/perf/tests/shell/list.sh
+++ b/tools/perf/tests/shell/list.sh
@@ -24,8 +24,11 @@ trap trap_cleanup EXIT TERM INT
 
 test_list_json() {
   echo "Json output test"
+  # Generate perf list json output into list_output file.
   perf list -j -o "${list_output}"
-  $PYTHON -m json.tool "${list_output}"
+  # Validate the json using python, redirect the json copy to /dev/null as
+  # otherwise the test may block writing to stdout.
+  $PYTHON -m json.tool "${list_output}" /dev/null
   echo "Json output test [Success]"
 }
 
-- 
2.47.0.163.g1226f6d8fa-goog


