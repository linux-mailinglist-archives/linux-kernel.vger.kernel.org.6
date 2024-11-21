Return-Path: <linux-kernel+bounces-417166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCDA9D4FCC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 16:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 703DB1F23305
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 15:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC5E16F0CA;
	Thu, 21 Nov 2024 15:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LrA0ehL6"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1537B41A8F
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 15:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732203329; cv=none; b=DS4TPkmwAwGlLMV5wRjTi0fGxGDvfuh46dQQzI6aQbJsNlzAr5/y+JeNNloGublruWedTJSTj4sFzCrL/2mtYoQf5+5v84cjbhFwWi52QFXs8tAr5TNM7CQqSymX/zJ4TVKE5/Tnhh8ICmKMZ/aiE13IpqGSLQmb5cfM9GIwWW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732203329; c=relaxed/simple;
	bh=SsArjD+1glKC3LFuUTU1qcWsOXBbI35QwXJjYvQPPgA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bLXLSoTAuHxTomUM5Ye6zp4W3AuC4Xqi0g6rOH2GcTpcU3hKpA0wWb2atitB4nUXa2WnyKXi54hZi8vEY6IF3QQjKGb5zS0dIRDL1lS7SVQzsvTbOL2jCKeaXS4qW4trHtz88z/MaUZYaA4lH04GFdPvxQCRSaXTHgIfPl3SEfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LrA0ehL6; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-460969c49f2so310351cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 07:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732203325; x=1732808125; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=547IccmQdfQpz/uAg3RPtdIl621CchRTsFZX3/wSte0=;
        b=LrA0ehL6FTKR5tjVH6H7Sz1LsI2UZxFCr7xYy40jxgryu6zR+aFZvSqmA9N9f5WCz2
         DJLxu053DEtZRDaNl3XQFC7VO8uV78F7xuNwvJXBz0OJsw5PgxKS0poXzu94reKRWxfm
         ry/pGpd8aAvjCW83om3onFTfX9EqavzbXADID/DMmfphL3zwBF6UULv0/Jdp/cKpR3MW
         Unw2X0eleCHKBGMQS17yQncoihX8fdf2SHUGXXew/rnzGuAAxpPkZl93Xs8ujHAsDPWX
         4IY4tUCljB511KYHE4agp51sowqB4Oo9+rg1GOtWhccOc5KlpMYh7Gy0GS95nk/l1ENx
         mW2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732203325; x=1732808125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=547IccmQdfQpz/uAg3RPtdIl621CchRTsFZX3/wSte0=;
        b=So4RmcxDeqFyUQ59Z0PwFVAjjsmI1RADlU4sufUXOpiroxAC4iDn3B2nKYf6UdQccG
         5si1V5CZJ0Tc9aZvFe6ls9TUPugFVRcS8dgcyiULXbHXwM9ppdCYKPC/T9kZx1ajDQbV
         9r62KQ9wEoHVn6+eeJ4JMjU1m9T2bnJdzG2b57oBRbTbbuw6Ejipj66wWdxAU7rYv0RF
         b745j6G79V2uJ6ayvZFmJ6/A5AJirQWrbw0U8kBHcS7j9coxgdtkt4VWRQEadqIOjqHt
         eRk+zy2CKD3PxEhtQWFNd8B1fBDbGHkhgSE+bYGA/tCNukp/WqX0baamNExg9qJC3LKo
         kntQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYskH+RG4BwsDiiDFAw/9SfLonhFSGkFTRANpZCA6c0dCS6B88EuWPhXQGrX5Et6uo7Icf3gJXY5DS3wo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2Ndyjs5+J/srtstllec4fHEACsB0JVJ//vp8F40dmHh3k3mQA
	vDVV1plHYhao/QA4rhOyx4cAU6mgE+JG34yM96Q8mSkem5lLNNCASOm28ZLXii4Uq0R8ivgFdDZ
	SHwyj5pHBtPbsVMNOM8i/uJ3D4eMxvC30ZHKL
X-Gm-Gg: ASbGncueBcwwF5dMl2idT15SD7aPuvpE5spdKcHT79sqt1o30swU1uSeXsAialVaALC
	p893gR18jxootYkbiLuEPV8HndtHbTL4a7sAJB3b8qS1B9oLofCmFvbDQZvff
X-Google-Smtp-Source: AGHT+IFADvU4IPxoEGDBvsiWv2fnt3CEBsmaslZcEQXF5z8gP7iOsIe3UKpqtmvlizSwxHzRxnFWvsa1H0vOdEmntPk=
X-Received: by 2002:ac8:59ca:0:b0:461:6e0a:6a27 with SMTP id
 d75a77b69052e-4653bd848d4mr96191cf.20.1732203323364; Thu, 21 Nov 2024
 07:35:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028010818.2487581-1-andrii@kernel.org> <20241028010818.2487581-2-andrii@kernel.org>
 <20241121124011.GK24774@noisy.programming.kicks-ass.net>
In-Reply-To: <20241121124011.GK24774@noisy.programming.kicks-ass.net>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 21 Nov 2024 07:35:12 -0800
Message-ID: <CAJuCfpEBJsR803Ac-cwN0MWadzWW_WKZchaexdJauYETaww40w@mail.gmail.com>
Subject: Re: [PATCH v4 tip/perf/core 1/4] mm: Convert mm_lock_seq to a proper seqcount
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	linux-mm@kvack.org, akpm@linux-foundation.org, oleg@redhat.com, 
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org, 
	willy@infradead.org, mjguzik@gmail.com, brauner@kernel.org, jannh@google.com, 
	mhocko@kernel.org, vbabka@suse.cz, shakeel.butt@linux.dev, hannes@cmpxchg.org, 
	Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, david@redhat.com, 
	arnd@arndb.de, richard.weiyang@gmail.com, zhangpeng.00@bytedance.com, 
	linmiaohe@huawei.com, viro@zeniv.linux.org.uk, hca@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 4:40=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Sun, Oct 27, 2024 at 06:08:15PM -0700, Andrii Nakryiko wrote:
> > +/*
> > + * Drop all currently-held per-VMA locks.
> > + * This is called from the mmap_lock implementation directly before re=
leasing
> > + * a write-locked mmap_lock (or downgrading it to read-locked).
> > + * This should normally NOT be called manually from other places.
> > + * If you want to call this manually anyway, keep in mind that this wi=
ll release
> > + * *all* VMA write locks, including ones from further up the stack.
> > + */
> > +static inline void vma_end_write_all(struct mm_struct *mm)
> > +{
> > +     mmap_assert_write_locked(mm);
> > +     /*
> > +      * Nobody can concurrently modify mm->mm_lock_seq due to exclusiv=
e
> > +      * mmap_lock being held.
> > +      */
>
> You can write:
>
>         ASSERT_EXCLUSIVE_WRITER(mm->mm_lock_seq);
>
> instead of that comment. Then KCSAN will validate the claim.

Thanks for the tip! This one looks not critical but I see there are
more important comments in "mm: Introduce
mmap_lock_speculation_{begin|end}". I'll send a new version shortly.

>
> > +     mm_lock_seqcount_end(mm);
> > +}

