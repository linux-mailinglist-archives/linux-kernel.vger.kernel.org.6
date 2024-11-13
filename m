Return-Path: <linux-kernel+bounces-407297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A64F9C6B79
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 10:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D567E1F22A1F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 09:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705581F80A4;
	Wed, 13 Nov 2024 09:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PZVI1JSz"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBB01F77AC
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 09:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731490085; cv=none; b=Ejjjrl5hpeTWJbvr/aIllqex+tmLj/A2D0CXZDhSSmOTkaO7jVaXZPl+Oq0usfRL8Z6YTrTwVy9b4jdIhIDoZlTigfqosIlFp2Hi8MpV9Lt31Dpww6lrFwV3gXkc7ziXfzHxI7xcrHMlbQNDKQJiWcn+JXnSuo5riJlNwIHDbL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731490085; c=relaxed/simple;
	bh=rw+pO5pNFJraUoJRrMV1qOl9dD0u2m4DteK6ay/tSwo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HY6NF4x6tjWTD6nMNHM3fDiQHHnvYB3Uzk6oOHH3vTbX58RdIyj8oN+RZYFEysSni3ej/rrUon1HZoAx/gDegV28aR9ulT7mCunWoQwhiDGBfXbhR6BazbSPXfJVxEo/k8orlhVpZQyy//mU5AD5Fc2xFRQq6so+kiB/9yDf4u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PZVI1JSz; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9ed49edd41so1130871366b.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 01:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1731490082; x=1732094882; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EnXWL1Jj9Zlbxu4T61hcBX/Uq1lm0S21BmuvWymqUuk=;
        b=PZVI1JSzNMUSRojwj8XpmR8RnezypLur6Qsl+9IO238NTI/6Ytokp4/JhwGF6XVEF+
         ++ASxLCEsxqkP++voZNZmDU+8dP6pDPPAjNTuHHQihcxzRBYUcF5Xruj8IL9ssyA+cdD
         8BSJGFjeUGL8YI1JCyYafGtKp5tPQORcLr7BcJlTbF6CDWi+sJRvx/TQ/bB3eiSGMv3/
         BUr2ertpClrx9hrGnpF8UuHbzxM5lPNQarfst4lBKg1BOHa57tuHgP2F7uJvY60o01WY
         wHqrJx9qvLg1zD6CJ+CNONsSbwpOFWtsEENdOB4049Yi5HjG4mYgdGjMZZMVLD4IguC6
         EfmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731490082; x=1732094882;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EnXWL1Jj9Zlbxu4T61hcBX/Uq1lm0S21BmuvWymqUuk=;
        b=HuT2dKrEfSUVn4+DltYFw3w061HTu34trjsj3cPnXVd4KP3uJo6ZOBr6x8mBsPQnZL
         1R5AV4PigjZnUpQ6m8LGC2oaYl9mveilaVR8V0oNq0sHmVvv46xB1FZA4/xyBE1zgJ3G
         SMnneyTDB5ZTdV0bB58VWLOEwUK88HPy4wHuw/9bPiEClubl4ddjQnQwfOUpXfI6w+Rh
         QHuBKeSnyD8WOLtK7PCyoxb6v2VR23BPKyXKb4+4IMZ+DxB1nzXedWG5kRXxNIaYXFix
         n7eBop8shC5joIOfHryZp34mpCIYOW6ZdQsAT0dUvWbKGv1K7PyBVhXBRNE9qD59hCKM
         tUlw==
X-Forwarded-Encrypted: i=1; AJvYcCVe/KQ14LYmExJ6KEme903pxB6cyCXbftNgsphETjk9yU3bS6m0K1sTfkS1pRkZe1Gd0V5W+2Lvy7BuT0E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+4YWvjx930I6PtEuTqhqQY8i6R6NmO3AIdnJFzruoHS5ciDPY
	bbFnDA0+WAOMfr+ZX0RlGNNpeAQSzVqSywZ8UH0DMdaIkf4/YUXx2HyvsnA5Dmo=
X-Google-Smtp-Source: AGHT+IGGi9WABqSbpVk+N0iHsQT3tZlHLV9rL4xTj1pai188LmwCJdqs0EMiBgvjy2/0vkgOuQAeZA==
X-Received: by 2002:a17:907:3e0b:b0:a99:ff43:ca8f with SMTP id a640c23a62f3a-a9eefebd3damr1975650866b.10.1731490081863;
        Wed, 13 Nov 2024 01:28:01 -0800 (PST)
Received: from [192.168.0.20] (nborisov.ddns.nbis.net. [85.187.217.62])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0e2f096sm827883666b.200.2024.11.13.01.28.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 01:28:01 -0800 (PST)
Message-ID: <4dfb0169-ac37-4c93-8c3b-e8e21a73d8c8@suse.com>
Date: Wed, 13 Nov 2024 11:28:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH] x86/cpu/bugs: Consider having old Intel microcode to
 be a vulnerability
To: Dave Hansen <dave.hansen@intel.com>,
 Alex Murray <alex.murray@canonical.com>, dave.hansen@linux.intel.com
Cc: bp@alien8.de, linux-kernel@vger.kernel.org, tglx@linutronix.de,
 x86@kernel.org
References: <87v7wtvty0.fsf@canonical.com>
 <1c1015f8-1a47-4e5b-b088-f83054d2f613@intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <1c1015f8-1a47-4e5b-b088-f83054d2f613@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12.11.24 г. 17:51 ч., Dave Hansen wrote:
> On 11/11/24 22:37, Alex Murray wrote:
>>> == Microcode Revision Discussion ==
>>>
>>> The microcode versions in the table were generated from the Intel
>>> microcode git repo:
>>>
>>>   	29f82f7429c ("microcode-20241029 Release")
>>
>> This upstream microcode release only contained an update for a
>> functional issue[1] - not any fixes for security issues. So it would not
>> really be correct to say a machine running the previous microcode
>> revision is vulnerable.
> 
> There are literally two things this patch "says".  One is in userspace
> and can be literally read as:
> 
> 	/sys/devices/system/cpu/vulnerabilities/old_microcode
> 
> "You are vulnerable to old CPU microcode".
> 
> The other is in the code: X86_BUG_OLD_MICROCODE.  Which can literally be
> read to say "you have a CPU bug called 'old microcode'. (Oh, and I guess
> this comes out in /proc/cpuinfo too).
> 
> If you think this is confusing, we can document our way out of it or
> revise the changelog.  But we kinda get to define what the file and the
> X86_BUG mean in the first place.
> 
> I don't really see how it's possible to argue that they're "incorrect".
> 
>> As such, should the table of microcode revisions only be generated
>> from the upstream microcode releases that contain fixes for security
>> issues?
> 
> No, I don't think so. First, I honestly don't want to have this
> discussion every three months where folks can argue about whether a
> given microcode release is functional or security.  Or, even worse,
> which individual microcode *image* is which.
> 
> Second, running kernels with functional issues is *BAD*.  As a kernel
> policy, we don't want users running with old microcode. Security bugs
> only hurt our users but functional bugs hurt the kernel too because
> users blame the kernel when they hit them and kernel developers spend
> time chasing those issues down.

<Perhaps offtopic>

Probably the same reasoning can be applied here as for the CVEs - since 
the kernel (microcode) is a very fundamental piece of software, almost 
any issue can be treated as a security one (at least judging from the 
influx of automatically generated CVEs). By the same token we can assume 
that microcode always fixes a critical issue :)

</Perhaps offtopic>

> 
> So I guess it boils down to: First, should we tell users when their
> microcode is old?  If so, how should we do it?
> 


