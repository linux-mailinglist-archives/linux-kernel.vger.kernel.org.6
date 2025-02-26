Return-Path: <linux-kernel+bounces-535129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 523EAA46F50
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 00:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 533543A78A1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 23:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A9B25BAD1;
	Wed, 26 Feb 2025 23:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GE2taokc"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446EE2702D5
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 23:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740612027; cv=none; b=fj/LI7vgGz8qRJpkOvgKoSROuDIsQ27pb6PEyxyg2odomMagfAYvW3Lrw2TPxLgYIpSvQJ0Mq64ljNx+hCYwAUaAeBY3Y0a2lCM72Ycb/1Vst4KTIFCTmW8GHoR6vyn9rTrdZ9mwTk7RTy9AEzsvwIGAnqnD6hI+ToV1iwcINI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740612027; c=relaxed/simple;
	bh=txgPBmTkCS7pbnF2nvX6abPDlFL3Nn5DbTUA+/ZvUP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rg71nkmv80sTqAd/qjekmqesG9Zs4QitMex9Ci8G6VRJtYeVtnqUv3wmgo4JwNkq1qftyogq6H+jFzBqhbcXpkJvz1FdBhDGHbybLQ0cGE1ffZ+CsxZyx7Rg1uqsBNPSJTvuUEBR9Vsia2kRzykwpOO8MqrMmO2h4ADrLxkoyfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GE2taokc; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c0a1677aebso31441185a.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 15:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740612025; x=1741216825; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jb3Fg0r+9iy4edInBPQqpuUIWS2iy/W8yhLTpHiEveg=;
        b=GE2taokcO0whS/6wrDnvNxRbURHVIAv0PAPyOgLFRVhv6Zf5ES162HO1QFbS3yX/jQ
         zcVZ+YiyO1uZAMZulZ2HK9NRvnFLTgpkSILr3YBvtx22kVd55NJo0BOwJHCzBQPjVcpx
         12qZvY0kZJ3E25m/HXeXBjaXN8yfPEAhZ87w7hCBx9MqAHfNRz+hw5zEdDCCZUAvsIww
         TkkVCufxA++v6DdA5Eirq83r4xMPk6tUCjc56q8Nf2O7fSnFdEO/zgqRaCubUfxUL+pL
         52VedJctCLnh+Q6UqDWpGRcnKxeQYh3EHhIaraWba95gnJd3SZszUZfqxraiAs2uGa5X
         OWSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740612025; x=1741216825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jb3Fg0r+9iy4edInBPQqpuUIWS2iy/W8yhLTpHiEveg=;
        b=uB0WJLIww/L3STE56GuK9SYEqdQHOlHPDjFoZXVJQRdvDShXgnH1pGnYFe+DuMHkeA
         MnBvlSQKG3k6ICVkGHYI8Rd7aktTKy/Phzs2NwEGvOQzScxe/iudUUAPctq1yqvt7qdT
         K0a2sZ4ueDuZJIe9fVEtcvu+gPMWyfkSxVrDT6RGNMbJj98KbFR1DN9Na6Ar+T8ZXt7f
         Y8TJnqEhWlt4p6r45Iw4a+yk4N0bby/RaN3lrqgKeUdvcKIBWbHIjdvWz0mdnVfPDhYv
         zJE8SSr68ChIlwwsplyIxiiDWFprZCyn4/1Alxcf2ygahvOYEEDJ+BaipYlBSmSLm5ji
         LaYw==
X-Forwarded-Encrypted: i=1; AJvYcCU8BifQq59zFZ1EpK9Utxgr4pyLDwS0ayl8vjGomyvCZOalCtB6aYmfW0jrPEV969QwXNc/zAUlPVanhCs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuhhPPmxax4xmxlGyR7bMO8wRZkF2TTtQ2soYBskqDEzTFmFRP
	BZ93/FjN75alM46dF61MfPeMJZ9s/4h9KUYKWAinjrHhPAfuJE570FdD6Nvx5E9hKX62DgxUQWP
	owBAHdVoMqoQnQo10kkFE9aqFpE8=
X-Gm-Gg: ASbGnctxQuTtgAkN1Z6X2TGRJdYdQ5qpea6Q3k9WJ0lRkY+SnZ1FyUmecWo0w1CcyYA
	RLNigW/nPTluyz122WveJg3GIK15CvvAyEsb94n9KsVYw89LaxfFEAAwnJFfcu4YNzoFo85bj+F
	n+itwO0H/x6QOqOFT0at6REZM=
X-Google-Smtp-Source: AGHT+IFDSmNFSFi4SIYH7Yv5ExF0mwyWRGNqFyn9J5v1hn0HghXrN0QDGTOYjJw5GG8zkRssrUrm+/muv3Z1qxp+LmU=
X-Received: by 2002:a05:6214:f29:b0:6e8:96f4:73a with SMTP id
 6a1803df08f44-6e896f408c0mr12538536d6.19.1740612025035; Wed, 26 Feb 2025
 15:20:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225213200.729056-1-nphamcs@gmail.com> <Z76Go1VGw272joly@google.com>
 <20250226045727.GB1775487@cmpxchg.org> <Z780VzBOE3LKY0yi@google.com>
