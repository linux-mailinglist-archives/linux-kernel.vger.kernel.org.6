Return-Path: <linux-kernel+bounces-440099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 816269EB8BF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 18:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7846D1880207
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 17:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C397204681;
	Tue, 10 Dec 2024 17:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LG5eKT07"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A751AAA1C
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 17:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733853170; cv=none; b=gE72V3cikkTffa1hjEq03acmlmSjGhJLNBygKrb56NTsk4T3XZJdPn1c/0kMJSNJ8P+L+cYntasTDct2zQYBFfmALKOtalbHM1Q7vwCDXpjI+UbWGDPm55D/3+PgZx1zo/x9FhTqiOjag2Z15/KsdeM5JIk0DBsBbHdP2e9nGjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733853170; c=relaxed/simple;
	bh=DGmY49ZIKqA4CUxyhD2kOLWmzd1vsVv0boF4mbcySXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dkLvQWiOXtwwh8XQgtNx9dNiOoVMNil34qaQujmdvJ7oWW2dN8bKGc0FVjGLRoZoK/TGtELzd6vUBcj4tZDIBKZ5C8H34o9oEyELNUfE7dckRiw90SLrSiAQxRskEwEF6DH+criMGLPM7Z+Efuw5LblQF3v1vFwBSIt3Tj1oWu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LG5eKT07; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733853167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YqU+wCdvIl3266U71Sl65AIwUMu71vG8+SSC8yh1g38=;
	b=LG5eKT07wYpFYZME8t8T91vD+8z4pfR34wgFL7Un7lukcyb+XuQYjtcEtvH9NtjrHrU/Fo
	IM+gZRDDg0Az5ZNdkmPgmJJgP7UDjq4+PqZrZ+vzbPP9/CpezqxoAH/8x2N+SeeLMg22JA
	umvnU0mgUwDkjUGOheuWCSTfEBSUkzc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-1vmwI8N5Pt-l7hE1J6RfGA-1; Tue, 10 Dec 2024 12:52:46 -0500
X-MC-Unique: 1vmwI8N5Pt-l7hE1J6RfGA-1
X-Mimecast-MFC-AGG-ID: 1vmwI8N5Pt-l7hE1J6RfGA
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-385e00ebb16so2251582f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:52:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733853165; x=1734457965;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YqU+wCdvIl3266U71Sl65AIwUMu71vG8+SSC8yh1g38=;
        b=XoIax6cxcxlR83+mn7SGjDxRYL1cN7GR3KTjcVR1xkU/ooyKOBrW8nCZBYI+hlUd/q
         cjuYEd1HWs1aOhy5wHrDx+oIKIsGQIdDUAsBAWmjB12fCR9ArQLjTRty7S1s/Kgfs1yM
         AMd4wKoylzuRTDKvD7l9A4Qa6X8TJstqC42cwLos3hRPuAz6AepMYvdKCkUnzmb0ZeVE
         D2uuIf94+BDAzMSKo2xYujmOFMu1UJGLhbSCfqxzwoA0RZlpAIAHBKY4a43OT2X6nyZo
         OHVfgu0sAixgC9zyIjs+Qs7QWXwx//+WRs7UVUKzyza0sm1nceccI2Kt7z6Os/+ZEPZB
         O6PA==
X-Forwarded-Encrypted: i=1; AJvYcCW7/66SNV7RWstY8li8/pEHmwUb0bfZhvermB3/D2afb+hxY9d0mRtqge0ZeUvD47R+LfROJj7eyx3zHRU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxro7Jzg1aHU7Dvdf3AgQPDnN6bvSd2LALJeMeznvZRXWq5Dkpl
	1yMBqafzKcH7lxzGBhJgNIlR4LV9K45t+dZ4+mR7xquFIZ0PcTf7zLaIuqqSvF9MmCX/Sffi6QJ
	ztIK1F1fmnWETM+VQeXLLNwaatxExi//7AoGw7JcSPinu5uVKv+xOLJXhWPypRQ==
