Return-Path: <linux-kernel+bounces-243364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E2092953F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 23:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9BD51F21734
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 21:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C1122F11;
	Sat,  6 Jul 2024 21:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NVBSGusk"
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244FC17FE
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 21:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720301355; cv=none; b=q4lMtwT1vxY57MPBDE0+aQ6PlyoAuxENXOcCEPLGv4PskKf5otITZDKocIry+6fWm2uzJiuBEUqMOkWtplsRDju4JCZLuskD8RLlpyrTbij07s0AZmyzGJ52SE4eHbVkYOmjYAFzE09bmIzCvb2RJSmtB6CX7iVVVYzAstp8muo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720301355; c=relaxed/simple;
	bh=jdFXfcUQPuMYG8YSCp64iIiXJWjhTE6lvoXo6ybJ1Pk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ABQ+dUPbEwxTfBBd6KI77siMwMTeG1B5Z1ROrao1MYox/DwXyoyxk/C/H91Qzrdg3Y5yw0Xy0liyjT+sdnEQ5xxoBzrODuteZQHNtTuPmrsMNObQ1PvQnh6otv8Du1LTuqd8iMIf1N1nlZffpgPtdsRBQAhXWCONDvxVh9qhj1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NVBSGusk; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7035d5c08a8so753121a34.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jul 2024 14:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720301353; x=1720906153; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ue8gY35brEYBVWt8FyxwSeAIH2C+YwAP5qKojzB01cI=;
        b=NVBSGusko5T6/mSh9sTNHrcNKCLYDLPevlEvXuT4qG6PmUxhnY3Thjl856StJgFQGV
         HOiXtOjJ71/9c8+6mGpTbdXuIMb6rZ5PRLOAL2Vtv9yrUouE5lBrln4hRxQp/1EyURdA
         y+9RZWwK40+XTsSrVA7EDVJvrpcU1HUyTPjdciMlxpgRhdUOzlAGOphRpOREfZeoPHqm
         zJCC92+nGX3DYoXU1MOqdzsdIs5/lLai9SzBX2YPin0i1y3RfDm1EuU2SIvRIBRoKI+e
         lglXX2p0H332lfLb7R4dG+Ce3K7x6+v0cMSP88XPcQZE2qjbpCkCoJ8732jqbrJTzFFP
         9kug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720301353; x=1720906153;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ue8gY35brEYBVWt8FyxwSeAIH2C+YwAP5qKojzB01cI=;
        b=nnYtjDOr+t2lUeeTAvKSaypBTIKnFuHMMkQGPHI/3g367uwqh249LjEoQU43ppUS/a
         pmRW+gAQwjJONV6/EZ+Q4QzuQzX9ZI6j4dZWTl8W/Y3rigxQ8QG97eSSpnXBKBHqTKJg
         pWC8gVdUnm+vFkt13pv06EhQ0mOb+FsR5PDK0drNHEKHihl3fWACLrKPmVPwWi1XdX3L
         nDL4pi6tse4LXzm9rqvb13QdpfBNIaMnrfyVRehVKmZ7EuUgPOMh522lkkRp6Qz3Wu4S
         y8ECj7JUJiVYH/ZZMn2TTmJQ3JgCQXRu8x7tW9OIt/AkFIsPJL2WSYQI7DolMVG2UO6K
         i6wg==
X-Forwarded-Encrypted: i=1; AJvYcCULQQ0z7AMOc9auTgtyJortcfJLYTjXkG3yYvH04JSXZ/j0Slvdn8nMr1VyTivA17+Sfa3XlfS6AL52ifnaMfN4YLc/m7nhVPaBJxkS
X-Gm-Message-State: AOJu0YwTGiLwH4q26fbMIj4+8NAWQRDdzlZ6mMeGA0dqftPMGpI/nT7K
	NDm3NdMhndF0Ficu+EsAVrjfab2GjFhHShIUzkzZ1j8hPMFvTD00qhsVfs4Q/w==
X-Google-Smtp-Source: AGHT+IGHrlPCBl63akfzuRCMp6XLRSgTopTU+czREYQwtTu7G1RfFozNSVFeOgW1nhmv4D6E1jZ+EA==
X-Received: by 2002:a05:6870:eca0:b0:25e:1c9d:f180 with SMTP id 586e51a60fabf-25e2bf2aed9mr8482336fac.50.1720301352822;
        Sat, 06 Jul 2024 14:29:12 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25e71070ba1sm307134fac.34.2024.07.06.14.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 14:29:11 -0700 (PDT)
Date: Sat, 6 Jul 2024 14:29:00 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Kefeng Wang <wangkefeng.wang@huawei.com>, 
    Andrew Morton <akpm@linux-foundation.org>
cc: Hugh Dickins <hughd@google.com>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, Nhat Pham <nphamcs@gmail.com>, 
    Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>, 
    Barry Song <baohua@kernel.org>, David Hildenbrand <david@redhat.com>, 
    Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, 
    linux-mm@kvack.org
Subject: Re: [PATCH hotfix] mm: fix crashes from deferred split racing folio
 migration
