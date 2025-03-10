Return-Path: <linux-kernel+bounces-554174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1479BA593F9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 13:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 791AB16EFF2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 12:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C2721D59F;
	Mon, 10 Mar 2025 12:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EnKdBX0n"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132BC29A2
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 12:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741608857; cv=none; b=RgEzEzbiS9nX2gh36TsUMnamYoa21qtpKsH0dRqpK5wqk03joFYlIHA9YBi7+hfn0Duq9HyO9jSf9dujVdL/ibbYHKqFQ6SmBVrykKdVpss1uyu2YkznOeuSWC8jasXdpyaTcG61DjvjFxIScK1VobtmXD5ar41kNC5TxXLvzYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741608857; c=relaxed/simple;
	bh=nPGOcSA5g/f+JDgzg1rOF9U0pDLMs2VjAObvG6jFU1A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N7EqxOnMLRIkgJqmSMrXw0+hPXE3kAFlemQpBvpI19aQQoa3B8yLp6zpbZFKEk75QsAiXMvU3LOn0URUD7QjJYF/3F0DSpzCug4SLX3sWQDojDaNaSI5ukc+BgSZDe65IHnk5Y3avFGrI899v1VVY4RFRl8LZI8pQrNQj65haQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EnKdBX0n; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741608855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eryV+FUMI6b8m/5Vlnl0pDjjdupScr4/owQrghOZCsc=;
	b=EnKdBX0nRhe+HN/Kg0dx3PxxzMN5TFlDZnjrLx+AHImwQa4eCmxDzOwVmb+fkrOe9GVoP5
	lXloAyhO8Ob9pDSm43C2NTVTJ/EGbAQMwprHAYCekhyNVAQHZH+4VgFF4mru24gHVCriRE
	7NI0Zel0rIaWK14E1Dhf+RrPV6NBa98=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-mpjx6prqODan1wma-FoqBQ-1; Mon, 10 Mar 2025 08:14:13 -0400
X-MC-Unique: mpjx6prqODan1wma-FoqBQ-1
X-Mimecast-MFC-AGG-ID: mpjx6prqODan1wma-FoqBQ_1741608853
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3914bc0cc4aso402356f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 05:14:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741608853; x=1742213653;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eryV+FUMI6b8m/5Vlnl0pDjjdupScr4/owQrghOZCsc=;
        b=qJhGWLTKGEyc0qV4w7/xdVZlUb4q8LtqPilR3lb8ds+UGSZwcfp1aqhJ85gdBq1A0/
         DBitj7v3xldeN/4/ZZAMTshoLKr7BLXw+wonJ7hvtij3fiI8co0qrBFSoDvR/qtzvlGf
         gKh/dMUZgJPYn4wIR7jP4y8TumZnANfsR8ATyYWkQXjxwph+suB8/LadyIzwbChbkFXm
         g7oGQ1U8VMUrAtU2+O8mWaawK9QiYrI2QAZBWHK5Yn9I4A8VqNGja2H7G+YPzowuMiqS
         CgXUl216FQayLoMIZ8S7udcblyJy8mxxlTaREaavajN42PZyfPMzuB2xQKY8ATyo8w/x
         rJEg==
X-Forwarded-Encrypted: i=1; AJvYcCX2QR/DZvNTAf769FGULncAVdDZkafQb2Ica8URLfn6wSnngNxeJcYpvnxvR8AN8J2oCdwF/Pyc9r3OtI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGvBlmGF9wIIC5afiDA9KOuPNak0NrtS1157TPtxP2+KyxSuqy
	+PztLlprxKHzEJPujW743i/VIlF9q9M7FSdM+UYQ8NiEtM5KhMHV5dB/OCAbk2ZbAnR4fn8vuKr
	cd34vztNwJfRUO/IcjYm2grpJISTuDEfpyj/a6O7LPoHIviouPcBwWcYcY7hOKA==
