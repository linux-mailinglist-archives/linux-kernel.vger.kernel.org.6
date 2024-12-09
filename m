Return-Path: <linux-kernel+bounces-437988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D899E9B52
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 17:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AEE216519A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 16:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C3B13A87C;
	Mon,  9 Dec 2024 16:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mmmJ7PwF"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA36137930
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 16:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733760758; cv=none; b=BYwsb9/vXWgknWWv57r0XF/U5QYe5mC/6aAZgdOX2ocLHOHGlZYq/FuUINB0cPCb4tx5b2dYHD2/jFT6ouZMtaewGCxZ+xMy8zgdRijkETQvOUhW4ANDaMnfAlRQsHCVdBPprf29MldfdV5hdPTpJfnwWS2NN1guohWYnSVYM7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733760758; c=relaxed/simple;
	bh=ZNw4fp2C4QYbIsK0RQbUfF/stAnQsN8yx5jwM1hdQIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GE33MMur0UQCfQ2pCvVcvzGoqe15vahjsRufD98tjcCL5Q/8lnZcHgdsx2M4OWZ3hd2r//DArnbR6NJEAJ10T/hvmljYLVVfGtnvdF+7hHVXY5yrk8i+jK/N2cD8TLkbdFTPnJOB7pQIg2LpQiO8lw3xjtjAweGcsPtpWHrhg8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mmmJ7PwF; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-385e87b25f0so3275210f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 08:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733760754; x=1734365554; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uX2zea6t4YtmQDjreQIsADkaIAGEnjyr87qXnrZSqec=;
        b=mmmJ7PwFpdOYPI8e2jcNyAEZtUQJns117Sax12+oORxF5DIppcdoROorF/IBHBdq5m
         XvR+tDmPimBsFYRrdJwnSKcCUy4KqIDBVWruj7xXUdf6v0LBHiGcgX3x5lLpwZRkdcr+
         /UZ/1EiNPYg09e/hNopmiCOrhvRR85j+UbLOGzSIU3pWXMIIo8w9XUpvKAgRUKdJCBmg
         AlBJ1BkOQmG5Z1u/b6dRYeQYXq5sX/evpE0plBqFNBAuSot+hg7uBdEPan97FlXfd9jB
         Evc0LVrQEiTTgBav2TSYLCH6pn8JpPthXGQmJm5ugUBSt3ylp66khaUzMFM2PBLRp35W
         3kVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733760754; x=1734365554;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uX2zea6t4YtmQDjreQIsADkaIAGEnjyr87qXnrZSqec=;
        b=QnHNQsfTYpzyHUwlkWcq1weWKWEFpRniemHMERJzofzszg5BSdzGuRuCWl58sEMAbf
         BAIsi0d+7+emT0FTqW11zY+Gr/+tJ+K7geD8QooeXAHTMl8TDRnXPxm4/1UsGFMQfbS3
         HHXaF3wQ3YNgqiSbg17sQPUeiSQ8o9/klzwFH6+vYFkx4CfLm8n26iBpDR44wwnWSymo
         WGgW0f1nigpYwzFMvNmLRG7pUW83p3iIYMI0ak9bbc1H5r7+lVDDzjBMLApeZE9dTxVx
         gunU5xLnrKbffbSk5n57NwmN3yLfllsxD5cAkYx7hF6MEo0G2YBWuBatETbth6QrvGay
         yPGA==
X-Forwarded-Encrypted: i=1; AJvYcCVkWXYnwhUVYfrG8YUKV4nPxf2C63a3NUvMXREyi5AzOLv7ATWHKlwO9FfzPJizxXYkUDtvnBzuOKBdFvg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5R6MJ0QB7GcERvJ3FRP5D/5mvGG7Sku3/3LNwRLPlIjl1mAMg
	eQgbZ4fl+U6oUoCPSBED0lhZx3m3OKO5he5h3Pz18+GFUFC7JgG4
