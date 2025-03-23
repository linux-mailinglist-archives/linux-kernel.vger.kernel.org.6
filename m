Return-Path: <linux-kernel+bounces-572774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E24A6CE89
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 10:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C41657A464B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 09:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658DA1FFC53;
	Sun, 23 Mar 2025 09:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jgx0IvxK"
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CCD18D65F
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 09:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742723393; cv=none; b=ELFBpL33ormrpcTJiEeN07YCM9E7+pwGTzPDboSj//peqbCJye/aQe4CHS0WpnS3dd2blaY5IdDXCzRbB8qMJS37Fk73QSFgWNossfPD8EKx+vVDLC5YQZfVT68eg7QzYZzK14FF5yNcsIwsBZKbgDaUmyOpO5u9gtWRxpxgJuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742723393; c=relaxed/simple;
	bh=zCCQPhULcp8Yr613A/F+Id/s/bqZMfd1q4V9qHcb1Jg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LytebmGZc/DTxiJ7gUwl9+rsiZtI3ICvDgJTaXrqNnu8WBOJbDCR17Couiua05Gnwq4XOKTP1yFJZWOqBXfdfun9QEGNjCYUNWsCpssh9/iGmW3EnIZInqKfYCxuzWWwieBgV1+35e0c4Yb4vEcXq7h11jAwWn4sNV3SrEP+2KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jgx0IvxK; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2c2bb447e5eso1844199fac.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 02:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742723391; x=1743328191; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qtl4aMOEbfVOV1/Eu8J0ZwV0cESQwszhmL0cG268KPo=;
        b=jgx0IvxKDoEbZ1k0hv3evKng2mrFUPopctxRkA26rUWx8ebHj2fYPX1J//WZq4ATJf
         Qh85Yu+rtF180bZQjsMuI8boL9F7sZT0EyWLvCspyR/WlQ3X3SUQIZkZKjlg7HJqnYJA
         LbErcx4e14zrDzcIrhxsq2Obo4zert2vQGLNT+8dki6S4c6jZS32RCR7ljRsAkoH1GFR
         Q5Ja6P+kg1BmctGbQYKGwafRnE+UWwRWX4vfBg3XaHqshN6TfE2FAsvcMH48OIvA5VKU
         Mz60gqHdowv4tA4FEHNfLtvV5imWFBqE2mT9CGu4pLjd7eQSOn9aJcBg2AurgYJOrPNy
         QxgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742723391; x=1743328191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qtl4aMOEbfVOV1/Eu8J0ZwV0cESQwszhmL0cG268KPo=;
        b=Tc8fBBwse81572chn96L17ZYVVX7C5iwnQHBvOemM4bQ88KCk1XVS2quSCBpvrItS7
         HWYdXLwgShWVgWrE9Z6cHuYflqYAJpTr2+lanSRIrcQjUn5VllCiI11+e8uODQYiiMKy
         z6kRO/msKlV8+JkdGfpdGQT7xeLow0qCF+qjxNl0H9YIVTBYxuw+AbxNcEmWirNqrZTM
         FBTU6jLBnliBY2ym0/JbgXHtNUMf4qdsNgVXRuP9n22eBVlVdH0VWm/8lwVwAJ1oJSXC
         hZpbcNFwUg7/yg/QgwvBCEp4SnBT0vTSTp/joN0w+H6Y9YZNO9PM/hZ+rYaQFe0b/a53
         5wgg==
X-Forwarded-Encrypted: i=1; AJvYcCVYgC+Pa3emb801PHl6/rZGyw5EmaBTypZfBlM4YCW17u814tqPo6D1o+yWRHCU22wRx3Glzr9LuiU7lrg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7ndb4dp6EKurrRYQLmjYXwdXAB2cHQ1J8nXVHnJ2ZtxRb7162
	oDRy9OCGZgCiWtieOflD6X7Muw/o2fiNjiKxPAj4VyAlBCJlvuDyFulfIlbnP0nEb0pSrN/VYbI
	JDlRVA/nvY3WA22HSABQQXp/+On4=
X-Gm-Gg: ASbGncuzM87BD6FPmn20TGH8CIc9nRFUktR/NaVQ5+YONqqA+ShwpN1i1dPhi+dtZ8D
	a8k/yoN6g6/OIXgIUiZ9IRtGFwD8DoJA2Cl1IplSHHMm1GqPmNYHotqy338pK+Ie1EAekGH3hcb
	ldJ8Y7A6AORZopQ6YCIyVpcWAS3S+a
X-Google-Smtp-Source: AGHT+IFbAl12hGCj2PVn2R4kzM0/iVrZhywz5UfVG+Lep2sLGwhL+4qnhCJvzW2eWiZaBz44180IIgiem78C1Cc7ib4=
X-Received: by 2002:a05:6830:620b:b0:72b:7cc8:435 with SMTP id
 46e09a7af769-72c0af0c2f2mr6743315a34.24.1742723390919; Sun, 23 Mar 2025
 02:49:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXGCsMcxu3pCF8jYPeqF_jN34saBwc8Fci+c-Dg2Lh7rqvuFQ@mail.gmail.com>
 <Z8m9AbD3tjNpBt6p@kbusch-mbp>
