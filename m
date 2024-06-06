Return-Path: <linux-kernel+bounces-204850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65AB48FF436
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 20:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC5ED1F22BC1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 18:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EAC22110E;
	Thu,  6 Jun 2024 18:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3YW4o+gG"
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3C31991D3
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 18:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717697034; cv=none; b=pXW5/ENj4Gbl+1QGVKYkHkwgooJjMsDTqu8KTyFTkilcXsOtaDCJKzRRxpGAOdEt3OI12KbKtUfDwBE7zxch2iuNRqlQrWFq2PMjq7a2MHq1lYfZrtYw8OjQariwC11Ov/1y8f/crrWLen7WR46+cwWTTEbtkSNfxbymCSZdgFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717697034; c=relaxed/simple;
	bh=OLlDyOEx/tnhcZ/wuPqcq30hMBwlqIfw82OXKbyQd/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=elX0cmqTR/+9s8KsJq7N2VLGlxQDRTEpq7Knff77SJrEbC4J6izgP8l8QySBuno+NRy7cj44mHRasFsnhDm+78GehTpXoT9g4yy+op+LLt2x8xazIRhAliQItUP96TAR4SLlMR9hOQZXz3F+hGnz/64BE8H66Tr6YNQzJCF2g28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3YW4o+gG; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3d20c0fe970so476658b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 11:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717697032; x=1718301832; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fmY9ClhcMnk3lfJDa8OPw7iQg8oOX8VXIGEoCMmXzxs=;
        b=3YW4o+gGWsLNY+NPzz8Jf/S6lhyt8EyESbFr+sWfS6TfDQeCe+UR3fKgWamZcUsLFY
         OvHWNjtya4Qk5yFGpsUfEqOm3HrV3YZVozqsqb6SQq7MQ9SD3Y7F9d0jKCnZNAa5KDte
         ZnX+vPGCviT8WMZyox1tNsxgYaRii6al94f/Bd0w5u1r23O9NGfOdlAEnq18Yg5jkxm3
         IEw4FuLFLY44bjf14ZJDX1c37cdcqofZVQSri1NBBdKhpeiVPHK3qQ3ZjN4HgUJKwrBY
         DW/afYAxRvPDZNMAD31yx3mhOi+VxSEbZxd4utA2rAYg5oR1A41PosFt4f+2PARMXynL
         VLvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717697032; x=1718301832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fmY9ClhcMnk3lfJDa8OPw7iQg8oOX8VXIGEoCMmXzxs=;
        b=tx2oqqWbIomKq+dzrh/a4H3a1YFRzj4lC4HtJZwtC+Y436t5ZruGyr+p9qhdxS8WWS
         Pif4es9FMmrrL0c24Aj1SvHvsLvJl1WE0UeDaY3fQbFhWX8CbSdFPLHbd9LY71lcYa5b
         5//wWmXsGvOg1vdT9SKCqa3OI6QT8yu+WfAlzbadjYPPTSdDqU80uOCo5aLIpdI0lDjP
         D8mBAB+2+gdHyDvBwFofXjiKEkrG67I0H5qe+MO1+gFyZWCHzbFnDyetAg10VbZ7KhMP
         Guv9ynMgwAWY2eX4kWmS4VP1OTqvvR+wtIZWKAh7FwjUo5dt/mqYBuIesoCFlMNiisft
         phGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeND7EkIzbZzweiQPCeAT92jvq8Br1Avcu68rt9EMpCfkjci0/BrXlypc0KwrRPKSKEtdMLd1YIvrtuxlyXlWjLgIDdz3AxPIqSM/4
X-Gm-Message-State: AOJu0YyAYELqqXQkvBfhRI+pSBFK3IuOwFOooRvYZcAgmYr5kiQluktF
	2KptR7bh1Vhn4wLrPZW3CuCUiz0TNBTsBqAjiPzdXS+qAomusq8XX7xM9TVkMrLLjMvhBK3BJOY
	0KD3WIhYn3aSjW3I9BXPXHpCeIb6Bupv0uDgK
