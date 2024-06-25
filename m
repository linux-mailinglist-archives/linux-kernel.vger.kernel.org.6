Return-Path: <linux-kernel+bounces-229304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF5C916E1C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 18:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EE3EB265AE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 16:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E303A173325;
	Tue, 25 Jun 2024 16:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kr5ItlXs"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D9A16FF59
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 16:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719332842; cv=none; b=cYUMfoPhWWS7zZjt4W18jMLToTrLUFC4GE4A+sq42Xodyo/m4B+VQfZThgFHUmkmQywkYEC3B5+hcnsVvBEBbNmezL16eq5Yt9Cs4qDIl6HHWV+SX6GJ2rOWi+STKdblX+rlJM9AZfbbWDFnEy5Pncn9Ay3StZywuQoFK63gEj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719332842; c=relaxed/simple;
	bh=FBgM8X7N6EV6X8VIVrL7KoXestIzzEPz81jUwgaNSTc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XlwhCTxFSaRfZ22BFRiqm5Q0sgBFKu6X1f/S5YQWbmR50fAkXRt1W1dgF7PVmjkS3TrVVeB+iwHt+Ew4Q1ZvxMTTMvXwjxuYeujEfLCHGylSQzsfU5OWqxDSgko2wv6gBxEzFUZ5JhrAMjggLKBF0dGwZ9tAaa81E15PUtZIICc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kr5ItlXs; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-79c084adaf4so44928885a.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 09:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1719332839; x=1719937639; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kd5y9hhIUx6r9hI0VhGrF9yxcbBN+8LVyQQ2ESHR5Ew=;
        b=kr5ItlXssd5XHeMY3sR1Gp0Eay0spKkS7xHUCx9FGrGtfco4rexAN4zQYVzqDowoBG
         iUWcsXjztqDDRQ2qFRDMdOwQKUuyVoaxWPp0O8yq1aZeT3MW9kpvrt2xeZYjl8IiFhPd
         ROOyNnP990NW/ELwJLehH+2lpVlpdSBR970Co=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719332839; x=1719937639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kd5y9hhIUx6r9hI0VhGrF9yxcbBN+8LVyQQ2ESHR5Ew=;
        b=D/5IR0s5eSSumxn6dxCqUtdcdyjCzwjAPFPk4oSh08or3ptRkt/7KYr8oo3z2N+T4h
         75i8dsuRvwmZbZVHLgIehF4wXTf3FpWsSHvWyYbGnIg3MMWduj4bQpEiV0fJ80T00JjT
         A9rXJcZICXWxUjtXXkT5DPYyVtuf3cUh52mWbKyUPC/r0p2Lf6Kfarn9vN6Amtxwi8+d
         m1mtHSHm+kINn0kRMUva0MnAV/bhGYrbnyMBZ0JhDlLk2oFAts2R4+9bnm/aF1et7U4D
         cPL5QyGBMw3q684Dx/RK2WL28+0iRKhjEhuXsXm4C6qPL1NorblO0hM9INUOreMXzUto
         npqA==
X-Forwarded-Encrypted: i=1; AJvYcCUe7+28NF67PbgksCeWIgaqzeBWVwdFc1esY80jrOIDdTRH9xGYZPwTqNFhRUSoWPDe3T35uDSdstFcNAIFJjsQrmedXckAJXTxJfF5
X-Gm-Message-State: AOJu0YyCHDaSZGgQxhwG8jhk0XgGIpFhpZdG+BXqvvA0ZGAR2TRgADUI
	cEIGjaB6n+aE6PBfcjDIbAKmqoPO7srmcMPeoeKyuIQ/9zleVdsgM/Rmmo3vsLq8NICFPWTHbGk
	=
X-Google-Smtp-Source: AGHT+IG2MmG9Xk0HgJWaXkTXp6QdDg/whiXHbnJ/x7UqEBTOFc5nHbZJcZwLG+HUaPfP5v+vJ06+Ow==
X-Received: by 2002:a0c:f587:0:b0:6b5:4ac9:dd55 with SMTP id 6a1803df08f44-6b54ac9dfb2mr71300086d6.0.1719332838931;
        Tue, 25 Jun 2024 09:27:18 -0700 (PDT)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com. [209.85.160.179])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b523cbef49sm42595886d6.77.2024.06.25.09.27.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 09:27:18 -0700 (PDT)
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-445022f78e1so109241cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 09:27:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU90FLeMTbW8SHdTG8qh4JR8J/CpcL3F+08TaCT1X2M7YdMF9C1sVsqGuvIQkyaWjO2xKTNsZKBhQQGugItQEN5WWnpZMA+mBR0K6/f
X-Received: by 2002:a05:622a:2a1a:b0:444:fe9d:7bc9 with SMTP id
 d75a77b69052e-444fe9d7f9amr1978871cf.8.1719332837590; Tue, 25 Jun 2024
 09:27:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624133135.7445-1-johan+linaro@kernel.org>
 <20240624133135.7445-2-johan+linaro@kernel.org> <CAD=FV=VZXnnbwTNc6dSqZvyCUc0=Wjg9mvBYsA1FJK3xR6bDEg@mail.gmail.com>
 <CAD=FV=UwyzA614tDoq7BntW1DWmic=DOszr+iRJVafVEYrXhpw@mail.gmail.com> <ZnraAlR9QeYhd628@hovoldconsulting.com>
In-Reply-To: <ZnraAlR9QeYhd628@hovoldconsulting.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 25 Jun 2024 09:27:01 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U+D34mkDoFkmEXUm9fCAhC_RKbHnKXHsDZFQPxDaPmtg@mail.gmail.com>
Message-ID: <CAD=FV=U+D34mkDoFkmEXUm9fCAhC_RKbHnKXHsDZFQPxDaPmtg@mail.gmail.com>
Subject: Re: [PATCH 1/3] serial: qcom-geni: fix hard lockup on buffer flush
To: Johan Hovold <johan@kernel.org>
Cc: Johan Hovold <johan+linaro@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 25, 2024 at 7:53=E2=80=AFAM Johan Hovold <johan@kernel.org> wro=
te:
>
> On Mon, Jun 24, 2024 at 01:45:17PM -0700, Doug Anderson wrote:
>
> > Also: if we're looking at quick/easy to land and just fix the hard
> > lockup, I'd vote for this (I can send a real patch, though I'm about
> > to go on vacation):
> >
> > --
> >
> > @@ -904,8 +904,8 @@ static void qcom_geni_serial_handle_tx_fifo(struct
> > uart_port *uport,
> >                 goto out_write_wakeup;
> >
> >         if (!port->tx_remaining) {
> > -               qcom_geni_serial_setup_tx(uport, pending);
> > -               port->tx_remaining =3D pending;
> > +               port->tx_remaining =3D min(avail, pending);
> > +               qcom_geni_serial_setup_tx(uport, port->tx_remaining);
> >
> >                 irq_en =3D readl(uport->membase + SE_GENI_M_IRQ_EN);
> >                 if (!(irq_en & M_TX_FIFO_WATERMARK_EN))
> >
> > --
> >
> > That will fix the hard lockup, is short and sweet, and also doesn't
> > end up outputting NUL bytes.
>
> Yeah, this might be a good stop gap even if performance suffers.

I've officially posted this as:

https://lore.kernel.org/r/20240625092440.1.Icf914852be911b95aefa9d798b6f1cd=
1a180f985@changeid

I realized that I didn't need to re-calculate "chunk" so the patch is
very slightly different than I posted above but should be effectively
the same.

-Doug

