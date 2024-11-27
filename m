Return-Path: <linux-kernel+bounces-423775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE3B9DAC82
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 18:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 310C2280F48
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 17:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24340201022;
	Wed, 27 Nov 2024 17:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZHQRtxIw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TfP3mvnw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DAA13D502
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 17:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732728787; cv=none; b=N2EipdHY0KqhbrN/V5PQbMRti0bZ9NEA1ijz2tMc9yGMxWaTc3UhjTheu+3FKEN5c4vH7xXOGhDE0iBEMrdcLdde3RXXbVnKkXRSQWqAFzgmJDjohQloB/650KXb3R+8+NjVq0nE2ql9jbOyPD3quVxMqa/S0yDCxTfW0F8yPfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732728787; c=relaxed/simple;
	bh=XwQ24lKoGaM5yXflzJpqUoVfC1FC+JZBfBjFUVxpeWg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m5Af+rJ23IH4q+w5zoq3Wk2b3jPgwZPDkFvXlJTlwg+IfSxhOR1DbbcG1pKE4sKRSbsWF1ZZkZhQJdU46e+rP6rYsmjiuFt0/GuV3EElPAUNwqtDxfV4wWVewfqvSHiSIUjIk8zWZ1jn/YDJVh2+NjDThfRpO/g7SBcYfa06SQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZHQRtxIw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TfP3mvnw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732728784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y4g56DdkReUIpRotepUg2ZtJiooZ9BSk94Xid5oP+/M=;
	b=ZHQRtxIwqOxAINWpY+leKbj3lSDhcXICRZ2AZgosorUWYhM27qTZJAmHOwjAzSZy7sVXeP
	h4eQWGsSq8sSthM2hEbq7QyDlOwEECLJXWGafGekVYXr2mOTEbnef2h/rEw3wqDaRu8dyC
	TpKWnlpTfoTElXBCk1VfTSOed8+KEw2x0o3XuHiPJ1s3d7LC/4UKnAya4SGTA51Wcc9Ef7
	C2950MJzTSJMBdojDydf1Jr5At+e8dl09tM65MjIp8WcXQOl+hrLAAfFCnU7zYKVICaQgR
	hkENnkTMaeEjqUP9uZWVNDL8xFMuVZuSpvxiOepa0w4wmEPX0OYa0LXm+6s7Lg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732728784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y4g56DdkReUIpRotepUg2ZtJiooZ9BSk94Xid5oP+/M=;
	b=TfP3mvnwVhfIGZo2nzqTIXYMTH5ywwNvc2AjssSyFxkf6sULfKFmxCy+lk2WTnSiJLPh4M
	XTOkjv8u9Xf+QQAQ==
To: "Dalmas, Marcelo (GE Vernova)" <marcelo.dalmas@ge.com>,
 "jstultz@google.com" <jstultz@google.com>, "sboyd@kernel.org"
 <sboyd@kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Cc: "Dalmas, Marcelo (GE Vernova)" <marcelo.dalmas@ge.com>
Subject: Re: [PATCH] ntp: fix bug in adjtimex reading time offset
In-Reply-To: <87zflkydgp.ffs@tglx>
References: <SJ0P101MB03687BF7D5A10FD3C49C51E5F42E2@SJ0P101MB0368.NAMP101.PROD.OUTLOOK.COM>
 <87zflkydgp.ffs@tglx>
Date: Wed, 27 Nov 2024 18:33:02 +0100
Message-ID: <87wmgoy435.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Nov 27 2024 at 15:10, Thomas Gleixner wrote:

> On Mon, Nov 25 2024 at 12:16, Marcelo Dalmas wrote:
>> Due to an unsigned cast, adjtimex returns wrong offest when using ADJ_MICRO and the offset is negative.
>> In this case a small negative offset return approximately 4.29 seconds (~ 2^32/1000 milliseconds).
>
> Nice find. Please format the changelog to be within ~72 characters per
> line next time.
>
>> Signed-off-by: Marcelo Dalmas <marcelo.dalmas@ge.com>
>> ---
>>  kernel/time/ntp.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
>> index b550ebe0f03b..02e7fe6a0afa 100644
>> --- a/kernel/time/ntp.c
>> +++ b/kernel/time/ntp.c
>> @@ -798,7 +798,7 @@ int __do_adjtimex(struct __kernel_timex *txc, const struct timespec64 *ts,
>>
>>                 txc->offset = shift_right(ntpdata->time_offset * NTP_INTERVAL_FREQ, NTP_SCALE_SHIFT);
>>                 if (!(ntpdata->time_status & STA_NANO))
>> -                       txc->offset = (u32)txc->offset / NSEC_PER_USEC;
>> +                       txc->offset /= NSEC_PER_USEC;
>
> This patch is white space damaged. (tabs are replaced with spaces).
>
> I fixed it up to you this time. Please send your next patch to yourself
> first and verify that it applies cleanly.

And it triggers a compile fail on 32bit as txc::offset is of type 'long
long'.



