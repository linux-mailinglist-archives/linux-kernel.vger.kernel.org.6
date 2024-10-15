Return-Path: <linux-kernel+bounces-365758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E329899E992
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 14:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73BC11F23AC8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 12:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34861EF0AC;
	Tue, 15 Oct 2024 12:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ajhtBLHX"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F7E1EC018
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 12:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728994746; cv=none; b=XG4kIoFQS6nbXsnzGxeWXs5dtvMQ8jIQyhUecEi/9pwzERL+O1jmSu+GMZ4CgnMxAp13wgTRZ1AIqs4fmx6Nr/EzDfYFaM66Pz8yq9RFOLfmEjI6DQhpCsUgdlm/9znsXDukQ+oLV5Akvdd/kXMKyIsrRTPuQhd00NhK/PcJdG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728994746; c=relaxed/simple;
	bh=aRCf8E0XYeMl3rjjwU9ql3OSCuCKiWZsGaedbuIwvyM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t99gX7F4lv5xlz23G+OT/8hCqkkiaGGQW4HTNrklVTDBNmnSo4AXcYXyBldg4YjQcU3Nk9ClziZUX+Ybd512wD9kF6LYySYZ6h+naTeVk4rQhw9Hg1Zu4GCCuHyppp9COZyvcIgh9haxPY7BqfCJ+XMPrtwutQiB65e1/nJQyN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ajhtBLHX; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539f8490856so2160673e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 05:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728994742; x=1729599542; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E2Nzr/f3LnLUD1j4bkCrqVzP0/G5tRk6VST+iGhoZ4s=;
        b=ajhtBLHX5LC7n3SGalyBes5NTrchDZgudIJG+r0P2M+G9Fw1SIVxfA6Gm9PYtSlAvw
         LYLtO66ec+e1RLLAo5xDkeKA+Di9qepNVjqHHQL6EskKd2M5de+f6QCWsQPli5BB9/2n
         SnqPPjPzAIscgfSfjfc0NLA/bY58oxxq3D+3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728994742; x=1729599542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E2Nzr/f3LnLUD1j4bkCrqVzP0/G5tRk6VST+iGhoZ4s=;
        b=DHgCxN2zvE/54sQ3L7CSD0LAk6AN1LRJn23TuKiGEfv/hHlq+LQVOR8KWq6uo8PP61
         b5ligRomkNAhHixqorqDDa7mbK9bNmmd0lhWogs/6qd2+cLCST/bjuZMfCZg2doMzMzR
         HNfOr8ggP3lro+pD7XVJPiO9hO3vUXfj8MFMiCPUezpwVecVCyxLc3al7Y9uS7wDTBnt
         bav+G3ZnfGBcSOWRVJMCHCMs31hIvp8+ymgC0eU0YZYqMMRK3C8AxSyynVjaxOS8SOzE
         00ya+zU86tymAPnBU7NWC2ZPFad4iC1KDNTNDICNntMPNiA9oih2YPMTlNRrC1d2XHgr
         4OXA==
X-Forwarded-Encrypted: i=1; AJvYcCVFATDG48MoyHDbIUZCM6s3nB+Uef2oYhE+fKGJ1uVChHYHs+hUsi12MzG5b+fHSKc5ZTY6Vch+AKVYeoo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw55KFqOu2MfF4ntFTWMtmYpx5jcQXSlnBLqZWkJCcJD7es4Jim
	QKPM7v+iZWGOgzLxWmF0TvQ/0MH4m9SJOpHPrDOEvNIIKNMbeJFDsfs1WWrl8LT/uexQdGOchkd
	o+F0b39brEzG4LzwkoVKYgqKuFewNOwDNxJxr
X-Google-Smtp-Source: AGHT+IHhelc1sPDiNO+kxEEhE8ky8z+lqqPZB1C0Uie/J5s8p86hdxcscCA4LhHzO10mmd95cq8TFxe0+nBzft1TCjY=
X-Received: by 2002:a05:6512:687:b0:52c:a5cb:69e4 with SMTP id
 2adb3069b0e04-539da599f59mr5899850e87.54.1728994742015; Tue, 15 Oct 2024
 05:19:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008073430.3992087-1-wenst@chromium.org> <20241008073430.3992087-8-wenst@chromium.org>
 <Zwfy6ER6sbr_QxsY@smile.fi.intel.com> <ZwfzhsvlPrxMi61j@smile.fi.intel.com>
 <CAGXv+5ED7j49ndT7BaESW8ZL7_mjVUJLM_FWma8Lwkg+Uh3saw@mail.gmail.com>
 <Zwz_Kl7SwfL0ZaAZ@smile.fi.intel.com> <CAGXv+5H0Yvt1cwPOim-quT3C+=s9NapnryJhNxs_QW=DAyAycQ@mail.gmail.com>
 <Zw5QzP-5hnHW--F-@smile.fi.intel.com>
