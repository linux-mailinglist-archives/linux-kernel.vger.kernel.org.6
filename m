Return-Path: <linux-kernel+bounces-526708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75356A40240
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 22:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 704B07A4450
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 21:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C399254B0D;
	Fri, 21 Feb 2025 21:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hR2ch61u"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FA8253F3B;
	Fri, 21 Feb 2025 21:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740174307; cv=none; b=m+gUh7GSEThAoXHB589K5L0ks1dgQMfxMt9KiB4papCPaqTZjuB4FaXdZ0xSnWhIAKdvllV8XfsWtAQOTUtizzI88YbH+xRDDiqfbVzs3Jf8jMXhWsD+2WncNZJZyn/O3aF8L9JwBGpuFEd4v6YhYX29NgIXjDFvr/MAFXUQmK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740174307; c=relaxed/simple;
	bh=77cxc+L7gEsSz9B50V7m+LLHVcTxPFOxH675Ge037MI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=faH+YQUMSL5m/fCZZuLxouhAVJ5yAK1MMit3s+FwQNxlC+11yDMqxGsVndp0Pz7lp9hfQ2PGFqQ3J/FL11+Rq/w9WtVJnjqbLXrJ1lqbJ7X/BoF83XlECxxvcQmXZE7UxaUufL/BWdOl9hrYm8xja757ampzK4ARXO2P8OGQQj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hR2ch61u; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-38f26a82d1dso1405695f8f.2;
        Fri, 21 Feb 2025 13:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740174304; x=1740779104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zPEGG+QJeVb3Vp5xacSyItMTz4p/kfs9+QzZ02Bxf/Y=;
        b=hR2ch61ujV8Ywr8j4uk3w4lwLdQgbj4zkSNw/HMtAx4xN4aJGAz+4VRq6MRf3MDKEV
         Ru+GjbhXdGUNmvS3TLh9GHltc7qlpHGloThjUWDJWgA/Eipx8V87oe2/Lg0ZBcCup/Sb
         aAxGqqpWTZxevdyzNbXLVcXLY+O/Tjo6MGUQf+tCcppl/XJ1WffmrghW1Ozf4hGxxUKf
         bq4aoYexXMEweXm2t3nH8snd1Gq10tVSuV4rMn4ob/AhTAJv04qbHPULmiIYDT9tabIW
         oX4sRGn2I3iCexXcGRJE93tirA+Ws6YdJqPr8qp+IVy+eydeiaU2EXPB+64LOFUDUG/5
         3PIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740174304; x=1740779104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zPEGG+QJeVb3Vp5xacSyItMTz4p/kfs9+QzZ02Bxf/Y=;
        b=Yvmk22XsMAfQC5NF3faPE8sfNCbTzn3H3ofg7rnnP5SsJPNtP58TX/T0dphoItqCSq
         B+KT6mEU75ai1LMW8K0VLCi7ww0VikUVtxxrASptj9Z0Sbz/73p+F0vQ1bE8lGG1k00G
         jzVRbilAMuTxuSYG2KCP3yl9B0wf35OytAZUn3g3DucnHyiuSjrgNWEuDdS2bnc3WWgP
         QGLMVGfJZTBQ4S2JgqUN8vp9gWpYaKqYgbePaSmlAZ8LXZE+SRVULyEOsaoyCTcyw0xZ
         wg/MC+JS/+Iu8hPJFDVRkCPTfRn3U2TFxVQwjiXkbEIAqtDv9w2uGDAjOeVECDNt+Vei
         KKJg==
X-Forwarded-Encrypted: i=1; AJvYcCVRDRlLleCdYxmRbZElHdhyFIrpeYKtGy17jCqbIRFqERHnPl9/auYrWbJhQUPUBkb6PWDz1zNZb4ozdTiZtcw=@vger.kernel.org, AJvYcCVSiD3k6f/d1y5piwRBA6b7CF9Dxj2knfcoKcJ2hRWUdZ2TTVjI04fu//F0fgoh/bEcRD4lIIHgUJD/1WQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZmtq4qFRJTW508VR7oT7oWbMDIPVecJ+PUfeQOhdeOxo8FGeP
	dcYLCZEshEZUgBGXEYLCTTMKF5P62GfQ5o70JV6afwVE0AINT7yR
