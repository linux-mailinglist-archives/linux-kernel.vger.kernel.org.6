Return-Path: <linux-kernel+bounces-547124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0D4A50336
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 16:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E75CF164528
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9762E24FC03;
	Wed,  5 Mar 2025 15:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WZ0eKWTS"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C7724F5A9
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 15:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741187423; cv=none; b=GbCxMQ9/AKROXEdq7Apl6K93+UoDd023RX8g8lJ/4do/BRqUH4aFpasn7NEghkP+byypx8lM6AmMpNw6EuQE6kqLOEjFHK0ujqCV1ujeLJNWQ/h8HeVps/KrIabhYZ+zG+PrcKvMe3r+o+LtGjQ0MESQp8EzLm3M14MPQjD+upU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741187423; c=relaxed/simple;
	bh=tk1Njz4liFyWt+bIWBJGJ6wnP2wPoLpY1p0ap4RgtR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KgJ49qcqHp1K5VCy3FV79S9K7opScbYr4dbXRRs4HGkaHTLC7CJr86xdh4+CUIJp/+qiHBbzBNTGsQltyiAQ+G5xPaWdQ0riSMFtA6fRkASU7BXzu2ePlUTlZmqOPwTwfybyK3nNBS8Kww7Iwcmz9c87p0wbTuh1+JRJOaGQZOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WZ0eKWTS; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43948021a45so63210115e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 07:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741187419; x=1741792219; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nb3IwvZEIbVMVABGFoJs3pODTanC6EEzp5rqEbnLKAY=;
        b=WZ0eKWTScajRj4EEcThPq5qOGDLkcY7EgaIRKrcfugZ9M7rUNv7tzI/RH/O/KqmLHR
         ZQzoj9D93YFYHIbNvJcn4DMX9Euu/012uPE8sW7kNMDeb05qvwDtWXCAEv7+zuzkFANS
         VM7i/W6PsAMlfonCozJZn4Nk04/6jP7BFiY3UK78C/QP/7vvj3/VfS6nNgXnb4ZNbHMH
         reIBz6QPL5yrs+zH3UTTKFsHD7JLSyYEsFSjkcvOb1zSEmFhxG3QJC39A6VFPyq/N87V
         KLWZEwyhgFlnhfzwjT6YAcqrWG69V+aYME7VLYoS6GRASjZ6E9T9QouScL5TVSUYFf3e
         pcsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741187419; x=1741792219;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nb3IwvZEIbVMVABGFoJs3pODTanC6EEzp5rqEbnLKAY=;
        b=QIFiEFyev8SRGltonx1q4N1fIubxdY/QJhjeD+xY+rJgpPljlInR3a6NJlc2SRwDUW
         a4kRGCZ7Rc6L1MoyB2zaSAplsCuFf/aE8+XAnygLShLWleFpmHC6I56ff6xf/Z+VDP0N
         UBjp+i8uZUuUQRHKQsRPkjWC8p3FC/fBFqqB8yuAs63HfwPANgipabk+rcc+PbpXy/VD
         cx/pwg8C9LQfGQMz4FknCDztOI2cRjPDygUradr6rPNu/d/0kaa3rq/e90Q/RG4y+2q6
         Wgt9I4IvolX9FEJaw1PYKZ04IJt7pAPYb5gm2YXT/Jqd9m07W5Ek7JffO4sycv1ssR0k
         6nHA==
X-Forwarded-Encrypted: i=1; AJvYcCWguoGl35j+BOwHbzD7CGn4+FRuNBfVndDFrzyigVeKQQLYtRIuYDQ+4W3QaC05jUlVBsNuSvQuNk8If2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YybLSuwKavoxDuREIOkPUk1y8SFBjzDqHKPc+1flmGC43YnApvB
	lXZ5GAIK9j78OxuYc7pkdN2uvN8kJ0fBPop3NLWVlNcAQcIdNys4r9udATV3IC0=
X-Gm-Gg: ASbGncu1a6Nlt5fUP9nnn5YP8ae0llsp2k8f69c6xiHQkB4SgjmkOA9ho4TzpvqoyQd
	5hkS91yTSOXUjVPSsHaYhRgM76YjXPbQuvTVLGbM2rdx0otwy6XQRTq7RD0IfLxWsCnymA5BQGx
	jXt3bm7dQDwotbwJJmNdhdWel/8LtICshh+3x60OnOLPr97oeCcN7ADTXKGzch3y/yZMQLRRd4S
	z2xMNvbcfKstkkAXjmJhLW7pSh56FyPE/jBtAFnshWTKkpvr65Nmw8WO0lkA2ORaM79Po1e3Hlz
	mo97P+PagsYql9+k5NuDru0fIq6OVpQYwEDugHRSEj0dHvSlzbuO3J/mRQ==
