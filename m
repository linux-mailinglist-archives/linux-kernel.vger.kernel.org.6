Return-Path: <linux-kernel+bounces-263520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B3793D72B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 18:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBAA1B21194
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 16:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2BAF17C201;
	Fri, 26 Jul 2024 16:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p3jibGVi"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BE811C83
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 16:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722012423; cv=none; b=cHVo9cEcDpq4KtVg9CEVwfshaWsOGTmfXaSMevucq+JskImM22WNswxd7tb7vwx5mKcfPmmZLDRF1r1TYDDGPmtNvUBJa3YP0YlnK7BNElvIlA1HWJjQPcCgO1y5vzildn14ut/EWPRNVdPtYfiVuz0v/eCwCoA0wQ8dmW3cySs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722012423; c=relaxed/simple;
	bh=VsX59mPgZtrEie39/GZ8ygIZ9hc+816v+5X04tjRwYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ipW/B8LTdk9aU1vbL9j6lUIUuhvmmNl9dOwrfW/pv/syzwnmGXnqDlmsUQbonrAX4oEc8qAU7lkqqPJaH3WPkHUzA6zDHvMSXM6HNkVI/z/R4hfbnqs7sV50n9cJusC3jUqc2GaF9ZXdpJkzbSqYZkbtqBWZIi3bq8UwPK2vtk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p3jibGVi; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dff1ccdc17bso2210902276.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 09:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722012420; x=1722617220; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VsX59mPgZtrEie39/GZ8ygIZ9hc+816v+5X04tjRwYI=;
        b=p3jibGVioZDUwtW9wBmlSecmJfEVnPyjHZPJVTivu49bTF0XX341kiD4rpA3yNDwaF
         qXJ7fUnD5tjtf/YzCuPkxN8q2PhJ/hxas819ws7XLL6C5Ovm9KU23UqS1gPzTJrv7dSc
         3mKP6T49bp0c8iq1RDeGkcvBVCLozRSsOBOzLN592oNIzDITy/waKVApkSl7R5z+L1x8
         2IeX8IDVoZOWoN9kQnbioa0/unHKYtYkaRxEHH7qwJAwHfic9zIJVx+gjZXxoH3uE5nU
         j38sDFBa+y3yueQGtDAFdR0Z6eh9Iuu0R7TSEfeYWNm3MpSpH2lk+sW0IH5aQPRGPaJH
         tEeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722012420; x=1722617220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VsX59mPgZtrEie39/GZ8ygIZ9hc+816v+5X04tjRwYI=;
        b=ntYrmL6yTn0wK1/e3btt8FhKTar/zAFTTNUcOmXb/4OW78OZeXO30qX/lVnFaCTxdD
         m5y2jjQVypkGJJOQpFylmeao9ZHIPzxhknYmmLvFMdZ9sEh2pDK/Kw/qNTzhFNgT1Q2S
         l2gFaKA+W4bTESO4BLKN4qLizmvXH4SEza9SEucITYf93X0uOtrSgpmp0EkII/G2reVm
         KeeBnJxZNet/Iw2gez8W/Z4xiFQZFQp0g6WJnJA4MsGJQWwqUArSoBBrEe5s25uUStfC
         i+Gn6voyurW+QtYGitTBmtGWD0zWsoYFGIjKjwe//w9wbEv09bsTpWFuJFsJ2DuH4A+b
         ooww==
X-Forwarded-Encrypted: i=1; AJvYcCXTnKBrF7EbH/ql0iovV5Wcd2guv46934T5LgkknjS6GiDbEidMjfQhD+uowH36rSzzIId7a3k5WoKL6iA2TezO+b4Q9+lWxa2qb+Bo
X-Gm-Message-State: AOJu0Yyw20/n12uYYRU7VjbUTAx7p07qGPqjJ7iRfCbMx2xZceNfemgT
	2+J2rEHBzLarxc2pW2qcMpG87A+n+QXoGT41an5N6T1VsZpFLIA7bF+HU/RHeGvVfQUk+UDYY2d
	tbIKddnNybnagymYEwx2umOL+dCOTuHnDW+u7
