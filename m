Return-Path: <linux-kernel+bounces-283789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED1194F8B1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 23:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DDCD1F22BDE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 21:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18AB61537BB;
	Mon, 12 Aug 2024 21:00:48 +0000 (UTC)
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1715A139597
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 21:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723496447; cv=none; b=qGtwaG8stCv20IeQIT40L1La3FslGKlhgkJlBmM47dGzl3NfvTLUKDuFarjjKAo3BZ64zxG3F2I5oUkLOy6rXbpnX/fgekU25gdQEWXHuE2Xgz6lDZu1x8OU6GArKSnloJQqG/xFwwHQXteqv6+ONqgo8T4Qlet0bDEfzDTtcjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723496447; c=relaxed/simple;
	bh=T0rguNq3/opMSkH8cn5aiQlOYKHFretvgGh0Gaj3u+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LlD7moG86wQdcJAN/C2C11ZY3WYJv14W2qL6WG0niwcUOEQAklDUqkwYLyKweUbknI4Ek2Vk84gXgt8fn9Wk5+hvdzwGL5dJqHX8vbFwG8x7chzCBGQb5WPr6fAyUh7/VKfhVPnEaJ09r2YivlvIeV/DtnIZXdLrKp/zhLJfBCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 47CL0dJT009640;
	Mon, 12 Aug 2024 23:00:39 +0200
Date: Mon, 12 Aug 2024 23:00:39 +0200
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Ammar Faizi <ammarfaizi2@gnuweeb.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] tools/nolibc: clang LTO compatibility
Message-ID: <20240812210039.GA9624@1wt.eu>
References: <20240812-nolibc-lto-v2-0-736af7bbefa8@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240812-nolibc-lto-v2-0-736af7bbefa8@weissschuh.net>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Aug 12, 2024 at 10:50:16PM +0200, Thomas Weiﬂschuh wrote:
> A few tiny bugfixes and refactoring to provide compatibility with
> clangs -flto.
> 
> $ CFLAGS_EXTRA=-flto ./run-tests.sh -m user -l       
> i386:          195 test(s): 193 passed,   2 skipped,   0 failed => status: warning
> x86_64:        195 test(s): 193 passed,   2 skipped,   0 failed => status: warning
> arm64:         195 test(s): 193 passed,   2 skipped,   0 failed => status: warning
> arm:           195 test(s): 193 passed,   2 skipped,   0 failed => status: warning
> mips32le:      195 test(s): 192 passed,   3 skipped,   0 failed => status: warning
> mips32be:      195 test(s): 192 passed,   3 skipped,   0 failed => status: warning
> ppc:           195 test(s): 192 passed,   3 skipped,   0 failed => status: warning
> ppc64:         195 test(s): 192 passed,   3 skipped,   0 failed => status: warning
> ppc64le:       195 test(s): 192 passed,   3 skipped,   0 failed => status: warning
> riscv:         195 test(s): 192 passed,   3 skipped,   0 failed => status: warning
> s390:          195 test(s): 192 passed,   3 skipped,   0 failed => status: warning
> loongarch:     195 test(s): 192 passed,   3 skipped,   0 failed => status: warning
> 
> GCC is not supported, for details read the discussion in v1 of the
> series.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
> Changes in v2:
> - Drop GCC support
> - arch-x86_64.h: Don't try to wrap the asm functions in C functions,
>   Instead just replace the local symbol with a local label.
> - Link to v1: https://lore.kernel.org/r/20240810-nolibc-lto-v1-0-a86e514c7fc1@weissschuh.net

For the whole series:

Acked-by: Willy Tarreau <w@1wt.eu>

Thanks Thoams!
Willy

