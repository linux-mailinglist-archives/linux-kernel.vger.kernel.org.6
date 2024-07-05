Return-Path: <linux-kernel+bounces-242412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 008249287B4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 13:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F1161F217C1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 11:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F7C1494A8;
	Fri,  5 Jul 2024 11:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xjbh6szX"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1A21482F2
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 11:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720178369; cv=none; b=ciJDZhs9pdk2jUK++roIwYuxONGKbdYR/q+5ApLA0OvLirKokuIGdAuw/S3guCmTzJ5JBzGQhynucPo2LavoMbopGmWhH98NjRxQ4uWX4L+JjPwM8qQtBvmu9WUEnv6TxmMUYfbIM/SrJbcBuKGEhDyMAE9dU8s3J9jfXX5XuWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720178369; c=relaxed/simple;
	bh=sHk7T/cpGTeagAnGnHNdbkgqMl1ekUfrbhJPQkwsvVs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oBn+lEkVFUDOxB8ZJZPpL4tOg5t4n+0zC6b2G63QlElLMRmskvcIeTf6ys5dFk+6scQWQcbAQT/Is2jd31zP9pDFrmLzCgjjjH2ZJ/vgq2OrHaZ1uEJPB79tbTjdfuFuu4dNOkQL3iwGERZzZa0uJhzhRj7jwq0/v0sZ9FpsKHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xjbh6szX; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57cc30eaf0aso1010666a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 04:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720178366; x=1720783166; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5CZbNI7VdWEztIyeBdO2rOowUpdrgoXYkMXWl+mjWHU=;
        b=Xjbh6szXDnsky6DQTjaNyIO9ZK835J2MXfiTCYR5TsQzPqUN0d4YotS8S5uVn2WqTq
         C9oMXQgCWoDnPL5Bdst6B6iBRUslMfPiFiQK/3JuUTklDhcP6X5iGprIY10OUsYJdIig
         PcKvnOEmtV2/mZpeMIQl04Affr7Ow1sG5jw8nSAOMkhbhQDcvDvI33Rqps2GxGNV8oN5
         7wz/bapLZe+Vyu6K3Em3+Rdsmh71zQtiI+hj4D34S+ZP/moT2UYipZCOywnjK2lPwvLc
         dz4t5n45i4uqbdjMywbPUtdJIoB9afHRMa4kP+22ZaTRjOV8bfvBu1HWE1VGqC6PiMQ+
         xfuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720178366; x=1720783166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5CZbNI7VdWEztIyeBdO2rOowUpdrgoXYkMXWl+mjWHU=;
        b=FjJD4jzEfEfxeStiAwdO4yevV+iF8UOvhprg1RIzNxUGdZyCzXT4oXDdCVn8cvlWUv
         Y4+c4QW3gLGJvVf6LSVqR5WIB++pD/o10Im6zbeCdTcKyfXhjloon0CXpFFkIX0EdgTU
         lYJLn4xrCKyCUJgYAHhJZvPLpcQGUSLe4VR2Dfu87UyeizdSy2nmVTeArGnb1p3F3d9w
         ncuwYAxCl3zD01JF3SFh9Tj71BfqdeVVqiIPt/UzRPSG39p45QWbgWFxXUy4h1v3iNfM
         PYnCQWSe+1OeMzjTb/8ip1YOEIJcrB4mwvO/EL+g8HCdWnv+8yK/UarvXbj1GFf4p2Ru
         YQRw==
X-Forwarded-Encrypted: i=1; AJvYcCUlAZu+FiuSIY9BeuVSWvoyvlR517bpcEJ8brBmODuPitqGCTHtmCdIobln6xzcOkcovRwetnE5FTCHxu7rOYKhkadMB4cDo0rBd1mK
X-Gm-Message-State: AOJu0Yx53At7kEstwoUzFs/hZk38MW4hMvOkw9dmcZztvnEau1qiEwhH
	DziLj1TIjIdHjU5RpMax2uOvm3SKpAHFXLgIdf977fp6xoZFpbutxTEvbY6Ojmll2XWuO6DGVn/
	/d63YU1BYJpCMRpH+EAe+1iOranxny2pW4BCOwA==
