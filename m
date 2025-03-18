Return-Path: <linux-kernel+bounces-565979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C471A671AC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 072F87AA4AA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 10:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628C5207DE6;
	Tue, 18 Mar 2025 10:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fbnv7ZbE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573692080E3
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 10:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742294660; cv=none; b=iYyJFpQe9fmR3/VgHZRlymdC8lyAdxXxM3L306B7jXrEMF9ysoxDU6vEFOk7gR0cb7+Besu+ROt9DU5F6GVVviO1fmF8ZmG4zGud2K+Zoxo46WFZK7WnpjJBaG8UIoWgGsHNSj5yfvBGNsD8qYoiQMLQTqqdEclXiyaXe4/IdfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742294660; c=relaxed/simple;
	bh=JjVwiG6JTed8Funsj+Yghz5UOx9ruQQVenphykw5+t4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jAAXi2ElDsqz+JNcY8iy5S+ooodLtc2AvXxBwUWWMa5sv+aLFfTSa+jsjOrcNyRDT1R/tYl8Wl4knIm3UVykCKXd0VTlcpW9UqQZkIRz8wZwKN10CVtVPtekZ7+RyzqRjESRE1djnJMS3P7bahtShlvsekKYp8KErRLk/0RJUK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fbnv7ZbE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742294654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vODclRtlESq833QiRMA2SC9kn8teAEC7lQk1RJgpb+0=;
	b=fbnv7ZbETMPyPE7HpDWZwPtJGNFoAe4DEdXsHttDBupJ0RvUjb9IeZxKom5jy8TRtqRsDq
	/ylJ8k0IyeDsTaknupq+Jmd/H0iUQO4xfzbUEsgWlEvaf9U7wYEy7yb0Ig/xBBO9xlBcV2
	mAmTYXGPuzOfQheDcnxWinK9r3A9pj0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-llkvMNf5PsmTSaaZ2GNnIQ-1; Tue, 18 Mar 2025 06:44:12 -0400
X-MC-Unique: llkvMNf5PsmTSaaZ2GNnIQ-1
X-Mimecast-MFC-AGG-ID: llkvMNf5PsmTSaaZ2GNnIQ_1742294651
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43cf172ffe1so27137375e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 03:44:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742294651; x=1742899451;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vODclRtlESq833QiRMA2SC9kn8teAEC7lQk1RJgpb+0=;
        b=brTyyOI5lBbr7o4DQRw+djogAvzZBaRB9lwS1slsQlY3+q9NleqSzPMMe18bcDikkF
         FJdTmqhdMsrbe7/Wrek1uZCf8BhI/gUqToUCK7qeOBiaqMQReGEDZVtXLo/0r8vPMYw2
         y8oXKigu4f89jC69YvQ+mG6SIag2EVnqM9LB/DlWrys7Y2/ZUN2tsWfzxAJ61/WsyLC6
         kulYVCaKmEsFJ3LRmF2gVQv3RLoccQYrPkrni6z+J+NXdsN3OddhXDWm5CRrXJknLuiJ
         ZKeny9EbVRTPEApWHsOvWNarqaY0O5cMrNdZtjAaBHGAVlX9sZTiB5LVKyPND2HKkRlk
         B9UQ==
X-Forwarded-Encrypted: i=1; AJvYcCUa4jORDvkC5R3jiiKWfDROIbGWy6pESiaAx9/Ke6cvBjQnMbbFWisNKhwfIcK3SzdF/9wYO7jFEqyEEaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbGe6Ycf2EGDER/pRZzeZqUfL9EhffROHq1KFxXU7tzmkD2OW7
	GOPhx9lAngsJQGhqIo4CBMj0rXuyxuC0G0C4Bhf6Hq3uCbKGxYC+jFGKZ1Qwhy7rr5evm2y8saU
	s/DGaY62UPLfK/n5Y8NDjDcIXTDdHq3BD2c1Kxbt0oAM5fqPL46NsU8VF03T5jw==
