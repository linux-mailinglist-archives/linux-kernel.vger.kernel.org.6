Return-Path: <linux-kernel+bounces-319638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C71970016
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 07:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E3A31F21943
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 05:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8F985956;
	Sat,  7 Sep 2024 05:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xHNgr0SV"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB045025E
	for <linux-kernel@vger.kernel.org>; Sat,  7 Sep 2024 05:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725685725; cv=none; b=J10LlRtANr/UQ4Rz5vjUUvIntb0ItCNKgejTqSB686+Mrfrdiov+ajXzZMwN245EK4IsOqVy3Sk9E5rAlRZwSPMNX2upcWpsAZ5cjvTsiCumrKHF210X6vOsY6QC9BnZtNLkA/o5atYHGAb/+Gun+6GdJur15mj2cRbu31OpjEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725685725; c=relaxed/simple;
	bh=GtXRyRAclVPuKyzrz5Y0RxXirN/zDK2r6Wx7Lfe/Aic=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=htZUosPrsr+f1BVJjSIXNnjc0vbXdBpnjoUDk91dvEsqINUTuMKZPUS2YtO5oPBiVZbIwW/xsQEafzdOd0IzoywIw9d5o3j551JHO85v+e1GWA3yjDiKD4izDgcE0CabjER+CEk8myGz71RKv2tHVa9gC76mCWbd0htlllEGuSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xHNgr0SV; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6d4f52a4069so102142907b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 22:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725685723; x=1726290523; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8ApYaFx0+sxUWqA8R+JFTFM43Yl04Vb2u4ryemp0VHs=;
        b=xHNgr0SVPVKyRp865NREJy4AX9c3abPTA1J+ykmhjnLVoEaypehL0I/MVbRD55IHjx
         i+E+NqEUaNR84rWMq70+TqdJ+Nw47i9zfBEKTaNYJ18wzFnFobRgyKv96rmku4G8Xtm/
         WUh5nDhzB79gZ9aIum9NsTmOHpIoi+i/oGRjyZv6T3c7DvfgjjeqqN2OndFR/I71ejKC
         xQ/cCfYfBU0LsWABtJs87iN3KkQCnhRX3APyBZ9u/kNEnARuQ3PUY6EuyLjXVDW21v2f
         xPmPZxnDDMHwoZzAdPsQ3hMlz5wHI6i9ySvFYxz6sbGV+VAJJ2uQOlEYeIhO/IEpRdWo
         a9HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725685723; x=1726290523;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8ApYaFx0+sxUWqA8R+JFTFM43Yl04Vb2u4ryemp0VHs=;
        b=v4+FLxK7gjmgdzQiZ6hsmYs6vTHh+1VoqSjzVUNFx1ZLHRoqXVmhx01z7rkdWBisuB
         KWfE30j4d39+0V1YLRJrGFlfZZhty9Sj7ZQRr0iWRmZsS026Kd7//9qvxDvJ3to8friL
         I5JH0SdTOJ88uaAHI7ZOXRnygiwnQoEAipepUD0ZJpYxCG3ZycjES2kY2UyKyUVN49JU
         SwQY0et2/JX4F5DuGtryZjpJpXIvHqDWISs3ymI/b4jYaHU24yKZJWqqecThiyPFPRIR
         pIaV9YlLqXwEu09VlV9B/Tzlx/GkXu2pOwa4SCjj3Isqabcimbtv24HuR420exzzckf6
         QnRw==
X-Forwarded-Encrypted: i=1; AJvYcCWarQSt+AXnjFkENeddkR2BEGgcEqtLUIKl19qFyFN9GVKKPfIuY7RSKvPisWawLmloQyvZfLyX3HEyU04=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQvPruxbtL094Y5pPnGnf2VqN5ouREf18PcfOwxE8hvNGT6bqZ
	bFNXtDxuvFyiydHv4l5mg+UtZUjsPYFRvUhbx6QKJ3EDXwY6uFp/0+67ta7BNWBdMjux5mJ8RCt
	pRNyILA==
X-Google-Smtp-Source: AGHT+IEP84F/M2rTb3JNZ7bCbxgU/+jIK+b9LqWkHujq8bu5u0u7fEm7frKSL7le+5SzKQ0eekBwy8lqkNNo
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:90e5:a813:c3d3:daed])
 (user=irogers job=sendgmr) by 2002:a05:6902:4d1:b0:e0e:a784:2957 with SMTP id
 3f1490d57ef6-e1d34865f70mr12294276.1.1725685722506; Fri, 06 Sep 2024 22:08:42
 -0700 (PDT)
Date: Fri,  6 Sep 2024 22:08:16 -0700
In-Reply-To: <20240907050830.6752-1-irogers@google.com>
Message-Id: <20240907050830.6752-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240907050830.6752-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Subject: [PATCH v1 01/15] perf list: Avoid potential out of bounds memory read
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Weilin Wang <weilin.wang@intel.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Sandipan Das <sandipan.das@amd.com>, Benjamin Gray <bgray@linux.ibm.com>, 
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>, Howard Chu <howardchu95@gmail.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Yang Jihong <yangjihong@bytedance.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Changbin Du <changbin.du@huawei.com>, Ze Gao <zegao2021@gmail.com>, 
	Andi Kleen <ak@linux.intel.com>, 
	"=?UTF-8?q?Cl=C3=A9ment=20Le=20Goffic?=" <clement.legoffic@foss.st.com>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Junhao He <hejunhao3@huawei.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Yicong Yang <yangyicong@hisilicon.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

If a desc string is 0 length then -1 will be out of bounds, add a
check.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-list.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index 82cb4b1010aa..65b8cba324be 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -173,7 +173,7 @@ static void default_print_event(void *ps, const char *pmu_name, const char *topi
 		if (pmu_name && strcmp(pmu_name, "default_core")) {
 			desc_len = strlen(desc);
 			desc_len = asprintf(&desc_with_unit,
-					    desc[desc_len - 1] != '.'
+					    desc_len > 0 && desc[desc_len - 1] != '.'
 					      ? "%s. Unit: %s" : "%s Unit: %s",
 					    desc, pmu_name);
 		}
-- 
2.46.0.469.g59c65b2a67-goog


