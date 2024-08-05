Return-Path: <linux-kernel+bounces-274894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAAC0947DFA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDB271C20CFC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA6B16CD3E;
	Mon,  5 Aug 2024 15:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J+EcWmFr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789C416CD0E
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 15:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722871340; cv=none; b=Eg9pYFllQRsv7333nPoEgPp27fLAFjXpp4Fa8AeO9hDXfKxyDN745XdP2zt9texToIWAfV9ypPYTWB/q3s1hoSavYvyTyU6xOcukmy0SFrok+WutbQQbt2wSy+jhj3VM+snfVR9UdBXrM0IXKBItsZIDf02AfPpNh3lWRXc3pAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722871340; c=relaxed/simple;
	bh=8abpcgimZ8zhWhHlWs9YVGQE18wAOSsWG48ZhjBiE8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pW/orzlbn5TnVxXjJMC9Z9p7a0M4SF4DGU1PJk2wqvPgX9mgvHg+PW9jRlm/IKIhabD9sC/I1ttGd84NBGtMBQb95/NszIl/N4c1LYXL0CEjuYU1DdSdZWYv0W3iZljvRLowvnMRuGBqnYkEB8ZcKSPtSujkXRMi9y48gc5CiJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J+EcWmFr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21125C4AF0E;
	Mon,  5 Aug 2024 15:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722871340;
	bh=8abpcgimZ8zhWhHlWs9YVGQE18wAOSsWG48ZhjBiE8Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=J+EcWmFrHfavILP+4wyerdS0sBKsXIKEo3qbw9viOT6Bs+G+kubhy4Fl8O/dMnFtG
	 WqjI/2UQgkmzntO+dtXM5QNqfz3EtVaZ8v4pyFUvFr43pWlZDPVUCNP3zT3Kxsc4E/
	 ZT9omEnyzxHC0mJhbzLQ9e91Y78JaRqIHwC8eTT2oHKML+gCszAlkAbrbM55Ml605u
	 jb5bACG5+6otD/RqFVCU3pzBXI1Lbqf8wLej5cEnVgs/XlOCD27LlcLCVxmxqGL8Ll
	 +9wNpzgXZWENUSsa08mq4Zap2rDloxyKIShZGl+XRvVQjzJZadd23YlO5qv0x2yRUJ
	 9qDfaS9A2Hjzw==
Date: Mon, 5 Aug 2024 17:22:15 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>, "Michael
 S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>, Shannon Zhao
 <shannon.zhaosl@gmail.com>, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 1/7] arm/virt: place power button pin number on a
 define
Message-ID: <20240805172215.0c8c2597@foz.lan>
In-Reply-To: <20240805160439.0bafb58d@imammedo.users.ipa.redhat.com>
References: <cover.1721630625.git.mchehab+huawei@kernel.org>
	<bf8367bddfdc95e378b5725c732533c3ba20d388.1721630625.git.mchehab+huawei@kernel.org>
	<20240730092549.6898ff3c@imammedo.users.ipa.redhat.com>
	<CAFEAcA8VWc3eQZqfJP9k5LYF-9aLChHQ+uS9UBfGV6nvybDxqQ@mail.gmail.com>
	<20240730132620.46cca4ce@imammedo.users.ipa.redhat.com>
	<20240801151544.2f315598@foz.lan>
	<20240805160439.0bafb58d@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Mon, 5 Aug 2024 16:04:39 +0200
Igor Mammedov <imammedo@redhat.com> escreveu:

