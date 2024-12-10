Return-Path: <linux-kernel+bounces-440102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 650D29EB8CB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 18:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABC131672E3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 17:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45887204686;
	Tue, 10 Dec 2024 17:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a2LqzByO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874111C3F13
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 17:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733853272; cv=none; b=CynjjeUvUi4flyKFF8YJ1FR+OlBnHelZ6NSse+/c7XnAl3OYx0kHpMmE+hsZ8mCi/f5CY+KDnIKtj28xqKpuiTr6ADtGrIA9jymNm/OY3fHUjtxa+dNB1+zUy1lv4tDFPgBagUTErrOZTxOvcL2BBQSu6DYR3z3ZZFxAhvfXkvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733853272; c=relaxed/simple;
	bh=K9ByPjXthNnzk4FPK877f5xtZOPcLGkA29sc86con5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JXZ5y2VibhitFU4G+I0lqqin14Qe75WChwkBybDfPYvAJGhfe97/AwuMYbD88NUPGVWZSgQ5gEvLBWgR/x4z03Rx+DEbsBTpsIN56LUP1ChymPKFyHkx3YxSwx4p9l/nckJZ1rcn8CDd3wE4WFIr1wO04yerLlp4s3PMyAWUeyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a2LqzByO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733853268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1rRzY7/WWXd0NQuWwIWH9kGuyMdF7tM8qRG1Uei+GbU=;
	b=a2LqzByOOCA6McWSHwYLqtyXdfqbP5cR6dxkiy7GWmxQtGCqOvd4RsX8Z6diajPwCXt+xk
	pdvJ2cgCp/X4utf1DkvEv9zhiXkqzJvCZn01vOd48sr5jgSwACpo4UOaWOqVYRhV28tmyw
	7vAa+Ha0OEgvIh1d8nVKqQx293YZeDE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-aW1uQ1waPKOc8wQOo73P_w-1; Tue, 10 Dec 2024 12:54:26 -0500
X-MC-Unique: aW1uQ1waPKOc8wQOo73P_w-1
X-Mimecast-MFC-AGG-ID: aW1uQ1waPKOc8wQOo73P_w
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-434efe65e62so20262875e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:54:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733853265; x=1734458065;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1rRzY7/WWXd0NQuWwIWH9kGuyMdF7tM8qRG1Uei+GbU=;
        b=kNRVq2Ai0FSGea7C5QwCZz6+zXUqPIcl+BgzCGZhWg6/QrtB3cFe88Lz+TpnCJ6r7/
         CyCw7uxBhc6RijLH+08Lm6+Y4zLw+xuwjt3yqU46He2RffM5w0eiJSHTZTfkdWq5XECF
         3Fg3i+xHc08Yrp+SEwdLRs+mUvCydfdBV9VC7ecuYTCgdmDwWb95EVT7bnl2w6WXKEIf
         /zT8RowE5NuUAYwhcL3F2OKHMGuWKwK3/UJZ9pQz4vMFHpDPLh02E6cBzyXG/ZphDPqb
         L6KD8rM9ifLqz1x+GgkaNhsCRC/wGjxSlHfM4uynkpj4EbFNSOUnmFxIA+J0SdlEitlv
         BRpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSKEWCtrhJCd/6KL0ymsmIqJUAex3ak51G7blkf8QkbQbcMuSC8ILXpQMlIYht7F7Ylw5mnJ/qXel74FE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE8WXl0VJgfnI9DHaWaB/XI5HHW+iiI7W2o0vlpQRMWQvXKa0C
	nrVxbyy359LNlWfxNOrnWUeeHYuIiNNemeMJ61fuM114Lvk2dqBVVJWGl9BOAdy1OXT0yeYDiAe
	e4+q4gGo8ZwKyMXAjGzloAe9Xd9t+cRi1QfRZsYF2jEU82ByHp1ZNAlFdyMAOMg==
X-Gm-Gg: ASbGncvI1K5DTpfc/EFt9cjZYg0GrJ3zt0F1IjzxoE6/sEShca4lOZSW07wNuORyrcj
	Ht4qooIkQjVKDt149Gib5SzlOGz/LgcWuKO5DolEGmpUPwCDQJnfJjJR5BjGvfgBdVMV8nerEFl
	L6QsLZB00qSuW8alZ75ixIbOsHJSMG2smJA0ITQkKdmvssf9+UWa8199/R2OlKkUGVaxOon/kGY
	z2HDocNNQzSi+wHFksWiN28M7c4pGLazd1EUu7SOyCtlXb/k9XdNPa9BW2vGOLNg/EiNppMsOzu
	7DOW/wTWMIVZxI8g7ZBmoVi+tn26jw==
X-Received: by 2002:a05:600c:3d8f:b0:434:f131:1e6d with SMTP id 5b1f17b1804b1-434fff41b82mr59305305e9.10.1733853264788;
        Tue, 10 Dec 2024 09:54:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGPWoOUzyZKPwP8dqnFSdgd5moePBZMHqB64BaKkDl1ZXBJyZATfPmpsXV2IUepOobQ2Kj0XA==
X-Received: by 2002:a05:600c:3d8f:b0:434:f131:1e6d with SMTP id 5b1f17b1804b1-434fff41b82mr59304895e9.10.1733853264190;
        Tue, 10 Dec 2024 09:54:24 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-25-244.business.telecomitalia.it. [87.12.25.244])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861ecf42b2sm16120454f8f.12.2024.12.10.09.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 09:54:23 -0800 (PST)
Date: Tue, 10 Dec 2024 18:54:18 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v4 5/8] vhost: Add kthread support in function
 vhost_worker_queue()
Message-ID: <e2wooukn372tdfx374ffs54cotb3y3cy3jn7gn34u4ztnnrxw5@eio7rllodou2>
References: <20241210164456.925060-1-lulu@redhat.com>
 <20241210164456.925060-6-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241210164456.925060-6-lulu@redhat.com>

On Wed, Dec 11, 2024 at 12:41:44AM +0800, Cindy Lu wrote:
>The function vhost_worker_queue() uses a function pointer in
>vhost_worker, which is initialized based on the inherit_owner
>value.
>
>Signed-off-by: Cindy Lu <lulu@redhat.com>
>---
> drivers/vhost/vhost.c | 5 ++++-
> 1 file changed, 4 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>index 0175bbf4d8b3..d1aec41bcd56 100644
>--- a/drivers/vhost/vhost.c
>+++ b/drivers/vhost/vhost.c
>@@ -237,13 +237,16 @@ EXPORT_SYMBOL_GPL(vhost_poll_stop);
> static void vhost_worker_queue(struct vhost_worker *worker,
> 			       struct vhost_work *work)
> {
>+	if (!worker)
>+		return;
>+

In which scenario can `worker` be NULL?

I would like to better understand why it couldn't happen before and now 
it can.

Thanks,
Stefano

> 	if (!test_and_set_bit(VHOST_WORK_QUEUED, &work->flags)) {
> 		/* We can only add the work to the list after we're
> 		 * sure it was not in the list.
> 		 * test_and_set_bit() implies a memory barrier.
> 		 */
> 		llist_add(&work->node, &worker->work_list);
>-		vhost_task_wake(worker->vtsk);
>+		worker->task_wakeup(worker);
> 	}
> }
>
>-- 
>2.45.0
>


