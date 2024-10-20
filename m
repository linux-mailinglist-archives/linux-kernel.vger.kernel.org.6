Return-Path: <linux-kernel+bounces-373446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A18829A56B9
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 22:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48C7E1F21EC0
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 20:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E705B1974F4;
	Sun, 20 Oct 2024 20:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Uif+QDAT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8MLJ6yVf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55166EBE
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 20:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729456893; cv=none; b=Dz0u7r95KdPseTUcTaMhowqJaR/cHzxa1WGI57eh/XjByd1QPRVYDtkxWsvdl5KBxvMNuMuQt6ZVUtuhUHqlAxwgbUbHVZ+EqyMmOXB/+4udMIgssobV00fwZiDnCt/2u4wFX2UncuczhNrMMXjwKeD3/85bJNfA3QTdxgjkAYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729456893; c=relaxed/simple;
	bh=tKIYY93z6ZYfngRWP/RsHLeLinoN7aNllab37ooFVzM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YUntOss8iaX7MlGNXucpQwqGHkgUO3MgU8ghVAT3fwfMq4BMeETMpCSLlxX2RLFHTnFRUyjOCOxuBVfldxPDNPwY+kr3FUuSF6AFmXjYtYi+52gx3jwIo2NLmuWDSfyZHa3nEK1BhPR6oJKYk/bf95up3IA1NuyWlLv1qu70eZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Uif+QDAT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8MLJ6yVf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729456889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GXCHDEQcm8YdN8F1iwjzE6iyroHSAz0L4jbGCcItr1Y=;
	b=Uif+QDATu7vVQXyUT4WrkPkf5V3xQI+9bKdPfS34vwzdyPWZlWKY3UH5nzwqpArLJruZ9z
	hGp2Mf2T97eNm19LYpchfVWy+rgJa551pgVuUSulKZjuIF0D1NHLKa2h3S6b3jPXATLQtc
	omISRON/QzgoAvRiiTNryiaumewY93jrx96jxB8Dz7HVdASwc4cT+M6PiVvusnnNz3VY/r
	q8fnzZMjxvJSD+lQnlU18kyZ7ZtfcS9eZ7S5DgATXL1QXGJzbGwX0iylkDK9nW4QsUn9IT
	T7fZBm7hA92oVjs3JBcoBM11Fv0HAtQY1AHfqUEgcmvPmsNVforCGOQRxL0FDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729456889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GXCHDEQcm8YdN8F1iwjzE6iyroHSAz0L4jbGCcItr1Y=;
	b=8MLJ6yVf5L/ODBLGiCSy6Vtul+9dPVFi7xz7Cwedcm/BFROxM5l0kuSsDKaAhihuGadhAK
	B1xaNPOR02IRFxAg==
To: Ryo Takakura <ryotkkr98@gmail.com>, mpe@ellerman.id.au,
 npiggin@gmail.com, christophe.leroy@csgroup.eu, naveen@kernel.org,
 maddy@linux.ibm.com, sourabhjain@linux.ibm.com, hbathini@linux.ibm.com,
 leobras.c@gmail.com, pmladek@suse.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Ryo
 Takakura <ryotkkr98@gmail.com>
Subject: Re: [PATCH] powerpc/crash: Allow direct printing on kexec
In-Reply-To: <20241020071755.328706-1-ryotkkr98@gmail.com>
References: <20241020071755.328706-1-ryotkkr98@gmail.com>
Date: Sun, 20 Oct 2024 22:47:28 +0206
Message-ID: <844j56v75z.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Ryo,

On 2024-10-20, Ryo Takakura <ryotkkr98@gmail.com> wrote:
> Let legacy consoles print directly so that we can see messages on kexec, as
> the commit b6cf8b3f3312 ("printk: add lockless ringbuffer") turned printk
> ring buffer lockless and there should be no worries panicked CPU 
> deadlocking writing into ringbuffer after shutting down non-panicked CPU.

It is correct that the ringbuffer is now lockless. But the legacy
console drivers are not. Allowing them to print directly in panic can
lead to similar effects that commit af2876b501e4 ("powerpc/crash: Use
NMI context for printk when starting to crash") was working around.

Note that although printk is deferred, it is only the printing that is
deferred. The messages are landing in the ringbuffer immediately. So
they would be available to kdump and crash kernels.

Rather than removing the deferring, it would be better to convert the
console you are using to the new NBCON API. Then it would be able to
print direct and safe during panic. (printk_deferred does not affect
NBCON consoles.) What console driver are you using that you want to see
the messages on?

John Ogness

