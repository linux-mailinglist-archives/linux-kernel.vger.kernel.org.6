Return-Path: <linux-kernel+bounces-432561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 774109E4CF5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 05:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDA97188198E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 04:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8499A187FE4;
	Thu,  5 Dec 2024 04:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ioqNXH8l"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A0C4C83
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 04:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733371309; cv=none; b=np+OkWcBcR6YlVVez7vAooXRRRt6MtwxYSwm0aS0+fSeZ1blsZkilmN1rR/kx1vrotCuLleomdeT3ug0OA49drY4v7LnTRF64z5XHt0X1Dh5SWtk222mlJtXyFUvVsT+koAxVoBzQOmfEPdGjufAAGsc0OgcFQIwvxtq3lcRVa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733371309; c=relaxed/simple;
	bh=NJbUNp5KQdiOm4hLOSMPKNgf9oVFfsN/R/DVEqOAt4A=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=OqBg8bOBBMtJ/5TkumuPex4dh31yx4bhhn1i34qLfcEbQtLS3Zbr0b5PuIcRtL5rblmzkv0DUsSJTF77mfZYy6A5Jb1naGRlRra68UubK2X9qTEK2/jdMp7Jr2qjWHW/s5/MYL2W4qtFUs6p3+HBcIGprmnRSLJYH++VXkYNNbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ioqNXH8l; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733371307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l1c0RZJqAUSQmqGb0lWra/RcE0Rl+ptIUXcMQZ+qpsY=;
	b=ioqNXH8lNHlFuRs7sarh1JaqdmzwFgovHQRsdv8HE0EU7ICm6XBKH8eizU2HB5YflrwAtW
	GgM1dIePIOuekZJZhtmShq1t3WGUBJf/UrBAhPXUMRO7rbsIUvjWYLmK4VveBhMs/dA0yo
	0iB7L8+UCRRnSH1r6pDhpMRY0LfB5Z8=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-CkPdfihdMFyR-CE_QDOhDA-1; Wed, 04 Dec 2024 23:01:46 -0500
X-MC-Unique: CkPdfihdMFyR-CE_QDOhDA-1
X-Mimecast-MFC-AGG-ID: CkPdfihdMFyR-CE_QDOhDA
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4667c1c3181so6326901cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 20:01:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733371305; x=1733976105;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l1c0RZJqAUSQmqGb0lWra/RcE0Rl+ptIUXcMQZ+qpsY=;
        b=CxtKIC2GKsrEPsKRBn4h4WuOZkbZhxSHS3YnIG3xsNSu1+CKsxsVN4ZPs72fp3OWDK
         Xk01qluRuAgpK/hYdfZxYEh45GliqrYcSFLG7A3Z3fKM3UV2N7EZ29mLHlronztz2QCf
         1TGjvTZNzRiv6UGhTD+p3KcgLL7dGi+lXslG4tABX3PhjhklGCfxZrrE+TTKzKpihca6
         5W+tNnbwbWRMEXtOMn7N4vnmKmB2UYvwc4MNeNn+inApiUeJMTJyzNJsWLmlM2W4x9mV
         xSTduIl19Nf6HS7bXPXJMPEJlcKymhqRUmctO0yUoKakaKhC/JObstCkpcrRqbB0nSki
         7DGg==
X-Forwarded-Encrypted: i=1; AJvYcCV07FMg5sCS/kM511eSfnZkafFtOE4ip6v45/3IPww4cOfGSiOAwk5QEwqWXjNnAy+lmhA6sbtlgALI5Lo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQgX82kby0L4wuimUqEZ6C1jQF50hbJHEzRmru9UGAWsfgVh0w
	67FKlqIQ7slcx5YUsPYIBnWqQolqog8HjYJ+jP6Xyp/qS4pAtDhUaWnOQDdC0r7KIw3XmkCRmLr
	4R6mn9TfULdATIRbTiGobRUTZhPloPmK4Iq2SYJak4OZIK96pNCS8blW6zf/nmlKIXDzh6A==
