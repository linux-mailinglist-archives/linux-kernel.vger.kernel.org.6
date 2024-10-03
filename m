Return-Path: <linux-kernel+bounces-348980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C0598EED7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 14:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 768A1284709
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 12:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB88016C6A7;
	Thu,  3 Oct 2024 12:11:55 +0000 (UTC)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449B9EAD7
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 12:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.18.0.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727957515; cv=none; b=VTU2ugDW6LY7UNSjA9m+pERIrRldvon7SarTbgbQLrsVqmut0sHbIXVDN1zfiVLF4RjmYoi5JhwWTDMNB5KUfzQLbz5P9JgBYrEZujqhYuiBcc5ozPxStkl+NoFyZRFJOlCdlYjbDOiRvVEkE5YadZx+bZUxKqJrsOJvt0bAe/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727957515; c=relaxed/simple;
	bh=ivZwLpoRksMCfDXEPdwZBFZc5ne1vj41X4P5xVWMTnM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BwHDiC/3DdPsqx7y6QUkogDnF+ThjCruiHHlbmYkjZfQz2mKSPoClfcbr33fTf53c96TXgh71EgB1Ia7yOgoWEfdv1Dtb1zDr7/9TcP7XF2aDZNlRwB+uPaWj216tBDDfbhMAs2S9vwXN7ZM6bbLzULNQ4rrLho2cbZ7nd5irZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=nefkom.net; arc=none smtp.client-ip=212.18.0.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nefkom.net
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 4XK9X5612Tz1syBl;
	Thu,  3 Oct 2024 14:11:49 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 4XK9X500d9z1qqlS;
	Thu,  3 Oct 2024 14:11:48 +0200 (CEST)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id mdoEWRC87a-3; Thu,  3 Oct 2024 14:11:48 +0200 (CEST)
X-Auth-Info: uM0mVwWojgAv/nkRWEG7E8gCUPPslPpGIa4Kz3Wz8kso1NPfCF6EvsdJofUGFZSz
Received: from igel.home (aftr-62-216-205-174.dynamic.mnet-online.de [62.216.205.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Thu,  3 Oct 2024 14:11:48 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id E3DEC2C2286; Thu,  3 Oct 2024 14:11:47 +0200 (CEST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,  Tony Ambardar
 <tony.ambardar@gmail.com>,  Daniel Borkmann <daniel@iogearbox.net>,
  Miguel Ojeda <ojeda@kernel.org>,  Jiri Olsa <jolsa@kernel.org>,  Andrew
 Morton <akpm@linux-foundation.org>,  Arnd Bergmann <arnd@arndb.de>,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] compiler-gcc.h: Disable __retain on gcc-11
In-Reply-To: <CANiq72k3BBCCChVhDRALxX=mrtq2dZYR1RzdVU00n2LU=sGXjg@mail.gmail.com>
	(Miguel Ojeda's message of "Thu, 3 Oct 2024 13:02:55 +0200")
References: <1e82c551938c32b4dbf8b65dc779c1b772898307.1727853749.git.geert+renesas@glider.be>
	<87zfnmbfu7.fsf@igel.home>
	<CAMuHMdW-_oowzrzpoeU-=mD1t8P_65cBr4meY-BToYbkyQMXtg@mail.gmail.com>
	<87iku9r300.fsf@linux-m68k.org>
	<CAMuHMdW474PRT3F3qfcJaghoB1NTH0o2xXuuLpQfWPqpSSe-mA@mail.gmail.com>
	<87ed4xr22r.fsf@linux-m68k.org>
	<CANiq72k3BBCCChVhDRALxX=mrtq2dZYR1RzdVU00n2LU=sGXjg@mail.gmail.com>
X-Yow: I always wanted a NOSE JOB!!
Date: Thu, 03 Oct 2024 14:11:47 +0200
Message-ID: <87h69t75do.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Okt 03 2024, Miguel Ojeda wrote:

> Otherwise, does it mean we need a build-time test?

A simple gcc version test definitely does not suffice.

The suport for retain also depends on HAVE_INITFINI_ARRAY_SUPPORT, which
is usually enabled by default (depends on glibc support, but that is
much older), but can be disabled with --disable-initfini-array.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."

