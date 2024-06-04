Return-Path: <linux-kernel+bounces-201410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4948FBE20
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 23:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 258001C23A39
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 21:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FB814B977;
	Tue,  4 Jun 2024 21:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KgxVfdlX"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEBA84E1C
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 21:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717537071; cv=none; b=Mipmx1+HF+zKoa5aF2O6CDEVKHRvNRuhBqjWXpptZ7xI00VcsaJvIDKqExlJ7Kblqoul60E4QPsYGP108HeBeYlUtcGmsmrvQdSjN3POY0p6HJQtWWh7yD2Jo9GNQQC0D2Ko5xCiWuWHLtv6xvdJn/iMej6YH+ZEq9+zVcXSs0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717537071; c=relaxed/simple;
	bh=4xEASyT5mO1LPnQB759BVaKHul3BQ4y1LZA8+XWCkRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DdQc2+lM6ahC6cnKCKcbeYbFBSCf6NrhbQm6ZIRsz+/jJuzBGwbjrWpix9x0D5rQaxghu9u8y9kwT3fAaO5l4eDcPEsbroBKT4qE/IMi7FADIHV9obTECZuiYs/X7hNkzKr9IeB1TvK++jDtV5C1Msor5odjS+XE1w/4bToF2Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KgxVfdlX; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-62a0827316dso4028727b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 14:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717537069; x=1718141869; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XjLR8zp8xaF9e7AIOZUXaas/fY4uKdUZFyE2m9Eo4uw=;
        b=KgxVfdlXFj9YvUdSTQdJ41MdA5JjC8o+OWQxNUMdQUNre1x8JRp2/0neNiaiBBdd9w
         9UyCGL96uZWnwwukmrHolGbqScU80K3z0ShK2pZhV44oOwKHCT3ZJir/RNvq3eyIuhM9
         juY7T2ZWahDUSJHk5+ExABqq73OlLAgd9/EkN3yFMWN5H9yNVsBTVB7Mx+i5l9aE76dG
         8GbBiKmb90I6Xo7Krh6j6DMTBAmb9ZHFTE2H+52/PgZvN/5r8fEbmAUbFby2AuD3RIMB
         VuaRX9/yrFac4ofc5JMZiUjkQq9gd1PxY1lje4Wa8mDS3yEUvEtLFl20NwCPUaHvFh1m
         4v6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717537069; x=1718141869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XjLR8zp8xaF9e7AIOZUXaas/fY4uKdUZFyE2m9Eo4uw=;
        b=g8jDJoS/u4lsWRmSHZ6EABEI3BTUxxwwzGHqRlQPwsWggd3UioHvWOD7M4GhZ8k7O4
         pXANdlmZ4yli83MMT2iKQh5dddmCYpLwIZfSWIpOAIoDy6d6Kf9pe/EHWegaxFUtTbjN
         ykfDGo4jg2MdGBrSOZGNpPjHoMLOdZJ1A5TVl2fr2r8FIr1O4CHNeAqv9+GBwe8HyQ+1
         VgtciglD8TFNqDEUSBEKidPapI0/downMCwXdUli1utfTL7nNhlLtxKKbTHbx/SAAw3F
         5qDI58YNck7IW5l7xnIDYNhXSOjtt6+nolt/Isb08NOkzaP6uKNXzlx9XchTEf1V+iAO
         SvtA==
X-Forwarded-Encrypted: i=1; AJvYcCXZpIowVQT1fc2Uvh5kmdWUpS43UlPk1+DVhzn3UgeGDezSmT8nS0oQIRtx9OMZCKjXElbonPuvXXcGHxYvWJlL4gunIu+tumniYyba
X-Gm-Message-State: AOJu0YygYExQaDy31F/C3C5LR0h5IPjso7OzUlFKKrIPiDsilX/+2P8l
	KK774KJ+8FgjtSg1MNq0mmiiHHc+CfjSFprGru0Y5PlueYEyRhxDr5ketj7Oupt5MId2JiUrY5v
	f0y691ziCisifAAkRF8zqwI4KsYU=
X-Google-Smtp-Source: AGHT+IHMSUsN4L//fguDdOItLcFgQdOi1WGqnEsNTenvRjEawfGT374N9VMZDvhJqxFod7fN9YhFbGo+Smk6gtsoR2U=
X-Received: by 2002:a05:6902:2507:b0:dfa:705c:6e3e with SMTP id
 3f1490d57ef6-dfaca7e16b2mr682450276.0.1717537069283; Tue, 04 Jun 2024
 14:37:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240531053704.2009827-1-olvaffe@gmail.com> <2024060427-upstairs-jackal-b10a@gregkh>
In-Reply-To: <2024060427-upstairs-jackal-b10a@gregkh>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Tue, 4 Jun 2024 14:37:38 -0700
Message-ID: <CAPaKu7RWuLEts+niTEbTN2yMke=AGQuiWzpG6uH39qudvbr2hQ@mail.gmail.com>
Subject: Re: [PATCH] kernel/resource: optimize find_next_iomem_res
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	christian.koenig@amd.com, alexander.deucher@amd.com, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 4, 2024 at 8:41=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, May 30, 2024 at 10:36:57PM -0700, Chia-I Wu wrote:
> > We can skip children resources when the parent resource does not cover
> > the range.
> >
> > This should help vmf_insert_* users on x86, such as several DRM drivers=
.
> > On my AMD Ryzen 5 7520C, when streaming data from cpu memory into amdgp=
u
> > bo, the throughput goes from 5.1GB/s to 6.6GB/s.  perf report says
> >
> >   34.69%--__do_fault
> >   34.60%--amdgpu_gem_fault
> >   34.00%--ttm_bo_vm_fault_reserved
> >   32.95%--vmf_insert_pfn_prot
> >   25.89%--track_pfn_insert
> >   24.35%--lookup_memtype
> >   21.77%--pat_pagerange_is_ram
> >   20.80%--walk_system_ram_range
> >   17.42%--find_next_iomem_res
> >
> > before this change, and
> >
> >   26.67%--__do_fault
> >   26.57%--amdgpu_gem_fault
> >   25.83%--ttm_bo_vm_fault_reserved
> >   24.40%--vmf_insert_pfn_prot
> >   14.30%--track_pfn_insert
> >   12.20%--lookup_memtype
> >   9.34%--pat_pagerange_is_ram
> >   8.22%--walk_system_ram_range
> >   5.09%--find_next_iomem_res
> >
> > after.
>
> That's great, but why is walk_system_ram_range() being called so often?
>
> Shouldn't that be a "set up the device" only type of thing?  Why hammer
> on "lookup_memtype" when you know the memtype, you just did the same
> thing for the previous frame.
>
> This feels like it could be optimized to just "don't call these things"
> which would make it go faster, right?
>
> What am I missing here, why does this always have to be calculated all
> the time?  Resource mapping changes are rare, if at all, over the
> lifetime of a system uptime.  Constantly calculating something that
> never changes feels odd to me.
Yeah, that would be even better.

I am not familiar with x86 pat code.  I will have to defer that to
those more familiar with the matter.

>
> thanks,
>
> greg k-h

