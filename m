Return-Path: <linux-kernel+bounces-574213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4A0A6E20B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 19:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 116C01888C88
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 18:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C302641F2;
	Mon, 24 Mar 2025 18:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CBZAdRUu"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AAC25E445
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 18:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742839601; cv=none; b=E8vnPLC9ELRbQMYEhRb/ylE34U6b61g8E43FyRrsSTYodX92BxnwuFElwmiuAAvHDb0nv+reqT5cbQMvjne8lUWigjDDuN+RfpZdI6adZFZW3COa/zxzI0/Wwr+8JRpj0m9bXTEd7uBC/PVhyJ3kSCL9rEY2qzrKcAyF8iXDSYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742839601; c=relaxed/simple;
	bh=Xi4scCCRkeS5pHUqB09CH/3cnaJ+YCpaal7qzZ50RSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ExwgUJs11DsZBO4f7U6B2dUB3Yt/ezaYYFsnnA7Tql7Z3n1e7Y2p8kcLz2y2Q/T0ZsfO2UOE9JUSmZBmC8c6OOz72vhwSraF8rbrNK0NbMZlDlGgW5v+z8UvOsijpkY4aVFxW8m3hi9QcXnWeUYDX35BZONI5kvhKDu4D8YoWgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CBZAdRUu; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 24 Mar 2025 14:06:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742839587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0Aks8YAQlWekQIl9Jf+Q6ox356mZlxKKGmGkcI9fcHE=;
	b=CBZAdRUu7haXbmPwe8SV3pG9uvrLKVlvUDKnunF2gz8PuRCB+160jIm4pTYw0AjNyAgeji
	xhsGCFfQE9t4p5D15OPgL7VOlsuOi17eeNppnH0bbRNfA3p9Dh07Mrscp1l0GpMuB8YK+c
	2+SZ4HA1ZLCXTcqSVZDNi4chzRCnz5c=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Hui Guo <guohui.study@gmail.com>, linux-bcachefs@vger.kernel.org, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: use-after-free Read in poly1305_update_arch
Message-ID: <rs7ocmzcqkwf3ac6spqvign6rov2ecqef3bu2dzeg6y6ryvv7x@4c47km4r5iqb>
References: <CAHOo4gLWAbArwg+w+AqqkxGmOFX6cm8Tvy85tb4igN6V7Z9BZQ@mail.gmail.com>
 <20250324170046.GA19087@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324170046.GA19087@google.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Mar 24, 2025 at 05:00:46PM +0000, Eric Biggers wrote:
> This is a bcachefs issue.
> 
> +linux-bcachefs@vger.kernel.org
> 
> In the future, when fuzzing a filesystem please direct any bugs found directly
> to the mailing list for the corresponding filesystem.

This is also one I've been unable to reproduce, so if anyone knows what
does it (kernel config opts?) so I can repro it in ktest - please let me
know

