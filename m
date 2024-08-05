Return-Path: <linux-kernel+bounces-275115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 146F19480C1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 19:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51A73B21EB0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF32215F3FE;
	Mon,  5 Aug 2024 17:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hSOwsd9I"
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92551547E7
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 17:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722880499; cv=none; b=hB8+VaAwzh6JrN1UF1Trq01yn/LUzSA6lvJ2y1UGWffdky9KXgI375PeeRVGN2Fy9BDEOiSP2+cgygVZMkoRUj40hRWGsmnb2M27RExn7RaU0jCP5+uv8CorKz/CCx4KWw4Ymlq6mO2hoF5kHHfT8AB8+Pf+o+/v1EAMTcBCADY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722880499; c=relaxed/simple;
	bh=GQkjH4R2oNhKk0Gv7sFrDvmfpAjpYyo6PtB/FbwIiNs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tiB3i4rghNnNW1teTIQw5RO+AGUULKKIi2OzHZ0m0ZbkDD2PVFHVaVJJYbL0ieMNMrdHvYr1R6SYlbTaeTSPDZIWvJ4salIPHCnE31qRstp0I3fjZTkSE582h9qK/EJCjRZc4V0HXm4RT1xhVaIX5ZAB5mBoQgNo+2VSaeeAUxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hSOwsd9I; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-260f033fda3so6643050fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 10:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722880496; x=1723485296; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aI072rJ95IpNDgMCOsSYpX0fqCtQK3FmN4K3CCKoTUo=;
        b=hSOwsd9IdBWukliXc38sQFv+gQV2xJA5Bf42V4+EpCic8KWSpIxWMiCs5ZNH4rhNLq
         doOj1qtdgOOmLeHjoI/gY3p/+s5qPcE13KO2LXzIiEQnnJsyKx99gvL8RPksIZzZCmDL
         spmPqZeCOkes9crMXB6WyWWyDpFDeI3Kb/3NU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722880496; x=1723485296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aI072rJ95IpNDgMCOsSYpX0fqCtQK3FmN4K3CCKoTUo=;
        b=BaF3SQW2uUX0KWrDZJARnJJLiuoFu0fjb1DNLa2WoIGIl3n2H1wCEZ5hN80S8U5yui
         7sMtk8eS6p8Wz5DjD1KswvCl3UkQ9pq/LjKzLQltLWYkW2sjjW/40ZlrHEYZEbDELS8a
         /TvXyq7BUt62zU2bFlsYNwm0Z2E9+SmxivQP9EuBL9XBy3cGobJvHTagGMzfAcpVuuHb
         2FkNdk39YI2L3WfVY06BcOOsG7N27mjrnGjH5AQjvRQt86jcKTWdMS/G9Ov9DP/8+1pK
         g3/biWn4uJvjY9ofSBU5zDpibunVWUeIG0r7OTLHwJ9uIFvzjHlDY47A5424PM9ddWc4
         psSA==
X-Forwarded-Encrypted: i=1; AJvYcCX8UpbrQSi8eZCx7ZuoHITVB8tmLz1ftD53eEqMDgzEpLWN5sX9yiSwKlO9EeAcypuSvUhZXIKX+h0dVILfx3wmWSfGOpbxQvyKcO85
X-Gm-Message-State: AOJu0Yy67qw6NZmiuYkk6Mdv8mzSkExA2FJtFzQ2ETgljV/I2Q2v43e8
	CJNNEioyhgOKPvdXctlSsWWh4lqpSBsDFwi17MxSAzbCxMfVpmmaLVVXiPNrsrDqf6kSPLTIa+8
	vwS2n50CQzrH7xwYJYOq1qI3fH/juQIfW7ljN
X-Google-Smtp-Source: AGHT+IHEMfm5KZKzTuBuhbgn2BzM+Kkm0uGH+2NRDn+4bmV5rY5gAUDOiMxN7ccdXki/NJFJB+bUPiTfh36WFyShrO8=
X-Received: by 2002:a05:6870:d152:b0:260:e2ed:1abe with SMTP id
 586e51a60fabf-26891e929d5mr15828098fac.39.1722880495977; Mon, 05 Aug 2024
 10:54:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202408041602.caa0372-oliver.sang@intel.com> <CAHk-=whbxLj0thXPzN9aW4CcX1D2_dntNu+x9-8uBakamBggLA@mail.gmail.com>
