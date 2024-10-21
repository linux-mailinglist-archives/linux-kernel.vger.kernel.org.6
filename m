Return-Path: <linux-kernel+bounces-374713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A7D9A6EE6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 17:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62146281699
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 15:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7081CBEA3;
	Mon, 21 Oct 2024 15:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="R02flJPg"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283F4176ADE
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 15:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729526237; cv=none; b=OMD2+cweyDl1Dw5mGC/odKO06180P/tO1xI72KUwv/QjwsX8+SyHjcYbUIqCMY2lLf52TrnOJBSX4uskiVrpcBXaBQRb/MbCEFM8V/a9mYAPMS3RkwWxE63R7+k6KY0WNcGxAenyU4qtr3290l+2D9RHl9SVXPjompnCzzmYO18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729526237; c=relaxed/simple;
	bh=rDqF9HRJ9NrejWv1i63XVUmfDKFrWmrBwIErnzkWKXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=naERy8BPbx3tmwGDiCmMWWytHMK2bJX7rlIY3WUZnZvERyGHV2aBX/gi3A+S+w4kpMA8QpMyk/qo3bRAHv/hH2AqPo+qVg6yiBDBG28+o7Mt2JtVcDG487/0uQtEclNuCl2rsonejiwcItUw4lPslMx5jx5wb3zhYBS7JfkPL0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=R02flJPg; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9a5f555cfbso298534566b.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 08:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1729526233; x=1730131033; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dDw/eqUUNfsBtWyAEhbHkP16UO4fYbMtXP5eNWAHVM4=;
        b=R02flJPgxKKoXJgbfqPm3Xvt/LhvLFXi1x2nmHJyx1ksn+V/SC53iFKbmG6wj4ood6
         UqagCb5QdcTlqNLBwcssgli278rs3NEkoLehtBoTF2z6p+eDKOJskyG/ioazaOJKHdar
         tfl85Qdb2YmxdlyzyLltoNmWOSkimuE8mBkxXjNW617+/vzKlxdeSzmyCPs14p0CVJoS
         7ewQ9VsROm4PM5C1uIcumGkiLrzd3wQ+isV5shOpHYBmdfqr7eAxlnpLY7F4rVHaO4li
         8eEZTylLSE1lARCk7GF8hKHSBLTKtZxeVZCyJrsYFJ17wfMBKbvqpXzNwtG2QbPx+W4P
         fiDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729526233; x=1730131033;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dDw/eqUUNfsBtWyAEhbHkP16UO4fYbMtXP5eNWAHVM4=;
        b=ASL15wdVXsN/IkhEnji8cDmKh8SStzy0O4EadlU66z+we2dyE4GUNMvXBXPH37651f
         fTHB4dCpA0vyXCqkXWm58MaIqbVsi3rrlCvrgb/zJ9ivBornsldERcAKtkS7fzZdcol4
         wcCpFpGjJ9U9ikYK4kW9bZFCDk/8CVBPupn/6qu+UfObt0A0FH6Coji1klA/CSCqaaBH
         aviDkM4PD3cdR+WM/DsIWHE2CCgigq+sIYZyK/GTep4nrk0RzvPJyliT8L1UhUlMDZUv
         VGA/HFrOhLP4kmzuwyFXTHrRQbgsYHfYTA5YtyEsz5A2hqq3gUbxDJ1aX0U9guxWkfcZ
         mhjg==
X-Forwarded-Encrypted: i=1; AJvYcCWAl3wVwwIRtFt/6AvCqbuxgKyqSgjB744/gRf1wkZ0wyl1uKOxBIpeqKVFACrBO4Uz4griTbGrm2oIgQw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3qh/IPQGFZ+FPrXWtck8DeheZA48QYXKZiLS52zRaPGv7X7sM
	/Kxi1ImXLf9Lc+PQ0y7RCb6nzQUI9+US4gmqrC+NwType6QKU9zKgIAjtSYE9jM=
X-Google-Smtp-Source: AGHT+IH8rj3/sUlYj4idAmDktH+SYwN0X+O5bSIWGTSplCx3Kpe3omxzwpgCZW0mKkaRkknG0Ii7EA==
X-Received: by 2002:a05:6402:42d6:b0:5c9:137b:b81b with SMTP id 4fb4d7f45d1cf-5ca0ae81126mr14584037a12.25.1729526233247;
        Mon, 21 Oct 2024 08:57:13 -0700 (PDT)