> On Thu, 1 Aug 2024 15:15:44 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > Em Tue, 30 Jul 2024 13:26:20 +0200
> > Igor Mammedov <imammedo@redhat.com> escreveu:
> >   
> > > On Tue, 30 Jul 2024 09:29:37 +0100
> > > Peter Maydell <peter.maydell@linaro.org> wrote:
> > >     
> > > > On Tue, 30 Jul 2024 at 08:26, Igor Mammedov <imammedo@redhat.com> wrote:      
> > > > >
> > > > > On Mon, 22 Jul 2024 08:45:53 +0200
> > > > > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> > > > >        
> > > > > > Having magic numbers inside the code is not a good idea, as it
> > > > > > is error-prone. So, instead, create a macro with the number
> > > > > > definition.
> > > > > >
> > > > > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > > > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>        
> > > >       
> > > > > > diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> > > > > > index b0c68d66a345..c99c8b1713c6 100644
> > > > > > --- a/hw/arm/virt.c
> > > > > > +++ b/hw/arm/virt.c
> > > > > > @@ -1004,7 +1004,7 @@ static void virt_powerdown_req(Notifier *n, void *opaque)
> > > > > >      if (s->acpi_dev) {
> > > > > >          acpi_send_event(s->acpi_dev, ACPI_POWER_DOWN_STATUS);
> > > > > >      } else {
> > > > > > -        /* use gpio Pin 3 for power button event */
> > > > > > +        /* use gpio Pin for power button event */
> > > > > >          qemu_set_irq(qdev_get_gpio_in(gpio_key_dev, 0), 1);        
> > > > >
> > > > > /me confused, it was saying Pin 3 but is passing 0 as argument where as elsewhere
> > > > > you are passing 3. Is this a bug?        
> > > > 
> > > > No. The gpio_key_dev is a gpio-key device which has one
> > > > input (which you assert to "press the key") and one output,
> > > > which goes high when the key is pressed and then falls
> > > > 100ms later. The virt board wires up the output of the
> > > > gpio-key device to input 3 on the PL061 GPIO controller.
> > > > (This happens in create_gpio_keys().) So the code is correct
> > > > to assert input 0 on the gpio-key device and the comment
> > > > isn't wrong that this results in GPIO pin 3 being asserted:
> > > > the link is just indirect.      
> > > 
> > > it's likely obvious to ARM folks, but maybe comment should
> > > clarify above for unaware.    
> > 
> > Not sure if a comment here with the pin number is a good idea.
> > After all, this patch was originated because we were using
> > Pin 6 for GPIO error, while the comment was outdated (stating
> > that it was pin 8 instead) :-)
> > 
> > After this series, there will be two GPIO pins used inside arm/virt,
> > both defined at arm/virt.h:
> > 
> > 	/* GPIO pins */
> > 	#define GPIO_PIN_POWER_BUTTON  3
> > 	#define GPIO_PIN_GENERIC_ERROR 6
> > 
> > Those macros are used when GPIOs are created:
> > 
> > 	static void create_gpio_keys(char *fdt, DeviceState *pl061_dev,
> > 	                             uint32_t phandle)
> > 	{
> > 	    gpio_key_dev = sysbus_create_simple("gpio-key", -1,
> > 	                                        qdev_get_gpio_in(pl061_dev,
> >                                                          GPIO_PIN_POWER_BUTTON));
> > 	    gpio_error_dev = sysbus_create_simple("gpio-key", -1,
> > 	                                          qdev_get_gpio_in(pl061_dev,
> > 	                                                           GPIO_PIN_GENERIC_ERROR));
> > So, at least for me, it is clear that gpio_key_dev is using pin 3.  
> 
> if you switch to using already existing GED device,
> then this patch will go away since event will be delivered by GED
> instead of GPIO + _AEI.

This patch is actually independent from the rest. It is related to a power
down event, and not related at all with error inject.

The rationale for keeping it on this series was due to the original
patch 2 (as otherwise merge conflicts would rise). It can now be merged
in separate.

Btw, this is doing a cleanup requested by Michael and Peter:

	https://lore.kernel.org/qemu-devel/CAFEAcA-PYnZ-32MRX+PgvzhnoAV80zBKMYg61j2f=oHaGfwSsg@mail.gmail.com/

Thanks,
Mauro

