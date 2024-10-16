Return-Path: <linux-kernel+bounces-367696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E6D9A057F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 11:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 058C8284080
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 09:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A8D204F93;
	Wed, 16 Oct 2024 09:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HnhzG/Ce"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C999D205E00
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 09:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729070900; cv=none; b=beewZkMCwo/zyv8HxX4gqYaENYxua3X8R7aHBQkkc+SOCQk1vYw65+CFrdKvA7+ALjMpcNwARIiUkGtawT1ZqSCdmY3MyOoIiYyEffThKo2d7Q3F5gYUEbZ6a5ewOXJCKmZlpbT/arLuyXQcYhBITIa8EZunI+jz/Frh1TUwE+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729070900; c=relaxed/simple;
	bh=udOf30ZlWky3uzp/m7PSgXQuHwti7csL/gsXUNukPSA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Go7Ce0m/PZFATLLucG7BlL2LRo6lTwf2Fw1mlibOF+++o5amp6aQCUgj0mjDbm0GzZMyEYQiJx5uDixsISSXV3NAVUdHdDopt/bS0M9aUpNtnuBjcQ4ezeoG53VGyMKCo2IJKAFdlQYVy1lqpwuOhKWZdhNCc36Et5uyA9WnVck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HnhzG/Ce; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539e690479cso4294732e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 02:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729070897; x=1729675697; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OlvkqeHB10TeR7p0qpAqomrEbyrl0g2iGDmWLXtmqe8=;
        b=HnhzG/CegpiN93X0l8TGdSJk0KARYSY5olJJy7gYXVdUDefGjD7/B1z+Cwi8oHX1lT
         Ju62Sd+yXxy/L8RrM3ZFLKjsqNDwPVf90Cp23hhc+wp9XNodUN3ECttzdlNKCmn70MSk
         r4/qlLmi/SanCmtfug3qu5p1FlK0xi9YE5pLA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729070897; x=1729675697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OlvkqeHB10TeR7p0qpAqomrEbyrl0g2iGDmWLXtmqe8=;
        b=m/5wYXtX26VknqJe66uqO7g2VuXDfX6cyEg7H1/q2mk+7Z2m3EDE4JAKOUoFBXslfB
         wS42n6OZyZ+tX3tVjLNQhsH5VQUNM/qFrIU27OQFg0aFvm+PpLmQA3j+aQdUjW//y4hW
         dM7EOoVCR7k5iQBHdofyjAJCKwbh8p/QzDq0S5ksgApGYsmfqugK3PxExTnNXgRY7+B7
         oiCCN4/jtMkgk5FmQcjoDHC8omQ9JuQFX1x7Or2QfIYRgUsq3Odou2L/6knke01qZLPB
         1c9yH27fMrgdhIOvtVoNSsFwXD8ViTwy6PDoVlzlykoBKQpPH80wGKwbnUSauU5AXKS4
         N/ng==
X-Forwarded-Encrypted: i=1; AJvYcCXm565e2opbd8n+KVMJ2MDRjYt0R8kWDiLG5e9TyS5BRN/sweC7K9CV97EcnZ995coRWbgYt0VX4bWvi/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtauHNSKSDCzpyas9pU/1MFc3vW1WMuhEdHCXf/5qkuZkJU4JJ
	9tEbC5bjSnlGq6sRG7N4zC20Gj/DFy1xSbgzs6QgmmSivMuG+H44N028VTdodiVID1dNcmPuGJk
	zWrV/nOdD1EqEWRF9zAwKJVrlltwOHyRegzRu
X-Google-Smtp-Source: AGHT+IEaS5qJnG1F/Na+fPMzIxej3L36Oa+G1Du15MTwKWHu6l9SdRlVC+wBVlX0gEHyVjj7AKsa/2ZIQjZ3p9uU05A=
X-Received: by 2002:a05:6512:b11:b0:530:e323:b1d0 with SMTP id
 2adb3069b0e04-539e54d77bdmr6806437e87.9.1729070896644; Wed, 16 Oct 2024
 02:28:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008073430.3992087-1-wenst@chromium.org> <20241008073430.3992087-5-wenst@chromium.org>
 <CAD=FV=WRSjk3U9Kau0wqkgv3KB=9jM6wCM9Gs-WxWai35sfxTg@mail.gmail.com> <CAGXv+5FW0UTjR_ZiqZ8VEOQkBemt54omtJe_aTj3jvScC-LuMw@mail.gmail.com>
In-Reply-To: <CAGXv+5FW0UTjR_ZiqZ8VEOQkBemt54omtJe_aTj3jvScC-LuMw@mail.gmail.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Wed, 16 Oct 2024 17:28:05 +0800
Message-ID: <CAGXv+5GHDt3_Td8B441xv=-G1=LBfSXp8_sQ4XRRPX1f4VyTMQ@mail.gmail.com>
Subject: Re: [PATCH v8 4/8] i2c: Introduce OF component probe function
To: Doug Anderson <dianders@chromium.org>, Rob Herring <robh@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Saravana Kannan <saravanak@google.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Wolfram Sang <wsa@kernel.org>, 
	Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	chrome-platform@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>, 
	Jiri Kosina <jikos@kernel.org>, linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 3:01=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.org> w=
rote:
>
> On Wed, Oct 16, 2024 at 1:58=E2=80=AFAM Doug Anderson <dianders@chromium.=
org> wrote:
> >
> > Hi,
> >
> > On Tue, Oct 8, 2024 at 12:35=E2=80=AFAM Chen-Yu Tsai <wenst@chromium.or=
g> wrote:
> > >
> > > +int i2c_of_probe_component(struct device *dev, const struct i2c_of_p=
robe_cfg *cfg, void *ctx)
> > > +{
> > > +       const struct i2c_of_probe_ops *ops;
> > > +       const char *type;
> > > +       struct i2c_adapter *i2c;
> > > +       int ret;
> > > +
> > > +       ops =3D cfg->ops ?: &i2c_of_probe_dummy_ops;
> > > +       type =3D cfg->type;
> > > +
> > > +       struct device_node *i2c_node __free(device_node) =3D i2c_of_p=
robe_get_i2c_node(dev, type);
> > > +       if (IS_ERR(i2c_node))
> > > +               return PTR_ERR(i2c_node);
> >
> > I'm still getting comfortable with the __free() syntax so sorry if I'm
> > wrong, but I _think_ the above is buggy. I believe that the definition
> > of the free function for "device_node" is from:
> >
> > DEFINE_FREE(device_node, struct device_node *, if (_T) of_node_put(_T))
> >
> > ...which means it'll call of_node_put() to free "i2c_node" when it
> > goes out of scope. of_node_put() handles NULL pointers but _not_ ERR
> > pointers. So I think that if you get an error back and then return via
> > the PTR_ERR(i2c_node) then it'll crash because it will try to free an
> > ERR pointer. Did I get that right? Presumably you need to instead do:
> >
> >   return PTR_ERR(no_free_ptr(i2c_node));
> >
> > ...or change of_node_put() to be a noop for error pointers?
>
> Good catch! As Andy suggested, it should be updated to handle both.
> I'll add a patch for this.

On second thought, it might be better to change i2c_of_probe_get_i2c_node()
to return NULL on errors. That seems to be what most functions do. I only
found a handful of exceptions.

Rob, any thoughts from your end?


ChenYu

