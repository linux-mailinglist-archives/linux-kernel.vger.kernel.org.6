Return-Path: <linux-kernel+bounces-570945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1643A6B68E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 10:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FC3F3BD081
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 09:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A711F099D;
	Fri, 21 Mar 2025 09:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a5Qk9SkZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AE01F03D8
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 09:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742547691; cv=none; b=Pq316G9QRIyjP0ORF3y1JGQXbcSyxI4RnPQ7wr2emcHH2lCr8Wkqa5xWgaXFOSR0a6L43+2B/wZKef7Vmvre5EbbbiFQly9wiIeL6te/2dTWs6JbC/XfHWkYpCl9kt4ovz1aSXVfmUk4QlsKw1vKEkmRcJr3DnjUyZFjNZae8qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742547691; c=relaxed/simple;
	bh=sD61hq3NbhxezVFYNQMHc6yPU40zBPjZnQBfIAHwJ6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UPLTMli0GU2edugRHl4KG70Aaj87iVNzYki7gBcz8Uk2pJlxuw3et16G8PVMRr+4UZ0MvoDeun8YdPPBqhORCLT3sEIr/aKoY6BIsQeWDyQSDoi1KlkqycWbLMT64iczCHjNbCuy0eSO9C9SepMudMiDlgvJ8TCup4xFiQ4WCus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a5Qk9SkZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742547689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FmxTpqzZ0HZCDGZEFV/pcObjt3lzP/3kzdelw6nLCTI=;
	b=a5Qk9SkZFL6BlvIyxUOgCwcGK4038B4aAmSruYiKhy0ScX/6mTH9u06xDCgVMOH2EdWdQf
	evpTSrqdX1qu2mCR5g2NqfDm4kmobPxHjyN4zB4ZsXdAg2B9la/7odr+S0ZSescv9DW59o
	B33R8rbYwwzD/F8zUjX4BuHVsWsE81s=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-_gC0E8VzOQqZdcv26D4nyg-1; Fri, 21 Mar 2025 05:01:24 -0400
X-MC-Unique: _gC0E8VzOQqZdcv26D4nyg-1
X-Mimecast-MFC-AGG-ID: _gC0E8VzOQqZdcv26D4nyg_1742547683
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ac28f255a36so139185266b.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 02:01:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742547683; x=1743152483;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FmxTpqzZ0HZCDGZEFV/pcObjt3lzP/3kzdelw6nLCTI=;
        b=Brb4DmqbS0f6zn73rurt+4TiT0HIKxAxWDCO7Yw5nUlu3moo7R57T6MMpHn/zeRY5y
         FUVQOKRtiiqx7nfOx9MIWcFCqLOGzFM2qCmzdRkF+cRkyJgLRyygi8w4iZffQBH8wQmk
         2MgXWc/pxuu49OfzaffbLEM6noYVCtpEVoLkt7zkp8EjNKRrbGLNt5M8Wa+si2QtuwWO
         w8dW9F64N+vtWpyXlfUXvqROn4YxlwiHmsjTAsFlRkpE5vS1bQaxvItB26yOdQ6hLmbG
         C5vl6TB7zzQhniCaYMEKDy6VGOpa5aRgQE5WavBADlgDsLNhENk/g77JkTBinDftK0yH
         UFMw==
X-Forwarded-Encrypted: i=1; AJvYcCWP6Qmz/6mbn3uyzTlH7mwhULX2xX9dknRcXe1BYoSDXKUQpoe/RaZVgjopYY37cTaKAnCaEub+FxujES0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPLR0Ko2s/OzD5V+oZF6C6Z4zZo3Uu1s8kVJFrUHQKfAjK1DC9
	AdcuygJouwhRIIJ/MutdCtCkWb7f6xKPBVtOhOmeIciRsEjFxuPrZee9gMqmUjFzzRWV0A7J89A
	sgNStnwgN1MQjiAgWTuH251KUgVJw59YDLZzUYv02TCKFje/M9Y//gMdgJZsLFw==