X-Google-Smtp-Source: AGHT+IFuQBhaGGxL/7iPZB5mR3yB+SEInlItazwA2fUnSsOJoCQYdPSoBCpVWEN8lB9iEBUd6vWHIY/YD6fRusQ2vbE=
X-Received: by 2002:a05:6402:4408:b0:57c:671d:8455 with SMTP id
 4fb4d7f45d1cf-58e59f27147mr3947638a12.14.1720178366341; Fri, 05 Jul 2024
 04:19:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704012905.42971-1-ioworker0@gmail.com> <20240704012905.42971-2-ioworker0@gmail.com>
 <677fc803-0bb9-48dc-a1ff-3ca1fb0dea15@redhat.com> <CAGsJ_4xX1cqKHU0eEsT=k0YDYKPs2m82bCkggdJyA1iwG4vXrg@mail.gmail.com>
 <3aef2bc6-c889-4a9a-b35d-f10ca8a5796a@redhat.com> <CAK1f24=M0i_Wisf9NHGcyo4wJ90a5QYefm=+rck5XAXMg1QNJQ@mail.gmail.com>
 <c9c98cbf-711c-4755-ae99-fb13aeb51381@redhat.com>
In-Reply-To: <c9c98cbf-711c-4755-ae99-fb13aeb51381@redhat.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Fri, 5 Jul 2024 19:19:15 +0800
Message-ID: <CAK1f24=wK9Gpt71NtVCyM1RRQF0MDmhm4MViVj_gPx_+ywks7w@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] mm: add per-order mTHP split counters
To: David Hildenbrand <david@redhat.com>
Cc: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org, dj456119@gmail.com, 
	ryan.roberts@arm.com, shy828301@gmail.com, ziy@nvidia.com, 
	libang.li@antgroup.com, baolin.wang@linux.alibaba.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Mingzhe Yang <mingzhe.yang@ly.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 5, 2024 at 6:56=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 05.07.24 12:48, Lance Yang wrote:
> > Hi David and Barry,
> >
> > Thanks a lot for paying attention!
> >
> > On Fri, Jul 5, 2024 at 6:14=E2=80=AFPM David Hildenbrand <david@redhat.=
com> wrote:
> >>
> >> On 05.07.24 12:12, Barry Song wrote:
> >>> On Fri, Jul 5, 2024 at 9:08=E2=80=AFPM David Hildenbrand <david@redha=
t.com> wrote:
> >>>>
> >>>>> @@ -3253,8 +3259,9 @@ int split_huge_page_to_list_to_order(struct p=
age *page, struct list_head *list,
> >>>>>                 i_mmap_unlock_read(mapping);
> >>>>>     out:
> >>>>>         xas_destroy(&xas);
> >>>>> -     if (is_thp)
> >>>>> +     if (order >=3D HPAGE_PMD_ORDER)
> >>>>
> >>>> We likely should be using "=3D=3D HPAGE_PMD_ORDER" here, to be safe =
for the
> >>>> future.
> >>>
> >>> I feel this might need to be separate since all other places are usin=
g
> >>> folio_test_pmd_mappable() ?
> >>
> >> Likely, but as you are moving away from this ... this counter here doe=
s
> >> and will always only care about HPAGE_PMD_ORDER.
> >
> > I appreciate the different opinions on whether we should use
> > ">=3D HPAGE_PMD_ORDER" or "=3D=3D" for this check.
> >
> > In this context, let's leave it as is and stay consistent with
> > folio_test_pmd_mappable() by using ">=3D HPAGE_PMD_ORDER",
> > what do you think?
>
> I don't think it's a good idea to add more wrong code that is even
> harder to grep (folio_test_pmd_mappable would give you candidates that
> might need attention). But I don't care too much. Maybe someone here can
> volunteer to clean up these instances to make sure we check PMD-size and
> not PMD-mappable for these counters that are for PMD-sized folios only,
> even in the future with larger folios?

Thanks for clarifying! Yes, agreed. We should ensure we check PMD-size,
not PMD-mappable here, especially as we consider large folios in the future=
.

So, let's use "=3D=3D HPAGE_PMD_ORDER" here ;)

Thanks,
Lance

>
> --
> Cheers,
>
> David / dhildenb
>

