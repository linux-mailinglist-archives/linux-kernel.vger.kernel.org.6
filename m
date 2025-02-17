Return-Path: <linux-kernel+bounces-515562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC88EA36644
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 20:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5022A188747E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 19:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF411ACEA7;
	Fri, 14 Feb 2025 19:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="T0arnYQB"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737A81A76BC
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 19:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739561967; cv=none; b=RE3PyB/t0OIUICAL7HKnE5oHW7rbQi4tkLzO/zTDKbNA91M7aY49PxFG4thToCX+CyTsSOf8dhTPG3Js4ffHprOK6WOtay3FIk0a5XCeb9X4bSiYZr1Z7ZNdxcUSsRYzHclWt4pS8YR8TUw9fI1p98xG4a3izzol2f49zhybync=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739561967; c=relaxed/simple;
	bh=xhXR7WiXEbWEK9s2/hr//izmZeE0Z65b63Lpwf4elBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lQz9/p0x0xzvavYmLHmL4brTh838vKwgmR0xI+i6hU/UuU4G3mOXaAK+dr8v26Nh1E38Cc7icoyI+v9qA8+AgIxsJ92R2dPHtnID6Catos238dnMYTuKf3vBwVTM4OE8pIf1ro4s3kkKcTpl9fKSXE52HuSs2NNBuzI5rbLW4gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=T0arnYQB; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-38dc0cd94a6so1277438f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 11:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1739561963; x=1740166763; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mPz8IwHa6sNCZcb7usnuOuGvQU6AOa9aG4kdF5DAJnM=;
        b=T0arnYQB0Mum4/1p/T/amTh5YxCFQubCmAtLSUrJ77f+nnKUOTDjLE6ulY8gfX8A+1
         joVsgjkpX7ekiJTDZqoZUU64a1ACYF4sagWyJ3f3HsPA5tOyZ20ul68eiRNHZbrqh9UU
         MTYZFLzdMqTvXJ4NSAmtdBYlVp0MvQsfFz/wk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739561963; x=1740166763;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mPz8IwHa6sNCZcb7usnuOuGvQU6AOa9aG4kdF5DAJnM=;
        b=XF6x28Z52PbrBVXFoIFg9S/My7T/6CXV/GmfhvKv7/1eq8z/S2BN8x8xyHme/Lzzun
         4FvXg7iCw7ee1VGZ/uGPIz3YUY610bOPhdaWDQLjBMLYMao4pkrdhc3sFXqOcWPd4QsL
         Z7/I1z6tzqYmlNi5cC3GZnHkhmcTSbEckoZNXXFpICVSffR7hOBPVqh5PriGJgQ+A7Pw
         +aj7isR+QNQHu7Ws3eFkno8S98GK3xq/wu8iggNl31Us8JvTKfwO4y2wBr6Xn+AZSyzL
         5k5Z2QMaoQkkgBgcTCe2n9K+V0v5DYu1EN21dXVsuo+YWYqpZJkUg0yhWu6u0KRRWoCY
         FRXg==
X-Forwarded-Encrypted: i=1; AJvYcCVfsaKXgzq5Ql/+8kappFow3AtC1Am6LqIFHyOVMH6OcO3rx9Q7OBHTZaioJbfXZSFVgvXydMtrE36GxD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxLhG/+eM+NpyB52pOubBnkUd7rhhLbV7Aq5O0NbStXuWbQjjX
	5JnpMNX4eGPtQPz1/Z6UboSk6WkyNIByPlxF1q1H8YIyRBvMaZCJKLAY3qRyh2KEmvnIBZ5Eck1
	R