X-Gm-Gg: ASbGncvCRLoU2jLDe5NEi3uQQlMtL4vzyhCVTyZNm58AaUgiEUrt921dpPHiTdxGTMk
	CTePfKFoO8NjVG77sUjpQGMoYzPspLO82Aas6S91TKvDTVu5ghX+6NwFYUr1uQndQPT1z3hR53f
	Uv2eDyFzOx4qcxEiDWlKyrfeQOcJfFQqcqqiwWOfNHr5/TlE/I/MaE3yCu5UeL216KO0m2HZ/Xv
	O7jMy2GpN2slq2gZk5RqueUu24n/kj6jT0houIiM5REK5IqADPxSEFQqXbqu6yhltsbNU993pbf
	nCQFwUE4sC9aFetK4ligraL4cVlcsoD5aO92X959AdbOmJpofehqF1X5cIM1YcIO
X-Google-Smtp-Source: AGHT+IGs+RHE6sIXvHtolmoTaCjzVDl5T6yNybvmSDm/Idz17ST+OAfBTvT0SyHLs5ZNMaMuEH7fQA==
X-Received: by 2002:a05:6000:2c8:b0:38e:ae25:6d66 with SMTP id ffacd0b85a97d-38f6e95f9b8mr4656870f8f.19.1740174303828;
        Fri, 21 Feb 2025 13:45:03 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258f5fb6sm24093400f8f.44.2025.02.21.13.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 13:45:03 -0800 (PST)
Date: Fri, 21 Feb 2025 21:45:01 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jan Engelhardt <ej@inai.de>, "H. Peter Anvin" <hpa@zytor.com>, Greg KH
 <gregkh@linuxfoundation.org>, Boqun Feng <boqun.feng@gmail.com>, Miguel
 Ojeda <miguel.ojeda.sandonis@gmail.com>, Christoph Hellwig
 <hch@infradead.org>, rust-for-linux <rust-for-linux@vger.kernel.org>, David
 Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
 ksummit@lists.linux.dev
Subject: Re: C aggregate passing (Rust kernel policy)
Message-ID: <20250221214501.11b76aa8@pumpkin>
In-Reply-To: <CAHk-=wjF0wjD4ko7MgrZ1wBZ9QOrQd_AnyhDDUJQ1L5+i-o22A@mail.gmail.com>
References: <CANiq72m-R0tOakf=j7BZ78jDHdy=9-fvZbAT8j91Je2Bxy0sFg@mail.gmail.com>
	<Z7SwcnUzjZYfuJ4-@infradead.org>
	<CANiq72myjaA3Yyw_yyJ+uvUrZQcSLY_jNp65iKH8Y5xGY5tXPQ@mail.gmail.com>
	<326CC09B-8565-4443-ACC5-045092260677@zytor.com>
	<CANiq72m+r1BZVdVHn2k8XeU37ZeY6VT2S9KswMuFA=ZO3e4uvQ@mail.gmail.com>
	<a7c5973a-497c-4f31-a7be-b3123bddb6dd@zytor.com>
	<Z7VKW3eul-kGaIT2@Mac.home>
	<2025021954-flaccid-pucker-f7d9@gregkh>
	<2nn05osp-9538-11n6-5650-p87s31pnnqn0@vanv.qr>
	<2025022052-ferment-vice-a30b@gregkh>
	<9B01858A-7EBD-4570-AC51-3F66B2B1E868@zytor.com>
	<n05p910s-r5o3-0n36-5s44-qr769prp69r5@vanv.qr>
	<20250221183437.1e2b5b94@pumpkin>
	<CAHk-=wjF0wjD4ko7MgrZ1wBZ9QOrQd_AnyhDDUJQ1L5+i-o22A@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Feb 2025 11:12:27 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, 21 Feb 2025 at 10:34, David Laight <david.laight.linux@gmail.com> wrote:
> >
> > As Linus said, most modern ABI pass short structures in one or two registers
> > (or stack slots).
> > But aggregate returns are always done by passing a hidden pointer argument.
> >
> > It is annoying that double-sized integers (u64 on 32bit and u128 on 64bit)
> > are returned in a register pair - but similar sized structures have to be
> > returned by value.  
> 
> No, they really don't. At least not on x86 and arm64 with our ABI.
> Two-register structures get returned in registers too.
> 
> Try something like this:
> 
>   struct a {
>         unsigned long val1, val2;
>   } function(void)
>   { return (struct a) { 5, 100 }; }
> 
> and you'll see both gcc and clang generate
> 
>         movl $5, %eax
>         movl $100, %edx
>         retq
> 
> (and you'll similar code on other architectures).

Humbug, I'm sure it didn't do that the last time I tried it.

	David

> 
> But it really is just that the two-register case is special.
> Immediately when it grows past that size then yes, it ends up being
> returned through indirect memory.
> 
>                Linus


