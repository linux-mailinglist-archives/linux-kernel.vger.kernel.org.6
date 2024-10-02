Return-Path: <linux-kernel+bounces-348059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B45098E20E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 20:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB14CB21D5E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 18:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEFB1D1E98;
	Wed,  2 Oct 2024 18:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wE6/1NWF"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62FE8F58
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 18:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727892440; cv=none; b=BgxISOolrHICjmtJpZ8+kYmkbcwbA4ANiaAJGtkQ+ia1vAeX/2fNYVZwlPB124Ke/CeaAeSqlFQNslo7Jn3vz9FAQVgZRUuy9zjsbIJe2Ixh3kZit4Iq2/GGHEMmPyZ0jj5/0k3tnD/hBCijxhoEJeZvB3LANbXdft4jrF5I+Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727892440; c=relaxed/simple;
	bh=DVXPE8LW0o+h5erW2O73EH0JqEFz3MQVW/H/il1Qi4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D6BGozmBRCk9Ie/MmXhwuXopjz3B3x8wjr3SM7pJfQvL2hQ8pmmGwzSxB2w66edIerHU+ukSo33FjxTxkGnSvKWF+otVTboPGOkmLrNqWXeK3ORM1o46HY7m60MDLIl4zvmKgtx88O4jCFddOjkD6mYt1XLV8UaOnIh14aRwdEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wE6/1NWF; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a8a7b1c2f2bso5611766b.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 11:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727892437; x=1728497237; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DVXPE8LW0o+h5erW2O73EH0JqEFz3MQVW/H/il1Qi4Y=;
        b=wE6/1NWFfb16asdzvCy8Z/inVJacRSWLRaA8A5O84bJTluqr4tuPKj+egOPzzFEjIw
         4hbiubuRAipixBr03MgPWLTfqbNupOagp5x10im8gdqbceWxcq3b4KbtuIQwrJJX8H1Z
         Y+negmyl1u6HV+UUvM6Ot5HU0nNWkAfSgjXpL/NBXrZvfNmnkKStzbGn2VMVL1ji0THp
         GlBdjSHPhhJME5rXJYA4D7DukZVcS55I+luJQF6goSaGxEWvch+liwgX5sYN0gorp1DI
         AIG710g1u8S/rI6zliGTOAQNIv9UX3Vqb3bbVtQ9rCBbQjB7P1TdNxeu+KmofOT6+JCI
         xCEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727892437; x=1728497237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DVXPE8LW0o+h5erW2O73EH0JqEFz3MQVW/H/il1Qi4Y=;
        b=QUyekzCMmEdTl7gZzwYBmYHQFY0KX9pYyC57StOGZdRDfdYAhEDpSPH0VbFFbt4hvG
         jI07SfmRsxpP8Nrs5GVmZrNzbHRYjgkhS4P7cdcEDttxIgIWfXTiN7ck7hoZbIdIstkd
         H/lCL8a12FGhNXorbQZHUNcINS89NdykK++MHn5BcX+m0nhYTOyBnNZRgsAl8FiChKUR
         gGodh1HqtltyEYeH9PfWHxy5kkBLVeJvWwC5UyqF3OOuu9/Xb7ghMp9AYsX8IPz2n4Mb
         KnvKRUMknrzIPpF9bbznv5lVNEHCL0I3T88KyYgNQCAJZdUWwvdgTxyb+auKPJhy03Bg
         izfg==
X-Forwarded-Encrypted: i=1; AJvYcCXLX6sMNwnKtlUqgqyNjXuMMZgxnwj2nzSKpx/FjKKJUrq1VSFqk6jqEmxf79L5K1zBMaBtxZbjLNiasag=@vger.kernel.org
X-Gm-Message-State: AOJu0YwItFYdJgZGZMsL/Ktx4q0aitfVWAKREcaAYMTk9ibOIsqc/CfY
	S5oP+U5sOnu+ghDnacJArI83uUToTQkGmfZMs3InvJznX1JHA81c9htVKUfc60e/Fj3NzXM5puz
	Tameo7N1se3YH4ZRcG3k5XY7ScR2SVsTl+32P
X-Google-Smtp-Source: AGHT+IFnVdqpPsW8lCBi0z9jZOfyK06xdivLZmdsWdN3iWqdFCCajHhvs9K8jIIN5LrJNP1Ha+2BEiAjDdwW2gc0BPQ=
X-Received: by 2002:a17:907:3e8e:b0:a86:9644:2a60 with SMTP id
 a640c23a62f3a-a98f81f6817mr415127966b.6.1727892436723; Wed, 02 Oct 2024
 11:07:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002012042.2753174-1-nphamcs@gmail.com> <20241002012042.2753174-2-nphamcs@gmail.com>
 <CAJD7tkaFv_KmF4gM=wb_Rwi7S1Dt4yy+TU=TyMd1R=gx=3eWuA@mail.gmail.com>
 <CAKEwX=OPaBCYHSesm7wT_+k-MExQk9b8wzEaEg6z9581YkPevA@mail.gmail.com>
 <CAKEwX=OTq2HaEKGgM4n8M60xh217r=vKs4U-GGc83moS5pcZJA@mail.gmail.com>
 <CAJD7tkYOs0Abg4818uCosbGAj=zq0eb-QppcE+w-xzg=TbCWiw@mail.gmail.com>
 <CAJD7tkaPX_AnzMu8c0ezxXkeLi1V-GBEgj6AaerhEK35-dUuUA@mail.gmail.com> <CAKEwX=P58aJo9G2Jq+b0EJP8RJBcd=_MSp-zMSB7ZG5tqr=tuw@mail.gmail.com>