X-Google-Smtp-Source: AGHT+IGB4znCbBR8zUXjogqePqqiINLBxrZ4BZNRbTT6dQK52MxMOJB+MSnUdj/K2GhLRkzuaQLVnFWonw/plNYoJYA=
X-Received: by 2002:aca:130b:0:b0:3c7:50ac:c570 with SMTP id
 5614622812f47-3d210f072b9mr155114b6e.44.1717697031595; Thu, 06 Jun 2024
 11:03:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508202111.768b7a4d@yea> <20240515224524.1c8befbe@yea>
 <CAOUHufZ-9NmzOKjLedvZFp0=N0LvRZn77qC6k1WXK+NHtKr=0w@mail.gmail.com>
 <CAOUHufZ36rQc8AfLtRv2QrEareysdvbprAEO5XkcG-FeDOxFLA@mail.gmail.com>
 <20240602200332.3e531ff1@yea> <20240604001304.5420284f@yea>
 <CAJD7tkbCRLdy0vD2Pd17fNrxHgkzW1VucN4qMkohLFLBLaaeCQ@mail.gmail.com>
 <20240604134458.3ae4396a@yea> <CAJD7tkYjJJGthQ_8NukGw6Q9EYbLA=8sAH_7=B90KXEL6HWdSw@mail.gmail.com>
 <CAOUHufa0Fpj6SjNgB-z0n5Jg63q1ewkbOAU65forpDwQVs45qg@mail.gmail.com>
 <CAJD7tkb=5GJ9SNUwDsu1Zy3Tus4rjsNo60Hg9N7=gGth409Diw@mail.gmail.com>
 <CAOUHufb6zXr14Wm3T-4-OJh7iAq+vzDKwVYfHLhMMt96SpiZXg@mail.gmail.com>
 <CAJD7tkZ+QY55GTzW9A7ZCm=rxAEfrW76cWXf8o5nwiKSXp8z=w@mail.gmail.com>
 <20240604231019.18e2f373@yea> <CAJD7tkYq5u7B+0UH2XKpeWJnUxoO2kJ1_XZ2JOgYpyNEVR7u0g@mail.gmail.com>
 <20240606010431.2b33318c@yea> <CAJD7tkbhWYzx=6YmzAh0F+cK-_Bn8mPOH7gMbQS7YVXmaFSgFg@mail.gmail.com>
 <CAPpoddc2vOLdQJ7HwG7x+=oZsTz221+YJcNbUtKvPjA9AyeY2w@mail.gmail.com>
 <CAJD7tkb2b0+4_m0gb8DKSTtRwtC2GMa9NF5RuGKhXJARYHK0gw@mail.gmail.com> <CAOUHufZ_dKpts4uW4Xg3jVYnX5Z5MN9U9icxhP0Nmz7QnqurBQ@mail.gmail.com>
In-Reply-To: <CAOUHufZ_dKpts4uW4Xg3jVYnX5Z5MN9U9icxhP0Nmz7QnqurBQ@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 6 Jun 2024 11:03:13 -0700
Message-ID: <CAJD7tkbkDhDhDejVPWNxiCs-9WmFm_gvA2zX9ztF+tDgWLXpTg@mail.gmail.com>
Subject: Re: kswapd0: page allocation failure: order:0, mode:0x820(GFP_ATOMIC),
 nodemask=(null),cpuset=/,mems_allowed=0 (Kernel v6.5.9, 32bit ppc)
To: Yu Zhao <yuzhao@google.com>
Cc: Takero Funaki <flintglass@gmail.com>, Erhard Furtner <erhard_f@mailbox.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Minchan Kim <minchan@kernel.org>, "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 10:55=E2=80=AFAM Yu Zhao <yuzhao@google.com> wrote:
>
> On Thu, Jun 6, 2024 at 11:42=E2=80=AFAM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> > On Thu, Jun 6, 2024 at 10:14=E2=80=AFAM Takero Funaki <flintglass@gmail=
.com> wrote:
> > >
> > > 2024=E5=B9=B46=E6=9C=886=E6=97=A5(=E6=9C=A8) 8:42 Yosry Ahmed <yosrya=
hmed@google.com>:
> > >
> > > > I think there are multiple ways to go forward here:
> > > > (a) Make the number of zpools a config option, leave the default as
> > > > 32, but allow special use cases to set it to 1 or similar. This is
> > > > probably not preferable because it is not clear to users how to set
> > > > it, but the idea is that no one will have to set it except special =
use
> > > > cases such as Erhard's (who will want to set it to 1 in this case).
> > > >
> > > > (b) Make the number of zpools scale linearly with the number of CPU=
s.
> > > > Maybe something like nr_cpus/4 or nr_cpus/8. The problem with this
> > > > approach is that with a large number of CPUs, too many zpools will
> > > > start having diminishing returns. Fragmentation will keep increasin=
g,
> > > > while the scalability/concurrency gains will diminish.
> > > >
> > > > (c) Make the number of zpools scale logarithmically with the number=
 of
> > > > CPUs. Maybe something like 4log2(nr_cpus). This will keep the numbe=
r
> > > > of zpools from increasing too much and close to the status quo. The
> > > > problem is that at a small number of CPUs (e.g. 2), 4log2(nr_cpus)
> > > > will actually give a nr_zpools > nr_cpus. So we will need to come u=
p
> > > > with a more fancy magic equation (e.g. 4log2(nr_cpus/4)).
> > > >
> > >
> > > I just posted a patch to limit the number of zpools, with some
> > > theoretical background explained in the code comments. I believe that
> > > 2 * CPU linearly is sufficient to reduce contention, but the scale ca=
n
> > > be reduced further. All CPUs are trying to allocate/free zswap is
> > > unlikely to happen.
> > >  How many concurrent accesses were the original 32 zpools supposed to
> > > handle? I think it was for 16 cpu or more. or nr_cpus/4 would be
> > > enough?
> >
> > We use 32 zpools on machines with 100s of CPUs. Two zpools per CPU is
> > an overkill imo.
>
> Not to choose a camp; just a friendly note on why I strongly disagree
> with the N zpools per CPU approach:
> 1. It is fundamentally flawed to assume the system is linear;
> 2. Nonlinear systems usually have diminishing returns.
>
> For Google data centers, using nr_cpus as the scaling factor had long
> passed the acceptable ROI threshold. Per-CPU data, especially when
> compounded per memcg or even per process, is probably the number-one
> overhead in terms of DRAM efficiency.

100% agreed. If you look at option (b) above, I specifically called
out that scaling the number of zpools linearly with the number with
CPUs have diminishing returns :)

