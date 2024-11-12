Return-Path: <linux-kernel+bounces-405057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5429C4C84
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 03:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47ED6B2B6BC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 02:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0652120B814;
	Tue, 12 Nov 2024 02:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wBG0ZWJY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zOEMJ2Fh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC70209670;
	Tue, 12 Nov 2024 02:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731377774; cv=none; b=cE9OhErPge+lBLKafuDbuID4XByzQq+W+vdLzhIe1bE4+dB1pJt6O2+5Dfh0Aaxhko/6NXjFlSddifRZgv3WXe2iDaKe1wqZ8aFFyV/sZRkPDumPhgvEpkgMK1QErEjyh1srMGHH1ToFpso50xp8txR3y/XV4oSUkC6PoSzeldg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731377774; c=relaxed/simple;
	bh=9gCxh3df/uX39iS48E0ze88Zoy2lwQ8Ih/tMM1BCdWk=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bGtV19QFDu6RIKomgW12hKWf4kVG09gyvIh1pjooGEk3bPaDgSzXhd7Skc6aDPIHr7GwHhavq7FJhMutKMsAO3unjJkvikYioEUVge87Xmn7l8vKcL4B4gOSEIS7RGQyFIvBArWz73VQjPJpL8a/i6ktetYn81L7/HBKSmTwqsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wBG0ZWJY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zOEMJ2Fh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731377770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ObQV8GjwYWgV8qc9nnVOdFDBvJQxVf9HFS/fWcs3lxM=;
	b=wBG0ZWJY80vjYqRYfBmIzqDYRlJsm59BhzqF9I+UgpdHTp50AjeVHMx/0aRPuvIip1iXMd
	2Pzr7cvIhQd+P/ObXFOBvnPzNYbHBWO8iYRo2zxvZ3Zl7VLu57U9zQ/XWMfoM5rH1xKqqW
	Ipbd3wP3oANFuP9Js52ZAoNUFqfYWNk9foOI3wqdZO41v3Phwws0XDFDipo0r9aSBIBeOs
	7qNksGeN+DMN80U675Nmxh+7ZdOphPYNRADZeuQPIELASyoe2A6CKxzGesODXk1UQX85w4
	9iOqshA6VOCT6nnCGc9Xo77QvFSIPjEa3RXimDW+tq4AxrTsmNqmbL3XEAeMEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731377770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ObQV8GjwYWgV8qc9nnVOdFDBvJQxVf9HFS/fWcs3lxM=;
	b=zOEMJ2Fh1oe5xZW284Q+dLRowT7jQPPt1tadaJ2fsAsOtX8E0WgtecwyYqygsxKnF1+hAl
	SzabHpDBND/7g3BA==
To: "enlin.mu" <18001123162@163.com>, 18001123162@web.codeaurora.org,
 enlin.mu@unisoc.com, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, hch@lst.de
Subject: Re: [PATCH] proc/softirqs: change softirqs info from possile_cpu to
 online_cpu
In-Reply-To: <20241108162225.19401-1-18001123162@163.com>
References: <20241108162225.19401-1-18001123162@163.com>
Date: Tue, 12 Nov 2024 03:16:13 +0100
Message-ID: <87ed3hnqmq.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Nov 09 2024 at 00:22, enlin mu wrote:

> From: Enlin Mu <enlin.mu@unisoc.com>
>
> like /proc/interrupts,/proc/softirqs which shows
> the number of softirq for each online CPU

This changes the output format of a file which is used by various
tools, i.e. this is an ABI change.

Did you validate that none of these tools relies on consecutive CPU
numbers even when CPUs in the middle of the number space are offline?

Thanks,

        tglx


