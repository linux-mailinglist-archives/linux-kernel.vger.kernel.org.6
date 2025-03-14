Return-Path: <linux-kernel+bounces-562269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27642A620D7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 23:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D90446131E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 22:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14321EDA1E;
	Fri, 14 Mar 2025 22:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="MjMmRbLU"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0121922DE
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 22:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741992701; cv=none; b=cEm2pBM1wno1tEvn+Yv4+obxVBBTyLb2pn55237NExP7SIaPqxGq7+MMD0LAtJq2hfb3UcIlLiSqef1umDpQ+INQK0feNv8VWTCa9wRp1ZOyXC+7Dm3dRGUcxEBwyWUtt4RnSIjNit0nVrxMnsDZCWCRnPZG66HbXNo/RwYTcUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741992701; c=relaxed/simple;
	bh=4gsZ4m1kHf3BGFSOL7yk57cso1LQSOwXnOHZ/4rbT2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VjZ0acNpvk1/4oF8ZvRQU19RG5LNsHnckLiuQ9YD6LZLCTsg4nDxIg/Y2j74auxiiNXQcBc8XxBYP7vBuPpQar8VVFx7ejve8OWuIgzMDe2F34h2xYtJJi2asyH94dN49X6ehtS+6ARmMN1N1XVbB+iQGpmS+hygNQhI7AS2+zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=MjMmRbLU; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac2dfdf3c38so485137566b.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 15:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1741992697; x=1742597497; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LNuopg2At9pwbYv4+F2y2ceVbOgXNoMsyFZWZzEtBfM=;
        b=MjMmRbLUErg39B8jUvTY5nWLhxxyXHpdJrWlfCyDwXlBPp/Gpv4Q+OODotIijhBSqe
         mnV/LgmpWQ6njDbEaQ7CzAgaK0jYKt8PchLh7I+n81d6Ex59yrU2kaUuCwE7mUroaH5s
         N3iAW/OD5AicHB926ImcstdgCKt6ycI956EeQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741992697; x=1742597497;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LNuopg2At9pwbYv4+F2y2ceVbOgXNoMsyFZWZzEtBfM=;
        b=J/cl06U3ET6y46SqIg0R/5Te+6jTqnSbAjwv5XinbZqcDDgwSgcKSDKr2j1hDAM2nt
         DsUPh2mIOHlaXsSBVFRuU8ulvep9LnKRwENtMMg4pYiI8fy9pjgxGz10Isxu8lUonyHC
         qFST0esvharnsZj7C9TuovLEJ4wJ9dw8CG89lMfapYldlZNDeO260LEl1qVYfw+UUODU
         r9nhQNFq9aR78ZT7d4WumgfbzLhTNY/bxdw9nQH6vGjQFxFVUb4GqdUTyxdhZD5h6InS
         qb1bCs+ZdrKT/HjZ0NWndsE9n7SCJicZi52pkam29gdEaNWOE4k1Gb/3LL7Z8XFo3/gs
         chAA==
X-Gm-Message-State: AOJu0YwmTPYZiVScQVf0Am2kdQpCsl1I97aFdPEAI3VC+xiE+KySAC9j
	vSx67d10908LIAWPh13k3YfFj79j8EGL4x+jz02rJWZwUrCs131c4if0CdZXSvw=
X-Gm-Gg: ASbGncsolYUER8WhAkrYu0CRTaH2+egF8JDUzdt7jVOMMqDjjhHpYTwlpA3cnfdoGLW
	pXg5Ugdto5eY/Z1eZnsfqcLMu1pi4FXsPn+5GWYJhb3N+Haw+/BN6SpCLw2G+W4Gvq117Bn433y
	20XYTEoK2EHmEWCmVjk4+MMt31tc8HK/hUn6m2IH9GYnY2a75rrSMgthu4E7HwNeBSeZpqLPVoA
	nrynDkysH2OsHGDuVrr0szVlz1D6k9J1/7C1jMiFI+pgzyStK9x+/RERjQlzHtIDSO6gY+y4Wgq
	8B1FzV2YG/vk1kzV8bO46xnjUfKTKkNonwEYYhQtMRQmDe6uFy9TccOa9bORcYPQrLiikC6ldoN
	uOQsPsOlo
X-Google-Smtp-Source: AGHT+IE0EKPDOE0B+bIWGp0aTjPyAO/iDE+qBS8tblNrc9s6pcUfm/9HZuLYDsBQB2sS3i9QU3Z+eA==
X-Received: by 2002:a17:907:2dac:b0:ac3:2368:9a11 with SMTP id a640c23a62f3a-ac330397b09mr520459566b.35.1741992697416;
        Fri, 14 Mar 2025 15:51:37 -0700 (PDT)
Received: from [192.168.1.10] (host-92-26-98-202.as13285.net. [92.26.98.202])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac314a489e0sm280187766b.151.2025.03.14.15.51.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 15:51:37 -0700 (PDT)
Message-ID: <313e0c9d-9733-4216-980a-cb473fbb5475@citrix.com>
Date: Fri, 14 Mar 2025 22:51:36 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/20] x86/smap: Use named asm operands in
 smap_{save,restore}()
To: Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>,
 "H. Peter Anvin" <hpa@zytor.com>, Uros Bizjak <ubizjak@gmail.com>,
 Ingo Molnar <mingo@kernel.org>
References: <cover.1741988314.git.jpoimboe@kernel.org>
 <4631b5fb3e33af925f4bd82ecb56a5facff354cf.1741988314.git.jpoimboe@kernel.org>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <4631b5fb3e33af925f4bd82ecb56a5facff354cf.1741988314.git.jpoimboe@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 14/03/2025 9:41 pm, Josh Poimboeuf wrote:
> @@ -50,9 +50,9 @@ static __always_inline unsigned long smap_save(void)
>  static __always_inline void smap_restore(unsigned long flags)
>  {
>  	asm volatile ("# smap_restore\n\t"
> -		      ALTERNATIVE("", "push %0; popf\n\t",
> -				  X86_FEATURE_SMAP)
> -		      : : "g" (flags) : "memory", "cc");
> +		      ALTERNATIVE("",
> +				  "push %[flags]; popf\n\t", X86_FEATURE_SMAP)
> +		      : : [flags] "g" (flags) : "memory", "cc");
>  }
>  
>  /* These macros can be used in asm() statements */

The problem with ASM_CALL_CONSTRAINT and asm_call() is that it's not
just call instructions.  It's any transient stack adjustment.

Peeking forwards the other half of the series, you convert IRET to
asm_call(), but leave these alone.

These need converting, and hopefully someone can think of a better name
than "call" to be used for the wrapper.

~Andrew

