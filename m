Return-Path: <linux-kernel+bounces-408379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 225A99C7E0C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 23:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F03DB24FA0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 22:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B9518BBA2;
	Wed, 13 Nov 2024 22:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ow/nwraA"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2215F15AAC1
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 22:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731535360; cv=none; b=MshY74aDJQ7U18wXVgdVPKrgNxn1lsoWlPjM3i5Tjac4gAlKBngzu+3fSdwMNzGIEVMjMJju1rc9wCeNxuIq1QXi/aPcqYTKtjbgpWiFzWda84AtE2YhXSmcr3rX3Kk9OTKY+zropZ1oLzye+ya6m4Fm6b96bIQgix9CBK/8y7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731535360; c=relaxed/simple;
	bh=8Tue0NA7Gyr/4e4kASUwpcagXEvSkFrkfPrAWsPw47E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qmu45Sgzf3EbkEt1Hy/WKTWtcgpilU+9axmuph2aWG4sqNSUMdETGP2aahYLbEdMYnsWIgToqJnJsTMb8mtdGv0LNvTrCocaNDoR4gLxDk6SwDeVOG387FknhiCqpZlB0j5PJKN0qbUB4ifR5tMjXNhLBnVRgqGCF8I4e7t2FcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ow/nwraA; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6cbcd49b833so48480986d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 14:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731535358; x=1732140158; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Tue0NA7Gyr/4e4kASUwpcagXEvSkFrkfPrAWsPw47E=;
        b=ow/nwraAcc7jlci30gE8/RZ8In+3jeWDRBgGu79lkBAPIT+Wqrdxd2iRSjJrLs3LNc
         u7HLdKDn70qUkPLck8fKt7wEF9VzOCrC6wANjFqauHnIQR3OG/ono6E7UvxJSF872E1V
         v3fc2lId7aMgWwXcMpqVqzmsesTrl6SEZiiCa//brGqD25KjBBaKMQN/XE67HRobKM4F
         rmFCsPEvDMcLi3CQiSau84AiLzoF4xyElZn15T4ScwjvmYRQHfNScZZyuTuwzsuJfbRv
         hrRBul6665r6vdbVD1IwQ+NbnxOqtBvthjmul8/W9g20S+L6W0bqCYwpJlGNtvWMiL1i
         0w6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731535358; x=1732140158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Tue0NA7Gyr/4e4kASUwpcagXEvSkFrkfPrAWsPw47E=;
        b=ATHTWszRK1l8dG3I+RD4bp+/UdbjTF8z+EfFplUF3N0csQDiAcyvTlBq4x2XnHOdyF
         7CNFthDZ2MT6Q/84ZqPVRG/PJr2CzUY0nrBp4rHGjH8Q6jsBuzwJZ08JlAM6g8QmBIa6
         J5D7VnPUy3HKWKcZpfaygWIDpyYh5B2t/zNJyFvqj3Z8BWaNQRDaElTommEIPjCDjhwE
         IYCDd9n8AgibiE9MuCvyZlXoEitjOPS3J4Tjl/V2onvRxzcuiblPlYnJdbbgU1gnP6Ux
         jAtFWgMhuzXE5j2Xp3+EpYPPOW8cgiN7qbVtxpcqxvp4uR7BzmWroDgjc6S2rv8dKtEy
         pIjg==
X-Forwarded-Encrypted: i=1; AJvYcCWhcmprLfvqknwuyIzR1UgGhq8aFw5eiogbaj0D2vvnGZvM+z9LiTiMVnTiGlz+fqsSmO8iabUA/gDH/Dw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbK/9owB/YGjew9XC5bIOhq/KugnJVy3eJ5TFEBbBj4tjKZKt0
	RzyalLHucLH7arpR+RQHZHVVJFABVCJ1rNW2J0C4mThgrqWgk8flGRNrU8Ze4JwZnsvqbFJSwKB
	h5S/GC551Mtg9bOJdHTxb/6HfoT67VkcgB/8wMLWiFbRLp9OtU0rm
