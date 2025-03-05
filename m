Return-Path: <linux-kernel+bounces-546350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D294A4F987
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53B001892D36
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D09202975;
	Wed,  5 Mar 2025 09:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RTRdKlBO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D13320125B
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 09:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741165660; cv=none; b=DIJYDbZEHIheCeYfF3yNnK/sPtv00SgbXl47QTJ2HOEj2U+tAYeyYaWqP95EH2LLB4hb0uUbi0fRnZ9Uh1yJoTgjUYXEg4oJTTcHZYqBjF4tsG1BZt9eNIWqzSbCQs5et5pm+qAw37l7DPLU0tDgMw3qyt/Gl1sQhSHOygFGOOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741165660; c=relaxed/simple;
	bh=uEYVEqCtoYbzYquK/VaMlg3Ti7944pqijjFq53C1gDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z3babHW9Vp2dX3cfAwnnn1oasGbSrhsO5Mrdv/BCrB/qH8nx+fyYrxo9X4gNI2S2eXFfNcOJiZgPiBbhVoVQjZPM9qjNONoZfo4gfo7t0sadT32T6Z7Xob6a+ToSZ+/ELP+fAVRWIx1U/566E6NTJx6GBFNriF+ezB1LEVRc3kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RTRdKlBO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741165657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uEYVEqCtoYbzYquK/VaMlg3Ti7944pqijjFq53C1gDQ=;
	b=RTRdKlBOGcXlh9JjYYd1zZgfU+RXhBN2Ixr4gzWvRfM0MJSvuFWIiY023cOV3SXmLsEUUY
	xJbW6cbYYeJehcQLlJQXNBAueIlNhYR53QDTZ8u9dDoy/gOlXB4dt9xpfvQZMxKYSURn7E
	8zvXsDPHYpslOhRD9qY+X4u/cVgYbg8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-75fcvS1pN8uOQI6OOApj-w-1; Wed, 05 Mar 2025 04:07:36 -0500
X-MC-Unique: 75fcvS1pN8uOQI6OOApj-w-1
X-Mimecast-MFC-AGG-ID: 75fcvS1pN8uOQI6OOApj-w_1741165655
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ac1e442740cso96273866b.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 01:07:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741165655; x=1741770455;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uEYVEqCtoYbzYquK/VaMlg3Ti7944pqijjFq53C1gDQ=;
        b=YgA8ksS8X0BhoWyRojqKLtnXwXYNI0RSyCCWwdM10GOeM4tysBCZIkEULfcvLKtTD1
         jz7VGz2H0Ch/Xz0xgCmCLdush4hX9VZ7VN/IEjRZfy/DFErOeMNV697ry6jHFOQ0B90+
         V64apRiNED4N78KS96d9RbkSl/kUgrIkco4iOaKGr6URKQ0ZEkp2liJR7tj8pfK4SHRH
         oWCSnSmfBjEYqvofoU4O1gQ1NVBsEeV1DhyBt/S9Bo4lbklV7LqTd4cVmRT/IC1scZSQ
         zkd/geIxg6AoV6qw3z6wQSNNcZ/uYSPqnrfsyVJ+SsL71OrQMFtS8UzPxhHVN4fHtMIE
         hFSw==
X-Forwarded-Encrypted: i=1; AJvYcCXKGwxM4uuK94DNqhQ6nv6qQfs14Uz1NFwQl1/u/GGTT4sLlGbbjH7xHY1eDv1osEQoKw1qSkJ7EzgVRas=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVPIb+fqHGJMamUQ3hhaK0R89IPEbIG4lZCFKdJKcfzIvE1WpE
	yciCcjV00irNFUmxkxsL+lmID9cTkLqMS7tECJYFlWO8/O7BEnH/pm6A/GuH4oUvP1e5p/eD5pq
	mP2ms1OoU4+g8RpOkDXRelrwDEJcdij3JmUaLbfY1PnWHWQjWyOqJy6eMrqvuRg==