X-Gm-Gg: ASbGncuHvmSi2tWYEwm1giAaFtN40NEXJwWMDaHllYYIzXPzY729J3gGCBEu+nAmkUQ
	C8y5l+TLtK2g68z8xQNMTNBCQaVCRPuw2mGU2gJBlFjfBndmVnVswN8co7OzocMELpr6MbT9jmB
	1TMOZv2vBu9kH6Hw7wPA+LVQPUjlBXHq9jDfYBEVX0LDu9ZkxU+4x1f8ZWsv4mCTsxpj253Yvk1
	UYa4Z5wdGnynsigw925ksGfZ+ao0jGWQW8bKxiQlUOIr//9rpooj8yzJ/qmJ42xGc11lS+bdZLY
	VIesDyavJY3lb7Ed6vyhpqYrgAhFOi1DwHvrVBKTAzR3SB4=
X-Received: by 2002:a5d:64ae:0:b0:391:3cf6:95fd with SMTP id ffacd0b85a97d-3913cf6996amr5557443f8f.30.1741608852697;
        Mon, 10 Mar 2025 05:14:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzaQkC6x6aMdKZuim/zrdQO7lM6MLsCgjcq/5tL+T/E948p79/UPbtXj6c+NA6eVwCb7S11g==
X-Received: by 2002:a5d:64ae:0:b0:391:3cf6:95fd with SMTP id ffacd0b85a97d-3913cf6996amr5557413f8f.30.1741608852334;
        Mon, 10 Mar 2025 05:14:12 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-51-231.web.vodafone.de. [109.42.51.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfba888sm14926378f8f.16.2025.03.10.05.14.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 05:14:10 -0700 (PDT)
Message-ID: <7eed4668-9352-45d6-8116-235c8be43bfa@redhat.com>
Date: Mon, 10 Mar 2025 13:14:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390/uapi: Replace __ASSEMBLY__ with __ASSEMBLER__ in
 uapi headers
To: Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, linux-kernel@vger.kernel.org
References: <20250310102657.54557-1-thuth@redhat.com>
 <20250310104910.27210B18-hca@linux.ibm.com>
 <ab1ab15a-89e1-4c26-b7a2-6147a10a2fca@app.fastmail.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <ab1ab15a-89e1-4c26-b7a2-6147a10a2fca@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/03/2025 12.07, Arnd Bergmann wrote:
> On Mon, Mar 10, 2025, at 11:49, Heiko Carstens wrote:
>> On Mon, Mar 10, 2025 at 11:26:57AM +0100, Thomas Huth wrote:
>>
>> Did this cause any sorts of problems? I can see this pattern all over
>> the place, so why is this now a problem?
>>
>> Also, wouldn't it be better to fix this with an sed statement in
>> scripts/headers_install.sh instead? Otherwise this is going to be a
>> never ending story since those things will be re-introduced all the
>> time.
> 
> It should certainly be done in a consistent way across all
> architectures and architecture-independent headers. I see that
> all uapi headers use __ASSEMBLY__ consistently, while a few non-uapi
> headers use __ASSEMBLER__.
> 
> glibc obviously defines __ASSEMBLY__ whenever it includes one
> of the kernel headers that need this from a .S file. Unless
> there is a known problem with the current code, leaving this
> unchanged is probably the least risky way.

Well, this seems to be constant source of confusion. It got my attention by 
Sean's recent patch for kvm-unit-tests here:

  https://lore.kernel.org/kvm/20250222014526.2302653-1-seanjc@google.com/

Quoting: "This is essentially a "rage" patch after spending
way, way too much time trying to understand why I couldn't include some
__ASSEMBLY__ protected headers in x86 assembly files."

But also if you search the net for this, there are lots of other spots where 
people get it wrong, e.g.:

  https://stackoverflow.com/questions/28924355/gcc-assembler-preprocessor-not-compatible-with-standard-headers
  https://forums.raspberrypi.com/viewtopic.php?p=1652944#p1653834
  https://github.com/riscv-software-src/opensbi/issues/199

So I thought it would be a good idea to standardize on the #define that is 
set by the compiler already. IMHO it would be great to get it replaced in 
the whole kernel, but that's a little bit bold for one patch. So the obvious 
first step towards that direction is to replace it in the uapi header files 
first, where it hopefully will help to reduce the confusion in userspace. 
So unless you really don't like this idea at all, I could continue with the 
uapi headers for the other architectures, too?

  Thomas


