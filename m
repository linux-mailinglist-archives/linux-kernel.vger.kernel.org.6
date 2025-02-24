Return-Path: <linux-kernel+bounces-529425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E30BA42611
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 16:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B9E2168B3D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992C817B50B;
	Mon, 24 Feb 2025 15:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M6cF9bst"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC5E13D52B
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 15:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740410062; cv=none; b=UQr1JrjY7RSqSCj8Vv6ECqc1jtjOP0zRued9JPwtWK84hCvTPDnAUkgdI4rktCjicL5noGIMTgADrkW8aLm5KQJjd3m/FILO8Z8jKggXYyqXmL5Q0PHnaa9QWMBYza1OcGZ61zplhgQRb+YA2m3mQ3aoctFuvgBhA9YxfhCeMQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740410062; c=relaxed/simple;
	bh=60EDANKSZrkagzc6tUmC3fbQGdwCC6BeIMq8eEB8aPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HAbEOB14Ckt4utqTprY1zUMWXrJItCMpSB7saLjnJaFNLoPB8p9Zt7HO16L2IlqxUQAihnLJ2PfT1QsSoTrQxfXM6NJBPDEIQRFBameslFhY8C/PKIKQtEDa3BB3ivpn7e9H9scn8ie51revdqVeY37onQ89XPbH8fuzekfjUik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M6cF9bst; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740410059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C/OIVsN35hJS55OzGv2ukuVUaJw07LiZohQKwUs4joY=;
	b=M6cF9bstJvG6RaMTJRDUu+eO5pRUeVcDiFc7Se9VIpTjFrdW21FvvVXRO9MSDAXNtVsIyk
	vKA16S1eSnPEBFdo6apQtWp6FRqU4kXTtUfZEptJekTyBOY6LrZcSkLd5nC6l+kOdllDKF
	nQ2xG0AAGRH5KQiSWr0LCr+LG1DG5Gs=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-bcBh0MIjMYS56gy6ns9jZA-1; Mon, 24 Feb 2025 10:14:17 -0500
X-MC-Unique: bcBh0MIjMYS56gy6ns9jZA-1
X-Mimecast-MFC-AGG-ID: bcBh0MIjMYS56gy6ns9jZA_1740410057
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5dc0de54194so6411638a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 07:14:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740410056; x=1741014856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C/OIVsN35hJS55OzGv2ukuVUaJw07LiZohQKwUs4joY=;
        b=AgWzPEpFrhOE4fJgF/xjRRucXQrzYXCGsKvI8PnObu+Z/p/mJqqAmNGYnIeQ23y+ei
         yNYjhI+S+s+xYd5Ec8C/JVhFJA8JOUYDRG4GjBUCwRoFTlAoFNuBCAX/9U1mdCG9bOlp
         Sy6qckurzVd50c9szSi6yD8cKEUkh6Iy9Bo8nV778jD+zX2yoVDtsDAOay9zHNFQLRVk
         x188sE77iTplJ6qnd9Y9/hXKeXj5vdNTDUiM1QfCvY+iuMzLZMdNcc+lU2bpE5Cvvq8x
         DrcWpEwugOqeRLAcoVD5rUxnmiLLqg2BvhuK9fZ2zsoO/cYPxVhYOafPmMbhcsjFu3pb
         rgsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPK+JIt5nwlO8K7iVHqZJ2hPBGwBQRmtv0sbDzSzSOb7SSVjs1bqqbnA2s+kguyL2C9EyQonvw9e/AWTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHPiN7Ylh4vOW4omKGzmaVD0bUCIreTjwNlXc0gtdZ+KhY207a
	L4pmP+dXEHrvKpYpVpguIF3MoxJ1VYw5CwotLAtr9gPdDjkeSVlNLL5UBUxOL8uagRpsBwjSzh2
	k5XouTXZWKb5Qve4g4XhUJpYRFzn9+8GsNaxmXj+pL7lBJo1tTq9iYm0aq9g9T59ZWrohvUukF3
	CjwcP8TfZcYR4YyU6RswgKFLsr45fj3jKviAD6
