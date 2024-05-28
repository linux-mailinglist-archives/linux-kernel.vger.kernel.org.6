Return-Path: <linux-kernel+bounces-192017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFE28D1746
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 11:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA18B1F23A07
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 09:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCA3156F3C;
	Tue, 28 May 2024 09:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bI+RCWed"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409C5156F26
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 09:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716888654; cv=none; b=vD1M7k/bmpYFf6LJ+u49xT1oIPlVTKDBKBKnWkX+8lribstgLo3zaCymfyZwNuVGWfVDJe8Jg1x0ULqj7/GynrEkR1w0qylxv0EeHCYFQw5oJq4qqI4LiLXnB29oPQPvHhUUG97HtHQ3T96YlJNt56kn4le9H00JaSeULRLQ9Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716888654; c=relaxed/simple;
	bh=WJRxDDCwe1r+cGN/5oFq52lRYe30ytOZkfrkgk8TaSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eQIp078QQJ8D7w20JER3F7th1JwYkZPyQcfCQ1mb3ErUwxFWMeS0USjmTMh7qlAZdxATUs4xwm1117nfGMH2i5p8ohgMndj3fB5CpQ2PNtq6VM06OaHCSt2M/U0Wmdi2UMOLDWf4dbaOLgNw2nlRUvU4aJ4lVWNPJFx3pXbFNUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bI+RCWed; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2e95a883101so6812881fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 02:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716888651; x=1717493451; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GeDX4IQwDQDJtjpBLNQxj6g39RMuIlmmyZG0b2JVKEk=;
        b=bI+RCWedZ6Z4aMYP0UPcfht6AO+6RM0+rLwfvUBTdcXgtfOsz44PYrdab1QFDFif3c
         qmF/er95pbh9DT4G1eFt/BXIwcPXnCtgxyiUV0DoLwCRkC6KShx0lpItw1MPBPXKCKrm
         CAVlkWZZC9OP4hzZP6LQHrDwT+JeVSmg+LpLo2fOCvuhAKjlcekxiKGi1uqPMhb3QkXZ
         tqV5iP6e8hpOnpDBdYcGKcNTI8/oBLQ8iGC8twqFUix+zDsuFj+h2xrvNjlniAAZqknc
         RkFZ1jmtWZNeIJCd0xV/dYg8+axs+AaDzAJ9xtB8Tl6DfG6DupBGbpQ4YY1jeI7OyDJe
         PyDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716888651; x=1717493451;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GeDX4IQwDQDJtjpBLNQxj6g39RMuIlmmyZG0b2JVKEk=;
        b=gf24Dx8MyqXTOb/OpRU54+NRaGFZI1u99gqFaHJoUqEMWT5teqz6C4N8ZsEFcI0KqK
         0LrbrBYBxNMuE130y4O0qfCXvr43SPB7QSZS9IXmA7QJg4tX4XqVT/47dPFdOkbCi24B
         I4+M2UyBTu02odO+3TRpnH/RpiO9H3Yc8ydaJVwUos/DCK78FYuWkrA5EavJ0TxyBHxS
         Q1+PR5DenZxyYVZStsXzD0NnPW9RlFynvDWpxpBWFErYMbqLQP/q9yR0P9oUfaKgPhIH
         8Hh/LqfP/+0nozPZeR/166R4lUHzsgyWpf8tQc79H+PIzo0yh5ZhNVAqHN70Scw/7pXC
         Lo9A==
X-Forwarded-Encrypted: i=1; AJvYcCUPc8iHhhB+D4vuRpAlwe8Mmo8SQ6Gk2pQ5JMWjzP1nR/2ubt/hoGTuDHyMaYGuyuqwV+Tls8kK+RK35ehqooQ4mC9/kC4qpcjwdJTj
X-Gm-Message-State: AOJu0YwNBCsyGlguw977UNQG2fMEtC85plaHZRLqOiEQHLcNngbMWFvg
	nfjM5Mb+LrM/+UxbejSC6pceXO1s+V33Q6WnQ0Cmj/ANIyuj5g7cBYzPsEvRiGc=
X-Google-Smtp-Source: AGHT+IHgzrfQ9MC+g0Udj5wPSqEf953Emf/p5rF/Qi5duSrqYkyswcPhNyw1oK3vTXXcoPztAfiN4w==
X-Received: by 2002:a2e:780a:0:b0:2e9:81f0:8597 with SMTP id 38308e7fff4ca-2e981f0868fmr21754631fa.43.1716888651391;
        Tue, 28 May 2024 02:30:51 -0700 (PDT)
