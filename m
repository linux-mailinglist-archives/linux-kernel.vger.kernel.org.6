Return-Path: <linux-kernel+bounces-524801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7818AA3E747
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 23:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 175743BA64F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 22:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CD21F03FD;
	Thu, 20 Feb 2025 22:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uti/uGMq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832571E9B07
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 22:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740089519; cv=none; b=SHo1KGOntOsoQPRi5NisK76hzc+vPw3khksK7usocMLW6ckqOasOTeC051jo7zqd/cl9VsjRXgk7690MKZ49o/5n7EGk+zMl7MoodI4b20TN5R07ovl0Ti9+tSWL+lNXq9aNbMjTtcT/LSLF+MudRsMGWrNLykEQMVKB+erxkck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740089519; c=relaxed/simple;
	bh=qBXoJkzKREy07+LOypx8OaynUb6qdH3LK0f47BNKw1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qtJCkfA56sHVRhdvgOuvSRFVn4CJEiXb1qU6hSbas4/iAUfSu8p4DuDyTUzLjDZv+2iFvrJDvbOzzzWkgBbFY4FGCtaxgPRQGC+V62ARAV0sE+8AclujyQ/7IrLbxu2g/F6CYTLuhHS9rtVRUJ5J8bixVhZykp90idyiMSU6v/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uti/uGMq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7BF7C4CED1;
	Thu, 20 Feb 2025 22:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740089519;
	bh=qBXoJkzKREy07+LOypx8OaynUb6qdH3LK0f47BNKw1M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uti/uGMqRyIyjKidlvKU0DFcD3NZaDoELkxlhppPs0yqZrq75CvXFBAWCXXhgBrMU
	 oFBO62p58SytbUmJxtI2Pd89GmqL0dkaaZ1futX8IQQ1AotL+IEjl/aK2WmlWdKDJJ
	 qJQS9FWKbkSNbdHIRoV1fvX/uof9V8YtZ+oNIcNIx2ZPg1bbtJHD+tSYExemTrFe5X
	 Q3dCdZSm6LMnJ1L3kBCgEHxqQjC727RepZAVcIoxHap36knmEiODK7Ykcwnpn4ZdgO
	 wKcb99xIqibHLsaXGRS4gG4gMU7SocV7UZSw+FwrF8sUTtVxsi/lMj/28+dbg/tJLF
	 FmnVE+K9vrzGw==
Date: Thu, 20 Feb 2025 14:11:57 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/1] objdump: Fix disassembly if CROSS_COMPILE not set
Message-ID: <20250220221157.njqmvge5t6kvn6b5@jpoimboe>
References: <20250215142321.14081-1-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250215142321.14081-1-david.laight.linux@gmail.com>

On Sat, Feb 15, 2025 at 02:23:21PM +0000, David Laight wrote:
> If CROSS_COMPILE isn't set and -v specified the code tries to run
> 	system("(null)objdump ....")
> which really doesn't work very well.
> Fix by changing NULL to "".
> 
> Fixes: ca653464dd097 ("objtool: Add verbose option for disassembling affected functions")
> Signed-off-by: David Laight <david.laight.linux@gmail.com>
> ---
>  tools/objtool/check.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index 753dbc4f8198..c1b771e772fd 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -4506,6 +4506,8 @@ static int disas_funcs(const char *funcs)
>  	char *cmd;
>  
>  	cross_compile = getenv("CROSS_COMPILE");
> +	if (!cross_compile)
> +		cross_compile = "";

Makes sense, I'm not sure how this works for me already?  Regardless:

Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>

Peter, can you take this one?

-- 
Josh

