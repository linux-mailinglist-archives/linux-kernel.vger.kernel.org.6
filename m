Return-Path: <linux-kernel+bounces-550031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1CFA55A39
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 23:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A3463B01F7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 22:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F48F27CB05;
	Thu,  6 Mar 2025 22:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ClOnhpg7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC8E206F22
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 22:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741301704; cv=none; b=FPBkmgHNdaqBgN9iMbVJpI80NFY0wWGofEImnfaEMeL/SaKMRxrQJ7VHacOh0HILSPxztqf9KQv3s4dwkylSfEFwmExkytGRvXF4FURIznV3iPJ1MpVib8m6bhyc1p0G90Dty2vSXv70C2Fr8JJu4Y5XUk7ZFyFi4p06dLsppa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741301704; c=relaxed/simple;
	bh=Ec2v/6+I2m2dMEutWSk/xRKfwD+T9KZtIxeor2olnSM=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=QzWPZQEzFLruZviVQJ9EE8A3OtJ4UHdI6Uw1SdTUDT4/McPqQ2x38ggWFueIxlZUgHhT072ZFzHuXLrUjZtxGDeS2SxMT3D6lTJDetfTBqAbwmZrf6GeGSKIOKUr3zNWcBfAAJbEZXfOGSqHtqgJs0RIXdf5Kf7VA2bKL9Ez9aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ClOnhpg7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741301701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WSX2Ub1CKLDkvugsqLVThWkv/Fyhg59pKvv3HTVRtQk=;
	b=ClOnhpg7FeUqUiBDuQxeyycJonITJwHu+549FtYKbwEHfkDpUQfUhBef071gT5lPT5biWZ
	wxsMp4chTsa48evAgyILV4JN5Z0sO4mCngyAljJuPZR7h7i1+o+UCfqiynEF3401LkBQHS
	YMUWYD8s3cvP7n9iSQgDyslRQVgBCQo=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-BfUEQpk7M7iXNEJAyrGy0w-1; Thu, 06 Mar 2025 17:54:45 -0500
X-MC-Unique: BfUEQpk7M7iXNEJAyrGy0w-1
X-Mimecast-MFC-AGG-ID: BfUEQpk7M7iXNEJAyrGy0w_1741301685
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6e8feea216aso10832236d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 14:54:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741301685; x=1741906485;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WSX2Ub1CKLDkvugsqLVThWkv/Fyhg59pKvv3HTVRtQk=;
        b=Bl5AvUQF00c9YQ7ZBmAwvLwmzLTpKjTDmVv98gkHGjDW2tLnCf0I1aC/uDYFmQ5gci
         y/5qP08AummCA/qtDynBUcJaOwFS3SmBs/h+z4Ns1XWSlM05A9LIXBKyXsvBQM4SCVSi
         +jpDnw2e/w3K9kh25VXPdYDkBGbSvPchKgFoxtONONMMQPISVPb0zfeJE2GsGz1cE8Wg
         wWkiKxxVtTPN7H1Kt0NmkCLFf2unChthZG6LvnPguEx3yLfnfnpPGVS2+Rwwh5CQ2XsS
         tI9qVK9NC+q+4Nc/pTut6KZ5iP/69/eILcoPWdLWlL88w1p0zI4q4wI0KUytuaeB9O/k
         fa4g==
X-Forwarded-Encrypted: i=1; AJvYcCVNC0UkG50qdG6Ilksb4zc9KdOOyFrpImuHFiySV/ZO4kvN4y6JmFNXey1whYbyrjVi2o0lCbh0vWcRgio=@vger.kernel.org
X-Gm-Message-State: AOJu0YweZueV0JibCgufAO8o7AWlnj8xBCxpfw51XZE3+ygOQjWKBmCO
	3zh4QRdAiY9hH64LSFVDvuN2lrqo4ycilGN8J1rz43CMZxx0HwpyjXelpda3OqWDWvS0MUzW+DA
	bCFyNg7LJn4flzmQZejcDqKcl62v4CDRGdCrrx4FJ7UCna1nEvEWDZ7chHg3mtw==
X-Gm-Gg: ASbGncsNjNliqqI5rkcNOJLwm0bEsheHK6CMMHddQs8i2dDqQG5VSDj9x+B3A4Nku2n
	8E3Xyg7mSsEFGjynE3nyq0QfmVF6OqbeDq8rNgrK6i3dd61hvvtnMEXC5g5MwMJP9MyeyoYJ+Rd
	dYiCkPcVkPrXEQMa5pI8mFO0+hjgzAbJSi7Lp05UQ7YiUyYlrG6lF4QDiUmKfKET8ONADj/KGnq
	qIwvyis4L0znargUX/4oWneBbubOU0VipbAZDAbI13L718lNNRngaCCv8mmtjuCEvWVkNf5eOLx
	TxqspDKTaqMvAuj+QX6Z1TOOZk7DBSRQWl7oZAAMQt9VxruDui5xRRaq3HSXI87PeNGv9VutKA=
	=
