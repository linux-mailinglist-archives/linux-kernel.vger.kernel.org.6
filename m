Return-Path: <linux-kernel+bounces-243712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D4192997D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 21:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E23AAB20BA6
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 19:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE17C6A022;
	Sun,  7 Jul 2024 19:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Yjs0UHnv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LgeQIs6Q"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBC137700
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jul 2024 19:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720380038; cv=none; b=tgHnEwpgh9CMFUD6noSZ3amGAbvG9anleH2Q/to+rC8i70W6eDqrkzebKvrzVa2ZL9xMWTi2OouVNjqXr6NXaZxHEXUJ436AQN9BQnQK2sF0rfc3AB87ydi3XPAvcc1uGd7jp4a8OhBGVsmcPJO8LtXR07eMxmAGIRlfilknGVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720380038; c=relaxed/simple;
	bh=mZXewmgHh8cpeSWGmm0uE8hF49EfWZWsw1JyR6TLfl4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ua/CQvPrIDudyBz5/a/2MGoH1IcF5MlCEpkXL1gsrYgjCNbXddXKNCeGQ++EbUEZfQNIfvCnTx4uqPrhPOOkRdQMG+75ppyjbxZEmTBPb/EdKk6ZTO8cYmwVH+1IridYJ3rj+xPYaZXoaYBSXKQeF4TE6KOxIHmSyMljbnPqZyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Yjs0UHnv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LgeQIs6Q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720380034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mZXewmgHh8cpeSWGmm0uE8hF49EfWZWsw1JyR6TLfl4=;
	b=Yjs0UHnvAzgF/mnmsHD3tH8HWk4aZar4tjPliF/5yU2UaT8RelJ1Dw2Mh6uIE2xRsbTxRR
	6ZowPC5Ly7UCjfCbvoGYAghQMpCbYTHPDxDU3Iftj+O2z/Rz0yZUQQTDHACTr0syIDlNoq
	EUgnjSycNyXAAj6yWqinkR9qdQbfNpjVfzG06tVxauuH74ruYXQoi+9eLXwRBmviybATvA
	+uKwo4dJfR/OSbs3HcXvUFgdeQRmtdMaZFo1uTdl8ZIcHbOTR0xDUEfZwscUnOr513xW3g
	4IBpSMQYA2emlwmqGCgYsImKfwwH2tOUIf0URU/d7t1z9PtNQrS5mOa2LLVvZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720380034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mZXewmgHh8cpeSWGmm0uE8hF49EfWZWsw1JyR6TLfl4=;
	b=LgeQIs6QB9CCthu705fyD4Jk21tEhjXLppnl0LRibpE42nrLO+ACsSaTWofXhpYOyD/42w
	vVjPJSOgh6v32aCA==
To: Kees Cook <kees@kernel.org>, Jinjie Ruan <ruanjinjie@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, oleg@redhat.com,
 peterz@infradead.org, luto@kernel.org, wad@chromium.org,
 rostedt@goodmis.org, arnd@arndb.de, ardb@kernel.org, broonie@kernel.org,
 mark.rutland@arm.com, rick.p.edgecombe@intel.com, leobras@redhat.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 0/3] arm64: entry: Convert to generic entry
In-Reply-To: <202407021358.D259DF0BCA@keescook>
References: <20240629085601.470241-1-ruanjinjie@huawei.com>
 <202407010839.125126F@keescook>
 <ab934094-ec54-b580-512e-199017ca99fc@huawei.com>
 <202407021358.D259DF0BCA@keescook>
Date: Sun, 07 Jul 2024 21:20:33 +0200
Message-ID: <87ed85vwji.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jul 02 2024 at 13:59, Kees Cook wrote:
> On Tue, Jul 02, 2024 at 09:01:42AM +0800, Jinjie Ruan wrote:
>> It Seems Thomas only sent it to me without a public email.
>
> Ah ha! Okay, thanks. I thought I was missing some discussion somewhere. :)

No idea why though ....

