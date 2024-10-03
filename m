Return-Path: <linux-kernel+bounces-348781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CFB98EBCE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 10:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E399B1F24399
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 08:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DAA13D509;
	Thu,  3 Oct 2024 08:43:08 +0000 (UTC)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C31313D245
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 08:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.18.0.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727944988; cv=none; b=f/XDPnBQPpE7vTL4Qpod6qFGDkzVUi9eE2WmqbhGDw3zYe55ivXs8i/knAg47Kk0lLyld9/Omk5CmqvJDL1Cu33/ghtftoGmLU0cdz81yZX5zHEDZ/5fXxP9xhx42mVvSu67ZZtI0FRS2b0RnjYJu0xPwtNpshOH495VrsoB6xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727944988; c=relaxed/simple;
	bh=ajhl215o2SrIAJDth0Lf5yT5nfRQIpsdiIlCsE/oxXc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BpqZDwBOOAPct/olFXN9xJ+z0zS4AlL6x2REUJAgIPRVfa0LYu2stVimh41KvCq8zZMMEelteALWqUL5pOGXnXCfacYMvxF6p0sEWQAKCnl6HK8V5thCyUD3bvPgHOB6fQmTzvABmdySdD6bOuEAsKoaDa9D5yiPUm9P8OU+4cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=nefkom.net; arc=none smtp.client-ip=212.18.0.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nefkom.net
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 4XK4v45bLtz1sBqT;
	Thu,  3 Oct 2024 10:42:56 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 4XK4v42Y9Yz1qqlS;
	Thu,  3 Oct 2024 10:42:56 +0200 (CEST)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id vKBpyDcSRKtH; Thu,  3 Oct 2024 10:42:55 +0200 (CEST)
X-Auth-Info: JoSkwZccGc1tes1/Ov/6s4QopIQKbce/eDE5IQV4LxzSeC66oxFlq9twITgt4DQi
Received: from tiger.home (aftr-62-216-205-225.dynamic.mnet-online.de [62.216.205.225])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Thu,  3 Oct 2024 10:42:55 +0200 (CEST)
Received: by tiger.home (Postfix, from userid 1000)
	id 21A9B2E532C; Thu,  3 Oct 2024 10:42:55 +0200 (CEST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Tony Ambardar <tony.ambardar@gmail.com>,  Daniel Borkmann
 <daniel@iogearbox.net>,  Miguel Ojeda <ojeda@kernel.org>,  Jiri Olsa
 <jolsa@kernel.org>,  Andrew Morton <akpm@linux-foundation.org>,  Arnd
 Bergmann <arnd@arndb.de>,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] compiler-gcc.h: Disable __retain on gcc-11
In-Reply-To: <CAMuHMdW-_oowzrzpoeU-=mD1t8P_65cBr4meY-BToYbkyQMXtg@mail.gmail.com>
	(Geert Uytterhoeven's message of "Thu, 3 Oct 2024 09:57:30 +0200")
References: <1e82c551938c32b4dbf8b65dc779c1b772898307.1727853749.git.geert+renesas@glider.be>
	<87zfnmbfu7.fsf@igel.home>
	<CAMuHMdW-_oowzrzpoeU-=mD1t8P_65cBr4meY-BToYbkyQMXtg@mail.gmail.com>
X-Yow: Sign my PETITION.
Date: Thu, 03 Oct 2024 10:42:55 +0200
Message-ID: <87iku9r300.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Okt 03 2024, Geert Uytterhoeven wrote:

> | That ultimately depends on binutils support for SHF_GNU_RETAIN (2.36+).
>
> So binutils 2.38-4ubuntu2.6 is sufficiently new, but it doesn't work?

It ultimately depends on the binutils version the compiler was built
against.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."

