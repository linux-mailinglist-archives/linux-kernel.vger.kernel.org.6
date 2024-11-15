Return-Path: <linux-kernel+bounces-411500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3839CFB22
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 00:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C21B81F24654
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 23:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE17C19E98B;
	Fri, 15 Nov 2024 23:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hYfERTga"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF77190661
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 23:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731713137; cv=none; b=i0tQr58Wle6U1G4o9gI20xZKCUwF+n3ja5tVNW4OkUphuEK0LaqmV4rfeNahS05z96SD/megGJgEiKAHmyZQAp7TBB7u2UIHLsIbh+7iJeHui6ihEF3kOyrq9Xpg9ycgY3w6ZQ9ba8VbzTrnVNeHBoJaOp6jYTGrYQmRoC34d8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731713137; c=relaxed/simple;
	bh=jOGikEDxwCZPFPhJzh1spbZ6e1tKLGv6RP/JNo3dHYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pD73Hba2SHFNOT2Pz/nBnvp0BYegsYpw2dCfj3Fxcbm5sss2ae5HUxBX0NWMwvCHqn4OgQeKXCkqdddnUv5Ri5CGsdR7IoEYGk6io7pH6AXCZvRC993HnqTCP27cwk1grWtsSTOy1yHqgYxUqGdbPctX3RgISk3rU6Pit2W+e90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hYfERTga; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731713134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h9n2/xSuMXaPBgmDuhqwxjwGQzNOBLQE9f1CIZ7JNxw=;
	b=hYfERTgaTARrLlWX1tyz+Qop6WwSTXQFtNGoyw0JaSZt2KoXMtJUbHJd/iuSFPGIawTxf3
	T6ufOjK6zCouaH11tqyjSqH3RI9J8+/ulgepBofRQzonhK8WP+HgVbQQ23CgKV9D84jX+L
	tayHsz0yEuDPvIoCBndUx6rL4ERLhJE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-261-8on8kbpEPJ2v4nE9N9jVQw-1; Fri,
 15 Nov 2024 18:25:33 -0500
X-MC-Unique: 8on8kbpEPJ2v4nE9N9jVQw-1
X-Mimecast-MFC-AGG-ID: 8on8kbpEPJ2v4nE9N9jVQw
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A61471956080;
	Fri, 15 Nov 2024 23:25:30 +0000 (UTC)
Received: from localhost (unknown [10.72.113.10])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 57FB31956089;
	Fri, 15 Nov 2024 23:25:28 +0000 (UTC)
Date: Sat, 16 Nov 2024 07:25:24 +0800
From: Baoquan He <bhe@redhat.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-kernel@vger.kernel.org, bp@alien8.de, x86@kernel.org
Subject: Re: [PATCH 1/3] x86/ioremap: introduce helper to check if physical
 address is in setup_data
Message-ID: <ZzfYZLdAKZjUCzml@MiWiFi-R3L-srv>
References: <20241115012131.509226-1-bhe@redhat.com>
 <20241115012131.509226-2-bhe@redhat.com>
 <d6c946f5-8e7c-ca06-ed0a-4d4e8a82d679@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6c946f5-8e7c-ca06-ed0a-4d4e8a82d679@amd.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 11/15/24 at 08:22am, Tom Lendacky wrote:
> On 11/14/24 19:21, Baoquan He wrote:
> > Functions memremap_is_setup_data() and early_memremap_is_setup_data()
> > share completely the same process and handling, except of the
> > different memremap/unmap invocations.
> > 
> > Add helper __memremap_is_setup_data() to extract the common part,
> > parameter 'early' is used to decide what kind of memremap/unmap
> > APIs are called.
> > 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> >  arch/x86/mm/ioremap.c | 81 +++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 81 insertions(+)
> > 
> > diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
> > index 8d29163568a7..5ef6182db630 100644
> > --- a/arch/x86/mm/ioremap.c
> > +++ b/arch/x86/mm/ioremap.c
> > @@ -628,6 +628,87 @@ static bool memremap_is_efi_data(resource_size_t phys_addr,
> >  	return false;
> >  }
> >  
> > +#define SD_SIZE sizeof(struct setup_data)
> > +/*
> > + * Examine the physical address to determine if it is boot data by checking
> > + * it against the boot params setup_data chain.
> > + */
> > +static bool __init __memremap_is_setup_data(resource_size_t phys_addr,
> 
> You should remove the __init for this helper since it is called by a
> function that is outside of __init.

Removing __init for helper will trigger below warning. Then __ref need
be added to helper __memremap_is_setup_data() to suppress it. Maybe the
latter way should be taken since the helper need be called by a normal
function?

WARNING: modpost: vmlinux: section mismatch in reference: __memremap_is_setup_data+0x5f (section: .text) -> early_memunmap (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __memremap_is_setup_data+0x167 (section: .text) -> early_memremap_decrypted (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __memremap_is_setup_data+0x180 (section: .text) -> early_memunmap (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __memremap_is_setup_data+0x1a9 (section: .text) -> early_memunmap (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __memremap_is_setup_data+0x1b4 (section: .text) -> early_memremap_decrypted (section: .init.text)

Thanks
Baoquan


