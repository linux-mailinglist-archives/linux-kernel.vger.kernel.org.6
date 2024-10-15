Return-Path: <linux-kernel+bounces-365115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0566599DDBE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 07:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B11C21F21EF9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 05:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37957178368;
	Tue, 15 Oct 2024 05:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Haw9srrH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0034173357
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 05:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728971728; cv=none; b=hI5LJ/65na5L/YHkm3CSUZViPY3MD6TZHoS1jXQuqTOkTqwwK92tGXD/Hc235oDICC2jA9ZQ0ObgxsdHB0zSTOrTmVVz6MWbt1zdko9gClZs8zG6STKWUKrjGkiUBHlVk4+E+2mS1vWBx3JnR3HCw2JISOPvjtCld6QEc37E9r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728971728; c=relaxed/simple;
	bh=x69P0Z65oXCH9k7dXC/rZ9aJQ5P/0luVc80ETZqatuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hD5wNoSNTk+BA89JYEjS4l+0LjVY96/zjBuVuU+VQmDmRIqWJFknYQaQih0Bdxsqf50n6nelYnXvY2+mIVBIIGps48Wy2vRvWdw635tPBB2E+K2Er2TGTrnJnJ9DSeS+GHn8oBAEeRB7aDXmRlyfFzOk9saAYeM2EnySF8+Yv1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Haw9srrH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728971725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nLop8z2nADHha6QKe8wKTicygsTgRvsS7+q08jtnUQY=;
	b=Haw9srrHp7cb9JEW7R6dyCd33pB3im/kZJMrULqGorfqeNiJXHnHOQD8+jO9P8jq9g8PWt
	lC2E4HqdlFdRVz622B+tQUlCWdSpuX91kJOcLhm3ar309Zpd90elAqmD6g/0JxqZoaRB1o
	rl3mRNGp4tAiHLpCw7Zszfxah3rjpec=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-T4Y7XtC2OXOThYFGKxCxtA-1; Tue, 15 Oct 2024 01:55:23 -0400
X-MC-Unique: T4Y7XtC2OXOThYFGKxCxtA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a9a2c3e75f0so15280966b.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 22:55:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728971722; x=1729576522;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nLop8z2nADHha6QKe8wKTicygsTgRvsS7+q08jtnUQY=;
        b=ds2LliHG69cRdLtU/7YwAdIiYiP1XF2fK8P00wqsr1ss86KVpCyGlSvFKVaEzwTa4N
         O37WbTDPqMFwB2ymy8wPoLIQotoe8W7XgszqF2ywln0GaP9aU7Ffu3bEEJ4kyezuy8fz
         F9cUvdB31Cy0iSHwZxF1je+JoVo+8tukyR/JvKyOMJdan9nkbt/Jlcwhj27xZDSOsGxL
         CNbu9ayBh3aELxWpqA27iGWEJW5eZAjxAzThghUT1FBo+8XONcJxeZ2XSqNU42zjAjdt
         Qbq8n/enUD4O0Ta31Oj3OCXTE9HDhjGzMAdhXh0yjfLTo465SBWRo49FLyND/bDbeUg1
         7KCA==
X-Forwarded-Encrypted: i=1; AJvYcCWC6feXmjJ63lQjtSVe9uIN1EQm6+KaB/oXljsUoHrMBJNxJMex/BKW4QCbbkwGwalhBtP0KvcrRV+fHZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzEu8Za/eYp3UbloKPKLwmjzjeKx3VGUDTIo5y6t49Ny3llSfr
	nFI9ehJwdyjbnsUOXW4C0+Z9rYWcL8S2c5EapRhTpy9eWbs+gCbBn1QZ6A13KcMPs98dKJek9of
	zUKbCsZgm6jekRaHzY46Agkl8fMp5q0O+vJ8h8Q7Hmev5HUhnO6uPD//zlDRAKk4DBWxPiK3+IS
	GZOECOpUZtNhm+NqQ0L2e5iZNiNv6dkdBVPARy
X-Received: by 2002:a17:907:846:b0:a99:4eac:bb98 with SMTP id a640c23a62f3a-a99e3e3e61bmr1001505066b.51.1728971721978;
        Mon, 14 Oct 2024 22:55:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjt5CGZTGpCyBOXaYD1O5WADuUpaIz5hSp3KPQ1fxEr1hHSQgXOGp8y5FVkyhKceluqiCgv5Ijc+HLMtC+mvE=
X-Received: by 2002:a17:907:846:b0:a99:4eac:bb98 with SMTP id
 a640c23a62f3a-a99e3e3e61bmr1001503966b.51.1728971721556; Mon, 14 Oct 2024
 22:55:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004015937.2286459-1-lulu@redhat.com> <20241004015937.2286459-4-lulu@redhat.com>
 <4z4lgkittsui6xv26h4gwo4o4xuut4sbcih6p7jxajwignftyq@catixvwskk5m>
