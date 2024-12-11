Return-Path: <linux-kernel+bounces-441984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B72629ED674
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 20:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3736B18856FB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 19:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3587225949D;
	Wed, 11 Dec 2024 19:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d1caUvE8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YFU/6U71"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6A3259497
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 19:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733944746; cv=none; b=JKcA82QXRrgN+DlILThguTVJL9TE01vF2PZJ55DwBqWK4x5tCPZTQ8W0HUwNnHDxZEfSYrmTC/AOWzzsXE+Zgintu3l5+s/Ts3S+z31qWeTsiiBrii2LxaI5E4TXJWJetS4AVjRmgZVuKEmrhLy5+FkD1KZ7DlFdNCDFXXJk7ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733944746; c=relaxed/simple;
	bh=lVAPGR+Im0KH8SC2MUHwzpnACZu3d5BO+E0mboa0XJ8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=boli3Cykmt3Vg1zfx6bi4QuV4y1RXXjVZzP4JMfkIhTq3ZC5WKxuDxffVFM6jdOmd50p1mkJ1fJ5h7bqxpuwREDBxu4mN6nfIGcFHKut5zSSA+3XMxH82UMG+rWu8daZWce4NlDOlYACHrlyR5zqauTPESL6+1O3U4cTlqfwpwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d1caUvE8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YFU/6U71; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733944743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Yu8MQgOeGPe0LAWyAHg1mUK3yAfhKPtgRkxCrhwe+X0=;
	b=d1caUvE8SCai4jHeEeuFQl98ctOWGuImZqQissHxPWGeH2u26PyjHvvSz+C2Rf8Drk+kwH
	dPDJpEKwmlcOrcYqwjMaHRuEcPW04Wp9Jpqz/5tjMxedKNokIMBLIDwI1QQ362SD9NaEn6
	JGK0mAnwdaMmFz9wn18uKL2nyy+ld/Z8LzNaz/BsUrkTQitIQidWpuQOe2mg3FQCsyVzZo
	5/BFo2fgUpxG8TltUcQT7CRavEcVp8atLVh2wqrSPAU0GWLPWddrQyZ6xzbDXk8/I+2Sgo
	F/RFUf6Lk8GS0aP44iKSXlXLiRUWeZTQtPk+xIpXPJUwtJBIwtLatAFXKNfL4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733944743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Yu8MQgOeGPe0LAWyAHg1mUK3yAfhKPtgRkxCrhwe+X0=;
	b=YFU/6U71fRTEiuUSXce8nWIkJ+y3C+flEf3H0Lf1WQQygHT6bvq1I4udjmtEzybiRLjMQn
	DgMasrgCUnfq6fCg==
To: Bert Karwatzki <spasswolf@web.de>, jstultz@google.com
Cc: Bert Karwatzki <spasswolf@web.de>, Metin.Kaya@arm.com,
 boqun.feng@gmail.com, bsegall@google.com, daniel.lezcano@linaro.org,
 dave@stgolabs.net, dietmar.eggemann@arm.com, joelaf@google.com,
 juri.lelli@redhat.com, kernel-team@android.com, kprateek.nayak@amd.com,
 linux-kernel@vger.kernel.org, longman@redhat.com, mgorman@suse.de,
 mingo@redhat.com, paulmck@kernel.org, peterz@infradead.org,
 qyousef@layalina.io, rostedt@goodmis.org, vincent.guittot@linaro.org,
 vschneid@redhat.com, will@kernel.org, xuewen.yan94@gmail.com,
 zezeozue@google.com
Subject: Re: commit 894d1b3db41c leads to frequent hangs when booting
In-Reply-To: <20241211182502.2915-1-spasswolf@web.de>
References: <20241211182502.2915-1-spasswolf@web.de>
Date: Wed, 11 Dec 2024 20:19:02 +0100
Message-ID: <87wmg69gex.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Dec 11 2024 at 19:25, Bert Karwatzki wrote:
> I tried to debug this with CONFIG_LOCKDEP=y in v6.13-rc2, but using CONFIG_LOCKDEP=y
> makes the hangs disappear or far less likely, and I get this warning
> (2 examples from two boots):
>
> [   17.203857] [   T1337] BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!

config LOCKDEP_CHAINS_BITS
        int "Bitsize for MAX_LOCKDEP_CHAINS"
        depends on LOCKDEP && !LOCKDEP_SMALL
        range 10 21
        default 16
        help
          Try increasing this value if you hit "BUG: MAX_LOCKDEP_CHAINS too low!" message.

Can you increase the chain bits config and try again?

Thanks,

        tglx

