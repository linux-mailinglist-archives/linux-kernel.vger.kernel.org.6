Return-Path: <linux-kernel+bounces-431142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF049E396B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 13:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FF7416949B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 12:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E051B4F21;
	Wed,  4 Dec 2024 12:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EiQ6vOZq"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D66E1AB53A
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 12:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733313718; cv=none; b=UzEQgiAzdMZQXEELL/DS8ocbPl9jDCsMT2Hof5VTEW4jVcszQqPbzTcMHL1XvqIqKWxT55U6gfMvPaSVniX+A3W2+jPwACmUgBd1PGMAIBX2mRDlbbzZxoxUSzBIVaPAEjtzHiW7QjTdh+qN/k1OB5PgXKZbD0TXYhHG2NS9pAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733313718; c=relaxed/simple;
	bh=yu9K6L0reByIxM4EZiwlstKaAxLSrHPxGYe85KbLfgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K/L4Vnc/t3es/aIT4dfY8utsLbjbh73x3gnGfgj+uH3A2MFYSTN92wiJHW9U3E57EZguD+0ScwVwad1xO4IxTLBLm4dHHxUx24sF6bdyBBBl8jz673GydxrhbWHX6l7ZvPZnT+9tAGZlelz7a/WaMxmO79YkrvESyF0kJGZdH/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EiQ6vOZq; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4349fd77b33so55374345e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 04:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733313715; x=1733918515; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g351fpLdK2lkyYhcqP1PpLN3dK/iLJKWziU/9Oqsr9E=;
        b=EiQ6vOZqSxT2DAwr1d5L7/lH1P95XZ5ywDAft4Rx73eYBgQZR6KE6eK18eJPHDZ+g8
         d4maLNpZlOkJ5DIuxFKXK+rIQSIYUjbrAfjUZTAJVhHO4ZmhFDlRAANk/ihQx3WvIFiA
         G7PTSYG2vt9ug6Ns18KTo/Qha2iDI47sDvsg34b/e4OmEln7rctfBsMNn9Ih4QrqWSqb
         rzuU9MMufQp5g+itpA4b73iLoHEM28fZQDkbNbbgZHafC3HfFLU9z/wp7ZR+JTCke3VZ
         dZeqMkAEY1A+xQvwUpMN2rhOu7o7YD+frcS5dvSFPWSY6LX12edcXgxouzxZtsQHrB/5
         cwWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733313715; x=1733918515;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g351fpLdK2lkyYhcqP1PpLN3dK/iLJKWziU/9Oqsr9E=;
        b=OW4neuPnbe4N3sXgv9QWwAiQEo4cVRNOwW5GKn59wm39kWajRVSzvJoDwZiwRcudiF
         42Zntjlv4w5rfM/xruirjm+COQujZ+Bq+eaaugyyaQBlydzdXqG48NkWhdEDluhNRP9M
         bpnsQ2SCyO6FuO4PiKfHM4Cn3NLGDUdgTngQVyO258RrS+zH8/ncQN+s+sgDYFWAnGbv
         xJzuVSDD9fvsf9tVncaJWoXyVZrDGso0BjN856FkfFENX6i1eVC7OInzA5GxHT5A5rO2
         n8h9xOEO09iWFUMFc5VUK4gTce7HOpnaMLGzL6Pcki5iTrFSUbAa0n4/zeEDhAFOHDOr
         FJSA==
X-Forwarded-Encrypted: i=1; AJvYcCUVJFZnhh74wLEQQoNExKynK/yZnt4BX8PmB3zUclkjXTOSucxVW7worxOllnTFc0Y098xQvKfSM5+6sk4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/B7hjExVjYn3LBAtf08qeRV46CAZtLr0Ps9LpCfXfuCJ8lNWz
	IKX7s7qOHauXdQi94jSSb3hyiITGtdn2vRa+1v7UqfW/3h7ZNebe
