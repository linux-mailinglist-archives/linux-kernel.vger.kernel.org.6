Return-Path: <linux-kernel+bounces-296055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 295BF95A4F6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 21:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C7751C202F5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 19:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B6C166F02;
	Wed, 21 Aug 2024 19:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LOgpLLK6"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459DC14C596
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 19:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724266955; cv=none; b=YIGx30YBhvY9q/po5VKsy5OLGsiTn6qdBa6S5ssK1D5UnECnfgs1POopOWNlJspo2Sc2N/BrZ+8R+xL0DlmDPhx/tqVez5fCFIDxDRQlJO9zoiwBe6liK0KYp1AGu9qpR3qEh0uDcVpjg5Z70kQ6yvobfXvytq4E43+LMeeFZCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724266955; c=relaxed/simple;
	bh=1ahm9esPITVeZ0QIpZcT8JjHfRFyH7cLMPiUbwzxhbM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VfN4OTV24BS1cLdHMan1vK9AWsQ/VcxNjvk2hXcL2TYGKxw7QoHoo8aAlfeOgk8R0xL0i5QTE0kCJ+LB0hlFUFgfAF51RDquNYBtTVMh2cDiaZxp/ctDwM3Fa/DsfHcWnDWzz05PXNwoAF71XthDI1iDi6MOeyTgH1qDuaxlNwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LOgpLLK6; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53346424061so5208e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 12:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724266951; x=1724871751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sTk2wQSGpS2A9NuKFMEhj1HJguytFPmwi5TTNL6/m+0=;
        b=LOgpLLK6IEZmNFOqT6UL9CWSJ9Ei7tdDVMBWtqwhfTc1eh5E1+9vpHKY+qJwbXWW4w
         CAjSy3bVCvG1SstedQ++ObFtlQWd2cxWgqDcmB05XbghO+putgI12GP+lQu4Wy35ZlAU
         BntopNbEZkkSOLCC3UeRGpiFf/me9vinJEg1ndK/0X9ubPdaj+tVcqDA1cvdgB/q3m3S
         jDjObhpXD9W6/71hAnGxPoCeayysjnlWCodlJ0XaREW7c8L2w71c7Jfww4Ubg5MCZCKj
         2HfX0/WfMSU7w5WQksR/HndrrCxS7pgW77yorj6ythFhm5tC0epLfKd/y4lyqv3JvQAt
         3u/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724266951; x=1724871751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sTk2wQSGpS2A9NuKFMEhj1HJguytFPmwi5TTNL6/m+0=;
        b=TRrAC/JnyT6/HQmeUvOmJr8fxYpF+4vrQlihOD7aRtvlVEzH9HGen2pby0RFMRzcpY
         RWvlA6CZsQZp/P+xicVLbz+6P+Xpb9r8Hp4tbjRAYIAD3lMDXeL5woga+f92OMCpM2Kp
         e7oObYsQSE6woySzz6WfcezqJbp+JTzGePkefJyhKXlV/OwLViOq4N4yNfY/69k+p7rL
         rOiANlCHNasSF1+LdTD6Tq23VlB0hSvZ6Y+1D4qNH9VzrFoz2sNR4d8tZhNEZ3j9mQLy
         QZTHWCjIyeyP2XAj0kYlS7kGTJjAkugdr6fiw4jHAz/CJywXedIPvnONRyfvd7PK4DoG
         Ivgw==
X-Forwarded-Encrypted: i=1; AJvYcCUN4zb30BUEVheeTV9srOTIsdRjH99gJIJtzCtypzDUmEuxYGLrKsZLYQTcxQvXazzyt6rwtU9qHoqXi7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9suEui8Jp0EAuZLyAo37iEz12ap+GWPjAxQ+AVYpVFEbJeb8l
	G7mSKvf/N7EcvLoj4pSpINhmg7TLtgbji96/o305sCSGR5GRxgbA5Iyv7GiV0RNOMI9wPA1kdk+
	1
