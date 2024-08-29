Return-Path: <linux-kernel+bounces-307185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD79396499F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 17:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C1C31C22981
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 15:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8F51B140E;
	Thu, 29 Aug 2024 15:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cLFplHRE"
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7822C3D97A
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 15:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724944549; cv=none; b=LXmM1E3YJ/Y5lQr64hekLCdo82rtMGWi0VdtxNek4Ah8ntgOALNjP7W94MamO2b+43p+N4qFaESb3m68ZDBPh+6GDeZkZ95esSVCUCQXk5PgcKvmcEpu08EXJCPU2uNsMmSw3Lxxv8jq8CK9cWtHPK5IlB55s5bYfnc8SY1K9Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724944549; c=relaxed/simple;
	bh=5TmukUoN3OqViIZSgckxwOaFaXhvahwdFF1GZRjk2XQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qd/FystePU2WShFO2JXGui2DytqH0SazVreV7Vcx62lhsW45PXo6j0bL1wrGdnyls//TZ2Kk+abSC+in+sNSVUnU5uKSGHUB2RT+UX/Gn5BmV24d1M3zg7h11ePzMVdIhzn9SHcCQHjmiwfGyj12ZtgjncqROYEK6hwWj3CJWP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cLFplHRE; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-27045e54272so357692fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 08:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724944547; x=1725549347; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FRirlb6wvvKBJEvpGg/PBmMNU4ZDQpov8zWQVHUhVVE=;
        b=cLFplHRELF4tCvLMcLRcXd0O0Laq3DJaegMmtEYw63Spp23gOR22DehlBGBh9GMGn1
         a8kO71d1GpwGhy+HM3+NlCkj+Lw7QvpvwLht2hybsOIcKMvCAfet9hMAhl7oItybXjdZ
         SWvOx+xcDl90meWAThbuJlWsTlb89mjFsR5TunMvfP1gaQyVb7fOuFFjpxmzQh2az7Gd
         0QE6k4aYawWABny2WmIiuA8x1+V4NsFrORoH+F7QZrP9TMnoRSSyR8QKowXQ95lfdrRN
         LNPlv0H0hffuYBiI8oK6gjs+Qf0vINWcvhdjo0g3DX0f9+0IY5548rO7Ok9nXgrG5+vW
         JX0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724944547; x=1725549347;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FRirlb6wvvKBJEvpGg/PBmMNU4ZDQpov8zWQVHUhVVE=;
        b=Mq3upSEVHEISRGLs2VG1zhsYfwybjiomikfju8Jq+k413MRfNWERpmFzr8IdtgErRt
         P8n71ExsBiw9/PzzGEQL6+ea7RksduuWBPhtybIXSbiDf+EEWmCmBGryz/vOSPK53fEw
         WVCmtykcU0iTXBySA38FskoNGV4HHXR0ArQQsfC45iHQxLYtdg5ZiX+V71awFGshWCsl
         UBwlUsyR67l5VK4PecEbf6kYBImhQ44YCnWHm10EFx89Y0nZFwRjO+t4d0C51KF6kfQA
         wPO39E0/fSJ7m3z1YpuVemsKHWhHBjl9BFy8RZpV7nR+GXaaJSJxRjDwdcPuhO6YzqHf
         yLkA==
X-Forwarded-Encrypted: i=1; AJvYcCUYIbCUl4EtlCCsWuFu5zffW0fgbLd4xNDceRjoo5sz5GPN1dXctlWktu9YzvFNgWl6yF77k7eg6H4hBbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ68EGTEUl+ntBM/LHwPz3tJKp8gYjy2ub2Z29NoNKcLVvCOB6
	rKb/dNpU4l9UkmpXeKtXki0vveeujmM3gmbr7VXYXmi9vG6VtR0Z5YgtRcHMbKDOj5z9dkbBHOg
	CghOpIo+V0O8pQNSS9TdXUJ6WSt2h9H0Y
X-Google-Smtp-Source: AGHT+IEmDAAEp6aILEts2ZQokWen4qdf4maZMNl5CZILfDzYorhaJtj0RtTgC+Siv3QhBB5D/pUU+iRfGQYH8lu3gJ4=
X-Received: by 2002:a05:6870:82a6:b0:259:ae64:9234 with SMTP id
 586e51a60fabf-277900be218mr3667675fac.13.1724944547243; Thu, 29 Aug 2024
 08:15:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829143757.85844-1-sgarzare@redhat.com>
In-Reply-To: <20240829143757.85844-1-sgarzare@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 29 Aug 2024 11:15:34 -0400
Message-ID: <CAJSP0QW3WN2Z-x5Y8TnyA_Rq-ok9VgG1YSUzYPDCrav7Phx6Hw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add virtio-vsock driver in the VIRTIO CORE section
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 29 Aug 2024 at 11:01, Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> The virtio-vsock driver is already under VM SOCKETS (AF_VSOCK),
> managed pricipally with the net tree, and VIRTIO AND VHOST
> VSOCK DRIVER. However, changes that only affect the virtio part
> usually go with Michael's tree, so let's also put the driver in
> the VIRTIO CORE section to have its maintainers in CC for changes
> to the virtio-vsock driver.
>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 878dcd23b331..6dcea63f396e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -24218,6 +24218,7 @@ F:      include/linux/vdpa.h
>  F:     include/linux/virtio*.h
>  F:     include/linux/vringh.h
>  F:     include/uapi/linux/virtio_*.h
> +F:     net/vmw_vsock/virtio*
>  F:     tools/virtio/
>  F:     tools/testing/selftests/drivers/net/virtio_net/
>
> --
> 2.46.0
>
>

