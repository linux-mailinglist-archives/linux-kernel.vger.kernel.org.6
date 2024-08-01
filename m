Return-Path: <linux-kernel+bounces-270896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B0A9446BD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 10:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C42BD1C23FA4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 08:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3DF16EBEC;
	Thu,  1 Aug 2024 08:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E6yB6w6P"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C4D16DC12
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 08:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722501398; cv=none; b=Qo7JSO3VjOUX59Rha14kRlP85E5InqcBJ4i3nJaEPXIBq/TnmqH9TITH+ykADtnu9HKGFJTtubdKAnxHtQpF2BHhIL/GoLQolHiXE+vAl8gcZ2/Qdzgw0piuBHnrerKDJURwTzDHswS4OTRyDaTfXXNQfbCFZqFOIIkEdzT4WRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722501398; c=relaxed/simple;
	bh=53Gol62HXI8ANgITIavk6nlOE1BZliLnA74q+AhXJoA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FXIPo7z0z/plXTku4o2C3ShSQUmoCW6PYJLtQ0NHvbpJXc9TCUrM05kXbVgIpajjroN4NDehuCMZk8h0qutLCIPE1iIn7h1k3Ky+VKfXLyosRhIXJ7VzEXUAwqB66fKTfJGLGKrqrFijiA9XH/Bgs1kfFnCUNeI4oPmtbkQgZF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E6yB6w6P; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722501395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MLE6KK5gFMf2XsogUqCDNWEoA2wLRWIKBwIRKG5g89I=;
	b=E6yB6w6PthGWFotrW9XGzK3xtj1f2kv2fIPZFSW2NBMzRxwNlAesbbytcpc3ibmAomf3v9
	ylhicTyhjzbExvBK9E01T//he6Qave8TH7l4IHEpLv8htFy2JTS72g0JMerppIdPwJPQke
	cB4h/mlvglxy0Y4hfk0SIJ5AmwGVfGs=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-7lyaByPMNxO8phBjFt29XQ-1; Thu, 01 Aug 2024 04:36:34 -0400
X-MC-Unique: 7lyaByPMNxO8phBjFt29XQ-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2f01bd7ad5eso66975951fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 01:36:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722501393; x=1723106193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MLE6KK5gFMf2XsogUqCDNWEoA2wLRWIKBwIRKG5g89I=;
        b=DcGB96NFYUXVnLm7JrP5e5vNzBaPMcd6V/jvRZO9RKuh/MkNyP70rrKhX0KD0P83BT
         JpHUrMcPBGsPDGPNwTOP3WkL74n6AUZnxLc4b7odvlkyZzI+1JJpF11faiFpD8sVuQqZ
         GjJQxveuL0Yi4HicLsZ8SWqef/nDK9ap/ndUCp8ko/Zr0UIAOWxHZHQlyx62/ains3Dv
         JS1E/iG2i6XsUYMfQWe8dyDUFMnILYeHp9CexCRq4Qmew36zGRhwTMH7H2df3JRt4hLH
         kdDlAjeVBqMODS6rnwjjE6CNe4xpMh9azQ4PQOreXCd0DHP+KQH8WzSmMikkkykjvo6s
         JNpw==
X-Forwarded-Encrypted: i=1; AJvYcCV3jbMJYD/9qzRX9kzRoTMAD+F6XL8S+g32cCXqFH0GEp46PSeiLAdeUoGE4Ga0sPrzXNiLoK2rdX9isuTeK4v5QrtP6unpWH0lxgXr
X-Gm-Message-State: AOJu0YxEJJXuqccYt8blyPRVBi5AmYIjpBeCyiVIrPBfrksRQDXbLnp1
	9igco1hUc/+98ZlIhUr03zk9KJdExNeX4EKT+85rU8bn6MMuqvmf+9SSfmDDiRPE2415PA7SCDm
	hTSkPfoCh8qOMsN9L86Xuy2wj21HN8EiO113SOrOC9jQGCp5ZQ9wzhrwac2oGWw==
