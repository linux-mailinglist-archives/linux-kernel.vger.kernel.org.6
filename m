Return-Path: <linux-kernel+bounces-515187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FAACA36179
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 16:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12CD37A6340
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 15:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A15266EED;
	Fri, 14 Feb 2025 15:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eZrEUvL2"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8812D2676DE
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 15:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739546345; cv=none; b=Z/xFdkYkTJQOdEWTgR8Fa9kNl4sroyZIYmJZs/BQoxL1A2BzGK/nIJ/mGxlVn7KNi5iiOG5HpbnCb56PlAHFiSkG2Tez0tjJlXnSa9oRfOEPn9Sah+d5mDvDP+u0IJP3HGs40F1BL5CDVCl7+01dylf+9nXMEfivWEWSOtubeKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739546345; c=relaxed/simple;
	bh=pEgNB+e8X9eCmb5Em4WEq2/1ktgDjteXr7M4CLHP70Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TW4X37JUjnRtBGDAJPwJySt9GWAj8tpQPZsc3WEnO/PTOIABEBm1RUJZD2EKQrUxcG7SvrkGn4Ir5y2qMTkvvKujCdUVw+T+8s6e4Du6QNFXxr+gJ3XbNzeLJvtBwOoiYZ6s6vjrOSft208dEgTd1xXjdOjIIFqcg0VkIA7PWao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eZrEUvL2; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7231e216a06so272086a34.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 07:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739546342; x=1740151142; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pEgNB+e8X9eCmb5Em4WEq2/1ktgDjteXr7M4CLHP70Y=;
        b=eZrEUvL20WLc5uxxH3CJO3ooZ766lTdIvgHUj/Fvacnc4OFW39+VTGFLGQTr5B53j5
         gr+u6HY53jD7kCwL/aYaIMYrsR/P9GPUPtVbjVGrLrfH71QtP5SJOjoHBrxRxHza63pg
         ZsONjU3oBCLQ1Cf6nr4avr3KMnE6E7DmB9Jnk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739546342; x=1740151142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pEgNB+e8X9eCmb5Em4WEq2/1ktgDjteXr7M4CLHP70Y=;
        b=WHQUnlwJbr1I6WLeRXK0AuLfcLCFfoD/R70JmuVm62dc5hi+5qoc1je7rzMLj4w/hZ
         UxqtHRA3R568Apa9P+NYXueayikw5T246N8WFTOdQdNA+BSIhmfQ1ewyBttT5DBwiTEY
         daYQZg96e1Etb4U5c5sJJ2P8gDQuZU3oKgurIHbrnJQXov35UDZjXS+HhbCoZedS0xnr
         vBDeNMovc4nBda4s2hrTfUxJXkZ+1MFu3p2RvQnKPpviuzSoEOGEeg8Ytv4xNsOp8ROy
         WNy6BkfaBn8epRvhJYWXF3BocRCIeAjFdpxcSZcM4HbK1g5MCN6zOWHSO89jikHwTxe4
         yORQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcEy5p77hnoz229tstRQZjHzpR2v58iwT8/ez0wAox4EMtgfDfG3zFarP94yzyVv38/f31skYGsabTTa8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIsqzKA1lCM6rYEff5pecfyinJjTryVd7FQ/JGIWQAosf0/mBL
	DQM0377J65hTYtSIzhThLMmmzZ/cdce2JbEbLbZHDw0z01jRw2Xn6hxHtslo6YdibalPJDsn/k1
	A1quJNNuHGdxgik+Y4hORVDqKjka5GtKNHHqz
X-Gm-Gg: ASbGncvwiIbhlCvrBqbQWl311XiMJG15F3uJwMr1sMChppXxunqxNJftY6mvgzW4m30
	XrXUt2ZG3Uwfapyh6J9d1tBc/xDQ2z8vC4uuuVVV55xXBs06dKI1pt+ijAC3WAxwPU7uQxa2Nr5
	iqWZyebX6winZLMQ4NsEjZ6Kq9DGgXpg==