In-Reply-To: <Zw5QzP-5hnHW--F-@smile.fi.intel.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 15 Oct 2024 20:18:50 +0800
Message-ID: <CAGXv+5FuMjSaUJ+qDrx7Vmr9o5vJ9VW=tss1ezvdJyaZZouHKw@mail.gmail.com>
Subject: Re: [PATCH v8 7/8] platform/chrome: Introduce device tree hardware prober
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Wolfram Sang <wsa@kernel.org>, 
	Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	chrome-platform@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Douglas Anderson <dianders@chromium.org>, 
	Johan Hovold <johan@kernel.org>, Jiri Kosina <jikos@kernel.org>, linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 7:24=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Oct 15, 2024 at 02:32:54PM +0800, Chen-Yu Tsai wrote:
> > On Mon, Oct 14, 2024 at 7:23=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Mon, Oct 14, 2024 at 12:56:20PM +0800, Chen-Yu Tsai wrote:
> > > > On Thu, Oct 10, 2024 at 11:32=E2=80=AFPM Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > On Thu, Oct 10, 2024 at 06:29:44PM +0300, Andy Shevchenko wrote:
> > > > > > On Tue, Oct 08, 2024 at 03:34:26PM +0800, Chen-Yu Tsai wrote:
>
> ...
>
> > > > > > > +   .cfg =3D &chromeos_i2c_probe_simple_trackpad_cfg,
> > > > > >
> > > > > >       .cfg =3D DEFINE_I2C_OF_PROBE_CFG(trackpad, i2c_of_probe_s=
imple_ops),
> > > > > >
> > > > > > Or even
> > > > > >
> > > > > > #define DEFINE_I2C_OF_PROBE_CFG_SIMPLE(_type_)                 =
       \
> > > > > >       DEFINE_I2C_OF_PROBE_CFG(type, &i2c_of_probe_simple_ops)
> > > >
> > > > I'm not inclined on using compound literals here. "simple X cfg" wi=
ll
> > > > likely get shared between multiple |chromeos_i2c_probe_data| entrie=
s,
> > > > and AFAIK the toolchain can't merge them. So we would end up with o=
ne
> > > > compound literal per entry, even if their contents are the same.
> > >
> > > I'm not sure I follow, you are using compound literal _already_.
> > > How does my proposal change that?
> >
> > I'm using it where it makes sense, i.e. where the embedded variable
> > is not going to be shared with other instances.
> >
> > For the dumb probers, there's only going to be one instance per "type".
> >
> > For the simple probers, the config part is still one instance per "type=
",
> > but the parameters are board and component specific. There will be
> > multiple instances. Hence the config part can be shared, while the
> > parameters likely won't be.
> >
> > > > > With that also looking at the above
> > > > >
> > > > > #define DEFINE_I2C_OF_PROBE_CFG_NONE(_type_)                     =
       \
> > > > >         DEFINE_I2C_OF_PROBE_CFG(type, NULL)
> > > >
> > > > For the "dumb" case it makes sense though, since it would be one in=
stance
> > > > per type. But we could go further and just wrap the whole
> > > > |chromeos_i2c_probe_data| declaration.
> > >
> > > Maybe it's too far from now...
> >
> > This is what I have:
> >
> > #define DEFINE_CHROMEOS_I2C_PROBE_DATA_DUMB(_type)
> >                         \
> >        static const struct chromeos_i2c_probe_data
> > chromeos_i2c_probe_dumb_ ## _type =3D {       \
>
> >                .cfg =3D &(const struct i2c_of_probe_cfg) {
>
> But the below is static initializer, why do you need a compound literal h=
ere?

Because .cfg takes a pointer to a struct. It's not an embedded struct.
The compound literal creates the internal struct, and then its address
is taken and assigned to the .cfg field.

Does that make sense?

> >                         \
> >                        .type =3D #_type,
> >                         \
> >                },
> >                         \
> > };
> >
> > DEFINE_CHROMEOS_I2C_PROBE_DATA_DUMB(touchscreen);
>
> s/dumb/simple/g

"simple" is taken. This is "dumb" as in it does not need any helpers.
Maybe "no-op" if you don't like the negative connotation?


ChenYu