X-Received: by 2002:a05:651c:2228:b0:2ef:2e1c:79ae with SMTP id 38308e7fff4ca-2f1530f24a1mr16821301fa.19.1722501392764;
        Thu, 01 Aug 2024 01:36:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEnRPh18F35epnWcai49QbqGK/JB6KrfWRu28nZeMpboe3XxDseKb4PssaF64W5E2uUYHddA==
X-Received: by 2002:a05:651c:2228:b0:2ef:2e1c:79ae with SMTP id 38308e7fff4ca-2f1530f24a1mr16819291fa.19.1722501389463;
        Thu, 01 Aug 2024 01:36:29 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282bb232besm47864495e9.48.2024.08.01.01.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 01:36:28 -0700 (PDT)
Date: Thu, 1 Aug 2024 10:36:23 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth
 <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, <linux-kernel@vger.kernel.org>,
 <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v3 4/7] acpi/ghes: Add a logic to handle block addresses
 and FW first ARM processor error injection
Message-ID: <20240801103623.2a74012e@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240731095719.000004dc@Huawei.com>
References: <cover.1721630625.git.mchehab+huawei@kernel.org>
	<6a3542a7d8acfbf88c906ec6f6dc5a697257b461.1721630625.git.mchehab+huawei@kernel.org>
	<20240730131709.10e72c7d@imammedo.users.ipa.redhat.com>
	<20240731091133.07ddd58c@foz.lan>
	<20240731095719.000004dc@Huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 31 Jul 2024 09:57:19 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Wed, 31 Jul 2024 09:11:33 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > Em Tue, 30 Jul 2024 13:17:09 +0200
> > Igor Mammedov <imammedo@redhat.com> escreveu:
> >   
> > > On Mon, 22 Jul 2024 08:45:56 +0200
> > > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
[...]
> > > Preferably make it generic enough to handle
> > > not only ARM but other error formats HEST is
> > > able to handle.    
> > 
> > A too generic interface doesn't sound feasible to me, as the
> > EINJ code needs to check QEMU implementation details before
> > doing the error inject.  
> 
> To be clear we are talking here about a script that
> generates 'similar' stuff to ACPI EINJ does and injects
> via qapi, not guest injection (which is almost always locked
> down on production machines / distros because of the footgun
> aspect).  + ACPI EINJ interface suffers exactly the same
> problems with state discoverability we have with a raw interface here.
> (I checked with Mauro offline that I'd interpreted this
> comment correctly!)
> 
> > 
> > See, processor is probably the simplest error injection
> > source, as most of the fields there aren't related to how
> > the hardware simulation is done.
> > 
> > Yet, if you see patch 7 of this series, you'll notice that some
> > fields should actually be filled based on the emulation.
> > 
> > On ARM, we have some IDs that depend on the emulation
> > (MIDR, MPIDR, power state). Doing that on userspace may require
> > a QAPI to query them.  

QEMU has qmp commands to query QOM tree, device properties is
likely what you'd be interested with.
Adding new QAPI might be not necessary as long as needed
data point are exposed via device's properties.

And additional properties are relatively cheap, especially if their
names prefixed with 'x-' which by convention means
/internal use, not stable, not ABI/

Well whole qmp tree structure hasn't been declared as ABI (as far as I know),
but it's relatively stable and we try not to mess with it much
(especially for mainstream virt machines), as some external users
might (ab)use it anyway (no promises on QEMU side though).

On contrary QAPI is mostly considered as ABI QEMU provides
to its users with burden to maintain it stability.

If injection script is internal tool to QEMU, it should be fine
for it to use qom introspection to get data and limit QAPI
necessary minimum only.
To make sure it won't be broken silently by 'innocent' QEMU
contributors, have a CI job to make sure that it still works
as intended.

