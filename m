Return-Path: <linux-kernel+bounces-275680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BFA948850
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 06:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B03CD28584F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 04:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0141BA87B;
	Tue,  6 Aug 2024 04:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PAVEdh+X"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C2864A8F
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 04:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722918085; cv=none; b=rG/iTKEKcMil16EeNqfO5qbPX5ihI3GAy5zOUR+mNKil9fNrlBN9DsnbXFzkSiYqBcKLfcOBn+D5OdWW1cnfqC4SdLEaEC4klObLd8hGbDMIQW0Hw3nY4YRB6uoZJl2X8NydjItZmx9N+SGXJCTAasUFc/QpQvJm4veGL2FgNmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722918085; c=relaxed/simple;
	bh=o1eqt+OVrvUWTqAntF2W1U3ZrkozspLKs0sTN9xrhBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jgfZC66ghdb1Wi0tEagACVhwaEWHucbHttLplOayBiU7zndN8OklxLmoPtd4hAfP7eFSCyMzmU3Un7WkMYulEfu6tILJBSgbkvmGEEbENrW7C/eqw59T5ESyJRHVKcmJbsohA23qeM4WP1z+tKN1FlbXXApZUHZLD/NRMxIVxsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PAVEdh+X; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70d2d7e692eso150137b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 21:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722918083; x=1723522883; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j3Ry5XzHK6hadkPH1Nocla7p6wfaq6jwKqbf9AM3MC4=;
        b=PAVEdh+XWgM+At93JlJGKxkL+u/1EpwtziXH7NK9WYVMM4ke2C0zmucfq0AdIQAc2v
         DU3LOEsiHhOp2XVM5+dpdcw01Wsw7EoqDBzJxEdqoxgtUAoPhZeYbcDCR5U9qEWJqoam
         M5HRV67SYMnv3Lo3pLCMEdVD+eLcPzUGselCaMBoQTVE5zYlKjh2TbFYn+Wh/CFGz0tL
         sTY1HRR44zmMBc9Z8rq9rGRNzXKHrqOsPLHsy7X5le64M/v2Csy7N3hEHksx6+G732QL
         8yNAwSE19YtKYYmec28U9Udvh6JX8bXzedU2D5vWHNTnayPFVYW5AYoRtoXWVhRBKIwi
         cDSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722918083; x=1723522883;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j3Ry5XzHK6hadkPH1Nocla7p6wfaq6jwKqbf9AM3MC4=;
        b=QXW1iybLn+SgbNQpS6TmeTi+ZELPyD7T3Do/pUUQoGpeyfqIVcfLZLX1kkHdIAg/9h
         589jwfMEJhg4MXsVglNdWULnj22c92c3McTk9cGInF+ZQFoc1p3XOEBtQU2gJZztavQB
         lIra8ACPxefUNnGwpPGJ7Kon6y5s+iBo9p0NvD2fdKRcufcKJUON/v6vWZjqdgc2SvEf
         YbclssDQ0OAYfF/la4X5pQp7+LpcgxBacnRwSpGVzRpshkgDpu7m1oIvPhXSyMlMUDfJ
         DDqgjKikDnDIIf7O3mr5vzKVcC7Lf9hiYUZ3m5GHm3A8yhXbSiMCdEhbZI81ML3h+qHs
         RmgQ==
X-Gm-Message-State: AOJu0YzY+I0Elnn5EeKVFKr9NfRHwuu9fSRL4dK57B4oqCgMdXG6PlfZ
	a1zFl7MMx5FprLE1Qbxxc+YHD3km31U/jNP6BNd2Rdnt+SWYBvE0koXHRw==
X-Google-Smtp-Source: AGHT+IHReBL0FNivgM55/2t2zHwjwCrbvGYikK6SuepIQfGSASupagJZYokSGOjRy9wUOoYXmw64GA==
X-Received: by 2002:a05:6a00:4b4f:b0:70e:8f75:35b2 with SMTP id d2e1a72fcca58-7106cfa6ddbmr13112526b3a.12.1722918082416;
        Mon, 05 Aug 2024 21:21:22 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ed1573esm6147983b3a.159.2024.08.05.21.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 21:21:21 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 5 Aug 2024 21:21:20 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: Linux 6.11-rc2
Message-ID: <314ee964-fe3f-4b4a-b83f-76ed6e6e16dd@roeck-us.net>
References: <CAHk-=wh01xPAWUT_=J1TehFOu3SST12UTNuB=QQTeRw+1N4pDQ@mail.gmail.com>
 <378f3810-8b3f-416f-90ec-c81bb3f29123@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <378f3810-8b3f-416f-90ec-c81bb3f29123@roeck-us.net>

