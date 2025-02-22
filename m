Return-Path: <linux-kernel+bounces-527517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 990BEA40C3A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 00:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F00A3189A75B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 23:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3D5204F6F;
	Sat, 22 Feb 2025 23:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="wy2Qk700"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE575201266;
	Sat, 22 Feb 2025 23:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740268285; cv=none; b=SjJqJ/1hEL7Rtx1dGNAMeXPQOsx3f7hVQi8njOz1kKlogd+g2024GZE0Zl/uGPH9OhbsBC/sQohPr6adsdAIex3LugFF4bwMWZCvc02ooxpZB+vfLZ3Zkyq/pmfjg6FspMdHLt2fb+Mt+uFEiMoJLRyd580iJ7CH0Gniv6Pz7mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740268285; c=relaxed/simple;
	bh=BUzYO5WNI0AvIV65QgeIcllxZT6M0OQeWB3k+6nghto=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=fX8WTkWbjj6RkCczkM7HVnK0S3XTZKRiZY6YbNB7Psa4g4V0PZJbPMo32PX9JF3F5g4a2Cynrv8UhDEBFnX1tAvf21y5Nf2awi+SGN0Q6Oc83wIPgcCuktohcSJlnRA4UDwYAULZarkirsEwfYQEKAF8pqBAKhjZf/sOeu0xNgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=wy2Qk700; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPv6:::1] ([172.59.160.4])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 51MNp5Sj3857546
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sat, 22 Feb 2025 15:51:06 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 51MNp5Sj3857546
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1740268267;
	bh=/+nn2rQ/7gqR+dEBO1aJufprBuwk9A8ZUqZnTRwjCes=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=wy2Qk700Kt5HER5PMi4N6WC6wigTrEclUj6Nbe/+p2kEBxRpdA9PzEfuoO2XBf2/a
	 iWg71U7XW921i92gYXs5Q2Yye/96v9I5si/RIblHu8XZGlFCxNmxA4tfj5YJBY0IPy
	 yihby4SfJVBzKKQMXw7q9QaA/2+8M+CtEW3gnsLL4sNWuBRb+Bau3vDuxStnRv0UOS
	 QLCxOj1gOmxfo29UmbYTjS3EzFYIFxzPI3RPlo/bq+G5bFVNC9YHZRWRcdEyYalDvE
	 4fdNxGawsFNiWAW4pJKv4UIBoZIJUctcq3Pl6ZwndPS98KAj+AHyPbrVCpP9e95vH3
	 9G4PDYBYiCYXw==
Date: Sat, 22 Feb 2025 15:50:59 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
CC: Linus Torvalds <torvalds@linux-foundation.org>,
        Ventura Jack <venturajack85@gmail.com>, Gary Guo <gary@garyguo.net>,
        airlied@gmail.com, boqun.feng@gmail.com, david.laight.linux@gmail.com,
        ej@inai.de, gregkh@linuxfoundation.org, hch@infradead.org,
        ksummit@lists.linux.dev, linux-kernel@vger.kernel.org,
        miguel.ojeda.sandonis@gmail.com, rust-for-linux@vger.kernel.org
Subject: Re: C aggregate passing (Rust kernel policy)
User-Agent: K-9 Mail for Android
In-Reply-To: <c3spwcoq7j4fx5yg4l7njeiofhkaasbknze3byh4dl45yeacvr@rb6u6j5kz7oe>
References: <CAFJgqgRygssuSya_HCdswguuj3nDf_sP9y2zq4GGrN1-d7RMRw@mail.gmail.com> <20250222141521.1fe24871@eugeo> <CAFJgqgSG4iZE12Yg6deX3_VYSOLxkm5yr5yu25HxN+y4wPD5bg@mail.gmail.com> <6pwjvkejyw2wjxobu6ffeyolkk2fppuuvyrzqpigchqzhclnhm@v5zhfpmirk2c> <CAHk-=wgq1DvgNVoodk7JKc6BuU1m9UnoN+k=TLtxCAL7xTP=Dg@mail.gmail.com> <yuwkqfbunlymofpd4kpqmzpiwbxxxupyj57tl5hblf7vsvebhm@ljz6u26eg5ft> <6EFFB41B-9145-496E-8217-07AF404BE695@zytor.com> <c3spwcoq7j4fx5yg4l7njeiofhkaasbknze3byh4dl45yeacvr@rb6u6j5kz7oe>
Message-ID: <B8A09E5A-D3A6-4A1F-94F6-9E301EE9BBE4@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On February 22, 2025 1:22:08 PM PST, Kent Overstreet <kent=2Eoverstreet@lin=
ux=2Edev> wrote:
>On Sat, Feb 22, 2025 at 12:54:31PM -0800, H=2E Peter Anvin wrote:
>> VLIW and OoO might seem orthogonal, but they aren't =E2=80=93 because t=
hey are
>> trying to solve the same problem, combining them either means the OoO
>> engine can't do a very good job because of false dependencies (if you
>> are scheduling molecules) or you have to break them instructions down
>> into atoms, at which point it is just a (often quite inefficient) RISC
>> encoding=2E In short, VLIW *might* make sense when you are statically
>> scheduling a known pipeline, but it is basically a dead end for
>> evolution =E2=80=93 so unless you can JIT your code for each new chip
>> generation=2E=2E=2E
>
>JITing for each chip generation would be a part of any serious new VLIW
>effort=2E It's plenty doable in the open source world and the gains are
>too big to ignore=2E
>
>> But OoO still is more powerful, because it can do *dynamic*
>> scheduling=2E A cache miss doesn't necessarily mean that you have to
>> stop the entire machine, for example=2E
>
>Power hungry and prone to information leaks, though=2E
>

I think I know a thing or two about JITting for VLIW=2E=2E  and so does so=
meone else in this thread ;)

