Return-Path: <linux-kernel+bounces-321773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E87F3971F47
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 18:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EC5D28708C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 16:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034F4166F26;
	Mon,  9 Sep 2024 16:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eTejcysy"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB32165F0B
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 16:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725899549; cv=none; b=fT9FpmyOdabQtlBc2kMqBU9fGBtC7EUKzlEPIsUiU0moD0nG5v9hz10VrsbdQF+rGBOBOYWfmWIhTZWT7uvRr9Cr0hm1+Ge2j4QapUc1GAFGVHbzYnbbQIs+Rn2MFlO4YPpIXSpb4ZvTZLvtDY+YHBo4WTxzFLLvWdsZE1zBOKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725899549; c=relaxed/simple;
	bh=5wi8Dcw3wd8SAW+yjS2gtvuUpo3vzMFwvlt6X1nV1HE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ka+7ru1N9TVZqTljiuoRc0bX2K1RPtpI48s+Y+VUuHN8S/6PjZ6uDXyyMAIR63Ka4G7kLYONI3FhzP/+/PEC1j366GFZ5fU6RCa486v4od83oiwb7fuP84tJvKqc+3MvbrWMCReufeqoC/Cq8B+uOCHPi5Sf2kQb/DfJMcdhXLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eTejcysy; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42cacabd2e0so24587195e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 09:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725899546; x=1726504346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qcEdQE9kkUNRmd1oSgPgT8tBtd/F56AnD10peYUx9eU=;
        b=eTejcysyVlGYCEHDZ4Lx3IWvY73sExclGQ0Lfu6SGEjAMvz+rDx0nqemrVY7OzGEXm
         vI/IAw0xT+hvV1wyyzGO8uNF4clDjkVTUrIe+gFfXqBbZE6BAtEvK6RtSOxFhjKyFxN3
         MNX/4i/pwigu5QVoroJr0P5HhTi2i8j9R165J7JkuW2zq0d5srrc73PCN8jWC/W4WAYx
         0cGTdJQUvVU5bvzrfV8M+BeAx3+N7bJ/JiHjE03VgXoiByOvfTrini/FaIj409EyNctP
         qYhlQzEjtZ60jgJ1E4Ch8iekHi7asfpokYK3qX1slxYVEwgUFxlOmKDZ6MIKERgsIRo6
         6FhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725899546; x=1726504346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qcEdQE9kkUNRmd1oSgPgT8tBtd/F56AnD10peYUx9eU=;
        b=VX95u+95tilMUyU0Ji9mCFmn/53lyw+a1WBjJdTUzVSfZwmpLeIwuh7gfWlI1djRI5
         0G1W8fIGRnWzw0/wcskm0kwoTJF3RBW0PIAiesSccAp5SCPKZd4ru07aalSwMCrEXhj5
         AfK/jwc2keJ3JNDW4oJMCibO3/RINZjqAOHNkn95tmEOy3F1XGjA8QS7Z9HA0Bbrj6UA
         nOcDbj8KuG7d3yx/VJuBwLIY3UHT58Qp17wwHX8ZimTsJZ/pTxaMYNfIZII04dUlrtl+
         6V3Ph9WbDxq9tDg6/gOPl6VTykyknGGTKR8uO/WwVFpl1hfSuV3V1trIBBpaHBsb6MOA
         R9VQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqLLXxtqIG29liHOWcCcscGJUXzj6Q4JSbG0I/sE8EDr/j83Mpvpynx26ZHFJLS5e7nkdSevopMmF1CD8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwENu8nm/X107LyVbuAzcFZPJKAhgraHkCBb+5TJKLH7GjLUWg
	96MxmVS6zHeoEzRwG/8ifFgNeKMcjjceh7X9sRh7tNvo8BdG5asK4uziW2KnsKE=
X-Google-Smtp-Source: AGHT+IFYKssoeiQ8071s5mgXvgeKUkJPqXfUO0b5wcMLkjdGWzc7MF/UiF8wCm6ppGL882KotfQOTg==
X-Received: by 2002:a05:600c:1c81:b0:42c:bbd5:af70 with SMTP id 5b1f17b1804b1-42cbbd5b273mr10759625e9.30.1725899545970;
        Mon, 09 Sep 2024 09:32:25 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3789564a072sm6478606f8f.2.2024.09.09.09.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 09:32:25 -0700 (PDT)
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
Subject: [PATCH 1/4] memcg: Cleanup with !CONFIG_MEMCG_V1
Date: Mon,  9 Sep 2024 18:32:20 +0200
Message-ID: <20240909163223.3693529-2-mkoutny@suse.com>
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

Extern declarations have no definitions with !CONFIG_MEMCG_V1 and no
users, drop them altogether.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 mm/memcontrol-v1.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
index 56d7eaa982741..db2ebf8bea6c5 100644
--- a/mm/memcontrol-v1.h
+++ b/mm/memcontrol-v1.h
@@ -140,8 +140,6 @@ static inline bool memcg1_charge_skmem(struct mem_cgroup *memcg, unsigned int nr
 				       gfp_t gfp_mask) { return true; }
 static inline void memcg1_uncharge_skmem(struct mem_cgroup *memcg, unsigned int nr_pages) {}
 
-extern struct cftype memsw_files[];
-extern struct cftype mem_cgroup_legacy_files[];
 #endif	/* CONFIG_MEMCG_V1 */
 
 #endif	/* __MM_MEMCONTROL_V1_H */
-- 
2.46.0


