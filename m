Return-Path: <linux-kernel+bounces-521608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2077A3BFE1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 662E23B537C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 13:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4A01EA7F0;
	Wed, 19 Feb 2025 13:26:17 +0000 (UTC)
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E941E8339;
	Wed, 19 Feb 2025 13:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739971577; cv=none; b=LnuTvNdI6GUMDT+XZTWDWGDeLfIJ0TPziP71JDV+bBr5GVULt1kh6WELyFa+3U0FXXsspHdmSMmdoJZvuqcP9lO1zY+r22s/nVm/l6/0120cOUkdXaSjkfk41oZscV7oF/wklPs6lB9agugoYqVzF6elepeyjII7w/OMKMDKKrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739971577; c=relaxed/simple;
	bh=HYlKWCDdRQA017nK/x1uUpaYrn41MgwmoI5QgAxA2hU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ajkp/uW6Y5TUcgAX2KFGuvD443jAKPB47DMPronqHFsjxLRu53RIjvZmALMCfg1aRcs1Fp0T+OfDyiP0bNk57t8TEAG3JjvlhQH31UwnX/Y6NquVWmkDTAR7nQXLofX6Ko4gC1L6peuF/rcNtAderQFjKtuCt5QkF8vygJMc0Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-51e902b58c0so4047359e0c.0;
        Wed, 19 Feb 2025 05:26:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739971573; x=1740576373;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JOe7FxW1+GHMaHIpdwnQzHku6W752ees95gkUS64ZLg=;
        b=t++DC1W16HtPz8sV8jMEyMTM9PUZWXLTCyB6O14dxgysE40rjgWlcokKkyieEbjD3r
         DgkmZnmn8+lEzD3DQ3X1aZ1f7fA0PO6LeWTuedBpX4TaTFLdRelN4OJd69yubz7PsIBW
         TorZCNiWyiMaeLmm6zAwh3hErR/qpLrcYAxEUxslE5fu0QnxuAeqAAuL1wqxQulHSC8V
         QlBO6kCvSFqgNp1PCCqd9vwDVcsj3D/AymDdzznF8uKdpDJz/YjuyyY9OcIEi7mX5jRH
         RP14rqjwR0ATlaonz1i53lwMxHtuNBxWIEKeY/L5dK7X92HYus4KstZ97FSUWry5pwBQ
         G1XA==
X-Forwarded-Encrypted: i=1; AJvYcCUzNK01n3SQrAXWX5+i1PUGBULIAGssgBg96zhyAinlYCY/c/uTSLVALEzIbB5R4+kivL1R1j5Elrta4Fo=@vger.kernel.org, AJvYcCWzh5Dw4a38RpMf/48GeL73f5Z4zVdxSW3aAvT2IGCQ0c1gsYDG7B/hNnaM957VOcc8CdNd23yOX3z99TgSN0k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1dCsXd9yx7WaiZKNQL7R3wDgpbwLDrxGxPJPZl6MkqIPiSL/5
	0KFmcNTz+Pv15b2ikdkQ1IhkbVDGnGtkfkzz4bPNW4Rm5PF1gE07bSuO16sG
X-Gm-Gg: ASbGncvSj4CcED5neaST6T1/8pn0LFTHKAV0s2Is1Z6vGLD7HRvYiPbzRaurH1ZRLx5
	LiUAeyAAIVgsd21cxOcf/4msqHAV7GU90bn2e+f4gKSADkhdHK2ugw4b8VEmhI6hBHBCRR4swY+
	Osa06OkVfWh7OXXTkMLZtcyd3uF4/Z9R3IgpxzZ2FCqfBHqQNVRG9mVcvcalpwlDCCuqQq48plW
	F65mulrw4m7t51oB+TEuRjb/i2zxHIPGpSddIScpdA5w96Bm+4RTLJUCLDetzqcwYcTDNCM3Xnz
	dq92TAgxvOIsFXiutazcnbGe2q23XDaaoLuBvmFP4cZsvdliU2kJeQ==