X-Google-Smtp-Source: AGHT+IH3M1MI/ZXrgxBWoTn5XcbnUy6hIbnxuW/lProqCtfwB8xj5L8NYkLoYKwgjWiSVdZWrl3xniim+6Zu173XrLs=
X-Received: by 2002:a05:6808:221b:b0:3eb:a61c:4c27 with SMTP id
 5614622812f47-3f3e19f2b9emr742458b6e.5.1739546342616; Fri, 14 Feb 2025
 07:19:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212032155.1276806-2-jeffxu@google.com> <qrxmfa6jvaojedmo6fle2e6vd5k4hzihcuxdc6zk43dclf6nsd@dvuzolusdtz4>
 <CABi2SkUWGXtWAir5j1TO1c7FwOhbNmSwEzwTrxRgzfBydus=2A@mail.gmail.com>
 <66q7feybn3q2vuam72uwmai322jdx3jtv2m5xmh75l6w6etqiv@knpsyh3o627k>
 <202502131142.F5EE115C3A@keescook> <t5hsasch3aybjujmjzs3shpiorcgzp5pjc4fmz77u574voi3hr@qomzrd2llv2q>
 <CABi2SkX3o-PdeuzownVkFT-oo8tjtaaS9ebOALu+r6O1S6W3sg@mail.gmail.com>
 <tfoitovawb6zwr7nvwfo2mnbahgtnoo6umvecj5mgtie4b5vuf@sloraia3ppfy>
 <ex3y7knp5kmubeauwktvv4fdjqya7ndatzm7ht4gf773c72hc3@y4ow7k54fttj>
 <CABi2SkW_CqwNXFu9BUDfTX07aq5T8OAZern9hL=WumEWqK=ZFA@mail.gmail.com> <8ded890d-f88a-4c59-acbb-8df3418c4a98@lucifer.local>
In-Reply-To: <8ded890d-f88a-4c59-acbb-8df3418c4a98@lucifer.local>
From: Jeff Xu <jeffxu@chromium.org>
Date: Fri, 14 Feb 2025 07:18:50 -0800
X-Gm-Features: AWEUYZmbPTbxI-LPUCQ4dfMkA3k9A-wBqOYbs8zt4NFvzvrRV5Zo7S6APKk28jo
Message-ID: <CABi2SkV+ai5WBG-RaRp9bkc9H0GFp__DgxbeGnu_BRJe9OGrtg@mail.gmail.com>
Subject: Re: [RFC PATCH v5 1/7] mseal, system mappings: kernel config and
 header change
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Kees Cook <kees@kernel.org>, akpm@linux-foundation.org, 
	jannh@google.com, torvalds@linux-foundation.org, vbabka@suse.cz, 
	adhemerval.zanella@linaro.org, oleg@redhat.com, avagin@gmail.com, 
	benjamin@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, jorgelo@chromium.org, 
	sroettger@google.com, hch@lst.de, ojeda@kernel.org, 
	thomas.weissschuh@linutronix.de, adobriyan@gmail.com, 
	johannes@sipsolutions.net, pedro.falcato@gmail.com, hca@linux.ibm.com, 
	willy@infradead.org, anna-maria@linutronix.de, mark.rutland@arm.com, 
	linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de, 
	rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com, 
	f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com, 
	mingo@kernel.org, ardb@kernel.org, mhocko@suse.com, 42.hyeyoo@gmail.com, 
	peterz@infradead.org, ardb@google.com, enh@google.com, rientjes@google.com, 
	groeck@chromium.org, mpe@ellerman.id.au, aleksandr.mikhalitsyn@canonical.com, 
	mike.rapoport@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 7:00=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Fri, Feb 14, 2025 at 06:39:48AM -0800, Jeff Xu wrote:
> > mseal_system_mappings() can be placed in mm.h in this patch, as you
> > suggested. But in the near future, it will be moved out of mm.h and fin=
d
> > a right header. The functionality belongs to exe namespace, because of
> > the reasons I put in the commit message and discussions.
>
> With respect Jeff - and I feel that this might simply be a miscommunciati=
on
> here - but this doesn't read wonderfully. 'can be placed' 'it will be mov=
ed
> out', etc.
>
> Please try to be respectful of experienced maintainers who are taking the=
ir
> time to review your code, and respond politely and respectfully. I think
> what you meant to say is something more like:
>
> "I'm more than happy to do that, but I feel that it would be more suited =
in
> a separate header, as this strictly belongs to the kernel functionality
> surrounding the execution of code. However we can revisit this at a later
> time!"
>
Thanks!
I apologize if my expression appears to be rude. Your revision
reflects what I'm trying to say, in better english.

> My feeling is that this is exactly what you mean, but you are just
> essentially abbreviating this. However it reads rather rudely, which I'm
> sure you don't intend.
>
> Ultimately the fact of the matter is that your series will be merged when
> it reaches the standards required of you by the relevant maintainers, as =
is
> the case will all code submitted to the kernel when we reach consensus.
>
> In this series you have addressed a great number of concerns which has
> brought the merging of it very much closer, so I hope we can continue in
> the same vein and reach this consensus soon.
>
> Let's try to avoid any miscommunication which might delay us reaching thi=
s
> aim!
>
Thanks !
-Jeff

> Thanks, Lorenzo
>
> >
> > Thanks
> > -Jeff
> >
> > -Jeff

