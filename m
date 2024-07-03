Return-Path: <linux-kernel+bounces-239932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 678969266F8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 19:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 987631C22134
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 17:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC74F1849CF;
	Wed,  3 Jul 2024 17:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OD9XWGHh"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9763518308A
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 17:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720027287; cv=none; b=TtPOtR5wv/VO4atEeGP/IWGDjp7m1+sJQfk03GOW50KLCJJHx432Z6oz3mWwjGrI2t7vdBG/T9fpke4b6fHm0ZrhZdYjdSvezTbeRz8Dy3XdHixAWe+FQu1AKRRUf+l3T4/bnhXOMaT2R3M30orXyP8qZmFodFBWKxvLQDf6h7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720027287; c=relaxed/simple;
	bh=XSLtNpQyYpFfkguGPVVIRjjiBCkd6K/LCJ4NTdjR/E8=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=MGXIMXryeP5gF+TJ6TANgiz2qlq5sEOnkGFLRL47nKRVPTv+DofJf23MFHLw8ectBHBKN71L5wFh5cAS7bClsulg1TT+bGRT4q23IFs0kvtEFTfKZCSNfdXtTZjRypgk8r+pxoO0Xgd50JesajmqLVlOrAlteOxLirr1ANJ+PgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OD9XWGHh; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6502e4c5aafso9078887b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 10:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720027284; x=1720632084; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=O6DICyukWO//hDnJTxN/2aPKt92AdYPiZHqQbb+7vPI=;
        b=OD9XWGHhhMPHEVGWrmlRhfoDbz7rSOnPRMDu9h3+lvu12+COAXXiDah5k3ggnG3kW7
         YoZhA7q4qMmmPDZJ3Z6NGsoJa/NYH+k1Ntp+RUWjUE70h0wqpX5++riCEoH/WS+XWQwV
         Qy5eDfwhOqbYAN5ZUjFP1GP34R0gtUShemRnbp5Td21ukDB25ogv4LFIC+DbXQ90Qlb8
         AMr43m0dQSBgJQLCVIexCy1DKRiu8b9SgQ843XRfqsrb1jvYhxvjTIN9oafE7XuNXet/
         YSjGbPN7JxeQ3ES9j5HqmYeqQYy08Nf9kE1opxJs+X9sVPY1ma+Xt8cdA3M7oVZKLVFU
         4fYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720027284; x=1720632084;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O6DICyukWO//hDnJTxN/2aPKt92AdYPiZHqQbb+7vPI=;
        b=oYUr/vm84Nu64gNSOUmyMNZ7fQye8vAguXr9O+ezw2+pF+y0TnBToeb21lY9bEwQd9
         6eOqW4S/5P5fj79qAeGOH317h9oOzH2azeUB3oOoeWUw0kCsBIQCqcuojcQ76r7seFhZ
         /TcFa7yBbIxcHJGGYVQb0+34vmBFPVUTX6la7NQ/6tPE5mV3Lw+EPLYcr3cFugQKf/VV
         CMQ51uVl0DEC2EQ2/5NrAyz9bWhihfzDjzCpA5aN7BHRbUY0U+9FK2GDC15uxjz6VPNQ
         NpAAZBQEvvva3L1YCIypoTnHcNv3eURlkKMU3m95LMuaMX0V02SU278bZPmdewECqsfe
         hWdg==
X-Forwarded-Encrypted: i=1; AJvYcCVxJ+lmO+h8tI2UkPMe0HPOBoH2RTgiAedSWDuJsojtB4Ki9muzuiW4VvMxIbyjTjjjIXEG9AaekF5SAlQALF3lYS22BhZ79PEsxso+
X-Gm-Message-State: AOJu0Yz644UGw7lnpYlB8MvXodbb97Ay3RdclsJgTInqzek/t79m441N
	MXypnoHi1/SxnNsMSOvQppaPtevfMwM93stFbYZveM1dsvk9FPBonSO8VD8zc4gTyRsTxXMW/ZK
	fWu+vkg==
X-Google-Smtp-Source: AGHT+IGv2CIYh9To76MKX40LCNyELwQzrEHoDJAI0BU1AT3bkehsbRkH7SSJrQqkR9ENVbfP0BoApbYrhh6S
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bdc2:f28d:3877:f0f2])
 (user=irogers job=sendgmr) by 2002:a05:690c:c0a:b0:618:5009:cb71 with SMTP id
 00721157ae682-651818f0323mr197937b3.5.1720027284599; Wed, 03 Jul 2024
 10:21:24 -0700 (PDT)
Date: Wed,  3 Jul 2024 10:21:15 -0700
Message-Id: <20240703172117.810918-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Subject: [PATCH v1 0/2] Try to avoid some qsorts
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Steinar Gunderson <sesse@google.com>, Matt Fleming <matt@readmodwrite.com>
Content-Type: text/plain; charset="UTF-8"

Reference count checking doesn't work well with rbtree due to the need
for counts on each child and parent edge. As such the reference count
checking changes removed rbtree and replaced them with sorted
arrays. There have been instances where sorting has been shown to be a
regression:
https://lore.kernel.org/lkml/20240521165109.708593-1-irogers@google.com/

These patches address a further 2 cases in comm and dsos, avoiding a
sort when the array is already sorted at the cost of an O(n) memmove.

Ian Rogers (2):
  perf comm str: Avoid sort during insert
  perf dsos: When adding a dso into sorted dsos maintain the sort order

 tools/perf/util/comm.c | 29 ++++++++++++++++++-----------
 tools/perf/util/dsos.c | 26 +++++++++++++++++++++-----
 2 files changed, 39 insertions(+), 16 deletions(-)

-- 
2.45.2.803.g4e1b14247a-goog


