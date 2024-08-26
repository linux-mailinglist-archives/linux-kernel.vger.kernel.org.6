Return-Path: <linux-kernel+bounces-300994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1BA895EB5E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ECAC281473
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AFAE13C677;
	Mon, 26 Aug 2024 08:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oV4BXd9t";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dsXcEODP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B87713B588;
	Mon, 26 Aug 2024 08:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724659492; cv=none; b=r7ECNt4LBh7Rios3+EIF5tbeUQoTYh2p8zDbT3G+mCGt1DH91RbHKbQT9RTBfUoAhEbaqEIZwj7D5eJ9cvuhpCfLxBY/xgM+g7al13XFtyPzxi18RkAuZ92TrIP+D2SNU0isLlPJCo+jdYo7eIpfMJW+mys+XQCB+JHgAphpNM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724659492; c=relaxed/simple;
	bh=y6cwMGReTgz04Iyy1OxxA59oi3cee4HEA0/Mn8IrGpw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XbhUAg80NQ6absVRrKo3ilL3V4Sl/OhjEtmn/r2rx64P5rsQhsvXajXwj6yS44oKYVoocPIupHQ6+0BZqvoQgQDPsV5VPzauC/zi8kJQxF8NJa/5phPpnnqwJeBzrxqkqxNz7H9DKAkvzSatmbypylnjzFSoOa9lNGVGdv/83bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oV4BXd9t; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dsXcEODP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724659489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LrRqXGGEsz0iA/YvCeblc9xm4n+0r6XNKKo5IDSa6KU=;
	b=oV4BXd9tFl9NM6gv/+c9u52+mU9C1Kz8HvBtXYtoMzNas0XuPtwK+oyuPDsPzjSqZDK7Cz
	4vQOqq84CHbEy8P+Zt+NIz2NdQ4ib5LpT0GciocDpVYRB45lk2SJcmv0AfrWPZFzz38AVQ
	S0WKizgtYxpVdEwmOi9l4KXm/JQe+G6Zp7KjYctn2cnQQeVaRhO1liWnLMplb3xOdlCB+e
	YtrAAJ/CoUfszVOZnqDBDDvHoLUKKInNL9OzD4NmR3eZ+NlTXr+NDyBGbqWGHbly7rsden
	FYuFtfDIlVFLTDQpXZd/fPW8ycYMfE70IO+rks5pwZh3SBBqSajcMR2QBZKDdQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724659489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LrRqXGGEsz0iA/YvCeblc9xm4n+0r6XNKKo5IDSa6KU=;
	b=dsXcEODPMFSkqEDpkejt5iO20tti+sFlo6V6jkgWC0HEnIYYaMSoExqkvt9NqKEtSAWNnq
	Ld3xbwoAABOB44Dw==
To: Stephen Rothwell <sfr@canb.auug.org.au>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Chen Yufan <chenyufan@vivo.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the tip tree
In-Reply-To: <20240826130137.631e5e31@canb.auug.org.au>
References: <20240826130137.631e5e31@canb.auug.org.au>
Date: Mon, 26 Aug 2024 10:04:49 +0200
Message-ID: <8734mremla.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Aug 26 2024 at 13:01, Stephen Rothwell wrote:
> kernel/time/timekeeping.c: In function 'timekeeping_check_update':
> include/linux/typecheck.h:12:25: error: comparison of distinct pointer types lacks a cast [-Werror]
>    12 |         (void)(&__dummy == &__dummy2); \

Offending commit has been removed.