X-Gm-Gg: ASbGnctlQWJ7I0B40KBkDXbQ6UFqH4Lb6xqg9NRsfnTWFKJc/vpH3FSveDIrCLjs7Jt
	vBB0TNVMd0KSnEpiTgrxl12bWvqsoDpOxlvvUZE4EaBdJvbjDPHahWv9ID/n0GoVz7JLm8L3aOY
	xzNVoP1Cj3fTWkAazHKVtI0IKo3k/4vuD3DmtWnsTonL23Pd7I7I8ifIFyqQJwD9GzEy6RM1aPv
	2KE0EIOyG6Y6A5OndrujR2wbVX2vEq/nD+znlGVTKZcOhj79q74+o/5p97myQa4kg==
X-Google-Smtp-Source: AGHT+IExkdgpP7kbzKSBzKp6R4wEoIAIMtqGdSNfyUy9NQb7ie77vdhSGKCArjukHLIcvRVhUWOLfw==
X-Received: by 2002:a05:6000:186b:b0:385:e8e7:d09a with SMTP id ffacd0b85a97d-3862a771f72mr10599032f8f.2.1733760754251;
        Mon, 09 Dec 2024 08:12:34 -0800 (PST)
Received: from egonzo (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3862de365f0sm10363936f8f.3.2024.12.09.08.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 08:12:33 -0800 (PST)
Date: Mon, 9 Dec 2024 17:12:31 +0100
From: Dave Penkler <dpenkler@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v5] staging: gpib: Fix i386 build issue
Message-ID: <Z1cW78qDiLb6NxjC@egonzo>
References: <20241204162128.25617-1-dpenkler@gmail.com>
 <CAMuHMdVUnr4iAZmuy8Z3S+sCYN4P26RdpPwXevwiJrh+KN025Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVUnr4iAZmuy8Z3S+sCYN4P26RdpPwXevwiJrh+KN025Q@mail.gmail.com>

On Mon, Dec 09, 2024 at 05:01:19PM +0100, Geert Uytterhoeven wrote:
Hi Geert,
> Hi Dave,
> 
> On Wed, Dec 4, 2024 at 5:21???PM Dave Penkler <dpenkler@gmail.com> wrote:
> > These drivers cast resource_type_t to void * causing the build to fail.
> >
> > With CONFIG_X86_PAE enabled the resource_size_t type is a 64bit unsigned
> > int which cannot be cast to a 32 bit pointer.
> >
> > Disable these drivers if X68_PAE is enabled
> >
> > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > Closes: https://lore.kernel.org/all/f10e976e-7a04-4454-b38d-39cd18f142da@roeck-us.net/
> > Fixes: e9dc69956d4d ("staging: gpib: Add Computer Boards GPIB driver")
> > Fixes: e1339245eba3 ("staging: gpib: Add Computer Equipment Corporation GPIB driver")
> > Fixes: bb1bd92fa0f2 ("staging: gpib: Add ines GPIB driver")
> > Fixes: 0cd5b05551e0 ("staging: gpib: Add TNT4882 chip based GPIB driver")
> > Signed-off-by: Dave Penkler <dpenkler@gmail.com>
> 
> Thanks for your patch!
> 
> > --- a/drivers/staging/gpib/Kconfig
> > +++ b/drivers/staging/gpib/Kconfig
> > @@ -50,6 +50,7 @@ config GPIB_CEC_PCI
> >         tristate "CEC PCI board"
> >         depends on PCI
> >         depends on HAS_IOPORT
> > +       depends on !X86_PAE
> 
> !CONFIG_PHYS_ADDR_T_64BIT, to match the definition of phys_addr_t?
> 
> Or is this only showing up on x86?
> 

I think so. See this message from Guenter
https://lore.kernel.org/all/7d7e65af-b818-45de-a92c-ee59a864dbdb@roeck-us.net/

cheers,
-Dave


