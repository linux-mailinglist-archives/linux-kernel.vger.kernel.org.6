Return-Path: <linux-kernel+bounces-257778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A77A937ED8
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 05:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C50111C2128A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 03:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4171BA29;
	Sat, 20 Jul 2024 03:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FypLg8ez"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F48372
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 03:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721446919; cv=none; b=bHTIQAj2kkbI9TA1JGrA6lohLi7/w034oR1WFciMZVtSkyZySr+LBykwLgFpWfsM2q2v8kdzzL0oiLtkIv7TutzUi3CzWHOxor09AWa9o0nQ/KrQDtm6cQRDqRmmm7b5Usb/f0GIS1Z/NTxoPoC+84sdYnaurxcqqyADwLU65Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721446919; c=relaxed/simple;
	bh=c+IDvkezVP4bl/CQyLxM0sQAlZG3MoahgJFUM00006Q=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=E2RsFqZit8KlnnujKooAfabyAcCVL9YfGI+RyfjyQHlZD2Srr2/M3lwKgvwjvng5CGEOP11DvABbNCnR5C38TZHJbRA6Q05ropnf+xY9THyWIT7brPu9uy8omw6DAEeJti8nWaaAlqPHppliyG7hSMARvVpZPnJJDFlwUYhtB58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FypLg8ez; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fd657c9199so270205ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 20:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721446917; x=1722051717; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hA28LeSjbZup5ALMxE294YbllnKvicLer46RDpBm6UA=;
        b=FypLg8ezueE8HU8Ad7i2uvJLInm7Pd+q5jzfxnHjLRtRWPbvSxKblS5JODyQrU2Zvo
         I/7VnL02HuQtbBDv2y7Opqppa7TpdsKOgFIUBg3/rtQmUEFgFD0wIYJi881irw4uJx31
         lSnf7jLs3Lkn64CmkQ8/X3Bw7czeCVlz5n1QXtDOK3VErdI+irp7Rl8plpak9HYGhllj
         wSOKjZorGJw8ecGc6w9e/hnjp1Bzj7u0GoXej+t3JkKQ6S5WynMQjMIPDMXQIRa7TO38
         m2ZURRQxPilGSQ0skwBk5THTy2N1WmcKgUe5Rnt0A2S1WWJtuH0AGXyDYUFNLn1uWSv0
         Yvmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721446917; x=1722051717;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hA28LeSjbZup5ALMxE294YbllnKvicLer46RDpBm6UA=;
        b=nT672f9QeAswUvPZb3E6FX6CpkvvQPqA+ivNAhQYZW/tf/mBib/Vqa0OFT0iYE4e63
         6vKp8hgXiJLrA8ktl99npzFNKohme/hVnWldPwT7lF0JqHjcgLT4IPbSKJ7bCC/C5Ru8
         21ZJNvcOVsAWeH/+aMZRPZHf7DRSf5CwT48bOI0VvdRHAmOIf2uvRqual+1009pEdtMc
         eNg84qIbreRf3QEO54Hie4PeAWbS+tJDIa9t6pRsidIPl8ypnHroQDVQYC45jjOG6LMH
         m63I9+LASfrgRqPmUjqqziZtYO7J42HfSZKNOh2HkfJQihgkjq74fdsJzuP3w/Hiln/j
         ajwg==
X-Forwarded-Encrypted: i=1; AJvYcCUm4SwPTz86FE1bffDkOKLNFAP4tPvI67DYRvaUl31qZzt5i00HbwB+p6/DUzuPu9u0hi5QCnxb5rqadYssI6k/wM76xuERylTX8fSS
X-Gm-Message-State: AOJu0Yw+4DfuAMmoz7pmk9tCiHir7dCZFqvlMuBcquq1UeMvMRGnd6M4
	7VKAyhAI9cNbBY+Wo70hZ+WjxPMYv/Hq2+OMWfyDTZQWerLuP7ZpMv5TV+j6kA==
