Return-Path: <linux-kernel+bounces-556138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D868A5C16A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 13:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29EF3188C512
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 12:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7652256C8C;
	Tue, 11 Mar 2025 12:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZjFO4j4u"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36778233D65
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 12:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741696618; cv=none; b=NgmqN1bsKjWPmhBSfnsr+RSEItIv4vecDyksKj8aW5G7KCfsb/3ABH/7z30093wwDMs2gqGcSWHTA1aNxOJPgz2YyYTScr1JCzpQ+i0HCu7KVvmeim19lg2fK6TSK9Z+8w7UchCjwr07P69BomXezgbN8GO+tHax5azJNnvE2og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741696618; c=relaxed/simple;
	bh=nW4jLdG4pxSPugL4mUyzgVTHJ6J8k0id4IG/O948Mcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O5DYF+5ok4B6A7g1cLoHKsm59IqjKwsuiFKwHy6j/BEwIbW2MIXMrXrqmPcxfnRHJyWQd198kQNk++rSUx8ebeE8FvxA/qchAV3dU9Cqj4UbFZZhHuJfGoQ1KC6zO1Kn2d0dLS+c426fgfZc9xJXd8DiMeKjjVcDCA4mFhkkEmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZjFO4j4u; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43690d4605dso33316185e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 05:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741696614; x=1742301414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=854zdfjcN/UDCoKW38CZ3IaEk9swBTCN45qjV2gxt8s=;
        b=ZjFO4j4u0e14NtQ4mw5lf7R42p6et1J8GgDSBlGuj+n6sDQJVkYOyWvOWuhbKVonUX
         1iUhv5fTdQ8Kgm1iDsKFgeE5LHVpHazOt4V1O1gOvFW4aKkSZGHcL1VfZGoflOlNIUFU
         +r0kA56m08H+GJkpV1V1x8F297uI6neNkLQdiLZQ5+UDf8dRwdyRgKbu6wL2f1YJiPBG
         jpryfT4JWga7KgYvrr5MsPQZ9NWPIbva160PBeElJsTyiOtdNcKkFuq3K3gyXh3M6E+5
         Vq2NCVHzyyobJTWnhwKQrszyCqG13/tRNdFF7b0QyUU3D7oqFKiQPyJ/e/SIO1c8aDVL
         cFWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741696614; x=1742301414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=854zdfjcN/UDCoKW38CZ3IaEk9swBTCN45qjV2gxt8s=;
        b=uydbVbfc4Eoi0XzYUStcSxhavx6TozgArhnWWZjtRbT2tWU4Miv4W3ExywUTqayq7T
         IDXwArL3tZi7gE4skqNT0ISwkBynFuitLdz9ay/FCnocad2Cw+3TuBP/Bt+JI1bBk1NX
         bopuQVL8lbIRr+ORvWfynl485C9rGdhmrKkzLuo7g8SlUco3QfMkYQhVHGjKCllMajLe
         Ezgd+xm75CW9GK+2ozd5AYSYRG79O6YmF0xRkPpJOwKv5ftSeRMM+PUvR+k9eRIs79UY
         mHxVf/1KHBZ2JfZRy/9c4UW8M7ei5mjyxQldIOw9ervM1RT/mrUNIo5dYy56gadrNJeG
         LUKA==
X-Forwarded-Encrypted: i=1; AJvYcCUjG8+AKHOOMp2f1UxXXiwGE7nl1UJ8speu5z31CA0PLUzP8BFETLz+FBPp+dmwhCHcZxA/xPNgYh9Lr0c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX714vNgiPf9rPpqkqE3YPvtqvZ6BNr3ZmfTZgB9cbkP1OIj+7
	/SDk3RwwCfUKk7GWK3rU8GsEVvqTH7c2jTYqtOnNADqmUNOCQuCPREDcwS22U6I=
X-Gm-Gg: ASbGncvXqp2X+ZUic2QjY12c5lLINMCgBcFL57MOUwJdEB707JXPZAl81ODhtreKZiL
	cSlyb9YjQivl4vrn/R7ewHJB/uPIu3crjGoRPzkd3d+q2D5sdRQVja/vS9hQb8pLKTOgqlBrQAM
	Ta6z/TfUNnpttjfoFJD2fCVLDZ7uWUo1kXIy+Wbjb4eq5ODEJLKBRCZ2zQvJC9Nj3I5asR0hdu/
	LpSzHP1wqUmkn00bgNPCwkrm3KvljTUsQCHn1Ch/JbRXEQojwGfoWtuBDCGY+RKw4i+5XtjGmV7
	GKZN6wWwrR5bBJRaLSEL4KI5mhfgpPD4s4negOJIzyAW/Fs=
X-Google-Smtp-Source: AGHT+IEWMHT7CvjCWIzlXfslrA0NNHfMmwLfEld4qci+NoRLiOZKAENxmwF8nz0PqnnF8QUx9HYXpw==
X-Received: by 2002:a05:600c:510c:b0:43d:45a:8fca with SMTP id 5b1f17b1804b1-43d045a9259mr31387195e9.30.1741696614492;
        Tue, 11 Mar 2025 05:36:54 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d04004240sm9742265e9.3.2025.03.11.05.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 05:36:53 -0700 (PDT)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Waiman Long <longman@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>
Subject: [PATCH v2 01/11] cgroup/cpuset-v1: Add deprecation messages to sched_load_balance and memory_pressure_enabled
Date: Tue, 11 Mar 2025 13:36:18 +0100
Message-ID: <20250311123640.530377-2-mkoutny@suse.com>
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

These two v1 feature have analogues in cgroup v2.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/cgroup/cpuset-v1.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
index 25c1d7b77e2f2..9d47b20c03c4b 100644
--- a/kernel/cgroup/cpuset-v1.c
+++ b/kernel/cgroup/cpuset-v1.c
@@ -430,12 +430,14 @@ static int cpuset_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
 		retval = cpuset_update_flag(CS_MEM_HARDWALL, cs, val);
 		break;
 	case FILE_SCHED_LOAD_BALANCE:
+		pr_info_once("cpuset.%s is deprecated, use cpuset.cpus.partition instead\n", cft->name);
 		retval = cpuset_update_flag(CS_SCHED_LOAD_BALANCE, cs, val);
 		break;
 	case FILE_MEMORY_MIGRATE:
 		retval = cpuset_update_flag(CS_MEMORY_MIGRATE, cs, val);
 		break;
 	case FILE_MEMORY_PRESSURE_ENABLED:
+		pr_info_once("cpuset.%s is deprecated, use memory.pressure with CONFIG_PSI instead\n", cft->name);
 		cpuset_memory_pressure_enabled = !!val;
 		break;
 	case FILE_SPREAD_PAGE:
-- 
2.48.1


