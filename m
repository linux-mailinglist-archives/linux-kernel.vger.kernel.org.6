Return-Path: <linux-kernel+bounces-348803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0790D98EC04
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 11:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A15E4283BAC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 09:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4814914658C;
	Thu,  3 Oct 2024 09:02:59 +0000 (UTC)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8335414431B
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 09:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.18.0.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727946178; cv=none; b=Yf5gv7GmS0WNTqTEIzIdZ7VBJbOG3N5cewBtG09vnFMlzHcp774NUbcRdn0CvAzpN0SwpnLRRCNDTskpRca6fo3+9anCn61QOONL+4x8WnReUR7LoVKkCVN7uLwq2clwYeWBjW/BhuOGj2DndZe/aVvzb80hcY0B5lPk/F2JYHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727946178; c=relaxed/simple;
	bh=Fd+VtmuiXki21YWwNJWnixSvPv6gDBoXy5pI+95WSKc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=txz8U+zUpeh3UdoxO6ka0gVAFBOF8KsCq0Qv4fCNQVZ+iW1a66zE4wFCYm2TOPt87L7Yu4FgQ7T8jqtV4LnIMpzQySZ+0yMNSitRzuf5oLiFH5xwCRZ+9yPkJyKcXMiM+E2Hk0v8PuHs1BmzQ3zD6Iu11zUfCKBG91y7WyFZEzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=nefkom.net; arc=none smtp.client-ip=212.18.0.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nefkom.net
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 4XK5L62t8Fz1sB8C;
	Thu,  3 Oct 2024 11:02:54 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 4XK5L56g9Gz1qqlS;
	Thu,  3 Oct 2024 11:02:53 +0200 (CEST)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id 75HeFWYO4mBt; Thu,  3 Oct 2024 11:02:53 +0200 (CEST)
X-Auth-Info: CB/kAc5x6XOEVrzG/r5t3YzOu1nJjI25ghujM0htYYpjkQsyTK0A6vwpAD1gmHZ1
Received: from tiger.home (aftr-62-216-205-225.dynamic.mnet-online.de [62.216.205.225])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Thu,  3 Oct 2024 11:02:53 +0200 (CEST)
Received: by tiger.home (Postfix, from userid 1000)
	id A12E12E5330; Thu,  3 Oct 2024 11:02:52 +0200 (CEST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Tony Ambardar <tony.ambardar@gmail.com>,  Daniel Borkmann
 <daniel@iogearbox.net>,  Miguel Ojeda <ojeda@kernel.org>,  Jiri Olsa
 <jolsa@kernel.org>,  Andrew Morton <akpm@linux-foundation.org>,  Arnd
 Bergmann <arnd@arndb.de>,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] compiler-gcc.h: Disable __retain on gcc-11
In-Reply-To: <CAMuHMdW474PRT3F3qfcJaghoB1NTH0o2xXuuLpQfWPqpSSe-mA@mail.gmail.com>
	(Geert Uytterhoeven's message of "Thu, 3 Oct 2024 10:57:50 +0200")
References: <1e82c551938c32b4dbf8b65dc779c1b772898307.1727853749.git.geert+renesas@glider.be>
	<87zfnmbfu7.fsf@igel.home>
	<CAMuHMdW-_oowzrzpoeU-=mD1t8P_65cBr4meY-BToYbkyQMXtg@mail.gmail.com>
	<87iku9r300.fsf@linux-m68k.org>
	<CAMuHMdW474PRT3F3qfcJaghoB1NTH0o2xXuuLpQfWPqpSSe-mA@mail.gmail.com>
X-Yow: I am NOT a nut....
Date: Thu, 03 Oct 2024 11:02:52 +0200
Message-ID: <87ed4xr22r.fsf@linux-m68k.org>
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
> On Thu, Oct 3, 2024 at 10:42 AM Andreas Schwab <schwab@linux-m68k.org> wrote:
>> On Okt 03 2024, Geert Uytterhoeven wrote:
>> > | That ultimately depends on binutils support for SHF_GNU_RETAIN (2.36+).
>> >
>> > So binutils 2.38-4ubuntu2.6 is sufficiently new, but it doesn't work?
>>
>> It ultimately depends on the binutils version the compiler was built
>> against.
>
> Is there an easy way to check that version?

No.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."