X-Gm-Gg: ASbGncuAET5QToCwETUr2eEzfiPaFRyusP7VpAbblt1jn82aTwAuNEIJXE9EO3/zq7G
	4mW2VU+YZ4r9Ve+9NqVBnRa59zSc4X9xSBgykqBIRhp1wCM3jX5/Uduw9zbco44aDxhmaYy1TD7
	AJGM9d7vW5grUtMISP/Nx+H3ugMvmAncbb4GgARUx0NcsxLNYNnRJ58T7haZ+j07X2wSbHgH1Uz
	qkqjKkVG90UXTsMz92O68cppOI6Hl2cmARBE+hk9wqWC3wqG61Jfbps3ZVuzQUvAnMVvDjy9gnr
	2S7EoDlPXW+KjymIjQFG8qJGYBmuSeSqWSvtT5bqYejupuKLbg/9CRXCK8i6qRKL
X-Received: by 2002:a17:907:971e:b0:ac2:622f:39c1 with SMTP id a640c23a62f3a-ac3f20f3e88mr195017166b.22.1742547683215;
        Fri, 21 Mar 2025 02:01:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWCLFs66okYwfxdtv5GcgcdWwR8ZJt//AkHzaDeJko0ra/kue35fF/YS12dNXFy2WPXsVuiQ==
X-Received: by 2002:a17:907:971e:b0:ac2:622f:39c1 with SMTP id a640c23a62f3a-ac3f20f3e88mr195011766b.22.1742547682576;
        Fri, 21 Mar 2025 02:01:22 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-55.business.telecomitalia.it. [87.12.25.55])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef8e50edsm114444066b.52.2025.03.21.02.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 02:01:21 -0700 (PDT)
Date: Fri, 21 Mar 2025 10:01:17 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	x86@kernel.org, linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, 
	Dov Murik <dovmurik@linux.ibm.com>, Dionna Glaze <dionnaglaze@google.com>, 
	linux-coco@lists.linux.dev, James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Claudio Carvalho <cclaudio@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v3 1/4] x86/sev: add SVSM vTPM probe/send_command
 functions
Message-ID: <rspkz663fg7i7jomvg5ehv3ldr6ayehttb7vgwwzsfsxafzb5y@uhqcadvsmw6f>
References: <20250311094225.35129-1-sgarzare@redhat.com>
 <20250311094225.35129-2-sgarzare@redhat.com>
 <d7e5a1d2-5fcc-bf7f-a67d-7871a1627c98@amd.com>
 <Z9glWp6U6vyEmKQa@kernel.org>
 <7kuhiyy7gj4py323g5n2vy3ddlg666zwhtx3mjcklebgtlstdc@xgdyeecifwei>
 <Z9wuLVeP726Cssqp@kernel.org>
 <20250320171619.GOZ9xNY4W54avW2a-u@fat_crate.local>
 <Z9xQw8QpRKk26G6R@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Z9xQw8QpRKk26G6R@kernel.org>

On Thu, Mar 20, 2025 at 07:30:43PM +0200, Jarkko Sakkinen wrote:
>On Thu, Mar 20, 2025 at 06:16:19PM +0100, Borislav Petkov wrote:
>> On Thu, Mar 20, 2025 at 05:03:09PM +0200, Jarkko Sakkinen wrote:
>> > > I can do that, I slightly prefer BIT_ULL() macro, but I don't have a strong
>> > > opinion on my side.
>> > > @Borislav since you suggested it, WDYT?
>> >
>> > Either goes for me. Sorry for nitpicking that :-) The first comment
>> > stil applies.
>>
>> Bit 8 is a lot better than 0x100.
>>
>> Let's give a better example:
>>
>> 0x0000000008000000
>>
>> or
>>
>> BIT_ULL(27)
>>
>> :-)
>
>Sure, I'm fine with using BIT_ULL() :-)

Yeah, we all agree :-)

>
>>
>> While I'm here: I'm guessing I'll route patches 1 and 4 through tip once
>> they're ready to go and give Jarkko an immutable branch he can base the other
>> two ontop.
>>
>> Agreed?
>
>Works for me.

Just a note, patch 2 adds `include/linux/svsm_vtpm.h`, that file is 
basically a translation of the AMD SVSM specification into structures 
and functions used to communicate with SVSM in the way it is defined by 
the specification.

I realized that the file does not fall under any section of MAINTAINERS.
How do you suggest we proceed?

Should we create an SVSM section to maintain it, including the TPM 
driver and future other drivers,etc.?

Or include it in other sections? Which one in this case?

I'm willing to help both as a sub-maintainer and reviewer of course, but 
I would like your advice.

Thanks,
Stefano


