Return-Path: <linux-kernel+bounces-524026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A85C5A3DE58
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 046BD7A45F6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5671FDA94;
	Thu, 20 Feb 2025 15:17:13 +0000 (UTC)
Received: from a3.inai.de (a3.inai.de [144.76.212.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06ECE1FCCFF;
	Thu, 20 Feb 2025 15:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.212.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740064632; cv=none; b=VlwmPmwuM5EQB/WSma4ZwML2mdVTEdCLFDQqRFNMvLZZt/KX5ENged0vXeWofTPwOUROfpkzDHqq4LpwmPxpnlBIAw0VqiPGVEC9Anir/0hCnbFHa5oiBtb+MUXwBO9vH9Ww/iatm9eYP34Fu/b2OZ+LDXEAlWkTfoiLgh2Yd/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740064632; c=relaxed/simple;
	bh=v+zkuUk8OESiitfztpae1TwbIUwd5PHIth0crqqdQ1w=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=K6ZEPuKaLpNzVM58nIl5sup02Bj/4BaeFddhU+BCwcX2vjjpKLjMG+we5q9PIXPV8BcSMOdv7NboNCV6j2yHmaQybNWvXa4JdMqs1vt6mErIIN+W2JXQcrtHLjZPUlxnanMAPTH4SZi0sfEGbckWAKiJ2mHDhNgc9e/uFjuqhNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inai.de; spf=fail smtp.mailfrom=inai.de; arc=none smtp.client-ip=144.76.212.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inai.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=inai.de
Received: by a3.inai.de (Postfix, from userid 25121)
	id D096B1003C0D53; Thu, 20 Feb 2025 16:17:07 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by a3.inai.de (Postfix) with ESMTP id CEBC61100B0CC0;
	Thu, 20 Feb 2025 16:17:07 +0100 (CET)
Date: Thu, 20 Feb 2025 16:17:07 +0100 (CET)
From: Jan Engelhardt <ej@inai.de>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: Greg KH <gregkh@linuxfoundation.org>, Boqun Feng <boqun.feng@gmail.com>, 
    Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
    Christoph Hellwig <hch@infradead.org>, 
    rust-for-linux <rust-for-linux@vger.kernel.org>, 
    Linus Torvalds <torvalds@linux-foundation.org>, 
    David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org, 
    ksummit@lists.linux.dev
Subject: Re: C aggregate passing (Rust kernel policy)
In-Reply-To: <9B01858A-7EBD-4570-AC51-3F66B2B1E868@zytor.com>
Message-ID: <n05p910s-r5o3-0n36-5s44-qr769prp69r5@vanv.qr>
References: <CANiq72m-R0tOakf=j7BZ78jDHdy=9-fvZbAT8j91Je2Bxy0sFg@mail.gmail.com> <Z7SwcnUzjZYfuJ4-@infradead.org> <CANiq72myjaA3Yyw_yyJ+uvUrZQcSLY_jNp65iKH8Y5xGY5tXPQ@mail.gmail.com> <326CC09B-8565-4443-ACC5-045092260677@zytor.com>
 <CANiq72m+r1BZVdVHn2k8XeU37ZeY6VT2S9KswMuFA=ZO3e4uvQ@mail.gmail.com> <a7c5973a-497c-4f31-a7be-b3123bddb6dd@zytor.com> <Z7VKW3eul-kGaIT2@Mac.home> <2025021954-flaccid-pucker-f7d9@gregkh> <2nn05osp-9538-11n6-5650-p87s31pnnqn0@vanv.qr> <2025022052-ferment-vice-a30b@gregkh>
 <9B01858A-7EBD-4570-AC51-3F66B2B1E868@zytor.com>
User-Agent: Alpine 2.26 (LSU 649 2022-06-02)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII


On Thursday 2025-02-20 14:23, H. Peter Anvin wrote:
>
>People writing C seem to have a real aversion for using structures
>as values (arguments, return values or assignments) even though that
>has been valid since at least C90 and can genuinely produce better
>code in some cases.

The aversion stems from compilers producing "worse" ASM to this
date, as in this case for example:

```c
#include <sys/stat.h>
extern struct stat fff();
struct stat __attribute__((noinline)) fff()
{
        struct stat sb = {};
        stat(".", &sb);
        return sb;
}
```

Build as C++ and C and compare.

$ g++-15 -std=c++23 -O2 -x c++ -c x.c && objdump -Mintel -d x.o
$ gcc-15 -std=c23 -O2 -c x.c && objdump -Mintel -d x.o

Returning aggregates in C++ is often implemented with a secret extra
pointer argument passed to the function. The C backend does not
perform that kind of transformation automatically. I surmise ABI reasons.