In-Reply-To: <7b7f2eb7-953a-4aa0-acb0-1ab32c7cc1bf@huawei.com>
Message-ID: <68feee73-050e-8e98-7a3a-abf78738d92c@google.com>
References: <29c83d1a-11ca-b6c9-f92e-6ccb322af510@google.com> <20240703193536.78bce768a9330da3a361ca8a@linux-foundation.org> <825653a7-a4d4-89f2-278f-4b18f8f8da5d@google.com> <7b7f2eb7-953a-4aa0-acb0-1ab32c7cc1bf@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 4 Jul 2024, Kefeng Wang wrote:
> On 2024/7/4 11:21, Hugh Dickins wrote:
> > On Wed, 3 Jul 2024, Andrew Morton wrote:
> >> On Tue, 2 Jul 2024 00:40:55 -0700 (PDT) Hugh Dickins <hughd@google.com>
> >> wrote:
> >>
> ...
> > 
> > And perhaps a conflict with another one of Kefeng's, which deletes a hunk
> > in mm/migrate.c just above where I add a hunk: and that's indeed how it
> > should end up, hunk deleted by Kefeng, hunk added by me.
> > 
> >>
> >> --- mm/memcontrol.c~mm-refactor-folio_undo_large_rmappable
> >> +++ mm/memcontrol.c
> >> @@ -7832,8 +7832,7 @@ void mem_cgroup_migrate(struct folio *ol
> >>     * In addition, the old folio is about to be freed after migration, so
> >>     * removing from the split queue a bit earlier seems reasonable.
> >>     */
> >> -	if (folio_test_large(old) && folio_test_large_rmappable(old))
> >> -		folio_undo_large_rmappable(old);
> >> +	folio_undo_large_rmappable(old);
> >>   	old->memcg_data = 0;
> >>   }
> >>
> >> I'm resolving this by simply dropping the above hunk.  So Kefeng's
> >> patch is now as below.  Please check.
> > 
> > Checked, and that is correct, thank you Andrew.  Correct, but not quite
> > complete: because I'm sure that if Kefeng had written his patch after
> > mine, he would have made the equivalent change in mm/migrate.c:
> > 
> 
> Yes,
> 
> > --- a/mm/migrate.c
> > +++ b/mm/migrate.c
> > @@ -443,8 +443,7 @@ int folio_migrate_mapping(struct address_space *mapping,
> >    }
> >   
> >   	/* Take off deferred split queue while frozen and memcg set */
> > -	if (folio_test_large(folio) && folio_test_large_rmappable(folio))
> > -		folio_undo_large_rmappable(folio);
> > +	folio_undo_large_rmappable(folio);
> >   
> >    /*
> >     * Now we know that no one else is looking at the folio:
> > 
> > But there's no harm done if you push out a tree without that additional
> > mod: we can add it as a fixup afterwards, it's no more than a cleanup.
> > 
> Maybe we could convert to __folio_undo_large_rmappable() for !maping part,
> which will avoid unnecessary freeze/unfreeze for empty deferred
> list.
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index ca65f03acb31..e6af9c25c25b 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -412,10 +412,11 @@ static int __folio_migrate_mapping(struct address_space
> *mapping,
>         if (!mapping) {
>                 /* Take off deferred split queue while frozen and memcg set */
>                 if (folio_test_large(folio) &&
> -                   folio_test_large_rmappable(folio)) {
> +                   folio_test_large_rmappable(folio) &&
> +                   !data_race(list_empty(&folio->_deferred_list))) {
>                         if (!folio_ref_freeze(folio, expected_count))
>                                 return -EAGAIN;
> -                       folio_undo_large_rmappable(folio);
> +                       __folio_undo_large_rmappable(folio);
>                         folio_ref_unfreeze(folio, expected_count);
>                 }
> 

What you show above is exactly what I had when I was originally testing
over the top of mm-everything (well, not quite exactly, I don't think I
bothered with the data_race()). But I grew to feel that probably everyone
else would be happier with less of those internals _deferred_list and
__folio_undo_large_rmappable() spread about.

There are many ways to play it. I had also considered doing it Zi Yan's
way, freezing always in the !mapping case as well as in the mapping case:
what overhead it adds would probably get lost amidst all the other overhead
of page migration. It will not be surprising if changes come later requiring
us always to freeze in the anon !swapcache case too, it always seemed a bit
surprising not to need freezing there. But for now I decided it's best to
keep the freezing to the case where it's known to be needed (but without
getting into __s).

Many ways to play it, and I've no objection if someone then changes it
around later; but we've no need to depart from what Andrew already has.

Except, he did ask one of us to send along the -fix removing the unnecessary
checks before its second folio_undo_large_rmappable() once your refactor
patch goes in: here it is below.

[I guess this is the wrong place to say so, but folio_undo_large_rmappable()
is a dreadful name: it completely obscures what the function actually does,
and gives the false impression that the folio would be !large_rmappable
afterwards. I hope that one day the name gets changed to something like
folio_unqueue_deferred_split() or folio_cancel_deferred_split().]

[PATCH] mm: refactor folio_undo_large_rmappable() fix

Now that folio_undo_large_rmappable() is an inline function checking
order and large_rmappable for itself (and __folio_undo_large_rmappable()
is now declared even when CONFIG_TRANASPARENT_HUGEPAGE is off) there is
no need for folio_migrate_mapping() to check large and large_rmappable
first (in the mapping case when it has had to freeze anyway).

Signed-off-by: Hugh Dickins <hughd@google.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
---
For folding in to mm-unstable's "mm: refactor folio_undo_large_rmappable()",
unless I'm too late and it's already mm-stable (no problem, just a cleanup).

 mm/migrate.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -443,8 +443,7 @@ int folio_migrate_mapping(struct address_space *mapping,
 	}
 
 	/* Take off deferred split queue while frozen and memcg set */
-	if (folio_test_large(folio) && folio_test_large_rmappable(folio))
-		folio_undo_large_rmappable(folio);
+	folio_undo_large_rmappable(folio);
 
 	/*
 	 * Now we know that no one else is looking at the folio:
-- 
2.35.3

