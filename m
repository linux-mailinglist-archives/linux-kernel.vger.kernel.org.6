Return-Path: <linux-kernel+bounces-544751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A62D7A4E46B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 399C57A31B1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6D228FFF7;
	Tue,  4 Mar 2025 15:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VsTqcrWL"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DBB27C86F
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 15:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741102741; cv=none; b=LO3Op/gB+eqYdBz0XldoATu8FE3mg6j3ATi1WVgsjKIp/468VrGBTYT+qaep2mOrMciQP9TONENiLfSDzTxnM30aycNKCfBFZy/tCVRwWCPpN9preuH9qN85wfA1aYsqEcPyFX0YYpAoU8NFqqX7BJ/Z/GYI08TNk9DdMMuk+6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741102741; c=relaxed/simple;
	bh=MdgvuPV/x8WhlRRCw7Trx9k9ojx5GfL3R2IFVSBLDBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dpCVLXhOREfGdNEtZuppCRwKmMizs6QRnGEn1CXVfEELo8jidKz9cuTyGCTh9f/DCxL0ejIH9OI4nrci+Cheuy3Df4gK+Qy34i/cXm1JFnkrwVmtyh4N3jLlTETxh1NEKdRDTlijE4OMO6xh1LFcR4CEOHmRiPfeNxdKYNQER7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VsTqcrWL; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-438a39e659cso39745015e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 07:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741102738; x=1741707538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TgXxWXRYbTk04GQd58ITj+iG+NER5RZZsNgCYR7jvUU=;
        b=VsTqcrWLiRztdJqD+hckVkKPe1yjJ76YHIAWTRnEf737KnahCd6bqo1dAMJhSD/VSq
         4DqQnPNAKhRzX3Aiuw2/i0mBSgSDxhHYlcFJE1hAEabP7ANQgTGDT0PO1kYBuR48XpPR
         AS77lJoAKkkEL4LWLzf5vY9QXoEGyrZrV9bTL2apQMJJZN1DjVsNg2IW1h2XvQ4Jz8IS
         uUQMzvihGsce8JQ79fkjhCOLS4Sivt0c82bu8seSHuRQI6SqLzXJbnuf+iHkWSwa0kyJ
         RHuOVB+bgpMcJqNyaPTYocI+uPnPQ/trxh2ggCGW8iwzNejTjizmJuIi0Z/9Z8iPtyow
         hZ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741102738; x=1741707538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TgXxWXRYbTk04GQd58ITj+iG+NER5RZZsNgCYR7jvUU=;
        b=mwM2ri+nTjFd0rqMc2mGskaOMgiGC/SZ9aRTgvmM/s0X+IFtJTd4TOAeqaRRCLoKyD
         hVny87sZcvAdm3IjXrZe5f+Bt9cxT0tEOcuGrdX/E95eDdLbyr2WawWFAAELXylQSfXv
         f4RAdMEtS3XkIF55L5sZD8LDi/EOROvR3VHmu9uMiwyYGStkXl+jAeJEpPr9+f8aK8fs
         7LQbtYoYNphmPS0aQR1j8v3JVZKzDJ8dyXJoCWC8YBvV8EprvhgD7HNTKhlAosSKrbuH
         ugs1nsqBSk0+8yGOpVY+vxy/ZsTl3pltaSy4WXVeujuDmO0nWzctY3Nn6oiJHIZI3i+z
         5Elw==
X-Forwarded-Encrypted: i=1; AJvYcCXwCk7pFm1jGsq92ArbewmSM17ctv/joopE0BnfkPd1kSuZ5LPYHkiRrH4aqDrJcHeAIcaLp4DOGh9wMqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUB0fASe+S31mdZ+jynh60ZokHJz11CQD+wYMQGR5cEqY7V5XD
	OgThgLIsa7f3mFYi++IeFEXB6KJ0YFiXo2x91duO2vBxpQC9lACo7Gtlf1tdIvM=
X-Gm-Gg: ASbGnctac5gJ04X8zkW5gV9juLHhvgRFiP6zVR/cT94y6xq++cFflM8BIBny4gcSKfB
	VtqA8d1sFi20oy9gep3zBPPB8y2FcxUnt6F429Q8dWZHAJ+65K5EvMkJbJhtA4oZ5RnO6s1Gt7R
	c+zea9q8oM7Mu7VEqoyqsLdAKw5D+Vc/4nKFgoCtkLNhT7rmbo5FI5bLHQcCFRI2/LqbGCsY/Z3
	auU1HibD6vLzwyhyfJn967M5OHSJGGllSdtdJFDVcPfZdhWQr3KTLVGLA49qHsFSGtk2qJNoutz
	y3aXODKyUJpLufvBQ5Y0f7f4XjQH7uKuml2h82Q1bvaJqD8=
X-Google-Smtp-Source: AGHT+IGFdMgALKsPh/yOBcPEpPtHnNxwQeHrF4SOqKDJXo/p70nI+zMPXEdR7SegUyRy3tSFD06IsQ==
X-Received: by 2002:a05:6000:2ce:b0:38d:d9bd:18a6 with SMTP id ffacd0b85a97d-390eca07164mr13871828f8f.42.1741102738265;
        Tue, 04 Mar 2025 07:38:58 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5710ebsm238670625e9.26.2025.03.04.07.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 07:38:58 -0800 (PST)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Waiman Long <longman@redhat.com>,
	Paul Jackson <pj@sgi.com>
Subject: [PATCH 6/9] RFC cgroup/cpuset-v1: Add deprecation warnings to memory_migrate
Date: Tue,  4 Mar 2025 16:37:58 +0100
Message-ID: <20250304153801.597907-7-mkoutny@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250304153801.597907-1-mkoutny@suse.com>
References: <20250304153801.597907-1-mkoutny@suse.com>
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

Cc: Paul Jackson <pj@sgi.com>
Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/cgroup/cpuset-v1.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
index 05d3622ea41e5..6155d890f10a4 100644
--- a/kernel/cgroup/cpuset-v1.c
+++ b/kernel/cgroup/cpuset-v1.c
@@ -436,6 +436,7 @@ static int cpuset_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
 		retval = cpuset_update_flag(CS_SCHED_LOAD_BALANCE, cs, val);
 		break;
 	case FILE_MEMORY_MIGRATE:
+		pr_warn_once("cpuset.%s is deprecated\n", cft->name);
 		retval = cpuset_update_flag(CS_MEMORY_MIGRATE, cs, val);
 		break;
 	case FILE_MEMORY_PRESSURE_ENABLED:
-- 
2.48.1


