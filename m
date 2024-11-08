Return-Path: <linux-kernel+bounces-401093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7FD9C15E4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 06:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A62EBB23FF2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 05:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB107196C86;
	Fri,  8 Nov 2024 05:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vsXH5RMx"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF50D80C0C
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 05:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731042492; cv=none; b=Hh3UzL6l7+M3LjqMzaMqEZnUDCAxvNKkkpme5VQ5uVdXL7wWw+9d19aPF1xlRDSeVXQDVDWpHNTVtVWAQxNhR2HdjXpVzddNC8Qmoe3eBUQ2MCp1ZMifjkTaj6mYTLbJ2uGaYI0X7H0Hp4vcW9hUXb4e7rfFKfMYQ7w6+nbRZTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731042492; c=relaxed/simple;
	bh=DJrNvfYuviNmzptmELXiCM4ljRCEfyiTXCuHXx4uVqg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=CwQFRVARUxmEdKFpC3h5NnalGaVq+gU3b+I0fhHkL3Aeh72+vdFScKgI18b4sEQNIVBwIbPs4iMgsRSQffn+C0eROFY7IuPq2dC6mMn76SNc39Cn8oJAYh7hI8sIlbTU8YzEf+4LdJQJ3z73vCO/Kjl+dJYFwVUlr3php73z5F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vsXH5RMx; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ea86f1df79so34083847b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 21:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731042490; x=1731647290; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=von0VATUbmkAXtyUIAh4ZopKLVWbRkOEeG8Zx0qdBUQ=;
        b=vsXH5RMx7UZ1LJelGwSAHM08IdlXNu2I1RZ0bYLgA0erBBXHbm2/6SW6Hcu3iwfsTB
         OvD+9H0el4lmt5bn9yDuJAoRXLHAwxpRpECSu2bkMMViLXfEQkADavVM7KcA5HXRvGyO
         6nwgiWxkbpyt9EMhh6gWh3l0uqqf2TzPYMOC2xqBXYHk4ElPiB7oeDO3dqRjcAq5+yik
         Mt6t4DNRb8AdmiscwI8y2fyyRz/RLvcBTDzSr7sasuBPWakVXVf2ugAS+Qv8CFFtARpa
         Q+j/oK4OmMdwgvpjGegrsPJ+6ztSOs6+3w7LtkVax/02eWsdDAAptLZneUcDl5cHBwD1
         obbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731042490; x=1731647290;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=von0VATUbmkAXtyUIAh4ZopKLVWbRkOEeG8Zx0qdBUQ=;
        b=QLruekIkzgEu2j4qkIpnYNmYODQCvIUEAGouwlsuEZcnW0LJmsTF8tHTu1vNmm/YdL
         0LejPj75XvAr7osRGZRKRstpG2TedsvLCesNrhTrhrWO5ws2da/kLEFlseCq8LQFtlFw
         GuBBPvl+upDYf6bAuuCQCd6lnymzSTzDxHPjFopqZ0qZfNdlW9REXFXLx2ZLpV2oMZbZ
         U5FqI/Z7nH8+oZ/3CKFBAy6BHqyel0ctaGcZF1H/kaYS/MRS3/kpJ9aG7v54j4943j+6
         1udPxnFn0GP9ZjdR3IFl4WRxlZ/nYrFlJ1qCCSNrIpeJH7fZ6BecYviVhhr4EwphrTEd
         PipQ==
X-Gm-Message-State: AOJu0YweCHqAeT7sV5PRlJWPxZwdsgDib1bvYtqKm34P10yhTthBStwF
	Vu2Nqo5WYuXqbNPXUuU780tfEPp1iuwgstaWjbxdoFTUVmE/gfx4K5Jsi0ohyviPHPvC2OwIFj2
	326zvcApTjkj4EoOljszuRTqljq4Ygqg8hJWya/rSweMvSjJAbXE7Q4IkxJaG2jptSRzSDsAqMv
	zKLaeu6sBkcuTc7uoyS6tYx/ouSCG57ZR0ijQj5sZH
X-Google-Smtp-Source: AGHT+IHf1OGIq7/pvMGuOdBfBHjFf/WXAEr9CNSUYS3G1/Tm9SGTNY03PZ4oy45jtL7gQWDxy/rglOLQzS4=
X-Received: from colette.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:ce7])
 (user=ctshao job=sendgmr) by 2002:a05:690c:200f:b0:6ea:34c3:742b with SMTP id
 00721157ae682-6eaddfad76amr150937b3.6.1731042488912; Thu, 07 Nov 2024
 21:08:08 -0800 (PST)
Date: Fri,  8 Nov 2024 05:08:05 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241108050806.3730811-1-ctshao@google.com>
Subject: [PATCH v2] perf/arm-smmuv3: Fix lockdep assert in ->event_init()
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
 drivers/perf/arm_smmuv3_pmu.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
index d5fa92ba8373..dabdb9f7bb82 100644
--- a/drivers/perf/arm_smmuv3_pmu.c
+++ b/drivers/perf/arm_smmuv3_pmu.c
@@ -431,6 +431,17 @@ static int smmu_pmu_event_init(struct perf_event *event)
 			return -EINVAL;
 	}
 
+	/*
+	 * Ensure all events are on the same cpu so all events are in the
+	 * same cpu context, to avoid races on pmu_enable etc.
+	 */
+	event->cpu = smmu_pmu->on_cpu;
+
+	hwc->idx = -1;
+
+	if (event->group_leader == event)
+		return 0;
+
 	for_each_sibling_event(sibling, event->group_leader) {
 		if (is_software_event(sibling))
 			continue;
@@ -442,14 +453,6 @@ static int smmu_pmu_event_init(struct perf_event *event)
 			return -EINVAL;
 	}
 
-	hwc->idx = -1;
-
-	/*
-	 * Ensure all events are on the same cpu so all events are in the
-	 * same cpu context, to avoid races on pmu_enable etc.
-	 */
-	event->cpu = smmu_pmu->on_cpu;
-
 	return 0;
 }
 
-- 
2.47.0.277.g8800431eea-goog