X-Gm-Gg: ASbGncvDOR2Tg0+Ok4ejcK//S7r5x2D8q44mdfA/zsBJK8bZtN/AA69e9ojRqIsXudz
	OOu/s456lBVKlGu08Bjd+Lz/Kmu9NKC2149IlKHece/Z3bOSVkPk8xZisUb/+d1ixoqXq8R2gpA
	==
X-Received: by 2002:a05:6402:42c7:b0:5e0:8840:5032 with SMTP id 4fb4d7f45d1cf-5e0a11ffb02mr17044076a12.3.1740410056598;
        Mon, 24 Feb 2025 07:14:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEZmaNvoGvIZVGGdIwMY93Wp0Yy1Q6TK+nzx9SOVjoSDw+yiizvIm0X3myqUTvD89H31D2GF15UCAEoQ7Xt6T0=
X-Received: by 2002:a05:6402:42c7:b0:5e0:8840:5032 with SMTP id
 4fb4d7f45d1cf-5e0a11ffb02mr17044043a12.3.1740410056200; Mon, 24 Feb 2025
 07:14:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250223154042.556001-1-lulu@redhat.com>
In-Reply-To: <20250223154042.556001-1-lulu@redhat.com>
From: Lei Yang <leiyang@redhat.com>
Date: Mon, 24 Feb 2025 23:13:38 +0800
X-Gm-Features: AWEUYZmPagj9OOZEPQeCs835JiaQmlpElW3pT8viTwfAfpqqaO40WKocPzM1el8
Message-ID: <CAPpAL=wQY3uknaDSiW_AJV4inkC5speMnvO0dGc3+NojK9TXng@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] vhost: Add support of kthread API
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	sgarzare@redhat.com, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I tested this series of patches with virtio-net regression tests,
everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>


On Sun, Feb 23, 2025 at 11:41=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> In commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads"),
> the vhost now uses vhost_task and operates as a child of the
> owner thread. This aligns with containerization principles.
> However, this change has caused confusion for some legacy
> userspace applications. Therefore, we are reintroducing
> support for the kthread API.
>
> In this series, a new UAPI is implemented to allow
> userspace applications to configure their thread mode.
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
> Changelog v4:
>  1. remove the module_param, only keep the UAPI
>  2. remove the structure for task function; change to use the function po=
inter in vhost_worker
>  3. fix the issue in vhost_worker_create and vhost_dev_ioctl
>  4. Address other comments
>
> Changelog v5:
>  1. Change wakeup and stop function pointers in struct vhost_worker to vo=
id.
>  2. merging patches 4, 5, 6 in a single patch
>  3. Fix spelling issues and address other comments.
>
> Changelog v6:
>  1. move the check of VHOST_NEW_WORKER from vhost_scsi to vhost
>  2. Change the ioctl name VHOST_SET_INHERIT_FROM_OWNER to VHOST_FORK_FROM=
_OWNER
>  3. reuse the function __vhost_worker_flush
>  4. use a ops sturct to support worker relates function
>  5. reset the value of inherit_owner in vhost_dev_reset_owner
>
> Tested with QEMU with kthread mode/task mode/kthread+task mode
>
> Cindy Lu (6):
>   vhost: Add a new parameter in vhost_dev to allow user select kthread
>   vhost: Reintroduce vhost_worker to support kthread
>   vhost: Add the cgroup related function
>   vhost: introduce worker ops to support multiple thread models
>   vhost: Add new UAPI to support change to task mode
>   vhost: Add check for inherit_owner status
>
>  drivers/vhost/vhost.c      | 227 +++++++++++++++++++++++++++++++++----
>  drivers/vhost/vhost.h      |  13 +++
>  include/uapi/linux/vhost.h |  18 +++
>  3 files changed, 234 insertions(+), 24 deletions(-)
>
> --
> 2.45.0
>
>


