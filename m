Return-Path: <linux-kernel+bounces-344752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A6398ADCE
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 22:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F03AB22ACD
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 20:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC311A0BD2;
	Mon, 30 Sep 2024 20:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fkBPN/jo"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7F71A0BCE
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 20:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727727180; cv=none; b=dX5NxqdHCKr/R8oV3nLHgx+O8qvWfmmzydX4eyEcUhCoVu0q5hNd5CvZc0uHvU5gMbogsMch+qGh0hR3+kR/ZuJm7und1SDkxQvgtyeRomAtX6aUEXyIJ2QoGhApTItcgZ2RxM/wG/6zC07GmkYG07SaZ8SzzEAo8G8HpLg1GLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727727180; c=relaxed/simple;
	bh=HQF9J8H/AuRUNDVm0LUM1/KuCoSlcEZcddS5OBrqJUI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FuMU9rtsq1qzzYfQfvqO+U3+R25ZJ3iQ0I7ji8TsS0vTpnHS79LaAZhHO/LBIxGKaJDUXIVJNdS6SgJeo7otlKAB+Ks/arxDWYQE6XAP9b0Nu/eodof/kQ2FIFiUzrchbOxNWJy6adrpfPskVax1rsIlSf0d078uSt3s9EaC5sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fkBPN/jo; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c8952f7f95so2076418a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 13:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727727176; x=1728331976; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M8SU9mjR4XCAezY3L+HkJFDMRx33ZVP0EqsIm6USarM=;
        b=fkBPN/joJbt4vpOQIL741YiJgU7wNqHpX3l9jsLkS2w6UA47/ajYHhcBjZXEAw+d+T
         AcmYByno0yvurvxfjVPcROfz/6Gs8mfJdTT6qu0Tn1ckQHuShomQtDlaJJUqUl2nXwd4
         +lnjlndUL/63UJs1Xw8AJW8n4w82AEqIRMygk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727727176; x=1728331976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M8SU9mjR4XCAezY3L+HkJFDMRx33ZVP0EqsIm6USarM=;
        b=O+LdRkzpvC3vu3oCPLv/doA6m6BfwkPEv25sgUVZj4e/pvxjO6L9lN0l+VryTCKMaI
         nfgiINUaz9GwZLFFC5jXb1QLMtXegkJfyX3S3zG65gFmr++iF7W2KnriPcU9RhkEK0NZ
         3nTTGi412WkhTCVp5slhiGc7QB87zDi6u32je4si0k/Gbp5XPT/1iiLt6+etp7Vz+bTx
         8JVBZ7WvosfMBTtneQBCOj3ufIBc+H2rZat4f8fjFm6cEE3hrbc2oUBPIL4JKet7oJhC
         STgfSj5/RMTEeXfJwALyW8NhU9n3AHPjBIHfX4DZB6U9YHV9Mpfc/2hOzCZJlyDwy+DP
         aF6A==
X-Forwarded-Encrypted: i=1; AJvYcCV/r712vJ0vHx5dmupLdjXsmTz8wOgXyALIVC8K6spQriD8si8zIIsO11EVaB16pYdG9BdQJUfolzh2ZjY=@vger.kernel.org
X-Gm-Message-State: AOJu0YytAtnS/a1cR2Hp68mXDV8N0eaK7TekOOhtlLvMNY4Mp3kgiRCQ
	suKpxKQVPZoUmx2tHQnpu/xW9mDZr5Y8JaFXn7k3heqO34iCByMtUjRKVKwA1iUbgORJ1ssg94k
	0y5rmiw==
X-Google-Smtp-Source: AGHT+IE5iAup43kDGZemCSobcmTg7BIavnaxSQWpQhv27Zp70MIanUfxnSic2RU+fR1YYiquY+rJGg==
X-Received: by 2002:a17:907:3681:b0:a8d:2faf:d343 with SMTP id a640c23a62f3a-a93c49674c0mr1462601766b.27.1727727176054;
        Mon, 30 Sep 2024 13:12:56 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c27c5b2dsm582491166b.77.2024.09.30.13.12.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2024 13:12:55 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a8d56155f51so610657866b.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 13:12:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVrMT4gs09s1mMqfIZuhiwYIlTYOiTa5g7f/znRCL/B70tCXMTdhF7Uiq1cRrKRNWVURaFXNRFa97Tfk5w=@vger.kernel.org
