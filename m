Return-Path: <linux-kernel+bounces-177669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D83FA8C42D5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 16:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F2F11F21503
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 14:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBFCE153826;
	Mon, 13 May 2024 14:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDnREElo"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BDA50279;
	Mon, 13 May 2024 14:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715609193; cv=none; b=SzwPi+yhdtw7jJM2ZkIp7ErMwGM3Ex+8ueeRiZYgm8G0JZeeJw/lps0iretTubHeijXXoc2OnqvCc/NyH3JNncbgI9ZNnr6sE59YT7bWHgiZ2eBxfkCCW5S7qEpYmWSgjvNhJ2YGiIQd/t06WK6GSv6/l3RSN6SOTBgPWy36ekA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715609193; c=relaxed/simple;
	bh=SxnE7rnuwXBi3EDidJwQErZKklISfFQ7ftxTwHnECuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=snCVkR8JvT7vVEEKpKX2ZWRZzlKxrReVe708w1unVn1StWkHfu+8Z8jaNj3zTjXhv71p08jWaGtN6KmJWOAJAoMSAr2efqigup8JReOwiTJEr8lqVZDDMiLVYSJRjkkWcQmLz7i053nbm1IyzuMqzpWUujqhwXGH+9SYOTZTcw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MDnREElo; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-792c7704e09so283321385a.1;
        Mon, 13 May 2024 07:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715609190; x=1716213990; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=97qvlrEWAPmxPYorX7UQV2kS8NfIOzG0eHj66y0TAo4=;
        b=MDnREEloq4zsNQVJq2DJJAM63gmZFO240iTiYhQb/cppBcbaRVL32jBgo0QPVklonl
         bG6tx236JHycDZj1emQMFFub1KIlbLsMHNTMoR9cHvr6k0/OG+7HYlZ+W9qzHoNUAe24
         tyTU14PLqT1WGAUMcDdoac/mD9t7Q+bckZ9UtHhdYMGzyotRTos+Byy7043jB94cuOC/
         dYvfVRgDTtOl4vh7xdSFMgdFjD/+Ik1OqbKtrkB5hSQJV6tgEU5kUTD+x1VaSimIT9lD
         rmx211EtI70U6n8mgRRLdb0Kc9RS+hGcpHnpizD032mS0VeoYXvWJX4rJLnvlTuEAU+q
         +Vxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715609190; x=1716213990;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=97qvlrEWAPmxPYorX7UQV2kS8NfIOzG0eHj66y0TAo4=;
        b=lsgdBf1kRlpiXeUfozUp88UIujhre05ti7eNvY38knkNXohS7T+rvDb7kRBWZVMbt5
         vMwxjgP/e2jBiyW9p7Cp9vH09rsfv0hA1J5K+ijOzTmMWRwedloYxJrwgYfzIy5GUbfj
         kpFdHn9S/VRE9/Nq94Rb7KqFoIO2V2rkWz0vliMEA31p1swDd0vHuiwCzU3Dz6Advinw
         aRju6J1si9ll+p/rXFI+uCPjDOLlEmnV6itg1a82YYEAA2rxBgj80n0FcBv1Y/lRm7Zz
         COIaspGBHwa7rIk0qwImMQEFUTJVPKocxuna1myuU/hns7B3rs9RmZlJHJ8tp1C6HiX1
         9hIw==
X-Forwarded-Encrypted: i=1; AJvYcCW0vPuRng+/Eht8OPNvUrAUi0k2vwgYOiwiqMsnQLm+s6WK9lKWbVxWUiRMZR08EyWmTv6q0CWSZhK14Mt1RsVacjBva8Bk9b511ShbJeduYMDykh3onkmK97NpfPx2RwxpbBpAuZbD7QigHOc=
X-Gm-Message-State: AOJu0YxbZQm4RxgPv++W+F//n6LRs95xKU5oA94qwd/G6MPJEX9YkLUK
	cF7n5ZXEYAR18jkm89ZLsgQYWWheXJsHfmbjRtYWf1AbgUJmwcwg
X-Google-Smtp-Source: AGHT+IHcbAWlauuYuu89G0SaL1p+fkjOPQxOioCqkRiv6vcAaQvHx3eeai/M4AoB6cGDSMxsiUENjA==
X-Received: by 2002:a05:620a:4448:b0:790:9dad:ec52 with SMTP id af79cd13be357-792bbdd9cfemr2314253385a.13.1715609190525;
        Mon, 13 May 2024 07:06:30 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf2fc3dbsm458274685a.96.2024.05.13.07.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 07:06:29 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 0FBE11200066;
	Mon, 13 May 2024 10:06:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 13 May 2024 10:06:29 -0400
