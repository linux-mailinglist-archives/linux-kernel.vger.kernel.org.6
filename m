Return-Path: <linux-kernel+bounces-225465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65FF19130D7
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 01:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 968741C20BB9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 23:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F058A16F8E4;
	Fri, 21 Jun 2024 23:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QqGJqM+w"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F97016F0C5
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 23:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719011943; cv=none; b=hyGYv8kwlHPfNLUlG0cscs3z4qhiHHb0Da6/3CjvOHUmP1x5NgksQ2y3YO9bV0COKe/VARaP0+JZqP862l4iH5aqtFKsVwIQiit+pDu5XnZ6pvcDQu711QlDsFoVnQzi0n/uO8lv0xomqU5yhRIf6OOi4hpZGTnmAqeHUFVE/cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719011943; c=relaxed/simple;
	bh=Gn3DJb+zESEJBowNLklC/dB4nSSMSWXbRChavmZhQhU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RmAN926sHCRnYbkRdNcGwvG2Eql5oyv5QkAUM1AOQCm8aezZwTQfVKdAWeXm4EJcNZXA356t6mXtTUYj4S6LTjP16rfyRgp9Tu/kfFLuGNbD8y1z03ODB5ErT8NHeGJ2mGBObl3WjyN+B45XvDQ9BUnGt3FvFlcYGbMbsZ6Xvyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QqGJqM+w; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2e72224c395so26336531fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 16:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1719011939; x=1719616739; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a2rnkJTBDtNIKWQQ680DNdljrfWh8lccsRjNGx9v3JY=;
        b=QqGJqM+wbL+wHdDaHSMKgpxw989b1Gc+RpxiFSHorpUOQtJZgU7HMg6loAByvfBl5+
         PKYBh3wCfZEJxlpB/1q6R1KZzOzq2tnkSrxVmVxJyyQobzT8TyfxtU4qlaXpap7muKw/
         TVPd4zkDtpcZOiRHyKKvFqBPqUykgbrXOMVkM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719011939; x=1719616739;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a2rnkJTBDtNIKWQQ680DNdljrfWh8lccsRjNGx9v3JY=;
        b=L+EkG95k5MCM/JaYZr5pcE9zJUeUo9k6gKFd77SYXZ6ZXaVEKmUIoIHh38IqiC5ar2
         WF3o/VSRlzstBn1LXcenJ30373PFfD6ZclA/kF1LUz25mseMCZIzKnDNszNdRDHUPwK/
         ZOwwaRXPivSZKfLpkGr+lhfGDamn67E0+acEU/N3WFvt2e340HzlzMzK3MB0k42Ha0IS
         faVXNMU4SDEtMqmXwOs8GWa1Vhjf2XYlO7EJ08PdGGdvZI6t8ou9XhrRF9ruO+/y9SZP
         XL2VXTefU4QMAtje34PYz6xidnFeA48wT6WOA18zpoHeD7pu+JwQkUGS7y3/3/YovXLo
         HBUw==
X-Forwarded-Encrypted: i=1; AJvYcCUABYzGIbNcsqRA9qdnSjoilQmjmhzpEZQo34ZOW3jlsD6VeG2QIWFS5ZCkuP+K07Omit77kQcT+4ZwCr9nHeIDF40fKbj3WB1C6F5A
X-Gm-Message-State: AOJu0YxMLGKM65CGM/K3CKGpvQb6L7HK6/wsR2/OOxXhq4LI0ArRr6Uo
	jFdaiFsdZYCSL4MBIefBUPjFTEdRVpQ8yld0uZsxdzdVxuR1gpoV/3dSaA+6g7gvFL9sRJnqOek
	LzviIfw==
X-Google-Smtp-Source: AGHT+IFhoJr8EPl6F1GCM47xS96AwJAtNPgzM+dCGzLCuDEHKrJDnYdVfusUwYS44H0oX+E6gS/orA==
X-Received: by 2002:a05:651c:1050:b0:2ec:5019:becd with SMTP id 38308e7fff4ca-2ec5019c4e1mr19759331fa.49.1719011939165;
        Fri, 21 Jun 2024 16:18:59 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec511dac51sm1932891fa.74.2024.06.21.16.18.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jun 2024 16:18:58 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ec10324791so27606621fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 16:18:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUGruY7Tiovzu56hCpYeZWGvERn+6hWBKfPvV2806GLqLmkfdTqYIJUnaAKncC7deSoBgFrWDM4PhZysIVwDFuDvCKxa9Q67Au9gm55
X-Received: by 2002:a2e:9a86:0:b0:2ec:3206:57e4 with SMTP id
 38308e7fff4ca-2ec3ceb7d18mr65006831fa.15.1719011937769; Fri, 21 Jun 2024
 16:18:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240621211819.1690234-1-yabinc@google.com> <ZnYAQhNjVEvFlkdY@gondor.apana.org.au>
In-Reply-To: <ZnYAQhNjVEvFlkdY@gondor.apana.org.au>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 21 Jun 2024 16:18:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=whWXCP9Jn=y=MXot3T6sECEyK5nTmuvT=WDQM9h_NtJqA@mail.gmail.com>
Message-ID: <CAHk-=whWXCP9Jn=y=MXot3T6sECEyK5nTmuvT=WDQM9h_NtJqA@mail.gmail.com>
Subject: Re: [PATCH v2] Fix initializing a static union variable
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Yabin Cui <yabinc@google.com>, Steffen Klassert <steffen.klassert@secunet.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Fri, 21 Jun 2024 at 15:36, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> On Fri, Jun 21, 2024 at 02:18:19PM -0700, Yabin Cui wrote:
> > saddr_wildcard is a static union variable initialized with {}.
> >
> > Empty brace initialization of union types is unspecified prior to C23,
> > and even in C23, it doesn't guarantee zero initialization of all fields
> > (see sections 4.5 and 6.2 in
> > https://www.open-std.org/jtc1/sc22/wg14/www/docs/n2900.htm).
>
> What about all the other places in the kernel that use the same
> idiom? A grep shows that there are more than a hundred spots in
> the kernel where {} is used to initialise a union.

The important part is not what the standards text says - we happily
use things like inline asms that are entirely outside the standard -
but that apparently clang silently generates bogus code.

And from my admittedly _very_ limited testing, it's not that clang
always gets this wrong, but gets this wrong for a very particular
case: where the first field is smaller than the other fields.

And when the union is embedded in a struct, the struct initialization
seems to be ok from a quick test, but I might have screwed that test
up.

Now, it's still a worry, but I just wanted to point out that it's not
necessarily that *every* case is problematic.

Also, the problem Yabin found isn't actually limited to the empty
initializer. It happens even when you have an explicit zero in there.
All you need is _any_ initializer that doesn't initialize the whole
size.

End result: the "empty initializer" is a red herring and only relevant
to that standards paperwork.

So empty initializers are not relevant to the actual bug in question,
and I actually think that commit message is actively misleading in
trying to make it be about some "Linux isn't following standatrds".

But that also means that searching for empty initializers isn't going
to find all potential problem spots.

Notice how the suggested kernel patch was to remove the initializer
entirely, and just rely on "static variables are always zero" instead.

I don't know how to detect this problem case sanely, since the clang
bug occurs with non-static variables too, and with an actual non-empty
initializer too.

           Linus

