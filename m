Return-Path: <linux-kernel+bounces-532831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A607CA452B1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 03:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81B7C16FBD1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 02:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573FF47F4A;
	Wed, 26 Feb 2025 02:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qx6+KCev"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40A918FDDF
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 02:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740535528; cv=none; b=rK3Svqh0cC44mpLHB8AZc+KbyLebGhbzzZ3K5WzryzVe6mGilJ+75WSF6ES0FJVz0CiT8VgI3ZMdD2oknZPgJzjnnWdqmjlWUEg4ZhfcAJ/RTPOipvsQw0zPgL8ouhQLlxpR/1RKnRKapqIzVKZw4IJKCH40VjBOVM8jM6ENz04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740535528; c=relaxed/simple;
	bh=JCftPQYVyvK+z4ejhkMDA1JxlGnB45HtW0/686G+fKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M7P6wk4cnr9+QTf6D69xIBT9tNI1Q5lk7STHa6Hda4Wc4HweF/oyM8WYC6VEV0H38bF3H6POBEb2YYH9FMgFh8V39BXPvWy9kmgQdjhDtY+G9fFvWFD5bqmf/837FaGVk8mvWVBxFPDw4zs3yFRV1RKmBzqksBrsfFRTlZkqu80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qx6+KCev; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740535525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=57XmEgDKKtefwUvQro1qxevSUUpBlr1i0FY1HHy6KeA=;
	b=Qx6+KCev5WvUuGAsvoNGPm3AXroILOq6/6xi3fGB4CkZrKqYbZJoDfGulR0zIxieKlXy9a
	+VeCyaN2O0hWvv5PJn3SfsZPbEQMnXI10z8nzLxVp4j8KebBgDyaXjsWEh1r0mjqyJ4UkK
	Rs1UfVJVH+fj9TrvV12Ca+f7Wzy8wrY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-9MizpNOmOAOJyhP8MOtujA-1; Tue, 25 Feb 2025 21:05:23 -0500
X-MC-Unique: 9MizpNOmOAOJyhP8MOtujA-1
X-Mimecast-MFC-AGG-ID: 9MizpNOmOAOJyhP8MOtujA_1740535522
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ab68fbe53a4so691095366b.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 18:05:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740535522; x=1741140322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=57XmEgDKKtefwUvQro1qxevSUUpBlr1i0FY1HHy6KeA=;
        b=gWg9PuWF7Q9u7l+p8tAkXFXf2e2YSMq7ls7L/I0VwTCNjZq42aO+FIRN/13SWS6RLI
         NWyJvKNaBGGB7qtIc8bBSZB6y1mBTPg0y03MgsiZCqWSqaxALQXDPAy6CZg+LthAtLQi
         Wt/Wi7YJkOoGBocGrfy+S7p4ERLbLBR21Ueqzq0VeqtPq2G/Gs5eZSIqU+AxQKBi1Axa
         uZpnDdEBqWmX6nyX7R6EaM7ApGxCFrtRS7JWCAj4+bN8GUsA+YNIguI76bgnVSlge4Uq
         /3xKFfvgn7QOZXeIIowrXGele3E8jrFtJ5yIq3+P5/9yr/5VJ+sJVhnxhjmknEG6HqNS
         RGXA==
X-Forwarded-Encrypted: i=1; AJvYcCWHq3L9DyxBur7GkvTY87ivyjJtvHRLKqq0Y+qyW/FHJL1xQ76BnGLC5Do6vY+2F+1ecN5EofjxFgOxxYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUAtSv92YitfAgKsAe2PzfK2bdQ1fUm/qfTJ9sfIXS4pGzHSc5
	A4Jp6azUf4apf8tWG0+NAYEV8Of5+Y41bMVLYjnT9Kc3xF79UJEuwQ5YezjiRtGeXDffOqbnXTT
	dShvc/DiNYCtoB3WXfgvVb8BNvs1U2yppqLZTVjyRtDu/2TgY6l4gS1nIh9J49tocgC1ETdDcXA
	iMVS30NFogXvZEir++tHrUmRb74gQLyHhGe4EA
X-Gm-Gg: ASbGncvGEaKVYuAzP+6EuL4TgheYntJ70TTL2pw+9xHQc8D27kkD4K7K8uRmXSxWGmh
	xs9c1G+V7F5SMZ5FuAbF0uWf60CM/uohw5hPDH+Bzwyf1F5Agpe+MKbwvIcsVaHMv9x3iAhLF6A
	==
