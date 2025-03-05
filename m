Return-Path: <linux-kernel+bounces-547451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8DEA5095C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F8B71683C5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 18:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17CE9252900;
	Wed,  5 Mar 2025 18:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sAXZYSeA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D6F250C1A
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 18:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741198581; cv=none; b=qTxQIwM9qxBGO1bCeB4RgcCsbcchHSmoXtiuMMS7nksl2MQFs1Wsbt7yWbS7XfchCkQxAhg/pFxMMqJ6/NWK9Cz6SxuK8UNJDr0D+HGNOcss5NwwvpG45md6DaM2QcugVY4nRxfi4ptwGP6555nbr6Uz76X7lXRXCc3mMGUoSWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741198581; c=relaxed/simple;
	bh=sHWxz+0ShuFmutLGSt5hwCRMCNmucoCWmOorPvlaBq4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fHkWJJaGj0EMltqiX6SMf0pbVoSVmSag6Fr+DRG6uaogn652QPzsqNU2rpG65RdSmRIDiGbC7OBRIFmzAd5uqbKXi6H+7rwXxKD2kDRrrPxciuuzxk7FX49q/BBbSrgFmcpYVU8IPWMFWt6zfNoY2D5gsN9q/6XExdsAB2cab38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sAXZYSeA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1394DC4CEE2;
	Wed,  5 Mar 2025 18:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741198581;
	bh=sHWxz+0ShuFmutLGSt5hwCRMCNmucoCWmOorPvlaBq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sAXZYSeAbWhcz5LT0yvaAeEsnGtslYmnxLZZlGzmNk7/NTF1qAvm5yqfjEVeO9TdV
	 Rif5lZv9l5yNiQTVhD7iR1rKRmVhxb6x0f7AtA5o+dDIi8dxA8k5+/hJNfj3M46CWo
	 sitQN1QOJpXhDlw8MsqtGOU9rDauvpS566PKb/egzlDjOjw5HOOykW0p+6aaUy4+ZO
	 MEFOD269bYvOMYz51UGc+NTi+U4dipo10wu5Cn47Yt7HxeoiYcEFt2g0Rr6CkLSXel
	 R0AqI1OIzw8RiD5YCnRDB4PBzWL61je0d7EWQu7B8vxEk05bBfernmks5BaYa+d+GT
	 f/9hPYOZmRYjA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <howlett@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 01/16] mm/madvise: use is_memory_failure() from madvise_do_behavior()
Date: Wed,  5 Mar 2025 10:15:56 -0800
Message-Id: <20250305181611.54484-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250305181611.54484-1-sj@kernel.org>
References: <20250305181611.54484-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To reduce redundant open-coded checks of CONFIG_MEMORY_FAILURE and
MADV_{HWPOISON,SOFT_OFFLINE} in madvise_[un]lock(), is_memory_failure()
has introduced.  madvise_do_behavior() is still doing the same
open-coded check, though.  Use is_memory_failure() instead.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/madvise.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 388dc289b5d1..dbc8fec05cc6 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1640,10 +1640,8 @@ static int madvise_do_behavior(struct mm_struct *mm,
 	unsigned long end;
 	int error;
 
-#ifdef CONFIG_MEMORY_FAILURE
-	if (behavior == MADV_HWPOISON || behavior == MADV_SOFT_OFFLINE)
+	if (is_memory_failure(behavior))
 		return madvise_inject_error(behavior, start, start + len_in);
-#endif
 	start = untagged_addr_remote(mm, start);
 	end = start + len;
 
-- 
2.39.5

