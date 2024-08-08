Return-Path: <linux-kernel+bounces-279619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C47294BF9E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 16:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC627B23F6A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 14:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C986E18EFD2;
	Thu,  8 Aug 2024 14:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KmmdopGV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4353D18E77B
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 14:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723126933; cv=none; b=m6cfXFpUG3Q6DXqSwVCo/yH7F+lIAi9AEm8tnjpAFpX63fzxlNSKki2c5fj2XT0TcAlSTmk5D2N0yb2TpV76pgXxO4MAnsBGyIUatdezsM/xvFSgUTV44nXMhOPW1VQcARZIMoDM7H7L2ahXTC4zgBUicP2JJBcXTHG0xzjt+0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723126933; c=relaxed/simple;
	bh=PI1jTHZJ/+JrAglLAw0mHOtRkp8SskuOCqsV3WbRsz8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pCuJGyIQNLULsvY1L2S9eNyFwFXk8iYRo5qAW7i26GR9rB9w8wnZ0ApS7uKahLJ+lqRVzh22nxSxiw5Zy90ImLG3dw46vXkDTpY0fdhzDCEqVkI2XB8pdDfvPbp73/b68DJBQDG+pz2B3CcFrjF1omR65X88jrSpwtKktexjoV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KmmdopGV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723126930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eWiq/R1qfDvotqZucy6GvkqQ+EVl6vxLjsehT82Sjwk=;
	b=KmmdopGVUfUre9W270lCOg+lDDW5VH58CEthLyDYBrzeAx0xuX8P2+6jc3HEgjKESA9K7D
	sE0n7i05fnm3pWHns/f4CG6ceWjTkBxw7rhIWEtsxE6gvCksjKDDgLLYuhohKfzzu8T0Ta
	G98VWKbT5kkESFvx2fbpnPXj/U3G/6E=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-RyaZLZpLOmq3kVs1ZOqGaQ-1; Thu, 08 Aug 2024 10:22:08 -0400
X-MC-Unique: RyaZLZpLOmq3kVs1ZOqGaQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-36bbcecebb4so625053f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 07:22:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723126927; x=1723731727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eWiq/R1qfDvotqZucy6GvkqQ+EVl6vxLjsehT82Sjwk=;
        b=WeBQ1BMY943FyM43D5E78KjtnAhTty+ibb9Ri4YMJCwv7slYjsOW7zNoPhQ2KjIQBR
         0MwHcnDRbtS8NefZfY7ThsrbTKWOgQMyzeXLJKocg6bYbNsk5MOvBA7Qs16m2aKRZ2hz
         62dLA43I9vo4kizkfeAq3Bcb6Np0WfigEG3NVrmS41AHWLTitZ+xnj5N27MQ72O8ocQt
         AsteNqUZCKf+nnBbH8g+PSTK5x8tk75sVpLBirf3H3V2LOt9H8pJA4meJcbPV0FAtX4U
         DSuoiz6iBTU3djfmVJoIp+hnoPYjp5T/Vr+mvQgT69hMw9BPzeQmHbYp1JpUVFpoOV5k
         6gTQ==
X-Forwarded-Encrypted: i=1; AJvYcCV95kaZs5NFyFmrELAzHDoqo8g8Pjyu6ZPwFRKIjdCHHauJ3RPJTynR7ebZZTR7nEWJk1oMyqfv4xTE50jk1aRO91ndoypV67oFHFBq
X-Gm-Message-State: AOJu0Yz9H5nvCsO/RXwn3DiTsL/ah4eXnzq6WVWXTI1dZ5tZNNBtWIuS
	mjBGHKsaBVoGXJs+QIjebTPimaBCEqYk69Z9C9JDLdvvsLlfR+JMcvGytj6/P4YmhdWRutY75z8
	pg88VSYBecOav+yXdGZDcDMCH8enc5ydAuImG4z35Th343dvMc7lwLbFZ8HJsLw==
X-Received: by 2002:adf:979e:0:b0:36b:a40c:5c09 with SMTP id ffacd0b85a97d-36d27591d39mr1599404f8f.58.1723126927515;
        Thu, 08 Aug 2024 07:22:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEo0de8q7z1Eh0G8+bm2AJ2Ysdfe9LC2CbGZ+DN71+L8yiJUWpRbi57ySyHOUuoDJl7shFiVg==
X-Received: by 2002:adf:979e:0:b0:36b:a40c:5c09 with SMTP id ffacd0b85a97d-36d27591d39mr1599371f8f.58.1723126926960;
        Thu, 08 Aug 2024 07:22:06 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36d2718bfc4sm2072056f8f.57.2024.08.08.07.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 07:22:06 -0700 (PDT)
