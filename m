Return-Path: <linux-kernel+bounces-330411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07440979E2D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 11:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88F1C1F218F9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 09:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F24614659A;
	Mon, 16 Sep 2024 09:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="rUxSty4F"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD2112F5B1
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 09:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726478223; cv=none; b=P+cGhvviibRzJbus7Tdy8Ali3f0R27fCKDQFZIAe71FmKJJz4ov4cBGIN7LC/YR1QCecn9Tz0/AY6Pg/N1GzMDUd2VxPOfzBQbekV/vcJHveFPMswsGbpEVRuvzSoK9vg+YENzfuP3zh5h1IK1jwRa7OjWVkZxB1EV1fFuTcClw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726478223; c=relaxed/simple;
	bh=T6PZtUOFMvEB8M8Bs/2Gy77RXwOAUSMhILV2bvuH06s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QSEPUqakN6peLAl4U/mU6c6S7HmQnE/FpJPKKNNVlxt3t3F+fTVouH7RAQyMz8qb7K5UKuI1+Fm0G+jWyz+xDhzS6dCfzs0mxOZ2bL+1arhxiWFA3D6vt6LJaPkrG73A/M8KBMFqME8soNO820Oi7W85FvHAgdFrA4nKTEqUGbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=rUxSty4F; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5356bb5522bso3594394e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 02:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1726478220; x=1727083020; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=T6PZtUOFMvEB8M8Bs/2Gy77RXwOAUSMhILV2bvuH06s=;
        b=rUxSty4FSUxiGfGghiR2VyIxLpY7orpWzAxCqdy+0fkH9NzwJbBOE+xYm2r2AZdVPn
         Fsw5tyaI21DZ02SyhWzD7S0rUyhq7Rb+OTIrU023Y1YsmPP0Q5aXV/y55QtLsRz7SVXM
         GER5409dE0HIXRV542jbjdmaXa5o3fL2Jh3XA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726478220; x=1727083020;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T6PZtUOFMvEB8M8Bs/2Gy77RXwOAUSMhILV2bvuH06s=;
        b=PApDjv3Dle59cxdTTCb06egdX/z0ZKxxwubekMzjWBGTsZ6IdAe9h+g5vGKzfOyK6E
         hq/UVZ22ytnsKe6JZ7Spz1EZScaQe36yV9+P/8PXlMZzRrjqtU9b3G9H6UjxM0slnlA+
         XHziovDraE5R8yIYo8YkkpplL6q2KATalrZv1jMxxYg4CtNIdtwHuxDj1UtjlUpNWyQr
         8jFMUTZVMFSRCrdT1hwa7dGNqtYjhHwhaov7XztikkryxP+lj5ZDe7YpoWhG9F9EPtVx
         aSXy25JiXsJ0qYZflrJ4DfJYPbdQzAjfBJtlTLxOJFxj0xfuLJd5kXnfN4HSPmtJvpvB
         K85g==
X-Forwarded-Encrypted: i=1; AJvYcCVn3BnfMIQIzMbHHgJ0Ky/Xq0tQxjOHf8TKFxoOcsuYVh+4jmD/oxSRRqjyLXwyNOFnP3u8a+6uwXd6aZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxUksylQU0zs+tgUrbAKy3fMUqDHST9p1E1CnFfUy310G2qvfw
	d0+OWODINfxm/Tas4fQqf6HZL4AT0qQUV8sYxEBEvkQnysWRL+whhKyodIX1GCWH7PUGDR/YHrs
	T
X-Google-Smtp-Source: AGHT+IHcJGR44OVyCt7FqvZOnazyvOKO9D2BuwiVsNVjIbExemt/CzqLXr3xbecLLhtnoy9UsPEwZg==
X-Received: by 2002:a05:6512:b90:b0:530:ea6a:de42 with SMTP id 2adb3069b0e04-5367fee5467mr5213864e87.26.1726478219012;
        Mon, 16 Sep 2024 02:16:59 -0700 (PDT)
Received: from [10.125.226.166] ([185.25.67.249])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bc89313sm2305389a12.93.2024.09.16.02.16.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2024 02:16:58 -0700 (PDT)
Message-ID: <be9eaafc-a3cd-4c46-93bd-fe611a45c94f@citrix.com>
Date: Mon, 16 Sep 2024 10:16:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] x86/fred: Clear the WFE bit in missing-ENDBRANCH
 #CP
To: Xin Li <xin@zytor.com>, linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 peterz@infradead.org
References: <20240911231929.2632698-1-xin@zytor.com>
 <04674df0-a026-42d1-aacf-293f3018329f@citrix.com>
 <5cc939d6-c5f5-410c-b7a2-3e96fe7f1fae@zytor.com>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <5cc939d6-c5f5-410c-b7a2-3e96fe7f1fae@zytor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 15/09/2024 7:17 pm, Xin Li wrote:
> On 9/11/2024 4:35 PM, Andrew Cooper wrote:
>> On 12/09/2024 12:19 am, Xin Li (Intel) wrote:
>>> The WFE, i.e., WAIT_FOR_ENDBRANCH, bit in the augmented CS of FRED
>>> stack frame is set to 1 in missing-ENDBRANCH #CP exceptions.
>>>
>>> The CPU will generate another missing-ENDBRANCH #CP if the WFE bit
>>> is left as 1, because the indirect branch tracker will be set in
>>> the WAIT_FOR_ENDBRANCH state upon completion of the following ERETS
>>> instruction and the CPU will restart from the IP that just caused a
>>> previous missing-ENDBRANCH #CP.
>>>
>>> Clear the WFE bit to avoid dead looping in missing-ENDBRANCH #CP.
>>>
>>> Signed-off-by: Xin Li (Intel) <xin@zytor.com>
>>
>> Ah - good.  Finally some evidence that this hole in CET has been plugged
>> by FRED.
>>
>> However, I'd suggest describing it differently.
>>
>>
>> By definition, all missing-ENDBRANCH #CPs are a result of WFE && !ENDBR.
>>
>> But, in original CET under IDT delivery, any transfer for
>> interrupt/exception/etc that does not change privilege will clobber the
>> WFE state because MSR_{U,S}_CET.WFE is intentionally set by microcode so
>> as to expect to find an ENDBR at the interrupt/exception/syscall
>> entrypoint.
>>
>> In practice, this means interrupts and exceptions hitting the kernel, or
>> user interrupts, loose the WFE state of the interrupted context.  And
>
> loose -> lose?

Yes indeed.  Sorry.

~Andrew

