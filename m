Return-Path: <linux-kernel+bounces-288647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A24CC953CF0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 23:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B12F28632B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 21:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE2915442A;
	Thu, 15 Aug 2024 21:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYpmx/rQ"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D271815380B
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 21:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723758808; cv=none; b=LcyVCUXkWVGSWtPXwA83+itOats+pCYad44AwNTqX+ysxkQsAMdNpgjcCHKtHab6azxQBMvSaHMORFe0tdv+OFoQZzQnHluzhIcH/bNMifpHzoDmzagMfd1aZ40ls6bUM7F0ba0C4DMSBBsBH0Ms49k5fKqR70X58jHFxRgN3yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723758808; c=relaxed/simple;
	bh=78bx67Tet1c+c8KNfs9+WIOpJSt0ODviPpxiWkk6FO8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iHWuWLYCTBxcIVh0mtq+6Qqwc1IvO1VeHg+z/u2Je03CKx8eLM+ppwiYWYFY9kRH/2lDO+/i/mk7shwbSjDWmd52y5A0V5EgFbsP1Pfuhg9a/2WV0uGhd3sIZuTCR+tZQwjFRPJTvOF18bDRS3M3wPyMDW014gMFluxNNg/poE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HYpmx/rQ; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3db51133978so873161b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 14:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723758805; x=1724363605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8zJpy/IyCPqQzjs+ERcVL5gW6xIYZ4aJwCr3Umsn95I=;
        b=HYpmx/rQugw3JtS2RzUJwP3iMZmNU824VoOoed1tBCIEEe17neZfunt7/vSLr8A1Aq
         nKfSrrOdxuhf+qoIz+LzbnDtukUnIo2fV/wtS50ythGuuunhodHSeQ1DrMMVKoLIStdG
         IQ3ipJJQdDm7PpaZ88cyAzCISWmKPQglbesZmAU3I2BaL3EK1ucpp0fBbH34I3zDCV/j
         HQ7Kl9GItIhq2M7e88vgOqsDJuBfSGFiZWsl2egPmVgR9pFGl4hRfh4+jgYpp46h3mjE
         nn3oBctLPlk5R6jTOyRNju4F3KVTxLZQ6roBuVeu4t5L6PUhqI1SA6jZzrFdEFpUHYGu
         Z2ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723758805; x=1724363605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8zJpy/IyCPqQzjs+ERcVL5gW6xIYZ4aJwCr3Umsn95I=;
        b=nrtsGJ6z/GwdQdITkW3Z5sYZSNGwNup3hHB68SeZsilUXhYQTN0kpDyhVUlriCjKY1
         bjwyyGVZeZBeUjrmPEtfy/ztCMv5SirLBczScXGpdehGmrlFRY24Y/WJFgGickInDePi
         F8zQct/5O+0z7i9trHbM159vcbqSJxtpv9RZslLEzoyuoZkmIWczoLbBxcmYKezA7lHJ
         gDI831WZYahE1ZYuLzujGiULQQxUpCiXHB+ypXRYIEsbA2cnHava+HvW7kpyRGW3Uo+8
         6ibP13V+w3aT7CBmolcTL2/wA+cfRJg65lDNsXBOA3vcnqdBVkNmBbyI4UsCnnIJv9b/
         UAhQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9j/wLG+PPELoFkULX7HWndk/riOS1KSEeTTHctulhAlNoVi+g1B0rCHbVltCn9kuzVdg8rM26yLo8dWme/rwlkhILWMpUyz8zG+/S
X-Gm-Message-State: AOJu0Yye3uYfR7+lr5MoG0o9pSVgVCYb3I+MSV0whByXcFFZ9VLjne6R
	nPrTnIclJQnzAetB8ZCaM/CaZkosp3rR109kjuAyB6ho2wywMQPZGxYeWg==
