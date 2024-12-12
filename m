Return-Path: <linux-kernel+bounces-443303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4055B9EEC38
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 16:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAF9B188AC46
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 15:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B630D2210FE;
	Thu, 12 Dec 2024 15:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M4NSWmMV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5A7218EB5
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 15:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734017419; cv=none; b=abqwdHq1Vh2lE+VElB6OCCS9bZU0GJUpCBJuUZIqM9wcKudftyoV5djuxkdjyhoY4jewexrXm5uaJBPGheqpL43+pZb6xd/HugLmoLE8Tuv7gGJ84wiDgnjrTJbaYap5XKOlejc/tyaFQNzCS0/l9/Nk0Fy15VwED8kBwFe4odw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734017419; c=relaxed/simple;
	bh=O5ahhxuiUloPACS05gzUNOEWN3T1mok3ANYk7EW/OLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d0U1GxMf76xsYSeXs3qLRPxUgSxW64PvaPWTkuDfZ+XLFhS+7Zzr7Dak9kM7bpl4O9GuKCNLu0wC7jF7LLfWRdVkZp4Dp2LemZ6geOKrbNfyllNvWOqaP9HL4Fny/FCP+BgG9rgVttYNvrAE8uVqhccKPL3K9ymOWEyZ7AoqeaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M4NSWmMV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734017416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pNvPlu3/tbTEKcryDTMAGFOHz4wBWW7XP10awKbwl0c=;
	b=M4NSWmMVcP+Qy6LmeNdC5u01qwFD13jFUNXX+CFYfxn2fjw+uG1H2Ozrge/eBr8PRJMuWH
	k/V9kcup/wt11QFZ/wV/DGIBiBAl1R+PV7n1RhMm9ld55DqeRdYwUa8riKhS4GCsoOZ5wW
	WcBcjpUSrm4kUGgCwHU0AEs5RDG0aK8=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-iDOo3x4xOKCvebIUJIsDmA-1; Thu, 12 Dec 2024 10:30:15 -0500
X-MC-Unique: iDOo3x4xOKCvebIUJIsDmA-1
X-Mimecast-MFC-AGG-ID: iDOo3x4xOKCvebIUJIsDmA
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4679becb47eso16404011cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 07:30:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734017414; x=1734622214;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pNvPlu3/tbTEKcryDTMAGFOHz4wBWW7XP10awKbwl0c=;
        b=oqB5fB6wz17KbgN58HXVdKxkMEa6k44yPxi4FT1BbYPYRgESFeIMg6OWnS/Dvm4VTf
         HIJWVdD61JTIFb9x+C7lh64TOOMNI5X/iSK4SzrTGr6Cg8hitRRrkKm8X9ZiZUpPQGj6
         Z+nWpjyJ/qhSlQT6oCU4Y0QxvdUwsZe0FBeNpVbKbEGUAlrnMmJwc9wUEpHPNd9LR2Pe
         dzt4knP9+0KzS3HynOsvkk41L3L5fPHthrQwSIDZfdJTlj58J+PX7ZJVaUDOAmTU0Q3b
         Ent6CWcNccvHqAlDGIF9XRKoEcpNGqDFeScZQwGu1wGI5g4Y8D7DR97zMSlcQR2Nq+a0
         tSvQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7vEhqzzNOS4jYfXi3uRHmq75+oW0XEQ7W94HS9QNPTWv82IWOFURoSKAlto77bLNZOos6/u5oyxqn7Nw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBDEiS3J4YDplOQXY5Nd5Buu2BvUP/PoQC4JkW7g7ekvePr7cZ
	o3V/ZRwkH/J9jgqWZ22wrSnLOg0ThGfnaI/SeLUorUWw5yBgNte8eMrI4kOeha2KbUKaWFbT6ru
	a9clexEXc9TEU1ZI/fUiNfWpa4cIL0Dx1VWdVwqijPATymz0nwloEwri0m/8QSg==
X-Gm-Gg: ASbGncv8DlUAdVfxAPj3RT+kUZ/YnimzcClQ1wi2rFh8vC5L4LDyQ8U9hXX73+Ur7yG
	VPXEHfqyce6QIo2NNRpS0c1dUv/SgPITY0EwpfiqhvVFGe2D/AASu1AIH+VIAMndhDHpfQhDJRq
	zCBWLWlWJNbbMt6sNly3PIYuGmjhvFENSB6Uo12itc/5Vtkxme16nx8Cl/94CR5XtD1smMTawc7
	PwtcKsSWtvY5kHkYD9R64Sf/fP6zFmo0q5QHILcqcwAa4On5NsABbIOr6n7Xi7Gr8B95KZLOnOK
	MeEBR6WzDBs3LHyb38MrJzTk5XVn9E4p
