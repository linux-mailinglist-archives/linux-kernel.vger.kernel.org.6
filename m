Return-Path: <linux-kernel+bounces-238646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6F4924D5E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 03:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D934284D23
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 01:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2137A1FB4;
	Wed,  3 Jul 2024 01:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="12Jf0vNh"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9256138E
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 01:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719971901; cv=none; b=s5euKhrRwt+Hvu8GTAGgTyN/cSPmtoQmLEX2EicUMg6dJ9vEKFpR0LduzS9TFR6fLodWfAPo6dH1guXfoDWu1/a0V3lcUai8WTY5ZO/Z7n/Mi2JXD9q9hE4hgGNshxyBOOfx7gPQZKG9t+N1tYes1qsjvyd+eTqYdi6iZG9hjpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719971901; c=relaxed/simple;
	bh=uk0GJoRHfWkj7+H1v6+2c9m8FurjseDBIprPtk/NzQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QSKAEzcQy2HzPdYf2ewH1ghdST00FkZZmgNARAJuQIA50Wv+yBqjkaF/jqFm1JTgA6bRekNRN+W9BhtmbLnJ0NWWe3pdFI3vhmxixvyV4HS1uYcjCvbns1aeol4aO+R8feTYNbhhT0e1E2fgJYtr5RbaK9TWrFsBdhjxI4QXqTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=12Jf0vNh; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-64b29539d86so43293677b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 18:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719971899; x=1720576699; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uk0GJoRHfWkj7+H1v6+2c9m8FurjseDBIprPtk/NzQo=;
        b=12Jf0vNhmSuK2f6lLZGuyiXxOOSsx+9+j+GMJSevEdb/djqJRAZnChNbxEbxZCfMF5
         gchs7yhxPN9UBNugBub9XFzwgTM7cTzqzFgOtuKAfng4o1eBnYyNFB5lMjY9Xd9Lf4Cu
         7A4bcU/Yr9DOIsWddRaVMRo6ML1yQ3qjCa5lUxt+XdZln4Y9xzH8PWLTwoUJ0KE7Uwxx
         5SvXjIpCb/0CAM9vbuQHvki+TAvkwFEBCzKROTGQJ4mdax+xElw8Kf5nnL+xKYeMqygh
         CZV/r3qNiRHt7qLQGxPSBut2+8G7mShG3NVKaDN0iPWHc5ScPb5taRvfbXqoeJQniFT2
         hkRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719971899; x=1720576699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uk0GJoRHfWkj7+H1v6+2c9m8FurjseDBIprPtk/NzQo=;
        b=TWX1QLqhzvDbsKlB6IELnW585wBBSDrue9Vb6bvK31t3Ufk1BbMRLpXAA3JoOkdkuL
         ReK9ub6hyHPTT8LBVFX+FjmzEVH4iNgOul+MbOondvUiZpIOMsq14PNZavpQRCtZIpDW
         0+f/znYR6e/62y2VeCXq3EtnDFFZFXpKZAdhPOEUgQccuwZF5LWcQ+B4n4ytTUAl5izl
         cVAQn//8AvGW31JA60QSTDFPbJQjPwwd+0/FJeGBUXtpbSwlCAMymtR/D9NOvhahdKxb
         ooCzHB9B2in/nb6AVYtcnnHAzg9ScEvL+DUWXrRDKBakMOhUsRBK3pcsspQpjE5s4ziR
         RVQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOSrz5spa6kN66HVy6nXC2IfUJ8HVNz5rzB/ytS0736uRfubfGpeNOluzGp5DhoLs04JjNXwatpKR05tkIbkfGpI1rPiD0jEjry5p7
X-Gm-Message-State: AOJu0Yxy8IlQUYlVGzszZeVYaEC6/3jPjbsZviP6WRWNAyhndCjq/xMH
	BHW7eoRyGwd0nkFVh1sb5qZYGP2FqCFsgkj/wNB4IVC98U5a1bRhRwpcaHGQ8q3lx3wVRE6MnWR
	PrguQIfmUtuNtZrgeGUfujCjOR23NjpqvbW9X
