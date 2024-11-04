Return-Path: <linux-kernel+bounces-394557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6919BB120
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 11:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4BA32841BC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 10:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CE31B2187;
	Mon,  4 Nov 2024 10:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JvtdmwST"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF4B1AA78E
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 10:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730716257; cv=none; b=a0TgMDi+7s+EaT0OhF+kdDg/xJ5ynLf9YXSMX/SsFqXt8s/lghcqfVVm7uFxD+xCa0WYZuFe5EWZu1hZPHAzgKxy5irbFR3aDO2m7TUHJrChzTXp3nXh7EyXOEtAw4CPtLWFgXp2505r23NsiKrYMr1tHJdDeVu9db4+Xwb2Vb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730716257; c=relaxed/simple;
	bh=I395zEKb8Bev9f/3HX43LehcL9J13vNgFXO6d9YNxC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZWUCChOEPoKqQT/9s9zEbghTGLDaz1su1iNoUAC+XtjgRio1LUldVyt/P5K3X0/vvWg1x30PX5Qs5NGhK7EAlowGo09dEjUIjWsDfnTR2IRWWPKo7Fxvwc8ksEIMA2mc29+7drlGw+ZBC40c/n6YP75tQ+0iavu+hwwangr1aIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JvtdmwST; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730716255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3eJy5WNiwFRVMqcxFsMidLua/jpD3sD4ZFQw/Wge0zg=;
	b=JvtdmwSTIEEL+gkl9KX36m31EEu29z0B13ud+V/QwOFnzNhq8iI8JkErWLaG3+WcBLyp4D
	snn4Y6sHksqh1kqbycUoQQlukhx5AqET2BguCXs+aq0NyYk1e018/9n+oq3craJrs0Rh1N
	4h81JXJX5X91Ksk1uw6ryUj2fpekdPk=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-mpuiu5-gPIS-xivMUxrd-g-1; Mon, 04 Nov 2024 05:30:53 -0500
X-MC-Unique: mpuiu5-gPIS-xivMUxrd-g-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a9a194d672bso307712566b.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 02:30:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730716252; x=1731321052;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3eJy5WNiwFRVMqcxFsMidLua/jpD3sD4ZFQw/Wge0zg=;
        b=iAID1gLsvKV7dPZgVR7bT79i07WMg/t0eg91atbs9r3pYG/tDykNtnde/bBHu7/SRZ
         Mp+SMPtMZLqvKNN2N4zG9LhBUfr+ffE7qKyGnzYVBjenbMuS6rZ/dcF2DxYeTf7H1Jqt
         oYqE5tNKLmV1ovdTXl2Q8pN9AtcThCdk3qUMtaMlycTFrv9KWbaE79uQ5MonWdo8b5bJ
         dxUO58l5xlfca+aGrZ4VuZUyhySDVzConTLmLRiL1PqPru+jC3ALgPRJXFmwmXzDcx+T
         eovbw5U0bIlSyx+v0D+Wxu1UkD3Y4N1Ss7LFNthoUQ2mT56tB47ZmuY2aq6O9981iSSA
         wbHw==
X-Forwarded-Encrypted: i=1; AJvYcCVbiVDJESXySyR7Q0ktQpC+x7gl9hrF6Q+uSJUVINy/9/+uJM4GU5K5Fbrq1d8W1edLJmnDdymfXwdq0iA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiqKjaTVWRSuKZ9BiD9jI+r33L1De5mrfGniIVAWFHsgFcgGvv
	K5tN7UG7rRge349J260CM6qc4NQ6SYiD52nwy7Ymlu6u8SCpCovyJ8ox+FoRRoW2tif8A26+Xnx
	mUBojAqvq6EuU0eEf7QwY2RqngXb/8stOBKrqriS4v7S7fLvS1ABUQ0A/9dEz+SWBXbfI3Q==
X-Received: by 2002:a17:907:1c02:b0:a99:a9b6:2eb6 with SMTP id a640c23a62f3a-a9e652c179emr1193849166b.0.1730716252199;
        Mon, 04 Nov 2024 02:30:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHoQpPCpx3YecoTHWC0P3yZ07ffXbK9Wd1bdfoDP5+ZNFBDPgR51GTmMRuTd96DXek9PCnDWQ==
X-Received: by 2002:a17:907:1c02:b0:a99:a9b6:2eb6 with SMTP id a640c23a62f3a-a9e652c179emr1193845366b.0.1730716251575;
        Mon, 04 Nov 2024 02:30:51 -0800 (PST)
Received: from sgarzare-redhat ([193.207.102.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e564c53d6sm536943466b.68.2024.11.04.02.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 02:30:50 -0800 (PST)
Date: Mon, 4 Nov 2024 11:30:45 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mjrosato@linux.ibm.com
Subject: Re: [PATCH v4 2/2] vsock/test: fix parameter types in
 SO_VM_SOCKETS_* calls
Message-ID: <m3yaa3o6gknyk27w6enfyp4xs76yn6dyawxaolafvf3r6fffa4@rjbfmbxmc26f>
References: <20241029144954.285279-1-kshk@linux.ibm.com>
 <20241029144954.285279-3-kshk@linux.ibm.com>
 <7o2b3ggh7ojcoiyh5dcgu5y6436tqjarvmvavxmbm2id3fggdu@46rhdjnyqdpr>
 <9accb7aa-d440-40dd-aee9-10b334b0a087@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <9accb7aa-d440-40dd-aee9-10b334b0a087@linux.ibm.com>

On Thu, Oct 31, 2024 at 11:04:06AM -0500, Konstantin Shkolnyy wrote:
>On 10/31/2024 09:16, Stefano Garzarella wrote:
>>On Tue, Oct 29, 2024 at 09:49:54AM -0500, Konstantin Shkolnyy wrote:
>>>Change parameters of SO_VM_SOCKETS_* to uint64_t so that they are always
>>
>>In include/uapi/linux/vm_sockets.h we talk about "unsigned long long",
>>but in the kernel code we use u64. IIUC "unsigned long long" should 
>>be u64 on every architecture, at least till we will have some 
>>128-bit cpu, right?
>
>I'm not sure what "unsigned long long" would be on a 128-bit machine.
>
>>What about using `unsigned long long` as documented in the vm_sockets.h?
>
>I use uint64_t because the kernel uses u64. I think, this way the code
>isn't vulnerable to potential variability of "unsigned long long".

IMHO the test should look more at UAPI than implementation.
Since we document to use "unsigned long long" I think we should use that 
in the test to check that our implementation behaves well with what we 
suggest the user to do.

>If we change to "unsigned long long" should we also change the kernel
>to "unsigned long long"?
>

For now, it should not change much to use u64 or unsigned long long, but 
I agree that it would be better to change it. I would do it in a 
separate series, though.

Thanks,
Stefano