In-Reply-To: <CAHk-=whbxLj0thXPzN9aW4CcX1D2_dntNu+x9-8uBakamBggLA@mail.gmail.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Mon, 5 Aug 2024 10:54:44 -0700
Message-ID: <CABi2SkWkD0hbr_Bv1DiL-gzCgCtuJrWKvhGhh8GuU1vVMejzmw@mail.gmail.com>
Subject: Re: [linus:master] [mseal] 8be7258aad: stress-ng.pagemove.page_remaps_per_sec
 -4.4% regression
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Kees Cook <keescook@chromium.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Pedro Falcato <pedro.falcato@gmail.com>, Dave Hansen <dave.hansen@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guenter Roeck <groeck@chromium.org>, 
	Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Matthew Wilcox <willy@infradead.org>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, =?UTF-8?Q?Stephen_R=C3=B6ttger?= <sroettger@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Amer Al Shanawany <amer.shanawany@gmail.com>, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	linux-api@vger.kernel.org, linux-mm@kvack.org, ying.huang@intel.com, 
	feng.tang@intel.com, fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 4, 2024 at 1:33=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sun, 4 Aug 2024 at 01:59, kernel test robot <oliver.sang@intel.com> wr=
ote:
> >
> > kernel test robot noticed a -4.4% regression of stress-ng.pagemove.page=
_remaps_per_sec on
> > commit 8be7258aad44 ("mseal: add mseal syscall")
>
> Ok, it's basically just the vma walk in can_modify_mm():
>
> >       1.06            +0.1        1.18        perf-profile.self.cycles-=
pp.mas_next_slot
> >       1.50            +0.5        1.97        perf-profile.self.cycles-=
pp.mas_find
> >       0.00            +1.4        1.35        perf-profile.self.cycles-=
pp.can_modify_mm
> >       3.13            +2.0        5.13        perf-profile.self.cycles-=
pp.mas_walk
>
> and looks like it's two different pathways. We have __do_sys_mremap ->
> mremap_to -> do_munmap -> do_vmi_munmap -> can_modify_mm for the
> destination mapping, but we also have mremap_to() calling
> can_modify_mm() directly for the source mapping.
>

There are two scenarios in mremap syscall.
1> mremap_to (relocate vma)
2> shrink/expand.
Those two scenarios are handled by different code path:

For case 1>
mremap_to (relocate vma)
-> can_modify_mm , check src for sealing.
-> if MREMAP_FIXED
->-> do_munmap (dst) // free dst
->->-> do_vmi_munmap (dst)
->->->-> can_modify_mm (dst) // check dst for sealing
-> if dst size is smaller (shrink case)
->-> do_munmap(dst, to remove extra size)
->->-> do_vmi_munmap
->->->-> can_modify_mm(dst) (potentially duplicate  with check for
MREMAP_FIXED,  practically, the memory should be unmapped, so the cost
 looking for a un-existed memory range in the maple tree )

For case 2>
Shrink/Expand.
-> can_modify_mm, check addr is sealed
-> if dst size is smaller (shrink case)
->-> do_vmi_munmap(remove_extra_size)
-> ->-> can_modify_mm(addr) (This is redundant because addr is already chec=
ked)

For case 2:, potentially we can improve it by passing a flag into
do_vmi_munmap() to indicate the sealing is already checked by the
caller. (however, this idea have to be tested to show actual gain)

The reported regression is in mremap, I wonder why mprotect/munmap
doesn't have similar impact, since they use the same pattern (one
extra out-of-place check for memory range)

During version 9, I tested munmap/mprotect/madvise for perf [1] .  The
test shows mseal adds   20-40 ns or 50-100 CPU cycle pre call, this is
much smaller (one tenth)  than change from 5.10 to 6.8. The test is
using multiple VMAs with various types[2].  The next step for me is
to run the stress-ng.pagemove.page_remaps_per_sec to understand why
mremap shows a big regression number.

[1] https://lore.kernel.org/all/20240214151130.616240-1-jeffxu@chromium.org=
/
[2] https://github.com/peaktocreek/mmperf

Best regards,
-Jeff


> And then do_vmi_munmap() will do it's *own* vma_find() after having
> done arch_unmap().
>
> And do_munmap() will obviously do its own vma lookup as part of
> calling vma_to_resize().
>
> So it looks like a large portion of this regression is because the
> mseal addition just ends up walking the vma list way too much.
>
>               Linus

