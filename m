Return-Path: <linux-kernel+bounces-282794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B765594E8B9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 10:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61916280DA2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 08:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F253B16B3B7;
	Mon, 12 Aug 2024 08:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BK2NvEon"
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E35B4D599
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 08:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723451808; cv=none; b=YOifyaWanY7YpsGmfawkaeNI+T2OGkWdvsGCtpvvGq2JL7T2xK3z6B9bpOyhy9wfC7zQuX6yGJzp7rdFXcd8RJbKrrkmhsZFG2gCvwghEEAOWInHQjVq0d/fiND77SlMXaHQF9WpSQ8GYWx3vLFUxqKy9uQIsKnoxI/MvFas9Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723451808; c=relaxed/simple;
	bh=4R8Svbxkp171kMzD5AlVoXzAKFtIEJPXTIqFc59Wikg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l7Dgx5DcCuXAO4lTz0LhQE9E0cPi0dnC8BMbveq8Rb6D4NFtaIrKjjnAbeH7W/27yQK70Ooe6n0kFTJs9f3SbKtOXiY3Gie74N7CWFgrDfvKnOSUwm2t5lGiztCysQMLuOip2JcAvZcz6ndfJiBsVrqWTMqmwQsSEgh/9VKbf2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BK2NvEon; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4f521a22d74so1183920e0c.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 01:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723451805; x=1724056605; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U1JsfLqQ9LSdOmAjyn3CJzHlFX+uzh/xVJFUjHoNFWo=;
        b=BK2NvEonSFcX3m/WvcCwvy/prAQlrVfMHe32D3Vqj+VmbDvhK0oZNmfpNBssHiwBWo
         li5aRg9bKw/8jxpupnnYqZ+rQVS9SvkTEdUIeywLQjXH1rbbm5ITMPHSazrnZiJW3Fl1
         +2iLCKKZK7IXp+H7/dgzXHJmODMHOWLpckWP+iRQ64h2UW8b0bSei25TT7Jc8XpYZLTw
         Nngs19wKPBG6pbrkpRNCc51RjsIhQHgVm02XgGtU8h8pGJHY5QJR5HhfEfX1ys4TXHTo
         QVkvcHG4MuaOHEJpiRV5xlrfnam9uGhw7VkgEz/8s7NYQqMv+InZI1PHmEIcvqLrtawH
         aimA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723451805; x=1724056605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U1JsfLqQ9LSdOmAjyn3CJzHlFX+uzh/xVJFUjHoNFWo=;
        b=Tr8DikTLav5zAKhJEkJwpyLyGvizN1mGMFJsvHuEVoNgkqFPPLVaqqxd0uFsBkEbHf
         mZkcMjJvjxzNGO0qqkDzosOgUuFKpxjDkhOYPARENo6iBCXLKFmcZgdducIyaf/URhpB
         oN2YoW39UuLyYw3J37kHMb4/hQ6qeAX1x5Q3WVOgQnIoyrVm+JhdqAAeVwztFPiHz4n/
         yjvm9ntGq5vhWnzNXG2bdTVbQLv42yoUDZLfyZPqCmQS4sOr9eTT8Jkn9Rn0eBC9wZEa
         FyyQWh/UNv+L7VhCv4nsSMRcnyaY+HMBUcdDKRtxZ6st6h1zBpvPG6yFO8wMkxnhN8Kw
         LNqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVOE2/1JyA/nYhP9t63pigrtl7IydY+CZVHoTqCULsIDZEvBcT/A8V1NnzXl1aLtUpmcamLBsGrbfmKbo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6yvi1HKzm2UDW0eDkFC5WSMT750VOOQr/rJ79/OLlQydSQrbV
	8wK195lV3q3onlNUzrenIN+euRR8Pk11aq5B0qrtqdoVPg5V6Tt+PeD7w4ba0Drb3YeR53rsRlM
	6/VAcyCyLkl4bd3uUAO8uR3ZPZhU=
