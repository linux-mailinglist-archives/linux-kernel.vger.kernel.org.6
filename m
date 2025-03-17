Return-Path: <linux-kernel+bounces-564997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B58D7A65EAF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 21:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50E06189B4B0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 20:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533EC1E833B;
	Mon, 17 Mar 2025 20:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IE0uoQvC"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED211DE8A7
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 20:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742241877; cv=none; b=AQR+t/iACDBWJrdfYxLWmz79mlTHYMley6CqEW2U38FTG4u866Hh1MQGdYLe7bXJt0O07pOHA5WcI0J+Z5iOJR3lUyVOq7/1tzQw4KlQ/V+rUPtZqhxO/3bqgAd3bZF1i2ezFymXXogzQO0RVOGBS87GEOEB+upRXp5v+yUDWfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742241877; c=relaxed/simple;
	bh=5bDbl7G+5LGMGcfVxcK2EQBWdcwcjSQpiqdMNi9eD/M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uwQuagSaqbuwG95o1MMobNuv29FNpurRsbYH47BhvuYIPqSDsTVHoqmq8pA+iwAQxJFeu8sE+ro3StERfQkBMGr40cRNg0ok7lSPW9BjK9T0Jru0/xHEvygtQ5fJTmtmIvYZ41URQwVx/ySNKIbs1QMw8qn2mNWuWEOwuyfphKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IE0uoQvC; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43cf06eabdaso25129695e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 13:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742241874; x=1742846674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I+yftTMxlic2mD1ryKYfkycnPpOKHvoQOGTtzztr5L0=;
        b=IE0uoQvCcOoDq90i+TnVP1SSFdmJYkJiuXYb7I4go1xX+L9sNtII9syisfQLkVlA38
         i1rUfuLm0JgNOJxQnKxhlrpkJE3WljCEAH+qrGSEqyQ71vFR85i9BsJSptJVwyVDzhMq
         LXWCdUiXYItxkqvoBsZZdk6P+dRWCe3qZKdpchJ4Rn4GldtYZmsmzvM2oDb4ajrRu8CC
         B74753UWNh/6UFSCfMIScKMCVbB0UbzgmYv5aRLbsFsPf+aWzyLLoAA+SyBnOqoTu2pP
         Pbm0CYqrB2Y3ZwWU3G4FRQwbggG+IIEN8NouC+Aw3JJ/dizePcim4j/f23TWtcM7E6ZG
         qsZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742241874; x=1742846674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I+yftTMxlic2mD1ryKYfkycnPpOKHvoQOGTtzztr5L0=;
        b=sKEVhfhpik3+SbZli3cp89wyYHXqTkDTWXaoQyojmvtCEkX8J3eYkQsxaSL8jjXLZS
         v3+WUZu7OpeeKM+XW4E3kPEQVsjjz9VX7uprLWzS1cCbwOqWtD9zhhb0rEx+XZnuLWCb
         Cpsk+U8m4AAfRZ1CuQrsddwEa6nBnMF2iQS/IExKgJ1V4yX9ya1+/N8rE4QbkPrT2o7v
         hEa4y2OsU6fPDi8ldBzd7hYzhwM9LMWoxf3MPRrHKCyvmNBCKybA4L5apD9pCmNTC0ku
         keLxjnhHqTXbuiEARP3vx/GUP2Bhyc/EejuJA4ErQ8uwObVLFnJ1Qjzt6VQukGv98Xrz
         yQow==
X-Forwarded-Encrypted: i=1; AJvYcCXUaxlNYTTcfPrHqPtYMt3SdLg4xS+bLVTAHDcPdTGmR9aV97agd2KEKfA6RrYarD2lDCxkHxtSL/0Y2CE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw59S28EANSEqZu+O3MOtR/YoSAaGeWwh7Gv/AUruOFiSD48cvF
	mRDGoqEhD7wv5Q6PUQwkg/iy0HFQeTNFAkgbGkg48fJuuYzChLdV
X-Gm-Gg: ASbGncuZg/MW0emL0JPvIylk3UQmKLzOteAQKtGLyqbgx1xPJYPVeAccNlJ5Qhu5cEg
	8xrUVo5b5BJWiOnB5FDWF7nSdwAN8M1mCjB3Xk7sFNDdpEMMIk6rjxViuXMLFDbqWPD+L789uIF
	P7nwdUXatKKczphn/526cSa5qRp5YoFJYycwSZ7/yDSx+QYFhosk/VZavfS+l/ZHfB0PiKXi3Rw
	WByUuOZEWoN3yqqRf+U2O5drsQn3bb4O7eXTutQpTVfejHujztOa1xwdrb0OeYp85kqRlKBUqN2
	dGAC9NtNQLzj7SkaSRSYzrB5Zf3d+cs7MOfhiuxdOMGGr3l8js0UyKeNlQmNWfI1BYsgvisoBsp
	iPwmJ5epR6hsoO2GpKw==
