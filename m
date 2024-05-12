Return-Path: <linux-kernel+bounces-176915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1CA18C36FA
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 17:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28887B20BD9
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 15:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205573D0D5;
	Sun, 12 May 2024 15:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g8LK7RAx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74AF2F873
	for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 15:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715527533; cv=none; b=D68PbvN2JoO8QdnZ5rf2sCIzugEUwVcbVKG2COBofAnm6f5Ld7Lf5UEeD+dDSUG9NVnEe0wivFex/+iS7E1c30tophsTGcLBnVqs7rjsjOgs1CnyGyOJpUa732hfW8wl0Vd6uHc3hHUrNkIR6ci+4touDhEdQlV79hofcSO7iXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715527533; c=relaxed/simple;
	bh=RfLwX01/3WZpELU+1hMwbX8ioZ2ZPB6T+yvhcOFTJ/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dbkVr3K46/tR7tgYmAq0slbqC/szzC9lI9Po9jS6T59hdcvwCpCKNiQvExuH3wpvQx5pn5zx3uN9od+GkIAhUQBgA495EviPkPXSlppxbTOlUtl//osyYksFZX1LFv3GaJNl+kKQJGfPiNV8ylwIrju8GwMP2phLOzgnbosQxbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g8LK7RAx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715527530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=REXEqRClpHRev0wKw6MM0lA0UZQFaO1XDkvWqjxKpSs=;
	b=g8LK7RAxZpvRfntHzY2dzxx+axNF6cG9h0rq+OyihpFfRxyziFtnhDV3z0T8ZuGPY0VjDv
	df1fAwnnyNSRQjWQ3aDoqOECosLMB+SeTI8rZU2P/Fs0E/1KdmjiFAAmfu7fDhoiwvJdLo
	boqjUjrw5zbllIy6EEuBp7OhVm+8XTA=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-e0P-NwfsMNatY8NEcNg4XQ-1; Sun, 12 May 2024 11:25:24 -0400
X-MC-Unique: e0P-NwfsMNatY8NEcNg4XQ-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5206ef0d6fdso3108370e87.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 08:25:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715527522; x=1716132322;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=REXEqRClpHRev0wKw6MM0lA0UZQFaO1XDkvWqjxKpSs=;
        b=TpCI/Uz2IC/1M42/PHwONSPZ9gVjUOKt9Cx+HuUyRU5bE+WYQxpnqoQwO9DXnGUbfn
         mVBKqJWIaBmG//IoQDCL9v/elQaSUv5FNL0lIKZ9kZmS+QjoSANdMclJNfnzVl6oCLMH
         XtprI00iPRk6pacvWaeQyFcHJa3Au++w+d0afKqM9jDnIzqIheTj2kC367cbqCDI7TcD
         qbemSbVzvBWR8Nh94VkUvxYryGekOEt/wwDgiiui8mEQz8uXWfGs22fCZ9eq6uwTfOco
         EkYV6PTZ/I7zLQ13A8KCmf6ONSMDQfqrr+5ZRXi9QovpSDzQ75WYG0B/fS46cIAlquIj
         5j0g==
X-Forwarded-Encrypted: i=1; AJvYcCXNDynMIlZTJhFjNq4nOPnabf32ZkBHXGN7KA1JV+mYrz3Vdc2StAEbaEhXoSFhB/cUig1y650vG88VbydZBUBYfZV8vtE+pjw+uLRR
X-Gm-Message-State: AOJu0YzRMESB3/bR/n0jNxNSt1QRSZ326ufHQ/eJPD72A7c9y7una+DU
	42tZ3CGES1snkrbovR1k+Mvl6R597XG8/qxwy/b1C8MCxLmhqJM7L9IXylAS7Oq/LG9mhvYFXVX
	ZeKLKZAoZt2pSuFxiTBluC1Nlh0Laqxy5XsZE0ojNfP++MdWtc3jTWLmbqES7VQ==
X-Received: by 2002:a05:6512:310f:b0:51d:6660:e43 with SMTP id 2adb3069b0e04-5220ff746c8mr4705597e87.59.1715527522604;
        Sun, 12 May 2024 08:25:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFL4+5i84D+bxhz3X4VH1waOivUquTPnysBNjyifN3WMq3+4sJUxIXZ9K4Rbsv97lME5t88Qg==
