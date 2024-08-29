Return-Path: <linux-kernel+bounces-307157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA9E964952
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 17:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC0111F23567
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 15:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0DF91B14EF;
	Thu, 29 Aug 2024 15:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GWmagH0U"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E1A3A1A8
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 15:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724943625; cv=none; b=r3v3T1Cm2TrxTEb/rFVi5f5t0TRNNQOh1nDkkLF+ZujNcf2vAZBY6hkDU3aN/oCAo1vw2NubhE0Y57JdqcaAhj5FLvOPnEvQHEoX5yUxP9UPE4zPiLYL2oHNmf67AC3w3ePieaOR5UICB9W4HK9rpTf0ktU08+43KGoxPD0lfzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724943625; c=relaxed/simple;
	bh=sVn91xrolhVEEiy6TWS8+uyci7ep+YQUPghYPzFMyK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KMYjvd+ucMAsiRtsFKZ0P7FAxsLeMhAYVix2aU+AN7eMCpicmfGNtumtQa2gXhgD0y8Ql+UozOwvcKa61Lm1ea/Wd2rINn4y1Z5lN1GgOwtJZiNMkZV9GBZNLg4XX+B3xGYNhgl3CZTifpeUray0DZy3ye46U2w8YdtJhezpX4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GWmagH0U; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-428e3129851so7194335e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 08:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724943621; x=1725548421; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nabzqbq3d4n7upoEt7nD8rDZUukL6YPjVtAA5PPRGA4=;
        b=GWmagH0UtvPlHZx8+UT/ZyeEkQ/MGhryAEjiHzcMr4euf9W+kS5q6wZXu+rX8vqysM
         bC5dH31v9OH+7cFCZhCzPDYkgk4jml7ejONpPCXkQA18YBkbm1UxhQmRfSBdQp5ZoXMe
         JJN1AWpPuUGQZsJymBNiWBstfC5PW6HR9psoKUtFayWf9lrfkRXJuCDEylpnnLx7HnOW
         VCTzrQk3rfcNTSC/Ekpf3txiMmcTWYBOlV2eunmi55VlNCyTt2IyWK2lJw5HfEZEN9ev
         kf8RRLKSxW3KNrGEwclpou3MG79FOX2Hm14FsEYgCcjLTDnBurIDZcL7zqFFhtf0hYF0
         hA7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724943621; x=1725548421;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nabzqbq3d4n7upoEt7nD8rDZUukL6YPjVtAA5PPRGA4=;
        b=lWUteEzBnqg8FxtZBFkn2AYy+Ai/VQYclDxuMNFE+ztQgeYGoLreQQDXSUyPl8wHpC
         8jp7NlUgd1+NV7eTxBlQSN0aTVhlInUpvuzVv4RkHQWmMt3JWEQP/P1PtcntyoJRKuKf
         L22H+erWmWPuLnE/+e+erzmHFyng+gu1z8YzkLIxCFpst/UACVfIHvtdByBgBsO7A0KC
         /KzBcZEDTSQ5Y2IJnkcs4nZmXZYZw+xLRtbKTTMabjfiFcE8uHSZeRj1jVM8LHnEYkB8
         BrXyr6nSeNQsE/skEm0DhzrrWGT6TUZTKH7+llYBohRI+6I6lusvvIiCyIPGYeW6fNJP
         mIRw==
X-Forwarded-Encrypted: i=1; AJvYcCXfZEtSl1pQZrH+EpZb+aI40469aYHu8FbMKfxESR0oIjb/1BGv7fMDya+B3kVenlBn9+MSZfpJvGTCQT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YznBuK8FxhhMvnmLpDMtKwSIubHlUP0JmjsaLYYG3fbd1S0Oifu
	2njsWje2qReNO7mvUAQRm4eS8QCkkHkPSZ8T2j56dwi6NjVMZ2zWA8AqOneIQg8=
