Return-Path: <linux-kernel+bounces-400723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A89889C116D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 23:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ACEE282A90
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 22:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B92218D61;
	Thu,  7 Nov 2024 22:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d5P4Y+QO"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B5F2170C2
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 22:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731016802; cv=none; b=UdUVA3pOJ8s9U6bLN7asWJ7IcOaYt2O226yw8xqMgY9EB4VSUia3g4naCoe9X8GmKl1cwC7a1lpJJqx3fTg9BIqxBFxzpA/iXbBlFoSInbJYv5kvpHaVVhcEXwD6H60AVTI7jc0RwFJ5v2kvJmVak4wIcv1LyhyVcLGyNMNrJs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731016802; c=relaxed/simple;
	bh=P1YgY9Etxj/vyoCw5UD8iDv/GdrLFEv4Z+3GsKv90/A=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Iqrl1zQRK0OQDRSFILtpGbd3yNKUzVcBlvgOQfXbfU0VdddFeIBjv6/ARRBj3i4nNAmWyURDHxTCTyRmmaJvrgUVFoDdb3k6d5RLwC53emOQwBgx+1JsgeNtXOfsAU5AcrBzkjmuVeBuHjpHuVBYM8pY+JfpJcznIAFRerqekY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d5P4Y+QO; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e32e8436adso20712147b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 14:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731016799; x=1731621599; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gtY+hQlMOB+auZZ9MVGgAKHoK8XC+h0pobgnTF7y3AY=;
        b=d5P4Y+QO5RvDzmdQa5vXLNWz5ESiYyGRSl9lHS5+QXF2AwOF3EE20kBsQaiLrNKwqC
         PnSXQK7Q3fs5CD1xMY0r/ULZ1UQPEDvs8uos/9Etn2pE+QqF5bYtDI9pNMzE4wPwR167
         YcvAxinBAubolICGPoG2xH0ZQF4lPS1I4eex66ZUnMutlQzAODxrm/OyRHu61hLsSY/L
         f+qwK06n3KjVF1MzFHUcnxcLFvzl3rnN8sgG00MTd8H2H/ZhI0P/akz9iuDjRUf8Ho6X
         zTuHt4bCehH+5Hg7Gl3U2yrm8aQjrTCKdfExAq2mK93vnk3agXSsGIVfI4tV66oVdrQD
         X0NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731016799; x=1731621599;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gtY+hQlMOB+auZZ9MVGgAKHoK8XC+h0pobgnTF7y3AY=;
        b=AJMQRDiAITVTnvSLT28nf8kWtccH+vSPoO0eEzudMZ1kfVJLyO0KEm5iMB8OFI3zK3
         KdC6M1fm0g0MN5l87VWIVj2MzGjr0nsmja4bPaZ4JicJBu4QMyAPWd/RfUKNy4gb2SLs
         XdEUQ17nMypZTmaKu3jsixnhk+GdGe3KDj45o4/kwKtd5EWcdwRgFLZzo+fXczdr0BaE
         Oe4PpVBIF30CzQhT8+SbVFNCz+D12Mg7WZkkKi9kI8fFL4DbapvWoGDIBU4lSIKkvdVY
         LD6N2J9U1ddpoL0TJT3LPfaf1hUDhGCyQsYNzmm/w/Irnv31lK0siqnXB78VkTcbjBRV
         KOaQ==
X-Gm-Message-State: AOJu0YzcJa1knd/NLgsRgANdhvdNsYsTIsXujRE47dcqr5j8kj4vn26+
	FosSOA5yTu8MTfCN+L10gCoivkxBpJoL2b6/GL9gNPY/rCB1T0dYzq6VoV6w7ktkioSDW4r6mD6
	TJZaSjYaY6gPTMePfjxQzt9/aIL7FbbmBQ6/roPoT4CaLhK0jIP7qtX3VzwRCy9EiSUhLbSU5/y
	EYSp4Nm88gp7/O1YNwgE7iDqco8X104oWBgFb3Q7ey
X-Google-Smtp-Source: AGHT+IEBoD/+PLidUWzTFlXIEkUGdpqIY92WXMs23wir0KWmLxUl/0R1hyGSqpFepm1jXlRwU0nKDc6bsIk=
X-Received: from colette.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:ce7])
 (user=ctshao job=sendgmr) by 2002:a05:690c:d19:b0:6e3:eab:18b1 with SMTP id
 00721157ae682-6eaddd6378fmr47907b3.1.1731016799454; Thu, 07 Nov 2024 13:59:59
 -0800 (PST)
Date: Thu,  7 Nov 2024 21:59:20 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241107215921.3518636-1-ctshao@google.com>
Subject: [PATCH] perf/arm-smmuv3: Fix lockdep assert in ->event_init()
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, Greg Thelen <gthelen@google.com>, 
	Namhyung Kim <namhyung@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Tuan Phan <tuanphan@os.amperecomputing.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Same as
https://lore.kernel.org/all/20240514180050.182454-1-namhyung@kernel.org/,
we should skip `for_each_sibling_event()` for group leader since it
doesn't have the ctx yet.

Fixes: f3c0eba28704 ("perf: Add a few assertions")
Reported-by: Greg Thelen <gthelen@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Tuan Phan <tuanphan@os.amperecomputing.com>
Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
 drivers/perf/arm_smmuv3_pmu.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
index d5fa92ba8373..09789599fccc 100644
--- a/drivers/perf/arm_smmuv3_pmu.c
+++ b/drivers/perf/arm_smmuv3_pmu.c
@@ -431,6 +431,11 @@ static int smmu_pmu_event_init(struct perf_event *event)
 			return -EINVAL;
 	}
 
+	hwc->idx = -1;
+
+	if (event->group_leader == event)
+		return 0;
+
 	for_each_sibling_event(sibling, event->group_leader) {
 		if (is_software_event(sibling))
 			continue;
@@ -442,8 +447,6 @@ static int smmu_pmu_event_init(struct perf_event *event)
 			return -EINVAL;
 	}
 
-	hwc->idx = -1;
-
 	/*
 	 * Ensure all events are on the same cpu so all events are in the
 	 * same cpu context, to avoid races on pmu_enable etc.
-- 
2.47.0.277.g8800431eea-goog