X-Google-Smtp-Source: AGHT+IGOW9B3upBTZIdKzWpP0/qRNUf6283GowEY8DUKzjuipp8t5d3FT3uRQsiJ3fEXUOoxYFPvlw==
X-Received: by 2002:a05:6808:120d:b0:3d6:2b42:82ff with SMTP id 5614622812f47-3dd3ae2a516mr809151b6e.37.1723758804767;
        Thu, 15 Aug 2024 14:53:24 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6b63694a1sm1593939a12.92.2024.08.15.14.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 14:53:24 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: chrisl@kernel.org
Cc: akpm@linux-foundation.org,
	david@redhat.com,
	hughd@google.com,
	justinjiang@vivo.com,
	kaleshsingh@google.com,
	kasong@tencent.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ryan.roberts@arm.com,
	v-songbaohua@oppo.com,
	ying.huang@intel.com,
	yosryahmed@google.com
Subject: Re: [PATCH v3 2/2] mm: attempt to batch free swap entries for zap_pte_range()
Date: Fri, 16 Aug 2024 09:53:08 +1200
Message-Id: <20240815215308.55233-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CACePvbUOgPLyCPzQMvH8sNZj_=FayR9Y7A4sGBEyk4ubW1Uo_w@mail.gmail.com>
References: <CACePvbUOgPLyCPzQMvH8sNZj_=FayR9Y7A4sGBEyk4ubW1Uo_w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, Aug 16, 2024 at 6:29 AM Chris Li <chrisl@kernel.org> wrote:
>
> Hi Barry,
>
> We got a crash report from syzbot that has been bisect into this change.
> > +static bool __swap_entries_free(struct swap_info_struct *si,
> > +               swp_entry_t entry, int nr)
> > +{
> > +       unsigned long offset = swp_offset(entry);
> > +       unsigned int type = swp_type(entry);
> > +       struct swap_cluster_info *ci;
> > +       bool has_cache = false;
> > +       unsigned char count;
> > +       int i;
> > +
> > +       if (nr <= 1 || swap_count(data_race(si->swap_map[offset])) != 1)
> > +               goto fallback;
> > +       /* cross into another cluster */
> > +       if (nr > SWAPFILE_CLUSTER - offset % SWAPFILE_CLUSTER)
> > +               goto fallback;
> > +
> > +       ci = lock_cluster_or_swap_info(si, offset);
> > +       if (!swap_is_last_map(si, offset, nr, &has_cache)) {
> > +               unlock_cluster_or_swap_info(si, ci);
> > +               goto fallback;
> > +       }
> > +       for (i = 0; i < nr; i++)
> > +               WRITE_ONCE(si->swap_map[offset + i], SWAP_HAS_CACHE);
> > +       unlock_cluster_or_swap_info(si, ci);
> > +
> > +       if (!has_cache) {
> > +               spin_lock(&si->lock);
> > +               swap_entry_range_free(si, entry, nr);
>
> Here it calls swap_entry_range_free() to free a range of the swap
> entry. However the swap_entry_range_free() has the assumption that all
> entries belong to the same folio and charge to the same memcg.
> It eventually pass down to swap_cgroup_record(), which BUG on this line:
>
> VM_BUG_ON(sc->id != old);
>
> The root cause is that the swap entries are not from the same memcg.
> Thankos Yosry for finding the root cause.
>
> > +               spin_unlock(&si->lock);
> > +       }
> > +       return has_cache;
> > +
> > +fallback:
> > +       for (i = 0; i < nr; i++) {
> > +               if (data_race(si->swap_map[offset + i])) {
> > +                       count = __swap_entry_free(si, swp_entry(type, offset + i));
> > +                       if (count == SWAP_HAS_CACHE)
> > +                               has_cache = true;
> > +               } else {
> > +                       WARN_ON_ONCE(1);
> > +               }
> > +       }
> > +       return has_cache;
> > +}
> > +
> >  /*
> >   * Drop the last HAS_CACHE flag of swap entries, caller have to
> >   * ensure all entries belong to the same cgroup.
> > @@ -1792,11 +1856,9 @@ void free_swap_and_cache_nr(swp_entry_t entry, int nr)
> >  {
> >         const unsigned long start_offset = swp_offset(entry);
> >         const unsigned long end_offset = start_offset + nr;
> > -       unsigned int type = swp_type(entry);
> >         struct swap_info_struct *si;
> >         bool any_only_cache = false;
> >         unsigned long offset;
> > -       unsigned char count;
> >
> >         if (non_swap_entry(entry))
> >                 return;
> > @@ -1811,15 +1873,7 @@ void free_swap_and_cache_nr(swp_entry_t entry, int nr)
> >         /*
> >          * First free all entries in the range.
> >          */
> > -       for (offset = start_offset; offset < end_offset; offset++) {
> > -               if (data_race(si->swap_map[offset])) {
> > -                       count = __swap_entry_free(si, swp_entry(type, offset));
> > -                       if (count == SWAP_HAS_CACHE)
> > -                               any_only_cache = true;
> > -               } else {
> > -                       WARN_ON_ONCE(1);
> > -               }
> > -       }
> > +       any_only_cache = __swap_entries_free(si, entry, nr);
>
> Here we are just doing a page table walk, there is no guarantee the
> 'nr' number of swap entries came from the same folio and previously
> charged to the same memcg. The swap_pte_batch() only checks they are
> the same swap type, does not check they charge to the same memcg.
>

