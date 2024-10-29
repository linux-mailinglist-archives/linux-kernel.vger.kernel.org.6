Return-Path: <linux-kernel+bounces-386588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F54D9B4580
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 10:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9767283914
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 09:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8CD3203708;
	Tue, 29 Oct 2024 09:19:19 +0000 (UTC)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7831E285F
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 09:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730193559; cv=none; b=cjmWMaTmQ0teZciwnHgjFWwg3jk1hhFeAQdTIAevJm3/atzd1dvnklFjyBw1Wf5sw49J5XMWxCcOYG3s1QnWSu9058WTL6dajvUl44RBS1mQLsFA7S+ZFtUmj2UY1Xqe1ZmLnzoPJ7rOelsq3+sYNmx0L9lCu2LBbJzjbNgLA8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730193559; c=relaxed/simple;
	bh=PpFy5OXSCkctGcIQtuqlwU8FSmNzEk9QnROjBePomRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SZOTsYtMXYphhMXAb0HGQecFCtyXlWSNsXU2/MSpka8UPQuBDXDfQJyhfsxNIbZzvTAt4854HqddTrifjOWWxtwJ/CQ0oD++Z9EVgfQQI2IsQBJ9wpJp1gLWBwbu174LREIIgCYuy7kqmrssyI+0tnahKfZMnV/2BJzhm266r5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9abe139088so767033266b.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 02:19:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730193556; x=1730798356;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=giOq4TCAE/0lshwh5nDMfFj4aygOc8GFt4DmCjGDK/o=;
        b=ORejUNxx8fpEhg8iSuB8PVgDB43ICYXF3CckofkuOQFCGD/2uT5DHV3lXH3VX9Fzzb
         Nc01ijuzRcSYdOGIWajCa+BdTHYaoGnPysPRJq5hmw/QlZUBOukbLkgmHdgBQUkcO1DU
         KqeWbbDysjNuhcoNmuRKuUR145GbRGGfGVeGjfUA/PoeUfwtUUMpT8qpZVJbIFAmiIQ9
         i+pbloqk7VbXfostGUta2aiSsYeORg2Z7jNa/C2O3KOFeVJSE2XLHlfEHwkKr7+quGkd
         CX0NXxhoWLzSTr5Zlo6kW+HReON+79C/C7xe27sq2SVMl0w5Cg49IavjkzraUxYDn7KN
         HEVw==
X-Forwarded-Encrypted: i=1; AJvYcCVVONqL18l5F+vatsdOR3ANQoB+h/veBvfIWRRuyi/yuT+v6BwsoYiwHGqDpmHXvrCW9jniQoRJBAKRIhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1D2TTtEL/8jRNdH1mS+OVYU+PdF3FSFtYORuzrr5e0hfMSQ3D
	GOfszMLlLu8EH1nWiVSd9ppoAq/YGfMlb47brmMmUqdYGSTEfM0n
X-Google-Smtp-Source: AGHT+IFjixhMZ5koqT4HCi2rpacq1F84uaFAxnW/NkrLVQZtVT5T5JAJBEZHJ+i/rh5WnYG2lhwpNg==
X-Received: by 2002:a17:906:c156:b0:a99:f4fd:31c8 with SMTP id a640c23a62f3a-a9de5d65a4fmr1137612966b.22.1730193555594;
        Tue, 29 Oct 2024 02:19:15 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-004.fbsv.net. [2a03:2880:30ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1f29950asm448643366b.122.2024.10.29.02.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 02:19:15 -0700 (PDT)
Date: Tue, 29 Oct 2024 02:19:12 -0700
From: Breno Leitao <leitao@debian.org>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: bp@alien8.de, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, kernel-team@meta.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] x86/bugs: spectre user default must depend on
 MITIGATION_SPECTRE_V2
Message-ID: <20241029-large-perfect-bulldog-ce53b3@leitao>
References: <20241015105107.496105-1-leitao@debian.org>
 <20241015105107.496105-3-leitao@debian.org>
 <20241028143453.govo3bnbayc7rqjj@desk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028143453.govo3bnbayc7rqjj@desk>

Hello Pawan,

On Mon, Oct 28, 2024 at 07:34:53AM -0700, Pawan Gupta wrote:
> On Tue, Oct 15, 2024 at 03:51:06AM -0700, Breno Leitao wrote:
> > @@ -1277,9 +1277,13 @@ static __ro_after_init enum spectre_v2_mitigation_cmd spectre_v2_cmd;
> >  static enum spectre_v2_user_cmd __init
> >  spectre_v2_parse_user_cmdline(void)
> >  {
> > +	enum spectre_v2_user_cmd mode;
> >  	char arg[20];
> >  	int ret, i;
> >  
> > +	mode = IS_ENABLED(CONFIG_MITIGATION_SPECTRE_V2) ?
> > +		SPECTRE_V2_USER_CMD_AUTO : SPECTRE_V2_USER_CMD_NONE;
> > +
> >  	switch (spectre_v2_cmd) {
> >  	case SPECTRE_V2_CMD_NONE:
> >  		return SPECTRE_V2_USER_CMD_NONE;
> > @@ -1292,7 +1296,7 @@ spectre_v2_parse_user_cmdline(void)
> >  	ret = cmdline_find_option(boot_command_line, "spectre_v2_user",
> >  				  arg, sizeof(arg));
> >  	if (ret < 0)
> > -		return SPECTRE_V2_USER_CMD_AUTO;
> > +		return mode;
> 
> This doesn't look right to me, spectre_v2=eibrs|retpoline... will override
> CONFIG_MITIGATION_SPECTRE_V2=n and enable the kernel mitigation, but the
> user mitigation will stay disabled.

Correct. In the current configuration, if the user compiles the kernel
with CONFIG_MITIGATION_SPECTRE_V2=n explict, then the kernel will have
all spectre v2 mitigations disable by default, and can opt-in using
command line arguments.

In other words, if the user compiles the kernel with
CONFIG_MITIGATION_SPECTRE_V2=n, then it means all spectre v2 mitigations
will be disable. the user wants to opt-in mitigation by mitigation, tho.

For instance, if user sets `spectre_v2=eibrs|retpoline` in cmdline, then
it must not set `spectre_v2_user` automatically. User can decide to do
enable userspace mitigation so as well by passing userspace another
command line `spectre_v2_user=on|prctl|..`. I.e, they are independent
selectable.

> If this is the intention it should be
> clearly documented that enabling kernel mitigation does not enable user
> mitigation. And an explicit spectre_v2_user= is required to enable user
> mitigation.

That is fair. I didn't find a place where to document about diferent
behavior when CONFIG_MITIGATION_X is disabled. What would you suggest?

Thanks for review and good points.
--breno