X-Received: by 2002:a17:907:869f:b0:a72:50f7:3c6f with SMTP id
 a640c23a62f3a-a93c49219f2mr1408201666b.14.1727727175132; Mon, 30 Sep 2024
 13:12:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wh5LRp6Tb2oLKv1LrJWuXKOvxcucMfRMmYcT-npbo0=_A@mail.gmail.com>
 <Zud1EhTnoWIRFPa/@dread.disaster.area> <CAHk-=wgY-PVaVRBHem2qGnzpAQJheDOWKpqsteQxbRop6ey+fQ@mail.gmail.com>
 <74cceb67-2e71-455f-a4d4-6c5185ef775b@meta.com> <ZulMlPFKiiRe3iFd@casper.infradead.org>
 <52d45d22-e108-400e-a63f-f50ef1a0ae1a@meta.com> <ZumDPU7RDg5wV0Re@casper.infradead.org>
 <5bee194c-9cd3-47e7-919b-9f352441f855@kernel.dk> <459beb1c-defd-4836-952c-589203b7005c@meta.com>
 <ZurXAco1BKqf8I2E@casper.infradead.org> <ZuuBs762OrOk58zQ@dread.disaster.area>
 <CAHk-=wjsrwuU9uALfif4WhSg=kpwXqP2h1ZB+zmH_ORDsrLCnQ@mail.gmail.com>
 <CAHk-=wgQ_OeAaNMA7A=icuf66r7Atz1-NNs9Qk8O=2gEjd=qTw@mail.gmail.com>
 <E6728F3E-374A-4A86-A5F2-C67CCECD6F7D@flyingcircus.io> <CAHk-=wgtHDOxi+1uXo8gJcDKO7yjswQr5eMs0cgAB6=mp+yWxw@mail.gmail.com>
 <D49C9D27-7523-41C9-8B8D-82B2A7CBE97B@flyingcircus.io> <02121707-E630-4E7E-837B-8F53B4C28721@flyingcircus.io>
 <CAHk-=wj6YRm2fpYHjZxNfKCC_N+X=T=ay+69g7tJ2cnziYT8=g@mail.gmail.com> <295BE120-8BF4-41AE-A506-3D6B10965F2B@flyingcircus.io>
In-Reply-To: <295BE120-8BF4-41AE-A506-3D6B10965F2B@flyingcircus.io>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 30 Sep 2024 13:12:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgF3LV2wuOYvd+gqri7=ZHfHjKpwLbdYjUnZpo49Hh4tA@mail.gmail.com>
Message-ID: <CAHk-=wgF3LV2wuOYvd+gqri7=ZHfHjKpwLbdYjUnZpo49Hh4tA@mail.gmail.com>
Subject: Re: Known and unfixed active data loss bug in MM + XFS with large
 folios since Dec 2021 (any kernel from 6.1 upwards)
To: Christian Theune <ct@flyingcircus.io>
Cc: Dave Chinner <david@fromorbit.com>, Matthew Wilcox <willy@infradead.org>, Chris Mason <clm@meta.com>, 
	Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org, 
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Daniel Dao <dqminh@cloudflare.com>, 
	regressions@lists.linux.dev, regressions@leemhuis.info
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 30 Sept 2024 at 12:25, Christian Theune <ct@flyingcircus.io> wrote:
>
> I=E2=80=99m being told that I=E2=80=99m somewhat of a truffle pig for dir=
ty code =E2=80=A6 how long ago does =E2=80=9Cold old=E2=80=9D refer to, btw=
?

It's basically been that way forever. The code has changed many times,
but we've basically always had that "wait on bit will wait not until
the next wakeup, but until it actually sees the bit being clear".

And by "always" I mean "going back at least to before the git tree". I
didn't search further. It's not new.

The only reason I pointed at that (relatively recent) commit from 2021
is that when we rewrote the page bit waiting logic (for some unrelated
horrendous scalability issues with tens of thousands of pages on wait
queues), the rewritten code _tried_ to not do it, and instead go "we
were woken up by a bit clear op, so now we've waited enough".

And that then caused problems as explained in that commit c2407cf7d22d
("mm: make wait_on_page_writeback() wait for multiple pending
writebacks") because the wakeups aren't atomic wrt the actual bit
setting/clearing/testing.

IOW - that 2021 commit didn't _introduce_ the issue, it just went back
to the horrendous behavior that we've always had, and temporarily
tried to avoid.

Note that "horrendous behavior" is really "you probably can't hit it
under any normal load". So it's not like it's a problem in practice.

Except your load clearly triggers *something*. And maybe this is part of it=
.

                 Linus

