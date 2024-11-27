Return-Path: <linux-kernel+bounces-422935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE279DA021
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 01:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB201B22B56
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 00:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B1C79CF;
	Wed, 27 Nov 2024 00:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GjWYdWnX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736BBD2FB;
	Wed, 27 Nov 2024 00:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732668917; cv=none; b=IM8PvufHDRfXIOMmhvzMWYstwcXEoSwl+M+q95MXtYy1LdYuLDarhQltG43Aa7+yt8IznoZgCyQEO2f4/j0lPkyUfkPH76hpDEAm0wJTXDI9uRUZwFWaziZR/c+8p4nvOwCqaYhG86G5mFpCIxP2WPIneLbF55H+9uzQ5XCAEZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732668917; c=relaxed/simple;
	bh=imNjZRcBR90I27HKUDJIEKz/hnsSnwClFz4Af8W4ETE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JSllcW2DVdhF0q9GAOzcw2spGAhqhZPlcnbjSjNLdOd7yg8BV7vccMjDaDwt2XU/h+wTkcKDZWaWkix2B9GhOEcUc7jcVRq1JVQhMrq6oR53tcP/2+8ybs+SzIFXSka3GbX2VylR0Ns8NJ0F0AQpgsvLixU0ocNs5aBxbkapMe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GjWYdWnX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD6FBC4CED0;
	Wed, 27 Nov 2024 00:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732668917;
	bh=imNjZRcBR90I27HKUDJIEKz/hnsSnwClFz4Af8W4ETE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GjWYdWnXPshkQK0G9gH2iYw6c1CE+tucyC9U2N9Gv7zgfnCLchzF1op64wKFjiwvt
	 Z+WSyDF1r/EJaoenzSQcL/+3Q96KUU649IuT9smu8cx0m+45CRssvDKi88BvhJGTU4
	 No+3uRz6lJJQNtEj52myEllYNGGRYLQF6lJJQ58onZ6ChbkJuUg982YBQ9bKYOIXQ4
	 7/QUa+uUdwe9mBhqM25r/DsNyxT2oWMeknJGW333KFw8+4tLPewirct72A8xBP7nl7
	 Mb0r4GUQalN61Pr/VAgrQ4QkIUGSStxyuPrg5ZJMcmzrFUF/WOspxgP1HrZlN8ztsD
	 2SrUlVwH/XK4Q==
Date: Tue, 26 Nov 2024 16:55:15 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 05/10] objtool: Handle unreachable entry of rodata
Message-ID: <20241127005515.a5ddv44cjnvd5awi@jpoimboe>
References: <20241122045005.14617-1-yangtiezhu@loongson.cn>
 <20241122045005.14617-6-yangtiezhu@loongson.cn>
 <20241126072557.b6qt7jaiikvkcswn@jpoimboe>
 <20537f77-e105-317b-7f95-8a72533c8e43@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20537f77-e105-317b-7f95-8a72533c8e43@loongson.cn>

On Tue, Nov 26, 2024 at 07:04:39PM +0800, Tiezhu Yang wrote:
> On 11/26/2024 03:25 PM, Josh Poimboeuf wrote:
> > Are you sure this is specific to loongarch?
> 
> I am not sure, I only found this issue on LoongArch compiled with Clang,
> but I think there is no effect if make it generic, like this:
> 
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index f7586f82b967..87302e6fc07f 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -2103,9 +2103,10 @@ static int add_jump_table(struct objtool_file *file,
> struct instruction *insn,
>                 if (!dest_insn)
>                         break;
> 
> -               /* Make sure the destination is in the same function: */
> -               if (!insn_func(dest_insn) || insn_func(dest_insn)->pfunc !=
> pfunc)
> -                       break;
> +               if (!insn_func(dest_insn) || insn_func(dest_insn)->pfunc !=
> pfunc) {
> +                       prev_offset = reloc_offset(reloc);
> +                       continue;
> +               }

Yeah, something like that might work.

-- 
Josh