Received: from nuoska (87-100-245-199.bb.dnainternet.fi. [87.100.245.199])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e95bcca242sm22159681fa.12.2024.05.28.02.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 02:30:50 -0700 (PDT)
Date: Tue, 28 May 2024 12:30:48 +0300
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: Jens Wiklander <jens.wiklander@linaro.org>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
	op-tee@lists.trustedfirmware.org,
	Shyam Saini <shyamsaini@linux.microsoft.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sumit Garg <sumit.garg@linaro.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Manuel Traut <manut@mecka.net>
Subject: Re: [PATCH v7 4/4] optee: probe RPMB device using RPMB subsystem
Message-ID: <ZlWkSCCjJ2fbE2ML@nuoska>
References: <20240527121340.3931987-1-jens.wiklander@linaro.org>
 <20240527121340.3931987-5-jens.wiklander@linaro.org>
 <fc3bfebb-78b7-428e-8da5-5221f4921faa@linaro.org>
 <CAHUa44G0bcK55RxNrN5sXiicBZ-BJtA46KpedfBdUSKsN8eUOA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHUa44G0bcK55RxNrN5sXiicBZ-BJtA46KpedfBdUSKsN8eUOA@mail.gmail.com>

Hi,

On Mon, May 27, 2024 at 03:24:01PM +0200, Jens Wiklander wrote:
> On Mon, May 27, 2024 at 3:00 PM Jerome Forissier
> <jerome.forissier@linaro.org> wrote:
> >
> > On 5/27/24 14:13, Jens Wiklander wrote:
> > > Adds support in the OP-TEE drivers (both SMC and FF-A ABIs) to probe and
> > > use an RPMB device via the RPMB subsystem instead of passing the RPMB
> > > frames via tee-supplicant in user space. A fallback mechanism is kept to
> > > route RPMB frames via tee-supplicant if the RPMB subsystem isn't
> > > available.
> > >
> > > The OP-TEE RPC ABI is extended to support iterating over all RPMB
> > > devices until one is found with the expected RPMB key already
> > > programmed.
> > >
> > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > Tested-by: Manuel Traut <manut@mecka.net>
> > > ---
> > >  Documentation/ABI/testing/sysfs-class-tee |  15 ++
> > >  MAINTAINERS                               |   1 +
> > >  drivers/tee/optee/core.c                  |  96 +++++++++++-
> > >  drivers/tee/optee/device.c                |   7 +
> > >  drivers/tee/optee/ffa_abi.c               |  14 ++
> > >  drivers/tee/optee/optee_ffa.h             |   2 +
> > >  drivers/tee/optee/optee_private.h         |  26 +++-
> > >  drivers/tee/optee/optee_rpc_cmd.h         |  35 +++++
> > >  drivers/tee/optee/optee_smc.h             |   2 +
> > >  drivers/tee/optee/rpc.c                   | 177 ++++++++++++++++++++++
> > >  drivers/tee/optee/smc_abi.c               |  14 ++
> > >  11 files changed, 387 insertions(+), 2 deletions(-)
> > >  create mode 100644 Documentation/ABI/testing/sysfs-class-tee
> > >
> > > diff --git a/Documentation/ABI/testing/sysfs-class-tee b/Documentation/ABI/testing/sysfs-class-tee
> > > new file mode 100644
> > > index 000000000000..c9144d16003e
> > > --- /dev/null
> > > +++ b/Documentation/ABI/testing/sysfs-class-tee
> > > @@ -0,0 +1,15 @@
> > > +What:                /sys/class/tee/tee{,priv}X/rpmb_routing_model
> >
> > Wouldn't /sys/class/tee/teeX/rpmb_routing_model be good enough?
> 
> Doesn't the routing model concern tee-supplicant more than a TEE
> client? Then it might make more sense to have
> /sys/class/tee/teeprivX/rpmb_routing_model only. Keeping it for both
> devices representing the same internal struct optee makes it easier to
> find. Anyway, I don't mind removing one. Mikko, what do you prefer?

As simple as possible. A single sysfs file is enough. Even the existence of the sysfs file
could be the needed indicator for userspace to queue tee-supplicant startup.

Outside of these patches, I think the optee RPC setup with fTPM TA is one area which
currently requires tee-supplicant to be started. Detecting the existence of TPM before
kernel drivers are loaded is possible via the exported EFI logs from firmware to kernel
or ACPI TPM2 table entry, and detecting optee and thus starting tee-supplicant in userspace too.

In userspace and systemd it's just important to know that service need to wait for a TPM2
device to appear in early initrd and when can things be postponed to main rootfs and later
stages. Kernel and udev will bring up the device then once discovered.
Knowledge about the RPMB backend is important when something like TPM2 device
depends on it.

Hope this helps,

-Mikko

