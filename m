Return-Path: <linux-kernel+bounces-382426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3464C9B0D77
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 20:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A6392868D1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 18:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BDE2022EC;
	Fri, 25 Oct 2024 18:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ocn9TZX9"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F1E185E50
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 18:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729881391; cv=none; b=KmDrp5NlwnYLPiJJp+yMDJnp9QA6RQ3CuVllh/rt/54vmR21ao/pluyzLyRCXb+EGfGurbp/2blU7ciSgvX6J8B5p7DAk7pHU/WGe1XI+rdiIdWdRr7FBaaIMAJowgoCg+VWibNeg9z1sSKKGgqxAFto0Ljkvz7tvyMV2SwH0IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729881391; c=relaxed/simple;
	bh=MFNDyFcHqT4Df6FZHW6zcDQQZqb99bE7QMExN7fPw0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HWGexx+pVFI0tJvwKOmCo1embNUoYRoNQT5af8etVza2tcIe/AtAKIIEnfBHPW11Uz6tM0yWz4KDp5SW9adM15GcrM845gb8XWhPLXBVbPVBeEC4gD9UhgDN30vlqFLLwfxpSijCWsS2myJ0JF1LUamgnkQ74wRX8+IR+9B+S28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ocn9TZX9; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c903f5bd0eso4501701a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 11:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729881387; x=1730486187; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FVqk1yJPQA/+HKOpSAlTiulTaUi2W5hnnPyvpTl0kVs=;
        b=Ocn9TZX98Ur4aoJvInJ4yHqClh5yoexX41usUd5FtpIllImqIP/eMzyQwRQiJ6CKas
         Mf++gz+N28Zu+ikT8aV17NRJfwskaSe/tazLv3A2GqhU2R41rQ4yIeoIUvtocAPF9Jbe
         62Cibs0Ntp51HhZfBS3utmMU8u6PY+H4qwb+2aA6AbSDT6tryoorwoDN/XAuMDTHBO/5
         9biYWMoC4AmZg6+U5OQJZezG3HrEENbFxjenodrUl/qw1vq4BB4kMx00aM9ZFrG4pfZX
         4HSiGkePSDeuv8Ibp/67uN1TOJD5pTkikES/5+ax709NPmbvh4toxtIOo9B46sGlYHeP
         rRlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729881387; x=1730486187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FVqk1yJPQA/+HKOpSAlTiulTaUi2W5hnnPyvpTl0kVs=;
        b=YI+GgSNmPyM5iZHq1MJzV2wAwjDaUfNoypXKvKU/XUCeQ0LByMCAKZzGIjONtI2ikI
         kXtOWLB67i50EHqu7BqVPpmfE0G/lb7Rrio4eANDLO4p8gRBHq2F32hSpS3N7p1y6Z85
         jjLFzk4mLGh0rZTb4ECnvkSRX75YQcZ+R+kysQi+0EZIaaiCf8JJYjMRD+QCa9latfnb
         yzEllSmeHfIIRUkPobcL9I+9orUD+dqgqR23SsIy9WoDO/6G6ePwek7FdH+BTtei2N4l
         9GKQ5SBH7MjPEoW5of8TH0ZwST9uxbbR30/Q9T5Cc8oLwZSK/2BYaT4rgeLpFlG+CyBx
         nOJg==
X-Forwarded-Encrypted: i=1; AJvYcCX/oACJfjAASPboGCJQtyxw+zC1VlR50uB4bfSdeTb0uAesOqDS0JsRZ4nc6eM8QyBp/DqlyUAlcDMuyV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLe9aEFpkygq5CiV35lYK7gnqyUQokSmyc9I2Be+I+953eCndS
	QD4zLAKQrzHFOY5GxiCpnkdnqTG6CIrnJtbxx7g0VFxB89ZeUZWpGAetyufr5axkgPrxzL8q1Ue
	DM14KWvNQajjuWvXgoHmFQ1GSvfk=
X-Google-Smtp-Source: AGHT+IFDhMroGBcIugrFh5ZmmzBe/63nbTL/N+2PUYOiLt/O7wlBsRhdH24OaHMpbCqKImjBZmctfDVP7eBmfnaMZrQ=
X-Received: by 2002:a05:6402:529b:b0:5c9:5a96:2869 with SMTP id
 4fb4d7f45d1cf-5cbbf8b1ceamr191791a12.10.1729881387104; Fri, 25 Oct 2024
 11:36:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <760237a3-69d6-9197-432d-0306d52c048a@google.com>
 <3A1E5353-D8C5-4D38-A3FF-BFC671FC25CE@nvidia.com> <966a4aff-f587-c4bb-1e10-2673734c2aa0@google.com>
 <E5A75697-55C7-4335-8D86-EE5CB6A99C4F@nvidia.com>
