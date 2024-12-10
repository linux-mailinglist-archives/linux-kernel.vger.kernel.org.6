Return-Path: <linux-kernel+bounces-440100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 326379EB8C3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 18:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3E52167159
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 17:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E03E2046AB;
	Tue, 10 Dec 2024 17:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gJCn+yP8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447F31C3F13
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 17:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733853197; cv=none; b=XP1CCLX6KNt/Sd39txGUwriPKfGqj4QLwwjSkEDj/gOMJi9DEfY0DJr/OlXlQO+hEfL+7qEUIylfSR/CW5CxqFcxcf7FV77P+f+Hx0pw+yvfWHZzEwdUwDAiqAsEhxXNMyq+69+uPxNDy4P0C1h3BXZwMEDXAeNYLUVTrahhFKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733853197; c=relaxed/simple;
	bh=GiA6E6YUT24hkxZZfyf2XJKY4+22S6/8ZvzlZG2X5rA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EiqjQxkk/83BvuH8uKufAb8oZf9wF76VsUSaxsHBymXQw+3EcgRFjyPq8MLIRfgtJU5wImM5Jq6HJ9F5pHoyp6yUeQVuCMNRGdBgGdkafIsvgutee5pSnCCWVeU8BPsEaZPjpkRcucR49CTr+Wtj0BRJ7FrWBGd92J/PF1aLyow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gJCn+yP8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733853194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V7+hheXjFxQWX/A6CbQM2y9lEoN18zy57mFtnrvRGzE=;
	b=gJCn+yP8vPPSth8nlHEFz1Y9Ju1H1++Vs4FPskH8JDfIqrhlhaqcMqAdqFYaLDA48U605I
	PVafCcF3ocbTq9yIopJHnnumE42iqSqmyhLZyLynr102W8JBH+yseJxqCjsKOtJ7n80aVn
	H9Hcb76MaAj4OaLcRy7tXYF2oujnCss=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-6lhAhdFeOf6SttbMsYt7LA-1; Tue, 10 Dec 2024 12:53:13 -0500
X-MC-Unique: 6lhAhdFeOf6SttbMsYt7LA-1
X-Mimecast-MFC-AGG-ID: 6lhAhdFeOf6SttbMsYt7LA
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-385e3cbf308so1436304f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:53:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733853191; x=1734457991;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V7+hheXjFxQWX/A6CbQM2y9lEoN18zy57mFtnrvRGzE=;
        b=UlevNERO9uvQWArGUAJ1jQvZ4CJ3wGM7UqdNM7me54fgUhnVE4v873lDx2Pd8LqF3r
         k+1KJUHQJRG2tqmrC6r4AV3Z2dJ3lNo1J4xe+WHh6wg0y2Z6GOEo4tnwj4pUkezc//1z
         UWlqefzdhWP6Q4NtAAr6Ey7lxMJJjfpo6IF5FTRh3BCgT9Ja3ZKVa+xTQwZyTVD/BfU0
         4jTjWDCVtUIB2vuE9Nv1FfTngEeSFyQpDsU8clK6OS+TeU+Xydf8axnp3Q1Hb3VYECy3
         5BWCrD3UqXWWFNkw9AX/MLoQXAgN61PI8H5HbClV8NvxTvru4zIWKU+A8NngSvqJAUKS
         fbNA==
X-Forwarded-Encrypted: i=1; AJvYcCWSUG7ArVfYIgcRdbmMHOjQLUyJPnR4MLxTRCHqiBB4fYsqfhuPnvEvmu+o3PyzW+4wgUrcLT5DPNQTynY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi8AIFk26kx1FY2vjss6mLKMZ3GeGb66M1hlSbte2hC6u2oavk
	b9iIWeZqI7xTvma7TrUsSOLeMK4AcOO3mjH/DScfWeXRQlmiF2yeNj4+h+kzDxHa+TKxvgJGVmn
	lAdBkybvK40/swuz/rW3m1X5RPiR3myaxMgaPnniNE0ZQMy9m7xp7WopHiy9Voufap3/GlA==
