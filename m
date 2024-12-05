Return-Path: <linux-kernel+bounces-432433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA909E4B27
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 01:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56800282A64
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 00:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F0F3D6B;
	Thu,  5 Dec 2024 00:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U0b+XS6w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDCC653
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 00:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733358639; cv=none; b=YD3aH6VRx/raHFZ3u1yDgiilTgLY4+0sJCJYpQlccwEWcf3H9ZIsVgrbc7g0ksaDqKdwxKLXeqdfg2xHfizSsZIcLds9UR7h0a2EsoQs5xAt0PqGtCWw+hOhYGPPqFDWBoscrzab5sZCnqY6h3ZlsV6PtCS/Chmr1wZA/9D3WRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733358639; c=relaxed/simple;
	bh=/2sfueJmjtuNFdSJDAv70/lV2GSeIQBqxjwAlB5dnHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DzSQzNLvXbJzzY6/AVU44UQ0kO0GY61QxYYFR2kqFvse2PGNHgL2O1SrXDYbAt9r8/r2eIwp34Jb04b3POXAaf+qu6ILzyRbbiuztp7D+XL6+6o0uSSmo1HO+Ax1juG0Edts8L7hx37IS0KJ9QPJGCzLZdLfs+i9EJnb0zbkPn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U0b+XS6w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA8FFC4CECD;
	Thu,  5 Dec 2024 00:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733358638;
	bh=/2sfueJmjtuNFdSJDAv70/lV2GSeIQBqxjwAlB5dnHU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U0b+XS6wBGTJTdoUB+zX5yCYC80xQg8mG1JECA6jtd/ZXQyr+wkFKnJpWr4Exsl3q
	 PKUXHtJajUBEY4qoOn2lhqNOARzwLDGjRy42ZnHfelm66fsXvnBWhMn7kn7XHhCR9u
	 zis+5iQfSgyOY+qra3sg65bwGSzqxyPKuTkP/ABRbdkStCVZeRpNSyYSgAsc2094iQ
	 0Dojw17kSxZ02gPDQGiuLSkb/0s1hhbmFmrLSoW/9qiE3SckHm30ckc58xbfU202eY
	 PHb3cNAnXcUsNvTparem6jFHAsV+hk5RMSyvv4yYodMVAFENmD0zSeGU+TnTv/pMsY
	 tO4BV4HgQsr8Q==
Date: Wed, 4 Dec 2024 16:30:36 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Atharva Tiwari <evepolonium@gmail.com>
Cc: atharvatiwari1101@outlook.in, Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Ian Rogers <irogers@google.com>,
	Aditya Gupta <adityag@linux.ibm.com>, Jiri Olsa <jolsa@kernel.org>,
	Eder Zulian <ezulian@redhat.com>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix: add safety check for OPTION_END and refactor code
 for consistency
Message-ID: <Z1D0LNfWcnPkWC3_@google.com>
References: <20241129104401.5997-1-atharvatiwari1101@outlook.in>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241129104401.5997-1-atharvatiwari1101@outlook.in>

Hello,

On Fri, Nov 29, 2024 at 04:13:53PM +0530, Atharva Tiwari wrote:
> - Added a null check for 'o' before copying the last OPTION_END in options__order function to prevent potential uninitialized usage.
> - Refactored the parse_long_opt function for improved readability by aligning function signature.
> - Minor formatting fix to ensure consistency in the codebase.
> - Updated the wrapper script for pseries architecture to handle 'notext' option in a more reliable way.
> 
> Signed-off-by: Atharva Tiwari <atharvatiwari1101@outlook.in>
> ---
>  arch/powerpc/boot/wrapper        |  1 +
>  tools/lib/subcmd/parse-options.c | 10 +++++-----
>  2 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
> index 1db60fe13802..d25ad8c622f4 100755
> --- a/arch/powerpc/boot/wrapper
> +++ b/arch/powerpc/boot/wrapper
> @@ -267,6 +267,7 @@ pseries)
>      link_address='0x4000000'
>      if [ "$format" != "elf32ppc" ]; then
>  	link_address=
> +	notext='-z notext'

This is a completely differnt change and should be sent to powerpc devs
separately.


>  	pie=-pie
>      fi
>      make_space=n
> diff --git a/tools/lib/subcmd/parse-options.c b/tools/lib/subcmd/parse-options.c
> index 555d617c1f50..f85b642bc9aa 100644
> --- a/tools/lib/subcmd/parse-options.c
> +++ b/tools/lib/subcmd/parse-options.c
> @@ -360,8 +360,7 @@ static int parse_short_opt(struct parse_opt_ctx_t *p, const struct option *optio
>  	return -2;
>  }
>  
> -static int parse_long_opt(struct parse_opt_ctx_t *p, const char *arg,
> -                          const struct option *options)
> +static int parse_long_opt(struct parse_opt_ctx_t *p, const char *arg, const struct option *options)

Please don't change this unnecessarily.


>  {
>  	const char *arg_end = strchr(arg, '=');
>  	const struct option *abbrev_option = NULL, *ambiguous_option = NULL;
> @@ -828,9 +827,10 @@ static struct option *options__order(const struct option *opts)
>  
>  		nr_parent = nr_opts;
>  	}
> -	/* copy the last OPTION_END */
> -	memcpy(&ordered[nr_opts], o, sizeof(*o));
> -
> +	/* Check whether o is  valid before using it to copy the last OPTION_END. */
> +	if (o && o->type == OPTION_END) {
> +		memcpy(&ordered[nr_opts], o, sizeof(*o));
> +	}

Do you any real problems with this?  I think the existing code assumes
the last entry should be OPTION_END.  Otherwise it won't work well.

Thanks,
Namhyung


>  	/* sort each option group individually */
>  	for (opt = group = ordered; opt->type != OPTION_END; opt++) {
>  		if (opt->type == OPTION_GROUP) {
> -- 
> 2.43.-1
> 

