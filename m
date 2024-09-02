Return-Path: <linux-kernel+bounces-311843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B969A968E7B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 21:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 704F7284379
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 19:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8CB21A304D;
	Mon,  2 Sep 2024 19:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QN991v7u"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A53A1A3AB6
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 19:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725305876; cv=none; b=gUQL0rpwgg6Pqg+XUpEEeaG+vAshg2jckWKIsFPNgt8YTbVbLreAj0DPRTLfDobjVLKAbQbav2ROxpwMs0F9e7XUV9KM9z1XyJNzr+5tndBl3C9A0JXyH1c/x3q4RsuJLSu9BS4UgQoBrW6jrMUZyJAHBvSfUaVLQB03sFfntBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725305876; c=relaxed/simple;
	bh=tNZQ6agAWthYG6pghQu1uO6CYRuBInN2VRjmXerBimU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jXOzHxgW4RKPtydDkfsQr2ik5pWywVeL0wXViu1G1HpsDzzaeSXeLpeY1y4H47ves6Mc0UKHIAaOfXlZA0TlJXvaXcovyxACdKPWfBKLNtJ1VSriPTchkvnBlKOThzLh+3ry3mvhArHvEW97vGc8Ibkv+uuYi+aJqklufWxLekw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QN991v7u; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c26852af8fso816356a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 12:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1725305873; x=1725910673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8kTkaMtZbTOFi94WeEiiNkDEjcRyVv3G+OkzuX2Kg7Q=;
        b=QN991v7u7nhhVnfZQeMjeV9zVyIeayTQA+0zdVZBzG782n8Y/D9jA+TbUk5DUPkIoX
         awyAhVQ2NYSdBb/F8lQgRN4aDbdOj+1AKTXfJHb1BHF9sAWqSiMNCXMtkCXvg1N3/x9M
         wzxvDqxDk/Cxb4JXlv6Z1EmloSAj0xnOoqP+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725305873; x=1725910673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8kTkaMtZbTOFi94WeEiiNkDEjcRyVv3G+OkzuX2Kg7Q=;
        b=jabaKoAxPuWhL2nPSXzeoWAeyGLuVhhFExQVK2hvqf2MGc9tXFgL0nx5xpmg18BPmN
         DbGld8kowNyC8vWmbwXdXCbs11RHs6ulOhRmNcfhNK0xpV82jA0w9l3/GQRrIw4RgdmL
         mujzWGg68Px+vVIL1N16nP6w6lhfDZcrmNmf1BL0uaS1URbhDAtIiu4T5fz6yOHvdUHw
         SKG9LJTSXivw+pFufrvvk2RvXNDQu4nEi04c2CvHNAU/XbPvw3Y+HAgWHzl9aTXGO68f
         mA0n1N5/2EUriH/J+h9th/ZQwJb9FKiLnaeBsB6zKbibNq6Vx32aFMMQyZIHG1WS0rXT
         Pc/g==
X-Forwarded-Encrypted: i=1; AJvYcCVGnLyUXnLuYVRNHlcPjTjf2DTHudh7/KNKLgBSIGq/X1Jdq5kxHecBplLt9eIGAz6tfpRlT4f2fWRws98=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuEGavkmIUzrcHc61lrujTSfgfHiTnneXe+s0RZTK/NacLny9/
	CI7Dd1QowtJ5gtVqdQ+3FM2tjjendI8900n0BLG76FAVf/3UKjygDokDnEcKlxcePM+D97g++sd
	/2Af19Q==
X-Google-Smtp-Source: AGHT+IFBNLlT8o+ZktxrARq0TvwDWj8ve+kWtWNs5xeFC0znQ+cdKJgMvhyJvrAB6pEF3+18Hoh/8A==
X-Received: by 2002:a05:6402:1d56:b0:5c0:9097:c0fc with SMTP id 4fb4d7f45d1cf-5c21ed89fe2mr11707754a12.26.1725305872075;
        Mon, 02 Sep 2024 12:37:52 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c226cd18a3sm5524758a12.66.2024.09.02.12.37.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 12:37:51 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5bec87ececeso4816803a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 12:37:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW96or/+vAI07/QARpjuUH3V4IDeY2B5wvsh5ZSnbmHkXN/xnNUjEBXjRJrPM3pWZccVxpnmNDonmhbH8w=@vger.kernel.org
X-Received: by 2002:a05:6402:348f:b0:5be:ed8c:de7 with SMTP id
 4fb4d7f45d1cf-5c21ed3e14bmr12483998a12.11.1725305871261; Mon, 02 Sep 2024
 12:37:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPM=9tzX71UKndfu8JECMOzc9kf4s4pp9cWTMWwE476cQXt_Yw@mail.gmail.com>
 <CAHk-=wijFJM9MHvwGSS4ADs8ncRagrXYi2E9SvhK8coMH32D7A@mail.gmail.com>
 <CAPM=9txF4+rC_CXQTftPctUd0N37t306YKcV3oKPjz+_zQGqag@mail.gmail.com>
 <440d041982f7f232f0ce3284bed4db391adb05c1.camel@linux.intel.com> <5c493bd5-e657-4241-81d7-19ccd380b379@amd.com>
In-Reply-To: <5c493bd5-e657-4241-81d7-19ccd380b379@amd.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 2 Sep 2024 12:37:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wivPvBbaTnKgdH84gtWD-VXUD529L8t8-BxhPEwJvY+4w@mail.gmail.com>
Message-ID: <CAHk-=wivPvBbaTnKgdH84gtWD-VXUD529L8t8-BxhPEwJvY+4w@mail.gmail.com>
Subject: Re: [git pull] drm fixes for 6.11-rc6
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Dave Airlie <airlied@gmail.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, 
	dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, 
	Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>, Alex Deucher <alexdeucher@gmail.com>, 
	lingshan.zhu@amd.com, Matthew Brost <matthew.brost@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2 Sept 2024 at 03:34, Christian K=C3=B6nig <christian.koenig@amd.co=
m> wrote:
>
> Am 02.09.24 um 11:32 schrieb Thomas Hellstr=C3=B6m:
> >
> > The remap_pfn_range was last tried, at least in the context of the i915
> > driver IIRC by Christoph Hellwig but had to be ripped out since it
> > requires the mmap_lock in write mode. Here we have it only in read
> > mode.

Yeah, that does make things much more fragile. The "fill in multiple
pages" helpers are really meant to be used at mmap() time, not as some
kind of fault-around.

So remap_pfn_range() sets the vma flags etc, but it also depends on
being the only one to fill in the ptes, and will be *very* unhappy if
it finds something that has already been filled in.

And fault-around is *much* more fragile because unlike the mmap time
thing, it can happen concurrently with other faults, and you cannot
make assumptions about existing page table layout etc.

> The pre-faulting was increased because of virtualization. When KVM/XEN
> is mapping a BO into a guest the switching overhead for each fault is so
> high that mapping a lot of PFNs at the same time becomes beneficial.

Honestly, from a pure performance standpoint, if you can just do all
the page mapping at mmap() time, that would be *much* much better.

Then you can easily use that remap_pfn_range() function, and latencies
are much less of an issue in general (not because it would be any
faster, but simply because people don't tend to use mmap() in
latency-critical code - but taking a page fault is *easily* very
critical indeed).

                Linus

