Return-Path: <linux-kernel+bounces-432000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 043FA9E4481
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 20:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A03AB3A7A9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 18:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD8D1A8F85;
	Wed,  4 Dec 2024 18:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LhzR9LbO"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1171A8F73
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 18:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733338192; cv=none; b=LQSAaQtNpDJPV7PGUS9PbGuIc2Fj2M3d0ONj/zCVcpVLMaa7IdArXe9ADVMj+eJ+f5iEDSXT1TSB4VG0/npLo/7ZoPQXPQBVufwVys527avCqarfuJXM29nhV15wEmfoM575ovL+YuTTNCdbLfizm9wUBomfaARhQSityhmW07c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733338192; c=relaxed/simple;
	bh=gaS3H7w49pPJGSkJwATaUvBuoP2XokTLv34Iwwlewww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RClWuz0shTVyXQ8WHlP1p8SoVQ0wBYbLFpsWdHY9qE0opfaRkXMkd5x9Pye3/gPxkIyvU/fa6Qn6IAYNuxyw3XW1CFkBJTty0teDFtEaJkI+i5pFEOQJFkcLgUtNl3GIsx2QvfXKqevH3ODs/TA+4UKdJrfIHxE05g1eFTwopUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LhzR9LbO; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d0bdeb0419so27011a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 10:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1733338189; x=1733942989; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NGLJVdk4TR/idekV3ukEREDXaXfKXH37K0Vwo+4cWE0=;
        b=LhzR9LbOhbvfFC4GmjbitDYUaEM/tMkyBL5vvk/yDJKZNsBMwWwl3ObRUJ0lqgd/x/
         he0i/S7gS3EcBmRwJNvu5fnEaw6Myt+qC64/xBN0t2JC8KtUVzE2GX03l29aOxMUGdUE
         CKnOWAxvK3uVNBFILSTX5Lp80TlwvgvWAnc+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733338189; x=1733942989;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NGLJVdk4TR/idekV3ukEREDXaXfKXH37K0Vwo+4cWE0=;
        b=gObs2c9lRdPQFim8dFOnndsiqqe2SjCzNV/qHI3+M8bNh3qCQHmNvB76krClyhssAN
         u7yDeQoG65tkYPIDTWNi6ytsuUwSNP+ImP6yxL0frUCik6rm1BKVcV2qH1QGLNgJmLtM
         TqIPZlIP3aqkxCVr+n8RrkJWxnw7omMc9eGq71G0l2ZoQtf2hqSFAEvYN9/S4UUHtz2H
         v8mz/aZ2G+DdPiSQtpMvdkOZwB6ZWUwqcq9SyHPrJQy6ndZ0fQ5z4UP8Ch50NKczZ8Uq
         8uLYQVR56IqqFX+rg4wFsAzfO5Mzzpry5phkcMLeVTk7+gvhAdtxBhuWFY3MH3kr+yTX
         A6pQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNtTpv+GJtIIPw8z5nWJxi0wks03OfFwkW9I+G9ZgBdyW1QyHJVv0O68fAMQeEUh+24InzsCzYy0Xgsko=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc4VJyxl+QD3YB7mPOBYsv3yhLd62Awy7UI5qKkkffnF3XSI1l
	IrDZXyvqrSgpcjve2tQ5MWJbVqVXES45mShhTn65uSg4i39x4neM/NOZIGBuYVYAB46I7E+978p
	HPAs=
X-Gm-Gg: ASbGnctdBLRs62yZI4QQuhHWxkPcZnf/3AREnZvrv8EB7uAV8wATcmW3926mFZ0lqri
	FdN1cJc6HXEmBbsx05c7HvpjDHlnSbBc5VfDMBusy9rji3r2xKfsH8iHvm9irhzCgwExlvbml33
	Ku/7oBw1bFewa2mLn22fHXbGirjKGgYTUTqgNSO63wmGxACKwM881o1c2Ns3y5smMtZsAuUI389
	ZT7dah0phhXFn3GGDo1yEUdMkxCkQleGvk0rsp/G0peD3bLFDEw+bLgIVPW6Wau9+F2oaqPAQHp
	e8ADqkPPRz0Yx0LenDBgcoQ=