X-Google-Smtp-Source: AGHT+IE8CJ8oZ/bFRW+PT5mM0jYJyPu79xaWWoRxA+P2hfKfYSP71RYPrsSK3I1bMf+QJ/tWAKxB6EBa4neIA7TmBoM=
X-Received: by 2002:a81:ae18:0:b0:650:a40c:acb1 with SMTP id
 00721157ae682-650a40cadb0mr29215107b3.28.1719971898541; Tue, 02 Jul 2024
 18:58:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614225951.3845577-1-surenb@google.com> <18a30d5c-abf3-4ceb-a7fd-2edfd8bee2a8@suse.cz>
 <CAJuCfpFPDAjE5aNYxTngxzAusz_9QkOdnELSRNadi2Sxb4O=oA@mail.gmail.com>
 <bb4214ca-fada-4aa9-af40-008182ea4006@suse.cz> <CAJuCfpGr237=zQb58Zd6E-NmpBfvq-6_LQ58nsiwgx9S1KE0pQ@mail.gmail.com>
In-Reply-To: <CAJuCfpGr237=zQb58Zd6E-NmpBfvq-6_LQ58nsiwgx9S1KE0pQ@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 2 Jul 2024 18:58:05 -0700
Message-ID: <CAJuCfpG5R54jOq1psZKY5FKLKZNnVGCqo2bkyT3v=GX_ikozVw@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/slab: fix 'variable obj_exts set but not used' warning
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, 
	pasha.tatashin@soleen.com, souravpanda@google.com, keescook@chromium.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 8:16=E2=80=AFAM Suren Baghdasaryan <surenb@google.co=
m> wrote:
>
> On Tue, Jul 2, 2024 at 9:31=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> w=
rote:
> >
> > On 6/30/24 9:20 PM, Suren Baghdasaryan wrote:
> > > On Mon, Jun 17, 2024 at 3:04=E2=80=AFAM Vlastimil Babka <vbabka@suse.=
cz> wrote:
> > >>
> > >> On 6/15/24 12:59 AM, Suren Baghdasaryan wrote:
> > >> > slab_post_alloc_hook() uses prepare_slab_obj_exts_hook() to obtain
> > >> > slabobj_ext object. Currently the only user of slabobj_ext object =
in
> > >> > this path is memory allocation profiling, therefore when it's not =
enabled
> > >> > this object is not needed. This also generates a warning when comp=
iling
> > >> > with CONFIG_MEM_ALLOC_PROFILING=3Dn. Move the code under this conf=
iguration
> > >> > to fix the warning. If more slabobj_ext users appear in the future=
, the
> > >> > code will have to be changed back to call prepare_slab_obj_exts_ho=
ok().
> > >> >
> > >> > Fixes: 4b8736964640 ("mm/slab: add allocation accounting into slab=
 allocation and free paths")
> > >> > Reported-by: kernel test robot <lkp@intel.com>
> > >> > Closes: https://lore.kernel.org/oe-kbuild-all/202406150444.F6neSai=
y-lkp@intel.com/
> > >> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > >>
> > >> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> > >>
> > >> But it seems to me we could remove the whole #ifdef if current->allo=
c_tag
> > >> (which doesn't exist with !MEM_ALLOC_PROFILING) had an access helper=
, or
> > >> there was a alloc_tag_add_current() variant?
> > >
> > > Hmm. I'll check if current->alloc_tag is the only reason for this
> > > ifdef. If so then you are correct and we can simplify this code.
> >
> > The fix is now in mm-hotfixes-stable but we can cleanup for the future =
as a
> > non-hotfix.
>
> Yes, it's on my TODO list now. Thanks!

obj_exts->ref was also undefined when !MEM_ALLOC_PROFILING, so I moved
that call into a separate hook. It's posted at
https://lore.kernel.org/all/20240703015354.3370503-1-surenb@google.com/
Thanks,
Suren.

>
> >

