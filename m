Return-Path: <linux-kernel+bounces-263262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 708EF93D366
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 14:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26DBC1F24E38
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 12:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E0A17836A;
	Fri, 26 Jul 2024 12:46:53 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F05C17B40C
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 12:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721998012; cv=none; b=KLlRiZiHT0+/e54QLmhcCWFgyKEgCsLyrzac8fuaYmuOf/rWx9V2bOg3ws840witjjizelOCJX12DomSkPAhJSTFCp1gTvkd03Wab5YQ5rtvRzPK4xtT4xzr7afdsrp54PuiSyDbo+sfNnnMiyhVGQ4IaKvLv3y8lcsGv3ZVh/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721998012; c=relaxed/simple;
	bh=USy3Y7HETaGwYFyoTkroQ+T2pnga4792AMGxJ3PZCQQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DPCFxUbWFPw62OLG998C2CfYgCqofdVXbO9SzMvWlUEmtAgr1J4kLv0gatrzHPJZqwpJXGF/2XI0GcAEArMPlXlCWmikI80MUvTSzOMLBgBOwcy6frhcd5ZFVcMNuqIFwdDcRUumtfK+hGm+EpR4UP3jsFUxe+VLJ/8TK+M3Yzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WVnXJ0JGsz6K5nd;
	Fri, 26 Jul 2024 20:45:04 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 0F4EB14065B;
	Fri, 26 Jul 2024 20:46:48 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 26 Jul
 2024 13:46:47 +0100
Date: Fri, 26 Jul 2024 13:46:46 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Markus Armbruster <armbru@redhat.com>
CC: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Shiju Jose
	<shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
	<anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>, Eric Blake
	<eblake@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Michael Roth
	<michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
	<peter.maydell@linaro.org>, <linux-kernel@vger.kernel.org>,
	<qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v3 4/7] acpi/ghes: Add a logic to handle block addresses
 and FW first ARM processor error injection
Message-ID: <20240726134646.000046e3@Huawei.com>
In-Reply-To: <87bk2lreeb.fsf@pond.sub.org>
References: <cover.1721630625.git.mchehab+huawei@kernel.org>
	<6a3542a7d8acfbf88c906ec6f6dc5a697257b461.1721630625.git.mchehab+huawei@kernel.org>
	<87bk2lreeb.fsf@pond.sub.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

A few quick replies from me.
I'm sure Mauro will add more info.

> > +           'tlb-error',
> > +           'bus-error',
> > +           'micro-arch-error']
> > +}
> > +
> > +##
> > +# @arm-inject-error:
> > +#
> > +# Inject ARM Processor error.
> > +#
> > +# @errortypes: ARM processor error types to inject
> > +#
> > +# Features:
> > +#
> > +# @unstable: This command is experimental.
> > +#
> > +# Since: 9.1
> > +##
> > +{ 'command': 'arm-inject-error',
> > +  'data': { 'errortypes': ['ArmProcessorErrorType'] },  
> 
> Please separate words with dashes: 'error-types'.
> 
> > +  'features': [ 'unstable' ]
> > +}  
> 
> Is this used only with TARGET_ARM?
> 
> Why is being able to inject multiple error types at once useful?

It pokes a weird corner of the specification that I think previously 
tripped up Linux.

> 
> I'd expect at least some of these errors to come with additional
> information.  For instance, I imagine a bus error is associated with
> some address.

Absolutely agree that in sane case you wouldn't have multiple errors
but we want to hit the insane ones :(

There is only prevision for one set of data in the record despite
it providing a bitmap for the type of error.

> 
> If we encode the the error to inject as an enum value, adding more will
> be hard.
> 
> If we wrap the enum in a struct
> 
>     { 'struct': 'ArmProcessorError',
>       'data': { 'type': 'ArmProcessorErrorType' } }
> 
> we can later extend it like
> 
>     { 'union': 'ArmProcessorError',
>       'base: { 'type': 'ArmProcessorErrorType' }
>       'data': {
>           'bus-error': 'ArmProcessorBusErrorData' } }
> 
>     { 'struct': 'ArmProcessorBusErrorData',
>       'data': ... }
> 
> > diff --git a/qapi/meson.build b/qapi/meson.build
> > index e7bc54e5d047..5927932c4be3 100644
> > --- a/qapi/meson.build
> > +++ b/qapi/meson.build
> > @@ -22,6 +22,7 @@ if have_system or have_tools or have_ga
> >  endif
> >  
> >  qapi_all_modules = [
> > +  'arm-error-inject',
> >    'authz',
> >    'block',
> >    'block-core',
> > diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
> > index b1581988e4eb..479a22de7e43 100644
> > --- a/qapi/qapi-schema.json
> > +++ b/qapi/qapi-schema.json
> > @@ -81,3 +81,4 @@
> >  { 'include': 'vfio.json' }
> >  { 'include': 'cryptodev.json' }
> >  { 'include': 'cxl.json' }
> > +{ 'include': 'arm-error-inject.json' }  
> 
> 


