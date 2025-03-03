Return-Path: <linux-kernel+bounces-544666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3818AA4E3CD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8138519C4081
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D8727D79F;
	Tue,  4 Mar 2025 15:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="DUu0KZw2"
Received: from beeline1.cc.itu.edu.tr (beeline1.cc.itu.edu.tr [160.75.25.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA5627D794
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 15:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741101772; cv=pass; b=oljChiNynS7+mVRpMkEp6GT45e+//uReDHl9quXlC3G5+RVYdDKJfUfpha3mjBYQ9RreTzX9WKZHlpFjYVbHFHj77jo6HUa699PUT78codQz3HyEzThQJf1ufnYfggX+2SLbct8fXo5EXNYkNYMt3zPuxdYFjUt3gWiEq/HfzAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741101772; c=relaxed/simple;
	bh=jlc0C8rbMbqoeY8g3R7Lv7cLmPJKlL8deuN+Bm1QkIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BQRxVzsP34KutABRu2t154sJa4XxSM+T9BcaycHl6pV8rIaktiVxmMpAlvV3xGKuv2PKhGVdll4skhGeoX8dnmjXg74pwox5JpLVr1JN1t9hXKF2JWmiTvf0RGsLvrN5ps3aUqr9wU4oxHow2u89AihfBe8G9LQGPYNCUnNCE3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=DUu0KZw2; arc=none smtp.client-ip=65.109.113.108; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; arc=pass smtp.client-ip=160.75.25.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (unknown [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline1.cc.itu.edu.tr (Postfix) with ESMTPS id 4389A40D053B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:22:48 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6fY037VYzG00k
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:21:40 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 9936442730; Tue,  4 Mar 2025 18:21:28 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=DUu0KZw2
X-Envelope-From: <linux-kernel+bounces-541718-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=DUu0KZw2
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 6979341C7F
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 15:43:06 +0300 (+03)
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by fgw1.itu.edu.tr (Postfix) with SMTP id 39EEE305F789
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 15:43:06 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F7CB1893F5E
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC11F20F08B;
	Mon,  3 Mar 2025 12:42:55 +0000 (UTC)
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
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250226030129.530345-1-riel@surriel.com>
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6fY037VYzG00k
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741706511.30401@FQ6rYCrwM9TaAqnE2JTq9A
X-ITU-MailScanner-SpamCheck: not spam

On Tue, Feb 25, 2025 at 10:00:35PM -0500, Rik van Riel wrote:
> Add support for broadcast TLB invalidation using AMD's INVLPGB instruction.

Ok, I've got the whole thing here now:

https://web.git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/log/?h=tip-x86-cpu-tlbi

Lemme take it for a spin on my machines, see whether the cat catches fire...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


