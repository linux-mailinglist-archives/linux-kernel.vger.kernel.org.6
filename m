Return-Path: <linux-kernel+bounces-375239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 999BA9A9392
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 00:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ABCA1F22E14
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 22:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C031E1FEFC9;
	Mon, 21 Oct 2024 22:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Zq7l6w9s"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C211E3DF4
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 22:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729551395; cv=none; b=oGRXhdKAeQjk3pnwvRMuzM4bRU8S0BaoibIl/hPawas+MCUKBdgagtx4DFA+lxGA60g+iGKlGBNi7Y8LYO9Pk2WT/dAeyRaH5CEwABPdt+q4pcaGySuQYfBWQxbpN1sZHJiN4e7mJAfU/gWR1ODpVPA1l+6YWCQVpuUQc0sim6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729551395; c=relaxed/simple;
	bh=r8egg/Vf14/dqyN4kV4AetN5NUQl2M/4KMeQDZE3hfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fKy8LdI7MUsJXXngPjmS7uyxyu9yF/biQTlzr5GSmiLYHxkpRhXetmLLaeNorXqXQo+KWDT7vKR3e85pM9d7sLkIM5FE832kFMhCu9Wj6iuQ0xeJDqehrf5FxF366uqgv6HZGxTtQt0PUrzlJzoVFtW2cBIcTN/CZ6unkGnoW78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Zq7l6w9s; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c962c3e97dso5980722a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 15:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1729551391; x=1730156191; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lGZ24lUdsgbUdWUq48cY+ttuhX+8F11TIe0DlZ2JCjI=;
        b=Zq7l6w9sLpgxsSBBbWAyd7Unz+ET64C4iYrrK14GkbdSsPrmYXLm9lROz6bcFfEK0O
         VeKhkBzSLfp7fjcUfZFmgIKBKiZrEOjkfkDY2vXAr65iDn6IEepPkzirZLyKyjZAq0ue
         1Hhd1yX8mKpcC12JSRKmvmW+UJIyeJT13cVk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729551391; x=1730156191;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lGZ24lUdsgbUdWUq48cY+ttuhX+8F11TIe0DlZ2JCjI=;
        b=K4khCCSaf2GfgAaYyJg0uq8plH1OCktNxVgb2DPfyt4j/W8oaYN5SBpn4ber8DLCDU
         L8Hry/n9dSxdT0PCthv7+4DusI6pQtGBzT5XStBSilZ8DvpfTJa8mLLGSz4xF540LxIZ
         9DKS9IZeMZU2IdQL4L7eFhDa3jTQ00zryndR/EzVcAjw4Q/v0PBvd3wds/8gEYNlEtNq
         EKgqFoghWKoAsWHKbhAKiPYzrVjDNnKOPsuIN9g1XEMoYtedYlhJJANuJHkry6k/6n7p
         AIqi9MQ1tPcKjQFLfsXOPD0au68vtDH7/IuDHSZWRtgCQIkhIY2BD8p8Zibu9Mon45I+
         Y11g==
X-Forwarded-Encrypted: i=1; AJvYcCXth2X52z3c004igkC3eg4LrSobGxIT8tKjLm6mmpVctRnWO84ScQ9E+Ki97Ye28pN28S2c97Rfqe0mA18=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzlJK28xGKiOMr2GNFigR4YRFDCQ+QBPH4bnze2hlyBt2OKCCB
	m1GBj0i/qQZH5BVTWHuEJF3Qi3awOkjppgVobbla6TjWIjqNL80RHprUm0IOPv76Y/6hiXl9m8/
	FJ6A4zw==
X-Google-Smtp-Source: AGHT+IE27H9PV/GgQpnKPg+nE1VXI7rzA/Srg9f2bOnlq9dO9HUbkSH/YmogWmzki3Z/9LZaqbZtpA==
X-Received: by 2002:a05:6402:234e:b0:5cb:6b86:82d with SMTP id 4fb4d7f45d1cf-5cb7fdcbd21mr276482a12.36.1729551391391;
        Mon, 21 Oct 2024 15:56:31 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cb66a65419sm2422276a12.25.2024.10.21.15.56.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 15:56:30 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9a0cee600aso630981466b.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 15:56:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW1oddYkN2XNuYKGBzPKdDKJkMWoDQvSx34rx4fkES7v4WxFLn8x+GsP2qUlqJ8fEZPnSYkTIv5FKPqUJw=@vger.kernel.org
X-Received: by 2002:a17:907:31c2:b0:a9a:66a9:2c55 with SMTP id
 a640c23a62f3a-a9aace25cb3mr45947166b.6.1729551389933; Mon, 21 Oct 2024
 15:56:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZxZ8MStt4e8JXeJb@sashalap> <xhjzj6kfgg2dxq6swurwaeyzqtd2sl4dat5pzg6jolirw5og6z@bmwdcuwsf2bv>
 <ZxavDApnkMl2xZNA@sashalap>
In-Reply-To: <ZxavDApnkMl2xZNA@sashalap>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 21 Oct 2024 15:56:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjDo9gr8gD+XcWBjvNCSZg=GbmfqtM13o0tAtWrGY8zQA@mail.gmail.com>
Message-ID: <CAHk-=wjDo9gr8gD+XcWBjvNCSZg=GbmfqtM13o0tAtWrGY8zQA@mail.gmail.com>
Subject: Re: linus-next: improving functional testing for to-be-merged pull requests
To: Sasha Levin <sashal@kernel.org>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, ksummit@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 21 Oct 2024 at 12:44, Sasha Levin <sashal@kernel.org> wrote:
>
> On Mon, Oct 21, 2024 at 02:36:39PM -0400, Liam R. Howlett wrote:
> >
> >Would it be difficult to catch branches that change things outside their
> >scope without correct SOB/RB/Acks?  Asking for a friend...
>
> Up to the guy in charge... I don't want to attempt and monitor a policy
> that won't be enforced :)
>
> If Linus wants to add this to the workflow (which is doable), then an
> explicit ack would be great.

Has this been a huge deal?  There are things like ABI changes
(function renames, dropping or adding arguments etc etc) that will
inevitably end up tree-wide, and honestly, it would often be totally
frustrating trying to get acks from every maintainer.

Is it hugely common? No. But still, I'm not convinced there is a sane
model for "outside their scope".

I mean, sure, if the change comes from an individual driver or
filesystem or something like that, then it generally has no business
touching anything else. So it *can* be an issue, but I don't see how
to sanely automate this kind of thing without it becoming a potential
huge annoyance.

Maybe other people don't mind, but I personally hate false positives
that you are then supposed to ignore when appropriate. It just makes
people ignore the things they *should* care about.

                 Linus

