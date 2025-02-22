Return-Path: <linux-kernel+bounces-527518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5C0A40C3C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 00:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2D377ABFE9
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 23:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38725204F6F;
	Sat, 22 Feb 2025 23:56:33 +0000 (UTC)
Received: from a3.inai.de (a3.inai.de [144.76.212.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BF9201266;
	Sat, 22 Feb 2025 23:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.212.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740268592; cv=none; b=RLUdMpqCQVNLrNdVtDwkdM6De+mErrWGVi5ZEsiJ9/ru8f6hJs3CQFR+P+Hl4Us4fnFy2XBJbDGpafeko/PV9gvaZxM4Xz1BESPjQqvVijDvMZR76e9HcMdQE2dNrQDqX5tkhkpETLAbXjzf7DzGuO8fV/0FO66biBaRQeGM3lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740268592; c=relaxed/simple;
	bh=9ABD/FEpOYYbzq3lpPi/WIdZDVwo0SQr5BKiQasBGjo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=qEv+PO9+2ORCUn0zlA7COMZkgXwSnzI4eis5Mz3SlWB9urj/sBnXtK8IWdYqfecLWaNqk1nXvo75fn/SyDAuwyhP5KjFqS39x9eXQEDyjUC+pGHqRaxWujIdz9eY1n9eOCEal4b5J9TWEajwci+gh3OTrBQibJhxE1qzvI79fIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inai.de; spf=fail smtp.mailfrom=inai.de; arc=none smtp.client-ip=144.76.212.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inai.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=inai.de
Received: by a3.inai.de (Postfix, from userid 25121)
	id 6647B100485918; Sun, 23 Feb 2025 00:56:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by a3.inai.de (Postfix) with ESMTP id 65E5C1100AFC34;
	Sun, 23 Feb 2025 00:56:22 +0100 (CET)
Date: Sun, 23 Feb 2025 00:56:22 +0100 (CET)
From: Jan Engelhardt <ej@inai.de>
To: Kent Overstreet <kent.overstreet@linux.dev>
cc: Linus Torvalds <torvalds@linux-foundation.org>, 
    "H. Peter Anvin" <hpa@zytor.com>, Ventura Jack <venturajack85@gmail.com>, 
    Gary Guo <gary@garyguo.net>, airlied@gmail.com, boqun.feng@gmail.com, 
    david.laight.linux@gmail.com, gregkh@linuxfoundation.org, 
    hch@infradead.org, ksummit@lists.linux.dev, linux-kernel@vger.kernel.org, 
    miguel.ojeda.sandonis@gmail.com, rust-for-linux@vger.kernel.org
Subject: Re: C aggregate passing (Rust kernel policy)
In-Reply-To: <ngxypsinp2xnhc3yhg57c4sram5i6vbophgjakoyk32yb3sabs@dg6ne6jbuale>
Message-ID: <09rq8307-0431-2610-8920-p6rnsosr0n7o@vanv.qr>
References: <CAFJgqgRygssuSya_HCdswguuj3nDf_sP9y2zq4GGrN1-d7RMRw@mail.gmail.com> <20250222141521.1fe24871@eugeo> <CAFJgqgSG4iZE12Yg6deX3_VYSOLxkm5yr5yu25HxN+y4wPD5bg@mail.gmail.com> <6pwjvkejyw2wjxobu6ffeyolkk2fppuuvyrzqpigchqzhclnhm@v5zhfpmirk2c>
 <CAHk-=wgq1DvgNVoodk7JKc6BuU1m9UnoN+k=TLtxCAL7xTP=Dg@mail.gmail.com> <yuwkqfbunlymofpd4kpqmzpiwbxxxupyj57tl5hblf7vsvebhm@ljz6u26eg5ft> <6EFFB41B-9145-496E-8217-07AF404BE695@zytor.com> <c3spwcoq7j4fx5yg4l7njeiofhkaasbknze3byh4dl45yeacvr@rb6u6j5kz7oe>
 <CAHk-=wi0UmOAhyDjOeCJcL7eEt+ygKnMqtx+RcHtzZGd7OY4Kw@mail.gmail.com> <ngxypsinp2xnhc3yhg57c4sram5i6vbophgjakoyk32yb3sabs@dg6ne6jbuale>
User-Agent: Alpine 2.26 (LSU 649 2022-06-02)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII


On Saturday 2025-02-22 23:34, Kent Overstreet wrote:
>
>> The VLIW people have proclaimed the same efficiency advantages for
>> decades. I know. I was there (with Peter ;), and we tried. We were
>> very very wrong.
>
>If we ever get a chance I want to hear stories :)

The story is probably about Transmeta CPUs. The TM5x00 has some VLIW
design, and for "backwards compatibility" has microcode to translate
x86 asm into its internal representation (sounds like what every OOO
CPU having microops is doing these days).

