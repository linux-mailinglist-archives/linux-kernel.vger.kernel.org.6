Return-Path: <linux-kernel+bounces-570832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC3AA6B524
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 08:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C7C8465762
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 07:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E98F1EEA31;
	Fri, 21 Mar 2025 07:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="OAPjI+Nt"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EFB1EB9F7
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 07:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742542555; cv=none; b=KwXzgzm6Tj8OSirzL97sPTyeZr891rJ6atYpaoqbgDGT0w8DeiD4CRRNRKSP5N20HxE994QZxxYey6ExTMHpEHC4ZUPS64WioQz3vFS88rlYXzVO/1A+np3b4uyonwqVxcEGDxdrPvzLZ1E1CslO4ZWPpAdeu2RuvXEew+ZB88U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742542555; c=relaxed/simple;
	bh=oVEU4h1wTtlqlUbh+FEIic8QhsG6E3beaWkZ1pscJx8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=tttGq5zJMNZ3EBhSaNhENZ99TENWidiObK8oeJ7nXzsfs9gAbsC6KLGQFaMpWxnDGyAPSnd1heW1kgIIgEq4VK2vCcxeAX7JkHXyoa8EscN3V2b18Lg23M698deYuYJHhS+rdE0CVNlobcE77Cr+6DvkIwdMxNd9z9OLSnyr8u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=OAPjI+Nt; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-39127effa72so192681f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 00:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1742542551; x=1743147351; darn=vger.kernel.org;
        h=in-reply-to:references:subject:from:to:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uE0YN48K2zRXVt+YdSQ/RPd3ayIjfmSlm7kfHTz7O6c=;
        b=OAPjI+Nt8Mx7oV7aEVLf94wsdw+DPtnZFtkzH1+AA2u31jCIT1+VBXpuzC/2X46qXd
         x558zm27VkDuYd75yDwCGQuu9lhq5Xj+h41lYnMHrm9krK9AyzXE2UAZUEYZRGp0WxMs
         cJqdtk9U6Nx3CFN4imX/4xn2O2btcPml93+vKVoV4monqJ05p9WMdHx9rToeFw+yb/Dz
         MIy/AwQZkpRzQWF65imYjbbFbhvMKNFMtxfo3QIfFjf2+Wc3aq0hmwkU66NjrQACmYMH
         XFXCaiPgCRmEm/sRm7nFcbQmPR2a7RCeEsqkBAT5wj57EOelvetdxbMq82PQmd40/kob
         1WhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742542551; x=1743147351;
        h=in-reply-to:references:subject:from:to:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uE0YN48K2zRXVt+YdSQ/RPd3ayIjfmSlm7kfHTz7O6c=;
        b=VVcDpUWjFE/BDvtSRTO7I3KmP2EVKn2G6y/iA2z6s6q3SFwf1X1aoyqDCj/wY1nm92
         WRe2iHezjXr8zEb1BuJGX0EdhrcfCgX8+bx3kIbrYksvmR1pv/ZNYueCnkSyRifGUEcs
         2yh+ZguLbfOMTicuO5lMf1MhodHJWRhnX5tpihRoDmyut4ugX8fKOPSvxI5rNqO2Jq+F
         ESKZvA/kOYjJ6bxclLdSUBZBXDIt3oi1HYF5xhslVy+jFo0AgGrqnp3nXkle1DsvB3CK
         89+H5l3oP1RMz+dZzAGynlfengmWqN2E9BnFPBHk2K76WGyoD/TcjQ+50TtA/daU4AxC
         OOlA==
X-Forwarded-Encrypted: i=1; AJvYcCVO+fG6yoqPQCrL7OKEFi8Srlm65NdG6+d3mEwXSm0tUfwJRQZBZ+ncxPFUwuEVyJqvmDjfxUmxkeupXrk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUCiDR7Ys4uCzQzrd6sg3o0Qala8GjVH7VNZrWjVwQAizCKCd4
	pekLEF7ob+zkGPyFGHpAagHQLRmUWEC/MJCPIwlHfkMyBOwxBm+ns5QHjzHKSRw=
X-Gm-Gg: ASbGncu3q5PUbsXb6Z9nvRK6DDFblcEVBKtkIipwIvs36VpiNknGjoD48o+BDI5/MVt
	Rjcd2QbASWrHBkz8LBijpPsLfh9U2tfEky7w5mpwOaD8m9WMhep1bdDCka3n7/OEaiTMHyNgFRe
	KTdXgg8fj79PVF+S1fiU6CIqz441UEnAskA0MZDNGcS1OR4yw/9EfQoVD3mbaFvE5lbT8N4JQmp
	qKg0HZwzHpf8L9OHbX0NkiFheAjGplkFbeJSbk0M33TXW7hz+/inkBsi34veS9fKT0mJSokLq8o
	ElH2EWurnct/ZrcgeTOxGIlhq44Uj6aEAtJS64CX19mWMZjc466vbdeYxSG2UPXLL0IXnItcHjj
	tyuczlFrTJFNWv5U=
X-Google-Smtp-Source: AGHT+IGZStgpQKD6s5SPSh0Un5MoJV2dCYto8osYkw90aX9XoWoskpnSL/J6+EfI/KAtzzUYKMCKnA==
X-Received: by 2002:a05:6000:188f:b0:391:277e:c400 with SMTP id ffacd0b85a97d-3997f941b74mr851925f8f.13.1742542551154;
        Fri, 21 Mar 2025 00:35:51 -0700 (PDT)
