Return-Path: <linux-kernel+bounces-320246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E5779707F6
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 16:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A4101C213DD
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 14:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B22716FF37;
	Sun,  8 Sep 2024 14:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H1FEyWiH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mdnVPBDR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71A11482E2
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 14:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725804391; cv=none; b=Sr4ZLtqgFBiRxjMRps9MDHPNwv94474cfnn0tA6kw0bTOG1vl8qsvNTi9tUnz664aHVqBHV2Lsl5OeB04lpAkU3qVqdy49HY+JON6aMQlKEneFIuZDurfoitmJuVOz2cwe++Won4GF7xw9nKtCJrjdTHs0AklALyiU5gnqRulcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725804391; c=relaxed/simple;
	bh=2ILzY125Xiu5j+N4EmaJMw/NlkSXgVrltxJCBstvzzM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ASbolDcdTb7/JP8dTrO2A6/plHRt9th88Nmp0nidly5qd7d1XJyarSUhsc1GDTCgQlVSJulOf2y4v09yeH5+TmyT6hhWWGiyjfmgNUNVr++8f7MSt6nJ9QwGWjoOPZvClJh4gNTepWxASmYpjkiwM56QPPQ5zHOHEp93piVRCzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H1FEyWiH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mdnVPBDR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725804387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VGz26AQwDTycrFjKFoG3oGY5gn4ZRxL67tNqoeG+qqk=;
	b=H1FEyWiHWtv/JnL6l6BEvE0CvVmJH6f2QH41hPtClSS47lLl855DmJws1NpbUwhzXRRf04
	NGRigA1Lg306I9aiZ3D6Njip5l4mzT6YUfv+bFuN4u36dlhBEx02qJhMz+FUNjAZxeOPjn
	RmEcyF04EaH5QP9IE82cSLQ+JOLjT08jO2JuS50Aqix2sZgtnZjarUr8AYtuUxMDeynIMS
	7y80JGcMkNcuWqu2nCdX3CKs7LT7mmaTupdqXy39hoDhVHhNNpEBqup/LdvaTtpJxweu7c
	wQc3c93GeQe/CR6Blx1T4XqwPCFssB91RvJAOLZQx7omnvlSR6je0hHNeAeWFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725804387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VGz26AQwDTycrFjKFoG3oGY5gn4ZRxL67tNqoeG+qqk=;
	b=mdnVPBDRf7brk2hUQbGy19PDmeDJyyS9d8uW7PNcEIVN+552uCtzGD1nLTkLhhVGlVQ/eo
	XjVVOBS62t5g4GCA==
To: Jinjie Ruan <ruanjinjie@huawei.com>, linux-kernel@vger.kernel.org
Cc: ruanjinjie@huawei.com
Subject: Re: [PATCH -next] genirq/timings: Use time_after_eq() macro
In-Reply-To: <20240902025727.2298958-1-ruanjinjie@huawei.com>
References: <20240902025727.2298958-1-ruanjinjie@huawei.com>
Date: Sun, 08 Sep 2024 16:06:26 +0200
Message-ID: <87seuack9p.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Sep 02 2024 at 10:57, Jinjie Ruan wrote:
> @@ -383,7 +383,7 @@ static u64 __irq_timings_next_event(struct irqt_stat *irqs, int irq, u64 now)
>  {
>  	int index, i, period_max, count, start, min = INT_MAX;
>  
> -	if ((now - irqs->last_ts) >= NSEC_PER_SEC) {
> +	if (time_after_eq(now, irqs->last_ts + NSEC_PER_SEC)) {

time_after_eq() is meant for handling jiffies and not for arbitraty time
stamps which have nothing to do with jiffies at all

Thanks,

        tglx

