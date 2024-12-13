Return-Path: <linux-kernel+bounces-444957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6CF89F0F0E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 15:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C7B81883C8E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 14:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFEA1E0E10;
	Fri, 13 Dec 2024 14:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AsxJ3AbC"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F03A1DF731
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 14:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734099909; cv=none; b=V5NKXixI5JeF9muWUqxuXwzFywi5KBeWxOrqI93vXfHxklrDglR3u5kNoa064VpTsVdDqJEHsVy4OlbLzKFuOngH4xCRQ3WromeKMuewuI0fC4xoiDbOKlo/zLuX9+HhZiOk0aE3Cui/4XmzInfHh+7wbb3ckH2BCrrzSnWUDh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734099909; c=relaxed/simple;
	bh=t+Fci6Wr6RyAVUyax6WtlRrMWfMTVgsO0PXOjq1qZEo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QgfzB2KV0n/dgVOG8uje8Uiz1fYiIIBAXUyyWuR2mL6UtHxOubEDftQjv42GtxdTPJdmTzmnpjx6togzYJyiyuGKFWzaKKODC54IIs29BBhb6OhrvjAuqqa0zSxM7vhlKJgDyuSrGll5pmCz3e1zoPUame/KGWcnxrB84zbZgJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AsxJ3AbC; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d3dce16a3dso3253736a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 06:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734099906; x=1734704706; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LsEyhK1UDCh91BCy8kAzhKC4PcLtI4+QQ+70pp3vZ98=;
        b=AsxJ3AbCI0PyAe6FAajhwEruu1RTkZ4JvPQ7Bx5KWRRJILmQBq+IO08CnY4TOq6g4v
         nakKhOXX9GzlYTibyzRcujpdYzWLgsdg/r0xry6QLVDX7u0QHrmpotOwjryp82w/aRFu
         K2XsbX7VFEN3+E+9owMxx+MKxUXOTNVyabzQAtxD137bxWyvl8byX8+Bm308siFYHNFy
         o7IAA45aN3+1k5tQsMp6Pp4BFbO57YGO16rAJelDqcSz6bNYlJGdukNcBVui0BtMdXiI
         hz0MAwgFuU7mRlkeOVJRZUN32Q+6VoKjpp8xJvzBypKOUB4cWJ9loecv52cuoGFRYgky
         QE7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734099906; x=1734704706;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LsEyhK1UDCh91BCy8kAzhKC4PcLtI4+QQ+70pp3vZ98=;
        b=phc+2PV4Ytq3dIUkrk0VxSTBa4A6k/dnqtRBCbpk+d/eW3lIArlg44IPF8llZz5bcj
         5oVIRSNoRGldZcjnDsNflpl+ybMlZ6Vp3nz3mKCyUS/O/yYqKp6jQh2yoNvRWRgOq/Kh
         ptG/jVjyVXM4IK8Wdax6ZxNZhMNLiynz+6lJO7Jiao7ZicST4kSbIdBb8obsNkR6DBVZ
         oJgxnJBe/ZfZckBv0VbYnpDhERknagdyFkxZZsrC7vouVAFGDvPoJG8ZWOfZsW8UGH3g
         LPNPitT+MbfBGoitcxtcTD1I+SpQeHwzCCkEQFGn00Y13ucZs+KK/47xMyL16rILUi6T
         2jpg==
X-Forwarded-Encrypted: i=1; AJvYcCWbFhL5oCc+0rVFp4o+NmML6GO0cH7eqzv6slNpw2M8rNLCqWV/YdY97ssHaM4Xa49NB8BcTT8SOBwbI/g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0LjxhBUoMxKF/s+Nxo/LWF4h1KYQpTBOXZRVmaNZkcYyT0kP4
	GHGygJIyI5XhIbnWHCyAEajS5RBroQM6L3F76bVZU5v99N00DfmtuWfLmJO07S8=
X-Gm-Gg: ASbGncuFcJFhVnoo2gfjnbwrz5ul4PT9XVeCH45l+iilw0pot4wl5eM7Y2CdCSnJB1/
	Zv427LwMwEImfaVH3rkCmLp3sCTG/yMOseJjM6d+Dw7gLcaydqYF4YUznzx980uHp47qDLkI6+W
	HZGBzrdIaCfpWk4uJy23/rajt0fp/agKYGbsDhyrNAMdmEgdI/kc+j3M9uaztEJOzhMLqR0H5iB
	Sj/UJ5oz2idWTMutZMcmmRan4FmieKm4I1PEevALnb1bHAg++9hXqogVtCbrg==
X-Google-Smtp-Source: AGHT+IF/x7LXkAXimyLkyfWi+pepsYvfRdlmpoLdzPWYXB9z1y+v2IhnIOSPg0r2ct1zfV9cRdMS6g==
X-Received: by 2002:a05:6402:43c6:b0:5d0:d845:2882 with SMTP id 4fb4d7f45d1cf-5d63c2c8e70mr2227780a12.13.1734099905774;
        Fri, 13 Dec 2024 06:25:05 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3e7349b44sm8530694a12.71.2024.12.13.06.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 06:25:05 -0800 (PST)
Date: Fri, 13 Dec 2024 17:25:02 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, Chen Yu <yu.c.chen@intel.com>,
	Yafang Shao <laoar.shao@gmail.com>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] kthread: Fix a NULL vs IS_ERR() bug
Message-ID: <64c234af-5141-4062-9170-2122c3edf088@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The kthread_create_worker_on_node() function returns error pointers,
never NULL.  Fix the check to match.

Fixes: e9853c812f86 ("treewide: Introduce kthread_run_worker[_on_cpu]()")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 kernel/kthread.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kthread.c b/kernel/kthread.c
index 83bf73d2355c..922f15762ec3 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -1124,7 +1124,7 @@ kthread_create_worker_on_cpu(int cpu, unsigned int flags,
 	struct kthread_worker *worker;
 
 	worker = kthread_create_worker_on_node(flags, cpu_to_node(cpu), namefmt, cpu);
-	if (worker)
+	if (!IS_ERR(worker))
 		kthread_bind(worker->task, cpu);
 
 	return worker;
-- 
2.45.2


