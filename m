Return-Path: <linux-kernel+bounces-271334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FFCA944CFD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 15:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C13AD284E5B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 13:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E16C1A4F27;
	Thu,  1 Aug 2024 13:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DzclRxhr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05441A2542
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 13:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722518150; cv=none; b=q6Te8GZ7BjP+UoVwjhSLMVNvz9gsl2+aUyu2eaA6G2EoAQubJk4Qs4oHjZvcV2WJFNAUj/dgGCSw3jDa/7QNMXdTVlZSrf6VXviiA0yL5Xm5eppwk9tUHyOKKvbybogwgC+eQaA9CtJk8ZHVSnO8/2GiuR7UY3JOBzbYIR1/I1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722518150; c=relaxed/simple;
	bh=/ynuOET3kqXPxIs7OTQjFHflicpksvorsX2OImbJQXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rg8XfySBDtulmsJxgL8d/fzI8XCvQ12JdCBB28QLNdfA+uBVXYW3cx55iCMK/QcMY4tKUZEUH9cBgRyQdlhzPmAUUwAs3zaxan1C2z+94IOCzH2Gb3xhvFuGSPJDKJCw94kJeGwbJrv/5J99dWSmliGEYlSn4ZSEdE3v0adtNwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DzclRxhr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1840EC32786;
	Thu,  1 Aug 2024 13:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722518150;
	bh=/ynuOET3kqXPxIs7OTQjFHflicpksvorsX2OImbJQXQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DzclRxhrP1lTsQq9QJqhnAOyyl1UR+j+M8xVPNUAwklNL+E/9AJ0EbloztWcn9oeg
	 DTn5fUH1AaD/aFKaGtFvGgyPWrsN+tsbOm3ORrQVLrtNm9fXebQmhklGL/lqKrlvvX
	 ZH+vE+8TBf591YEJ8xbjKY6EUfKgVKmGyqUrRlm4ctN5WyC1oZTF2ptyo4q0PkLtC0
	 5Wj8DCjn72GChw54Br/o+QcCSddlM/TKmrRIZThxH2n3dKU1OvZAxvzGR6lPve1Omr
	 ltZneqv8/FzN/kXYFFCSGS8UVEyvVt2uaUhSaeHo3IHT3+m85yM27PjSsOthW9wmGE
	 RGQjgHDUSPwtw==
Date: Thu, 1 Aug 2024 15:15:44 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>, "Michael
 S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>, Shannon Zhao
 <shannon.zhaosl@gmail.com>, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 1/7] arm/virt: place power button pin number on a
 define
Message-ID: <20240801151544.2f315598@foz.lan>
In-Reply-To: <20240730132620.46cca4ce@imammedo.users.ipa.redhat.com>
References: <cover.1721630625.git.mchehab+huawei@kernel.org>
	<bf8367bddfdc95e378b5725c732533c3ba20d388.1721630625.git.mchehab+huawei@kernel.org>
	<20240730092549.6898ff3c@imammedo.users.ipa.redhat.com>
	<CAFEAcA8VWc3eQZqfJP9k5LYF-9aLChHQ+uS9UBfGV6nvybDxqQ@mail.gmail.com>
	<20240730132620.46cca4ce@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Tue, 30 Jul 2024 13:26:20 +0200
Igor Mammedov <imammedo@redhat.com> escreveu:

> On Tue, 30 Jul 2024 09:29:37 +0100
> Peter Maydell <peter.maydell@linaro.org> wrote:
> 
> > On Tue, 30 Jul 2024 at 08:26, Igor Mammedov <imammedo@redhat.com> wrote:  
> > >
> > > On Mon, 22 Jul 2024 08:45:53 +0200
> > > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> > >    
> > > > Having magic numbers inside the code is not a good idea, as it
> > > > is error-prone. So, instead, create a macro with the number
> > > > definition.
> > > >
> > > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>    
> >   
> > > > diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> > > > index b0c68d66a345..c99c8b1713c6 100644
> > > > --- a/hw/arm/virt.c
> > > > +++ b/hw/arm/virt.c
> > > > @@ -1004,7 +1004,7 @@ static void virt_powerdown_req(Notifier *n, void *opaque)
> > > >      if (s->acpi_dev) {
> > > >          acpi_send_event(s->acpi_dev, ACPI_POWER_DOWN_STATUS);
> > > >      } else {
> > > > -        /* use gpio Pin 3 for power button event */
> > > > +        /* use gpio Pin for power button event */
> > > >          qemu_set_irq(qdev_get_gpio_in(gpio_key_dev, 0), 1);    
> > >
> > > /me confused, it was saying Pin 3 but is passing 0 as argument where as elsewhere
> > > you are passing 3. Is this a bug?    
> > 
> > No. The gpio_key_dev is a gpio-key device which has one
> > input (which you assert to "press the key") and one output,
> > which goes high when the key is pressed and then falls
> > 100ms later. The virt board wires up the output of the
> > gpio-key device to input 3 on the PL061 GPIO controller.
> > (This happens in create_gpio_keys().) So the code is correct
> > to assert input 0 on the gpio-key device and the comment
> > isn't wrong that this results in GPIO pin 3 being asserted:
> > the link is just indirect.  
> 
> it's likely obvious to ARM folks, but maybe comment should
> clarify above for unaware.

Not sure if a comment here with the pin number is a good idea.
After all, this patch was originated because we were using
Pin 6 for GPIO error, while the comment was outdated (stating
that it was pin 8 instead) :-)

After this series, there will be two GPIO pins used inside arm/virt,
both defined at arm/virt.h:

	/* GPIO pins */
	#define GPIO_PIN_POWER_BUTTON  3
	#define GPIO_PIN_GENERIC_ERROR 6

Those macros are used when GPIOs are created:

	static void create_gpio_keys(char *fdt, DeviceState *pl061_dev,
	                             uint32_t phandle)
	{
	    gpio_key_dev = sysbus_create_simple("gpio-key", -1,
	                                        qdev_get_gpio_in(pl061_dev,
                                                         GPIO_PIN_POWER_BUTTON));
	    gpio_error_dev = sysbus_create_simple("gpio-key", -1,
	                                          qdev_get_gpio_in(pl061_dev,
	                                                           GPIO_PIN_GENERIC_ERROR));
So, at least for me, it is clear that gpio_key_dev is using pin 3.

Thanks,
Mauro