Received: from localhost (ip-89-103-73-235.bb.vodafone.cz. [89.103.73.235])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9b3f7csm1592933f8f.49.2025.03.21.00.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 00:35:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 21 Mar 2025 08:35:49 +0100
Message-Id: <D8LRS46QQ2FE.ZF1856CR80JM@ventanamicro.com>
Cc: "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar"
 <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>, "Dave Hansen"
 <dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
 <hpa@zytor.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Liam R.
 Howlett" <Liam.Howlett@oracle.com>, "Vlastimil Babka" <vbabka@suse.cz>,
 "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>, "Paul Walmsley"
 <paul.walmsley@sifive.com>, "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert
 Ou" <aou@eecs.berkeley.edu>, "Conor Dooley" <conor@kernel.org>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Arnd Bergmann" <arnd@arndb.de>, "Christian Brauner" <brauner@kernel.org>,
 "Peter Zijlstra" <peterz@infradead.org>, "Oleg Nesterov" <oleg@redhat.com>,
 "Eric Biederman" <ebiederm@xmission.com>, "Kees Cook" <kees@kernel.org>,
 "Jonathan Corbet" <corbet@lwn.net>, "Shuah Khan" <shuah@kernel.org>, "Jann
 Horn" <jannh@google.com>, "Conor Dooley" <conor+dt@kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-mm@kvack.org>, <linux-riscv@lists.infradead.org>,
 <devicetree@vger.kernel.org>, <linux-arch@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <alistair.francis@wdc.com>, <richard.henderson@linaro.org>,
 <jim.shu@sifive.com>, <andybnac@gmail.com>, <kito.cheng@sifive.com>,
 <charlie@rivosinc.com>, <atishp@rivosinc.com>, <evan@rivosinc.com>,
 <cleger@rivosinc.com>, <alexghiti@rivosinc.com>, <samitolvanen@google.com>,
 <broonie@kernel.org>, <rick.p.edgecombe@intel.com>, "Zong Li"
 <zong.li@sifive.com>, "linux-riscv"
 <linux-riscv-bounces@lists.infradead.org>
To: "Deepak Gupta" <debug@rivosinc.com>
From: =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
Subject: Re: [PATCH v12 22/28] riscv: enable kernel access to shadow stack
 memory via FWFT sbi call
References: <20250314-v5_user_cfi_series-v12-0-e51202b53138@rivosinc.com>
 <20250314-v5_user_cfi_series-v12-22-e51202b53138@rivosinc.com>
 <D8LFQYX4EHF8.2AJ01XL34WK0W@ventanamicro.com>
 <CAKC1njTyiaBkmHvAM8VT_MG4Cdch=H9P8r3C-m-=QQEuzyrRNA@mail.gmail.com>
In-Reply-To: <CAKC1njTyiaBkmHvAM8VT_MG4Cdch=H9P8r3C-m-=QQEuzyrRNA@mail.gmail.com>

2025-03-20T15:42:44-07:00, Deepak Gupta <debug@rivosinc.com>:
> On Thu, Mar 20, 2025 at 3:10=E2=80=AFPM Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrc=
mar@ventanamicro.com> wrote:
>>
>> 2025-03-14T14:39:41-07:00, Deepak Gupta <debug@rivosinc.com>:
>> > Kernel will have to perform shadow stack operations on user shadow sta=
ck.
>> > Like during signal delivery and sigreturn, shadow stack token must be
>> > created and validated respectively. Thus shadow stack access for kerne=
l
>> > must be enabled.
>>
>> Why can't kernel access the user shadow stack through an aliased WR
>> mapping?
>
> It can, although that opens up a can of worms. If this alternating
> mapping is user mode
> then ensuring that another threat in userspace can't write to this
> address in this window
> of signal handling.

Right, it must not be user mode.

>                     A kernel alternate mapping can be created, but
> that can lead to all
> sorts of requirements of ensuring the page is pinned down. IIRC, It
> has been debated
> on x86 shadow stack merge time as well on how a flaky alias mapping appro=
ach can
> become and weaken the threat model it is supposed to protect against.

True.

> Simply using `ssamoswap` is simple and serves the purpose. Enabling shado=
w stack
> access for the kernel doesn't have any adverse effect on the kernel.

Makes sense.  We just depend on an extra feature, because we should
consider the case when M-mode doesn't allow S-mode shadow stack, but
S-mode can enable U-mode shadow stack:

>> > ---
>> > diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
>> > @@ -320,6 +326,12 @@ SYM_CODE_START(_start_kernel)
>> >       la tp, init_task
>> >       la sp, init_thread_union + THREAD_SIZE
>> >       addi sp, sp, -PT_SIZE_ON_STACK
>> > +     li a7, SBI_EXT_FWFT
>> > +     li a6, SBI_EXT_FWFT_SET
>> > +     li a0, SBI_FWFT_SHADOW_STACK
>> > +     li a1, 1 /* enable supervisor to access shadow stack access */
>> > +     li a2, SBI_FWFT_SET_FLAG_LOCK
>> > +     ecall
>>
>> I think the ecall can fail even on machines that have Zicfiss, so it
>> would be good to disable user shadow stack if that happens.

