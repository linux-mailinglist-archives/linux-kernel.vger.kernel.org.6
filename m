Return-Path: <linux-kernel+bounces-407937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE50C9C7797
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 16:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A43C52875EA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 15:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9E413B29B;
	Wed, 13 Nov 2024 15:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dLbHHppD"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793057C0BE
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 15:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731512735; cv=none; b=lKLY/m92xS2j4uwxLMTIToyQG7561hZSB+NzpXr1mCQXi3pOYnHYs4lwZKgr88HvtEB+R/gxscC1go7K08JhX4VDQs9nnZYsUw8Ucoaea5c6k5ekgqADlDCAMIoMelIvuMpZwSt06lQdJyYeeLhJZn42TtUUK7c5zrqcygJZAiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731512735; c=relaxed/simple;
	bh=y9LcAqJQLCHBtE4PTnGvwVOmtzNtUb5KN/Kd4UQbnZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bDwknc6HT49LGbClNJ0MxiwIXGcj59H+qkGf7iTDaYws3c10Dy1yK0Vu9NzYJIULQaTIPbBLh2nk/tQqgSFmgMLq//KK6iQgXU6BWrbP5Nli7d3aZHJ8fo+eFH7bIhWLXBM80Ki4Bp9bIor4dUfLQ5K1/4Io+epsspFupoKS7lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dLbHHppD; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-460969c49f2so301901cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 07:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731512733; x=1732117533; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y9LcAqJQLCHBtE4PTnGvwVOmtzNtUb5KN/Kd4UQbnZw=;
        b=dLbHHppDwk03SIp3kiYfiiCJ228yG4LelNGcQMfdKE+ZGVBuRpDgkIPjtJV7HvVJFE
         hQfoym5wCQWQjhuV67LMT8NOwiOYtB3faDgnkAiVPkJL8KgpBifRKhwcj2bAXaQG/HyF
         F6gSOwDHOIqhCD3iyZHmgarALPbZ8Y1qhizfbuJFqbfHOhJhN02pJU9whbk9gNtFmLeD
         MbbPuRjvulj9h6u//eMF9JM7W6F+/eA9UN35BrUr2SN8eZM9SFKACsxy2uOpf1jvuRqj
         Hi+TjLfV/uvQ9KwUiIi7yy2CC3C8ugrPJURoqyyZlWU/THFR4U5lRL2GckEMfQhR1zBc
         BenQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731512733; x=1732117533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y9LcAqJQLCHBtE4PTnGvwVOmtzNtUb5KN/Kd4UQbnZw=;
        b=I/K2BVgS2A8erksytV2o25KO2hNT1f8LTNjJPazX45lnLnvf1D1ukGXWxfAQ1+x/pG
         4wPt3WZQzwpAtCGJC+n5zxu5V4sQiGgKF4uvbdnp0R2mCdcHRMxJ8UD8/UI7cU5OWBSh
         w6kepgW4CHBIv2wKFAe4t1Juzfp3lp9lbZQ/nBeqiq2dEQQz55HB7zjOeD4xj9upEn8g
         1OCjnHWZpLDcNZH88PZN6HLJ9bp/JmMkTrFQGuvyduHgYv9gfpJw7kh+A/CdkFIL1Ewa
         cujZtlZfJOyV0h98Jdq4wPrcAaGhIT0yw16fp+8f12svaqz/bCDyOFI7s5uTP5AEIwSZ
         QCrA==
X-Forwarded-Encrypted: i=1; AJvYcCXsHwNEE69uKpdrgvDjQokcQTStk1ImZtkSwPYHmukCWdfbigTAfQ6GHQ6cDCSSksZi95ZXr/tc07Z7leo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIkkapbAPsuPnfSfs9tmcfxXQn2HYAf1Bj02bNZTi1iTkaXrem
	f6ckTIZXELugTeSZ+3rEobePIa176PvADZG0GsyYtObxfSq6Kq5rTU6CGR9dN9rvvDtDXkIKdkK
	6tEjW9y1dGL6QC1TLsJ6V/OiQhelKAHsk0BoM
X-Gm-Gg: ASbGnctf7g5nvGqLGzWwiLNdM3IYg9/jkIb2f37DSYM8BeAj/s2z/TlL4gFLwAfnWJv
	egO7s87fmiuvDLyd1NKNl7kx+eq3CPWY=
X-Google-Smtp-Source: AGHT+IEU50ssIRkLH4v8of+m3tqCQvKnSi3e7I6ibXMiHACUohVg9DGIX6dJ3TtfEcYenzYEZtiSpyNteI9xWnXGsuI=
X-Received: by 2002:ac8:6716:0:b0:463:53bf:19c0 with SMTP id
 d75a77b69052e-46353bf1db6mr945271cf.11.1731512733108; Wed, 13 Nov 2024
 07:45:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112194635.444146-1-surenb@google.com> <20241112194635.444146-3-surenb@google.com>
 <637370b8-3e3e-4457-81d6-5913a3ff1d4e@lucifer.local> <5d34da83-92eb-4666-816c-73a0e831aa89@lucifer.local>
In-Reply-To: <5d34da83-92eb-4666-816c-73a0e831aa89@lucifer.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 13 Nov 2024 07:45:21 -0800
Message-ID: <CAJuCfpEe9Sas46r1QUEe7Bu3QD5atKUxy3E5Z8Xg66aZS81suQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] mm: move per-vma lock into vm_area_struct
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, liam.howlett@oracle.com, 
	mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org, mjguzik@gmail.com, 
	oliver.sang@intel.com, mgorman@techsingularity.net, david@redhat.com, 
	peterx@redhat.com, oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org, 
	brauner@kernel.org, dhowells@redhat.com, hdanton@sina.com, hughd@google.com, 
	minchan@google.com, jannh@google.com, shakeel.butt@linux.dev, 
	souravpanda@google.com, pasha.tatashin@soleen.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 7:02=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Wed, Nov 13, 2024 at 02:28:16PM +0000, Lorenzo Stoakes wrote:
> > On Tue, Nov 12, 2024 at 11:46:32AM -0800, Suren Baghdasaryan wrote:
> > > Back when per-vma locks were introduces, vm_lock was moved out of
> > > vm_area_struct in [1] because of the performance regression caused by
> > > false cacheline sharing. Recent investigation [2] revealed that the
> > > regressions is limited to a rather old Broadwell microarchitecture an=
d
> > > even there it can be mitigated by disabling adjacent cacheline
> > > prefetching, see [3].
> >
> > I don't see a motivating reason as to why we want to do this? We increa=
se
> > memory usage here which is not good, but later lock optimisation mitiga=
tes
> > it, but why wouldn't we just do the lock optimisations and use less mem=
ory
> > overall?
>
> I worded this badly. To clarify:
>
> I don't see a motivating reason _in the commit message_ as to why we want
> to do this.
>
> I am certain there are, in fact Mateusz and Vlastimil have provided them.
>
> So my review is - let's just put these there :)

Yeah, I had trouble wording all the reasons because in my head it was
simply "the right thing to do". Now with all your input my job has
become much easier :) Thanks folks!

