Return-Path: <linux-kernel+bounces-518131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3365CA38A56
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 18:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 164097A48F1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 17:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CF1228393;
	Mon, 17 Feb 2025 17:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ZlEiaGdB"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B5F228363;
	Mon, 17 Feb 2025 17:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739812126; cv=none; b=SqK7Mrwn9Gr3FidFAQbP3wsPACK+Ja6EKu80iYrMZPTQVCajeGEgSi0Yre1IUj/vhXq24URkFVsUWtLBWZjE7/0k7UqDN9Z/tzRlarfwfGC9tyx8uZv2YAFHrHd3oyi6bslxvy2jPOcDK2NDu0DcTYC1peMzWqt3tv646TLMZk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739812126; c=relaxed/simple;
	bh=ZFOdUwWtRNVXzUAoQlEeq/bYzJVm3c2ZgNbB0ZJ4+RA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l0oqvYeAFOd7VMwevB5fZVJ8wTwe5kmJHUa79qyTr8hbYP7EySZESKNdwK3Yc4TPigYFxe5JBvWUqCAGDzffyCl7ZzN28SmoqUa6nluzRaB8yNuzdHSaGn84mFDrlt6Wk6FjMidvClqisUn87GWK5o9TVOHaZPJN6hAw0Ocyspg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ZlEiaGdB; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4F2EB40E0212;
	Mon, 17 Feb 2025 17:08:39 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id iIGhgKGd4JcJ; Mon, 17 Feb 2025 17:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1739812115; bh=HFpDfhLVBPFrfNwHOM1CAXJm8CEHtiyXWsWntdg2e/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZlEiaGdBO10Xp4uR03NjKAcf3SKMcqFOjvqjU0zef94hS4v8Ra1ImW0U3E9WlOMxR
	 v6Tx26MHrAStQxnpa47lqyQEG3cPsibNe/vqJpiXU6yKYGQY4wZiCZWG7gl+2kraN3
	 fInljbzDOY4a+2I8hYzWnQgWPIMDPidYy6cPa1+SsznA6efykeknMgzX26lTSGw1MO
	 Ws4wmNOyq+uCsnfi3o/tTU3ZFQOF+AzsNujVi/p0jTbVZIQCfeYyIyre4i1cRm6ZiX
	 m/W2cAHPnadSZ4JdA8umf+CjzvZ+NJk/8n+adeKfDG4sfcGZ1H+1URNCTtRlKmz3bS
	 OVzvDtMwlvKXNIamtOKuoieHc/zCvxHunuXFxsDSLKuAutmTMHAJBxDKW2Wrwd3edZ
	 008T6aWrEoBY9iO6eIFm494S0ryZjWWLHgN1cv5PysazJwuCQ7q4+wukAKuVr+0BUG
	 ooRIuSGOXESE9wesIyRMonYlJUygvJhG9JiXg9atZDNwi6UTkN9cxRuRb6vqyh/frL
	 GWHvDEX7rpOCvFwbMRcawgiMgveHdXfgGaL5FyiAIfquzA0NgW6yoDcrlExpH6bvZO
	 PTSbyBTbhmCOcqd1mdEOso/0gMqNzd+XxTxEnRUSqFgL+b0o+5FvrHnYrT99uuXWei
	 4qhOGa9+4dRDE+fhzrkSqSUY=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DE77E40E0176;
	Mon, 17 Feb 2025 17:08:24 +0000 (UTC)
Date: Mon, 17 Feb 2025 18:08:17 +0100
From: Borislav Petkov <bp@alien8.de>
To: Brendan Jackman <jackmanb@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2 3/3] x86/cpu: Enable modifying bug flags with
 {clear,set}puid
Message-ID: <20250217170817.GGZ7NtAf-mg-zySpdP@fat_crate.local>
References: <20250129-force-cpu-bug-v2-0-5637b337b443@google.com>
 <20250129-force-cpu-bug-v2-3-5637b337b443@google.com>
 <20250217111029.GIZ7MZJUGJRoeiScgn@fat_crate.local>
 <CA+i-1C3fetiBYVbfpAbQEAnogzdza25pu2DosCiTT9YkXwt0yw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+i-1C3fetiBYVbfpAbQEAnogzdza25pu2DosCiTT9YkXwt0yw@mail.gmail.com>

On Mon, Feb 17, 2025 at 05:56:32PM +0100, Brendan Jackman wrote:
> Er, hold on, what chunk can be whacked? Do you mean delete the ability
> to set clearcpuid by number? There are still features with no name.

Really, which ones?

Are you saying you want to turn off *arbitrary* features? Not only what gets
advertized in /proc/cpuinfo?

Why?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

