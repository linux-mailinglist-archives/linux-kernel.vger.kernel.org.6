Return-Path: <linux-kernel+bounces-404463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2759C43FC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 18:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 641BE1F22564
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 17:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12FF1A76CB;
	Mon, 11 Nov 2024 17:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rlLbJXLB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2031A3AAD
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 17:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731347027; cv=none; b=nD8zZWpeIpLnzZYT09rRpyGMu0sTK5+dISfM3zIvtdJvwVcP4QNIdF9RPfIVXxXhueaOqfDmoGnQznK5ifX7xDDXabF8HHierA0LaBLryKN20gdep2VxTE5kpoebCFec2rQ/ITS76EKdWXzGOz99xjB2GNA8s1ArxrMRWNmp520=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731347027; c=relaxed/simple;
	bh=7szS0JcxAGIA/EZsPYEvx6AhLPm6rNTGOAPQfCCP3kA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f9TAN0PyQ5VH1mRI4c6XR62YNEVU7yz4DvJuSPb1RhD0ppCOVqxIOEYKEZjami/NLjPxCS/QouKQvcioj+N1XkJU4kbbmGhsFGezRkI5aB4B4JgKyLL3AS2JnYaz2XRzHCRW3MQfoQXFCuvgyyu85U8sure4kGc+zCfRlbxnifE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rlLbJXLB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E415C4CECF;
	Mon, 11 Nov 2024 17:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731347026;
	bh=7szS0JcxAGIA/EZsPYEvx6AhLPm6rNTGOAPQfCCP3kA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rlLbJXLBm1nswLr94bS9mXpTvWaNhXrVk7dGs3jsHfwQ9gekuMPk5irl3PdK7S9O5
	 48nFt5+AOnTDOKZQPZMDr9Mo0ub7GOmUHKWB4hhqdPZRGOQ9TnUZdx0bIroCOl+AbK
	 LtNY8uhLFPqwYYA7G9zv23NaiN24wHFA1QqrOBtJPOEJPG8zCxDuUtMagtJHoaEoT5
	 KZ7cztUY0oiU1LsEzU6fc+csp6eXqleeryFVjtiMZnRpGeWYMkqzx/c6eiNqfncsfZ
	 cQA+TIzpfaRSXITzskO4iaZy8L6Xq190NQH7+p3dC5oz6zvmqM2z5tc4jPp2/12eSq
	 gMKz+K0ZT2ktw==
Date: Mon, 11 Nov 2024 14:43:43 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Luo Yifan <luoyifan@cmss.chinamobile.com>
Cc: jpoimboe@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/lib/subcmd: Move va_end before exit
Message-ID: <ZzJCT_LkhkKRQOTt@x1>
References: <20241111091701.275496-1-luoyifan@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111091701.275496-1-luoyifan@cmss.chinamobile.com>

On Mon, Nov 11, 2024 at 05:17:01PM +0800, Luo Yifan wrote:
> This patch makes a minor adjustment by moving the va_end call before
> exit. Since the exit() function terminates the program, any code
> after exit(128) (i.e., va_end(params)) is unreachable and thus not
> executed. Placing va_end before exit ensures that the va_list is
> properly cleaned up.

Thanks, applied to perf-tools-next,

- Arnaldo
 
> Signed-off-by: Luo Yifan <luoyifan@cmss.chinamobile.com>
> ---
>  tools/lib/subcmd/subcmd-util.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/lib/subcmd/subcmd-util.h b/tools/lib/subcmd/subcmd-util.h
> index dfac76e35..c742b0881 100644
> --- a/tools/lib/subcmd/subcmd-util.h
> +++ b/tools/lib/subcmd/subcmd-util.h
> @@ -20,8 +20,8 @@ static __noreturn inline void die(const char *err, ...)
>  
>  	va_start(params, err);
>  	report(" Fatal: ", err, params);
> -	exit(128);
>  	va_end(params);
> +	exit(128);
>  }
>  
>  #define zfree(ptr) ({ free(*ptr); *ptr = NULL; })
> -- 
> 2.27.0
> 
> 

