Return-Path: <linux-kernel+bounces-333148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB58797C488
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 08:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F045B2141A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 06:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501F518F2FE;
	Thu, 19 Sep 2024 06:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SpEr+eq3"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04A018C354
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 06:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726729070; cv=none; b=AROIDk+UrEQYhNFHTYtw8QpupSEbVEnNR/MxQgtB82oa/Nok8Sga2JBiglwlgi4+0WLkhjSJwOvC8o4zcD7UVbQ7yAI+ZXAS2pSilWHJ4/cQXe4lVdg+eO73DjB3Cdtki6Tb8uEubEhhmrCjoDXPKlIzOGNzL7igQlha9sYtagw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726729070; c=relaxed/simple;
	bh=T42I0lRZBaFB9187EeGtKoTYqZo584h9kb6/EqVjmtE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rYfi97zwRcbSGVEJfFE+ID9/gK7cj1fgf1UC5vz9HK3diXHQ8IvJo/EDrSUbImeHfHApEKMy0Us44Y0z9+ySbfD6JQQKjiD/OdpCQjlTapLfXL1F3BgCKyJcaiSw6uUz8r+3DqEGZ0KUBlrw0D/ohsuwuBIFjhzs3DCm8xXzPTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SpEr+eq3; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a8ce5db8668so68344766b.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 23:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1726729067; x=1727333867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5TUPhH68J4aIRtGndcy4NXpmyIlQij++uMUQdRa57QE=;
        b=SpEr+eq3/HQ76fT8RajuijqMzOA6bqekax+/as/obHB1a77UjrN5y1LJrrFqfcCIK7
         AcxmtSLzvY3ZQSDCZOfg0DR819lly9TCQbo2PuO8eentFY4zmIAZ2PVpe0y2mTlSv0gM
         nFQVT0QYN3rgJtORcJUYDcrQHBUc2xJOcYc2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726729067; x=1727333867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5TUPhH68J4aIRtGndcy4NXpmyIlQij++uMUQdRa57QE=;
        b=BFEQZU4xMW3+DlzDDavxioLuRV8TAZGDbHWO8zVHOvGGDVJuuxzytq2dXyDfGFJrFx
         1Lz36ZHtX/eHyZ15Mha/805z+Ma/xzKHZkdfdGLyY/awaduA44o7hComv+8zl6OEmk0x
         EotPZP4TfKDr0PZ9gJ+LLZEkEtrW2qwxbr2Q+fuUFvp0wLlKIng3GlITRd1V1YavgJmH
         +IYj/QiawMKhF6mTMUZKAiKfoUFrWJRSK4Ag11jUMy3ScHqnz5biPd2i4sxodhEJTefs
         s9jgqWfWzRKkZBRxnVtdPkDZMS2YeCwWFxNha4L4VUHBbh8CgGVKugAZo+x03FGFSqKU
         xrVw==
X-Forwarded-Encrypted: i=1; AJvYcCUMriyV6iqmF87xDFzqhhKpgDqiNgKA15pNFg23NCkkMcysyzjvmXSesEQWR7h1orsC0w0Gs0sUtxo/V+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YycT5Kk+iUtebCUSk8P/ZB+sUJiE/+6xMpzmlsJ4qilyZJ1iOYX
	6139stUMoVsbDqS2FlYhBCnQVjoF75QQ3ll3jdhgXOqrRab626zm/vd0bK/4XqA+Tsk0nUx+CHs
	3TqDMjQ==
X-Google-Smtp-Source: AGHT+IHJo6KfsyjJIaaaKhtSTvUA6CAP7/kj1DhA8s2KnJ1B2rwE2VgwDqua+yZ3U8ukzzpxKIRVbw==
X-Received: by 2002:a17:906:c151:b0:a90:1ed4:dec6 with SMTP id a640c23a62f3a-a902961bf01mr2983524566b.43.1726729066916;
        Wed, 18 Sep 2024 23:57:46 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610f4971sm681017866b.90.2024.09.18.23.57.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2024 23:57:46 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a8d0d82e76aso58825266b.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 23:57:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWmwXuDEjdiFxz+QgYmJ8SJBKYkQTQ8m4LTLsJ8f5q1gf0tSLrySIqaOjym0v1VYvXsucHxg/oNgHUWIGg=@vger.kernel.org
X-Received: by 2002:a17:906:f5a7:b0:a86:a56a:3596 with SMTP id
 a640c23a62f3a-a9029678cbemr2701906566b.60.1726729065735; Wed, 18 Sep 2024
 23:57:45 -0700 (PDT)
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
 <CAHk-=wgQ_OeAaNMA7A=icuf66r7Atz1-NNs9Qk8O=2gEjd=qTw@mail.gmail.com> <E6728F3E-374A-4A86-A5F2-C67CCECD6F7D@flyingcircus.io>
In-Reply-To: <E6728F3E-374A-4A86-A5F2-C67CCECD6F7D@flyingcircus.io>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 19 Sep 2024 08:57:29 +0200
X-Gmail-Original-Message-ID: <CAHk-=wgtHDOxi+1uXo8gJcDKO7yjswQr5eMs0cgAB6=mp+yWxw@mail.gmail.com>
Message-ID: <CAHk-=wgtHDOxi+1uXo8gJcDKO7yjswQr5eMs0cgAB6=mp+yWxw@mail.gmail.com>
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

On Thu, 19 Sept 2024 at 08:35, Christian Theune <ct@flyingcircus.io> wrote:
>
> Happy to! I see there=E2=80=99s still some back and forth on the specific
> patches. Let me know which kernel version and which patches I should
> start trying out. I=E2=80=99m loosing track while following the discussio=
n.

Yeah, right now Jens is still going to run some more testing, but I
think the plan is to just backport

  a4864671ca0b ("lib/xarray: introduce a new helper xas_get_order")
  6758c1128ceb ("mm/filemap: optimize filemap folio adding")

and I think we're at the point where you might as well start testing
that if you have the cycles for it. Jens is mostly trying to confirm
the root cause, but even without that, I think you running your load
with those two changes back-ported is worth it.

(Or even just try running it on plain 6.10 or 6.11, both of which
already has those commits)

> In preparation: I=E2=80=99m wondering whether the known reproducer gives
> insight how I might force my load to trigger it more easily? Would
> running the reproducer above and combining that with a running
> PostgreSQL benchmark make sense?
>
> Otherwise we=E2=80=99d likely only be getting insight after weeks of not
> seeing crashes =E2=80=A6

So considering how well the reproducer works for Jens and Chris, my
main worry is whether your load might have some _additional_ issue.

Unlikely, but still .. The two commits fix the repproducer, so I think
the important thing to make sure is that it really fixes the original
issue too.

And yeah, I'd be surprised if it doesn't, but at the same time I would
_not_ suggest you try to make your load look more like the case we
already know gets fixed.

So yes, it will be "weeks of not seeing crashes" until we'd be
_really_ confident it's all the same thing, but I'd rather still have
you test that, than test something else than what caused issues
originally, if you see what I mean.

         Linus

