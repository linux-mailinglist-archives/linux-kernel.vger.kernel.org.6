Return-Path: <linux-kernel+bounces-183914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FDC8C9FCF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 17:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1769F1F21A0F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 15:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4ED213775D;
	Mon, 20 May 2024 15:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jcDWKg0s"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940ED13774A
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 15:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716219523; cv=none; b=HYi1BhGv63J6MlEKh78R9qzS6zc7aJoP8w8iiOlA2kIoV2KPUTce8yXqdgkDiGCqpo9XEYagbX/mqUC5dWdUjnI+KbSnPyXjtiDBqQxmRnCUpPk4TdkWCJjO6DdwA0En3skL+m3FzTUNkBw++wjA5YaXFxWoCEYkogtKdUdZoN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716219523; c=relaxed/simple;
	bh=xR38KVD3bbKUAoYUfwjtudqWW7AHDRaw+vcgMm2ki0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GcPNatY1Y6uL9Ywnd94pzetMAzBOfbQ33yEuf99rW1HJHiqBEMBvk5rtfaqPpkB6HUN44sKYT3M/y5MNz4LDq0f+3ECt0pDzdCJAvJg+ETfagd+wwsY2piX2tx3jES1MnVeiPEkbmFc1JyLiwUx0tDs1D9Vtu+Hz2EnQxv3FDDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jcDWKg0s; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-792b8d98a56so263191185a.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 08:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716219519; x=1716824319; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OKPnejpOVVglMsc+d8kH/kXQPdEfmoXhhEf4Gy8y/h4=;
        b=jcDWKg0sCj9Z1di9jCbTIx5rkSsbT3LhrbMyn7yENFnTPNcxNyDJ0zf0d2CHFf34JT
         i576qs6AC94WVfmFFMgIVz3ZdnOGZ9GHmN92EktC2txstqXDkWTSK6hoWeo9Ptu8yLIa
         ZGZL21wAbxmorqAO4T1F1IZj8Gq2/r8mQeISU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716219519; x=1716824319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OKPnejpOVVglMsc+d8kH/kXQPdEfmoXhhEf4Gy8y/h4=;
        b=eXGpFBoOiqLcbopVSWA0LNwqikM//5xTzUjuRwZ6vYqBp5KSNn8mvd4iiMLT6ob1/P
         1wZOAqe8qc3bU7Vwwi+wq0oE7Ewbuhnh+bF3a3KNuwdu3RxZZ1H6unajcfJltV6Dtu5K
         nMXlT+kzuChoknJctDBeR/n5y8wzdCkNo8xXorIEu2ZDmNEqHeNo2WpzGS4/iVKLJXiC
         uTFTBbgPKL7X7CdgvXZygVw5ouPqM7b/F1zK195t2hnwKj0wC5+NJIX449T4w7ioe9uD
         uReD4RnC5+ElBS4TIwTAj1QOWOk7mTx33S2UTcXGNDnh2dhxODFgwkv/fTGZEy+zhpwn
         dSXg==
X-Forwarded-Encrypted: i=1; AJvYcCWetau5+J6flj1cDT6WU7gS4Cs+/SN1LJPgX7HsGbpbYZWoIuI2gByYGD9KhcRmXggQdXbMy8phaz9T79ERLg5vdUceDWkTAIL6LECY
X-Gm-Message-State: AOJu0YzAFr1pzjU0BrDhph+CAz0qXGY5wJXlFqktDjkNFSi+6/vNHPxR
	1uUTOLUZeAa7q8Qhp0F7FcGsg2HTbjMOaSRkKCFHjn8G3UQ9Mmpr619OtrEWQ2smWEXeeVV5ptY
	=
