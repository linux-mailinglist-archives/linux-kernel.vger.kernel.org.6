Return-Path: <linux-kernel+bounces-205421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADCF48FFB60
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 07:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14403B225D3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 05:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F81821A1C;
	Fri,  7 Jun 2024 05:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="WM59gHdA"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904ECD2FE
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 05:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717738994; cv=none; b=KRCOC8HaJVVbdCOKZ/uaQNQQpQXAQcdRKDCw6v46bmENdPCzSkYLUU4cO0LklUIgahTqoM0vZkHuTt4feXRJH8Wg7AltauLCqrXWBYMZwrHQKFCxzfrDYGAcoccISetM/HHLaXc49Yo9dVjOOPQjq7oKhsIYKYrJHJoczMF24bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717738994; c=relaxed/simple;
	bh=L90KvPb0Tm3KLZRT4+hpjIxgY+M3OEtcQDcEh/vAzxk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YMsvaG9vrK7MXnforOc1+kGSzMarPNS6WO9njmwmowzb6R3fGht5N8X+3m5pzbSTAw7xQ6Qgxw+BsRl0dL14F5vVzSZMrlaWszXJgc3ZHzPDiTfLMKLlN6/N3jsqCKBaVDx+EqP0Zj51Ig/j+yeiBGhSCbZJESeedvc0CEJBnkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=WM59gHdA; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1717738977;
	bh=L90KvPb0Tm3KLZRT4+hpjIxgY+M3OEtcQDcEh/vAzxk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=WM59gHdAAZ5b+Abw4UPENNb4iCodOsByf7TjH/w4eFjZu2zgDipbXips76zQBQznE
	 elgqXYrmLYJzQbENUcPJosaEgXJmQcJBTKcfew7xOhbuqiBxVDAzzxj0a33pH3Osie
	 8DGt8y8622rDzYcdkHf0m2NxmnGqOHlwvc84WycM=
Received: from [IPv6:240e:358:11b5:b400:dc73:854d:832e:6] (unknown [IPv6:240e:358:11b5:b400:dc73:854d:832e:6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 6A30166A5B;
	Fri,  7 Jun 2024 01:42:48 -0400 (EDT)
Message-ID: <96a2e8a80c06772b64fcbdba42e1dae2d68a53a7.camel@xry111.site>
Subject: Re: [PATCH] loongarch: Only select HAVE_OBJTOOL and allow ORC
 unwinder if the inline assembler supports R_LARCH_{32,64}_PCREL
From: Xi Ruoyao <xry111@xry111.site>
To: Jinyang He <hejinyang@loongson.cn>, Nathan Chancellor
 <nathan@kernel.org>,  Peter Zijlstra <peterz@infradead.org>
Cc: Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Tiezhu Yang <yangtiezhu@loongson.cn>, Nick Desaulniers
 <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, Justin Stitt
 <justinstitt@google.com>, Youling Tang <tangyouling@kylinos.cn>,
 loongarch@lists.linux.dev,  linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, mengqinggang@loongson.cn,  cailulu@loongson.cn,
 wanglei@loongson.cn, luweining@loongson.cn, Yujie Liu
 <yujie.liu@intel.com>, Heng Qi <hengqi@linux.alibaba.com>, Tejun Heo
 <tj@kernel.org>
Date: Fri, 07 Jun 2024 13:42:41 +0800
In-Reply-To: <2bf11cd2-8449-acda-f5ad-659c38cb018e@loongson.cn>
References: <20240604150741.30252-1-xry111@xry111.site>
	 <20240605054328.GA279426@thelio-3990X>
	 <b55b8cb2c52f2c3701c83353586130b8dc237ee2.camel@xry111.site>
	 <20240605062548.GF279426@thelio-3990X>
	 <f8ef61773b0119b8573fc0fed9ad0a8b43061efd.camel@xry111.site>
	 <444ec2031ef6ca016cbfa8dfedc51bddc8529ba7.camel@xry111.site>
	 <ada035690e446909c3cdbf9a43a92def96020615.camel@xry111.site>
	 <82b7e6ea-c2cb-6364-ebe9-bff928028408@loongson.cn>
	 <1c132209a612e2e8953f0b458fc01853120db9a9.camel@xry111.site>
	 <2bf11cd2-8449-acda-f5ad-659c38cb018e@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-06-06 at 10:10 +0800, Jinyang He wrote:
> What I just confused is that there is no ".cfi_*"
> in the eplogue by clang, which may cause wrong backtrace if gdb set
>=20
> breakpoint there and backtrace. (But this is out of this topic.)

I don't think it'll cause wrong backtrace.  The real assemble code has
restored the registers and missing .cfi_restore will just make unwinder
restore them again.  There are redundant works but not breakages.

For objtool the main difference seems a thing explained in
https://maskray.me/blog/2020-11-08-stack-unwinding by Fangrui:

   Note: on RISC-V and LoongArch, the stack slot for the previous frame
   pointer is stored at fp[-2] instead of fp[0]. See [Consider
   standardising which stack slot fp points
   to](https://github.com/riscv-non-isa/riscv-elf-psabi-doc/issues/18)
   for the RISC-V discussion.

So perhaps we just need to code a constant named "PREV_BP_OFFSET" or
something in arch/ and use it in update_cfi_state() instead of fully re-
implement the entire function?
--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

