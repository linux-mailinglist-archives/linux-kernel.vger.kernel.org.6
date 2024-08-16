Return-Path: <linux-kernel+bounces-289421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4429895460D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 038542830FF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 09:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18EF616C6A6;
	Fri, 16 Aug 2024 09:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVp+SRLZ"
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD9078C9C
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 09:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723801642; cv=none; b=gO+NNcnJLkFyx+ZRo1E2CK83Be5yG5d0pDxz8aCwYzWnKyWZN/nRhtyJUfyn1hBFN6WjNdcW88n1Lg/SZWkNgFSclJ0eHd0i5lzq2wxDYTMzQ/fTx5GFc4gHHw9/P+h2PVyw66k+kPlpM36sbQJ9mQDo42oleUvGVEq2hYHFDVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723801642; c=relaxed/simple;
	bh=ZXtz/uxS+ZLezxFtVzS54kEvHOdxu3StTH7Lr2A0sjI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LiML20XYrHRtCkxLHKMltGSBS8DmP5Zgk4z9xCD8JCJUliGMTWuzkJrTf3whOYgvWVfoOax7elrf4KopkXRZ2MYi7Q3golt4m+VmS/W6sDuCkhfbt246nOr1E6NjmEp/wkkeAyHAV1jHhGwPqTkSjcAXJEOjY0CgziSagYPmOzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NVp+SRLZ; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-4f6b8b7d85bso627473e0c.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 02:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723801639; x=1724406439; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=juhozGP38pQUisELDGJeljBYJ302hnOpTsrGh2pGnFU=;
        b=NVp+SRLZYbvWvaEfltb3+7+ljolMZ9DyqtjA+BqwXFcEXOlep1PcHlG2Aq0HQ1rf2W
         RAG9TTGgU3e8+mFmSljEVKGqSTS0SFZYak4NCktBgGMKQUkM8pthxICe57FJcqjxIKpQ
         7jYUfgY5cuuaLPjgnrLVFbYTW06cidkFnOnpS7kPWBt5OEgCGiHLRplZ9xr8ML7whzxK
         5rssBCYeZheVhdOWRwKGo6M99JBNomRrHV/l2LPS6kDJ8NYNi4ScmD5oUgv2jksdOCVg
         HqfqB8cQxyAwoxF/lR+ObrEMsWEIk74igVsk8zeMZKHwrTy38JuLRva+5kXHFVdMF5l1
         HsHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723801639; x=1724406439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=juhozGP38pQUisELDGJeljBYJ302hnOpTsrGh2pGnFU=;
        b=K3nEvj0CIU+EFgzOngfFwbuEhxOJ+kKD4/xGxnEn1P7Ie8HPLr3GW1kNBXXST0DaYT
         zc3fRjIVd+4kTpAc+rmU47tt8A50cDutCoQdxh4I+KI+Hoc798KN6iWlXzayRG7k7QP1
         9xw6hSxrp/IsKQIX5DJOjQKptMHOxju8GsUyiVdERxfryQutIGuCJBE9ubP06lF7sGrI
         nN+WB7KY2iA8Fs/DL8Y8SFX9iRm8MVQ9uvOeNXYlv7VgORlafrgVnn51OSnTL/FdgN6j
         hSRZpo1W3iV6gwfKq2OMEwuUhJ7qZwxqE7sZutVXQXh4lOLIehZFnuzGNrT1u+BsS+Af
         h2qg==
X-Forwarded-Encrypted: i=1; AJvYcCVRlovrG+S0UpGhEOcbvqLuFwIC/B/26xrn9PhnSu7t6PWM012SUx8GCE7mHfpop+b6bFxBNELdx2SBMB/ri2UtwitZGGUWfcnxCE8b
X-Gm-Message-State: AOJu0Yz3xQb7A9Nd6dI+I525vRkLpTNPWNtyuNHwtzyM/1fMBlfRImc4
	/1yLi+vxOv5bBEch6wtErWy4BCTlGsbZDtuw+W7PPLJAeBuX+PBO16Pk6yt91UQ0iIj9ncYY5nP
	q7FecPJYcgOM+OJ8tiSuVMomvpyY=
