Return-Path: <linux-kernel+bounces-353415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C30B2992D76
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80DB628495F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 13:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A611D5CFE;
	Mon,  7 Oct 2024 13:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J1ppXsGT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC0A1D4351
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 13:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728307982; cv=none; b=m8PyMX9gWpgbBjAI50os2zgrwhtP7dfcy6LVemn7IIgse657ePd8K6mdT9ob9vvonc7ThNCYqdWmJZRrTtMi4Ey5DYMcc4hdKomg8k0otAqLNJm8zqxtWIeotD5tSZ+tgQjzJ9dllf7tWk4uvsp78FEvX0qrUUbgT4lADwYseaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728307982; c=relaxed/simple;
	bh=xFFQ1MQf5j6u4d/PzJtIt6kJj1vEBw9MYBPu8ZPD6pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kwnvszUAcpajc1G5wViC71PaO+Db2pCFq2etnXYE7peYeDRURPwd/630n4szJTYrcmnDE66tQzemUgsPwbKd6eZZUsXaqQep8qbxVBIE/EMm0apuev+y8LI5TTL8dUfI4MnUrMfWZIVnb2PZec4sayhTX8qjbSvaGc0EiUkTySU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J1ppXsGT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728307978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OTN4CRfzPnQ/qrZpds/jhk2KkRl2haBLO3LpgMX8X/c=;
	b=J1ppXsGTezidmvDhqONgbps8nuRydF+URqo2bXqEgo3tqpOfdiBX80QKUPE3BOnPtL0yi2
	xSmkwE+FRO3mt/NOx0/7rIxayLKXyqxp/pHe0FatvQvvJU9/JzP5olu7ovjrBFXseVkHDJ
	aWEbrK8pZSq2lEN3w4RvMtqFEpHDvvQ=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-3w2Xet2ON3Gz45_PLm62hg-1; Mon, 07 Oct 2024 09:32:56 -0400
X-MC-Unique: 3w2Xet2ON3Gz45_PLm62hg-1
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a34ebe595bso57810125ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 06:32:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728307976; x=1728912776;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OTN4CRfzPnQ/qrZpds/jhk2KkRl2haBLO3LpgMX8X/c=;
        b=DQ0kdTSaP+NACt+4uk+f2GPTPXu/UXiy73e/nPq2mF/7wWn3AcPKmacOkmlJV+ESKm
         a3amwCf2BKYRwwizZqQAejzWMrkxrc7Wyr49mb0DYdYgtSloUUSvoojGj2GB4I7IMU4m
         Sv1mlLkomV4sbLTDBOmtL80OZlOsoUg4Ptws1vsmGPPdi2CowyerFoPtl45Gn/5G0G0z
         0E3aclDUroai2xHl8qY8KGn5vYKMmHjV70PmZ3Y2lTkW5TsJ+jf0YBINYCHoHPbToYVq
         SeKYQAGtE0MWpnX7F636nABAU2eJ2queN9C+U1ksw5kIDACb3PQ1aVguYXOtjgypIF5E
         4yuw==
X-Forwarded-Encrypted: i=1; AJvYcCW1Jdc2OjBWsEN7Blw4GANvD6N7D5bjHTmW4dzoHSi2igoKq8tXnRs0b8kyO2LgSTGRFFSFDrg1foAbHI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YypQI8waiT/0/ggK11VBPHq3J7JAKOiOXbOf7mLJnZyK/x2oKVq
	XTHvENb39Pln3vrsZbCy75sEbDM5CrvG2ijeBI+viltvL5925unbnMOTftSJ8/CJzrX6NUXpDyO
	ZABRdEzDJQNy7fhihf+7hZIr9LlE7HUmZhqAuVeYw8HassWbNaVl6bTAONPpH/Q==
X-Received: by 2002:a05:6e02:13ae:b0:3a1:a57a:40a4 with SMTP id e9e14a558f8ab-3a375b9cdb6mr108023885ab.14.1728307975949;
        Mon, 07 Oct 2024 06:32:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/UTDImvemizxdOzxc8SgbKn3v2FDbIAI+glc8weW/S+V4tQELtKLGbB5hHuDm0/kTZK4uNw==
X-Received: by 2002:a05:6e02:13ae:b0:3a1:a57a:40a4 with SMTP id e9e14a558f8ab-3a375b9cdb6mr108023175ab.14.1728307975203;
        Mon, 07 Oct 2024 06:32:55 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-231.retail.telecomitalia.it. [79.46.200.231])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4db6eb868fbsm1163255173.76.2024.10.07.06.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 06:32:54 -0700 (PDT)
