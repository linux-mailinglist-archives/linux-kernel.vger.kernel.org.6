Return-Path: <linux-kernel+bounces-438206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C679E9E3A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 19:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADB7218837A2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 18:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A41D178368;
	Mon,  9 Dec 2024 18:41:01 +0000 (UTC)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEB07080B
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 18:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.18.0.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733769660; cv=none; b=bBSDcvQecMiviBl6s0r24x4zqMPcgew5RbIarUF0TzFFxH1m0UK0wUYZIadtG2cyR4MLFoKBj/O2Mc0CStP7OIezUeCwkFfhmRe5Bl9d3DmwZWaJDmj/BB4oPMY33C3aeQ7oBCIXZjjTefZkvkKgn7Mm3F1sk7AoqCje9/NGXnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733769660; c=relaxed/simple;
	bh=YyPjvKuJEpM4CNPJs9OhLN+5bRvih8fimdR0plWhrU4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TO1X5CGFRYJ5FJB5zHMNnbqB+l3FUmEgEXcegIX0jp4BqviVpu+N1YEPB8dmNY4EJYdnPidxfdcXe6k7/D/u5zvSKlC2TJ3x83DLcKXaH/qXVSsRy1nLe74prygQzzRnc4TLxEJJ01AaV6LmiH2zHuoV/7jSlOV31/7ZR+8X++g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=nefkom.net; arc=none smtp.client-ip=212.18.0.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nefkom.net
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 4Y6Vpr5wGwz1qsPx;
	Mon,  9 Dec 2024 19:32:52 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 4Y6Vpr58zWz1qqlS;
	Mon,  9 Dec 2024 19:32:52 +0100 (CET)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id DAGK58Tns2FM; Mon,  9 Dec 2024 19:32:52 +0100 (CET)
X-Auth-Info: oBX17wFr/StoNeFHnknxTLQepuuwk97VrTe1nqtIBhIrx1Gs+J9KHbF0bmaMNbYG
Received: from igel.home (aftr-82-135-83-150.dynamic.mnet-online.de [82.135.83.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Mon,  9 Dec 2024 19:32:51 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
	id A8E7F2C1B0F; Mon,  9 Dec 2024 19:32:51 +0100 (CET)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,  LKML
 <linux-kernel@vger.kernel.org>,  x86@kernel.org,
  linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] futex: improve user space accesses
In-Reply-To: <CAHk-=wjnvFU3sMjjKyqtgvPe6EMu3M4f1qyZncJR5=QDQsV=ng@mail.gmail.com>
	(Linus Torvalds's message of "Sun, 8 Dec 2024 16:32:33 -0800")
References: <20241122193305.7316-1-torvalds@linux-foundation.org>
	<87bjxl6b0i.fsf@igel.home>
	<CAHk-=wjnvFU3sMjjKyqtgvPe6EMu3M4f1qyZncJR5=QDQsV=ng@mail.gmail.com>
X-Yow: Is this an out-take from the ``BRADY BUNCH''?
Date: Mon, 09 Dec 2024 19:32:51 +0100
Message-ID: <87bjxkzoz0.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Dez 08 2024, Linus Torvalds wrote:

> IOW, does this one-liner fix it for you?
>
>   --- a/kernel/futex/futex.h
>   +++ b/kernel/futex/futex.h
>   @@ -265,7 +265,7 @@
>         else if (!user_read_access_begin(from, sizeof(*from)))
>                 return -EFAULT;
>         unsafe_get_user(val, from, Efault);
>   -     user_access_end();
>   +     user_read_access_end();
>         *dest = val;
>         return 0;
>    Efault:

Thanks, I can confirm that this fixed the crash (changing both arms as
pointed out by Christophe).

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."