X-Received: by 2002:a17:906:6a18:b0:ab6:d6c3:f1e2 with SMTP id a640c23a62f3a-abed101a68emr584728166b.38.1740535522481;
        Tue, 25 Feb 2025 18:05:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEDnpl2j+0DavpNWZdYT5Z/FgRyn64TInVqaEucZU+lYsdoJPEs6pdWR0j3CR6bsT3Arc59/ceBLEEvkVFCxxI=
X-Received: by 2002:a17:906:6a18:b0:ab6:d6c3:f1e2 with SMTP id
 a640c23a62f3a-abed101a68emr584726366b.38.1740535522087; Tue, 25 Feb 2025
 18:05:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250223154042.556001-1-lulu@redhat.com> <20250224164233-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250224164233-mutt-send-email-mst@kernel.org>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 26 Feb 2025 10:04:44 +0800
X-Gm-Features: AQ5f1JqiQ7lr3YyNb7nTi5Z3YzGts4m-JzTljklxhrdzE-njba0nKckam0rKUMM
Message-ID: <CACLfguVo+04seP-hmbVjzKBVk4XfXcPvtRsuHOiiMUn7fzJB8g@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] vhost: Add support of kthread API
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 5:43=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Sun, Feb 23, 2025 at 11:36:15PM +0800, Cindy Lu wrote:
> > In commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads"),
> > the vhost now uses vhost_task and operates as a child of the
> > owner thread. This aligns with containerization principles.
> > However, this change has caused confusion for some legacy
> > userspace applications. Therefore, we are reintroducing
> > support for the kthread API.
>
>
> This looks good to me.
>
> Pls address Jason's comments and add a Kconfig knob, and I will apply/
>
Thank you MST, I will add this
thanks
Cindy
> > In this series, a new UAPI is implemented to allow
> > userspace applications to configure their thread mode.
> >
> > Changelog v2:
> >  1. Change the module_param's name to enforce_inherit_owner, and the de=
fault value is true.
> >  2. Change the UAPI's name to VHOST_SET_INHERIT_FROM_OWNER.
> >
> > Changelog v3:
> >  1. Change the module_param's name to inherit_owner_default, and the de=
fault value is true.
> >  2. Add a structure for task function; the worker will select a differe=
nt mode based on the value inherit_owner.
> >  3. device will have their own inherit_owner in struct vhost_dev
> >  4. Address other comments
> >
> > Changelog v4:
> >  1. remove the module_param, only keep the UAPI
> >  2. remove the structure for task function; change to use the function =
pointer in vhost_worker
> >  3. fix the issue in vhost_worker_create and vhost_dev_ioctl
> >  4. Address other comments
> >
> > Changelog v5:
> >  1. Change wakeup and stop function pointers in struct vhost_worker to =
void.
> >  2. merging patches 4, 5, 6 in a single patch
> >  3. Fix spelling issues and address other comments.
> >
> > Changelog v6:
> >  1. move the check of VHOST_NEW_WORKER from vhost_scsi to vhost
> >  2. Change the ioctl name VHOST_SET_INHERIT_FROM_OWNER to VHOST_FORK_FR=
OM_OWNER
> >  3. reuse the function __vhost_worker_flush
> >  4. use a ops sturct to support worker relates function
> >  5. reset the value of inherit_owner in vhost_dev_reset_owner
> >
> > Tested with QEMU with kthread mode/task mode/kthread+task mode
> >
> > Cindy Lu (6):
> >   vhost: Add a new parameter in vhost_dev to allow user select kthread
> >   vhost: Reintroduce vhost_worker to support kthread
> >   vhost: Add the cgroup related function
> >   vhost: introduce worker ops to support multiple thread models
> >   vhost: Add new UAPI to support change to task mode
> >   vhost: Add check for inherit_owner status
> >
> >  drivers/vhost/vhost.c      | 227 +++++++++++++++++++++++++++++++++----
> >  drivers/vhost/vhost.h      |  13 +++
> >  include/uapi/linux/vhost.h |  18 +++
> >  3 files changed, 234 insertions(+), 24 deletions(-)
> >
> > --
> > 2.45.0
>


