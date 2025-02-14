Return-Path: <linux-kernel+bounces-515252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CC9A36256
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 16:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6C2C1891090
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 15:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905BA267389;
	Fri, 14 Feb 2025 15:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YegUEbz1"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67232267383
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 15:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739548506; cv=none; b=njzSjPFmsIllkEdkBL3EhDTJqU35zuVkq3Mw9Fzwq39bv/DWREAT3K4UmVlLv8QoJrI4oHtEcCBF3Ief/caJIJrHQIAtO7lQ1reBSCLPXcY6L6+JeoFSlsjgTvSgw0qsF1LA8nIMQiiyBz8dLfkoKsRz8ZVsm5SkFoewqUQ4y2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739548506; c=relaxed/simple;
	bh=KFQ/T0ZOHyXnh2QzE10Q52y2wGhJG5fheJVpOwYLPtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q70hxoZla+Tml1ZbLVcep4ZJujD51IR2lk87DU9gspDBIxzGDAW32fHMAEZBlPNckt8avkj1RbDKrVfqVqCIw6/IPLVxh4q0qA3kq7gxenDr4dlMnv5yo3928zfHf40tfKPYK4xBtX7nK5+lXlEGVTjHkM/8L9rC3pcTTi5a2rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YegUEbz1; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6f77b9e0a34so17228487b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 07:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739548504; x=1740153304; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=evB6ag2DB+gOxam6ZcR9tr0ZtaLn6IT+dTVvE/Fs/eI=;
        b=YegUEbz1RZU/cQX1rK85chxXkuHgQXDgXptKb52T+ivR3eUYA1CGm1SJcGJsHm9xfG
         fKFcTkzQz5WHp919vjW+Z/Rqn34jZND7NOqP7Y7QxwgoFYDCj01TtTHfFwvUlNoQxPe2
         GOQOE6F2yQR0bcwnw2TWhsmtYpP3nyQ8KIx8K7mfGbe06+Nfdmkk4UrgzoJ3+LJjmvHx
         VrtIfPoeOMQW0MOKkGGvbUfvMwTX5/IsrlHrbI8iy+R6Lp2Y7FqJU1jGMdenTSpgriC7
         nnZu2KeVWuaHkUZNqu0k+nVwxHRSIUa/sY4653SkhJLmBo01zpBdehzt9yyPMLfhSV5U
         TULQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739548504; x=1740153304;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=evB6ag2DB+gOxam6ZcR9tr0ZtaLn6IT+dTVvE/Fs/eI=;
        b=g72pzNpL28MbthG+5P947IXKxBTO1HPcPS024cu4uM8ncZLdUao+PVcuPRKXg1fAfx
         GmMgy4YiwkDwxeAAwRxkWdL4ZO+Ml0a3S2DREsjy3WeT3KRADtlE7zCRp8Sxtm+U4ZcL
         6S1mDu+xScx+0Wh5/cbRqh9WlMuH6z+ppMoSol9hV69mKZbLi5ZHhCVTfh7+npNyefqv
         uSWy0WGVGhQo9/h5EOHcYJ8ojcpCTBp99UX0tBJD6iiinWgKpduT9ONC3jHO++lGilhd
         Ts/IQoamtRNprnvZ67zdRsXbbpemEeIGAf/mDOGAcZUCf/98flybemzTw04N0oPgYk70
         v0EA==
X-Forwarded-Encrypted: i=1; AJvYcCXffdiGrhSAaKWH6Ha8x0Ntb1SLCXPZGEJFDOyjUBtYYCpvXuNrEj0vjspxFcw+4b4SHbYWT0OKKq9wQLg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy37KH5gAEnGMu4e7VAGzCJfFV4eqM9LAE3Q6fptITbCZw+uPJw
	Q6v9elYiEqXu30iRNn9GQ9DmfoT+X8bzOd38rs5bBm8hJLdlgTJ3
X-Gm-Gg: ASbGnctN9WLKgSP37iJ2y6SzYhfUg1wnD58ddu7ouaQsyK90AYv9YaLYZv5UKL6qH4A
	8KfzFAQXwPm283u2v29cFlmXzwcQKW0n/VN3QYqek5mEuEj68ZvwWu+Eeb9BfrCTQf3bMjjId2s
	nF53b42WRo4bnhSrcbZO7lEPp9079sRyuGp+oM4C7rGAoAxx/DOUkeBN6zyvB9MRXLsR9v02E8P
	4YMyC+o5qQ/yjXopXJe7PpalDpsDl1RZP3MPm6Xg59BZZ1ETYGPLEkr2/o0nuFV7+u83gcjQN0m
	AtnPIeW43ji3bOv2RR23F4P+r0eREmdLvGOrWQEQsCAjXkJT4+k=
