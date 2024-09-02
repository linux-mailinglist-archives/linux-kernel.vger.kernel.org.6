Return-Path: <linux-kernel+bounces-311137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C363B96854C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8661B2826B6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D5C17F389;
	Mon,  2 Sep 2024 10:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBLHtNvF"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C563A7347B
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 10:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725274223; cv=none; b=Ma4pN/IFJrPxESzD/y2A9mGP4GDZ3IJp1AuP2sMn53YIqLjFcGcKtHSFysBdfkDYp5m4/UomsMgzwsNEXznzjGJt8vsta/jDVo/XL7mKwWwep19MyAoCk/sB48uScdJiW//5Bsu8ygoJSuLRS73aWx3Uh3Vg//iO9fBhd50bDAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725274223; c=relaxed/simple;
	bh=xzIxyvFaGu/lXt7uMruDYTE1w8muyitkE+oBI99apMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M3Id2D7/HHhQfPbaEL44wIzSiVDzwD+bkOd/Mf28IAw8EaiYzXIfFzq65878ihkEnudV7aTWbSqFMtKV0tct1JBoBM6Q5+1Q1mVL7k/jNtin1fh1WotChjuvBE3sK+hd5nBT6K+W4NXHnyGnpoNgDDl1m0/UMZ0ysuVSTbJb0eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nBLHtNvF; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2f50f1d864fso46342561fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 03:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725274220; x=1725879020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DWUP7HRNyt+jwib8gjx7GjoaGXD/YcwYZvl6nvy2rdA=;
        b=nBLHtNvFcsPfz4YvD3jhB0QKOpKiHBJNPDMg5c0aWpKPpUNemrbrFRQ3Sxkj6wGt8S
         ih5fh00yUH2odluEsP9bTez8pSz4KlvgjrxZyjdrAK/Cf9aH3LNDCeJ6xKg27qDyNmr6
         c1Tt0kKf8repHAXABgoi1//RDeqkgj386xnwAxdfxRj35U8q8ncPHdi4HQbP97nBLVGF
         fLqWQ3URIyO73JFwsa/dWp10k1X2ERdABf6NGRBAYZtid30y+Nf9HuZwBd+sY5jyTxGg
         SZIZ0o2kWDNP3FoF+T8s7J0JNBAJzY7/U5vAlTFuQxHqA2gen4UBD4ysZSBgrRClcPeg
         +TIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725274220; x=1725879020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DWUP7HRNyt+jwib8gjx7GjoaGXD/YcwYZvl6nvy2rdA=;
        b=vMUAeJ00IMHQDkxWbUpS8ZsGkqQd3dyCYxuZ5yCa7uvogP4x3+TBabbRqPs2Mzgfm5
         YKOqAvTCQDYXbCRLG2vVy5t+UxrTu2Wp1qN9gfq3zhZP4sOL20EacG2urxcbBQ8JUQUI
         Ye5iSI27BzgCN/PGGwMcQOq3j/XNznpoQCyvxG06O9FgqFSbUVqXqNnxhG7XMLB3lD+0
         PB3LAto9+LTuhhFyH+WXumkAEUpmr2hN9EtKxVHd2r/LHWnz9yRJlouarPIG9ctHFpap
         j08HuU6PRTX8SbPywsqGMtetyNmBkOoFhWHteNgV7KcNgG1Y9afjtYIn0bctaxxg+8MO
         CJJA==
X-Forwarded-Encrypted: i=1; AJvYcCXAGcWWtC/Dz/BPGlXXYemyMsix7ZapK7K5pRLH+ET6lFyVNVWlpeRz+8pkT3dl5iKAN8PbZPGD97fJcEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlnyZ40IsKc8krE0OI0DS1VsrIoAzHb2ad2XpAHv+5HKNQi6vu
	sSYjP7BeY6VOTZhrosZ9bwMb+us48098+jHygB9QNlnRHsQ/xYBMZj15UYfCBGVoyd5BD8NT+yB
	e0/jNV+6LScEwMO/gCG26ewNKTGW7Hnbj
X-Google-Smtp-Source: AGHT+IHiuHr77PXksfUPMShCT2zicDgFvA8LCQMqvPwonzT7kasMIlWFb4LaB2abfsytx1TmSTCD3vvahmbEB8U5tCM=
X-Received: by 2002:a2e:be9e:0:b0:2f3:aed8:aa9b with SMTP id
 38308e7fff4ca-2f62902dcd4mr44556831fa.5.1725274219089; Mon, 02 Sep 2024
 03:50:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730132015.8920-1-ubizjak@gmail.com> <51c33ede-b379-41ab-88b0-71615e214853@linaro.org>
 <CAFULd4Y83ciewbJe36jsuTVXL705_DoS_QpjKayniSCdqkpsEw@mail.gmail.com> <21cc2173-2934-470e-a151-ed3fe2bba9db@linaro.org>
In-Reply-To: <21cc2173-2934-470e-a151-ed3fe2bba9db@linaro.org>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Mon, 2 Sep 2024 12:50:07 +0200
Message-ID: <CAFULd4Ya-dx-=8yYeOd_gmzvXdriZX1i+pUaG9L+X5ykwJxXJQ@mail.gmail.com>
Subject: Re: [PATCH] clocksource/drivers/jcore: Use request_percpu_irq()
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rich Felker <dalias@libc.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 2, 2024 at 12:33=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 02/09/2024 12:11, Uros Bizjak wrote:
> > On Mon, Sep 2, 2024 at 11:17=E2=80=AFAM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >> On 30/07/2024 15:20, Uros Bizjak wrote:
> >>> Use request_percpu_irq() instead of request_irq() to solve
> >>> the following sparse warning:
> >>>
> >>> jcore-pit.c:173:40: warning: incorrect type in argument 5 (different =
address spaces)
> >>> jcore-pit.c:173:40:    expected void *dev
> >>> jcore-pit.c:173:40:    got struct jcore_pit [noderef] __percpu *stati=
c [assigned] [toplevel] jcore_pit_percpu
> >>>
> >>> Compile tested only.
> >>>
> >>> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> >>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> >>> Cc: Thomas Gleixner <tglx@linutronix.de>
> >>> ---
> >>
> >> Added Rich Felker in Cc
> >>
> >> Applied, thanks
> >
> > I think we also need the following patch, since we changed request_irq
> > to request_percpu_irq:
>
> Hmm, I think you are right:
>
> I would say it is:
>
> static irqreturn_t jcore_timer_interrupt(int irq, void *dev_id)
> {
>          struct jcore_pit *pit =3D dev_id;
>
>         OR
>
>         struct jcore_pit *pit =3D this_cpu_ptr(jcore_pit_percpu);
>
>         [ ... ]
> }
>
> The former the better for the encapsulation.
>
> Do you mind to update the patch ?

Done, v2 with changed jcore_timer_interrupt() was just sent.

Sorry for the inconvenience.

Thanks,
Uros.

