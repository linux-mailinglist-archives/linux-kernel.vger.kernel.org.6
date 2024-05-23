Return-Path: <linux-kernel+bounces-187108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A718CCD37
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 09:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B46C11C212C9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 07:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E67513CA81;
	Thu, 23 May 2024 07:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BF9U98Ot"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90DF13B2B6
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 07:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716450244; cv=none; b=WoniC9UI8kGI0Q61xdhCVZMEv8lAJyFx+B5Hjwtw4tWwhgNtLO81/EvhEB7tBTdmYa+6cDtiXcRE6lAPmvJ7wdz2r1QYg59a36FXovK90U3J7mB2rSHr1YP8Iu5uBsdPhjNOQU+dH7WaBj4j0o0r1sdx4HWSDuN3K+H3BEoLZVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716450244; c=relaxed/simple;
	bh=+6H0NuY7yf5yKBj+9qrBGACSuEKEjoGIDa04RAZyPB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J19g/sS3bomTuJLk7Y87KolfTuYnwERyPGn2F8PJLIIlCJWoXaJAkVqhvFRvP01clAocZN1E6sqVK0/zhDEnKj0XxvwCeprN0tLrSmnMMQ5Dx2QwVoRitmX/p4twdTlZjH66aQj5avWg3tu6T+X5eINdW7qZjuTH3K7dfo5yZ44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BF9U98Ot; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2e576057c2bso107583311fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 00:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716450241; x=1717055041; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQaQnll249PzObj0jm3igRrSGBLp96MOKX/eXVstz48=;
        b=BF9U98OtYzMQfzj5Yas/dJuwzl4POXxcUIn8BRuErnI6dRxci8BtT21ifeoFpBgRf0
         L+OPjlWYsHa3jGCR4UsUAhSSJ7Eh7kJ3ypOHSGoNkJPZ9g21xp6bQ14gTZHD4Qz6bqT5
         sQmarYBOpRepOzVEM8XrBPZddjKB2ScXYZrjIpwrzYPngiqBjtnR7ncg5ImhTXL7ia1G
         SZXHbCBxgtvjrh/gQqD2P+eB5s2AkY0eeZUV39CXD+rrSY0vy9qAqVQ1qczlkQ/JzvOR
         NYbBmmAgPTNhw9ysY5TQaetOo3sDnwCN7NJ3D8CgJnb1MPwWUo/yTKkPmbK025VGGbN9
         1vSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716450241; x=1717055041;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pQaQnll249PzObj0jm3igRrSGBLp96MOKX/eXVstz48=;
        b=LxJPPXh3OT9UePKuMi2IHmomvgdl2WHCFDbJR5b0DNeCXh/Z0q3gpNRgrXSrHbePsQ
         eUGRT7xE363ruGf81uvR2tjg5aThVTBP+2UO51BazztfI4DzKNNFOe01BpSZMrQcLIFR
         XQQSTZHg1z/5DshbXe10Qt2vb3llR2NroV2b56ALT+Plmc7WMIMS/JdA7rz51eZEj4OF
         b3DHhE85RlKOsav5AijaE06Yw8YLR2xE5EyTfzv7QSIhUNFmUHMxolp1E8S40ES0ArZq
         X/zLHOmksz22aU0qyDqGj4WhmPV3e0cQKMI6Gj2kWpQPuZihijkmgPjSOJhTsKNEAq+8
         e7Gw==
X-Forwarded-Encrypted: i=1; AJvYcCUX+6Wq6AsCW4gEanpgUoqBK0cLLQafertC3vVoD571VfaZofXubl0V082x0240uOoDWlC7wkro5cUHPlowjdsGjcFn2cxZhteRyIS5
X-Gm-Message-State: AOJu0YyLo32BGpP36bjeLMnUUV9ivTvN+DZNtd00iz5hIJlwTCbt2ZUM
	6zlwX8zu3t+zhtFLZoCy5wNJTmucakaVlmBsxh2AfO6Gjj7zqXrR
X-Google-Smtp-Source: AGHT+IE5e9Zd5efr0fJkiJxH9yPmzb9fqN4396AbqSEx6AVkQZ2469hY6NkXoWnVN+M9g2ISeUpqtw==
X-Received: by 2002:a2e:86c8:0:b0:2e7:1e4a:31e0 with SMTP id 38308e7fff4ca-2e949467bf2mr30023561fa.18.1716450240590;
        Thu, 23 May 2024 00:44:00 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b01968sm1899538766b.166.2024.05.23.00.43.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2024 00:43:59 -0700 (PDT)
Date: Thu, 23 May 2024 07:43:59 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Wei Yang <richard.weiyang@gmail.com>, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org,
	linux-kernel@vger.kernel.org, Vivek Goyal <vgoyal@in.ibm.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Ingo Molnar <mingo@kernel.org>, Steve Wahl <steve.wahl@hpe.com>,
	Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH] x86/head/64: level2_kernel_pgt's kernel area is built
 with _PAGE_PRESENT set
Message-ID: <20240523074359.wiqurnqqrxjtgghu@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20240323232621.10400-1-richard.weiyang@gmail.com>
 <87jzjmgod2.ffs@tglx>
 <20240522140614.fxe6tw6y5clrnve3@master>
 <87a5khh9in.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a5khh9in.ffs@tglx>
User-Agent: NeoMutt/20170113 (1.7.2)

On Wed, May 22, 2024 at 10:33:20PM +0200, Thomas Gleixner wrote:
>On Wed, May 22 2024 at 14:06, Wei Yang wrote:
>> On Wed, May 22, 2024 at 11:58:01AM +0200, Thomas Gleixner wrote:
>>>
>>>What's the actual problem you are trying to solve?
>>
>> Not a problem. It tries to remove some duplicate check.
>
>I assume you mean redundant check, right?

Yep, you are right.

>
>The changelog should explain that. I really could not figure out
>what this is about.
>
>>>>  	/* fixup pages that are part of the kernel image */
>>>>  	for (; i <= pmd_index((unsigned long)_end); i++)
>>>> -		if (pmd[i] & _PAGE_PRESENT)
>>>> -			pmd[i] += load_delta;
>>>> +		pmd[i] += load_delta;
>>>
>>>Fixing up non-present PMDs is a pointless exercise.
>>>
>>
>> Agree. While we are sure then range here must present.
>>
>> The whole process looks like this
>>
>>     pmd in [0, _text)
>>         unset _PAGE_PRESENT
>>     pmd in [_text, _end]
>>         fix up delta
>>     pmd in (_end, 256)
>>         unset _PAGE_PRESENT
>>
>> Since we have compiled in _PAGE_PRESENT in this page table, it is not
>> necessary to check _PAGE_PRESENT again before fixing up delta.
>
>That wants to be in the change log.
>

Sure, I would put this in the change log in next version.

>Referencing the history of the code is definitely interesting and you
>did a great job on decoding it, but for the change itself the only
>relevant information is that all PMDs between _text and _end are marked
>present because the whole table is marked so.
>
>> BTW, if one entry between _text and _end is not present, we will failed to
>> fixing the kernel code pmd entry, which will lead to some problem.
>
>It does not because a non-present entry does not care about the load
>delta obviously.
>
>Thanks,
>
>        tglx

-- 
Wei Yang
Help you, Help me

