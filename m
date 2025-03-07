Return-Path: <linux-kernel+bounces-551424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFBCA56C44
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0919A3ACA81
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 15:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D253421D3FF;
	Fri,  7 Mar 2025 15:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RF9uQAcS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72F821D010
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 15:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741361882; cv=none; b=dD2sLHJXtXq0KT7v2qTzSGr+H2k/Q0vESIHBFNTTq1rIFeKy+YpNWQo9rFySfFwqdLMgx8zir5nhGtX6uhocESZvHQaI0vk14GJDQxBnNVW1H8/YBRP/hkgvhptrIOf9PR1yOnlw5MlxmW5pbkrdGYbe1WEqN6tDDNBgkbFN8/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741361882; c=relaxed/simple;
	bh=UaKgYKgRNweERNpL0sYd2eYOjEHfRdISZiNE+9EOqdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=orcJkp53+TPtWVLbK3p0e2K+yHV/b5SAn9Dvpe9907vgZ3mOoILA5AT3UZ3+Jiu5z3Hpp0QmxQmMZR8NV4SJhS392mb3nvWcTo/6OF/Bf7den95ITgzXYgHi3dvTK+MwlIJBDrcQDDCOZrZsutkUNCxEFZPKwvddWLOMfkhbAdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RF9uQAcS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741361879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uCEnBg90XzFtM7VUQEX7isG0VF2FTRraT+UhcAxtG0U=;
	b=RF9uQAcSKZxf85Z6ImZCGnjT033M2BIC6Hy1Dq2NVfkylAuGtIF3NUdKXiz2H7U5IoqFef
	pvgRXUfftdl1rad5FDe2OtdEQ8zqXQF50CwS+w74CsOlZMTTcvw2mqZ84USIn7pDy69Fln
	IDVJwqFJ6Gu0FqtF9wxycbO52bHrBek=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-7LMlY-cRM9uAUGloWRfU_g-1; Fri, 07 Mar 2025 10:37:58 -0500
X-MC-Unique: 7LMlY-cRM9uAUGloWRfU_g-1
X-Mimecast-MFC-AGG-ID: 7LMlY-cRM9uAUGloWRfU_g_1741361877
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-39131851046so457398f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 07:37:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741361877; x=1741966677;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uCEnBg90XzFtM7VUQEX7isG0VF2FTRraT+UhcAxtG0U=;
        b=hO1yE6ImTzeNWQnm85FXV3AY4i+QcoKSyEv9qYbrscYj6z+RPREHfuEm0U8oFPJKuE
         x0SP2YMvlf41ib+Qk0zE8pHiphktUFFyShJ0PY5b3clkFB3EKfKTT6ZW6xi5u9bJ9zXm
         39VT3f7c0if/BAVE67mFON0bIMQxgYjF+RAr9RsQpHWDAZ/CvzVU4lRf+8T+WISomPRp
         aEU5BANmaAujZyQ2DsJoGcJBjTkGwiBZedFfiYPuGarYwRkGO3VzgfmMz6bbBn0iIWFt
         LvY3UkilKG7Qt2wGvLsThnowuOAn5e1zEmpF7xMGaaObiin4r+pW7R9vRtV6TCewOp/y
         clYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUONKvyWRIOYvzazwaU7tF3Od7md43ramuQswmQd1MQUAUYpnC8prPSk5EAntGiYPhxuaF+5Ij/t25ZRgc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWeQH7zFZ66L+DLnNcoVqIsPqvoGUkpGx7rYszvsUMpMkpu/gH
	plrtASW91iy4jTN0z8yM3A4nQeFCG1fdB89LsiEi2CrbgNEyWPOwF10IME582kRdLxP2gfZr9sQ
	4r6NsnhkdPrcXuk6pkIJjthgQvu7MAoc7A9u0I4R/zPafEAy5CguJjiiKfUvb2g==
X-Gm-Gg: ASbGnctEDln4HM2m7rBsTLuHqb+LMnawYfePo+oMKq/oWMS38OVUCp3EWWmYeuLB9b1
	sDVxwRz97CqawrBBV4vW9AGOcwD5OUt9BHP9WOBGssGecCBStRlJ91gpXzhlHG5gk0YOdfDtjIY
	ZI51HImNtpI2a4ypS7RhJfKuplmT1pp5Qg+KUEHKDfQdDy23GcZeWV1PNXPDmChTQZjnEi0357I
	N90eN5LU1SazuPZGhhQSfS/TAKiMYTNxyZn4RMHUaJwlRyxMmXCMZdGG+psPt95Z0rzwfkfBNyq
	nELBngBr8Gf2GjHtPmsqsrUkoiJrtzjyRC2lonXHs5PcY957zVBr2sCy/ED9YkKU
X-Received: by 2002:a05:6000:1fa1:b0:390:d6b0:b89 with SMTP id ffacd0b85a97d-39132da91b9mr2467064f8f.50.1741361876991;
        Fri, 07 Mar 2025 07:37:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGIJMvm5xV/SzBS3SsEtyfC9KwyMaXW507M9hj1kZ3KsK4zYX0qBeDOTEmMi3doGmekM7Y1Mg==
