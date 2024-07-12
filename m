Return-Path: <linux-kernel+bounces-251050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4273930035
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 20:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 688E71F2365E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 18:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16CFF176FD6;
	Fri, 12 Jul 2024 18:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3wlSGdx+"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED212178361
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 18:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720807937; cv=none; b=VkwD/IP+7lsscdOO37MNl1nWjO2X2GgQAlmSQi0otIVduCqpwxEezq1JRkJRgjMlTCqnoi3gUAJlWA6aDhX1JjtmHF23CZEDzpnp9cDhp/XXp79zQFTrkJtIhuDZ90oFy2rfJt9COoC4dM9eFjpzPiPAfBZVBOM4Lp/ohEucp+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720807937; c=relaxed/simple;
	bh=LctEg2Je3fRQdJP1aZySQP64dlbQCviuGkAlqwvn5oA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=nWgDg79SzaR/E+FB5/3HxSpOIgqXGE/xvWqBdWzz2HGQDcruuNgwaKXnpTgC7Fh/2uV1mJpT3UofEPLvuTYvFoB5RhoYBvQ2MaaD0k6jzmXCH+U3zG2AUiQyjujoEnzPwXt2451mPVtOxkWYd4Qrh6pQUViTPvuF8iTNpK/2RQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3wlSGdx+; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e03a694ba5aso3598907276.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 11:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720807935; x=1721412735; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AbSFIAjgELn8En/ODTzECP6YTzi/bZUaiF8JxVDqD4U=;
        b=3wlSGdx+VpQbcv2sqOTDUzio+fUQVprQZ7TFarkZI8oyJrTnBW2b3cLbbJJe2QL9ET
         l3oayrKkNPvqQauUIXETTJAKBpq3JrcVpQRJKwzvdJ9m+5YHK8C3Zix+9sNaod7IYqqO
         hF3TscKDO4FAXS+HIb4qLDF5LhMmSTPqgK6x35Lru9mDyl+b/iLWIhQtVvcU2fCy34w4
         S4ykt9PhwkIWu8FAMO/8j3e521uNSKOyKoSgM/deVnchXW3+MEJzHfw6dRdgjNFTA1Lf
         aO6IQoP+tXBhKIkzgBK5EeXEQu5LUXnU/6OrxRDmpfSM/O01UoMxjIPZ8g21RmMB1I9N
         xmXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720807935; x=1721412735;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AbSFIAjgELn8En/ODTzECP6YTzi/bZUaiF8JxVDqD4U=;
        b=J+FT1dQFk9OxKsvnczzU6ISqMsLJiVkyioaquo7ovFd/OD9sySf5ijEuPocr5rYGM8
         TWKjMjfjW3ZnBbfLA5XGg+bgVJG5Wc8VwPVlciJ/p7NUjtODC/dCPwVL+rqLkoSX8fSc
         G/gNZBmgJEtYl/oKti5gemBL9yTexFgPpfGa7ud/kVIavtLgB92yqAQDagmh7Gtrs6iv
         OEbevLXvCd1NOhzVHYmplEFDPx5Xzd4Gm2nAsp2CTJITG/1p0gIcf0BxMOufRlPloSge
         9cMms4qWGwxMDdHa7fgNx7PaaJC28lwW3q0JbrnUBilBkyhz9DbesBeIMe15t2ujrRVD
         wPpw==
X-Forwarded-Encrypted: i=1; AJvYcCUCwcheReD1zQFXYdQiayJ/rtZSrq6EbI1Ca8LExohxc6Mp5dRVuNdiMHJmQ4pq/2Ryxohlq0EfJzS4Oe3R8bnMOv+Q1SHQpymJFZNz
X-Gm-Message-State: AOJu0Yw2inr/mhCXxsWsJakTP4EmhE4W5QvcIUF3H4diIasYgDV4b27K
	TINWDgjqeHenGq8r9mHNkfAQr9GoQLGU6gAQzsrdbrTj673f0QFGkVKADSQzQocyBiYOavk0tfQ
	YPnFAkQ==
X-Google-Smtp-Source: AGHT+IFiaKeWftjlYDypGwGYdX+YIN1A5uSwmAuQjC00TFYkgW3S+YBZZ4Y/Pr7DJjydk0jmQ0Rw6pq2PkQl
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:2e7d:d47a:a0c6:e3b1])
 (user=irogers job=sendgmr) by 2002:a05:6902:274a:b0:e03:2f8e:9d81 with SMTP
 id 3f1490d57ef6-e041af3b67amr54130276.0.1720807934990; Fri, 12 Jul 2024
 11:12:14 -0700 (PDT)
Date: Fri, 12 Jul 2024 11:10:43 -0700
In-Reply-To: <20240712181108.475336-1-irogers@google.com>
Message-Id: <20240712181108.475336-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240712181108.475336-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Subject: [PATCH v5 02/27] perf s390-cpumsf: Remove unused struct
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Nick Terrell <terrelln@fb.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Song Liu <song@kernel.org>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Yanteng Si <siyanteng@loongson.cn>, 
	Sun Haiyong <sunhaiyong@loongson.cn>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

struct s390_cpumsf_synth was likely cargo culted from other auxtrace
examples. It has no users, so remove.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/s390-cpumsf.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tools/perf/util/s390-cpumsf.c b/tools/perf/util/s390-cpumsf.c
index 6fe478b0b61b..4ec583e511af 100644
--- a/tools/perf/util/s390-cpumsf.c
+++ b/tools/perf/util/s390-cpumsf.c
@@ -952,11 +952,6 @@ s390_cpumsf_process_event(struct perf_session *session,
 	return err;
 }
 
-struct s390_cpumsf_synth {
-	struct perf_tool cpumsf_tool;
-	struct perf_session *session;
-};
-
 static int
 s390_cpumsf_process_auxtrace_event(struct perf_session *session,
 				   union perf_event *event __maybe_unused,
-- 
2.45.2.993.g49e7a77208-goog


