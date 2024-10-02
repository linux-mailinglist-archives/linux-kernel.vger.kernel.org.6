Return-Path: <linux-kernel+bounces-348329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4820E98E600
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 00:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F21361F2117B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 22:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4C2197A8B;
	Wed,  2 Oct 2024 22:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n35SjfgW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Wx81Kmxv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF1A2F22
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 22:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727907430; cv=none; b=HnJdyH96LFlOj77O5sZSF72sVzTAWQecDkhUbF7kd0Ua1QLpBWk0+icffx9xrkNfh7ptoPNhjuygg66sftTAQZm5ToPW827goGhfo5GmdfT67oFVCDnvstTMDkN4PbY2KliN1qqoS9fbyCbkypX46s2zSoVrYDZw763jo821pdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727907430; c=relaxed/simple;
	bh=Adaya8o31F5yI2fcaUtOAw966u92kYxku98bF7cOFbY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mP2+IV5BIj6hf/+XopTZcqMuxetMLAmJvoqfhIK4iYwTszN3ozoBFDOBF7SGgLdZrKiU0yj/o3m0ZrHrI1O26pvCDkkMtjFk8KTi3pvOAlxIbWl06KZDM2AwluO2jpAM+z86AvdOEKltZ8bflDy0Sh7/SvX0T/02HAT1JRBXD1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n35SjfgW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Wx81Kmxv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727907422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jFjZeiFVpmHVjg0rdNh6hIED5M51QQAMChgDBPTcq2k=;
	b=n35SjfgWXhPe4Ya9YJz1AieiQfL3DkXpxCk2Z4WisZBKx+wUE+AKS0X+qKGmkP9VV8kOJa
	pDTFvS5RisMxRO5DrDRQ/hYf9mz7+biK1CYjk61npZdTBp0/WJnO8Xhn/Ac/hhjSSili1m
	Pru1mB8FmxVxTKqsqRGQKhWFzS1gHh+BZMsN3zox2uHRwrjgEEucrpLFFSS3Jeddv6VJeQ
	QTf1R2z8o6e6kEy2DtyiFh4fBBTgQqsZT6IOZzsP/rjBl5mv07EIVXFz/i+p4i/0/LuI1l
	1Tm60F3S6VnxNI2iYkEiDlN7/n6XExQLYSklmH0vpQuOsmJO+MnCM2Kp/MI39Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727907422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jFjZeiFVpmHVjg0rdNh6hIED5M51QQAMChgDBPTcq2k=;
	b=Wx81KmxvDq9BKJxN0r990aUW4SiMEGRYtT3TsO3IpmFdRk7LD0nokdzjPUx5ZEng7mDk4R
	2iL3ekJU0tkEPZAA==
To: Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Cc: Kunkun Jiang <jiangkunkun@huawei.com>
Subject: Re: [PATCH] irqchip/gic-v4: Don't allow a VMOVP on a dying VPE
In-Reply-To: <20241002204959.2051709-1-maz@kernel.org>
References: <20241002204959.2051709-1-maz@kernel.org>
Date: Thu, 03 Oct 2024 00:17:02 +0200
Message-ID: <87zfnmup41.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Oct 02 2024 at 21:49, Marc Zyngier wrote:
> Kunkun Jiang reports that there is a small window of opportunity for
> userspace to force a change of affinity for a VPE while the VPE has
> already been unmapped, but the corresponding doorbell interrupt still
> visible in /proc/irq/.
>
> Plug the race by checking the value of vmapp_count, which tracks whether
> the VPE is mapped ot not, and returning an error in this case.
>
> This involves making vmapp_count common to both GICv4.1 and its v4.0
> ancestor.
>
> Reported-by: Kunkun Jiang <jiangkunkun@huawei.com>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Link: https://lore.kernel.org/r/c182ece6-2ba0-ce4f-3404-dba7a3ab6c52@huawei.com

I assume this wants a Fixes: tag and a cc: stable, no?

Thanks,

        tglx

