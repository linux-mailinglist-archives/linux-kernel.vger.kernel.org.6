Return-Path: <linux-kernel+bounces-245207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A17E92AFA2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 07:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DB461C21CD6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 05:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA2512D20D;
	Tue,  9 Jul 2024 05:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l20HNKBc"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E56380604
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 05:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720504741; cv=none; b=l/hMJXdFDSzzXyN5alXMNl8DCIQzgkpJZgui00z/KCPbN7ARC1T9DS1eqKW9ewAGbQsIXKhqU8v7BzBkeJmV5fKd68JosCH5fQrrB/3O+dwK6GV+Dxox8Iv18Ovwbq0bxa/3ZWvG64b2GnLNYp4hKM6uhA31Y/yAd7vvL5MZF8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720504741; c=relaxed/simple;
	bh=+Xm/T1AZE+960n3ewseut1wdgmY2bEHOQybZp6zwdWE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iMJBydDeJC2f3J87x764dtIHm84uCUGtVVMMlbCArVd171SXwW/lrOY9SjEhoNGDiBgBT8+aI0lXbXX1ZriC7c2j2n0cQd4QThYKgOB2XUZEl3bKKEBt7KmjuxQrPfEGtugw6nCsSrDCwKQcEMhRrnTJTTJ2Dn3AuOlc/+HULzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l20HNKBc; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-447df43324fso141951cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 22:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720504739; x=1721109539; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ybuXPGKJnTRCHaqveoOG9YYSY5DjRvZaZMYAdb94zUA=;
        b=l20HNKBcUvocXQ45WO+JVM5PPonm5/euDdOQFGN/q3CN2YmleRv88Zwbkyy9r347is
         OFekkBMLUlLzaIGtWX/MhAfG9h6lGVhQY29Ef1qMXY7/LGOzZk2uBnn7UKCmZYC6eSiX
         QvjiWkKFJ/tUyXoaXOFfri+j+KcscpckoYIxFburJWh1dvve0Yx+KYsYSE/qjDPbnBLc
         mxO17vnhTjXRzJm1phojfqXTPLMpMGP+Jhh6cfhBsS8APH9vRrJA2f2u9NY9LGd5z/d5
         tssxMEMrZWU4IDkc2zFAGVBnz34vz2wF2kBKw091t/pru+nKYo/4LfPNBSQomg+JgZvP
         QAng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720504739; x=1721109539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ybuXPGKJnTRCHaqveoOG9YYSY5DjRvZaZMYAdb94zUA=;
        b=NMt6phawUPBxEm6ThZzLFsJw+V9wNzHdnLFBMUNQTUtG864rNzXbXlVkB6NS4xF687
         0//iaIYWSUbQ9UWCvWF0DRRqaKWbhsQx8IHQw7YmeZ5mnB7Q6v7BiihWW23y3OBVoEt3
         DgIraMtpN8fqiJJQTK/0sYtwjw7qnJuXa3dqPBkgMVcrx0oRAPrdHu5syvVWKo1bRJ3b
         ZhfJIP5ww6JyJqdTtY/IEnJCjGhBWI9k8G3hybtFq71KHU2RzlojI7g2RDaCGseP3hK3
         LdMuDx13uUMhaEJboJcHkVGK3RDVtfijW2+Sa2Btc++rNLmmeRSfz9FYnW3CIgzdcUsA
         1U5w==
X-Forwarded-Encrypted: i=1; AJvYcCUgnH7oM7bgteKGP9FSxudUsX9UKu38S/PH3i1B33BULwkr1m3D8DsixACCOtUgq4Oo0r2Ni51c3fCnEUriypMSMAO5zrRhz+4m9D9g
X-Gm-Message-State: AOJu0YyPnK1QCvCWuEoRwnKegcRVY3e5BbsdK3QjOs76uHCbYgI/CHUE
	jVu8PYVTqPjhNmMkE23JoH7+0NU91rN6CF0gcsfYH2ANvEhtNQOma6dCZoRauz/hN/G3GAdBFd5
	pvzEk2u+RBey61vnx89qVSITQJVPx1abZDSH5
