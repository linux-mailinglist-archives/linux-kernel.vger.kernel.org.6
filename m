Return-Path: <linux-kernel+bounces-312398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE2696960D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 09:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57009280A4B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 07:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008F81DAC77;
	Tue,  3 Sep 2024 07:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Lq4IxXAG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x/j6Wkvt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30551D54ED
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 07:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725349787; cv=none; b=DUOiQ4YlLU82Z6O0k5lc716AMACOB4mze3h7vonPGbkXrCmhEwGrVGX7G1w5EytDH66dO58KPVtkk7lWJuF0fYEI1+5hFcFC8PD3lptnC74pCSBo56+vOrOrCufTvJ85p7thrrx+De296zLwqd6qS3q9EjbcAexXV3WGSyax814=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725349787; c=relaxed/simple;
	bh=kHfUSFzQ8vtqQ2Z5BEEf+dqKFTTT99BCS7+IWpmNtzI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kJZakWC8ZaLTdfVVZlwhyhySISs6ueDGc7Y22ap6X0snpzrV2mT+Th3iZSHe68gbbU/oGcNkScTT5jLUkxXmlOwF18QsReHjxOF1sEFdAjefZuIjKyZrl2jWDodWxl1uje0IbmfPfDTGFO8vvuR4NntYnzOXC4p4FudTUC3QoZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Lq4IxXAG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=x/j6Wkvt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725349783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kHfUSFzQ8vtqQ2Z5BEEf+dqKFTTT99BCS7+IWpmNtzI=;
	b=Lq4IxXAG4F7CIqCSsb4Ex3zWPae/swJdYDGxAtb5EMcNUdDC1ECjri7DoY7WJgD8O9hIMR
	BfmlVTvxgea3xQ58xmd1MQ32ozjTAXCbli5YqSyRnt9saOtlsOElVklB+0wMU87/ZAMXIz
	vQ1p+RtAPWM7NSct2x/JGAPvEc9BGHAQEei13y31Dm+S7pE66Ht95PuGiiRmuD7Dm0O/0u
	LZWEDKT7iGXPUrVBaihZByNJxORtFlQ6zV70MbPmnaRK8gtnlG+45DMwejCbtrohAzOzkW
	od9HFAw8sYlkgZfpfMpTQhrt+ZNnk0hxzAWLUglht8KYdBQo832a6ci7M0npYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725349783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kHfUSFzQ8vtqQ2Z5BEEf+dqKFTTT99BCS7+IWpmNtzI=;
	b=x/j6WkvtIqASu7GseRKn2IxUBY5TN+LCrmmsD51b6QW9tSVD+pMr7Jc2fdqguD0nYg8iP3
	+g97773c6msCQUAw==
To: Jinjie Ruan <ruanjinjie@huawei.com>, pmladek@suse.com,
 rostedt@goodmis.org, senozhatsky@chromium.org,
 linux-kernel@vger.kernel.org
Cc: ruanjinjie@huawei.com
Subject: Re: [PATCH -next v2 RESEND] printk: Use the BITS_PER_LONG macro
In-Reply-To: <20240903035358.308482-1-ruanjinjie@huawei.com>
References: <20240903035358.308482-1-ruanjinjie@huawei.com>
Date: Tue, 03 Sep 2024 09:55:43 +0206
Message-ID: <87ed61jhwo.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-09-03, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
> sizeof(unsigned long) * 8 is the number of bits in an unsigned long
> variable, replace it with BITS_PER_LONG macro to make it simpler.
>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
> v2:
> - Add include.

Thanks.

Reviewed-by: John Ogness <john.ogness@linutronix.de>

