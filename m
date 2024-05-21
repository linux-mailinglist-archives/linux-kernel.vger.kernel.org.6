Return-Path: <linux-kernel+bounces-184752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 213D08CAB7E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 12:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A23C1C21C90
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 10:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6D06AF88;
	Tue, 21 May 2024 10:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C6ph+Ugq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAE76BB20
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 10:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716286022; cv=none; b=mF9X5YumPJ0f9nIE75OqMqummEb1aIv2ghOL0kXIzfXwE1UHqD6RgR1oI1ziKI30TOV2KoNrYcN3Tm9na8KFFWWyNGTkc0X9fs0v3iX1WXt4IzGOBTWB2Uobo43cyGs43bejErFN6ibS+QjNYEbxghJjsdCusH3+yznyMph6Xzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716286022; c=relaxed/simple;
	bh=jqZc2bJtxtIBJwM/97UqABA4R2EDya0YKbUlffFLnUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bdsMeFYZakXcSRg3Ao4WjgEEdjdGCas94qNzfF0OYFpP03lQx1keQnDqH3FenLB/KF1PQrgFJE8VvWVLVtOMfEH3wAL79wVHcG1Dxjr6TablA4C0RAXehXdYtYBtpGL2/EGBf2dnzLfmcMfTKkux9ay6YrJl/GwziOo4o1I3Lig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C6ph+Ugq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1005FC2BD11;
	Tue, 21 May 2024 10:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716286021;
	bh=jqZc2bJtxtIBJwM/97UqABA4R2EDya0YKbUlffFLnUE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C6ph+UgqyXtfZIRxRb/DfroOOuKcv1Gl/t/19hLlpXi7xxFMMW8HxBAiNjdXp6Lgr
	 CXMT36Inc8sua/bFzVdlBdwCudNKe6WAb9+avJoIgXehtW6xKAwRXr5KYkGroWvVxI
	 gK8PBa5AoSB1BLO+G+enX1PqVj3IVJCWsoX4Pr6MDMDH3kW4MzHQTDlqg+msX8PlqY
	 SQHimPMaoiXTfRexnlALwPGwXht0OrD3OWKM5sTZSV348deu39cs+eSFpd3m0IDTph
	 noeiKda1I/kRhB6V4HlIlFioB0HuOgL7FPbqRq2D+ipUbt9YGHo2NK5sV9wSfEWuqo
	 dc9IEjN2wVGXA==
Date: Tue, 21 May 2024 12:06:58 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Keith Busch <kbusch@meta.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] nvme-pci: allow unmanaged interrupts
Message-ID: <ZkxyQmR0cpT7-zKY@localhost.localdomain>
References: <20240510141459.3207725-1-kbusch@meta.com>
 <20240510141459.3207725-2-kbusch@meta.com>
 <20240510151047.GA10486@lst.de>
 <Zj5JMqWRY187PqnD@kbusch-mbp.dhcp.thefacebook.com>
 <Zj6yvTxIpUnOXl7R@fedora>
 <Zj6-1sXvUNZWO1pB@kbusch-mbp.dhcp.thefacebook.com>
 <87r0e7mt9w.ffs@tglx>
 <20240520153742.GB921@lst.de>
 <ZkwHnw6HkGFFq7mR@fedora>
 <87a5kjimpq.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a5kjimpq.ffs@tglx>

Le Tue, May 21, 2024 at 10:38:25AM +0200, Thomas Gleixner a écrit :
> On Tue, May 21 2024 at 10:31, Ming Lei wrote:
> 
> > On Mon, May 20, 2024 at 05:37:42PM +0200, Christoph Hellwig wrote:
> >> On Sun, May 12, 2024 at 08:35:55AM +0200, Thomas Gleixner wrote:
> >> > That's expected as you pin the I/O operation on the isolated CPUs which
> >> > in turn makes them use the per CPU queue.
> >> > 
> >> > The isolated CPUs are only excluded for device management interrupts,
> >> > but not for the affinity spread of the queues.
> >> 
> >> We'll probably need a version of isolcpus that also excludes the
> >> interrupt spread given that users are asking for it.  And I'd much
> >> prefer that over adding radom module options to every driver to disable
> >> managed interrupts.
> >
> > BTW, isolcpus has been marked as deprecated, and it can't be adjust
> > runtime.
> 
> Which is far from reality as cpusets do not allow to do what isolcpus
> does today.
> 
> Also runtime adjusting managed interrupts needs way more thoughts.

I'll remove that comment (unless someone beats me at it?). We used to think
that cpusets would indeed deprecate isolcpus but for several reasons this
will never be the case.

Thanks.