X-Google-Smtp-Source: AGHT+IEy7x1pOQEULOMJQvQTcrsHZUpY/lyapLK7k74AH78pYQYsVyNt2Tl97l1QAR7PzdvOUsFh6Q==
X-Received: by 2002:a05:6122:91c:b0:520:63e6:79d1 with SMTP id 71dfb90a1353d-5209dcea152mr7181974e0c.10.1739971573429;
        Wed, 19 Feb 2025 05:26:13 -0800 (PST)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-520d028985csm1436268e0c.12.2025.02.19.05.26.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 05:26:11 -0800 (PST)
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4be25046fceso2465599137.3;
        Wed, 19 Feb 2025 05:26:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV0kHBPhuT7BDnrwc9eRn3pOUxQ/is5ZPp4DePmcvKYbnQ/2T7P3YpJm72ZnBStnwpyhVX7RTaOjNoCk/BcJsc=@vger.kernel.org, AJvYcCXQQWxUgliolEQSGuy8h/e+hL5W7h0M94gdQPv9m4r9ze6npTx28yZXYOxVuRqzxML7kKnIA30cJA1btZI=@vger.kernel.org
X-Received: by 2002:a05:6102:80a3:b0:4bb:edc9:f95c with SMTP id
 ada2fe7eead31-4bd3fd57f40mr9878304137.15.1739971571449; Wed, 19 Feb 2025
 05:26:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z7SwcnUzjZYfuJ4-@infradead.org> <36783d51be7576fcdbf8facc3c94193d78240816.camel@kernel.org>
 <4cbd3baf81ca3ff5e8c967b16fc13673d84139e8.camel@kernel.org>
 <e63089e15c6f4d19e77d2920d576e0134d8b7aa7.camel@kernel.org>
 <Z7T5_WGX_VXBby9k@boqun-archlinux> <615ce44fa528ad7be28ba518e14a970f04481078.camel@kernel.org>
 <CAPM=9txBg1m=qp9=nHJXS1h2XB8TSL1tj6CF=Z802u=YX7hBDg@mail.gmail.com> <c84254c0164de551189a1f92ddec71f5dc222e42.camel@kernel.org>
In-Reply-To: <c84254c0164de551189a1f92ddec71f5dc222e42.camel@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 19 Feb 2025 14:25:59 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWNQfmNgMBkkMezeUt573fczzyf7FhXKEo7621xuhWC4Q@mail.gmail.com>
X-Gm-Features: AWEUYZn4XOlU3xEA8NygLrT4kEbl_JLjkhKpcGEqNeKU7F_TibfeVbW1m0EArKo
Message-ID: <CAMuHMdWNQfmNgMBkkMezeUt573fczzyf7FhXKEo7621xuhWC4Q@mail.gmail.com>
Subject: Re: Rust kernel policy
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Dave Airlie <airlied@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Christoph Hellwig <hch@infradead.org>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	rust-for-linux <rust-for-linux@vger.kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Greg KH <gregkh@linuxfoundation.org>, 
	linux-kernel@vger.kernel.org, ksummit@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi Jarkko,

On Wed, 19 Feb 2025 at 12:39, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> On Wed, 2025-02-19 at 16:35 +1000, Dave Airlie wrote:
> > On Wed, 19 Feb 2025 at 16:20, Jarkko Sakkinen <jarkko@kernel.org>
> > wrote:
> > > On Tue, 2025-02-18 at 13:22 -0800, Boqun Feng wrote:
> > > > FWIW, usually Rust code has doc tests allowing you to run it with
> > > > kunit,
> > > > see:
> > > >
> > > >       https://docs.kernel.org/rust/testing.html
> > >
> > > I know this document and this was what I used to compile DMA
> > > patches.
> > > Then I ended up into "no test, no go" state :-)
> > >
> > > I put this is way. If that is enough, or perhaps combined with
> > > submitting-patches.rst, why this email thread exists?
> >
> > There is users for the DMA stuff (now there should be some more
> > tests), the problem is posting the users involves all the precursor
> > patches for a bunch of other subsystems,
> >
> > There's no nice way to get this all bootstrapped, two methods are:
> >
> > a) posting complete series crossing subsystems, people get pissed off
> > and won't review because it's too much
> > b) posting series for review that don't have a full user in the
> > series, people get pissed off because of lack of users.
> >
> > We are mostly moving forward with (b) initially, this gets rust folks
> > to give reviews and point out any badly thought out rust code, and
> > give others some ideas for what the code looks like and that it
> > exists
> > so others don't reinvent the wheel.
> >
> > Maybe we can add more rust tests to that particular patch series? but
> > this is the wrong thread to discuss it, so maybe ask on that thread
> > rather on this generic thread.
>
> Here's one way to do it:
>
> 1. Send the patch set as it is.

You mean the series from b) above, right?
(To be repeated for each subsystem for which you have such a series).

> 2. Point out to Git tree with branch containing the patches + patches
>    for e.g. driver (hopefully for something that QEMU is able to emulate)
>    and other stuff/shenanigans that allows to test them.

Exactly.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

