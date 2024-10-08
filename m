Return-Path: <linux-kernel+bounces-355725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1032399561B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 20:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDD6D1C2503B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 18:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DBD920CCE9;
	Tue,  8 Oct 2024 18:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c0ZQ/H0h"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDD2770E2
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 18:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728410479; cv=none; b=mxQKxAOtddY4ho0aSrKTglIMCMbdXYLMOY1v7bg5/FOHIG2cHur5bCUMckVHn2Uee5hXOCBzikkFzLwHQv4fEV4OdeOLWsrCA1r+wyxDVU+i6793C2BkueR9yaScbm7cd8bZHMZ8z4EJ24QEprM19dXf4kIz7Nf6TqCVyr+TRWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728410479; c=relaxed/simple;
	bh=2yFlFySOqczoOdWeKt9yGH4PkuPwIlU8a/zHkEKdd3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oX4NF+rITvYA5u1WXQ/yOQ5YHk7T3CUlWiSCiVUWht5Re+ZSndTR5/cYm3ogd+oOlzv1sPgVYdtlgdldfd/EAyXVVkI4lGkCwpwb3n6byV/Ncero9gIezO5xL/djg3OYkiQFj0b3KzxQi/0wnmMdWVmqbpZ0qZqyliJthwIeNaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c0ZQ/H0h; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20c5b628b7cso20665ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 11:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728410478; x=1729015278; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p+IBE+ElxQQ3KklLY0tqNQuq2CoN66CRvPNbSS2QbwQ=;
        b=c0ZQ/H0hBZDCOK62w8BCPS5pjqqhFtyKiVSAUse4ojLfXjDsC+dNV0TuT2zeyVxyS3
         2Neb0DF8rS2JZZZ7FiT96Tz3cdtBPvzP7Plq0rTkx+9V6SelE1RAZ0PCdt4FL1SVGQs1
         +5Q0Ge+StlgUlI80wbTzBvp3hktidZMONfZaXjw5b2k5GnzA7Jq2fIxeZgAsY6B686sC
         /DX13l7Rl230BCKnYKFLtHZSLfnE8SaWiKacX8NdYIkDXbaNNpwxErxCs6XG8zQ9VgQP
         5WvW/DAlyoGPZzT41nXgjELOZ++lr8pvRMrNmy1I4CHEbFO+RZdOmcr//7srLc8acBhj
         lmWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728410478; x=1729015278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p+IBE+ElxQQ3KklLY0tqNQuq2CoN66CRvPNbSS2QbwQ=;
        b=YqqyI8JaTcUvaaTP1RqerDWRR1UjiuU0N68vYoW56KdEH0W3ZFjh8QNoI+PBvS2QB+
         nZe3JxiPqJkJ06jMG83BXZJGanJ08Ig21cCBeyoQyPvNVOn1pYNoEBiKpwXLD9V+LTUw
         T6LkqXYoJQd0sIxb3+LjXM0Cr7lOajArV6VTd1DdcvawTiwki/BdxAPNSZ8t+ThlHjq7
         VjdoCLWaaJlWTHmUkCh96YqrZ/nig8do4bwKi2vGk8BO1v3aMpORduHKMCXzMV8ViPlM
         lTfKyfjnwSWCdzlEGELKUE94/ygoYhMYR5h9GkS4Z45pQgy5YO4wH7fHvKLj8i8QGo9U
         Z4gg==
X-Forwarded-Encrypted: i=1; AJvYcCWGHgj6QhbBGsGD+eRwhQEvAU7hvbqRMys3PWDseeq5BQXAyqz6LZElA02TmEg6sgYHHdGuV/NXFM7Kysc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKW1E5H/5/mR+owxAGYF8YIRMyMod/EEiygCvdzEdR0nGi80Ix
	sy6LZPYNvREHcDrAjX6hmEARRYzO1w+T8Sbjf9PwWYH1B66a83p9GiQakiwx2Q==
X-Google-Smtp-Source: AGHT+IGFtPF4nvpbz0v0pdr7UQdyCl/MdyjMsie62gBbqQ7gmKClsU+spSOKPy0A6abyTGEVOn9Kqg==
X-Received: by 2002:a17:902:ea0c:b0:1fd:6c5b:afcd with SMTP id d9443c01a7336-20c62b64568mr126025ad.22.1728410477378;
        Tue, 08 Oct 2024 11:01:17 -0700 (PDT)
Received: from google.com (201.215.168.34.bc.googleusercontent.com. [34.168.215.201])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0cbba11sm6622739b3a.15.2024.10.08.11.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 11:01:16 -0700 (PDT)
Date: Tue, 8 Oct 2024 18:01:11 +0000
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
Message-ID: <ZwVzZ2TfmS7pLOdh@google.com>
References: <20241003103009.2635627-1-leitao@debian.org>
 <ZwQ2l8zo6BZQnnkB@google.com>
 <ZwUVBW72bZQNaWqt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwUVBW72bZQNaWqt@gmail.com>

On Tue, Oct 08, 2024 at 12:18:29PM +0100, Breno Leitao wrote:
> Hello Carlos,
> 
> On Mon, Oct 07, 2024 at 07:29:27PM +0000, Carlos Llamas wrote:
> > On Thu, Oct 03, 2024 at 03:30:05AM -0700, Breno Leitao wrote:
> > > decode_stacktrace.sh adds a trailing space at the end of the decoded
> > > stack if the module is not set (in most of the lines), which makes the
> > > some lines of the stack having trailing space and some others not.
> > > 
> > > Do not add an extra space at the end of the line if module is not set,
> > > adding consistency in output formatting.
> > > 
> > > Signed-off-by: Breno Leitao <leitao@debian.org>
> > > ---
> > >  scripts/decode_stacktrace.sh | 7 ++++++-
> > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/scripts/decode_stacktrace.sh b/scripts/decode_stacktrace.sh
> > > index 826836d264c6..4b3502a007fd 100755
> > > --- a/scripts/decode_stacktrace.sh
> > > +++ b/scripts/decode_stacktrace.sh
> > > @@ -311,7 +311,12 @@ handle_line() {
> > >  	parse_symbol # modifies $symbol
> > >  
> > >  	# Add up the line number to the symbol
> > > -	echo "${words[@]}" "$symbol $module"
> > > +	if [ -z ${module} ]
> > > +	then
> > 
> > nit: it seems the convention would have been something like:
> > 	if [[ -z $module ]]; then
> 
> That is how I wrote originally, in fact, but, the rest of the code is
> using the other way. Example:
> 
>         if [ -z $release ] ; then

This is actually problematic if $release can have any spaces but I
suspect it's not possible here. I'd still either quote "$release" or use
double brackets e.g. [[ -z $release ]] to be safe.

BTW, I assume $module can't have any spaces either?

>                 release=$(gdb -ex 'print init_uts_ns.name.release' -ex 'quit' -quiet -batch "$vmlinux" 2>/dev/null | sed -n 's/\$1 = "\(.*\)".*/\1/p')
>         fi
>         if [ -n "${release}" ] ; then

Yeah, there is no need for the curly braces here, they are not doing
anything.

>                 release_dirs="/usr/lib/debug/lib/modules/$release /lib/modules/$release"
>         fi
> 
> Thanks for the review,
> Breno

Note that I was initally referring to the 'then' being on a new line but
these are all minor nits.

Cheers,
Carlos Llamas

