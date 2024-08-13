Return-Path: <linux-kernel+bounces-283932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 567CA94FA91
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 02:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB4551F2228B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 00:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451E0EC5;
	Tue, 13 Aug 2024 00:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnuweeb.org header.i=@gnuweeb.org header.b="G0EwOuxy"
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC5664C
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 00:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.81.211.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723508124; cv=none; b=gygtvUMkukPIu6FXkD+GBqhqWQg1JQtnCNBsE6V9+bTO2gSCus2YXXgGhty6E04bwBUxEFleWPrIc7Z2HVBR7vnsSQbU5HOCh6XI+KWmgjl0OmOmttgiFCRfWcuSokUq2DIla6JRTy8NpziTTNElkSYpTdiD1Yvwwwd3kne92YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723508124; c=relaxed/simple;
	bh=EPtnGP5+DlhvQP5KFRx0Ar2y4hV5LkFXfhqQaEhSMl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UBJ7clBFjK3O4Ne0JGhsoJep4uaPGdsRWDTRp7CMCviEwqeW8IkuSN5EZ/9nYDnH5uf5shnq2Z90Qi/YJIk5Lbto1UWDKdvweJMsZmGCu4s8iJLdzNcYySe5236CMbw3wV/yezUzO98HJ8fo+Lgj/Fmic5lCwvPq+NnlnlZy3T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gnuweeb.org; spf=pass smtp.mailfrom=gnuweeb.org; dkim=pass (2048-bit key) header.d=gnuweeb.org header.i=@gnuweeb.org header.b=G0EwOuxy; arc=none smtp.client-ip=51.81.211.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gnuweeb.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnuweeb.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
	s=default; t=1723508116;
	bh=EPtnGP5+DlhvQP5KFRx0Ar2y4hV5LkFXfhqQaEhSMl4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=G0EwOuxyk/um9tc2SchVwXRIHzhPxDvDChf7/qIIYw4ECC/DXumHANK6Oj/gxn812
	 CQ6oUoEedG5goXEaJCDtOqLBE0sI1QX/84TxMDvyxhYlDDXU5v4NyT6WpKNofFtyxE
	 t8P6O3z/PxuQaOggCFbAyUBaNfe1hzjeKAQyIMeVmd7Z1mMKCyrq9dvZieehvAfLNU
	 Ty396b1DUm+Sc2cTXwwbON1WgpFCFZ5VCMWMflYf+RMMWqSp3r/J5D84+FBKXoAsQF
	 0BuZYPOG21a4SLX1GvZPQiTDXN7rZcyYbk2VKtSjtLXVm6g2C1Ql6jJYtOjyflthZM
	 V5huLb7vTzaZA==
Received: from biznet-home.integral.gnuweeb.org (unknown [182.253.126.223])
	by gnuweeb.org (Postfix) with ESMTPSA id 5733E24D0A4;
	Tue, 13 Aug 2024 07:15:15 +0700 (WIB)
Date: Tue, 13 Aug 2024 07:15:11 +0700
From: Ammar Faizi <ammarfaizi2@gnuweeb.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Willy Tarreau <w@1wt.eu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] tools/nolibc: x86_64: use local label in
 memcpy/memmove
Message-ID: <Zrqlj5OHi6dFulxh@biznet-home.integral.gnuweeb.org>
References: <20240812-nolibc-lto-v2-0-736af7bbefa8@weissschuh.net>
 <20240812-nolibc-lto-v2-3-736af7bbefa8@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240812-nolibc-lto-v2-3-736af7bbefa8@weissschuh.net>
X-Bpl: hUx9VaHkTWcLO7S8CQCslj6OzqBx2hfLChRz45nPESx5VSB/xuJQVOKOB1zSXE3yc9ntP27bV1M1

On Mon, Aug 12, 2024 at 10:50:19PM +0200, Thomas Weiﬂschuh wrote:
> Compiling arch-x86_64.h with clang and binutils LD yields
> duplicate label errors:
> 
> .../gcc-13.2.0-nolibc/x86_64-linux/bin/x86_64-linux-ld: error: LLVM gold plugin: <inline asm>:44:1: symbol '.Lbackward_copy' is already defined
> .Lbackward_copy:leaq -1(%rdi, %rcx, 1), %rdi
> 
> Instead of a local symbol use a local label which can be defined
> multiple times and therefore avoids the error.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---

Reviewed-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>

-- 
Ammar Faizi


