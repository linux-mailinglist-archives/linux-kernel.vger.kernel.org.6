Return-Path: <linux-kernel+bounces-526724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E4AA4026C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 23:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF2F619C1851
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 22:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63361EEA56;
	Fri, 21 Feb 2025 22:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iv9vFzz6"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8139218DB0B;
	Fri, 21 Feb 2025 22:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740175327; cv=none; b=UlR/1AMa0ZsWAHQjc+XimR7uU6wGfggUERX14sEKyTSQe/hPSC8vciOLkXA53eQ/30uAPr1HML0nGFbvDtNCffAlT0gXj/nHxssIW1kF48M7dTBPbHqeHWR5D8MiR800dUS3J6eqW+Cg1jgM3SdrykuctdcissUsOeFEcepSXDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740175327; c=relaxed/simple;
	bh=VuZcuBGGTaU1S/eDL8RLJUuYcasTLJ3q8msICjDjT4s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g0Pq4Vg6ym3fTtKg2A++CGwzM8xxBbFzu+va+4U0oXt9LDrrVg9JH31KW8HIEO6mN9uQKdUV2082n5lP0zdSLBs8wi98WTZkou0Fzp1VIX+R5f4jxTne/0enrXdfF/xh2ZFenFgldykRbUua+iOXD7rk+2h3BnkGSQ1CdMSFJNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iv9vFzz6; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-438a39e659cso17237945e9.2;
        Fri, 21 Feb 2025 14:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740175324; x=1740780124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H8//BbINdigUGhI3vG32BvD2ovM86xEn4SPyKThRhFI=;
        b=Iv9vFzz6sqiy6kldz71vdlIsZ1BjftC95eniVvoF4Jsx9mi73Qr42rgE4DNv/Ur0MZ
         pYK/+AyNRw/CcYqeZG+eHLZKoDeHmeq2oxb6ONDDpqx5m87UGUXL80Zn2Vc5mYKmWN3H
         VQwPi3Z3LRLnnQc2ZJUU4z5/1Olh3NgLAruM37GGcStZiHMvELEmxzlPOmSofQ2RDzoD
         PlteGIYWO/9eTm/XQJYufM/eKrcaDyNNYSWo4DMrZM+CRubeKJMJBmQFmW4cRV2yp8kj
         hzJIafKCHC/HJ4SFAnXXkgtLIuege4GY9c1VW8gkFzRKpoWZ/Uy/d2Dv7tCXADj3V4ul
         GdjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740175324; x=1740780124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H8//BbINdigUGhI3vG32BvD2ovM86xEn4SPyKThRhFI=;
        b=jDudsjUKb1eIaoyM82Il/E0CEE83GBitzTfrbnIhaDe+QRJP39fYKq/+/HVEdHmBs8
         plpnBkrKI9v4uWaYEeAqPF/dHquMA+oDz9UV2+2Ah5Li+Y38cVqhMKeQzoTkurTbEBXQ
         1pb9N0SrUjEVvdXDIqdysmbqsmfUtNs+WgNMjabRW9h1zCUswF6rjVhsGPpd54KZ5c+X
         HMzNgW9NsZWfarbiw9uGZOHF7ynI47k4jNo4JJ+57Pr/AGidib/PIg2kOuEqLtZbd8E+
         qPGJcEYaaxx/jseB4jfswcHh+KbTiVcWo38g+Oc41I/1Jkfzm1LvCS/VRxdG4eWmdYI9
         A+/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUSzaaEh+V2s0i5LV4pc4Mos/s6ZqMKJLgHp31eI66wqPzHl/ndBZG/Onzey9jkiG8ZNf9VOjO9x0MmTl0=@vger.kernel.org, AJvYcCX6ix2Nyhyj2T1KFXgAQoU5mdwgk7frI14wC2PqMAW3qiogQ2nVi0z9hVqL8TFBXlNWtR/v1xlVvsg2W+tnHQw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfil8MDi1MXS1CcFAsqoEdyGsDXFLFA7iQMl2GlyXyOQDVO73a
	dXY6f1wW7ulwK/6NYfZenpLwVyRIfnMs4N2JWS6MHnNtF738yH3Z
X-Gm-Gg: ASbGncvibHfFVBxMV6onRIycpAiDEhzmczhO46cy3FAHIp1t8iP2t/+mvMktKadbLbK
	Wr4YhWmaK4T6UTvNWRyGJX78v1rKRfeiD3ltMO1GCJmY/WFcyxClUYjCfUaRhaG2dXHnrf58Grv
	Gv3W2ltOi6HYpYovGwlQNSz6dSbHNt0i0szgLdWYn4PtiJFcdACnN6i2wmYtxvNeKoCqvpKP0ye
	78eDQ56k76UugwGu95zEn6I5wy8ZwehDQQ2XrgbYHrrhgLMZT7RTbiBykiG1p1It+SumI5t9Yzs
	GIn1kPO+hyu4piLrg77HFhXb/rgfb0BR4N8qHn2SRqSlFJRArqmmEq4OQ9rjrcVj
