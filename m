Return-Path: <linux-kernel+bounces-274769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0561F947C72
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 16:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A19D1F21747
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 14:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0A37710C;
	Mon,  5 Aug 2024 14:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DU07lIZr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56A117C64
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 14:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722866691; cv=none; b=dbR4CQNWlhqn+xO6YNH6z+tU4nhS52+wtnKurxIOPgjPz9nKyQ9JEWrbPFwELKYNc+Qqxt3tMt5lkEmnY6HUg7NyIBFzPfZbWX2khKNWzGdpjtanR3qU8NeTpf2QTtMRyMtCcxLfANIM0/6bBI/NXiW3dfSKF7BJ9Ymg2pyytL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722866691; c=relaxed/simple;
	bh=tQf3ZqrOfXNjtoysOKnt8hMz1BI520/ZU+KVrWZx4Mc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iFfyfScbvwKDj0ty6X93BraEU3D8cAZO4IXv6fiOSM4LFR17zN1XZMuPm2sdCw2IMM3d7BdqPIPo6IkG8L3mJQqh/DXck2QEsox19jnmHL3lklrrGGU/zZ+RY782eqQuC5nSBUBxwpa+34yNe1sP0xlIWlcJ8sFH1MaHjPv+wdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DU07lIZr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722866687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R+AVzWWReouMoN7zruePSuW9jT4ReN30A6YfedCpgFI=;
	b=DU07lIZrxgj07jiAJ2oOwK3dj1AuNQR66AtyfpVXAKZc2yCta0TE3FkUdMIjbNUHzNT6RM
	73nc4eFD4ySNveoztccgJqpjZtSutNhJKU00vOrfta6rgrFfXmoolhGmkbempdCXCBid4/
	zTANVohbPhJoLm4sJURqnSGdz6lIV24=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-t68oSQXMP9yC28beHzzCSg-1; Mon, 05 Aug 2024 10:04:45 -0400
X-MC-Unique: t68oSQXMP9yC28beHzzCSg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-367990b4beeso5421119f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 07:04:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722866684; x=1723471484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R+AVzWWReouMoN7zruePSuW9jT4ReN30A6YfedCpgFI=;
        b=RRLPLHOiFZ3/BKyTFb7mSQvJNf3VAgos1JF+9YPISpYURcsKH0fPFioD7qP+eTDLkq
         YZ/CeCZKY4VbOjxitWZi5gmdvJ/Ikt/Qpqo8HxRWa2HygzTQoVHr6jwzY87bJ2RQzH4s
         30SK3es9swafiWPxI3gn51+akkqOwZAEzEo8BzEE3QRLi2NVfXZqZLZbQKPSPYBO9hjx
         9UHU0ndwwO9hmheq+GN2of4tXcA1k+9wfncqWZac9dRguGlszXcS8myrih/j+RxzfuiT
         7ILawbAwhAo3SwgFz2qzFHTbGvNhXL7GNTOL7nanNCECxPsQoIiDouPzo/TsvFCxJhNj
         xaEg==
X-Forwarded-Encrypted: i=1; AJvYcCXnZZacPy22iuwyvuloV1Osz/m+7a92/wi2WKqn9XcnbWvI2optPKH+5FAmrvXMr/VQ8shzdh/86+AyB8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO2be2GOfGhI2KmJ89aOodTv9j/orhBoGoxCaG1Cqswb2y7wNF
	qPa4a6koB+9UkhOTTC+uwGG1tI5VKpHCrWGLolmm7m4VCBF5chwre4DO7aTqcxts9KaVFH50KPl
	JhAcSDfYB4aR7L+fe0uNYKD3ZotGT+88HOrGuK1/9xDcbngrOnbH6RVyrqjqm5A==
X-Received: by 2002:adf:e84b:0:b0:368:48b1:803 with SMTP id ffacd0b85a97d-36bbc0a7516mr7666474f8f.12.1722866683804;
        Mon, 05 Aug 2024 07:04:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqMOWFKU9XiHMC7qZcwwpmZWNzT4B2DcK1et3m5b0MIWcN/Gs6j/xwsCEBWBB3P7GaUOmicw==
X-Received: by 2002:adf:e84b:0:b0:368:48b1:803 with SMTP id ffacd0b85a97d-36bbc0a7516mr7666448f8f.12.1722866683267;
        Mon, 05 Aug 2024 07:04:43 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbd01b5c4sm9894503f8f.42.2024.08.05.07.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 07:04:42 -0700 (PDT)
