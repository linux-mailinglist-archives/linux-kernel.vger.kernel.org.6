Return-Path: <linux-kernel+bounces-275318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 799CF94834E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 22:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D5F91C20D37
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 20:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1054116C683;
	Mon,  5 Aug 2024 20:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gCe+/Ij4"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930D014AD30
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 20:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722889312; cv=none; b=jGQCu/yGDcYjO1c4L5j3jB+5UCgZ9x0fDqwtW3LBGDb2wgsFWClARiXEdNGHDwuoj9k/9cca5n76CtGpQ7aV9l9Kt2VKxhcyMGNNp7heLSR81+WGHSwx5lmhoPC00jlWUo/WFoPiSMTy37HF4rK3iXGW7dOduph6AqGOVv4Jq2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722889312; c=relaxed/simple;
	bh=wHMEn1zFd24Oer0tEUkzcZ1FcJ9lIJ1Vzd9N2/oCrQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PF9ZCDWZRN8GgrzVZZWi3/51hfG2fRIl7tDCTlk2/PASknFpOteEI8tdosMyOQfp6nDo8oNvNHdhhmgzw2QzdCf9RkUcCYRKndHNIK+6gnFeKn/dlTaPmgqzmfIT+kAz8LL6Hrdhdv6DhjqcsAEAq3euPYNEaTdExMUYbOYP83E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gCe+/Ij4; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42817f1eb1fso68240845e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 13:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722889307; x=1723494107; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C2VtB6mWVBKDX2VzFpUFwlx5syPrh3Cm35/Cbik5opc=;
        b=gCe+/Ij4QZYwq5SRc0kOKe63fZNX3HZdyNs5izTQb3y7+mxHefqUjKFvfAetPWa/ft
         /LM3pqNzoC84gIV547w19TzDWvXSyoTfjK4gphx+kncTs/oGleQkjQddJxQlaJONgqPI
         JRvyuoLcdHJ30J/vEV0iZGNrlmPokdepTXlZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722889307; x=1723494107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C2VtB6mWVBKDX2VzFpUFwlx5syPrh3Cm35/Cbik5opc=;
        b=A7g4gr2STOWGj7RnMuRQz8rBVyHJm+im6MdvKCPvXzQPYAMZ0EAASnCSqp5cqcOaHt
         bdFs3NZ8OH8qcHx+SzlagGUo8VNq8jco8oAzAfg0KXpalWyLUGuxYw2/3yAPeYyenma2
         P5j8gIAhaeeca5NT53geetKXzRaLHVz3vdeL+z2iFCBfgD2Md8WlC7iAIFgbC2pkTAl3
         SMAMSnOE1cwa+e4eICM1zJdffsBRfFXg2uu2OzMfa2ZPJYPznhhPJGPnAcKvB2+Cfhcy
         CO7xMbj8cUmBCPHa+PqCPCQOAt62vzEHdtjRUpySeHMMpngdAI+kriagZBS+ugMTR3PV
         xmXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNaQmbPKNm0SiBRTzIqyvIvR71FoZEUnNmX1QUu0qmTWvmdaGMqnebIHbCGx5TrhIQJx0z0rkOSsPr/yxCKPP7z65fKuWwE3Wil7Pv
X-Gm-Message-State: AOJu0Yz35NNUE5bzRrjE9waNBIriXx00kK11+gRlvVYzUSMfQEZvIW4D
	twffO/0DIdb5Di1ibDFlTBLN7YP2SvPlUInlkm16lxnrw6uxfrrMOQ89Oj/1vxGyo7rZtjfE2Of
	sZMEd
X-Google-Smtp-Source: AGHT+IF6CjnI02TR2XXn96aSWX8k1JTuXyW504j7C1dSyWDpnlD1XekHm3vS9mztykV+TY6U/GFotQ==
X-Received: by 2002:adf:f546:0:b0:36b:b24b:d169 with SMTP id ffacd0b85a97d-36bbc12e00cmr8402734f8f.32.1722889306801;
        Mon, 05 Aug 2024 13:21:46 -0700 (PDT)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9bcaf7esm494465366b.12.2024.08.05.13.21.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 13:21:44 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-428e12f6e56so21065e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 13:21:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU+nWD7OnpKkH872foTQOppmmVf32skBgfxgVSHjtAJ53zKF8iXkk3CgV2vaVuopuV/rqMlM8gswmGLImuAO1NpSXqeYcDCE3P4KktO
