Return-Path: <linux-kernel+bounces-329004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2334F978BF1
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 01:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8D74284358
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 23:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD2319B3C3;
	Fri, 13 Sep 2024 23:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VncChesb"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA94195805
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 23:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726271019; cv=none; b=J9RR2+txfPiQaivSW8Zjqa2XmX8YVxAZSf8RowNUGD1POhbfmIKffEoY8hm6jpQnriU4KPnH+iD+scGVFcJBm7RR7+IG4ePI0dyKulfIBdLM7Wb0DgFK3ZBqsrZ4Hg50imtt34EX+SjN8VLdUnsrjFUcGeKSW0JoFJjq6qCWPdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726271019; c=relaxed/simple;
	bh=HPCIWNWpBdtqLYZEm2Q7Mjcha/BIoksmpFmSMnXlxFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TujGwoFcmKbYh63ce4HqutnXXFgc95QZse03wepDhwYnk8WwrEKqZmMaQj3bdjZ2C7R4nRQwlvwH2EXNoNuZHhEN9Wba3tWSrRxVuC025i7MITHJpj2LlCUYjOeFl78DqDy6SNP83tBQaoFwoffnl03gvXXLgRWG5plt+5YPJCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VncChesb; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6c34c02ff1cso16592256d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 16:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726271015; x=1726875815; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QgrnQAkPxnP9xr/uHfnesOWhy4bQylWu/nCRFkQoiTg=;
        b=VncChesb/YV4HDu//VZkXMJB7/REK7gmE1rZvc0DoO7Vtno74woYKfRfADMDsmVu6w
         mNbU6YzfbrlViW9uDADNtfJlul4vs2ybn0ygrpuA8utPXiUPn9zaemzl/b6bHO8V1Zer
         PNhLy8S2AF1B1T89Uq/BVTbl3iJ9i5jHp1rvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726271015; x=1726875815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QgrnQAkPxnP9xr/uHfnesOWhy4bQylWu/nCRFkQoiTg=;
        b=fTw4gHVB6+5eyv7P/7nJTqnvktjLRKMqSPaH15iHDs05tMfG0lAnufH0nHancOfgIr
         FSzHoDYInaOdVIjKQ49YShuUj04u5t9jPmfowpBtAvOoo6Up8o4iCg2jNozp2AG5aO+L
         ctl/DZDUKX0ZziCFlMZZLft2n3FcsXN38NlDGsbE2K0mk2waNg+jcffPdDvwFZnrRrtm
         gy+kcqYYi1GVlvsbjXBzTyYME9oCbRdc6sIFi6xxnDb40aQc9epjKDpm1ail2uuUAo/n
         eA5FzUCrPoQRDn1B3qNmC6vBgGxK/QmuCMKZ8ZvzhSUitHJnJuMe4hP7KTk00w52Tky1
         nv/g==
X-Forwarded-Encrypted: i=1; AJvYcCUmgs/aVcbe1gG1ZlQwHdRmA3+rhZJSZlkpXb2y0RcLhIunht0KauQAz9JLukjYXHqQfsDile3dAjtHS/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT2RGDZWj2h5+Z5S2UIwT2K+idfu8LTR6ZWPl9vKTBeyyKS6Xh
	QGm6AGtb/dQQvSoaWKfbwfZ5GLY9JVAd8IHfpVIveVLOy/LobgHuoer7BtUvKg1hNPAg3LloLxk
	=
X-Google-Smtp-Source: AGHT+IHnTBDL8p2gnzJFEGe2ttrwQblzJ0q1PcIjtVeXBuyOCa3b/2Gm76eK6uUGCcsBiXpkosNuKQ==
X-Received: by 2002:a05:6214:3988:b0:6c5:39dc:52bb with SMTP id 6a1803df08f44-6c573543962mr115976576d6.8.1726271015108;
        Fri, 13 Sep 2024 16:43:35 -0700 (PDT)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com. [209.85.219.53])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c58c62627dsm1379396d6.9.2024.09.13.16.43.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2024 16:43:32 -0700 (PDT)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6c352bcb569so14293206d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 16:43:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUpW5wJ8cDodW3kNfsK+2qeu1QCsgaha7uVFQeabap8NZHztSYltYlAfzWoMuTrPe1J2NaFijSOJqWHU7E=@vger.kernel.org