X-Google-Smtp-Source: AGHT+IEKangxSdv8RKVt8xT7NwbFnlr1CTlLF5FaXGHO4SmBkB8s3awJT4QE1Buowd2DfM8UOn033w==
X-Received: by 2002:a05:6512:114d:b0:52f:e5:3765 with SMTP id 2adb3069b0e04-53348593647mr1102285e87.6.1724266950793;
        Wed, 21 Aug 2024 12:02:30 -0700 (PDT)
Received: from mordecai (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868c23e1basm11382566b.204.2024.08.21.12.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 12:02:30 -0700 (PDT)
Date: Wed, 21 Aug 2024 21:02:26 +0200
From: Petr Tesarik <ptesarik@suse.com>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: Jonathan Corbet <corbet@lwn.net>, regressions@lists.linux.dev,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Bagas Sanjaya
 <bagasdotme@gmail.com>
Subject: Re: [PATCH v2] docs: bug-bisect: rewrite to better match the other
 bisecting text
Message-ID: <20240821210226.25862313@mordecai>
In-Reply-To: <e6681b51-297e-4ef8-a199-d36712088740@leemhuis.info>
References: <fbeae4056ae8174f454c3865bc45633281bb1b31.1723997526.git.linux@leemhuis.info>
	<20240820140751.0e024f21@mordecai>
	<e6681b51-297e-4ef8-a199-d36712088740@leemhuis.info>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Aug 2024 19:16:25 +0200
Thorsten Leemhuis <linux@leemhuis.info> wrote:

> On 20.08.24 14:07, Petr Tesarik wrote:
> > On Sun, 18 Aug 2024 18:12:13 +0200
> > Thorsten Leemhuis <linux@leemhuis.info> wrote:
> >  
> >> Rewrite the short document on bisecting kernel bugs. The new text
> >> improves .config handling, brings a mention of 'git skip', and explains  
> > Nitpick: git bisect skip  
> 
> Ohh, one of those cases where one misses the most obvious mistakes. Thx
> for pointing this out!
> 
> Also: many thx for your feedback in general, performed a most of the
> changes you suggested (thx again), only replying to a few other bits.
> 
>  
> > But it's still difficult to parse for me. Maybe it would be better to
> > reorder the sentence like this:
> > 
> >   After issuing one of these commands, if Git checks out another
> >   bisection point and prints something like 'Bisecting: 675 revisions
> >   left to test affter this (roughly 10 steps)', then go back to step 1.  
> 
> Chose to do it slightly different:
> 
>    After issuing one of these two commands, Git will usually check out another
>    bisection point and print something like 'Bisecting: 675 revisions left to
>    test after this (roughly 10 steps)'. In that case go back to step 1. 

That's just as good for me. Keep your wording.

> >> +  Git might reject this, for example when the bisection landed on a merge
> >> +  commit. In that case, abandon the attempt. Do the same, if Git fails to revert
> >> +  the culprit on its own because later changes depend on it -- at least unless
> >> +  you bisected using a stable or longterm kernel series, in which case you want
> >> +  to retry using the latest code from that series.  
> > 
> > Admittedly, this paragraph left me a bit confused. So, what is your
> > suggestion if I bisected using a stable or longterm kernel series (BTW
> > shouldn't we use Git-speak and call it a branch?)  
> 
> Not having a strong opinion here, but I'd say "series" is the better word
> here; but maybe "using" should go (see below).

Good point. I don't have a strong opinion either, so let's go with
"series".

> 
> > and Git fails to
> > revert the commit because some later changes depend on the commit?
> > Are you trying to say I should check out the current head of that
> > stable or longterm branch and retry the revert there?  
> 
> Yeah. Changed the text slightly; does it make things better?
>  
>   Git might reject this, for example when the bisection landed on a merge
>   commit. In that case, abandon the attempt. Do the same, if Git fails to revert
>   the culprit on its own because later changes depend on it -- at least unless
>   you bisected a stable or longterm kernel series, in which case you want to
>   check out its latest codebase and try a revert there.

Yes, this makes it crystal clear what I am supposed to do.

> > Overall, it all looks good to me.
> > Thank you very much for your effort!  
> 
> Thx for saying that, the time your spend, and your feedback, 
> much appreciated!

No problem. It's you who has done the hard work.

Petr T

