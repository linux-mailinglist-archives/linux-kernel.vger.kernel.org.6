Return-Path: <linux-kernel+bounces-441519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E84949ECF96
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0911A16A0FB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 15:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A71118A6B8;
	Wed, 11 Dec 2024 15:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Af2sStfw"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8234F19CC1C;
	Wed, 11 Dec 2024 15:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733930620; cv=none; b=YywWZ2QO79ghoEiju6FpISY9fKkFf6LbUq54e8ij3s82K2wdqNcxvXUoiuDmlrCU5YkyISVwpZY7ImmvkT4hLRkG0XNKVo5SdmR48T+bTAa3dWLkeFwfUmsc+MnLlA+b8DLu6AUccssRJ/3scPDB/q9z3msvewlNGScz1P7AxHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733930620; c=relaxed/simple;
	bh=QIEkG0xZSKxfU26IExAVUZoLdE72Tqxq3ScdnpGFQRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mTwkLj3T2o3CjyodnkeZDZZDN4wxS6mGH7vB9pPwzzkyMX+QxUg6agVb50/NHDrNM/W3V506AYmglFbSQP+Ey/ZaqD9cOvk1cfYcUvI0Jl0vXjxEBy6iXfaIaFyEzsRbV0i41FrHUny/tXU4M2WniUSpgJ32s0gUnG/33pEktGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Af2sStfw; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21619108a6bso41992295ad.3;
        Wed, 11 Dec 2024 07:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733930619; x=1734535419; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y+hMgNuteGPTfHUokgEk81f7fnYLmO/eqgwkl3XbjZo=;
        b=Af2sStfw9HXZAMg4S2KaRRWJlOd+ttD2X70Y+HjWRXczd4HGKZDD7WEhBHhqxipdRa
         LL0sE8PT80ISPsESwzJVVbfzmQepGFeqe/7oxZPWeM6N3qx5BiWHFby25NvSL2a67FHa
         M2Xi4Bxc0M+IZkSx7c8cUtSrcn39V6Vm82KNvpidx+ZLMEKwmQL3NHwTS/fq2ZBHgP5E
         5gdT1anX62tEPQQLWXru/6hXHsww14a8+lmk5E7sdt9sZYr5ZLA2Ilmifvd1xAKm29XP
         G+1TU8HJbrBJpCXDlvGagmXcu44VTCWKqtNvxdwuSok9EQyYRoCTRg7jaxVUBi44NZC+
         4RkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733930619; x=1734535419;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y+hMgNuteGPTfHUokgEk81f7fnYLmO/eqgwkl3XbjZo=;
        b=S0Mo04YuaQNvBfGMozdkMAH9dMlrvmrMJLbiBMzEGP5gVObTSLrsUzG+CMXqYCAMWS
         yfA2G28mqU+yogu6JKSy9dQp7sxkX6481AA+voyFTlmePF+OyhhwOTNmn3YORvpDwVK4
         D/ocRhSFop0i+fgdXdd9Ve4F9WTbDSrQ/XBe0TzLWeX7RkM1mDXzesxEhr9iDFPYvRSQ
         mTr2s4f7g/pSQqHwJ2OwDN3A8osUDQLUiqZUc2bVvG08syJ4EtphfbOIlEKZTU8IgJKA
         asf9cpby30hGJ981jDJq2uduknA5Yws9+CtdOV78OIVAjw8A8gRBTh+Aw815EQXX0l91
         VHuQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9OZ8MwO41QhFABw8TMGs8ylNLmNh0G1SbOEzpc9s0HpOb86kXG0GvG6jzTRwtQXrC3D4MEVlmB3lTwg8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb0F46fC4jd5o9Y1v2zH+YehXUYiI4IXxsfDzovZVykjnvrbrq
	3WsZ/bPKYdATiDdMMbaI7LSyr0aQflHplZAoYZX0xuYQbgPph/Bn