> We could strip back the QAPI part to only the bits that are
> not dependent on state.  However, the kicker to that is we'd
> need to make sure all that state is available to an external
> tool (or fully controllable from initial launch command line).
> I'm not sure where the gaps are but, I'm fairly sure there
> will be some.  Doesn't save much code other than documentation
> of the QAPI.
> 
> > 
> > The memory layout, however, is the most complex one. Even for
> > an ARM processor CPER (which is the simplest scenario), the 
> > physical/virtual address need to be checked against the emulation
> > environment.
> > 
> > Other error sources (like memory errors, CXL, etc) will require
> > a deep knowledge about how QEMU mapped such devices.  
> 
> For CXL stuff we'll piggy back on native error injection interfaces
> that are already there and couldn't be avoided because they
> are writing a bunch of register state (that we elide in the FW
> first path). 
> https://lore.kernel.org/qemu-devel/20240205141940.31111-12-Jonathan.Cameron@huawei.com/
> So we won't be adding new QAPI, but the error record generation logic
> will be in QEMU.  For background, the CXL FW first error injection
> has taken a back seat to the ARM errors because of the obvious
> other factor that CXL isn't supported on ARM in upstream QEMU.
> Once I escape a few near term deadlines I'll add the x86
> support for GHESv2 / SCI interrupt signaling as you'd see on a
> typical x86 server.
> 
> > 
> > So, in practice, if we move this to an EINJ script, we'll need
> > to add a probably more complex QAPI to allow querying the memory
> > layout and other device and CPU specific bindings.
> > 
> > Also, we don't know what newer versions of ACPI spec will reserve
> > us. See, even the HEST table contents is dependent of the HEST 
> > revision number, as made clear at the ACPI 6.5 notes:
> > 
> > 	https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html#acpi-error-source
> > 
> > and at:
> > 
> > 	https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html#error-source-structure-header-type-12-onward
> > 
> > So, if we're willing to add support for a more generic "raw data"
> > QAPI, I would still do it per-type, and for the fields that won't
> > require knowledge of the device-emulation details.  
> 
> Could blend the two options and provide no qapi for the bits
> that are QEMU state dependent - if fuzzing, can inject
> the full record raw as doesn't have to be valid state anyway.
> 
> > 
> > Btw, my proposal on patch 7 of this series is to have raw data
> > for:
> > 	- the error-info field;
> > 	- registers dump;
> > 	- micro-architecture specific data.
> > 
> > I don't mind trying to have more raw data there as I see (marginal) 
> > benefits of allowing to generate CPER invalid records [1], but some of
> > those  fields need to be validated and/or filled internally at QEMU - if
> > not forced to an specific value by the caller.
> > 
> > [1] a raw data EINJ can be useful for fuzzy logic fault detection to 
> >     check if badly formed packages won't cause a Kernel panic or be
> >     an exploit. Yet, not really a concern for APEI, as if the hardware
> >     is faulty, a Kernel panic is not out of the table. Also, if the
> >     the BIOS is already compromised and has malicious code on it, 
> >     the EINJ interface is not the main concern.
> >   
> > > PS:
> > > For user convenience, QEMU can carry a script that
> > > could help generate this raw value in user friendly way
> > > but at the same time it won't put maintenance
> > > burden on QEMU itself.    
> > 
> > The script will still require reviews, and the same code will 
> > be there. So, from maintenance burden, there won't be much
> > difference.  

it makes a lot of difference if code is integral part qemu binary,
(less people have to spend time on reviewing it, avoid increasing
attack surface, ... (other made up reasons)).

Implementing shim/proxy in QEMU and putting all error composing logic
into a separate script (even if it's a part QEMU source), shifts
most of the burden to whomever (I'd assume you'd volunteer yourself)
would maintain the script.

If script breaks, it doesn't affect QEMU itself (nor I believe it
should affect release process), script's maintainer(s) can have their
own schedule/process on how to deal with it.
 
> Agreed. I'd also be very keen that the script is tightly coupled to
> QEMU as doesn't make sense to carry with kernel or RAS daemon and
> I'd want to ultimately get this stuff into all the appropriate
> CI flows.

Agreed, it makes much more sense to carry such script as a part of QEMU.


> > 
> > Btw, I'm actually using myself a script to test it, currently
> > sitting together with rasdaemon - which is the Linux tool to detect
> > and handle hardware errors:
> > 
> > 	https://github.com/mchehab/rasdaemon/blob/master/contrib/qemu_einj.py
> > 
> > as it helps a lot when trying to simulate more complex errors.
> > 
> > Once QEMU gains support to inject processor errors, I can prepare a 
> > separate patch to move it to QEMU.
> > 
> > Thanks,
> > Mauro  
> 
> So tricky questions. I'm not sure which way is the least painful!
> 
> Jonathan
> 
> 