X-Gm-Gg: ASbGnct4r7cBdbtTiQUh2oveUY1/Fpa57R0Q24Da3CmqlsjHCk7tbM8dG0V0ItLHZYQ
	IdKUflTvOE8uIz5CEmRedwapavkHpO0lBbWSScT8c0jgdLoSXafioCHE10FH7fzqrIGthvrfaJy
	dpLuUzd5NTZFjLBiRNhQRqgpS5S691Gd3YrWGOdUI1R3OVYwBiXfQb7UD0t1RwZw34Ai89Xp7/P
	Dkqkrz8vSnCTDBL5XuHjSN9YESeP71UeiQmJ61az7US15Kco2z1Oz6NE2/4bk4p5Tu51/GHW/jx
	gjA1BbgI64OYwQZ2E0mbclRpaIBB3W30tGAsxbyTYV8kIzFfJaaFT6oDel7mwGWs
X-Received: by 2002:a17:907:1c18:b0:abf:44b1:22e4 with SMTP id a640c23a62f3a-ac20d8459e6mr251659766b.11.1741165655275;
        Wed, 05 Mar 2025 01:07:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH3mtYAsZxhVAJSSQRaDW6E8YonUSexggQDnhx967E+2X1tR/N3HMP/nk3AgqXd36cQEhZhUw==
X-Received: by 2002:a17:907:1c18:b0:abf:44b1:22e4 with SMTP id a640c23a62f3a-ac20d8459e6mr251655966b.11.1741165654712;
        Wed, 05 Mar 2025 01:07:34 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf7931de88sm476985366b.185.2025.03.05.01.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 01:07:33 -0800 (PST)
Date: Wed, 5 Mar 2025 10:07:03 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, 
	Claudio Carvalho <cclaudio@linux.ibm.com>, Peter Huewe <peterhuewe@gmx.de>, x86@kernel.org, 
	Dov Murik <dovmurik@linux.ibm.com>, linux-coco@lists.linux.dev, 
	Dionna Glaze <dionnaglaze@google.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dave Hansen <dave.hansen@linux.intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC PATCH v2 5/6] tpm: add SNP SVSM vTPM driver
Message-ID: <u3hnfqimgnavrhy4wxa63zorvbjomj5ptoqrn4aqnr5wlnjtxs@xyy6d4merpvy>
References: <20250228170720.144739-1-sgarzare@redhat.com>
 <20250228170720.144739-6-sgarzare@redhat.com>
 <Z8JoMrUm9Dnoqgoi@kernel.org>
 <tpi74sl22zqngutzbqp7ajz7khwom2fgth2n3i77houwdqc3gl@obkhgfcagubh>
 <Z8c4Avw2y7k4JODe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Z8c4Avw2y7k4JODe@kernel.org>

On Tue, Mar 04, 2025 at 07:27:30PM +0200, Jarkko Sakkinen wrote:
>On Mon, Mar 03, 2025 at 05:46:16PM +0100, Stefano Garzarella wrote:
>> On Sat, Mar 01, 2025 at 03:51:46AM +0200, Jarkko Sakkinen wrote:
>> > On Fri, Feb 28, 2025 at 06:07:19PM +0100, Stefano Garzarella wrote:
>> > > Add driver for the vTPM defined by the AMD SVSM spec [1].
>> > >
>> > > The specification defines a protocol that a SEV-SNP guest OS can use to
>> > > discover and talk to a vTPM emulated by the Secure VM Service Module (SVSM)
>> > > in the guest context, but at a more privileged level (VMPL0).
>> > >
>> > > The new tpm-svsm platform driver uses two functions exposed by x86/sev
>> > > to verify that the device is actually emulated by the platform and to
>> > > send commands and receive responses.
>> > >
>> > > The vTPM is emulated through the TCG reference implementation, so this
>> > > driver leverages tpm_tcgsim.h to fill commands and parse responses.
>> >
>> > Why? Please don't.
>>
>> You mean it's better not to have the external header and have all the
>> functions here to prepare commands and parse responses?
>>
>> As I mentioned, I did this because there may be other future drivers that
>> could use it to talk to emulated devices in the same way, that is, through
>> the TCG TPM reference implementation,
>
>Sorry about harsh comment. I think we discussed this (MS simulator
>caused confusion). Anchor this to SVSM spec and we're fine.

Yeah, I think we are now aligned, I will try to fix in the next version!

Thanks,
Stefano


