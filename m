Return-Path: <linux-kernel+bounces-342305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4E6988D71
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 03:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC5781F224DA
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 01:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB9714267;
	Sat, 28 Sep 2024 01:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Psf5NVTw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B115221
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 01:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727488211; cv=none; b=a/ET/cG99kica1ORAYAJpRDKdGblKMeAy6U07Yyf8T08vMl+n9NwyE0ZDDLHfLS08d7W+GCh/3GrGpDS8TuX6J8IaC7ikcIriIFHSQvnA0Vj5SWLOWmdV6yNvVgTmxmD/S1lbcvDGTg+4jAEDv7h8z/o7ImIwwk/t3CVNzippec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727488211; c=relaxed/simple;
	bh=xA+hY4A5qzV7an91JeU9TAQ84dTzk6zrw3Xj+wSY5D8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HYgmPZnyaRzMUV3ICCr9a23GRjNU2zBZ3+Emvzlu5apoEvPUrKiquOX9/M1NHjbx0QeCjXZPUwyG0y31KMnQWt/1+Foe0gWJZW7kveyILNincM93h5KV/ZHz0LYXt88N3kxbq1XQBgCztqjzGbuJz8kgvV8r7xefKYcpPnlTugE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Psf5NVTw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BC47C4CEC4;
	Sat, 28 Sep 2024 01:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727488208;
	bh=xA+hY4A5qzV7an91JeU9TAQ84dTzk6zrw3Xj+wSY5D8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Psf5NVTwJI1ctcMW4Bp1T6fSK5CCta9shReRrpfc5bDDMdyBo//vORcKgQh9VpYmj
	 Weo1wCBwHLoUK4jWeIze3G+lZklOzC0cGElCrqu6aPKXSIYEjzLlXbExwil/Q8SqtD
	 /Gh0vlqDklCZ4ok5tL7+fn41rDLWmRyVnJEWBh1C5DetullInGHkJ76NP1AjXnV87g
	 7gmzs3dytbqrhydJ/FjSLQCeoeG3beoGlYNzsTfiVTYNALWQzqvHB50TAVnhS1mIk5
	 SQ497Sq0sdsQCBnGpepd40OYr32ZZgyRvVHo4ZQatNkfpLtugNtoqCXqENNATVt/7z
	 pFe6RVXdVMtRg==
Date: Fri, 27 Sep 2024 18:50:06 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, alyssa.milburn@intel.com,
	scott.d.constable@intel.com, joao@overdrivepizza.com,
	andrew.cooper3@citrix.com, jose.marchesi@oracle.com,
	hjl.tools@gmail.com, ndesaulniers@google.com,
	samitolvanen@google.com, nathan@kernel.org, ojeda@kernel.org,
	kees@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH 14/14] x86/fineibt: Add FineIBT+BHI mitigation
Message-ID: <20240928015006.agymb4decrujal37@treble>
References: <20240927194856.096003183@infradead.org>
 <20240927194925.808912874@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240927194925.808912874@infradead.org>

On Fri, Sep 27, 2024 at 09:49:10PM +0200, Peter Zijlstra wrote:
> @@ -1190,6 +1214,8 @@ static __init int cfi_parse_cmdline(char
>  			cfi_mode = CFI_KCFI;
>  		} else if (!strcmp(str, "fineibt")) {
>  			cfi_mode = CFI_FINEIBT;
> +		} else if (IS_ENABLED(CONFIG_X86_KERNEL_IBT_PLUS) && !strcmp(str, "fineibt+bhi")) {
> +			cfi_mode = CFI_FINEIBT_BHI;
>  		} else if (!strcmp(str, "norand")) {
>  			cfi_rand = false;
>  		} else {

Do we need to hook this in with bugs.c somehow so it skips the other BHI
mitigations?

-- 
Josh

