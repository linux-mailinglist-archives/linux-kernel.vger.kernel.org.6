Return-Path: <linux-kernel+bounces-320178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7832097070B
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 13:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E84A1F219DB
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 11:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48C214D715;
	Sun,  8 Sep 2024 11:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=benjarobin.fr header.i=@benjarobin.fr header.b="PRJ4aBSW"
Received: from 8.mo571.mail-out.ovh.net (8.mo571.mail-out.ovh.net [46.105.72.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B9E4503C
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 11:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.105.72.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725795943; cv=none; b=tpu9eB3SAO8sSUAr1nzPL5JCjFU7niCTbksp/vuT631oRQvxM3i1YhRx7/U/guFafqXDpjaS39bdNFq13YSlDf2iXjQkfvyWCyPOF8gGJOA7p1FRhDwu6T7C1T42Swg6pr2sTML2aY0hIkgevruMswtE1wWYiP1rLbtkzKRY61k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725795943; c=relaxed/simple;
	bh=swa7L73NfZscjSMuTbSp4YSUVa8iRhjoFYvOSeb9y2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nEkDcyuaEKrII/ADyI/ztL1fB9iKWQCs/SyiRizUve89rxWkrUEW61Rv16VuvCZyFgkDG+cb3FON364iYVDWF1sfLoKeEeEQhBeFJAa6wOqTI263QSvfRNVo/fVaV8WOipkwVzUe/Sef7Im64NzloxRkUxXIiwR5R5rmTubi9bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=benjarobin.fr; spf=pass smtp.mailfrom=benjarobin.fr; dkim=pass (2048-bit key) header.d=benjarobin.fr header.i=@benjarobin.fr header.b=PRJ4aBSW; arc=none smtp.client-ip=46.105.72.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=benjarobin.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=benjarobin.fr
Received: from director3.derp.mail-out.ovh.net (director3.derp.mail-out.ovh.net [152.228.215.222])
	by mo571.mail-out.ovh.net (Postfix) with ESMTPS id 4X1p7K5XrGz19Qv;
	Sun,  8 Sep 2024 11:45:33 +0000 (UTC)
Received: from director3.derp.mail-out.ovh.net (director3.derp.mail-out.ovh.net. [127.0.0.1])
        by director3.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
        for <jstultz@google.com>; Sun,  8 Sep 2024 11:45:33 +0000 (UTC)
Received: from mta2.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.110.188.201])
	by director3.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4X1p7K4Gg7z7wVj;
	Sun,  8 Sep 2024 11:45:33 +0000 (UTC)
Received: from benjarobin.fr (unknown [10.1.6.0])
	by mta2.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id E694ABA355E;
	Sun,  8 Sep 2024 11:45:32 +0000 (UTC)
Authentication-Results:garm.ovh; auth=pass (GARM-110S00424369f2a-9afe-4cc9-9d13-f537fd79b63c,
                    2138D52549B61E75FE7EBB3F53CE47A04563795D) smtp.auth=dev@benjarobin.fr
X-OVh-ClientIp:92.161.126.4
Date: Sun, 8 Sep 2024 13:45:31 +0200
From: Benjamin ROBIN <dev@benjarobin.fr>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: jstultz@google.com, sboyd@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ntp: Make sure RTC is synchronized when time goes
 backwards
Message-ID: <6zxf76uvxe2ctbd4lpgtx2dyslwd3dcg2dwks46e2z4fnifbym@stulf7cbuwqs>
References: <20240907190900.55421-1-dev@benjarobin.fr>
 <87zfojcf8g.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zfojcf8g.ffs@tglx>
X-Ovh-Tracer-Id: 10258355528770075611
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrudeihedggeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdfstddttddvnecuhfhrohhmpeeuvghnjhgrmhhinhcutffquefkpfcuoeguvghvsegsvghnjhgrrhhosghinhdrfhhrqeenucggtffrrghtthgvrhhnpeegieffvdeihedtgfetvddtgfeuueefffeuudduheevffeuvdevleeluedvheegkeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduvdejrddtrddtrddupdelvddrudeiuddruddviedrgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepuggvvhessggvnhhjrghrohgsihhnrdhfrhdpnhgspghrtghpthhtohepgedprhgtphhtthhopehjshhtuhhlthiisehgohhoghhlvgdrtghomhdprhgtphhtthhopehssghohigusehkvghrnhgvlhdrohhrghdprhgtphhtthhopehtghhlgieslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheejuddpmhhouggvpehsmhhtphhouhht
DKIM-Signature: a=rsa-sha256; bh=M0yFKvJYiReJ4PHmT9gO4c3LfDTPoCtDcx0+zKmM+nU=;
 c=relaxed/relaxed; d=benjarobin.fr; h=From; s=ovhmo1728415-selector1;
 t=1725795934; v=1;
 b=PRJ4aBSWKYneqIMzbaAaVmOs4vDJOZTUyvwoyoiparwLygEhquI1vPXChYW64IG1wavMALO0
 y1fBRTgA1z+ZyXbnJz/1dGS7PDb37adg6RA+mWuzXSK3ZiurQpWje1fec2bBzUTs/xnKxT/Qyk+
 6WwWnwSERp+jMqVdoq3hqEUSaYCP1BzM7ue/TABIwUhkPeZ8oJ565d3XATGkzUAgmOY7Iuag1xm
 Un4BY3egLTWdS6LVRUPlBubKZWagyoAxJNBw4NwtNSrOjedvC6pEbQNxZotN0zjFMc3TAq/3na9
 gNu3fTf5/EUvxSX9DnhNjbVW/q0kf/WB4Y6lJzw5ofe+w==

On Sat, Sep 07, 2024 at 11:42:55PM GMT, Thomas Gleixner wrote:
> s/The "sync_hw_clock"/sync_hw_clock()/
> 
> See: https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#function-references-in-changelogs
> 
> s/the next .../the timer expires late./
> 
> And then please explain what the consequence is when it expires
> late. See the changelog section of the above link.

> s/This patch cancels/Cancel/
> 
> For explanation:
> # git grep 'This patch' Documentation/process 

Thank you for your remarks and the time spent to review this commit!
 
> Did you test this with lockdep enabled?

I did not... Indeed this is an huge mistake. Sorry!
 
> The caller holds timekeeping_lock and has the time keeper sequence write
> held. There is an existing dependency chain which is invers. Assume the
> sync_hrtimer is queued on a different CPU, CPU1 in this example:
> 
> CPU 0                                       CPU1
> 
> lock(&timekeeper_lock);                     lock_hrtimer_base(CPU1);    
> 
> write_seqcount_begin(&tk_core.seq); <- Makes tk_core.seq odd
> 
> __do_adjtimex()
>   process_adjtimex_modes()                  base->get_time()
>     hrtimer_cancel()                          do {
>       hrtimer_try_to_cancel()                       seq = read_seqcount_begin(&tk_core.seq);
>         lock_hrtimer_base(CPU1);                          ^^^
>         ^^^ deadlock                                      Spin waits for tk_core.seq
>                                                           to become even
> 
> You can do that cancel only outside of timekeeper_lock:

Again thank you for the time spent to explain this in some much detail.
You did not have to. This is really appreciated.

> Now you can fix that up in ntp_notify_cmos_timer() which is outside of
> the timekeeper_lock held region for the very same reason and it's the
> proper place to do that.

I will cancel the timer even for time jump in the future, everything will be 
explained in the commit message. Will see if you are OK with that.

> 
> Thanks,
> 
>         tglx

Thanks, Benjamin

