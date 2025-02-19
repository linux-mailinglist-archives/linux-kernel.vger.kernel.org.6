Return-Path: <linux-kernel+bounces-522716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 180F6A3CDBA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 00:42:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C4203AD43E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 23:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84585253F27;
	Wed, 19 Feb 2025 23:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="t6oqhi3i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1F11DE4EF
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 23:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740008518; cv=none; b=gpt/NfcMENV7DnP/o2K8rxR1sDCGpq3i9jGWeLVNa6VYQolEAdLltnAP+x3llikY10KEMXls4AgmaEidOj5AAVmfGQqVLA1I/UuoonFdQeW07PXBzKrkRIymneoWZsW+BjdrvgW+6CT0hQhYIeExMhMKlWhSzjQsNascLBLQ5JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740008518; c=relaxed/simple;
	bh=LDESUJLpKBJ7BUJ0owRp+Iq4MOUFY1pC4SeiKR8t81g=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=rBbKMHoFxalsKLqs/Nix5ZZ55ZfyYOZOZvWz5xLn92scixbcTmY58C7XrUhnYfk6p2NkOdgOblR8XvnkatdQGE18zzNtGFPZ6rG4RgBJipduDCij24LP2PQ6/GdUQ4VoCIl7rnpJwIxSDjXFUH0kKH7CurD4rg1hBMkXsFvhT3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=t6oqhi3i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F406EC4CED1;
	Wed, 19 Feb 2025 23:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1740008517;
	bh=LDESUJLpKBJ7BUJ0owRp+Iq4MOUFY1pC4SeiKR8t81g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=t6oqhi3iKLF9yHUz6nqtd1KawfwqMaN6HwZRX9TWll83ZvHe/9pYhX1ZBs5QllDTj
	 nYVgyjiPw4p8SbO5qHwA8uv0dM8xpgOf7kw9OVLPSE7iHFphhfWi26p1XYlzlVgWib
	 xyozl5g0RzSbn9oFtlNNZLkQVCC5QEWzDKJg40P0=
Date: Wed, 19 Feb 2025 15:41:56 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Wupeng Ma <mawupeng1@huawei.com>
Cc: <david@redhat.com>, <osalvador@suse.de>, <nao.horiguchi@gmail.com>,
 <linmiaohe@huawei.com>, <mhocko@suse.com>, <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] mm: memory-failure: update ttu flag inside
 unmap_poisoned_folio
Message-Id: <20250219154156.2fa7e0f63838e80f8456f1d5@linux-foundation.org>
In-Reply-To: <20250219060653.3849083-1-mawupeng1@huawei.com>
References: <55e4ad74-752b-65c6-5ceb-b3a7fd7959a1@huawei.com>
	<20250219060653.3849083-1-mawupeng1@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Feb 2025 14:06:52 +0800 Wupeng Ma <mawupeng1@huawei.com> wrote:
>
> ...
>

Thanks, I queued the below fix, so people can see what changed from v2:

From: Ma Wupeng <mawupeng1@huawei.com>
Subject: mm-memory-failure-update-ttu-flag-inside-unmap_poisoned_folio-v3
Date: Wed, 19 Feb 2025 14:06:52 +0800

unmap_poisoned_folio(): remove shadowed local `mapping', per Miaohe

Link: https://lkml.kernel.org/r/20250219060653.3849083-1-mawupeng1@huawei.com
Fixes: 6da6b1d4a7df ("mm/hwpoison: convert TTU_IGNORE_HWPOISON to TTU_HWPOISON")
Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Miaohe Lin <linmiaohe@huawei.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/memory-failure.c |    2 --
 1 file changed, 2 deletions(-)

--- a/mm/memory-failure.c~mm-memory-failure-update-ttu-flag-inside-unmap_poisoned_folio-v3
+++ a/mm/memory-failure.c
@@ -1585,8 +1585,6 @@ int unmap_poisoned_folio(struct folio *f
 	}
 
 	if (folio_test_hugetlb(folio) && !folio_test_anon(folio)) {
-		struct address_space *mapping;
-
 		/*
 		 * For hugetlb folios in shared mappings, try_to_unmap
 		 * could potentially call huge_pmd_unshare.  Because of
_


