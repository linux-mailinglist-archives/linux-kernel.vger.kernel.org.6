Return-Path: <linux-kernel+bounces-287977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E43952EE6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 15:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FD511C23D51
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 13:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83F417CA1D;
	Thu, 15 Aug 2024 13:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XYVxa3vg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zeMj9je9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1C51DA4E
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 13:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723727819; cv=none; b=oeClgbm+gq1YLwUdIPnvmnYHdfmAYVkqDptZuobn/bviFqWVzeZzQnm/q5q+84bJGurDZErZltarsQ0vex0W3MC1Qc7rK1WuL0j+B8m8yDlp5krh8gzgHUOhXw+Zxaor95XLek3md+hzaoNIHrsuQ0tODfvipbzAAm7j2AzkUeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723727819; c=relaxed/simple;
	bh=vvlPM4tQg6oUEHg1ci/iLoe3DQHswcLZewRSrBdXQeQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Nb4zjqA6u3/ZF8O5WYFIYqgrPV09BnYR7iKk98hiZ/TsuS02tgDJvtA0/CUjoFdMW0D9CQv2bYP8KC4EXVs7a/+sTTdCZwT/CtWSxROJKb44Jm3zdR82Ny61Tqr5eoTYOBMb1DKWBBugszLEQkI9vWLkRsU2stYqHWN5Z/iXP4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XYVxa3vg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zeMj9je9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723727815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nsfL4lSYcJUNCgpw/d4PnpralW8hjkD2gnw1p553Xgw=;
	b=XYVxa3vgapYFX5Gv1T1I2LtfFjFq3Jpz9d1PRcC2mgs1xXpZ0A820zXlq7R6AiTY+9IgDk
	ewGSqJiODtQE4SCCc71ede5XByFNoAJ2i2QsbwGTUaZvduWIqUzTQeMXnhNOE9utj+hpgL
	Ep3vVR/gyzoKjufu6SEWj8sGM5I9PdUftr+w+waC/5VyuV/tiH2ryBfX0NKkMZ0217oRu5
	sssP4FcRXinB/bbVi3kujuDcbV9+DLXC+iDsTFx0RVr5afSNk+LFMrgadSa4OAr4f3kqAh
	zJ5X3cgVGGskfIDs1lK+zGqwVL8bDHLLja4kkEPH5xgj9gn8GGGAXLPqmxNzEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723727815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nsfL4lSYcJUNCgpw/d4PnpralW8hjkD2gnw1p553Xgw=;
	b=zeMj9je9tFNfPbvoemRp0rsQO8v3oshK7uBtUNdhWefQRTTS2QO1EzZURv8y+5F5F2Ah7+
	9BPw4lAGgddbdpBw==
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>, Emil Renner
 Berthing <emil.renner.berthing@canonical.com>,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, Anup Patel
 <apatel@ventanamicro.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Samuel Holland
 <samuel.holland@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert
 Ou <aou@eecs.berkeley.edu>, Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v1 0/9] Fix Allwinner D1 boot regression
In-Reply-To: <CAJM55Z_qQX7n8tAeOFqrAH1BFjA9vaWA8rtsPG2BcKmiO88m=Q@mail.gmail.com>
References: <20240814145642.344485-1-emil.renner.berthing@canonical.com>
 <87jzgjnh9z.ffs@tglx>
 <CAJM55Z8WERQgs=QMyFGWvAHOpwcnOAudBqovaEuDudPSXCvL5Q@mail.gmail.com>
 <87ttfmm2ns.ffs@tglx>
 <CAJM55Z88H635Crc-Aeq+K0qcAk7NC89WVTAFdXDd2aQKQ7QmEg@mail.gmail.com>
 <CAJM55Z_qQX7n8tAeOFqrAH1BFjA9vaWA8rtsPG2BcKmiO88m=Q@mail.gmail.com>
Date: Thu, 15 Aug 2024 15:16:55 +0200
Message-ID: <87plqalyd4.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Aug 15 2024 at 05:14, Emil Renner Berthing wrote:
> Emil Renner Berthing wrote:
>> 6.11-rc3 + these reverts:  https://termbin.com/q6wk
>> 6.11-rc3 + Samuel's patch: https://termbin.com/7cgs
>
> I think this confirms what Charlie found here:
> https://lore.kernel.org/linux-riscv/ZoydV7vad5JWIcZb@ghost/

Yes. So the riscv timer is not working on this thing or it stops
somehow.

Can you apply the debug patch below and check whether you see the
'J: ....' output at all and if so whether it stops at some point.

Thanks,

        tglx

---
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -2459,6 +2459,9 @@ static void run_local_timers(void)
 {
 	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_LOCAL]);
 
+	if (!(jiffies & 0xFF))
+		pr_info("J: %lx\n", jiffies);
+
 	hrtimer_run_queues();
 
 	for (int i = 0; i < NR_BASES; i++, base++) {