X-Google-Smtp-Source: AGHT+IF5BDgKpU5OEcDYKDM2Wg1pubTLvM+jzGp12TT20Yq80Ru0soRPNTVi2XWqR8cM920PBmqkYGuhXujI83V7vZ4=
X-Received: by 2002:a05:6214:5c07:b0:6d3:4849:1b8a with SMTP id
 6a1803df08f44-6d39e14cdb2mr314905816d6.21.1731535356166; Wed, 13 Nov 2024
 14:02:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113052413.157039-1-kanchana.p.sridhar@intel.com>
 <CAJD7tkZWDhOXyyZnEYFiS7F4tSV+z6TYXUYiEcrZrRuy_3R=ZA@mail.gmail.com>
 <DM8PR11MB567179534CEE154369CCA174C95A2@DM8PR11MB5671.namprd11.prod.outlook.com>
 <CAJD7tkbLtjQqR-uf8EBoFCWbkYOLHsVh6vJoMZUj+z4eN0GKAQ@mail.gmail.com>
 <SJ0PR11MB56781940E69ABE93FF9076F6C95A2@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <20241113213007.GB1564047@cmpxchg.org>
In-Reply-To: <20241113213007.GB1564047@cmpxchg.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 13 Nov 2024 14:01:59 -0800
Message-ID: <CAJD7tkYB44Lgpahg=ABd0bH=iTB3pExNmuUWJpcFcSgND6taYQ@mail.gmail.com>
Subject: Re: [PATCH v1] mm: zswap: Fix a potential memory leak in zswap_decompress().
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"nphamcs@gmail.com" <nphamcs@gmail.com>, "chengming.zhou@linux.dev" <chengming.zhou@linux.dev>, 
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>, 
	"Huang, Ying" <ying.huang@intel.com>, "21cnbao@gmail.com" <21cnbao@gmail.com>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "Feghali, Wajdi K" <wajdi.k.feghali@intel.com>, 
	"Gopal, Vinodh" <vinodh.gopal@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 1:30=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Wed, Nov 13, 2024 at 07:12:18PM +0000, Sridhar, Kanchana P wrote:
> > I am still thinking moving the mutex_unlock() could help, or at least h=
ave
> > no downside. The acomp_ctx is per-cpu and it's mutex_lock/unlock
> > safeguards the interaction between the decompress operation, the
> > sg_*() API calls inside zswap_decompress() and the shared zpool.
> >
> > If we release the per-cpu acomp_ctx's mutex lock before the
> > zpool_unmap_handle(), is it possible that another cpu could acquire
> > it's acomp_ctx's lock and map the same zpool handle (that the earlier
> > cpu has yet to unmap or is concurrently unmapping) for a write?
> > If this could happen, would it result in undefined state for both
> > these zpool ops on different cpu's?
>
> The code is fine as is.
>
> Like you said, acomp_ctx->buffer (the pointer) doesn't change. It
> points to whatever was kmalloced in zswap_cpu_comp_prepare(). The
> handle points to backend memory. Neither of those addresses can change
> under us. There is no confusing them, and they cannot coincide.
>
> The mutex guards the *memory* behind the buffer, so that we don't have
> multiple (de)compressors stepping on each others' toes. But it's fine
> to drop the mutex once we're done working with the memory. We don't
> need the mutex to check whether src holds the acomp buffer address.

I have to admit that I confused myself with this alleged bug more than
I like to admit :)

I initially thought acomp_ctx->buffer can be changed, then when I
realized it cannot be changed I did not tie that back to the 'fix' not
being needed at all. I need more coffee.

>
> That being said, I do think there is a UAF bug in CPU hotplugging.
>
> There is an acomp_ctx for each cpu, but note that this is best effort
> parallelism, not a guarantee that we always have the context of the
> local CPU. Look closely: we pick the "local" CPU with preemption
> enabled, then contend for the mutex. This may well put us to sleep and
> get us migrated, so we could be using the context of a CPU we are no
> longer running on. This is fine because we hold the mutex - if that
> other CPU tries to use the acomp_ctx, it'll wait for us.
>
> However, if we get migrated and vacate the CPU whose context we have
> locked, the CPU might get offlined and zswap_cpu_comp_dead() can free
> the context underneath us. I think we need to refcount the acomp_ctx.

