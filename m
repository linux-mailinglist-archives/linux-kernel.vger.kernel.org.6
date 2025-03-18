Return-Path: <linux-kernel+bounces-565997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E64BA671EB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A3CD3AC45F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 10:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F16208989;
	Tue, 18 Mar 2025 10:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cBIRCjvD"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD632080F5
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 10:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742295566; cv=none; b=RESxt72hhMIi7pH1co8BYBJ8FBQuavgtEa6x9ihT3RnDnSAVFJ/lU8gHqJEHRxsTO/6i7Lm/Hm7J8vhwynHA3jpujiSz44z+qmwuD9E0kWyymZ0aSQsKb15zkgwKRPRwftIry9uUV05nt1CdkWASDG1tldjQrOr8WvHODNmJVzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742295566; c=relaxed/simple;
	bh=TmyY+52gsgW1yk4XO97qxIUKK0KEWAIT2EOBehWYqNM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FmducV+YR6h3OcGADdlewzQVkMyapsOODtm155psvTJBrGYK2TudpmxMSuPoI5LBbvDraW8XJ1mfixrYdwvP4bmLeT6gt1Z4iGP2QIhdWpnI1aaHnjVwY3qzkF2f7Do5bEQd9o06pUvpb4+ZEC7BUHuz1zrVe7Gb90IvSuSZ4sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cBIRCjvD; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43cf44b66f7so22750555e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 03:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742295559; x=1742900359; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Sqt8FVokWeKpJbMW7MOBvDu/DM0W5jzbOfl7XkZAR6M=;
        b=cBIRCjvDD+r5aD9b3dND5Hl7MGzg8fefuER5ddMqj3Ipet3Pkd/EsPdpPqoc/Qd6fm
         FX56nVEybRCdWq1PvPkY3k5i/Q0dEh5gn/9SBDqMV850UZXk9ElE/XGq7vcId/K8DuZ9
         9R933s5GdqHYhIvek9sxA/I9oJO0Cp5wiOvQS7L3LE1KdXWRL8qwKPXuU8EDyXrXKYdc
         ol8FZjVF9QJ17QgJtAah2tNJTnp7HacPUV0k9FjucpDjktB+iGsVdvAc2WCkMckdTOpe
         XbOjE6Bm/mBQdBm8EWxxEjSz4Dh9b9oZKW46Ac3HJwNpXOGHvLushtPgRJvZHt5/IcEm
         ZHDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742295559; x=1742900359;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sqt8FVokWeKpJbMW7MOBvDu/DM0W5jzbOfl7XkZAR6M=;
        b=X3lfmHTsJvMWmHRteMx6a7+JzqQZa8uWKWmJf+46d81m1c7RWTrNsd4FWJhmDNljMH
         MFVGPtsGEHdwft3sG1Kc2AO42O2OrSXkOHd2ddX4wv1uGgMKyj+Zyt+THgKFBh83E136
         YdbZXX2uWrPuNTFMV9sYo66sfdOOlnc+ZjZNHIBydNCIUADiueTkcUbBBtcnC8iHxzrt
         zfZ93RKJcPGZpxhXxurjkOP/bLTzM3FJn4aGSrB0UZhLErhJUy0uNLRLdbhN84lFkiff
         RnOClEXg49B3UP3D73XvqTZZHT9T3T0wD4MoEbdm+0nOTGcqAS3hgKvBbsziUsNiSXyN
         s16g==
X-Forwarded-Encrypted: i=1; AJvYcCW/Bz8SydeUBdylogU9BPfj8rd0H7/0DSEfFCrqD7K15aPaa2hiWIK83a0Bp+Qs60yKsI8DZHLPIzZ34UA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA6W/JUjYoAdccxbH2UkYhuBDoI8DSnoCrA3PuHpvZqF5rTl/+
	JWJ8komqaHnTWjj/ObWt6IphERRYuaf1ulFItrCj8y2gneOsEMKvJ6qubSdadreDLFNgiRHvJXp
	dKDetCsweGg==
X-Google-Smtp-Source: AGHT+IFf7jd2oyci8Ix+iGLg/B3NL6Yyg3jpCXCcoKzUgDRPsHu183PpDXyM9riCNUSfNWAjRU6yIxpWnXS6lg==
X-Received: from wmqd19.prod.google.com ([2002:a05:600c:34d3:b0:43c:ef1f:48d8])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1da6:b0:43c:f5e4:895e with SMTP id 5b1f17b1804b1-43d3b9504camr12032745e9.1.1742295559179;
 Tue, 18 Mar 2025 03:59:19 -0700 (PDT)
Date: Tue, 18 Mar 2025 10:59:17 +0000
In-Reply-To: <alpine.LSU.2.21.2503171327420.4236@pobox.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1741975349.git.jpoimboe@kernel.org> <aec318d66c037a51c9f376d6fb0e8ff32812a037.1741975349.git.jpoimboe@kernel.org>
 <Z9foFvqpmo0nX1XP@google.com> <alpine.LSU.2.21.2503171327420.4236@pobox.suse.cz>
X-Mailer: aerc 0.18.2
Message-ID: <D8JC89FNMZIR.CWZT19Q743I7@google.com>
Subject: Re: [PATCH 05/13] objtool: Increase per-function WARN_FUNC() rate limit
From: Brendan Jackman <jackmanb@google.com>
To: Miroslav Benes <mbenes@suse.cz>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, <x86@kernel.org>, <linux-kernel@vger.kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon Mar 17, 2025 at 12:29 PM UTC, Miroslav Benes wrote:
> > > diff --git a/tools/objtool/include/objtool/warn.h b/tools/objtool/include/objtool/warn.h
> > > index ac04d3fe4dd9..6180288927fd 100644
> > > --- a/tools/objtool/include/objtool/warn.h
> > > +++ b/tools/objtool/include/objtool/warn.h
> > > @@ -53,14 +53,22 @@ static inline char *offstr(struct section *sec, unsigned long offset)
> > >  	free(_str);					\
> > >  })
> > >  
> > > +#define WARN_LIMIT 2
> > > +
> > >  #define WARN_INSN(insn, format, ...)					\
> > >  ({									\
> > >  	struct instruction *_insn = (insn);				\
> > > -	if (!_insn->sym || !_insn->sym->warned)				\
> > > +	BUILD_BUG_ON(WARN_LIMIT > 2);					\
> > 
> > Shouldn't this be >3? Anyway, I think it would be clearer if the
> > coupling was more explicit, e.g:
>
> I think it is correct but I also think that the difference between bits 
> and the actual number of "allowed" warnings can be confusing.

Oh, yeah sorry I did not read this properly. So it's using
(1<<nbits)-2 as the "report that we're skipping duplicates" special
value.

So IMO  we need something like:

/* Subtract one because the warnings==WARN_LIMIT is used to report skipped warnings. */
static_assert(WARN_LIMIT < (1 << STRUCT_SYMBOL_WARNING_BITS) - 1, "symbol.warnings too small");

