Return-Path: <linux-kernel+bounces-573552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FADCA6D8FB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 12:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED8B516D762
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 11:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE60D1C84C0;
	Mon, 24 Mar 2025 11:15:30 +0000 (UTC)
Received: from bsdbackstore.eu (128-116-240-228.dyn.eolo.it [128.116.240.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADB625DAF2
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 11:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.116.240.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742814930; cv=none; b=aMI+jvXfYqoXFOjvxjbHgkgdRzqalYQL2F3wZdUN/vsU2FvoZ2nEAqO6sIMDVJtcCc/I84SUoHX+QE3FbIm7BXLAj0kOZdx4EYvA2OmpnBmmhK4SBdZn810p3sS+bvG0G3wDatxRRxBHRP8mUcwSenT8X2UDF6RdawAfrPYRSt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742814930; c=relaxed/simple;
	bh=P7kczrFvAEkecebYg+0SctMa4bfEcRb/otiqw2URygw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ZrLmr4Al61ObqeowhISAeooDUKa5GQxLtBTesRdaZTxdr/B5yMeD2uwNYxia/oasah+nM6+pxwGS7jPb19rAxiRQmTUa3TLpYiU3KOKuZzWGikWg738+dkwLht5c2L6OfnP4in7oXDvf9cgHQWV3LOoSExqlxmG6OBwU1q9Eu6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bsdbackstore.eu; spf=pass smtp.mailfrom=bsdbackstore.eu; arc=none smtp.client-ip=128.116.240.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bsdbackstore.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsdbackstore.eu
Received: from localhost (25.205.forpsi.net [80.211.205.25])
	by bsdbackstore.eu (OpenSMTPD) with ESMTPSA id 59e3081f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 24 Mar 2025 11:48:40 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 24 Mar 2025 11:48:39 +0100
Message-Id: <D8OFRDU1AVWC.1G6DIBZPLJ78@bsdbackstore.eu>
Cc: "Christoph Hellwig" <hch@lst.de>, <axboe@kernel.dk>,
 <linux-nvme@lists.infradead.org>, "Linux List Kernel Mailing"
 <linux-kernel@vger.kernel.org>, "Linux regressions mailing list"
 <regressions@lists.linux.dev>
Subject: Re: 6.13/regression/bisected - new nvme timeout errors
From: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>
To: "Mikhail Gavrilov" <mikhail.v.gavrilov@gmail.com>, "Keith Busch"
 <kbusch@kernel.org>
X-Mailer: aerc
References: <CABXGCsMcxu3pCF8jYPeqF_jN34saBwc8Fci+c-Dg2Lh7rqvuFQ@mail.gmail.com> <Z8m9AbD3tjNpBt6p@kbusch-mbp> <CABXGCsMd_xv8jPDF_sFYhwd8GtANZ23nbaSJuCxQRO7cjPtgWg@mail.gmail.com>
In-Reply-To: <CABXGCsMd_xv8jPDF_sFYhwd8GtANZ23nbaSJuCxQRO7cjPtgWg@mail.gmail.com>

On Sun Mar 23, 2025 at 10:49 AM CET, Mikhail Gavrilov wrote:
> On Thu, Mar 6, 2025 at 8:19=E2=80=AFPM Keith Busch <kbusch@kernel.org> wr=
ote:
>>
>> >
>> >     nvme-pci: reverse request order in nvme_queue_rqs
>>
>> The patch here uses the order recieved to dispatch commands in
>> consequetive submission queue entries, which is supposed to be the
>> desired behavior for any device. I did some testing on mailine, and it
>> sure looks like the order the driver does this is optimal, so I'm not
>> sure what's going on with your observation.
>>
>> Do you have a scheduler enabled on your device?
>>
>> How are you generating IO? Is it a pattern I should be able to replicate
>> with 'fio'?
>
> Sorry for not answering for a long time, but all because I was testing
> the off-list patch that was sent to me by Maurizio Lombardi.
>
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 950289405ef2..990d9ef1eef9 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -989,6 +989,9 @@ static void nvme_submit_cmds(struct nvme_queue
> *nvmeq, struct rq_list *rqlist)
>  {
>         struct request *req;
>
> +       if (rq_list_empty(rqlist))
> +               return;
> +
>         spin_lock(&nvmeq->sq_lock);
>         while ((req =3D rq_list_pop(rqlist))) {
>                 struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
>
> And I want to say right away that this patch solved my problem. I
> double checked, and both times the system worked for 4 days without
> errors:
>

Glad to hear it worked!

Keith, I think the problem here is simply that nvme_write_sq_db() ends up
being called even when the rqlist is empty and this couldn't happen before
the changes introduced by commit "nvme-pci: reverse request order in
nvme_queue_rqs".

If you say that this change makes sense I can submit a formal patch.

Maurizio