X-Gm-Gg: ASbGncs/YXfmO9jZ14OXz2wexF1n/GF690JcXm8TDdSyfZBus1hEq/6mo/Qj1WjBgmf
	BziB0uXtx0e00KcOIA0/i/3lR6yFlnYvVXA9tuw8YhzGxLs/V9Ql5kIzZxwwPq8dG46Zz4ZZiyd
	T8Nv3dJ4K2rHiBVQQehxrO1pT4WEIzmSyAIIPNtnisqXCglLGTmKCjyW7UefHAhUdgTKke0lHE/
	680Jxmpgf9Xm2kZ3DUtYiUS6cqoCUhhIwQMD8hhjP59d1ZBYG1y3TDRtPMQKCnpBfIYpFKLGn+p
	6t2jmZS7cTshaz36ezdntwE0DxXVzA==
X-Received: by 2002:a05:6000:481e:b0:385:e0d6:fb73 with SMTP id ffacd0b85a97d-3864ce54f0amr29308f8f.15.1733853165550;
        Tue, 10 Dec 2024 09:52:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHlIRanMyPY49k8LLWBeegAF0qzuzxLDFrLJbgvoiFUR/M2x7SIW77Vh90AfjtffquLWIfLFA==
X-Received: by 2002:a05:6000:481e:b0:385:e0d6:fb73 with SMTP id ffacd0b85a97d-3864ce54f0amr29278f8f.15.1733853164983;
        Tue, 10 Dec 2024 09:52:44 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-25-244.business.telecomitalia.it. [87.12.25.244])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434f387d112sm100286945e9.30.2024.12.10.09.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 09:52:44 -0800 (PST)
Date: Tue, 10 Dec 2024 18:52:41 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v4 2/8] vhost: Add the vhost_worker to support kthread
Message-ID: <tah7oyn43szvjmuzdatcaysonqlzel5zok2ancuupk5eir2hh3@xfq7uacjn7rn>
References: <20241210164456.925060-1-lulu@redhat.com>
 <20241210164456.925060-3-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241210164456.925060-3-lulu@redhat.com>

On Wed, Dec 11, 2024 at 12:41:41AM +0800, Cindy Lu wrote:
>Add the previously removed function vhost_worker() back
>to support the kthread and rename it to vhost_run_work_kthread_list.
>
>The old function vhost_worker was change to support task in

s/change/changed

>commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")
>change to xarray in

"and to support multiple workers per device using xarray in"

>commit 1cdaafa1b8b4 ("vhost: replace single worker pointer with xarray")
>
>Signed-off-by: Cindy Lu <lulu@redhat.com>
>---
> drivers/vhost/vhost.c | 38 ++++++++++++++++++++++++++++++++++++++
> 1 file changed, 38 insertions(+)
>
>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>index eaddbd39c29b..1feba29abf95 100644
>--- a/drivers/vhost/vhost.c
>+++ b/drivers/vhost/vhost.c
>@@ -388,6 +388,44 @@ static void vhost_vq_reset(struct vhost_dev *dev,
> 	__vhost_vq_meta_reset(vq);
> }
>
>+static int vhost_run_work_kthread_list(void *data)
>+{
>+	struct vhost_worker *worker = data;
>+	struct vhost_work *work, *work_next;
>+	struct vhost_dev *dev = worker->dev;
>+	struct llist_node *node;
>+
>+	kthread_use_mm(dev->mm);
>+
>+	for (;;) {
>+		/* mb paired w/ kthread_stop */
>+		set_current_state(TASK_INTERRUPTIBLE);
>+
>+		if (kthread_should_stop()) {
>+			__set_current_state(TASK_RUNNING);
>+			break;
>+		}
>+		node = llist_del_all(&worker->work_list);
>+		if (!node)
>+			schedule();
>+
>+		node = llist_reverse_order(node);
>+		/* make sure flag is seen after deletion */
>+		smp_wmb();
>+		llist_for_each_entry_safe(work, work_next, node, node) {
>+			clear_bit(VHOST_WORK_QUEUED, &work->flags);
>+			__set_current_state(TASK_RUNNING);
>+			kcov_remote_start_common(worker->kcov_handle);
>+			work->fn(work);
>+			kcov_remote_stop();
>+			cond_resched();
>+		}
>+	}
>+	kthread_unuse_mm(dev->mm);
>+
>+	return 0;
>+}
>+
> static bool vhost_run_work_list(void *data)
> {
> 	struct vhost_worker *worker = data;
>-- 
>2.45.0
>