X-Google-Smtp-Source: AGHT+IE4FA0oLziTVHdJF6hJ+k7szSovVH9EHqDlmFPGZ69qfh4moBtlT3+WMJ3xrpSuFx2fwpGLoA==
X-Received: by 2002:a05:600c:5106:b0:439:a25a:1686 with SMTP id 5b1f17b1804b1-439aebda0bbmr33296765e9.25.1740175323409;
        Fri, 21 Feb 2025 14:02:03 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b02d684dsm29205015e9.16.2025.02.21.14.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 14:02:02 -0800 (PST)
Date: Fri, 21 Feb 2025 22:02:01 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Jan Engelhardt <ej@inai.de>, "H. Peter Anvin" <hpa@zytor.com>, Greg KH
 <gregkh@linuxfoundation.org>, Boqun Feng <boqun.feng@gmail.com>, Miguel
 Ojeda <miguel.ojeda.sandonis@gmail.com>, Christoph Hellwig
 <hch@infradead.org>, rust-for-linux <rust-for-linux@vger.kernel.org>, Linus
 Torvalds <torvalds@linux-foundation.org>, David Airlie <airlied@gmail.com>,
 linux-kernel@vger.kernel.org, ksummit@lists.linux.dev
Subject: Re: C aggregate passing (Rust kernel policy)
Message-ID: <20250221220201.7068dfa3@pumpkin>
In-Reply-To: <20250221202332.GA6576@pendragon.ideasonboard.com>
References: <CANiq72m+r1BZVdVHn2k8XeU37ZeY6VT2S9KswMuFA=ZO3e4uvQ@mail.gmail.com>
	<a7c5973a-497c-4f31-a7be-b3123bddb6dd@zytor.com>
	<Z7VKW3eul-kGaIT2@Mac.home>
	<2025021954-flaccid-pucker-f7d9@gregkh>
	<2nn05osp-9538-11n6-5650-p87s31pnnqn0@vanv.qr>
	<2025022052-ferment-vice-a30b@gregkh>
	<9B01858A-7EBD-4570-AC51-3F66B2B1E868@zytor.com>
	<n05p910s-r5o3-0n36-5s44-qr769prp69r5@vanv.qr>
	<20250221183437.1e2b5b94@pumpkin>
	<p7946077-rn30-n3p3-ppp0-80o9n9p07718@vanv.qr>
	<20250221202332.GA6576@pendragon.ideasonboard.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Feb 2025 22:23:32 +0200
Laurent Pinchart <laurent.pinchart@ideasonboard.com> wrote:

> On Fri, Feb 21, 2025 at 09:06:14PM +0100, Jan Engelhardt wrote:
> > On Friday 2025-02-21 19:34, David Laight wrote:  
> > >> 
> > >> Returning aggregates in C++ is often implemented with a secret extra
> > >> pointer argument passed to the function. The C backend does not
> > >> perform that kind of transformation automatically. I surmise ABI reasons.  
> > >
> > > Have you really looked at the generated code?
> > > For anything non-trivial if gets truly horrid.
> > >
> > > To pass a class by value the compiler has to call the C++ copy-operator to
> > > generate a deep copy prior to the call, and then call the destructor after
> > > the function returns - compare against passing a pointer to an existing
> > > item (and not letting it be written to).  
> > 
> > And that is why people generally don't pass aggregates by value,
> > irrespective of the programming language.  
> 
> It's actually sometimes more efficient to pass aggregates by value.
> Considering std::string for instance,
> 
> std::string global;
> 
> void setSomething(std::string s)
> {
> 	global = std::move(s);
> }
> 
> void foo(int x)
> {
> 	std::string s = std::to_string(x);
> 
> 	setSomething(std::move(s));
> }
> 
> Passing by value is the most efficient option. The backing storage for
> the string is allocated once in foo(). If you instead did
> 
> std::string global;
> 
> void setSomething(const std::string &s)
> {
> 	global = s;
> }
> 
> void foo(int x)
> {
> 	std::string s = std::to_string(x);
> 
> 	setSomething(s);
> }
> 
> then the data would have to be copied when assigned global.
> 
> The std::string object itself needs to be copied in the first case of
> course, but that doesn't require heap allocation. 

It is still a copy though.
And there is nothing to stop (I think even std::string) using ref-counted
buffers for large malloc()ed strings.

And, even without it, you just need access to the operator that 'moves'
the actual char data from one std::string to another.
Since that is all you are relying on.
You can then pass the std::string themselves by reference.

Although I can't remember if you can assign different allocators to
different std::string - I'm not really a C++ expert.

> The best solution
> depends on the type of aggregates you need to pass. It's one of the
> reasons string handling is messy in C++, due to the need to interoperate
> with zero-terminated strings, the optimal API convention depends on the
> expected usage pattern in both callers and callees. std::string_view is
> no silver bullet :-(

The only thing the zero-termination stops is generating sub-strings by
reference.
The bigger problem is that a C function is allowed to advance a pointer
along the array. So str.c_str() is just &str[0].
That stops any form of fragmented strings - which might be useful for
large ones, even though the cost of the accesses may well balloon.

The same is true for std::vector - it has to be implemented using realloc().
So lots of pushback() of non-trival classes gets very, very slow.
and it is what people tend to write.

	David