X-Gm-Gg: ASbGncuQC+yNpDfz9mDRvpF2mns5RymPvSBRFRt+IaUihmxaEvHFUszLxFXo7oitwDr
	ilv2I3lwfQGO+nC0PEaDrAtzZLHFHZuLWsy6AKUeC9G3d2igioB5wP8PofWgp+BkksD1RtM5Jo6
	B6u2Du52zScAd9DGxz+h+D3vkdLf+HMXhAXgYKLlq2dUOcN/79+1LRY4kppiuTOwmDRAPnqKlmi
	nPYwxzVk/c/rodP3Fn6VRxyZURczNQ/FF7MBmtiIbTYGXs6u8NQg3+AhLuLbs2exxhkjUSkkLgN
	Vl4q9KCU0ppsiKV3c12slCTOteCt1RQt9T0LLQStwj8asvfUmKDDvIJosH583Om6
X-Received: by 2002:a05:600c:3d14:b0:43c:fffc:7855 with SMTP id 5b1f17b1804b1-43d3b9b5537mr20194555e9.15.1742294651436;
        Tue, 18 Mar 2025 03:44:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGc40ALDk8HYZeNcIG4ZWmui1bzdkvrY09zY+lTByGVYf7UuCwtqoNcke3O+q2K99biFiE4lQ==
X-Received: by 2002:a05:600c:3d14:b0:43c:fffc:7855 with SMTP id 5b1f17b1804b1-43d3b9b5537mr20194255e9.15.1742294650956;
        Tue, 18 Mar 2025 03:44:10 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1fe60951sm130776845e9.26.2025.03.18.03.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 03:44:10 -0700 (PDT)
Date: Tue, 18 Mar 2025 11:44:05 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	x86@kernel.org, linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>, 
	linux-integrity@vger.kernel.org, Dov Murik <dovmurik@linux.ibm.com>, 
	Dionna Glaze <dionnaglaze@google.com>, linux-coco@lists.linux.dev, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, Claudio Carvalho <cclaudio@linux.ibm.com>, 
	Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v3 4/4] x86/sev: register tpm-svsm platform device
Message-ID: <nrn4ur66lz2ocbkkjl2bgiex3xbp552szerfhalsaefunqxf7p@ki7xf66zrf6u>
References: <20250311094225.35129-1-sgarzare@redhat.com>
 <20250311094225.35129-5-sgarzare@redhat.com>
 <7c35f370-f1f2-7100-3b78-b595e977e964@amd.com>
 <Z9gk0jg1JLZY4Fk9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Z9gk0jg1JLZY4Fk9@kernel.org>

On Mon, Mar 17, 2025 at 03:34:10PM +0200, Jarkko Sakkinen wrote:
>On Fri, Mar 14, 2025 at 11:56:31AM -0500, Tom Lendacky wrote:
>> On 3/11/25 04:42, Stefano Garzarella wrote:
>> > SNP platform can provide a vTPM device emulated by SVSM.
>> >
>> > The "tpm-svsm" device can be handled by the platform driver added
>> > by the previous commit in drivers/char/tpm/tpm_svsm.c
>> >
>> > The driver will call snp_svsm_vtpm_probe() to check if SVSM is
>> > present and if it's support the vTPM protocol.
>> >
>> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> > ---
>> >  arch/x86/coco/sev/core.c | 8 ++++++++
>> >  1 file changed, 8 insertions(+)
>> >
>> > diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
>> > index 2166bdff88b7..a2383457889e 100644
>> > --- a/arch/x86/coco/sev/core.c
>> > +++ b/arch/x86/coco/sev/core.c
>> > @@ -2664,6 +2664,11 @@ static struct platform_device sev_guest_device = {
>> >  	.id		= -1,
>> >  };
>> >
>> > +static struct platform_device tpm_svsm_device = {
>> > +	.name		= "tpm-svsm",
>> > +	.id		= -1,
>> > +};
>> > +
>> >  static int __init snp_init_platform_device(void)
>> >  {
>> >  	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
>> > @@ -2672,6 +2677,9 @@ static int __init snp_init_platform_device(void)
>> >  	if (platform_device_register(&sev_guest_device))
>> >  		return -ENODEV;
>> >
>> > +	if (platform_device_register(&tpm_svsm_device))
>> > +		return -ENODEV;
>> > +
>>
>> You could avoid registering the device if an SVSM isn't present. Not sure
>> if that is desirable or not.
>
>Is there any use for the device if an SVSM isn't present? :-)
>
>I'd judge it based on that...

I tried to keep the logic of whether or not the driver is needed all in 
the tpm_svsm_probe()/snp_svsm_vtpm_probe() (where I check for SVSM).
If you prefer to move some pieces here, though, I'm open.

Thanks,
Stefano


