Return-Path: <linux-kernel+bounces-228063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C9D915A5C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 01:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33CADB2211B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 23:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DFC1A2C06;
	Mon, 24 Jun 2024 23:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="T8ERIJuz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1BB1A08DF
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 23:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719271505; cv=none; b=eGlDf4WNmxjD/PZ43nPMuwzUUFStGO5pWVAdKCmB/FMXQJIML5afMgdSjhF0PIVxLrLenQLmCgEBpVG3WQYEYXQyFJOBKY04wUpXJVNi8wN4lPdkiLBRuk+v5AXMJ1apnOYSQlelU+1WjF1/Cetq7zDsR7/srlklikgKfCpitC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719271505; c=relaxed/simple;
	bh=WMMkwBu7WgtyE3mBCT8urby6K5l/l1sjpNKhe5d5cuQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=WAuJbZjPVoFUTlX57E7DMycF+7y9/lj6MOYb52G/R0lHkzHDIOmmUee5Qm+3XhFRYiBB3djt6ufmk5tPzd74AL+5FDJlc7gD5IJo1bWQVm+mDDluroVOV1GTEF8ggDkvg8c1OyCitJUR3tR2QLId0o8EJ0c4CNvCG4Uq0Y7VQxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=T8ERIJuz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EE4AC2BBFC;
	Mon, 24 Jun 2024 23:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1719271504;
	bh=WMMkwBu7WgtyE3mBCT8urby6K5l/l1sjpNKhe5d5cuQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T8ERIJuzx9qJP2atoIKP0PA74mxbs0eEjMG8JZo75ZA+1E+ZdedEOLqdyyoR0DiGr
	 STG+LrhnswZKNShrkelgPgVeYllhrNHENMB0Vr8KNYyoK6QlgSq95k9yxYp63bQyb8
	 Li0gV7qW0DHurH8J93K9tERZm0EduRUx+plt4Qk0=
Date: Mon, 24 Jun 2024 16:25:03 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Barry Song <21cnbao@gmail.com>
Cc: david@redhat.com, baolin.wang@linux.alibaba.com, chrisl@kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
 ryan.roberts@arm.com, shy828301@gmail.com, surenb@google.com,
 v-songbaohua@oppo.com, willy@infradead.org, ying.huang@intel.com,
 yosryahmed@google.com, yuanshuai@oppo.com, yuzhao@google.com
Subject: Re: [PATCH v2 2/3] mm: use folio_add_new_anon_rmap() if
 folio_test_anon(folio)==false
Message-Id: <20240624162503.61996134e5e148eea93960af@linux-foundation.org>
In-Reply-To: <20240622032002.53033-1-21cnbao@gmail.com>
References: <02b87f01-69c9-4007-b0d0-5ce9ce35876d@redhat.com>
	<20240622032002.53033-1-21cnbao@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 22 Jun 2024 15:20:02 +1200 Barry Song <21cnbao@gmail.com> wrote:

> > >
> > > Since this is primarily a documentation update, I'll wait for two or
> > > three days to see if
> > > there are any more Linux-next reports before sending v3 combining these fixes
> > > together(I've already fixed another doc warn reported by lkp) and seek Andrew's
> > > assistance to drop v2 and apply v3.
> >
> > Feel free to send fixup patches for such small stuff (for example, as
> > reply to this mail). Usually, no need for a new series. Andrew will
> > squash all fixups before merging it to mm-stable.
> 
> Hi Andrew,
> 
> Can you please squash this change(another one suggested by David)?

sure, but...

> From: Barry Song <v-songbaohua@oppo.com>
> Date: Sat, 22 Jun 2024 15:14:53 +1200
> Subject: [PATCH] enhance doc- mm: use folio_add_new_anon_rmap() if
>  folio_test_anon(folio)==false

The only description we have here is "enhance doc"

> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4346,6 +4346,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  		 * here, we have to be careful.
>  		 */
>  		VM_WARN_ON_ONCE(folio_test_large(folio));
> +		VM_WARN_ON_FOLIO(!folio_test_locked(folio), folio);

And these aren't documentation changes.  Please send along a small
changelog for this patch.