X-Gm-Gg: ASbGnctrnP84qbL27bX9tkGH9RzVNPZ3j3MEeZAYgaUC9MEp2w3MIMUhMPYLO20wirQ
	idMjts9iU11bkrqay233+/P6teAKINmd5IBt/6uJYjJS9dz0zvmkDhswyVplvXLxP1uAf2h5NMC
	k/pv988gTBC66ApGVYesV58akGUbI2JhSMQWoTls76+qmmTV0xwUMlmaS19nmJLRTplQhAcpcBV
	EZZEWKRQcB0zdUm62J3BkLA6+d60yWVJquRHKcurce0zkkB8QfPE010vZz7wD9c+yP2+Y8hWPip
	2RD9f70Hwmfe+NMGQ7TR
X-Google-Smtp-Source: AGHT+IESqCr2uoZAEWlto9KvuQWuQ1N2Pt+TlQMnWsiWnPJrqU1CIuO3q4tVaWWFiOO1/VD42gmlYw==
X-Received: by 2002:a17:902:e94d:b0:215:522d:72d6 with SMTP id d9443c01a7336-21778591140mr59631005ad.38.1733930617915;
        Wed, 11 Dec 2024 07:23:37 -0800 (PST)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-216728cf4cbsm31563225ad.219.2024.12.11.07.23.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 07:23:37 -0800 (PST)
Message-ID: <ac6bb4a4-d57c-481d-93e1-e08ab9fd6bdc@gmail.com>
Date: Thu, 12 Dec 2024 00:23:35 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scripts/kernel-doc: Get -export option working again
To: Jonathan Corbet <corbet@lwn.net>, Greg KH <gregkh@linuxfoundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Akira Yokosawa <akiyks@gmail.com>
References: <e5c43f36-45cd-49f4-b7b8-ff342df3c7a4@gmail.com>
 <87pllz2r30.fsf@trenco.lwn.net>
 <b7c99226-7c03-425a-91b6-c7969bdbb1cf@gmail.com>
 <87v7vr12qr.fsf@trenco.lwn.net>
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <87v7vr12qr.fsf@trenco.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Jonathan Corbet wrote:
> Akira Yokosawa <akiyks@gmail.com> writes:
> 
>> Jonathan Corbet wrote:
>> [...]
>>> Ah ... I should have thought of that ... I'm glad you did.  I've just
>>> pushed the fix out to linux-next, will send it Linusward in the near
>>> future.  Thanks for fixing this,
>>
>> Your docs-fixes is based on v6.13-rc1.
>> This fix needs to come after v6.13-rc2.
> 
> ...which will happen once the fix hits mainline - the *fix* doesn't
> depend on -rc2.
> 

Well...
The fix conflicts semantically against v6.13-rc1.

I know you hate full rebuild of htmldocs. But I'd like you to follow
the following steps to see the full scope of this fix.

 - git checkout v6.13-rc2
 - git checkout docs-fixes
 - make htmldocs

You might be surprised, but you'll see the following:

./drivers/dma-buf/dma-buf.c:1: warning: no structured comments found
./drivers/iommu/iommufd/device.c:1: warning: no structured comments found
./drivers/iommu/iommufd/main.c:1: warning: no structured comments found
./drivers/counter/counter-core.c:1: warning: no structured comments found
./drivers/counter/counter-chrdev.c:1: warning: no structured comments found

Current docs-fixes has a semantic conflicts opposite to the one v6.13-rc2 has.

I'd really like you to send a pull request that resolves the semantic
conflict existing in v6.13-rc2, not the one that happens to negate the
conflict on merge.

That's the minimal expectation I have.

You might wonder whey you need to checkout v6.13-rc2 first and go back
to docs-fixes to see the conflict there.

That's because "make htmldocs" don't rerun kernel-doc conversion
when only the kernel-doc script is updated.  To see the effect of
its change, source files with affected kernel-doc comments and
"EXPORT_SYMBOL*" need to be updated as well.

Of course you are well aware of this problematic behavior of
documentation build.

I don't mind docs-mw if you'd like to keep it v6.13-rc1 based.

Have I made my points clear enough for you?

        Thanks, Akira


