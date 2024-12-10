Return-Path: <linux-kernel+bounces-440338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 525DF9EBBF0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 22:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C973167E6B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 21:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72323237A40;
	Tue, 10 Dec 2024 21:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Af3/xZFN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D0E237A29
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 21:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733866618; cv=none; b=FDfFEKdDrX0Gu3MqVbhwgwv2BbgvgTRUQjVuAyBYG3MGmxrK+3ZSEWUoPWUj4qjbAgzozoTeQRaVGIYZQGkuePtcQZ2ojr9GUdqhzu/d2tp5QDrVfz0jsMe2+qJreoIRQV8iqgnycgRHJCCGe7yZDN/KNfcj/B448I3m6XiRGYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733866618; c=relaxed/simple;
	bh=kVLRhtKdianMhUJiBSB5RAuhhAuiqmseZ4Kt3QafGag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H9ieQeMkHQeEkCKuPsw0N+VrxtdwU+ywuKKUtD5QLKt89ZgMccnGyP1et79RCQ5yVAy9M2YQZSePLteHyWEs742SUV0DuNScD7XNkyowqndYYKALaq7o0+ZREJCEhkxsH7Z0FM/N6OCXs6XQ0w2eG0KBN3N4Zu8ssxWQe9TR718=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Af3/xZFN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22535C4CED6;
	Tue, 10 Dec 2024 21:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733866618;
	bh=kVLRhtKdianMhUJiBSB5RAuhhAuiqmseZ4Kt3QafGag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Af3/xZFNdYfHWsxxQzQUff+pnIlPOYBAgqLPr+T9Cg+233TH4HS9J2TRQ8CUynX1g
	 3I8xauzpo7m+sHqSNRv6CH8nEobOcKLcAIg2ci8so+RlMcZObPK+Ap5KXQXzPvl0bp
	 z8uAstSs8XKOqGbWjREtE/2NO9sZGo44IYCd0PsDmFjaa03vqlKtc1uDFPdcBxl/+A
	 d+32XunHNN2HaIIODU30f0Xjo/sbZ78bioVNEk34Lw/BiTFZ3v/3T8ViAUOHxhrkqf
	 aaUMCfyCMMuUwntX93+Ffsw7KJU6nkSvjN6kOWE6e1vtrmjtk1YCdngBtTPhfGtuLg
	 72lTuUYdqZ/EA==
Date: Tue, 10 Dec 2024 14:36:55 -0700
From: Keith Busch <kbusch@kernel.org>
To: =?iso-8859-1?Q?Pawel?= Anikiel <panikiel@google.com>
Cc: Robert Beckett <bob.beckett@collabora.com>, axboe <axboe@kernel.dk>,
	hch <hch@lst.de>, kernel <kernel@collabora.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-nvme <linux-nvme@lists.infradead.org>,
	sagi <sagi@grimberg.me>
Subject: Re: [PATCH] nvme-pci: 512 byte aligned dma pool segment quirk
Message-ID: <Z1i0d5Ht8zUHhSu-@kbusch-mbp.dhcp.thefacebook.com>
References: <20241112195053.3939762-1-bob.beckett@collabora.com>
 <20241114113803.3571128-1-panikiel@google.com>
 <1932ad8722a.102613bdb3737.769617317074446742@collabora.com>
 <CAM5zL5rKsEd1EhOx1AGj9Au7-FQnJ5fUX2hLPEDQvmcrJXFFBg@mail.gmail.com>
 <1932b818328.ad02576784895.6204301822664878956@collabora.com>
 <Z0DdU9K9QMFxBIL8@kbusch-mbp.dhcp.thefacebook.com>
 <193ab67e768.1047ccb051074383.2860231262134590879@collabora.com>
 <CAM5zL5pvxrpWEdskp=8xNuUM+1npJkVLCUTZh3hCYTeHrCR5ZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM5zL5pvxrpWEdskp=8xNuUM+1npJkVLCUTZh3hCYTeHrCR5ZA@mail.gmail.com>

On Mon, Dec 09, 2024 at 04:33:01PM +0100, Paweł Anikiel wrote:
> On Mon, Dec 9, 2024 at 1:33 PM Robert Beckett <bob.beckett@collabora.com> wrote:
> > [...]
> > I have no further updates on this. I have received no further info from the vendor.
> > I think we can go ahead and use the alignment patch as is. The only outstanding question was whether it is an
> > implicit last entry per page chain vs simple alisngment requirement. Either way, using the dmapool
> > alignment fixes both of these potential causes, so we should just take it as is.
> > If we ever get any better info and can do a more specific patch in future, we can rework it then.
> 
> I think the 512 byte alignment fix is good. I tried coming up with
> something more specific, but everything I could think of was either
> too complicated or artificial.
> 
> Regarding the question of whether this is an alignment requirement or
> the last PRP entry issue, I strongly believe it's the latter. I have a
> piece of code that clearly demonstrates the hardware bug when run on a
> device with the nvme bridge. I would really appreciate it if this was
> verified and my explanation was included in the patch.

I've pushed this to nvme-6.13 with an updated commit message here:

  https://git.infradead.org/?p=nvme.git;a=commitdiff;h=ccd84b8d6f4a60626dacb933b5d56dadca75c0ca

I can force an update if you have any edit suggestions.

Commit message copied below:

Author: Robert Beckett <bob.beckett@collabora.com>

nvme-pci: 512 byte aligned dma pool segment quirk

We initially introduced a quick fix limiting the queue depth to 1 as
experimentation showed that it fixed data corruption on 64GB steamdecks.

Further experimentation revealed corruption only happens when the last
PRP data element aligns to the end of the page boundary. The device
appears to treat this as a PRP chain to a new list instead of the data
element that it actually is. This is an implementation is in violation
of the spec. Encountering this errata with the Linux driver requires the
host request a 128k transfer and coincidently get the last small pool
dma buffer within a page.

The QD1 quirk effectly works around this because the last data PRP
always was at a 248 byte offset from the page start, so it never
appeared at the end of the page. Further, the MDTS is also small enough
that the "large" prp pool can hold enough PRP elements to never get to
the end, so that pool is not a problem either.

Introduce a new quirk to ensure the small pool is always aligned such
that the last PRP element can't appear a the end of the page. This comes
at the expense of wasting 256 bytes per small pool page allocated.

Link: https://lore.kernel.org/linux-nvme/20241113043151.GA20077@lst.de/T/#u
Fixes: 83bdfcbdbe5d ("nvme-pci: qdepth 1 quirk")
Cc: Paweł Anikiel <panikiel@google.com>
Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>

