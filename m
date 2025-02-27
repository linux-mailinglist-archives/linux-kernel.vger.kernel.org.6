Return-Path: <linux-kernel+bounces-535243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E40CA47083
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 01:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3F69188B58F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 00:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E34C2FA;
	Thu, 27 Feb 2025 00:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="pCF6FuEn"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152041EEE6
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 00:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740617393; cv=none; b=RIAAAWaz7sEd+js4tSMtB6me5HIhfPZZBH/Scd31N3ICWd338NTvPo1Bp2wr0i/rwH3hM0SQ5wDlAT3WvWBrB9w4vXt+Fi9rtI+RCugoCW/37J1BwBi0aqs6W++weVQECo/3FwWRMc9aMVYltQd8M99ZBSw3t0hu9xvhIecqWTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740617393; c=relaxed/simple;
	bh=VKfKBSoKsWgdO+5+inyMfZQxtAALsjTA1Rz1kTOzju4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CssYSKEYR/nlnTXllFvDA+mKLNzQIK5lMm9nm8V7ll4rCSSroRNXIbuubTiz5vzPIcVGp7VoQtnu3rI05WN33u7qkK07E0tR9GNc4+RRwLpReXueORaAdF0y64yHTZpj/UeGtNwf9Gcflu1OUczo6foLwSqHoRbxhlVPSUXrpCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=pCF6FuEn; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-439a1e8ba83so3878055e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 16:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1740617390; x=1741222190; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Y8IoVJnLvqM0mjAqtWpyGMN4QIA5NLPCn75z9KjHyIg=;
        b=pCF6FuEnf9xwVWq5tUXKxmVikqRtTU4ntxC5RPqeOYEFZcOizRfX8/EHBdrUB080/R
         EV4xlSfLg09u9IfgFEJZHKvbib1y8R2ZdadABrcvUIyII5MfZGLpgioxLXNFlvYFIUtT
         JxAAg7q1Uxtm3hoP0FWeK+AJYjFihX1Crve+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740617390; x=1741222190;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y8IoVJnLvqM0mjAqtWpyGMN4QIA5NLPCn75z9KjHyIg=;
        b=D+wJpaj0HhdmTe2Q2spQj0cIttB93YQL8DUrN+x7Hel1eWqijqPVzN8TZAWe7zddGg
         AB/Yb9HcohPAEAfg1Zbr55YfICBEco2Do02IeayDN3DHWQ0tvcHo0Q78wp/dI26B1Mz0
         iFTZRU2OWX0r4sL2WXbxdU+jV/FG6Zx2MAos9HnNa/FHprxYsOI91UsX3NRljTVed6zJ
         LhN9naK82L2jfXxZMkuNGe5hwi+DXF4xrCLczHeLjcQP8WeEH8gpOXfDWw3qUtVyDwLb
         rDa7fSsAhk5hxZgFIrQUf4NaLEizhV/4LAFH+SzTPHGa9ryi5cajDijQKyLURqRtJPph
         OooA==
X-Gm-Message-State: AOJu0YylxZRDPcmH4ZM+D/NiNaYMX40jioY0m7IdgqRFRv0N80bauRRy
	RAlt42apvEEyQcOS28fhTnvngym5tbvktHPKtS8kOUYS96iVluRV3zN4PynlhB7gCJMejcS2hGA
	Y
X-Gm-Gg: ASbGncsqiNXUMPsQWH5gk5vs1p9tbULi971t7Ga+M90+hxLldAoo32QErTSNLHd5zMr
	KQqzn+7X3+mHnapgiUPNlUXHiUaKUUiXzfRYk8gQ6FyDjsLUJs/C/jvknNJxII5Zq6ktS1rYBMJ
	OLWlNLEZ0L0bYP0sUOZ5t9m85lzsG35e48W2ewGRcJ0OaiJ+MkcFfIK2mywCRMti+KBb8nWl2Jf
	jr/kZzXSyX709JMDO+THfOYktcah4WgwxDB+0iG2tqB2mlNngga97E4yjZ1Mb7amNHOfMRIL+CW
	j66griQP1xw0d2zgnUW1jcDgi9oHPY0uLOmOKpwncg8wh6hmxmoK3uhqEqfDs2PVXw==
X-Google-Smtp-Source: AGHT+IGpsPywBJAzXALDQ0K7XrDZ7T0bbJAVmRf7sfiVbZ5/xXkC0xIWYXubPm/rFRohJ/Ap0ZlT2g==
X-Received: by 2002:a05:600c:3506:b0:439:9f97:7d6c with SMTP id 5b1f17b1804b1-439aebcfc40mr188435305e9.29.1740617390403;
        Wed, 26 Feb 2025 16:49:50 -0800 (PST)
Received: from [192.168.1.10] (host-92-26-98-202.as13285.net. [92.26.98.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b73718de4sm5642915e9.23.2025.02.26.16.49.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 16:49:49 -0800 (PST)
Message-ID: <497a3694-cb0d-4678-9622-d9443bf8a40d@citrix.com>
Date: Thu, 27 Feb 2025 00:49:48 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/speculation: Simplify and make CALL_NOSPEC consistent
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, x86@kernel.org,
 Josh Poimboeuf <jpoimboe@kernel.org>
Cc: linux-kernel@vger.kernel.org
References: <20250226-call-nospec-v1-1-4dde04a5c7a7@linux.intel.com>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <20250226-call-nospec-v1-1-4dde04a5c7a7@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 26/02/2025 9:03 pm, Pawan Gupta wrote:
> @@ -420,20 +420,28 @@ static inline void call_depth_return_thunk(void) {}
>  
>  #ifdef CONFIG_X86_64
>  
> +/*
> + * Equivalent to -mindirect-branch-cs-prefix; emit the 5 byte jmp/call
> + * to the retpoline thunk with a CS prefix when the register requires
> + * a REX prefix byte to encode. Also see apply_retpolines().
> + */

Technically, both comments aren't quite accurate.  __CS_PREFIX() emits a
conditional CS prefix in a manner compatible with
-mindirect-branch-cs-prefix, not the full 5/6 byte jmp/call.

> +#define __CS_PREFIX(reg)				\
> +	.irp rs,r8,r9,r10,r11,r12,r13,r14,r15;		\
> +	.ifc \\rs, \reg;				\

Why are these escaped differently?  Given they're all \r of some form or
another, I guess something is going wonky with __stringify(), but its
still weird for them to be different.

Do you have a fully pre-processed source to hand to see how CALL_NOSPEC
ends up?

~Andrew