In-Reply-To: <Z780VzBOE3LKY0yi@google.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 26 Feb 2025 15:20:13 -0800
X-Gm-Features: AQ5f1JofLM7kJEVa7nec65D0NSModdvCkdorgscjPpQjOZdFeHkQYJwf3eIq2sI
Message-ID: <CAKEwX=PR3tJM4X00hSua-w-FNR_ZwQ1oRqdT2Cgj_FV9cCUing@mail.gmail.com>
Subject: Re: [PATCH] zswap: do not crash the kernel on decompression failure
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>, akpm@linux-foundation.org, chengming.zhou@linux.dev, 
	linux-mm@kvack.org, kernel-team@meta.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 7:33=E2=80=AFAM Yosry Ahmed <yosry.ahmed@linux.dev>=
 wrote:
>
> On Tue, Feb 25, 2025 at 11:57:27PM -0500, Johannes Weiner wrote:
> > On Wed, Feb 26, 2025 at 03:12:35AM +0000, Yosry Ahmed wrote:
> > > On Tue, Feb 25, 2025 at 01:32:00PM -0800, Nhat Pham wrote:
> > > > Currently, we crash the kernel when a decompression failure occurs =
in
> > > > zswap (either because of memory corruption, or a bug in the compres=
sion
> > > > algorithm). This is overkill. We should only SIGBUS the unfortunate
> > > > process asking for the zswap entry on zswap load, and skip the corr=
upted
> > > > entry in zswap writeback.
> > >
> > > Some relevant observations/questions, but not really actionable for t=
his
> > > patch, perhaps some future work, or more likely some incoherent
> > > illogical thoughts :
> > >
> > > (1) It seems like not making the folio uptodate will cause shmem faul=
ts
> > > to mark the swap entry as hwpoisoned, but I don't see similar handlin=
g
> > > for do_swap_page(). So it seems like even if we SIGBUS the process,
> > > other processes mapping the same page could follow in the same
> > > footsteps.
> >
> > It's analogous to what __end_swap_bio_read() does for block backends,
> > so it's hitchhiking on the standard swap protocol for read failures.
>
> Right, that's also how I got the idea when I did the same for large
> folios handling.

And your handling of the large folio (along with the comment in the
other thread) was how I got the idea for this patch :)

>
> >
> > The page sticks around if there are other users. It can get reclaimed,
> > but since it's not marked dirty, it won't get overwritten. Another
> > access will either find it in the swapcache and die on !uptodate; if
> > it was reclaimed, it will attempt another decompression. If all
> > references have been killed, zswap_invalidate() will finally drop it.
> >
> > Swapoff actually poisons the page table as well (unuse_pte).
>
> Right. My question was basically why don't we also poison the page table
> in do_swap_page() in this case. It's like that we never swapoff.

That would require a rmap walk right? To also poison the other PTEs
that point to the faulty (z)swap entry?

Or am I misunderstanding your point :)

>
> This will cause subsequent fault attempts to return VM_FAULT_HWPOISON
> quickly without doing through the swapcache or decompression. Probably
> not a big deal, but shmem does it so maybe it'd be nice to do it for
> consistency.
>
> >
> > > (2) A hwpoisoned swap entry results in VM_FAULT_SIGBUS in some cases
> > > (e.g. shmem_fault() -> shmem_get_folio_gfp() -> shmem_swapin_folio())=
,
> > > even though we have VM_FAULT_HWPOISON. This patch falls under this
> > > bucket, but unfortunately we cannot tell for sure if it's a hwpoision=
 or
> > > a decompression bug.
> >
> > Are you sure? Actual memory failure should replace the ptes of a
> > mapped shmem page with TTU_HWPOISON, which turns them into special
> > swap entries that trigger VM_FAULT_HWPOISON in do_swap_page().
>
> I was looking at the shmem_fault() path. It seems like for this path we
> end up with VM_SIGBUS because shmem_swapin_folio() returns -EIO and not
> -EHWPOISON. This seems like something that can be easily fixed though,
> unless -EHWPOISON is not always correct for a diffrent reason.
>
> >
> > Anon swap distinguishes as long as the swapfile is there. Swapoff
> > installs poison markers, which are then handled the same in future
> > faults (VM_FAULT_HWPOISON):
> >
> > /*
> >  * "Poisoned" here is meant in the very general sense of "future access=
es are
> >  * invalid", instead of referring very specifically to hardware memory =
errors.
> >  * This marker is meant to represent any of various different causes of=
 this.
> >  *
> >  * Note that, when encountered by the faulting logic, PTEs with this ma=
rker will
> >  * result in VM_FAULT_HWPOISON and thus regardless trigger hardware mem=
ory error
> >  * logic.
>
> If that's the case, maybe it's better for zswap in the future if we stop
> relying on not marking the folio uptodate, and instead propagate an
> error through swap_read_folio() to the callers to make sure we always
> return VM_FAULT_HWPOISON and install poison markers.
>
> The handling is a bit quirky and inconsistent, but it ultimately results
> in VM_SIGBUS or VM_FAULT_HWPOISON which I guess is fine for now.

Yeah I think it's OK for now. FWIW it's consistent with the way we
treat swap IO error, as you pointed out :)

>
> >  */
> > #define  PTE_MARKER_POISONED                    BIT(1)

