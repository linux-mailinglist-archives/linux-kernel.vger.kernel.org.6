Return-Path: <linux-kernel+bounces-426368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B2F9DF23A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 18:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23CE7162747
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 17:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1AC61A4B69;
	Sat, 30 Nov 2024 17:29:23 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475EF1DFF7;
	Sat, 30 Nov 2024 17:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732987763; cv=none; b=IvSf/ZbJQTkwlUSBpdWnezWXTu4i4Ylw7CMqbPCKKjMy9wM3yf6AQ1z/TrHRgekS3PsbZ2+dVOPKbIuA2zJBUuUPzNRoxbf2lEfjJ3zmyHRHGKtMIUwO1d+vDL40a3k7OSvHrKRdQEVDL9tnkGEyiTqllhHw/B2hnqKvIuxs+YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732987763; c=relaxed/simple;
	bh=yvGAdforTN0ygcbVy3nA1rvlhEMGS0L2mrKMS1RMxfs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wz/zcVGQDIVJdF/FmHafzycQQc4ZDnCbsnL2GgFv4+C/1bs9CedYIuevtmAvRrGB7aNdSgJY4sXwGNlFNMWLtu+72/DpTOcBYwPefWxy74DU2nxlLTZjAZuZSGFYya/q9COXRIY4z2SMGZ8h1vwxhn+xjOCW63c1uII62X6L8TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1tHRGs-000000005G9-3gEG;
	Sat, 30 Nov 2024 12:28:42 -0500
Message-ID: <069d686ab958d973563cfad52373ec6c8aad72ca.camel@surriel.com>
Subject: Re: [linus:master] [x86/mm/tlb]  7e33001b8b:
 will-it-scale.per_thread_ops 20.7% improvement
From: Rik van Riel <riel@surriel.com>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
 Ingo Molnar <mingo@kernel.org>, Andy Lutomirski <luto@kernel.org>, Peter
 Zijlstra	 <peterz@infradead.org>, Linus Torvalds
 <torvalds@linux-foundation.org>
Date: Sat, 30 Nov 2024 12:28:42 -0500
In-Reply-To: <202411301528.342383d8-lkp@intel.com>
References: <202411301528.342383d8-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: riel@surriel.com

On Sat, 2024-11-30 at 16:07 +0800, kernel test robot wrote:
>=20
>=20
> Hello,
>=20
> in this test, we don't have CONFIG_DEBUG_VM.
> # CONFIG_DEBUG_VM is not set
>=20
> below report is just FYI.
>=20
>=20
> kernel test robot noticed a 20.7% improvement of will-it-
> scale.per_thread_ops on:
>=20
>=20
> commit: 7e33001b8b9a78062679e0fdf5b0842a49063135 ("x86/mm/tlb: Put
> cpumask_test_cpu() check in switch_mm_irqs_off() under
> CONFIG_DEBUG_VM")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git=C2=A0mast=
e
> r

It's good to get this confirmation that the mm_cpumask
really is that expensive.

I guess we could experiment with something like the following:

1) Stop using the mm_cpumask altogether on x86
2) Instead, at context switch time just update
   per_cpu variables like cpu_tlbstate.loaded_mm
   and friends
3) At (much rarer) TLB flush time:
   - Iterate over all CPUs
   - Use cpustate.loaded_mm and .is_lazy to  build a=C2=A0
     (per-CPU?) cpumask.
   - Pass that cpumask to functions like flush_tlb_multi
     and on_each_cpu_mask

Does that make sense as something we could try to
further reduce context switch overhead, and the
TLB flush thundering herd on the mm_cpumask triggered
by the main loop in will-it-scale's tlb_flush2 test?

https://github.com/antonblanchard/will-it-scale/blob/master/tests/tlb_flush=
2.c


--=20
All Rights Reversed.

