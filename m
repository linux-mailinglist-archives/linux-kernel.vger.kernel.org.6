Return-Path: <linux-kernel+bounces-360685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B057999E0A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 09:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E35CB21B19
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 07:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D3C209F51;
	Fri, 11 Oct 2024 07:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XECGUSDc"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F9C20B1EF
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 07:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728632185; cv=none; b=i8U9U7yE2hd0v0W07ZBVWhrR5AnuII0mq9ajOnDt7h8HmlJXby4PyY3aLCrlXJyzw5IGmoRm9ynHWgfkvkdD6oWncJZtmDwQFchBSquWwbm0K7giHC3vfiQgZv3SLZwJOqHKR8RQTvG7LtDjYQeUT8U3dSbG0VRfIlInJSn3q8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728632185; c=relaxed/simple;
	bh=JuqmInDNCF0j1qi7X8VY+IRMQTve1+ETPqQ3Y60nnhA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=FWuNGvBlZLFs4kwfo0n4X1ng/0jcMXD/mCDHl96b90cR6HBQQF6aZhQneLPE4E/2iiUtq3RChBLhl2OPXe1vTwmmVIVoytI66BYH/SkX8SpB73aVomAjtI8CVJlCW+nEwq/A1/rDCD+JXUHXPAUcSB5wOca/L5A+HvpsenvCMaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XECGUSDc; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e1fbe2a6b1so32159477b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 00:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728632183; x=1729236983; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h1RDoAb7ubYjo7SH/MUMAZWwf1Fgw9lZgxpoFFh96f4=;
        b=XECGUSDcKH6N8BU/D68R30ZD8DXcqX6UVk1jaioffmgJUn+/YwVry+XOhwqyBCw9Qy
         T9lkglx8s3v37tQw2LmjbsIGWlIbOgYyrAXpMZhoEmPDXS2TQiiBItvqvWAk7+GeuQQm
         eH3WYfZdESAdyVuSPX7lg214IEOfKXuG1BfkYGoQb7+S78lmmAlvMhILzpeyGTZXeQWG
         IAElI+Jq9upgqZCda/psCuaozUr8n17IZFRjbbqQ23duA9QG3zCFXHTCVWB3vbHkWkal
         DIKBVu5FrXaikicbTz1787SjGNArOuZEkSFeZ5YoYZxkRfHozBirHGSdzLmsnA0ZVdDa
         N8HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728632183; x=1729236983;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h1RDoAb7ubYjo7SH/MUMAZWwf1Fgw9lZgxpoFFh96f4=;
        b=DLtJPCWhV+a8spIyauqtmT4P7oOkmKwyK/JfN4AqCzq+IzPSFMY8yTus2XJHwiKqyS
         PEJjtkNdrbzvj6Gf8y7vx8nzL2PPPN9sC71tNKJvWKDIcHD31iIrsquxAvoBjUzJyMQ9
         TLU+XRTi/FnGiyl5NN1TQaPZQWqdMzpM3YQUccBchqZKm39cS1owTYbkzZOWElLLxup2
         X7JJ0hhnG+2VKJrOR16DP7pFHebsmkl/g8Z29RK/HKEcQzC7/xoZFJF6pFjDpuSa4AdT
         rvIUhm11F6qyY0BGfmXkvcPsYZ0wdMH3qZ+meRvQ6+Bfm6WbaSuQ85kL7FKG+VW0Ekvb
         4inw==
X-Forwarded-Encrypted: i=1; AJvYcCUkj2ho5pp2Ze/uaNJTHRlAFAoZu/wGPvGV3nYguFBzuU76PtwgBvWqXrRpOJ5HEhWhpc3jPeSFN90ZJCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU+G46q0bvOb843KO+n/tv54wcQRc/K7zMAoG6++0Iqbiw4R1+
	tMMrYe0YRR8KAewsGMNcjHfMVVnFT8qA2bIeIlYm5bY9abXtaWmryByVTM/+gFxVhEZ1hgva1t7
	XXuCnCw==
X-Google-Smtp-Source: AGHT+IEU5guu/3Lk+woHIE6L9NJ5fVlRdYN3CeRTj1h03zL1dcCIN4gq5f88dhPrvr+ImWXEtantlftK84yf
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8144:56f:2e1e:4db])
 (user=irogers job=sendgmr) by 2002:a05:690c:6d8f:b0:6e3:21cf:a67f with SMTP
 id 00721157ae682-6e347c76847mr857467b3.7.1728632182799; Fri, 11 Oct 2024
 00:36:22 -0700 (PDT)
Date: Fri, 11 Oct 2024 00:35:55 -0700
In-Reply-To: <20241011073559.431302-1-irogers@google.com>
Message-Id: <20241011073559.431302-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241011073559.431302-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Subject: [PATCH v1 4/8] perf test: Avoid list test blocking on writing to stdout
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
2.47.0.rc1.288.g06298d1525-goog


