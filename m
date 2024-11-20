Return-Path: <linux-kernel+bounces-415300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FAB19D3411
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 08:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FCC7B22E30
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 07:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3A41586C8;
	Wed, 20 Nov 2024 07:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hDCGiDQM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A159D200CB
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 07:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732087320; cv=none; b=keE/LSbFij9j5VtNXlwG3p//dIParlbzLYxJloUz7zFFeO9mUphHLj5Eg8pWqGl+8b7yW1ytVfKpY32vdkUM5aHXSWnb12fbfpcyBtJBuMvM5YQs9auBedWPjD69w1ajjzgIj96gziIz1l8RpTM5XsWgdPsz9nz+jgqndydYF5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732087320; c=relaxed/simple;
	bh=C+0KfnGdDBUYcJNneAihNuIYCdtSQpayaOSP2MWpluY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p8ECHjSgliqK4vQgqhbq1MrNStvLGNyO3D0Ou8wC0N5vze24AsxkP/q1dpeMlJEsH0ogcYlNCi2kec6cNV+1KLEV1DoYhrvDTrkv8vLte7tojFtUexI9VqAh104inPz19qoGK8oN0CjOVx5gIKybvUsGDhaXAmYB3z3Gj6GeCpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hDCGiDQM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732087317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4UNfjaijTVuehkLLB09ZGD0Qs5te78NeeI0Sbpvi304=;
	b=hDCGiDQMu7fbr5G382elh+vogFJLS/pnQtzkpsTb28dkXy0KxDF7qPS+stAHUpU0kqnFr0
	tLnrAwv/6wiqyTvrNf+9Siv381rhunm9wNK8tlCk2AuEjThG8Wb/T4oQHbiUlPqi2Ctupq
	IxyWfBxl1CByG02iMoUWVr1rJtyfTvA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-541-Pp_YtALEMACgx0Bp-798LA-1; Wed,
 20 Nov 2024 02:21:55 -0500
X-MC-Unique: Pp_YtALEMACgx0Bp-798LA-1
X-Mimecast-MFC-AGG-ID: Pp_YtALEMACgx0Bp-798LA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 75EFE1956088;
	Wed, 20 Nov 2024 07:21:54 +0000 (UTC)
Received: from localhost (unknown [10.72.113.10])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3532B19560A3;
	Wed, 20 Nov 2024 07:21:52 +0000 (UTC)
Date: Wed, 20 Nov 2024 15:21:48 +0800
From: Baoquan He <bhe@redhat.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org,
	bp@alien8.de, x86@kernel.org
Subject: Re: [PATCH v2 1/2] x86/ioremap: introduce helper to implement
 xxx_is_setup_data()
Message-ID: <Zz2ODGBXmOLDY4mv@MiWiFi-R3L-srv>
References: <20241118010819.46602-1-bhe@redhat.com>
 <20241118010819.46602-2-bhe@redhat.com>
 <7cc5e26c-42fc-a700-ae19-608920cafe44@amd.com>
 <ZzwA53x3KYQgDbeQ@MiWiFi-R3L-srv>
 <Zzxuv3FFmCxmTtS-@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zzxuv3FFmCxmTtS-@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 11/19/24 at 11:55am, Ingo Molnar wrote:
> 
> * Baoquan He <bhe@redhat.com> wrote:
> 
> > On 11/18/24 at 09:19am, Tom Lendacky wrote:
> > > On 11/17/24 19:08, Baoquan He wrote:
> > > > Functions memremap_is_setup_data() and early_memremap_is_setup_data()
> > > > share completely the same process and handling, except of the
> > > > different memremap/unmap invocations.
> > > > 
> > > > So add helper __memremap_is_setup_data() to extract the common part,
> > > > parameter 'early' is used to decide what kind of memremap/unmap
> > > > APIs are called. This simplifies codes a lot by removing the duplicated
> > > > codes, and also removes the similar code comment above them.
> > > > 
> > > > And '__ref' is added to __memremap_is_setup_data() to suppress below
> > > > section mismatch warning:
> > > > 
> > > > ARNING: modpost: vmlinux: section mismatch in reference: __memremap_is_setup_data+0x5f (section: .text) ->
> > > > early_memunmap (section: .init.text)
> > > > 
> > > > Signed-off-by: Baoquan He <bhe@redhat.com>
> > > > ---
> > > >  arch/x86/mm/ioremap.c | 108 +++++++++++++++---------------------------
> > > >  1 file changed, 38 insertions(+), 70 deletions(-)
> > > > 
> > > > diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
> > > > index 8d29163568a7..68d78e2b1203 100644
> > > > --- a/arch/x86/mm/ioremap.c
> > > > +++ b/arch/x86/mm/ioremap.c
> > > > @@ -628,12 +628,13 @@ static bool memremap_is_efi_data(resource_size_t phys_addr,
> > > >  	return false;
> > > >  }
> > > >  
> > > > +#define SD_SIZE sizeof(struct setup_data)
> > > 
> > > Nit, I still think you should use "sizeof(*data)" in the code instead of
> > > creating a #define.
> > 
> > Thanks for reviewing, Tom.
> > 
> > Boris suggested this. Both is fine to me. If there is indeed a tiny
> > preference, I would choose SD_SIZE. It's going a bit far, but not too
> > far.
> 
> Yeah, I'd prefer Boris's SD_SIZE suggestion too: while *normally* we'd 
> use the 'sizeof(*data)' pattern, this particular size repeats a number 
> of times and not all contexts are obvious - so abstracting it out into 
> a trivial define looks like the proper cleanup.

Totally agree.

> 
> Maybe such material changes should be done in a separate patch though:
> 
>    x86/ioremap: Introduce helper to implement xxx_is_setup_data()
>    x86/ioremap: Clean up size calculations in xxx_is_setup_data()
> 
> ... or so, where the first patch is a trivial refactoring that keeps 
> the existing patterns - which would make the series easier to review.

OK, will do like this if Tom doesn't oppose it.

During v1, Tom suggested squashing the helper introducing patch and
helper using patch into one patch. I personally prefer splitting code
changes into multiple independent units so that reviewing is focused on
the controversial change, but not the whole big patch including many
controversial points is posted again and again. 

Thanks a lot for careful reviewing and great suggestions.


