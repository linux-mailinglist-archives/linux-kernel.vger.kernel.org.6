Return-Path: <linux-kernel+bounces-515465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91917A36528
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 19:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 576CC170A35
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 18:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53301267B7F;
	Fri, 14 Feb 2025 18:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uqTq1dd4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A408A18A95E
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 18:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739556136; cv=none; b=BJmgccmyxFGHZDPjVBAbYylMYAEhkcHePmHxoNQ1JlpzRh3pXS3Kuji3Rsx55zoUWArS0KmGABTkDn+sXvhcORhFFjX0PSPZF3S9wWNCwm+zmm6AMOCYjgjfbZ+GlBQQGF3ru/kESTMeJ31Zx32F1FGgjyt/YNOorAf6ISpOz3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739556136; c=relaxed/simple;
	bh=Z41fBWIEDAWmYgmEK2JE1TZTr7+n0htkzJNVtv4P2x8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ae6+SqWl9mZaPoG+uZWuGmZ3fiiToHiiSX4KxxVvNv5+73ZWwn+IufSVzcYMAKCzDOZkfbKQFhhAdzXwmQS2J+rd8grMCQ7geIsM2Coo3QcPRI1blNNszf5ec3TXV/SR+9c0bSnNVt4E3ny/m2FeTW5IrJYVehL+oz5ZEv7CarM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uqTq1dd4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D636C4CED1;
	Fri, 14 Feb 2025 18:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739556136;
	bh=Z41fBWIEDAWmYgmEK2JE1TZTr7+n0htkzJNVtv4P2x8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uqTq1dd4arhs1deJ2hvGoljjXOeOwsl7BsRup25a5uohaRE/NNRQQHVjDmv/+TJZC
	 TMkJTEIaVjRKbBNi0THSFtDz0Ioj30DKrZJAb8jIeXIWgwCOiyHaWhCvsXJlmq8tBa
	 mJ5TWoqGX8oaGxYPqk48rIBaJpc4yy1mnFa9XSdR6/RU2UyCOlGfBZDl23qdvrfnFW
	 ersEDXFfGghIUD2eGJyAREyRlLKuSp/JMOlrOkNDTfhrf7qBtUW7xRskQVcZjEtiqp
	 qcD3+sJv2+HZL9OWaFZcyK9n+T7VaIjwg7ED602bAPYpMpeXddrUKKnGI73QyEnLV8
	 f39+XJXUCALDQ==
Date: Fri, 14 Feb 2025 10:02:12 -0800
From: Kees Cook <kees@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, alyssa.milburn@intel.com,
	scott.d.constable@intel.com, joao@overdrivepizza.com,
	andrew.cooper3@citrix.com, jpoimboe@kernel.org,
	jose.marchesi@oracle.com, hjl.tools@gmail.com,
	ndesaulniers@google.com, samitolvanen@google.com, nathan@kernel.org,
	ojeda@kernel.org, alexei.starovoitov@gmail.com, mhiramat@kernel.org
Subject: Re: [PATCH 11/11] x86/fineibt: Add FineIBT+BHI mitigation
Message-ID: <202502140957.FE93863F@keescook>
References: <20250207121529.222723073@infradead.org>
 <20250207122547.124276834@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207122547.124276834@infradead.org>

On Fri, Feb 07, 2025 at 01:15:40PM +0100, Peter Zijlstra wrote:
> Due to FineIBT weakness, add an additional mitigation for BHI.
> [...]
> @@ -1020,6 +1036,8 @@ static __init int cfi_parse_cmdline(char
>  			cfi_mode = CFI_KCFI;
>  		} else if (!strcmp(str, "fineibt")) {
>  			cfi_mode = CFI_FINEIBT;
> +		} else if (IS_ENABLED(CONFIG_FINEIBT_BHI) && !strcmp(str, "fineibt+bhi")) {
> +			cfi_mode = CFI_FINEIBT_BHI;
>  		} else if (!strcmp(str, "norand")) {
>  			cfi_rand = false;
>  		} else {

While looking at FineIBT vs entry, I noticed that FineIBT+BHI must be
explicitly selected at boot. Did you want it to be enabled automatically
when the compiler supports it and FineIBT is enabled? Does there need to
be a check for BHI added?

-- 
Kees Cook

