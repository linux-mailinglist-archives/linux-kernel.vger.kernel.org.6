Return-Path: <linux-kernel+bounces-308791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5499661D6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 14:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03F221F2425D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 12:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E72B199FAB;
	Fri, 30 Aug 2024 12:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="b2kpA9mn"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3D91898E5
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 12:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725021357; cv=none; b=h7Cz/4xA/GR9C0REFkXBOTWiD4Ymg60MUMHIiVWCQuNYeic8ZLQbIpqeASvZJqsAwGyF1wfE2uf43Llxu0552xgmpETdKNlJrQRM0TIVmMCnR1UL1jiFCcQFB394TDnMhhvA4+86JNmpu/O/8GiXBGFxzJja+C/wFr1U6KuLbhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725021357; c=relaxed/simple;
	bh=mZj/imiSVkpXgD5AHKUTaDYg7AqBlz8uK0U/HLKNt7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ua8Y96lP7bSdh6gVF6oeSuNN29HdP7FAFQws8z1pHMD/r48mcH36O5djJTAlr8B+4aJ+eL4l4y5P7CwEGUdLKjB+F3qEMtosxjpltGV71W3NKxiMnu5nYW2b3xd3GMJS5KFQoNyEGf2lzSijY7Nxjm4LGCgwua+W2UBAEzqRJ8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=b2kpA9mn; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1725021301; x=1725626101; i=spasswolf@web.de;
	bh=4nbOvOVDATFNtTnDtR8RSedgSxHedphyClRNJUDjV2I=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:cc:content-transfer-encoding:content-type:
	 date:from:message-id:mime-version:reply-to:subject:to;
	b=b2kpA9mn3CRTll3lwC+tFMlzFEPc6Sr/QcL3m7QgTUor4EmDbUjMFm7wis7RPU55
	 AHO9GUeJdldqqSJy5QCqCqLDcZbzKWvm4LFkj0Ygp5VsbvKi//6uPzd5Qst6OajKA
	 v1WDzdJxVAox50P34+IX0L2BmRtHx29hINXb6CPDRstYGDuzOAGhMpNeUoZHADQo4
	 zTuGpqqnPJ2VBOydTCExF4lXhrcAMuJGweq/s1vROZa+bfE5Ey/sQrPJUN4E4p+Jx
	 VbBOcjCwUZy9ubu6WghvrpsFAy4c8d+ro6+wBPkSQHJTq/rGF0qIDtErOCLS9kyrn
	 moDfEGDojwlB4d7cow==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([84.119.92.193]) by smtp.web.de
 (mrweb106 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1Mho0A-1s6GEn30Vc-00mKhP; Fri, 30 Aug 2024 14:35:01 +0200
From: Bert Karwatzki <spasswolf@web.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Bert Karwatzki <spasswolf@web.de>,
	linux-kernel@vger.kernel.org,
	bsegall@google.com,
	dietmar.eggemann@arm.com,
	efault@gmx.de,
	juri.lelli@redhat.com,
	kprateek.nayak@amd.com,
	mgorman@suse.de,
	mingo@redhat.com,
	rostedt@goodmis.org,
	tglx@linutronix.de,
	vincent.guittot@linaro.org,
	vschneid@redhat.com,
	wuyun.abel@bytedance.com,
	youssefesmat@chromium.org
Subject: Re: [PATCH 17/24] sched/fair: Implement delayed dequeue
Date: Fri, 30 Aug 2024 14:34:56 +0200
Message-ID: <20240830123458.3557-1-spasswolf@web.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: 20240727105030.226163742@infradead.org
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Provags-ID: V03:K1:Qf/dK0i6GtjSXQL8BhzlRxzi7gFe6iAy2qqnsIR1XVUJ2fZzYlF
 cf69hF/02wemnHE9vDfGIv+uZuYSPON3iEjUO5P+TU03Ld6JvgN+wTloFkHepAMOmQCTGR2
 wRvBniQC71xW7OL2Q3TahuG7/N0QNXrEKAk1G3yLY66tbSxFPjOPwmcSDdcTAH3MWXyG7w9
 2jim0hhJ/lwvmOfd2QQKg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yhoQen5k9PM=;o9xImAfzxUwIQRw7doM/8R5Y05w
 XWCgqNQfXLldyu2XOZJ48VsrDi35vbplbaMjB7hlUC04OMLjl2/IrLCvYBS793PDVH3iMy5S1
 Z4dz/+6OvLmtQT2ukkYjaxjmcl2oCIjAw4StVmCBbdQcaYF3cOjBlkCKDRD47moUMslV3d0xi
 ewBimnO5x3IgR6RWQvaocKJs7gIE9XmFoFKXzqGzbNQNPs1O6gt36pvlfpc0tVSYBgboed+Ut
 JMsiqvNlo6AP4/gyTrX9BX1QlMWrIZnwlmbzZXHn5Sh9IXmV317ZfunwXZVb+ETjM5pEe/dF+
 N2YvqkdQRVRCxKsNmb147gMy2GwpBH7N9zscKcvjHUHiVWYYsSNHRdmpS7x9m+eLOZgCSCFWS
 HmtckD6WNUXfMy/XOWkRc27kGDL9Qze2fnMlcqNieluz3yLQ1dwJsCf25amZLV73TWq26UuH/
 v+KlXobmI6b2MZdAAgJ/Qog5Xg5jOG8D68yiABvvvhzjhBIQ9SwVEYDR0UUmYHE3HfRYj9ceU
 zNss3kauXh4xITd8PrFVyWTnuNd8Sja/DXmrTduAVHcJqpz/6dmwJA3SZ4TzHTEvj37aQgRNA
 vyTo23VRfts6AvSuOYYWIzsdqzEoH4GcabQCEkjc3PgSkIJz7Olpk3idJUR0VA4sRekbsigv/
 Fd9nzmzQ8PtWwKuQ3ZUTyfUymYYB94EVawiX5Cq4nztKTt9P94Gx3KybTfD8AcmTUx237a3Ph
 ayxY6ODtjt1A3Zondc6i91V+wsF64ZSbq284RsU3KanftRFgq5cNOI+ehfEZsubHV726XFZkT
 ouHn30evrW/3CsPTA09kyI9Q==

Since linux next-20240820 the following messages appears when booting:

[    T1] smp: Bringing up secondary CPUs ...
[    T1] smpboot: x86: Booting SMP configuration:
[    T1] .... node  #0, CPUs:        #2  #4  #6  #8 #10 #12 #14  #1
This is the line I'm concerend about:
[    T1] psi: inconsistent task state! task=61:cpuhp/3 cpu=0 psi_flags=4 clear=0 set=4
[    T1]   #3  #5  #7  #9 #11 #13 #15
[    T1] Spectre V2 : Update user space SMT mitigation: STIBP always-on
[    T1] smp: Brought up 1 node, 16 CPUs
[    T1] smpboot: Total of 16 processors activated (102216.16 BogoMIPS)

I bisected this to commit 152e11f6df29 ("sched/fair: Implement delayed dequeue").
Is this normal or is this something I should worry about?

Bert Karwatzki

