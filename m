Return-Path: <linux-kernel+bounces-284450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E92950113
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 11:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEC381F21650
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 09:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5EC16BE01;
	Tue, 13 Aug 2024 09:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jtl834G/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF37210E7
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 09:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723540641; cv=none; b=h24B/C4pzp49GgThjonTxEgDfHDQs01RrjqGB2T9aQcfxa8S6zVixqBUTLDxvWsOmxhmcG3o1RKUkT/25fuRhTtkWlJ/lb+lNfwXJtiYXiW7l2B9klyFS/VnEabZHShKAy6tWR9YWPVWBoZhxVsO8lrq1mj5dIMtbH8v5+NcPR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723540641; c=relaxed/simple;
	bh=l6tHKEWnYWJ9Hhm4vrM+0cpUxRH+L5N9NWRNQPRHAWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=blDy0iRiJ/e+ptY/qn2f+lpTD/aOttEkwFU+UaqylKyaXhLC5Qg95adsJCs0zCJbDVN8j8J7v0HIHA4hFNe4f4xojGUV7JsPm/7bpHKBxwhhhoWhOedPNMlb+wrLIsz5Agj3ZduKJpP+X1F7SyqTWrI8B2EzOIu3YPqKnAlKq5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jtl834G/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723540638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J3dzzkihmU0oWgDbdzaqrXfn8l2l+YCCSlKhwcKDVXU=;
	b=Jtl834G/hvdZnmcYVRm0jAukIygA9udnNt7faxABcE7T8q7hww+ZZP8qRnfpSIiXHFoSOu
	5ms4GahmRprXwF6ErJerwiGETG68rHMkmmv97J0Bq61o3uo2WQ52GKVKHckWPvfXEWW1Av
	cS9pPh2cAB6HQZD191rCVexvwMCz2jM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-457-tGbMoIq-NCG48YYwgfgsAA-1; Tue,
 13 Aug 2024 05:17:13 -0400
X-MC-Unique: tGbMoIq-NCG48YYwgfgsAA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A0EB11954B0E;
	Tue, 13 Aug 2024 09:17:10 +0000 (UTC)
Received: from localhost (unknown [10.72.112.25])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 84BB43001FC3;
	Tue, 13 Aug 2024 09:17:08 +0000 (UTC)
Date: Tue, 13 Aug 2024 17:17:04 +0800
From: Baoquan He <bhe@redhat.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Petr Tesarik <petr@tesarici.cz>, Hari Bathini <hbathini@linux.ibm.com>,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: Re: [PATCH v2] Document/kexec: Generalize crash hotplug description
Message-ID: <ZrskkDuMlQu+uBN4@MiWiFi-R3L-srv>
References: <20240812041651.703156-1-sourabhjain@linux.ibm.com>
 <Zrrpcn7cnCigNfWd@MiWiFi-R3L-srv>
 <4cbbf314-5134-4a1a-8a4d-f6f8c09104d3@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cbbf314-5134-4a1a-8a4d-f6f8c09104d3@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 08/13/24 at 10:58am, Sourabh Jain wrote:
> Hello Baoquan,
> 
> On 13/08/24 10:34, Baoquan He wrote:
> > On 08/12/24 at 09:46am, Sourabh Jain wrote:
> > ......
> > > ---
> > > 
> > > Changelog:
> > > 
> > > Since v1: https://lore.kernel.org/all/20240805050829.297171-1-sourabhjain@linux.ibm.com/
> > >    - Update crash_hotplug sysfs document as suggested by Petr T
> > >    - Update an error message in crash_handle_hotplug_event and
> > >      crash_check_hotplug_support function.
> > > 
> > > ---
> > ......
> > > diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> > > index 63cf89393c6e..c1048893f4b6 100644
> > > --- a/kernel/crash_core.c
> > > +++ b/kernel/crash_core.c
> > > @@ -505,7 +505,7 @@ int crash_check_hotplug_support(void)
> > >   	crash_hotplug_lock();
> > >   	/* Obtain lock while reading crash information */
> > >   	if (!kexec_trylock()) {
> > > -		pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
> > > +		pr_info("kexec_trylock() failed, kdump image may be inaccurate\n");
> > Wondering why this need be updated.
> 
> In some architectures, additional kexec segments become obsolete during a
> hotplug event,
> so simply calling out the `elfcorehdr may be inaccurate` may not be
> sufficient.
> Therefore, it has been generalized with the kdump image.

OK, I forgot the case in ppc, makes sense to me, thx.

Acked-by: Baoquan He <bhe@redhat.com>