X-Gm-Gg: ASbGncsx1RztHPRT8WCCiWN8PeFwXxTk/keOc7pIIhMyCaGL+Ze6Y6N/1dv9aufYwxD
	buWvky1XieGIjpM1Ryv7dTtf9+ZGjC5QNVv+vVFVaefVHJ+zwBrL7l7JOQXKBkvDZwJt2WQvW0a
	H1T9tfZ9Wj2chpxf3y+VLZFVsBTTYdw4Q7K5pqgaUHn+t3kjbnTzUUEeZL5P35aKya4LgOlaA6o
	CDIobWzXmcrzUA2977mOaXvDGmNiQvX/8jI4hwldcAgqRUyvbPIe5IOENZNSQXcsqpDNvSeZpZX
	4nSz7DWxPf4bqGpoY7FifcrogV1YLw==
X-Received: by 2002:a5d:5f91:0:b0:385:e43a:4dd8 with SMTP id ffacd0b85a97d-3864ce86740mr20241f8f.4.1733853191429;
        Tue, 10 Dec 2024 09:53:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGyNGcJtqIvdODAbGKru3zIfA/gLNJtt/5XcSx5m5F9FIgAvZT/2YjpbC5CxbPoDO18XR8O7g==
X-Received: by 2002:a5d:5f91:0:b0:385:e43a:4dd8 with SMTP id ffacd0b85a97d-3864ce86740mr20218f8f.4.1733853190735;
        Tue, 10 Dec 2024 09:53:10 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-25-244.business.telecomitalia.it. [87.12.25.244])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3862d3f57a0sm13157753f8f.108.2024.12.10.09.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 09:53:10 -0800 (PST)
Date: Tue, 10 Dec 2024 18:53:05 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v4 3/8] vhost: Add the cgroup related function
Message-ID: <yo2wq3brumnud4e7a4f4ni5s37olicv3ksvztcetgj2urmccks@qvrutryfahmf>
References: <20241210164456.925060-1-lulu@redhat.com>
 <20241210164456.925060-4-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241210164456.925060-4-lulu@redhat.com>

On Wed, Dec 11, 2024 at 12:41:42AM +0800, Cindy Lu wrote:
>Add back the previously removed cgroup function to support the kthread

nit: missing . at the end

>The biggest change for this part is in vhost_attach_cgroups() and
>vhost_attach_task_to_cgroups().

It's not clear what the big change is, is there a piece missing?

>
>The old function was remove in

s/remove/removed

BTW which is the old function?

>commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")
>
>Signed-off-by: Cindy Lu <lulu@redhat.com>
>---
> drivers/vhost/vhost.c | 33 +++++++++++++++++++++++++++++++++
> 1 file changed, 33 insertions(+)
>
>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>index 1feba29abf95..812dfd218bc2 100644
>--- a/drivers/vhost/vhost.c
>+++ b/drivers/vhost/vhost.c
>@@ -22,6 +22,7 @@
> #include <linux/slab.h>
> #include <linux/vmalloc.h>
> #include <linux/kthread.h>
>+#include <linux/cgroup.h>
> #include <linux/module.h>
> #include <linux/sort.h>
> #include <linux/sched/mm.h>
>@@ -620,6 +621,38 @@ long vhost_dev_check_owner(struct vhost_dev *dev)
> }
> EXPORT_SYMBOL_GPL(vhost_dev_check_owner);
>
>+struct vhost_attach_cgroups_struct {
>+	struct vhost_work work;
>+	struct task_struct *owner;
>+	int ret;
>+};
>+
>+static void vhost_attach_cgroups_work(struct vhost_work *work)
>+{
>+	struct vhost_attach_cgroups_struct *s;
>+
>+	s = container_of(work, struct vhost_attach_cgroups_struct, work);
>+	s->ret = cgroup_attach_task_all(s->owner, current);
>+}
>+
>+static int vhost_attach_task_to_cgroups(struct vhost_worker *worker)

This function looks renamed, should we mention in the commit 
description?

>+{
>+	struct vhost_flush_struct flush;
>+	struct vhost_attach_cgroups_struct attach;
>+
>+	attach.owner = current;
>+
>+	vhost_work_init(&attach.work, vhost_attach_cgroups_work);
>+	vhost_worker_queue(worker, &attach.work);
>+
>+	init_completion(&flush.wait_event);
>+	vhost_work_init(&flush.work, vhost_flush_work);
>+	vhost_worker_queue(worker, &flush.work);
>+	wait_for_completion(&flush.wait_event);

IIUC this block is the old "vhost_dev_flush", right?

Maybe we should mention also that in the commit description.

>+
>+	return attach.ret;
>+}
>+
> /* Caller should have device mutex */
> bool vhost_dev_has_owner(struct vhost_dev *dev)
> {
>-- 
>2.45.0
>


