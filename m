Return-Path: <linux-kernel+bounces-552478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95499A57A31
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 13:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFD5616DB78
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 12:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBD51B4139;
	Sat,  8 Mar 2025 12:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YhsDrL/2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NmGNVQkP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B8717A311
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 12:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741437454; cv=none; b=DrClyRQ1KIsIYJ49NYgmFotUe79LM1PMLT+0O/8Rw06EWj9Yy5KMvZbgsFnvQaf0S7Tr2dM2Y05c2DASWeIfIgKK11yUKutWZkc0gOsmHZnMO7DOBL31Rhr3T0YXJw8skiXkjJZMuIvs4ENsKzVp6yHH5EyDqBUPKG59gf7CUdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741437454; c=relaxed/simple;
	bh=Wf6JVzMeFP5SfVmulbI17SdUBUG71XcLDFYVQDNtUEg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uVbeJ8YE88IqBLil/aZY6HynP14bM9BBGSfJw5DaqEokZ0nUVeLlI27OcGtSqL8iIPM8i/S9ileTGocB22U9J7dmlv2yR0R6WR84H4r1k4+yn7TH0AeQP80qzEtdoNYvahSCdYBkdWATlhsA72tsivWb+Knq3y1a2Qv2UzVD2ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YhsDrL/2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NmGNVQkP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741437451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o8abf0OObLh7cZ3WWFsVYwo4EpsS2nDZ7Ej/A+vuDoM=;
	b=YhsDrL/295LV4DMGJmyeG5m59Er0pBPxblaWRcnwCDK/y5yjozDd7DoDlxC4bSiVpPZsnB
	GZoA4+vyRWmZmNZaXWQFwnhovlRyTLOo574r4Z+foLcPKukYepMMYXLQpBFTr1m809WX1i
	d3XL3e4Jr1WtoJnuzrLWExFXZExHJ4wwoZigcjXm0pu8Jyb+TYq4EGyp7Rx6YkW27BjQ3w
	OSPvivQ5uLtI6Be5KZxDwAny2jbZVJn6SLPPCdccoyVef3ReL92MkoEyvPJNYU9R3RpSZb
	5CykgaB95PHj+uYCIDlz5HvjXkqH1lnXSZ5RdL5ZLjSH2zzPDaRPicgAz8OyIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741437451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o8abf0OObLh7cZ3WWFsVYwo4EpsS2nDZ7Ej/A+vuDoM=;
	b=NmGNVQkPtxoG8GIZFsUt/CCutMvDnEhlPGrPQZUlA1eDT4l0qZQMhgwHpBWHBvXMWmgDRT
	2OQzka/4GKlsjLBw==
To: Charlie Jenkins <charlie@rivosinc.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Huacai
 Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Peter
 Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>,
 Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev, Charlie Jenkins <charlie@rivosinc.com>
Subject: Re: [PATCH v5 4/4] entry: Inline syscall_exit_to_user_mode()
In-Reply-To: <20250305-riscv_optimize_entry-v5-4-6507b5dff3ce@rivosinc.com>
References: <20250305-riscv_optimize_entry-v5-0-6507b5dff3ce@rivosinc.com>
 <20250305-riscv_optimize_entry-v5-4-6507b5dff3ce@rivosinc.com>
Date: Sat, 08 Mar 2025 13:37:30 +0100
Message-ID: <87senn3dh1.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Mar 05 2025 at 16:43, Charlie Jenkins wrote:
> Architectures using the generic entry code can be optimized by having
> syscall_exit_to_user_mode inlined.

That's a pretty handwavy claim. What's the actual benefit in numbers?

Thanks,

        tglx

