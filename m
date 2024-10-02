Return-Path: <linux-kernel+bounces-347580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE5198D5BA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 15:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFC021C21A51
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 13:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006561D0946;
	Wed,  2 Oct 2024 13:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="bx8NkI1S"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8991D049A
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 13:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727875969; cv=none; b=V/UUB/R2wqWYOMAy5fMxOxAa00R3+F+EEVRoawHQtPiT/v9rUnMDueTZSpvvkScD6/M1v2+kGiMW+XqEQeH+S5Nqr205lDOKWeo8g7mpAwcHiDuGWSL0RLzjKY7Tqun47Hu8TLgahcA0HtQJweZdJuodHBDPsax06K2anzbunUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727875969; c=relaxed/simple;
	bh=MmVbytaRCHeK0GOf0K/308WnBMUo9XLVumkvmAD/D9g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gxoZnhfcdkvow6E5xJo48jlvJk5v8Py22g3ttkkZ7uLVBUoakPn3SPSsn+gNEJl4gqtUxqLK4KcXhS0XTtSSeJfx/5icrD8p4Av0R36AGTxaXkh9xPhteZp/r1rK2FFlNcyXpVfe3Wsw/zCsVWktuV3tDy2Qo+H0KN3UVDILGK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=bx8NkI1S; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2faccccbca7so31365181fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 06:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1727875966; x=1728480766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MmVbytaRCHeK0GOf0K/308WnBMUo9XLVumkvmAD/D9g=;
        b=bx8NkI1S1iWYEowcfwYcLgX//fWhncGha+etF/95BQMurQf8DmvzKVngTq2YIKXFGL
         vx0vpQvYV7jAWKzV0XC0wFwtb/j0IOuEflMRd3kmfeV6OMI+pVMZjaDAJdQGktelSawK
         mBhghALnlm0RL9XOtjIfJqRBHM5BO4aPlPMMZzkx3amrWTr3QWM+2EAYV9cS3+Ue9AkE
         fnPitMwNdcVM7DvcPCmf9xsq9I7Yf+uq37tefkciiHr2RhTn/uz06bVa1GNqkugzVOjc
         rxEi7jKeaIcwbGRmSimUFCxyFDH+FfSf8JY0H04nBpdf/YjC7xR99+6jq4a1kbwE/n8j
         fYSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727875966; x=1728480766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MmVbytaRCHeK0GOf0K/308WnBMUo9XLVumkvmAD/D9g=;
        b=I7FglPMUHB7MFgxLmu2NMXgFJ2pMIwNIhRBOpIbDlgM6r7L2EJT7vBv9ok1X10Wx5H
         Iq9AZBQbB7WMYUJZH2g6dfpaqE4zQ/Tjb93MhezF3JYs8urKXkUdH/2uxkheuPtSrsb1
         Dw6nOJULaDKXJBSULFZcYcXNSMboGIL/5FiNd7OV3BhwblvxeH0rBFsehA+qYiCthaUH
         4e00CN2Rq+dj+gKVjX14EKiXxY2Tx5XgdeXOgMTMC04fOK9UMkBTc/pzuxu9JL2Y50HT
         0ofMRziZ4jtnq34SWyhBSZSU3/LMdICwKTAgEoKIhrfqsXtHWxt4cI00JPZkid5YZRgC
         ml+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVbDMFsc/oAVRN1qE+8j5Yzzy7m4bcRb+SZPOxgkQgBkzWGyqwzUmUVbXWzRE6pxpRAvEFPD9P875D9ao0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7kdAVtyeqNtgcaBZvr0eqbucMYC00fjqk/8cHFnHO144qgJJQ
	x+RGLYCUxAIZsdYvOCXQseMqhc/5vvD4qOblZO8A8QaLHaPmMM7IWJNetNeL9sNaIlee07yMt5e
	rVCZnIKWuiGC9htr07DNRfWV6aK4zyqD6N9yoQUIAhfIZCTb/
X-Google-Smtp-Source: AGHT+IGSoR2oYpSDRRYRSLGqKkMgx9JGiEy1OP0+HHmqnptfQyZ8E4IF2hcvOIYzFtye0Syh0VO6sL9EtTxJmT9YAZ8=
X-Received: by 2002:a05:651c:508:b0:2fa:c57a:3b1c with SMTP id
 38308e7fff4ca-2fae1016a1cmr23090481fa.17.1727875965921; Wed, 02 Oct 2024
 06:32:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925173504.1906872-1-robh@kernel.org> <CACRpkdYh22c08kLWDJ3wmK+i9-C2ngXdJwhg-kAXfdy2+mcB0Q@mail.gmail.com>
In-Reply-To: <CACRpkdYh22c08kLWDJ3wmK+i9-C2ngXdJwhg-kAXfdy2+mcB0Q@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 2 Oct 2024 15:32:35 +0200
Message-ID: <CAMRc=McdAwEUCDouUeOENt36LZ+d4Fd=yeqzm9dn83XSqZpQFA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: gpio: st,nomadik-gpio: Add missing
 "#interrupt-cells" to example
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "Rob Herring (Arm)" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 3:04=E2=80=AFPM Linus Walleij <linus.walleij@linaro.=
org> wrote:
>
> On Wed, Sep 25, 2024 at 7:35=E2=80=AFPM Rob Herring (Arm) <robh@kernel.or=
g> wrote:
>
> > Enabling dtc interrupt_provider check reveals the example is missing th=
e
> > "#interrupt-cells" property as it is a dependency of
> > "interrupt-controller".
> >
> > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> Can you please merge this into the DT git tree?
>
> Yours,
> Linus Walleij

It's already upstream. I learned it when I tried picking it up. Rob:
any chance you could send b4 notifications when applying patches to
your tree?

Bartosz

