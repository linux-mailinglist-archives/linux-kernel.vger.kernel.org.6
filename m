Return-Path: <linux-kernel+bounces-170938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E068BDE16
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 11:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 209A61C21BB5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 09:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F8514E2D6;
	Tue,  7 May 2024 09:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzDc1GHD"
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D651714D704
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 09:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715073886; cv=none; b=j2pCTAcL2+nYrCQeczSwxRERydBK6Gg3umWyDUio+cosmF7agl9vvZNqQ9X+1gA1mO1M23v+mKJ5otLTOBt/DUnYEMmwd3VY7NpioQ2LWsQKKg05JhQTt69tLntbLV8x3l4qoCJz07ZXMOPkUEFunImLKNHf2CTj3w0g5HpsfNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715073886; c=relaxed/simple;
	bh=vz/skXrhG9x2DCH4LT+Mllpp3Zo0NasQMYE/kCEwlTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nMIqdtjYCbSDUOEeK72C0Ja87at7fJhIDNEzjSS38Ctwma3/8u29INWJg2meVaVmiRBiq9Uga/dS3zb/b0JshlAI2yPXNXtKrmfd1yNw9lkveyXf/5Yj7ZcpUG5xJYhXzLtVX/CEXHWe0ZtWjCC1SGJFLYGcF5cABCsRBdIn/O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DzDc1GHD; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4df29c84f60so1542937e0c.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 02:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715073884; x=1715678684; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FUX/saWbO2sPYn3s2vChssRcjV2MRiGWaS+fdYSnFZ4=;
        b=DzDc1GHDBbjbuJ/Vdac7CCOGeQAn45yprR4zrlCy9MnuA624pk+kEn53DGG9nEGD6F
         EACypdgdC8E7Vzno7FBS2HR7OFB9xEyjDItTxdEI0bcr+CKw9Xovs3Zcb9eDIaYk3PEj
         YIGmTZK4SuvPFjRa6l4s425EUejpGSJGxyGsc6Ma6qCuVCP99EKZ5v4+21CZJbuzSBOA
         bWSyqzirKKpVSV1tO5719GoK+4Zt4PKNayauq/m1MhuHY2eqpPNhA3y3BCRbuZD0Mwx4
         2VPVvMzmUgy4QXBwPNFjGoKSCQoMHp7PEjY9/xF4EGOqhrGYXtMNlke8/hZd66nEUCoV
         WorQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715073884; x=1715678684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FUX/saWbO2sPYn3s2vChssRcjV2MRiGWaS+fdYSnFZ4=;
        b=FWZFYm5023Fszu7wiwW/hzbLvOtn9tO/Z9NnyRLQV06Rv7Y99i+UxsuhkgJKP6TqcC
         7xC0iLRKou2+osVglyyGSadb2fOz8q/7vdeO9gcRoC0PW8KR4yphEbCeZo74CjjyT9qp
         ZJY+lGFcYn52UmNVukIe325QnQZmc7VDoM0jvFppsSiz+IOt5zLAhJACEODNfVRgobZM
         +LNm3ES4F9/letqNgCgcPBbUw5CQYySWeWM6RBZxMSpwjgYaZbUxO6EOSm0hJ6BZ0WwM
         DU4F9OU1JqMiJx8SL+nzYYpWRUEUsd7ff1/xgoZg20qo83O0lyjE0T3Xsw6RGpI7tttI
         D19Q==
X-Forwarded-Encrypted: i=1; AJvYcCWNwD6HZdJB1etE6WSy15RILxzxpBnYiR71kcPRUtfzQveES6OA7X0zcxI4ireOVjrfvlrY+4ITHAY6CFzEueagK22lIBeve0CkWf1q
X-Gm-Message-State: AOJu0Yxlwoz05TeG31RtYuJNSazkHtiiF60UHkgexdcXHdzS9DIDwx/5
	IUJc9g+AVvUa7H5k9w75mcn0flwxG+txOxg9+ULa+LS8I85BbhEK70XLaueaQB88vDOR/Q15N0/
	eJKFeA8m9GejcMEnKTNbvIBNmU0g=