X-Google-Smtp-Source: AGHT+IFNU33YBZkwjsftRBJ0JC03LumKnMDfz+EQkdrPZ1MWpFEF4ZfGPUs/iaz6ZWc/jZG5sjD8qA==
X-Received: by 2002:a17:906:3ca1:b0:aa6:1ee0:c111 with SMTP id a640c23a62f3a-aa61ee0c441mr43532066b.42.1733338188731;
        Wed, 04 Dec 2024 10:49:48 -0800 (PST)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa61c6346dcsm22758266b.6.2024.12.04.10.49.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 10:49:48 -0800 (PST)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aa5b0d8bd41so4114466b.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 10:49:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWriXq5T8xbID3ykzrl9C2VqaXm91u8AvGtLaxwpxUnLn+rpGv4Wrgxasavf0dlzlvN0iSIp4QCrvKn49g=@vger.kernel.org
X-Received: by 2002:a17:906:32cc:b0:aa5:31bb:2d with SMTP id
 a640c23a62f3a-aa5f7d64a0emr582654866b.20.1733338187805; Wed, 04 Dec 2024
 10:49:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e654a20c9045487eaacbd256f584ce45@AcuMS.aculab.com>
 <CAHk-=wiG7dGtE6UsynOP3FuvApkh=FYrv1Q42DEVZmosuOFXnQ@mail.gmail.com> <b853710c4cb94ec0bf869edb41a685b6@AcuMS.aculab.com>
In-Reply-To: <b853710c4cb94ec0bf869edb41a685b6@AcuMS.aculab.com>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Wed, 4 Dec 2024 10:49:31 -0800
X-Gmail-Original-Message-ID: <CAHk-=wikqihO-ai-SLWGqVm1SPmYh60AujgpDniDWmXDBryKoQ@mail.gmail.com>
Message-ID: <CAHk-=wikqihO-ai-SLWGqVm1SPmYh60AujgpDniDWmXDBryKoQ@mail.gmail.com>
Subject: Re: [PATCH next] x86: mask_user_address() return base of guard page
 for kernel addresses
To: David Laight <David.Laight@aculab.com>
Cc: "x86@kernel.org" <x86@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andrew Cooper <andrew.cooper3@citrix.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	"bp@alien8.de" <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"

On Sun, 1 Dec 2024 at 14:24, David Laight <David.Laight@aculab.com> wrote:
>
> Agner's tables pretty much show that Intel implemented as
>         x = cond ? y : x
> so it suffers from being a 2 u-op instruction (the same as sbb)
> on older core-2 cpu.

So I don't worry about a 2-cycle latency here, you'll find the same
for 'sbb' too, and there you have the additional 'or' operation that
then adds another cycle.

And Intel has documented that cmov is a data dependency, so it's
mainly just AMD that I'd worry about:

> OTOH AMD have is as '4 per clock' (the same as mov) so could be
> a 'mov' with the write disabled' (but I'm not sure how that
> would work if 'mov' is a register rename).

So that's the part that really worried me. "4 per lock, just like
'mov'" makes me worry it's a clever predicted mov instruction.

However, it looks like Anger is actually wrong here. Going to

    https://uops.info/table.html

and looking up 'cmovbe' (which I think is the op we'd want), says that
ZEN 4 is 2 per cycle (I hate how they call that 0.5 "throughput" - at
least Agner correctly calls it the "reciprocal throughput").

So that actually looks ok.

I'd still be happier if I could find some official AMD doc that says
that cmov is a data dependency and is not predicted, but at least now
the numbers line up for it.

          Linus

