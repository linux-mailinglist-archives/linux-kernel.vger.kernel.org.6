Return-Path: <linux-kernel+bounces-425696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BE19DE938
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 16:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 525AC16351C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 15:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BDD1448DC;
	Fri, 29 Nov 2024 15:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dapkp6r3"
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80B113D62B
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 15:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732893602; cv=none; b=q/hjzub3NS0DRsyGMCaPiiKxG+CQyAq9S12ddXoC00bPaFCgEQSz40j5cAFYYabhcAs90b+UjGobo8iYIGx/zo1ic7y6cOpSxQKsd7GEKZWZgnThsTMqsDASEQ87+Npj2vvQdkDbvtxG7FrkfSHiv03TkQ1wYM4efFC1YcJ0keI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732893602; c=relaxed/simple;
	bh=CMYWT8dIX35tNfFWbz9ergTz/YOtGfMHI27ElIBN0ZM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=T/5yzYbmct9+cBPLR6CB4sWnFfxvAgsDCPbLPmNz7rv5r/BEgtOSiwnYHOHkdIauJyBn/C9FFubp0FIOGJKX2Cgv4rNxTKRrES5zboSTMzbMseRWyixPiCfIqTxodKVITsiTUfnKns5BXnUC17xxYLF09yYrNCnTBnm4cZHZVz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--matthewlavine.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dapkp6r3; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--matthewlavine.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-6d8881bd39fso6696366d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 07:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732893600; x=1733498400; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qFDJyQs894rf7BwqzapyU7ku8M+gWJhB3Sx+miz/FUw=;
        b=Dapkp6r3/V5/eh8IHJMmWLZpolSED4PzAwCywyDuMat4a+DvRjhYDH6YFPwFFGPYZ5
         ZrXqjKvgEtjAUgz3CR46P8B0hr6T5XOm9/vl8xLOEvPfdC5L4cNu5bfoRor5tTycboRn
         wwvgkMujNkok4eyvAebROhNcHbn94eCHyOTlZT7xn+Dwn9Gw6YMHDX0PCE28QKRuWvcQ
         jl4Lfq04WxiyztMFF19ZCEYiMEUXGJhj+FDIZ3dvoiYqmTqdX7lZ8Q/J/OuwUKrEXHir
         otbGWaNtIlrQIxXMsMJP0ZmddD26XteqZTQrs9vTef2YRpPEwGJkwGnrO+Ft47WTa+WN
         IdMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732893600; x=1733498400;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qFDJyQs894rf7BwqzapyU7ku8M+gWJhB3Sx+miz/FUw=;
        b=atR5s21uMWVnHzm6b8rnvz3vAUNrz9w+IvtJofWqqQ90UcOI46t01pmWNJ2e0q8Pic
         RpvFKQkkqmSySGWntsS4Y1pBxorICdjtGzENm4qJPkpoNjPbCLmyp2gowlg5RUx/eZO/
         WS4HJhUci6Wv4YyDg+Zki2f91/e7tEUz9NCnPq9jrUep6QtZ+kuJJVee3ewAnU7bbmzh
         sPiH/DbQlWopTevcmoWAVskaRIS1CHeK0xSrRee9yp906t5WbnW0Hk4g9kJYxcD1jHjc
         nvmKQRFQNHrn5RUT5Qy86sX3136CGjvg1FkxsMT+yGXpys2kREDIwnlupIVUxx8aYaNE
         TA8w==
X-Gm-Message-State: AOJu0Yy9ON9ogvA2FBk4PUMV12jqGW+o3X7BGjQ4fkihFa31n9qRiBjf
	PTBOXFk/BaNJ8jaLb+OyFQN+cPUS9BPHC9hR5Wz/ftrqlfJ/rKO6dlHKJhy2wwD9KRdqD4o6P77
	9odz79Ce2DD9L9NPZ7BOh9uS7n2ZCIQ==
X-Google-Smtp-Source: AGHT+IEHA62xKJzhBnQJx6qb0cUmf/GcgklJ2cCAx/e9cH58ybVjx7+XoJVwYFPc13Lwa95f0tBDMO0gLICCNyOsCjHY
X-Received: from qvbrh24.prod.google.com ([2002:a05:6214:4f18:b0:6d1:7549:7dbc])
 (user=matthewlavine job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:2424:b0:6d3:65ad:5cf9 with SMTP id 6a1803df08f44-6d864d26aebmr153786686d6.15.1732893599699;
 Fri, 29 Nov 2024 07:19:59 -0800 (PST)
Date: Fri, 29 Nov 2024 10:19:16 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241129151916.583133-1-matthewlavine@google.com>
Subject: [PATCH] sched: fixed a spaces/tabs coding style issue
From: Matthew Lavine <matthewlavine@google.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org, Matthew Lavine <matt@matthewlavine.net>, 
	Matthew Lavine <matthewlavine@google.com>
Content-Type: text/plain; charset="UTF-8"

Fixed a coding style issue.

Signed-off-by: Matthew Lavine <matthewlavine@google.com>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 95e40895a519..1d0c639b3e09 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10142,7 +10142,7 @@ const u32 sched_prio_to_wmult[40] = {
 
 void call_trace_sched_update_nr_running(struct rq *rq, int count)
 {
-        trace_sched_update_nr_running_tp(rq, count);
+	trace_sched_update_nr_running_tp(rq, count);
 }
 
 #ifdef CONFIG_SCHED_MM_CID
-- 
2.47.0.338.g60cca15819-goog


