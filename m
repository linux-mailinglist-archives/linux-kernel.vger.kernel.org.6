Return-Path: <linux-kernel+bounces-301826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3DA295F628
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 18:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A0451F24091
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 16:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64C719412F;
	Mon, 26 Aug 2024 16:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kDs0btL/"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC5118660E
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 16:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724688696; cv=none; b=Iog7mX/geNRqrB25D6LJeKHk1cmrFtP5riy2apSvv/f9kvd1mQuSpJ2ofqAswYPZUyDGNoMBtlkEaBSbIJxL5OpA1JsAni98pdbTXuEMjIoZhuGV2HWScwczmJ3j2sw7HRxYzdxDzkaqFLf+2QPcOCtFnzbclGFcbyj4Dpc4jhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724688696; c=relaxed/simple;
	bh=NGmownRSppN0A/GmRDT2VUSA4PxsfoDYAEdViXmYkC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k0muldWFySlbQ4JhoIJTI6GgF5JRh5p/TEdbvg1wxgV9/fkB/XQ+FugDaeOJBuEATjR/SuleWDVXCpKC0gmfGCZuE48AlqdsxCI1XAVu7sw6Tr7V7FO+yXQxR3S0qvUl2miJ05RfNBWUkYfWZRQqCpkgqh/w5N+vdQ1fYQMbfVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kDs0btL/; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71431524f3aso3583656b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 09:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724688694; x=1725293494; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t/wGVcsUhIFU2CQ12xc12lmWd0UdLGjy9SUN1w8YBrk=;
        b=kDs0btL/I0O376IgRsyRgBT8swmvjmwhbQ867m+hfrbhh8pdg5s/rjMwts+nTVdJJz
         Lb9Bv5Hx7GJ9m26hzAENKBrhLjjwi4768Z5AMjWNQRqhP5pip4V0JCbHf+OEcsCeP2l3
         uhKFnGpKEQql6xq5ZuE2rtIDc6tPwwMEK4GV4ZPe/MeBbAZlHnsilSitOabzGBTxrTry
         G/HNh3WOa8VnUrK5kZA3fNEDnjLXQ8k5Wu7A/agv5hCL5oypRwni/7C8xERyHGuAomWR
         a8+++5MqJJE088SGmaeriC7bYvEHGGe7g4uCQUNrUfyNloDNQWZVEd1yYHrkaIwQ7qn6
         QoZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724688694; x=1725293494;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t/wGVcsUhIFU2CQ12xc12lmWd0UdLGjy9SUN1w8YBrk=;
        b=DyBjyPGHdvbfsu5+awKxSsKczTmxiaeGxkWl1xqLSq68xL+WSWhggkdNpljRfiYxt9
         4biuiUpvnQslc973jt3NMBF6OwvqQDG6ONZoAy7h2EzQI4YWVQGYNatObktGP3pgt5Ra
         QkWE2vagvYDnLqNNzvjUXzIYY6YftR+NkHnBgbeJrHHApSkJQ5chPVzK8t5YrERAlDfb
         vYFS3Ls/FGvjtLgNgG8wec/Pcvhy1uTmnzTSqWgFLFW8jPbTcITPcr7DeQEsYKfr2uGO
         Nv1ZP6YeVOy2sS5VPBVJClG3qbQ1bfoSHU2lL0Pfka91N+biL2SAobM0yUiHVWBjjoFQ
         HFVA==
X-Gm-Message-State: AOJu0YwU8MUNLf/AVaQbJ8UyxEcCJXZ+fXWvrHVNWDJjMmC+w3l18mKd
	6yxS+cNT/6KWeAGp7Fa5SwVJ33qohDZPIgxTmWS7RW0tpmlIKbmJ5rb1ug==
X-Google-Smtp-Source: AGHT+IHrD+ODgcZfC/ydmfYL7WuXm/CCiXrK6QM4Yrm6bkCQTqn1JqZaTiKtd+a8HDVWU/BeQJDzTA==
X-Received: by 2002:a05:6a21:3946:b0:1c4:2151:7276 with SMTP id adf61e73a8af0-1cc89d199a1mr13732771637.10.1724688693657;
        Mon, 26 Aug 2024 09:11:33 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9ac99d0csm6632383a12.12.2024.08.26.09.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 09:11:32 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 26 Aug 2024 09:11:31 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 6.11-rc5
Message-ID: <b2214bff-aeae-44f9-9b14-4ddaec1456bc@roeck-us.net>
References: <CAHk-=wh599movdAyCHfVmYakq8rqKQD9wCvUAgBqbF3znEu_2g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh599movdAyCHfVmYakq8rqKQD9wCvUAgBqbF3znEu_2g@mail.gmail.com>

On Sun, Aug 25, 2024 at 07:27:16PM +1200, Linus Torvalds wrote:
> So I normally do the releases on a Sunday early afternoon, but I'm in
> an unusual timezone, and that would have been almost a full day
> earlier than usual. So I delayed things to the point where it was at
> least Sunday back home, even if not even remotely afternoon.
> 
> Other than the timing, there's not a whole lot unusual here. The
> diffstat looks fairly flat, which means "mostly pretty small changes".
> There's a couple of bumps here and there, but nothing worrisome: the
> biggest of them is in fact just a selftest update. The bulk of the
> (non-selftest) patches are in drivers (networking and gpu dominating -
> as is tradition), with some filesystem updates (bcachefs, but also smb
> and erofs), and the rest being mostly core networking and some
> architecture updates.
> 
> For details, see the appended shortlog, or just go dig even deeper in
> the git tree itself.
> 
> So please do go forth and test, it all looks safe,
> 

Summary: No change since last week.

Build results:
	total: 158 pass: 158 fail: 0
Qemu test results:
	total: 543 pass: 534 fail: 9
Failed tests:
	microblaze:petalogix-s3adsp1800:initrd
	microblaze:petalogix-s3adsp1800:rootfs
	microblaze:petalogix-ml605:initrd
	microblaze:petalogix-ml605:rootfs
	microblazeel:petalogix-s3adsp1800:initrd
	microblazeel:petalogix-s3adsp1800:rootfs
	microblazeel:petalogix-ml605:initrd
	microblazeel:petalogix-ml605:rootfs
	mips:malta:malta_defconfig:nocd:nosmp:net=e1000:initrd
Unit test results:
	pass: 376564 fail: 1330

The known problems (including the unit test failures) are all fixed by

98c0cc48e27e apparmor: fix policy_unpack_test on big endian systems
5a4c785905fd Revert "MIPS: csrc-r4k: Apply verification clocksource flags"
0075df288dd8 microblaze: don't treat zero reserved memory regions as error

For those interested in details, SHAs are from my 'fixes' branch at
git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git.
That branch is rebased on top of mainline on a regular basis, so please
don't expect the SHAs to persist for more than a day or two.

Guenter

