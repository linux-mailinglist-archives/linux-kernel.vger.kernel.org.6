Return-Path: <linux-kernel+bounces-349035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E6798EFD6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 14:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E8381C21422
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 12:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9F319882C;
	Thu,  3 Oct 2024 12:57:23 +0000 (UTC)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308E11922CA
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 12:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.18.0.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727960243; cv=none; b=uAlR2mn2jM2UTKXly0VsBXv3nk5LZG98Z47F8UUjVC5cj0MyAQPKc6pyd8zaZu8lq/lLgs2kdAFoNrtO72FGnskPrSENrnDbLD55WVIygNyxCTafxVp1hbAo8f1lQN03N/MsmVVvlg2Ox8UL654S0/8UXT5acjfsU1qbn1KHITA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727960243; c=relaxed/simple;
	bh=BGgbUp07OYTlZTawO6qfXiLgBMCk3ax1OvSr/sWPGDo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d1uS7h7NZ/gFRwfogT7RrfuXpqbWCcvPMyyiIn1sbvY4vhfG+FrWtq5dflzg4uKuBTkF4Gi6LWO2qOI9sgPtQ5ntpRlZ23MxSbpW7YY5tLo6E33REZlt3adoTeDpU6S8usyOjQI7YML0sCc9rWt//zch8AIMudJrR2ZmFingjB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=nefkom.net; arc=none smtp.client-ip=212.18.0.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nefkom.net
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 4XKBXZ6qg4z1syBl;
	Thu,  3 Oct 2024 14:57:18 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 4XKBXZ3TD5z1qqlS;
	Thu,  3 Oct 2024 14:57:18 +0200 (CEST)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id Mch6f4WPdx5w; Thu,  3 Oct 2024 14:57:17 +0200 (CEST)
X-Auth-Info: PT/HBXZifO/c8ATq5hhl2FeJNW5GMJ2Dr1y8kOC/Chq45NW148lLtDV4QsjNgsZd
Received: from igel.home (aftr-62-216-205-174.dynamic.mnet-online.de [62.216.205.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Thu,  3 Oct 2024 14:57:17 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id 8A7A72C2286; Thu,  3 Oct 2024 14:57:17 +0200 (CEST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,  Tony Ambardar
 <tony.ambardar@gmail.com>,  Daniel Borkmann <daniel@iogearbox.net>,
  Miguel Ojeda <ojeda@kernel.org>,  Jiri Olsa <jolsa@kernel.org>,  Andrew
 Morton <akpm@linux-foundation.org>,  Arnd Bergmann <arnd@arndb.de>,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] compiler-gcc.h: Disable __retain on gcc-11
In-Reply-To: <CAMuHMdVN9UyuUMFJUFb9hsKZ8=Uw=L0NEgS-kcoPDGbCk8XJnQ@mail.gmail.com>
	(Geert Uytterhoeven's message of "Thu, 3 Oct 2024 14:52:35 +0200")
References: <1e82c551938c32b4dbf8b65dc779c1b772898307.1727853749.git.geert+renesas@glider.be>
	<87zfnmbfu7.fsf@igel.home>
	<CAMuHMdW-_oowzrzpoeU-=mD1t8P_65cBr4meY-BToYbkyQMXtg@mail.gmail.com>
	<87iku9r300.fsf@linux-m68k.org>
	<CAMuHMdW474PRT3F3qfcJaghoB1NTH0o2xXuuLpQfWPqpSSe-mA@mail.gmail.com>
	<87ed4xr22r.fsf@linux-m68k.org>
	<CANiq72k3BBCCChVhDRALxX=mrtq2dZYR1RzdVU00n2LU=sGXjg@mail.gmail.com>
	<87h69t75do.fsf@igel.home>
	<CAMuHMdVkw+G6-YjDO_7F6xtgJCBfjKF8T=HuHzQuHbcJK6sp4g@mail.gmail.com>
	<87cykh74bw.fsf@igel.home>
	<CAMuHMdVN9UyuUMFJUFb9hsKZ8=Uw=L0NEgS-kcoPDGbCk8XJnQ@mail.gmail.com>
X-Yow: Gibble, Gobble, we ACCEPT YOU ---
Date: Thu, 03 Oct 2024 14:57:17 +0200
Message-ID: <878qv5739u.fsf@igel.home>
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

> Hi Andreas,
>
> On Thu, Oct 3, 2024 at 2:34 PM Andreas Schwab <schwab@linux-m68k.org> wrote:
>> On Okt 03 2024, Geert Uytterhoeven wrote:
>> > On Thu, Oct 3, 2024 at 2:11 PM Andreas Schwab <schwab@linux-m68k.org> wrote:
>> >> On Okt 03 2024, Miguel Ojeda wrote:
>> >> > Otherwise, does it mean we need a build-time test?
>> >>
>> >> A simple gcc version test definitely does not suffice.
>> >>
>> >> The suport for retain also depends on HAVE_INITFINI_ARRAY_SUPPORT, which
>> >> is usually enabled by default (depends on glibc support, but that is
>> >> much older), but can be disabled with --disable-initfini-array.
>> >
>> > FTR, no --disable-initfini-array seen here:
>>
>> --disable-initfini-array is the default for cross compilers.
>
> Apparently not for cross compilers targeting riscv64?

Yes, targets in the aarch64 era or newer enable initfini_array by
default.  Also, gcc 12+ generally defaults to --enable-initfini-array on
Linux as well.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."

