Return-Path: <linux-kernel+bounces-316497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF02F96D060
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 09:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E3ACB22897
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 07:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5344C192D72;
	Thu,  5 Sep 2024 07:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4VsvWJhI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CDHsX2g9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D7083CC1
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 07:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725521375; cv=none; b=f3B/JUd0j3aRxrTrFzfX5BDjO258JX/mjyAeJJwP5HsB6plX54Wsx4qM/X9/j4aoSQTTebBlzpW2UJ6ejGW3O6CzAv2sfZQXrSfDBbRqQA5XNhKIG2BU8/OPtXssvChT/Jmzv5CziA/NdRyDgR+I5M+bAPUEjBzPI1YmhqeL/zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725521375; c=relaxed/simple;
	bh=h1Q1BrpqFo24i9DWuPhlWTjTw30IMbMn8IY9rI46wts=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=umQheEBVwkzXIIYE+x6QuP6U/DP4MsPbkTKpI592Ih+fuPhEd+E0zzb396E0nM/7RksVc3ZIaFeJrv1+Yd+AT/1vWrJO0E6BMx+3Q+8xvhLq0MQF21EnQZ6gTdrbZGmZg9AlwPZgqd2uKDVK1GQQr9NdW6Zz/4h75geeRjw39M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4VsvWJhI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CDHsX2g9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725521372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rODZ8Mcl6ziSPnpnBj5WSdN83ODOngMe8fjgQSCk7sQ=;
	b=4VsvWJhIgO6iOu+WSABF/Vd1TbWZKTYdL32xWfsUmmStHG21H4HY8N8sXsWIjisOLPNUal
	MTUO08TZSvAjuwxdP2srzHxOq3V6L2eaPk9EZV83YHlyRBKzPDb9sUOWpOdYqPrsNAPhFg
	0gclCQ9rYw5Xp2HMAgSQ3N3ZJg7dabo76xtiv0gy6ihqBXpDfObqppemAP1cdT/DxB6bhE
	vVpTu8mwkmdw+0cWniDg/GAn21DfKhzBToj0du4zYNpiJUdpxRMEPxcESoDXPAPtEc7wSc
	nWqt3hFnjITzqQD/NM7rJjr3EWDH4HDr6KhueU9+ElPZCPFjmu//u1qcwZNEPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725521372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rODZ8Mcl6ziSPnpnBj5WSdN83ODOngMe8fjgQSCk7sQ=;
	b=CDHsX2g9hyGqoMqhMDrhQ+Cos/UxfKayejpg0mJp/IGg/Ysu5mWwm3r9wIryQFc3NcZ0DV
	R/wzh7sdoAxrvWCw==
To: Sergey Shtylyov <s.shtylyov@omp.ru>, linux-kernel@vger.kernel.org, Marc
 Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] irqchip/gic: prevent buffer overflow in
 gic_ipi_send_mask()
In-Reply-To: <048ff3bb-09d1-2e60-4f3b-611e2bfde7aa@omp.ru>
References: <048ff3bb-09d1-2e60-4f3b-611e2bfde7aa@omp.ru>
Date: Thu, 05 Sep 2024 09:29:32 +0200
Message-ID: <87cyli5zj7.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Sep 04 2024 at 23:23, Sergey Shtylyov wrote:
> ARM GIC arch v2 spec claims support for just 8 CPU interfaces.  However,
> looking at the GIC driver's irq_set_affinity() method, it seems that the
> passed CPU mask may contain the logical CPU #s beyond 8, and that method
> filters them out before reading gic_cpu_map[], bailing out with
> -EINVAL.

The reasoning is correct in theory, but in reality it's a non problem.

Simply because processors which use this GIC version cannot have more
than 8 cores.

That means num_possible_cpus() <= 8 so the cpumask handed in cannot have
bits >= 8 set. Ergo for_each_cpu() can't return a bit which is >= 8.

Thanks

        tglx

