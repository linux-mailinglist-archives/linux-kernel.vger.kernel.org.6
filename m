Return-Path: <linux-kernel+bounces-295241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDD39598F7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CF732844C3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7C01F4CD3;
	Wed, 21 Aug 2024 09:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="itQq/E4U"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA60E1F4CC7
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 09:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724233119; cv=none; b=mYIyighbhFi7hqwXv0S4sKCsTijWiKJkt8bFIB527Z+S+LyNgAQq+qHJ4k0kuGX4yaloE21xZQD2zAj1PteS0Ca/chN9wWJ+YQoywavgVw1v5HahN7JOrBr2SiBhkUO1zp5xiYP341Wf1YeObTf2oZ/231QAFlVoUfUc/q8EP7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724233119; c=relaxed/simple;
	bh=UU07Kw8gcO5fnWpRA31V/Lceie/0yKG2W71V1LAET9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AkU2ahVqzzNeYZK3bmFtCF2O0bhv69kf2byM3ZxFqorjBlEzRpRSVeEPSNfa5WvQitr/Lfax9SYF73ao/XOgacfybasMG8xz91gytm+QasmaJTTiZ3m85HmZ4fkjuuEbCHYoSUE6fc7xNnAbWC6sRW9C8Wo7MYMrbAhNfihxM8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=itQq/E4U; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-454b1e08393so320421cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 02:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724233117; x=1724837917; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vejj5hA/irSR2xi3jAzlX65MbEhh5Bh0pgXtUUu80ZU=;
        b=itQq/E4UYvaArBqkB//gHjd3uj88plqaosEu8QvTys2NtDGruuoa9wauhLP28rBY9z
         6Aw4G02EJHU2h5wFUR4Y0eoiRx+AmjdkY7i0E3FRYMcKYWUeTgWU2rrERARCp6YNqngx
         4EqXmIjCBMBrgOVxemu5TKlioe7pkIQ8N9Xau7Q+B+uMqlqH89MUXBn/ytelQSPu+DlZ
         vOV/aFzhNvUsbQnM0ooPai6vmHIzeygcamcyT1297hFxujRPouy1UDLhdZyi0CcxR+RE
         GLWXYnoIQgvUeFG2J/oRePEWX7ptfOgAAWFkodlxvGIBoCoRjpSidgEgGNDpW8sjkbz/
         1apQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724233117; x=1724837917;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vejj5hA/irSR2xi3jAzlX65MbEhh5Bh0pgXtUUu80ZU=;
        b=VpgABQOT2wowkb9ETHfuv915O4ub62/JvTP5/e+LZmcOkBDH3yR+C7jF1FaMIWSBsA
         eDg8613LTCp7x8jZI5Yiyxgfv6p9zcdjTAk8Slfx5XkGze4MQ/0Xa56MiCvX00/DPPA7
         wGMEnwN6yEIqgLqYnbNPoizSkCBGxPvtxw1Jquo6wuX5s+pxyg+hOAz3h2iX5JL8Zsmg
         oOOh02sfQtwAfytsLmBeT/96y929ZOZNWNuHjFHbEgoc99ZNJ/PtWtEBRkhM2APtmHw5
         RC1tArgdAgDh1vNdARCNYBui5sM2WNij574cBG3mSopw2bJvKTSgTQ1mChafm0sFn0vt
         fjEA==
X-Forwarded-Encrypted: i=1; AJvYcCWs+WArNzkdGkg+ZB/+tvXxOty2SRasOge7UeuLYS45pAxlPK6Q18+ZBmFjnLQtRKZzBo8p1JFLaBdOnpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGVgdFr0wp0Mq4pNUYFajqBhQBI8KBNbzu0wPxA3VFCxbVYFVv
	mIe4xhcvFoYwcF9Dg8tbi+qUjnMtzg6bDDANJNN52RxGWdcEpjui780iNpVtsN3ZzWzfwUqaECN
	k9HtXoPtyF4duiVpSGAUAi49YU13Stt1Z0GOJ
X-Google-Smtp-Source: AGHT+IEfmCQ3hZ8svgRwn+GckVGZCAfOe+elTox8PuWNhBqZ36SOmiZ6fR2RBEa7OdFZPfWIpgnGWRX6MIqrw1Ymg2U=
X-Received: by 2002:a05:622a:2997:b0:447:dd54:2cd4 with SMTP id
 d75a77b69052e-454e65ddd5fmr5974661cf.22.1724233116288; Wed, 21 Aug 2024
 02:38:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240712-asi-rfc-24-v1-0-144b319a40d8@google.com>
 <20240712-asi-rfc-24-v1-26-144b319a40d8@google.com> <49849e0b-5ed6-44a4-94b3-1d5dd54b9a29@amd.com>
In-Reply-To: <49849e0b-5ed6-44a4-94b3-1d5dd54b9a29@amd.com>
From: Brendan Jackman <jackmanb@google.com>
Date: Wed, 21 Aug 2024 11:38:21 +0200
Message-ID: <CA+i-1C1pdcdk0LYBJ=3mMqmP6x91Wpbo64ekV3uUirLpsJtjJQ@mail.gmail.com>
Subject: Re: [PATCH 26/26] KVM: x86: asi: Add some mitigations on address
 space transitions
To: Shivank Garg <shivankg@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Alexandre Chartre <alexandre.chartre@oracle.com>, Liran Alon <liran.alon@oracle.com>, 
	Jan Setje-Eilers <jan.setjeeilers@oracle.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Mel Gorman <mgorman@suse.de>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Michal Hocko <mhocko@kernel.org>, Khalid Aziz <khalid.aziz@oracle.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Valentin Schneider <vschneid@redhat.com>, Paul Turner <pjt@google.com>, Reiji Watanabe <reijiw@google.com>, 
	Junaid Shahid <junaids@google.com>, Ofir Weisse <oweisse@google.com>, 
	Yosry Ahmed <yosryahmed@google.com>, Patrick Bellasi <derkling@google.com>, 
	KP Singh <kpsingh@google.com>, Alexandra Sandulescu <aesa@google.com>, 
	Matteo Rizzo <matteorizzo@google.com>, Jann Horn <jannh@google.com>, x86@kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Shivank,

On Tue, 20 Aug 2024 at 11:52, Shivank Garg <shivankg@amd.com> wrote:
>
>  .pushsection .noinstr.text, "ax"
>  SYM_CODE_START(fill_return_buffer)
> +       UNWIND_HINT_FUNC
>         __FILL_RETURN_BUFFER(%_ASM_AX,RSB_CLEAR_LOOPS)
>         RET
>  SYM_CODE_END(fill_return_buffer)
> +__EXPORT_THUNK(fill_return_buffer)
>  .popsection

Thanks a lot for the pointer! UNWIND_HINT_FUNC does indeed seem to be
what I was missing with the objtool warning.

Regarding the build failure, could you share your config/toolchain
info so I can try to reproduce? Would be handy for checking my next
posting. Now I see your mail, it seems surprising that it compiles for
me.

Also while I'm replying to this thread I'll note this:

> +       if (!IS_ENABLED(CONFIG_RETPOLINE) ||
> +           !cpu_feature_enabled(X86_FEATURE_RSB_VMEXIT))

It's called CONFIG_MITIGATION_RETPOLINE now.

And furthermore, kvm_get_running_vcpu needs to be noinstr, I'm getting
an objtool warning about this that wasn't mentioned in my cover
letter.

