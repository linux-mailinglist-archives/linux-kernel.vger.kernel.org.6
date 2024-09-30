Return-Path: <linux-kernel+bounces-344925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9F498AFC9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 00:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 017A31C215EB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 22:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713D818890B;
	Mon, 30 Sep 2024 22:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="ZgmbN1vV"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2AE185B74
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 22:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727735022; cv=none; b=rIftKOvk+o8DfEDg4aw41sy+BJBPMu5A25SmURINeY8Ru3WKj/g2VF2twfWW2geDU5v+AhX5QNtE6wXUxKNVxuGaXrZLf3+/H4Ll0l4Zf7FChPJD3mvDgjCHY4WyLurQi5lBJAzcpKxn+VWlVJeUAs6wMB1Qjf7Au6ueOMO4OBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727735022; c=relaxed/simple;
	bh=iquXeB+u0aGbybYuqKzZeEfrH0zaRrbLCAid4Q/AYXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CGqTCXP4AhgUB5F/nXSX01Gat5hVmneofZEwQaMV5ZUO25ZX4ojkFN8CKnH+s3EJ15/Z+S0a9cfbuIFC4OdOa4otNDPNHiyle+1HBJjL/LSIJ8fjVmv7pba3BIWi/JQKi3xMhxzZYVP5dmGyChsLy6f0oHKWyLGmohP4E9byLA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=ZgmbN1vV; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c5b9bf9d8bso3510276a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 15:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1727735019; x=1728339819; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bB/THqgMzFtAK1FBogY3kWexpSacXYbvofHmjtuOpA4=;
        b=ZgmbN1vVaI+zEWXSk4FkuCnn5/9JKxXHhIxSBP1vBVclLhQYS7wersbRA3J/lvKfMr
         ruhfgiVMXZslPwRGSJK2QRbIzD6tAN7tGOCrgt6uq/LPKYGfnAXblNR7txwOdxAPUd6u
         MLtZ0HmsAFX8w7pzZwDEF7cZTuN9Sp6aSnFeo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727735019; x=1728339819;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bB/THqgMzFtAK1FBogY3kWexpSacXYbvofHmjtuOpA4=;
        b=iCsFgZyk25Z5Eff8ecFi8r6sQT4Y+bLNhkgj7X3XYVsSKMTjkTXjBxpjtt9m3uJzbZ
         lpXm/iNhXjnR9x0LhO5Sz2fwNTUAC600+fa2NN0ikyJlVK8qKZw4I0MYzJbKeWcwjqYT
         R/RS1GpF7sog4DL3svBvoLuWdSupwgFjDltlPcKMvpd/bF2RQB3954vJzoaJP3uzo6sx
         2OAwupn6zlwOCmxP7AUeVIX7tHWPY8QU8jr86/NiyZ1nAEff4tVjxxEqJA1Rk1IbxY8O
         1/Cd6zAovWyYilqqwneDJvhWQwMVv3rXWovf8f1q/UlAQknoimAmaNGmsHfKtfkSrJn6
         VOZg==
X-Forwarded-Encrypted: i=1; AJvYcCVBa/4tMym80JyQFYBCVVvvunapFCa1uwSRDFaKmONojEvaAMVOz2r3uO4WnBEc0ymf2RWj1gAlhId7fns=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj7nwvZ4BE/ZmIBU7Ovf0LgWscdQ9AMOBYMxQBLq2pCJTlr5z6
	Ya2Sk9s0E8Z5HDvXVQz2/jvWeR9dGI/8my4uGGt80p+yUJDJzEZMP8HEZAOKrLQ=
X-Google-Smtp-Source: AGHT+IEsNGtyVLM7Ziu0LpZOFS87o73GBiIRxN+t7uvntjBsba0d5hmstqLqzAwnKB1VzZxiwOUKsQ==
X-Received: by 2002:a05:6402:1ecf:b0:5c5:b7fd:170a with SMTP id 4fb4d7f45d1cf-5c88260391amr25036459a12.28.1727735019477;
        Mon, 30 Sep 2024 15:23:39 -0700 (PDT)
Received: from [192.168.1.10] (host-92-26-98-202.as13285.net. [92.26.98.202])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c88240a8e9sm5125834a12.36.2024.09.30.15.23.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2024 15:23:38 -0700 (PDT)
Message-ID: <54d392d3-32b3-4832-89e1-d2ada1af22a8@citrix.com>
Date: Mon, 30 Sep 2024 23:23:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/14] x86: BHI stubs
To: Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, alyssa.milburn@intel.com,
 scott.d.constable@intel.com, joao@overdrivepizza.com,
 jose.marchesi@oracle.com, hjl.tools@gmail.com, ndesaulniers@google.com,
 samitolvanen@google.com, nathan@kernel.org, ojeda@kernel.org,
 kees@kernel.org, alexei.starovoitov@gmail.com
References: <20240927194856.096003183@infradead.org>
 <20240927194925.707462984@infradead.org>
 <20240930213030.ixbsyzziy6frh62f@treble>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <20240930213030.ixbsyzziy6frh62f@treble>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/09/2024 10:30 pm, Josh Poimboeuf wrote:
> On Fri, Sep 27, 2024 at 09:49:09PM +0200, Peter Zijlstra wrote:
>> +/*
>> + * At the function start, launder function arguments that are a pointer through
>> + * CMOVcc, this will create a write dependency in the speculation flow.
>> + *
>> + * Notably, the CFI preambles calling these will have ZF set and r10 zero.
>> + */
>> +
>> +.pushsection .noinstr.text, "ax"
>> +
>> +	.align 8
>> +SYM_CODE_START(__bhi_args_6c1)
>> +	ANNOTATE_NOENDBR
>> +	.align 8
>> +SYM_INNER_LABEL(__bhi_args_0, SYM_L_LOCAL)
>> +	UNWIND_HINT_FUNC
>> +	cmovne %r10, %rdi
> IIUC, this works because if the "jz" in the CFI preamble mispredicts to
> the __bhi_args_* code, "cmovne" will zero out the speculative value of
> rdi.
>
> Why use %r10 instead of a literal $0?  Also how do you know %r10 is 0?

There's no encoding for CMOVcc which takes an $imm.

%r10 is guaranteed zero after the FineIBT prologue, but I don't see
anything in patch 11 which makes this true in the !FineIBT case.

~Andrew

