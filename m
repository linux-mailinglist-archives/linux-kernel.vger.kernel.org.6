Return-Path: <linux-kernel+bounces-215827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32BC990979C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 12:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B42861F22901
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 10:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA3D2E646;
	Sat, 15 Jun 2024 10:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="hHYIDjMl"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F41622067
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 10:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718446946; cv=none; b=X014Hyfogw1AzRxA8MRgnPRvIjKukS9MztlC5NEWPHqWDI3ydLw+vEt3kuH46KkGM4GCPBdvbCbgnnd7pnXWTfmR5RlXYASvlh5fDtwZzwEWoBAHkka9Sr02AilFxh3h4RCvNt5fUnKmzWTmEzD0TwF3omwWVGNnvRhv86JZtnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718446946; c=relaxed/simple;
	bh=z/4ct20fL6n/MSP4ly2WP3P4LEcvbuop2G7G6jjJf/E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GEfXydqLMbto/0QSIa5fXHjWc81rsYjSSSRvUlN+bf45KDdXL+onRAMVL4DeyC4PgsP1JQCBTfXgkshn7ZdJuP9fNdBD1pAizl6GbtUxyV+/VxN1pRfE3MVOfbViY/HZSKqRe3ze1O8r/lw86nifuGbCRldHeEqn5IDwcNjTpBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=hHYIDjMl; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1718446942;
	bh=z/4ct20fL6n/MSP4ly2WP3P4LEcvbuop2G7G6jjJf/E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=hHYIDjMltjAPz59GM8Br3E5JBrYEqOI381cFuAZphq7970tpxmbBOtvp24Q7QpIyw
	 EXXdF+8ruhJSipS1grNu6H/umgMMStm09ldVXbfbnJQWJ8zp56p14HU3s3tH+WJh6E
	 CSRz0B7EasGA8gA1Iyi6UxMiYsjJWX57Pciw5/Aw=
Received: from [192.168.124.13] (unknown [113.200.174.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id B9C1B674F4;
	Sat, 15 Jun 2024 06:22:17 -0400 (EDT)
Message-ID: <12099e6fb7ba377f3dcf6686e0b37200b9818708.camel@xry111.site>
Subject: Re: [PATCH] loongarch: Only select HAVE_OBJTOOL and allow ORC
 unwinder if the inline assembler supports R_LARCH_{32,64}_PCREL
From: Xi Ruoyao <xry111@xry111.site>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Jinyang He <hejinyang@loongson.cn>, Nathan Chancellor
 <nathan@kernel.org>,  Peter Zijlstra <peterz@infradead.org>, WANG Xuerui
 <kernel@xen0n.name>, Tiezhu Yang <yangtiezhu@loongson.cn>,  Nick
 Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>,  Youling Tang
 <tangyouling@kylinos.cn>, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org,  llvm@lists.linux.dev,
 mengqinggang@loongson.cn, cailulu@loongson.cn,  wanglei@loongson.cn,
 luweining@loongson.cn, Yujie Liu <yujie.liu@intel.com>,  Heng Qi
 <hengqi@linux.alibaba.com>, Tejun Heo <tj@kernel.org>
Date: Sat, 15 Jun 2024 18:22:14 +0800
In-Reply-To: <CAAhV-H7hhh3Jes0jMrg82+KJCa7GQZW=F9bDtktFh=eazMDX9w@mail.gmail.com>
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
	 <96a2e8a80c06772b64fcbdba42e1dae2d68a53a7.camel@xry111.site>
	 <2bd6ae20-ec56-c1a2-c5dd-e8c978a376d3@loongson.cn>
	 <329dac82e09dfc75e77ae93ebbeacdec1dc9ff7f.camel@xry111.site>
	 <CAAhV-H5Wz=U4kbX+tXt1qoCr6RaEDkzZXV7B=tgU_8o+X-NtVQ@mail.gmail.com>
	 <a97cd0f2e2cac10253d6b5cdd0ace3db3b220535.camel@xry111.site>
	 <CAAhV-H7hhh3Jes0jMrg82+KJCa7GQZW=F9bDtktFh=eazMDX9w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-06-15 at 17:33 +0800, Huacai Chen wrote:
> > To me for now we should just make OBJTOOL and ORC depend on BROKEN and
> > backport to stable...
> But this patch allows clang to build objtool, which seems broken, too.

Yes, so I mean make objtool depend on CONFIG_BROKEN because it is indeed
broken as at now.

Or we'll end up at least:

select HAVE_OBJTOOL if AS_HAS_EXPLICIT_RELOCS && AS_HAS_THIN_ADD_SUB && !CC=
_IS_CLANG && !RUST

this is already nasty and I still don't know if it covers all broken
cases (I've no idea if GCC will generate frame pointer in some cases as
well...)

> > Even if we can fix both the -mno-thin-add-sub problem and the frame
> > pointer problem in these weeks, they'll be some nontrivial large change
> > and improper to backport.=C2=A0 Thus we have to admit objtool doesn't r=
eally
> > work for old releases and mark it broken.
> I don't like to disable objtool, unless there is no better solution.
> And it seems there has already been some "large fix" in objtool's
> history.

Then we can still backport the large fix to the stable branches when we
finish it up.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

