Return-Path: <linux-kernel+bounces-420374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41EDF9D79A6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 02:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFBC4B21EB4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 01:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14DEBA38;
	Mon, 25 Nov 2024 01:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="g21e3ci9"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B6D2114
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 01:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732496564; cv=none; b=m11rlPhYez5DdUwQz5PQWpkM+/vG1O+aNUzYkv7ncSvsd3vxZosbWfeGNv4uDLRjmzK+mEnMHxQhky+/L/K9A9+XHY/LlecVf1DtV0yKlE4Oqyv/rVeBMflB+nAnjTobXj+DtoalTAlbaqYcnMDAZQIoGK6xOifI3tfPhsxCq8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732496564; c=relaxed/simple;
	bh=XNnjvCac9bWvQR/zH0IRaOUupHheXR6b5klmQQutxzg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QauJn4Rn7nB+3aygBj3Xm1nCYwWsxFp3d8Ksv4pcZBVLaMkk3s82jginIptccymj7UA4Z9ImCevwVeEPQ+8Erz5x0R0LMAs2jkotc3H/HjxJ3LdaIhlQoxos0ehJhmSVn9DiwJaICSNO8KwxpecMiMrH1FQDQDjyuRwCxbw6G/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=g21e3ci9; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5cedf5fe237so4702792a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 17:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732496560; x=1733101360; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3j9lfAM66cU/k+3UrceC9HJcVhxEaG6X/8s82jLLoQE=;
        b=g21e3ci9qhWUDfYd+ClaHl9o8FslkEI/rlMtM/sAXXgIeIM8QmGp5BLkityedAnxzT
         anCtJGQIdmA3btIIWdbV6UVO9lrRzNv1cYXoBTSKlfeTmGgrmxGd99WXn1xTzAFHpIqL
         S5Ev/5T4JyjG7C2XKKuXqS2k45anQwz5fJxCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732496560; x=1733101360;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3j9lfAM66cU/k+3UrceC9HJcVhxEaG6X/8s82jLLoQE=;
        b=gyMpZtcLKAmrr3JS+9lQrXKBeYPUgn14ybRKKfs5A0AIQGxc5jzYe75DMCH5PmgG8S
         sBUBpD9/MnZPaE56LjKriU51v1EXopPqJhG2vNh8vSDy2Ay2scBrhJ7y678iDJmb1u5J
         76X+fsOfK46FiaKsG3K0PHzUQ3+X7TRFwpcFsokc/i0V3/46I6b0cuGFC4VMyYaUtWS0
         YOlTix18fxLBIig+oZZPz6xm9NKSxjO4+bpnxpRRnw6MHOm5DmD+1rjGv+K9xVF14RMi
         LbkGTAtQA6Q30VyKdQZwFa9mvfacq+Kx4u9mL7ZC+FuUEm7TRSZ0x+YH5C7DOmKFc248
         20eg==
X-Forwarded-Encrypted: i=1; AJvYcCWxuK00Eq+GqlLXg9y0NdkIURmUziBm5hUKiXQ195GEASLL9DFLeoSgrdB/h5QnSu/u3/vk8OB2r+Try9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZvCyNqfsvBt8Mm9ge5gau10W1u0b1FO503xj9b0Q1H82gdinf
	L6bHZRvvEMFjfyt817/fsw1eqWDNc5dO2+IudlhbP7QuLRYeN0/hZUg9GFGjsdamEc932X8BLU8
	KfgfMGA==
X-Gm-Gg: ASbGnct8aP04L+QB9pS+57JGYjAjDkZfXBKYhfNFiZoquPWV1vN4zOckrZNF7gQfWRn
	mh7Pkoh0kh6qIhjVqYcXPJvRHUG6jwHtzhsjdZu0u4lwgEDjmG5x9H8R9/f6+CezSc4eWI+mKiw
	MyCAxZ754f4KqnsCptYNz7VIlKpx/dniQhZ554NXKY/lDt1BQA+T8aWkrZDpeGBcDk+NrI6D3vU
	pK81zsjqWAo/jI5+34q95/ngSfpux6iUHMCrhvf5tgr1hHcN6+A9+Uas4/WAoKXbwgSA+6WTt58
	hhfSdarYg8QBw3VxZiSLWpPd
