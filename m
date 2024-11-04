Return-Path: <linux-kernel+bounces-394982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 870F29BB6DB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 14:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BFD5281106
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 13:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F0F13B5B6;
	Mon,  4 Nov 2024 13:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Kz2em2KZ"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871F680604
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 13:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730728613; cv=none; b=L2zDmTeIde6ACq3pZXhlFDPMLX4x0EzPAxeJBZ2/urIeefen+Hal2bKo9WyIL7KUM6oDscYGwrM0ZCBDxk40MEcoTQDN9ARo3DaHW2O8Dvy53ssqwDt54fEBvnMcPG4ylQOjO/q7NErUpBEM8E4O/UwPfnszoQNLdaQ0RyeqdaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730728613; c=relaxed/simple;
	bh=zHW9YD/7eCMYa7LphcqJ8mN3Pu/mfIaMT5CflNBlLkc=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=N4VIo/HKlHAXt9XijC+n6YMbo9uim9fE7EECa/SnKFozxQkxyPmIwKrxUxgIPDNh4LcF3l2YAkbNDmqfoC+oBvXQ76OIMX4sGlpkCft4MRb4+GsH/6xPx/ydlWcwqEuwCxBFhtHN3muaU3y0lTobW4/eUvUKWFeBj3jLOT4MhMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Kz2em2KZ; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=/vlR3uasMyZRU/KR1NVUFXjOc/3IK9Q+9c2ECYAL0lk=; b=Kz2em2KZMiWJTP402faGvVxZ3H
	ND6yufTmbIJZJ6MP+8bu1tGLEC7O6ermUBTKvR9Kkc5jZ/svdelykHEPl7FkQY1CbLSzckzPM+lCo
	NxM85D1komGWlzR9fPiMD8WtYvl1/yKrzF1Dnk4iBKiAGv2LAxOpol8Kcrry3P49Fy/hw5JwN0Zmv
	g+CCzJFAiPGWOMdjwYPQlX9SokPwLMqMQwOiHl3Bar2AQh/awFL6f+b76J4W/nLNuZnNQe0zfEG8R
	PCLavjGtf+ZPzAgopDEEaU2DV85MAoGG9WutfTrvumK6HcWnY8Q5zgW9VnpFNKHNQ3dmYX0djBKCk
	tboX5oKA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t7xZY-0000000BL8D-0ca1;
	Mon, 04 Nov 2024 13:56:48 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 831E6308CC9; Mon,  4 Nov 2024 14:56:46 +0100 (CET)
Message-Id: <20241104135518.978956692@infradead.org>
User-Agent: quilt/0.65
Date: Mon, 04 Nov 2024 14:39:22 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org,
 lucas.demarchi@intel.com
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 willy@infradead.org,
 acme@kernel.org,
 namhyung@kernel.org,
 mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com,
 jolsa@kernel.org,
 irogers@google.com,
 adrian.hunter@intel.com,
 kan.liang@linux.intel.com
Subject: [PATCH 13/19] perf: Robustify perf_event_free_bpf_prog()
References: <20241104133909.669111662@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Ensure perf_event_free_bpf_prog() is safe to call a second time;
notably without making any references to event->pmu when there is no
prog left.

XXX perf_event_detach_bpf_prog() might leave a stale event->prog

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/core.c |   19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10782,6 +10781,9 @@ int perf_event_set_bpf_prog(struct perf_
 
 void perf_event_free_bpf_prog(struct perf_event *event)
 {
+	if (!event->prog)
+		return;
+
 	if (!perf_event_is_tracing(event)) {
 		perf_event_free_bpf_handler(event);
 		return;



