Return-Path: <linux-kernel+bounces-374315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D672B9A6864
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 14:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 984052834A3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 12:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B0E1E9089;
	Mon, 21 Oct 2024 12:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FTfTwZiv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jrFA/5hQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1229A1E7C09
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 12:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729513670; cv=none; b=pQK2gR02t8ZzVPsPrtg4TGHdVZ+5fOB88jW8QfxIS25kgY+UCKFdtZgjjU/lNYy6e5OWzsVKdj2/gqpGO/Sqyj6CNbozu98QtQ8VEOjWcy3ilhgtls3b5102aTl1cp+jPxqudMj4mQfXvfU5YECY/OI7xGJDVpdemtsdGvPC/z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729513670; c=relaxed/simple;
	bh=IGK5XyR7IlNtmOeaNTr+p/k+f61t96h/7mLGFkS+aUs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g8eoqn+Ue+d9BiL7JmDo9Go5U+LAMHbumZB8uEwrDFEWicRka79YiY0JSK/0co2CEaYG5xGnUe5v8eR6XxGizBvf62fX6gC69acz7pC6FTOHey0pQl3drtjIkEVqdvpgFn8JvmsWx1X+AFvPK+iVRlKmXAzVc9eEnqpNjEfuDu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FTfTwZiv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jrFA/5hQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729513667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=99jFXW/CwdyRcK8sGANnfyq1NG9lVOM4bAuwhhPMZ3Q=;
	b=FTfTwZivkJNNhVUSQLAGwI4zc3HGwCHeWIQA0KRcXWbxaIpgYlngv319X4Uv76M05mAzUF
	22eCKrIOuqvbcI7TaLpvYlkfncXaP3jLvoqqnuQeQEySbVqszPIhZgfAT3okHPkbOJUSbK
	IbAUIHTGs/UFQt+u8h2Dq2WY1lQY3mFC2kashseP/IUONO/GBVhPx/44NC/XeP8TRmY+sA
	rPvhpqHjdwUpCecLlwkzAQsIoTbLBz4IvJZD9/MN+/ESx2TCDXQwX5cOK9K5nNKizzSr8K
	cB8CTiksFaTuKECBpLrjbUpPCt37kSF7zqnqDK7iVzwxrDubIe7ybOm/S5EeuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729513667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=99jFXW/CwdyRcK8sGANnfyq1NG9lVOM4bAuwhhPMZ3Q=;
	b=jrFA/5hQfVqm9mel2IJlzbl//WFQCYPiYzZVO8TNDBHkNTn0/XLklq6P50n5V5eh1cGQiz
	7OE84fab6r5wXfBA==
To: Ryo Takakura <ryotkkr98@gmail.com>
Cc: christophe.leroy@csgroup.eu, hbathini@linux.ibm.com,
 leobras.c@gmail.com, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
 naveen@kernel.org, npiggin@gmail.com, pmladek@suse.com,
 ryotkkr98@gmail.com, sourabhjain@linux.ibm.com
Subject: Re: [PATCH] powerpc/crash: Allow direct printing on kexec
In-Reply-To: <20241021121159.331940-1-ryotkkr98@gmail.com>
References: <844j56v75z.fsf@jogness.linutronix.de>
 <20241021121159.331940-1-ryotkkr98@gmail.com>
Date: Mon, 21 Oct 2024 14:33:46 +0206
Message-ID: <847ca1fxod.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-10-21, Ryo Takakura <ryotkkr98@gmail.com> wrote:
>> Rather than removing the deferring, it would be better to convert the
>> console you are using to the new NBCON API. Then it would be able to
>> print direct and safe during panic. (printk_deferred does not affect
>> NBCON consoles.) What console driver are you using that you want to
>> see the messages on?
>
> I was working on qemu ppc64 this time but I am usually working on 
> Raspberry Pi 4 (mostly for fun and study) which uses either of 
> bcm2835-aux-uart or amba-pl011. It would be really nice to see them 
> working as nbcon!
> I am thinking of taking a look at [0] but If there were any other 
> references, I would really like to look into as well.
>
> [0] https://lore.kernel.org/lkml/87wn3zsz5x.fsf@jogness.linutronix.de/

The lastest version of the series is here [1]. The series is still
undergoing revisions, however the changes are 8250-specific. The API for
nbcon consoles is already available since 6.12-rc1. You are certainly
welcome to try to convert one of those Raspi 4 drivers to the nbcon
interface. I would be happy to review it.

John Ogness

[1] https://lore.kernel.org/lkml/20240913140538.221708-1-john.ogness@linutronix.de

