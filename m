Return-Path: <linux-kernel+bounces-559217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F61FA5F0FC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 11:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0AEA3A5003
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 10:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22F01F0E21;
	Thu, 13 Mar 2025 10:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c1wmXgcO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KDxaECw2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99EC16BE17
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 10:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741862040; cv=none; b=Hwpgm5Wd0mqNaodgkdxWDrz4NFLQCEtUS2LM/UA3vNsTGbAACp2Rvkr9KUCKlbrOtoyVNZ1rNeAgxr/U/xMAiGdcE+V1kh5B9g23/VKBXFqLnUP6EucwR6LczyFzOCsmIh22ZE5Qtik/INPOwWVSaez8+78pCO0v3666oZ36A3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741862040; c=relaxed/simple;
	bh=SN011RMdz1vz0Wnkcx/y2tFxaRlzN6Rhm0YK+fKdIWo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SejRHzsFQUKVDGDudwbOl7pYQpkUTKOokkn0xsBMK4Oyfa21wNfqxsXx/DnWMDxz+9jTVcu34ZxzI7kaXPdkf2M5kR8uR1UHmI7FumLl1bCxuP1iMarKlDhFzdPJ7DvfeOzX5iKncX47wItk+J3wctBJJ4SSRMmygwnAXWMG0Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c1wmXgcO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KDxaECw2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741862031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NTck8EuQDGS3CLlMJlTc9cE3m9iG7IO9MhpulxMfCEc=;
	b=c1wmXgcOd4yJ7CEhB0fQFsz9klj+0NvBisyoEar5NeJwE09pPyQ2kMLQarYJ5dSyASuM45
	MxDlpnAKJE0oKauTQ0TmHiJ4ZBfVAvkVNNokRF0IijZm7IgE6MscEAbFMkg9QfO+vZ4ydC
	l2mPKRUThhmub9tHkfaLQlTPNbHhZBA5NRGxsnI/WAWwioiAzBqyFjA2hb/Nk3f0+r8o3I
	lte8Q5lCaOuruRR/Wk9cDbni5d1cNx5y7odKbMyf8tu+wHBmL48zuyziD4xkP41QKlLFeH
	Kn5Zn2wtHFtRI9Go+LZG3VinTAmIqEO0oK+wcVjpZgwAQbuezoD2iWzSeHuYCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741862031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NTck8EuQDGS3CLlMJlTc9cE3m9iG7IO9MhpulxMfCEc=;
	b=KDxaECw2t7UsyShu0oXgI4lQCNe5rBQBfNVzKjILRbNUP8pqkXGoZ0yrE3a/h/rL/NXHsR
	8+d2NUTSlAgizbBg==
To: Thorsten Blum <thorsten.blum@linux.dev>, John Stultz
 <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] clocksource: Remove unnecessary size argument when
 calling strscpy()
In-Reply-To: <20250311110624.495718-2-thorsten.blum@linux.dev>
References: <20250311110624.495718-2-thorsten.blum@linux.dev>
Date: Thu, 13 Mar 2025 11:33:50 +0100
Message-ID: <87wmctw775.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Mar 11 2025 at 12:06, Thorsten Blum wrote:

> The size parameter is optional and strscpy() automatically determines
> the length of the destination buffer using sizeof() if the argument is
> omitted.

If, and _only_ if the destination argument is a fixed length array.

That's the case here, but without that distinction the above sentence is
misleading at best.

Thanks,

        tglx


