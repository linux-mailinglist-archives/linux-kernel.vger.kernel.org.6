Return-Path: <linux-kernel+bounces-189044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1BB8CEA44
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 21:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18B511F2120C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 19:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9CA57880;
	Fri, 24 May 2024 19:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KRje6Bgk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WfH3Uryk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782CA50263
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 19:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716578781; cv=none; b=HQ6psGF3eADybbPxJJieTeW7PvwlXyvsTH3PuamRjUnVK4p0BErp1LkuqoeksghfFrlgMIJ+edXiNYDsCGG39NW5PVAUFfzR2pGV9N+NghPzrUcdEE6jxoJ4zrn4CPMKtdVmDnSgGJkUBKubtT50bQ3d10qj3azCKe/rkIWKMwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716578781; c=relaxed/simple;
	bh=P73nN7b0ZF5GDD8McawvIj57MLNCTvFxZ02b3XMg3qA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s4YUridyT2vRacgQQDjkYpuzm1SEi9Pk1z9OehTyfGD2t2+BUTefsJlhuqjI636lyu+6M+NR0o6gP6YYST4zVQs1H1HuMUJZyv6OmuvIm4tW37oSYkPos4Fucu9BoKgi4V4IOBOqRS0XQodE7CLKzg7V4+RVzPu64iMa6kgo3jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KRje6Bgk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WfH3Uryk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716578778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G5i5L+hfuZyIpGJR1gtPKtKkb1VD3m9VEiDvJIPGdNw=;
	b=KRje6BgkmpNSc9bG6Mnn5DIxlZXhWleNqf+DL90RUGmZrGmznNplpNafssatOnFWbjzBCo
	WWgLHWOKN5nFl6iS/MNa5S4EuB3WI9mRpNTOThAkw7hYgXtD2uCW692ptJHjq2CsuZNY21
	IyJ8nE2WKTnp3a40gTqGUhh82N5A36dfqWSxg1nZdI/gNR3T0hXP3T6XpFsHXLl8oDpc39
	N2NrURPMQQDNs3/TC0y0NImGKUWEa3/NjrEsfZwDBBj4YhSfZorG+ZA4LPCQP/mVCzJKSD
	mXpU3Dt4NE0KSAvf8zKriwWAhlNA34FODlTcqHfiYQaKGur3Cg0QNseKP+nzzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716578778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G5i5L+hfuZyIpGJR1gtPKtKkb1VD3m9VEiDvJIPGdNw=;
	b=WfH3Uryk8PZSdlT5dlxLSlPzwYJXKGQwgnUk3LcSO01o+soanFc6Vo9eJOxm8EJo4si8lF
	1IRY9Iuzp5A7AlDw==
To: Breno Leitao <leitao@debian.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: paulmck@kernel.org, "open list:DEBUGOBJECTS:"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] debugobjects: Fix potential data race in
 debug_objects_maxchain
In-Reply-To: <20240509110612.768196-1-leitao@debian.org>
References: <20240509110612.768196-1-leitao@debian.org>
Date: Fri, 24 May 2024 21:26:17 +0200
Message-ID: <871q5rdnae.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, May 09 2024 at 04:06, Breno Leitao wrote:
> -	if (cnt > debug_objects_maxchain)
> -		debug_objects_maxchain = cnt;
> +	if (cnt > READ_ONCE(debug_objects_maxchain))
> +		WRITE_ONCE(debug_objects_maxchain, cnt);

The data race is actually harmless as this is just used for debugfs
statistics.

I'm pretty sure that the rest of these debug variables are racy as
well. Can we please annotate all of them without waiting for KCSAN to
detect them one by one?

Thanks,

        tglx