Sorry for the trouble, thanks for the report, Yosry & Chris.
Does the below fix the problem? otherwise, we might remove
the assumption all swaps must belong to one swap_cgroup in
batch free?

From c68e0d780ba808da4bb682b753e3fa77c4f96e13 Mon Sep 17 00:00:00 2001
From: Barry Song <v-songbaohua@oppo.com>
Date: Fri, 16 Aug 2024 09:36:23 +1200
Subject: [PATCH] mm: check all swaps belong to same swap_cgroup in
 swap_pte_batch()

Right now, it is possible two folios are contiguous in swap slots
but they don't belong to one memcg. In this case, even we return
a large nr, we can't really batch free all slots.

Reported-by: Yosry Ahmed <yosryahmed@google.com>
Reported-by: Chris Li <chrisl@kernel.org>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 mm/internal.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index adbf8c88c9df..d1f1e221212d 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -15,6 +15,7 @@
 #include <linux/rmap.h>
 #include <linux/swap.h>
 #include <linux/swapops.h>
+#include <linux/swap_cgroup.h>
 #include <linux/tracepoint-defs.h>
 
 /* Internal core VMA manipulation functions. */
@@ -275,18 +276,22 @@ static inline int swap_pte_batch(pte_t *start_ptep, int max_nr, pte_t pte)
 {
 	pte_t expected_pte = pte_next_swp_offset(pte);
 	const pte_t *end_ptep = start_ptep + max_nr;
+	swp_entry_t entry = pte_to_swp_entry(pte);
 	pte_t *ptep = start_ptep + 1;
+	unsigned short cgroup_id;
 
 	VM_WARN_ON(max_nr < 1);
 	VM_WARN_ON(!is_swap_pte(pte));
-	VM_WARN_ON(non_swap_entry(pte_to_swp_entry(pte)));
+	VM_WARN_ON(non_swap_entry(entry));
 
+	cgroup_id = lookup_swap_cgroup_id(entry);
 	while (ptep < end_ptep) {
 		pte = ptep_get(ptep);
 
 		if (!pte_same(pte, expected_pte))
 			break;
-
+		if (lookup_swap_cgroup_id(pte_to_swp_entry(pte)) != cgroup_id)
+			break;
 		expected_pte = pte_next_swp_offset(expected_pte);
 		ptep++;
 	}
-- 
2.34.1


> Chris
>
> >
> >         /*
> >          * Short-circuit the below loop if none of the entries had their
> > --
> > 2.34.1
> >

Thanks
Barry


