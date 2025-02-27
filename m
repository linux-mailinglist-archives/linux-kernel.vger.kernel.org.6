Return-Path: <linux-kernel+bounces-535701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B37EAA47634
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 08:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9406C188F428
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 07:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8228821CC7A;
	Thu, 27 Feb 2025 07:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dl9afDmA"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC99A433CB;
	Thu, 27 Feb 2025 07:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740639704; cv=none; b=TuUvZFIxRO1IziwEvrYXGEEYvyZsIF5RGVJ8QorcX3qkDREfaLuN1q3K2lr6v+Kf0iTk1jBh8tRrWAm9znwjrwEBp66gtAz0w4ZBSKn8Gwbwx4rpRTJkpjsR5tiRIXSgQZFoU5foj9UptQYQ9q4juJQEAX8mrS34DBcpSUQuCm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740639704; c=relaxed/simple;
	bh=3Lqh9XizIeTyAyCLnPjf0FaLSUdoiRpcIMx554DrbtY=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=QPIzC+PUhn524ffW7RinriAu9jhRc32Wn7EdldIoRxhcW8oKd3XM5p/YZbGyDkWGiIQPPT1VfIT0xVxsPOP6bN3dTm96Bx31+zj3HF/vZigVgxUrHWDyfOrZWJcOWKdazNgrgJ74/4LIYGeIkK+T8difqBZxdmyS3t4ataUIxMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dl9afDmA; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2234daaf269so13611625ad.3;
        Wed, 26 Feb 2025 23:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740639702; x=1741244502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G4Cf2Q2JGCb1vUFOG2D8/BTiCyHZaa8abHDKG2+9Rns=;
        b=Dl9afDmA0fCtNzkiR7POSBqav7rWDyLk/AybIvnGRHYNkZByWRjylLbSgycU4iMsjC
         IFSOz/3ahYhfLxv6b+2hkXxeMkdXNKJwn2kNQsXX47m/U78QC8RiAGu+k2ds/rIgQoKh
         2+OVCl82QPhxUrgbpwex3g9sZCh2/0MJ+HSi9U3dtQ7N6QxQ/Hfnywp1AigPEwz/7zal
         ZHRXtWMjlMaI/zpZa/bkcX5rOsrTaEkiozOQ2rtiLoDacIMrdGv8IYAIkqNW0yYopfjO
         nnSw0XKcmmqjYXH9ysATeGhcd+jkN0rfVa3EMy0UfiGvTeWs1W+l1ziylspid4OBYaL1
         uHyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740639702; x=1741244502;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G4Cf2Q2JGCb1vUFOG2D8/BTiCyHZaa8abHDKG2+9Rns=;
        b=aMbQIfMElVHj3hYanDdyR5T6I/V/9Jka5zgrkpwNgW8TSlx+Ogi9worrCL2KEp8wYL
         6FIVrwjAGMNi0AHejh0PjnPtnU279ICwfV6MR5ppu/hjrEJYot2w4BYwNvaQaciGmywL
         m6qTxXTl1Nf16hnKqn3FLnYpNC08rhZclDdQYE/ybTAJoactiZ52pEf8WQoaOZ3SW4eH
         Nm803hZsXlBJsoxAJdC72+Jwmq/7A8HosaxCg0PdOloa/uhLuJunbcPTW3DwzDAUdjzw
         GoA7F85LG1xEScnwJu/zpdYe9FdGSi/5h/72R80n53KlAWMAdBWm+BbM5G0nlqPN1iJO
         7/nQ==
X-Forwarded-Encrypted: i=1; AJvYcCVujeIgtr4/crgrdf0LRDdJKjisrEgDnxegKYmBPMBkjzmHp+2U7j1ii7TxEAxtmiiWKxLSy67GCQkxrFI=@vger.kernel.org, AJvYcCW8p2UH9bwf+cm3PaPcJGXCdT/dNqWxmvyDoGQf5easrzV476D38zK8t5DXimuboyIILCZH5Msd8ARd+hXxxd4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm5qOagM5ybzq+CH5ukiu4t6E58GvC62XHjhiTjZZGVJdrwk0+
	FrDnrzzvumcULVasgkTMbqdsP2Kiwu5Bk1nH/Uot4+m8caHqCquG
X-Gm-Gg: ASbGncuLAQM3utMQ3neNiYPzArEhZTpMbf04Fsteo+BUC17iCxy/pVPHxvzrCD4U4KP
	M+ROZiHTMBl2owYXGElnz8x9G/8gE78xWxXBIp9cjyCmA+95mBRAmvrv/9hDo6WbYQD2gQ4waQ9
	F0f/XzQQ29qTAk87T2oFzTZzr6dn+NDNZkcamTiNDPqcBr8wvdTk8ZaV+ExI1S7YC25fRw5nJ32
	CB+KDRWCIMdna2M3CvikJm0GbxYhKh+vmJmZ64D3C32MLJVF+73P7taVCZQ+/ejLExGX4T9ypOk
	I+ENHgr8oArxdBlSiGIs4lTfw3NExWdeuHhvxDgKacnM/NHDXjKGokhLbW28BTCm+Q1Kd5c6Bog
	XbGTplkA=
X-Google-Smtp-Source: AGHT+IH6Gzg0OYHyzDi78b7AFnhF1INa9SiQutoDGstlfU8EBaRq8eklnquk6k8/CG2wX5A54qoa2w==
X-Received: by 2002:a17:902:db0f:b0:220:efc8:60b1 with SMTP id d9443c01a7336-22307e6587bmr163986135ad.39.1740639701881;
        Wed, 26 Feb 2025 23:01:41 -0800 (PST)
Received: from localhost (p3882177-ipxg22501hodogaya.kanagawa.ocn.ne.jp. [180.15.148.177])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe825d2bd6sm3160785a91.21.2025.02.26.23.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 23:01:41 -0800 (PST)
Date: Thu, 27 Feb 2025 16:01:32 +0900 (JST)
Message-Id: <20250227.160132.578901242125873182.fujita.tomonori@gmail.com>
To: catalin.marinas@arm.com, chenhuacai@kernel.org, kernel@xen0n.name,
 loongarch@lists.linux.dev, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org
Cc: fujita.tomonori@gmail.com, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 peterz@infradead.org, hpa@zytor.com, will@kernel.org,
 tangyouling@loongson.cn, hejinyang@loongson.cn, yangtiezhu@loongson.cn,
 ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu
Subject: Re: [PATCH v3 3/5] arm64/bug: Add ARCH_WARN_ASM macro for BUG/WARN
 asm code sharing with Rust
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <Z79rO-wRZtN5S8f9@arm.com>
References: <20250213135759.190006-1-fujita.tomonori@gmail.com>
	<20250213135759.190006-4-fujita.tomonori@gmail.com>
	<Z79rO-wRZtN5S8f9@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Wed, 26 Feb 2025 19:27:55 +0000
Catalin Marinas <catalin.marinas@arm.com> wrote:

> On Thu, Feb 13, 2025 at 10:57:57PM +0900, FUJITA Tomonori wrote:
>> Add new ARCH_WARN_ASM macro for BUG/WARN assembly code sharing with
>> Rust to avoid the duplication.
>> 
>> No functional changes.
>> 
>> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks a lot!

RISC-V and LoongArch maintainers,

Can I get an ack? Or you prefer a different approach?