X-Google-Smtp-Source: AGHT+IFusvZlG+6uxNbC781BcbgG4URcYQBQQubc0DVfKShhPEmzVUwcnzvWiiwll63ZAFQD4RIzAxDvo3J/61pAK0A=
X-Received: by 2002:a05:6122:29c9:b0:4f5:2b7f:f1a7 with SMTP id
 71dfb90a1353d-4fc6cc4428emr2758053e0c.13.1723801639436; Fri, 16 Aug 2024
 02:47:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6e23c705-3d67-419b-b085-f19f5101124c@redhat.com>
 <20240815235001.96624-1-21cnbao@gmail.com> <d4f302e6-033a-4a6a-9c42-077331b32bd1@redhat.com>
In-Reply-To: <d4f302e6-033a-4a6a-9c42-077331b32bd1@redhat.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 16 Aug 2024 21:47:04 +1200
Message-ID: <CAGsJ_4yi-mhK4P8tuuVfanQmDa3Rg+_FdNfNrKpT9J8y+EAAiw@mail.gmail.com>
Subject: Re: [PATCH v4] mm: Override mTHP "enabled" defaults at kernel cmdline
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, baolin.wang@linux.alibaba.com, corbet@lwn.net, 
	ioworker0@gmail.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	ryan.roberts@arm.com, v-songbaohua@oppo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 9:33=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 16.08.24 01:50, Barry Song wrote:
