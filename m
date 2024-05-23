Return-Path: <linux-kernel+bounces-187021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF668CCBEC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 07:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A22F4283B1E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 05:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074F113B2A4;
	Thu, 23 May 2024 05:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OMF0ZvCA"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3356D53E31
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 05:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716443804; cv=none; b=d/vHRYjWCkD6I2pUGpPOlU16wLCPoFVozOzy1eugzI8PIvxFhrrzHgp9Q0G1KU/52NfkOl5wXnKFkbyIInDO40XzIpjQIBTjPBUD+bG9b4l66SFXr3TsjP7laBTtKlreiMVdIISj5rdA3pYjpQJDstqHshee/2tsB56UhDMI70w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716443804; c=relaxed/simple;
	bh=QcmKNaeadCmfjBKwZ3A6bKHF9tzg4uverKrdNId0nt4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ux35QNIw9ciDykAD3xjpslF2CSHaxIP/iiNHVShPZBuLhvPNU/1LQixzP1AsL/BnBvhhPbjY+tHspjKvGmYTYxsahJs8q7lkR5bUjvX+PFQbXq3mq90TR0IKktKnorc8OXACMMklqTCDfej8hxQjnIQWRLua+zu9srqV1cKwDf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OMF0ZvCA; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a623cf7764bso79936466b.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 22:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716443800; x=1717048600; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oHJGxxygKhr7lKwiErxVT7iLb1jusJ405Lsp+K8U1jI=;
        b=OMF0ZvCAy5KeFMvNICrZWDgR3zuLvwHdB7N8gYkvt1wPulCSMvukye3s+xUqCjUz0K
         WC+kGVqZaa8Q4akm0JTpl5po/q16c9zi1BPRIw41BuyzVxyu3QF5uoqOqmeWpKS/jDyn
         KTipc4RsLVdJs6rum27mnaKrC7zCGm5x2Tpepj6xBsIzjIuG/QCkS4DKVQeNC8p1m6JN
         hwF6CeWoCddw4KbwNTVD7Phn+QvabeNT2ceS4UDC1kp7WjP0MP2M7Z1CeT8ggtsh2Jxw
         l1E7df6SK8lB8kXyUleGXM6B3vaooT9X/+JdLKZb3gBCbEKW5ex9AoRFF7Yz34GRDYFi
         82dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716443800; x=1717048600;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oHJGxxygKhr7lKwiErxVT7iLb1jusJ405Lsp+K8U1jI=;
        b=ZitHORXLhVuVZSkqy43OhM7e34GDa3FhQQE2lvpej9IAlomXYOJgY19pcOkQ8QRlce
         Boe/Y5iYCkajY9FH8mDZio2rcOb10vSZ0PkLXBo1+nNvUNImNqrR/2IOBdb/CqgR4hzG
         WWG3FyG6Gu/SpNT1mQ+k6B8F52OVQcQ4G8e4bd8u3bhFYJV7flOzHeS7ORQmaCxwW8eP
         rHLQ5h34Y2zeMVH5zDhLknFnjQvuExHj7jdZbl/pOkx3UFlC5btNaR+lH2iW3+ETCfLM
         TdGIcgHQECWY2y5q/pi2nGfK8+e9TYRrf6nTLi1euVDhI4idCrUpNi/KpGLj/IZzU6oB
         Njzw==
X-Forwarded-Encrypted: i=1; AJvYcCVmKjby5prcvGc+cGQ0glBoxM/wbfT6KhFhNAR2gYxT3ghiFbGhz5zFRThTo/9XT00e0nq+b+K77BwD/wP8zGjKSR03skU7ikQOOai8
X-Gm-Message-State: AOJu0YyTK4yoQuNWQIsRdvkX6wkc3sQoxy/vqycXFPXdA7QVVXx6BxrG
	HOZ49anyDb4f0f2PJaCHkFAmVg+56uQVqsJwrlsm91Kl0b+D0Q0aL8RcCxT+aI4=
X-Google-Smtp-Source: AGHT+IEhH1qf1RK/Jjcy07X+3I4SVHyPhSEyUaDXD1nJg4bAEZR/1Ei9QxnLdlNV2uc7jTf1E0aNYg==
X-Received: by 2002:a17:906:3858:b0:a62:2f13:a7d6 with SMTP id a640c23a62f3a-a623ea280d1mr93142966b.36.1716443800494;
        Wed, 22 May 2024 22:56:40 -0700 (PDT)
