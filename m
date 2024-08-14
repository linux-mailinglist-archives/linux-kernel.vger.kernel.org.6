Return-Path: <linux-kernel+bounces-286319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 308DD951995
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 13:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0604E2845C0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 11:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04851AE84A;
	Wed, 14 Aug 2024 11:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PMQQ4pFP"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4781AE04A
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 11:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723633594; cv=none; b=VeM7h2YEL8ClpzLm1dji1HpYySAObsypJ7FwB446ZAR0p9s1qAZ9YwJyItNX+MmcyW9tLBvXdG4gcQsIZSeZOck2yD7d0XWOygQJwJq72DTYSLWR9tgCGNgyHYUxaqsNfbKa8MU4tDyVd+WgnUqHA62zXgAROCagk3mSqReh7PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723633594; c=relaxed/simple;
	bh=Qv97l7e5b0LvgnkvHUMfmxlR5ZaDvutE8U+fW/r807Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dMjU57F8qkHfndnBl6eU9dfNIzVGdH6xPE/IYXuTr/aNvizdYP1nW89X6onu1GMLHUQHNfBLiAWhxR/FagA590icAcZLDXpdmxAG6r20dCtaylYtrwRWIDwg4rFj5zfMOZQHnt3U0eaF7hoA9pMtlPEOFaB6bnGHzQjHv3x2gPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PMQQ4pFP; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5ba482282d3so8066086a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 04:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723633589; x=1724238389; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=37k6zoJGI4ySfWeQa+WNWY1gPNVBQcPCdoUsogardSg=;
        b=PMQQ4pFPYsXlGfV0HK6eUEtUSnOFgpTF1bil5RPQS2DnKoqZHpvwLd+R5mtE6ZBc2T
         hc3TDD77DwB8Mi3fGA8lDSWt8z7etSQCfn/WOxaBcl7HBUUuA/uBmGLkmLWZ/EHFMlsK
         pFkM/O0EPmiTpEsAmcCb4X8jJyqF9scp+kmkVc/irzWjPOmNDKpSE+yhQB5Vt2C4rmCh
         U9gGOo69ircVtzJb1P76Don/bc+7UcaXmbnVDqRhbdE9iCoQrznIvZRVB/dO7iMIA+gA
         g522aZWXs2jQ9ApzOte42mVf74ztkcMH9pfwzilGH271Jhr+f0C2lq4KKyv3YxGGB8P5
         H9GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723633589; x=1724238389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=37k6zoJGI4ySfWeQa+WNWY1gPNVBQcPCdoUsogardSg=;
        b=SuPvOqFLjuViHpSYCsO/yLq0PwLbgc37HGc6oWiCDVlWXx/jJQgppqeNk/xszAdlSb
         uL48bVSKnVdnAvbXG+HBZGeWNZrsOqGXkA5/RcZawOdX/fvQSxg4tKQvGpmcBBYeTCCw
         o7qsBrQj5bzTtcvNQiHm5S0k5E92VQTTHlhpGoLEkxS4yHS7H7+YDlXcmn/nGqKh78wf
         53/xv+Jh9thmc08DuKwVOPowxtwAQFgWf9Om6uwcZXNHIxCJk2ruyz9M+Ukhz++4Uu3t
         6m2Phd6bme8q5XFIjV8VJdvbueqFMxgpF956smGBD+SuPBfqBzup/X+xplQNIcIXgmdk
         24iA==
X-Forwarded-Encrypted: i=1; AJvYcCWmSeJOma9UehiC1gvv27kjYurbpu1RLwdWqYNEYIGB+AFOgzall+Bv7Pb0iLeXFbkMpTp3WJc6JKC3BbcqVdIKKHukV5Ij5Lyil3ko
X-Gm-Message-State: AOJu0Yw0S1x4aXToy0NzPuzHIuPzoyNm6cetMRYZq39x9WL4EWs9E6He
	amt7ZwNkKj7pfgXo2ql1IUP9nBzhn4jMbQm2TEMSYRY63M97tTzhxiSojZV31LOkKG7NphW/J0P
	SaR+l9s1Ax8DWDyn/pT66ld3XCEs=