In-Reply-To: <4z4lgkittsui6xv26h4gwo4o4xuut4sbcih6p7jxajwignftyq@catixvwskk5m>
From: Cindy Lu <lulu@redhat.com>
Date: Tue, 15 Oct 2024 13:54:44 +0800
Message-ID: <CACLfguVyO-L4z9qjVYnCLZvoGkYwLxViY7VWjrWsoHXzM7mW5w@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] vhost: Add kthread support in function vhost_workers_free()
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 7 Oct 2024 at 21:33, Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> On Fri, Oct 04, 2024 at 09:58:17AM GMT, Cindy Lu wrote:
> >Added back the previously removed function vhost_workers_free() and
> >renamed it to vhost_workers_free_khtread(). The new vhost_workers_free()
> >will select the different mode based on the value of the parameter.
> >
> >The old function vhost_workers_free was change to support task in
> >commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")
> >also changed in
> >commit a284f09effea ("vhost: Fix crash during early vhost_transport_send_pkt calls")
> >change to xarray in
> >commit 1cdaafa1b8b4 ("vhost: replace single worker pointer with xarray")
> >
> >Signed-off-by: Cindy Lu <lulu@redhat.com>
> >---
> > drivers/vhost/vhost.c | 52 ++++++++++++++++++++++++++++++++++++++-----
> > 1 file changed, 47 insertions(+), 5 deletions(-)
> >
> >diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> >index ad359d4b725f..fed6671c1ffb 100644
> >--- a/drivers/vhost/vhost.c
> >+++ b/drivers/vhost/vhost.c
> >@@ -648,8 +648,21 @@ static void vhost_detach_mm(struct vhost_dev *dev)
> >       dev->mm = NULL;
> > }
> >
> >-static void vhost_worker_destroy(struct vhost_dev *dev,
> >-                               struct vhost_worker *worker)
> >+static void vhost_worker_destroy_kthread(struct vhost_dev *dev,
> >+                                       struct vhost_worker *worker)
> >+{
> >+      if (!worker)
> >+              return;
> >+
> >+      WARN_ON(!llist_empty(&worker->work_list));
> >+
> >+      xa_erase(&dev->worker_xa, worker->id);
> >+      kthread_stop(worker->task);
> >+      kfree(worker);
> >+}
> >+
> >+static void vhost_worker_destroy_task(struct vhost_dev *dev,
> >+                                    struct vhost_worker *worker)
> > {
> >       if (!worker)
> >               return;
> >@@ -660,7 +673,7 @@ static void vhost_worker_destroy(struct vhost_dev *dev,
> >       kfree(worker);
> > }
> >
> >-static void vhost_workers_free(struct vhost_dev *dev)
> >+static void vhost_workers_free_task(struct vhost_dev *dev)
> > {
> >       struct vhost_worker *worker;
> >       unsigned long i;
> >@@ -675,10 +688,36 @@ static void vhost_workers_free(struct vhost_dev *dev)
> >        * created but couldn't clean up (it forgot or crashed).
> >        */
> >       xa_for_each(&dev->worker_xa, i, worker)
> >-              vhost_worker_destroy(dev, worker);
> >+              vhost_worker_destroy_task(dev, worker);
> >       xa_destroy(&dev->worker_xa);
> > }
> >
> >+static void vhost_workers_free_kthread(struct vhost_dev *dev)
> >+{
> >+      struct vhost_worker *worker;
> >+      unsigned long i;
> >+
> >+      if (!dev->use_worker)
> >+              return;
> >+
> >+      for (i = 0; i < dev->nvqs; i++)
> >+              rcu_assign_pointer(dev->vqs[i]->worker, NULL);
> >+      /*
> >+       * Free the default worker we created and cleanup workers userspace
> >+       * created but couldn't clean up (it forgot or crashed).
> >+       */
> >+      xa_for_each(&dev->worker_xa, i, worker)
> >+              vhost_worker_destroy_kthread(dev, worker);
> >+      xa_destroy(&dev->worker_xa);
> >+}
> >+
> >+static void vhost_workers_free(struct vhost_dev *dev)
> >+{
> >+      if (enforce_inherit_owner)
> >+              vhost_workers_free_task(dev);
> >+      else
> >+              vhost_workers_free_kthread(dev);
> >+}
>
> nit: new line here
>
sure, will fix this
> > static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
> > {
> >       struct vhost_worker *worker;
> >@@ -846,7 +885,10 @@ static int vhost_free_worker(struct vhost_dev *dev,
> >       __vhost_worker_flush(worker);
> >       mutex_unlock(&worker->mutex);
> >
> >-      vhost_worker_destroy(dev, worker);
> >+      if (enforce_inherit_owner)
> >+              vhost_worker_destroy_task(dev, worker);
> >+      else
> >+              vhost_worker_destroy_kthread(dev, worker);
> >       return 0;
> > }
> >
> >--
> >2.45.0
> >
> >
>


