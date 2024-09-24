Return-Path: <linux-kernel+bounces-337698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7708A984DCB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 00:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E976281387
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 22:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469F014C5AF;
	Tue, 24 Sep 2024 22:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jtMV4VoF"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4F51482F5
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 22:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727216952; cv=none; b=tFHZxekXrDgEJt761BmXDjyDAK4xvYAqeVn2iAtw/hgd6U5ongJ4Uz5TjnYufnOLK70kW7Lk+N5j5b6FsHo2zNd+VpUbP1WijK5UfhxcTjIIZ3LKtf76Ua+mVOvVHR3ZDqyKUJoHExym2pXJWHJYeBx/zH2Vfe/4j2qAsffAsLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727216952; c=relaxed/simple;
	bh=n39eMlOm+SyrgwEiQBgcVOHL+GxwOs4MvJmrNHifhyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M7Ldz6vrq8yJZDsJfc/p3KYfZ/jFe5dVIf4YIDRDS9BYaS5Y1g5QvC+iQJg8lkJ4dbu6NAzxgoJ2nyJGOqHJE4/KVM5RsfPxQHeDlyIoIzGWBmCuPYvGUDAS7GzCMCAaDt490wY6QODa4CjfwBy8+hI0WUvTF7D0WeJRpr7HNdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jtMV4VoF; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9018103214so852576566b.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 15:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727216949; x=1727821749; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n39eMlOm+SyrgwEiQBgcVOHL+GxwOs4MvJmrNHifhyo=;
        b=jtMV4VoF1OfIkRy+YR2IbrAmkeJ/Oy3w/VUfhqM32KCQR5LXQ6P1+UQood/aX2aRdq
         GzPsE31/4WllY0Zcs2KBaLEdmr50ItzSFX9pU+bPVyZAzCB7WQgwG1J9v/yl6OCYAFWW
         VOZFJ0qHTo/Stnpmv0pdqOsOdW85mlRUTm9Mik0es7HgRXkD57PUxGizl8lxs/s0eWGh
         1HiH2FfY6qAYW8tLL4gqseidAEwiWphw5XGEv0Kvrtfty6L0EC5wkFg20PobHdAhg3vd
         hcrX1bx3OgoTqE1/N0mJBvFH7Y2HUR3DlOSpOW+YvFZUvZxySPffav4ckpreztqZXqDe
         mXrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727216949; x=1727821749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n39eMlOm+SyrgwEiQBgcVOHL+GxwOs4MvJmrNHifhyo=;
        b=V2bDj8/RgrSTcOeFeskgv/z7oWBdtTAXlYmqmZTUMc4tfrng/Dbhcx00dvOxn/TbgJ
         y+WWO6YF7gWGG3wV2vlhFu7mIBPp5fXDUqkVZqESglBrJKoBMs1NjJ2M3qZb2ugQ1zCM
         Nj15VXLPCByS170ukrdLfSAIhfIAi9VOmZh43gqPtTDC4kPJJRg21ChV0w4hbFk1VOov
         j9+/G6tz6l2flInmH94qJotl7c0DoxK05vDmwjqqRW3U9HSem7kCRDZkxaF7WlO0l3uy
         NQ2XBS9U/D4LDuT4ziPR3/fXMmBuRC7nsQA9kSqw7DYDoUUUWYv2XAnagHIrsvn5UWv9
         fBSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGOfImkMwJdLjk773bdIDr5sfMxKWxCk6uZizG/G2pYbnhnMCEpQrdt0H3E3Yu6F8YKtrnCrpGqg8Tvso=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgYqF1opJDrecACm4I0NWp6q7Q/PyWDxHPh4IgsgaqqlEkbp4B
	gRgypkRr5VfT5bf37NGfe3sR4ZKu6hFm45S/YNuGggTvl16eyg9roWoccDBsSUV5E+Ul7cmm4aB
	W7bAZ7ZUi78pdVQTFC2NWjBdbPLZZPRMmulc3
X-Google-Smtp-Source: AGHT+IHZXtbf1m4/Vq1sqBrHk/G+Rz3IDVUgzWzPwCiWjokGu/B1SPj9zXhfB/fRMBaTX/BPBcYLLvgIwCxbb8dviQc=
X-Received: by 2002:a17:907:2d92:b0:a8d:6261:23ff with SMTP id
 a640c23a62f3a-a93a035da14mr58181166b.17.1727216948815; Tue, 24 Sep 2024
 15:29:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924011709.7037-1-kanchana.p.sridhar@intel.com>
 <20240924011709.7037-7-kanchana.p.sridhar@intel.com> <CAKEwX=Nw_ax0RRSaD9n3h1vqbu+5PEuur3RqXrMrYyvOPuzB3Q@mail.gmail.com>
 <SJ0PR11MB56785712C0EF98B7BE558720C9682@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAKEwX=MgpP_w6JFC5ahVN-erCWK2NDGSbxNdLxKg9P4yd01Unw@mail.gmail.com>
 <CAJD7tkasC4n+mE=q+L9cjf4342eSkOQPeeV1wzBKxTp39wnZJA@mail.gmail.com> <CAKEwX=PV4uwP7jyxYtThPGe8SFSchBXZGwxqvCr4YTWgYjtqYw@mail.gmail.com>
In-Reply-To: <CAKEwX=PV4uwP7jyxYtThPGe8SFSchBXZGwxqvCr4YTWgYjtqYw@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 24 Sep 2024 15:28:31 -0700
Message-ID: <CAJD7tkZSTTLap97s=izgWKAwMTxgs+koOOSR+6HPFuKdVoOFrg@mail.gmail.com>
Subject: Re: [PATCH v7 6/8] mm: zswap: Support mTHP swapout in zswap_store().
To: Nhat Pham <nphamcs@gmail.com>
Cc: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"hannes@cmpxchg.org" <hannes@cmpxchg.org>, "chengming.zhou@linux.dev" <chengming.zhou@linux.dev>, 
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>, "shakeel.butt@linux.dev" <shakeel.butt@linux.dev>, 
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>, "Huang, Ying" <ying.huang@intel.com>, 
	"21cnbao@gmail.com" <21cnbao@gmail.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, 
	"Zou, Nanhai" <nanhai.zou@intel.com>, "Feghali, Wajdi K" <wajdi.k.feghali@intel.com>, 
	"Gopal, Vinodh" <vinodh.gopal@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 3:16=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> On Tue, Sep 24, 2024 at 2:34=E2=80=AFPM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> >
> > Why can't we just handle it the same way as we handle zswap
> > disablement? If it is disabled, we invalidate any old entries for the
> > offsets and return false to swapout to disk.
>
> I think that was the suggestion.


Hmm I may be reading this wrong, but my understanding was that the
suggestion is to synchronously remove all entries of large folios from
zswap when zswap_mthp is disabled. What I am suggesting is to do the
same thing we do in zswap_store() when zswap is disabled.

Anyway, if we are removing the knob this is not relevant anymore.