X-Google-Smtp-Source: AGHT+IHBcflInclaycbNmc/as0HdvWTK8FU+u6idF7euvCZ8vEc1EQG2RhQrz+5S3KclxOzi2WotXQ==
X-Received: by 2002:a05:690c:a93:b0:6ef:6536:bb96 with SMTP id 00721157ae682-6fb1f19ba33mr124466497b3.10.1739548504120;
        Fri, 14 Feb 2025 07:55:04 -0800 (PST)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6fb3619cabcsm8078097b3.74.2025.02.14.07.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 07:55:03 -0800 (PST)
Date: Fri, 14 Feb 2025 10:55:02 -0500
From: Yury Norov <yury.norov@gmail.com>
To: I Hsin Cheng <richard120310@gmail.com>
Cc: anshuman.khandual@arm.com, arnd@arndb.de, linux-kernel@vger.kernel.org,
	jserv@ccns.ncku.edu.tw, skhan@linuxfoundation.org,
	Matthias Kaehlcke <mka@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/2] uapi: Refactor __GENMASK() for speed-up
Message-ID: <Z69nTow0iaZIeV85@thinkpad>
References: <20250211162412.477655-1-richard120310@gmail.com>
 <20250211162412.477655-2-richard120310@gmail.com>
 <Z6uZZPpQ9YYfrL-I@thinkpad>
 <Z6uaW9XzaKjSrWYC@thinkpad>
 <Z6ypqCN_KI2gaSJ4@vaxr-BM6660-BM6360>
 <Z65N81jXcyKIu95l@thinkpad>
 <Z69YYeQB5E5Mi3Jf@vaxr-BM6660-BM6360>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z69YYeQB5E5Mi3Jf@vaxr-BM6660-BM6360>

> No problem ! I'll be happy to help with these tests, I'll send the next
> iteration when I complete the things you mentioned.
> 
> > Is this for_each_cpu() thing the only case - I don't know, but it's
> > enough to consider reverting back to the original version.
> 
> So basically the reason of sizing up is because for_each_cpu() put
> non-constant parameter in GENMASK(), which is supposed to be used by
> constant only?

The (l - h) is supposed to be a const_true. In most cases both l and h
are compile-time constants. In that case GENMASK() is evaluated at
compile time, and it allows to complicate it to workaround clang
warning.

But now we obviously have an example where workarounding sacrifices
code generation. This is not OK.
 
> > Can you also please attach one or two examples of code generation for
> > real functions, not an artificial one as you did before. And maybe a
> > link to goldbolt?
> 
> I have no problem of other tests but this one, I wrote a simple
> artificial use case because most functions I found according to the
> report generated by bloat-o-meter, doesn't use GENMASK() directly or
> they're super long and GENMASK() only accounts for very small part of
> them, it wasn't very trivial to sense the difference of disassembly at
> least for me. Should I just pick 1~2 random use cases? or do you have
> any suggestions?

In bloat-o-meter output, pick some small function. The function size
is listed in 'old' and correspondingly 'new' columns. To begin with,
pick some with small difference. The cpuusage_read is one good example:

        cpuusage_read                     111     109      -2

It boils down to __cpuusage_read(), which is:

  static u64 __cpuusage_read(struct cgroup_subsys_state *css,
                             enum cpuacct_stat_index index)
  {
          struct cpuacct *ca = css_ca(css);
          u64 totalcpuusage = 0;
          int i;
  
          for_each_possible_cpu(i)
                  totalcpuusage += cpuacct_cpuusage_read(ca, i, index);
  
          return totalcpuusage;
  }

Now disassemble it like:

objdump --disassemble=cpuusage_read ../build-linux-x86_64/vmlinux.orig > cpuusage_read.orig
objdump --disassemble=cpuusage_read ../build-linux-x86_64/vmlinux.new > cpuusage_read.new

And if you put the listings side-by-side, you will see:

Orig                                              New
ja     ffffffff812efdf0 <cpuusage_read+0x60>      ja     ffffffff812efd2e <cpuusage_read+0x5e>
mov    %r8,%rdx                                   mov    %r8,%rdx
shl    %cl,%rdx                                   shl    %cl,%rdx
neg    %rdx                                       and    %rax,%rdx
and    %rax,%rdx                                  je     ffffffff812efd2e <cpuusage_read+0x5e>
je     ffffffff812efdf0 <cpuusage_read+0x60>      tzcnt  %rdx,%rdx
tzcnt  %rdx,%rdx                                

OK, now we see that new GENMASK saves one negation. Great success!

Can you repeat this exercise for few other functions both with
positive and negative impact and make a conclusion about how exactly
code generation is impacted?

> Btw, are you talking about Online Compiler Explorer? I don't really know
> what goldbolt means here, sorry XD .

https://godbolt.org/

The idea is that you can cherry-pick all necessary ifdefery from
kernel headers and build a simple example by using all supported
compilers. The godbolt's list of compilers is really long. You
will not need to install any of them locally to just check how
they work.

I actually cherry-picked GENMASK() recently for the other discussion,
so you can start from that:

https://lore.kernel.org/all/20250206020227.GA322224@yaz-khff2.amd.com/T/#m27bed06e15809d7b632966a1e861767c72a8722a

Thanks,
Yury


