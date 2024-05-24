Return-Path: <linux-kernel+bounces-188971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B498CE928
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 19:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 340661F21712
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 17:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8E412FF98;
	Fri, 24 May 2024 17:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="cod7Bk1x"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DC112E1E4
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 17:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716571073; cv=none; b=GqDQJnbnAZJOMAOScofQL4/yTwSOyIpUC0NjY+DvYW8WdhbDQlCRTYUNvf9EiateD9DYT7c/j6ZgPiKCBvxcjUFQHYzHLv7kS8M1+Cs4gX7cv1meymHRohFn5slbfRkV8tTgbXmkgCwKa89ii21tPurnZJ1GWHUpHSeMUT/jT8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716571073; c=relaxed/simple;
	bh=aP0165QcLcHzLMJYEu7SmZ+MzBAnpItX430VOnNGL/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q/OzXAEXlrWS5fXr6fTAv7+0UsMdoHC9Hp8mddIzlHTdKvbIkajUxn5tFUtwwUYKwqc5XLqqekoFW+TKnskLqMnHqicvCsBYWGoqVwPST1Hg79NUQc1r7C9phyf9MNII6okk91ybBW3rUAq9pr0OMo3powurdw0zRq6kyPjjzwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=cod7Bk1x; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6ab975abb24so10457436d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 10:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1716571070; x=1717175870; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WUUxz5qySMlLMqK3AlZAbp/sidfKbTTTihQT5JLcleI=;
        b=cod7Bk1xKdT0eVdIvOj5xx3bHwDZRYc8cb/w1fjTJS4TnlFwwhB3zkvh1S5ymdD7ye
         cPbEGGfGvYg+P6IScIuFvrlQObUV/SRJvRH7nwPC0uHQ8gFk9DX8M6p+gctLDM08kJDi
         O4Q30rW53Zu9dWQoJMsrq+ZyStN/wXCIk/DZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716571070; x=1717175870;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WUUxz5qySMlLMqK3AlZAbp/sidfKbTTTihQT5JLcleI=;
        b=EHOxTTQneyDPWsD6fnaXNTYiEepMExJhcZThrbktuMl1BP2diVbSBf4W6+mBxCb32s
         th2f+IURqmhw4twqAyw2ehDCQFIAQSm91A1QRLv2WVdlJUGK03I7TX3Rv/dWQwgiZeoe
         FUK08q1m+aPY/xbEqH/JVK6OVS8/wKJeTW/5L2x9pSpBjrchqsJVwPSC9g8UyAaViIxo
         +x0cs8iGy0lmJ/qMrn7CUqlQRLOFTQHY/EV7QbsRQ9+fdReGDWGwJPepSj5wEpM3C5Ys
         haHoigbI0DLcvkO/oGsE5P3yiQDggos39DMz+KaQPuapgdSMCCzlpSx5542JiWC9d74j
         ZyRQ==
X-Gm-Message-State: AOJu0YwDEO1pSlAxjvdM0gES8mSsgxHU+0hx/el2PYsZIVP7uUnIka6O
	eFW283Wrr30LOMO1NBjFwLsL8sMbTHwbiBFylmRTq02DKv/ZbFyTQyf1od0dMBA=
X-Google-Smtp-Source: AGHT+IE0OlUSmCf+vA2Bi9uY3k9E09THPtvrJH1In6r2i3fDfePJETCBKA4x+i9M5nI7mHOelosTAg==
X-Received: by 2002:a05:6214:5503:b0:6ab:7ab6:a0e8 with SMTP id 6a1803df08f44-6abbbc7191emr27473686d6.25.1716571070230;
        Fri, 24 May 2024 10:17:50 -0700 (PDT)
Received: from [10.125.231.30] ([217.156.233.157])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ac16321a47sm8919966d6.130.2024.05.24.10.17.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 May 2024 10:17:49 -0700 (PDT)
Message-ID: <a5411542-7d63-4169-9529-4a5ef7b69212@citrix.com>
Date: Fri, 24 May 2024 18:17:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/bhi: BHI mitigation can trigger warning in #DB
 handler
To: Alexandre Chartre <alexandre.chartre@oracle.com>, x86@kernel.org,
 kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, daniel.sneddon@linux.intel.com,
 pawan.kumar.gupta@linux.intel.com, tglx@linutronix.de,
 konrad.wilk@oracle.com, peterz@infradead.org, seanjc@google.com,
 dave.hansen@linux.intel.com, nik.borisov@suse.com, kpsingh@kernel.org,
 longman@redhat.com, bp@alien8.de, pbonzini@redhat.com
References: <20240524070459.3674025-1-alexandre.chartre@oracle.com>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <20240524070459.3674025-1-alexandre.chartre@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/05/2024 8:04 am, Alexandre Chartre wrote:
> When BHI mitigation is enabled, if sysenter is invoked with the TF flag
> set then entry_SYSENTER_compat uses CLEAR_BRANCH_HISTORY and calls the
> clear_bhb_loop() before the TF flag is cleared. This causes the #DB
> handler (exc_debug_kernel) to issue a warning because single-step is
> used outside the entry_SYSENTER_compat function.
>
> To address this issue, entry_SYSENTER_compat() should use
> CLEAR_BRANCH_HISTORY after making sure flag the TF flag is cleared.
>
> The problem can be reproduced with the following sequence:
>
>  $ cat sysenter_step.c
>  int main()
>  { asm("pushf; pop %ax; bts $8,%ax; push %ax; popf; sysenter"); }
>
>  $ gcc -o sysenter_step sysenter_step.c
>
>  $ ./sysenter_step
>  Segmentation fault (core dumped)
>
> The program is expected to crash, and the #DB handler will issue a warning.
>
> Kernel log:
>
>   WARNING: CPU: 27 PID: 7000 at arch/x86/kernel/traps.c:1009 exc_debug_kernel+0xd2/0x160
>   ...
>   RIP: 0010:exc_debug_kernel+0xd2/0x160
>   ...
>   Call Trace:
>   <#DB>
>    ? show_regs+0x68/0x80
>    ? __warn+0x8c/0x140
>    ? exc_debug_kernel+0xd2/0x160
>    ? report_bug+0x175/0x1a0
>    ? handle_bug+0x44/0x90
>    ? exc_invalid_op+0x1c/0x70
>    ? asm_exc_invalid_op+0x1f/0x30
>    ? exc_debug_kernel+0xd2/0x160
>    exc_debug+0x43/0x50
>    asm_exc_debug+0x1e/0x40
>   RIP: 0010:clear_bhb_loop+0x0/0xb0
>   ...
>   </#DB>
>   <TASK>
>    ? entry_SYSENTER_compat_after_hwframe+0x6e/0x8d
>   </TASK>
>
> Fixes: 7390db8aea0d ("x86/bhi: Add support for clearing branch history at syscall entry")
> Reported-by: Suman Maity <suman.m.maity@oracle.com>
> Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>

Reviewed-by: Andrew Cooper <andrew.cooper3@citrix.com>

