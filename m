Return-Path: <linux-kernel+bounces-257621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E53937CBF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 20:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B938F1F21BF6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 18:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276C8148307;
	Fri, 19 Jul 2024 18:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yDYLUd0p"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080461474C8
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 18:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721415218; cv=none; b=U7MAQjxsD4/i6tJravkEPCkUYqW/XicocsxxUJfEcEmK0LcXkdXkXDJSxX43i4ga0iB9lLcpgzr6zB5gMhVN2DDszfY3KmzlJqwMowSfi0+8L6Sc3tEPJcFV9bPuy0uCmtolSoUWmxz7zMPm9NcVtFkM9X2xnW2qX343j18YRCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721415218; c=relaxed/simple;
	bh=+kLJ84rOPDfadAIu/tPqOjfvEHdaowyp5cRy2Wb9NJM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=obhr7B/+VkeWGC1f7Ga1Zc9wRWrCY6OF4XTBdGu0iVpeD7zQeUnuRDI1W5lWFCqTrCV/2hoofV+XgekkZKRt/GDX5LsWI2Tx31jnDJ//Q8tLknU5iCWG9wffiaq0yZaD4eop0map1R3o7FqdyMOw7P2tLXuraUydNAd1WUryw7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yDYLUd0p; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-65026e6285eso56373747b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 11:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721415216; x=1722020016; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/YfiZYPFH3Xc3TdmGdnSOvHRo3erOgTPXdxqXA3ySl0=;
        b=yDYLUd0pmCS0b8xW2unoongoql/ETAdtFzXazCmoklyadgMOXqXn/QnU17DWVodKlP
         3VaQ/+pcyaQCysaAhWY8Np8oLDBoIQSpJhrpFwlSBJppS2PUvOVYn8DHYlKzIXQvLQ2F
         rDRA25BBvBgNNO3+kFzbZ0HvYclm0e7Q8xfNbb/z9mFMkCK7kyIhrUlc6ZBNW5IxFwVG
         QegTpVHP1YmKS9ev3mXEG7KXQbJrWiwXHeE3ro1GaXRCCyKTrbj95nClzlROKoCxS5Yf
         xLIO8mojKVOvkAAkpPYO5FD75bsraKkHK072BSUgICQWkmuJjFXNxbsTCspPB8SUcz06
         NL0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721415216; x=1722020016;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/YfiZYPFH3Xc3TdmGdnSOvHRo3erOgTPXdxqXA3ySl0=;
        b=MNYp4W6pn68KL9uIfzc7+6wpW6EHDzaiXqYF3MCkyGP8/Vvw/Ub+Ub6SteMZM6O4kC
         DeHmakCDKKB4vS6OvmzuVsdcuaxD92bVwzOQYKeF9H74+js3GOzMv2uEud3TMzm+ENY3
         GIYmxV9SglmcC58Uc17PLGobmnFSBqSl4kHcjs7pMmOFblRdm6BKCZfupkq3BbHDDeKP
         +iBOTeg6r8MxK6D00lU+p5rzt5hBpb8lrkaUxzs5tr4dS4lvHPVRm8jfVq6z89Cn0K1I
         IJdSoNziJsyWPLPj9V7pXtIXQs4ZZX0KibpOtnZaf3SC2fwKcPFwlKx9PFxt21d5Jez7
         V3cA==
X-Forwarded-Encrypted: i=1; AJvYcCUsyhcNQYBOu7wyu8cjKLvupuANpcpuwi7fX9icFBZLzkCNnSSC8CnbPgUI39Kj9o98V4+pVYSlwV7DHzvxyfArSnplDLPkXX9xjfsv
X-Gm-Message-State: AOJu0Yx15Ajj6/SiyI0lPI0OPleREwYcG1kG0hsHemUHXLSSK/4N9e6w
	bfLjlDjXClDMPK/gFczJhkvIINAQspoLFO3Z0ykVpHwZ0b32HalP9qcThcZuB1sbRtOvSG8zuUy
	lHA==
X-Google-Smtp-Source: AGHT+IFF/pVsJU+8/j16/MKkG1plwBz2/9GAQe2lj6JtMKqZQMhQL6o1VVB1Jy4v/044+B+FL3kjuTOTck4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:298:b0:64a:d8f6:b9ed with SMTP id
 00721157ae682-66a66e0debbmr143307b3.9.1721415215999; Fri, 19 Jul 2024
 11:53:35 -0700 (PDT)
Date: Fri, 19 Jul 2024 11:53:34 -0700
In-Reply-To: <b44227c5-5af6-4243-8ed9-2b8cdc0e5325@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <b44227c5-5af6-4243-8ed9-2b8cdc0e5325@gmail.com>
Message-ID: <Zpq2Lqd5nFnA0VO-@google.com>
Subject: Re: [BUG] =?utf-8?Q?arch=2Fx86=2Fkvm=2Fvmx?= =?utf-8?Q?=2Fvmx=5Fonhyperv=2Eh=3A109=3A36=3A_error=3A_dereference_of_NUL?=
 =?utf-8?B?TCDigJgw4oCZ?=
From: Sean Christopherson <seanjc@google.com>
To: Mirsad Todorovac <mtodorovac69@gmail.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Jul 19, 2024, Mirsad Todorovac wrote:
> Hi, all!
> 
> Here is another potential NULL pointer dereference in kvm subsystem of linux
> stable vanilla 6.10, as GCC 12.3.0 complains.
> 
> (Please don't throw stuff at me, I think this is the last one for today :-)
> 
> arch/x86/include/asm/mshyperv.h
> -------------------------------
>   242 static inline struct hv_vp_assist_page *hv_get_vp_assist_page(unsigned int cpu)
>   243 {
>   244         if (!hv_vp_assist_page)
>   245                 return NULL;
>   246 
>   247         return hv_vp_assist_page[cpu];
>   248 }
> 
> arch/x86/kvm/vmx/vmx_onhyperv.h
> -------------------------------
>   102 static inline void evmcs_load(u64 phys_addr)
>   103 {
>   104         struct hv_vp_assist_page *vp_ap =
>   105                 hv_get_vp_assist_page(smp_processor_id());
>   106 
>   107         if (current_evmcs->hv_enlightenments_control.nested_flush_hypercall)
>   108                 vp_ap->nested_control.features.directhypercall = 1;
>   109         vp_ap->current_nested_vmcs = phys_addr;
>   110         vp_ap->enlighten_vmentry = 1;
>   111 }
> 
> Now, this one is simple:

Nope :-)

> hv_vp_assist_page(cpu) can return NULL, and in line 104 it is assigned to
> wp_ap, which is dereferenced in lines 108, 109, and 110, which is not checked
> against returning NULL by hv_vp_assist_page().

When enabling eVMCS, and when onlining a CPU with eVMCS enabled, KVM verifies
that every CPU has a valid hv_vp_assist_page() and either aborts enabling eVMCS
or rejects CPU onlining.  So very subtly, it's impossible for hv_vp_assist_page()
to be NULL at evmcs_load().