In-Reply-To: <Z8m9AbD3tjNpBt6p@kbusch-mbp>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Sun, 23 Mar 2025 14:49:40 +0500
X-Gm-Features: AQ5f1Jqdg6rQH9CczdkRGALGwIfqDyOG2EaR3hIqmo1zElkNd9miN3R3DAWLx2Q
Message-ID: <CABXGCsMd_xv8jPDF_sFYhwd8GtANZ23nbaSJuCxQRO7cjPtgWg@mail.gmail.com>
Subject: Re: 6.13/regression/bisected - new nvme timeout errors
To: Keith Busch <kbusch@kernel.org>, mlombard@bsdbackstore.eu
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, linux-nvme@lists.infradead.org, 
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 8:19=E2=80=AFPM Keith Busch <kbusch@kernel.org> wrot=
e:
>
> On Wed, Jan 15, 2025 at 02:58:04AM +0500, Mikhail Gavrilov wrote:
> > Hi,
> > During 6.13 development cycle I spotted strange new nvme errors in the
> > log which I never seen before.
> >
> > [87774.010474] nvme nvme1: I/O tag 0 (3000) opcode 0x1 (I/O Cmd) QID 1 =
timeout, aborting req_op:WRITE(1) size:131072
>
> ...
>
> > I still haven't found a stable way to reproduce this.
> > But I'm pretty sure that if this error don't appearing within two
> > days, then we can assume that the kernel isn't affected by the
> > problem.
> > So I made bisection with above assumption and found this commit:
> >
> > beadf0088501d9dcf2454b05d90d5d31ea3ba55f is the first bad commit
> > commit beadf0088501d9dcf2454b05d90d5d31ea3ba55f
> > Author: Christoph Hellwig <hch@lst.de>
> > Date:   Wed Nov 13 16:20:41 2024 +0100
> >
> >     nvme-pci: reverse request order in nvme_queue_rqs
>
> The patch here uses the order recieved to dispatch commands in
> consequetive submission queue entries, which is supposed to be the
> desired behavior for any device. I did some testing on mailine, and it
> sure looks like the order the driver does this is optimal, so I'm not
> sure what's going on with your observation.
>
> Do you have a scheduler enabled on your device?
>
> How are you generating IO? Is it a pattern I should be able to replicate
> with 'fio'?

Sorry for not answering for a long time, but all because I was testing
the off-list patch that was sent to me by Maurizio Lombardi.

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 950289405ef2..990d9ef1eef9 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -989,6 +989,9 @@ static void nvme_submit_cmds(struct nvme_queue
*nvmeq, struct rq_list *rqlist)
 {
        struct request *req;

+       if (rq_list_empty(rqlist))
+               return;
+
        spin_lock(&nvmeq->sq_lock);
        while ((req =3D rq_list_pop(rqlist))) {
                struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);

And I want to say right away that this patch solved my problem. I
double checked, and both times the system worked for 4 days without
errors:

nvme nvme0: I/O tag 960 (33c0) opcode 0x2 (I/O Cmd) QID 7 timeout,
aborting req_op:READ(0) size:16384
nvme nvme0: I/O tag 961 (33c1) opcode 0x2 (I/O Cmd) QID 7 timeout,
aborting req_op:READ(0) size:8192
nvme nvme0: Abort status: 0x0
* * *
nvme nvme0: I/O tag 960 (33c0) opcode 0x2 (I/O Cmd) QID 7 timeout,
reset controller

and subsequent freezing of some applications.

> Do you have a scheduler enabled on your device?
No. nvme0 is server-tire 30TB SSD.

> head /sys/block/*/queue/scheduler
=3D=3D> /sys/block/nvme0n1/queue/scheduler <=3D=3D
[none] mq-deadline kyber bfq

=3D=3D> /sys/block/nvme1n1/queue/scheduler <=3D=3D
[none] mq-deadline kyber bfq

=3D=3D> /sys/block/sda/queue/scheduler <=3D=3D
none mq-deadline kyber [bfq]

=3D=3D> /sys/block/sdb/queue/scheduler <=3D=3D
none mq-deadline kyber [bfq]

> How are you generating IO? Is it a pattern I should be able to replicate =
with 'fio'?

It's very complicated. Because it happens only when I update (podman
pull) a large (16 GB) Docker container.

$ podman images
REPOSITORY                                                   TAG
      IMAGE ID      CREATED       SIZE
dev-image-store.my-company.com/local-stand/service  25.2100-latest
513139713b48  19 hours ago  16.5 GB
dev-image-store.my-company.com/local-stand/service  25.1220-latest
920708d4b3dc  9 days ago    16.8 GB
dev-image-store.my-company.com/local-stand/service  25.1220
67d2af91f323  10 days ago   16.8 GB
dev-image-store.my-company.com/local-stand/service  25.2100
24e6817bff52  3 weeks ago   16.4 GB

Podman stores its images on the 30TB BTRFS partition located in /home.

--=20
Best Regards,
Mike Gavrilov.

