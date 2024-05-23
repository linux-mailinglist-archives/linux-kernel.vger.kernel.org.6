Return-Path: <linux-kernel+bounces-186928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2022E8CCAE1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 04:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40E351C21205
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 02:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6580612B151;
	Thu, 23 May 2024 02:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZT4a9IjK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCC341C6C
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 02:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716432765; cv=none; b=BukjezRZpuMu9eW8GBJ789VYaNpJgZ6y7kuVONACBiERO0JO4Klv2fpsPSU/x3nUqxhjTAQAQyFsAtUyn6XlGekb0JZ1DxEUUb9Ud+9Mm1tKLDVdE4kQoabInDU5PjiggUrP9V7jgB1nQzK6C/gYQOgNpl9VqoOElj7fC/ljYJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716432765; c=relaxed/simple;
	bh=vR4+HrpPnSv3yvS4mfdFSTip8mI9qycDvxOpHK+uwzY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n7a4TQ7fWwsBThiZZGe59U27Db4N10kVBgvd/ZiG+rqmJPE6AnOeiB9Nh7ds2U5IUx8jC2h97NZr5wzhj79dw7BT7jIM8JhxSxIsr0HqA8Z8LCG6iSo9KflenMHKyvU6zoKb8oACe2eYs+OCLfD8VxsvvyzrW3poa7MY4QYO4mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZT4a9IjK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716432762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tWbBNmbHIEsZsY7vbmRzxEnY1vtC+xzevrdRnLUowJI=;
	b=ZT4a9IjKfUGL2skwqUj6nHZwQJnvEEeXPyx3Nviha3mhqyajjRPSWUlKymKJuwPXl2c/Qb
	EPvILrEqnaA4rPJ30Xb9Ex1mCN9ArWzWsW7Z3TYfJqTtD+VczfkF8POnp5hsp0GrjO5v2G
	QD4ALGKdBuDzoKRP5mfP9YZ09/yyvms=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-0Y3kWN3yNoCqkw17SSSymw-1; Wed, 22 May 2024 22:52:40 -0400
X-MC-Unique: 0Y3kWN3yNoCqkw17SSSymw-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7da357c99ceso10613539f.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 19:52:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716432760; x=1717037560;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tWbBNmbHIEsZsY7vbmRzxEnY1vtC+xzevrdRnLUowJI=;
        b=gLacwOiJpD8nu/PzG4HcmfKCr5Zz7ZZu8sfpPprxoMsN3a2wGBJcHBDgh75QQP/3tT
         j1tnG3vOgysgi1hHjVVD/jLt9Ekk994peZuhg09jrNIlNbR6kSE8SDPUqx0D8LGyzUkW
         6uTvUYpAhvMv0mzDyXUbCxvMswk1rwZe5lOQplYirkaCl+V8wuEFrjY0F3Q9qYLZQLeX
         NjP86+0Z6GBvMAxdT3lLHCyS9PkeWAEg62jCR+QMTSHYf2CWZwvvBxVmVG5br9UaSdrG
         dT6+xaCTVpnyFBcuf18oWjUmZhY5CUVI7qJcqTUIGyLGhioHBneYrz9e6HLFkWn1rrkC
         AFAg==
X-Forwarded-Encrypted: i=1; AJvYcCUanhrjPMUDNPS8ORpnMGkG95mCjWBzMOHYPqLN8AdTbuT9V1qGXrZ9fvqUlI9GeHYnH6Ww0tyL0NeLY4euXpzu2rbokqeXalFHQP89
X-Gm-Message-State: AOJu0YwGtvmlAooAjvnW3Fo5Guz/BoVwIi1/IoWnAgxrmTpR8M3VDbA8
	hej9gJec6NxY0JreFr2yhZR+f50Mi3OM0JWjHWI3Ki8Jfk2AyVHMTjybFxaTKBUv/+HM8Uhj3/+
	nEb9J67MhPBdH8FKygrfV4uBxMbF4w7fjEhOxMMlL/CZa4fYVCjwVhyA/7RRRmLjnIxyJErWoPT
	+8DfqlFDjI8RXMVLc3dHeJNrfU8uE4odaVVHB5
X-Received: by 2002:a05:6e02:1d0b:b0:36d:96ab:f4a with SMTP id e9e14a558f8ab-371f91127a8mr41001615ab.1.1716432759661;
        Wed, 22 May 2024 19:52:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjWnA6P8KZV/hpIelf87UTT4AP4Sz9G392bSeVHP6Ygbkz3KcB7JJHmUA4y++lOXl2QJWJjqKtmtk6c5TqFrQ=
X-Received: by 2002:a05:6e02:1d0b:b0:36d:96ab:f4a with SMTP id
 e9e14a558f8ab-371f91127a8mr41001505ab.1.1716432759314; Wed, 22 May 2024
 19:52:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240520183633.1457687-1-steve.wahl@hpe.com>
