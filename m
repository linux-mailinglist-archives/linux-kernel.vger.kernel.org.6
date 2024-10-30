Return-Path: <linux-kernel+bounces-388030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D543B9B597C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 02:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8040A1F24244
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 01:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D365028C;
	Wed, 30 Oct 2024 01:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="e/yjPJ5d"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F3E3398E
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 01:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730252713; cv=none; b=iH3FHwrCl4N4ubvOGt0dN40ZvWVHWlXW8D7K5r7iJnYp5DBMhD8T94Cm2orWc2ToFVJpexMkINORCbukXqbD8JjZNqEHPrJECmlEaWhsl7F0cECmarEWyf+CeVRbR+wp6ae5Wu8wJjfPJxfeKM59+SAxJLDlLeNu29a417Felts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730252713; c=relaxed/simple;
	bh=+NzgqF4BSBd/lYDIw9uqFm7SCjtWGwq07O/tymB9hLQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=SN1gDkUfISP9KQRtMKbNNJduPne0MGddT11EtR9EptjTpPckOxEDoeAr2/4ujUUgXwMe+JRTDCz7I3Gp65CAOenzNPf4m+rOp2OnbSsB+X8JLz6mU5ehg9dhH+Ra/1R74cYceggNNjQ7NMKqVaOKqXJiaYZRenPabE7y7vCvdH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=e/yjPJ5d; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 49U1iEC7640428
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 29 Oct 2024 18:44:15 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 49U1iEC7640428
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024101701; t=1730252656;
	bh=/SXochKldZHdY0qWbgDCKZifAjljwLY6zrS3QI4URGE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=e/yjPJ5d7Fb1SVjNl4ei3nrlu9rsPOdFrORh5pE2rqWglZomNGFa5R79I9rSe2wr5
	 WYbu3cAMdc3iGlK2Ms6V4czKGLWTzkiOpGtTdMG39UGFkM0XAXMXFedKOHNt2nBPe3
	 dxGXiNFe2uAK78SbPYAGTl8djY8B8im4Z/pU5KNzU4zqTt9Ei/HDK7Ya9Dfs9aYp+u
	 X0nedMdBLZgP4haZMixuHQwi56+dVZ+m1oNvViCpXRkrW0odi01yAoI9IZAjFNh3bf
	 Qx6abXDCFqI0JqePk+IT18XcuaaJklQdoEkdUZg2KzmVGFIczyYnmsf9I/x/nVHmpy
	 foE5bARkGxUNA==
Date: Tue, 29 Oct 2024 18:44:14 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, xin3.li@intel.com,
        krisman@collabora.com, x86@kernel.org, linux-kernel@vger.kernel.org
CC: ruanjinjie@huawei.com
Subject: Re: [PATCH] x86: Remove unused _TIF_SINGLESTEP
User-Agent: K-9 Mail for Android
In-Reply-To: <20241030012438.358269-1-ruanjinjie@huawei.com>
References: <20241030012438.358269-1-ruanjinjie@huawei.com>
Message-ID: <D75E52D0-2C84-410A-BF59-4E0CDFF67237@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On October 29, 2024 6:24:38 PM PDT, Jinjie Ruan <ruanjinjie@huawei=2Ecom> w=
rote:
>Since following commit, _TIF_SINGLESTEP is not used by x86 anymore,
>remove it=2E
>
>Fixes: 6342adcaa683 ("entry: Ensure trap after single-step on system call=
 return")
>Signed-off-by: Jinjie Ruan <ruanjinjie@huawei=2Ecom>
>---
> arch/x86/include/asm/thread_info=2Eh | 1 -
> 1 file changed, 1 deletion(-)
>
>diff --git a/arch/x86/include/asm/thread_info=2Eh b/arch/x86/include/asm/=
thread_info=2Eh
>index 12da7dfd5ef1=2E=2E734db7221613 100644
>--- a/arch/x86/include/asm/thread_info=2Eh
>+++ b/arch/x86/include/asm/thread_info=2Eh
>@@ -110,7 +110,6 @@ struct thread_info {
> #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
> #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
> #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
>-#define _TIF_SINGLESTEP		(1 << TIF_SINGLESTEP)
> #define _TIF_SSBD		(1 << TIF_SSBD)
> #define _TIF_SPEC_IB		(1 << TIF_SPEC_IB)
> #define _TIF_SPEC_L1D_FLUSH	(1 << TIF_SPEC_L1D_FLUSH)

"Following commit"?

