Return-Path: <linux-kernel+bounces-286926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EC9952081
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 18:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 465091C23752
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D091BA898;
	Wed, 14 Aug 2024 16:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJSzaOgZ"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245831B8EBA
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 16:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723654389; cv=none; b=e9Nrnk8y/VSuD8l5D1Iac6aLs9TVH9JXNcxNPZf/qOdBQspswmXgs+tsUMswkeC59QnyWHTGaavsAUoGLUjjoipOA3cmpiEWJ6/KIRE240U2xmbKOtbhDEClLgzFoE4kzNWipUCXWALqM9UuTeVQbX8OWejeToGJP9KAZuWzK3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723654389; c=relaxed/simple;
	bh=GT7CKvMczimC87FBJLISQL8kxlblQiRP+geGM33K0m0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pup9NBQOnZWTjSkeq4ynMwBBX+CHQTUKWSNntdPd+tJivlhgRggJyUEE7QCJS2IlIiifFk9AXW3F0CVuw6VxxeSGsAhm5/LGLU5jYyPFOIrRSTnhMNZlZtcphv2+TTKrhdoqgfyEUUqjO/5d7u8xCkdFUcdRtS8m09lyG6m1URI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UJSzaOgZ; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-710dc3015bfso29264b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 09:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723654387; x=1724259187; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BwwO5wVW1prWGaQkBuXOVaSfD3RuMaDWY0MKew4Ns6E=;
        b=UJSzaOgZCDQmdxiQKld5jdzakfBGgBM0IVq9TDsObnYMXa5QZakFs3Nebf8g4DUj21
         2O+FSeaMjJrRFvhtPbPiSCxZiza7/MqVC6TU2+bSXRkN1y7ASJV40znyUk+nJoqK16YM
         MOLGXMeCX6APZAq65ghhb+ezdnZEWHHbatuju/oKJQuYMsah7/eACo/AaxQvRcNQfBtl
         WEDePAhPo6Ae2nG4sGcAUn3mQu80oG+vgDvY3YXCId9s5oVO0iOghSsPUgc5DzLHSSYC
         hsyK25tE4ugn2Iuc7yakOJOem+7NrKuq66RI7cyxP5sCo6HHA6N2MVSWzTgN8Ez6XGvZ
         uiUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723654387; x=1724259187;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BwwO5wVW1prWGaQkBuXOVaSfD3RuMaDWY0MKew4Ns6E=;
        b=fj+vUG75Y7aiPy+S5Ou9ZIytA09MLL9MYVWR7UyYlfkzDPUuTzvEULKcSBdMwxyWZT
         ZOMdQI++r6At6jPFxW8E0Q2twWjWMmCSafCnH9TsQbUKtVFXbGCVEninzriVuocXsCN0
         PxtV++XxTQmnKUhtpkiws1mDmRKsLdKBVB68tz9kexzUkczwUbuGhLvCUUiiOgPDt2uB
         u/+fF3k7J9WFC3It5OraNO6MVLS5JRAi7VPU6CC0kVlAZDhtpZ9PFtMdDNlKIec7m44W
         7wTCcDOkvbGDd7Y7Y/4/BEl8GtVZLIOSZ2S/14VJMtDAv+Lc5mDbum1O6gF3KAqK/8vE
         f0ZA==
X-Forwarded-Encrypted: i=1; AJvYcCUxrb145yN4+BMbJdvmtTy00bOsSg0MZ2UCIschXm/Q5EM6ULcs/iSCoW37ACiiudDl3EenHys3Df4oeUwqEnyEJGaubw8vLRMq3CYs
X-Gm-Message-State: AOJu0YztUgGtYXzgI0/t9oAp5Fp06fnkX/d2Tc8qP4ma5lfbl3lWSkiw
	CXOWj1z5EY1z5gvtU70342aDoXfB+ZEF95N7QYkbOm6fJlAvjenW
X-Google-Smtp-Source: AGHT+IHmxEpbEQ/93LkX5r5SnT/1IryLya5f4uLO9hw8U1CmUX5OKAYC+a6oGI0yGdIREiHgnre9Pw==
X-Received: by 2002:aa7:888b:0:b0:704:151d:dcce with SMTP id d2e1a72fcca58-71276ef3201mr335463b3a.5.1723654387308;
        Wed, 14 Aug 2024 09:53:07 -0700 (PDT)
Received: from localhost ([216.228.127.128])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e58a0b52sm7548899b3a.55.2024.08.14.09.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 09:53:06 -0700 (PDT)
Date: Wed, 14 Aug 2024 09:53:04 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: kernel test robot <lkp@intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Herve Codina <herve.codina@bootlin.com>,
	Brian Norris <briannorris@chromium.org>
Subject: Re: WARNING: modpost: vmlinux: section mismatch in reference:
 bitmap_gather+0x68 (section: .text) -> sg_mask (section: .init.rodata)
Message-ID: <Zrzg8Mc9OcFx699j@yury-ThinkPad>
References: <202406200829.IytwLyQJ-lkp@intel.com>
 <ZrzcAnHNXDF2Ck6K@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrzcAnHNXDF2Ck6K@smile.fi.intel.com>

On Wed, Aug 14, 2024 at 07:32:02PM +0300, Andy Shevchenko wrote:
> +Cc: Clang and bitmap people.
> 
> On Thu, Jun 20, 2024 at 08:54:29AM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   e5b3efbe1ab1793bb49ae07d56d0973267e65112
> > commit: de5f84338970815b9fdd3497a975fb572d11e0b5 lib/bitmap: Introduce bitmap_scatter() and bitmap_gather() helpers
> > date:   3 months ago
> > config: um-randconfig-r123-20240620 (https://download.01.org/0day-ci/archive/20240620/202406200829.IytwLyQJ-lkp@intel.com/config)
> > compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 78ee473784e5ef6f0b19ce4cb111fb6e4d23c6b2)
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240620/202406200829.IytwLyQJ-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202406200829.IytwLyQJ-lkp@intel.com/
> > 
> > All warnings (new ones prefixed by >>, old ones prefixed by <<):
> > 
> > WARNING: modpost: missing MODULE_DESCRIPTION() in vmlinux.o
> > >> WARNING: modpost: vmlinux: section mismatch in reference: bitmap_gather+0x68 (section: .text) -> sg_mask (section: .init.rodata)
> > WARNING: modpost: vmlinux: section mismatch in reference: bitmap_gather+0x10b (section: .text) -> sg_mask (section: .init.rodata)
> > >> WARNING: modpost: vmlinux: section mismatch in reference: bitmap_scatter+0x68 (section: .text) -> sg_mask (section: .init.rodata)
> > WARNING: modpost: vmlinux: section mismatch in reference: bitmap_scatter+0x119 (section: .text) -> sg_mask (section: .init.rodata)
> 
> I have no other idea that this is a (yet another) clang compiler bug related to
> the constant data.

Hi Andy!

+ Brian Norris <briannorris@chromium.org>

I've been reported with a very similar warning from Clang 18, and the
fix is already in bitmap-for-next:

https://lore.kernel.org/lkml/Zq4uvqU3yg7bJ1Lk@yury-ThinkPad/T/#ma7a4c476f97fec16e228018b36137fdc0b2ffa4a

Compilers may not understand that small_const_nbits() is a
compile-time only condition.  This is especially true if
an instrumentation like GCOV is enabled.

Check this comment from Nathan for more details:

https://lore.kernel.org/lkml/ZoxCMp_ZQ-Su-r0D@google.com/T/#ma36706e8f5f06451dd0f490fc3b3ccbac15067f4

Thanks,
Yury

