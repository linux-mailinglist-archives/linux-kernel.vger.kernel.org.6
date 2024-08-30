Return-Path: <linux-kernel+bounces-309568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC00966CE5
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 01:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0627B2302D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 23:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B4D1917F1;
	Fri, 30 Aug 2024 23:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lk4VnZKU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55EF18FDB9
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 23:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725060553; cv=none; b=IOePOgWRM1z8GFy66t7Y8IRvSU/yFCp/35Te8i+mFFm0i6OVKSk0IpNaC3KBN7q1ARaBq4acH2A1Xp8Ybed/C26AzHZylxtRhXPijDKYTFHfmKp4YQi0yqK85DsN7KrPTeSmi+Kx828wlgWIT/NjBiZDmxlcX4DvArzenCFXS4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725060553; c=relaxed/simple;
	bh=prH0/SeaSKC9p22Ln6Tcjz4jujhD5pDE9JLweDDsE+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZFrW0e1NGEVqAMn7pFUuWdXd3LT7CekOxoq60ZLFjcrCHN+TbqjiJoVx3f78gF4UnsDqqc02TlR6BVVlEwnigEf71b5oRk70GsNIK2KFClsT1QhcSPus2P8gkCDEVU6yafz3uyw6PPNjkQctmdqYS0tHxurQkXiLX631cUrs8nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lk4VnZKU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC94BC4CECA;
	Fri, 30 Aug 2024 23:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725060553;
	bh=prH0/SeaSKC9p22Ln6Tcjz4jujhD5pDE9JLweDDsE+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lk4VnZKUIeNyGC2mJNoDVRkWUWyNRvRpH0MCIBhg57cokFqXiZAXf9dG6VeOYG+Sj
	 si/jD+B/YWvSqot4QSVjfHapkyXX2xTGyqNStpyM70wKWGI25tI3BGs43kSXmufTD2
	 BAOlINdpc/26xP2/+I4+YnD/pdqTI3zKqQfBZtnYa472/5gphyUj+DT0wwH25nHZ4W
	 1WdkGZmokHDaA2yHS5PP+NbPrKMF4LbtuP8E2qsWB9lXEXHj5ltD0vJjQWLdIlStpi
	 /4/C21ywBUZHp+pe4mtuallsEorKhFg4BSDM9qFwK/D0qwIkD8elpHydrjKw88ECUa
	 aTKGF+EsT6iUA==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Stephane Eranian <eranian@google.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>
Subject: [RFC/PATCH 3/4] perf/core: Account dropped samples from BPF
Date: Fri, 30 Aug 2024 16:29:09 -0700
Message-ID: <20240830232910.1839548-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
In-Reply-To: <20240830232910.1839548-1-namhyung@kernel.org>
References: <20240830232910.1839548-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Like in the software events, the BPF overflow handler can drop samples
by returning 0.  Let's count the dropped samples here too.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 kernel/events/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 8250e76f6335..ba1f6b51ea26 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9808,8 +9808,10 @@ static int __perf_event_overflow(struct perf_event *event,
 
 	ret = __perf_event_account_interrupt(event, throttle);
 
-	if (event->prog && !bpf_overflow_handler(event, data, regs))
+	if (event->prog && !bpf_overflow_handler(event, data, regs)) {
+		atomic64_inc(&event->dropped_samples);
 		return ret;
+	}
 
 	/*
 	 * XXX event_limit might not quite work as expected on inherited
-- 
2.46.0.469.g59c65b2a67-goog


