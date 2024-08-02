Return-Path: <linux-kernel+bounces-272194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B17594587F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 09:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65AAEB21955
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 07:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B551BE868;
	Fri,  2 Aug 2024 07:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QcjyMmSm"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0363E482EF
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 07:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722583120; cv=none; b=Mn2YiMYwHc18MV084GJ4P2OcczbWEicpRXMYZkeDazXYbJyC+CSXUOrnVQE0cfOovUdlHpTkmqzgAfpFXOuz3Dh3905gKQ2ECIDCVIlrCTcrdTN9DHJck8KQYMjNARQybmGQTp06v22SGRXPVc76sowzNTzTCNa2t752sha+cJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722583120; c=relaxed/simple;
	bh=j9KlRdMFlODPKkhIpLlo+fcnUbOPts0lOdJJDtVQPKs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O7jhdqI/+4oGnS6VS3KUDo0dn8hMGoAM7vGHZ/sOFRj0BjRUbFkWdq638oLxr15STkJxlbo4ebvjLdNwcGqHHkQRCOzPYHDKVoihGXTILw3tQv/wZ0pFfE6V17QV5mrMa3RGbSCEPbACJyx9HeM5Xemr3MqDMba0zVnYJWSpRMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QcjyMmSm; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fc4fcbb131so68646035ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 00:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722583118; x=1723187918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k78JGF02XTaSpSY2F19gccm9MTwGNhAILnPDJY5TGS4=;
        b=QcjyMmSmJNZo5Q7CpR+ZxmOqI+5UNkAddj/SBaADzWu6rsJ/yEUw+Wvt3JUbsLVdYL
         avBPA+tLZe1+hrIBQpqsKuGJ5zR57QnIrcOvI2gmeRPnq5KtJw8Q2KN4TNsRdplChsq/
         1FCSmn5kTf0R9GrVvFN6ciDa96opswHWvUS0L6KstMk2bnXmZKoJexYTFQnUlbh7Mh5D
         8jYofunXWZP8nUwMOgysNpgmHkFMMynWQoZzqmL0GDN2uExf8xgV7tQBiiZ2c8D3WGat
         skLwwSm+0UAw+ByRNOaD+turIvi+B/Gm4Tkuj0JvHVJfpfYzsXfedoWvHa9JCuqiTNFB
         jFVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722583118; x=1723187918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k78JGF02XTaSpSY2F19gccm9MTwGNhAILnPDJY5TGS4=;
        b=LwmP6chKJQC7B/KSAlQnO93cvGcQ8CBJ+yt38DIScJh2mbyvTgSU28aWG9bXzCYnNJ
         TMHwrZg83OK5Q3vL2MuTrChT4IiV/DbvcuIKqKIubRcs0Xl7/vChuZMv7xpU7BsUiovj
         OepFb2s3rpqxpem6Q5L0aYOhJOV6Z3IjIcNQrmejn8LutXL2JrmyczHsNpx1rZSejygK
         ByRj8rg6ZOM2PGp0c4U2uivEoR73YZBq0mK94MV5ioyWcWXDfDSgOhZVVxkntcD26DMq
         ux0pzuSVfWcAgedI38bH1o4Y2+kTFj3ezEgD1GwdQBNyKolmUi8IfJpTV8YGTltSHXW8
         uWqw==
X-Forwarded-Encrypted: i=1; AJvYcCWOXtcPG9HRVwffVcTqVxqQ3wIeL/9+OHCMDLeQ9/OY7ypIIsBFfyarsGO+vTjJH3ul9U7f1QEXXwFaQbM+pglbUgVZ4PjEZC9VLnFD
X-Gm-Message-State: AOJu0Yx/TbwrTTFm16v42yt4IOis0/d0Mz9c5Jr0A9ZMFxGS6J3f8LtV
	/Qq4TqkeLM11d9Aj1xiOHONeBsSdMSyr7jZIwfRjta464vEu/4OI
X-Google-Smtp-Source: AGHT+IHCBWMSEl6WKmbUX247lj6zM93iaVkd2vbq5KQvq05U1WFX8o+U3IBR2/Le70WBHfcgpmwgWA==
X-Received: by 2002:a17:902:dac2:b0:1fb:2e9a:beea with SMTP id d9443c01a7336-1ff570d8163mr43037285ad.0.1722583118068;
        Fri, 02 Aug 2024 00:18:38 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff590608casm10208605ad.159.2024.08.02.00.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 00:18:37 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: ying.huang@intel.com
Cc: akpm@linux-foundation.org,
	baolin.wang@linux.alibaba.com,
	chrisl@kernel.org,
	david@redhat.com,
	hannes@cmpxchg.org,
	hughd@google.com,
	kaleshsingh@google.com,
	kasong@tencent.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	mhocko@suse.com,
	minchan@kernel.org,
	nphamcs@gmail.com,
	ryan.roberts@arm.com,
	senozhatsky@chromium.org,
	shakeel.butt@linux.dev,
	shy828301@gmail.com,
	surenb@google.com,
	v-songbaohua@oppo.com,
	willy@infradead.org,
	xiang@kernel.org,
	yosryahmed@google.com
