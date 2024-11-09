Return-Path: <linux-kernel+bounces-402696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 287BD9C2A92
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 07:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A3F41C2103F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 06:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5A5183CA5;
	Sat,  9 Nov 2024 06:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zB9jMJNo"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6764416C444
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 06:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731133133; cv=none; b=GtHyi79OYKkVGHe2ejaYBN9ICfc0WvZrHntsxJamoVOBRq2DBAjIb/PxtPsHSIhMqM3OjEvTjh1tMhzjCr0FMwunn7A2n5OCsqpC0rBH13X52y2Tk+UQ7Vr+x17ZyiIhQMRXIH2cRuxEHok6fHdop+dk74LPu+UWUgl8yZlakTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731133133; c=relaxed/simple;
	bh=PrI8H7tlGg1LCekPP/1frVMROvXCGUe9rAOwO2eGntE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=G4HxoC3ZvOav9YXPZgdoSXuXPN25GhXDJAcqmTnAsg5XeIuwBnf1fazqUu01kh15uoDn8+wwKwkE7yZv2ltNCRmkP1/lSi+6yW5iHcHIZsrhOOG/kX2AfBl7ttnWLJ5xT1ynG8sTX9idjbf/oYgDljQF1xmqkGfx3Ap5/F95P4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zB9jMJNo; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ea7cfb6e0fso58240847b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 22:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731133131; x=1731737931; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X/OxRvItvp2GcJzeU66usK4CCv3xT9PTSZBKNZI0dSQ=;
        b=zB9jMJNoQpmCmq3Wior8m5mrlLSVakyXwXufV09vVERb2Mcz90vjHZCIXnNDjzt7E6
         EZzXfAuyL21l9Wo51soyoATJePrue6Y81EmN9YKhD72ZT7TlL8+W+kZGWQakU/ChVA2l
         EYKYRTtwCHQChG8w77dRA/fj3iylWS36V3XPPSKlqnA+N02VGUvCMZa+y19C6jNHKsla
         3X9cGHwdUZNDAsf1WzKgi9YiWz/H/O0y8bL8pR8wY2Au3ft54YzJtAPi59W0R6GwRwlQ
         /ZPnFb4UGNNOTY+jMoswMA0uhIMtaAX4SfJi0ARQzEa1QBlw0lMOWL50PBgnzRYiEXvj
         OsWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731133131; x=1731737931;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X/OxRvItvp2GcJzeU66usK4CCv3xT9PTSZBKNZI0dSQ=;
        b=oJK0EIfxhC8V/LIMMbBELUNCUlkflAkHc1mDLtwllrZamzIpxbQSZA5lDdcZk5/EaW
         dXQ+MFEXzwHwMIBi/0mXd5oM0rgMYcBYN+aYwzx5YIjhvDUy8U3rK/bPwF55Z0o5CQhd
         oz26RJyOqbHSt+i5vL1iJfKmKrOQq8NC2biBK+59M/m4PFyMmSUatUjLclWg07MjlJPB
         XtdMUQa9igaGWsW+NpmONehuqiIzyWtQ15AKEqN4c9226uOPonSnm9uNywJYRbI1wIGL
         AgkacS9iEq3Mxmo9Q0oiHBApUugIk8Rz92xXLfgk9Qz/rvlC953kqcAG5iFRBWDVLJ7H
         9YFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtA+iYWLvLehy9zGaK+9n5b/ax6T41hNARd2zs++WOWsaJhiJrqZ+y1tV8EZKg01J1CG5s+PmskGZ06rU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFJcPua8nnn+BZ/zdeyLCeCzRKTCY3abF9QLUURqwR145iwD9D
	pQDyJNiryWhvgKwUaKjNBlbbp55v/wT+GNGSBSdMBkhnJedL07mGXrmrPijxE/OKouamu0VbHsN
	VxFrXAA==
X-Google-Smtp-Source: AGHT+IF9zCEp+SsozjY07KdCJXudhDuS1WnIXH4lCviR6Xwd8Iwv4jVR0d7DV230Wl432lyc/AOOkh4pnxTS
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:acc2:d48f:a998:5915])
 (user=irogers job=sendgmr) by 2002:a05:690c:6084:b0:6dd:bf69:7e06 with SMTP
 id 00721157ae682-6eaddfe59c9mr620837b3.7.1731133131394; Fri, 08 Nov 2024
 22:18:51 -0800 (PST)
Date: Fri,  8 Nov 2024 22:18:00 -0800
In-Reply-To: <20241109061809.811922-1-irogers@google.com>
Message-Id: <20241109061809.811922-14-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241109061809.811922-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Subject: [PATCH v6 13/22] perf intel-pt: Remove stale build comment
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
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Commit 00a263902ac3 ("perf intel-pt: Use shared x86 insn decoder")
removed the use of diff, so remove stale busybox comment.

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/intel-pt-decoder/Build | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/perf/util/intel-pt-decoder/Build b/tools/perf/util/intel-pt-decoder/Build
index f99d150059b9..5b8f0149167d 100644
--- a/tools/perf/util/intel-pt-decoder/Build
+++ b/tools/perf/util/intel-pt-decoder/Build
@@ -7,8 +7,6 @@ $(OUTPUT)util/intel-pt-decoder/inat-tables.c: $(inat_tables_script) $(inat_table
 	$(call rule_mkdir)
 	@$(call echo-cmd,gen)$(AWK) -f $(inat_tables_script) $(inat_tables_maps) > $@ || rm -f $@
 
-# Busybox's diff doesn't have -I, avoid warning in the case
-
 ifeq ($(SRCARCH),x86)
   perf-util-y += inat.o insn.o
 else
-- 
2.47.0.277.g8800431eea-goog


