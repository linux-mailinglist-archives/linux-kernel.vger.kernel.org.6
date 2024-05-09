Return-Path: <linux-kernel+bounces-174283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50BD08C0C7D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 10:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CE0E1C21893
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 08:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3F4149C7B;
	Thu,  9 May 2024 08:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Wa44uraL"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2461414A0AA
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 08:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715242910; cv=none; b=U1LzPuH+JoJ0goGBMS+7TQgOet30EFL97Ikh4Ab+F0VsNrCwAu/KiArKUwNRn2/UN58ddkmih3exPJ9u2+fczN70QTIuahbdXZsNTu47deA48oAd4KS7cXhHO5gdqwLEZnK81GYvixiJtltjqbPq5PGQMPQ59Ydt3XabLpPhjMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715242910; c=relaxed/simple;
	bh=IXqoH3hnQ35zr7yeunibtDNWu/kksJKf+G6m/To04QM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BDaVPV8Xxce2b3Tp6SofbN6RrjduSxhB3m1EL8llr0nihmf4MTw27NoRu9uYLA4YsQwN9W5B2aVKNfVGaxFJj9kRD6XZAul+qA01U8SqAgNB8yOimfvdBlVDHFgHgOg63OEIPmVSZt8/8DAboU7qlqD7kCu3Bpu7zSDxIiFXWGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Wa44uraL; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-41c7ac6f635so3733035e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 01:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1715242906; x=1715847706; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L9OBZbvS0WP26j2hKZQO9jjPKnz/pC2a+sctlFlJyyM=;
        b=Wa44uraLCCwKvAboiaLFGAQe6hi2rSBb2mhvrZhIoWItBTJ6QGn1RDrPuKLfBPOQgV
         Z0tAuJDH+TgULe9dnvtb9KyupCj5mGNdQ5FnkERz+AI1Sp1OeP04m5LtCdgLZhLR1hnt
         cMFL/kWN5F8Q1UfERy3mnwaXBtEqQp0fHX3hop63meSMLoAVevKdfrDlTtsWgQJklbQz
         bmrhYnK7df0cPIrnuH4OhZ272+D/k8TUb4L4SDrgndG3qqBZq5ANAQ/jpe6wekPIqcMh
         YkhfMoMOGW2Bk7FQJNvoQkSBwFNXPLtgz27rqLvn+zHtfKUKhoQxl0cazyg4OyA5gt6x
         8Xyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715242906; x=1715847706;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L9OBZbvS0WP26j2hKZQO9jjPKnz/pC2a+sctlFlJyyM=;
        b=MNF0Q+3dZQhxIqkD4GWh4InphBJ4ga2gPIb1+2eaSt1MqwQG0Ycz1Kl1lFbmnYz1o/
         v4dfJYnci2WiywnhF3DIOasP/AT80ttd+4Q+IMDl9TCKi/KfY3yck5hfwrmh2dFK4cyL
         IIfhIP4R+yki3Zq4EPhB5ey9rL4rl0nyi+hvEsdJa+M7870DnpAbSNbB40aqyYD+H1Jt
         38jOE3/jMoi6wUypK3zMrXwH7r9546HBqQyeFvC4jG6sKiI/RkqXigsHXbj+sL+7TSyb
         G8idtfIOeToJa1mxZdCRt07TJ1RXzLTDJK5tCrejzI+G0tCDiLDscE0fcC/IOyBgQbkd
         jHNA==
X-Forwarded-Encrypted: i=1; AJvYcCUPvcaPlVwskl7fRirAcnEBo21gVzAOEyqHTwnVBE2yV1BPiQoS245S4KH2dEJU9tkg320euV6FltKEB8hTXB4g5NQH0tjiO57RZsgp
X-Gm-Message-State: AOJu0YyTOBoa4Ug9UAmLGuHn64aVJx6Y/HYSCKKQe9SlOb9NxrZJBS6n
	4mtuWtAEpLD08UcMb8YGoHw1vb7N7MnRNh6Er3eTKBF0dkktlS6l79YN+KYF5Wg=
X-Google-Smtp-Source: AGHT+IHPuleqIxD3VbBswpLKPEot5Wdxn0zjeY5Ob4s7b7lk2pbEtcKSrp4v7UithB94OfgjP9O2xA==
X-Received: by 2002:a05:6000:136d:b0:34c:5e02:7875 with SMTP id ffacd0b85a97d-34fca433f91mr5870618f8f.7.1715242906276;
        Thu, 09 May 2024 01:21:46 -0700 (PDT)
Received: from ?IPV6:2a10:bac0:b000:7315:9ae2:bce:2143:58f1? ([2a10:bac0:b000:7315:9ae2:bce:2143:58f1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502bbbc3e4sm1025016f8f.108.2024.05.09.01.21.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 May 2024 01:21:46 -0700 (PDT)
Message-ID: <60ddec81-5102-4984-848a-ae3adb8c4c38@suse.com>
Date: Thu, 9 May 2024 11:21:44 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] x86/bugs: Add 'spectre_bhi=vmexit' cmdline option
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Daniel Sneddon <daniel.sneddon@linux.intel.com>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Alexandre Chartre <alexandre.chartre@oracle.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sean Christopherson <seanjc@google.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, KP Singh <kpsingh@kernel.org>,
 Waiman Long <longman@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Ingo Molnar <mingo@kernel.org>, Maksim Davydov <davydov-max@yandex-team.ru>
References: <cover.1715059256.git.jpoimboe@kernel.org>
 <66327dcf87284a09ed17ac24227695ea3ba1f287.1715059256.git.jpoimboe@kernel.org>
 <f48601e1-e8a6-4161-9a77-32ad10c887de@suse.com>
 <20240509052447.kwdlruqad7r5h4pi@treble>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <20240509052447.kwdlruqad7r5h4pi@treble>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9.05.24 г. 8:24 ч., Josh Poimboeuf wrote:
> On Wed, May 08, 2024 at 06:10:21PM +0300, Nikolay Borisov wrote:
>>> @@ -1659,19 +1662,22 @@ static void __init bhi_select_mitigation(void)
>>>    			return;
>>>    	}
>>> +	/* Mitigate in hardware if supported */
>>>    	if (spec_ctrl_bhi_dis())
>>>    		return;
>>>    	if (!IS_ENABLED(CONFIG_X86_64))
>>>    		return;
>>> -	/* Mitigate KVM by default */
>>> -	setup_force_cpu_cap(X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT);
>>> -	pr_info("Spectre BHI mitigation: SW BHB clearing on vm exit\n");
>>> +	if (bhi_mitigation == BHI_MITIGATION_VMEXIT_ONLY) {
>>> +		pr_info("Spectre BHI mitigation: SW BHB clearing on vm exit only\n");
>>> +		setup_force_cpu_cap(X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT);
>>> +		return;
>>> +	}
>>
>> nit: How about setting CLEAR_BHB_LOOP_ON_VMEXIT unconditionally, then
>> afterwards checking if MITIGATION_VMEXIT_ONLY is set and if yes simply
>> return, that way you don't duplicate the setup of the VMEXIT code
> 
> I think the duplication actually makes it more readable.  In both cases
> it puts the setting of the features together along with the
> corresponding pr_info().

Right, my suggestion also meant that setting + pr info will be together, 
unconditional and if MITIGATION_VMEXIT_ONLY is set we return early, 
without setting X86_FEATURE_CLEAR_BHB_LOOP. In any case it's a minor 
remark, feel free to ignore.

Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>

> 

