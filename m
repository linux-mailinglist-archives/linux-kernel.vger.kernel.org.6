Return-Path: <linux-kernel+bounces-246756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E225F92C63C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 00:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BC721F238A1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 22:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F64185600;
	Tue,  9 Jul 2024 22:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pjPsQixP"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D0518786A
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 22:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720564114; cv=none; b=qDsntD58bqrUoWjni1vOOMehMuFviwJJ5Ob9n6uDh3flzONK2dTnBrHO0d8rYh7im2Um7K9MVtj9fmvZBRLOMu0nUNJYLhEyxrAoJVpPbkxdPWbPGsMQG1XYHKq6+P0TL5vWzY609J7tjwvI1yJeciK7JWS7uMMHfkXbgfmepGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720564114; c=relaxed/simple;
	bh=ch4pEoajc1Hcg13db7SXOy/3RpPUdyRprv37vkUf5bY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IUTdDCXBIiBgRVp3Js7mnTDh+xb7SnruLC0MIOfONXWqIodMTH74BUum67bVE26Th4nL8Sv5d0k+V3bB5eLHpwxEypL1VtzSg2zljRoqOeJS+vjvgN/JeZZ0nYjg02UoSwzbgZWngTi/X0fP8L8mkyAKcvfqhYH/nZd6l1QDntA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pjPsQixP; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-44664ad946eso36391cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 15:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720564112; x=1721168912; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RhsBlu6qll24zUY2yKGJJYQBS72AqtpPAo9VnNpUeh0=;
        b=pjPsQixPzDm3tD8BWMH8nL/mR8J3dENxRh28dzf+atS3EQPXF1+RSKv98NjirMX7za
         T8U48gsoLeBx4Y83A+zvJkVl7cbXmU1BvEBnPTB4F2PilNOhwDdAdYPG0Pvg03sebz1N
         fHsttDPqYORa0y2XhWEA2seWcnTkY8hFmE3+xD/YWXk8V9qhkdh7xt1x34QnUGT1gqLW
         8pZ2WxwSz+2RbO+vZg8YC9lXXo3I3Y948hHr56PNbDnu6tITh8dkKAKq/+ck0qvFQrJ9
         6CX7saya3FU3tDnuwYhA1gewYT62A+YP+WCtCxF8RWJajeqE4sXarnjrZqg1DS0RlmO6
         H8/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720564112; x=1721168912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RhsBlu6qll24zUY2yKGJJYQBS72AqtpPAo9VnNpUeh0=;
        b=rlLtzqi2n6hai0kjT0zLiFuXTtF/GUBU2RmfPtEZvmWIVdv3Zve+WqxO1iZdwyjYOG
         ErULdPlameGa3NYLvgI8qgwpbOOwlaEo42hQDwSW2aD0/a3+ZUCkWmrQQfmcXFd7B9Mu
         4yt3y5+WJFSU02ythnt+O+efcTYcrFzr/9yfSuV3xYrYU3QtzacWAtioqW81oGjL5XEe
         xYV3sq7yC2eS7BZd0Vdzyinf4qXAK1BaOh1tpyuOvnu8jbIlboBoQFlSXQc2qUe5Y/G2
         hc3cJ5+q+kf/txC2fD7HuQdzJsBvJnIdlqLTLJmHuYqIU/UIyQY4mUXW55K5z9Lf5WXc
         3A3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUfcd2k7eHuwLriDB2svKU1eqZP+ayOy1vavreN5RT9D0ItJTYnfD7B63jDPjn2BGWDsLrNgL2rXrI6mCP0AIG+8hpbbl3vMrbwePDY
X-Gm-Message-State: AOJu0YzzysRzdr6SnkOqx3t6xMIxpLV7vSDyGPrV+8OSyW0XbaCxAdjj
	CIYHNMcAwhckffCBfl3cmZwUOb2tO2hkwcUkkCfSba1nPtDJZBk9y9uSh2b9T2AGmw/mwBuBmgz
	zFq3cLnA4OgKyvkDXxee8fwfTIbdExHD1vw7u
X-Google-Smtp-Source: AGHT+IHeB9je+NxBzMGN6VzuBwrcm7niEoBEFnF9hemcs2GIYWQUqURUMjo2KvD1MmvJR2s2VXNPBW4xff4Hg23gm78=
X-Received: by 2002:a05:622a:214:b0:444:e366:3fda with SMTP id
 d75a77b69052e-44b1a8fb553mr589791cf.27.1720564111990; Tue, 09 Jul 2024
 15:28:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708212753.3120511-1-yuzhao@google.com> <20240708151619.dc738d16d3b2d56d6c4fe285@linux-foundation.org>
In-Reply-To: <20240708151619.dc738d16d3b2d56d6c4fe285@linux-foundation.org>
From: Yu Zhao <yuzhao@google.com>
Date: Tue, 9 Jul 2024 16:27:54 -0600
Message-ID: <CAOUHufZ42qn4vv+2w2MhFhqHib66s054YaXben28nddbZWRp5Q@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v1] mm/truncate: batch-clear shadow entries
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Bharata B Rao <bharata@amd.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Mel Gorman <mgorman@techsingularity.net>, 
	Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 4:16=E2=80=AFPM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Mon,  8 Jul 2024 15:27:53 -0600 Yu Zhao <yuzhao@google.com> wrote:
>
> > Make clear_shadow_entry() clear shadow entries in `struct folio_batch`
> > so that it can reduce contention on i_lock and i_pages locks, e.g.,
> >
> >   watchdog: BUG: soft lockup - CPU#29 stuck for 11s! [fio:2701649]
> >     clear_shadow_entry+0x3d/0x100
> >     mapping_try_invalidate+0x117/0x1d0
> >     invalidate_mapping_pages+0x10/0x20
> >     invalidate_bdev+0x3c/0x50
> >     blkdev_common_ioctl+0x5f7/0xa90
> >     blkdev_ioctl+0x109/0x270
>
> This will clearly reduce lock traffic a lot, but does it truly fix the
> issue?  Is it the case that sufficiently extreme loads will still run
> into problems?

I think Bharata was running extreme loads. So I'd say it's good enough
for now, considering truncation doesn't happen that often.

> > --- a/mm/truncate.c
> > +++ b/mm/truncate.c
> > @@ -39,12 +39,24 @@ static inline void __clear_shadow_entry(struct addr=
ess_space *mapping,
> >       xas_store(&xas, NULL);
> >  }
> >
> > -static void clear_shadow_entry(struct address_space *mapping, pgoff_t =
index,
> > -                            void *entry)
> > +static void clear_shadow_entry(struct address_space *mapping,
> > +                            struct folio_batch *fbatch, pgoff_t *indic=
es)
> >  {
> > +     int i;
> > +
> > +     if (shmem_mapping(mapping) || dax_mapping(mapping))
> > +             return;
>
> We lost the comment which was in invalidate_exceptional_entry() and
> elsewhere.  It wasn't a terribly good one but I do think a few words
> which explain why we're testing for these things would be helpful.

I'll put the original comment back. It seems to me it was stating the
obvious, and I don't really know how to improve it since it's obvious
;)

> I expect we should backport this.  But identifying a Fixes: target
> looks to be challenging.

I wouldn't worry about backporting, nobody else has run into this
scalability issue (not even a day-to-day performance problem).

