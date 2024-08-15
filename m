Return-Path: <linux-kernel+bounces-288172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7959536D8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 17:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 443EE1F21D38
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 15:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E5C1AD3EE;
	Thu, 15 Aug 2024 15:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IeuYPepv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/lnCCE5Z"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D231A76C1
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 15:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723734889; cv=none; b=WT3jEOImFzVJhtW2dv+P0ke+Gq4fOfBVhGBbhoR6415YrW/ksZxkE/pfAf09bPWhWjvHrLYg/DiL7e99mSsTaS63/PZIO9vOqjuYKFUw1WtopMDLxjFtlxZRtxJ4XuHRIQuLkHDBn2gqq0MvoQruFmzK7DQJ8RiF+W1y/HAyv64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723734889; c=relaxed/simple;
	bh=OkyHwXozf3/6w8P3MZbh7aenxKvTlvIn7PY84HsAdy4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qS872Rl3LdVdFb2WbGsJ/aqsteZ39LeNuRa24dZHYNFqi9Q2gtULC0eWL9wgNiwo8C8regGa3op8dNFPmVt7YikJcDuh32xTMTO3owkf8VjJ+4I7Mq68uuqh9u9C+xzkvqBopeBdduQvSwFDgIdbSYy0iddJ8ETqG5V6hRNQOgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IeuYPepv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/lnCCE5Z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723734886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BPuHrZFx778hIDCBjTHxN+nZoZJhuNLfJ7MygK5qf7s=;
	b=IeuYPepvPZJ9b1rhkQ533WHtEU3evyQekNsqApqteeceqLiw0RQuiRauBDeOWbo2IO5yS5
	wl+/NZ8uL6319HJxMJwKIz8IrbG3di0eNXj6r2zBwg/dUml/GeYb1KVXBOsuoiLZ1zefCq
	TSPkuXmbpC6J/v3gAlDPaIm5qfQF/P4yz0xOTacuXk18hEGvmv7pZXnQdNcVZQOdQh2cMI
	wz/XddR14znnDNYufDjhznkECv3Co8LEBd0zJCEHrMPbNqlRQthISCUBiAGCOjSHJR73Ia
	mnP057QIsVRjDejSdqxoudG3+/3J/atbprE+btzkFxb/X+X/sX851k6Xl6yprA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723734886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BPuHrZFx778hIDCBjTHxN+nZoZJhuNLfJ7MygK5qf7s=;
	b=/lnCCE5ZkYhDXIuRucYB2dv8d9MiH4kcasDEWTtt2b76j+ZHQy+ADQAsdCliqQTV9jX5jY
	0lsPltapscHbWrBg==
To: Samuel Holland <samuel.holland@sifive.com>, Anup Patel
 <apatel@ventanamicro.com>, Emil Renner Berthing
 <emil.renner.berthing@canonical.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, Paul
 Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Daniel Lezcano
 <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v1 0/9] Fix Allwinner D1 boot regression
In-Reply-To: <be1db8f5-af55-48a4-be7a-5e8a1a5e25c4@sifive.com>
References: <20240814145642.344485-1-emil.renner.berthing@canonical.com>
 <87jzgjnh9z.ffs@tglx>
 <CAJM55Z8WERQgs=QMyFGWvAHOpwcnOAudBqovaEuDudPSXCvL5Q@mail.gmail.com>
 <87ttfmm2ns.ffs@tglx>
 <CAJM55Z88H635Crc-Aeq+K0qcAk7NC89WVTAFdXDd2aQKQ7QmEg@mail.gmail.com>
 <CAJM55Z_qQX7n8tAeOFqrAH1BFjA9vaWA8rtsPG2BcKmiO88m=Q@mail.gmail.com>
 <87plqalyd4.ffs@tglx> <686d61c4-e7ac-4dca-a7fd-decdd72e84d9@sifive.com>
 <87h6blnaf1.ffs@tglx>
 <CAK9=C2V7oL023=u6nodJs76k_0yHZ8PTJs=n1QFqDWCcCnG9kw@mail.gmail.com>
 <be1db8f5-af55-48a4-be7a-5e8a1a5e25c4@sifive.com>
Date: Thu, 15 Aug 2024 17:14:45 +0200
Message-ID: <87ed6pn7h6.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Aug 15 2024 at 09:41, Samuel Holland wrote:
> On 2024-08-15 9:16 AM, Anup Patel wrote:
>> Almost all RISC-V platforms (except this one) have SBI Timer always
>> available and Linux uses a better timer or Sstc extension whenever
>> it is available.
>
> So this is the immediate solution: add the CLINT to the firmware
> devicetree so that the SBI time extension works, and Linux will boot
> without any code changes, albeit with a higher-overhead clockevent
> device.

That does not matter for the boot process when the sun4i timer becomes
available afterwards. But how can this be retrofitted along with the
kernel update?

Thanks,

        tglx

