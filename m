Return-Path: <linux-kernel+bounces-187464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F9B8CD234
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 14:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45012B20B8F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 12:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF1913BC02;
	Thu, 23 May 2024 12:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NOx7YY4m"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D1C13B5A6
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 12:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716466872; cv=none; b=mk5lbEgKjsKfcSEHO6h9voVnZQoWQxrkEeghUyNzfHp+dZMVLG2FkiwL0ysNful2O+3HXbIu7RkY++b8fGcCOPT6ZL0UguyMfx+u+ljbuIYdewDmibrMIGxmfJxKSAuX2DsDttTVTBcTuCYPD1eg+qzhRVwXuIj+1TavItsa3RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716466872; c=relaxed/simple;
	bh=n6t2n1Fr2QiCnyke8eJIa2ZdZQq/wiNoudAwWv5SMok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VViDpjIysfgDNDRTXm2SL8IaAWFA/k+j+WmPVG/9HfvOpgFzWhY/fIwOFptSRWDAVFVirrIU2fO7/1MghJlbeKIxCVhc5k1htzDx/gmrkU/fIiFAF4ou4Dn5r6lCzNhKNyamcpGVV3GcBXk5T67DA5c+fKNEI4v/VqPxyUpGI1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NOx7YY4m; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-354f69934feso509774f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 05:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716466867; x=1717071667; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3IX0krlB3YCXm71EJEDxuBOgVIuxuBFthhIi0sRnDic=;
        b=NOx7YY4mnzGUHJZ7MsziujWc6TggNeVnj3TGd8sSjtELlNNDOi1BtvGbU1fZV03ZXv
         3DBNiazy3KVo5GM659+ZktGA2JpfIiX40JztMuafo35MM1iwm6WqQPm+lPBMJO+uAzmu
         /GV7qi+YFLfiwOsynArUklKi3fRx1zkMouH24BqbgfFsud/mAw9H1m7zYx2hT/eSHTHY
         rwLnagceFzDvV3cb+cKQIUYcLcw2ZG2eosx+3xZc/jhQVCxxy2p34iJqKQOSI9tBHhCr
         qyIPdO1Jq/F6cFtrfPwQ1maIsKWCxyc49TUQf0mDwlklKmMeQH70kS10PH57PV7H/yAb
         wQwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716466867; x=1717071667;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3IX0krlB3YCXm71EJEDxuBOgVIuxuBFthhIi0sRnDic=;
        b=KZkFZ7/ZqKDeP9+yJ+CKRukMCN5hiXd3aIEJaxS6FuDUmRGVIpLmJeyZzFyCQHVbU6
         NLUkn4Xti102LDzDb5C12YPQQlOA5h4HbP7571W9VS/GTvjSdhWoAI6B/v334tHTSqQn
         x08mQnJbY8LvQeAB+j0zcpduQ+xhRmVNJmecu1NPdj3/ZklvZWRRPuBdCa0a2o/OtFxR
         mxnzhtbpnknS7ugN3OOv0c+uu1u590hiD0AAWDxmyVKTP7HQLcVNA1DP+SeyMD/JcCnH
         V/s870zTzURj2yZ9WOBhAfoip5uwi8tTp3R3NYGJNvH+k7kDJkfnT2Aex5V9hQo54BUH
         cXWA==
X-Forwarded-Encrypted: i=1; AJvYcCU516hVxuBsz4rhLJ0Pdl6B6B67hUDbPo2EzH1DIR/mL07haaPIq7vfUdclPsC8IGMgRs1H3o6utedXAVTNn1yn1B4Z29kqUZ24beME
X-Gm-Message-State: AOJu0YxHMkdeL4NBPOtYLQbR4xORklJKcgrIzj86F4f9+NZxxTTOTWUO
	o30nWTjy2exN8Bbhyj5ZgT+oaABXmJPcH11EM+MyqA3UOem8tD5lkn4FMPeDVagmIVGD70Cyuwa
	g
X-Google-Smtp-Source: AGHT+IFzdxDvmzESS7bM8gXGrM/v2nAUpVSfrcszc5DEXbMsV1WxHn0r+kn/0Y7aSwXlIvCY19mVQg==
X-Received: by 2002:a05:6000:118b:b0:354:f729:c3e7 with SMTP id ffacd0b85a97d-354f75baa66mr1833469f8f.34.1716466867136;
        Thu, 23 May 2024 05:21:07 -0700 (PDT)
Received: from ?IPV6:2a10:bac0:b000:7315:e681:bab5:4646:cf21? ([2a10:bac0:b000:7315:e681:bab5:4646:cf21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b79bc3bsm36540643f8f.13.2024.05.23.05.21.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 05:21:06 -0700 (PDT)
Message-ID: <d6981cc9-ea89-47fb-9084-267eba05c7a1@suse.com>
Date: Thu, 23 May 2024 15:21:05 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: CVE-2024-35802: x86/sev: Fix position dependent variable
 references in startup code
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org
References: <2024051738-CVE-2024-35802-959d@gregkh>
 <b3a6ea47-8628-4edc-aee5-e5051955124a@suse.com>
 <2024052334-cable-serotonin-fa2b@gregkh>
 <5ea91ae6-091d-4378-950b-833561eef48c@suse.com>
 <2024052310-undermost-cramp-5d81@gregkh>
Content-Language: en-US
From: Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <2024052310-undermost-cramp-5d81@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 23.05.24 г. 15:17 ч., Greg Kroah-Hartman wrote:
> On Thu, May 23, 2024 at 03:01:56PM +0300, Nikolay Borisov wrote:
>>
>>
>> On 23.05.24 г. 14:21 ч., Greg Kroah-Hartman wrote:
>>> Isn't crashing SEV guests a problem with "availability"?  That term
>>> comes from the CVE definition of what we need to mark as a CVE, which is
>>> why this one was picked.
>>
>> But availability has never been one of the tenets of CoCo, in fact in
>> sev-snp/tdx the VMM is explicitly considered outside of the TCB so
>> availability cannot be guaranteed.
> 
> This has nothing to do with CoCo (but really, ability of the host to
> crash the guest seems like it should be as I would assume that CoCo
> guests would want to be able to be run...)
> 
> Official CVE definition of vulnerability from cve.org:
> 	An instance of one or more weaknesses in a Product that can be
> 	exploited, causing a negative impact to confidentiality, integrity, or

I don't see how this is exactly "explotaible" i.e if a guest is run and 
it crashes during bootup it simply won't run. Can this be considered 
active exploitation of an issue?

> 	availability; a set of conditions or behaviors that allows the
> 	violation of an explicit or implicit security policy.
> 
> I think "able to crash SEV guests" is a direct weakness that has to do
> with availability here which is why I marked it as such (as did other
> reviewers.)  Now if CoCo wants to claim it as part of their security
> implicit or explicit security policy, all the better :)
> 
> thanks,
> 
> greg k-h

