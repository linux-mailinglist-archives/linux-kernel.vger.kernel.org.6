Return-Path: <linux-kernel+bounces-326787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A43CD976CEB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 17:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 315A41F258FC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 15:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7179548E0;
	Thu, 12 Sep 2024 15:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i/1bNx8d"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5985444C6F
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 15:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726153357; cv=none; b=fzagAXuXl4nk3K83KCDrGWdqLRBgkQjbhPdhnW+qbbvqK8sps/mjRc6GZuMCv926wUly9AdyxWHGh6M70kOr4e9fBSDC0M8YoQRUsxSYGZlksz0koMKvpM+IouU1VWZ1LLJzua+BI23Kx2MISk7/9s8Vr/71M5oXKuWfQZEc78Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726153357; c=relaxed/simple;
	bh=pCwUfPfW+tZr/wgmn6kXYp5e5XgcklV0FfGI1wa+ig4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TK4DxjoHis8xp0pTuk3mZJuK2BuuElwSB1JeQuhG3qz3Z8TdimQVYuqZ/DvTaGqZdJrwJ5TFLqZ/fN1aiuJyzkbXr/0KqW5f6+jayOlnRWNG5KlgLyWnCH+Lhbec6m2mm86dtaQxDv+9p3UJ54YUtyMqsT7F9Weng7REOjZkbTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i/1bNx8d; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726153354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=POUJMdgzbyeLPMy6EHJDd+KgN1IsD2zQwLwCfPdtios=;
	b=i/1bNx8dXZ8SGx874CATD9XrlO3TNW6J+VK+romtn2xHoUM9omj0yEaF5krXMA7xvabcMd
	HJ99qMAEgmpn/ICS/yTVW5ue1IseLfG4ESZsPSfq8GgSfNpN61Wpjz53/Ef+dnNMgNxbhn
	UokFB/RoFL7Rae0Jpy+twhSCFuDeYmQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-3jHgdKWSN7ql35IsjmRRLQ-1; Thu, 12 Sep 2024 11:02:33 -0400
X-MC-Unique: 3jHgdKWSN7ql35IsjmRRLQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42cb479fab2so11071985e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 08:02:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726153352; x=1726758152;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=POUJMdgzbyeLPMy6EHJDd+KgN1IsD2zQwLwCfPdtios=;
        b=VaemqQPQHB6QEbx1BtfjnCPOHtD1xYWe8Fs+EE/kBcQ9qwVcj4v83cyqSIGKLuMVHc
         3p/VfJbyvSVL0aPK4TslCFsI/eCMfCMtbCZXRz+YcPboGzC8rg+CdiLXg0RdxIn+WDsq
         KgSc4Ny6DHvnir2LNQZGa6aT5pYD7hbukp1KQRrc0XugvtvVXr+Lf4jJthvdm7UkGXCp
         tWCNesj9vUleDN0qTOKQ3yL/w59MUzb2Owt5bScB9BSskAFz0lHuHhpWJlGn9t3PjTKM
         /fBsXOjPG0Oh64h/gwe1feM6EMAuD0x4bAEarwu4Csmq/9Voa+tXZAWlqivl8ALxcpJd
         6tmg==
X-Gm-Message-State: AOJu0Yw8Sms4pDuDcxXcPA1cs6pzkOy5JiCadsvMv0pZ7Eqt+dfhKWl4
	a+99RItxfpy+M3or+rEylbQegfE1VcYUC1nrbhtRC5RfY6zGT70I+QEOaPRMwyn833VS/IvKvpX
	mL3pYMrKVEkC4xv1Kh3mdYrMY9JPRJIcg2LytSixrjvuIfR16dV1ue5399h0lDffAKIJw2Uue9T
	Yhk8GjLkJ3YDkhOnu9r1hcR2dH7nuJulwA3ikE0cU=
X-Received: by 2002:a5d:6a87:0:b0:367:8e57:8 with SMTP id ffacd0b85a97d-378a8a7ab0bmr6692336f8f.19.1726153351609;
        Thu, 12 Sep 2024 08:02:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQQPkAEY8RQQc+BFfq+NtbIjOBDj/FEKUqoUUMKlrrFseEWM6ZWT2N6n6+DXYJlT4UgCKLng==
X-Received: by 2002:a5d:6a87:0:b0:367:8e57:8 with SMTP id ffacd0b85a97d-378a8a7ab0bmr6692239f8f.19.1726153350627;
        Thu, 12 Sep 2024 08:02:30 -0700 (PDT)
Received: from redhat.com ([2a02:14f:177:45a6:a4e6:75a4:a286:2745])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cbbbf8a4csm108364955e9.47.2024.09.12.08.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 08:02:30 -0700 (PDT)
Date: Thu, 12 Sep 2024 11:02:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Marco Elver <elver@google.com>,
	syzbot+8a02104389c2e0ef5049@syzkaller.appspotmail.com,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH v2] virtio_ring: tag event_triggered as racy for KCSAN
Message-ID: <6bdd771a4fb7625a9227971b3cf4745c34c31a32.1726153334.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent

Setting event_triggered from the interrupt handler
is fundamentally racy. There are races of 2 types:
1. vq processing can read false value while interrupt
   triggered and set it to true.
   result will be a bit of extra work when disabling cbs, no big deal.

1. vq processing can set false value then interrupt
   immediately sets true value
   since interrupt then triggers a callback which will
   process buffers, this is also not an issue.

However, looks like KCSAN can not figure all this out, and warns about
the race between the write and the read.  Tag the access data_racy for
now.  We should probably look at ways to make this more
straight-forwardly correct.

Cc: Marco Elver <elver@google.com>
Reported-by: syzbot+8a02104389c2e0ef5049@syzkaller.appspotmail.com
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_ring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index be7309b1e860..98374ed7c577 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2588,7 +2588,7 @@ irqreturn_t vring_interrupt(int irq, void *_vq)
 
 	/* Just a hint for performance: so it's ok that this can be racy! */
 	if (vq->event)
-		vq->event_triggered = true;
+		data_race(vq->event_triggered = true);
 
 	pr_debug("virtqueue callback for %p (%p)\n", vq, vq->vq.callback);
 	if (vq->vq.callback)
-- 
MST


