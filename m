Return-Path: <linux-kernel+bounces-379496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D199ADF53
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 10:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40FD51C21598
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 08:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCB21B0F12;
	Thu, 24 Oct 2024 08:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rCzlAipl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ND0EAKfK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F9123CB
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 08:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729759213; cv=none; b=IrVRTC5znz5kRTc4G0QoKRDE2spstXaJyxR8u27ug/uRpnxPdW5JVt09sfTv6fG4vxp3ntwV28XGWk1IyRyAVkyAD6EhfToeLL8FTbGS7KSsaGyR+zvDDA1cpwVya9AGftBPlfuUpegzrxPTlTKAfqz8BaAvzDQXMiMsdi/R7tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729759213; c=relaxed/simple;
	bh=GH4sHUH+M6Mz+xsmT4xdWXdaQnJXLi4N6ynxLcQLzmI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JcvEMvIgfjhrSzmFGL8emN/LV70MJaMZi67ppzgvEA7Jv8LpYNYZytNmRAyU7mZ0Aj7t8K+XpB71jB0B51EVPuo+bnCggM8sD57MLtSTsg19ZsemUHXPUS5iNl4WE6WMBrlIP9YfCW1TTRcwwJtYnpN5BrDpDg+0VHWkn5b4Ds0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rCzlAipl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ND0EAKfK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729759208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T8B9IRibMV60lb0GD3TOYQTfcm82IgNA9zQnomRsXlA=;
	b=rCzlAiplXy8o71dfaaVKlYO6+sd9F448bDvJNAHYnizZz2HSn8P8w73EzELytd1aWZlAld
	o1A+RKYO4sYbR9cVFaPls59oaM9u62M8U74FMNF5OEUAKgcJss5Txs9U8uTOTf7+848wAn
	tgNVVD61qwo6ZnmXauUim3OG+V603RysQuT4wSK/LSsS6ZnFN5eCq6oM9Rj23Di2MhEdW6
	6JlIJCMNwkVcbyd+qZI1h3mSWwFlL/K/5nkXY1puNbyhG5JwWjbodUE9Dg0Pywc0nEZmEb
	yHzOF19OvUjtvTbFHMjTcSm7Xsr47rUe4S05pYF8wg9HNsDGStgkkANUEei6+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729759208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T8B9IRibMV60lb0GD3TOYQTfcm82IgNA9zQnomRsXlA=;
	b=ND0EAKfKI4H0pP66HEFqQf+R96BK1L7WsmQQGYOYTCn4P91KV/72edF8PlFxj3gDNdWBU5
	jVdrftpoCjgsJECw==
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, John Stultz <jstultz@google.com>, Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Stephen
 Boyd <sboyd@kernel.org>, Eric Biederman <ebiederm@xmission.com>, Oleg
 Nesterov <oleg@redhat.com>
Subject: Re: [patch V5 05/26] posix-timers: Drop signal if timer has been
 deleted or reprogrammed
In-Reply-To: <ZxZJPnqsQygi6juI@localhost.localdomain>
References: <20241001083138.922192481@linutronix.de>
 <20241001083835.553646280@linutronix.de>
 <ZxZJPnqsQygi6juI@localhost.localdomain>
Date: Thu, 24 Oct 2024 10:40:08 +0200
Message-ID: <87ttd16gif.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21 2024 at 14:29, Frederic Weisbecker wrote:
> Le Tue, Oct 01, 2024 at 10:42:06AM +0200, Thomas Gleixner a =C3=A9crit :
>> No point in delivering a signal from the past. POSIX does not specify the
>> behaviour here:
>>=20
>>  - "The effect of disarming or resetting a timer with pending expiration
>>     notifications is unspecified."
>>=20
>>  - "The disposition of pending signals for the deleted timer is unspecif=
ied."
>>=20
>> In both cases it is reasonable to expect that pending signals are
>> discarded. Especially in the reprogramming case it does not make sense to
>> account for previous overruns or to deliver a signal for a timer which h=
as
>> been disarmed.
>
> The change below indeed checks if the timer has been deleted but not if
> it has been reprogrammed/disarmed/reset.
>
> Or am I missing something?

No. You are right. This is a change log left over from a previous
version. This rearm/disarm part is handled later in the series.

Thanks,

        tglx