Subject: Re: [PATCH 1/1] mm: swap: add nr argument in swapcache_prepare and swapcache_clear to support large folios
Date: Fri,  2 Aug 2024 19:18:17 +1200
Message-Id: <20240802071817.47081-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <87sevpj6xp.fsf@yhuang6-desk2.ccr.corp.intel.com>
References: <87sevpj6xp.fsf@yhuang6-desk2.ccr.corp.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, Aug 2, 2024 at 1:50 PM Huang, Ying <ying.huang@intel.com> wrote:
> >
> > Right. I believe the change below can help improve readability and also
> > clarify the swap_count_continued() case.
> >
> > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > index 2fa29bdec171..75a89ce18edc 100644
> > --- a/mm/swapfile.c
> > +++ b/mm/swapfile.c
> > @@ -3538,6 +3538,7 @@ static int __swap_duplicate(swp_entry_t entry, unsigned char usage, int nr)
> >
> >       offset = swp_offset(entry);
> >       VM_WARN_ON(nr > SWAPFILE_CLUSTER - offset % SWAPFILE_CLUSTER);
> > +     VM_WARN_ON(usage == 1 && nr > 1);
> >       ci = lock_cluster_or_swap_info(p, offset);
> >
> >       err = 0;
> > @@ -3564,17 +3565,9 @@ static int __swap_duplicate(swp_entry_t entry, unsigned char usage, int nr)
> >                               err = -EEXIST;
> >                       else                            /* no users remaining */
> >                               err = -ENOENT;
> > -
> >               } else if (count || has_cache) {
> > -
> > -                     if ((count & ~COUNT_CONTINUED) < SWAP_MAP_MAX)
> > -                             continue;
> > -                     else if ((count & ~COUNT_CONTINUED) > SWAP_MAP_MAX)
> > +                     if ((count & ~COUNT_CONTINUED) > SWAP_MAP_MAX)
> >                               err = -EINVAL;
> > -                     else if (swap_count_continued(p, offset + i, count))
> > -                             continue;
> > -                     else
> > -                             err = -ENOMEM;
> >               } else
> >                       err = -ENOENT;                  /* unused swap entry */
> >
> > @@ -3591,8 +3584,12 @@ static int __swap_duplicate(swp_entry_t entry, unsigned char usage, int nr)
> >                       has_cache = SWAP_HAS_CACHE;
> >               else if ((count & ~COUNT_CONTINUED) < SWAP_MAP_MAX)
> >                       count += usage;
> > -             else
> > +             else if (swap_count_continued(p, offset + i, count))
> >                       count = COUNT_CONTINUED;
> > +             else {
> > +                     err = -ENOMEM;
> > +                     goto unlock_out;
> > +             }
> >
> >               WRITE_ONCE(p->swap_map[offset + i], count | has_cache);
> >       }
> >
> > This makes the two iterations become:
> >
> >       for (i = 0; i < nr; i++) {
> >               count = p->swap_map[offset + i];
> >
> >               /*
> >                * swapin_readahead() doesn't check if a swap entry is valid, so the
> >                * swap entry could be SWAP_MAP_BAD. Check here with lock held.
> >                */
> >               if (unlikely(swap_count(count) == SWAP_MAP_BAD)) {
> >                       err = -ENOENT;
> >                       goto unlock_out;
> >               }
> >
> >               has_cache = count & SWAP_HAS_CACHE;
> >               count &= ~SWAP_HAS_CACHE;
> >
> >               if (usage == SWAP_HAS_CACHE) {
> >                       /* set SWAP_HAS_CACHE if there is no cache and entry is used */
>
> The comments doen't apply now, we don't "set" here.
>
> >                       if (!has_cache && count)
> >                               continue;
> >                       else if (has_cache)             /* someone else added cache */
> >                               err = -EEXIST;
> >                       else                            /* no users remaining */
> >                               err = -ENOENT;
> >               } else if (count || has_cache) {
> >                       if ((count & ~COUNT_CONTINUED) > SWAP_MAP_MAX)
> >                               err = -EINVAL;
> >               } else
> >                       err = -ENOENT;                  /* unused swap entry */
>
> It seems that this can be simplified to:
>
>                 if (!count && !has_cache) {
>                         err = -ENOENT;
>                 } else if (usage == SWAP_HAS_CACHE) {
>                         if (has_cache)
>                                 err = -EEXIST;
>                 } else if ((count & ~COUNT_CONTINUED) > SWAP_MAP_MAX) {
>                         err = -EINVAL;
>                 }
>
> >               if (err)
> >                       goto unlock_out;
> >       }
> >
> >       for (i = 0; i < nr; i++) {
> >               count = p->swap_map[offset + i];
> >               has_cache = count & SWAP_HAS_CACHE;
> >               count &= ~SWAP_HAS_CACHE;
> >
> >               if (usage == SWAP_HAS_CACHE)
> >                       has_cache = SWAP_HAS_CACHE;
> >               else if ((count & ~COUNT_CONTINUED) < SWAP_MAP_MAX)
> >                       count += usage;
> >               else if (swap_count_continued(p, offset + i, count))
> >                       count = COUNT_CONTINUED;
> >               else {
>
> Better to add some comments here,
>
>                         /*
>                          * Don't need to rollback changes, because if
>                          * usage == 1, there must be nr == 1.
>                          */
>
> >                       err = -ENOMEM;
> >                       goto unlock_out;
> >               }
> >
> >               WRITE_ONCE(p->swap_map[offset + i], count | has_cache);
> >       }
> >
> > Ying, do you feel more satisfied with the version above
> > compared to the code in mm-unstable?
>
> This looks good to me except some minor comments above.  Thanks!

