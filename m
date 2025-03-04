Return-Path: <linux-kernel+bounces-544745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A62A4E4D2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F8BF19C3215
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D85827C173;
	Tue,  4 Mar 2025 15:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="O5Gbhjvy"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13D427C840
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 15:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741102724; cv=none; b=aANp+3gaB2EKQ6C2l0PVbAjeSpTtTnBE6PAO2R8TrMbCGDGBNLw3rR8AFcuI2jzGgx+ET/cLBTBUFk2Zb7Hh5BQ7frbPum9P0C6yQPRqck3yLT7j8RDIeCXuPt662/7dDps8qjGBeytShqaGhOPQF+xKwkUFdGMIYzeIJoW6wgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741102724; c=relaxed/simple;
	bh=n4HhF0iE5d/zFnVCBm46vTJrbP1QNpIud73Lm3o314M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dow2YIrMetIryjGXQrIpYJDVE1I4pD3buG33fygC6zoyU3N0wID7oG5LanFJ6DS9x5ioEzIAqOR+xUXJXd4xjnK8k1f/s7S0Upq9cOfCQA08E2ZI8R32nfWiLijSqv0XixnR+kSefCJdTe9pNgfSSArmS/RwNvJiOE1Q2VHZADg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=O5Gbhjvy; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43bc4b1603fso14512295e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 07:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741102721; x=1741707521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bDY1B2OgIPZSJkU1XkPMYSxsKEiRbouQuwYY7R8HO+0=;
        b=O5Gbhjvyz1AbPH2XY5j8usKVLea3mIH8afcb1jSDErxdguD/2ZgCi9YaQvXRXJU4nS
         c/hG42fQ9ixjctO6Ae+Nx69F0j7DDfE9YTp3gf3aVKTUC4fJQSofvi2/O7QAJgZtC9FY
         8BCC87kqSq0GyYbo3EgH5jrnGsGSli/8Jo3UVgbhf+G0012VnwLXnz4W48rj9Nd/42ug
         wS2JidLH+p8Ug97ruqcBc06XyRAbMZg80jXtVfhW4CxmWlkadtmSLWm1sxr/b/9NUQrp
         GvYt3IVOaqcpjYCdG7JrCdazwg6cxBWA/rFnEnsgZ80W+dSuKSSVgJxO6raVRsRhozlc
         dGpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741102721; x=1741707521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bDY1B2OgIPZSJkU1XkPMYSxsKEiRbouQuwYY7R8HO+0=;
        b=aQHnS2DttPKfsZyuIlilhIcEjOfGh84oKcONABkATAPuzzJjbszUE2OGlyfCk6rSOG
         NdZnSyKrw7Ybh+eyKV2SFjpzfNdfmNAYKl6pHaW6IGmzgHMP5lyZQ99fjTCxNG6pxoTu
         0hmWn9ct65DYmaZsKHxnaKoWdBwGN4SxNRE++9RAgl5YW/NlqERTeuQY2mX/Xy4Bt9Ul
         7+Th1WX5KZfnE48pB0VeWJy4x6QaLyZCVHbSccv3A9cpqv7HlcmJr39hZGf63poucprL
         HGmJOPAjC2uBwkwHmotnUCPdQ4HvPCcVHAqNyEpWJyIuu3tY7T8eMSKoyR0uqrGVIsvt
         ahjg==
X-Forwarded-Encrypted: i=1; AJvYcCVZX32wmlPwkubkce0ypKUK6Owt5mDD84xFKJGPB8uQ1iVuGoskTQmD9iE2WawaaLDfDaOXbwZLjlysdqM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkv1jwasySTZmPMjTosLNpWE/k5tt2ntKBOa0rSD5OkuOxKi3Q
	rEYP7jHQXgXWo6GSpMwnwB8+d+/KcVMP95OdaP+zY7TL12stz5MdTT+HGmxOa+4=
X-Gm-Gg: ASbGncuiDu00EzUcFMyrv1lr+Eg9f3/xNP6YjPdLp+OYcNa9U2rGHV0OJE1dQ17fSod
	LLkWEM4Z5NDPlpINqLCv67kef8qvneA7byraOYNm3rrRaW17hJqwYheHnvTmQ8R7+1pEiVCacGg
	HrAyqTnTeTIbESthD0c9pGlDVSiqENc9yXOOPw2ZZH219yd4/sVg0lb10sKAfn8Gc4ZLAw0/ySK
	Cv4eJ1O05w+NmKQ3K8fW05JOZUgBU3VZiufBZ0hDhFZrspbHfiGRYQX7zPFh3/bUWACq1a+FYFB
	x6aByU7Asr66Oy3VCykfTgwStcvmbsQCshATCt56RONoUA4=
X-Google-Smtp-Source: AGHT+IEK7jyhUNwdxioelGYxeSf+GoJMffZJrLOw6owQIFfGVyUvngoXcwDOhtyH+GDoI3MOes9CWg==
X-Received: by 2002:a05:600c:4685:b0:439:9a5b:87d4 with SMTP id 5b1f17b1804b1-43ba67047bemr148306905e9.13.1741102721047;
        Tue, 04 Mar 2025 07:38:41 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5710ebsm238670625e9.26.2025.03.04.07.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 07:38:40 -0800 (PST)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 1/9] cgroup/cpuset-v1: Add deprecation warnings to sched_load_balance and memory_pressure_enabled
Date: Tue,  4 Mar 2025 16:37:53 +0100
Message-ID: <20250304153801.597907-2-mkoutny@suse.com>
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

These two v1 feature have analogues in cgroup v2.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/cgroup/cpuset-v1.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
index 25c1d7b77e2f2..3e81ac76578c7 100644
--- a/kernel/cgroup/cpuset-v1.c
+++ b/kernel/cgroup/cpuset-v1.c
@@ -430,12 +430,14 @@ static int cpuset_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
 		retval = cpuset_update_flag(CS_MEM_HARDWALL, cs, val);
 		break;
 	case FILE_SCHED_LOAD_BALANCE:
+		pr_warn_once("cpuset.%s is deprecated, use cpus.partition instead\n", cft->name);
 		retval = cpuset_update_flag(CS_SCHED_LOAD_BALANCE, cs, val);
 		break;
 	case FILE_MEMORY_MIGRATE:
 		retval = cpuset_update_flag(CS_MEMORY_MIGRATE, cs, val);
 		break;
 	case FILE_MEMORY_PRESSURE_ENABLED:
+		pr_warn_once("cpuset.%s is deprecated, use memory.pressure instead\n", cft->name);
 		cpuset_memory_pressure_enabled = !!val;
 		break;
 	case FILE_SPREAD_PAGE:
-- 
2.48.1


