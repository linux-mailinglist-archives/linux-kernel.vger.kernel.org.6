Return-Path: <linux-kernel+bounces-366384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD9199F491
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 19:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6248F1C2207A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 17:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24D21FAF0C;
	Tue, 15 Oct 2024 17:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LQ19fuTw"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B797016EBE8
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 17:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729015134; cv=none; b=XYB6NtES+brNT1TdUhOzfM5TWu/DgurZwc+9j5teYyg+A43x+kZc6HwbDe4Gvrt6t6tOdOb2h3rjWXTkXvxMlsTD3urMy7t2EUBqjhaHqnV6rQx4dD470AdL9yS+UPoG8NSWlu7r1AYW6yy93JxwuVOGVkWq1DixVq0N1svNXEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729015134; c=relaxed/simple;
	bh=14O5MDyat6CX8O123WRU/kCYMtgocuRDZbVVnnkI2Yk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sg6QmkLvdoA1oGivtBirodZWxKfkgFqex6+AJJRgrcrE/Wyxu3ME1Z8YGDO73lc5jEDyKubK+Lm3p5edElhylX3EilEckeGj1l3yNrPFe2EZfabLoUqjGvNkLGyUzdShFhPN71oIu2WEsMYSBB8/Z6uFa/3EKh60ESL7Ci/vrc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LQ19fuTw; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539e6c754bdso2945938e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 10:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729015128; x=1729619928; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Yio/gvv50Y6PZv0Xv308n7irKGS6U7Q/Fl4Lj32yaA=;
        b=LQ19fuTw/08wVooh0hU7cfvMzD6rMk0HAaGXsaE7KEkUtVfo5r+RixKbPIluOL8TfG
         tpLH89BkyCw3Bpev/lTVa5VowtF3b1BI3qEyZc4h2ya1205zjhWX2ZNn22tNg7iPZSqG
         SEVmMdrV5LgCoTgyxCZcpzjLAfqboPLP/7Xbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729015128; x=1729619928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Yio/gvv50Y6PZv0Xv308n7irKGS6U7Q/Fl4Lj32yaA=;
        b=sD82PL8XYS/PXVOwg52a0g1GPsP+dP/aco9MVErVwGO3ZCRiBLfTOHWIpoy3hxhHyX
         UWBsRh9kKWfsc7pXawepjW3T3jJ8BQZHc4Kj/h7HQK/TvLNhgDVG668C4D2ajBglzYom
         SKUO1sCcbNBdDl3oPGB3cfbguqMHZqUBHwfafX5k1O7PnBD2Hd5M7ZPEC4f/XfG7HXsg
         E3B9Oj1srzF3BY2GKNTMdXtpAIEaulTWhl6yT0AYBXhKFa+nhT3K1Bi12qoLZwNRkDY7
         vNvM2/OO7iu97yM5uJqnRXxkAwxN6I/gPG+jOLV0iSZgYKoPRnHHoCO2P799hqeHfUji
         w3TA==
X-Forwarded-Encrypted: i=1; AJvYcCU3nCxeL1lF8yup2mL00d45Hgm0WBFmcLaNLZTRapeXPgJ8bmKihYoLdHnTQHLUrJB1RzE6sJLKfm7/Jcw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyFR6JIXO+RS7x66XoVaO0a69vfKeInuOyE+60P9sJhpp4jOmB
	GsTO2SAim4Tpaj2pSl4hr/5jddXoW+ypiXqujLCx6KJ2fZFF15YSxz/Licqe9zdjFKU31cOs4RE
	Chq88
X-Google-Smtp-Source: AGHT+IH0+rdMUKRc0PRmUYKo5ziByRPPO/v4SbJfA9Z07XCxcdBthFQUQHxh1rKuoli1SPgscv+fYA==
X-Received: by 2002:a05:6512:1044:b0:530:ae4a:58d0 with SMTP id 2adb3069b0e04-539da3c1d9bmr7375268e87.8.1729015127531;
        Tue, 15 Oct 2024 10:58:47 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a000142d5sm223218e87.293.2024.10.15.10.58.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 10:58:47 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53a007743e7so1188551e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 10:58:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWvsiyDbkkmjz57Dr9gnC/quf/o79C/wuSs5XT5l0Q/1c59HEH/jOUsnxksbBjsxL2CRho8Bf9PI3OcUZU=@vger.kernel.org
X-Received: by 2002:a05:6512:2c95:b0:539:e94d:2d3d with SMTP id
 2adb3069b0e04-539e94d2ea1mr5104630e87.7.1729015125333; Tue, 15 Oct 2024
 10:58:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008073430.3992087-1-wenst@chromium.org> <20241008073430.3992087-5-wenst@chromium.org>
In-Reply-To: <20241008073430.3992087-5-wenst@chromium.org>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 15 Oct 2024 10:58:31 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WRSjk3U9Kau0wqkgv3KB=9jM6wCM9Gs-WxWai35sfxTg@mail.gmail.com>
Message-ID: <CAD=FV=WRSjk3U9Kau0wqkgv3KB=9jM6wCM9Gs-WxWai35sfxTg@mail.gmail.com>
Subject: Re: [PATCH v8 4/8] i2c: Introduce OF component probe function
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Wolfram Sang <wsa@kernel.org>, 
	Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	chrome-platform@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>, 
	Jiri Kosina <jikos@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 8, 2024 at 12:35=E2=80=AFAM Chen-Yu Tsai <wenst@chromium.org> w=
rote:
>
> +int i2c_of_probe_component(struct device *dev, const struct i2c_of_probe=
_cfg *cfg, void *ctx)
> +{
> +       const struct i2c_of_probe_ops *ops;
> +       const char *type;
> +       struct i2c_adapter *i2c;
> +       int ret;
> +
> +       ops =3D cfg->ops ?: &i2c_of_probe_dummy_ops;
> +       type =3D cfg->type;
> +
> +       struct device_node *i2c_node __free(device_node) =3D i2c_of_probe=
_get_i2c_node(dev, type);
> +       if (IS_ERR(i2c_node))
> +               return PTR_ERR(i2c_node);

I'm still getting comfortable with the __free() syntax so sorry if I'm
wrong, but I _think_ the above is buggy. I believe that the definition
of the free function for "device_node" is from:

DEFINE_FREE(device_node, struct device_node *, if (_T) of_node_put(_T))

...which means it'll call of_node_put() to free "i2c_node" when it
goes out of scope. of_node_put() handles NULL pointers but _not_ ERR
pointers. So I think that if you get an error back and then return via
the PTR_ERR(i2c_node) then it'll crash because it will try to free an
ERR pointer. Did I get that right? Presumably you need to instead do:

  return PTR_ERR(no_free_ptr(i2c_node));

...or change of_node_put() to be a noop for error pointers?


> +struct i2c_of_probe_ops {
> +       /**
> +        * @enable: Retrieve and enable resources so that the components =
respond to probes.
> +        *
> +        * Resources should be reverted to their initial state before ret=
urning if this fails.

nit: might be worth explicitly noting that returning -EPROBE_DEFER is
OK here because this both retrieves resources and enables.


> +        */
> +       int (*enable)(struct device *dev, struct device_node *bus_node, v=
oid *data);
> +
> +       /**
> +        * @cleanup_early: Release exclusive resources prior to enabling =
component.

nit: change the word "enabling" to "calling probe() on a detected"
since otherwise it could be confused with the "enable" function above.


-Doug