Thanks very much, Ying. 

Hi Andrew,
Could you please help squash the below change?

From 17cbd696ecd37bc199b6e87c0c837d1a1ae9ac8d Mon Sep 17 00:00:00 2001
From: Barry Song <v-songbaohua@oppo.com>
Date: Fri, 2 Aug 2024 17:52:43 +1200
Subject: [PATCH] mm: clarify swap_count_continued and improve readability for
 __swap_duplicate

when usage=1 and swapcount is very large, the situation can become quite
complex. The first entry might succeed with swap_count_continued(),
but the second entry may require extending to an additional continued
page. Rolling back these changes can be extremely challenging. Therefore,
anyone using usage==1 for batched __swap_duplicate() operations should
proceed with caution.

Additionally, we have moved swap_count_continued() to the second iteration
to enhance readability, as this function may modify data.

Suggested-by: "Huang, Ying" <ying.huang@intel.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 mm/swapfile.c | 38 +++++++++++++++++---------------------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index d9cf31b04db3..ea023fc25d08 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3540,6 +3540,7 @@ static int __swap_duplicate(swp_entry_t entry, unsigned char usage, int nr)
 
 	offset = swp_offset(entry);
 	VM_WARN_ON(nr > SWAPFILE_CLUSTER - offset % SWAPFILE_CLUSTER);
+	VM_WARN_ON(usage == 1 && nr > 1);
 	ci = lock_cluster_or_swap_info(p, offset);
 
 	err = 0;
@@ -3558,27 +3559,14 @@ static int __swap_duplicate(swp_entry_t entry, unsigned char usage, int nr)
 		has_cache = count & SWAP_HAS_CACHE;
 		count &= ~SWAP_HAS_CACHE;
 
-		if (usage == SWAP_HAS_CACHE) {
-			/* set SWAP_HAS_CACHE if there is no cache and entry is used */
-			if (!has_cache && count)
-				continue;
-			else if (has_cache)		/* someone else added cache */
+		if (!count && !has_cache) {
+			err = -ENOENT;
+		} else if (usage == SWAP_HAS_CACHE) {
+			if (has_cache)
 				err = -EEXIST;
-			else				/* no users remaining */
-				err = -ENOENT;
-
-		} else if (count || has_cache) {
-
-			if ((count & ~COUNT_CONTINUED) < SWAP_MAP_MAX)
-				continue;
-			else if ((count & ~COUNT_CONTINUED) > SWAP_MAP_MAX)
-				err = -EINVAL;
-			else if (swap_count_continued(p, offset + i, count))
-				continue;
-			else
-				err = -ENOMEM;
-		} else
-			err = -ENOENT;			/* unused swap entry */
+		} else if ((count & ~COUNT_CONTINUED) > SWAP_MAP_MAX) {
+			err = -EINVAL;
+		}
 
 		if (err)
 			goto unlock_out;
@@ -3593,8 +3581,16 @@ static int __swap_duplicate(swp_entry_t entry, unsigned char usage, int nr)
 			has_cache = SWAP_HAS_CACHE;
 		else if ((count & ~COUNT_CONTINUED) < SWAP_MAP_MAX)
 			count += usage;
-		else
+		else if (swap_count_continued(p, offset + i, count))
 			count = COUNT_CONTINUED;
+		else {
+			/*
+			 * Don't need to rollback changes, because if
+			 * usage == 1, there must be nr == 1.
+			 */
+			err = -ENOMEM;
+			goto unlock_out;
+		}
 
 		WRITE_ONCE(p->swap_map[offset + i], count | has_cache);
 	}
-- 
2.34.1


> >> >> >> >> >> Best Regards,
> >> >> >> >> >> Huang, Ying
> >> >> >> >> >
> >> >> >
> >

Thanks
Barry

