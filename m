Return-Path: <linux-kernel+bounces-370506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DAB9A2DC0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 21:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F276F28423E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 19:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C879E227389;
	Thu, 17 Oct 2024 19:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vax/JZfC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F9D21D2AF
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 19:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729193263; cv=none; b=gT0FF9lPJcICZw04H4lZ16UoIOaEN9zu/zO7BNmlQ3l7NE11b97E3HWlAjeQH5ss6arpVPUhglQwGTdQprMKleBkddduZUUd+1qZrqToiv+3p+e4trM3GZUAb2caGqpYg0iQsaywnFQxWGcuDKOjxZ7k9AwRG0Mel+PpkDoy43M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729193263; c=relaxed/simple;
	bh=iX4j0r/woeVg/iIUI+JIRvMpYLF9/4zVNRSVpfqNgzA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ufKSPZFofbIDVEjSQbNhBfrFRAUZ54m2/U9ZIZQ2BjPn/9fvMPmzQMeY+/7HHK0xiemwDzPaBIq2kmNzGjOmxRe3BNKuv5pg3Cp8xnrwQaRaJCcK8DDmlCbAsZ9GRd0DY9uW+8fcM14cF8Liouyp7V+JNMjjicqhTWR4ilKNxuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vax/JZfC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729193260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=SDrTNA8noHLHlBRxbC5kw1SGkO4NC4H89J2bb8+gY1o=;
	b=Vax/JZfCwKw7uNnNomwA4Gz5trxm8+T7Kwv6tHTSBMOLbPtPHUnJ1VR38/WVm75at5KiEc
	+IBUflTzR1rm7fhufnlRewdgH1W8B+mX91ZGVs2cRSw1kUdoA7pe2ZMciadKerAvtKreQu
	C8ljZZFbSCtqvMtPGow81p6OF8prWaE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-pndMb5OoPIaBAoPo6OmRqQ-1; Thu, 17 Oct 2024 15:27:39 -0400
X-MC-Unique: pndMb5OoPIaBAoPo6OmRqQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37d5a3afa84so601780f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 12:27:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729193258; x=1729798058;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SDrTNA8noHLHlBRxbC5kw1SGkO4NC4H89J2bb8+gY1o=;
        b=bvMNdSqE6AO+TZ3p6ZmrbJ+UCE5cDKSk24SdjVbQHfvzTBlCRiP65uS1kqoPfjxZZx
         kz48tAJqUi+1FCm1mq9EHSPm8b9AhqJzCZ443g7i3Qt4rO3VTEUKe7rqk2iKQ1osc8O5
         7mdgCOxvxk9qC5E+XO2YbaBG/6ELSJoUtUqhphD7ifjlmmwjOT5hUr9ilZctKt2qVlVB
         mZsJdU0iulHCJj83GmLskVLI6YG3pVxEBNKrNZ6hmn/nWryq7udbl9U0VSB16DQ3OasY
         pGv+Zdd65gBu4laKaOrw8QqcaERQ6mmd8zFT/7WmDz/b8Y/ZEaDbIWMIk2CyhYfIf3Rc
         n8rg==
X-Forwarded-Encrypted: i=1; AJvYcCVX57O0KUTa+dofAMNeWPYxLFulLNEFuO/Eztax18iSPHzzxaeWYFM8CXDJraaWxkcW0YzP/VrzrKM7GI8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMvnccuNh8bZ71bU4pTI2UsmVZ7Q0bvxJaGNoR0QUNjxfq1Brn
	CxDKr+T9JeddXxW457AtL2qt8M2d6Kn6VpU85AVD1BAp6vNnHn0Gu/NA0qq/ClNtq5+CoeqoiQ6
	E1tpFnjNfOLW7EHzStAW8V9R89omeR/b8j4/C1tVAz/1cKPTJ4tl7O8kEGasPBA==
X-Received: by 2002:a05:6000:5:b0:37d:3985:8871 with SMTP id ffacd0b85a97d-37eab4ed358mr29511f8f.39.1729193257819;
        Thu, 17 Oct 2024 12:27:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYQ2woY5R9nAe/EldYPFaGiT9ilV0IzpRL6ToXMG8gZILvP9e+j2lJu83baqVnJNbu24Z46w==
X-Received: by 2002:a05:6000:5:b0:37d:3985:8871 with SMTP id ffacd0b85a97d-37eab4ed358mr29500f8f.39.1729193257332;
        Thu, 17 Oct 2024 12:27:37 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:7600:62cc:24c1:9dbe:a2f5? (p200300cbc705760062cc24c19dbea2f5.dip0.t-ipconnect.de. [2003:cb:c705:7600:62cc:24c1:9dbe:a2f5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7faa4085sm8162554f8f.65.2024.10.17.12.27.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 12:27:36 -0700 (PDT)
Message-ID: <9babc9ff-00f0-44c7-a2fe-8aeadfefe75a@redhat.com>
Date: Thu, 17 Oct 2024 21:27:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: WARNING in get_pat_info
To: lee bruce <xrivendell7@gmail.com>, dave.hansen@linux.intel.com,
 linux-kernel@vger.kernel.org, luto@kernel.org, peterz@infradead.org
Cc: bp@alien8.de, hpa@zytor.com, mingo@redhat.com,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 wang1315768607@163.com, syzkaller@googlegroups.com,
 Peter Xu <peterx@redhat.com>
References: <CABOYnLx_dnqzpCW99G81DmOr+2UzdmZMk=T3uxwNxwz+R1RAwg@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CABOYnLx_dnqzpCW99G81DmOr+2UzdmZMk=T3uxwNxwz+R1RAwg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.08.24 11:44, lee bruce wrote:
> Hello, I found a bug titled "WARNING in get_pat_info" with modified
> syzkaller in the lasted upstream and lasted mm branches.

Below report is from 6.10.0, which is not precisely "latest upstream", 
but I assume you have similar reports on upstream?

commit 04c35ab3bdae7fefbd7c7a7355f29fa03a035221
Author: David Hildenbrand <david@redhat.com>
Date:   Wed Apr 3 23:21:30 2024 +0200

     x86/mm/pat: fix VM_PAT handling in COW mappings

Was part of v6.9, but this is a different issue.

> 
> If you fix this issue, please add the following tag to the commit:
> Reported-by: xingwei lee <xrivendell7@gmail.com>
> Reported-by: yuxin wang <wang1315768607@163.com>
> 
> TITLE: WARNING in get_pat_info
> ------------[ cut here ]------------
> WARNING: CPU: 2 PID: 12458 at arch/x86/mm/pat/memtype.c:1002
> get_pat_info+0x4b6/0x5c0 arch/x86/mm/pat/memtype.c:1002

This is the WARN_ON_ONCE(1) in get_pat_info(). We don't find any page in 
the mapping, so it vanished already.

I thought we discovered that already recently and discussed it here:

https://lore.kernel.org/all/20240712144244.3090089-1-peterx@redhat.com/T/#u

Which was supposed to fix this problem IIRC.

That patch result in other issues, and my analysis about them is here:

https://lore.kernel.org/all/8da2b3bf-b9bf-44e3-88ff-750dc91c2388@redhat.com/

We didn't have a report from an in-tree driver, so we decided to "not 
care" about these reports:

https://lore.kernel.org/all/116ca902-103d-47cb-baf0-905983baf9bb@redhat.com/


But I don't see Peter's patch upstream.

Peter, do you recall what the conclusion on that was?


-- 
Cheers,

David / dhildenb


