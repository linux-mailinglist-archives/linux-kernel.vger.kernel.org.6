Return-Path: <linux-kernel+bounces-556945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46968A5D140
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 21:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C299A189DDF8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 20:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56D2264A7F;
	Tue, 11 Mar 2025 20:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nCEuXvlI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AA21EEA42
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 20:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741726497; cv=none; b=XlEMixtWYcPUbVUtm9S4E4mOz6nETWF1rTKfUeYdHyCZSfpgf+kdBZ4e6CKShqGM2POvCBnwD9+8bG4rUWUdiruqWQwZllcMa35+WkgqeThELMWRkkJz8MvwUs6MtlY0cj75SbbKHTjbsh0d1/zm1kvGA8Inl9y4lJTTFIo50cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741726497; c=relaxed/simple;
	bh=TzN4LNJKffjQiREVo1HUuDuM9wbToU+KqxW8vsljPSM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m0eyhYV4IFFYJ7F7PjvxTwhJ3ee7aC+YuI7/dPGIPrQC9kH+iwuZCX9z6k8paw/dd8vchldA/4wvWZ0z6WdEzjsJ56StAFwQpnBXxFBkht5r/FnQ2lOj+0irfvtzmMAj6deC0JIWOy9kPekwAMyKKWAHN/mLIGgvKEvvL3o6Xz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nCEuXvlI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C7C1C4CEE9;
	Tue, 11 Mar 2025 20:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741726496;
	bh=TzN4LNJKffjQiREVo1HUuDuM9wbToU+KqxW8vsljPSM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nCEuXvlI90Che7cF5uy2sAyIgOtY3koGKLdjSA9Xz45+5DBS7hzSv8eDLOggxcVbu
	 Wz3hY/ZrWFzDf5bM/xNH3xdVPCKakaSZYY5hEICYrcKjOrnv1/vIHthgwB7aniAomL
	 QKx7OIqiYPr6UJUaxBrxL0O/ayMNHSiwepNhlv65kMtfTaqJKjaNkDelJkXi4+L/3e
	 qPP+1N3xux0oX6pGlYsoExPIS2ZilkwtgDkbzTINnP65fz+rRhf6/xxfoIvubXLXPC
	 uVJTWa4FpJB5knpiG1KJl5kDkKdtNnWMG+QL59MZ5D1hNBxNiD5RqYckuh0qPojum2
	 URfmbWb6Umh7A==
From: SeongJae Park <sj@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <howlett@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 3/9] mm/madvise: deduplicate madvise_do_behavior() skip case handlings
Date: Tue, 11 Mar 2025 13:54:53 -0700
Message-Id: <20250311205453.85220-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <45ce499d-27a8-45ba-9644-67cfb73e489a@lucifer.local>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 11 Mar 2025 12:02:48 +0000 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> On Mon, Mar 10, 2025 at 10:23:12AM -0700, SeongJae Park wrote:
> > The logic for checking if a given madvise() request for a single memory
> > range can skip real work, namely madvise_do_behavior(), is duplicated in
> > do_madvise() and vector_madvise().  Split out the logic to a function
> > and resue it.
> 
> NIT: typo :)
> 
> >
> > Signed-off-by: SeongJae Park <sj@kernel.org>
> 
> madvise_set_anon_name() seems to do something similar, but somewhat
> differently... not sure if you address this in a later commit but worth
> looking at too!

Thank you for sharing the good finding!  I don't have a plan to address that
for now.

> 
> Anyway this seems sane, so:
> 
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Thank you for your review!

> 
> Note nits!
> 
> > ---
> >  mm/madvise.c | 53 +++++++++++++++++++++++++++++-----------------------
> >  1 file changed, 30 insertions(+), 23 deletions(-)
> >
> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index 611db868ae38..764ec1f2475b 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -1640,6 +1640,27 @@ static bool is_valid_madvise(unsigned long start, size_t len_in, int behavior)
> >  	return true;
> >  }
> >
> > +/*
> > + * madvise_should_skip() - Return if an madivse request can skip real works.
> 
> NIT: 'real works' sounds strange.
> 
> I'd say something like 'if the specified behaviour is invalid or nothing
> would occur, we skip this operation. In the former case we return an
> error.'

Thanks for this nice suggestion.  I will updte so in the next version.


Thanks,
SJ

[...]

