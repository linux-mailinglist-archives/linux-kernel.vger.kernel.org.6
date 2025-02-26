Return-Path: <linux-kernel+bounces-534963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8A9A46D50
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 22:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 143B73B043D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 21:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BA2236A74;
	Wed, 26 Feb 2025 21:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DMmbh3dq"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB3F218591
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 21:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740604923; cv=none; b=XT7F43yew8MMi8ERj0HXugfcDP8J7rIB5O0fZT2zNtK3cWQn5JoSvIupdON8ZwNNS6n0bm1q+jCVzF+gxCjOjVl6EvnDc1patTakBqSlSp0Cnv3HXCMAqDI1tKFu049RF3IjX2wwSkT2ofmt32flnDnr2Y1yY5WIseuxClP/JZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740604923; c=relaxed/simple;
	bh=+N3TkM1NRoZBHh9Ynr3C7aEtzpQAI6OT4vv0R68K6KA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lZNcmT2SEPazymLzyCD/PQaOCXPkrGBqCYGaC9skvSJr8estYA03aUWFmQxtDWQpKjezZdp4b7pvI+swDnsLCdkBrsxYshOdaanKuvwJlZjxkY9B9CHbF/QvaDfqJnYg7y3E1ik76MWY04WQ+M0h5VH7GTDcH4dwUr7bK+R2fcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DMmbh3dq; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-abbae92be71so17057166b.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 13:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1740604920; x=1741209720; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bdNIeKEV298BHIClZBktZsY+11PKkbWSpfNyTBEPjKM=;
        b=DMmbh3dqTkdqfMS6AaFoSF1aQpndrjsrMmhEjSQCJ2FZB87+hUa/fKQwOWtyuEXlmF
         /RWWTh91m79cDqqqJTLmulDW9IOgd2ig7XVTEB97dN/znIAv94JnmblDR+A7RCWxrptH
         m6Cj8E7GyudRqsLqWhk42InL/VAudf2qZ2v7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740604920; x=1741209720;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bdNIeKEV298BHIClZBktZsY+11PKkbWSpfNyTBEPjKM=;
        b=QRRNg79nsngRl4Y+WQ7HBGyl48el+VJkscB3bwrbMMq7RPypT8vl9V2v4uOQH/o+nS
         YGPTedkfCnQd8BAIaRO4CgqY1N9jvun5mHYydvo7QIoTyM9UWS3wVaR35W+1TZ+ujN0Q
         47gC7VQG5bs75awjCiEZ+uLXSwujP8DSZIZArFir1Vg92G9jBvGIDtF70S1upLYu4LHy
         lyghRoiX2vwQTY+g5N7zD2MIaHzKnF0XFGZ4i4J33iprCIxG1ixBUnODX26CUI7ec/Xm
         Q4GKZmvLjVgVW+EiMzNDX/laIM/eTJpmJBMKR3RvOub64k7ElhdGe8zcFGYR5YI1R1rw
         eKYA==
X-Forwarded-Encrypted: i=1; AJvYcCXg3oUZegtpIppsS+F+x4nCl8SUXV/isdfiPqOe/KcVIg/4fqB3qv9TR8BS7sS4gqAr8VgUZ5Pm9Skgwdg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCV7aaKal3R74cTRNB0NjT9KNvZG0eGNwOF7VLtIqFPH0//EO2
	uUYkHT8rD2pp74UiC2gZb1U38AdAWNpdZCynIXQnMTdOMxCgWIY2Aph+bUsFuXQGOe0/RDwHrhq
	0LJLR+w==
X-Gm-Gg: ASbGncvSq7XiyAZvKVOgs6n/mUFln8w7wUypJGFRoE8w5Sq4554JkRCVugFPxW2D+AY
	jaOKv+3UtFVui+Q8sstXq5zeAMosMxV2frihYwjJa8X5Q/4enmFFylB2m6ipvSjwalQPpNJX4Qa
	bQlA8k8oZ7C8LvQPhCO6OjiA5LwtpHBEXXjyvcekooF2MseYSp6Do7Q/JDX2Y/qAFyGIdLjkEGe
	fbZt/kYmlzob738T6m5CFURjgHHl3Qzt7Opeu9v2d3A9hWWBBv8dhDzLuey+2hidJdePrjq8LI+
	ZRz5PZLZaOszscU0uQxiEPYLo/VDYXPIssifYqqkd5E9yP67Dn4qkH1T1XXyuVmrc/ECDHLJNrU
	X
