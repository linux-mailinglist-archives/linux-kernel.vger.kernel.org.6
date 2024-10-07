Return-Path: <linux-kernel+bounces-354071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0E0993752
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 21:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24FA5284C78
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 19:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9DF1DE2C7;
	Mon,  7 Oct 2024 19:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gPyKmHgd"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0685213B797
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 19:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728329375; cv=none; b=VAhjaKyVT1pJ7WdrqYqu/MdD6hwC8C1EtS5sUQFDsch/yOOrn28mx9JMFShzxixiCp8bZkixzSgrwq4oAuED4PUxqJzMwaOeTssVto0ydfXZE1mBn4ytaoGItjgg8slZTVBgc86wWfILQe2J+MnfECNMJukeGx15RHYwheaDfvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728329375; c=relaxed/simple;
	bh=wAsyN4bfToRVIaCH2NfxQJUWEMKLcXcwV8IFUuXPkw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C4Hmz67OiaKpvcU5o8o8FxTwYVf0hjihm9UNiUo7mHiiQQ+WbQrUmMF5k62dlWoyx1T52GSvU1kuAWKMe/7cFi/u23cfW1uJLaO/Zk/LtSeaZkI0UkxaevuLUYwKXO9IYUkZyZtuH2ub4H2iDQ+y1mYUmmkOlcU1bBWqtM/i6Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gPyKmHgd; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20b40c7fd8eso48125ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 12:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728329372; x=1728934172; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6hjhwK26F7mqEB02C3imJBX9s7yag4ViNmToWybO248=;
        b=gPyKmHgdvcClarwr8d+Tv+OsHuzWqKP44LEfKpSSg+jKXG3r+98WHaVh+377Uqcr+B
         d54ZlLNzGhOUfEZazb4M/rmgUpVfFAe8R+D3hB7HngsG0tO3OOvU/tg9Tq2mtqRM05X1
         tvQ5bZRg6fBTwRxUZF0CLtJiTQOVYg8pRlTEewvOASkVLKbziuJ4BCHmrwqS3xLZUpzK
         nmrVDAzaD6J8BN1a6YTu1rZBlZe7fekUdRjFeAhbIyGX/dfL9PBbXnha14B069htFx6T
         LaJNh0+8HQZHuiFWL6pZZgpd8q9EI/ybR3+UL5CviKCqGbbj/T5El3hVnuqogfzERB75
         NyeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728329372; x=1728934172;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6hjhwK26F7mqEB02C3imJBX9s7yag4ViNmToWybO248=;
        b=Z0YS4b0n2ZrVLoCSb3jP8dvG9C3tigndNZQKZqtvW6vqYQGIseOpmWPKEQNyL9h62N
         mtFZO8049KQDZHuZnMZdYEobg99bXNV12LU48I5LMGMdtDEeUN1X9wgLhYqW69dzI/ym
         RCyMfWH4Wh6RQLtQwJWjNBikNhowzuH4iCkh+3rn+CyEb3Ns1jNC7XHw9iESq/8mwqB6
         vLUxEDEtaiyqMLN2lzijV9emQfei9aDPg8vCsFIB/bQjzlc8m0umWn7iDvgb6JlgmZZX
         C4vn+Ozc0SUakccq+hhmWMic7AH27gGP4CCTqjMfWJ5xTZRDZ39CJ+IgOqXEn8sKjzEs
         EbDQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1d6a6PN8laD+bKAT9XNIuqjK7H3Avq7dPkBSVJuVtIl5P8rrJL06ovOIo4uN3X2urKwMkPq+yhI0xZK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnMOQQCUlywCL4Hu1v+iLh8p+zdALVBp7w2sJK5HmwiCfh8opb
	WP4ZcxOsvkljfv4PL+k3/9Iy/erqn1a5kEgvVer2y2LyE0hnke4n+Yrxlk4/mg==
X-Google-Smtp-Source: AGHT+IHm3uGsIquaR2sBuXURdxuJmQi73sAnfh3g8tzK4+sv6nLogdVyFvjGokK76qW2HihTFLpbSQ==
X-Received: by 2002:a17:902:c952:b0:200:97b5:dc2b with SMTP id d9443c01a7336-20c50ed6c2amr385635ad.15.1728329372106;
        Mon, 07 Oct 2024 12:29:32 -0700 (PDT)
Received: from google.com (201.215.168.34.bc.googleusercontent.com. [34.168.215.201])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c13934817sm43024115ad.158.2024.10.07.12.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 12:29:31 -0700 (PDT)
Date: Mon, 7 Oct 2024 19:29:27 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Breno Leitao <leitao@debian.org>
Cc: akpm@linux-foundation.org, Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Stephen Boyd <swboyd@chromium.org>,
	Elliot Berman <quic_eberman@quicinc.com>,
	Xiong Nandi <xndchn@gmail.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scripts/decode_stacktrace.sh: remove trailing space
Message-ID: <ZwQ2l8zo6BZQnnkB@google.com>
References: <20241003103009.2635627-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003103009.2635627-1-leitao@debian.org>

On Thu, Oct 03, 2024 at 03:30:05AM -0700, Breno Leitao wrote:
> decode_stacktrace.sh adds a trailing space at the end of the decoded
> stack if the module is not set (in most of the lines), which makes the
> some lines of the stack having trailing space and some others not.
> 
> Do not add an extra space at the end of the line if module is not set,
> adding consistency in output formatting.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  scripts/decode_stacktrace.sh | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/decode_stacktrace.sh b/scripts/decode_stacktrace.sh
> index 826836d264c6..4b3502a007fd 100755
> --- a/scripts/decode_stacktrace.sh
> +++ b/scripts/decode_stacktrace.sh
> @@ -311,7 +311,12 @@ handle_line() {
>  	parse_symbol # modifies $symbol
>  
>  	# Add up the line number to the symbol
> -	echo "${words[@]}" "$symbol $module"
> +	if [ -z ${module} ]
> +	then

nit: it seems the convention would have been something like:
	if [[ -z $module ]]; then

> +		echo "${words[@]}" "$symbol"
> +	else
> +		echo "${words[@]}" "$symbol $module"

I guess the space could have also been prepended in module above? e.g
	module=" $module"

> +	fi
>  }
>  
>  while read line; do
> -- 
> 2.43.5
> 

...either way this looks good to me.

Reviewed-by: Carlos Llamas <cmllamas@google.com>


