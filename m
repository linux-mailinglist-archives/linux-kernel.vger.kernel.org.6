Return-Path: <linux-kernel+bounces-194599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C4D8D3EBB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 21:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BC2EB23599
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 19:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB3B15D5B9;
	Wed, 29 May 2024 19:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="MwBE7Z6b"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B583D6BFBA
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 19:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717009332; cv=none; b=V/RlGOivFDCD9zevIR3sZFoAUYEfjwisPW49AJCQ3hN5J3DWNNIHEkyGqFKb9q2INyfEJqBlE3592RYpI1/u0uUW2R2M4e3p2Il242dYT3VFW7zxI2UkPdCpKo+qWZ1EsABDYK9m8V7gk/bbr/7vXCvEJoEzBTNiAtigIz1A7k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717009332; c=relaxed/simple;
	bh=a0VD/WIcPZ5qaTNMLP3EsRq5AZnfcg/iweV1UsyJlEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c+f7OPXPn1w9yS+RPS+Fa+uEqsUKYUy28UCi6XiKUXY4A8+7siG6yX3z3jziO5KedAsYtXVFOF+NzdwvmN0wYrgB4g5qbmtDTwfmdOLqRFzVBEhNsgRwETTG+7b91AXr6wigfqz6x6FthwbCPmKCfHLhehDtUBsnK+H2pWQ9VmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=MwBE7Z6b; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7930531494aso10547785a.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 12:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1717009329; x=1717614129; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8GwTUMXYAxiAKC6EgbG+7U7zjWZSxba/eTmbEIDHYag=;
        b=MwBE7Z6bngvx1i1AzLX/mmsXre39JH0AMrJNU3L5Z9t8wAh5VoUxhMtjpc6/j9XMJp
         GcENn05nMW6CVIO55VgW7Sf8Nz4l6V5k1+ILWGvgxX8wVkQ/z4iUHP1M1RNp01EZSK/X
         /rtoPUSGmX5J/jud897mB4fFHsM7nqLOt6nws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717009329; x=1717614129;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8GwTUMXYAxiAKC6EgbG+7U7zjWZSxba/eTmbEIDHYag=;
        b=nD6zFIZ3bGpUoDwpcGHHZvB0tMi7hJWrOOexqhaWHQprqr4FV8BYcmQrQ1/UNIcmKF
         wwK7Ue0gTW1BPdEgSYiZ2dXz+z5lPydhxU4Ed4WuDmfakekrG+vu2uXl+bbzMVXByMYF
         L2BmZCchs7eBeoURq+ZSGr1h8UvR3RZiy3RVfRFqmbPIQ7WFwJaKnY1j4bhIxbPujLh6
         hW79MKnrwMvmcdy4HgTSxVVJAt00qmPwxW75VMf4PfcCKlELkHInjQrFbM9WBWYVOSiN
         HWQMkOAGHsi3gMS9uQ7ssqQ5dwXZpilqxh3I/Du+wGN5hWGXtMGw8LJ0+1hvvbUj3HXB
         aqKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRzSM5+Cs+JmAJxEz609B/Oh/a5RpNouSkHDv0i/vXajRghgx9GlzpT3LWApBv30Porer9ir8U9GJYPLOc2Q0DoEa4+TSLYDC8V2Pc
X-Gm-Message-State: AOJu0YwdGE0zRAoUa44BkqWFsPs1/q39ZO9gsyWqnCvFmNyst9Lsou8Q
	FWIvQTKCM+k9BKqn/PJj3Sdv9i9BzLFaiEpfaKsHW0O6i6Cl+q/Deq0Ftdt8Pqo=
X-Google-Smtp-Source: AGHT+IHDrykJ1fMgEjaJg2c9DXIPWFoeHtrr8K89VszE+xmesbuZ4BjPbpmSZgOtjM0g1rprUUfd2g==
X-Received: by 2002:a05:620a:2982:b0:792:9403:3aa8 with SMTP id af79cd13be357-794e9e0debfmr6863685a.58.1717009329450;
        Wed, 29 May 2024 12:02:09 -0700 (PDT)
Received: from [192.168.1.10] (host-92-26-98-202.as13285.net. [92.26.98.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794e0cbb512sm80039185a.51.2024.05.29.12.02.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 May 2024 12:02:09 -0700 (PDT)
Message-ID: <3ad4e909-9456-41ed-9fed-906c6c000d5f@citrix.com>
Date: Wed, 29 May 2024 20:02:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/cpu/intel: Drop stray FAM6 check with new Intel CPU
 model defines
To: "Luck, Tony" <tony.luck@intel.com>, "Hansen, Dave"
 <dave.hansen@intel.com>, LKML <linux-kernel@vger.kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "Schofield, Alison" <alison.schofield@intel.com>
References: <20240529183605.17520-1-andrew.cooper3@citrix.com>
 <8ef9d8ad-9236-4254-b819-50832cd05cd9@intel.com>
 <SJ1PR11MB608327E76C4C90EAA3452D76FCF22@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <SJ1PR11MB608327E76C4C90EAA3452D76FCF22@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 29/05/2024 7:59 pm, Luck, Tony wrote:
>>> The outer if () should have been dropped when switching to c->x86_vfm.
>> FWIW, we are going to need to do a pass over all of arch/x86 looking for
>> these.  I suspect many of the 'if (c->x86 == ...) ' checks can go away
>> like this one.
>>
>> Thanks for finding this one, though!
> Yup.
>
> Acked-by: Tony Luck <tony.luck@intel.com>

Thanks.  FWIW, none of the other uses of c->x86 I looked at seem trivial
to convert.

This one I only happened to notice because it stood out in context.

~Andrew

