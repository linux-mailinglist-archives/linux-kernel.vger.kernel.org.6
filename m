Return-Path: <linux-kernel+bounces-561193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0795A60E9B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:18:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74BC63B82E5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6671F30BB;
	Fri, 14 Mar 2025 10:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VdHEEF93"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCEE2AF00
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 10:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741947469; cv=none; b=sCeuwcSvOKeKFBnoKdNgrV9q3u7+0IFGnT/pBE/KnaAeIhR0o9EMZU7CoX4GaZ3960cEGKXh9nuQ3lQvOewXiVzgHtpGcom2KZHkh1YYWYMBsHBaMp7Ip7WVILIFppIeF93KeJUgi21FML9m++7LuMtKFry6gq6O885YJoA1huM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741947469; c=relaxed/simple;
	bh=S6m75BNvABFyEwi0kFUZfGuKF5ZMAhOPmfUqAvqwFE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RriihPyW3AswUFaLsJ5ThH3zQ1iEMwbB5fdf2Jl1I+eWLzddT5BUYsnCWLb2BVINKYLWwIC4++XLP7d+VcDu/fTnNvIG1L2mz1I4LyWNh4IL4XjMokHBGz76CIvXSNwYsD6yliPrSTfUP2nkawOtlMGr/Ig90rJ4Ec9EbAHCzW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VdHEEF93; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 229D0C4CEE3;
	Fri, 14 Mar 2025 10:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741947468;
	bh=S6m75BNvABFyEwi0kFUZfGuKF5ZMAhOPmfUqAvqwFE8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VdHEEF93t7r//l6heP3qlapvbf/rB8kInzDyu1/8ijyXfmbEZqo2Jn0IyezaOWaoY
	 NNH63xbBpnEHKYDEZfQWET7LKcbWYb8LVF7Z3DnqQlzMkj9pS80hESWh5crWUhxLF2
	 Rbo8UfxX/ZGQ60uzCEJ8l/1COYWTCSezaB2bix2jkiJKXp2/MBLkjaMoY25MlZd988
	 fS2WMWTKvTeF+kvHD3rbbDlWgz5M3Nr+jP05PihHfSelkLVXSppsaVraixhJW8/PhA
	 Aq7moZTFH8c/T0ENIwsiXlgU1aCRzNJppa86P54UG6KtU94n7Qn4L4RMVjReRr9+Kw
	 kfIXmXtFQKxAg==
Date: Fri, 14 Mar 2025 11:17:43 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Uros Bizjak <ubizjak@gmail.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] x86/asm: Use asm_inline() instead of asm() in
 amd_clear_divider()
Message-ID: <Z9QCRydO2yiCq_YR@gmail.com>
References: <20250313191828.83855-1-ubizjak@gmail.com>
 <96E2026E-CEF1-4A4C-B107-7FCE2CD9121F@alien8.de>
 <CAFULd4ZTkBwFo3nWXNZKXSKiy4dgPoZ8i95nj3UdtQPApKdj3g@mail.gmail.com>
 <B7AB40CF-165D-448C-963C-787D74BB9042@alien8.de>
 <Z9QB0nP6Mb3ri3mj@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9QB0nP6Mb3ri3mj@gmail.com>


* Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Borislav Petkov <bp@alien8.de> wrote:
> 
> > Sorry but this doesn't justify this churn. There's nothing 
> > quantifyingly palpable here to warrant this.
> 
> I disagree, asm() is a known-bad inlining interface for fundamentally 
> single-instruction inlines like this one, and there's various 
> performance benefits to cleaning this up, as evidenced by the benchmark 
> numbers and analysis in this pending commit:
> 
>   9628d19e91f1 ("x86/locking/atomic: Improve performance by using asm_inline() for atomic locking instructions")

Here's a link for those who'd like to view this via the web:

  https://lore.kernel.org/all/174188884263.14745.1542926632284353047.tip-bot2@tip-bot2/

Thanks,

	Ingo

