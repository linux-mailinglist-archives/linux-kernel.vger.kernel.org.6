Return-Path: <linux-kernel+bounces-545559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F50A4EE92
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 21:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93532165EC8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 20:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3C6251781;
	Tue,  4 Mar 2025 20:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Wqp33F2V"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358971FECB4
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 20:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741120892; cv=none; b=NNDpEMZ68Z0g1vUlGMF2uq5UN/3yrSMODlLX4Duzk1lCBtQL+6EG3hbZfNnYq9t8rClaH/ZxosTBta4xhYQEkIJkL3Ts8FLS5nboUyPqqG79sgA/A4x1rASUlcbpkLt1ES2pjS68OCzZh/itNKk3mzXHHVngEQy5TwtJ5SIEI24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741120892; c=relaxed/simple;
	bh=GJUYkFswbf3vcwD4sF00gsfWBJ+WhaC1VZb82bhTK0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mg11a8amaZG0aWm3ilhrz4aqHKabeQAY+awnHLP89Vwgfmy7Jn6ccIV8T37Q+QUkbNHICg3TxVYOJ+fWLQLbGKFA0XBx6ESg5u8JhxQl/ZD4HgbJcEWg7LL2VMX1xcPJ5Dmq3AGJiVRjDXvwW2lNorZaJQJpuV56hg1W4dkRVok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Wqp33F2V; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5dee07e51aaso11333321a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 12:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1741120888; x=1741725688; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kxXwhDVyR6qbTJQoUXWwo1wlriinEbaY/hOWV7spF6o=;
        b=Wqp33F2VaPIJFh3mI3JhHiImierCA39zLrSmudtiepBvTcdh3eG+b9tf17hNy7DoGY
         rLqWfYOuxk9hjCh8ZrbQFVSmionL8x6fKsTeqm6BIKhl7LZfWsT+yDY1TWb1qspUzI4a
         H0X+SkUrNsedwghaoFQoFTHdg/o1x1zaMGStM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741120888; x=1741725688;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kxXwhDVyR6qbTJQoUXWwo1wlriinEbaY/hOWV7spF6o=;
        b=I7RD+3hizk7bZ6juuCh+H8RE1lv63fvXtZWkTlbXoEAwLFYM+VdDYz04FvWzdwnYyK
         rEhfs5nm9pbxxHGUzs++JgZig7LaDlig5NKgDElWiTX91qnrC5wfpnDDf4VL0eiI+3BV
         80czSH8p92nyzNK968VIOST3Ga4HwOxHp/z4F3w4N9MvraLyhWo/a8IVAfFT3DJMDAYl
         wraZEhY85MKP4ha0sCYub5xrGS62lLmGIXA91P2qdtGT+1mV+5yts85D23JPIybfsnQO
         9Zp3EBZWHBtrFmaMTgrptlrSxlLRSIhvwLtvCKwiNFbfo1o5+YC+MFiEivoYhgYywFgw
         jlDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUP2v59NV7slPMVBoS4gNvtzD1jNDtSfRjGk50P+fOIrl5Kpm4Gz2Dj36wIeagBPHfZncZb/Sbu9H163ps=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8Zb2XKqGpdh3qfYiLryy5432HKwkjvcD7VDkECcnuvrugntSD
	MW+8ThFvD2wfiqU1EsW8S/XwxPbGe3/skbMkDVD9fm8+PovC0mFskjWaYX307Wa5PJ2yBZb5atR
	UKU9p/g==
X-Gm-Gg: ASbGncuSLWTr7MEH6T11FdFh7ppSEoa+1xvCycRhuJjtanmobQitMWKpASgd8UwyCIB
	MOB1ixt5LirKs0JG7mFfmwlsFlfP8qlLVMsVP84a0hmUJQYQn+JMkm3Tp2SS6TNIUt7mwRUy+64
	0ElSigy2TU1SlAfwm56rUBuO+lmKNfMfcSXja5bD5T5bMnnpnOx/e0zIzquFSUa3gs+gWAbGaQK
	sJvLHYCKxKeWUeYCphEY/DGfvEgXn30J0KGOpFwXdhBkPkezG6BPhwKlnuSXRlwSDP4zawCC6DF
	HQ2V9TXBfotmf89Nur3fkGGKb9t6Fu5egUAre04qunv9LzsBQh4PHZ+znAq6Vy8lcx6ZFyHk0gd
	aUR8kwi6BN3ps+2xqV3Q=
