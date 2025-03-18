Return-Path: <linux-kernel+bounces-566744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39266A67BFA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 19:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2761189F24E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 18:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837B11DE2C8;
	Tue, 18 Mar 2025 18:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SC0kAAn9"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC82F1AC892
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 18:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742322827; cv=none; b=nuyhwJB0Rz5mXXU8GRs9E3NI8mgpb/CVHJ6CN6duNrhmMtewj0VJldPqnin9Y7VOOSgaZ4gZyOS/dvQlfKxidGZGOE9XMzo3sVUAbalni1v07I4pVoKtX8xlAyf+h34V+BMdmVnZHPT2+QyKj0eOugkeIaQL0+DJAaoLdBLXVys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742322827; c=relaxed/simple;
	bh=JxWocTYQRgSYFL/cgy5gUXWgCv8mj2fV1HBW0Vo/u2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YBtkTsmjd8pm/PV0qjuXJ3CFXcHiet+2m0sYa4PiCvG25JsjQCBsKwGSFjzNieNdVfWZ5AqDscfywsu86K66oFFx2Rqvo7eEXuBqzln6EhKI6wEYaX77je64Ds5k1NA/lHg5OQ/2nGERIQSCscMECC7tyj1rOB73vJra6guqdDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SC0kAAn9; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac2ed007aacso1173692966b.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 11:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1742322824; x=1742927624; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BlwUV8/EKV47EmmjSR2Xs5sCzOBL6WwBTHn7b0L4IiE=;
        b=SC0kAAn9G1HoucnLGWeKtzR2nV71r62e/l9xXI+aCzCbNiYyS2Ha13QcoymIlxmNYb
         m3iUAj/CVFKUJz4gQbPIyXSsGkJ4VL2r6vvSKp6SVxnh/FPHh8+l+bY4uedOHuLysmh4
         mJKKtlbKJjh8JlIDjPh7HuyOmhK/ibnhyZ0+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742322824; x=1742927624;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BlwUV8/EKV47EmmjSR2Xs5sCzOBL6WwBTHn7b0L4IiE=;
        b=ILdB2TuIK7ri5Y9IbJTd/spasmu3j33FVUxYnpD+o6Brx/yhNMgAiSaM3CjpEaI/v7
         WFx54oK8Uzwtl6rbIl7ky4maVp1S1xBPvCwWcffSx1hJqlEUMNIkz24QUVmC02dxgsbo
         LmKlfiB9lUY6IPvmUP1/5rrsdUnkVxLczG2p/11W1KpzG8dVhU4aKBS5ilsPhmqGJkWe
         wDNb2e07C0wtYdEi9ye4NjO69WxohIyCLxSThEq2TcmjOpNk4K5n7u6hrY7o6afFe+QQ
         xr82BHSoIu4duZqjdN+SAOkyGTQ0M4gYdxQ9z94EV9Q8S5aFP+jJJAdQ5CE4YJt5MbIw
         r+mA==
X-Forwarded-Encrypted: i=1; AJvYcCVgMjgbTFY4btjPZlWrsrSD4j2XFwKzcycDTkLDxYR7um+CTWTJJSAIo03yOO3GUmsuyfuqTTBZ1ky8uQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz695HSaES44dFlYU3lHLWhXLVO5p8mUfK5GIn4B2XTv1Zi8RZH
	0aR4j/0KI6HYRouosq2QZYYPYl7LredcftSnEE7QI4cwyk7VbOwlij4EFUzFereXpwAnid2CqL2
	OS5k=
