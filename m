Return-Path: <linux-kernel+bounces-416102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 313E79D40EC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 18:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4E66B37086
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 16:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDF5148FE8;
	Wed, 20 Nov 2024 16:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="JTrwn96T"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C726F153820
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 16:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732120855; cv=none; b=oTdXTn1pIoO2bOPqX+EW+CwqFk+9xm5Nn91aWRcinHr5xifpHa7mcosw+jhxguxbFeOhQmuzeExwO8Bf08SMgkQc12F47nyQX5TV8J9kyow35gau4Rit9SLwO606zdQLVCO1ACqgYTuZIqsUZionupoAxpHlOX/mN577/pERJ9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732120855; c=relaxed/simple;
	bh=qFK5EvqBZ+FjmE22hL4UUAySxH2UgWn1OIf3kinQ/4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nxaSuuJzYvJxzoOILpNdy3fXRn3WMnC391qZiwJ0fazFYLADsKm5tJd8/7e3pBiMf1Nz1A22Aqq2rE8HtzInE2ngJ+3ApVvv+VQz2Qgv9wSrcEJdp3avcRiSqVGPn9N0D2FiY3dL06PX/U1WicCoxIWjU1C3JfcbNeqi0iNjUIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=JTrwn96T; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4609b968452so45284271cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 08:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1732120853; x=1732725653; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qFK5EvqBZ+FjmE22hL4UUAySxH2UgWn1OIf3kinQ/4M=;
        b=JTrwn96Ttky/UoBX+bQss/opbVOE+0VBNtYL4bVIeXW+wg8JYOmBiPNo9gEK2/ZQy4
         QuRqprRu+sLYER/ohrktYDHWPUGiptJlWDJYvptSr/o0Bqji5LAqFyJ1O6A4M3FX4tXZ
         wNiJltpw/yKf+bwS2YqY4jMAZ9KBykaAvU494brqAhXl1ach53sq/HAPysVm7MvjZi2p
         KKYvg0zzJwIXh7W+56f5OHo9Hi4Wf7k24gDq0uZyPTZX1WUwrFJbM58O3xIi7q5efido
         ukigsILg7vq01mp4uxGAWMBxjNX9AoPY9I11fwRYK/HBqTQQCzhrWTl0AbktuXRTuUeV
         b7sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732120853; x=1732725653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qFK5EvqBZ+FjmE22hL4UUAySxH2UgWn1OIf3kinQ/4M=;
        b=h86SUhH4W+zQee5dh36QJ2B0L1DM8PAGaXolHcpaZyqciGXfyMsZrjXaWkMMZyZi1a
         U1SoISv2XtZprV+UVWg0xXKF2otlU8eWkbCr8XlhauHh+euuaIO3r37FSqkjE7oTAmvM
         w0tai4567M5dDd9X5me9+Cw8aLZh+ojuBvipTQ1bwXEziT621+kEWCm3+qCELi8c48ks
         nhtmiPIWAc24EwQRCGhoqtTvnwkiq5MPLcizdM2iFdnp4FQ17LZMsf7tANc87Jsk5lxc
         WEHyoCvzdmp25I8s79atJplBPoifEg7vrm/TB3GIpZGKZN4/0NWnhhTb37hsjG6lbgJn
         NybQ==
X-Gm-Message-State: AOJu0YznNElNaLRtpNQDedUFyLx/8+Sp7Ef84XdJ2KUcsT9AJbmQocrb
	+pcAkZIjFdQdM4hUNipb/d3v1z3mzgyjK4G7p64qEWhbcn91xq2qShiyfsrJQNhhxNpIOQCkQe2
	wZzfUONOJ7C7BnR0tj/Y4AT31wLI5eNuHmMlzoA==
X-Google-Smtp-Source: AGHT+IGVXXSe3/jOn7/F0+v6GfoX8kW0XiYKv4M7VEKR+QzShMxf6KNfCHMwiuPpKZqaaCv3T5XpK+zCdLzMyTPmntk=
X-Received: by 2002:a05:622a:5496:b0:464:b81c:316e with SMTP id
 d75a77b69052e-464b82b74c4mr29186591cf.6.1732120852696; Wed, 20 Nov 2024
 08:40:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241116175922.3265872-1-pasha.tatashin@soleen.com> <87wmgxvs81.fsf@linux.intel.com>
