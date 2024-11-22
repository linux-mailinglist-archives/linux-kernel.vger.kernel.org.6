Return-Path: <linux-kernel+bounces-418733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 585B79D64D1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 21:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F13BE282E4F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 20:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A01C176AA1;
	Fri, 22 Nov 2024 20:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="DYAW5AWD"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F21B158DA3
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 20:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732306729; cv=none; b=Eqc6sZQVs7fm2Z04Va73GmUqGLR70ESzo1JziL7WbkspyE+yh+TR8oPhjwDPFfgtT5C7MehvB8G2jZIIL+LaQg0oO8bfmJkD/AFF4Ocr6Q5E06J///0Fn3AlV0dJYYuEOrOh2Iii2z4MuO54pQXYlAOoZsuAuQxz3+gWtTdsRmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732306729; c=relaxed/simple;
	bh=ShYX8AElLJr2n334KbhmpjPjVPPyhWkr5goeJbY2XCU=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Je04/clf8rNI5R8hHNlkt0duUgc6B4RGGIvoSzsKVvy+zPRlweW70whIvRf8+7DnLTiXFfyR9J/bt5myuSd8zwwPulhW1RVUlY+PVPFqva6nw/TQgHfJAuLV8doeIn3Mr7Tj4993OiR81RfUVIfC/ig7k1o6i5lRXH3cT0rUcXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=DYAW5AWD; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4Xw5yt2j42zlgMVX;
	Fri, 22 Nov 2024 20:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:subject
	:subject:from:from:content-language:user-agent:mime-version:date
	:date:message-id:received:received; s=mr01; t=1732306722; x=
	1734898723; bh=tvU7yzIXdrJ1JoTLWn58eZu1CUo1ZLYhMNfsnSJ7p70=; b=D
	YAW5AWDRHIrzIKx5sbX8LHwPweTU9rEUrH3vR1ZBWCADq34iVQ2boepZ1B+EGAxo
	gwjW6DAjMPktvVVXOYi7D42ba3IbZqMsmavJ439Vxc21V8Q9cbKejrIMbX8CHr8c
	BM/vHEVNOOUiBchITCuutJwB8rlV8JUwz/6kuMPkpiLj0Ap5Koa6YP1G98G8elLE
	W/jHA+Uhh4WNAKNdtjeUTMmsUO2iaXRw4chXd3uD9EmY44KlSTiWb6tBScwwgFri
	e1VJiOywelGieHy48pbZq723nRnXIaBDcWIHcokbiZmEzPiI7qPSAcRqiOjpvKlO
	UgZjvtIAyBnoMpBeCEQjQ==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id lIwshB4O9nuA; Fri, 22 Nov 2024 20:18:42 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4Xw5yn6H7TzlgMVW;
	Fri, 22 Nov 2024 20:18:41 +0000 (UTC)
Message-ID: <9025e912-7151-4a1e-b1ba-91eafde12179@acm.org>
Date: Fri, 22 Nov 2024 12:18:40 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>
Cc: linux-kernel@vger.kernel.org
From: Bart Van Assche <bvanassche@acm.org>
Subject: Unexpected lockdep selftest failures
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

With the for-next branch of this tree: git://git.kernel.dk/linux-block
(commit 12ab2c13ca77 ("Merge branch 'for-6.13/block' into for-next")) I
see the following:


[    0.887603][    T0] 
--------------------------------------------------------------------------
[    0.888763][    T0]   | Wound/wait tests |
[    0.889310][    T0]   ---------------------
[    0.889867][    T0]                   ww api failures:  ok  |FAILED| 
ok  |
[    0.892597][    T0]                ww contexts mixing:  ok  |  ok  |
[    0.894638][    T0]              finishing ww context:  ok  |  ok  | 
ok  |  ok  |
[    0.898020][    T0]                locking mismatches:  ok  |  ok  | 
ok  |
[    0.900689][    T0]                  EDEADLK handling:  ok  |  ok  | 
ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.908172][    T0]            spinlock nest unlocked:  ok  |
[    0.909484][    T0]                spinlock nest test:  ok  |
[    0.910902][    T0] 
-----------------------------------------------------
[    0.911824][    T0]                                  |block | try 
|context|
[    0.912970][    T0] 
-----------------------------------------------------
[    0.913890][    T0]                           context:  ok  |  ok  | 
ok  |
[    0.916613][    T0]                               try:  ok  |  ok  | 
ok  |
[    0.919235][    T0]                             block:  ok  |  ok  | 
ok  |
[    0.921852][    T0]                          spinlock:  ok  |  ok 
|FAILED|
[    0.924666][    T0] 
--------------------------------------------------------------------------
[    0.925852][    T0]   | queued read lock tests |
[    0.926506][    T0]   ---------------------------
[    0.927132][    T0]       hardirq read-lock/lock-read:  ok  |
[    0.928496][    T0]       hardirq lock-read/read-lock:  ok  |
[    0.929860][    T0]                 hardirq inversion:  ok  |
[    0.931269][    T0]   --------------------
[    0.931827][    T0]   | fs_reclaim tests |
[    0.932383][    T0]   --------------------
[    0.932932][    T0]                   correct nesting:  ok  |
[    0.934252][    T0]                     wrong nesting:  ok  |
[    0.935518][    T0]                 protected nesting:  ok  |
[    0.936784][    T0] 
--------------------------------------------------------------------------
[    0.937936][    T0]   | wait context tests |
[    0.938516][    T0] 
--------------------------------------------------------------------------
[    0.939661][    T0]                                  | rcu  | raw  | 
spin |mutex |
[    0.940646][    T0] 
--------------------------------------------------------------------------
[    0.941798][    T0]                in hardirq context:  ok  |  ok  | 
ok  |  ok  |
[    0.944946][    T0] in hardirq context (not threaded):  ok  |  ok  | 
ok  |  ok  |
[    0.948072][    T0]                in softirq context:  ok  |  ok  | 
ok  |  ok  |
[    0.951206][    T0]                    in RCU context:  ok  |  ok  | 
ok  |  ok  |
[    0.954345][    T0]                 in RCU-bh context:  ok  |  ok  | 
ok  |  ok  |
[    0.957477][    T0]              in RCU-sched context:  ok  |  ok  | 
ok  |  ok  |
[    0.960612][    T0]           in RAW_SPINLOCK context:  ok  |  ok  | 
ok  |  ok  |
[    0.963927][    T0]               in SPINLOCK context:  ok  |  ok  | 
ok  |  ok  |
[    0.967252][    T0]                  in MUTEX context:  ok  |  ok  | 
ok  |  ok  |
[    0.970571][    T0] 
--------------------------------------------------------------------------
[    0.971702][    T0]   | local_lock tests |
[    0.972422][    T0]   ---------------------
[    0.972965][    T0]           local_lock inversion  2:  ok  |
[    0.974319][    T0]           local_lock inversion 3A:  ok  |
[    0.975708][    T0]           local_lock inversion 3B:  ok  |
[    0.977106][    T0]       hardirq_unsafe_softirq_safe:  ok  |
[    0.978595][    T0] 
--------------------------------------------------------------------------
[    0.979723][    T0]   | lockdep_set_subclass() name test|
[    0.980424][    T0]   -----------------------------------
[    0.981123][    T0]     compare name before and after:  ok  |
[    0.982423][    T0] 
-----------------------------------------------------------------
[    0.983434][    T0] BUG:   2 unexpected failures (out of 395) - 
debugging disabled! |
[    0.984441][    T0] 
-----------------------------------------------------------------


Is this a known issue?

Thanks,

Bart.

