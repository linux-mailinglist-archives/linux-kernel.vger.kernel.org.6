Return-Path: <linux-kernel+bounces-279665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C192394C033
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 16:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46FD21F2B599
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 14:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D09019069C;
	Thu,  8 Aug 2024 14:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Km7uZpIu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BCE18F2C9
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 14:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723128362; cv=none; b=PDIYJJ89f3IXNDdn700PPHUbkUbCedSDs/MCyfnskkdXy+ERd4DvyYCSYMP315cRgSZi8+nvKbqgpCHzgzCEOvwXPdks1YeM9GDj2ggHK/7NbLtZ936S6KWNU2E8AOrEGtr2KbfmthqVbDDl5sJ0W7flomK+LgTtKJPVwKD6fAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723128362; c=relaxed/simple;
	bh=zNvHD4w+/y8NUBMfZxU71AMa4M89/5LaOnlHIpRGvw0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CHIM4R7L+PAEskh9Xr+svaYCQf3SWNYJZi/4d9OtRi9rK0nZPuj0mBMNFLk4kUAF8JGFv9//SXGjOk5tpAdNPsCBECkb3Z89ycwx0qDWi0jCphtqUKBwgEc2h0wRdrdEp3D1jcJpAJKu+0pFZPngramzs11331Jtnw3lpCOHVFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Km7uZpIu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723128360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vsy+kQPvnenW2/13lHMrZ1NDZEbx4ggdcgIqJP+YPxc=;
	b=Km7uZpIuvGpjK1h5hKMGMo+BaoO8yxDs5ZDmFWE6qU6KEtmVykE0wjW96QfMpzvl2KvkOB
	EWNuNAVoJZfKAw6V5kjITBhr/84gZB5NWVA5K4vzLL2mWBTMaed1UUOAIgjNpc2LjEYpDI
	w7sh54ipncV1lFAYREriWViGYOOtv7I=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-630-qmltV5FpPnSUeIh-n7Lpfw-1; Thu,
 08 Aug 2024 10:45:57 -0400
X-MC-Unique: qmltV5FpPnSUeIh-n7Lpfw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 22A8F1955BC1;
	Thu,  8 Aug 2024 14:45:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.245])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DC8431959164;
	Thu,  8 Aug 2024 14:45:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 8C41421E6682; Thu,  8 Aug 2024 16:45:51 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,  Jonathan Cameron
 <Jonathan.Cameron@huawei.com>,  Shiju Jose <shiju.jose@huawei.com>,
  "Michael S. Tsirkin" <mst@redhat.com>,  Ani Sinha <anisinha@redhat.com>,
  Dongjiu Geng <gengdongjiu1@gmail.com>,  Eric Blake <eblake@redhat.com>,
  Michael Roth <michael.roth@amd.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,
  linux-kernel@vger.kernel.org,  qemu-arm@nongnu.org,
  qemu-devel@nongnu.org
Subject: Re: [PATCH v5 5/7] qapi/ghes-cper: add an interface to do generic
 CPER error injection
In-Reply-To: <20240808162205.3a85efb6@imammedo.users.ipa.redhat.com> (Igor
	Mammedov's message of "Thu, 8 Aug 2024 16:22:05 +0200")
References: <cover.1722634602.git.mchehab+huawei@kernel.org>
	<51cbdc8a53e58c69ee17b15c398feeeeeeb64f34.1722634602.git.mchehab+huawei@kernel.org>
	<87v80b1jqe.fsf@pond.sub.org> <20240808161141.5ffe730e@foz.lan>
	<20240808162205.3a85efb6@imammedo.users.ipa.redhat.com>
Date: Thu, 08 Aug 2024 16:45:51 +0200
Message-ID: <87ikwbrs2o.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Igor Mammedov <imammedo@redhat.com> writes:

> On Thu, 8 Aug 2024 16:11:41 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
>
>> Em Thu, 08 Aug 2024 10:50:33 +0200
>> Markus Armbruster <armbru@redhat.com> escreveu:
>> 
>> > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:  
>> 
>> > > diff --git a/MAINTAINERS b/MAINTAINERS
>> > > index 98eddf7ae155..655edcb6688c 100644
>> > > --- a/MAINTAINERS
>> > > +++ b/MAINTAINERS
>> > > @@ -2075,6 +2075,13 @@ F: hw/acpi/ghes.c
>> > >  F: include/hw/acpi/ghes.h
>> > >  F: docs/specs/acpi_hest_ghes.rst
>> > >  
>> > > +ACPI/HEST/GHES/ARM processor CPER
>> > > +R: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>> > > +S: Maintained
>> > > +F: hw/arm/ghes_cper.c
>> > > +F: hw/acpi/ghes_cper_stub.c
>> > > +F: qapi/ghes-cper.json
>> > > +    
>> > 
>> > Here's the reason for creating a new QAPI module instead of adding to
>> > existing module acpi.json: different maintainers.
>> > 
>> > Hypothetical question: if we didn't care for that, would this go into
>> > qapi/acpi.json?  
>> 
>> Independently of maintainers, GHES is part of ACPI APEI HEST, meaning
>> to report hardware errors. Such hardware errors are typically handled by 
>> the host OS, so quest doesn't need to be aware of that[1].
>> 
>> So, IMO the best would be to keep APEI/HEST/GHES in a separate file.
>> 
>> [1] still, I can foresee some scenarios were passing some errors to the
>>     guest could make sense.
>> 
>> > 
>> > If yes, then should we call it acpi-ghes-cper.json or acpi-ghes.json
>> > instead?  
>> 
>> Naming it as acpi-ghes,acpi-hest or acpi-ghes-cper would equally work
>> from my side.
>
> if we going to keep it generic, acpi-hest would do

Works for me.

>> > >  ppc4xx
>> > >  L: qemu-ppc@nongnu.org
>> > >  S: Orphan    
>> > 
>> > [...]
>> >   
>> > > diff --git a/qapi/ghes-cper.json b/qapi/ghes-cper.json
>> > > new file mode 100644
>> > > index 000000000000..3cc4f9f2aaa9
>> > > --- /dev/null
>> > > +++ b/qapi/ghes-cper.json
>> > > @@ -0,0 +1,55 @@
>> > > +# -*- Mode: Python -*-
>> > > +# vim: filetype=python
>> > > +
>> > > +##
>> > > +# = GHESv2 CPER Error Injection
>> > > +#
>> > > +# These are defined at
>> > > +# ACPI 6.2: 18.3.2.8 Generic Hardware Error Source version 2
>> > > +# (GHESv2 - Type 10)
>> > > +##    
>> > 
>> > Feels a bit terse.  These what?
>> > 
>> > The reference could be clearer: "defined in the ACPI Specification 6.2,
>> > section 18.3.2.8 Generic Hardware Error Source version 2".  A link would
>> > be nice, if it's stable.  
>> 
>> I can add a link, but only newer ACPI versions are hosted in html format
>> (e. g. only versions 6.4 and 6.5 are available as html at uefi.org).
>
> some years earlier it could be said 'stable link' about acpi spec hosted
> elsewhere. Not the case anymore after umbrella change.
>
> spec name, rev, chapter worked fine for acpi code (it's easy to find wherever spec is hosted).
> Probably the same would work for QAPI, I'm not QAPI maintainer though,
> so preffered approach here is absolutely up to you.

A link is strictly optional.  Stable links are nice, stale links are
annoying.  Mauro, you decide :)

Thanks!

[...]


