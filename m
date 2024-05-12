Return-Path: <linux-kernel+bounces-176806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94AD88C353A
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 08:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD5AB1C20D84
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 06:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB445FBE8;
	Sun, 12 May 2024 06:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gOcJeskN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="24AKP5h2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E51E556
	for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 06:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715495768; cv=none; b=AMQMbsY1VtpNO51c2enCUsjO8KSaTJ3W6h7deFOhS+ipyXmSWuQkRe3lsWwBWfjMXkqkPt6AM6H7P+aNlCN6aJDaiJb2H3HVS3RyKH1gTqzKrgIa5i70PRFbIgZMvkdywYvYUKbwIR2eqZZZoafzBfTKymog8b/Qc81JXIlgbLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715495768; c=relaxed/simple;
	bh=jA+qK5hVsJOCZ/TVuc/fCxhMUa6r3N263i61oVDq9H4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uPPfuFRov9dDeN00RGfT2pO/KbD9Ycrpj6nt5FCt/S0a70/oE3rkIFvII460MRi5vhMYn5dzStsdrhoHJZ2Q78/dYsj/NqTNky2Ey/8yUiXEsYk7yJ4yjmbNfIhRI0207vAJflKZKAe0KzgqYAST9nd7YVz1oxdR2oiiAO3IJa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gOcJeskN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=24AKP5h2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715495756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QJak6izOLdXcT5b2TZaAlyg3uKMUWQPMlJ+3t6Ownik=;
	b=gOcJeskN/2y0z/zGSs1nmmCHx1/0DqBNDcf97/2kgXfnb2qnRUtv/jKClMYVJ4CLHQIQ6w
	NDbGdHDbiYDAPft3fzwe1tS9RVC6/25qoIF3b80vsxHD1Vtmj3Lq2p1ZiDkyzg4anCftJP
	QilpQgDSqctPPrOdgE3MFA6b5iB3Q3jICaYzLHrXM4szdzJ4kBnIbZtAvfzmj5xUuL78n0
	Td+coWZRwtqCEzwv7/Wz0C0A5HW/b/SLTgfY2PmQDqwZyiKMFEZG6C+pCMcAsjF0ShocpD
	jg0DBGik3J2PWbqw8VVKrORSamjUna9CL54lAzLvh9785m7glEYh1vpda+YnFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715495756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QJak6izOLdXcT5b2TZaAlyg3uKMUWQPMlJ+3t6Ownik=;
	b=24AKP5h2uBsPJidtVpL1o9LyJp+cc2J4nSHdY+ggiissoreeUu6SAxuSlPUGl8nI0cD3aM
	1NE3YuiWVgmRIyBg==
To: Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] nvme-pci: allow unmanaged interrupts
In-Reply-To: <Zj6-1sXvUNZWO1pB@kbusch-mbp.dhcp.thefacebook.com>
References: <20240510141459.3207725-1-kbusch@meta.com>
 <20240510141459.3207725-2-kbusch@meta.com> <20240510151047.GA10486@lst.de>
 <Zj5JMqWRY187PqnD@kbusch-mbp.dhcp.thefacebook.com>
 <Zj6yvTxIpUnOXl7R@fedora>
 <Zj6-1sXvUNZWO1pB@kbusch-mbp.dhcp.thefacebook.com>
Date: Sun, 12 May 2024 08:35:55 +0200
Message-ID: <87r0e7mt9w.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, May 10 2024 at 18:41, Keith Busch wrote:
> On Sat, May 11, 2024 at 07:50:21AM +0800, Ming Lei wrote:
>> Can you explain a bit why it is a no-op? If only isolated CPUs are
>> spread on one queue, there will be no IO originated from these isolated
>> CPUs, that is exactly what the isolation needs.
>
> The "isolcpus=managed_irq," option doesn't limit the dispatching CPUs.
> It only limits where the managed irq will assign the effective_cpus as a
> best effort.
>
> Example, I boot with a system with 4 threads, one nvme device, and
> kernel parameter:
>
>   isolcpus=managed_irq,2-3
>
> Run this:
>
>   for i in $(seq 0 3); do taskset -c $i dd if=/dev/nvme0n1 of=/dev/null bs=4k count=1000 iflag=direct; done
>
> Check /proc/interrupts | grep nvme0:
>
>            CPU0       CPU1       CPU2       CPU3
> ..
>  26:       1000          0          0          0  PCI-MSIX-0000:00:05.0   1-edge      nvme0q1
>  27:          0       1004          0          0  PCI-MSIX-0000:00:05.0   2-edge      nvme0q2
>  28:          0          0       1000          0  PCI-MSIX-0000:00:05.0   3-edge      nvme0q3
>  29:          0          0          0       1043  PCI-MSIX-0000:00:05.0   4-edge      nvme0q4
>
> The isolcpus did nothing becuase the each vector's mask had just one
> cpu; there was no where else that the managed irq could send it. The
> documentation seems to indicate that was by design as a "best effort".

That's expected as you pin the I/O operation on the isolated CPUs which
in turn makes them use the per CPU queue.

The isolated CPUs are only excluded for device management interrupts,
but not for the affinity spread of the queues.

Thanks,

        tglx

