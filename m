Return-Path: <linux-kernel+bounces-556143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E6BA5C178
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 13:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F1D2189506D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 12:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3B925A2A2;
	Tue, 11 Mar 2025 12:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QRcCTAvk"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AC6258CCB
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 12:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741696624; cv=none; b=P0gJ2r62id4maxP5OcVJS2wwjP11erxn+6WkcYfj6GLwDryeQyJwHXOs/sYtDEJXMHlMlSlj5TOY9vV1Z2Q6E+eL5upjQMo3etoBIqeNckdPWbWJ0tBhQOC4D9RwOQZnisbnxiPF9I3D+HUBXZrAsESuuI+FvUD+rcR0Y+bPdmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741696624; c=relaxed/simple;
	bh=oQiH4s8dqqTPoXcsDEfEFf/h97UEWukoBg/fCNG79Mc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G5Pxuy2c2Iuu/DenhPYCryckmZ8qDuEKgAEzj9EqxExkt5sb5PAGVNGhx34JY4pVuNHHMmS6QRNgRYC60HnzoNQ2Mp3/cxKwO2wQtRt7Q1cxHeR+oSfTvErd8EWhMPMyxk63RzOEXhe0DO78yQJgPcfpmj/elAjkefn3ovEmzUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QRcCTAvk; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3912e96c8e8so3019989f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 05:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741696621; x=1742301421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GirCFLl9Oa6UIyXIEajMTJx+vDKWVC1CpZz6XyjeJlQ=;
        b=QRcCTAvknEW63Tj34PTe4vXec5ix8J4yYreLHVrRcvXvOdiiaPxsC63gN2QNezvrC1
         e1f3vB/LuBaioCCwOEfR5wmio36G05wB49Y48ME7JyRdr66rRxSMcbLkNXK6UDp7VCxK
         J0st3bmPuafksihLjIwA+4aPVPUI5SyeGR9tiPjhK+CDYkudxaQHxz1KzeyHxdiK9pM8
         Ho8NlQDIlzENTsevsWkYYh5b33juFJc6MOdcD43g0KAc9krnN0JGp4+PGyOtd8WFK3NZ
         oK5PXUHsQLrGxjvM1DTqsO1NV+5fZ/QLVp2BlfvmSxlm1xy0dAoPbxotiLFHQq90kZ65
         kf6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741696621; x=1742301421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GirCFLl9Oa6UIyXIEajMTJx+vDKWVC1CpZz6XyjeJlQ=;
        b=l9vuFRFuAVvoe/TQjuvt4xoNghtwoP1EcXnFNmiYxvSOuzLiVFM0G1NrU9hR228byT
         9EwilTmy0TbWC8ERORB+y+hZ0pC4YNCAsI58mjF5zo/JoneIW2LEewnawjeZxF9m4BjI
         ipSA1JaFRDcTakO44sEK2VzAuHVpW3j3b/3wk1x8Kmy+x1Em2RI/o17/g/yxImRwv2po
         rWpTkrVvs7T6c9yk3YbdQv87AsKtNs+jEeDzG5JwK6TReegK+/J8fxFEn3+nPhI/QXfc
         /AxauIRLgKlYmOVK19J8iGR2FqVZj/y1L2lboU1YjDpQNLHf0xpSYXLdSj/U3wZa6DAH
         /xpg==
X-Forwarded-Encrypted: i=1; AJvYcCVGc4uhRqrc+O7YcWboL94yzjskSyeC2WcwVurWhIRNebnwV68vmqy1P9a11+66y+3WuDR2JLpcf2Pgb+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxL5WhQbzjuXjA2j8jxOTP5tR2IB75ToRFEHcTP75k3LFRMTeI
	gKuTAcnEbhWOCHxA9in68cp0rN8C2848G8nUKXHZEG1uho2NsDCG2+lJj1CkRz0=
X-Gm-Gg: ASbGncu1yNVTLZsrO/zF9xmJgonF/4uWbLf0rQM7CF4fNxoQixXMNle126GrXSDEWiU
	F3qR1W3ShFPDjQjXrwR1Ld0Cqb+ZKbd1YcYZKCUHZvmmEOjUHRurXrgE9hMcVaztv/4RyFd+scn
	ykAafbsBuQQYUHRSxIRFKqfAAOgvP4Eidz/e9xyXQ/qwh09j3wEBv5DvYJQ1g6U8b2oAAuF+Wgh
	TD2FNev6GqAaHz1e0f2NMVQa/fRS1hxqEmw8Y3kSyleEqOivwPtGrOGVyHFTNdv8WxFr/FmHcVx
	lBw8ISqmjToD8aIqa2z4OIRYt+PDwPYU6PqEO15+wPuquHQ=
X-Google-Smtp-Source: AGHT+IGScXuGUkBhL1X5gow1DaCbY9oCi5EpTUsqoNyHI3geIvP1EWLbpeg2VkBmjZnU7T6RnLfrpw==
X-Received: by 2002:a5d:47cd:0:b0:385:ee40:2d88 with SMTP id ffacd0b85a97d-39132d16d9fmr13476647f8f.3.1741696620818;
        Tue, 11 Mar 2025 05:37:00 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d04004240sm9742265e9.3.2025.03.11.05.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 05:37:00 -0700 (PDT)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Waiman Long <longman@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>
Subject: [PATCH v2 06/11] cgroup/cpuset-v1: Add deprecation messages to memory_migrate
Date: Tue, 11 Mar 2025 13:36:23 +0100
Message-ID: <20250311123640.530377-7-mkoutny@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311123640.530377-1-mkoutny@suse.com>
References: <20250311123640.530377-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Memory migration (between cgroups) was given up in v2 due to performance
reasons of its implementation. Migration between NUMA nodes within one
memcg may still make sense to modify affinity at runtime though.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/cgroup/cpuset-v1.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
index b243bdd952d78..7c37fabcf0ba8 100644
--- a/kernel/cgroup/cpuset-v1.c
+++ b/kernel/cgroup/cpuset-v1.c
@@ -436,6 +436,7 @@ static int cpuset_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
 		retval = cpuset_update_flag(CS_SCHED_LOAD_BALANCE, cs, val);
 		break;
 	case FILE_MEMORY_MIGRATE:
+		pr_info_once("cpuset.%s is deprecated\n", cft->name);
 		retval = cpuset_update_flag(CS_MEMORY_MIGRATE, cs, val);
 		break;
 	case FILE_MEMORY_PRESSURE_ENABLED:
-- 
2.48.1


