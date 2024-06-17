Return-Path: <linux-kernel+bounces-218394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A548690BF25
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 00:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41D031F22A2B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 22:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894D919938D;
	Mon, 17 Jun 2024 22:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="KL1EFnaJ"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA64D1990C9;
	Mon, 17 Jun 2024 22:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718664201; cv=none; b=R/m+A2pPTSitpL13ZdczFeC/V2yuj/q0xcPTDdODla8DlkjF7S+h39BOdjyuNxWh4R94hHigc463erSicUF69vL9jxEo/9XM7744eQCdZBmqB0DPleqOK7kENbVrHf2jbgINdz2oAQEGomcvl/OyjaEzOw4spHRQJMqC0mnJuA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718664201; c=relaxed/simple;
	bh=QN2ec0eISa/KKAtm4Ip2LGUpwKvKWARV0EbAHEkC13U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tpfvAD+zIUdwmTB7CLm9CgvaCPlmNRaYDsN/N+CbG0Ha5ia8ty+Qve3xM41XJHfk59zNpmMnoDFVx4YbBtZoUlg0DFfS/6//ebkq1k8z52VJyXxqsD8DMscAYnFGKSKfvZAYePSatdvhcHeS8WgoYWGkMki1E5U+epqO1kNIbY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=KL1EFnaJ; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net C732145E33
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1718664200; bh=EOrcP9SkJEFlUVAanP1Niwyhp1eixFLL0/aFpQwMuWA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=KL1EFnaJ47XRYQMnpcM162rfyKl6TwB9/2+3ceCMuc03EqOW4wor5YZMH4oiH4UFH
	 I+n+pOrAcvTFEebbpqffo6TqawCkHxkX4sLeiC4bDm4/EaTRWS/HAT7aphnoLRr7sw
	 na5qYAmkSthYOFd2UT0E6gmSgiZx85Oiq8G+lYdtzGVz48HCWa3oPJ4X6fK6hgxlmv
	 /Pxuc9WqgkC7F2aizGYOCgk5xULTR/yu1Go9G10s0CR3K1j4ozZVpmdbO0Tyalvq+l
	 fvv6Kyo75AGhDV6LQwyrkMU+QZHwlGSStZbwP4qyXftUQqUOPHdiCdRM5PQ+lC3aJV
	 IogTyp9zUsAZQ==
Received: from localhost (c-24-9-249-71.hsd1.co.comcast.net [24.9.249.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id C732145E33;
	Mon, 17 Jun 2024 22:43:19 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Li Zhijian <lizhijian@fujitsu.com>, linux-doc@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 linux-kernel@vger.kernel.org, Li Zhijian <lizhijian@fujitsu.com>
Subject: Re: [PATCH] Documentation: exception-tables.rst: Fix the wrong
 steps referenced
In-Reply-To: <20240614010028.48262-1-lizhijian@fujitsu.com>
References: <20240614010028.48262-1-lizhijian@fujitsu.com>
Date: Mon, 17 Jun 2024 16:43:19 -0600
Message-ID: <874j9rgph4.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Li Zhijian <lizhijian@fujitsu.com> writes:

> When it was in text format, it correctly hardcoded steps 8a to 8c.
> However, after it was converted to RST, the sequence numbers were
> auto-generated during rendering and became incorrect after some
> steps were inserted.
>
> Change it to refer to steps a to c in a relative way.
>
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>  Documentation/arch/x86/exception-tables.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/arch/x86/exception-tables.rst b/Documentation/arch/x86/exception-tables.rst
> index efde1fef4fbd..562d1bc6d448 100644
> --- a/Documentation/arch/x86/exception-tables.rst
> +++ b/Documentation/arch/x86/exception-tables.rst
> @@ -297,7 +297,7 @@ vma occurs?
>     c) execution continues at local label 2 (address of the
>        instruction immediately after the faulting user access).
>  
> -The steps 8a to 8c in a certain way emulate the faulting instruction.
> +The steps a to c above in a certain way emulate the faulting instruction.
>  

Those steps render as 1, 2, and 3 ... where did "a to c" come from?

Thanks,

jon