In-Reply-To: <87wmgxvs81.fsf@linux.intel.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 20 Nov 2024 11:40:15 -0500
Message-ID: <CA+CK2bDTKXuTHq7EOvErWFRe9XRGq9UF5L-LmzX3jhWd40_KbQ@mail.gmail.com>
Subject: Re: [RFCv1 0/6] Page Detective
To: Andi Kleen <ak@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	akpm@linux-foundation.org, corbet@lwn.net, derek.kiernan@amd.com, 
	dragan.cvetic@amd.com, arnd@arndb.de, gregkh@linuxfoundation.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, tj@kernel.org, 
	hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, muchun.song@linux.dev, Liam.Howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, vbabka@suse.cz, jannh@google.com, 
	shuah@kernel.org, vegard.nossum@oracle.com, vattunuru@marvell.com, 
	schalla@marvell.com, david@redhat.com, willy@infradead.org, osalvador@suse.de, 
	usama.anjum@collabora.com, andrii@kernel.org, ryan.roberts@arm.com, 
	peterx@redhat.com, oleg@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2024 at 10:29=E2=80=AFAM Andi Kleen <ak@linux.intel.com> wr=
ote:
>
> Pasha Tatashin <pasha.tatashin@soleen.com> writes:
>
> > Page Detective is a new kernel debugging tool that provides detailed
> > information about the usage and mapping of physical memory pages.
> >
> > It is often known that a particular page is corrupted, but it is hard t=
o
> > extract more information about such a page from live system. Examples
> > are:
> >
> > - Checksum failure during live migration
> > - Filesystem journal failure
> > - dump_page warnings on the console log
> > - Unexcpected segfaults
> >
> > Page Detective helps to extract more information from the kernel, so it
> > can be used by developers to root cause the associated problem.
> >
> > It operates through the Linux debugfs interface, with two files: "virt"
> > and "phys".
> >
> > The "virt" file takes a virtual address and PID and outputs information
> > about the corresponding page.
> >
> > The "phys" file takes a physical address and outputs information about
> > that page.
> >
> > The output is presented via kernel log messages (can be accessed with
> > dmesg), and includes information such as the page's reference count,
> > mapping, flags, and memory cgroup. It also shows whether the page is
> > mapped in the kernel page table, and if so, how many times.
>
> A lot of all that is already covered in /proc/kpage{flags,cgroup,count)
> Also we already have /proc/pid/pagemap to resolve virtual addresses.
>
> At a minimum you need to discuss why these existing mechanisms are not
> suitable for you and how your new one is better.

Hi Andi,

Thanks for your feedback! I will extend the cover letter in the next
version to address your comment about comparing with the existing
methods.

We periodically receive rare reports of page corruptions detected
through various methods (journaling, live migrations, crashes, etc.)
from userland. To effectively root cause these corruptions, we need to
automatically and quickly gather comprehensive data about the affected
pages from the kernel.

This includes:

- Obtain all metadata associated with a page.
- Quickly identify all user processes mapping a given page.
- Determine if and where the kernel maps the page, which is also
important given the opportunity to remove guest memory from the kernel
direct map (as discussed at LPC'24).

We also plan to extend this functionality to include KVM and IOMMU
page tables in the future.
<pagemap> provides an interface to traversing through user page
tables, but the other information cannot be extracted using the
existing interfaces.

To ensure data integrity, even when dealing with potential memory
corruptions, Page Detective minimizes reliance on kernel data
structures. Instead, it leverages direct access to hardware structures
like page tables, providing a more reliable view of page mappings.

> If something particular is missing perhaps the existing mechanisms
> can be extended?
> Outputting in the dmesg seems rather clumpsy for a production mechanism.

I am going to change the output to a file in the next version.

> I personally would just use live crash or live gdb on /proc/kcore to get
> extra information, although I can see that might have races.

For security reasons crash is currently not available on our
production fleet machines as it potentially provides access to all
kernel memory.

Thank you,
Pasha

