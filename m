Return-Path: <linux-kernel+bounces-241558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58DCD927C8A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 19:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF2BDB21F48
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2668476050;
	Thu,  4 Jul 2024 17:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ei7N/STn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0366DD0D
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 17:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720115529; cv=none; b=iVEfSGfRelGgHQToJbamSn3DLunjalxC9DCuSVXIRf+6KRsw74lvQYxiBETebFAkEJYHNCHqowwA9JGWedT9wcQPzNlbhFYV+LDv5S/R4UjlPWkXk25T47PUdraeFW8IFNua+k5Y7mQjtavXQC2wxJNq7K14DL6SFJR+TqLKtyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720115529; c=relaxed/simple;
	bh=NYdxyxDhA3T6gaR3w425ap8x3Chebygz2WNFxI6q4+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oIuZRD+mw/PWuMMIJNwt0avUz/kiRCbbbkbd4BhUD24gDM27Q44OJ9bSil5lcDWk4M6s6EI/BiGT877+ael5HTlwmsIcfIyWLhDC0pFUS086QTEOXCvOJrI/WK6lvZL5Y5fCWLAke1aVKHLskhxtL2Erpq29gL1D2PIZrYX6hrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=ei7N/STn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7730C3277B
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 17:52:08 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ei7N/STn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1720115526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NYdxyxDhA3T6gaR3w425ap8x3Chebygz2WNFxI6q4+Q=;
	b=ei7N/STnblDMNxuudSguEpUyYnQKtmspZ/5vzT7er9oidssvZY820l3TDcktuJXTVETmpd
	xrpLLrJlFSWzSQStPlEmPb/PaKqDphsrIXL1w2y3lO7kDxiZq4yoRZZiBGv665kTVD88dZ
	4onA0zXZHwjxdzKUd8ZLY0Vo3fZMBm0=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id a3a5537d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <linux-kernel@vger.kernel.org>;
	Thu, 4 Jul 2024 17:52:05 +0000 (UTC)
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-702233310b0so510130a34.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 10:52:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV+hPC827RwAYARXz8q8siPAqbtabkFUHXySSj018BtY9GPqpLN01h2NAG8Wy4iHS/NjmimjySJY63M66v9RJuID5IZjToRGp4LpKnd
X-Gm-Message-State: AOJu0YzPxB+JhRzhdf/6705htULy1RSZiGlMIbLkbh9xNPoUjHf6I2lx
	bWoonzq/aHFQOr2KIxVtFXtU/mN8HLeecwLyk71m1rpdRH41d3MtnDSPGGJRU6iv1JK6U4d4NPS
	KyEpR8OL43hD2A66Dw8g+0MAfen0=
X-Google-Smtp-Source: AGHT+IHfSF19ViNroA+XquvbNx2sD7uTrs14WoxFQxCaBLHXVORlgKtnHxFqdXg0lojLxyjDWKH3ZU1lrGQ1+Z1DlGU=
X-Received: by 2002:a05:6871:3a2c:b0:25e:247:3ae7 with SMTP id
 586e51a60fabf-25e2bd76120mr2055946fac.34.1720115524598; Thu, 04 Jul 2024
 10:52:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZobXdDCYBi8OM-Fo@zx2c4.com> <CAHk-=wiGk+1eNy4Vk6QsEgM=Ru3jE40qrDwgq_CSKgqwLgMdRg@mail.gmail.com>
 <CAHk-=wgiqw3q_W-B4faLHXgkDMvz-wdUHYuSweg0LJvKuw0qzg@mail.gmail.com> <CAHk-=whmVf0Wj0FMRJtb9ofKtZ30tQFosQ6fNqO6_uEEYXa1CA@mail.gmail.com>
In-Reply-To: <CAHk-=whmVf0Wj0FMRJtb9ofKtZ30tQFosQ6fNqO6_uEEYXa1CA@mail.gmail.com>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Thu, 4 Jul 2024 19:51:53 +0200
X-Gmail-Original-Message-ID: <CAHmME9oq9YdC49LwZadivwkz_YFi53ApL=WZhGtHbuJAO0yk0w@mail.gmail.com>
Message-ID: <CAHmME9oq9YdC49LwZadivwkz_YFi53ApL=WZhGtHbuJAO0yk0w@mail.gmail.com>
Subject: Re: deconflicting new syscall numbers for 6.11
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: jolsa@kernel.org, mhiramat@kernel.org, cgzones@googlemail.com, 
	brauner@kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

On Thu, Jul 4, 2024 at 7:47=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> One final note: the reason I'm so negative about this all is that the
> random number subsystem has such an absolutely _horrendous_ history of
> two main conflicting issues: people wanting reasonable usable random
> numbers on one side, and then the people that discuss what the word
> "entropy" means on the other side.

Yes. My entire goal since the beginning has been to clean up the filth
and insanity that's emerged from this. And there's a real userspace
side of filth too that's not going to be solved without this.

> And honestly, I don't want the kernel stuck even *more* in the middle
> of that morass.

Certainly I am not bringing us anywhere near that morass. I'm the one
who's been diligently trying to dig us out of it!

> I strongly suspect that one reason why glibc people
> would want this is the exact same reason: _they_ don't want to be
> stuck in the same padded room with the crazies _either_, so they love
> the concept of "somebody else's problem".

On the contrary, the glibc people were busy doing something grotesque
and incomplete, when I paused things so that I could do it properly
where it belongs.

> potato" thing. Which is why I really really want those real users
> standing up and saying "we can't use rdrand and rdtsc and our own
> mixing".

The point is that the people trying to "use rdrand and rdtsc and our
own mixing" are in for a world of pain, will come to a solution that
isn't complete and will fall over catastrophically in some
circumstances, and proliferates the problem.

Jason

