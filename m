Return-Path: <linux-kernel+bounces-251678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2838493080B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 01:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D27311F216DF
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 23:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50C8157A43;
	Sat, 13 Jul 2024 23:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bT496ZBW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBE613E88B;
	Sat, 13 Jul 2024 23:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720913228; cv=none; b=Di8HB7R9/DG7STIljVnI96bVHA41b1yKZJp6IcPHmuDRDvX/plL1PGJj5cG7pNiDFFPbZXb4G9AVwRg1s+1j3jPRJgDfaAk6AiSABlJNHh906zNpRyJw2TVP+xc9Z1KyAiAhXeEUa36KFDWHfT3XFiiu4RwiSwC5OFuJGRjh7fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720913228; c=relaxed/simple;
	bh=kpufdiNixm1YTtmaSnk2ctW+hG8JR73L/Ok4Iyu6ngY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zo5AGCHepJY6SbZm+41aHjGPPbX7yGAnWTo7mnlDArd3Yo6T9PNSGv2zL9qdyjGtGmXgLx2N9/B1JQnPeIocDCYTJC5Clq0ZZ2Ki9NHMeOehNzkMqHfsX+O0aiVAEOkpcvq+1OmDygfJY2jEi7WUkjqjZ0P+k8L6xtTzOI14Py8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bT496ZBW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17EECC32781;
	Sat, 13 Jul 2024 23:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720913227;
	bh=kpufdiNixm1YTtmaSnk2ctW+hG8JR73L/Ok4Iyu6ngY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bT496ZBW6kPfaIMUYXIIcFQ50Cq8pAxzZdXtZ0w9TJXxFfvQjM4R/nYVA6dPQjiWr
	 LhY0JuzO1EkyPiObRhkqPRAYn0QF3BD8phGrsD8pBQ3zVEDehCAzrFV3FmHAMkl6It
	 uZKlzWTtrH6X/6/k54tAExB6Yra8Qd/7lqyO11SpYYbtjO/bV1ErcWiDchyZDq4xTu
	 MPpGccxpQQNxZ9lS6dsNF8QGvdAMhWDpTcxhRzXPO6pU+1Gq8UHWUbF3hwHAXX2S5Z
	 XWOqDk3cW6Sjaumh95XO4AKuF/MDlVcdDBXNsAVxk/ECfco/Y6jJfh8fDcom+GVUUD
	 mESMmn4HjDwJA==
Date: Sat, 13 Jul 2024 16:27:05 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Yury Norov <yury.norov@gmail.com>, llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org, Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v2] bitmap: Switch from inline to __always_inline
Message-ID: <20240713232705.GA443207@thelio-3990X>
References: <20240711163732.1837271-1-briannorris@chromium.org>
 <ZpFhv5VSYZ6jnsd4@yury-ThinkPad>
 <ZpGVLl7NQZScd8aH@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpGVLl7NQZScd8aH@google.com>

Hi Brian,

On Fri, Jul 12, 2024 at 01:42:22PM -0700, Brian Norris wrote:
> But agreed, I can get a larger matrix with a bit more specifity in my
> commit log. TBD on the ease of getting a Clang 13 or GCC 9 toolchain,
> but I think I can convince my distro to provide them.

In case you have not seen them already, there are GCC and LLVM
toolchains available on kernel.org to make doing this type of testing
easier:

https://mirrors.edge.kernel.org/pub/tools/crosstool
https://mirrors.edge.kernel.org/pub/tools/llvm

Then use either

  CROSS_COMPILE=<install_prefix>/bin/x86_64-linux-

or

  LLVM=<install_prefix>/bin/

when building your kernels. If you have any issues with them, just let
me know and I'll try to help out.

Cheers,
Nathan

