Return-Path: <linux-kernel+bounces-365164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F73D99DE6A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 08:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 293111F24813
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 06:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579E4189F47;
	Tue, 15 Oct 2024 06:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DACy6eq5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA6A189BA9
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 06:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728973849; cv=none; b=gGNU0qXyrfIY61wziC7LJ4n9ASDz0MCWAAzVu2T30NqAJJwlXCZZ6k/6qHcEhps9/F3bKx+u6K6/AgGkLipuPxAvqt9CO5lNEHJXRnet0rBbbdV3Nn64DJMp3TPymf5E/+Vnzn3567j5mdiIfmlxLGafzyCcSCE+NsFIfZvAR/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728973849; c=relaxed/simple;
	bh=iqlpTDPssRh6Y5WPFC5t5f0ps5krq1Lvxz7uGIT8PhY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BNeo+PvZmowWLOG0LTvOlWgbtCzO0l9AGTCELX27NmcqY1XeX6twBAZjsBAe+K7AxiBIb7oWIrXxcxzuSa2a+fopesq2sjvczrTC94xqxwdgViCdxPvc90K0+ZsFP1V8QIjS6CcaPgbuKN94NEXt3LdZDENrJeiFdUHq5gJqL3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DACy6eq5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728973845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8jk67ZnwvaT69MO8EEaBF6QRTqEmY3du7hpoOAZQd7w=;
	b=DACy6eq53M7UkqzsoghMrYP46J91XR5qRkLyvL7S9PkehqZslsicIVee76aDM9J3zhO4Df
	+5g/2fxhCTmvOGCnJGacqpv9MMcaITMvsdlCCDMiGWJPvp4+fZgCRbR9qZ78OwtUT7FBOa
	q3Z9o6RRY3JwMeph5i3PWolpaQSeBAA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-nE5Uf87zN2ageDT04HFp5Q-1; Tue, 15 Oct 2024 02:30:44 -0400
X-MC-Unique: nE5Uf87zN2ageDT04HFp5Q-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a9a0710ca24so142140266b.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 23:30:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728973843; x=1729578643;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8jk67ZnwvaT69MO8EEaBF6QRTqEmY3du7hpoOAZQd7w=;
        b=WkueRBsocs5D6lXuk00vFahrsp62MeGT5o5hQOcXkwRLVRiI4DiURCWTtrwk5DMgoH
         u4clT+F4t8YyPC3mnmhFWYNIa58EttLXbJdLg0hoU45TxMuxvat6mIVwQ+7K8f6Lv9Xb
         VYqq0SN2FMdBROzRUCmTZ7n6oHksTnVYgsluvrEAwQim+epPqxEz5JXqpxQ6r4J7/Qer
         j4ZNR/SKitDjSHXy9txcMd0uWuSyRQA449miXvL6dySzdGpwu5A7oIPtGbMjE74oWUv8
         z6kj6jFhjbfOok/UpL5PbKQ55lwKJgTuKaPXxQHJVtHrROs4UuRMLqQfr8JroijqeyXB
         FRUw==
X-Forwarded-Encrypted: i=1; AJvYcCWzGyO8r9BNjwqqq5J6crv/uovHIlD9fdK/ZSoE5rGX/Fw81U14FOaYf1D5hOa+FBmVAAXHvp1+Su1bmZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNU6qq/r8AqExwD9xDp7vi69ovfC2rdWwCDk9oErOG2IenpSy3
	MmVsmTrTHIZdO/YRZqO5tKKShwKVq81tF0yvwEdCT02DK5cM1JZUHvTEa0wT8SGQDbzWMnDEwEj
	fh3XOYxFGp6UqT/LKBn7OK3pzPqfYdkDs7nLnALPViQw/95AgWDQV4XMwlqVIrwe61NEQYiPaHM
	Iptm8Yk7+HaC/M88s0UfqDOJd51h5L2AJAY944
X-Received: by 2002:a17:907:9288:b0:a9a:1585:dd6a with SMTP id a640c23a62f3a-a9a1585f6fcmr421157166b.36.1728973842907;
        Mon, 14 Oct 2024 23:30:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFFo6nEJ0i0crMHfbmLP0cYzCRHBgpqF2T2KbCZnHB1yGriJU9Zde0i+L/LSzxF6W7K8keK7004Y2J29YQRKw=
X-Received: by 2002:a17:907:9288:b0:a9a:1585:dd6a with SMTP id
 a640c23a62f3a-a9a1585f6fcmr421155366b.36.1728973842562; Mon, 14 Oct 2024
 23:30:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004015937.2286459-1-lulu@redhat.com> <20241004015937.2286459-7-lulu@redhat.com>
 <a317b7f1-b593-4cf0-a58a-8f375ad64f72@oracle.com>
In-Reply-To: <a317b7f1-b593-4cf0-a58a-8f375ad64f72@oracle.com>
From: Cindy Lu <lulu@redhat.com>
Date: Tue, 15 Oct 2024 14:30:05 +0800
Message-ID: <CACLfguWkYC-60RsxtLjkMcML9WR0ix8ieZH0T8nEZKK_29kisw@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] vhost: Add kthread support in function vhost_worker_create
To: Mike Christie <michael.christie@oracle.com>
Cc: jasowang@redhat.com, mst@redhat.com, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 15 Oct 2024 at 05:02, Mike Christie <michael.christie@oracle.com> wrote:
>
> On 10/3/24 8:58 PM, Cindy Lu wrote:
> > +static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
> > +{
> > +     if (enforce_inherit_owner)
> > +             return vhost_worker_create_task(dev);
> > +     else
> > +             return vhost_worker_create_kthread(dev);
> > +}
>
> The reason we are in this whole mess is because for vhost-scsi
> we wanted to create multiple worker threads as the single thread
> became a bottleneck. We couldn't use kthreads because they were
> not accounted for under thread that created it and we could
> exceed the NPROC_LIMIT.
>
> So with the above code, we could hit that problem again if userspace
> did the VHOST_NEW_WORKER ioctl and enforce_inherit_owner=false.
>
> You would want a check for enforce_inherit_owner in vhost_worker_ioctl.
>
sure, will add this check
Thanks
cindy