In-Reply-To: <CAKEwX=P58aJo9G2Jq+b0EJP8RJBcd=_MSp-zMSB7ZG5tqr=tuw@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 2 Oct 2024 11:06:39 -0700
Message-ID: <CAJD7tkaZ8gqv+iZuGG2Ce9fhVsmy+a_SbRc-kz-CJvaJsMZdig@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] swap: shmem: remove SWAP_MAP_SHMEM
To: Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, hughd@google.com, 
	shakeel.butt@linux.dev, ryan.roberts@arm.com, ying.huang@intel.com, 
	chrisl@kernel.org, david@redhat.com, kasong@tencent.com, willy@infradead.org, 
	viro@zeniv.linux.org.uk, baohua@kernel.org, chengming.zhou@linux.dev, 
	v-songbaohua@oppo.com, linux-mm@kvack.org, kernel-team@meta.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 11:01=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> On Tue, Oct 1, 2024 at 7:14=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com=
> wrote:
> >
> > On Tue, Oct 1, 2024 at 7:06=E2=80=AFPM Yosry Ahmed <yosryahmed@google.c=
om> wrote:
> > >
> > > On Tue, Oct 1, 2024 at 7:04=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> =
wrote:
> > > >
> > > > On Tue, Oct 1, 2024 at 6:58=E2=80=AFPM Nhat Pham <nphamcs@gmail.com=
> wrote:
> > > > >
> > > > > On Tue, Oct 1, 2024 at 6:33=E2=80=AFPM Yosry Ahmed <yosryahmed@go=
ogle.com> wrote:
> > > > >
> > > > > I was debating between WARN-ing here, and returning -ENOMEM and
> > > > > WARN-ing at shmem's callsite.
> > > > >
> > > > > My thinking is that if we return -ENOMEM here, it will work in th=
e
> > > > > current setup, for both shmem and other callsites. However, in th=
e
> > > > > future, if we add another user of swap_duplicate_nr(), this time
> > > > > without guaranteeing that we won't need continuation, I think it =
won't
> > > > > work unless we have the fallback logic in place as well:
> > > > >
> > > > > while (!err && __swap_duplicate(entry, 1, nr) =3D=3D -ENOMEM)
> > > > > err =3D add_swap_count_continuation(entry, GFP_ATOMIC);
> > > >
> > > > Sorry, I accidentally sent out the email without completing my expl=
anation :)
> > > >
> > > > Anyway, the point being, with the current implementation, any new u=
ser
> > > > would immediately hit a WARN and the implementer will know to check=
.
> > > >
> > > > Whereas if we return -ENOMEM in __swap_duplicate(), then I think we
> > > > would just hang, no? We only try to add swap count continuation to =
the
> > > > first entry only, which is not sufficient to fix the problem.
> > > >
> > > > I can probably whip up the fallback logic here, but it would be dea=
d,
> > > > untestable code (as it has no users, and I cannot even conceive one=
 to
> > > > test it). And the swap abstraction might render all of this moot
> > > > anyway.
> > >
> > > What I had in mind is not returning -ENOMEM at all, but something lik=
e
> > > -EOPNOTSUPP. The swap_duplicate_nr() will just return the error to th=
e
> > > caller. All callers of swap_duplicate() and swap_duplicate_nr()
> > > currently check the error except shmem.
> >
> > ..and just to be extra clear, I meant WARN _and_ return -EOPNOTSUPP.
>
> Ah ok this makes a lot of sense actually.
>
> I'll return -EOPNOTSUPP here. Do you think warn within
> __swap_duplicate() makes more sense, or at shmem's callsite make more
> sense?
>
> I feel like we should warn within __swap_duplicate callsite. That way
> if we accidentally screw up for other swap_duplicaters in the future,
> the feedback will be immediate :)

I think we should warn in __swap_duplicate(). We can also propagate
the error from shmem_writepage() to the caller, but I think this may
need extra cleanup to be properly handled, didn't look too closely.

We can also warn in swap_duplicate_nr() if we ever reach the -ENOMEM
fallback code with nr > 1, and document there that the current
fallback logic does not handle this case (instead of documenting it
above the function). This will make sure we never return -ENOMEM from
__swap_duplicate() incorrectly.

