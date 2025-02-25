Return-Path: <linux-kernel+bounces-530288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FA4A4317C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 01:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEC91173C57
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 00:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8136FBE49;
	Tue, 25 Feb 2025 00:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WS2UVq9d"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BF34C8E;
	Tue, 25 Feb 2025 00:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740441653; cv=none; b=JZBbZpKAQFIYN9avcB6YvqVYkRJKx3IG0F8AkNdOvapIeziXlfzA1y7Unw0TPte93kgaEZ+KpJ1gOD/5yAnPgXPR51z9pwf1BFMbjcNiD6BDEXNy2TYwuahF2qgFl4AOIPU/7FOyA1Jv4SYnBDNtURJuSsqM8C9RtucgXlBf18I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740441653; c=relaxed/simple;
	bh=aKy6zvZJPH22QLCWeZbB/gNhRbgPuueVPnEq9aawybU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bwd9HNkxag0EeTjEh2P3HIlbAfwJpBKwQyHw3nemUXqgsbGEJwEL0/++O9nEurK+JNaBC3pUDpq3xDUM5wi0C6y7rNn/1RphOMnnDk8pL53Q16dVvwAS63F/HPKL593pxLQAHXdPCedprZui6jia69ZR8mSblQOZ7cGnBxhEOB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WS2UVq9d; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-abb7a6ee2deso771610566b.0;
        Mon, 24 Feb 2025 16:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740441650; x=1741046450; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zwmz29OaB4anSC3HDaaMnvvDxasPenPirxVhby3n1zg=;
        b=WS2UVq9dLFPY7WEDatruuANg07CKYkTiyUD065bXwojU+AHYSyX//UkZg4Mhweb3gX
         UL1EKcVlMa5SnHLCEvJlcDZLAk1fwegDprVotOPckY42XaMoBV1N6PIJc8acYEwLIgXS
         utbN3k1oEXU+ydrnGVzH5g4Rq2baPiMbtDcyjsC4SJ5jTQS2d8JgnJCNYQgU/0Irg7Fa
         VzitNnST4lAB1NkIgfA8f6mFJQyEMP4BRfIPnRTo7ue/OVne++e2QXwEnUvef7vOSdzT
         i8NsI1gOKqax6uSAH5RoMH2WdQJHdJjEZtK4U3Gaap/icJmDaLec5GOzc9H5Yhlb2LX5
         LdGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740441650; x=1741046450;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zwmz29OaB4anSC3HDaaMnvvDxasPenPirxVhby3n1zg=;
        b=IFl9g318BxZSUGj5JdbzCxPn9P3KzKXRXfhelE7R7kgLD0C917NHDTE1AGK1ALHiqA
         LzaWnIQzlbVM4giSDP7JkvbRMr+LX8zh8a83kEN/I1b6Kg43fQt+tKIT/11mQAPAIRDY
         6A+tkcbfUPHJsrJC9fowRWoYU1XVqHEq260WWvXmw+qpwuV+4hQjiZWmjT2OCItgAXEC
         NkE7MwJKbBTf8n31G4W8UTPVZ0P6NXx6F4t6TQ0QsWorKziWYMoj7uXdnEg1KhLfXmoy
         /Vzsp377rJJ0tkq8yqhUw1u8oxo3OgOAt2aTGEr3EKPRgmQya6LXEpbVciAs2sbzCc8Z
         mZvw==
X-Forwarded-Encrypted: i=1; AJvYcCUIiY9UubOISFJ87Wnq28FxAwVYeZBM1s0irb3mnINk2+n2UNPop1rtkVcFbTxPpPY5WABo+jo0y0Pb@vger.kernel.org, AJvYcCVURJCCr8hNhTFmUL2+QDYuxlzqUmjrVI45s8HGw1ibuo6DXWfKbGqPZATbWECDbJu9bPLTRtI6bK4H@vger.kernel.org, AJvYcCXsvkSpZBK1V23t6nSWGPYj61waIaOO2BbZM8S11BhsAAFFY1knzwB/5XrLpyb6Zk7Vo6Pf+5CeYt9pDczD@vger.kernel.org
X-Gm-Message-State: AOJu0YwoojhWSVQGVsUEfJ5ESfQcwsD5ncWx9Js046hgCHBZkpusy9Tl
	3woqDF8NdvI0guGnU5Ar35Wtoq4ZExQrc0MRtF1gP4ivqfpvacMv
