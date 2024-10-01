Return-Path: <linux-kernel+bounces-345981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD7D98BDCA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 15:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A7311C20B35
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 13:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C6F1C5787;
	Tue,  1 Oct 2024 13:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O1mX0LwS"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CAB1C4631
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 13:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727789580; cv=none; b=laAHtSsq51iI02y0n0pfvt2/2+dnvWv3DLNwqKG2VMWv9xbuhQFT8bg8HoO/6bUocfi4p5DFDnEoJh646nO68FbjG7PUJVVyQjdBxe/cBK3uc8IxQ0jCsznJG4Wqv3rbceCPBmAntkblAxHZDfGMTEESjvFmadY6HHzvbMpTRyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727789580; c=relaxed/simple;
	bh=jG1f8aoHpacDaHdb5KmywmlItDO2TWAWsVpCx9NXHQc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T3tgtZPqrSwgdY9syCDfEjV/TO+FuGMkwl+5smyh0+CWe6OY5TULTnvZpb8dblYjZ0P/VLsfamCTq4ysgboaLLWgNWEEgnS6Uj81S7Awf7t8ifppDG024pXsA706gig61SRXbJltN1RDZWmAOyHGKwRq1jg6MoGsHwzDpEAxvgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O1mX0LwS; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37cd5016d98so2813580f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 06:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727789575; x=1728394375; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jG1f8aoHpacDaHdb5KmywmlItDO2TWAWsVpCx9NXHQc=;
        b=O1mX0LwSRL3zNP4rjkvL89rfY1wt70Vs+hGAibEAvPb/0ImD5dJ0lNh90KQyMEwFM8
         X66kLAI6cqq/dmNOhZxPoOgdzVwKGD59HSTLm2x9dTSv2cHV/S5XIJ5P2seYvlR8fC+O
         B1QPClmPDFncpHNToWU7ZLCfdviBk1/0m8ta587kHmLl9nHX8V3ryi96JW/wExoD9eES
         BisXkDQwHWseMz/RsXoGWSNX0SVZ/d0D5D117bZZxJBFN6eH5nCLAUjcOZMtAdhnvJ8i
         rXFFoBjd8YkeY2o//LqVOenjPpK+SA0ILAAsNnx4N6u5pGw81QKK+QNbX96OEX7h1vxN
         XeIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727789575; x=1728394375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jG1f8aoHpacDaHdb5KmywmlItDO2TWAWsVpCx9NXHQc=;
        b=ZmBAwRoP8L0gHiF2S5ezkdlrcGkwf+nmOKBIzVg9tMcAA/95djYbntRFiC4wKvSHqN
         ZbwPWo6JnLwEsotRqAp/O13C/+n7IjjV2YLXgzJFvVMscS5xf1So4X3U6S9FF19kdO0G
         r8wWM45htYlZWz+zTJqvJjJsGYIVlEYcyIvwxuqeIeKzHnU3F9oHwQLUMGJ3TV5CtA3u
         qX+rcYYEYJpLfL3SZvW3QzAVQrHJZbIciGx5qluXKD4Mr4WDrDF1QVYMLOsx5IJfc9sm
         9NN+USu5+BljQ32aKkGRq5Nkn4IEQtkeVOPj+8fY2mbkijvcJzteCATfV3C5MbQVFhgd
         LE4w==
X-Forwarded-Encrypted: i=1; AJvYcCUY/tzILXX62WusYMP3EsL1SCphYeUciXwBw9aQL3xMAO7N6rd4VJFXq4bVbD8hc8LBVGUXy5B9jVwQbI4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy15Gf/aWCcTy88UCOCbpQs2NKjSVFyE0hyq+NFxMHIoWdpGKjS
	TRanRwzB9q61V5+vRU9UNo83heRYxzUiO4PRALGtqOF5jBP54bmj13lxVbHTqia2vNiYCIrbyq1
	gOR5XCv5042FZnfAIDfON8MQ6CaI7wxUPP8/h
X-Google-Smtp-Source: AGHT+IHyQsBQmmP7WyMzsvnT7IUWl/PkBkfPPLhhwzoxkBXURriZ4Opu2OW3tEtRkPbGqwQWer73IFV8Bp15N9mptmE=
X-Received: by 2002:adf:e8c1:0:b0:37c:d261:3c6e with SMTP id
 ffacd0b85a97d-37cd5aa9a0dmr7774912f8f.10.1727789575379; Tue, 01 Oct 2024
 06:32:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822-tracepoint-v8-0-f0c5899e6fd3@google.com> <20241001091527.2fe4e039@gandalf.local.home>
In-Reply-To: <20241001091527.2fe4e039@gandalf.local.home>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 1 Oct 2024 15:32:41 +0200
Message-ID: <CAH5fLghOiGmcpQZvOwn=d2Jyo5+CDA_cinbGjkmjTgSeusAC2Q@mail.gmail.com>
Subject: Re: [PATCH v8 0/5] Tracepoints and static branch in Rust
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Jason Baron <jbaron@akamai.com>, Ard Biesheuvel <ardb@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	linux-trace-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Sean Christopherson <seanjc@google.com>, Uros Bizjak <ubizjak@gmail.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Mark Rutland <mark.rutland@arm.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Fuad Tabba <tabba@google.com>, 
	linux-arm-kernel@lists.infradead.org, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Anup Patel <apatel@ventanamicro.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Conor Dooley <conor.dooley@microchip.com>, Samuel Holland <samuel.holland@sifive.com>, 
	linux-riscv@lists.infradead.org, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, Bibo Mao <maobibo@loongson.cn>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Andrew Morton <akpm@linux-foundation.org>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, loongarch@lists.linux.dev, 
	Carlos Llamas <cmllamas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 3:14=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
>
> Hi Alice,
>
> Can you rebase this series on v6.12-rc1?

Done:
https://lore.kernel.org/rust-for-linux/20241001-tracepoint-v9-0-1ad3b7d78ac=
b@google.com/

Alice