X-Google-Smtp-Source: AGHT+IFGM3zEq1G1Y27SykyTrp93FIcWQs50mww6UNMM9UAx7l9nMYelCvutFX66Xd9aJmaFkviA7w==
X-Received: by 2002:a05:600c:3b10:b0:427:d8f2:5dee with SMTP id 5b1f17b1804b1-42bb01bb04dmr27517565e9.15.1724943621333;
        Thu, 29 Aug 2024 08:00:21 -0700 (PDT)
Received: from localhost (109-81-82-19.rct.o2.cz. [109.81.82.19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ee4ab0bsm1629466f8f.16.2024.08.29.08.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 08:00:20 -0700 (PDT)
Date: Thu, 29 Aug 2024 17:00:19 +0200
From: Michal Hocko <mhocko@suse.com>
To: Zhongkun He <hezhongkun.hzk@bytedance.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev,
	lizefan.x@bytedance.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [External] Re: [RFC PATCH 0/2] Add disable_unmap_file arg to
 memory.reclaim
Message-ID: <ZtCNA3iKd0_mH8Bf@tiehlicka>
References: <20240829101918.3454840-1-hezhongkun.hzk@bytedance.com>
 <ZtBMO1owCU3XmagV@tiehlicka>
 <CACSyD1Ok62n-SF8fGrDQq_JC4SUSvFb-6QjgjnkD9=JacCJiYg@mail.gmail.com>
 <ZtBglyqZz_uGDnOS@tiehlicka>
 <CACSyD1NWVe9gjo15xsPnh-JUEsacawf47uoiu439tRO7K+ov5g@mail.gmail.com>
 <ZtB5Vn69L27oodEq@tiehlicka>
 <CACSyD1Ny8OFxZkVPaskpnTDXgWZLBNK04GwjynT2a0ahUwKcAw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACSyD1Ny8OFxZkVPaskpnTDXgWZLBNK04GwjynT2a0ahUwKcAw@mail.gmail.com>

On Thu 29-08-24 22:30:09, Zhongkun He wrote:
> On Thu, Aug 29, 2024 at 9:36 PM Michal Hocko <mhocko@suse.com> wrote:
[...]
> > Seeing this my main question is whether we should focus on swappiness
> > behavior more than adding a very strange and very targetted reclaim
> > mode. After all we have a mapped memory and executables protection in
> > place. So in the end this is more about balance between anon vs. file
> > LRUs.
> >
> 
> I  have a question about the swappiness, if set the swappiness=0, we can only
> reclaim the file pages. but we do not have an option to disable the reclaim from
> file pages because there are faster storages for the swap without IO, like zram
> and zswap.  I wonder if we can give it a try in this direction.

I do not think we should give any guarantee that 200 will only reclaim
anon pages. But having that heavily anon oriented makes sense and I
thought this was an existing semantic.

[...]
> > > The delay of the task becomes more serious because reading data will
> > > be slower.  Hot pages will thrash repeatedly between the memory and
> > > the disk.
> >
> > Doesn't refault stats and IO cost aspect of the reclaim when balancing
> > LRUs dealing with this situation already? Why it doesn't work in your
> > case? Have you tried to investigate that?
> 
> OK, I'll try to reproduce the problem again. but IIUC, we could not reclaim
> pages from one side. Please see this 'commit d483a5dd009  ("mm:
> vmscan: limit the range of LRU type balancing")'  [1]
> 
> Unless this condition is met:
> sc->file_is_tiny =
>             file + free <= total_high_wmark &&
>             !(sc->may_deactivate & DEACTIVATE_ANON) &&
>             anon >> sc->priority;

There have been some changes in this area where swappiness was treated
differently so it would make sense to investigate with the current mm
tree.

> [1]: https://lore.kernel.org/all/20200520232525.798933-15-hannes@cmpxchg.org/T/#u
> 
> > --
> > Michal Hocko
> > SUSE Labs

-- 
Michal Hocko
SUSE Labs

