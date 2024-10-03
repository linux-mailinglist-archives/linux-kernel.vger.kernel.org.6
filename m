Return-Path: <linux-kernel+bounces-349008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC51398EF4A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 14:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EA681F20F52
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 12:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D87186615;
	Thu,  3 Oct 2024 12:34:37 +0000 (UTC)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA6E1494D4
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 12:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.18.0.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727958876; cv=none; b=Txwntr+uIAZPu41BryZOtfCjGWOd/UieRcXmJPMCLIFa3tlZTsO9fVH/4qjtxWTa9g6lCUTSfY7GxR4AhOh19PRo+1YSjfolD2V+ly8J6vlqu3bnxgt4QF9/ya7053LHWbp+uuJo+COmSckHQOQzV//IzmfY8oa0DSPmtrsAHN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727958876; c=relaxed/simple;
	bh=LRyrVvTLpT0Q3rWeYi98mihoqxUW/WuRTG9Z2QoAgDI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Cxe7enUryEE0LkuU311l1CtcJipnkw6X+UHk3TKqZ8qJyer1pytjSAIgwBLlci45JHGvM9Z177Py+pXB6ZoR05XV23qGTg2b9UeLKZnr1oBLCiIKHKm/ZhhR80a5ew0p4Y5cawez3W4rwB4Rig+xMuZgJ17NAivu/S6seCtgM7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=nefkom.net; arc=none smtp.client-ip=212.18.0.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nefkom.net
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 4XKB2G16Zjz1qtqS;
	Thu,  3 Oct 2024 14:34:30 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 4XKB2F6S2Rz1qqlS;
	Thu,  3 Oct 2024 14:34:29 +0200 (CEST)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id KdL094nhu9Lp; Thu,  3 Oct 2024 14:34:29 +0200 (CEST)
X-Auth-Info: ZrPd4+06x6YuBLb/KQ2/IwxAd2DQ/au0rqzeI0eWleMeFRz0qUW/4/mXKVABd5Hg
Received: from igel.home (aftr-62-216-205-174.dynamic.mnet-online.de [62.216.205.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Thu,  3 Oct 2024 14:34:29 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id B04F92C2286; Thu,  3 Oct 2024 14:34:27 +0200 (CEST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,  Tony Ambardar
 <tony.ambardar@gmail.com>,  Daniel Borkmann <daniel@iogearbox.net>,
  Miguel Ojeda <ojeda@kernel.org>,  Jiri Olsa <jolsa@kernel.org>,  Andrew
 Morton <akpm@linux-foundation.org>,  Arnd Bergmann <arnd@arndb.de>,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] compiler-gcc.h: Disable __retain on gcc-11
In-Reply-To: <CAMuHMdVkw+G6-YjDO_7F6xtgJCBfjKF8T=HuHzQuHbcJK6sp4g@mail.gmail.com>
	(Geert Uytterhoeven's message of "Thu, 3 Oct 2024 14:18:06 +0200")
References: <1e82c551938c32b4dbf8b65dc779c1b772898307.1727853749.git.geert+renesas@glider.be>
	<87zfnmbfu7.fsf@igel.home>
	<CAMuHMdW-_oowzrzpoeU-=mD1t8P_65cBr4meY-BToYbkyQMXtg@mail.gmail.com>
	<87iku9r300.fsf@linux-m68k.org>
	<CAMuHMdW474PRT3F3qfcJaghoB1NTH0o2xXuuLpQfWPqpSSe-mA@mail.gmail.com>
	<87ed4xr22r.fsf@linux-m68k.org>
	<CANiq72k3BBCCChVhDRALxX=mrtq2dZYR1RzdVU00n2LU=sGXjg@mail.gmail.com>
	<87h69t75do.fsf@igel.home>
	<CAMuHMdVkw+G6-YjDO_7F6xtgJCBfjKF8T=HuHzQuHbcJK6sp4g@mail.gmail.com>
X-Yow: I'm EMOTIONAL now because I have MERCHANDISING CLOUT!!
Date: Thu, 03 Oct 2024 14:34:27 +0200
Message-ID: <87cykh74bw.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Okt 03 2024, Geert Uytterhoeven wrote:

> On Thu, Oct 3, 2024 at 2:11 PM Andreas Schwab <schwab@linux-m68k.org> wrote:
>> On Okt 03 2024, Miguel Ojeda wrote:
>>
>> > Otherwise, does it mean we need a build-time test?
>>
>> A simple gcc version test definitely does not suffice.
>>
>> The suport for retain also depends on HAVE_INITFINI_ARRAY_SUPPORT, which
>> is usually enabled by default (depends on glibc support, but that is
>> much older), but can be disabled with --disable-initfini-array.
>
> FTR, no --disable-initfini-array seen here:

--disable-initfini-array is the default for cross compilers.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."

