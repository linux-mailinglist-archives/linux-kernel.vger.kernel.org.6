Return-Path: <linux-kernel+bounces-271038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CEF9448B4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 11:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAC051C243B5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 09:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F610170A3F;
	Thu,  1 Aug 2024 09:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aaaIXQQv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43FD183CB6
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 09:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722505510; cv=none; b=qpjDlI5lwFJhNVD8OsoFA+soK+LSC4e9msVnh2MLMjRbKMqujAIxE8fZ31GOcA8hqNBVpMLJaw75QlsDvS4IFvm53Xuk2ee/lVUMBL1O18H8G703h3EJDEyQh9u+CHQ6Kgf/wuGrIie6LDr+K1/jMOiA1LD+vsuYipBf8r8dlpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722505510; c=relaxed/simple;
	bh=clgL082mVYG3cRF+MaIMEVHgOzQA3SgdEwqoX1UqzE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u4FL+A15CjKKN4xUzZGvjgoD7ncLXe8YsjL/ubjatYA+dKmm/T6F94apY26iK8Sddb/XYb3Sde09zeWRx1fq0of8n/978YW8LrqN4UoC3dKhwNVq88M3N14NEHPwi4jQOQb47nDZFFox5JJwQswP7gQaWESykdZ3QOttgrfXh3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aaaIXQQv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722505507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8qN/79PmuKOBJUmafOXpm7k5iDkosvcOvyIebczVrtU=;
	b=aaaIXQQv3Zqvvp4Eipj/NbG1rAFxwaGpl+MZ3tp8OgqfWUHIQchJyidft38KdJCxwojYpR
	QzBbDsKso9OXXcdwZI5LNad1btrXDNK80Bdvd0jH4gPzJjh2jaokobupZksps0JkdfTs2K
	ITx6TTsUhoHQaQCDDuqVVx2rnZ5oplc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-TJOy5ErCMK6MmImsWtn_NA-1; Thu, 01 Aug 2024 05:45:06 -0400
X-MC-Unique: TJOy5ErCMK6MmImsWtn_NA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a7a83f54fdeso589751766b.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 02:45:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722505505; x=1723110305;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8qN/79PmuKOBJUmafOXpm7k5iDkosvcOvyIebczVrtU=;
        b=ejpjysRZV9jTOweyLTea4U+84+AQhLpzF8yjRtAuTOLIVdi6ORJowmItAxCQYUplBc
         CoRwCw2d//0pTGQwRLmBKHG25BEaBQGzk05Nny2SMdoyyKL8rRSwaC3C+Omfp6VH+Ls0
         bX7lYFN17/jHvyorBNyPqpYhlpTq4URFES24I9DcD9LJBkITl4JeqZVaTFhiLXj/SKqY
         vhpiUvUpSk2j9B9ohSRVueWrzNm8/8gWReyrKxXHx23oecKS4mEeA+oP0BjqsQChANP/
         UCMxS0EsVIpPQ8kTSJPcFKr0WvoKxJQAWCSjKcq6OKzApTTkehayBv/uaZMnywHK4RTg
         cAaw==
X-Forwarded-Encrypted: i=1; AJvYcCVCQEUopdiymc5+XaiNViNq2t09WE2iueUi0SArSWscU3SCfmZEhZHBlZm/KN2tfC4sQ1+D5HFKidnR1ZYfFY4DX+8jjUXRUHqeWW0T
X-Gm-Message-State: AOJu0YwCCvpOV0DF/7a60YuVukuwuzh7jY3cFBEU/p4jwQBBWe4WxPCA
	U426tLTYw/eIBwb+fKhFO7LWwYEL6FX148IBytzVNGELhn3ex0N9M8ELCHa9kHY2CAfYfA4q+we
	OSvbaqAjqI+XxT6e62r3+1odfHjsGp9iI4CrEWmUNoL9FbD6yqOd+RmFJqBiGtgtCPgUFleyHWJ
	8WTCG/zltgZWceCL7FLVzqlyHnanflxd+9vj0AG/KcatmRD+Y=
X-Received: by 2002:a17:906:6a25:b0:a7d:3617:b5f5 with SMTP id a640c23a62f3a-a7daf659c17mr118177766b.42.1722505505113;
        Thu, 01 Aug 2024 02:45:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUc+aTMM6ixUwEQdBCzdpLRUaysXSjI/S3eq/2DMY+/Pt0yDyS3H3KJApcbfEdivaG3F5DnF7KOO9ht7luUHM=
X-Received: by 2002:a17:906:6a25:b0:a7d:3617:b5f5 with SMTP id
 a640c23a62f3a-a7daf659c17mr118176266b.42.1722505504554; Thu, 01 Aug 2024
 02:45:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731083655.375293-1-tglozar@redhat.com> <20240731083655.375293-4-tglozar@redhat.com>
 <20240731114137.21499fed@gandalf.local.home>
In-Reply-To: <20240731114137.21499fed@gandalf.local.home>
From: Tomas Glozar <tglozar@redhat.com>
Date: Thu, 1 Aug 2024 11:44:52 +0200
Message-ID: <CAP4=nvS08OtNdGdFfVNst09HnZjR6fsoCMPKsbTb-Vey8wyX8g@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] rtla/utils: Add idle state disabling via libcpupower
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jwyatt@redhat.com, jkacur@redhat.com
Content-Type: text/plain; charset="UTF-8"

>
> Need to check if the calloc failed and return an error if it did.
>

Definitely, I completely missed that.

>
> Hmm, should this warn if state is not zero and disabled is negative.
>

rtla timerlat hist/top will error out if save_cpu_idle_disable_state
returns a negative value, so I don't think a warning is necessary
here.
```
            if (save_cpu_idle_disable_state(i) < 0) {
                err_msg("Could not save cpu idle state.\n");
                goto out_free;
            }
```

>
> Should probably have a check to see if saved_cpu_idle_disable exists.
>
> > +     nr_states = cpuidle_state_count(cpu);
> > +
> > +     if (nr_states == 0)
> > +             return 0;
> > +
>
> As well as saved_cpu_idle_disable_state[cpu] exists.
>
> Just for robustness.
>

Right, that would help catch some possible bugs if
restore_cpu_idle_disable_state is ever called before
save_cpu_idle_disable_state. The values of
saved_cpu_idle_disable_state and saved_cpu_idle_disable_state[cpu]
have to be read anyway, checking for zero should not make any
noticeable difference.

>
> No need to check here. free() works fine with passing NULL to it.
>

Ah, I see, I need to check that for saved_cpu_idle_disable_state so
that I won't be accessing null memory in the for loop, but not for
saved_cpu_idle_disable_state[cpu], where I just call free().

Tomas


