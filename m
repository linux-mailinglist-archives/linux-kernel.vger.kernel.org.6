Return-Path: <linux-kernel+bounces-339506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 533F8986617
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 20:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F9951C20DE7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 18:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0232B84A2F;
	Wed, 25 Sep 2024 18:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="RyC5TMn7"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AA5D520;
	Wed, 25 Sep 2024 18:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727287371; cv=none; b=eBfSJwDtPfILa2uVY4/9rXNwjI80TF1s2Goin3UvhPeYN0q74krIpgpgAuxAVdDyVvIwyokymEh6BfxXZLyOuzMsuT0ac/afdF7pVHf/vnPPxp6xjQWDCrzbj9TZOAsruezJeXpObpU/rDco0ZRY6Ps/uo7jDWWmKmbMwNOJT0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727287371; c=relaxed/simple;
	bh=ubZtjqgkEHcSLKdzn6nGGJAAygV9tuUOg+CSvkLi0js=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JhNH77yRlPxoVt0ojnGZd7zEpkL5XycT5GU5Er+UmGYpt2jkU/ex8slEs9qyJJvw1RabtvVaNjcrfg9Ap8DrK16s9T+pNguLTtOZVk37tKhPu3cDuKpl2cGHveB7XAQCZsdUTvFI2qRMFLKihwnKQaHQe/ZISwRTgu1LaZCSKDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=RyC5TMn7; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 7B12242B30
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1727287363; bh=KhWuW/hYDA06KYXwRlFbqTyp8jMGMd12FTTtzzUby4U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=RyC5TMn7I/DipJ8q07f3+pbjTqMT5u8yWGSBxpiUQddzY+OFcYk7iAvPnRBm0Sm+P
	 M4F3IqGx3osI60chgcozOAZChMVSNAOE6ka1Dcr8QhSPWZoeZJeiAvUAkUtslDiINf
	 QevD3Ivw9WalwF/zfi8hlziaIHPtRcJHpNFBtjkdo//QV9TTzabLiz5dLqvfjtrgZ6
	 fFvAoiSWDsYqTgZeG6dTV1mTufwn0o5zaXDeF90X2TccQAHLIVSatI/X8cpb75zDhZ
	 ZCJWOznTgLP0C4/P+Z2UPGFCaZfznWiaByjMp2YKksDeFqlYvp2o68KijWns2aba7E
	 /jr+2VxofeNFw==
Received: from localhost (bo-18-143-171.service.infuturo.it [151.18.143.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 7B12242B30;
	Wed, 25 Sep 2024 18:02:42 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Nam Cao <namcao@linutronix.de>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, =?utf-8?Q?Cl=C3=A9ment_L=C3=A9ger?=
 <cleger@rivosinc.com>, Evan Green
 <evan@rivosinc.com>, Charlie Jenkins <charlie@rivosinc.com>, Andrew Jones
 <ajones@ventanamicro.com>, linux-doc@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: Re: [PATCH] Documentation: riscv: Fix typo MIMPLID -> MIMPID
In-Reply-To: <20240925142532.31808-1-namcao@linutronix.de>
References: <20240925142532.31808-1-namcao@linutronix.de>
Date: Wed, 25 Sep 2024 12:02:39 -0600
Message-ID: <87h6a3fw74.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Nam Cao <namcao@linutronix.de> writes:

> The macro that is really defined is RISCV_HWPROBE_KEY_MIMPID, not
> RISCV_HWPROBE_KEY_MIMPLID (difference is the 'L').
>
> Also, the riscv privileged specification names the register "mimpid", not
> "mimplid".
>
> Correct these typos.
>
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
> ask me how I found out..
>
>  Documentation/arch/riscv/hwprobe.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
> index 85b709257918..fb0affa61eb9 100644
> --- a/Documentation/arch/riscv/hwprobe.rst
> +++ b/Documentation/arch/riscv/hwprobe.rst
> @@ -51,7 +51,7 @@ The following keys are defined:
>  * :c:macro:`RISCV_HWPROBE_KEY_MARCHID`: Contains the value of ``marchid``, as
>    defined by the RISC-V privileged architecture specification.
>  
> -* :c:macro:`RISCV_HWPROBE_KEY_MIMPLID`: Contains the value of ``mimplid``, as
> +* :c:macro:`RISCV_HWPROBE_KEY_MIMPID`: Contains the value of ``mimpid``, as
>    defined by the RISC-V privileged architecture specification.

You should be able to just say RISCV_HWPROBE_KEY_MIMPID() without the
:c:macro: markup and have the right thing happen.

Thanks,

jon

