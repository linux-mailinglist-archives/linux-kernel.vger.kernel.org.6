Return-Path: <linux-kernel+bounces-274369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5875D94776F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 10:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19A9D281CDB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 08:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5529B149DF0;
	Mon,  5 Aug 2024 08:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LrwzqV/N";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Qkoq3QRV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559521514C8
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 08:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722847087; cv=none; b=ZMrvifDCWX2grm9LKo82ci6p5lhyTn7xWEsIKPVuk01ULH8KpSePDfHU4U2SUkVh6KE3Xo5CglIzBADQqxTKlp5bg/5Pp6e2cLh7HLtaQc9PaLbtMxNYgm42OEQyRMSdeY9HTq1RuVOuboJeqnuWovEEPcRxMwxkgpmXEu/M71Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722847087; c=relaxed/simple;
	bh=r8H2Z9gIF58exXLjxomQlWcG7Y3FP7HIU738Q9jfHh4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=itkeSkm5vgVz2X4214BU7bKm4RW7BpGyHjW39JEBupsBZ0gPzOvhsN3TRMXy8JQbCaENVCiaakXci2XhUVnXcmM4Q4zpwU1Qq0U+qPo7jtqiN7LhuiF2iWY9F/+WLLAUP39Mc5QryK/TUFGVSRw+kTI5kG8lQAmzY4ZStRzcwr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LrwzqV/N; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Qkoq3QRV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722847084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kgYOYZXtyD1nwkUNLwFKpnO9QY5Yi0/hRQhCPV6glYw=;
	b=LrwzqV/NCMt1RiGEpYOqJmQuk+93wNX2xuIZ6MT39LRgovbF4gaZW+ubgKVBJ+7C0ZNlsS
	Wr6j9OeneAGEnKOoET8A5HfA6nuOK6uvkzL3Q1qyl8iJMhqPEayOMzWxYO2oLct4OAiWyf
	yRDGk7UnpaUJcXHMX6Zlx9lJ80ebD6Kkywc9pZ9lsNOWY02haE7B1LpQAxP1K7XWhLuBkF
	NrmBQhHDf0dHdHqjF+bfXUBMg03UrLa7/BotIdX8XVeuvrdWQgNg5GB7c/uFQgmUgfBd16
	Re2yogm8xQFSKZDmwhzqthTkbgenLvJSOUxgLfMQ1IROE4Tzyi25JSrhW3CAww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722847084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kgYOYZXtyD1nwkUNLwFKpnO9QY5Yi0/hRQhCPV6glYw=;
	b=Qkoq3QRVnngJ8BqWAbmkzie/d0bnfZEP7+2wfw2Z7VL/FebNV2gBTWsNExnJ1b8EstuQdN
	g02WvoI3w4GknuBQ==
To: Shay Drori <shayd@nvidia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pci_msix_alloc_irq_at() affinity
In-Reply-To: <16fbd3eb-92e2-4e6f-b020-4f5a2feee4ad@nvidia.com>
References: <ccb1b2ca-0d62-4c74-ada3-89cce13b8de3@nvidia.com>
 <87ttgcuuvi.ffs@tglx> <16fbd3eb-92e2-4e6f-b020-4f5a2feee4ad@nvidia.com>
Date: Mon, 05 Aug 2024 10:38:03 +0200
Message-ID: <87mslr5pqs.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Aug 05 2024 at 08:34, Shay Drori wrote:
> On 26/07/2024 16:48, Thomas Gleixner wrote:
>> Looks about right, though the diff is whitespace damaged.
>> 
>> Care to submit a proper patch?
>
> sorry for the late reply, Yes.
> on-top of which kernel branch to create the patch?

Mainline.

Thanks,

        tglx