X-Google-Smtp-Source: AGHT+IHvjARSHS13OyZRvXmxTUtGDoqeMUEoVpKPSZdXCI6sy/VtejyKKxC30+vNfneTHF35XYilujQgIJqHT7UU1to=
X-Received: by 2002:a05:6902:1028:b0:e03:3598:2989 with SMTP id
 3f1490d57ef6-e0b545bffe6mr372203276.45.1722012420186; Fri, 26 Jul 2024
 09:47:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722225306.1494878-1-shakeel.butt@linux.dev>
 <CABdmKX2Hsd7i_Erc2_n8FQqY90mMgX24hkVe+z=y9tCk7sUL6g@mail.gmail.com> <dhq4sgkuyix6le66i6usodzs6pqyturvl7awmzuyfzpgbqg5x7@xxocuq2wmbvd>
In-Reply-To: <dhq4sgkuyix6le66i6usodzs6pqyturvl7awmzuyfzpgbqg5x7@xxocuq2wmbvd>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Fri, 26 Jul 2024 09:46:47 -0700
Message-ID: <CABdmKX1LyubDhin5B_PxOrxHKyEsanZnW3yfd7+OyJG6am5ucg@mail.gmail.com>
Subject: Re: [RFC PATCH] memcg: expose children memory usage for root
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Greg Thelen <gthelen@google.com>, 
	Facebook Kernel Team <kernel-team@meta.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 8:47=E2=80=AFAM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> Hi T.J.
>
> On Thu, Jul 25, 2024 at 04:12:12PM GMT, T.J. Mercier wrote:
> > On Mon, Jul 22, 2024 at 3:53=E2=80=AFPM Shakeel Butt <shakeel.butt@linu=
x.dev> wrote:
> > >
> > > Linux kernel does not expose memory.current on the root memcg and the=
re
> > > are applications which have to traverse all the top level memcgs to
> > > calculate the total memory charged in the system. This is more expens=
ive
> > > (directory traversal and multiple open and reads) and is racy on a bu=
sy
> > > machine. As the kernel already have the needed information i.e. root'=
s
> > > memory.current, why not expose that?
> > >
> > > However root's memory.current will have a different semantics than th=
e
> > > non-root's memory.current as the kernel skips the charging for root, =
so
> > > maybe it is better to have a different named interface for the root.
> > > Something like memory.children_usage only for root memcg.
> > >
> > > Now there is still a question that why the kernel does not expose
> > > memory.current for the root. The historical reason was that the memcg
> > > charging was expensice and to provide the users to bypass the memcg
> > > charging by letting them run in the root. However do we still want to
> > > have this exception today? What is stopping us to start charging the
> > > root memcg as well. Of course the root will not have limits but the
> > > allocations will go through memcg charging and then the memory.curren=
t
> > > of root and non-root will have the same semantics.
> > >
> > > This is an RFC to start a discussion on memcg charging for root.
> >
> > Hi Shakeel,
> >
> > Since the root already has a page_counter I'm not opposed to this new
> > file as it doesn't increase the page_counter depth for children.
> > However I don't currently have any use-cases for it that wouldn't be
> > met by memory.stat in the root.
>
> I think difference would be getting a single number versus accumulating
> different fields in memory.stat to get that number (memory used by
> root's children) which might be a bit error prone.

Yeah that makes sense, I get how it'd be nicer to do just one read in
the root instead of digging into all the children. I just meant to say
that when looking at the root, currently I only care about a
particular stat (e.g. file_mapped) instead of the whole usage.

> > As far as charging, I've only ever seen kthreads and init in the root.
> > You have workloads that run there?
>
> No workloads in root. The charging is only to make the semanctics of
> root's memory.current same as its descendants.
>
> Thanks,
> Shakeel

