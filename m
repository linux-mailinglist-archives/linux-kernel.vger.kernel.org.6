Return-Path: <linux-kernel+bounces-424189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD609DB175
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 03:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4DB8B21421
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 02:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6FD433B1;
	Thu, 28 Nov 2024 02:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EYsunvdg"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A747B18E25
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 02:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732760688; cv=none; b=kXSoxtXyAiwWbCYa+P1cfYXUC/YCscQWYObE6E564SUtkeNSeEwaS+IKLvg5MZGf/rhCn66qn5DkUVHQxINRbavoFIU32LUjoRiVvLw8Huz7ij1IjOlJWqlop2BhIrU/LSA7MqGkREbSa/Sh0Vw0jRGeDGs8qqyjsSQq1FHAqwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732760688; c=relaxed/simple;
	bh=N0W3okzumZz4TO8+qDmG24KUaroSYe2aOImwtPOd8/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d9q8GPQiy1SeTPPef/hmiFRAAUBgM8SdrEsVapcA1nUV8tvpGH8JpLXDtOS5XOaHx5htfMuXdRqGFkoTcIpylycj9zo8EsLl0IgsDj/g4fM7fvKPaE44MKtuq7SJ5kN9Pp6nz9tByl5JWBQ9Hehq9t5mEb+/btzeIIqKdEs/8gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EYsunvdg; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5cfa90e04c2so377111a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 18:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732760685; x=1733365485; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z9Ph7RhIXjSqmMGkNKkbJMg6kBOtyd1H90lMnAwSrow=;
        b=EYsunvdgP8u/1VjrFlfJFEMDaVGnJVadtV8eDYGgmA6OigVI+1RpW3C/kmrGoAdrnP
         jDFeXebyujiYHygdBh9ZoJo3KdkAJIzQvcvJNKK6nUOft0Vy3SPQv6jGHHAV5amutcC1
         YR2d5BJSvZDBI1b1wV9zi1TX2psz7257DcDn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732760685; x=1733365485;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z9Ph7RhIXjSqmMGkNKkbJMg6kBOtyd1H90lMnAwSrow=;
        b=X2qBlccPQuyMXslTDthCsZUfBUlyy6VvTYN+unxlPwsWMnxqQy4dP28GZ5+lggyj4z
         FVNaKg94Uyh6nCl5gNG63ZyMfper2VDf9wEOKvAX7g7Z2/LSmag/FITT5gVSqIQfFhdV
         KsGOB1OfFlw9UaF83ok3IXaw/Q2G1mmGUOHd6vY5CKg+3ZamCYQ9xb89kVpHJNA7pbVd
         NuA0YQRtzwNuYRnsn2trot5g5BY4T723HV2nfjZT3jAefbhdi/LwLlVZDOBRG4astu55
         cGK63jCEtpAoq/KNj1jtkKX1kj629akvOw8FsPoJvuUGo0l2je1JAuX3xu8XLuF8gNMp
         XqhA==
X-Forwarded-Encrypted: i=1; AJvYcCU+EezGaWzAef3JwCV08ZvJSlzsJKtHpkXQjPIa6qFHslbmzLQbyego+bU4XiIT2BnP16AZwAPtFU4wdEs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0UW6S9sbN+6PyTo5trfUgb3iAt2b12LdiNqlNkPQsFA+68/Dr
	pbWCAGy8FHNaAAePqClMh50wFLOUNwRj7S+WfV0p/wK19hw+BrCivtuXcB7yaRkPl34Dbk6cgKW
	Pkvg=