X-Google-Smtp-Source: AGHT+IERKA4HXQE/HUQrXsD/N7VST/VXcydaEMCHc/Fsxv9HgpGK2bJ5+FDsxGqZ8At63iwEZsTIbQ==
X-Received: by 2002:a05:600c:1d2a:b0:43c:efed:732d with SMTP id 5b1f17b1804b1-43d1ec8dd4emr151411765e9.16.1742241874006;
        Mon, 17 Mar 2025 13:04:34 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c83b6b37sm16179101f8f.37.2025.03.17.13.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 13:04:33 -0700 (PDT)
Date: Mon, 17 Mar 2025 20:04:32 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Uros
 Bizjak <ubizjak@gmail.com>, Andrew Cooper <andrew.cooper3@citrix.com>, Ingo
 Molnar <mingo@kernel.org>
Subject: Re: [PATCH 14/20] x86/barrier: Use alternative_io() in 32-bit
 barrier functions
Message-ID: <20250317200432.1a076d6a@pumpkin>
In-Reply-To: <zfabhk7c3fucov7lpfsqf5bj7iie5324ccgn4ingzzakoyhl4u@fzg364keuphn>
References: <cover.1741988314.git.jpoimboe@kernel.org>
	<1c2fe7f93c4dd8a87c2e1fa8b780a8a2968be445.1741988314.git.jpoimboe@kernel.org>
	<CAHk-=wjtvTPERDdrok2kDrSSFBjqHCCNVff95VVxhvP6wCC6jg@mail.gmail.com>
	<zfabhk7c3fucov7lpfsqf5bj7iie5324ccgn4ingzzakoyhl4u@fzg364keuphn>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Mar 2025 17:05:34 -0700
Josh Poimboeuf <jpoimboe@kernel.org> wrote:

> On Fri, Mar 14, 2025 at 01:49:48PM -1000, Linus Torvalds wrote:
> > So all of these patches look like good cleanups to me, but I do wonder
> > if we should
> > 
> >  (a) not use some naming *quite* as generic as 'ARG()'
> > 
> >  (b) make the asms use ARG_OUT/ARG_IN/ARG_CLOBBER() to clarify
> > 
> > because that ARG(), ARG(), ARGC() pattern looks odd to me.
> > 
> > Maybe it's just me.
> > 
> > Regardless, I do think the series looks like a nice improvement even
> > in the current form, even if that particular repeated pattern feels
> > strange.  
> 
> So originally I had ASM_OUTPUT/ASM_INPUT/ASM_CLOBBER, but I ended up
> going with ARG() due to its nice vertical alignment and conciseness:

But ARG() does look horrid.

Is the ARG() necessary just to handle the comma separated lists?
If so is it only actually needed if there is more than one item?

Another option is to just require () and add the ARG in the expansion.
So with:
#define __asm_call(qual, alt, out, in, clobber) \
	asm("zzz", ARG out, ARG in, ARG clobber)

__asm_call(qual, ALT(), \
		([var] "+m" (__my_cpu_var(_var)), "+a" (old__.low),	\
		    "+d" (old__.high)),					\
		("b" (new__.low), "c" (new__.high), "S" (&(_var))),	\
		("memory"));

would get expanded the same as the line below.

	David
	
> 
> 
> 	__asm_call(qual,						\
> 		ALTERNATIVE("call this_cpu_cmpxchg8b_emu",		\
> 			    "cmpxchg8b " __percpu_arg([var]),		\
> 			    X86_FEATURE_CX8),				\
> 		ARG([var] "+m" (__my_cpu_var(_var)), "+a" (old__.low),	\
> 		    "+d" (old__.high)),					\
> 		ARG("b" (new__.low), "c" (new__.high), "S" (&(_var))),	\
> 		ARG("memory"));						\
> 
> 
> Though ASM_OUTPUT/ASM_INPUT/ASM_CLOBBER isn't so bad either:
> 
> 	__asm_call(qual,						\
> 		ALTERNATIVE("call this_cpu_cmpxchg8b_emu",		\
> 			    "cmpxchg8b " __percpu_arg([var]),		\
> 			    X86_FEATURE_CX8),				\
> 		ASM_OUTPUT([var] "+m" (__my_cpu_var(_var)),		\
> 			   "+a" (old__.low), "+d" (old__.high)),	\
> 		ASM_INPUT("b" (new__.low), "c" (new__.high),		\
> 			  "S" (&(_var))),				\
> 		ASM_CLOBBER("memory"));					\
> 
> 
> That has the nice benefit of being more self-documenting, albeit more
> verbose and less vertically aligned.
> 
> So I could go either way, really.
> 


