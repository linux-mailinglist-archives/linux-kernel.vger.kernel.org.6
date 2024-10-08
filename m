Return-Path: <linux-kernel+bounces-354392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A09993CF3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 04:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB89B1F25E50
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 02:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C78E1F60A;
	Tue,  8 Oct 2024 02:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFfpv/Ma"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CADD184D
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 02:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728354916; cv=none; b=UyldYbqrpK0faSSrapMc9urowPjlagU0aXqnX8PBNZ7YLIpG8mTQXhDYHT49gg1xqzlI27cIe7GOxdzQ3ngLWt3e4anxlyo8fgF5n4wJewcnUuW92OgOUOBDemPirrHyK7xpRHCQnnHaMngOYDWv4XXzft0ku3syt3MtyH4LUI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728354916; c=relaxed/simple;
	bh=C/W3IWDD87ZTgEdJdyokhTKbCHO3oRTnOxRDfwyVUhY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KSoUcJOdxTmeoJAEa0s8AP2gkVZAvFffb5EVk4eW5XgBOpcIiC61oBGU/fvywAjZKlw+ayO2kB+1tCFSinyLeuokcNgNSXcqwL3YA6ZCY9qfrDT+VyJmj4q5U048GLz3A4Hzru/Imlb6UrWypQ6nkj9GxW4YBK6c0bVdDNKCstM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CFfpv/Ma; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7e9f8d67df9so1784377a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 19:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728354915; x=1728959715; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uaHHyDTZ0d5NaZSkzM6y1pMwvv24VCw6oN9ExhsOJRk=;
        b=CFfpv/MaPbj+UMJU7bEh01kdVjQiftJwHOmmkTulOVUVPLY9i2qjQrWH/+I0vFlNfl
         DD/sooCSgfjA5XbiaFtHx/UoXGyNPceaD8jlBFMLENBAUhjfP0p5jDm+prjIHsH5LnHy
         0lC3nxob/gbYUpzE18WyawqM64A/iklozP1hlba0dQ+hohsVR3JFLNXfmzshQOGmddaF
         nnnfcATpFMXPpxf2wgt9csusqPUrxSi7CzzIXGHROVogg3qDgy7hylwuvyPcTdDuJN4R
         240tolQWUSswjMw25paBQkFDgSYGiHgGWFMRkpyfbD/EV6/z1WAdAEgVA5TRVZmFO2jw
         Dwxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728354915; x=1728959715;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uaHHyDTZ0d5NaZSkzM6y1pMwvv24VCw6oN9ExhsOJRk=;
        b=pEuKN43Y4BbfB2XWH/QjSy2XyyO3AwLB62etuOn5+BBhbdlK+/7nJlEksurndFGuPt
         WE9iS+Xz2FWigOtNawyc+YuK/99odNWPwbJEJWMLL3K+uqlS2lirnbefjfhTjFudQqkn
         mjQt1wVRyOpVCPsdjvO+qpf4K/FUYL5LJF38/AHRARx++ZvxxNjm0XHqViwvxmaB3QdF
         E1+T4rE9/pA5/kkWRpZOdwJDBLQdssUlwutEoZkJka11Rs/NyhWMYt7JKpQLwqYbApIg
         HBz1l/q9/qHmp7TV5GwJbVx2riwyOWzSxHsT7UvXRJAiAWPHurBAwfA7IN6HR/uBe2HY
         26Hw==
X-Forwarded-Encrypted: i=1; AJvYcCVHevjrpLZo4ydJcX6Pwh+ydiBdPV5c9ieJReEWCVyPhJ9qjWS1QYlqLQa8IBYQhtRRM3m8o4kNuJe8Ae8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtRl4GL8IzT6bmD9NjlNUHbsLIBl3TxTE3tXQTUeFxmsEtJfCB
	d3HT4FtxeqzJ/aEGf1TCVwQTTm4k1vgfRdiX9uqvRSbKNbr7BakG8ApTjF1ivDGPErbDlCJ8a9x
	x+8Az8DB5wlaeVKxawspxxBPPH/s=
X-Google-Smtp-Source: AGHT+IHYfukP36V0z2gYLJ/HbclCrt+viHg8RbDpyTrHSLRtEnGGEoCgvDAnqCHfZt3TprR9DvFLF75m59yFen0wrTc=
X-Received: by 2002:a17:90a:640b:b0:2dd:5e86:8c2f with SMTP id
 98e67ed59e1d1-2e1e626c37emr15952226a91.21.1728354914800; Mon, 07 Oct 2024
 19:35:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004142504.4379-1-aha310510@gmail.com> <202410071223.t0yF8vP8-lkp@intel.com>
 <20241007183052.9d87f42e19db5f9777dc8e77@linux-foundation.org>
In-Reply-To: <20241007183052.9d87f42e19db5f9777dc8e77@linux-foundation.org>
From: Jeongjun Park <aha310510@gmail.com>
Date: Tue, 8 Oct 2024 11:35:03 +0900
Message-ID: <CAO9qdTHUW+SRkLsxdO_PXKw7qGvXKCWfa1GtVYNrnyGWEUe0Mw@mail.gmail.com>
Subject: Re: [PATCH] mm: swap: prevent possible data-race in __try_to_reclaim_swap
To: Andrew Morton <akpm@linux-foundation.org>
Cc: kernel test robot <lkp@intel.com>, llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, 
	kasong@tencent.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	syzbot+fa43f1b63e3aa6f66329@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Mon, 7 Oct 2024 13:06:49 +0800 kernel test robot <lkp@intel.com> wrote:
>
> > Hi Jeongjun,
> >
> > kernel test robot noticed the following build warnings:
> >
> > [auto build test WARNING on akpm-mm/mm-everything]
> >
> > url:    https://github.com/intel-lab-lkp/linux/commits/Jeongjun-Park/mm-swap-prevent-possible-data-race-in-__try_to_reclaim_swap/20241004-222733
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> > patch link:    https://lore.kernel.org/r/20241004142504.4379-1-aha310510%40gmail.com
> > patch subject: [PATCH] mm: swap: prevent possible data-race in __try_to_reclaim_swap
> > config: x86_64-kexec (https://download.01.org/0day-ci/archive/20241007/202410071223.t0yF8vP8-lkp@intel.com/config)
> > compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241007/202410071223.t0yF8vP8-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202410071223.t0yF8vP8-lkp@intel.com/
> >
> > All warnings (new ones prefixed by >>):
> >
> > >> mm/swapfile.c:203:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
> >      203 |         if (!folio_trylock(folio))
> >          |             ^~~~~~~~~~~~~~~~~~~~~
> >    mm/swapfile.c:254:9: note: uninitialized use occurs here
> >      254 |         return ret;
>
> This warning can't be correct?

I think it's correct. Even if folio_trylock fails, the return value
should be -nr_pages. Not initializing ret like in the v1 patch
goes against the design purpose of the function.

So I think it's right to apply the v2 patch that I sent you.

Regards,
Jeongjun Park

