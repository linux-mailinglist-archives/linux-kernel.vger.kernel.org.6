Return-Path: <linux-kernel+bounces-192599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0891E8D1F8F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 17:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BA82B22E5F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 15:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F8017165C;
	Tue, 28 May 2024 15:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="opoXfCNq"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0773717083F
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 15:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716908538; cv=none; b=tMgRDWzxkRsdQbGrJvJT3P5Sq8240lQI3fMNL+zVvPmiHKNIWEFAefj/eEfVcCje6eDq007EmXjcWpo6hqbQvHH5ACc/+QwTqADhfFhB6/vc2mSePyyaFd3AYcuF8Bpnyx6ok/GwKalssepfJGjEmkz4imcki/KvahwsL3AY7A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716908538; c=relaxed/simple;
	bh=5ZHpZGACX2Frn3dDPf3fXyWybxr2L7JiyfRf2W2/hW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vj82fLF2FirYHwl02ErILOtsbdoVgyU8um7mjZw8DjNEHu4nuUh8+h8Z8ac9zGFqkpP8IMhztoh4BxxkQJfVLCppzXDFW4BKcCpMIN3n18aODLuOeHQD9vDClTXXHHjsnMaPOJppjknOcYJgdIQJSyxSfLAhXRpK/dnkMAeZjWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=opoXfCNq; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: glider@google.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716908532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dKnPZ9OJHpypgolMUhUxX3o8dY3J/6CO95tM7cGqfv8=;
	b=opoXfCNqL0eaKrPq9sbb09xqDBlnVf51DlM6AdAAiU/XeLeu4KiMfvs8PGhdiophKkgpNx
	4GMqFrplyQMupkP+yleNmZRmTkTXWHz5B0AWJMb6bufOkv6bZSG3IUOYbdoG9kCJZwp3/z
	J71p/VMOEAsFEaZQ3BGiLIx0kDif3Xc=
X-Envelope-To: mathieu.desnoyers@efficios.com
X-Envelope-To: bfoster@redhat.com
X-Envelope-To: keescook@chromium.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: linux-bcachefs@vger.kernel.org
X-Envelope-To: elver@google.com
X-Envelope-To: dvyukov@google.com
X-Envelope-To: kasan-dev@googlegroups.com
X-Envelope-To: nathan@kernel.org
X-Envelope-To: ndesaulniers@google.com
X-Envelope-To: morbo@google.com
X-Envelope-To: justinstitt@google.com
X-Envelope-To: llvm@lists.linux.dev
Date: Tue, 28 May 2024 11:02:05 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Alexander Potapenko <glider@google.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Brian Foster <bfoster@redhat.com>, Kees Cook <keescook@chromium.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, linux-bcachefs@vger.kernel.org, Marco Elver <elver@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, llvm@lists.linux.dev
Subject: Re: Use of zero-length arrays in bcachefs structures inner fields
Message-ID: <63zx2cnrf5u2slmabde2wptxvq6a3opvrj2zrkcolw3gdkjdpf@bttdonbctura>
References: <986294ee-8bb1-4bf4-9f23-2bc25dbad561@efficios.com>
 <vu7w6if47tv3kwnbbbsdchu3wpsbkqlvlkvewtvjx5hkq57fya@rgl6bp33eizt>
 <944d79b5-177d-43ea-a130-25bd62fc787f@efficios.com>
 <7236a148-c513-4053-9778-0bce6657e358@efficios.com>
 <jqj6do7lodrrvpjmk6vlhasdigs23jkyvznniudhebcizstsn7@6cetkluh4ehl>
 <CAG_fn=Vp+WoxWw_aA9vr9yf_4qRvu1zqfLDWafR8J41Zd9tX5g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG_fn=Vp+WoxWw_aA9vr9yf_4qRvu1zqfLDWafR8J41Zd9tX5g@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, May 28, 2024 at 01:36:11PM +0200, Alexander Potapenko wrote:
> On Fri, May 24, 2024 at 7:30 PM Kent Overstreet
> <kent.overstreet@linux.dev> wrote:
> >
> > On Fri, May 24, 2024 at 12:04:11PM -0400, Mathieu Desnoyers wrote:
> > > On 2024-05-24 11:35, Mathieu Desnoyers wrote:
> > > > [ Adding clang/llvm and KMSAN maintainers/reviewers in CC. ]
> > > >
> > > > On 2024-05-24 11:28, Kent Overstreet wrote:
> > > > > On Thu, May 23, 2024 at 01:53:42PM -0400, Mathieu Desnoyers wrote:
> > > > > > Hi Kent,
> > > > > >
> > > > > > Looking around in the bcachefs code for possible causes of this KMSAN
> > > > > > bug report:
> > > > > >
> > > > > > https://lore.kernel.org/lkml/000000000000fd5e7006191f78dc@google.com/
> > > > > >
> > > > > > I notice the following pattern in the bcachefs structures: zero-length
> > > > > > arrays members are inserted in structures (not always at the end),
> > > > > > seemingly to achieve a result similar to what could be done with a
> > > > > > union:
> > > > > >
> > > > > > fs/bcachefs/bcachefs_format.h:
> > > > > >
> > > > > > struct bkey_packed {
> > > > > >          __u64           _data[0];
> > > > > >
> > > > > >          /* Size of combined key and value, in u64s */
> > > > > >          __u8            u64s;
> > > > > > [...]
> > > > > > };
> > > > > >
> > > > > > likewise:
> > > > > >
> > > > > > struct bkey_i {
> > > > > >          __u64                   _data[0];
> > > > > >
> > > > > >          struct bkey     k;
> > > > > >          struct bch_val  v;
> > > > > > };
> 
> I took a glance at the LLVM IR for fs/bcachefs/bset.c, and it defines
> struct bkey_packed and bkey_i as:
> 
>     %struct.bkey_packed = type { [0 x i64], i8, i8, i8, [0 x i8], [37 x i8] }
>     %struct.bkey_i = type { [0 x i64], %struct.bkey, %struct.bch_val }
> 
> , which more or less looks as expected, so I don't think it could be
> causing problems with KMSAN right now.
> Moreover, there are cases in e.g. include/linux/skbuff.h where
> zero-length arrays are used for the same purpose, and KMSAN handles
> them just fine.
> 
> Yet I want to point out that even GCC discourages the use of
> zero-length arrays in the middle of a struct:
> https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html, so Clang is not
> unique here.
> 
> Regarding the original KMSAN bug, as noted in
> https://lore.kernel.org/all/0000000000009f9447061833d477@google.com/T/,
> we might be missing the event of copying data from the disk to
> bcachefs structs.
> I'd appreciate help from someone knowledgeable about how disk I/O is
> implemented in the kernel.

If that was missing I'd expect everything to be breaking. What's the
helper that marks memory as initialized?