Date: Mon, 7 Oct 2024 15:32:48 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 3/7] vhost: Add kthread support in function
 vhost_workers_free()
Message-ID: <4z4lgkittsui6xv26h4gwo4o4xuut4sbcih6p7jxajwignftyq@catixvwskk5m>
References: <20241004015937.2286459-1-lulu@redhat.com>
 <20241004015937.2286459-4-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241004015937.2286459-4-lulu@redhat.com>

On Fri, Oct 04, 2024 at 09:58:17AM GMT, Cindy Lu wrote:
>Added back the previously removed function vhost_workers_free() and
>renamed it to vhost_workers_free_khtread(). The new vhost_workers_free()
>will select the different mode based on the value of the parameter.
>
>The old function vhost_workers_free was change to support task in
>commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")
>also changed in
>commit a284f09effea ("vhost: Fix crash during early vhost_transport_send_pkt calls")
>change to xarray in
>commit 1cdaafa1b8b4 ("vhost: replace single worker pointer with xarray")
>
>Signed-off-by: Cindy Lu <lulu@redhat.com>
>---
> drivers/vhost/vhost.c | 52 ++++++++++++++++++++++++++++++++++++++-----
> 1 file changed, 47 insertions(+), 5 deletions(-)
>
>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>index ad359d4b725f..fed6671c1ffb 100644
>--- a/drivers/vhost/vhost.c
>+++ b/drivers/vhost/vhost.c
>@@ -648,8 +648,21 @@ static void vhost_detach_mm(struct vhost_dev *dev)
> 	dev->mm = NULL;
> }
>
>-static void vhost_worker_destroy(struct vhost_dev *dev,
>-				 struct vhost_worker *worker)
>+static void vhost_worker_destroy_kthread(struct vhost_dev *dev,
>+					 struct vhost_worker *worker)
>+{
>+	if (!worker)
>+		return;
>+
>+	WARN_ON(!llist_empty(&worker->work_list));
>+
>+	xa_erase(&dev->worker_xa, worker->id);
>+	kthread_stop(worker->task);
>+	kfree(worker);
>+}
>+
>+static void vhost_worker_destroy_task(struct vhost_dev *dev,
>+				      struct vhost_worker *worker)
> {
> 	if (!worker)
> 		return;
>@@ -660,7 +673,7 @@ static void vhost_worker_destroy(struct vhost_dev *dev,
> 	kfree(worker);
> }
>
>-static void vhost_workers_free(struct vhost_dev *dev)
>+static void vhost_workers_free_task(struct vhost_dev *dev)
> {
> 	struct vhost_worker *worker;
> 	unsigned long i;
>@@ -675,10 +688,36 @@ static void vhost_workers_free(struct vhost_dev *dev)
> 	 * created but couldn't clean up (it forgot or crashed).
> 	 */
> 	xa_for_each(&dev->worker_xa, i, worker)
>-		vhost_worker_destroy(dev, worker);
>+		vhost_worker_destroy_task(dev, worker);
> 	xa_destroy(&dev->worker_xa);
> }
>
>+static void vhost_workers_free_kthread(struct vhost_dev *dev)
>+{
>+	struct vhost_worker *worker;
>+	unsigned long i;
>+
>+	if (!dev->use_worker)
>+		return;
>+
>+	for (i = 0; i < dev->nvqs; i++)
>+		rcu_assign_pointer(dev->vqs[i]->worker, NULL);
>+	/*
>+	 * Free the default worker we created and cleanup workers userspace
>+	 * created but couldn't clean up (it forgot or crashed).
>+	 */
>+	xa_for_each(&dev->worker_xa, i, worker)
>+		vhost_worker_destroy_kthread(dev, worker);
>+	xa_destroy(&dev->worker_xa);
>+}
>+
>+static void vhost_workers_free(struct vhost_dev *dev)
>+{
>+	if (enforce_inherit_owner)
>+		vhost_workers_free_task(dev);
>+	else
>+		vhost_workers_free_kthread(dev);
>+}

nit: new line here

> static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
> {
> 	struct vhost_worker *worker;
>@@ -846,7 +885,10 @@ static int vhost_free_worker(struct vhost_dev *dev,
> 	__vhost_worker_flush(worker);
> 	mutex_unlock(&worker->mutex);
>
>-	vhost_worker_destroy(dev, worker);
>+	if (enforce_inherit_owner)
>+		vhost_worker_destroy_task(dev, worker);
>+	else
>+		vhost_worker_destroy_kthread(dev, worker);
> 	return 0;
> }
>
>-- 
>2.45.0
>
>


