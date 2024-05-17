Return-Path: <linux-kernel+bounces-181978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E801E8C8487
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 12:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B0AE28157F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 10:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84B62E646;
	Fri, 17 May 2024 10:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="EsGD6JFd"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4FC2C69C
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 10:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715940460; cv=none; b=lVX0EF8UrCVQHobFm5iW9UyRxnnDMVkbcz0NPZaLeN/eDqMnLGkW+o7xMlmYbUOWKTB82UC04HQCsxYE7kDBzqxns3QAyadVJR29O7d5KWvTgN6KRYDfpDwj/r22EBJ0TXF2N42UJJxmA/FYZB00g6dsbnZ0dWbH/qPZ7iNVwaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715940460; c=relaxed/simple;
	bh=QBT+qEM2pjZjgyv+4u9pdeganrrxkRsrU8ojAFlzxVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nDTVQthh9kHy50/WY9FinSiw5n1EG3CztYXNjms1H3sM1rqg4ucF28Ij0nJC7z0vkdCGzexnGnHWetEOeYWEpzuLu+SlgymnO2RX+Yz8dCxuhwWdk7JOYLGRwOl2ItXtVLI73yjYhfkGPNzF8OwHK7TLEj8MlnxytZu2TwjpHS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=EsGD6JFd; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B0B9040E0177;
	Fri, 17 May 2024 10:07:35 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id J_hDZ4ChGJYP; Fri, 17 May 2024 10:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1715940451; bh=fgsksDGvpkbJix4G3B/ukq5St7H0Tecp7h0VFNE9OKM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EsGD6JFdWu9djOpVDPQjfAulQGOZTQLNrkh3c+NuoidKKzrDFyNHXp0NyxP0emG5R
	 lbJx1CyLDSVeeSbROqVwJ5b8T9s7piQEmz4ZEdikDdEvAXB+g7olLOXKfw4DF8mFLp
	 kDnn+q9tu+JU1lgQVT9AsC9s38YhRhoy6dBGzM/y/nPZxAqn2bQPbK8+z9YDpGzkRo
	 afWX9YFSEdX5o794dkx7jXHHb8b1s1nQYMgju8PHypj2s3LtKwWHEQtW866HyYrMHq
	 ZZXsuSFSQKc+3sZeHHxTFAhml22GPTK5dGwaU7xhVdH+yBmDhjGQb7YZY66wqYpPd9
	 2S29u1JFv8TSd1Gtfj2PH8Y7L3/3+GCZy+ZByIpsmGEPaxtMh0HPF6JP9mxv9kJ2bB
	 i7I/XKdTNueq9sGk7BIC2+IQgHvyYiD7BbPLkvFMvdhDAn0lfI4MPGTRnhXURiN260
	 KcTc0s7SCsU5KpUXtWtskHMtboAy9UZOU57NZb5trrIbZMdgOsotc8OuOyqaCQ541P
	 8sT3zD7y9YpPBEgJldZZTy34m95S73Onm54RNyXwBwOd1rxQTtSZET2/10wXH/+d22
	 FLqomnthGsfTaP/Wp1fKQ99eH6Z7hQthrJSkfXOk/4IyLsuddEOfJnYwRom0Abp4gh
	 ebHl+79B+tLgV4C7CXZ/USik=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B4C7740E01E8;
	Fri, 17 May 2024 10:07:20 +0000 (UTC)
Date: Fri, 17 May 2024 12:07:14 +0200
From: Borislav Petkov <bp@alien8.de>
To: Jordan Niethe <jniethe@nvidia.com>
Cc: linux-kernel@vger.kernel.org, jgross@suse.com, ajay.kaher@broadcom.com,
	alexey.amakhalov@broadcom.com, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	peterz@infradead.org
Subject: Re: [PATCH] x86/paravirt: Ensure calls to pv_op functions are RIP
 relative
Message-ID: <20240517100714.GAZkcsUqHxScXJErxP@fat_crate.local>
References: <20240517024224.995517-1-jniethe@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240517024224.995517-1-jniethe@nvidia.com>

On Fri, May 17, 2024 at 12:42:24PM +1000, Jordan Niethe wrote:
> This has been observed at lower levels of compiler optimisation but
> there is nothing preventing it from occurring generally.

How can I reproduce this?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