X-Received: by 2002:a05:6214:da6:b0:6e1:715f:cdf5 with SMTP id 6a1803df08f44-6e8ff7c8320mr21742856d6.15.1741301685268;
        Thu, 06 Mar 2025 14:54:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEvjp20tEDMblS/SX0z+fmGjibqY6SKFgG687G6r4tW6uVdNve7F0FARHWp0aDZcMETKqdTzw==
X-Received: by 2002:a05:6214:da6:b0:6e1:715f:cdf5 with SMTP id 6a1803df08f44-6e8ff7c8320mr21742576d6.15.1741301684937;
        Thu, 06 Mar 2025 14:54:44 -0800 (PST)
Received: from [192.168.1.61] (pool-68-160-135-240.bstnma.fios.verizon.net. [68.160.135.240])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f707c721sm12227996d6.21.2025.03.06.14.54.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 14:54:44 -0800 (PST)
Message-ID: <c291e9ea-2e66-e9f5-216d-f27e01382bfe@redhat.com>
Date: Thu, 6 Mar 2025 17:54:41 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: Petr Mladek <pmladek@suse.com>
Cc: Nicolai Stange <nstange@suse.de>, live-patching@vger.kernel.org,
 linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>,
 Miroslav Benes <mbenes@suse.cz>
References: <20250115082431.5550-1-pmladek@suse.com>
 <20250115082431.5550-19-pmladek@suse.com>
From: Joe Lawrence <joe.lawrence@redhat.com>
Subject: Re: [PATCH v1 18/19] Documentation/livepatch: Update documentation
 for state, callbacks, and shadow variables
In-Reply-To: <20250115082431.5550-19-pmladek@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/15/25 03:24, Petr Mladek wrote:
> This commit updates the livepatch documentation to reflect recent changes
> in the behavior of states, callbacks, and shadow variables.
> 
> Key changes include:
> 
> - Per-state callbacks replace per-object callbacks, invoked only when a
>   livepatch introduces or removes a state.
> - Shadow variable lifetime is now tied to the corresponding livepatch
>   state lifetime.
> - The "version" field in `struct klp_state` has been replaced with the
>   "block_disable" flag for improved compatibility handling.
> - The "data" field has been removed from `struct klp_state`; shadow
>   variables are now the recommended way to store state-related data.
> 
> This update ensures the documentation accurately describes the current
> livepatch functionality.
> 
> Signed-off-by: Petr Mladek <pmladek@suse.com>

Hi Petr, I'm finally getting around to looking through these patches.
I've made it as far as the selftest cleanups, then skipped ahead to the
Documentation here.  Before diving into code review, I just wanted to
clarify some things for my own understanding.  Please correct anything
below that is incorrect.  IMHO it is easy to step off the intended path
here :D

The original livepatch system states operated with a numeric .version
field.  New livepatches could only be loaded if providing a new set of
states, or an equal-or-better version of states already loaded by
existing livepatches.

With that in mind, a livepatch state could be thought of as an
indication of "a context needing special handling in a (versioned) way".
 Livepatches claiming to deal with a particular state, needed to do so
with its latest or current versioning.  A livepatch without a particular
state was not bound to any restriction on that state, so nothing
prevented subsequent atomic replace patches from blowing away existing
states (those patches cleaned up their states on their disabling), or
subsequent non-atomic replace patches from adding to the collective
livepatch state.


This patchset does away with .version and adds .block_disable.  This is
very different from versioning as prevents the associated state from
ever going away.  In an atomic-replace series of livepatches, this means
once a state is introduced, all following patches must contain that
state.  In non-atomic-replace series, there is no restriction on
subsequent patches, but the original patch introducing the state cannot
ever be disabled/unloaded.  (I'm not going to consider future hybrid
mixed atomic/not use cases as my brain is already full.)

Finally, the patchset adds .is_shadow and .callbacks.  A short sequence
of livepatches may look like:

  klp_patch A               |  klp_patch B
    .states[x]              |    .states[y]
      .id            = 42   |      .id            = 42
      .callbacks            |      .callbacks
      .block_disable        |      .block_disable
      .is_shadow            |      .is_shadow

is there any harm or confusion if the two patches' state 42 contained
disparate .callbacks, .block_disable, or .is_shadow contents?

I /think/ this is allowed by the patchset (though I haven't gotten too
deep in my understanding), but I feel that I'm starting to stretch my
intuitive understanding of these livepatching states.  Applying them to
a series of atomic-replace livepatches is fairly straightforward.  But
then for a non-atomic-replace series, it starts getting weird as
multiple callback sets will exist in multiple patches.

In a perfect world, we could describe livepatching states absent
callbacks and shadow variables.  The documentation is a bit circular as
one needs to understand them before fully grasping the purpose of the
states.  But to use them, you will first need to understand how to set
them up in the states. :)  Maybe there is no better way, but first I
need to correct my understanding.

Thanks,

-- 
Joe


