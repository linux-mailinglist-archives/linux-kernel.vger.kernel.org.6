Return-Path: <linux-kernel+bounces-197040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 552188D655B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 17:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B325D1F26315
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 15:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF230176ABA;
	Fri, 31 May 2024 15:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0fm7uU6"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C65176AC9
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 15:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717168213; cv=none; b=YpxYqqcnYv10EaZ4ZXZJd0Mubl0svkNuFY6D533LF1DVZKPRqSH2ZQKLPEBTN8jayBSSZ15BuiTds95vRe64N5LbZZfv/pmV1o1+ZTw1lb1XlGxI1KqauujPbGBzHI8B/NXetyB9lpyncnfb7+Ekxlv7c2SCT88StyWgPhNv59U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717168213; c=relaxed/simple;
	bh=aAFoj1nQJv9eWht7cafhIt8bfUNw+ZFX8S3MZtNZ45E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qetHt21zoRTD4I72UjzQkYb8HYHtirKReA1pFwMy8MCrF5cUqRrfTYTsuSTEVMBfJ9Ie8mBGHU9AOSqu1W9dKGrL+5oiwR2tSiXROLg583D/MNW285Fsgp02x7hhbotQkbX5fUglnwpx4NLvuh+EZ392CfbOxCUFi+chnCm3vnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m0fm7uU6; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a63036f2daaso245304066b.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 08:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717168210; x=1717773010; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KQ+k8MjnPe+PGGHhvvxgv0JVQrL81ckxYVKdMATgRt4=;
        b=m0fm7uU6liqyoxHWV625SPmNtdZoDOvtd2NpS+9FzbrXjRfgoa2rwYJjZMEuCSVkK1
         MG4jD8EnX2wEiogSTV+7Tgi1ehA9AissYI5gdzN65K3h4jGUxFO13FZo4BB2/opYMAPG
         8PgpyazhcZObDTJlYBKYHr3kGLRj/cHTrz7ilMIjZv5y8z3vbY7D95xgLejxRWSf86e7
         oHbK20Lb5B0qFz39wnVBFLDOmXx/BVB7H3HKo9MO1UWoMz+OLPfycpFGN8wMD7NTGQgO
         gbQ5DfjKLir3ccxyCaRCZAiPiOcxKNmWutfQ63bTEv6tV4CN5l9idqe28d1wl6MrygIq
         ne1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717168210; x=1717773010;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KQ+k8MjnPe+PGGHhvvxgv0JVQrL81ckxYVKdMATgRt4=;
        b=X6yKnDrOnd4pxfybWASH6zpGXBpQUm9Hpg0uLrazIgjBzg9R+yI/DlQQmiEKl2Z4Ig
         CpeiTdYG10PQiIFmqpAAsNUDFxFCxXonRzCOjcG7N+n7n64lYzrVztlLW9C1TRPwzqS0
         DmcblKu5H8wZ7JyLxfL/AttMcBntkAxFKx8yqUQ8b4m6bVSz628v4OU8J/2xVFFl8BiZ
         rt64sL0NjIZDnXzwVfU1p4A1i/tMfRg9l9XPXcyBsHWTzNZJ2F+NwHGG/agyYB4+kp0V
         cWTNWbp3aElBO0jeKrZGVJ6FpHWHL4EVIcIQSUXMNT+oI925oDyOPmbd6tg4fFP3aV0/
         zZ8g==
X-Forwarded-Encrypted: i=1; AJvYcCVmxA1zf5Bvg12IIwDl/lpaGcv8Ns8UvhcKkJAdj3IJxA5xUtWohU7DEvbLN7AKKEnCqnigUbofO8Pnes+OSZXIvgL/9DTdRU5aYWhj
X-Gm-Message-State: AOJu0YxQUsKMoxm3KOwgdd9ev5F6CQMfWVYpOq7YJVurxg3Huqhe0qys
	mMSPnK1uf8HQI4YnP3MT5FTYUq17hMhQY4WtaTvNQbyzivtElBjh
X-Google-Smtp-Source: AGHT+IFPrnAX+y1wIrUwZTLLnjyMLVE5vd3bsUxWYgyXc4bf/Vz7qpDQYMx/J5AOQEFfKreGUhHi5w==
X-Received: by 2002:a17:906:3f89:b0:a66:b27:f9d4 with SMTP id a640c23a62f3a-a6820be9275mr147593366b.42.1717168209830;
        Fri, 31 May 2024 08:10:09 -0700 (PDT)
Received: from [192.168.1.100] ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a67eb341abfsm95668066b.192.2024.05.31.08.10.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 May 2024 08:10:09 -0700 (PDT)
Message-ID: <d3969a10-7cd2-3dfb-2e49-37ebad2d6440@gmail.com>
Date: Fri, 31 May 2024 17:10:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 02/14] x86/alternatives: Add nested alternatives macros
To: Borislav Petkov <bp@alien8.de>
Cc: Borislav Petkov <bp@kernel.org>, X86 ML <x86@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>
References: <20240531123512.21427-1-bp@kernel.org>
 <20240531123512.21427-3-bp@kernel.org>
 <3a86f790-3194-4ea0-de8d-0af231ec7525@gmail.com>
 <20240531143625.GHZlngaQfx6CiJlujI@fat_crate.local>
Content-Language: en-US
From: Uros Bizjak <ubizjak@gmail.com>
In-Reply-To: <20240531143625.GHZlngaQfx6CiJlujI@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Borislav Petkov je 31. 05. 24 ob 16:36 napisal:
> On Fri, May 31, 2024 at 04:30:31PM +0200, Uros Bizjak wrote:
>> Please don't resurrect the %P modifier, use %c instead.
> 
> Btw, out of curiosity, is %P being phased out?

No ;)

> I'm looking at
> 
> 41cd2e1ee96e ("x86/asm: Use %c/%n instead of %P operand modifier in asm templates")
> 
> and yeah, %c is the generic one while %P is the x86-specific one but
> phasing latter out is probably going to take a bunch of gcc releases...

The intention of '%P' operand modifier is primarily to be used with PIC, 
where:

'P'        If used for a function, print the PLT
            suffix and generate PIC code.  For
            example, emit 'foo@PLT' instead of 'foo'
            for the function foo().  If used for a
            constant, drop all syntax-specific
            prefixes and issue the bare constant.  See
            'p' above.

the fact that is handles constants is due to historic reasons.

The '%c' operand modifier will also check its operand that it is indeed 
an immediate integer operand, so should be used with 'i' operand constraint:

'c'        Require a constant operand and print the
            constant expression with no punctuation.

Uros.