Date: Mon, 5 Aug 2024 16:04:39 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>, "Michael
 S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>, Shannon Zhao
 <shannon.zhaosl@gmail.com>, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 1/7] arm/virt: place power button pin number on a
 define
Message-ID: <20240805160439.0bafb58d@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240801151544.2f315598@foz.lan>
References: <cover.1721630625.git.mchehab+huawei@kernel.org>
	<bf8367bddfdc95e378b5725c732533c3ba20d388.1721630625.git.mchehab+huawei@kernel.org>
	<20240730092549.6898ff3c@imammedo.users.ipa.redhat.com>
	<CAFEAcA8VWc3eQZqfJP9k5LYF-9aLChHQ+uS9UBfGV6nvybDxqQ@mail.gmail.com>
	<20240730132620.46cca4ce@imammedo.users.ipa.redhat.com>
	<20240801151544.2f315598@foz.lan>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 1 Aug 2024 15:15:44 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Em Tue, 30 Jul 2024 13:26:20 +0200
> Igor Mammedov <imammedo@redhat.com> escreveu:
> 
> > On Tue, 30 Jul 2024 09:29:37 +0100
> > Peter Maydell <peter.maydell@linaro.org> wrote:
> >   
> > > On Tue, 30 Jul 2024 at 08:26, Igor Mammedov <imammedo@redhat.com> wrote:    
> > > >
> > > > On Mon, 22 Jul 2024 08:45:53 +0200
> > > > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> > > >      
> > > > > Having magic numbers inside the code is not a good idea, as it
> > > > > is error-prone. So, instead, create a macro with the number
> > > > > definition.
> > > > >
> > > > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>      
> > >     
> > > > > diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> > > > > index b0c68d66a345..c99c8b1713c6 100644
> > > > > --- a/hw/arm/virt.c
> > > > > +++ b/hw/arm/virt.c
> > > > > @@ -1004,7 +1004,7 @@ static void virt_powerdown_req(Notifier *n, void *opaque)
> > > > >      if (s->acpi_dev) {
> > > > >          acpi_send_event(s->acpi_dev, ACPI_POWER_DOWN_STATUS);
> > > > >      } else {
> > > > > -        /* use gpio Pin 3 for power button event */
> > > > > +        /* use gpio Pin for power button event */
> > > > >          qemu_set_irq(qdev_get_gpio_in(gpio_key_dev, 0), 1);      
> > > >
> > > > /me confused, it was saying Pin 3 but is passing 0 as argument where as elsewhere
> > > > you are passing 3. Is this a bug?      
> > > 
> > > No. The gpio_key_dev is a gpio-key device which has one
> > > input (which you assert to "press the key") and one output,
> > > which goes high when the key is pressed and then falls
> > > 100ms later. The virt board wires up the output of the
> > > gpio-key device to input 3 on the PL061 GPIO controller.
> > > (This happens in create_gpio_keys().) So the code is correct
> > > to assert input 0 on the gpio-key device and the comment
> > > isn't wrong that this results in GPIO pin 3 being asserted:
> > > the link is just indirect.    
> > 
> > it's likely obvious to ARM folks, but maybe comment should
> > clarify above for unaware.  
> 
> Not sure if a comment here with the pin number is a good idea.
> After all, this patch was originated because we were using
> Pin 6 for GPIO error, while the comment was outdated (stating
> that it was pin 8 instead) :-)
> 
> After this series, there will be two GPIO pins used inside arm/virt,
> both defined at arm/virt.h:
> 
> 	/* GPIO pins */
> 	#define GPIO_PIN_POWER_BUTTON  3
> 	#define GPIO_PIN_GENERIC_ERROR 6
> 
> Those macros are used when GPIOs are created:
> 
> 	static void create_gpio_keys(char *fdt, DeviceState *pl061_dev,
> 	                             uint32_t phandle)
> 	{
> 	    gpio_key_dev = sysbus_create_simple("gpio-key", -1,
> 	                                        qdev_get_gpio_in(pl061_dev,
>                                                          GPIO_PIN_POWER_BUTTON));
> 	    gpio_error_dev = sysbus_create_simple("gpio-key", -1,
> 	                                          qdev_get_gpio_in(pl061_dev,
> 	                                                           GPIO_PIN_GENERIC_ERROR));
> So, at least for me, it is clear that gpio_key_dev is using pin 3.

if you switch to using already existing GED device,
then this patch will go away since event will be delivered by GED
instead of GPIO + _AEI.

> 
> Thanks,
> Mauro
> 


