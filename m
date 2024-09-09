Return-Path: <linux-kernel+bounces-321776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF84971F4D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 18:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 110CBB22ACB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 16:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946DE16EB7C;
	Mon,  9 Sep 2024 16:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FskJ6rvq"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EF11667F1
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 16:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725899551; cv=none; b=iQHtThLklytegdoZ42WLByDucmkXzacb4GCFZc4AwCrtJaGBpIR53kHhiSeGFOFpUIgLugqFHJlonkuJjBIzE9Wip/1Q03pzgYL9I3Bjwf59UUJFLeU+a/regMhUng445GV185zdq2sxqVW5gDf36OguxXK2qlgwqQ4VUQSRBPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725899551; c=relaxed/simple;
	bh=+jtKQ79qkwGmLZ8LQTtUxHvnXR3dvvYB7R64gvm9pY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AEEv6+UO8Wk/uufhFjy869D0whRFIvTCajYWbhdrW9evikT0N9yEtb7o3nIf//4+NPOVShn6u2Sci4t7NdLWYfNI7+tEsiBRuVgAyO3JcUsvuxp9NxrmGYVXOIP1fZ0lza5ZUX5gLXsFBRIarMrqjT0odYxFOp7mwiCVCFzkEUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FskJ6rvq; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-428e0d184b4so39201955e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 09:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725899547; x=1726504347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3hN1sbdsSr5xjIEEi3K2BOZrBarvDPImrotZrDBVesU=;
        b=FskJ6rvqV30OtSq5ORuDrKCtWIsRsc0tXF7IEf2hODbR3mflHq2pG7cUyrPIosnYA8
         2h7Ic1tgRdK+lMUaN6qcSPdM8xL5cnzzGf2nV2FIlKBXdsP6FMx116HOv+b4PYSaAcws
         Ebvr31DGnXeKLnTolVvFqT/bUE8eCdRmvPO6PW/2VEPD/fS6QUfWaXS2s6LbHBBkTGiL
         7XhgCyoC1B0oSFq9EWZsXrRR0cXL/c6Iu3YrUBaGdGTAKkWuGu7a9aptd4mWBPVXLW3Q
         n0vv+EyMbMHdIXXdZgWH/p5JJwV0hsRY0DdnZJwQMkD4L7VXUOIiVxGprAYhrNekxjl1
         PI/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725899547; x=1726504347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3hN1sbdsSr5xjIEEi3K2BOZrBarvDPImrotZrDBVesU=;
        b=nwSPcYsDsLanucLjibCA/o1naDD1bh9Z15YrI/e5A/84bxLlg6QtHdSjs3uIrvvp+F
         +r6wPylh9BH9oz+TV0JI6+GzpNOGhECcvISshhod4pwUK1eKYGZaHdENOSqhHbjScUl0
         78JBKJ3vfBZWp6Fl4Zb5FbhkaaPJdz/dG2fTE9o/cXM+8rhaOBSPNLXNN5uh/PEvc2Ja
         XYJpyeTI0smDWebebbkXDh1ksGyHvXjA9p+ML0itygbhgl/X+uGLHNXrYzdjP7EbW/5H
         +WJT/UayfihzSOGKr1NlBNc/8+FmcP7sgMQ030hblCGEifGdFNT8nVHxxZTNGvGBcGWY
         65yw==
X-Forwarded-Encrypted: i=1; AJvYcCXcy2LZoxZ+2KHMXI/tinPyJUPsaIhDeQBKNrDAvZF+OarAR+m76nE6X+C/Kwo8L9T7iVUwcZO7nWscvoc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHhrGWvTsD2IZqDU17JrW3DwyTupQIUO0Bx/qt8wU3mK+7juXd
	77LzzShi+JsXkBcREL2DHIITeqDwxYbQOA88RIQ1TQAvZCtkZ8PQ/UQDoGdKu74=
X-Google-Smtp-Source: AGHT+IGxjAbrDtFXLx+iO1e9KJ4se6OA7eld34L5kuJJJmD5mvX5+Dcs4EKLQGfBldRlsEeQGM6bsA==
X-Received: by 2002:a05:600c:1e02:b0:42c:b949:328e with SMTP id 5b1f17b1804b1-42cb949341dmr21798805e9.31.1725899547259;
        Mon, 09 Sep 2024 09:32:27 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3789564a072sm6478606f8f.2.2024.09.09.09.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 09:32:27 -0700 (PDT)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chen Ridong <chenridong@huawei.com>
Subject: [PATCH 3/4] cgroup: Disallow mounting v1 hierarchies without controller implementation
Date: Mon,  9 Sep 2024 18:32:22 +0200
Message-ID: <20240909163223.3693529-4-mkoutny@suse.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240909163223.3693529-1-mkoutny@suse.com>
References: <20240909163223.3693529-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The configs that disable some v1 controllers would still allow mounting
them but with no controller-specific files. (Making such hierarchies
equivalent to named v1 hierarchies.) To achieve behavior consistent with
actual out-compilation of a whole controller, the mounts should treat
respective controllers as non-existent.

Wrap implementation into a helper function, leverage legacy_files to
detect compiled out controllers. The effect is that mounts on v1 would
fail and produce a message like:
  [ 1543.999081] cgroup: Unknown subsys name 'memory'

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/cgroup/cgroup-v1.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index b9dbf6bf2779d..784337694a4be 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -46,6 +46,12 @@ bool cgroup1_ssid_disabled(int ssid)
 	return cgroup_no_v1_mask & (1 << ssid);
 }
 
+static bool cgroup1_subsys_absent(struct cgroup_subsys *ss)
+{
+	/* Check also dfl_cftypes for file-less controllers, i.e. perf_event */
+	return ss->legacy_cftypes == NULL && ss->dfl_cftypes;
+}
+
 /**
  * cgroup_attach_task_all - attach task 'tsk' to all cgroups of task 'from'
  * @from: attach to all cgroups of a given task
@@ -932,7 +938,8 @@ int cgroup1_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		if (ret != -ENOPARAM)
 			return ret;
 		for_each_subsys(ss, i) {
-			if (strcmp(param->key, ss->legacy_name))
+			if (strcmp(param->key, ss->legacy_name) ||
+			    cgroup1_subsys_absent(ss))
 				continue;
 			if (!cgroup_ssid_enabled(i) || cgroup1_ssid_disabled(i))
 				return invalfc(fc, "Disabled controller '%s'",
@@ -1024,7 +1031,8 @@ static int check_cgroupfs_options(struct fs_context *fc)
 	mask = ~((u16)1 << cpuset_cgrp_id);
 #endif
 	for_each_subsys(ss, i)
-		if (cgroup_ssid_enabled(i) && !cgroup1_ssid_disabled(i))
+		if (cgroup_ssid_enabled(i) && !cgroup1_ssid_disabled(i) &&
+		    !cgroup1_subsys_absent(ss))
 			enabled |= 1 << i;
 
 	ctx->subsys_mask &= enabled;
-- 
2.46.0