X-Gm-Gg: ASbGncvQKG/BsdTVaGf0dYPYqEU0vRhLan8NAN1daoedxCmAfwOtOxxNMs2fGqwFa0R
	F3w2K2v1vLWvfSB1of7qo66JRoRP8uP4gYhBLHu6FL/X40xdrCcL/vGR6cBBrdnj/c46Hh8flE7
	OUPeWdKpfGfLPvqID6hhQV52dH/RdEL3Q4XmxLnyaDQwPdBUSnINRZsVz8UBZpBuwJOVlli7LTT
	qJ01NIiWPTKgNmwzc38lsrsL9DRvz54P7VN4IiI/vxHQrDLhi7k82fd5R20KdEcLrhm+NvfROMJ
	cu1pFcjvbDHvQ3lPUg==
X-Received: by 2002:a05:622a:90d:b0:462:f690:d202 with SMTP id d75a77b69052e-4670c740353mr151953391cf.40.1733371305287;
        Wed, 04 Dec 2024 20:01:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHTO04TadCpLGsnXjyPaAoa0bQwSNmqGFDIihAPgRWooYKIuNHkvO9280L1/e33+/9eM7hb8w==
X-Received: by 2002:a05:622a:90d:b0:462:f690:d202 with SMTP id d75a77b69052e-4670c740353mr151953231cf.40.1733371305002;
        Wed, 04 Dec 2024 20:01:45 -0800 (PST)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467296fcb20sm3542411cf.47.2024.12.04.20.01.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 20:01:44 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <9765a61a-e832-4491-af02-97b8736411ef@redhat.com>
Date: Wed, 4 Dec 2024 23:01:38 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/nmi: Add an emergency handler in nmi_desc & use it
 in nmi_shootdown_cpus()
To: Thomas Gleixner <tglx@linutronix.de>, Waiman Long <llong@redhat.com>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>
References: <20241203150732.182065-1-longman@redhat.com> <87h67jsif0.ffs@tglx>
 <7aa93137-4b5e-474f-a99c-47acffdf71a3@redhat.com> <87zflbqqar.ffs@tglx>
 <59b254dc-acf6-4114-b6b4-a7ae517bfa06@redhat.com>
Content-Language: en-US
In-Reply-To: <59b254dc-acf6-4114-b6b4-a7ae517bfa06@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 12/4/24 2:28 PM, Waiman Long wrote:
>
> On 12/4/24 1:03 PM, Thomas Gleixner wrote:
>> On Wed, Dec 04 2024 at 12:23, Waiman Long wrote:
>>> On 12/4/24 8:10 AM, Thomas Gleixner wrote:
>>>> On Tue, Dec 03 2024 at 10:07, Waiman Long wrote:
>>>>> +    /*
>>>>> +     * Call the emergency handler first, if set
>>>>> +     * Emergency handler is not traced or checked by 
>>>>> nmi_check_duration().
>>>>> +     */
>>>>> +    ehandler = READ_ONCE(desc->emerg_handler);
>>>>> +    if (ehandler)
>>>>> +        handled = ehandler(type, regs);
>>>> Shouldn't this just stop processing right here?
>>> Yes in the case of crash_nmi_callback(). I suppose it is a no-return
>>> call. As the emergency handler is supposed to be a general mechanism in
>>> design, I don't want to make too many assumptions of what will happen
>>> when the handler is invoked.
>> I'm not convinced that this should be used as a general mechanism. It's
>> for emergency situations and that's where it stops. If the thing
>> returns, it's a bug IMO.
>
> OK, I am fine with that. I will put a BUG_ON() after that in the next 
> version.

Actually, crash_nmi_callback() can return in the case of the crashing 
CPUs, though all the other CPUs will not return once called. So I 
believe the current form is correct. I will update the comment to 
reflect that.

Cheers,
Longman