X-Google-Smtp-Source: AGHT+IGV++E5gqPS9iW9+LLQOn6LEUwO0Bx+NPoKj6GsnOlt4C6jIAUZQTJVBE99ylc8GwERwxBKyA==
X-Received: by 2002:a17:903:6c8:b0:1fc:6166:da4c with SMTP id d9443c01a7336-1fd7ff6667bmr49255ad.27.1721446916553;
        Fri, 19 Jul 2024 20:41:56 -0700 (PDT)
Received: from [2620:0:1008:15:652e:fdf2:c177:d5b1] ([2620:0:1008:15:652e:fdf2:c177:d5b1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f316be5sm12318395ad.146.2024.07.19.20.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 20:41:55 -0700 (PDT)
Date: Fri, 19 Jul 2024 20:41:55 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
cc: Shakeel Butt <shakeel.butt@linux.dev>, akpm@linux-foundation.org, 
    jpoimboe@kernel.org, kent.overstreet@linux.dev, peterz@infradead.org, 
    nphamcs@gmail.com, cerasuolodomenico@gmail.com, surenb@google.com, 
    lizhijian@fujitsu.com, willy@infradead.org, vbabka@suse.cz, ziy@nvidia.com, 
    linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3] vmstat: Kernel stack usage histogram
In-Reply-To: <CA+CK2bAWRN7-UHc0C1u6UAqT82tQXgO6a4AnHEHWN-qqij1LQQ@mail.gmail.com>
Message-ID: <9f044745-aa8f-5fff-66c6-4b24521967c8@google.com>
References: <20240530170259.852088-1-pasha.tatashin@soleen.com> <cq7537bswpnbsmeiw3rh4ffrgqky4iufsaurukpk2flxts6jcu@6ctttkclvf3f> <CA+CK2bCuiDAv05Xu6OuKB=gqJ5NM20F_uUyJV8E=XH=r47ik=Q@mail.gmail.com> <i66bzhgnbql7bvuteqttpijml3ze3nngxapv32k7paqv25c5th@wd37oaastkvz>
 <usfcwyq76np42s5b2rpzgjrvvtdpwakaum7ayy4zumaa73ke3u@txbukb2464bl> <CA+CK2bBm4COW+jZifyjFEyJNcW1cAXWYzCpuO81jL3YziKxfRw@mail.gmail.com> <dz2ryasq3bbshlayah4dja3esvpwu5hzftgaapzbmjf42n7gzk@qs4wfnuuixtu>
 <CA+CK2bAWRN7-UHc0C1u6UAqT82tQXgO6a4AnHEHWN-qqij1LQQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="2003064516-483020861-1721446915=:3457478"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--2003064516-483020861-1721446915=:3457478
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 18 Jul 2024, Pasha Tatashin wrote:

> On Thu, Jul 18, 2024 at 7:19 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
> > Hi Pasha,
> >
> > On Wed, Jul 17, 2024 at 12:50:00PM GMT, Pasha Tatashin wrote:
> > > On Wed, Jun 12, 2024 at 2:50 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> > > >
> > [...]
> > > > >
> > > > > One more question: Is there any concern in making
> > > > > CONFIG_DEBUG_STACK_USAGE not a debug feature i.e. enable in default
> > > > > kernels instead of just debug kernels?
> > >
> > > We enabled it in Google ProdKernel. There is some overhead when
> > > threads are exiting, because we are looking for the first non-zero
> > > byte, but that is minimal. We haven't observed any performance impact
> > > on our fleet.
> > >
> >
> > So, you would support making CONFIG_DEBUG_STACK_USAGE enabled by
> > default, right?
> 
> Right, I see nothing wrong with having this enabled by default.
> 

The benefits of enabling CONFIG_DEBUG_STACK_USAGE by default would 
certainly outweigh any theoretical performance downside, I strongly favor 
enabling it by default and was surprised to find it hidden behind 
debugging when I enabled it in Google's production fleet.
--2003064516-483020861-1721446915=:3457478--