Date: Thu, 8 Aug 2024 16:22:05 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Markus Armbruster <armbru@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>, "Michael
 S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>, Dongjiu Geng
 <gengdongjiu1@gmail.com>, Eric Blake <eblake@redhat.com>, Michael Roth
 <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v5 5/7] qapi/ghes-cper: add an interface to do generic
 CPER error injection
Message-ID: <20240808162205.3a85efb6@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240808161141.5ffe730e@foz.lan>
References: <cover.1722634602.git.mchehab+huawei@kernel.org>
	<51cbdc8a53e58c69ee17b15c398feeeeeeb64f34.1722634602.git.mchehab+huawei@kernel.org>
	<87v80b1jqe.fsf@pond.sub.org>
	<20240808161141.5ffe730e@foz.lan>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 8 Aug 2024 16:11:41 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Em Thu, 08 Aug 2024 10:50:33 +0200
> Markus Armbruster <armbru@redhat.com> escreveu:
> 
> > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:  
> 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 98eddf7ae155..655edcb6688c 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -2075,6 +2075,13 @@ F: hw/acpi/ghes.c
> > >  F: include/hw/acpi/ghes.h
> > >  F: docs/specs/acpi_hest_ghes.rst
> > >  
> > > +ACPI/HEST/GHES/ARM processor CPER
> > > +R: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > +S: Maintained
> > > +F: hw/arm/ghes_cper.c
> > > +F: hw/acpi/ghes_cper_stub.c
> > > +F: qapi/ghes-cper.json
> > > +    
> > 
> > Here's the reason for creating a new QAPI module instead of adding to
> > existing module acpi.json: different maintainers.
> > 
> > Hypothetical question: if we didn't care for that, would this go into
> > qapi/acpi.json?  
> 
> Independently of maintainers, GHES is part of ACPI APEI HEST, meaning
> to report hardware errors. Such hardware errors are typically handled by 
> the host OS, so quest doesn't need to be aware of that[1].
> 
> So, IMO the best would be to keep APEI/HEST/GHES in a separate file.
> 
> [1] still, I can foresee some scenarios were passing some errors to the
>     guest could make sense.
> 
> > 
> > If yes, then should we call it acpi-ghes-cper.json or acpi-ghes.json
> > instead?  
> 
> Naming it as acpi-ghes,acpi-hest or acpi-ghes-cper would equally work
> from my side.

if we going to keep it generic, acpi-hest would do

> 
> >   
> > >  ppc4xx
> > >  L: qemu-ppc@nongnu.org
> > >  S: Orphan    
> > 
> > [...]
> >   
> > > diff --git a/qapi/ghes-cper.json b/qapi/ghes-cper.json
> > > new file mode 100644
> > > index 000000000000..3cc4f9f2aaa9
> > > --- /dev/null
> > > +++ b/qapi/ghes-cper.json
> > > @@ -0,0 +1,55 @@
> > > +# -*- Mode: Python -*-
> > > +# vim: filetype=python
> > > +
> > > +##
> > > +# = GHESv2 CPER Error Injection
> > > +#
> > > +# These are defined at
> > > +# ACPI 6.2: 18.3.2.8 Generic Hardware Error Source version 2
> > > +# (GHESv2 - Type 10)
> > > +##    
> > 
> > Feels a bit terse.  These what?
> > 
> > The reference could be clearer: "defined in the ACPI Specification 6.2,
> > section 18.3.2.8 Generic Hardware Error Source version 2".  A link would
> > be nice, if it's stable.  
> 
> I can add a link, but only newer ACPI versions are hosted in html format
> (e. g. only versions 6.4 and 6.5 are available as html at uefi.org).

some years earlier it could be said 'stable link' about acpi spec hosted
elsewhere. Not the case anymore after umbrella change.

spec name, rev, chapter worked fine for acpi code (it's easy to find wherever spec is hosted).
Probably the same would work for QAPI, I'm not QAPI maintainer though,
so preffered approach here is absolutely up to you.

> 
> Can I place something like:
> 
> 	Defined since ACPI Specification 6.2,
> 	section 18.3.2.8 Generic Hardware Error Source version 2. See:
> 
> 	https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html#generic-hardware-error-source-version-2-ghesv2-type-10
> 
> e. g. having the link pointing to ACPI 6.4 or 6.5, instead of 6.2?
> 
> >   # @raw-data: payload of the CPER encoded in base64
> > 
> > Have you considered naming this @payload instead?  
> 
> Works for me.
> 
> Thanks,
> Mauro
> 


