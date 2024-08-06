Return-Path: <linux-kernel+bounces-275927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C50948C0F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 11:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D230B24387
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 09:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648AA1BDA8B;
	Tue,  6 Aug 2024 09:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aKx82Bmj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C975464E
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 09:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722935901; cv=none; b=RcCUZxQs5GNav2xC6g81wmyp6JhaxIp6pVle0JEImbs29a0Kk4f7EoAP9FmmXdgkCRNzMtvLjwzJCNBfhhT2lO8Wfx+U+UstODG1OTEXZP05KKw7dRFTh/dbIfedN4Lqc8otvog53IvAV42ApeHiBns9jUAWdrHdPXXGizVRJCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722935901; c=relaxed/simple;
	bh=xQdSI9C7Qu+kqgTBevD0hD13tRvt7O8vyHl2hu1aq2k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kPay+TbxqbO7QCVyRp7eaUr9zXRXrsApf9B+Af5vX0F69mM2Z3F52wjzuzLHBdn4s5CCr5n4uVmEgoXyhaPTfK/r8GWDUDixqPqVndFENMd+AsyB0eaEuPQY0cefr/qeelV5HyfQz4ILRy5OXPIVviM1qe8qbuZWNzEtAXpCzoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aKx82Bmj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722935899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y59hN2s/MNY6Pe91xmrj92ENgow4G095yCJtbOBOOcs=;
	b=aKx82BmjvI2+FvASV7MX9tRhoTDFCMqWgPwC1JqQNYmIMEBux8dM50cGiF2P9ZijlCTsbE
	NO83rnOrViseNOtdO253rbmF175Z0ZXC+kGg4j6+dXL0JLM/HxXUf3hbPuyWtmrqPGI4+b
	hiEu5vqdpzvmpsQTIG826mEdeHGhd40=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-qW5OfVn5Pa6fyPqbrUf6Pg-1; Tue, 06 Aug 2024 05:18:14 -0400
X-MC-Unique: qW5OfVn5Pa6fyPqbrUf6Pg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4281b7196bbso3859455e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 02:18:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722935893; x=1723540693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y59hN2s/MNY6Pe91xmrj92ENgow4G095yCJtbOBOOcs=;
        b=OuYPeFycNqmin8CtRLgbwJsVNhn9nuqiga4IpT29O78029lUBbONixfas/7MCHlskM
         /lFvOMiJkXiykuvqfm5r6T9JgEtug6p66LxsIkU2ld2PFtgQfAE5ReEX9doNhxjwxe/W
         2Nx9q1bTYQxT0losO/eGjuXm46j8XhyTtPQyPApw8Vak4NpdeQ5zeYf2U4mYl1ws//3r
         g3fNVwCBXvxWz5Cr1yzyn6UCNONail19DJZIw+oycOf7VgYyTtw+FJV1CayN5GNzDn64
         Q41GZyeRNQWtEVJ/it3+I/TrO4b3xh8qWIG6Pu9YEvJ5+2R6mrvzhooMHB2tNHYiuNqd
         i2rg==
X-Forwarded-Encrypted: i=1; AJvYcCVYrnx0n0CMXHP2lba2sF0/ko5TfKzyzeTknze1lJm+ZsAyDrr8t7TReQWYdhHD0xhmt2KUWnz8ypRKOhKk5DnTGuouXFD0XewcILS3
X-Gm-Message-State: AOJu0Yylqoi7KcTFMO8T88Eds7uI0N53RJw4a2IRD1vKAQpNvovpDdCL
	hG1m1vM1BIF+AjD48BLppuyS/0g91b/3T6XTpau0VixlP+Eyx/lYrB1RNmk4m2WWHedAa12EVok
	HqCeElaFtMyoX/LSCYtXcKzhYvYWMwccWDESE0qXhtfBNrW/d2lDk5Ug/UQhSMg==
X-Received: by 2002:a05:600c:3caa:b0:426:622d:9e6b with SMTP id 5b1f17b1804b1-428e6b7e5ddmr108736235e9.23.1722935893261;
        Tue, 06 Aug 2024 02:18:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvysX2vltXK8sXDEyjf8yRaX+R57uey5E5z7HEyphW/MiuBtAMi/U71enPWHJ9RzN/4Bfl5A==
X-Received: by 2002:a05:600c:3caa:b0:426:622d:9e6b with SMTP id 5b1f17b1804b1-428e6b7e5ddmr108735955e9.23.1722935892704;
        Tue, 06 Aug 2024 02:18:12 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282bb64b84sm231279505e9.32.2024.08.06.02.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 02:18:11 -0700 (PDT)
Date: Tue, 6 Aug 2024 11:18:09 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 <linux-kernel@vger.kernel.org>, <qemu-arm@nongnu.org>,
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v5 4/7] acpi/ghes: Support GPIO error source
Message-ID: <20240806111809.10bc2406@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240806080928.5a04c550@foz.lan>
References: <cover.1722634602.git.mchehab+huawei@kernel.org>
	<5d53042ebc5bc73bbc71f600e1ec1dea41f346b9.1722634602.git.mchehab+huawei@kernel.org>
	<20240805175617.000036ce@Huawei.com>
	<20240806080928.5a04c550@foz.lan>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 6 Aug 2024 08:09:28 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Em Mon, 5 Aug 2024 17:56:17 +0100
> Jonathan Cameron <Jonathan.Cameron@Huawei.com> escreveu:
> 
> > On Fri,  2 Aug 2024 23:43:59 +0200
> > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> >   
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > 
> > > Add error notification to GHES v2 using the GPIO source.    
> > 
> > The gpio / external interrupt follows through.  
> 
> True. As session 18.3.2.7 of the spec says:
> 
> 	The OSPM evaluates the control method associated with this event 
> 	as indicated in The Event Method for Handling GPIO Signaled Events 
> 	and The Event Method for Handling Interrupt Signaled Events.
> 
> E. g. defining two methods:
> 	- GED GPIO;
> 	- GED interrupt
> 
> I'm doing this rename:
> 
> 	ACPI_HEST_SRC_ID_GPIO -> ACPI_HEST_SRC_ID_GED_INT
> 
> To clearly state what it is implemented there.
> 
> I'm also changing patch description to:
> 
>     acpi/ghes: Add support for General Purpose Event
>     
>     As a GED error device is now defined, add another type
>     of notification.
>     
>     Add error notification to GHES v2 using the GPIO source.
                                                  ^^^^
did you mean: GED?
>     
>     [mchehab: do some cleanups at ACPI_HEST_SRC_ID_* checks and
>      rename HEST event to better identify GED interrupt OSPM]
> 
>     Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>     Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> 
> Regards,
> Mauro
> 


