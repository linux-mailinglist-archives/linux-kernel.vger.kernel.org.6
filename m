Return-Path: <linux-kernel+bounces-515511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 050CEA365BE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 19:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEFE016E83C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 18:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6054918952C;
	Fri, 14 Feb 2025 18:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="s8dv2vqJ"
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F89134AB
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 18:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739557918; cv=none; b=meGTYjv+duvpXrp1h3B8M+dZfWS4xioK/lSbrjA3CAlNRf4dvmj71DeGGyflsmyGXeedB3WeUcShTGEqkSyineNWkb6gO74Hp4lKKVeiReFiI6GB1etzHWCsoVQn32GvxDsCsT6WFeip84e/1MHn6x/K6H8LkdJFtqHYAszGiAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739557918; c=relaxed/simple;
	bh=p3fzLWBxugP9UUQLXxBaAVSacaf+hJEcj69Vafsmb74=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=OwXfCuLLdWPQ/4cqtGNYpiJ9YMWNoW6SrmP3WbvOBuTmj8YdIwri+7nzpvR68sZxcDP4BimyZtryRSfXEl8+tnA1Fy/wo+VAdTnhYJByvWxoC+mMlpKi32GgyGGFCS7pDz17wkjoLvHAH2bMST4H23/UMChuXS86/Sn6o1ZtaMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=s8dv2vqJ; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1739557328;
	bh=p3fzLWBxugP9UUQLXxBaAVSacaf+hJEcj69Vafsmb74=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=s8dv2vqJdWTQ5e/kt71jraL+Uo4nTZcq4pVLfEgg/qqtiCpouftP+sGWVAn8m6Fmo
	 VtgLqsfvxIQBYHdaH37rVJnDDTAmKNp1CfnQFXkl5dVqex25fqvuE8DZOlkm7Z3CZs
	 Ac2gWiwbbp9wTfTmkEiLPItE+h+JsgH32frEqjSA=
Received: by gentwo.org (Postfix, from userid 1003)
	id 30CBB40113; Fri, 14 Feb 2025 10:22:08 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 2F2E8400C6;
	Fri, 14 Feb 2025 10:22:08 -0800 (PST)
Date: Fri, 14 Feb 2025 10:22:08 -0800 (PST)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Uros Bizjak <ubizjak@gmail.com>
cc: Dave Hansen <dave.hansen@intel.com>, x86@kernel.org, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
    Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, 
    Dave Hansen <dave.hansen@linux.intel.com>, 
    "H. Peter Anvin" <hpa@zytor.com>, Dennis Zhou <dennis@kernel.org>, 
    Tejun Heo <tj@kernel.org>, "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [PATCH RESEND 1/2] x86/locking: Use ALT_OUTPUT_SP() for
 percpu_{,try_}cmpxchg{64,128}_op()
In-Reply-To: <CAFULd4YUSCBSJQ1F0Rn45bwTonQJb2_=c2sZZEGV7RfgHBAOJA@mail.gmail.com>
Message-ID: <cf264b5f-be03-af53-3de3-a97051f9577e@gentwo.org>
References: <20250213191457.12377-1-ubizjak@gmail.com> <04adffd9-2900-4cdb-a557-1c486a87b522@intel.com> <CAFULd4YUSCBSJQ1F0Rn45bwTonQJb2_=c2sZZEGV7RfgHBAOJA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 13 Feb 2025, Uros Bizjak wrote:

> OTOH, all recent x86_64 processors support CMPXCHG128 insn, so the
> call alternative will be rarely used.

Do we still support processors without cmpxchg128? If not then lets just
drop the calls from the kernel.


