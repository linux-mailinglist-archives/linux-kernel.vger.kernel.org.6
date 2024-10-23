Return-Path: <linux-kernel+bounces-377755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B714E9AC565
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 11:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 597F41F24672
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 09:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA0E198A38;
	Wed, 23 Oct 2024 09:23:37 +0000 (UTC)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD0717B51A
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 09:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729675416; cv=none; b=sxs+03T0LfxGkjZD8Rlo3Vv8lUieycGZvU3zDL1bX8ODNwRZMXbhop9N50sBHB6yWXzfsRuLUGVbGhlEH7uEPHogpWua/l4loIf/xuWp8wLJT7/i03rH+X2osgZd8Oi9hkjNiSIq+LGBAtVNbdcpxJPjiIgpjeiW5XSiXRLLtJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729675416; c=relaxed/simple;
	bh=b873wxbOtrs++2LVoQSE881XzbQPkTOIgQkc7egGAoE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GpVaCSduk8QoUsrlLkKcU/i+7oAMYHAVFBkP+qkHZgzuggd+M+bRCf+N8urIbMhcM6JviWWr9yL5p/Mzz3GSvhcwrURXg4ahG572VS8GlcJZFszND4JSexWx+uBzYy+Xa7MEQk0iDRMSoMmWvTjDyXBNjXnphhftbN5C4bFppMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6e3d7e6f832so63361207b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 02:23:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729675413; x=1730280213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4OUxjxaEtG+AG1y3fcT6N6LYOlGucW8Y738Nm7+hUf8=;
        b=hN2i7pBhUbfABGEd3BV4eQftWUjH81RIkyMGG+/da620vRewJ18/AGkl5mimqoIirX
         bVhsQljzu8moeWDvqjg8L/sUJKSfgHR9FNz3eSrnhknRn5AMUztlFSQDAbJoiv5VgS2H
         I75kMRhKXQ+n1F/fGxJ8T3mDMG7Bdw4HWrShle8XO9EB5xXsOtJi1SFB4a0laa9YVSD0
         ilYgpQCMhndeH4BQ71lTSRYsJx/ZrXeus4iUPrAKxOKg2PTA7Dp17M4gBMjwf/RdBpw1
         6y76QQTOetn8Hjq+2V7+x2IjWEY9F3d796EIsTstTc0LnZnOEY9hyaDKJk4keenAZD5E
         0cqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzC43x7O0TA8DVM52BZYMKa+GhVCGsbl8V50RVr9q/LY2+ou670i7oiuDGVNxGemeDBXjYmNb/am62WyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRBX7Je4ZUKxLPqoegRnyfBrgC0x/1c0U5VOczB/bjBZZtFkEu
	KrdL/OZMYcrNXH1S1FEimIs3jYWhE6Th0gG7kGNOaY+gB7vS+3C+GD6oJ1jK
X-Google-Smtp-Source: AGHT+IEI5PiDYZlrQeC7yYRh4hmdqjy5QZUi58FM2pFzyyMkR6/+BMhRbwIEdTB6KvdDq+hoQHDcbw==
X-Received: by 2002:a05:690c:fc7:b0:6e2:e22:12d9 with SMTP id 00721157ae682-6e7f0fa3a10mr16394917b3.35.1729675413024;
        Wed, 23 Oct 2024 02:23:33 -0700 (PDT)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f59f5939sm14558487b3.6.2024.10.23.02.23.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 02:23:32 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6e5fadb5e23so31203857b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 02:23:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU+keAhO4BvZT85sZUxLdCCfHURK9gx1PN9G8b7SFYPjtZ+ytOpfd9tnjVEUZyw2dbdx7yPITHSJUOYYTA=@vger.kernel.org
X-Received: by 2002:a05:690c:9a06:b0:6e3:b6c:d114 with SMTP id
 00721157ae682-6e7f0fd7dc1mr16599767b3.38.1729675412363; Wed, 23 Oct 2024
 02:23:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZxZ8MStt4e8JXeJb@sashalap> <792F4759-EA33-48B8-9AD0-FA14FA69E86E@kernel.org>
 <ZxdKwtTd7LvpieLK@infradead.org> <20241022041243.7f2e53ad@rorschach.local.home>
 <ZxiN3aINYI4u8pRx@infradead.org> <20241023042004.405056f5@rorschach.local.home>
 <CAMuHMdUxrULbo=A77DFDE4ySbii3jSMuh8xVvUXaqyCnwEAU-w@mail.gmail.com> <20241023051914.7f8cf758@rorschach.local.home>
In-Reply-To: <20241023051914.7f8cf758@rorschach.local.home>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 23 Oct 2024 11:23:20 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWnuapbk4tcOqAS_TrsLcGz9wcC0RD5z1gzUd_GcE_wRQ@mail.gmail.com>
Message-ID: <CAMuHMdWnuapbk4tcOqAS_TrsLcGz9wcC0RD5z1gzUd_GcE_wRQ@mail.gmail.com>
Subject: Re: linus-next: improving functional testing for to-be-merged pull requests
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Christoph Hellwig <hch@infradead.org>, Kees Cook <kees@kernel.org>, Sasha Levin <sashal@kernel.org>, 
	torvalds@linux-foundation.org, ksummit@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Steven,

On Wed, Oct 23, 2024 at 11:19=E2=80=AFAM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
> On Wed, 23 Oct 2024 10:36:20 +0200
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> > > To put it this way. The bugs I'm fixing was for code in linux-next
> > > where the bugs were never found. They only appeared when they went in=
to
> > > Linus's tree. So why put the fixes in linux-next, if it didn't catch
> > > the bugs I fixed in the first place?
> >
> > Hmmm...
> >
> > Your arguments sound very similar to those being used in recent
> > discussions about not posting patches for public review...
> >
> > Please follow the process! ;-)
>
> What process?
>
> Note, I probably post everything to mailing lists more than anyone
> else (besides stable). All my commits come from mailing lists. Even
> things I change myself. I always send out the change to a list. Then I
> use patchwork to pull it into my tree.
>
> After the changes are tested, I send out the patches *again* with my
> [for-next] tags in the subject. If it's a fix for Linus, it goes out as
> a "[for-linus]" tag. These emails automatically update my patchwork
> status.
>
> No change goes into Linus's tree from me that hasn't been sent out
> publicly.

All good!

> But pushing to linux-next for a day or two, what does that give me?

It may catch issues you missed, e.g. compile failures on obscure
architectures or configs, e.g. due to indirect includes.

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

