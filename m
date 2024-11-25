Return-Path: <linux-kernel+bounces-421395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 170B99D8ADE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 18:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E31CB2C495
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 16:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F8D1B6CE3;
	Mon, 25 Nov 2024 16:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6q/3Xkc"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766AF1AD418
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 16:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732553872; cv=none; b=aofuvEFvDN6DNNkG/KHa4bloKceV4q2HRxpLWfqF+UAcytKbFUGyiOTcRsTLQI+Zm6bvTnHI4ykIdWbqZri6085YVT11vpf4gsgQgIXl+X8wyX4DrZaTgffYKiqZVxdWPxunxxRSjWB/qEh9cZWohqCcOsdqMmUIHa2JvYtx0is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732553872; c=relaxed/simple;
	bh=Z6P1vbJRoR6U453YkDlYVMtfwVgpUxsKiaaruZVmf48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Goxd1wEsrzpeKLYgy0elX+jxqxp1lewQkPQ4P0AdJj6mbD5tokKlg8HkM83axuW3F0QmW9x6zHo1uh8ciJyCBLY0rZOVPNsEX7cv7nOqT25S2o+H0Ou0uXH7UgOSdDa8SuZB9EFLa0yR0Qwrj95DebZyLE4OITKlfssoLZC3nhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C6q/3Xkc; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ffc7a2c5d5so9594831fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 08:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732553868; x=1733158668; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YZj7Tss77lciH17hRXQ1BEAAVY5qJ8Av4xkREtLcIzo=;
        b=C6q/3XkcZnjbX/Dc+pu0CsMBIMkpuPt7RuWaciX7o8HIu3uODBn509F/1qGLgKcvZU
         wOrWRU8D8e6yoNwPjuRrADOVJFRheDYB9rDEU4S+W7DCSpPK716MmntmRmmMHfkKwMbI
         bXxRsgHpVLghj0kSbJx+MmuKRb6Ha3sbphtDAr/BPOuhN3dZOG7YBmARV2/BNGAIDeXZ
         rDyMIZhjaapAddU/C5IdpWrMB6WN2m6IKpxRKKmzruca5IGdl1bY0XaycUeDC5xU4WSj
         YFwGgsftG0bKYIVnKZEo8RqbDfUtEmwgluYccXI15UCvR3n1Yxp1jWND8BfS+EYeuFqQ
         5y2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732553868; x=1733158668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YZj7Tss77lciH17hRXQ1BEAAVY5qJ8Av4xkREtLcIzo=;
        b=eie7e1s/ZAsQlbDl7CYQArqC50E+HwzoqbwdkDesT8V5jUjbQu6g2duyVZLPvnwqz2
         o205hbIcbtVVnQVSuk7xEIhglrf2x0EIc7TBIvpQHVFKeE6O/tKu8filGIFZqyD8NYG6
         j/ALCcl1JJN/hDFiR17cn8JM0tMbT4NTYqDOsgPTM6Y07eVQtZImQRK+PMdYNQtwwIbN
         RyzolklKF/ybzG4rBfP+XWD7NnfRD0f9EmMZAjdpMUeC6VcZ6HO8c/6IE8Xsd7C0tbS3
         PgPSCF16Pv/RUk3ZJBm+7yl9R8Fty6+GJS3IyOOo718kxA/BufrZZp50T44VZcaCs8Zw
         584Q==
X-Forwarded-Encrypted: i=1; AJvYcCXCK7wFYJa4uFDO+eTvHOP0fI+7g8J1IwmsLhkTZuk2OPzS+h5v/tPXmyNoTn23rwRFTjPD+eCEXRnaoHI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv5p9iXARIk7IvQZ3c+qwrk5wy0a4iBsCmNIwFJjbqrgUDbtH5
	axqtB0cCNq++fb3VMkNLBxySEPnl2JpE78fbjW7soXnq7zTVge5mS/PsBoI1jiaDrmwKb9nGSAk
	rhW6fb7qnbPoLW1I2FvDtm37N9g==
X-Gm-Gg: ASbGnctnWof//HZ2ixzUZCGebQuYN/XBjCyJOBALGHYQKA87138EyiJHpzOeNgUHP1M
	dkAAMPZWz1HQr8qJ4CAzw/GF6uFC++1/7NfYiXfV1O/MGNA==
X-Google-Smtp-Source: AGHT+IFQmU4WTgOVBRDGwyFzVHvE4qyUE6ZeAmezGevhgjS7K+k18MZ2tyY56i/H9+r7/w0jtwqanR4Lfl92sBz3FPU=
X-Received: by 2002:a05:6512:6c7:b0:53d:de36:d0e5 with SMTP id
 2adb3069b0e04-53dde36d13fmr3338826e87.14.1732553868282; Mon, 25 Nov 2024
 08:57:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122163139.GAZ0Cx63Ia9kgYgRIr@fat_crate.local>
 <Z0C3mDCngAf7ErM2@gmail.com> <20241122170227.GAZ0C5I-F8AUpwCAcG@fat_crate.local>
 <Z0Q0PJzTMg_Or22I@gmail.com> <20241125102223.GBZ0RP375DufF0QQds@fat_crate.local>
In-Reply-To: <20241125102223.GBZ0RP375DufF0QQds@fat_crate.local>
From: Brian Gerst <brgerst@gmail.com>
Date: Mon, 25 Nov 2024 11:57:37 -0500
Message-ID: <CAMzpN2gysxoKsjGhdSwykxQ1a_F0pZG=j6Y76QDgSmNG3V7SPg@mail.gmail.com>
Subject: Re: [RFC PATCH] x86/boot: Get rid of linux/init.h include
To: Borislav Petkov <bp@alien8.de>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, x86-ml <x86@kernel.org>, 
	lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 6:08=E2=80=AFAM Borislav Petkov <bp@alien8.de> wrot=
e:
>
> On Mon, Nov 25, 2024 at 09:24:28AM +0100, Ingo Molnar wrote:
> > And if someone doesn't add the ugly KERNEL_PROPER_HEADER defines to a
> > new header that somehow gets included into the decompressor build
> > virally, it won't fire either. I think it's better to concentrate the
> > uglies in the 'weird' code, ie. the decompressor.
>
> Yes, I'd need to think of something slicker...
>
> > Also, what's the root problem being solved? The changelog says:
> >
> >    > no collisions and ugly ifdeffery when those kernel proper headers
> >    > get shared.
> >
> > But that's pretty vague - is there some recent build regression this is
> > responding to? Which kernel headers collided with which headers used by
> > the decompressor build?
>
> The sharing of headers has always been a PITA. Because the decompressor i=
s
> different from kernel proper, the moment you start including kernel prope=
r
> headers for functionality, you need to exempt or add ifdeffery or do some
> other weird dance to be able to share those headers.
>
> Things like below are only some examples.
>
> So I'd like to separate the two namespaces and only share common function=
ality
> through asm/shared/ and avoid all that ugly ifdeffery and workarounds we'=
re
> doing. Because each time we have to touch the decompressor - and we get t=
o
> touch it a lot with the confidential computing stuff recently - it is lik=
e
> a house of cards.
>
> I hope that makes sense.

How about removing the kernel headers that you don't want from the
include path?  This is a part of a broader issue where different parts
of the kernel need different compiler flags (main kernel, VDSO, boot,
etc.) and the current makefile structure doesn't handle that very
well.


Brian Gerst

