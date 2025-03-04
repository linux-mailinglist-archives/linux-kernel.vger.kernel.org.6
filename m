Return-Path: <linux-kernel+bounces-545542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0733FA4EE59
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 21:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A2753A949D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 20:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1105225FA09;
	Tue,  4 Mar 2025 20:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QChqHiPG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nySXIn4T"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DEC1FBE9E
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 20:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741120208; cv=none; b=XBOBPhP9ztXkSLEXlTFh0cHck24M4OhfCd3O37L6X3/NNHByK4KFP74bD50Aa7t98QbhPHY/e5Y0yKyIjzRgDIZ931KXVuCBI9ThuRf/il9VOmpbTPidHaQ+LwEzvhSGiVuhj5b8uYE4jZocCONWicipnw1q8bklyGppo5N23U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741120208; c=relaxed/simple;
	bh=n+XCb/mQEAvyAxQV+XgBHDE6MBmGaRcXkZI7v7tKpzk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k8nfxPa9wNdRsVxRNUFkUa5sCDO4dPrdG6l2i6F5MJl0ucBKLtxAl3zU3NWzogJgnp+Hq3M/Mi5lNLAx2PDFx26wnVhAKT9P61arqUQAfgiq/EDuURn30i4UDR+aS4EihJI6D7toDipmUA8aldUCBNd3nMdw99r+LZNmTONZwwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QChqHiPG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nySXIn4T; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741120205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tawQ88tVituZhPa5H5T3lpBwSfKDNHrvVgtDD+CYQI4=;
	b=QChqHiPG+CnvjO/82iHkHr0B6rZPgzrx84YI0CN76pOtl+4UVQHEaHcxI84EgHYsN8i02V
	IpWTawcy/nd29Ff7nK83zCdXk1/30084p2kgpqSwX3RaifwT4Uigl+pqritJ+j7Wf75Oq1
	tzNvL2QwEZtnmFQvYpmzCiRpBu4c8t4wRng6n/Y6m956IxzwQTjncU5yqtLLGy3FuOYi+t
	IKtxcU3YyTcDeBz4xx32gZulQa6lM5r/X/M1MTPygjXA/UC9e7CUbk/5QA9+ih/dSiWJWd
	BJzaMAu2l5pYjTxhNIb3hntUhFgK6oG2nq3Ncc0dEu71O0CMXHE3CfE5salwyw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741120205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tawQ88tVituZhPa5H5T3lpBwSfKDNHrvVgtDD+CYQI4=;
	b=nySXIn4T8CjjAkp1ZzKiHZ6kL47T+Yl7S7Wo2p0xYx7ivX2Y4LfpdDAk66BqNStm0WmSUx
	bd3KxpKcJiXzP6Ag==
To: Cyrill Gorcunov <gorcunov@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>,
 Benjamin Segall <bsegall@google.com>, Eric Dumazet <edumazet@google.com>,
 Andrey Vagin <avagin@openvz.org>, Pavel Tikhomirov
 <ptikhomirov@virtuozzo.com>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch V2 10/17] posix-timers: Make
 signal_struct::next_posix_timer_id an atomic_t
In-Reply-To: <Z8c-vvnMpPjYRvOn@grain>
References: <20250302185753.311903554@linutronix.de>
 <20250302193627.543399558@linutronix.de> <Z8YPQn0UpxucZLJP@grain>
 <87sentbyer.ffs@tglx> <Z8c-vvnMpPjYRvOn@grain>
Date: Tue, 04 Mar 2025 21:30:04 +0100
Message-ID: <87mse05yk3.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Mar 04 2025 at 20:56, Cyrill Gorcunov wrote:
> On Mon, Mar 03, 2025 at 10:24:28PM +0100, Thomas Gleixner wrote:
>> 
>> Welcome. Some quick validation with CRIU would be appreciated.
>
> Just tested in criu: works without problem, both modes -- with new
> prctl and without it. Note that I only have ran separate posix-timers
> test case, probably virtuozzo team might do more deep tesing.

Thank you very much!

      tglx

