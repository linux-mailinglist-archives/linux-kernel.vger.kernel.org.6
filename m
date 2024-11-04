Return-Path: <linux-kernel+bounces-395459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 063859BBE29
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 20:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D8E4B216DC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 19:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E40E1CC893;
	Mon,  4 Nov 2024 19:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="n8PZ+lvd"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF9A1CBA1A;
	Mon,  4 Nov 2024 19:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730749288; cv=none; b=Vt61ZEXV2mqJ0e53wQLknnKjA5b6GEFazVdJGfww0dXlbz6gY8j2wttdXNSHPozQoZ+AZdvhnKeEF9vqzVb/34nMadozlX7ZZKV4yyDXgvhekhPQSFwJpnrx/CG88ajeTuS38GpVZrQY86LKNi6+2zHqXQA2RBYx2g4vN9NKerg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730749288; c=relaxed/simple;
	bh=TlfnKi73QV/9wCkfGcRyEygU9J9eNazH15v8tXAdF3o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ng+g82yYvyri0RFi4arkDKQuoBB8YNxkDIo5j+PVPPDciwgQ6ryFNJyTZl9PtbNXZdx9hr16WGWcvD7Dj+bdyM5dWZWVilE2/rrP5gVaD8w6MhUu6LQNdg8kMAC8OvBhEv8VTBaUl2LmTSL2lyYqW85KP+UKzLZGT1dNtmVPFjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=n8PZ+lvd; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 479A142C30
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1730749286; bh=/IFed8QuxmGzZBbHkfBNbEfyJ1RoaIBovaPG1f0VPG8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=n8PZ+lvdV9S8DRrV5uughGMOtaA9H3oWENpGvlYt/sC2JQoufU1tcxY54Ptc9v2tC
	 GZtZM7inLdMb3Yg6hJr21LWAY5u/TYR1V1M6N1BZY2JeX9pA5Rh22sWTTP11xVydlV
	 L7aqqZFthR/iVCvg+akLG1EMYJDr6AW0o1X4BsrOEOZkeVwA3GsWdm8ywJvgXzrxTr
	 8KUmLUeJrUFWIT5li55End9O/KFWWamMROt8jQEW913d5F3fFqJ4B0dhJS6qa0namB
	 gziO8YJDsdCDAuzVKp0LxwQQMp79ykXyEG6y1/rg0UiUVae33IF2xZ8VT1JDZUuraP
	 XHhzFLoqK0O/A==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 479A142C30;
	Mon,  4 Nov 2024 19:41:26 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Dongliang Mu <dzm91@hust.edu.cn>, si.yanteng@linux.dev, Alex Shi
 <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>, Dongliang Mu <dzm91@hust.edu.cn>
Cc: hust-os-kernel-patches@googlegroups.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 llvm@lists.linux.dev
Subject: Re: [PATCH] docs/zh_CN: add the translation of kbuild/llvm.rst
In-Reply-To: <20241023153235.1291567-1-dzm91@hust.edu.cn>
References: <20241023153235.1291567-1-dzm91@hust.edu.cn>
Date: Mon, 04 Nov 2024 12:41:25 -0700
Message-ID: <87wmhi7pne.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dongliang Mu <dzm91@hust.edu.cn> writes:

> Finish the translation of kbuild/llvm.rst and move llvm from TODO
> to the main body.
>
> Update to commit 145082ebfcf0 ("Documentation/llvm: turn make command
> for ccache into code block")
>
> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
> ---
>  .../translations/zh_CN/kbuild/index.rst       |   3 +-
>  .../translations/zh_CN/kbuild/llvm.rst        | 203 ++++++++++++++++++
>  2 files changed, 205 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/translations/zh_CN/kbuild/llvm.rst

Applied, thanks.

jon