X-Gm-Gg: ASbGnctN/GojWrLyJPKKtbtKbjDRdwF6+Jgj5ktsXKFACHgHEd91xkmS3bwPqdBhjBQ
	fdOc8ckTHdEKKyG9umPAWdkBwWGBcTV60dkEMQ+0cBtzk2XoqEhjbaM74/gvFsI5ma130siH0ko
	qL4LQLn2LwPoCEqkS9Pkp1rn8kEELQZSTWtD5qLGrvRuc3VxBuYHEyetSMLUvHFbWsoSlDMZZSn
	rXW6VE2mKSZX22bGq0jLaPv/a0Qx6UQeiIIqZ5k4XdALy5DGSecrHKs6wuDcao/SnBFy5avGRaq
	d8Opw4v5oQP0QYI/83E62T5Y/w==
X-Google-Smtp-Source: AGHT+IHCiDeg8iTtlMHBTT+8rsM3bDbDCpBQksJY/HtiteE5vEuZdMawubgKL7nC7L+KAJkK6uv0bg==
X-Received: by 2002:a17:906:2c4b:b0:abe:bfdd:e68c with SMTP id a640c23a62f3a-abebfdde8f5mr390505766b.4.1740441650101;
        Mon, 24 Feb 2025 16:00:50 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed1da4892sm42880766b.82.2025.02.24.16.00.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Feb 2025 16:00:49 -0800 (PST)
Date: Tue, 25 Feb 2025 00:00:48 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Wei Yang <richard.weiyang@gmail.com>, linux-kernel@vger.kernel.org,
	Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Anthony Yznaga <anthony.yznaga@oracle.com>,
	Arnd Bergmann <arnd@arndb.de>, Ashish Kalra <ashish.kalra@amd.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Ingo Molnar <mingo@redhat.com>, James Gowans <jgowans@amazon.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Pratyush Yadav <ptyadav@amazon.de>,
	Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Usama Arif <usama.arif@bytedance.com>,
	Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v4 12/14] x86: Add KHO support
Message-ID: <20250225000048.f2nmfn5isuh3fn6s@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250206132754.2596694-1-rppt@kernel.org>
 <20250206132754.2596694-13-rppt@kernel.org>
 <20250224071355.xsl2dbupda4dhfzl@master>
 <Z7yD9g1AgtUUfKr0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7yD9g1AgtUUfKr0@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)

On Mon, Feb 24, 2025 at 04:36:38PM +0200, Mike Rapoport wrote:
>On Mon, Feb 24, 2025 at 07:13:55AM +0000, Wei Yang wrote:
>> On Thu, Feb 06, 2025 at 03:27:52PM +0200, Mike Rapoport wrote:
>> >From: Alexander Graf <graf@amazon.com>
>> [...]
>> >diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
>> >index 82b96ed9890a..0b81cd70b02a 100644
>> >--- a/arch/x86/kernel/e820.c
>> >+++ b/arch/x86/kernel/e820.c
>> >@@ -1329,6 +1329,24 @@ void __init e820__memblock_setup(void)
>> > 		memblock_add(entry->addr, entry->size);
>> > 	}
>> > 
>> >+	/*
>> >+	 * At this point with KHO we only allocate from scratch memory.
>> >+	 * At the same time, we configure memblock to only allow
>> >+	 * allocations from memory below ISA_END_ADDRESS which is not
>> >+	 * a natural scratch region, because Linux ignores memory below
>> >+	 * ISA_END_ADDRESS at runtime. Beside very few (if any) early
>> >+	 * allocations, we must allocate real-mode trapoline below
>> >+	 * ISA_END_ADDRESS.
>> >+	 *
>> >+	 * To make sure that we can actually perform allocations during
>> >+	 * this phase, let's mark memory below ISA_END_ADDRESS as scratch
>> >+	 * so we can allocate from there in a scratch-only world.
>> >+	 *
>> >+	 * After real mode trampoline is allocated, we clear scratch
>> >+	 * marking from the memory below ISA_END_ADDRESS
>> >+	 */
>> >+	memblock_mark_kho_scratch(0, ISA_END_ADDRESS);
>> >+
>> 
>> At the beginning of e820__memblock_setup() we call memblock_allow_resize(),
>> which means during adding memory region it could double the array. And the
>> memory used here is from some region just added.
>
>There are large KHO scratch areas that will be used for most allocations.
>Marking the memory below ISA_END_ADDRESS as KHO scratch is required to
>satisfy allocations that explicitly limit the allocation to ISA_END_ADDRESS,
>e.g the real time trampoline.
> 

Thanks, I see you point. We would add memory region during kho_populate() and
mark it scratch.

>> But with KHO, I am afraid it would fail?
>> 
>> > 	/* Throw away partial pages: */
>> > 	memblock_trim_memory(PAGE_SIZE);
>> > 
>> 
>> -- 
>> Wei Yang
>> Help you, Help me
>
>-- 
>Sincerely yours,
>Mike.

-- 
Wei Yang
Help you, Help me