X-Google-Smtp-Source: AGHT+IGl8rQOKWt46bnh6yFyPkhvxMFPAQhx4ZovtHKw8fXy4iuGV4Sm/O/FZpP5PW2RIIvyILPoCgj3gsGaYRTjBEU=
X-Received: by 2002:a05:6122:3c4f:b0:4da:e199:4411 with SMTP id
 71dfb90a1353d-4df58828726mr1759406e0c.7.1715073883632; Tue, 07 May 2024
 02:24:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503005023.174597-1-21cnbao@gmail.com> <20240503005023.174597-7-21cnbao@gmail.com>
 <0b4d4d4b-91d8-4fd5-af4e-aebe9ee08b89@arm.com> <CAGsJ_4wm6v+xgh4jQ+u2-EzOXCLsz6L6nRJi_=FfWuGDUjxRYg@mail.gmail.com>
 <ff5b371a-16f6-4d03-b80d-b56af0f488c3@redhat.com> <CAGsJ_4z93FwPZx7w2VuCEkHP_JCwkO0whKwymonRJ9bSiKMVyQ@mail.gmail.com>
 <CAGsJ_4xssg3CcjifePMmgk4aqLO+iAon0YdT9p=Uq-D8vFMxyQ@mail.gmail.com>
 <5b770715-7516-42a8-9ea0-3f61572d92af@redhat.com> <CAGsJ_4xP1jPjH-SH7BgnFHiT4m+2gB0tP7ie_cUFynVpD_zpxQ@mail.gmail.com>
 <7dc2084e-d8b1-42f7-b854-38981839f82e@redhat.com> <CAGsJ_4w4vDu4p-ALrTSKMZhGKDK6TpyDLrAyvY4vkPJEJ3N5Lw@mail.gmail.com>
 <099a2c9e-f85e-4fe7-99dd-81b61115935c@redhat.com>
In-Reply-To: <099a2c9e-f85e-4fe7-99dd-81b61115935c@redhat.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 7 May 2024 21:24:32 +1200
Message-ID: <CAGsJ_4wNTgkP7An7ofXkfyhRpF=J-OLWTW7e5hOFef5-CxZe4Q@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] mm: swap: entirely map large folios found in swapcache
To: David Hildenbrand <david@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	baolin.wang@linux.alibaba.com, chrisl@kernel.org, hanchuanhua@oppo.com, 
	hannes@cmpxchg.org, hughd@google.com, kasong@tencent.com, 
	linux-kernel@vger.kernel.org, surenb@google.com, v-songbaohua@oppo.com, 
	willy@infradead.org, xiang@kernel.org, ying.huang@intel.com, 
	yosryahmed@google.com, yuzhao@google.com, ziy@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 8:59=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> >> Let's assume a single subpage of a large folio is no longer mapped.
> >> Then, we'd have:
> >>
> >> nr_pages =3D=3D folio_nr_pages(folio) - 1.
> >>
> >> You could simply map+reuse most of the folio without COWing.
> >
> > yes. This is good but the pte which is no longer mapped could be
> > anyone within the nr_pages PTEs. so it could be quite tricky for
> > set_ptes.
>
> The swap batching logic should take care of that, otherwise it would be
> buggy.

When you mention "it would be buggy," are you also referring to the current
fallback approach? or only refer to the future patch which might be able
to map/reuse "nr_pages - 1" pages?

The current patch falls back to setting nr_pages =3D 1 without mapping or
reusing nr_pages - 1. I feel your concern doesn't refer to this fallback?

>
> >
> >>
> >> Once we support COW reuse of PTE-mapped THP we'd do the same. Here, it=
's
> >> just easy to detect that the folio is exclusive (folio_ref_count(folio=
)
> >> =3D=3D 1 before mapping anything).
> >>
> >> If you really want to mimic what do_wp_page() currently does, you shou=
ld
> >> have:
> >>
> >> exclusive || (folio_ref_count(folio) =3D=3D 1 && !folio_test_large(fol=
io))
> >
> > I actually dislike the part that do_wp_page() handles the reuse of a la=
rge
> > folio which is entirely mapped. For example, A forks B, B exit, we writ=
e
> > A's large folio, we get nr_pages CoW of small folios. Ideally, we can
> > reuse the whole folios for writing.
>
> Yes, see the link I shared to what I am working on. There isn't really a
> question if what we do right now needs to be improved and all these
> scenarios are pretty obvious clear.

Great! I plan to dedicate more time to reviewing your work.

>
> >
> >>
> >> Personally, I think we should keep it simple here and use:
> >>
> >> exclusive || folio_ref_count(folio) =3D=3D 1
> >
> > I feel this is still better than
> > exclusive || (folio_ref_count(folio) =3D=3D 1 && !folio_test_large(foli=
o))
> > as we reuse the whole large folio. the do_wp_page() behaviour
> > doesn't have this.
>
> Yes, but there is the comment "Same logic as in do_wp_page();". We
> already ran into issues having different COW reuse logic all over the
> place. For this case here, I don't care if we leave it as
>
> "exclusive || folio_ref_count(folio) =3D=3D 1"

I'm perfectly fine with using the code for this patchset and maybe
looking for other
opportunities for potential optimization as an incremental patchset,
for example,
reusing the remaining PTEs as suggested by you -  "simply map+reuse most of
the folio without COWing."

>
> But let's not try inventing new stuff here.

It seems you ignored and snipped my "16 + 14" pages and "15" pages
example though. but once we support "simply map+reuse most of the
folio without COWing", the "16+14" problem can be resolved, instead,
we consume 16 pages.

>
> --
> Cheers,
>
> David / dhildenb

Thanks
Barry

