Return-Path: <linux-kernel+bounces-386485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB749B440B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 09:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B60DF1F2361E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 08:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE19201246;
	Tue, 29 Oct 2024 08:20:38 +0000 (UTC)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAA4201027
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 08:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730190038; cv=none; b=g+7M08gpDxhmeXGXMitlDQRPMhZzbE274H955vjX80INTpUpox4sute0gnzbfFpfb0vuc+A/YZfIl4z3xyHjdErzC0/ndwmtAhwREUQJbh5/gexzIuE5rQkyuw3UYAlB8lkhYO91JsbGCbS9w+9wPORggYMtZvsmFPQ4wD0pfiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730190038; c=relaxed/simple;
	bh=sxQnfhQBb8SyF7+rSrPwtZzt4KWeubEXZ7zMptVq8UY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FGhVMMZLock8v4zRd/gDq4D074+FUv55XLEGhGR52DOEsPyOML9eMJf/CZhMHrgHG4rOSg6QTQcXiasJVZOyjksjNbsyLlRC3CqKDSo4aAec2ItHhMByzzWuecJZGOvaneB3BA227xid/uMeGDN4kLEjzdYS4YhARGXKZn7ga9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6e59a9496f9so56711157b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 01:20:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730190034; x=1730794834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZbKJj/heHZ8h7dStl0WMCzBK50Xi/U4OKafIMf/dP9s=;
        b=rQ2rzb7iETyN8XyaDAa14OFDUKel4vcCAns5L5pYlbMf//d5Umb6XInmuLTFAGG0E0
         TmSfsV/oe9gSt7LnpmcrbluntLnxmWh0PFibK+lo17Fo5qG1dRAvywXJwhLj0EpymNVy
         tXSOGQQRsBNRMP963Ur5VfxGWRWA8w9nUSq/c9CYFlfYz9LCcGk2oKvHq9K7/zV3vb7e
         gClhUBdPsI6BcuP40rNUD04voiD6Jmh5XyGMNcgg7gAfS1pZjol6ic9LOueSOQ2Ec6Ez
         uQtzgCnqROtXv3DMzXOlBVY+nOYRwSSD5srrx3EBOSSABOYU3+vJA14SO9aTaY0oJ7fu
         8URQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhSBixB7+/x6M/AuAaIOgnticykqZ0yAG/fTVGfnpb18A93MwLOrPDC675vRRIHD7upaFk9zt/Tx1rqhA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxSjRNJab56x01P1fXNrUS6Vk2mNvI04nglyCxKEn8OgJ2CcbX
	ZKIipZSGMVDXg+bNwgL0urFiWWo3tVpZh9rBiJcEDStc6WI8sghsb/0ZG9fD
X-Google-Smtp-Source: AGHT+IH/+fDOMXh6ksPNXuyw/V3vxj5AauMhLF2uwgkiTJC+mcYHzenZCKB1SfgY+QPCNIXzs78T2A==
X-Received: by 2002:a05:690c:368a:b0:6dd:cdd7:ce5a with SMTP id 00721157ae682-6e9d8963fcfmr115932077b3.18.1730190034199;
        Tue, 29 Oct 2024 01:20:34 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e9c6c18650sm18241567b3.64.2024.10.29.01.20.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2024 01:20:33 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6e5cec98cceso42743577b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 01:20:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVsTXzSnnb4xvSUCOGLD9Ea5NpvitQFWZaM98p3z5/Auv5O6PtzeujoTZL8lCX2ACoKIS3j8s7GgceSu9M=@vger.kernel.org
X-Received: by 2002:a05:690c:38a:b0:6b3:a6ff:7676 with SMTP id
 00721157ae682-6e9d88fe24bmr107937077b3.3.1730190033476; Tue, 29 Oct 2024
 01:20:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZxZ8MStt4e8JXeJb@sashalap> <792F4759-EA33-48B8-9AD0-FA14FA69E86E@kernel.org>
 <ZxdKwtTd7LvpieLK@infradead.org> <ZyAUO0b3z_f_kVnj@sashalap>
In-Reply-To: <ZyAUO0b3z_f_kVnj@sashalap>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 29 Oct 2024 09:20:20 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVLH1z244DC6OBQx1JDwvW_KdYaof_u6FQq4P8OUb3KNw@mail.gmail.com>
Message-ID: <CAMuHMdVLH1z244DC6OBQx1JDwvW_KdYaof_u6FQq4P8OUb3KNw@mail.gmail.com>
Subject: Re: linus-next: improving functional testing for to-be-merged pull requests
To: Sasha Levin <sashal@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Kees Cook <kees@kernel.org>, torvalds@linux-foundation.org, 
	ksummit@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sasha,

On Mon, Oct 28, 2024 at 11:46=E2=80=AFPM Sasha Levin <sashal@kernel.org> wr=
ote:
> On Mon, Oct 21, 2024 at 11:48:34PM -0700, Christoph Hellwig wrote:
> >On Mon, Oct 21, 2024 at 09:54:53PM -0700, Kees Cook wrote:
> >> For example, for a given PR, the bot can report:
> >>
> >> - Were the patches CCed to a mailing list?
> >> - A histogram of how long the patches were in next (to show bake times=
)
> >> - Are any patches associated with test failures? (0day and many other
> >> CIs are already running tests against -next; parse those reports)
> >>
> >> We could have a real pre-submit checker! :)
> >
> >That would be very useful.  Items 1 and 2 should be trivial, 3 would
> >require a bit of work but would still be very useful.
>
> If you've been following so far, there is a bot that is capable of doing
> most of the above
> (https://git.kernel.org/pub/scm/linux/kernel/git/sashal/next-analysis.git=
/).
>
> Here's a histogram that describes v6.12-rc4..v6.12-rc5 as far as how
> long commits spent in -next:
>
> Days in linux-next:
> ----------------------------------------
>   0 | +++++++++++++++++++++++++++++++++++++++++++++++++ (89)
> <1 | +++++++++++ (21)
>   1 | +++++++++++ (21)
>   2 | +++++++++++++++++++++++++ (45)
>   3 | ++++++++++++++ (25)
>   4 | +++++ (10)
>   5 |
>   6 | + (2)
>   7 |
>   8 | + (3)
>   9 | ++ (4)
> 10 |
> 11 | +++ (6)
> 12 |
> 13 |
> 14+| ++++++++ (15)
>
> This is where I think the value of linus-next comes during the -rc
> cycles: the (89 + 21) commits that haven't gone through the -next
> workflow before being pulled. I'm not looking to delay the process and
> add latency, I'm looking to plug a hole where code would flow directly
> to Linus's tree bypassing -next.
>
> With linus-next, we can at least squeeze in build tests as well as some
> rudimentary testing if we get a few hours before Linus pulls (and we
> usually do).

[Oops, I misread "linus-next"-with-an-S in the last two paragraphs,
 and only noticed _after_ I wrote my comments below.  Anyway, I am
 still sending them as they (partly) explain the histogram's shape.]

Linux-next releases are not created automatically.
The last linux-next release happens on Friday (AU time), while Linus
creates the -rc on Sunday (US time), so most PRs sent during the second
half of the week would miss linux-next until Monday...

"Release early" still matters...

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

