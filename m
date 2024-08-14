Return-Path: <linux-kernel+bounces-286293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A66C95192F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 12:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B1021C22580
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 10:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E642B1B0112;
	Wed, 14 Aug 2024 10:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gxqJgeYS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PpaqTBOR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D181AED45
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 10:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723632151; cv=none; b=XwfC+J97pTtojqyK0cYeK17ykD0Yz5o0JNL9LfIydweuibeX3cPy+Uq7nRdJaCKxs+wPEhyIjKoSLnIwRiKpK9DN8fTEMLpQ9nTF21ajNrIIjciwe9Obzr8ZG4g7w+SD//U3WgY8mwUU+A36nMetwRw4Ey4yZoVxN2F6vVwTJ+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723632151; c=relaxed/simple;
	bh=MRuNoanQXI5AkfJ9dlrM6J1ujaEw/Jm7dhs5K4tRcn0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TMXw68ZmFvCqlBpkkU9Zkwo1cNVfe5H9fPz9+qbetJ7WPaseQNgTsdcVX8lDLFtWaUTH489s4/pdQ50llwZDKHjNvTRQYbwQDoD6Y1MYq24BCKIES+rHtX43609L1jMXlXOjc3PUwIZQmCdCpCBntXx2tQjTjC3Uk9ErrllCv8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gxqJgeYS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PpaqTBOR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723632148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H4aQcGk6fdWTHdL3Yr+0P+FCsA2cACQeTwkywscVyWU=;
	b=gxqJgeYSSzEQppWothFlL+JQe8qUKnLdoB98s8/TI/ZkikD+b/GOokhnTH1cExUwFZnml+
	9Ub3++rQ7pTRNTfe6YmmAsjqe9D4HOCnCZY8pSkpIBjyvbYMqF71dSVbPprltd7BSDG2vB
	yNIzGf2tSt0Re0ZzDGZMBm6W738182y7ihzHpymPG1zELY5SJwohdki39RUvVmUZ4G81A4
	gLntffddnXB25VLQyzIsN77MbW9XHLctQTIptNuR5BwS3aZadJfCoRWArrgOAw27cqqSUl
	kQb4QxXGx3K1lyjDW/VkKAnzN+46okieuxEtJztBU0bJr4DdWBKGj/ZEKBCBkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723632148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H4aQcGk6fdWTHdL3Yr+0P+FCsA2cACQeTwkywscVyWU=;
	b=PpaqTBORddv+97PFttFQaiJz/GxvHtEVNAjhOsIKOCt1ZQJ6EC93azE462JtlunZwcdPQF
	j2+ScYWu/lx8mIDQ==
To: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "qyousef@layalina.io" <qyousef@layalina.io>, "frederic@kernel.org"
 <frederic@kernel.org>, "Kiszka, Jan" <jan.kiszka@siemens.com>,
 "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
 "anna-maria@linutronix.de" <anna-maria@linutronix.de>
Subject: Re: [PATCH v3 1/1] hrtimer: use and report correct timerslack
 values for realtime tasks
In-Reply-To: <76cd1f3e07c6c12a7dceac31cdf7a3ca8d1e8265.camel@siemens.com>
References: <20240813072953.209119-1-felix.moessbauer@siemens.com>
 <20240813072953.209119-2-felix.moessbauer@siemens.com>
 <87ed6src28.ffs@tglx>
 <76cd1f3e07c6c12a7dceac31cdf7a3ca8d1e8265.camel@siemens.com>
Date: Wed, 14 Aug 2024 12:42:27 +0200
Message-ID: <8734n7per0.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Aug 13 2024 at 10:23, Felix MOESSBAUER wrote:
> On Tue, 2024-08-13 at 11:45 +0200, Thomas Gleixner wrote:
>> Why are you declaring that a RT task has to have 0 slack if we are
>> lifting the hard coded slack zeroing in the hrtimer functions?
>
> This is what the manpage states [1]:
>
> + Timer slack is not applied to threads that are scheduled under a
> + real-time scheduling policy (see sched_setscheduler(2)).
>
> [1] https://man7.org/linux/man-pages/man2/PR_SET_TIMERSLACK.2const.html

Fair enough. Mention it in the changelog please.

Thanks,

        tglx