X-Google-Smtp-Source: AGHT+IFWBf4IOcNv8L48h4nWrR4lFn/UyzS7Gqhr5rzljJUvX5MdbKGbkEVGQVNRinGdg6ohW91PYA==
X-Received: by 2002:a05:6402:2787:b0:5dc:74fd:abf1 with SMTP id 4fb4d7f45d1cf-5e4469da925mr22724468a12.15.1740604919701;
        Wed, 26 Feb 2025 13:21:59 -0800 (PST)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c0dc150sm6683866b.61.2025.02.26.13.21.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 13:21:59 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e033c2f106so177350a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 13:21:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXPs9i/JVrpAGRvyStF909l48GkJju70XuI32Bwcj0u7aJ56Qt0fXTsdFmULIy0u2mtuO9B9X3xDRaA5bI=@vger.kernel.org
X-Received: by 2002:a05:6402:40ca:b0:5e0:922e:527a with SMTP id
 4fb4d7f45d1cf-5e43c17fd68mr23458418a12.0.1740604918551; Wed, 26 Feb 2025
 13:21:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFJgqgRygssuSya_HCdswguuj3nDf_sP9y2zq4GGrN1-d7RMRw@mail.gmail.com>
 <20250222141521.1fe24871@eugeo> <CAFJgqgSG4iZE12Yg6deX3_VYSOLxkm5yr5yu25HxN+y4wPD5bg@mail.gmail.com>
 <6pwjvkejyw2wjxobu6ffeyolkk2fppuuvyrzqpigchqzhclnhm@v5zhfpmirk2c>
 <CAHk-=wgq1DvgNVoodk7JKc6BuU1m9UnoN+k=TLtxCAL7xTP=Dg@mail.gmail.com>
 <CAFJgqgSqMO724SQxinNqVGCGc7=ibUvVq-f7Qk1=S3A47Mr-ZQ@mail.gmail.com>
 <CAH5fLgh7Be0Eg=7UipL7PXqeV1Jq-1rpMJRa_sBkeiOgA7W9Cg@mail.gmail.com>
 <CAHk-=wgJQAPaYubnD3YNu8TYCLmmqs89ET4xE8LAe2AVFc_q9A@mail.gmail.com>
 <5d7363b0-785c-4101-8047-27cb7afb0364@ralfj.de> <CAHk-=wh=8sqvB-_TkwRnvL7jVA_xKbzsy9VH-GR93brSxTp60w@mail.gmail.com>
 <ed7ef66dbde453035117c3f2acb1daefa5bd19eb.camel@tugraz.at> <CAHk-=whLSWX=-5-z4Q8x1f_NLrHd0e3afbEwYPkkVSXj=xT-JQ@mail.gmail.com>
In-Reply-To: <CAHk-=whLSWX=-5-z4Q8x1f_NLrHd0e3afbEwYPkkVSXj=xT-JQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 26 Feb 2025 13:21:41 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj3C7Gc7pB0BD+5dvrFWh8xNJLYgupq6parOCFk94VyoA@mail.gmail.com>
X-Gm-Features: AQ5f1JrrDtu6pQtaXDIWizvRpIKwFgJHej09xYvppc2qRPzk9XWU6Yj8paFL6N4
Message-ID: <CAHk-=wj3C7Gc7pB0BD+5dvrFWh8xNJLYgupq6parOCFk94VyoA@mail.gmail.com>
Subject: Re: C aggregate passing (Rust kernel policy)
To: Martin Uecker <uecker@tugraz.at>
Cc: Ralf Jung <post@ralfj.de>, "Paul E. McKenney" <paulmck@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Ventura Jack <venturajack85@gmail.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Gary Guo <gary@garyguo.net>, airlied@gmail.com, boqun.feng@gmail.com, 
	david.laight.linux@gmail.com, ej@inai.de, gregkh@linuxfoundation.org, 
	hch@infradead.org, hpa@zytor.com, ksummit@lists.linux.dev, 
	linux-kernel@vger.kernel.org, miguel.ojeda.sandonis@gmail.com, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 26 Feb 2025 at 13:14, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> That "single read done as multiple reads" is sadly still accepted by
> the C standard, as far as I can tell. Because the standard still
> considers it "unobservable" unless I've missed some update.

I want to clarify that I'm talking about perfectly normal and entirely
unannotated variable accesses.

Don't say "programmers should annotate their special accesses with
volatile if they want to avoid compiler-introduced TOCTOU issues".

Having humans have to work around failures in the language is not the way to go.

Particularly when there isn't even any advantage to it. I'm pretty
sure neither clang nor gcc actually rematerialize reads from memory,
but in the kernel we have *way* too many "READ_ONCE()" annotations
only because of various UBSAN-generated reports because our tooling
points the reads out as undefined if you don't do that.

In other words, we actively pessimize code generation *and* we spend
unnecessary human effort on working around an issue that comes purely
from a bad C standard, and tooling that worries about it.

            Linus

