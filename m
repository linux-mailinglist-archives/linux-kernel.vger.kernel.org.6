Return-Path: <linux-kernel+bounces-358945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 081A699859C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A2AB282FBD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 12:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2931C3F1B;
	Thu, 10 Oct 2024 12:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eea0MmAz"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093F118FDBE
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 12:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728562285; cv=none; b=cnf0umK6iYA4JRZ1V2nF/PlemcB/ZvNdqlLFxrMeuqDsM44hEkJ8pEjNPYP39WjSmHI16eihYIGaHkky8ajWP3UNW90Bzqi0g7sonntIaI3REp7VQhz3ijUVn9yOnIF5lLBpcCcljmlNufZBdvl7yCeEY58ZQRTywQ9FZkM6n40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728562285; c=relaxed/simple;
	bh=9IwGJpkMTMBw0yGJitvUVuWUOMwCQ/DbccBrOqTbNus=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DupBT7N2f7SlJsVL2Q1S3uKpd7k7AdkQaBJA3MFBUvam1zfWSCGqZNIrjPI0JLurK3tuqZdE1VabN1ou0vjE5uy12zOTLp6Ih+gePZu44DcoS7Tqjos7pV0Lw9ZH4H+Gju06+qDM6vLjrMkVmpTAsTv06SyWnsaPxMgm40RADLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eea0MmAz; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2fad6de2590so12243641fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 05:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728562282; x=1729167082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9IwGJpkMTMBw0yGJitvUVuWUOMwCQ/DbccBrOqTbNus=;
        b=eea0MmAzBrJrcpoB2Z+JoanHdRQMf7zBb8NRwNSbsdaoVOtdd3/OetdEvZlwaE8y9o
         wR+KghN0P1fBDS6pPYAeYtK9aRTJfDyOp8i5eXvTT9Ml0BOO5Vi0Ld6Q6h3ebm4Tybs6
         rESpQvj5KcooezEgI1Hmj9IwR5Vc4R/uoZBjbltDbjrRdomvkbKtRhpNiV5RB7DaoPFD
         vqYWKbGLhNkK4QZrO+jKQqkbUzsPHZYo4QhhXTJKOnX8SblmJCuFn9IJczz9ODnwoBgo
         tX6XtvsmtQwo8Xu6QtOrOcMIY3oNQWXpwaS9T+T6igfx74peot63/ecVZUKz4+ZIUQK0
         l7+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728562282; x=1729167082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9IwGJpkMTMBw0yGJitvUVuWUOMwCQ/DbccBrOqTbNus=;
        b=XXPYLgYXyb8BzpJsneBS0lpq7Qfo/xo9pHIdQ5YgJM9VYLuEjAoCTjn3fczVaTDiUp
         /UzQdR1Qxj7jKAKmTf93thTQfsBXQsCSlAc+j75p1HwjmhBywdJDDDJ764jT4L67YRzD
         gVwXh50nGQA4qQq1tvVvKnREHHjOfiAw/WwNoQnQpdilQoc1WtHM8DvpZpA1b8xrioW2
         ahUKwJ1557D7TdunmC7bKebvMpw4KpQV7BM5m7lqAiFKMoZLdHnpncrU4bOXlk0M/TZd
         tkQHVHVQWqe6HPLBNCb3D3J7v4I0ukS87/mTvQNuehQd4m4qQvIFGNwp1ruBgKOHwMTs
         MRMw==
X-Forwarded-Encrypted: i=1; AJvYcCVdCBjnxj1bP9q2l+bQ2BJobdAGDilbBrp6tReSvOKHkpv+4aZORqVmE++NtD1tY62gqegMloYVQRGBp00=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdFSGAUKVVWzNnYoxzd9ZMmmAtIL7vAJncUnD+N+lEa+Q8QgIk
	TVzfnh35CSo6Mi76ip/RmdwP4YcW4MUrVEbJneeZgy6ZPDjjq59pj9vhjyqaxQRHndCmVEVtslK
	NDWeHyHiofwVliejae1EYaekHNyOe303Ls1rThw==
X-Google-Smtp-Source: AGHT+IHjcaQoBqfpJ8FYrx1gfWjq+eWVknX20o4i9A4+sUsdM9VmYBZstGFuWFa39n9O361+kyXBgz7xYBS4U1aZZok=
X-Received: by 2002:a05:651c:1548:b0:2fa:c0b5:ac8c with SMTP id
 38308e7fff4ca-2fb1873dfe2mr55267331fa.21.1728562281963; Thu, 10 Oct 2024
 05:11:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010-arm-generic-entry-v1-0-b94f451d087b@linaro.org> <ZwfAtJfNm95sXgo8@shell.armlinux.org.uk>
In-Reply-To: <ZwfAtJfNm95sXgo8@shell.armlinux.org.uk>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 10 Oct 2024 14:11:09 +0200
Message-ID: <CACRpkdYPmqXQrt4r5pxCUugHWHkBVF4qPSkvU5X09QB=1sscjA@mail.gmail.com>
Subject: Re: [PATCH RFC 00/28] ARM: Switch to generic entry
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Oleg Nesterov <oleg@redhat.com>, Kees Cook <kees@kernel.org>, 
	Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
	Frederic Weisbecker <frederic@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Jinjie Ruan <ruanjinjie@huawei.com>, Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ardb@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 1:55=E2=80=AFPM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:

> I haven't looked at the series yet, but I guess we're throwing away
> all the effort I put in to make stuff like syscalls as fast as
> possible.
>
> So the question is... do we want performance, or do we want generic
> (and slower) code?

Yes, the very same question that came to me as I was working on it, we
need to reach some conclusion here. Al Viro also put some nice
assembly optimizations in the syscall restart that just go out the
window as well.

Some of the C interpersing relates to the RCU context tracking that
really likes to be called at every single IRQ, FIQ or SWI, and where ARM32
is one of the few last users of the user_exit_callable()/user_enter_callabl=
e()
API which is obviously less intrusive as it only needs to get called
at transitions to/from userspace, while these calls are marked
with big block letters as obsolete in the context tracker.

> It seems insane to me that we spend time micro-optimising things like
> memcpy, memset, divide routines, but then go and throw away performance
> that applications actually rely upon, such as syscall performance.

Yes, this series is a real RFC in the true sense of the word.

Yours,
Linus Walleij