X-Google-Smtp-Source: AGHT+IHLA3KARxvO1GQYnYoHemosKuZRdJlx7z2flT5ePQ81gacRwx5Nt8UVgknnY/+JPuXby8eBFTTaKdsb8cm4+rA=
X-Received: by 2002:a05:6122:318c:b0:4f6:b160:3806 with SMTP id
 71dfb90a1353d-4f9132eaf09mr10292319e0c.11.1723451805227; Mon, 12 Aug 2024
 01:36:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8258bf4c-ecec-4e06-ada0-da9fb99b1219@redhat.com>
 <20240812053636.97700-1-21cnbao@gmail.com> <08390990-b47a-4663-8eae-ee51aac55b45@redhat.com>
In-Reply-To: <08390990-b47a-4663-8eae-ee51aac55b45@redhat.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 12 Aug 2024 20:36:33 +1200
Message-ID: <CAGsJ_4ziAchNaqHXmXFLa56t5PxfayDwkrdfR9OzRc35t3PfAg@mail.gmail.com>
Subject: Re: [PATCH v2] mm: Override mTHP "enabled" defaults at kernel cmdline
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, baolin.wang@linux.alibaba.com, corbet@lwn.net, 
	ioworker0@gmail.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	ryan.roberts@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 8:20=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 12.08.24 07:36, Barry Song wrote:
> > On Sat, Aug 10, 2024 at 1:15=E2=80=AFAM David Hildenbrand <david@redhat=
.com> wrote:
> >>
> >>>>>>> -You can change the sysfs boot time defaults of Transparent Hugep=
age
> >>>>>>> -Support by passing the parameter ``transparent_hugepage=3Dalways=
`` or
> >>>>>>> -``transparent_hugepage=3Dmadvise`` or ``transparent_hugepage=3Dn=
ever``
> >>>>>>> -to the kernel command line.
> >>>>>>> +You can change the sysfs boot time default for the top-level "en=
abled"
> >>>>>>> +control by passing the parameter ``transparent_hugepage=3Dalways=
`` or
> >>>>>>> +``transparent_hugepage=3Dmadvise`` or ``transparent_hugepage=3Dn=
ever`` to the
> >>>>>>> +kernel command line.
> >>>>>>> +
> >>>>>>> +Alternatively, each supported anonymous THP size can be controll=
ed by
> >>>>>>> +passing ``thp_anon=3D<size>[KMG]:<state>``, where ``<size>`` is =
the THP size
> >>>>>>> +and ``<state>`` is one of ``always``, ``madvise``, ``never`` or
> >>>>>>> +``inherit``.
> >>>>>>> +
> >>>>>>> +For example, the following will set 64K THP to ``always``::
> >>>>>>> +
> >>>>>>> +     thp_anon=3D64K:always
> >>>>>>> +
> >>>>>>> +``thp_anon=3D`` may be specified multiple times to configure all=
 THP sizes as
> >>>>>>> +required. If ``thp_anon=3D`` is specified at least once, any ano=
n THP sizes
> >>>>>>> +not explicitly configured on the command line are implicitly set=
 to
> >>>>>>> +``never``.
> >>>>>>
> >>>>>> I suggest documenting that "thp_anon=3D" will not effect the value=
 of
> >>>>>> "transparent_hugepage=3D", or any configured default.
> >>>
> >>> Did you see the previous conversation with Barry about whether or not=
 to honour
> >>> configured defaults when any thp_anon=3D is provided [1]? Sounds like=
 you also