> > On Thu, Aug 15, 2024 at 10:26=E2=80=AFPM David Hildenbrand <david@redha=
t.com> wrote:
> >>
> >>>>> +static inline int get_order_from_str(const char *size_str)
> >>>>> +{
> >>>>> +     unsigned long size;
> >>>>> +     char *endptr;
> >>>>> +     int order;
> >>>>> +
> >>>>> +     size =3D memparse(size_str, &endptr);
> >>>>
> >>>> Do we have to also test if is_power_of_2(), and refuse if not? For
> >>>> example, what if someone would pass 3K, would the existing check cat=
ch it?
> >>>
> >>> no, the existing check can't catch it.
> >>>
> >>> I passed thp_anon=3D15K-64K:always, then I got 16K enabled:
> >>>
> >>> / # cat /sys/kernel/mm/transparent_hugepage/hugepages-16kB/enabled
> >>> [always] inherit madvise never
> >>>
> >>
> >> Okay, so we should document then that start/end of the range must be
> >> valid THP sizes.
> >
> > Ack
> >
> >>
> >>> I can actually check that by:
> >>>
> >>> static inline int get_order_from_str(const char *size_str)
> >>> {
> >>>        unsigned long size;
> >>>        char *endptr;
> >>>        int order;
> >>>
> >>>        size =3D memparse(size_str, &endptr);
> >>>
> >>>        if (!is_power_of_2(size >> PAGE_SHIFT))
> >>
> >> No need for the shift.
> >>
> >> if (!is_power_of_2(size))
> >>
> >> Is likely even more correct if someone would manage to pass something
> >> stupid like
> >>
> >> 16385 (16K + 1)
> >
> > Ack
> >
> >>
> >>>                goto err;
> >>>        order =3D get_order(size);
> >>>        if ((1 << order) & ~THP_ORDERS_ALL_ANON)
> >>>                goto err;
> >>>
> >>>        return order;
> >>> err:
> >>>        pr_err("invalid size %s in thp_anon boot parameter\n", size_st=
r);
> >>>        return -EINVAL;
> >>> }
> >>>
> >>>>
> >>>>> +     order =3D fls(size >> PAGE_SHIFT) - 1;
> >>>>
> >>>> Is this a fancy way of writing
> >>>>
> >>>> order =3D log2(size >> PAGE_SHIFT);
> >>>>
> >>>> ? :)
> >>>
> >>> I think ilog2 is implemented by fls ?
> >>
> >> Yes, so we should have used that instead. But get_order()
> >> is even better.
> >>
> >>>
> >>>>
> >>>> Anyhow, if get_order() wraps that, all good.
> >>>
> >>> I guess it doesn't check power of 2?
> >>>
> >>>>
> >>>>> +     if ((1 << order) & ~THP_ORDERS_ALL_ANON) {
> >>>>> +             pr_err("invalid size %s(order %d) in thp_anon boot pa=
rameter\n",
> >>>>> +                     size_str, order);
> >>>>> +             return -EINVAL;
> >>>>> +     }
> >>>>> +
> >>>>> +     return order;
> >>>>> +}
> >>>>
> >>>> Apart from that, nothing jumped at me.
> >>>
> >>> Please take a look at the new get_order_from_str() before I
> >>> send v5 :-)
> >>
> >> Besides the shift for is_power_of_2(), LGTM, thanks!
> >
> > Thanks, David!
> >
> > Hi Andrew,
> >
> > Apologies for sending another squash request. If you'd
> > prefer me to send a new v5 that includes all the changes,
> > please let me know.
> >
> >
> > Don't shift the size, as it can still detect invalid sizes
> > like 16K+1. Also, document that the size must be a valid THP
> > size.
> >
> > diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation=
/admin-guide/mm/transhuge.rst
> > index 15404f06eefd..4468851b6ecb 100644
> > --- a/Documentation/admin-guide/mm/transhuge.rst
> > +++ b/Documentation/admin-guide/mm/transhuge.rst
> > @@ -294,8 +294,9 @@ kernel command line.
> >
> >   Alternatively, each supported anonymous THP size can be controlled by
> >   passing ``thp_anon=3D<size>,<size>[KMG]:<state>;<size>-<size>[KMG]:<s=
tate>``,
> > -where ``<size>`` is the THP size and ``<state>`` is one of ``always``,
> > -``madvise``, ``never`` or ``inherit``.
> > +where ``<size>`` is the THP size (must be a power of 2 of PAGE_SIZE an=
d
> > +supported anonymous THP)  and ``<state>`` is one of ``always``, ``madv=
ise``,
> > +``never`` or ``inherit``.
> >
> >   For example, the following will set 16K, 32K, 64K THP to ``always``,
> >   set 128K, 512K to ``inherit``, set 256K to ``madvise`` and 1M, 2M
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index d6dade8ac5f6..903b47f2b2db 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -953,7 +953,7 @@ static inline int get_order_from_str(const char *si=
ze_str)
> >
> >       size =3D memparse(size_str, &endptr);
> >
> > -     if (!is_power_of_2(size >> PAGE_SHIFT))
> > +     if (!is_power_of_2(size))
> >               goto err;
>
>
> Reading your documentation above, do we also want to test "if (size <
> PAGE_SIZE)", or is that implicitly covered? (likely not I assume?)

as we also check the order is valid. so size <PAGE_SIZE will get invalid
order.

static inline int get_order_from_str(const char *size_str)
{
        unsigned long size;
        char *endptr;
        int order;

        size =3D memparse(size_str, &endptr);

        if (!is_power_of_2(size >> PAGE_SHIFT))
                goto err;
        order =3D get_order(size);
        if ((1 << order) & ~THP_ORDERS_ALL_ANON)
                goto err;

        return order;
err:

        pr_err("invalid size %s in thp_anon boot parameter\n", size_str);
        return -EINVAL;
}

>
> I assume it's implicitly covered: if we pass "1k" , it would be mapped
> to "4k" (order-0) and that is not a valid mTHP size, right?
>
> I would appreciate a quick v5, just so can see the final result more
> easily :)

sure.

>
> --
> Cheers,
>
> David / dhildenb
>