X-Google-Smtp-Source: AGHT+IE9s6EeXXa5+5jH0FLBqqwcSIlaabORpUN/0MoGtzOnz56BqLqdzYocfeDKJEgc0y/IWf/mYDF4wkludJ0+4q8=
X-Received: by 2002:ac8:4dcd:0:b0:447:ed5f:bca6 with SMTP id
 d75a77b69052e-447fcfe9339mr1355951cf.5.1720504738887; Mon, 08 Jul 2024
 22:58:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d2841226-e27b-4d3d-a578-63587a3aa4f3@amd.com> <CAOUHufawNerxqLm7L9Yywp3HJFiYVrYO26ePUb1jH-qxNGWzyA@mail.gmail.com>
 <1998d479-eb1a-4bc8-a11e-59f8dd71aadb@amd.com> <CAOUHufYA-ZAHni1_aDQjjwB5UC9EFYPL_YqVN52DoL3J7SFziQ@mail.gmail.com>
 <7a06a14e-44d5-450a-bd56-1c348c2951b6@amd.com>
In-Reply-To: <7a06a14e-44d5-450a-bd56-1c348c2951b6@amd.com>
From: Yu Zhao <yuzhao@google.com>
Date: Mon, 8 Jul 2024 23:58:21 -0600
Message-ID: <CAOUHufa7OBtNHKMhfu8wOOE4f0w3b0_2KzzV7-hrc9rVL8e=iw@mail.gmail.com>
Subject: Re: Hard and soft lockups with FIO and LTP runs on a large system
To: Bharata B Rao <bharata@amd.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, nikunj@amd.com, 
	"Upadhyay, Neeraj" <Neeraj.Upadhyay@amd.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, willy@infradead.org, vbabka@suse.cz, kinseyho@google.com, 
	Mel Gorman <mgorman@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 10:31=E2=80=AFPM Bharata B Rao <bharata@amd.com> wro=
te:
>
> On 08-Jul-24 9:47 PM, Yu Zhao wrote:
> > On Mon, Jul 8, 2024 at 8:34=E2=80=AFAM Bharata B Rao <bharata@amd.com> =
wrote:
> >>
> >> Hi Yu Zhao,
> >>
> >> Thanks for your patches. See below...
> >>
> >> On 07-Jul-24 4:12 AM, Yu Zhao wrote:
> >>> Hi Bharata,
> >>>
> >>> On Wed, Jul 3, 2024 at 9:11=E2=80=AFAM Bharata B Rao <bharata@amd.com=
> wrote:
> >>>>
> >> <snip>
> >>>>
> >>>> Some experiments tried
> >>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>> 1) When MGLRU was enabled many soft lockups were observed, no hard
> >>>> lockups were seen for 48 hours run. Below is once such soft lockup.
> >>>
> >>> This is not really an MGLRU issue -- can you please try one of the
> >>> attached patches? It (truncate.patch) should help with or without
> >>> MGLRU.
> >>
> >> With truncate.patch and default LRU scheme, a few hard lockups are see=
n.
> >
> > Thanks.
> >
> > In your original report, you said:
> >
> >    Most of the times the two contended locks are lruvec and
> >    inode->i_lock spinlocks.
> >    ...
> >    Often times, the perf output at the time of the problem shows
> >    heavy contention on lruvec spin lock. Similar contention is
> >    also observed with inode i_lock (in clear_shadow_entry path)
> >
> > Based on this new report, does it mean the i_lock is not as contended,
> > for the same path (truncation) you tested? If so, I'll post
> > truncate.patch and add reported-by and tested-by you, unless you have
> > objections.
>
> truncate.patch has been tested on two systems with default LRU scheme
> and the lockup due to inode->i_lock hasn't been seen yet after 24 hours r=
un.

Thanks.

> >
> > The two paths below were contended on the LRU lock, but they already
> > batch their operations. So I don't know what else we can do surgically
> > to improve them.
>
> What has been seen with this workload is that the lruvec spinlock is
> held for a long time from shrink_[active/inactive]_list path. In this
> path, there is a case in isolate_lru_folios() where scanning of LRU
> lists can become unbounded. To isolate a page from ZONE_DMA, sometimes
> scanning/skipping of more than 150 million folios were seen. There is
> already a comment in there which explains why nr_skipped shouldn't be
> counted, but is there any possibility of re-looking at this condition?

For this specific case, probably this can help:

@@ -1659,8 +1659,15 @@ static unsigned long
isolate_lru_folios(unsigned long nr_to_scan,
                if (folio_zonenum(folio) > sc->reclaim_idx ||
                                skip_cma(folio, sc)) {
                        nr_skipped[folio_zonenum(folio)] +=3D nr_pages;
-                       move_to =3D &folios_skipped;
-                       goto move;
+                       list_move(&folio->lru, &folios_skipped);
+                       if (spin_is_contended(&lruvec->lru_lock)) {
+                               if (!list_empty(dst))
+                                       break;
+                               spin_unlock_irq(&lruvec->lru_lock);
+                               cond_resched();
+                               spin_lock_irq(&lruvec->lru_lock);
+                       }
+                       continue;
                }