X-Received: by 2002:a05:622a:109:b0:466:954e:a89f with SMTP id d75a77b69052e-467a15c5d85mr9981501cf.14.1734017414000;
        Thu, 12 Dec 2024 07:30:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGUqrMzHnYDqYzGLOnDSNbK6UCDbQs0xhbgvHxu32yCmWJ3ltiMe4gnLZlEysVazYeVy4rzFA==
X-Received: by 2002:a05:622a:109:b0:466:954e:a89f with SMTP id d75a77b69052e-467a15c5d85mr9980721cf.14.1734017413364;
        Thu, 12 Dec 2024 07:30:13 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-185-21.business.telecomitalia.it. [87.12.185.21])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4679748dac4sm10045351cf.22.2024.12.12.07.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 07:30:12 -0800 (PST)
Date: Thu, 12 Dec 2024 16:30:06 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Claudio Carvalho <cclaudio@linux.ibm.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, linux-coco@lists.linux.dev, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Peter Huewe <peterhuewe@gmx.de>, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-integrity@vger.kernel.org, x86@kernel.org, 
	Joerg Roedel <jroedel@suse.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Jarkko Sakkinen <jarkko@kernel.org>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Dov Murik <dovmurik@linux.ibm.com>, 
	Oliver Steffen <osteffen@redhat.com>
Subject: Re: [PATCH 1/3] tpm: add generic platform device
Message-ID: <cnq6nzhvrsas6ud7t4woybktpesepm7a3sq5sd5yldq4hr5kyl@ezm4xi3o7eax>
References: <20241210143423.101774-1-sgarzare@redhat.com>
 <20241210143423.101774-2-sgarzare@redhat.com>
 <zzi3fvbo2rnb2d76soseuekwaqe22ifnrhhjplqhvw6x26lbb4@nmcqylrenzyj>
 <b92113a11f121dc4d485b5ba522c8c8c0781d1be.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b92113a11f121dc4d485b5ba522c8c8c0781d1be.camel@HansenPartnership.com>

On Thu, Dec 12, 2024 at 09:35:46AM -0500, James Bottomley wrote:
>On Thu, 2024-12-12 at 10:51 +0100, Stefano Garzarella wrote:
>> On Tue, Dec 10, 2024 at 03:34:21PM +0100, Stefano Garzarella wrote:
>[...]
>> > +static int tpm_platform_recv(struct tpm_chip *chip, u8 *buf,
>> > size_t len)
>> > +{
>> > +       struct tpm_resp *resp = (struct tpm_resp *)buffer;
>> > +
>> > +       if (resp->size < 0)
>> > +               return resp->size;
>>
>> While reviewing Oliver's work for the driver in edk2[1], I noticed
>> that
>> there wasn't this check and asked to add it, but talking to him and
>> looking in the code/spec, we realized that it's strange that
>> tpm_resp.size field is signed.
>>
>>  From SVSM spec it looks like it can't be negative:
>>
>>      Table 17: TPM_SEND_COMMAND Response Structure
>>
>>      Byte     Size        Meaning
>>      Offset   (Bytes)
>>      0x000    4           Response size (in bytes)
>>      0x004    Variable    Variable Response
>>
>> And also Coconut SVSM remap it to the `responseSize` of the TCG TPM
>> implementation which is unsigned:
>>
>>      LIB_EXPORT void _plat__RunCommand(
>>          uint32_t        requestSize,   // IN: command buffer size
>>          unsigned char*  request,       // IN: command buffer
>>          uint32_t*       responseSize,  // IN/OUT: response buffer
>> size
>>          unsigned char** response       // IN/OUT: response buffer
>>      )
>>
>> @James, @Claudio, @Tom, should we use u32 for tpm_resp.size?
>
>The original idea was to allow the protocol to return an error (like
>out of memory or something) before the command ever got to the TPM
>rather than having to wrap it up in a TPM error.  However, that's done
>in the actual return from the SVSM call, which the sendrecv routine
>checks, so I agree this can be removed and a u32 done for the length.

Thanks for the details!
I'll fix it in v2 and put a comment also in the edk2 PR.

>Dov did recommend we should check the returned length against the
>maximum allowable:
>
>https://lore.kernel.org/linux-coco/f7d0bd07-ba1b-894e-5e39-15fb1817bc8b@linux.ibm.com/

I added in this version the check he suggested:

	if (resp->size > TPM_PLATFORM_MAX_BUFFER - sizeof(*resp))
		return -EINVAL;  // Invalid response from the platform TPM

Were you referring to that?

Thanks,
Stefano


