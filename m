Return-Path: <linux-kernel+bounces-561706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1440A6150D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 16:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3353416BAC3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 15:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E991202963;
	Fri, 14 Mar 2025 15:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bIueEY/b"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA89960B8A
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 15:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741966496; cv=none; b=Ad4DHBNlAO9009uaxdo2dCX+473WH3drjCQaw+DjceQ6T4A1YBnTshXSoRnJnGZgNGPidSq9OD9iZTNYB9V1rBWJUKClvy2UNJUpEKhR9P7gfiAV/fXXZuJZODW/FpHL+ykHHxBAqn2rzEZvmXVBULnsihcOW2iOrRRF9UiMe9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741966496; c=relaxed/simple;
	bh=ufhNrf4TC4B1qsP2tLLhXQwR7ucshSA5pGUrOoXUcyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LufgQlq1v9P/CrwDtpe+ODXAZP3vWzu5x+iOYtELL2Nbh/hm7+XbOWpintehSXPKXaLt1URfcgg91i+eicOlJ9DaZEPhJ64fBUacl+lkSwq1XjYA64s8XJqwy57jdh/fLfC49dBmw79glmshrxLZq3lKiJDpWc/66iP+9G/vc5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bIueEY/b; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741966493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3hf9EGY507xgOdKl5PqvUA6OV/20OWtgDQf4mTrf+oU=;
	b=bIueEY/bAtsxDe9s5eqBD+eEljOA60S5kg07LGSG+yC29XzfTQXH41ZcLbFrnR7DUM5nGY
	5Mq+aIYjfJqcRRyAtMDmphE871K//chn1klyIXo35+smZx/+5Z/MN7CsObvk0vo4aV2bd5
	ahZAY6XK5y2jVNAEMC+r6lY9aWi+99Q=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-EYxbINIEO1y4mYAJBRru-g-1; Fri, 14 Mar 2025 11:34:52 -0400
X-MC-Unique: EYxbINIEO1y4mYAJBRru-g-1
X-Mimecast-MFC-AGG-ID: EYxbINIEO1y4mYAJBRru-g_1741966491
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ac316d639c6so144338866b.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 08:34:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741966491; x=1742571291;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3hf9EGY507xgOdKl5PqvUA6OV/20OWtgDQf4mTrf+oU=;
        b=YOIFLzNPxkbkjYxJCcXPF36l0G78tPojYmSlWwHa0rl2+tt+FNuPULT0yOFSK8mLED
         +On5fXKUUZrPJVmAl1B0KgQbbTXDuD6J3lfERPGE9gPnGQ5hPwBWQmQOrEV1dCP3T0xe
         ZEguhgRZjgw2g/XP5PxKl/5Sn45wigawhK5eSjR1HzfNEUfB5XFVxSZNLyc1IQbnJmeR
         AgLoPD+AbM/taCi8NwWIyrwfMJdkd8LHkRO6lzkWGUbnjbPMF52QAdo16PZ8IXdVcQ4W
         3MtTEdSuEwpuBpbms+WxlNtzJ8ThfK7gVLyWATyaBQJIAi/ywnHchhrxEvEVyCiDfinP
         iQFg==
X-Forwarded-Encrypted: i=1; AJvYcCXwtppoNWxkfLceQWe+zAR9dJ/7C32GDyDFzogslD1HBz8GjsO9mNJrQIBCn14UMBSXVUz5lROWNwrVaJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtAsiAuDFeQSBOvLuTCuGrIajExnAG1QXvWWnuPofXPw67f89q
	QP+XraEA/ycen1IhlMEtlomC57LuD01DBPd7b3RyGxBNLKQRyjFNW9JiN764qZHq/phrYtTuQJ2
	vud0ckCeAPZLJxEwtHJrsjxy3BBHvOpGPgouJp8h+a5ZkG0U21SKCo338qEdxvA==
X-Gm-Gg: ASbGnctHmmDnq8WiEqGe74NaD82PX6ZVw4LMJqgWoNn3pq3GTBDM1mwQVuj5kBHsYnR
	t0oJxjuWmgbQSw7YdlEIk/yOi9A1QplpJ0B0rb11kUDQWDIRP3aU86K6vDA484HSopD3ydIrJSl
	4uNbn8WTpDBhBZ0LwJouK9nvO0IowLwSQD4P6fxOniY/eVSMOGFP8YOuOpU+Gn4c04Q7DPOtsSl
	6VII14SLfXUCxgPWKl0KSvwKxPY3dDXJz0xOzvBxvwv/gfGGX4tUNd4ua3AjjtKyFVoqXHlJtV3
	fxm8G4P2DX9kYNa9JvXViQ==
X-Received: by 2002:a17:906:dc7:b0:ac3:777:ed75 with SMTP id a640c23a62f3a-ac3304df63emr329834266b.48.1741966491174;
        Fri, 14 Mar 2025 08:34:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpKyqwnoPXJe0Dx/GwMzgbMpYZse4OQz56GHWwIROHPr+IMN93fKgn+YH1Eqq+gJNtgkDWEg==
X-Received: by 2002:a17:906:dc7:b0:ac3:777:ed75 with SMTP id a640c23a62f3a-ac3304df63emr329831866b.48.1741966490713;
        Fri, 14 Mar 2025 08:34:50 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.122.167])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ac3146aef85sm237249166b.20.2025.03.14.08.34.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 08:34:49 -0700 (PDT)
Message-ID: <f10cef8c-107f-4eb6-87bc-3d704f663c3e@redhat.com>
Date: Fri, 14 Mar 2025 16:34:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: x86: Provide a capability to disable APERF/MPERF
 read intercepts
To: Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org
References: <20250225004708.1001320-1-jmattson@google.com>
 <CALMp9eRHrEZX4-JWyGXNRvafU2dNbfa6ZjT5HhrDBYujGYEvaw@mail.gmail.com>
 <Z9Q2Tl50AjxpwAKG@google.com>
 <2fd1f956-3c6c-4d96-ad16-7c8a6803120c@redhat.com>
 <CALMp9eRYvPJ5quwa7Dr1GgjPpmZVm+6TM_fkhA6KbVAdMsGH7g@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <CALMp9eRYvPJ5quwa7Dr1GgjPpmZVm+6TM_fkhA6KbVAdMsGH7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/14/25 16:33, Jim Mattson wrote:
>> It would be simpler for userspace to be able to say "if the bit is there
>> then enable it and make it visible through CPUID".
> Good point. I'll take care of that in v2.
> 
> I feel like I am abandoning my principles with this patch, but as long
> as you and Sean are on-board, I will do what needs to be done.

True, but there's a time for that as well.  As long as it's not enabled 
by default, stuff like this (or even quirks that _are_ enabled by 
default) has its place.

Paolo


