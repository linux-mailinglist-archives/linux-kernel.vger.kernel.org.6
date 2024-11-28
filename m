Return-Path: <linux-kernel+bounces-424586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6D79DB652
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 12:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EDCD281072
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 11:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F05194A74;
	Thu, 28 Nov 2024 11:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xEdZLEK6"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F40B13A3F3
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 11:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732792381; cv=none; b=nqRbdRvMHuXAzkkuhUiJ8Dgvxk2+uKhtQqVO6iQ2tt1ZUkP02E+iCpcnhM3qR3CiRIjQ0m1L0VcFxYDAHlnsOYpGHa9MDqqyOsTaQnfH3iUtewsFhVqKCFrnv//7rlM3oqjaOv1YkGLt5979n/ef5Ip31OqazdDfYqPweSYcPZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732792381; c=relaxed/simple;
	bh=OoObH6wvD+y8f4IQZlNNL3LT0T39+wjdDoULtx4Ft5A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kyLrf4tPlhTvY//s8FIIVn2/o7NrJmVSDcvMh+gEI6JqeWiiAM55T3z6WcugMmc4Tf7sh1U+6ZTRENMDa/QXOziYA7ZhlNsBtglSB//pJNA1PrvQQxgRSIQaV5VYzwevI/cifVNUsskhqhC4gUiSSX8u3jyKYqa3/hhhxG3eoIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xEdZLEK6; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1732792375; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=auSYmrP4H1sEfPgq0w8ztv2jUfFB1qQmrkLw05UiALw=;
	b=xEdZLEK6E9JW/L56JG2LRKOzAVB1Ctd53a+cRqduZRJCmu+3KZMfoy4XixVlCEFDwjP829Rvb0oQbMwBG8k3IxKt7FqpkUWjpBKqEKAa6tWHjEaLcKSentWvmOZtJc2NX/h/8UI0QhhKinNzaghCvRTnlfCB+QdcvzBD6wT5Z04=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0WKPndYG_1732792332 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 28 Nov 2024 19:12:54 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org,  linux-kernel@vger.kernel.org,
  nehagholkar@meta.com,  abhishekd@meta.com,  kernel-team@meta.com,
  david@redhat.com,  ying.huang@intel.com,  nphamcs@gmail.com,
  akpm@linux-foundation.org,  hannes@cmpxchg.org,  feng.tang@intel.com,
  kbusch@meta.com
Subject: Re: [PATCH 1/4] migrate: Allow migrate_misplaced_folio APIs without
 a VMA
In-Reply-To: <20241127082201.1276-2-gourry@gourry.net> (Gregory Price's
	message of "Wed, 27 Nov 2024 03:21:58 -0500")
References: <20241127082201.1276-1-gourry@gourry.net>
	<20241127082201.1276-2-gourry@gourry.net>
Date: Thu, 28 Nov 2024 19:12:11 +0800
Message-ID: <87plmfeho4.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Hi, Gregory,

Gregory Price <gourry@gourry.net> writes:

> To migrate unmapped pagecache folios, migrate_misplaced_folio and
> migrate_misplaced_folio_prepare must handle folios without VMAs.

IMHO, it's better to use migrate_misplaced_folio() instead of
migrate_misplaced_folio for readability in patch title and description.

> migrate_misplaced_folio_prepare checks VMA for exec bits, so allow
> a NULL VMA when it does not have a mapping.
>
> migrate_misplaced_folio must call migrate_pages with MIGRATE_SYNC
> when in the pagecache path because it is a synchronous context.

I don't find the corresponding implementation for this.  And, I don't
think it's a good idea to change from MIGRATE_ASYNC to MIGRATE_SYNC.
This may cause too long page access latency for page placement
optimization.  The downside may offset the benefit.

And, it appears that we can delete the "vma" parameter of
migrate_misplaced_folio() because it's not used now.  This is a trivial
code cleanup.

> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---
>  mm/migrate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index dfb5eba3c522..3b0bd3f21ac3 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2632,7 +2632,7 @@ int migrate_misplaced_folio_prepare(struct folio *folio,
>  		 * See folio_likely_mapped_shared() on possible imprecision
>  		 * when we cannot easily detect if a folio is shared.
>  		 */
> -		if ((vma->vm_flags & VM_EXEC) &&
> +		if (vma && (vma->vm_flags & VM_EXEC) &&
>  		    folio_likely_mapped_shared(folio))
>  			return -EACCES;

---
Best Regards,
Huang, Ying