X-ME-Sender: <xms:ZB5CZkCkp5r9oUYz_3j6oq0jnbPqzovN2yk_NTREEG3SBSWvUCEJvg>
    <xme:ZB5CZmiL6Kk-S22o7ITqtaZbN3qCFSAc4l3jjpLRKbtTWq0w_5pXF64jysInkzcB6
    GvAo7WAh1cH_pF9Gw>
X-ME-Received: <xmr:ZB5CZnkjg_ALpRlpzcLASh4U-ClvgtStNmuOIKbRJhgNbVTAQ-K0_84oc7AayA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeggedgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeejiefhtdeuvdegvddtudffgfegfeehgfdtiedvveevleevhfekhefftdek
    ieehvdenucffohhmrghinheprhhushhtqdhlrghnghdrohhrghenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgr
    uhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsoh
    hquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:ZB5CZqw8JCDBVFs_bmi_FCRulnhBEXP1Y9JwvnYCaoL8g50xLXCphw>
    <xmx:ZB5CZpQhxJCiINKm1sQKqotT2EhfNzGE9fY207e3MnyBP87hHnKY6A>
    <xmx:ZB5CZlbgA6dui3585w5ftZB0cGrx7HRu6cHdlGUvnIgn4QwnbHt45g>
    <xmx:ZB5CZiRaGW550WxK5YAh7ISH7pt9qb-Sv3oqTZs8V9AAtW-1j2rFWg>
    <xmx:ZR5CZjCGqAEm7WMd6eiWbKnfutUoJUEpTvUTFWXqL_0pwLRuP73QDsyb>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 May 2024 10:06:28 -0400 (EDT)
Date: Mon, 13 May 2024 07:06:19 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Miguel Ojeda <ojeda@kernel.org>, John Stultz <jstultz@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>, bjorn3_gh@protonmail.com,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 2/2] rust: time: Use wrapping_sub() for Ktime::sub()
Message-ID: <ZkIeW_NgXFYsAx5M@boqun-archlinux>
References: <Zigj-lY5lnBSKuib@boqun-archlinux>
 <87cypvnpwn.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87cypvnpwn.ffs@tglx>

On Thu, May 09, 2024 at 02:14:16PM +0200, Thomas Gleixner wrote:
> On Tue, Apr 23 2024 at 14:11, Boqun Feng wrote:
> > On Thu, Apr 11, 2024 at 04:08:01PM -0700, Boqun Feng wrote:
> >> Currently since Rust code is compiled with "-Coverflow-checks=y", so a
> >> normal substraction may be compiled as an overflow checking and panic
> >> if overflow happens:
> >> 
> >>         subq    %rsi, %rdi
> >>         jo      .LBB0_2
> >>         movq    %rdi, %rax
> >>         retq
> >> .LBB0_2:
> >>         pushq   %rax
> >>         leaq    str.0(%rip), %rdi
> >>         leaq    .L__unnamed_1(%rip), %rdx
> >>         movl    $33, %esi
> >>         callq   *core::panicking::panic::h59297120e85ea178@GOTPCREL(%rip)
> >> 
> >> although overflow detection is nice to have, however this makes
> >> `Ktime::sub()` behave differently than `ktime_sub()`, moreover it's not
> >> clear that the overflow checking is helpful, since for example, the
> >> current binder usage[1] doesn't have the checking.
> >
> > Ping. Thomas, John and Stepthen. Could you take a look at this, and the
> > discussion between Miguel and me? The key question is the behavior when
> > ktime_sub() hits a overflow, I think. Thanks!
> 
> In principle ktime_sub() should not overflow for regular use cases.
> 
> If the binder example overflows the substraction, then something is
> seriously wrong. Though in that case as it's only for debug purposes
> panicing would be totally counter productive. A warning might be
> appropriate though.
> 

Thanks! Looks to me, a reasonable implementation would be calling
`overflowing_sub`[1] and print a warning if overflow happens:

	<in the implementation of Sub trait of Ktime>

	let (ret, overflow) = self.inner.overflowing_sub(other.inner);

	if overflow {
		pr_err!("Overflow on Ktime: {} - {}\n", self.inner, other.inner);
	}

	return ret;

I will use this as a new version for more reviews.

[1]: https://doc.rust-lang.org/std/primitive.i64.html#method.overflowing_sub

Regards,
Boqun

> Thanks,
> 
>         tglx
> 
> 

