Return-Path: <linux-kernel+bounces-280770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4960994CEEE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 12:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7983B216BA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 10:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7571922F2;
	Fri,  9 Aug 2024 10:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MOPmKc2J"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CD618FC6F
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 10:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723200410; cv=none; b=ajvUGgpwTQhQozVJUFgZ294q8oSrNKPMPXmLkRxgsYAw83HuChDZMP0XFuE7moi8+RNWRKV28R7ai1pa48MfKgRdogEKs1IgszDTaFQehRvojUHJ1X22tLAufgRlcQa2fcuB6gvDItJ0LdssV+Yxig4FvuVBkozVUBfk3pHXxlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723200410; c=relaxed/simple;
	bh=faiyHW0o6cRrU/6xvh9xkIr5FO7DO3NhbnfoixAXvhg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M7eu2j+dCInOKfss3n7/I4x8GeyNTMEx3YdCR1s+a1Ov0iyIJx7R8A6UGf5juTvS4SBSbCqFQRPJJQKQ5KE26oBemARvMxN0evd2mX0JMctlUyuPvNRzWuKRg1tqUAJgdFKDz3ThBxs2mGrDE2qeZX+Zc+JERmMyVg/f8rqzr5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MOPmKc2J; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a7aa086b077so195546166b.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 03:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1723200406; x=1723805206; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fJs+/RT35McLGCA60w1WZuDEUgEuqSMSCbSUihWusmo=;
        b=MOPmKc2JO0BMXmB7l/BJIsyZ4XAt9L4BWR2iNdznsCsbWg+m8oFtGyZzOzyJTzg0LN
         yA5G5M10POfhB86TJ0NITAAfB8HXFIrUCVza5CnIESoiIDHsubEDawpn0Gd3AkyUV6Zd
         oAGCJrG1NJ/R9BQQUK5VrUn1yNmf+A7SLU1/Wi2WwjSjXVwcfqS0KHcrLhhEwxlj5cjc
         T5QFAk+qdeMPjhDWXg7XU+ZoIPFt83PXDRnvqHz+qjW+rXARCFLBTyD7yAIO0GVg6Xy+
         cS5WBp77ayQ9J2YHo8QwvIyHyxA2H0mwLfxVSN4MzxlRR3Nogp0IbO0dkXcWeabETuaG
         INtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723200406; x=1723805206;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fJs+/RT35McLGCA60w1WZuDEUgEuqSMSCbSUihWusmo=;
        b=sleGPpb/RJ6CG0htaVS6Y2ZYMSWizyZWCmFzmFmHAZxJyi0wR8yWRmpED83DKqVeuo
         T1TUv1N1qsbNVrgvM3ctn9+M68DhAb43THtRTHASinup+dAAYTN8ortC2+XbCQvrghSi
         su2qrb0eomH6JHNu0HhQIhWuZexYewX4FlitqevKrVtOUuvSTNDvDKqFOKMljvtzCURO
         04g5Oxq+8pb7TP1WUCgPn7RLpv4v2pfPo3+J+plC1v3q5EaEcYnFiEC29jPZTUg/gMGE
         +hppAmtTVp3AVGBAQdolGVs4FqBzFMq5at6F31F1UnRv3GNrFhWDb5kZixGkBbw7eR6c
         IHRw==
X-Forwarded-Encrypted: i=1; AJvYcCU/Nfph+LvWtGVhW9Wpdphq4oS1wIAAMZ+xHL6BcVgP7Bm09DOTNrbMVh4B/a8HkXAL66Nur6rF5wC+EhqRKsLwgg+xhDfaqFhGITMK
X-Gm-Message-State: AOJu0Yz+CBCJ7qHouLwmD+qrBFyh6nAyP/jyit2SeZZnelxWlKw6gJXV
	Yx+ifKp2OrAJBnDZrP9dLQAmo9UhlmLjZ3fCGVlXqTbrwqFNvfyjoy0VI9A0L1c=
X-Google-Smtp-Source: AGHT+IHU3rQncxndKon8M2TIzQH6dJgiKVzIYK4fhBeVF/rtLt8FjgDvfOhmmFlz6r8nq1FP3RclxA==
X-Received: by 2002:a17:907:940a:b0:a7d:a0d0:f5c1 with SMTP id a640c23a62f3a-a80aa6e9af0mr78287166b.65.1723200406400;
        Fri, 09 Aug 2024 03:46:46 -0700 (PDT)
Received: from ?IPV6:2003:e5:8741:4a00:60e5:7bee:fc48:e85c? (p200300e587414a0060e57beefc48e85c.dip0.t-ipconnect.de. [2003:e5:8741:4a00:60e5:7bee:fc48:e85c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9c0cb9esm826885666b.78.2024.08.09.03.46.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Aug 2024 03:46:46 -0700 (PDT)
Message-ID: <34551b4d-7420-4203-bf14-564b5f3443c4@suse.com>
Date: Fri, 9 Aug 2024 12:46:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] xen: tolerate ACPI NVS memory overlapping with Xen
 allocated memory
To: Jan Beulich <jbeulich@suse.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org,
 =?UTF-8?Q?Marek_Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org
References: <20240807104110.18117-1-jgross@suse.com>
 <20240807104110.18117-6-jgross@suse.com>
 <90d67e10-6e35-487e-a9e7-611a0fa3b00b@suse.com>
 <64e0ac51-690d-4c44-85fb-6a0b8415fcb7@suse.com>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
In-Reply-To: <64e0ac51-690d-4c44-85fb-6a0b8415fcb7@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09.08.24 11:45, Jan Beulich wrote:
> On 07.08.2024 14:05, Jan Beulich wrote:
>> On 07.08.2024 12:41, Juergen Gross wrote:
>>> In order to minimize required special handling for running as Xen PV
>>> dom0, the memory layout is modified to match that of the host. This
>>> requires to have only RAM at the locations where Xen allocated memory
>>> is living. Unfortunately there seem to be some machines, where ACPI
>>> NVS is located at 64 MB, resulting in a conflict with the loaded
>>> kernel or the initial page tables built by Xen.
>>>
>>> As ACPI NVS needs to be accessed by the kernel only for saving and
>>> restoring it across suspend operations, it can be relocated in the
>>> dom0's memory map by swapping it with unused RAM (this is possible
>>> via modification of the dom0 P2M map).
>>
>> While the kernel may not (directly) need to access it for other purposes,
>> what about AML accessing it? As you can't advertise the movement to ACPI,
>> and as non-RAM mappings are carried out by drivers/acpi/osl.c:acpi_map()
>> using acpi_os_ioremap(), phys-to-machine translations won't cover for
>> that (unless I'm overlooking something, which unfortunately seems like I
>> might be).
> 
> Thinking some more about this, the above may be pointing in the wrong
> direction. If from acpi_os_ioremap() downwards no address translation
> (PFN -> MFN) occurred, then what's coming from AML would still be
> handled correctly as far as page table entries go. The problem then
> might instead be that the mapping would appear to be covering RAM, not
> the ACPI NVS region (and there may be checks for that).

All PTE entries written go through the P->M translation.


Juergen

