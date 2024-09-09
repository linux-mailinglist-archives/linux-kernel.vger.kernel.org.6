Return-Path: <linux-kernel+bounces-321774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB108971F4A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 18:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 787DE28727C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 16:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD8B161326;
	Mon,  9 Sep 2024 16:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PCNglOSx"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F35C1662E4
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 16:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725899550; cv=none; b=LdS41xV/YfKcnVl0Sok7xQZL4Q1pjnyqiWJyFXp9t84xytZiwIrqdXn76Zrfn6Y54qCICdgWTU49uzXrLQmQQgkRLuytJCm+fTdOLUdA8CeXfYJPP503TQBn/kPIDIfu6T0dSsCzqFrvo0aBr2lJxtoJ27vm97uVLed3qoiHk/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725899550; c=relaxed/simple;
	bh=iMVZjh7xj4+ygIIIc/WPUfeZ+OxGtc9LdVyEVn81WZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AgSdykXR02jw5TmSNU5k2CYSFAnYgSIupZ4MP4IfHYCrb99lwGu4pInksZqHdFjsyjNYfY3TfX/Cb796ppf55yNxToNxkALa8TmAGwet9GawFV/Kcgs+A8SPqhpHOVi7+Jdbg1hif/FZqFvigivg2DDVxPYTCxLbrAQxYTlicLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PCNglOSx; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42cbbb1727eso4670455e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 09:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725899547; x=1726504347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sobUieX7sbiSPYFy6bxdFPzYBPZvmuQtQFMPmLF111k=;
        b=PCNglOSxBMYm7fD4+fTmcT0zPpzLAshxwcQDUqDnWF0LIfIEVHYm2xPIar+NQBHqhH
         ywoQAlXl1SLI0b6iJzq50Jr0tLI3fD1tWdiTG4WGlFDiSsW2cgMEzdo6cRPv9hhe3MVY
         yqVvuDGBEoT2sD0UTsSLghVvcjIz9Y0QQIjFNBs5kKfaI4dQd4+0MdpQcjHjXX7GGv/t
         yswJ7wkg8WJk4vu5/OT/ExQcxXET5OiHtsslhSsbwZufyvXjkPRYfTTYYlzj1ukMdGnB
         3YZz1vzl3RLVqu6IOO84nQubSp4aINiKHG8HrK8+Qpml5Q76oxgkqKDBnYEVtsPB5JWa
         xA1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725899547; x=1726504347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sobUieX7sbiSPYFy6bxdFPzYBPZvmuQtQFMPmLF111k=;
        b=nJ5w6LpxCK7GpxKRxyPUZNd0cVAh/jJuONUh5bRPSJkI8VLCl4UVH0KQ1I6bjVGm1h
         /BEjfMc+XWu8nMt3RpjZpipWM+7vBD9DtvkyiqellzYCvh8zC2WZf4Cdhoa8pq7eObQF
         BytvEw0epkDuyP/2/3bHKfPRJIVVjirOwiInoY5tbklTm6RzD0F2Rwzi2HOPh9LYUfHL
         wWEKA8vPGAvHljY+11srusYlFlX9/Yk7xn1h46sV+Iw+KUKu06mjfNAQa6c2SjiBSyUR
         QaKYHQVFDnMTflAB+PByggI7+NsFwlAyeF0n9FtptqyWjPksE5UGOucV5OBia8ed1sgb
         UApw==
X-Forwarded-Encrypted: i=1; AJvYcCVkM756DUsD/8VM3SJ/45WbxFyth2IZ+5Fh4QyQ0dGdo5UU89SnqZxVRgG26tW8NTeV7Q1GMrk/R4aB5mk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoAKxOkZ4h7fzZ0cOQA5rvAA9upipdDh7eY4tRcVU2SIgHKLdX
	wz7OLHf8gjr1uPtNVOL6yEAlgxS12L28vSdYUv10p5MN4ySgSUKv5c+GoNkiS0g=
X-Google-Smtp-Source: AGHT+IHP56w+Vwo326v4est5mKtZvXJI1kCa6K6pwhkIOZ6Q1r5Njpbo29H7KJ8jdrsk9xU+NzXgbg==
X-Received: by 2002:a05:600c:1ca0:b0:42c:b995:20d3 with SMTP id 5b1f17b1804b1-42cb9952478mr18658765e9.26.1725899546518;
        Mon, 09 Sep 2024 09:32:26 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3789564a072sm6478606f8f.2.2024.09.09.09.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 09:32:26 -0700 (PDT)
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
Subject: [PATCH 2/4] cgroup/cpuset: Expose cpuset filesystem with cpuset v1 only
Date: Mon,  9 Sep 2024 18:32:21 +0200
Message-ID: <20240909163223.3693529-3-mkoutny@suse.com>
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

The cpuset filesystem is a legacy interface to cpuset controller with
(pre-)v1 features. It makes little sense to co-mount it on systems
without cpuset v1, so do no build it when cpuset v1 is not built
neither.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/cgroup/cgroup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index c72e18ffbfd82..90e50d6d3cf39 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -2331,7 +2331,7 @@ static struct file_system_type cgroup2_fs_type = {
 	.fs_flags		= FS_USERNS_MOUNT,
 };
 
-#ifdef CONFIG_CPUSETS
+#ifdef CONFIG_CPUSETS_V1
 static const struct fs_context_operations cpuset_fs_context_ops = {
 	.get_tree	= cgroup1_get_tree,
 	.free		= cgroup_fs_context_free,
@@ -6236,7 +6236,7 @@ int __init cgroup_init(void)
 	WARN_ON(register_filesystem(&cgroup_fs_type));
 	WARN_ON(register_filesystem(&cgroup2_fs_type));
 	WARN_ON(!proc_create_single("cgroups", 0, NULL, proc_cgroupstats_show));
-#ifdef CONFIG_CPUSETS
+#ifdef CONFIG_CPUSETS_V1
 	WARN_ON(register_filesystem(&cpuset_fs_type));
 #endif
 
-- 
2.46.0


