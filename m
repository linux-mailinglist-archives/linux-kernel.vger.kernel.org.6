Return-Path: <linux-kernel+bounces-296283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3D495A897
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 02:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3117D1F225F6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 00:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41E64A3C;
	Thu, 22 Aug 2024 00:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z4QppVcw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y5lOjtXC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BC523B0
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 00:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724285526; cv=none; b=HDKtjvzCuv9nOfTytfe/AxT+AO7RCzccpgHqUCG1YehGyV6Hl5cxQvgZu88hF7oTrXuhtzbWhAAY2hyPQ8QvM5OOTg5mBJYrHhn1kkWBfUZqIECwZBjA7C4FMmWFFWVF89DzV6qNQlDjFoppZgyA+o9mup2yQ6vFNHG0I401EXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724285526; c=relaxed/simple;
	bh=mbbco71KR1JqUR2zFBgwIJTeKuQC79CT62Gz5C6W2jc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ikiswyfg0cyYcllKbXEmzp+92QIqPqtEvdmRKPSYxhp16CT+TBleeWkaMeVYRKhUdvlt7++IsKfp7oCdl0WROrRhYDl5mEc01ae5oJyKjASVQNIIouK4zfXgf/v8FlMs/Gffev36scmYQ59nHLAHu7HBrgoQnvu6fq5vzIglRxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z4QppVcw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y5lOjtXC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724285517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nTUMdp4DLthcUGcY/irLYo8CFAJpz6GHRVfIL4XIkZ0=;
	b=z4QppVcwMBRdbBQ072LinP71W1zOlor23cICLAjGQj73Hztt+7i8BtXwKDvdzsaVKWSEZn
	+JIpfnc4OPbO6pbgR5nZrxdHyrJbJPabwlNQbXp5uK54wDbG7qO7erfzxxWc6+n6kXcEuz
	yyifLQ4RLE2JwzpVGwoE1cuzypxQyP130KzK08UpOTDqzKqRN2jfXSm+G7rTLUlW6WlxhQ
	Dpi+QkZ3X8gBg/UDIdm12kYUFydrgwuF8OZguOk5XgEQrUHvUV2C5DEsNWyZOqxuMSfhud
	qKIz6CGeyM/Fy/ITUKIV55A2bMMiQTR67yveE5fWwL6gidCVFcyq7QWCpWiuXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724285517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nTUMdp4DLthcUGcY/irLYo8CFAJpz6GHRVfIL4XIkZ0=;
	b=Y5lOjtXCugRKhpF/1T9QZtwJ5jinBvbTtG5Zz1A8E9ahHe1fD3U+uhVde599TJtyHLup+v
	k/fPXG2YiR6NhUCA==
To: Woody Zhang <woodyzhang666@gmail.com>, Andrew Morton
 <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Woody Zhang <woodyzhang666@gmail.com>
Subject: Re: [PATCH 0/5] Minor memory size optimization in debugobjects
In-Reply-To: <20240821230539.168107-1-woodyzhang666@gmail.com>
References: <20240821230539.168107-1-woodyzhang666@gmail.com>
Date: Thu, 22 Aug 2024 02:11:56 +0200
Message-ID: <874j7difg3.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Aug 22 2024 at 07:05, Woody Zhang wrote:
> As of now, debugobjects framework uses hlist_head and separate spinlock
> as a hash table bucket. We have hlist_bl_head APIs which embeds a
> bit_spinlock in head pointer and thus no separate spinlock is required.
>
> This patchset first wraps irq variant API for bit_spinlock as well as
> hlist_bl_lock and several other APIs and macros. Lastly, It replaces
> hlist APIs with hlist_bl counterparts.

You are telling _what_ your changes are doing, but not _why_ and neither
_what_ they are trying to achieve.

Aside of that you are failing to explain how replacing a spinlock by a
hlist bitlock is equivalent to a lockdep covered locking primitive.

It is NOT.

And you have to come up with a convincing argument why this makes sense
aside of saving an unspecified amount of memory, which you haven't even
bothered to document. Neither in the changelogs nor in the cover letter.

You also completely fail to provide an analysis why converting the debug
object locking from a fair and sensible locking implementation to a
known to be unscalable locking implementation makes sense for a debug
facility which is used in a lot of hotpaths.

Any attempt to substitute a spinlock with a hlist_bl locking scheme
needs to come with a proper analysis to demonstrate that:

   1) this is a completely equivalent locking scheme

   2) the resulting loss of lockdep coverage is justified

   3) there is an actual performance benefit

   4) the actual memory savings

Just handwaving about an unspecified amount of memory savings (probably
in the range of 2 bytes or such) without any of #1 -#3 above is not
cutting it at all.

Try again.

Thanks,

        tglx

