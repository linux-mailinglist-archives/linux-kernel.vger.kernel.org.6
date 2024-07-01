Return-Path: <linux-kernel+bounces-235597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB1C91D72A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 06:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 280CB286CA3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 04:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B657036AF5;
	Mon,  1 Jul 2024 04:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p1JGeSid"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94091B809
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 04:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719808962; cv=none; b=iM5Y58Q1MnDGhrY8BHSFIQ8WYTxs869JTvomBbIP5QRcPPyGpqOHuHudKCGTyvsvRl65dzDlq1YkT/bF7eXZQcdYAv7RSQ8/vue/KBmum8/TpS43coZUx37G/3QuO5ZAakwer1rfBpQ5fKzzOI2j6ADXLhgXYb4PRR6SfM112Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719808962; c=relaxed/simple;
	bh=f17c88A26NZskfgiFXDQMND/t9HuKkVv+EOcHsvscrQ=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=c3FTWXAD0eOd/6ZwgTjR0pYf2vvWc31Rs3ZF62aYXZv3DHbHyQVx+dxit9dYLJKq5JYQq7V3jVwoLB+Zf+MPd12Ebfsgx5eqi2bpgKcnoAJln0HOcTZvKPqP8OeALVYwssiPTk7HdormnPwZDoo+n3BMhUZkGsXJg9X4Eej44So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p1JGeSid; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-62d054b1ceeso46004267b3.2
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 21:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719808959; x=1720413759; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ja0X0aEX+OPc1UcZxy/m1jTtUBMOJm0IX9nvA6gMdVk=;
        b=p1JGeSidvIsJa6T/EhjB31zVmImik86Y/pTsH5zX7NseWNpomJQ/eOGKF4ctC+gafp
         a8mIBIb25MXEeDW5bnUL0uT1pceQzVk5iuFzSD6fIxuu5SRq2bAhGJ0N0tsJHg2+8Ms5
         LeLoucuolnGauCV4oXv/Kv6IwxlIpMK9YVJ9WZiQZiYBoUtvcen/IBE96zNff9FzE4Bu
         Ugr2Pi3C2Px8SdVFXnTzoKcPZWFLalfhgJ2Dz9akAOB9E5qVO6raUTu/j3VsnKikmzD7
         lhXSj1TXGmn+Yap4nP6shGP1nz8gWnTAWoEoXEETyVb8icMydCXBHvpXJUKX3qjn875T
         dNAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719808959; x=1720413759;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ja0X0aEX+OPc1UcZxy/m1jTtUBMOJm0IX9nvA6gMdVk=;
        b=n6Am17auFimPYfSzaSA2lHQY71j7SDszDLo1+74xhqtmD7KZ9eMwby1LWusAkZsrlN
         8fQabDMeFPeqhLk5lDFfON6gEkTIr1KcpFwkJYy4nnU8kjX8vVYBqh2l6SrKHshG+ftL
         rY8uSroXzdrvV+5aWy7qK5Q5rmgfK5vXjP1SX50qm2+COp09YqdoazLo89hJcDV1PHVv
         WKqauQ1tpZbMpcdPE65YNmj1cBaU7Vn0+7OZwull5t6CE5KHXKxowpCRxr+zVObpj2qD
         pORK+GTCwwUpXbL7NNvJwOSQXCELUs5Hff83yQlDLSRMfOZH33on8XGF5xO5QJNugKYR
         VbiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWRfu4MNEjHU+Fez+rZdZ/MkGo5I5tsJkmo9h4ZpkwmxeOGEBSGwvlqwEJ8NaWm+UaFxRShx23UeE9L7Xpgcd1FW64LLQ1nA2M849S
X-Gm-Message-State: AOJu0Ywxx3yAIomWNsAOSLzha5VULMxZ/kr0p7Qxl8rHjlU0Yi0ao6SR
	vqksyBUfX9tlUQJbjsIqVDLj0ykJ5NNiawNGxALkWoivBfxPgIImFDmu7uwQGN1SYTMKWR7xEWb
	znS9ASg==
X-Google-Smtp-Source: AGHT+IFxobfPLI+HYKOSGevXm/fFjBZH1Ej99MSAQeEXdFzOTyUxD8UDyMe878XEaCetpI4+dWDCHii3+Md/
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7bcd:6ae9:263e:82ff])
 (user=irogers job=sendgmr) by 2002:a05:6902:2d45:b0:e02:e1c7:6943 with SMTP
 id 3f1490d57ef6-e036ec43f15mr9180276.12.1719808959578; Sun, 30 Jun 2024
 21:42:39 -0700 (PDT)
Date: Sun, 30 Jun 2024 21:42:34 -0700
Message-Id: <20240701044236.475098-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Subject: [PATCH v2 0/2] perf test: Display remaining tests while waiting
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The v1 patch series:
https://lore.kernel.org/lkml/20240405070931.1231245-1-irogers@google.com/
was partially merged. The check_if_command_finished wasn't working as
intended as stdout/stderr could be lost due to waitpid being
called. Modify this function to not use waitpid and use procfs
instead.

Keeping the output test display logic in 1 place should simplify
improving parallel and sequential output. Namhyung was experiencing
issues with this in:
https://lore.kernel.org/lkml/20240628215751.1512250-1-namhyung@kernel.org/

Ian Rogers (2):
  tools subcmd: Add non-waitpid check_if_command_finished()
  perf test: Display number of remaining tests

 tools/lib/subcmd/run-command.c  | 33 ++++++++++++++
 tools/perf/tests/builtin-test.c | 77 ++++++++++++++++++++++-----------
 tools/perf/util/color.h         |  1 +
 3 files changed, 86 insertions(+), 25 deletions(-)

-- 
2.45.2.803.g4e1b14247a-goog