X-Google-Smtp-Source: AGHT+IGkhhNIlvaYHuktyfDYxJb+u2pbOc8VlnBWuejJJjQZV7pk19LHUkz3UWQh8TAKpCvGkJua/Q==
X-Received: by 2002:a05:6402:5256:b0:5ce:bb32:ccac with SMTP id 4fb4d7f45d1cf-5d020695138mr8049245a12.26.1732496560236;
        Sun, 24 Nov 2024 17:02:40 -0800 (PST)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d01d41aea8sm3497094a12.85.2024.11.24.17.02.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Nov 2024 17:02:38 -0800 (PST)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aa535eed875so216528066b.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 17:02:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWKVuY6iO9xEuH1wD2M9Z71FURW7fRLPzqlZEcUcmMoAiYU87ci3XiPCyNJk4DKgez89UBAzNMNI5Z6pbk=@vger.kernel.org
X-Received: by 2002:a17:906:3293:b0:aa3:49b6:243 with SMTP id
 a640c23a62f3a-aa50990b336mr650184166b.9.1732496557620; Sun, 24 Nov 2024
 17:02:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <61292055a11a3f80e3afd2ef6871416e3963b977.camel@kernel.org>
 <20241124094253.565643-1-zhenghaoran@buaa.edu.cn> <20241124174435.GB620578@frogsfrogsfrogs>
 <wxwj3mxb7xromjvy3vreqbme7tugvi7gfriyhtcznukiladeoj@o7drq3kvflfa>
 <20241124215014.GA3387508@ZenIV> <CAHk-=whYakCL3tws54vLjejwU3WvYVKVSpO1waXxA-vt72Kt5Q@mail.gmail.com>
 <20241124222450.GB3387508@ZenIV> <Z0OqCmbGz0P7hrrA@casper.infradead.org>
 <CAHk-=whxZ=jgc7up5iNBVMhA0HRX2wAKJMNOGA6Ru9Kqb7_eVw@mail.gmail.com>
 <Z0O8ZYHI_1KAXSBF@casper.infradead.org> <CAHk-=whNNdB9jT+4g2ApTKohWyHwHAqB1DJkLKQF=wWAh7c+PQ@mail.gmail.com>
In-Reply-To: <CAHk-=whNNdB9jT+4g2ApTKohWyHwHAqB1DJkLKQF=wWAh7c+PQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 24 Nov 2024 17:02:21 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgECCWJvNiFURP-jCHFhsYSB3wS5suFLvfMC56OYxFJEg@mail.gmail.com>
Message-ID: <CAHk-=wgECCWJvNiFURP-jCHFhsYSB3wS5suFLvfMC56OYxFJEg@mail.gmail.com>
Subject: Re: [RFC] metadata updates vs. fetches (was Re: [PATCH v4] fs: Fix
 data race in inode_set_ctime_to_ts)
To: Matthew Wilcox <willy@infradead.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Mateusz Guzik <mjguzik@gmail.com>, 
	"Darrick J. Wong" <djwong@kernel.org>, Hao-ran Zheng <zhenghaoran@buaa.edu.cn>, brauner@kernel.org, 
	jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, 21371365@buaa.edu.cn
Content-Type: text/plain; charset="UTF-8"

On Sun, 24 Nov 2024 at 16:53, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> and look how the reader is happy, because it got the same nanoseconds
> twice. But the reader thinks it had a time of 6.000950, and AT NO
> POINT was that actually a valid time.

And let me clarify again that I don't actually personally think we
should care deeply about any of this.

I think the race is entirely theoretical and doesn't happen in
practice (regardless of the "re-read nsec", which I don't think
works), and I don't think anybody cares that deeply about nanoseconds
anyway.

The "worst" that would happen is likely that some cache that depended
on timestamps would get invalidated, there really aren't a ton of
things that depend on exact time outside of that.

Also, fixing it with the sequence count should be fairly low-cost, but
is not entirely free.

I wouldn't worry about the writer side, but the reader side ends up
with a smp_read_acquire() on the first sequence count read, and a
smp_rmb() before the final sequence count read.

That's free on x86 where all reads are ordered (well, "free" - you
still need to actually do the sequence count read, but it is hopefully
in the same cacheline as the hot data), but smp_rmb() can be fairly
expensive on other architectures.

              Linus

