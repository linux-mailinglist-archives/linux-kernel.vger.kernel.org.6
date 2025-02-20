Return-Path: <linux-kernel+bounces-523152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C39A3D2CF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 09:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28EE83A638C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 08:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAAD61E9B26;
	Thu, 20 Feb 2025 08:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eNpic2d/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QCLrtVlt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A53249F9
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 08:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740038997; cv=none; b=QgHrTZjfhsiHTH7SgUHN87f+jBMO15dWOyxIAzmkbeZC39JODEtXlpu1zSZ7PrMfewQsNatwLo4rhFFbIlSAto7GnOzqrDZM9MvSuPr4s27xALsyzNymJay0jk0UGA64e5glD01Ttd8lriWcZxEy3TxzT+MAzQIq1Ybh/OZW3kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740038997; c=relaxed/simple;
	bh=i//B90PkzV7wtJ2+oeAzYYdehz7FBTS2bwE5XLhqAgM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pYpjdphWpmi5XUVEj0Yq+xD6qhOnEjV5l5+qBYjUt71KpkmqfNcKv6e2acx2ub1QYUNLGQbje8igDx4G481RAlm3ZhlzrtXgka3OYnFKAlXRe9QUGy3ZGdzNWkIPKgMvLVZgBC0iIfyYdWDdJ9KfqKJBa5bcjtn1dpsCryeyWcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eNpic2d/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QCLrtVlt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740038992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e1m/Gvo0gLg79ykL56JzR29+XsfYklk8kAWUchCwIKQ=;
	b=eNpic2d/OrLE8pQXQCNfF5aTPXQZDr7Rk8q2mNpueRyr5kQ9Y2sSmxDiO9sxbDSUBMMX2z
	HBGsn72guvg9HOO8S9PNApk08bJtOlSo2lmxSmkkbiKF+zSdhFhpQGxGxEZHqEt5FtfMCs
	gDWAVidoNbMcthO0/9j0GE6R+5XbXqKv6pESffG/B3sCgln/hb5F1mkAgSn+E5YJXMfHjL
	wtqdkcOuS2dwKTShgu6HRziXOwIDHYbKS1BtBl1l1vWxKKeqhrfOzU2C2EQxKjTcPKlj1R
	SbavETPUrrTp+FVAjNj4FnHi5c3/DQMLQ4XNAZSfyjravoe1ILt7Ad6NbhxmIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740038992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e1m/Gvo0gLg79ykL56JzR29+XsfYklk8kAWUchCwIKQ=;
	b=QCLrtVlt4SWxRKg2bsHpsjd5HY3LCJFHkP49net0W7BFRyljnZuDNzKEbcY5D+7yFfVnV5
	HJ/YEMasIZdP0lCg==
To: Eric Dumazet <edumazet@google.com>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Benjamin Segall
 <bsegall@google.com>, Eric Dumazet <eric.dumazet@gmail.com>, Eric Dumazet
 <edumazet@google.com>
Subject: Re: [PATCH V2 1/4] posix-timers: Make next_posix_timer_id an atomic_t
In-Reply-To: <20250219125522.2535263-2-edumazet@google.com>
References: <20250219125522.2535263-1-edumazet@google.com>
 <20250219125522.2535263-2-edumazet@google.com>
Date: Thu, 20 Feb 2025 09:09:51 +0100
Message-ID: <87wmdlhwa8.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Feb 19 2025 at 12:55, Eric Dumazet wrote:
> Instead of relying on a global and shared hash_lock
> to protect sig->next_posix_timer_id, make it atomic.
>
> This allows the following patch to use RCU.

Your patch ordering is slightly off by two :)

And it fails to explain for what RCU can be used....

Thanks,

        tglx

