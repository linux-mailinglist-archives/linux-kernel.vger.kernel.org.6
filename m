Return-Path: <linux-kernel+bounces-319652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A7D970023
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 07:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2B24B2478A
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 05:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB921459F6;
	Sat,  7 Sep 2024 05:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="clrmrY5u"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FBF13D53A
	for <linux-kernel@vger.kernel.org>; Sat,  7 Sep 2024 05:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725685757; cv=none; b=jHHfrS/OK2TUayngB3oc4iVDpR96rXUaeuA5q6jAcyGopKsFCWbTnqkBqhSM3cYBaltaDod47fciLlt1lQ3Ofm3wp+G+yNDeEqf/kq944xXl5BJYFY55JYm5Q4VMJvjLbpPH28is67/3dRtPV6BFM2ElIJhUCgI3NtHyWkDI8+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725685757; c=relaxed/simple;
	bh=BXv09/LFN1ICQHkKACTJrUA/ZU2WzDzFV1Km970Ic/A=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=h708arfwl+uiq6TBdSY9FpLuiwpkNHbg2nVG2i8S3sr9tZm9eRMORQ95mFu/Xi2ekvtCIQ1/G/p0XArKTZZAC4ir+osI88IViDYWNl5HT4zwpmqtPSCw9iMjKgXxcG2bbZ6llqkwbwchWYRbOImeFuF+jz9PNtG7gJdUbLRkNeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=clrmrY5u; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6d5dd6d28c2so90706447b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 22:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725685754; x=1726290554; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hstFZECCLUDlqUcYiOTZJguGTSu2dQsvz/r164qnMpE=;
        b=clrmrY5uMU4j+GBargyQroPiXTxQQrYigJcFWYUmjtdzSmtnwDdlTdYrBHaWBXy9sr
         xvNIhDTsybmZhw86N4fJGqM5KmOE/+/h4WE3G+9/USkUq9XXLUcnRAGHrrFkGntHz7FY
         CrrAuQ4Ee9vRRR2hMZIrZXLJBQyRAwF43OINtkFjV8B7NI3hv95baejt1nui8q2IMvG5
         PRzsz3NS52Kz3PxP9i86pY/DWa/e5FFW/4YP8RuVVYdlg0K4jYMCS7bkh7pPu6ZHXv4t
         mWkmV18qu6m6FuTsmKBerYuyMLbVhOGXw95qjlEHxnf1vZ7TgZsWRTp/AY/16P9dvfLe
         Uu0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725685754; x=1726290554;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hstFZECCLUDlqUcYiOTZJguGTSu2dQsvz/r164qnMpE=;
        b=rGD3DldaFvAW8URVyYiAoeP2EAFq6jTKnGMVI3LfHvrLONOT5x34N/dNL1aYfzHEPx
         pRz73Cs7/NaL2s0nYP1N2EqtSkYTBzqxq23eEWjZggsczDDEy4/XaLe7yGbh8/pTDJBR
         I//ORwFenWD2C7zJ5Q5j6DJc0g+1O+3DS4RtbrTiB3pFlN6b9o/ghQQ9bIL3fxHrQKoq
         wb6ei/VeosRI+6EGNsTCuQPght2anTHXBrQLNqW/ZWpN9Vv2YQtIhsdhz4j6Wu5tZ4o0
         v0/EfslMq29M7nOj2naoLLHbIdoXy67weqREBsBCTMMY7UuJDh+qsto0bH1Ijlwhy2zY
         A3Tg==
X-Forwarded-Encrypted: i=1; AJvYcCW7DD+XMVSguK2VrwiUbRpRm5na5PtBih0yIbZwVVkTWu9VFKFDMkRdXMtVgpjwQ9LXXY03me5R/uHt66w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze4hchXUFd18viZ8nXBK/dG691kDbQxJEdmm+nUgeJkWS7e4Pm
	J2zq8jRhVKnWP5/LE6A5KwbpzIuZozyptlMq+J645x8OLs7uhKT1erLhW+L3k4mkQ57NwbAS7Lr
	S3hmStg==
X-Google-Smtp-Source: AGHT+IG5oJaUZYWopcDEnnIXdYJhIy/sCSeitouQEpUX7tKbh+Ek6ySPDIWgZ4WxN7Y8NudRskSnJjYF+jnj
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:90e5:a813:c3d3:daed])
 (user=irogers job=sendgmr) by 2002:a05:690c:ed6:b0:6b2:7ff8:ca3 with SMTP id
 00721157ae682-6db4512bbbfmr2038657b3.4.1725685754616; Fri, 06 Sep 2024
 22:09:14 -0700 (PDT)
Date: Fri,  6 Sep 2024 22:08:30 -0700
In-Reply-To: <20240907050830.6752-1-irogers@google.com>
Message-Id: <20240907050830.6752-16-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240907050830.6752-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Subject: [PATCH v1 15/15] perf docs: Document tool and hwmon events
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

Add a few paragraphs on tool and hwmon events.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-list.txt | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
index dea005410ec0..7e3cd6c5e35d 100644
--- a/tools/perf/Documentation/perf-list.txt
+++ b/tools/perf/Documentation/perf-list.txt
@@ -243,6 +243,21 @@ For accessing trace point events perf needs to have read access to
 /sys/kernel/tracing, even when perf_event_paranoid is in a relaxed
 setting.
 
+TOOL/HWMON EVENTS
+-----------------
+
+Some events don't have an associated PMU instead reading values
+available to software without perf_event_open. As these events don't
+support sampling they can only really be read by tools like perf stat.
+
+Tool events provide times and certain system parameters. Examples
+include duration_time, user_time, system_time and num_cpus_online.
+
+Hwmon events provide easy access to hwmon sysfs data typically in
+/sys/class/hwmon. This information includes temperatures, fan speeds
+and energy usage.
+
+
 TRACING
 -------
 
-- 
2.46.0.469.g59c65b2a67-goog