X-Gm-Gg: ASbGncvy665oupuQPw6A11umkqIAuHQnyS/ri2tYXDEuVv5FCTSxAHIo+ACGei4mqa3
	ALANTULAfhAPPQNKnvR7uV0aBJexWdxvnH3qoOpGr85QmHnZ+o3qTR4neMfSOftqIpVtMPpJj3m
	BgftFrQ0uzzUpIB3G+c2MQXAjBo7XxB0p2+3HzqKPGaESYeSih8CwmZi76mAes7oCIoc9rZuMI9
	SnwiK8QbUta/OU9LrTf704qs5OTIfg9JqoyyGPoD74UXnL5U9gXFuxcA1BMcPLtzH9BtwYFd6tc
	+SJh4bS8KkZ35do5Rw6moKwR
X-Google-Smtp-Source: AGHT+IHqSYikF7mbhPmhp9nqAZMug7ve4FlTNfbj/9RuSYuBkLnhtCdDKggUY4saG5apqtOkSEBOvw==
X-Received: by 2002:a05:6402:2710:b0:5c9:62c3:e7fd with SMTP id 4fb4d7f45d1cf-5d080bcd250mr4765912a12.16.1732760684702;
        Wed, 27 Nov 2024 18:24:44 -0800 (PST)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d097dafd48sm237886a12.22.2024.11.27.18.24.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2024 18:24:44 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aa5302a0901so34561866b.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 18:24:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXccj8Gap5Ed+LCuQGpDT67axqzUUHx3wy1nXEK+Hzgmfq9RDeOJpgHSUgm2rEvcujEZ6F/ncRjVxu0YB0=@vger.kernel.org
X-Received: by 2002:a17:906:1bb1:b0:aa5:2e85:3b04 with SMTP id
 a640c23a62f3a-aa5810739e7mr351910566b.50.1732760683133; Wed, 27 Nov 2024
 18:24:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202411210651.CD8B5A3B98@keescook> <CAHk-=wjMagH_5-_8KhAOJ+YSjXUR5FELYxFgqtWBHOhKyUzGxA@mail.gmail.com>
 <05F133C4-DB2D-4186-9243-E9E18FCBF745@kernel.org> <CAHk-=wgEjs8bwSMSpoyFRiUT=_NEFzF8BXFEvYzVQCu8RD=WmA@mail.gmail.com>
 <202411271645.04C3508@keescook> <CAHk-=wi+_a9Y8DtEp2P9RnDCjn=gd4ym_5ddSTEAadAyzy1rkw@mail.gmail.com>
 <20241128020558.GF3387508@ZenIV>
In-Reply-To: <20241128020558.GF3387508@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 27 Nov 2024 18:24:27 -0800
X-Gmail-Original-Message-ID: <CAHk-=whb+V5UC0kuJkBByeEkeRGyLhTupBvpF-z57Hvmn7kszA@mail.gmail.com>
Message-ID: <CAHk-=whb+V5UC0kuJkBByeEkeRGyLhTupBvpF-z57Hvmn7kszA@mail.gmail.com>
Subject: Re: [GIT PULL] execve updates for v6.13-rc1 (take 2)
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, "Eric W. Biederman" <ebiederm@xmission.com>, 
	Nir Lichtman <nir@lichtman.org>, Tycho Andersen <tandersen@netflix.com>, 
	Vegard Nossum <vegard.nossum@oracle.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Nov 2024 at 18:06, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> > So if pathname exists and isn't empty, AT_EMPTY_PATH does nothing.
>
> ... so let's tie that to pathname _being_ empty - it's not as if it
> had been hard to check.

This is not some kind of new system call, and AT_EMPTY_PATH isn't some
Linux-only thing.

It has well-defined and documented semantics:

  AT_EMPTY_PATH
     If this flag is specified, oldname can be an empty string.

Note the "can be". Not "will/must be".

> What's more, let's allow userland pointer to be NULL - use getname_maybe_null()
> and treat NULL returned by it as "we have an empty pathname".

Now, that's separate, and I agree with that extension.  That just
suppresses another "empty string" error case.

But no, I do not accept changing well-documented behaviour of
AT_EMPTY_PATH, much less the insanity of making "execveat()" have
completely different semantics for AT_EMPTY_PATH than a plain openat.

             Linus

