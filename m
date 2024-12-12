Return-Path: <linux-kernel+bounces-443436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE909EF0F8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 17:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 440EB1742FC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 16:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4603A23D42E;
	Thu, 12 Dec 2024 16:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MZvApBMa"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955EF23A584
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 16:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734019944; cv=none; b=et9mhVn3zx+rAbYhadtAsZM2Z6y50vAdLNJdMhkTJJwqHIcX7DHpndag2L16dDYeQJKshAKshOzt0fEbB2M3TVg2MfmRBoZVLU+vvpsHXwfjggOKcZdgm9i+224S80DEOtcyy0ETFp+VzJArM0lvdFe6H5ZwEgA1tQR77Jml/Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734019944; c=relaxed/simple;
	bh=gQeMN/hzMse2RdZ8TAIK8FaDfdRqMn7t4SI9J9weUu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AygxKvaxBkEFjutuy1SjvzcUOegHkcBKIDwQE7J7SUN8Xk0l/4P/GmNfeWUz3YCvmuTqk4J/jSukZqJPFrDzk7wPeJ3aoAkDmBJUtJncaQ2R4TWjGQ6s5HgTXPgpVposqOyy5pTS59C4Da86wgtzV48es+hx0QOr0KnF+HCvz2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MZvApBMa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734019941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n3yKeZBqhENcBvrI8hOmZpd1UmWO6hrsqES60Q4cdw4=;
	b=MZvApBMahV41KA+DfnRjXoncnJpcQKc4S7q7QMzD8hmM+wRb7PwD7V2EGCstS8mmCaHvx/
	bMC50TVDMRcbbek6MsHAwp0w93YBtRY7bSP20VCEsfBurZxlAndFUU3izk9sPlX3a5ENUh
	oP9GIBMF+fdnIgZ0DEN50mf6Seia9l0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-j-n6cl59PSabF_GoyMAfnQ-1; Thu, 12 Dec 2024 11:12:20 -0500
X-MC-Unique: j-n6cl59PSabF_GoyMAfnQ-1
X-Mimecast-MFC-AGG-ID: j-n6cl59PSabF_GoyMAfnQ
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7b6f2515eb3so89629585a.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 08:12:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734019940; x=1734624740;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n3yKeZBqhENcBvrI8hOmZpd1UmWO6hrsqES60Q4cdw4=;
        b=GixrZjxgKhZo80gb2JaoP+Oyb5jpEorj0/j2CrAa3UzH718l3nTVjqPETBLazom7F/
         8H6zXwF5dU020x28MS0uZ1QqDig7JNSYHwAWhrkjNXtNNdHb+kI9Det0ruFEdN9VFDjL
         lh0CnjJ5lLxXKIZypgNoaK0fvHHw/pvbUIrquL3JETuf1QNArLo9yNTevMUtRRbGSOz/
         8QkGkWJ5/4w0wqxWsh5+ElYhm6wOOyUiIUBF83DpmKCRGh+FfaxkDPtJSzxQd6/NPmsd
         Zjctu7uj9yOcSE6sQBd5JZpgOh8pCr2wL0Y+QSkYAYfLjxVhxhaAvn5YIaxL37aypo26
         pPSg==
X-Forwarded-Encrypted: i=1; AJvYcCU59qO3JPhrJHNVsRCWfPiHik9wsGC5+nZiUJj7o/9OVxr7SjHE0m5h1yYWmRx/ovMDQW6ilazP3VbqV84=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFCZroWEVCwymo580QDMHrNcgXBsXjxkXhVHWAprHqRN4LQWuD
	PgAGucldXsqrXuLBq6FKVyuqVCiQmrOOJB750LiKhJ75YSvoFjzlt6j2dBDHLUiYQi2nUURJhD3
	+7HP3himej8icUY9rGC1+xa7GDgh/0C8x5ZghR4jSH9Zgp5WFv0Lj4yytnt6y2Q==
X-Gm-Gg: ASbGncuNwYW6qtnly3QjytWC8a1XX/U34MG3hs7hdUdhx0VwjpgzRt+QfJ+fa9xnxf6
	fyD7Bny8VKDW0Cxh5bESIXwjCFfu4XPR2oaWV15XnAJslv7oFBj9OTxHIa/rzWrAv+mK9r+RwP8
	jEmcuJUexw0WoWiyskejpKZQehTVVdH8poiTIS6wNnREI5VFgfL27iSxeGH1DMipcMfVus+cTvP
	M31f14lztMfhiyAnxylyamCRPUlp3+dOxTRXZGduKlEP/yl9oTg9oJL+Ikl6WZaaRYk8vEz0c0U
	/5gUVavmgqTEXRwMKJryCHmTtX4cWmOl
X-Received: by 2002:a05:620a:2402:b0:7a9:bd5b:eb61 with SMTP id af79cd13be357-7b6f893e1e5mr122009685a.27.1734019939736;
        Thu, 12 Dec 2024 08:12:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHYVaqJoVFY+tmY6ANONIZ3h5S86lA/dyXyVvVbMqYIqUn3UoSvlQ53qJQSvuWrq2qJ25Yn0g==