X-Google-Smtp-Source: AGHT+IHY0XWIZIrtX7/phGcFfq+MLz0FI2euq2tdU8kbJkxFDE3E48w83KNAkvsZm9llZmZhdx3qVg==
X-Received: by 2002:a05:600c:3b2a:b0:43b:d251:7aff with SMTP id 5b1f17b1804b1-43bd29d71c3mr24143305e9.23.1741187418796;
        Wed, 05 Mar 2025 07:10:18 -0800 (PST)
Received: from localhost (109-81-85-168.rct.o2.cz. [109.81.85.168])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-39122da6cb4sm2115955f8f.72.2025.03.05.07.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 07:10:18 -0800 (PST)
Date: Wed, 5 Mar 2025 16:10:17 +0100
From: Michal Hocko <mhocko@suse.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
	Filipe Manana <fdmanana@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm, percpu: do not consider sleepable allocations atomic
Message-ID: <Z8hpWSsDuMX1salt@tiehlicka>
References: <20250206122633.167896-1-mhocko@kernel.org>
 <Z6u5OJIQBw8QLGe_@slm.duckdns.org>
 <Z6zS4Dtyway78Gif@tiehlicka>
 <Z6zlC3juT46dLHr9@slm.duckdns.org>
 <Z60KQCuPCueqRwzc@tiehlicka>
 <Z60S4NMUzzKbW5HY@slm.duckdns.org>
 <Z60VE9SJHXEtfIbw@snowbird>
 <Z69mygllBATJ6dsm@tiehlicka>
 <Z7fmnsHTU49eYEaU@snowbird>
 <cfc2d4f2-08d4-45c1-830f-d1786306454a@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfc2d4f2-08d4-45c1-830f-d1786306454a@suse.cz>

Sorry, I have missed follow ups here.

On Fri 21-02-25 10:48:28, Vlastimil Babka wrote:
> On 2/21/25 03:36, Dennis Zhou wrote:
> > I've thought about this in the back of my head for the past few weeks. I
> > think I have 2 questions about this change.
> > 
> > 1. Back to what TJ said earlier about probing. I feel like GFP_KERNEL
> >    allocations should be okay because that more or less is control plane
> >    time? I'm not sure dropping PR_SET_IO_FLUSHER is all that big of a
> >    work around?
> 
> This solves the iscsid case but not other cases, where GFP_KERNEL
> allocations are fundamentally impossible.

Agreed

> 
> > 2. This change breaks the feedback loop as we discussed above.
> >    Historically we've targeted 2-4 free pages worth of percpu memory.
> >    This is done by kicking the percpu work off. That does GFP_KERNEL
> >    allocations and if that requires reclaim then it goes and does it.
> >    However, now we're saying kswapd is going to work in parallel while
> >    we try to get pages in the worker thread.
> > 
> >    Given you're more versed in the reclaim side. I presume it must be
> >    pretty bad if we're failing to get order-0 pages even if we have
> >    NOFS/NOIO set?
> 
> IMHO yes, so I don't think we need to pre-emptively fear that situation that
> much. OTOH in the current state, depleting pcpu's atomic reserves and
> failing pcpu_alloc due to not being allowed to take the mutex can happen
> easily and even if there's plenty of free memory.

Agreed

> >    My feeling is that we should add back some knowledge of the
> >    dependency so if the worker fails to get pages, it doesn't reschedule
> >    immediately. Maybe it's as simple as adding a sleep in the worker or
> >    playing with delayed work...
> 
> I think if we wanted things to be more robust (and perhaps there's no need
> to, see above), the best way would be to make the worker preallocate with
> GFP_KERNEL outside of pcpu_alloc_mutex.

Yes this would work as it would break the lock chain dependency.

> I assume it's probably not easy to
> implement as page table allocations are involved in the process and we don't
> have a way to supply preallocated memory for those.

Why would this be a concern if the allocation is done outside of the
lock?
-- 
Michal Hocko
SUSE Labs

