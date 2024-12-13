Return-Path: <linux-kernel+bounces-444265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F799F03C8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 05:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72EFC188B533
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 04:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C2717D378;
	Fri, 13 Dec 2024 04:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I4utew6C"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA8B149E00
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 04:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734063768; cv=none; b=D4Nizj6YQfb260IK91jUO4tABrra38OGC8cQyyaTstv/T++RQVWZsRzDBggj8jN/q5pZyw3MPHpG5nTeJlSQBidTVSINUxNbfQPE4SOzz3uOjFr/79/WvhPIFpbaSGSsFiRKF2ZPfPI/DR+QoJzBrdokkmmuzKxxbrMAUb1APVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734063768; c=relaxed/simple;
	bh=ojlvihfvzGrfCRyRnL2DrfCyL4PYjfoSzc9ch2VJB/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d3/l0NoqBqAWjoqe94kuhXIPfA0vnf2lDooBaCxdYVWG8tHQ7BZ8bUSDa2KIyE8ERIyKrxt1Vg8YzsGL+kKV1mvBdinCvtJ1AzgxW40r84JQgrFtmWkQSYZ0F5egN8O9ZAcI4tm8SFMrvMsjrXYEDYTLd5uGPBJNRaeyrHymIg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I4utew6C; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4679b5c66d0so96491cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 20:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734063766; x=1734668566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2zusNDVE9tIk+XAMjo2wDNCl3eBQntRzpxBDCfZphJ0=;
        b=I4utew6C9zywE4n0320HfYJ/pzrUnQOVGZlhQ0GJ5wnUqjMP5CJgvlsiFAOK335lmR
         R1FX+eedvhchN2d8+NQcSQmUNJS6OwzT9QaVxhWhbmtiUuD2OIJinsnitUZRvQj6BBQ/
         WU+UN5SEMfbsWZmiTUQOklRvES5/FHLFDi3VeG8eQ+1Me4/fuXS2cpbPTWqUn3qL7trL
         cvBfKhlDP4HQDoEtyxGtovBuurZ/MJ8IAla/mJZt7kp8FSGHwHVqJ0loePs5MNo7xcrC
         jtIIxJGqKEs7WCOERYWs6tQLgrsnFrG3LaOm61V391vBKkPkvcZEkvwC6ZLrX8Z/YOMC
         2lmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734063766; x=1734668566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2zusNDVE9tIk+XAMjo2wDNCl3eBQntRzpxBDCfZphJ0=;
        b=lrhyZNMMcL8Q6jtJbZ/T6RUvROBvp+fyhqeJ9MY4AeRuNhi5UZDJPj1gzEUfh8FX3o
         Ehz38t1Y+QuHnOTWxx0k80ABS2G/FkYRDeguMUj8+fSktdfQFVVvTBkRdjJ0Vsq++frg
         T1R5g0CFA+4gCW4879mkosqMOm6UQ7XABlkpWL0Ez8lRsA4SCIq/N+EME6IGcIj5h499
         PbfUcnM+8Q+iOMGSQaI9hsWH7fxOyno6XE+lNVkkMYvz1TdW5gboGcqWtlfX1uHlfR2w
         MnWL+HYVGOM3sA407ENwC4u3MmuTQZaha5Y/ck+NCqvLKZqF/Glab0OPL1tG/bbpCQdv
         O5iQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwkTjIim39ii9cGEFO+SrB9WEuy0ZnWXYnrMaFVWlVjbC9pU12ws8oh93UQfbgM2XmBCM8FNIC4G4nNss=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMqYGWN+AkxwsanHsBXm6mH6fozNOdNU5cONXsokBx3oVoLt8w
	Ss6t7J2O76YPbinlB9LWF4XlezeDV7C3Nrxx9aOklq43n/KqH88VLyYFipsQVde3ted2RX0JZL9
	YKJ+8FpuKb8K7NggwGnPZEmopqmblOZTh4HrT
X-Gm-Gg: ASbGncs0JlNUxYBu0DZ45+TKqownp203OC7CT53et+vxikiTx+//HiZMuBL0vmBN8td
	vt1jjdl99tqp6D6ZSCuDon9wpqgw2zMpqmSzi+Q==
X-Google-Smtp-Source: AGHT+IHUjsjX9/4hhtNsDvYlspKvkzYig7wPXadi+PWScjnds/jNc+sQHm8865fCSk/cwCPwuMUgBfUr39sbO0iN8jA=
X-Received: by 2002:a05:622a:250e:b0:467:462e:a51b with SMTP id
 d75a77b69052e-467a4275a11mr2308501cf.14.1734063765511; Thu, 12 Dec 2024
 20:22:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJuCfpF2e7niEbR=nX2u0HZHq-7tjRGB=xV397pFpjdzBqUGfQ@mail.gmail.com>
 <20241213013332.89910-1-00107082@163.com> <20241212201212.c61bfebbbdb51b3c8bfeed11@linux-foundation.org>
In-Reply-To: <20241212201212.c61bfebbbdb51b3c8bfeed11@linux-foundation.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 12 Dec 2024 20:22:34 -0800
Message-ID: <CAJuCfpEbEd57-8Lrn9_jSK0p=KN7p0PwsuhhjxJViqcN+v+0bw@mail.gmail.com>
Subject: Re: [PATCH v3] mm/codetag: clear tags before swap
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Wang <00107082@163.com>, kent.overstreet@linux.dev, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lkp@intel.com, 
	oe-lkp@lists.linux.dev, oliver.sang@intel.com, yuzhao@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 8:12=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Fri, 13 Dec 2024 09:33:32 +0800 David Wang <00107082@163.com> wrote:
>
> > When CONFIG_MEM_ALLOC_PROFILING_DEBUG is set, kernel WARN would be
> > triggered when calling __alloc_tag_ref_set() during swap:
> >
> >       alloc_tag was not cleared (got tag for mm/filemap.c:1951)
> >       WARNING: CPU: 0 PID: 816 at ./include/linux/alloc_tag.h...
> >
> > Clear code tags before swap can fix the warning. And this patch also fi=
x
> > a potential invalid address dereference in alloc_tag_add_check() when
> > CONFIG_MEM_ALLOC_PROFILING_DEBUG is set and ref->ct is CODETAG_EMPTY,
> > which is defined as ((void *)1).
> >
> > Signed-off-by: David Wang <00107082@163.com>
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Closes: https://lore.kernel.org/oe-lkp/202412112227.df61ebb-lkp@intel.c=
om
>
> This points at
>
> 51f43d5d82ed ("mm/codetag: swap tags when migrate pages"), which had
>         Fixes: e0a955bf7f61 ("mm/codetag: add pgalloc_tag_copy()")
>
> e0a955bf7f61 ("mm/codetag: add pgalloc_tag_copy()") had
>         Fixes: dcfe378c81f7 ("lib: introduce support for page allocation =
tagging")
>         Cc: <stable@vger.kernel.org>
>
> And I'm thinking that this fix should have
>         Fixes: 51f43d5d82ed ("mm/codetag: swap tags when migrate pages")
>         Cc: <stable@vger.kernel.org>

Yes, that is correct. Sorry for missing that.

>