X-Received: by 2002:a05:6000:1fa1:b0:390:d6b0:b89 with SMTP id ffacd0b85a97d-39132da91b9mr2467028f8f.50.1741361876487;
        Fri, 07 Mar 2025 07:37:56 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bdd9470e2sm54526185e9.33.2025.03.07.07.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 07:37:56 -0800 (PST)
Date: Fri, 7 Mar 2025 16:37:53 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Thomas Gleixner <tglx@linutronix.de>, 
	Claudio Carvalho <cclaudio@linux.ibm.com>, Peter Huewe <peterhuewe@gmx.de>, x86@kernel.org, 
	Dov Murik <dovmurik@linux.ibm.com>, linux-coco@lists.linux.dev, 
	Dionna Glaze <dionnaglaze@google.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>, linux-integrity@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC PATCH v2 3/6] tpm: add send_recv() ops in tpm_class_ops
Message-ID: <tjo335oq47ogyobxzlopuxwqzto6gzm4gezqs6umphndehothu@5u4hqukop36i>
References: <20250228170720.144739-1-sgarzare@redhat.com>
 <20250228170720.144739-4-sgarzare@redhat.com>
 <Z8Jmps6AF_geaHUw@kernel.org>
 <3p5erujbhxw7ozdnfpmresv3dqdh2xszolv6mh4khkagoy3wit@ow5qht4keh4h>
 <0e156883acf95d31b9358831550d6d675e3ce4ff.camel@kernel.org>
 <Z8dg46Mj81Q9Z0WV@kernel.org>
 <jkr5z4thb55gs2jcmtcfipgg6p7z6ikhr6etd6l3nqpf723hf7@3fns3z5cjqk4>
 <Z8oehuPVMXbgjAxz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Z8oehuPVMXbgjAxz@kernel.org>

On Fri, Mar 07, 2025 at 12:15:34AM +0200, Jarkko Sakkinen wrote:
>On Wed, Mar 05, 2025 at 10:04:25AM +0100, Stefano Garzarella wrote:
>> On Tue, Mar 04, 2025 at 10:21:55PM +0200, Jarkko Sakkinen wrote:
>> > On Tue, Mar 04, 2025 at 06:56:02PM +0200, Jarkko Sakkinen wrote:
>> > > On Mon, 2025-03-03 at 17:21 +0100, Stefano Garzarella wrote:
>> > > > On Sat, Mar 01, 2025 at 03:45:10AM +0200, Jarkko Sakkinen wrote:
>> > > > > On Fri, Feb 28, 2025 at 06:07:17PM +0100, Stefano Garzarella wrote:
>> > > > > > +	int (*send_recv)(struct tpm_chip *chip, u8 *buf, size_t
>> > > > > > buf_len,
>> > > > > > +			 size_t to_send);
>> > > > >
>> > > > > Please describe the meaning and purpose of to_send.
>> > > >
>> > > > Sure, I'll add in the commit description.
>> > >
>> > > It's always a command, right? So better be more concerete than
>> > > "to_send", e.g. "cmd_len".
>>
>> Right!
>>
>> > >
>> > > I'd do instead:
>> > >
>> > > if (!chip->send)
>> > > 	goto out_recv;
>> > >
>> > > And change recv into:
>> > >
>> > > int (*recv)(struct tpm_chip *chip, u8 *buf, size_t buf_len,
>> > > 	    cmd_len);
>> >
>> > I think I went here over the top, and *if* we need a new callback
>> > putting send_recv would be fine. Only thing I'd take from this is to
>> > rename to_len as cmd_len.
>>
>> Got it.
>>
>> >
>> > However, I don't think there are strong enough reasons to add complexity
>> > to the callback interface with the basis of this single driver. You
>> > should deal with this internally inside the driver instead.
>> >
>> > So do something along the lines of, e.g.:
>> >
>> > 1. Create dummy send() copying the command to internal
>> >   buffer.
>> > 2. Create ->status() returning zero, and set req_complete_mask and
>> >   req_complete_val to zero.
>> > 3. Performan transaction in recv().
>> >
>> > How you split send_recv() between send() and recv() is up to you. This
>> > was merely showing that we don't need send_recv() desperately.
>>
>> We did something similar in v1 [1], but instead of your point 2, we just set
>> `chip->flags |= TPM_CHIP_FLAG_IRQ;` in the probe() after we allocated the
>> chip.
>>
>> Jason suggested the send_recv() ops [2], which I liked, but if you prefer to
>> avoid that, I can restore what we did in v1 and replace the
>> TPM_CHIP_FLAG_IRQ hack with your point 2 (or use TPM_CHIP_FLAG_IRQ if you
>> think it is fine).
>>
>> @Jarkko, @Jason, I don't have a strong preference about it, so your choice
>> :-)
>
>I'd say, unless you have actual identified blocker, please go with
>a driver where the complexity is managed within the driver.

Yep, got it ;-)

Thanks,
Stefano


