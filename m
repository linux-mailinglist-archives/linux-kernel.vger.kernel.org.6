Return-Path: <linux-kernel+bounces-534095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DF1A462C8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8F9E7A859B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F12C221F00;
	Wed, 26 Feb 2025 14:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="tXwF2kCB"
Received: from lamorak.hansenpartnership.com (lamorak.hansenpartnership.com [198.37.111.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA90F22332E;
	Wed, 26 Feb 2025 14:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.37.111.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740580014; cv=none; b=LCQk/OVrjeLonh3i2S2cCqYf5sUgB7MI09S6Ntp/95Mq4wlWXd//osSgyCMx8sWuJrwuZcIQwx+64sqVp+aE1ZgMNBe8nre1Ov/Tka9WspsXqhFNBPNKs8YcMesWMmE8fQpjAifOGlPxNFxelM3EuALBMNCHRFdVbG/UzLq3u4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740580014; c=relaxed/simple;
	bh=/OSmedE/ACjr7gFlF/szGIcSg2BBYnDAW6sXgSCux1M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f95L6LuYNh9NSiysahjyMWwQpbthwjcAgkqNPLeS1hoS3JcgeC/t1P76r7eYObTFt7nidJiGYiASbzPXt2nDz4ZGUWYOMweOfoaAsghqdxjrJVaZITKtyBYE+IWjVvEn8kS8+XJSjrMLcMV13tQ0+z/QfzmAUSNKkQJZzac6+0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=tXwF2kCB; arc=none smtp.client-ip=198.37.111.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1740580011;
	bh=/OSmedE/ACjr7gFlF/szGIcSg2BBYnDAW6sXgSCux1M=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=tXwF2kCB1vbEyn8qGStqaZZVIB+Wbe2KS4s7B6H0K3VGoOXZ4oxq/zoCDBMcwJ1v1
	 fZ6oFZZf8mKYA32O9ZjdPM/VZKSx3qISuThxcc7PBzG+Sty1S6LL+FKOQhP31q1bTF
	 n0FKfgp8mzn+anNwwaC0tK9pCHMx+BWBm23uFxDw=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	by lamorak.hansenpartnership.com (Postfix) with ESMTPSA id 465FC1C257A;
	Wed, 26 Feb 2025 09:26:51 -0500 (EST)
Message-ID: <f2bf76553c666178505cb9197659303a39faf7aa.camel@HansenPartnership.com>
Subject: Re: C aggregate passing (Rust kernel policy)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Ventura Jack
	 <venturajack85@gmail.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, "H. Peter Anvin"
 <hpa@zytor.com>, Alice Ryhl <aliceryhl@google.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Gary Guo <gary@garyguo.net>,
 airlied@gmail.com,  boqun.feng@gmail.com, david.laight.linux@gmail.com,
 ej@inai.de,  gregkh@linuxfoundation.org, hch@infradead.org,
 ksummit@lists.linux.dev,  linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, Ralf Jung <post@ralfj.de>
Date: Wed, 26 Feb 2025 09:26:50 -0500
In-Reply-To: <CANiq72mOp0q1xgAHod1Y_mX86OESzdDsgSghtQCwe6iksNt-sA@mail.gmail.com>
References: 
	<CAFJgqgRygssuSya_HCdswguuj3nDf_sP9y2zq4GGrN1-d7RMRw@mail.gmail.com>
	 <20250222141521.1fe24871@eugeo>
	 <CAFJgqgSG4iZE12Yg6deX3_VYSOLxkm5yr5yu25HxN+y4wPD5bg@mail.gmail.com>
	 <6pwjvkejyw2wjxobu6ffeyolkk2fppuuvyrzqpigchqzhclnhm@v5zhfpmirk2c>
	 <CAHk-=wgq1DvgNVoodk7JKc6BuU1m9UnoN+k=TLtxCAL7xTP=Dg@mail.gmail.com>
	 <CAFJgqgSqMO724SQxinNqVGCGc7=ibUvVq-f7Qk1=S3A47Mr-ZQ@mail.gmail.com>
	 <CAH5fLgh7Be0Eg=7UipL7PXqeV1Jq-1rpMJRa_sBkeiOgA7W9Cg@mail.gmail.com>
	 <CAFJgqgREAj-eP-d244WpqO-9H48ajZh83AxE31GqoONZ=DJe-g@mail.gmail.com>
	 <CAH5fLghEMtT663SNogAGad-qk7umefGeBKbm+QjKKzoskjOubw@mail.gmail.com>
	 <5E3FEDC4-DBE3-45C7-A331-DAADD3E7EB42@zytor.com>
	 <2rrp3fmznibxyg3ocvsfasfnpwfp2skhf4x7ihrnvm72lemykf@lwp2jkdbwqgm>
	 <CAFJgqgS-SMMEE2FktuCUimdGkPWMV3HB2Eg38SiUDQK1U8=rNg@mail.gmail.com>
	 <CANiq72mOp0q1xgAHod1Y_mX86OESzdDsgSghtQCwe6iksNt-sA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 2025-02-26 at 14:53 +0100, Miguel Ojeda wrote:
> On Wed, Feb 26, 2025 at 2:03 PM Ventura Jack
> <venturajack85@gmail.com> wrote:
[...]
> > Exception/unwind safety may be another subject that increases
> > the difficulty of writing unsafe Rust.
> 
> Note that Rust panics in the kernel do not unwind.

I presume someone is working on this, right?  While rust isn't
pervasive enough yet for this to cause a problem, dumping a backtrace
is one of the key things we need to diagnose how something went wrong,
particularly for user bug reports where they can't seem to bisect.

Regards,

James