Received: from localhost (109-81-89-238.rct.o2.cz. [109.81.89.238])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cb66a654cfsm2065438a12.29.2024.10.21.08.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 08:57:12 -0700 (PDT)
Date: Mon, 21 Oct 2024 17:57:12 +0200
From: Michal Hocko <mhocko@suse.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: David Hildenbrand <david@redhat.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Yosry Ahmed <yosryahmed@google.com>, akpm@linux-foundation.org,
	kent.overstreet@linux.dev, corbet@lwn.net, arnd@arndb.de,
	mcgrof@kernel.org, rppt@kernel.org, paulmck@kernel.org,
	thuth@redhat.com, tglx@linutronix.de, bp@alien8.de,
	xiongwei.song@windriver.com, ardb@kernel.org, vbabka@suse.cz,
	hannes@cmpxchg.org, roman.gushchin@linux.dev, dave@stgolabs.net,
	willy@infradead.org, liam.howlett@oracle.com,
	pasha.tatashin@soleen.com, souravpanda@google.com,
	keescook@chromium.org, dennis@kernel.org, yuzhao@google.com,
	vvvvvv@google.com, rostedt@goodmis.org, iamjoonsoo.kim@lge.com,
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v3 5/5] alloc_tag: config to store page allocation tag
 refs in page flags
Message-ID: <ZxZ52Kcd8pskQ-Jd@tiehlicka>
References: <ZxJcryjDUk_LzOuj@tiehlicka>
 <CAJuCfpGV3hwCRJj6D-SnSOc+VEe5=_045R1aGJEuYCL7WESsrg@mail.gmail.com>
 <ZxKWBfQ_Lps93fY1@tiehlicka>
 <CAJuCfpHa9qjugR+a3cs6Cud4PUcPWdvc+OgKTJ1qnryyJ9+WXA@mail.gmail.com>
 <CAJuCfpHFmmZhSrWo0iWST9+DGbwJZYdZx7zjHSHJLs_QY-7UbA@mail.gmail.com>
 <ZxYCK0jZVmKSksA4@tiehlicka>
 <62a7eb3f-fb27-43f4-8365-0fa0456c2f01@redhat.com>
 <CAJuCfpE_aSyjokF=xuwXvq9-jpjDfC+OH0etspK=G6PS7SvMFg@mail.gmail.com>
 <ZxZ0eh95AfFcQSFV@tiehlicka>
 <CAJuCfpGHKHJ_6xN4Ur4pjLgwTQ2QLkbWuAOhQQPinXNQVONxEA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpGHKHJ_6xN4Ur4pjLgwTQ2QLkbWuAOhQQPinXNQVONxEA@mail.gmail.com>

On Mon 21-10-24 08:41:00, Suren Baghdasaryan wrote:
> On Mon, Oct 21, 2024 at 8:34 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Mon 21-10-24 08:05:16, Suren Baghdasaryan wrote:
> > [...]
> > > Yeah, I thought about adding new values to "mem_profiling" but it's a
> > > bit complicated. Today it's a tristate:
> > >
> > > mem_profiling=0|1|never
> > >
> > > 0/1 means we disable/enable memory profiling by default but the user
> > > can enable it at runtime using a sysctl. This means that we enable
> > > page_ext at boot even when it's set to 0.
> > > "never" means we do not enable page_ext, memory profiling is disabled
> > > and sysctl to enable it will not be exposed. Used when a distribution
> > > has CONFIG_MEM_ALLOC_PROFILING=y but the user does not use it and does
> > > not want to waste memory on enabling page_ext.
> > >
> > > I can add another option like "pgflags" but then it also needs to
> > > specify whether we should enable or disable profiling by default
> > > (similar to 0|1 for page_ext mode). IOW we will need to encode also
> > > the default state we want. Something like this:
> > >
> > > mem_profiling=0|1|never|pgflags_on|pgflags_off
> > >
> > > Would this be acceptable?
> >
> > Isn't this overcomplicating it? Why cannot you simply go with
> > mem_profiling={0|never|1}[,$YOUR_OPTIONS]
> >
> > While $YOUR_OPTIONS could be compress,fallback,ponies and it would apply
> > or just be ignored if that is not applicable.
> 
> Oh, you mean having 2 parts in the parameter with supported options being:
> 
> mem_profiling=never
> mem_profiling=0
> mem_profiling=1
> mem_profiling=0,pgflags
> mem_profiling=1,pgflags
> 
> Did I understand correctly? If so then yes, this should work.

yes. I would just not call it pgflags because that just doesn't really
tell what the option is to anybody but kernel developers. You could also
have an option to override the default (disable profiling) failure strategy.
-- 
Michal Hocko
SUSE Labs