X-Google-Smtp-Source: AGHT+IFxno9/G65dhVjx9wlF+xu4tEDdgzUpJUbvbTdDjN+mgCawXy6DPLVolNNzGcxoDLTcEYyfGJZYqxfZiWA7z2c=
X-Received: by 2002:a17:907:c8a0:b0:a7a:b73f:7582 with SMTP id
 a640c23a62f3a-a8366c120e5mr172158566b.2.1723633589129; Wed, 14 Aug 2024
 04:06:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202407301049.5051dc19-oliver.sang@intel.com> <193e302c-4401-4756-a552-9f1e07ecedcf@redhat.com>
 <439265d8-e71e-41db-8a46-55366fdd334e@intel.com> <90477952-fde2-41d7-8ff4-2102c45e341d@redhat.com>
 <6uxnuf2gysgabyai2r77xrqegb7t7cc2dlzjz6upwsgwrnfk3x@cjj6on3wqm4x>
 <5a67c103-1d9d-440d-8bed-bbfa7d3ecf71@redhat.com> <CAGudoHH4NGgPdTe2yL33TNNFriPM9mVM=0_iuh5dLuesZXQMAQ@mail.gmail.com>
 <5c0979a2-9a56-4284-82d2-42da62bda4a5@redhat.com> <c7e0d029-0a64-4b27-bd62-cf9a3577d7ff@intel.com>
 <wbbieqyyjqy7ulbta6muzepxwxi6galwvhjdxpqaqbeljzpcer@dpeoqrbkl5p2>
 <817150f2-abf7-430f-9973-540bd6cdd26f@intel.com> <CAGudoHG1=p0GEVaSASA1C+iVYbfA5rryozAPPEoxr5uKtM=ghw@mail.gmail.com>
 <f4ddda8d-3513-4471-8609-acb3ce29219e@intel.com> <CAGudoHECfSYd7EcxiY+soh157m9H4xfU1en=TgX_=QkpbsOFdg@mail.gmail.com>
 <116e117c-2821-401d-8e62-b85cdec37f4a@redhat.com>
In-Reply-To: <116e117c-2821-401d-8e62-b85cdec37f4a@redhat.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 14 Aug 2024 13:06:16 +0200
Message-ID: <CAGudoHGzNu4MUDyd1OeP+R=TdOzO6Nidk26_hrinBncz6FpGvw@mail.gmail.com>
Subject: Re: [linus:master] [mm] c0bff412e6: stress-ng.clone.ops_per_sec -2.9% regression
To: David Hildenbrand <david@redhat.com>
Cc: Yin Fengwei <fengwei.yin@intel.com>, kernel test robot <oliver.sang@intel.com>, 
	Peter Xu <peterx@redhat.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Huacai Chen <chenhuacai@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, 
	Matthew Wilcox <willy@infradead.org>, Nathan Chancellor <nathan@kernel.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, WANG Xuerui <kernel@xen0n.name>, linux-mm@kvack.org, 
	ying.huang@intel.com, feng.tang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 11:45=E2=80=AFAM David Hildenbrand <david@redhat.co=
m> wrote:
>
> On 14.08.24 06:10, Mateusz Guzik wrote:
> > On Wed, Aug 14, 2024 at 5:02=E2=80=AFAM Yin Fengwei <fengwei.yin@intel.=
com> wrote:
> >>
> >> On 8/13/24 03:14, Mateusz Guzik wrote:
> >>> would you mind benchmarking the change which merely force-inlines _co=
mpund_page?
> >>>
> >>> https://lore.kernel.org/linux-mm/66c4fcc5-47f6-438c-a73a-3af6e19c3200=
@redhat.com/
> >> This change can resolve the regression also:
> >
> > Great, thanks.
> >
> > David, I guess this means it would be fine to inline the entire thing
> > at least from this bench standpoint. Given that this is your idea I
> > guess you should do the needful(tm)? :)
>
> Testing
>
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 5769fe6e4950..25e25b34f4a0 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -235,7 +235,7 @@ static __always_inline int page_is_fake_head(const st=
ruct page *page)
>          return page_fixed_fake_head(page) !=3D page;
>   }
>
> -static inline unsigned long _compound_head(const struct page *page)
> +static __always_inline unsigned long _compound_head(const struct page *p=
age)
>   {
>          unsigned long head =3D READ_ONCE(page->compound_head);
>
>
> With a kernel-config based on something derived from Fedora
> config-6.8.9-100.fc38.x86_64 for convenience with
>
> CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=3Dy
>
> add/remove: 15/14 grow/shrink: 79/87 up/down: 12836/-13917 (-1081)
[snip]
> Total: Before=3D32786363, After=3D32785282, chg -0.00%

I guess there should be no opposition then?

Given that this is your patch I presume you are going to see this through.

I don't want any mention or cc on the patch, thanks for understanding :)

--=20
Mateusz Guzik <mjguzik gmail.com>

