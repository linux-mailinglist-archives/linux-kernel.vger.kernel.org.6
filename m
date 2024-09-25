Return-Path: <linux-kernel+bounces-337959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8160E985179
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 05:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BA9928357B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 03:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE19C136345;
	Wed, 25 Sep 2024 03:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="OXC9OlOP"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51768126F0A
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 03:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727235317; cv=none; b=SCzq9d5nag0KWxTLJCJO3oe4Q9GeJZbB/aRg+JP1TmleQg0kVdwdt0Ig+nqvloP+lLZptn6BUGV2cdnX9rrPkLTFOFFhU2wGcrlm8SVMn/EHtnpDyxTLnV2TwHxyAyaaNK8nIcL3+xgt9eixFZGKftFN5KJ9ykWQzv9eyZip+ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727235317; c=relaxed/simple;
	bh=iLgtg90wOeliSlqQMnwYaJCPtaKqSDrREFsW38kY/1k=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=asZ7VAg1DnT2Z03actU2ochsTveDec/4iQisiy8+VXz+3xfRYvJiOUwg4Q55B3aUHZNGogxwRDbSjuUEM2CnfDtf5A4885FC+gaOh+xeSThxkiYNcHUPpSEqGNqoFecfJnj/dxhYpjblmls6cnCRZZ4pIxX58Y9RJTEwH35Ft7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=OXC9OlOP; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1727235307; x=1727494507;
	bh=iLgtg90wOeliSlqQMnwYaJCPtaKqSDrREFsW38kY/1k=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=OXC9OlOPakLXZFM6M4Hf9ts/89IoFeYhzgj3BLwaOEr14Ak7HZGZmvPhEVCAkWHYI
	 vfgAPntoEjnnxK1yBIULLJtWknLcoHSbFThTLMdZYkDJ34FizsWQiNhKaVrNhDKFsv
	 hqB92LX8k+cieXCQ5jtVkCYSaiIm/JNzRr2IGOhaqRqHcq6GA7XHWCIRqJ0uE1x9NK
	 FdoRYTTrRTp3VA2/ZgyROXpJiuH7EfYkBIz8btXIxgkBHNF25swu4cBhsSF2/qsjh+
	 KpwjO+iSYRqXRGPGJ73xLYBf90uZhbhobbTzioQZUtbqfTDZwq1+S95Nwlctvb9zhz
	 r2AGL/Dn/YYgg==
Date: Wed, 25 Sep 2024 03:35:01 +0000
To: Peter Zijlstra <peterz@infradead.org>
From: Michael Pratt <mcpratt@pm.me>
Cc: Ingo Molnar <mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [RESEND PATCH] sched/syscalls: Allow setting niceness using sched_param struct
Message-ID: <pOIpWW9nGoJJKFRKRfj0SCJr5LH9bCDGcuNDMSB2Uo1sYLeFJGmJIa6_gvj3UZGH7bpuHut02MEPuEA-mAvBH9fymaf2IELMF_MBFuMWs0s=@pm.me>
In-Reply-To: <20240916111323.GX4723@noisy.programming.kicks-ass.net>
References: <20240916050741.24206-1-mcpratt@pm.me> <20240916111323.GX4723@noisy.programming.kicks-ass.net>
Feedback-ID: 27397442:user:proton
X-Pm-Message-ID: c5894c849814c552b10b65ace28f8a7c741053c5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Peter,

Have I addressed your concerns?

In my opinion, this is a simple change that adds ABI functionality,
without affecting any other parts of the syscalls involved, whether breakin=
g or non-breaking.

Like I said in previous replies, POSIX doesn't allow passing a negative num=
ber
as a successful value, and setting the static priority directly can expose
the scheduler to invalid priority values for CFS policies in later syscalls=
.

As far as I can see, this is the only way for usage of posix_spawnattr_sets=
chedparam()
to be both compliant _and_ functional for SCHED_NORMAL and SCHED_BATCH.

--
Thanks for your time,
MCP

