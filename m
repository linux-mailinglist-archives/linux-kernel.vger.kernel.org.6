Return-Path: <linux-kernel+bounces-319224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 800B796F977
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 18:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BFA21F22018
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 16:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40421D4154;
	Fri,  6 Sep 2024 16:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QEwGQuVB"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563BF2D045
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 16:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725640802; cv=none; b=Mkq5ukJpHIwjaMlIMyAqs+NwWZK1P4NQe15XcG0M+wB8gb2RzUxYRYWotK8QaN32YyHiQ9Mm3Obych4ZHJBq4FgHgGGycXRNp3pux5SJCBDBpu8yyuabQC65f67yRincHbtf0P8SOvQwRS6FnjUjyTKV03VOCXiTABEc9QZdW14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725640802; c=relaxed/simple;
	bh=P9Eryl5SCGSwf+/z7iLEZUpwtqsdlYrJ1wkIzKBU3SU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=afW9fVAcwLRmqw1XOpe7EzGrD7BIHmpvwq/f9QsxhkLkcMcvUoPkg1zKaw69ds2B3btxMG8lGAalut6f1/3HV/vk354uyIdGcx9HMgVsKXVhYsZV0vYomm2Qb45mGk0sp67RwNpsTS5Kj7iIPZEMCUkffDPiSkfvsNdgOuxfwHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QEwGQuVB; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a86910caf9cso602338966b.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 09:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725640799; x=1726245599; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QF/ebzmzQk3Rvt7bUbW4XRiKYFS0zEetz6yd91MTpio=;
        b=QEwGQuVBA3s49ZdxMgyOOQf2gPWUaWoq7zrgLSi/E3ViEFHP3Nc21Zc6zTmRA3/YNV
         D3iTImKbxMwdYJtKQVjnXc5N2xZwJ7UMu+0P30gTR6P6TjYAniOaCwI/j5vsWVF8FXQo
         N+Nx9VdEhvb+J+0FZWI4lXVNFxsjwUavnPGYigUzdwm5ZVIpJ8auYqsW/5gKeBCvGBFA
         GLjzsg73G0KLjsb+9tqI2wr0u5c1SB6HUu2YOVUaW+j420hD4SM/FArSQPJT8yGQOxhi
         N93KpMP2gLB1wbpcFFO9tKp9Qh1+kq7DjLsv/dEgQWGTMOOQXHKmRP3HK+oMSLdGe7SS
         NQKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725640799; x=1726245599;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QF/ebzmzQk3Rvt7bUbW4XRiKYFS0zEetz6yd91MTpio=;
        b=BcX02YEOOub0Ek0mGE0ixHxr92/vXmLYb/LMYx4K8EWISkqkdtzUOw7i+qJL7lqOOG
         bNkk0YDPr3EIU7kA3v05Hdow1xIN//II5fnEh24wjPk83FVzUvVEeccYIVy/a/wYTsT7
         cnvRqUgqFpqBzjd9NZjF7k0qfcSXasiCA6ZZoo5JL/q3Sjx7u/i1JPSQAnJq5b3iKTRZ
         AgUJNOYoKiD6jHxC5I+gQJrtwquSHbLmg6mHUVfw5R2X9VJ+PQa/jy147vZnNM0b+5Jv
         xIleaPqD3XuQL1WO69+JUravoARMh2bOBtX0kRyKKtTQ7EmwgadIHYq5bHqmPLejLxG6
         Uoqg==
X-Forwarded-Encrypted: i=1; AJvYcCVYqzftT+rqDNF8y2BgJ6NabY3QMOVrWm9RRlH+gIJ0M9LA2LPrPd0LgFffL0Yn30ju7nIxLKcqoUpDecE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfWfVFIzBOAnL6+S7U7stzxrAwh8yPZB9Ga7bbiVZcKCKyvnDy
	obZYy4XkOEaClb82AGu5Rt5jduZDOMwyTfASuCa+e1Iyx2bCgsmpCPTsvNhTf8Q=
X-Google-Smtp-Source: AGHT+IHBVZlr6HZWdZFnGdPIe/stiZVSdziTDEHho/C+HkkwlqCK9AL+pQ7P/fc4xWY+NVIYws13oQ==
X-Received: by 2002:a17:906:ee8e:b0:a75:7a8:d70c with SMTP id a640c23a62f3a-a8a85f330a6mr394147566b.4.1725640798595;
        Fri, 06 Sep 2024 09:39:58 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a61fbaf2dsm294998066b.30.2024.09.06.09.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 09:39:58 -0700 (PDT)
Date: Fri, 6 Sep 2024 18:39:56 +0200
From: Petr Mladek <pmladek@suse.com>
To: zhang warden <zhangwarden@gmail.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
	Jiri Kosina <jikos@kernel.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	live-patching@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] livepatch: Add using attribute to klp_func for
 using function show
Message-ID: <ZtswXFD3xud0i6AO@pathway.suse.cz>
References: <20240828022350.71456-1-zhangwarden@gmail.com>
 <20240828022350.71456-3-zhangwarden@gmail.com>
 <alpine.LSU.2.21.2409051215140.8559@pobox.suse.cz>
 <20240905163449.ly6gbpizooqwwvt6@treble>
 <285979BA-2A85-495F-8888-47EAFC061BE9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <285979BA-2A85-495F-8888-47EAFC061BE9@gmail.com>

On Fri 2024-09-06 17:39:46, zhang warden wrote:
> Hi, John & Miroslav
> 
> >> 
> >> Would it be possible to just use klp_transition_patch and implement the 
> >> logic just in using_show()?
> > 
> > Yes, containing the logic to the sysfs file sounds a lot better.
> 
> Maybe I can try to use the state of klp_transition_patch to update the function's state instead of changing code in klp_complete_transition?
> 
> > 
> >> I have not thought through it completely but 
> >> klp_transition_patch is also an indicator that there is a transition going 
> >> on. It is set to NULL only after all func->transition are false. So if you 
> >> check that, you can assign -1 in using_show() immediately and then just 
> >> look at the top of func_stack.
> > 
> > sysfs already has per-patch 'transition' and 'enabled' files so I don't
> > like duplicating that information.
> > 
> > The only thing missing is the patch stack order.  How about a simple
> > per-patch file which indicates that?
> > 
> >  /sys/kernel/livepatch/<patchA>/order => 1
> >  /sys/kernel/livepatch/<patchB>/order => 2
> > 
> > The implementation should be trivial with the use of
> > klp_for_each_patch() to count the patches.
> > 
> I think this is the second solution. It seems that adding an
> interface to patch level is an acceptable way.

It seems to be the only acceptable idea at the moment.

> And if patch order
> is provided in /sys/kernel/livepatch/<patchA>/order, we should
> make a user space tool to calculate the function that
> is activate in the system. From my point to the original
> problem, it is more look like a workaround.

It is always a compromise between the complexity and the benefit.
Upstream will accept only changes which are worth it.

Here, the main problem is that you do not have coordinated developement
and installation of livepatches. This is dangerous and you should
not do it! Upstream will never support such a wild approach.

You could get upstream some features which would make your life
easier. But the features must be worth the effort.

Best Regards,
Petr

