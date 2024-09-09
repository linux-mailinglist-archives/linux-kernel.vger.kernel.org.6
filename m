Return-Path: <linux-kernel+bounces-322124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD1897246D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 23:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E9CD1C23297
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 21:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247CD18C352;
	Mon,  9 Sep 2024 21:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fKFgOkTM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4BD178CC8;
	Mon,  9 Sep 2024 21:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725916745; cv=none; b=Upm5iy9vIy9qHwDvJxd/p6OGxySLiV1ypYggILnJvogM3I5QqPPhG1bbIjzS++gX1QRuNoJ6VCFjuGm+0EYKFOIX/lLJJQlB0CHSajVckkL1XdhoBx93WEFOGXvE1JeznL9R80CL6CC0M1oUslBvXIoxJj3/SvsorYiS+DVqsoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725916745; c=relaxed/simple;
	bh=fi/PTNm06HMFkbgUnJfbIiRFbs/hwBx+wMXFqX/yviw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UiYnl8Wk2JLKL+Phv+qhjbNhmwKwhMyNzaNeySqL/AtI7zTitZocUr3wOQ2ifC71YYx41xL0eiriLpNg24TPgjgyJJNegUl1jfzOeOj7GcXXvhjH7YqgsShdMnoPulbqUVSeGvHy80JFTLd7cLRqSD04zKzt8WSibZv4/vSz19g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fKFgOkTM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB422C4CEC5;
	Mon,  9 Sep 2024 21:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725916745;
	bh=fi/PTNm06HMFkbgUnJfbIiRFbs/hwBx+wMXFqX/yviw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fKFgOkTMxBg237SMXKoJ+vALVZbFVktr2V228pW3szmQjySeOWciJPcABHNvHtcUT
	 gwiVGkonvA5f+rYaufIfsDOxRU2Gu4LSq9UQ2AqQI6yJCcLHRc4Z7aqdSdjkJ/yRBK
	 DpvSefrRzuSTQ/OQ7oyb5Lxh8eL1IYB1vbljUDlzz2+d4vZ0PhRyhPbb74n0vyyJhW
	 SVGzoYPp2Hv93TDCdj/rZ0Hrvkd2eW+6TLB1r0IytKFzpb487aznLpvK1l9nGG5xaS
	 GqJLIVz6G3CeUr8Ryta2oEeaedxgQzbhog+6chSJLWY1fW+OaBTzWovuv2941EJIHf
	 42aNlHfp3FsQA==
Date: Mon, 9 Sep 2024 14:19:02 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Song Liu <song@kernel.org>
Cc: live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Jiri Kosina <jikos@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: Re: [RFC 00/31] objtool, livepatch: Livepatch module generation
Message-ID: <20240909211902.3tvzxp6wryqvbbhr@treble>
References: <cover.1725334260.git.jpoimboe@kernel.org>
 <CAPhsuW6V-Scxv0yqyxmGW7e5XHmkSsHuSCdQ2qfKVbHpqu92xg@mail.gmail.com>
 <20240907064656.bkefak6jqpwxffze@treble>
 <CAPhsuW4hNABZRWiUrWzA6kbiiU1+LpnsSCaor=Wi8hrCzHwONQ@mail.gmail.com>
 <20240907201445.pzdgxcmqwusipwzh@treble>
 <CAPhsuW4TyQSSnAR70cE8FChkkqX-3jFAP=GKS7cuaLSNxz00MA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPhsuW4TyQSSnAR70cE8FChkkqX-3jFAP=GKS7cuaLSNxz00MA@mail.gmail.com>

On Sat, Sep 07, 2024 at 10:04:25PM -0700, Song Liu wrote:
> I think gcc doesn't complain, but clang does:
> 
> $ cat ttt.c
> static inline void ret(void)
> {
>   return;
> }
> 
> int main(void)
> {
>   return 0;
> }

Ah...  That's probably why the kernel adds "__maybe_unused" to its
inline macro (which the tools don't have).

Does this fix?

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index d1740a724eb2..74fec9f97339 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -100,7 +100,7 @@ static inline unsigned long __sym_last(struct symbol *s)
 }
 
 INTERVAL_TREE_DEFINE(struct symbol, node, unsigned long, __subtree_last,
-		     __sym_start, __sym_last, static inline,
+		     __sym_start, __sym_last, static inline __maybe_unused,
 		     __sym)
 
 #define __sym_for_each(_iter, _tree, _start, _end)			\