> >>> think we should honour the PMD "inherit" default if not explicitly pr=
ovided on
> >>> the command line? (see link for justification for the approach I'm cu=
rrently
> >>> taking).
> >>
> >> I primarily think that we should document it :)
> >>
> >> What if someone passes "transparent_hugepage=3Dalways" and "thp_anon=
=3D..."?
> >> I would assume that transparent_hugepage would only affect the global
> >> toggle then?
> >>
> >>>
> >>> [1]
> >>> https://lore.kernel.org/linux-mm/CAGsJ_4x8ruPspuk_FQVggJMWcXLbRuZFq44=
gg-Dt7Ewt3ExqTw@mail.gmail.com/
> >>>
> >>>>>>
> >>>>>> Wondering if a syntax like
> >>>>>>
> >>>>>> thp_anon=3D16K,32K,64K:always;1048K,2048K:madvise
> >>>
> >>> Are there examples of that syntax already or have you just made it up=
? I found
> >>> examples with the colon (:) but nothing this fancy. I guess that's no=
t a reason
> >>> not to do it though (other than the risk of screwing up the parser in=
 a subtle way).
> >>
> >> I made it up -- mostly ;) I think we are quite flexible on what we can
> >> do. As always, maybe we can keep it bit consistent with existing stuff=
.
> >>
> >> For hugetlb_cma we have things like
> >>          "<node>:nn[KMGTPE|[,<node>:nn[KMGTPE]]
> >>
> >> "memmap=3D" options are more ... advanced, including memory ranges. Th=
ere
> >> are a bunch more documented in kernel-parameters.txt that have more
> >> elaborate formats.
> >>
> >> Ranges would probably be the most valuable addition. So maybe we shoul=
d
> >> start with:
> >>
> >>          thp_anon=3D16K-64K:always,1048K-2048K:madvise
> >>
> >> So to enable all THPs it would simply be
> >>
> >>          thp_anon=3D16K-2M:always
> >>
> >> Interesting question what would happen if someone passes:
> >>
> >>          thp_anon=3D8K-2M:always
> >>
> >> Likely we simply would apply it to any size in the range, even if
> >> start/end is not a THP size.
> >>
> >> But we would want to complain to the user if someone only specifies a
> >> single one (or a range does not even select a single one) that does no=
t
> >> exist:
> >>
> >>          thp_anon=3D8K:always
> >
> > How about rejecting settings with any illegal size or policy?
> >
> > I found there are too many corner cases to say "yes" or "no". It seems
> > the code could be much cleaner if we simply reject illegal settings.
> > On the other hand, we should rely on smart users to provide correct
> > settings, shouldn=E2=80=99t we? While working one the code, I felt that
> > extracting partial correct settings from incorrect ones and supporting
> > them might be a bit of over-design.
>
> No strong opinion on failing configs. Ignoring non-existing sizes might
> lead to more portable cmdlines between kernel versions.

Well, I realized that the code I posted has actually applied the correct
parts because it modifies the global variable huge_anon_orders_xxx.
Unless I use temporary variables and then copy the results to
global ones, the code has been this issue to some extent.

maybe I should remove the below  "goto err", instead, ignore the
incorrect strings and go to the next strings to parse.

static int __init setup_thp_anon(char *str)
{
        ...

                        if (!strcmp(policy, "always")) {
                                set_bits(&huge_anon_orders_always, start, e=
nd);
                                clear_bits(&huge_anon_orders_inherit,
start, end);
                                clear_bits(&huge_anon_orders_madvise,
start, end);
                        } else if (!strcmp(policy, "madvise")) {
                                ...
                        } else if (!strcmp(policy, "inherit")) {
                                ...
                        } else if (!strcmp(policy, "never")) {
                                ...
                        } else {
                                /* goto err; */     ->   pr_err
                        }
                }
        }
        ...
err:
        pr_warn("thp_anon=3D%s: cannot parse(invalid size or policy),
ignored\n", str);
        return 0;
}

>
> >
> > I have tested the below code by
> >
> > "thp_anon=3D16K-64K:always;128K,512K:inherit;256K:madvise;1M-2M:never"
>
> There are some parameters that separate individual options by ";"
> already (config_acs). Most parameters use ",". No idea what's better
> here, and which separator to use for sizes instead when using "," for
> options. No strong opinion.

But we have used "," for the purpose "128K,512K:inherit". so here
we have to use ";" for  "16K-64K:always;128K,512K:inherit"

>
>
> --
> Cheers,
>
> David / dhildenb

Thanks
Barry

