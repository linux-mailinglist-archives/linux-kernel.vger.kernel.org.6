Return-Path: <linux-kernel+bounces-302273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F9F95FBFA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 23:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B2421C220DD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 21:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D98B19CCF3;
	Mon, 26 Aug 2024 21:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="enqoMCoV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QFcxmrsT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AAD19CD13
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 21:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724708768; cv=none; b=D9w5Apmgi3srPVcxZ0jApocawTvobf6R72YIRLMryEIMbNrsuJAFZIYeTY9JYLlx85L7hx1RWiwM9gh8U1+AZfk3T19TxoteRi/FPTEFq9JvpvYgKe5KC+m9USkAl/pOyotdW4HZ3c2tyxdlfzxZ2fhdJ2Ibx13QOFJlFnqqID0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724708768; c=relaxed/simple;
	bh=Ns6vBlFWgisuPvXoJSQcTucQYxtf52oJTH2DCd5k6jc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dCYFQMqatrduWcs+GAkwtMXOiVirji0vd/R7xif7NySGe7a9qyH7mmyYy8hl+Gub6P/ZHxsQFX1whExlYNJqHssApKJzhLN/d3y1i8Iqk72A3tTJ35E+3Q8dumweymU/X0vP1gGf7IM3NMDzuTr1YweGDdDi9ZMtm4W6rOIjN4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=enqoMCoV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QFcxmrsT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724708760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c8+aGTYdPZN3BZHNO+QX2znPkGwizoE4MxV9R2pXW70=;
	b=enqoMCoVbqX6VEwnLNmHfaVG2JNf4gBpgoDsSjczuftgVOf+LyvCrMPpwRkvqCAut22FO0
	MWQmY3Tq2c9Y3oEnhCtn9QDYp9tHdMKxUFqGT1+NqKwflqUwJt6zrdxqn/5N6XNWZx3551
	cl/eAufLpfuLB+IPNw5/XFMVpDO6qAy8d/uQCZRcRGlk4SgGzCRslRT6EDwK8f+DZtfuJb
	xbFbsNDw9hbBiRXtBdLBPEa7IAoib2cGSvxaeSzG8Y6Y5vNShZON09ME3OdRQ4YVUB0VHf
	jrJspbyu/sk/SZ0oyGmXliHcRFZh38VfVGZW8SfYpiHE78rAVYbOMS8GmCQf/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724708760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c8+aGTYdPZN3BZHNO+QX2znPkGwizoE4MxV9R2pXW70=;
	b=QFcxmrsTPvpq0wqcNf1Gckp2MU2VBjxR+g7ep5tslD9IKIiEc30YsJJeWz+8ZIlRLSIp4o
	i13qEIah+ZEKQzDA==
To: Chen Yufan <chenyufan@vivo.com>, John Stultz <jstultz@google.com>,
 Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com, Chen Yufan <chenyufan@vivo.com>
Subject: Re: [PATCH v2] timekeeping: Convert to use jiffies macro
In-Reply-To: <20240826032734.7570-1-chenyufan@vivo.com>
References: <20240826032734.7570-1-chenyufan@vivo.com>
Date: Mon, 26 Aug 2024 23:46:00 +0200
Message-ID: <87frqrc607.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Chen!

On Mon, Aug 26 2024 at 11:27, Chen Yufan wrote:
> Use time_after instead of using
> jiffies directly to handle wraparound.

This kind of terse changelog is really not cutting it.

There is zero explanation why this requires to change the type of
timekeeper::last_warning.

I also fixed up the subject line for you when I applied the previous
patch and you got an email when I applied it which made you aware of
that change.

Please pay attention to such details and stop copy and pasting a boiler
plate text into the change log. I fixed it up for you only once.

Thanks,

        tglx