X-Received: by 2002:a05:600c:502b:b0:426:66a0:6df6 with SMTP id
 5b1f17b1804b1-428fe266b40mr116535e9.0.1722889303787; Mon, 05 Aug 2024
 13:21:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625160718.v2.1.Id4817adef610302554b8aa42b090d57270dc119c@changeid>
 <20240805165336.GA10196@willie-the-truck> <CAD=FV=WGfQeJr2CuA7J5XgytAVpVxZPpH4EY8e8y63wMOaHRwA@mail.gmail.com>
 <CAOUHufYWHECbnhfodCKzNp81YHCHomC2NhgZCtX3cHdzn48ROA@mail.gmail.com>
In-Reply-To: <CAOUHufYWHECbnhfodCKzNp81YHCHomC2NhgZCtX3cHdzn48ROA@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 5 Aug 2024 13:21:30 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VodEuhwaTh5ne0YCPkvxna0rkL9_mKN2tJzhWL3ToVEw@mail.gmail.com>
Message-ID: <CAD=FV=VodEuhwaTh5ne0YCPkvxna0rkL9_mKN2tJzhWL3ToVEw@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: smp: smp_send_stop() and crash_smp_send_stop()
 should try non-NMI first
To: Yu Zhao <yuzhao@google.com>
Cc: Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Mark Rutland <mark.rutland@arm.com>, Sumit Garg <sumit.garg@linaro.org>, 
	Misono Tomohiro <misono.tomohiro@fujitsu.com>, Stephen Boyd <swboyd@chromium.org>, 
	Chen-Yu Tsai <wens@csie.org>, Marc Zyngier <maz@kernel.org>, 
	Daniel Thompson <daniel.thompson@linaro.org>, 
	D Scott Phillips <scott@os.amperecomputing.com>, Frederic Weisbecker <frederic@kernel.org>, 
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>, James Morse <james.morse@arm.com>, Kees Cook <kees@kernel.org>, 
	Tony Luck <tony.luck@intel.com>, linux-arm-kernel@lists.infradead.org, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 5, 2024 at 10:26=E2=80=AFAM Yu Zhao <yuzhao@google.com> wrote:
>
> > > > +     /*
> > > > +      * Start with a normal IPI and wait up to one second for othe=
r CPUs to
> > > > +      * stop. We do this first because it gives other processors a=
 chance
> > > > +      * to exit critical sections / drop locks and makes the rest =
of the
> > > > +      * stop process (especially console flush) more robust.
> > > > +      */
> > > > +     smp_cross_call(&mask, IPI_CPU_STOP);
> > >
> > > I realise you've moved this out of crash_smp_send_stop() and it looks
> > > like we inherited the code from x86, but do you know how this seriali=
se
> > > against CPU hotplug operations? I've spent the last 20m looking at th=
e
> > > code and I can't see what prevents other CPUs from coming and going
> > > while we're trying to IPI a non-atomic copy of 'cpu_online_mask'.
> >
> > I don't think there is anything. ...and it's not just this code
> > either.
>
> I agree -- I noticed this a while ago [1], and I added
> cpus_read_lock/unlock() on the caller side, because having the locks
> inside callees can be a problem for callers who can't sleep.
>
> [1] https://lore.kernel.org/linux-mm/ZnkGps-vQbiynNwP@google.com/

Sounds reasonable. I'm happy to review a patch doing that.


> Also, do the handlers always see `crash_stop` set by the sender? If
> not, would it be a problem? (In the above link, it has to do extra
> work to make sure that handlers eventually see any updated values.)

I _think_ this is OK. It's been a while since I wrote the original
patch but I seem to remember thinking that I didn't need to do
anything special. Tracing through the code again, I see in
gic_ipi_send_mask() the comment:

/*
 * Ensure that stores to Normal memory are visible to the
 * other CPUs before they observe us issuing the IPI.
 */
dmb(ishst);

...so I think that means we're fine, right?