Received: from ?IPV6:2003:e5:8729:4000:29eb:6d9d:3214:39d2? (p200300e58729400029eb6d9d321439d2.dip0.t-ipconnect.de. [2003:e5:8729:4000:29eb:6d9d:3214:39d2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a621b4e2988sm281054266b.79.2024.05.22.22.56.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 22:56:40 -0700 (PDT)
Message-ID: <e2d844ad-182a-4fc0-a06a-d609c9cbef74@suse.com>
Date: Thu, 23 May 2024 07:56:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/kvm/tdx: Save %rbp in TDX_MODULE_CALL
To: "Huang, Kai" <kai.huang@intel.com>,
 "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
 "Hansen, Dave" <dave.hansen@intel.com>
Cc: "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>, "x86@kernel.org"
 <x86@kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>,
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
References: <20240517121450.20420-1-jgross@suse.com>
 <ohvjbokpaxagc26kxmlrujab7cw3bekgi5ln7dt46cbsaxcqqh@crvqeohfazmf>
 <f63e1217-3dbe-458d-8c14-7880811d30ba@suse.com>
 <2a2guben2ysyeb43rzg6zelzpa57o24ufai3mi6ocewwvgu63l@c7dle47q7hzw>
 <03d27b6a-be96-44d7-b4ea-aa00ccab4cc5@suse.com>
 <fc0e8ab7-86d4-4428-be31-82e1ece6dd21@intel.com>
 <c0067319-2653-4cbd-8fee-1ccf21b1e646@suse.com>
 <6df4fb48-9947-46ec-af5a-66fa06d6a83b@intel.com>
 <86ca805d-7ed7-47dd-8228-5e19fbade53f@suse.com>
 <f7edef9c-5eb5-4664-a193-3bb063674742@intel.com>
 <f02d9ebb-a2b3-4cb3-871b-34324d374d01@suse.com>
 <4b3adb59-50ea-419e-ad02-e19e8ca20dee@intel.com>
 <c7319c0614c9a644fa1f9b349bf654834b615543.camel@intel.com>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
In-Reply-To: <c7319c0614c9a644fa1f9b349bf654834b615543.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.05.24 13:54, Huang, Kai wrote:
> On Fri, 2024-05-17 at 09:48 -0700, Dave Hansen wrote:
>> On 5/17/24 08:58, Juergen Gross wrote:
>>> On 17.05.24 17:52, Dave Hansen wrote:
>> ..
>>>> Once we have the specific TDX module version, we can go ask the folks
>>>> who write it if there were any RBP clobbering bugs.
>>>
>>> Okay, how to get the TDX module version?
>>
>> You need something like this:
>>
>>> https://lore.kernel.org/all/20231012134136.1310650-1-yi.sun@intel.com/
> 
> This one prints TDX version info in the TDX guest, but not host.
> 
> The attached diff prints the TDX version (something like below) during
> module initialization, and should meet Juergen's needs for temporary use:
> 
> [  113.543538] virt/tdx: module verson: major 1, minor 5, internal 0
> 
>>
>> .. and yeah, this needs to be upstream.
>>
> 
>  From this thread I think it makes sense to add code to the TDX host code
> to print the TDX version during module initialization.  I'll start to work
> on this.
> 
> One thing is from the spec TDX has "4 versions": major, minor, update,
> internal.  They are all 16-bit, and the overall version can be written in:
> 
> 	<Major>.<Minor>.<Update>.<Internal>, e.g., 1.5.05.01
> 
> (see TDX module 1.5 API spec, section 3.3.2 "TDX Module Version".)
> 
> The attached diff only prints major, minor and internal, but leaves the
> update out because I believe it is for module runtime update (yet to
> confirm).
> 
> Given there are 4 versions, I think it makes sense to implement reading
> them based on this patchset ...
> 
> https://lore.kernel.org/kvm/6940c326-bfca-4c67-badf-ab5c086bf492@intel.com/T/
> 
> ... which extends the global metadata reading code to support any
> arbitrary struct and all element sizes (although all 4 versions are 16-
> bit)?

With that I got:

[   29.328484] virt/tdx: module verson: major 1, minor 5, internal 0


Juergen