In-Reply-To: <20240520183633.1457687-1-steve.wahl@hpe.com>
From: Dave Young <dyoung@redhat.com>
Date: Thu, 23 May 2024 10:52:59 +0800
Message-ID: <CALu+AoQGvHzkoRPvAwqaCCokOBsjQ7tDwMVwgyOMUqKm=tEkuQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] Resolve problems with kexec identity mapping
To: Steve Wahl <steve.wahl@hpe.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, 
	Pavin Joseph <me@pavinjoseph.com>, Eric Hagberg <ehagberg@gmail.com>, 
	Simon Horman <horms@verge.net.au>, Eric Biederman <ebiederm@xmission.com>, Sarah Brofeldt <srhb@dbc.dk>, 
	Russ Anderson <rja@hpe.com>, Dimitri Sivanich <sivanich@hpe.com>, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Yuntao Wang <ytcoode@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Joerg Roedel <jroedel@suse.de>, Michael Roth <michael.roth@amd.com>, Tao Liu <ltao@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Add Tao in the cc list.

On Tue, 21 May 2024 at 02:37, Steve Wahl <steve.wahl@hpe.com> wrote:
>
> Although there was a previous fix to avoid early kernel access to the
> EFI config table on Intel systems, the problem can still exist on AMD
> systems that support SEV (Secure Encrypted Virtualization).  The
> command line option "nogbpages" brings this bug to the surface.  And
> this is what caused the regression with my earlier patch that
> attempted to reduce the use of gbpages.  This patch series fixes that
> problem and restores my earlier patch.
>
> The following 2 commits caused the EFI config table, and the CC_BLOB
> entry in that table, to be accessed when enabling SEV at kernel
> startup.
>
>     commit ec1c66af3a30 ("x86/compressed/64: Detect/setup SEV/SME features
>                           earlier during boot")
>     commit c01fce9cef84 ("x86/compressed: Add SEV-SNP feature
>                           detection/setup")
>
> These accesses happen before the new kernel establishes its own
> identity map, and before establishing a routine to handle page faults.
> But the areas referenced are not explicitly added to the kexec
> identity map.
>
> This goes unnoticed when these areas happen to be placed close enough
> to others areas that are explicitly added to the identity map, but
> that is not always the case.
>
> Under certain conditions, for example Intel Atom processors that don't
> support 1GB pages, it was found that these areas don't end up mapped,
> and the SEV initialization code causes an unrecoverable page fault,
> and the kexec fails.
>
> Tau Liu had offered a patch to put the config table into the kexec
> identity map to avoid this problem:
>
> https://lore.kernel.org/all/20230601072043.24439-1-ltao@redhat.com/
>
> But the community chose instead to avoid referencing this memory on
> non-AMD systems where the problem was reported.
>
>     commit bee6cf1a80b5 ("x86/sev: Do not try to parse for the CC blob
>                           on non-AMD hardware")
>
> I later wanted to make a different change to kexec identity map
> creation, and had this patch accepted:
>
>     commit d794734c9bbf ("x86/mm/ident_map: Use gbpages only where full GB page should be mapped.")
>
> but it quickly needed to be reverted because of problems on AMD systems.
>
> The reported regression problems on AMD systems were due to the above
> mentioned references to the EFI config table.  In fact, on the same
> systems, the "nogbpages" command line option breaks kexec as well.
>
> So I resubmit Tau Liu's original patch that maps the EFI config
> table, add an additional patch by me that ensures that the CC blob is
> also mapped (if present), and also resubmit my earlier patch to use
> gpbages only when a full GB of space is requested to be mapped.
>
> I do not advocate for removing the earlier, non-AMD fix.  With kexec,
> two different kernel versions can be in play, and the earlier fix
> still covers non-AMD systems when the kexec'd-from kernel doesn't have
> these patches applied.
>
> All three of the people who reported regression with my earlier patch
> have retested with this patch series and found it to work where my
> single patch previously did not.  With current kernels, all fail to
> kexec when "nogbpages" is on the command line, but all succeed with
> "nogbpages" after the series is applied.
>
> Tao Liu (1):
>   x86/kexec: Add EFI config table identity mapping for kexec kernel
>
> Steve Wahl (2):
>   x86/kexec: Add EFI Confidential Computing blob to kexec identity
>     mapping.
>   x86/mm/ident_map: Use gbpages only where full GB page should be
>     mapped.
>
>  arch/x86/kernel/machine_kexec_64.c | 82 ++++++++++++++++++++++++++++--
>  arch/x86/mm/ident_map.c            | 23 +++++++--
>  2 files changed, 95 insertions(+), 10 deletions(-)
>
> --
> 2.26.2
>


