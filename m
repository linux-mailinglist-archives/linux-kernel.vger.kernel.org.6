Return-Path: <linux-kernel+bounces-407148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1039C696A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 07:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30D0F283EAC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 06:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8DCC17DFEC;
	Wed, 13 Nov 2024 06:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3XFJ+1uy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FIPC+Sh+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9467175D51
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 06:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731480074; cv=none; b=gF0qCviuAoPKY7CTZoZuQU4GiFV6mKWMYiCszrw2IGG8DcAjSupMmzrjfG4RAiTdY0LpBOEkptH6griuAxj9lciPcjlPtLMlxIK5XOuWC/slk2472VS/NCCmuszLSLxquZqMQIzQ31YVD1DgXNTAzLVfv0oE0eBZVVRhFJUJOk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731480074; c=relaxed/simple;
	bh=HIH4/RRdPQpuWhdWgE971sWQUKB4qKy5gyFQuz0Qh3o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t7mifO+2RZYEbOR4XhyBnJR0pfX5qIJUp+Xh5jbvFROI2JSsILSFuS+FtpSNSO0th1R5q77oTMq0b+Dwy47lX3kFAbdmErAopFeno/NJhUoQGaalZpaERZTQ6WnY7uiXaRw+a5J/YbptHyq7pV3q4/w1QTDn0r9uB/8EOY4+TvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3XFJ+1uy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FIPC+Sh+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731480070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JRNvgkgyAq1nq2s+FmJibdkLS9j4evHhQhts6ydEE3Y=;
	b=3XFJ+1uyMPT3YAz61nx3nSMkvYXWjQMiLWZnkuLedBWgyZLnRFq6zTQ9snAmaEkshKWTR+
	i2wyk/p4VbkvjgyL0TwIjCgEE1KayJ6dgkUIH6x4bFUwIxbSbJNDxgGCL/8VIjBLETyDR9
	rhOR+ZvJmkXRypI6B5ysDRcuFJt0qU38VSV/i1gYi0z5GvqssgGa3iy82Vkdq3e8KRTiXJ
	5VymkvSZ4n48w4dZd82xpgwZS1eeXrkc9Gcu9jKxwn7pgQsOlo+acvEU7QQSeNSghzL2B5
	fzsjKwLrD02+n1jHHJNqgt/7TRpSWrVNZsQxssegZnNiW6x4ITKWzwUoLe5gIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731480070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JRNvgkgyAq1nq2s+FmJibdkLS9j4evHhQhts6ydEE3Y=;
	b=FIPC+Sh+Vq47vUS2+43S+5N47lk2kyiUgz/DgkC8ECgHTz4tg+oJICEMn53ZCRSEcBAcUA
	kY/Ag++xbnEP5SAg==
To: Luming Yu <luming.yu@shingroup.cn>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, mpe@ellerman.id.au, npiggin@gmail.com,
 christophe.leroy@csgroup.eu, luming.yu@gmail.com
Cc: Luming Yu <luming.yu@shingroup.cn>
Subject: Re: [PATCH v2 5/8] powerpc/entry: add irqentry_state and generic
 entry support
In-Reply-To: <B8D89E4E26FBB584+20241111031934.1579-10-luming.yu@shingroup.cn>
References: <20241111031934.1579-2-luming.yu@shingroup.cn>
 <B8D89E4E26FBB584+20241111031934.1579-10-luming.yu@shingroup.cn>
Date: Wed, 13 Nov 2024 07:41:26 +0100
Message-ID: <877c97my95.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Nov 11 2024 at 11:19, Luming Yu wrote:
> generic irq entry support via generic irqentry is added for powerpc.
> There may be duplciate calls and missing callbacks requires further
> work.

No. This needs to be a transition which is consistent and correct at any
stage of the series.

You cannot go and break stuff first and then gradually add hacks to fix
it up. Well, you can but don't be surprised if it goes nowhere.

Thanks,

        tglx





