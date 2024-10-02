Return-Path: <linux-kernel+bounces-348119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8975A98E2C0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 20:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2896B23DDF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 18:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58CE2141BD;
	Wed,  2 Oct 2024 18:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1t5pTMFb"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AB81D174C
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 18:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727894656; cv=none; b=C+fqgJGnMGYOJu4GkHlxFb1NyzMTW73LVyJX2aR+CTS+LFPZEUgajrJVK0ly952rENWf3bgpjRxfGg26lJ2aGsiO5eIn2hjvnKwFq5jDjo+9VyGrGtWti0M3cPbiNRy+UVK4PbgkbEecryA26muiRgXvbVLLbAA8JuHeIV6QQX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727894656; c=relaxed/simple;
	bh=iJBzvn/cj/JRuaVnnHh9DDHoNTwL/SAzdLlHVGlLAm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AHu5TvfiGXy4V8RCRLTe+9AzGzZoRkT0Evm4563tSBzUAewuFOWyqdFfauznfnOXU/+NHU+0GHt0xMBzqWm6RamTzl8tzS9kz+QK/86C1q4iRm3gu9u5/8gHaAG/J0+XyeCGwXcigGU5M7CkNWgDzqJeoX7YeoT6cCpg1QVWca8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1t5pTMFb; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c896b9b4e0so35468a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 11:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727894653; x=1728499453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZE2Ce/T+Mvy1H3tSTUGCLB3DqdOmW8uu6V5jQSIQoeI=;
        b=1t5pTMFbbZHpwM5yHFSy2WvuHbtkt9FtnifjbQ0BEDjRDoMg2ncGr4EJLaiBClCmJQ
         XW/Olb+W/Mlm5316HZ+EHrJq7RV2xR2/gu+Sqi0w0FCWVwgzaKpIzHNRy7Dcn8tge3MS
         fRSeQ26QMpJz4WonSCKU/nnt8pdoBtn9HQChJloLiPIcHU6iFBLprQkGX4g+SMAjYWYE
         Vpm1x1UA3vUjcxpgAYZxqsl41e+0X+JrY0ErJrPr6R2yMdAtGyq0BiLWhtdwdetgRTe3
         BBtrSy10ri2+TjK85SUceS5o717+i/31vce78L8efhpiHGG4738TK4V/Ynes2OV4V6TL
         b+Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727894653; x=1728499453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZE2Ce/T+Mvy1H3tSTUGCLB3DqdOmW8uu6V5jQSIQoeI=;
        b=BfduDp9bwLzwAfsjp/l4fljqfX5nVebvoIDVzRkYMz9xrJMveY9iEUwrlehjWzsKUV
         UqBQg2rL2QBOKQ+3lS9ApbqvvhgOGLVE5W4+twxqASociRq6CVnpUILglb6V4GgxsP0O
         igteD8h/Cm3t89x0KRGcIbAfshwXdm/MGeIHw2Uu1eMGsbpORgWpFxXXOSg+8B6Q/0ic
         6Gd3X3xXufv7KHaar/cLBtgBeJCn+pYEleEjdHmmfbY3T1Beihw1MelXvN0UeB99S4G5
         69pSNqN/6T3KsZ4K9cFMb8q1wSSNe5e0VBnzwZZA5kFVF2svrpgNFYjKmDVB2Wm3AqZC
         q59A==
X-Forwarded-Encrypted: i=1; AJvYcCWMCak2oJJwdCpgj289etpTLqBjAgDelaHmx30QzTqxQzjd8wu8SBXsQueY+SjdOgllCWQ6/xy8m/uNC5E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3xw0clBpIovegdZgZlo1X3iQpzMxIOvz5C6Yt9D7+p8mLVIVH
	4WcwFPxRhMRcZb1DGJEGUwmkESV+QzeIS5peD348R0IgoxOyRtMlg5Na0h2KY6KY2hcZQO6J2pH
	W5GG0qHV3lIQ5rhp4OZwB0EyjlQhAdws/6G8SEhdH7NoNlwTeog==
X-Google-Smtp-Source: AGHT+IEil/s7p+VRY6t+0zcsrwiNDY//TmdLrQJ3cdUC1G29saH9zpEzRGC2WIzFjCvXcKvMUeQ2DtMotmphT//t2nY=
X-Received: by 2002:a17:907:25cb:b0:a8d:2e3a:5303 with SMTP id
 a640c23a62f3a-a98f8295ed5mr418895066b.39.1727894652491; Wed, 02 Oct 2024
 11:44:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202410021530.DnNbPqfN-lkp@intel.com> <CAKEwX=Ma9usQBge8uKvin=+GsuRDgJrDYTthzLg7zhtbLMPc8w@mail.gmail.com>
In-Reply-To: <CAKEwX=Ma9usQBge8uKvin=+GsuRDgJrDYTthzLg7zhtbLMPc8w@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 2 Oct 2024 11:43:35 -0700
Message-ID: <CAJD7tkYoL-V+tEHSDQ2uCdSTeEL-TfJDnok9gGR-d_MW42F2cw@mail.gmail.com>
Subject: Re: mm/zswap.c:744:52: error: 'struct zswap_lruvec_state' has no
 member named 'nr_disk_swapins'
To: Nhat Pham <nphamcs@gmail.com>
Cc: kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Linux Memory Management List <linux-mm@kvack.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 11:13=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> On Wed, Oct 2, 2024 at 1:01=E2=80=AFAM kernel test robot <lkp@intel.com> =
wrote:
> >
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git master
> > head:   e32cde8d2bd7d251a8f9b434143977ddf13dcec6
> > commit: e31c38e037621c445bb4393fd77e0a76e6e0899a zswap: implement a sec=
ond chance algorithm for dynamic zswap shrinker
> > date:   4 weeks ago
> > config: x86_64-randconfig-r133-20240215 (https://download.01.org/0day-c=
i/archive/20241002/202410021530.DnNbPqfN-lkp@intel.com/config)
> > compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> > reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/arc=
hive/20241002/202410021530.DnNbPqfN-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new ve=
rsion of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202410021530.DnNbPqfN-l=
kp@intel.com/
> >
>
> I'm stumped...I downloaded this config file, and used the same
> reproducer build commands, and it built successfully for me :(

There seems to be tons of existing build problems with zswap.h and
zswap.c, I am not sure what's going on.

>
> Fellow zswappers, anyone managed to reproduce this? Or is this a false
> positive...

No luck here.