X-Google-Smtp-Source: AGHT+IEygEf/8vNWFxJpnsK1uIiaVOh2QmcOlqIEeMr/QQCeuzVo1n7KDwTiJ6mSrFOx8ImfVlbVgg==
X-Received: by 2002:a17:907:9451:b0:ac1:e53c:d15a with SMTP id a640c23a62f3a-ac20e1e0852mr56013966b.54.1741120888195;
        Tue, 04 Mar 2025 12:41:28 -0800 (PST)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf4e50c80esm679862466b.61.2025.03.04.12.41.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 12:41:26 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-abf5e1a6cd3so577620266b.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 12:41:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWC/ki9xkWvYzr4725YBdTQaIrSI639FeYvezwAQOVJ8FFRuTBA2UknYh5+A43yDw27wRunmV5Vcwj85gc=@vger.kernel.org
X-Received: by 2002:a17:907:d94:b0:ac1:da0c:f668 with SMTP id
 a640c23a62f3a-ac20e153524mr57232366b.43.1741120886518; Tue, 04 Mar 2025
 12:41:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <174099976188.10177.7153571701278544000.tip-bot2@tip-bot2>
 <CAHk-=wjSwqJhvzAT-=AY88+7QmN=U0A121cGr286ZpuNdC+yaw@mail.gmail.com>
 <Z8a66_DbMbP-V5mi@gmail.com> <CAHk-=wjRsMfndBGLZzkq7DOU7JOVZLsUaXnfjFvOcEw_Kd6h5g@mail.gmail.com>
 <CAHk-=wjc8jnsOkLq1YfmM0eQqceyTunLEcfpXcm1EBhCDaLLgg@mail.gmail.com>
 <20250304182132.fcn62i4ry5ndli7l@jpoimboe> <CAHk-=wjgGD1p2bOCOeTjikNKmyDJ9zH8Fxiv5A+ts3JYacD3fA@mail.gmail.com>
 <CAHk-=whqPZjtH6VwLT3vL5-b3ONL2F83yEzxMMco+uFXe8CdKg@mail.gmail.com>
 <20250304195625.qcxvtv63fqqk6fx4@jpoimboe> <CAHk-=wizdAA_d1yHZQGHoJs2fqywPiT=NJT2wNA0xybV+GVefw@mail.gmail.com>
In-Reply-To: <CAHk-=wizdAA_d1yHZQGHoJs2fqywPiT=NJT2wNA0xybV+GVefw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 4 Mar 2025 10:41:08 -1000
X-Gmail-Original-Message-ID: <CAHk-=wiwhHKvxZoaCPs2Zs4gaMAfCyZ=arBvXdP_kvNKOH5sKA@mail.gmail.com>
X-Gm-Features: AQ5f1JqwCdnEAOm6EQyOOf2Fa04agj1a8LvsPchd0a3tBCRJF8Yhs-p8vOWYtdw
Message-ID: <CAHk-=wiwhHKvxZoaCPs2Zs4gaMAfCyZ=arBvXdP_kvNKOH5sKA@mail.gmail.com>
Subject: Re: [tip: x86/asm] x86/asm: Make ASM_CALL_CONSTRAINT conditional on
 frame pointers
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-tip-commits@vger.kernel.org, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Brian Gerst <brgerst@gmail.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Mar 2025 at 10:13, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Does clang even need it?

Bah. Yes it does. I may not have clang sources to try to look at, but
I can do a test-build.

Anyway, I do think it would be better to make this compiler-specific,
and keep gcc using the old tested case that works well regardless of
whether frame pointers are enabled or not, since it doesn't _care_.

And I think there's a better way to deal with the whole "generate
better code when not needed" too, if clang really has to have that
disgusting __builtin_frame_pointer() thing that then has problems when
frame pointers aren't enabled.

IOW, you could do something pointless like

   extern int unused_variable;
  #define ASM_CALL_CONSTRAINT "+m" (unused_variable)

which generates a dependency that doesn't matter, and then doesn't
then require preprocessor hacks for when it is empty.

So I *think* the patch could be something like

 - move the define to <asm/compiler-xyzzy,.h>

 - for gcc, use the old tested code

 - for clang, use the "either __builtin_frame_pointer(0) or dummy
dependency" thing

 - have big comments about it, because our historical changelogs
clearly are not accurate wrt this all.

                 Linus

