Return-Path: <linux-kernel+bounces-353930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BCA993498
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 19:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DAB51F2494F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 17:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E221DD536;
	Mon,  7 Oct 2024 17:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="c1IXQdZ7"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876F84206B;
	Mon,  7 Oct 2024 17:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728321383; cv=none; b=T04N09YMj8QW6n/anuQy9DUOPtsQXm3NfJsm3sjdPpHaTmu5AVe2Fbn8QRis299eiIGyvefnXfgOXXKnlUbeDY2IFq/a8caLvQ//en+Cec4NeWZKxXiA0Hkf1dZ7omDzh65DeThuFrIqabigxoNmnZLOcxLGFVfGyIOJXJR+KiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728321383; c=relaxed/simple;
	bh=CniX1cx7M1vGsPsPWMs6+B7FzHXU+prUUDK3W0pB53o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jTQiqXoT/0cuyJbM7uAi6cUTetss5NuCdy1KlYDH4/LyyyAYBK41cqMIifu5u4dXMBfjz7Bg3HFPQNKuTEyjnN7C3Phrqc7EWtdLo8nnyusnhEEjI5OfqTYJQkrMrq4PTb6IPPSsihpw9vw4lK/U8lHrZVyNav2CuaP13+5lZHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=c1IXQdZ7; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net AF17B42B38
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1728321381; bh=RqT6aehZHZFeYR2cjNnWIgOZ+bE1Xkjzgc5OKkRND6A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=c1IXQdZ7MmPFJEhiFl7cJMUPnLfEmZbUtXvtB7mV0++ZqPvvfsOgVMQeRhibTntB4
	 arOuAp7/pTEuQ/pYJb1Rcpi/Cy58Agk7UU/j8NswFIt8PU5YmPv3FHgVvCgIdp8GC/
	 80qN5xTCZXdN5oUZTzQSYNxx6+euoHasFPsOdlTBDMgA7+foCf1GojJljL0LqNHJ4r
	 iVbsn7JbXi18U5z9O2+NdNcxeCH62kaH1q/1AAv1cRvYUjCxPgFvcrVt+owDQ9vwdI
	 gx4U5LulEt6TJnRfgLY5R1Jdb+Ro2LbK9Z2KbXekzZkeA13ZMGxvyRH/23Jbi6aT7b
	 Uya+67ZuNJlcA==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id AF17B42B38;
	Mon,  7 Oct 2024 17:16:21 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev,
 Peter Oberparleiter <oberpar@linux.ibm.com>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)"
 <matttbe@kernel.org>
Subject: Re: [PATCH doc] docs: gcov: fix link to LCOV website
In-Reply-To: <20240926-doc-fix-lcov-link-v1-1-46f250cb7173@kernel.org>
References: <20240926-doc-fix-lcov-link-v1-1-46f250cb7173@kernel.org>
Date: Mon, 07 Oct 2024 11:16:20 -0600
Message-ID: <871q0rkf4r.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Matthieu Baerts (NGI0)" <matttbe@kernel.org> writes:

> The previous website hosted on SourceForge is no longer available since
> January 2024 according to archive.org [1].
>
> It looks like the website has been officially moved to GitHub in June
> 2022 [2]. Best to redirect readers to the new location then.
>
> Link: https://web.archive.org/web/20240105235756/https://ltp.sourceforge.net/coverage/lcov.php [1]
> Link: https://github.com/linux-test-project/lcov/commit/6da8399c7a7a [2]
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  Documentation/dev-tools/gcov.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/dev-tools/gcov.rst b/Documentation/dev-tools/gcov.rst
> index 5fce2b06f22954c3ac6e7d7118064f015624c4a9..53a85ffebcea9fc99484296c5193df7ab5ec4e3e 100644
> --- a/Documentation/dev-tools/gcov.rst
> +++ b/Documentation/dev-tools/gcov.rst
> @@ -23,7 +23,7 @@ Possible uses:
>    associated code is never run?)
>  
>  .. _gcov: https://gcc.gnu.org/onlinedocs/gcc/Gcov.html
> -.. _lcov: http://ltp.sourceforge.net/coverage/lcov.php
> +.. _lcov: https://github.com/linux-test-project/lcov
>  
Applied, thanks.

jon