X-Google-Smtp-Source: AGHT+IE0UPJ9V4M5PWxBo4d6N0urFcF7h9PdA9lYFnm98FKX4exl1YbHPYlrUGIU94w3/6yhYOVRTg==
X-Received: by 2002:a05:620a:4607:b0:792:95cf:99fc with SMTP id af79cd13be357-792c75f44a8mr3838576785a.62.1716219518672;
        Mon, 20 May 2024 08:38:38 -0700 (PDT)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com. [209.85.160.169])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf2fca82sm1191793985a.89.2024.05.20.08.38.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 May 2024 08:38:37 -0700 (PDT)
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-43dfe020675so647991cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 08:38:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWCJXPo3v9H9xAHRAFHQZ4ZEbbiwZtg/4jQEg9s2OluR5Hoa6l7ZFBTOdnBkAwVrYUY/kOzK3Tkqj06NK+0sfKEDTIer/AklxQoqLef
X-Received: by 2002:a05:622a:5917:b0:43e:ec2:4bb8 with SMTP id
 d75a77b69052e-43f797e0ecemr5611191cf.26.1716219516885; Mon, 20 May 2024
 08:38:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507144821.12275-1-johan+linaro@kernel.org>
 <20240507144821.12275-5-johan+linaro@kernel.org> <CAD=FV=V59t_tZ9Xk=uhbgOdTRYLKu+kZt8cpaksTkJo+D4yt8Q@mail.gmail.com>
 <Zks3hp5iUhTe3rLH@hovoldconsulting.com> <Zks5gJ7H6ZuWr_Xm@hovoldconsulting.com>
In-Reply-To: <Zks5gJ7H6ZuWr_Xm@hovoldconsulting.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 20 May 2024 08:38:20 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UDdc_YgZ=JGamWpdyCgAM_0szk-m_RgUnkDA9m1zbzWw@mail.gmail.com>
Message-ID: <CAD=FV=UDdc_YgZ=JGamWpdyCgAM_0szk-m_RgUnkDA9m1zbzWw@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] HID: i2c-hid: elan: fix reset suspend current leakage
To: Johan Hovold <johan@kernel.org>
Cc: Johan Hovold <johan+linaro@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <benjamin.tissoires@redhat.com>, Bjorn Andersson <andersson@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Steev Klimaszewski <steev@kali.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, May 20, 2024 at 4:52=E2=80=AFAM Johan Hovold <johan@kernel.org> wro=
te:
>
> On Mon, May 20, 2024 at 01:44:06PM +0200, Johan Hovold wrote:
> > On Fri, May 10, 2024 at 04:36:08PM -0700, Doug Anderson wrote:
> > > On Tue, May 7, 2024 at 7:48=E2=80=AFAM Johan Hovold <johan+linaro@ker=
nel.org> wrote:
>
> > > > @@ -67,7 +77,14 @@ static void elan_i2c_hid_power_down(struct i2chi=
d_ops *ops)
> > > >         struct i2c_hid_of_elan *ihid_elan =3D
> > > >                 container_of(ops, struct i2c_hid_of_elan, ops);
> > > >
> > > > -       gpiod_set_value_cansleep(ihid_elan->reset_gpio, 1);
> > > > +       /*
> > > > +        * Do not assert reset when the hardware allows for it to r=
emain
> > > > +        * deasserted regardless of the state of the (shared) power=
 supply to
> > > > +        * avoid wasting power when the supply is left on.
> > > > +        */
> > > > +       if (!ihid_elan->no_reset_on_power_off)
> > > > +               gpiod_set_value_cansleep(ihid_elan->reset_gpio, 1);
> > > > +
> > > >         if (ihid_elan->chip_data->post_gpio_reset_off_delay_ms)
> > > >                 msleep(ihid_elan->chip_data->post_gpio_reset_off_de=
lay_ms);
> > >
> > > Shouldn't  the above two lines be inside the "if
> > > (!ihid_elan->no_reset_on_power_off)" test? If you're not setting the
> > > reset GPIO then you don't need to do the delay, right?
> >
> > Yes, I guess you're right. The off-delay is weird and not normally used=
,
> > but apparently it is needed by some panel-follower use case. AFAICT it'=
s
> > not even related to the reset line, just a hack to add a delay before
> > the panel is reset by some other driver (see f2f43bf15d7a ("HID:
> > i2c-hid: elan: Add ili9882t timing")).
> >
> > I think that's why I just looked the other way and left this little
> > oddity here unchanged.
>
> Hit send too soon.
>
> Since this hack does not appear to be related to the reset line, I think
> it's correct to not have it depend on whether the reset line is asserted
> or not (e.g. as there could be 'panel-followers' with
> 'no_reset_on_power_off'):
>
>          The datasheet specifies there should be 60ms between touch SDA
>          sleep and panel RESX. Doug's series[1] allows panels and
>          touchscreens to power on/off together, so we can add the 65 ms
>          delay in i2c_hid_core_suspend before panel_unprepare.
>
> The power-off delay variable should probably be renamed, but that's a
> separate change.
>
> So I think v2 of this series is good to go.

Sure. As I think we've seen in the past, my choice of bikeshed paint
color seems to be quite different than yours, but nothing here seems
like it needs to block landing, so:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

