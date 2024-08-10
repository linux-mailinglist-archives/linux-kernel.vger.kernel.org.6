Return-Path: <linux-kernel+bounces-281971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BEA894DDA3
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 18:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E46A528171C
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 16:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74DE139D04;
	Sat, 10 Aug 2024 16:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="jVdHZ4ph"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69036C8D1
	for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 16:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723308325; cv=none; b=CR4B7anwb8oqLJZfmxx1/A0AfSylTnkD+oZ/DP6tjMe7j1Bh+OUIrgWE1vv0Gx/TBOrKxBorn1D/TqhFlkpHZtW9TfTj6SmZAsL07PnmuTfiG1mhWlWXdxZBpYNff8QfHhgKTtk1lERlbP1bqr4j4sRTKyk+rwtiUINKG/XkDao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723308325; c=relaxed/simple;
	bh=0QQvNdqf9ih0oMQlqpiX7zYukO/vMUbEL2fi2ZTUNxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eTxLmpr5ubpxYwOsmCs22fZMlZE9EyuLHImw/CS5GqfSVlZ6MzeyqE9VgexH2LXlwJTw5AwVFLn1+GDA+29gvHxzfqqZCgUIdutas3SEhjVDX0/AtcSNEJhGmv2Wse8rdKMcf4ehMrpKE6xVz/yvuwyyNrfWrzqVcBEmCs1WbB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=jVdHZ4ph; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1723308320;
	bh=0QQvNdqf9ih0oMQlqpiX7zYukO/vMUbEL2fi2ZTUNxc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jVdHZ4phLE3TvD6RSaZ9IOuNSu/O8FiGTbGcp5cwVBPYRyhNd0iXmW3cW6J07kIcD
	 eKCRKejh+AxDEhUPBfq+++/bOvVlIuS+Mu+tXBoi/kwEx6nbpb6Lr+R00aBxwx9100
	 SE/Z6SQfvv1wJhS3HYYs1Q2t3d9eu+P2jqhtVp54=
Date: Sat, 10 Aug 2024 18:45:19 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>
Cc: Ammar Faizi <ammarfaizi2@gnuweeb.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] tools/nolibc: x86_64: wrap asm functions in functions
Message-ID: <17ed9bf5-64da-418e-b40e-6e3d40c67769@t-8ch.de>
References: <20240810-nolibc-lto-v1-0-a86e514c7fc1@weissschuh.net>
 <20240810-nolibc-lto-v1-3-a86e514c7fc1@weissschuh.net>
 <ZrdZKcQ1SClUHWa1@biznet-home.integral.gnuweeb.org>
 <121f58b7-b781-44cf-a18f-6f8893c82187@t-8ch.de>
 <20240810143556.GA9168@1wt.eu>
 <384a1d29-13ca-4e4b-b4b7-2a99e3fdb01b@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <384a1d29-13ca-4e4b-b4b7-2a99e3fdb01b@t-8ch.de>

On 2024-08-10 18:04:36+0000, Thomas Weißschuh wrote:
> On 2024-08-10 16:35:56+0000, Willy Tarreau wrote:

<snip>

> > Also I'm wondering why there are errors about memcpy and memmove being
> > already defined with -flto, because these ones are marked "weak". Maybe
> > we need to add something else, that gcc emits with the functions when
> > using lto ?
> 
> I think normally .weak would only be resolved by the linker.
> What happens here is that the assembler is already presented with
> duplicate definitions which it is not prepared to handle.
> (See below for an example)
> 
> It works on gcc without -flto and on clang with and without -flto.
> It seems like a compiler bug to me. If you agree I'll open a ticket
> against GCC.
> Then we can fix only the label to make it work on clang and wait for a
> fixed GCC.

Iff we really want to support it, we could do use naked where available
and fall back to toplevel asm otherwise.
This should work on newer compilers and older ones without -flto.
It looks horrible though.

  #define NOLIBC_ARCH_HAS_MEMSET
  void *memset(void *dst, int c, size_t len);
  
  #if __nolibc_has_attribute(naked)

  __attribute__((weak,naked))
  void *memset(void *dst __attribute__((unused)), int c __attribute__((unused)), size_t len __attribute__((unused))) {

  #else

  __asm__ (
  ".section .text.nolibc_memset\n"
  ".weak memset\n"
  "memset:\n"
  );

  #endif

  __asm__ (
  	"xchgl %eax, %esi\n\t"
  	"movq  %rdx, %rcx\n\t"
  	"pushq %rdi\n\t"
  	"rep stosb\n\t"
  	"popq  %rax\n\t"
  	"retq\n"
  );

  #if __nolibc_has_attribute(naked)
  }
  #endif

(Or some impenetrable macro wrapper abstraction thereof)

The memcpy / memmove combination could be split up into one real
function and one C inline wrapper and then the same pattern would apply.

But to be honest I'd be fine with not supporting -flto on GCC.


Thomas