X-Received: by 2002:a05:6214:5f07:b0:6c5:de4:3edb with SMTP id
 6a1803df08f44-6c5735881a8mr122878276d6.29.1726271012120; Fri, 13 Sep 2024
 16:43:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911072751.365361-1-wenst@chromium.org> <20240911072751.365361-10-wenst@chromium.org>
In-Reply-To: <20240911072751.365361-10-wenst@chromium.org>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 13 Sep 2024 16:43:20 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WtVSQ5GX6H5CtxNPTdOAJVMj_xNRvG9siZB6_ePZr7CQ@mail.gmail.com>
Message-ID: <CAD=FV=WtVSQ5GX6H5CtxNPTdOAJVMj_xNRvG9siZB6_ePZr7CQ@mail.gmail.com>
Subject: Re: [PATCH v7 09/10] platform/chrome: Introduce device tree hardware prober
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Wolfram Sang <wsa@kernel.org>, 
	Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	chrome-platform@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>, 
	Jiri Kosina <jikos@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 11, 2024 at 12:29=E2=80=AFAM Chen-Yu Tsai <wenst@chromium.org> =
wrote:
>
> @@ -8,6 +8,7 @@ obj-$(CONFIG_CHROMEOS_ACPI)             +=3D chromeos_acp=
i.o
>  obj-$(CONFIG_CHROMEOS_LAPTOP)          +=3D chromeos_laptop.o
>  obj-$(CONFIG_CHROMEOS_PRIVACY_SCREEN)  +=3D chromeos_privacy_screen.o
>  obj-$(CONFIG_CHROMEOS_PSTORE)          +=3D chromeos_pstore.o
> +obj-$(CONFIG_CHROMEOS_OF_HW_PROBER)    +=3D chromeos_of_hw_prober.o

"o" sorts before "p" so "of" should sort before "privacy"?

I guess it's not exactly all sorted, but this small section is. Since
it's arbitrary you could preserve the existing sorting. :-P


> +static const struct hw_prober_entry hw_prober_platforms[] =3D {
> +       { .compatible =3D "google,hana", .prober =3D chromeos_i2c_compone=
nt_prober, .data =3D &chromeos_i2c_probe_dumb_touchscreen },
> +       { .compatible =3D "google,hana", .prober =3D chromeos_i2c_compone=
nt_prober, .data =3D &chromeos_i2c_probe_dumb_trackpad },

The fact that the example is only using "dumb" probers doesn't make it
quite as a compelling proof that the code will scale up. Any chance
you could add something that requires a bit more oomph? ;-)


> +static int chromeos_of_hw_prober_driver_init(void)
> +{
> +       size_t i;
> +       int ret;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(hw_prober_platforms); i++)
> +               if (of_machine_is_compatible(hw_prober_platforms[i].compa=
tible))
> +                       break;
> +       if (i =3D=3D ARRAY_SIZE(hw_prober_platforms))
> +               return -ENODEV;
> +
> +       ret =3D platform_driver_register(&chromeos_of_hw_prober_driver);
> +       if (ret)
> +               return ret;
> +
> +       chromeos_of_hw_prober_pdev =3D
> +                       platform_device_register_simple(DRV_NAME, PLATFOR=
M_DEVID_NONE, NULL, 0);
> +       if (IS_ERR(chromeos_of_hw_prober_pdev))
> +               goto err;

FWIW if you didn't want to see your prober called over and over again
if one of the devices deferred you could just register one device per
type, right? Then each device would be able to defer separately. Dunno
if it's worth it but figured I'd mention it...


Also: as a high level comment, this all looks much nicer to me now
that it's parameterized. :-)