X-Gm-Gg: ASbGncsZsdzEDnx6ORpGTWFfoZQpwgfo71xVf9G7jXw8WCgkGQPV6YTf1n7kTlHgZ/n
	CMKzYuV4OMOiLgB8Hi1YX0D7rSjiFEY+MnDnpzyDUlefmqiXdC6eye3HkqsBlBxXlQn6howW5Xq
	It7D53NhJW75FGBr3Znp6Mr68P6kkRwaMJUz/WX+HiL0iwK/YHJJEuP4WibTU3hhwMS7hvmkhQx
	VG/b+4W/T8a8Z1kUUVPT9YMW0kW26AeTjJQqlGkBKLUKZ5fCXk1Bwpn0B8o0pC2tw==
X-Google-Smtp-Source: AGHT+IF9NqIgghnkEvv/kl/PYOge+dz/Z66I+zobuoCi4wMGv79T9pki3Apb0qMW6ImoKaW4ahhW8A==
X-Received: by 2002:a05:600c:3c9b:b0:431:5ab3:d28d with SMTP id 5b1f17b1804b1-434d09b630amr56228135e9.9.1733313714460;
        Wed, 04 Dec 2024 04:01:54 -0800 (PST)
Received: from egonzo (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d526b131sm22909155e9.7.2024.12.04.04.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 04:01:53 -0800 (PST)
Date: Wed, 4 Dec 2024 13:01:51 +0100
From: Dave Penkler <dpenkler@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: gpib: Fix i386 build issue
Message-ID: <Z1BEr4QEF3vPDo57@egonzo>
References: <20241202173301.6462-1-dpenkler@gmail.com>
 <88c8ede5-47c0-49ec-805d-161293eec679@roeck-us.net>
 <Z07EtdJpe6mnKYOH@egonzo>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z07EtdJpe6mnKYOH@egonzo>

On Tue, Dec 03, 2024 at 09:43:33AM +0100, Dave Penkler wrote:
> On Mon, Dec 02, 2024 at 09:48:49AM -0800, Guenter Roeck wrote:
> > On 12/2/24 09:33, Dave Penkler wrote:
> > > Both drivers cast resource_type_t to void * causing the build to fail.
> > > 
> > > With CONFIG_X86_PAE enabled the resource_size_t type is a 64bit unsigned int
> > > which cannot be cast to a 32 bit pointer.
> > > 
> > > Use ioremap() instead of pci_resource_start()
> > > 
> > > Reported_by: Guenter Roeck <linux@roeck-us.net>
> > > Link: https://lore.kernel.org/all/f10e976e-7a04-4454-b38d-39cd18f142da@roeck-us.net/
> > > Fixes: bb1bd92fa0f2 ("staging: gpib: Add ines GPIB driver")
> > > Fixes: e1339245eba3 ("staging: gpib: Add Computer Equipment Corporation GPIB driver")
> > > 
> > > Signed-off-by: Dave Penkler <dpenkler@gmail.com>
> > > ---
> > > v1 -> v2 changed pci_resource_start to pci_resource_len for second parameter of ioremap
> > > 
> > Sorry, there are some more.
> > 
> > drivers/staging/gpib/tnt4882/tnt4882_gpib.c: In function ???ni_isa_attach_common???:
> > drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1430:26: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
> > 
> > drivers/staging/gpib/cb7210/cb7210.c: In function 'cb_pci_attach':
> > drivers/staging/gpib/cb7210/cb7210.c:974:36: error: cast to pointer from integer of different size
> > 
> > Not sure if that really fixes the problem though, since there is other code
> > which maps the void * back to phys_addr_t (or, rather, to unsigned long).
> > It might be better to work around the problem for now by disabling support
> > for platforms where sizeof(phys_addr_t) > sizeof(void *).
> 
> I think it is dealt with in v3.
> - Dave
OK this does not work so I will submit a v4 which makes these
drivers depend on !X86_PAE
-Dave