X-Gm-Gg: ASbGncu8KR942YvBdMI23nro4+wlyL4l+2NqHKj4Actq1a25Om8XF85QFylgJzBAGPt
	Yx/aOPwNtTpmP9W7/jyvlGDJsQkRbrvX4xIFxrm5WiTr8YWV9iEIDQ6Zoj8387GwEef9VDtvZNY
	d2vlJAD7D7NAXPnxsIHtddthlWQh5dFSRqzMH26Sbjy207SzTa47aGmFOw0sZT4nGjM3Lgcy+8E
	bTsTpBrlTdlL0tPe7JVAzwwEvRYnCWa03mr6uhZfnwBAQWOVYfKlvlBKPTNgvbwoBJh3FPsmv9v
	g4kvVRtvzlrgEfZp7tv+l0tFpM8h71IutOHziR8oabO808ws6ChLjN4=
X-Google-Smtp-Source: AGHT+IFUhys7D9vWfzjIblReIoA3OOJ9K1R36zWonnWpiLefrqsA+SQs+pRupA/XwizeDpiM4xlGGA==
X-Received: by 2002:a5d:6da1:0:b0:38b:d824:df3 with SMTP id ffacd0b85a97d-38f33f2e90bmr366777f8f.24.1739561961875;
        Fri, 14 Feb 2025 11:39:21 -0800 (PST)
Received: from [192.168.1.10] (host-92-26-98-202.as13285.net. [92.26.98.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258b410dsm5390540f8f.5.2025.02.14.11.39.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2025 11:39:21 -0800 (PST)
Message-ID: <5d26bcdf-0e72-45b6-98c5-f90481650f09@citrix.com>
Date: Fri, 14 Feb 2025 19:39:20 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/kcfi: Require FRED for FineIBT
To: Kees Cook <kees@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: Jennifer Miller <jmill@asu.edu>, Sami Tolvanen <samitolvanen@google.com>,
 Jann Horn <jannh@google.com>, Nathan Chancellor <nathan@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Alexei Starovoitov <ast@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 Rik van Riel <riel@surriel.com>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20250214192210.work.253-kees@kernel.org>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <20250214192210.work.253-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 14/02/2025 7:22 pm, Kees Cook wrote:
> diff --git a/arch/x86/include/asm/cfi.h b/arch/x86/include/asm/cfi.h
> index ef5e0a698253..dfa2ba4cceca 100644
> --- a/arch/x86/include/asm/cfi.h
> +++ b/arch/x86/include/asm/cfi.h
> @@ -93,7 +93,7 @@
>   *
>   */
>  enum cfi_mode {
> -	CFI_AUTO,	/* FineIBT if hardware has IBT, otherwise kCFI */
> +	CFI_AUTO,	/* FineIBT if hardware has IBT, FRED, and XOM */

You discuss XOM in the commit message, but there's no check ...

>  	CFI_OFF,	/* Taditional / IBT depending on .config */
>  	CFI_KCFI,	/* Optionally CALL_PADDING, IBT, RETPOLINE */
>  	CFI_FINEIBT,	/* see arch/x86/kernel/alternative.c */
> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> index 97422292b609..acc12a6efc18 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -1323,7 +1323,9 @@ static void __apply_fineibt(s32 *start_retpoline, s32 *end_retpoline,
>  
>  	if (cfi_mode == CFI_AUTO) {
>  		cfi_mode = CFI_KCFI;
> -		if (HAS_KERNEL_IBT && cpu_feature_enabled(X86_FEATURE_IBT))
> +		/* FineIBT requires IBT and will only be safe with FRED */
> +		if (HAS_KERNEL_IBT && cpu_feature_enabled(X86_FEATURE_IBT) &&
> +		    cpu_feature_enabled(X86_FEATURE_FRED))

... here.

Is this meant to be "/* TODO: wire up XOM */" or is that accounted for
somewhere else?


Also, while I hate to come back and contradict myself from earlier...

Architecturally, FineIBT without FRED seems to be no improvement over
simple IBT.  (I'd love to find some way of hardening the entrypoints,
but I can't see a robust way of doing so.)

However, micro-architecturally, FineIBT is still far better than simple
IBT for speculation issue, seeing as Intel keep on staunchly refusing to
turn off the indirect predictors by default like AMD do.

A security conscious user ought to be using FineIBT for this, given a
choice, even if it's not perfect in other regards.

~Andrew

