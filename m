Return-Path: <linux-kernel+bounces-439450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D639EAF7F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 12:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CB632894EA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 11:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1EFA2153E7;
	Tue, 10 Dec 2024 11:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="esh+EjNi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1E9210F56
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 11:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733829009; cv=none; b=UZbRPyZ3UwvnTMKAPoXb8P32BBSUvoge3ujW8HCk2LQC3dZMqdRHXjPNZCPX289HHW8O4choHort0Xk164A7NbycuYKbhIy7lfqnZzwPlSKSozbQ1MfmIk7er5Rn0dBoQMjYpr3J0s8kCEtVqyhqRbmj6ZFrkzefBA8m1iaUSL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733829009; c=relaxed/simple;
	bh=FMEKrToJmfBes2IkIWI0FUbZrDzX9gRWI0fGcz6poD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P3XNHzQLSgmLm7ULyWUyeZ6T77M1yyZ6kuVJwSLM9DbbITpvN4NIDtjab8piKkmzasTXGGpg2JekrIJ8lgcm+hrgwDoSlvaBmDlUNSqxkOhbls+sPWuj882iBb9n5S2P7Lp9ImplGPha+FdLt+uPx3HNQdU7n+SKrtV+Bv963d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=esh+EjNi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733829005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QUiqFq4GdwpAzAF+gSyIYQSFTlqcU1aOkiz1L8FVzVk=;
	b=esh+EjNiOfDdkyJERk7937vFvkZN8yKe2W9UDgcNaym2Dj2oSw106TaHLfxNhSJt4MqNUs
	I+JMayU06NOcZ+jMLNtuD8RbFLwr1XTbJcbQTAyBIXVYuERx8MYA3ROYX55FUAnH0PTcMl
	K7BRT/rsECiDk9I3uYz3u92Uw8ItApM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-zkJHE2LyMi6qBhXZN9jtdQ-1; Tue, 10 Dec 2024 06:10:04 -0500
X-MC-Unique: zkJHE2LyMi6qBhXZN9jtdQ-1
X-Mimecast-MFC-AGG-ID: zkJHE2LyMi6qBhXZN9jtdQ
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5d3f3d6a999so2378886a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 03:10:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733829002; x=1734433802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QUiqFq4GdwpAzAF+gSyIYQSFTlqcU1aOkiz1L8FVzVk=;
        b=S/nABlvvU1clvBoTQXre/ahodepf3WqJ/vi9NO9bVYfM/EpRFlU9e8lzi1hRLDuPaU
         2Q8y9O0RdrUdL7WC9Uocx6zzzYX40xuGsUs/PgVWwgJruD1zuZxZfhg6VEWuoAUQO0t4
         UT5FReraQtTK18ORSOXCmJwo0xrYKeZ4lPMleXDQkgpBwAuWUxu/9cvscTMRTqAAfY7x
         eg9PFN0P8rMWPMY5E37/EU10rIxafUAnTi7M88JgqafkqE6sX6s0DnxSv4Rzqg1O6AN4
         0D4AMKUv8KvbnwbzQVJVRuQ44JHjYXQLcxz53eJXFnT+Izr0zrjnueoNHXJKzjMfJse7
         6Jzw==
X-Forwarded-Encrypted: i=1; AJvYcCXK8Mtf3cG06jez2UBz3hJK6HVk5d45EJkQ9nt2zI0w8l6NPPDGKFQJRvZjB1VCRK2q4Xluf3d1yp9Ypdg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa+i9wLx0Ji2WmFtFNKXSJco/VLE2ZtbA9jKiayf00udL1tJL6
	S5YMBVmBOl03y61tXSRZRKWsDFBtxlBhdi7A76DcrJcYQHY0ccDFwKRy7O44NMNWRGSaKJrSFSg
	kTKg5/wAWMRVVD+DXWLhYpxIVI+C3fk8WgofJoFi+3Sa+tTVGM+Ko0owli0nG0g2Hobf5E34Ccr
	qSS8tpNAL3ev6uXegzVUiQdAE33UcjZCmefHy5
X-Gm-Gg: ASbGncvfeKkAUlOL5sc5wjnjlC+1ln2RdZoFW8HRw1nrIOEAT2Nr68H+CBWXiq8b5pP
	+iI7b0+vYny5Waephne3sqwpMGEU4xBjmn3+l
X-Received: by 2002:a05:6402:2115:b0:5d3:ce7f:ac05 with SMTP id 4fb4d7f45d1cf-5d41862e26fmr4233957a12.31.1733829001637;
        Tue, 10 Dec 2024 03:10:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEaVJmbf9FsFzQlv76BIkK6pJvh123nB+XTw7CeGSQecbDCarRu6td/3KUmrwW2b7PdOi/34sbWrQxNNyd1r0o=
X-Received: by 2002:a05:6402:2115:b0:5d3:ce7f:ac05 with SMTP id
 4fb4d7f45d1cf-5d41862e26fmr4233925a12.31.1733829001213; Tue, 10 Dec 2024
 03:10:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105072642.898710-1-lulu@redhat.com>
In-Reply-To: <20241105072642.898710-1-lulu@redhat.com>
From: Lei Yang <leiyang@redhat.com>
Date: Tue, 10 Dec 2024 19:09:24 +0800
Message-ID: <CAPpAL=zqL9qmaa=4XW8fu-nMgbh+LkDc1OUCfYOuYv7vVcp7rA@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] vhost: Add support of kthread API
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	sgarzare@redhat.com, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I tested this patch with virtio-net regression tests, everything works fine=
.

Tested-by: Lei Yang <leiyang@redhat.com>

On Tue, Nov 5, 2024 at 3:27=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> In commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads"),
> The vhost now use vhost_task and workers working as a child of the owner =
thread,
> which aligns with containerization principles. However, this change has c=
aused
> confusion for some legacy userspace applications.
> Therefore, we are reintroducing support for the kthread API.
>
> In this patch, we introduce a module_param that allows users to select th=
e
> operating mode. Additionally, a new UAPI is implemented to enable
> userspace applications to set their desired mode
>
> Changelog v2:
>  1. Change the module_param's name to enforce_inherit_owner, and the defa=
ult value is true.
>  2. Change the UAPI's name to VHOST_SET_INHERIT_FROM_OWNER.
>
> Changelog v3:
>  1. Change the module_param's name to inherit_owner_default, and the defa=
ult value is true.
>  2. Add a structure for task function; the worker will select a different=
 mode based on the value inherit_owner.
>  3. device will have their own inherit_owner in struct vhost_dev
>  4. Address other comments
>
> Tested with QEMU.
>
> Cindy Lu (9):
>   vhost: Add a new parameter to allow user select kthread
>   vhost: Add the vhost_worker to support kthread
>   vhost: Add the cgroup related function
>   vhost: Add kthread support in function vhost_worker_create
>   vhost: Add kthread support in function vhost_worker_queue()
>   vhost: Add kthread support in function vhost_worker_destroy()
>   vhost: Add new UAPI to support change to task mode
>   vhost_scsi: Add check for inherit_owner status
>   vhost: Expose the modparam inherit_owner_default
>
>  drivers/vhost/scsi.c       |   5 +
>  drivers/vhost/vhost.c      | 194 ++++++++++++++++++++++++++++++++++---
>  drivers/vhost/vhost.h      |   7 ++
>  include/uapi/linux/vhost.h |   2 +
>  4 files changed, 193 insertions(+), 15 deletions(-)
>
> --
> 2.45.0
>
>