On Mon, Aug 05, 2024 at 09:00:04AM -0700, Guenter Roeck wrote:
> On Sun, Aug 04, 2024 at 02:00:57PM -0700, Linus Torvalds wrote:
> > So rc1 had a fair number of annoying small build or test failures on
> > Guenter's test matrix, which never looks good. But most of them seemed
> > to be of the "stupid and trivial" variety, which obviously doesn't
> > instill confidence in the process, but also isn't exactly scary. When
> > the microblaze tinyconfig doesn't build cleanly, it may not be a great
> > look, but it's also probably not a showstopper for actual use.
> > 
> > Hopefully we've gotten rid of the bulk of the silly noise here in rc2,
> > and not added too much new noise, so that we can get on with the
> > process of finding more meaningful issues.
> > 
> 
> Build results:
> 	total: 158 pass: 158 fail: 0
> Qemu test results:
> 	total: 539 pass: 516 fail: 23
> Failed tests:
...
> 	mips64:malta:malta_defconfig:nocd:smp:net=e1000-82544gc:ide:ext2
...
> The mips64 test failure is a networking interface failure. It started
> happening a week or two ago. The problem is spurious and thus difficult
> to bisect.
> 

I managed to bisect this. Bisect results below. I didn't try to understand
what is going on, but reverting the offending patch fixes the problem.
It is seen with all variants of e1000 controllers.

Guenter

---
# bad: [de9c2c66ad8e787abec7c9d7eff4f8c3cdd28aed] Linux 6.11-rc2
# good: [0c3836482481200ead7b416ca80c68a29cfdaabd] Linux 6.10
git bisect start 'HEAD' 'v6.10'
# good: [280e36f0d5b997173d014c07484c03a7f7750668] nsfs: use cleanup guard
git bisect good 280e36f0d5b997173d014c07484c03a7f7750668
# good: [a4f9285520584977127946a22eab2adfbc87d1bf] Merge tag 'clk-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux
git bisect good a4f9285520584977127946a22eab2adfbc87d1bf
# bad: [8e313211f7d46d42b6aa7601b972fe89dcc4a076] Merge tag 'pinctrl-v6.11-1' of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl
git bisect bad 8e313211f7d46d42b6aa7601b972fe89dcc4a076
# good: [acc5965b9ff8a1889f5b51466562896d59c6e1b9] Merge tag 'char-misc-6.11-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc
git bisect good acc5965b9ff8a1889f5b51466562896d59c6e1b9
# bad: [d2be38b9a5514dbc7dc0c96a2a7f619fcddce00d] Merge tag 'mips_6.11' of git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux
git bisect bad d2be38b9a5514dbc7dc0c96a2a7f619fcddce00d
# good: [45659274e60864f9acabba844468e405362bdc8c] Merge branch 'pci/misc'
git bisect good 45659274e60864f9acabba844468e405362bdc8c
# good: [8e5c0abfa02d85b9cd2419567ad2d73ed8fe4b74] Merge tag 'input-for-v6.11-rc0' of git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input
git bisect good 8e5c0abfa02d85b9cd2419567ad2d73ed8fe4b74
# good: [3c3ff7be9729959699eb6cbc7fd7303566d74069] Merge tag 'powerpc-6.11-1' of git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux
git bisect good 3c3ff7be9729959699eb6cbc7fd7303566d74069
# good: [3de96d810ffd712b7ad2bd764c1390fac2436551] dt-bindings: mips: brcm: Document brcm,bmips-cbr-reg property
git bisect good 3de96d810ffd712b7ad2bd764c1390fac2436551
# bad: [9c7a86c935074525f24cc20e78a7d5150e4600e3] MIPS: lantiq: improve USB initialization
git bisect bad 9c7a86c935074525f24cc20e78a7d5150e4600e3
# bad: [580724fce27f2b71b3e4d58bbe6d83b671929b33] MIPS: sync-r4k: Rework based on x86 tsc_sync
git bisect bad 580724fce27f2b71b3e4d58bbe6d83b671929b33
# good: [c171186c177970d3ec22dd814f2693f1f7fc1e7d] MIPS: csrc-r4k: Refine rating computation
git bisect good c171186c177970d3ec22dd814f2693f1f7fc1e7d
# bad: [426fa8e4fe7bb914b5977cbce453a9926bf5b2e6] MIPS: csrc-r4k: Select HAVE_UNSTABLE_SCHED_CLOCK if SMP && 64BIT
git bisect bad 426fa8e4fe7bb914b5977cbce453a9926bf5b2e6
# bad: [7190401fc56fb5f02ee3d04476778ab000bbaf32] MIPS: csrc-r4k: Apply verification clocksource flags
git bisect bad 7190401fc56fb5f02ee3d04476778ab000bbaf32
# first bad commit: [7190401fc56fb5f02ee3d04476778ab000bbaf32] MIPS: csrc-r4k: Apply verification clocksource flags

