Return-Path: <linux-kernel+bounces-189056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D5D8CEA64
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 21:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FC472838A0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 19:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE026D1A0;
	Fri, 24 May 2024 19:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3WD9/WcC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qU+VxrMO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244DC171A1
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 19:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716579393; cv=none; b=P4QYph8Oo4qpcJxMWLrx8hECX63XV9IFrnhD3/wiEmdCQSwSvZaZZfcaB8u6nHvmPF6OXBlmxr8yv0XXYRp2ux/sq51L0wlkrEfNghSAxLSxoKmXuivCq9NFhOaeCPgJ4B/zyLbOiot2N0NQpCcuXx0vfWXxhYekAuHsEqPm5xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716579393; c=relaxed/simple;
	bh=hNm24N+303+Eh3MG7JmHts0ImqtsVr4f5oZlFElgeCU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O+XAKx2/H1IAYto/0cjntmYdh2m4YzyZVq4KNQqN/yqEKgBvUnOPIbBt1lI6KNYmgLk9FF1Bgdr9lu/3YybAP0zNDr9H8tD0HUns4Qe/WYHMgJSh6V9cjmCr4VUhnduf8slPkRd7zZtQOC6Iau2IxeT2t2W+1VB0kn55dBb/KAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3WD9/WcC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qU+VxrMO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716579390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iyBt2ECzfVmFCZHLo5ZC95DN7e5Ms+svFwknAIN23AQ=;
	b=3WD9/WcC2NxMMIC4HZU1cBqAMMWsNLq1yOqBP888RkF3HxgY/j3QNoZM7ziMvg4bJ5JIbo
	/iZNFONV+nHh/8Hc55z9oOv+bqtJCDDkazvqULpQlN//8yXwV17ZUfNAGK0Q8ooklA3HTI
	YBQ9GL8sQN76jJThK+hzui0WmnmTwLIQscgpeYofbZYRl6zVHjkey78ekK/0NNu5R0JpBl
	jIhG/xpopaoQU0iu0G0sO5sVwO07HRqW4A8GA3dEkZIPRDgqUNRrki31o/9OHV8jbOJXsf
	I63DGyHGAiq7EV2PKwQU6u4M5SxNpAQ5UsqTAwVP32/VTGN+O5E1Dhnd55Tp/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716579390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iyBt2ECzfVmFCZHLo5ZC95DN7e5Ms+svFwknAIN23AQ=;
	b=qU+VxrMOzqTSj/kFZ90TGVWqWp4Dia3K5914XJoI7iPg7S5xAo6c7RH8CM2kx9BKYgCkwn
	9H0wFxPovVYtPqCg==
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: linux@roeck-us.net, Conor Dooley <conor@kernel.org>,
 naresh.kamboju@linaro.org, linux-kernel@vger.kernel.org,
 lkft-triage@lists.linaro.org, regressions@lists.linux.dev,
 linux-riscv@lists.infradead.org, apatel@ventanamicro.com,
 anders.roxell@linaro.org, dan.carpenter@linaro.org, Arnd Bergmann
 <arnd@arndb.de>
Subject: Re: riscv: irq-riscv-imsic-early.c:52:9: error: too many arguments
 to function 'riscv_ipi_set_virq_range'
In-Reply-To: <mhng-44d7a1c7-c15a-4077-ac94-23985f686474@palmer-ri-x1c9>
References: <mhng-44d7a1c7-c15a-4077-ac94-23985f686474@palmer-ri-x1c9>
Date: Fri, 24 May 2024 21:36:29 +0200
Message-ID: <87y17zc88y.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, May 24 2024 at 10:35, Palmer Dabbelt wrote:
> On Fri, 24 May 2024 10:18:42 PDT (-0700), tglx@linutronix.de wrote:
>> On Fri, May 24 2024 at 08:10, Guenter Roeck wrote:
>>> On Wed, May 15, 2024 at 10:05:59AM -0700, Palmer Dabbelt wrote:
>>>> as a conflict resolution, which IIUC should happen when Linus merges my next
>>>> PR.  So I'll try and remember to call that out.
>>>>
>>>
>>> Unfortunately it looks like the conflict resolution did not happen,
>>> and mainline builds are now affected.
>>
>> Fix is queued and goes to Linus tomorrow.
>
> Sorry I misesd this.  The PR I sent Linus this morning contains my fix 
> from earlier this week: 
> https://lore.kernel.org/linux-riscv/171647463438.13050.6219786365640043025.git-patchwork-notify@kernel.org/T/#t 

Happens. I don't rebase my try. I just mention it to Linus when I
send the pull request. It's the same change so the result is a NOOP and
not another conflict :)

Thanks,

        tglx

