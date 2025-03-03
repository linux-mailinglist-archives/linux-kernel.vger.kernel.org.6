Return-Path: <linux-kernel+bounces-541718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D3CA4C089
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 13:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 123DE3A7581
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 12:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC9D20E32A;
	Mon,  3 Mar 2025 12:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="DUu0KZw2"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B8BAD27
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 12:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741005772; cv=none; b=JK/0E9Zpnr/C3BkazFpWpFVY3MbO92K1S4d5LT7wMbtO6+ncUh0YwjxArxMfnqy6SF/Jw/24DNOl944Z2cAyUA+c/ysx7nSmXELj9WM2xdhrqzgeeNmCtavI2SrNRR3Fd1P1vWiqsl9MKjd1wRS34Af/IU8eKpeH9aOM0qEeiSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741005772; c=relaxed/simple;
	bh=jlc0C8rbMbqoeY8g3R7Lv7cLmPJKlL8deuN+Bm1QkIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VMzBqgh7mgvz/NTY5QNFxBeOMXUYUKmQQvjNR2OI9D+IAyK1Q06JybggVE7Rb4RLO9i5jxSZbxGD9jYxKMJQBwwiwpcL7+NqJ+xUb0jBmVKJBGQDvplyxVDRwlowrPSsVpJ2UWvJDKYcdBHtQTa0m+LId1vp8eRG9Yl0o4LT0lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=DUu0KZw2; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A0B5C40E0216;
	Mon,  3 Mar 2025 12:42:42 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id F3WNkQU5fF0l; Mon,  3 Mar 2025 12:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741005758; bh=gdGS48ZkBp7tPq/jrYUCtRhNMC7QldOP4oiLkMSaAug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DUu0KZw23FzzGcPKTR0vKoqqMRQyM3m1l+N9spPfiXWUWg61TvoeVgkCE06UNDsyz
	 f5Jlk8cK7idtmn4JKQHA208FA5TtoJU/8yTWftHzRMXEyKs+Wh9eNXgmZDr33f7l69
	 dSlXYB7TqpSesYID+DrprR9m7UJmtwmk+/iXnBNtWlKoHy7K4Wkhx8zjzj1qkxrOwF
	 8UOzveLc2jp6Rbjb/zs9g3U/UKc6Z3JlmFZbqWaBKz0yAJGvKMki56+k+jmPqPUKgV
	 OjqN3R7zZZJCbH6PJLkymsdoabSLzh3947SU1b/hYAkfo/2H5hAsAkzb2OCd51ElKE
	 XDv1lc3zSUruNOlr8YE0ms3g/ikKzHnLrvkOkJAs2li7QLbTQKQa1UB0v+oYV7BIFh
	 BEUaqd3hHpwASwupNKVFy2KlRSkaplV7jYq/qcpkXXMhW6Roh9T0/tS0Hv0XaBX5Go
	 IAM1tryo1ruA12/OeHCIXbTy9Yj0N0h0JikxJK7lGTZEjjwYMg2lSwqn1fStZOZF/o
	 I2IzkzP9eExzOGheni2X4IwbeF+pWCrXe51xG/2VXSvMTGZNBF67H9kBr/EKIyjlCk
	 VChkaDf5YvCjsFMZl6Tm6tl2rXy5Q83BUA357v0C16biUBtlYSg+zxd2WUyLWGPRfH
	 MZBpnLHGzlNXRU+wKV79DB0w=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4383F40E01D1;
	Mon,  3 Mar 2025 12:42:21 +0000 (UTC)
Date: Mon, 3 Mar 2025 13:42:14 +0100
From: Borislav Petkov <bp@alien8.de>
To: Rik van Riel <riel@surriel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org,
	dave.hansen@linux.intel.com, zhengqi.arch@bytedance.com,
	nadav.amit@gmail.com, thomas.lendacky@amd.com, kernel-team@meta.com,
	linux-mm@kvack.org, akpm@linux-foundation.org, jackmanb@google.com,
	jannh@google.com, mhklinux@outlook.com, andrew.cooper3@citrix.com,
	Manali.Shukla@amd.com, mingo@kernel.org
Subject: Re: [PATCH v14 00/13] AMD broadcast TLB invalidation
Message-ID: <20250303124214.GDZ8Wjpn7l4bOy8LYI@fat_crate.local>
References: <20250226030129.530345-1-riel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250226030129.530345-1-riel@surriel.com>

On Tue, Feb 25, 2025 at 10:00:35PM -0500, Rik van Riel wrote:
> Add support for broadcast TLB invalidation using AMD's INVLPGB instruction.

Ok, I've got the whole thing here now:

https://web.git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/log/?h=tip-x86-cpu-tlbi

Lemme take it for a spin on my machines, see whether the cat catches fire...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

