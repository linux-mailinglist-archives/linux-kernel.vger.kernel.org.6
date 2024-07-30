Return-Path: <linux-kernel+bounces-267993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 096DD941F22
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 19:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AAEE1C2320D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 17:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F1618A6A8;
	Tue, 30 Jul 2024 17:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="CRx99wT8"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E1D189522;
	Tue, 30 Jul 2024 17:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722362371; cv=none; b=fmasrXo+5Qe2n/kKH6z1IP3oKrRE/bd/gJzY5DJ4+xvdKxHCR6Su108OdaOyXjPd4g5agNUsbl/L3KbnLSUAemTxFOcMs6wtQFPwt0jnq8+6xLPoaxwcnMOw7bnXsnGstk5H722zV4aOtbJQmHgaGpa/MToKEZT2AfgULL2Anro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722362371; c=relaxed/simple;
	bh=0biNpjGgb2ykySOjjWXdFINtIuFDeh1GrHLCI4gUqS0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ipQfZ+duN10ObthBIDY/LCSU8qv9TqfqSgAYS9r5xca8lhhbhvZ29EuDVyS6h24Jkze8NGvM6na09XxAh+nbuaw3Yr7GpDilr2Gly/5tKt7ESnS/JG2AFXPkUMOLS56aUrfRFEO94+zcn/SdHH8HhBWZ3qwxoqka7Fq1zWV0A50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=CRx99wT8; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 6EFEE41A31
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1722362368; bh=gjWwOYsC9ejMcN/lW6xvyv7ohEv7jitlRIes9qzgcak=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=CRx99wT8cBsIl0KRONO3aNIcvsiUu2fxBEIn+lelGc/Wo9ZAEEUGutEx0/oEiHZlR
	 yMomQJHgvNl6IhlLDosJsg82IBirOplXqq5wsqN0XtQBYO2kS/YdhId7Yqj78wB7Q5
	 GQmEbGHYZk5LUxTKveMVXUG1nSrhrZ/BQE8tdEGwO7L2+oxFQevjJAwQTd+4UgQJ8p
	 PSrwwvxqvaDLQCJiKRsqS/RwYj1E6qHNoaABYwspJP474N5tqT4UOn6+hGDHHsKUJt
	 LVZwsEE40BfEi2RuoMl7czNURWtYkVMUQsLhZJyRwKOQmhPe+eSCRmNzhfVJe09vbA
	 UDec71bDLJrLw==
Received: from localhost (c-24-9-249-71.hsd1.co.comcast.net [24.9.249.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 6EFEE41A31;
	Tue, 30 Jul 2024 17:59:28 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>,
 Michael Dolan <mdolan@linuxfoundation.org>
Subject: Re: [PATCH 1/2] Documentation: embargoed-hardware-issues.rst: minor
 cleanups and fixes
In-Reply-To: <2024073032-outsource-sniff-e8ea@gregkh>
References: <2024073032-outsource-sniff-e8ea@gregkh>
Date: Tue, 30 Jul 2024 11:59:26 -0600
Message-ID: <8734nq92wx.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> The embargoed-hardware-issues.rst file needed a bunch of minor grammar,
> punctuation, and syntax cleanups based on feedback we have gotten over
> the past few years.  The main change here is the term "silicon" being
> used over "hardware" to differentiate between companies that make a chip
> (i.e. a CPU) and those that take the chip and put it into their system.
>
> No process changes are made here at all, only clarification for the way
> the current process works.
>
> All of these changes have been approved by a review from a large number
> of different open source legal members, representing the companies
> involved in this process.
>
> Co-developed-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Co-developed-by: Michael Dolan <mdolan@linuxfoundation.org>
> Signed-off-by: Michael Dolan <mdolan@linuxfoundation.org>
> Co-developed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> Jon, I can take these changes through my tree if you don't object.

They seem fine to me, no problem.  Should anybody care:

Acked-by: Jonathan Corbet <corbet@lwn.net>

jon

