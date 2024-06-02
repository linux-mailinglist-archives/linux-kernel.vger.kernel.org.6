Return-Path: <linux-kernel+bounces-198224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFE08D7525
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 14:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 840081F218A2
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 12:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626C6376EC;
	Sun,  2 Jun 2024 12:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9NyiqJr"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72909381B8
	for <linux-kernel@vger.kernel.org>; Sun,  2 Jun 2024 12:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717329622; cv=none; b=QWO4OVpGFuT5KW8bMl9bpRx8YFGkG2zvUJWTyYvxTkI4h23GEjF6S+4zwuRChrX7cShg0/OwmrjvJCoUtK+Nx9OqYxTG1UNjT8AQXOkmsrw5JTCRMTTrUxPbwVhgfjgW0osTBo98gAF3lXenZ+iU7hYdmWOXeoZ7F8PS7PIze6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717329622; c=relaxed/simple;
	bh=CHVtnpg3uCqxc9bMDs1cBsccakyGZI17Hop+IfNVdfU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=foOPkrZdomHl8s67Bjl98SDOooAR+Dazv9iAHngIbXlZbaqu5fBYz65bQgbm+DFXLWp9opnl2XTfLsFsfxsYdflC+kubzv9nmhEcL1Z3r5vJkQUps2zDBqtq4ZUEzcQ+suH7WKBaBdwoUWYNGDD7knlvEwFou+WwkUpkiLCfqQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i9NyiqJr; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1f630e35a01so19012685ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2024 05:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717329621; x=1717934421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XL/a/t0HNCjbSIN7BOvuvI2I2oiI7guAXKEDmSOgeTg=;
        b=i9NyiqJrbu87Fds8B5iRqJn1W1mt34uu9s3juLbf81LPLkIo+rNSWGixX700f/qBXN
         bTmZs5Xdr2h9wZ/K4I5dA0mVTsKXkzTAuvtYvnZ3fi5A6upvPvPDqrKM+jj8x3y/cTjI
         Hi383MKF8p6k5nMelbQsKXlH7U+odoTO8ZVbp9VWa6fFfPv3JkIDzEbu04fYO8AS8RVe
         Sl+D7QDgyrA7S5q3RbYo5BAbUMJONk3MBMi3rNMgIMlNBLsXmyGhbsmpvLZ3Hgqo3ZQe
         +BIHvXIdDKHa1ZqZ0hmdrY510XlrfF9zDPWI/U5IYDakQudfHr1L9Wsx0gSzw7wlfGfU
         nrQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717329621; x=1717934421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XL/a/t0HNCjbSIN7BOvuvI2I2oiI7guAXKEDmSOgeTg=;
        b=MDGF9E+4/8Rt1PFUVwvf/x2P9mInNLJypBJWQAv/XeFIyRM5WfnvGYngR7/+XIlgV/
         wmIugXbDW/Ho5MS3WwdeMrcLnH8BRKtutDV24BY6oG7qkoT672d7g/IsOrYX1rO83WKJ
         pAVJWHCXyrK4yPG80srrV7KVdKC9//jX3OUmVgIkSP9tWJ9NbgfyhU+p7qiHXqrPTZPM
         NMBI9epfQth+WsEFbfbaLRqipzhv9bLWXQg+tih7x7XKefp5pqzcZ/ta7+XnjeswP1E5
         vYeoGQTrzVVeH2K3nppRZEBxX5DyK3+nvIImPTRlohsxYUgvLXFdzI3qFQQzbMDGPuSd
         TZUw==
X-Forwarded-Encrypted: i=1; AJvYcCVRz02nNtgfPZ4DCCJ4JEGUDas1HRkn+4CLtcBG/KUUQa41RAA7x6fdpvDMMWZ/7QLqCtoNldLSOhkBuQeX7Kudu0uQW5/gC+KdLO5b
X-Gm-Message-State: AOJu0Ywqeh2T2HKLiSmmQyxmF71358PNSRuUOK2urINYWRkBpRkfc04s
	k0CFQ8psjFSk0jvD9Af2iAv+wf7LzjzQBxQgHmSUSf9JFEli8QST
X-Google-Smtp-Source: AGHT+IF8WFkaK3EXTkxUu6gRPru1fAOvWM2c0mlQjQmyQnj2zt8/lLuvAtw7w0j0TNqvI1WsRBkJKw==
X-Received: by 2002:a17:902:dac1:b0:1f6:1c1f:f31f with SMTP id d9443c01a7336-1f6370bf132mr85003295ad.64.1717329619913;
        Sun, 02 Jun 2024 05:00:19 -0700 (PDT)
Received: from LancedeMBP.lan.lan ([2403:2c80:6::3038])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323f6d97sm45919145ad.218.2024.06.02.05.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jun 2024 05:00:19 -0700 (PDT)
From: Lance Yang <ioworker0@gmail.com>
To: roman.gushchin@linux.dev
Cc: akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	mhocko@kernel.org,
	muchun.song@linux.dev,
	shakeel.butt@linux.dev,
	willy@infradead.org,
	Lance Yang <ioworker0@gmail.com>
Subject: Re: [PATCH v1 13/14] mm: memcg: put cgroup v1-related members of task_struct under config option
Date: Sun,  2 Jun 2024 20:00:04 +0800
Message-Id: <20240602120004.62824-1-ioworker0@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20240528214435.3125304-4-roman.gushchin@linux.dev>
References: <20240528214435.3125304-4-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Roman,

I noticed that you changed '#ifdef CONFIG_MEMCG' to '#ifdef CONFIG_MEMCG_V1'.
However, it seems like the comments for the corresponding #else and #endif were
not updated accordingly.
 
It might be something like:

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index ba55ebd15354..796cfa842346 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1883,7 +1883,7 @@ static inline void mem_cgroup_unlock_pages(void)
        rcu_read_unlock();
 }

-#else /* CONFIG_MEMCG */
+#else /* CONFIG_MEMCG_V1 */
 static inline
 unsigned long memcg1_soft_limit_reclaim(pg_data_t *pgdat, int order,
                                        gfp_t gfp_mask,
@@ -1922,6 +1922,6 @@ static inline bool mem_cgroup_oom_synchronize(bool wait)
        return false;
 }

-#endif /* CONFIG_MEMCG */
+#endif /* CONFIG_MEMCG_V1 */

 #endif /* _LINUX_MEMCONTROL_H */
---

Thanks,
Lance

