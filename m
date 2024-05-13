Return-Path: <linux-kernel+bounces-177281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5135B8C3C5B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 09:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B8082818F4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 07:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA71146D6A;
	Mon, 13 May 2024 07:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKF2Ff0W"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADF5146D66
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 07:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715586488; cv=none; b=cb2wQkThtDFFMoMDQpo9/nKyAGyrw+E0mgJKz7Tz7cBkLgqvHx5PqQ+U8qEQTOWj5C0B9li8C4Bg2TyghFKF0nY32MiNMcu/ZwuXO+SCVDSTR9M5sIvvsL734uR5B8UwOWAlU7iwgaF7Nw5hnyfpb4XjItmFlAbgFlCckEDYmbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715586488; c=relaxed/simple;
	bh=LVB2t4hgTGzc+6gDjDH8VhApIuASOYTgUThH5iWUziQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EYoE6Cszacf+OtTFL3NbGgI2nWE49ZwvbMKO1wWmDyhiMP+05HfU3IGgsyPgOL4+leNjgZMG/sUglrDhHZkNIgFv/FrOzkOaDXZomWkWt9ZU7N9Ie/GM9x4laMd/LQViKNGl6ZQkk3Mhlq5iG8c8txjuwLUAtELOqPvnoAkj1hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jKF2Ff0W; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6f467fb2e66so3626615b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 00:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715586487; x=1716191287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d2aMd7RSjLCt9aorWWhiNJrgbBDqFo4vIbYySyvRoqM=;
        b=jKF2Ff0WZPWRrdxB2ov0xTz8MUGzvdASzOVjLD6d761pjJGDCxRnUE6xATosuFCXFk
         OQC2+1bNp+MYnVNg/3ttBa1bG7fIMq5F7cRlMWH/AIhW4+TgtUIHOKBWQFyDCd//xMMp
         c9uNMxI4uMKfJ1Msu8eUAUeppv1IV0sC+BH7yRHfPYU7rUm0itBYvszJXZ8T3xBJZVNJ
         4fBzyznrE8/p08zJxrTuQRWnQ93SaeFvaUINESS7aGYQm/krPfG5hf8wGxiLOKjUbOA7
         NgpCMKzWpoug5d59ZqWsjUUkxoa83Q5cIqqKjghWfp3jZ2/MZxmTYkdljaMKhHzQlHfd
         XXSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715586487; x=1716191287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d2aMd7RSjLCt9aorWWhiNJrgbBDqFo4vIbYySyvRoqM=;
        b=INbFy8hh6guiaoVA6VnZEJ++zdUyaIdQUtsKt3jIqnZaFTX1RWRG5NjVxozyr8jqDv
         0i6Bv5PN4RZWCvni7pP9uiI65PDDI+eu3c6nEHX6waHwzsfilugKJwWP/Z6i+vVpviUR
         oeFzC5rNgU5lQBcw+13B2wCCMp7/MfphJ48AcyrmAjJJkNqBUqpmqGpdZX5sQ9sNlhdj
         NWq54FQgteFtnV955aF6io9UE5x08GH3aVrWlS+uVqz2XKsvv/1B1DfY+8K82LFzzVwh
         OISnRCitFZXMiKLibaKGZNnF775Inv5O12hTl4v81ZG193DaWW9miHMcCI4QG8a2hVnm
         C95g==
X-Forwarded-Encrypted: i=1; AJvYcCUZKj75g4DfwT+8m55BQFhSgb0a9oYT/MaMpER58f68qLvaF7Z64knHDkhIMej4n0948X5DtDCC2/58iyNu8PwlLzw4M8YULmgZvxVq
X-Gm-Message-State: AOJu0YxVGpb7GyCNgnfsC0eFrTbbczuRj7FpcC8YXelMsezdE+Jpwb78
	pr1P/tUX2JJUR2lJy0sZKcs7E/EHLiooH9iCck42E4xKmu4Oxj+q
X-Google-Smtp-Source: AGHT+IFpk9hHf0b9JsRoNRMxoqauhjaBA5WO539N9iC0llVow5ZRKrgoRxRAavfqAmqPSX2Tdv4EqQ==
X-Received: by 2002:a05:6a00:2195:b0:6ec:f28b:659f with SMTP id d2e1a72fcca58-6f4e02988b7mr11861591b3a.3.1715586487009;
        Mon, 13 May 2024 00:48:07 -0700 (PDT)
Received: from LancedeMBP.lan.lan ([2403:2c80:6::304b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a66621sm7008967b3a.13.2024.05.13.00.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 00:48:06 -0700 (PDT)
From: Lance Yang <ioworker0@gmail.com>
To: akpm@linux-foundation.org
Cc: willy@infradead.org,
	sj@kernel.org,
	baolin.wang@linux.alibaba.com,
	maskray@google.com,
	ziy@nvidia.com,
	ryan.roberts@arm.com,
	david@redhat.com,
	21cnbao@gmail.com,
	mhocko@suse.com,
	fengwei.yin@intel.com,
	zokeefe@google.com,
	shy828301@gmail.com,
	xiehuan09@gmail.com,
	libang.li@antgroup.com,
	wangkefeng.wang@huawei.com,
	songmuchun@bytedance.com,
	peterx@redhat.com,
	minchan@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Lance Yang <ioworker0@gmail.com>
Subject: [PATCH RESEND v5 3/4] mm/mlock: check for THP missing the mlock in try_to_unmap_one()
Date: Mon, 13 May 2024 15:47:11 +0800
Message-Id: <20240513074712.7608-4-ioworker0@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20240513074712.7608-1-ioworker0@gmail.com>
References: <20240513074712.7608-1-ioworker0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TTU_SPLIT_HUGE_PMD will no longer perform immediately, so we might
encounter a PMD-mapped THP missing the mlock in the VM_LOCKED range
during the pagewalk. It's likely necessary to mlock this THP to prevent
it from being picked up during page reclaim.

Suggested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Signed-off-by: Lance Yang <ioworker0@gmail.com>
---
 mm/rmap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 4c4d14325f2e..08a93347f283 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1671,7 +1671,8 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 		if (!(flags & TTU_IGNORE_MLOCK) &&
 		    (vma->vm_flags & VM_LOCKED)) {
 			/* Restore the mlock which got missed */
-			if (!folio_test_large(folio))
+			if (!folio_test_large(folio) ||
+			    (!pvmw.pte && (flags & TTU_SPLIT_HUGE_PMD)))
 				mlock_vma_folio(folio, vma);
 			goto walk_done_err;
 		}
-- 
2.33.1