In-Reply-To: <E5A75697-55C7-4335-8D86-EE5CB6A99C4F@nvidia.com>
From: Yang Shi <shy828301@gmail.com>
Date: Fri, 25 Oct 2024 11:36:15 -0700
Message-ID: <CAHbLzkqEhbw89HMh7h-r6M1xM5vw7bUZDNO7KEgPyaguO32d-Q@mail.gmail.com>
Subject: Re: [PATCH hotfix 1/2] mm/thp: fix deferred split queue not partially_mapped
To: Zi Yan <ziy@nvidia.com>
Cc: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Usama Arif <usamaarif642@gmail.com>, Wei Yang <richard.weiyang@gmail.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Matthew Wilcox <willy@infradead.org>, 
	David Hildenbrand <david@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <baohua@kernel.org>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Nhat Pham <nphamcs@gmail.com>, Chris Li <chrisl@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 8:32=E2=80=AFAM Zi Yan <ziy@nvidia.com> wrote:
>
> On 25 Oct 2024, at 1:41, Hugh Dickins wrote:
>
> > On Thu, 24 Oct 2024, Zi Yan wrote:
> >> On 24 Oct 2024, at 0:10, Hugh Dickins wrote:
> >>
> >>> The new unlocked list_del_init() in deferred_split_scan() is buggy.
> >>> I gave bad advice, it looks plausible since that's a local on-stack
> >>> list, but the fact is that it can race with a third party freeing or
> >>> migrating the preceding folio (properly unqueueing it with refcount 0
> >>> while holding split_queue_lock), thereby corrupting the list linkage.
> >>>
> >>> The obvious answer would be to take split_queue_lock there: but it ha=
s
> >>> a long history of contention, so I'm reluctant to add to that. Instea=
d,
> >>> make sure that there is always one safe (raised refcount) folio befor=
e,
> >>> by delaying its folio_put().  (And of course I was wrong to suggest
> >>> updating split_queue_len without the lock: leave that until the splic=
e.)
> >>
> >> I feel like this is not the right approach, since it breaks the existi=
ng
> >> condition of changing folio->_deferred_list, namely taking
> >> ds_queue->split_queue_lock for serialization. The contention might not=
 be
> >> as high as you think, since if a folio were split, the split_queue_loc=
k
> >> needed to be taken during split anyway. So the worse case is the same
> >> as all folios are split. Do you see significant perf degradation due t=
o
> >> taking the lock when doing list_del_init()?
> >>
> >> I am afraid if we take this route, we might hit hard-to-debug bugs
> >> in the future when someone touches the code.
> >
> > You have a good point: I am adding another element of trickiness
> > to that already-tricky local-but-not-quite list - which has tripped
> > us up a few times in the past.
> >
> > I do still feel that this solution is right in the spirit of that list;
> > but I've certainly not done any performance measurement to justify it,
> > nor would I ever trust my skill to do so.  I just tried to solve the
> > corruptions in what I thought was the best way.
> >
> > (To be honest, I found this solution to the corruptions first, and thou=
ght
> > the bug went back to the original implemention: that its put_page() at =
the
> > end of the loop was premature all along.  It was only when writing the
> > commit message two days ago, that I came to realize that even put_page(=
)
> > or folio_put() would be safely using the lock to unqueue: that it is on=
ly
> > this new list_del_init() which is the exception which introduces the bu=
g.)
> >
> > Looking at vmstats, I'm coming to believe that the performance advantag=
e
> > of this way is likely to be in the noise: that mTHPs alone, and the
> > !partially_mapped case on top, are greatly increasing the split_deferre=
d
> > stats: and may give rise to renewed complaints of lock contention, with
> > or without this optimization.
> >
> > While I still prefer to stick with what's posted and most tested, I am
> > giving the locked version a run overnight.  Thanks a lot for the review=
s
> > and acks everyone: at present Zi Yan is in the minority preferring a
> > locked version, but please feel free to change your vote if you wish.
>
> Thank you a lot for taking the time to check the locked version. Looking
> forward to the result. BTW, I am not going to block this patch since it
> fixes the bug.
>
> The tricky part in deferred_list_scan() is always the use of
> folio->_deferred_list without taking split_queue_lock. I am thinking abou=
t
> use folio_batch to store the out-of-split_queue folios, so that _deferred=
_list
> will not be touched when these folios are tried to be split. Basically,
>
> 1. loop through split_queue and move folios to a folio_batch until the
>    folio_batch is full;
> 2. loop through the folio_batch to try to split each folio;
> 3. move the remaining folios back to split_queue.
>
> With this approach, split_queue_lock might be taken more if there are
> more than 31 (folio_batch max size) folios on split_queue and split_queue=
_lock
> will be held longer in step 3, since the remaining folios need to be
> added back to split_queue one by one instead of a single list splice.

IMHO, the folio_batch approach is worth trying. The deferred list lock
is just held when deleting folio from deferred list and updating the
list len. Re-acquiring the lock every 31 folios seems not very bad. Of
course, some benchmark is needed.

The other subtle thing is folio->_deferred_list is reused when the
folio is moved to the local on-stack list. And some
list_empty(deferred_list) checks return true even though the folio is
actually on the local on-stack list. Some code may depend on or
inadvertently depend on this behavior. Using folio_batch may break
some assumptions, but depending on this subtle behavior is definitely
not reliable IMHO.

>
> Let me know your thoughts. I can look into this if this approach sounds
> promising. Thanks.
>
>
> Best Regards,
> Yan, Zi