X-Received: by 2002:a05:6512:310f:b0:51d:6660:e43 with SMTP id 2adb3069b0e04-5220ff746c8mr4705584e87.59.1715527522075;
        Sun, 12 May 2024 08:25:22 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b01647sm467000666b.160.2024.05.12.08.25.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 May 2024 08:25:21 -0700 (PDT)
Message-ID: <d12713a2-3b1a-47f1-8173-ec4d675021ec@redhat.com>
Date: Sun, 12 May 2024 17:25:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] platform/x86: dell-laptop: Implement
 platform_profile
To: "Limonciello, Mario" <mario.limonciello@amd.com>,
 Lyndon Sanche <lsanche@lyndeno.ca>
Cc: pali@kernel.org, W_Armin@gmx.de, srinivas.pandruvada@linux.intel.com,
 ilpo.jarvinen@linux.intel.com, lkp@intel.com, Yijun.Shen@dell.com,
 Matthew Garrett <mjg59@srcf.ucam.org>, Heiner Kallweit
 <hkallweit1@gmail.com>, Randy Dunlap <rdunlap@infradead.org>,
 Jonathan Corbet <corbet@lwn.net>, Vegard Nossum <vegard.nossum@oracle.com>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dell.Client.Kernel@dell.com
References: <20240425172758.67831-1-lsanche@lyndeno.ca>
 <20240511023726.7408-4-lsanche@lyndeno.ca>
 <9ba4a500-9d88-4630-bd94-99f07dd51abe@amd.com>
 <B3AA4333-03DC-47D6-9519-7FA9496220E5@lyndeno.ca>
 <48JCDS.E4RT1F9DTKFU1@lyndeno.ca>
 <9b652a48-4107-4b68-9aea-6cfdf1e0e4fa@amd.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <9b652a48-4107-4b68-9aea-6cfdf1e0e4fa@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 5/12/24 3:43 AM, Limonciello, Mario wrote:
> 
> 
> On 5/11/2024 7:12 PM, Lyndon Sanche wrote:
>>
>>
>> On Sat, May 11 2024 at 09:59:17 AM -06:00:00, Lyndon Sanche <lsanche@lyndeno.ca> wrote:
>>> On May 11, 2024 9:16:56 a.m. MDT, "Limonciello, Mario" <mario.limonciello@amd.com <mailto:mario.limonciello@amd.com>> wrote:
>>>
>>>     On 5/10/2024 9:36 PM, Lyndon Sanche wrote:
>>>
>>>         index 6ae09d7f76fb..387fa5618f7a 100644 ---
>>>         a/drivers/platform/x86/dell/dell-smbios-base.c +++
>>>         b/drivers/platform/x86/dell/dell-smbios-base.c @@ -71,6 +71,7
>>>         @@ static struct smbios_call call_blacklist[] = { /* handled
>>>         by kernel: dell-laptop */ {0x0000, CLASS_INFO, SELECT_RFKILL},
>>>         {0x0000, CLASS_KBD_BACKLIGHT, SELECT_KBD_BACKLIGHT}, +
>>>         {0x0000, CLASS_INFO, SELECT_THERMAL_MANAGEMENT}, };
>>>     So when Alex checked on v5 that this doesn't load on workstations,
>>>     it has made me realize that doing this will block the interface
>>>     totally even on workstations. So I think there are a few ways to
>>>     go to handle this: 1) Rename dell-laptop to dell-client or dell-pc
>>>     and let dell-laptop load on more form factors. This would require
>>>     some internal handling in the module for which features make sense
>>>     for different form factors. 2) Add a new module just for the
>>>     thermal handling and put all this code into it instead. I don't
>>>     have a strong opinion, but I do think one of them should be done
>>>     to ensure there aren't problems on workstations losing access to
>>>     thermal control.
>>> A dell-client/laptop separation makes more sense IMO. I don't think keyboard control would belong in a the dell-client module either. Separating just thermal control would be easier, but not as clean I think. Thanks, Lyndon
>>
>> Thinking about it more, we can leave dell-laptop as-is and create a common dell-pc module that does not check for specific form-factors, assuming that is possible. Thermal management can be the first function to go in there.
>>
>> We will still block the calls from userspace regardless of which modules are loaded. If dell-pc fails because thermal management is not supported, we aren't losing anything by blocking that call anyway.
>>
>> Thoughts?
> 
> Sounds good by me.  So basically laptops will load both dell-pc and dell-laptop and workstations would load dell-pc.

Ack this sounds good to me too.

Regards,

Hans




