Return-Path: <linux-kernel+bounces-304091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2851F961A14
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 00:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AA9D1C22A41
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 22:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34FB41D4157;
	Tue, 27 Aug 2024 22:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J1yK5dMk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939C8176AD8
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 22:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724798418; cv=none; b=CDGEpjBVmX1Bm+1SXJGN0uBqKUXaitFhB64zZCvfVcdHCwPvDVaWi52Rzq0MRsavYs1+n4r5Cei9BNsuxdHEJAd/TKtkYrCPj1IdQEGOwciVSeN0OzofiGV43B0XAkbs1kBUQKJnO1EnLo5HIWM0KA16TVYhRvYQSIWF3qNEyn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724798418; c=relaxed/simple;
	bh=vhd/bLBfV7lj2HbUYcsFetANlUpgvKny5CC1ndgfo9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l9q0R/wMp6L5I41d/UTxNuMAyiUcSAkRE0Z/9X6YhzB0u5nqqF+Atpcuvez2ZhDRAqbAYOYREoNfFM6xdJAoo3UPsPlETatxS6A8jIo3aVDVWvTtLTHSsrm8la4qfc9P1Dps4aP6xgSO3lj7oNX9caa2n3t5GTnoMRS93l/3XN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J1yK5dMk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724798415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NmdBAM2JtkvTbDIIpL2at1ANoYfOw4zWq0b3hsBM2zc=;
	b=J1yK5dMkSF0N8Yy2bFfPESNF9RtmiPcPGNTiPpaZbb0NrB8Bq+GUs5g/UZtln3XAA1H6jY
	7KUaSjsn7T1kl+NTiurPPB89ILywOQ2aKTp2ZSaFyiJUe+1akDCDPG+2HTQV3rN6KQ50j4
	48WzQS5DBFp6mMPQw6lFdk2+77kcF7I=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-122-9FifvTB6P1S61EsS22p3Ag-1; Tue,
 27 Aug 2024 18:40:09 -0400
X-MC-Unique: 9FifvTB6P1S61EsS22p3Ag-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 813EC19560A2;
	Tue, 27 Aug 2024 22:40:08 +0000 (UTC)
Received: from localhost (unknown [10.72.112.42])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A5F6C1956054;
	Tue, 27 Aug 2024 22:40:06 +0000 (UTC)
Date: Wed, 28 Aug 2024 06:40:02 +0800
From: Baoquan He <bhe@redhat.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-kernel@vger.kernel.org, noodles@fb.com, x86@kernel.org,
	lijiang@redhat.com, dyoung@redhat.com, kexec@lists.infradead.org
Subject: Re: [PATCH] x86/mm/sme: fix the kdump kernel breakage on SME system
 when CONFIG_IMA_KEXEC=y
Message-ID: <Zs5VwrKVetWFkYmR@MiWiFi-R3L-srv>
References: <20240826024457.22423-1-bhe@redhat.com>
 <35e40987-1541-cbbe-6b16-1ddadc2c4c35@amd.com>
 <Zs1FrZVuZK14Je7z@MiWiFi-R3L-srv>
 <be6e5ab6-8b43-1a3f-39a6-b4aa5e0523ac@amd.com>
 <ac929075-27a3-8cbd-5ffd-966ea3e82697@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac929075-27a3-8cbd-5ffd-966ea3e82697@amd.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 08/27/24 at 09:00am, Tom Lendacky wrote:
> On 8/27/24 08:52, Tom Lendacky wrote:
> > On 8/26/24 22:19, Baoquan He wrote:
> >> On 08/26/24 at 09:24am, Tom Lendacky wrote:
> >>> On 8/25/24 21:44, Baoquan He wrote:
> >>>> Recently, it's reported that kdump kernel is broken during bootup on
> >>>> SME system when CONFIG_IMA_KEXEC=y. When debugging, I noticed this
> >>>> can be traced back to commit ("b69a2afd5afc x86/kexec: Carry forward
> >>>> IMA measurement log on kexec"). Just nobody ever tested it on SME
> >>>> system when enabling CONFIG_IMA_KEXEC.
> >>>>
> >>>>
> >>>> Here fix the code bug to make kexec/kdump kernel boot up successfully.
> >>>>
> >>>> Fixes: 8f716c9b5feb ("x86/mm: Add support to access boot related data in the clear")
> >>>
> >>> The check that was modified was added by:
> >>> 	b3c72fc9a78e ("x86/boot: Introduce setup_indirect")
> >>>
> >>> The SETUP_INDIRECT patches seem to be the issue here.
> >>
> >> Hmm, I didn't check it carefully, thanks for addding this info. While
> >> after checking commit b3c72fc9a78e, I feel the adding code was trying to
> >> fix your original early_memremap_is_setup_data(). Even though
> >> SETUP_INDIRECT type of setup_data has been added, the original
> >> early_memremap_is_setup_data() only check the starting address and
> >> the content of struct setup_data, that's obviously wrong.
> > 
> > IIRC, when this function was created, the value of "len" in setup_data
> > included the length of "data", so the calculation was correct. Everything
> > was contiguous in a setup_data element.
> > 
> >>
> >> arch/x86/include/uapi/asm/setup_data.h:
> >> /* extensible setup data list node */
> >> struct setup_data {
> >>         __u64 next;
> >>         __u32 type;
> >>         __u32 len;
> >>         __u8 data[];
> >> };
> >>
> >> As you can see, the zero-length will embed the carried data which is
> >> actually expected and adjacent to its carrier, the struct setup_data.
> > 
> > Right, and "len" is the length of that data. So paddr + len goes to the
> > end of the overall setup_data.
> 
> Ah, I see what you're saying. "len" doesn't include the size of the
> setup_data structure, only the data. If so, then, yes, adding a sizeof()
> to the calculation in the if statement is correct.

Exactly. That could confuse people sometime.


