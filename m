Return-Path: <linux-kernel+bounces-355043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 919D999466A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 13:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51ED428A58D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 11:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2371D12EA;
	Tue,  8 Oct 2024 11:18:35 +0000 (UTC)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987CF1D0E38
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 11:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728386315; cv=none; b=O1rXWc7OrnjXZ8hHgrFgO5pF3u81gI9qVrJHmmvagyEgn69102BG3QN2HIjFEGKinTtEBHh+DbScuX6hVJIP41X8nQMAzk0EcXBe1AlHuCHP1GSpKZudE0EviFkWKT55yXDhtFawtODQsJV9GV9j1Mqs8KRAbmbnHg6nCoNiatA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728386315; c=relaxed/simple;
	bh=DNhkwOHJhL7ejzdjOeLmcFosXdNQ+SBcCRCuVZuT8PM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DmmnTatVyAA0OEB5u/KoF6X4lehYTw0HtH6bnWhyD0JJ7OtQIew05fWWoTsaXxz8fLjGge+qwWMldhQdnSXHp0YrqzEckGMk7CK1gNEUc3d4jjSz1RhuvYS7Znpr43tQwPxsMZvNAH0BDjqI7d6Xrl98mnS4eh0K9NUhNqhArEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c883459b19so6419158a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 04:18:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728386312; x=1728991112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YXF1LQvYDHFGef47bcQ3m4/fpMy7m4G1up8G5liYiXg=;
        b=aQ7FwYyPkwZo9LL4XR6T+lY3/Q0Xt83vs14OBGd/GHaq4GMOwXC4aBiXI8QblOEpY0
         JBGD/E8yVFJURffGB6LKq447+wBiWokYr22sryusIjsIOP5e0AVJYjD6voI44vmMllal
         eo+dyXSkitX59m/47Dw2d7abDLAFy0mWg3xwc84yEG1ejWXpxRuKlTk5h9Oo5dzko2Bd
         ggNhUVJbsOTnObzLTTXrU14JeOTAGBma3vcwjc3ftJPddHg15TV445F/K9iGktidoeRD
         yzW0RJXlzqgcGKSwe3ubdeMMkJODjpNVtNMTxgFX3IAa14A6yrXMqUgaqwVDD6SUjqjf
         mkWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhfVkY2hmzSiOCh2tViaaisFGcKWRv4ng27CuaD6AqwcDvbAoo2++MEAG6QThfrwJaaN24AYQiGMP9zCE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/72VdIll1eiBaAz69euiZjp70tJ+nTVJCVqftwpH8ZlUT1Fk+
	grNj5VL1BQQpEe0E7XuPPkGLgbATdqbTvS6WtvaTIdgLlw7crL/E
X-Google-Smtp-Source: AGHT+IEa+UR4w2eBlyFF7Y1SuVcyT39KKyTZg85PYmkDh8Jp/k5/WNQmH2JP/RczuoiOCtpTZliLyQ==
X-Received: by 2002:a17:907:9343:b0:a86:a481:248c with SMTP id a640c23a62f3a-a991bd3f9c7mr1632832366b.19.1728386311709;
        Tue, 08 Oct 2024 04:18:31 -0700 (PDT)
Received: from gmail.com ([2620:10d:c092:500::7:e36b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a995350d522sm264996666b.32.2024.10.08.04.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 04:18:31 -0700 (PDT)
Date: Tue, 8 Oct 2024 12:18:29 +0100
From: Breno Leitao <leitao@debian.org>
To: Carlos Llamas <cmllamas@google.com>
Cc: akpm@linux-foundation.org, Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Stephen Boyd <swboyd@chromium.org>,
	Elliot Berman <quic_eberman@quicinc.com>,
	Xiong Nandi <xndchn@gmail.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scripts/decode_stacktrace.sh: remove trailing space
Message-ID: <ZwUVBW72bZQNaWqt@gmail.com>
References: <20241003103009.2635627-1-leitao@debian.org>
 <ZwQ2l8zo6BZQnnkB@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwQ2l8zo6BZQnnkB@google.com>

Hello Carlos,

On Mon, Oct 07, 2024 at 07:29:27PM +0000, Carlos Llamas wrote:
> On Thu, Oct 03, 2024 at 03:30:05AM -0700, Breno Leitao wrote:
> > decode_stacktrace.sh adds a trailing space at the end of the decoded
> > stack if the module is not set (in most of the lines), which makes the
> > some lines of the stack having trailing space and some others not.
> > 
> > Do not add an extra space at the end of the line if module is not set,
> > adding consistency in output formatting.
> > 
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> >  scripts/decode_stacktrace.sh | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/scripts/decode_stacktrace.sh b/scripts/decode_stacktrace.sh
> > index 826836d264c6..4b3502a007fd 100755
> > --- a/scripts/decode_stacktrace.sh
> > +++ b/scripts/decode_stacktrace.sh
> > @@ -311,7 +311,12 @@ handle_line() {
> >  	parse_symbol # modifies $symbol
> >  
> >  	# Add up the line number to the symbol
> > -	echo "${words[@]}" "$symbol $module"
> > +	if [ -z ${module} ]
> > +	then
> 
> nit: it seems the convention would have been something like:
> 	if [[ -z $module ]]; then

That is how I wrote originally, in fact, but, the rest of the code is
using the other way. Example:

        if [ -z $release ] ; then
                release=$(gdb -ex 'print init_uts_ns.name.release' -ex 'quit' -quiet -batch "$vmlinux" 2>/dev/null | sed -n 's/\$1 = "\(.*\)".*/\1/p')
        fi
        if [ -n "${release}" ] ; then
                release_dirs="/usr/lib/debug/lib/modules/$release /lib/modules/$release"
        fi

Thanks for the review,
Breno

