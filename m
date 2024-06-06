Return-Path: <linux-kernel+bounces-203501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 334B68FDC2C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 03:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91EE41F24CF3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 01:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3871119A;
	Thu,  6 Jun 2024 01:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0WcE+K4"
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65A410F7
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 01:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717637671; cv=none; b=XmFzgzOpEHfDltwV7wMuSsgkexGsSaVPud0ET1PCwuNsF/OW89LnS9Yo94RNHL0SkCHm3M7QJos0yafZvNHZxK6Q03TX3vZiZB4d/IXYbCJdVmwCCgi5qweabnCg8NFIaHGpQ7QFbr5KVsZDqKoBOpe5CTiTvhGAY6/TXpI5iD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717637671; c=relaxed/simple;
	bh=YUHzooVVNX8IzjheUSL76YM6S3DIu6xXVkg7MCW5LAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qjUGaq1I35C2wgzy7+2bpYjg+wpjtYS9ms1UGWl5/oVvAk3Gg7FJGAYxu7uQrrOBX1/CIkfAGPom3e83PMu0rxUd7ICwQ/t6ssinwkJEqG8ylkDbZyDfT/zGVkqTVNThNM9vFe75vCJI2tWl7ONQl/pgdIzfKq/a33jsV6TAklo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P0WcE+K4; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-48baea0acfdso171485137.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 18:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717637669; x=1718242469; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=06T7JD9TzLagw1HoaEfo4EvOvyoWt/K/eu8qOPbaOiI=;
        b=P0WcE+K4v7Y6r6Fc9tosFa2ne4nveLa1nYIJTBq6nUVd8eGXm/dBIjr3olT95pOntF
         SH87ye55CA/LcaAA3J6lg+opUC4mqvxFhxT0EaY4fowYukpCH8ICIzOiADZRdKSO8mQ1
         x5PjHzJcejVO5hKwXoMEOaiZVz2jAOUYlZntFIiGS1IArGbn86EURORwzPjvDmFexqpq
         LPu91bVbbLZY3nEt+Zg0KSogqpXMpUW4f8GFus3Yp45uI7g1ImbV8pwWAlYpiIYfF/bg
         +OwQA3I3Wi/gBkXnd7VrK7Pb7gPPCtE4dmmOR5KYHzw/kSGFTQn+UdjqrT5wXCtmkiz0
         CEew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717637669; x=1718242469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=06T7JD9TzLagw1HoaEfo4EvOvyoWt/K/eu8qOPbaOiI=;
        b=B6C/i1fpI3n7lx5Dw5IpST/4578R7Qx3Hf4iNg+fJTzmj3eQYAhLBm5cEfX81wSl2t
         FHGlKJKAjamPlRfeCKsBl9JDsrAeP0jndGja+AtJRziJG7OuVR9sgLfTVDt5T8LHtmWG
         37ch2f+Cl3EiUcHj0Yau0U/G9lqfj95aRVqaB2zcKV2az9IVBbZ6QVxrieAZDQfJ5FXV
         o+rznq+70Vj03dAvpBP7g1LZuGD5fhI+PeLx/YxmCNW3gI5aXXqRdgZkNBA9hVRMjjeg
         sj6xwW0zxXzm/p3dl9m10OAPB01xfEgiYbLRn9+Ku0NjU9JJEUHZ3NkI84cJF/WPzUr1
         J+wQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+xzvs6l67Td3GboLueJYWXoQEgQ2tAkkrd/luz8UfrJdHd+FASiF+H2Hwk0QiZ0dPVY1sarax0h26cUBq/kTROtxXtlBVow+C5YIk
X-Gm-Message-State: AOJu0YxWnne81T80GdLa8wrnm5PXetWk+sT2opeNbjCSEHGjAgK41qP3
	sjNtPzOUViVwggalC0Knuh9OaVjeSynSwUh+d9KxOut9V/mMPBC1WUS1D/fsBKoQuWGS65gEssc
	2y6xaolD8m9SWCsw9P0qwy/pKbSg=
X-Google-Smtp-Source: AGHT+IFvvwHmoVJKz690HPDRcgdEvbUevNN1TCtSrXCMBvkBg5/9zEakDVu+eMDfsczVMmmtvf9T00c21CIp/iQlT+0=
X-Received: by 2002:a05:6102:22d2:b0:47a:2386:268d with SMTP id
 ada2fe7eead31-48c048482d3mr4365244137.12.1717637668515; Wed, 05 Jun 2024
 18:34:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGsJ_4wFyFBTDDfsBpi0sKs1WOH2jaKKoYWWj9Ln_PsNjP2uuA@mail.gmail.com>
 <20240605095406.891512-1-ranxiaokai627@163.com> <D667F08C-0CCE-4D5E-89A3-56674B0893DE@nvidia.com>
 <c110eb46-3c9d-40c3-ab16-5bd9f75b6501@redhat.com>
In-Reply-To: <c110eb46-3c9d-40c3-ab16-5bd9f75b6501@redhat.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 6 Jun 2024 13:34:17 +1200
Message-ID: <CAGsJ_4yBqBTLKBNME1vUTqz6XMdngVSp3V5RP7HqiQkLU-NWtA@mail.gmail.com>
Subject: Re: [PATCH linux-next] mm: huge_memory: fix misused
 mapping_large_folio_support() for anon folios
To: David Hildenbrand <david@redhat.com>
Cc: Zi Yan <ziy@nvidia.com>, ran xiaokai <ranxiaokai627@163.com>, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org, 
	v-songbaohua@oppo.com, xu.xin16@zte.com.cn, yang.yang29@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 2:42=E2=80=AFAM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 05.06.24 16:08, Zi Yan wrote:
> > On 5 Jun 2024, at 2:54, ran xiaokai wrote:
> >
> >>> On Tue, Jun 4, 2024 at 5:47?PM <xu.xin16@zte.com.cn> wrote:
> >>>>
> >>>> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> >>>>
> >>>> When I did a large folios split test, a WARNING
> >>>> "[ 5059.122759][  T166] Cannot split file folio to non-0 order"
> >>>> was triggered. But my test cases are only for anonmous folios.
> >>>> while mapping_large_folio_support() is only reasonable for page
> >>>> cache folios.
> >>>>
> >>>> In split_huge_page_to_list_to_order(), the folio passed to
> >>>> mapping_large_folio_support() maybe anonmous folio. The
> >>>> folio_test_anon() check is missing. So the split of the anonmous THP
> >>>> is failed. This is also the same for shmem_mapping(). We'd better ad=
d
> >>>> a check for both. But the shmem_mapping() in __split_huge_page() is
> >>>> not involved, as for anonmous folios, the end parameter is set to -1=
, so
> >>>> (head[i].index >=3D end) is always false. shmem_mapping() is not cal=
led.
> >>>>
> >>>> Using /sys/kernel/debug/split_huge_pages to verify this, with this
> >>>> patch, large anon THP is successfully split and the warning is cease=
d.
> >>>>
> >>>> Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> >>>> Cc: xu xin <xu.xin16@zte.com.cn>
> >>>> Cc: Yang Yang <yang.yang29@zte.com.cn>
> >>>> ---
> >>>>   mm/huge_memory.c | 38 ++++++++++++++++++++------------------
> >>>>   1 file changed, 20 insertions(+), 18 deletions(-)
> >>>>
> >>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> >>>> index 317de2afd371..4c9c7e5ea20c 100644
> >>>> --- a/mm/huge_memory.c
> >>>> +++ b/mm/huge_memory.c
> >>>> @@ -3009,31 +3009,33 @@ int split_huge_page_to_list_to_order(struct =
page *page, struct list_head *list,
> >>>>          if (new_order >=3D folio_order(folio))
> >>>>                  return -EINVAL;
> >>>>
> >>>> -       /* Cannot split anonymous THP to order-1 */
> >>>> -       if (new_order =3D=3D 1 && folio_test_anon(folio)) {
> >>>> -               VM_WARN_ONCE(1, "Cannot split to order-1 folio");
> >>>> -               return -EINVAL;
> >>>> -       }
> >>>> -
> >>>>          if (new_order) {
> >>>>                  /* Only swapping a whole PMD-mapped folio is suppor=
ted */
> >>>>                  if (folio_test_swapcache(folio))
> >>>>                          return -EINVAL;
> >>>> -               /* Split shmem folio to non-zero order not supported=
 */
> >>>> -               if (shmem_mapping(folio->mapping)) {
> >>>> -                       VM_WARN_ONCE(1,
> >>>> -                               "Cannot split shmem folio to non-0 o=
rder");
> >>>> -                       return -EINVAL;
> >>>> -               }
> >>>> -               /* No split if the file system does not support larg=
e folio */
> >>>> -               if (!mapping_large_folio_support(folio->mapping)) {
> >>>> -                       VM_WARN_ONCE(1,
> >>>> -                               "Cannot split file folio to non-0 or=
der");
> >>>> -                       return -EINVAL;
> >>>> +
> >>>> +               if (folio_test_anon(folio)) {
> >>>> +                       /* Cannot split anonymous THP to order-1 */
> >>>> +                       if (new_order =3D=3D 1) {
> >>>> +                               VM_WARN_ONCE(1, "Cannot split to ord=
er-1 folio");
> >>>> +                               return -EINVAL;
> >>>> +                       }
> >>>> +               } else {
> >>>> +                       /* Split shmem folio to non-zero order not s=
upported */
> >>>> +                       if (shmem_mapping(folio->mapping)) {
> >>>> +                               VM_WARN_ONCE(1,
> >>>> +                                       "Cannot split shmem folio to=
 non-0 order");
> >>>> +                               return -EINVAL;
> >>>> +                       }
> >>>> +                       /* No split if the file system does not supp=
ort large folio */
> >>>> +                       if (!mapping_large_folio_support(folio->mapp=
ing)) {
> >>>> +                               VM_WARN_ONCE(1,
> >>>> +                                       "Cannot split file folio to =
non-0 order");
> >>>> +                               return -EINVAL;
> >>>> +                       }
> >>>
> >>> Am I missing something? if file system doesn't support large folio,
> >>> how could the large folio start to exist from the first place while i=
ts
> >>> mapping points to a file which doesn't support large folio?
> >>
> >> I think it is the CONFIG_READ_ONLY_THP_FOR_FS case.
> >> khugepaged will try to collapse read-only file-backed pages to 2M THP.
> >
> > Can you add this information to the commit log in your next version?
>
> Can we also add that as a comment to that function, like "Note that we
> might still
> have THPs in such mappings due to CONFIG_READ_ONLY_THP_FOR_FS. But in
> that case,
> the mapping does not actually support large folios properly.
> "Or sth. like that.

+1. Otherwise, the code appears quite confusing.
Would using "#ifdef" help to further clarify it?

#ifdef CONFIG_READ_ONLY_THP_FOR_FS
            if (!mapping_large_folio_support(folio->mapping)) {
                          ....
            }
#endif

>
> --
> Cheers,
>
> David / dhildenb
>

Thanks
Barry