X-Gm-Gg: ASbGncsxxl2+3/cughlIXMvuNXgiexj5Q05KwfPFJCRXoyi5vkLEhstzdWyNJLDnaT7
	vz/uJ51urc6SXDLZLqTE+K1Qk5Tja7UNNDzy4uSqVwfILMxt0VliOWSEQybfHjeh/fSAtf3SanE
	F+O/mmJPyrxTJ7SyY3LtaPUfLQ1CoENXkU8G3nAIXExGsGDNGuo8Azwwu3H+SFBer1Wc9T0dBp6
	Hymbe9UbliqOdF6IzNXGCzmr0nfk+0MbcH3hR81gGU2+S3pof1igiEbQSNa3GzjsAtsyYXOX/dw
	eTrUtIvI0+FHYNebIwUmE8U26FOyu1Sdc1smkKsbyXGK1CeqcsM8MydwdUsok1O4FssZNDkK/DK
	Mg8IpV/OBdVQ25xZ+JEVRZ3qrWdYiPg==
X-Google-Smtp-Source: AGHT+IEmRKDPUSzCkKyAOalMLD54jLXu3UR9ykv00WyWJxJlitJ5UjelVbbPsRKP14jPYqt0orgv9w==
X-Received: by 2002:a17:907:7fa1:b0:ac3:773:62a7 with SMTP id a640c23a62f3a-ac330272e60mr2094152966b.31.1742322823761;
        Tue, 18 Mar 2025 11:33:43 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3147e9cb8sm890431966b.53.2025.03.18.11.33.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 11:33:42 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ac2ed007aacso1173685966b.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 11:33:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWDXLZaxDGMtC2s6PBaKF2w4z1EZr7jQg64e8p+XfsIYA/Qo/pUnt+FkRMfX1ZxFEP1ZiowGP7UyVdc8+M=@vger.kernel.org
X-Received: by 2002:a17:906:340f:b0:ac3:4487:6a99 with SMTP id
 a640c23a62f3a-ac344877921mr1175205366b.47.1742322822461; Tue, 18 Mar 2025
 11:33:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317221824.3738853-1-mingo@kernel.org> <5A417EE0-8DF3-4C6E-A7E9-9EE6705282F1@zytor.com>
 <Z9m1rtmlk1PxGIQA@gmail.com>
In-Reply-To: <Z9m1rtmlk1PxGIQA@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 18 Mar 2025 11:33:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=whAUHyXM29_9w_T26=15D1KZnuR3R+f4MT9f-C89oukvA@mail.gmail.com>
X-Gm-Features: AQ5f1Joe4-oM2jfUkY6bO3W92E87-RP6wjSQvN3AznFLlCuRU4dy5a3khXFz2dw
Message-ID: <CAHk-=whAUHyXM29_9w_T26=15D1KZnuR3R+f4MT9f-C89oukvA@mail.gmail.com>
Subject: Re: [PATCH 0/5] x86/cpu: Introduce <asm/cpuid/types.h> and
 <asm/cpuid/api.h> and clean them up
To: Ingo Molnar <mingo@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, 
	Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
	"Ahmed S . Darwish" <darwi@linutronix.de>, Andrew Cooper <andrew.cooper3@citrix.com>, 
	John Ogness <john.ogness@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, 
	Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

On Tue, 18 Mar 2025 at 11:04, Ingo Molnar <mingo@kernel.org> wrote:
>
> plus we could implement the main CPUID call as:
>
>  static inline void native_cpuid(struct cpuid_regs *cregs)
>  {
>         /* ecx is often an input as well as an output. */
>         asm volatile("cpuid"

So this really needs "asm inline" now. Because if it's not inlined, it
generates horrific code.

Anyway, I agree with whoever (hpa?) said we should probably just
unconditionally make all "asm" be "__asm__ __inline__" .

And then *if* there are any places that want to out-line the asm (why
would you do that? At that point you'd be better off just writing
assembler!), they could use an explicit __asm__ instead with a
comment.

Sadly, I think doing just a mindless

    #define asm(...) __asm__ __inline__(__VA_ARGS__)

doesn't work, because we also have

        register void *tos asm("r11");

kind of patterns.

So first we'd have to change those to use __asm__(), and *then* we
could do the "asm() is always __asm__ __inline__()" thing.

             Linus

