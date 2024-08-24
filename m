Return-Path: <linux-kernel+bounces-299834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A65F95DAA1
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 04:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B93D81F22CC0
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 02:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF8DF4ED;
	Sat, 24 Aug 2024 02:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YwL2qKBU"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918C3847C
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 02:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724466323; cv=none; b=Hob6lpJFxh5KK64Nv3mrDc6NUADjY9Uq71KLj1QhnqXvlR+H2eqH3W1ONYprRxsC4b+8oKKg/0xb5UTFRSNWUlwF90W2ix2v+eIkMff8oV41xjBM9PIzzJMkR4oJ7QKYjuRzUasd3JOx6mPai06VosAnB08sZ5aSmPyX2uLYA3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724466323; c=relaxed/simple;
	bh=Qqf15j6v2yiLLe8CF3OCSjA/vKpAkg09Fp7KgnUeagw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LnoWU0Mdh/ryKCnMIpCBC6vOF8KMC3BWSKzRe4XBpvoF86vW1Dfhjqkyt3pCtLb9he6DZt+NswwERmPxU+C+aqUicRWYFd/pLhrEA1qNO6XByayAlIlMvMkLbp+UbVLr2iApUbeSeJ11y+jM8zjC571D8TszEhLTiZgl1mB8cUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YwL2qKBU; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a8695cc91c8so273245366b.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 19:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1724466320; x=1725071120; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2xKPzNyZISPiEHK/cpzIhG4H3Lo5I0AHNFIjgfYtaa8=;
        b=YwL2qKBUS/r0SNnrw7mB1sx0+KXpvOHNmsKeM/YQpjspukQlK5OPy6fey2wtH75G7o
         HVgb2GTQ4UbICMTLrgAugiDZp3P7KtLTMrg+k8tGbzpFghJ9o0I7E88pV/JwMSDNkLm7
         okK21cPYeqmfUptWTPIJ1/O8YWU3k6GXW/POU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724466320; x=1725071120;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2xKPzNyZISPiEHK/cpzIhG4H3Lo5I0AHNFIjgfYtaa8=;
        b=GUjWniAve4lbjkggazZ6+3ityBRM8MG4tNujvah3gkoo7NrVkB3Sr3maIzWdINhFae
         xCDy4e66Ye2Tik7eL8PXSms4hUioQ1FlIkgmVKergN9gxlH5VLs0qyE5pj1AyZnqh/HI
         OIfXcYZ1hQLuW+yH5IovanDA/NsDMMxsmbUNTd5LvdIW/OJw/M/29eRk6CBSsfFiMBqR
         kjhLuuHBzn89Rm7+uwue7yAGh7WJqqsrNcD3F3KAhbSPjvyQHZ5rVpCrlKwSoDUR9BwZ
         X4wIYR1DpRHXFH9icaCwSMSyXRQIPGZ2iRBbkZUzxgFrriSYEQ0Lb64VpRvqJYudWZ6t
         HMGA==
X-Forwarded-Encrypted: i=1; AJvYcCVQXPOx8yLOjSuQR/wXJQfD2wrmSqzivkSqL+XcFAn4CjnMAlj2XDgw23ub6X1sYrjK9awdSCojP2HVODo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEhGNRUP/A6g5WISkKFfNhu156TFFmau8hMb/S5G4hFqiIyeZ+
	x99hEaw1mwshzovd3bS+9P28Rfkl82Yzn6Jjih3WiSLlf+8KhCBNY3Nupa44IUWWHVyH8RWQPjD
	lRD9ZRA==
X-Google-Smtp-Source: AGHT+IHEtDkVM5HbKYofMqAWgXDOhB5C59js7i7rnBzimHmg9D5+kwozbaPRr1uTFYX11zotx6TSPw==
X-Received: by 2002:a17:907:7e95:b0:a86:668d:c0b2 with SMTP id a640c23a62f3a-a86a5189298mr370792366b.7.1724466319339;
        Fri, 23 Aug 2024 19:25:19 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f222af5sm339335566b.41.2024.08.23.19.25.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 19:25:18 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5bec87ececeso3101756a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 19:25:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWnuxnUTVq0YeUXF4cIRq94jVw96qcOpszllTgp2wVUX06lHQFEcmSBLVCm+o/39iy+mwxqqDl1zXQ5K1I=@vger.kernel.org
X-Received: by 2002:a05:6402:43cc:b0:5bf:8f3:7869 with SMTP id
 4fb4d7f45d1cf-5c0891791e4mr2666131a12.21.1724466318472; Fri, 23 Aug 2024
 19:25:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <sctzes5z3s2zoadzldrpw3yfycauc4kpcsbpidjkrew5hkz7yf@eejp6nunfpin>
 <CAHk-=wj1Oo9-g-yuwWuHQZU8v=VAsBceWCRLhWxy7_-QnSa1Ng@mail.gmail.com> <kj5vcqbx5ztolv5y3g4csc6te4qmi7y7kmqfora2sxbobnrbrm@rcuffqncku74>
In-Reply-To: <kj5vcqbx5ztolv5y3g4csc6te4qmi7y7kmqfora2sxbobnrbrm@rcuffqncku74>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 24 Aug 2024 10:25:02 +0800
X-Gmail-Original-Message-ID: <CAHk-=wjuLtz5F12hgCb1Yp1OVr4Bbo481m-k3YhheHWJQLpA0g@mail.gmail.com>
Message-ID: <CAHk-=wjuLtz5F12hgCb1Yp1OVr4Bbo481m-k3YhheHWJQLpA0g@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs fixes for 6.11-rc5
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 24 Aug 2024 at 10:14, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
> On Sat, Aug 24, 2024 at 09:23:00AM GMT, Linus Torvalds wrote:
> > On Sat, 24 Aug 2024 at 02:54, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> > >
> > > Hi Linus, big one this time...
> >
> > Yeah, no, enough is enough. The last pull was already big.
> >
> > This is too big, it touches non-bcachefs stuff, and it's not even
> > remotely some kind of regression.
> >
> > At some point "fix something" just turns into development, and this is
> > that point.
> >
> > Nobody sane uses bcachefs and expects it to be stable, so every single
> > user is an experimental site.
>
> Eh?
>
> Universal consensus has been that bcachefs is _definitely_ more
> trustworthy than brtfs,

I'll believe that when there are major distros that use it and you
have lots of varied use.

But it doesn't even change the issue: you aren't fixing a regression,
you are doing new development to fix some old probl;em, and now you
are literally editing non-bcachefs files too.

Enough is enough.

                   Linus