X-Received: by 2002:a05:620a:2402:b0:7a9:bd5b:eb61 with SMTP id af79cd13be357-7b6f893e1e5mr122006285a.27.1734019939299;
        Thu, 12 Dec 2024 08:12:19 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-185-21.business.telecomitalia.it. [87.12.185.21])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6d990baf2sm365110085a.113.2024.12.12.08.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 08:12:18 -0800 (PST)
Date: Thu, 12 Dec 2024 17:12:05 +0100
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
Message-ID: <qjfj2dkue6r54di4hsrsguzbaxasvpyvv2llcnruhp75s6izc3@7lgj7zmxzsly>
References: <20241210143423.101774-1-sgarzare@redhat.com>
 <20241210143423.101774-2-sgarzare@redhat.com>
 <zzi3fvbo2rnb2d76soseuekwaqe22ifnrhhjplqhvw6x26lbb4@nmcqylrenzyj>
 <b92113a11f121dc4d485b5ba522c8c8c0781d1be.camel@HansenPartnership.com>
 <cnq6nzhvrsas6ud7t4woybktpesepm7a3sq5sd5yldq4hr5kyl@ezm4xi3o7eax>
 <d84a9a960e419cf8cbfd086e8210b6c4a112d04f.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d84a9a960e419cf8cbfd086e8210b6c4a112d04f.camel@HansenPartnership.com>

On Thu, Dec 12, 2024 at 10:41:40AM -0500, James Bottomley wrote:
>On Thu, 2024-12-12 at 16:30 +0100, Stefano Garzarella wrote:
>> On Thu, Dec 12, 2024 at 09:35:46AM -0500, James Bottomley wrote:
>> > On Thu, 2024-12-12 at 10:51 +0100, Stefano Garzarella wrote:
>> > > On Tue, Dec 10, 2024 at 03:34:21PM +0100, Stefano Garzarella
>> > > wrote:
>> > [...]
>> > > > +static int tpm_platform_recv(struct tpm_chip *chip, u8 *buf,
>> > > > size_t len)
>> > > > +{
>> > > > +�������struct tpm_resp *resp = (struct tpm_resp *)buffer;
>> > > > +
>> > > > +�������if (resp->size < 0)
>> > > > +���������������return resp->size;
>> > >
>> > > While reviewing Oliver's work for the driver in edk2[1], I
>> > > noticed that there wasn't this check and asked to add it, but
>> > > talking to him and looking in the code/spec, we realized that
>> > > it's strange that tpm_resp.size field is signed.
>> > >
>> > > �From SVSM spec it looks like it can't be negative:
>> > >
>> > > ���� Table 17: TPM_SEND_COMMAND Response Structure
>> > >
>> > > ���� Byte���� Size������� Meaning
>> > > ���� Offset�� (Bytes)
>> > > ���� 0x000��� 4���������� Response size (in bytes)
>> > > ���� 0x004��� Variable��� Variable Response
>> > >
>> > > And also Coconut SVSM remap it to the `responseSize` of the TCG
>> > > TPM implementation which is unsigned:
>> > >
>> > > ���� LIB_EXPORT void _plat__RunCommand(
>> > > �������� uint32_t������� requestSize,�� // IN: command buffer size
>> > > �������� unsigned char*� request,������ // IN: command buffer
>> > > �������� uint32_t*������ responseSize,� // IN/OUT: response buffer
>> > > size
>> > > �������� unsigned char** response������ // IN/OUT: response buffer
>> > > ���� )
>> > >
>> > > @James, @Claudio, @Tom, should we use u32 for tpm_resp.size?
>> >
>> > The original idea was to allow the protocol to return an error
>> > (like out of memory or something) before the command ever got to
>> > the TPM rather than having to wrap it up in a TPM error.� However,
>> > that's done in the actual return from the SVSM call, which the
>> > sendrecv routine checks, so I agree this can be removed and a u32
>> > done for the length.
>>
>> Thanks for the details!
>> I'll fix it in v2 and put a comment also in the edk2 PR.
>>
>> > Dov did recommend we should check the returned length against the
>> > maximum allowable:
>> >
>> > https://lore.kernel.org/linux-coco/f7d0bd07-ba1b-894e-5e39-15fb1817bc8b@linux.ibm.com/
>>
>> I added in this version the check he suggested:
>>
>> ��������if (resp->size > TPM_PLATFORM_MAX_BUFFER - sizeof(*resp))
>> ����������������return -EINVAL;� // Invalid response from the
>> platform TPM
>>
>> Were you referring to that?
>
>Yes, the theory being that we're required to provide a buffer of this
>length for the response, but if someone can inject a bogus response
>they could induce us to copy beyond the end of the buffer we provided.

I see, but we alread check that `len < resp->size` in
tpm_platform_recv(), so on second glance, for the current
implementation, maybe it's a duplicate check.

This because in tpm_platform_send() we return an error if `len >
TPM_PLATFORM_MAX_BUFFER - sizeof(*req)` and here, in
tpm_platform_recv(), we already return an error if `len < resp->size`.

IIUC buf/len are the same for send() and recv(), so the `resp->size >
TPM_PLATFORM_MAX_BUFFER - sizeof(*resp)` case would already be covered,
right?

Anyway this code will change a bit in v2 if we implement the send_recv() 
op for tpm_class_ops, so I'll be sure to take care of this case.

Thanks,
Stefano


