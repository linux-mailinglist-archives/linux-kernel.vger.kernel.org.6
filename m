Return-Path: <linux-kernel+bounces-184659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D64578CAA27
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 10:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A2C81F2245A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 08:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56ED35645B;
	Tue, 21 May 2024 08:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ygfBtFLt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OprfSqsk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F6C55E53
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 08:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716280708; cv=none; b=OUMjgmF7+tYhKt6ISLDpY+TPTsTHqLtZv2eCwiihsYi9g/mqj6dbnnIgBryJaifF026jofD/RgSBOnObRAD/WLsSzfDZX7UDhjhw77tqbascJkYfBttKlHvvFeMoVtY5o0U6u4B/KVhmmVoiAWRZd4uCw37AoEVIM/70fiuK0HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716280708; c=relaxed/simple;
	bh=+XgBJMEW2upLD0In7KyCwJ74L278deDjE0vH4DoRdqQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f6e5mM+Rrwt1PlKnu+WEUdqnYZPv3Gd82Ku2Q3iJEmr6hFytltI5EsuF6rY33YN8xIoG5Sv+X4Na4B7/WUp0A8btPMFjTIeK1/c/Tf9qCT3h7APolUxh5rN4AQSD28PL/Qw9F7Cy3Jtvv3DQeQhHZJnLhMnZsaco6aL7lC7BREs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ygfBtFLt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OprfSqsk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716280705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9EBxGA62sPS5tkIrqIPbzKOO4Z8UW4B2EcNsRchc6hw=;
	b=ygfBtFLtHfRnmQ2px15ELOxug0Y1KQVXaK1ppgsKNwkeDOQRz0Klx2yIVcyWPhBqTapTGD
	/cxBN+65zGC5TyULEsHz+xP9wSE+qjBgAaTGbj1WQx9WsWE+ibA+pb4WE2ZTkG+gaI3s6S
	FWL8sP6lk+8zbtsmSf8TkR1iPUQ7HQJ76kxO2A4CgVEedVZ8WVEDEdD/gJ77Debo9wiaGn
	F3XFk7i/EHZ6jRPiGM8QbrvkojUa78NhnpLNW6mHsHxkU7F5gGih8rOEoK449/6r2yFiie
	7Xnc0Fcfe9OUS5q+jLmpIkFEhX1zjKccemZ7Wfidv/rTnXy4a7/b0PhPtuiEkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716280705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9EBxGA62sPS5tkIrqIPbzKOO4Z8UW4B2EcNsRchc6hw=;
	b=OprfSqskTBJL2IflXnVh7+N1+Gk6FYsfFQLL8jaA3P7QMGnfVcWFG/0KLNI18Bizi0cY6Z
	g4ant+ntddR++2Ag==
To: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Keith Busch <kbusch@meta.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, Frederic
 Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH 2/2] nvme-pci: allow unmanaged interrupts
In-Reply-To: <ZkwHnw6HkGFFq7mR@fedora>
References: <20240510141459.3207725-1-kbusch@meta.com>
 <20240510141459.3207725-2-kbusch@meta.com> <20240510151047.GA10486@lst.de>
 <Zj5JMqWRY187PqnD@kbusch-mbp.dhcp.thefacebook.com>
 <Zj6yvTxIpUnOXl7R@fedora>
 <Zj6-1sXvUNZWO1pB@kbusch-mbp.dhcp.thefacebook.com> <87r0e7mt9w.ffs@tglx>
 <20240520153742.GB921@lst.de> <ZkwHnw6HkGFFq7mR@fedora>
Date: Tue, 21 May 2024 10:38:25 +0200
Message-ID: <87a5kjimpq.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, May 21 2024 at 10:31, Ming Lei wrote:

> On Mon, May 20, 2024 at 05:37:42PM +0200, Christoph Hellwig wrote:
>> On Sun, May 12, 2024 at 08:35:55AM +0200, Thomas Gleixner wrote:
>> > That's expected as you pin the I/O operation on the isolated CPUs which
>> > in turn makes them use the per CPU queue.
>> > 
>> > The isolated CPUs are only excluded for device management interrupts,
>> > but not for the affinity spread of the queues.
>> 
>> We'll probably need a version of isolcpus that also excludes the
>> interrupt spread given that users are asking for it.  And I'd much
>> prefer that over adding radom module options to every driver to disable
>> managed interrupts.
>
> BTW, isolcpus has been marked as deprecated, and it can't be adjust
> runtime.

Which is far from reality as cpusets do not allow to do what isolcpus
does today.

Also runtime adjusting managed interrupts needs way more thoughts.

Thanks

        tglx

