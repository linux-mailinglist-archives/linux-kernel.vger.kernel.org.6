Return-Path: <linux-kernel+bounces-514587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C29CA358E9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 09:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E13416F16A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 08:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E813D2236F8;
	Fri, 14 Feb 2025 08:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aqHgxKSQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882B2222564
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 08:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739521741; cv=none; b=DvYwHk6mMnOaGCO9Cai3NRx/Ki6fqJjvhwq9aaIZIgCmzKsFntGsuC9+HVog/p5sZwsGju/Gn3Y+CbBLywOhMpg5Z2hYS6WPWs5DAF7qckg/RxqWolmhhIEKM7uRG9CRJpXZASLs0yhQlPf1dZCIL8hxRPjNKjTaLi70VXORBXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739521741; c=relaxed/simple;
	bh=hyQ5NmIfMrko1VRElwCCNAtVPuygcPt45xxVrsnv/ko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jJxcDhBX4rMZdPuAp1A1tVIKD3MAFZjE3mOL1Sd+hIGRfrozyc82tQiCo5rOX6Oe60Hppc1/2BQxjlp7pAc4trbSaFdGQSBdr2iieI82kkUOwU8u3n6eKakvI5gy5Tco/3W9kePHVxOLHqo+07vNxmcLzTkiUqzNCfxgwDG2Uoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aqHgxKSQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739521738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0WVztTJxSqWk8M5Ig8djlDAnjEtV6dMcd76ytcJcnFc=;
	b=aqHgxKSQQz2pBThYkrbYraJ+i9poOl74oBx2sHOjNaZxqEAaFJEhZCkLkUr14h5fn71aaW
	x0b7Ev8d43Ej5oRFoUSg0qEQ6heOK4wsQHNe9Iolm0XSU6959XfAhcZ1h7hboKInOMXkGp
	COe/damNiWhxSHvn7Jo9Qgq2CubEdfo=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-Qkt6vZZ5M0mFyMKtB-Mzjg-1; Fri, 14 Feb 2025 03:28:56 -0500
X-MC-Unique: Qkt6vZZ5M0mFyMKtB-Mzjg-1
X-Mimecast-MFC-AGG-ID: Qkt6vZZ5M0mFyMKtB-Mzjg
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-220ee2e7746so11053445ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 00:28:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739521736; x=1740126536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0WVztTJxSqWk8M5Ig8djlDAnjEtV6dMcd76ytcJcnFc=;
        b=S+HVOvCIkU98cnwp2f1imn8Sksot1n1l+ecYpxfgDsgqTXT2pjWG0GvbSCmUonXd2v
         e4yR/kaDJwyR/gAQYkrh2xu3j4pQQtf2qdPLOcYYIAbhFP0wRsGzMavyuFt/kHxyUSYm
         Ke/FQGGbw06c/aw2gQ8l1voyZ2Ka8P+w6HHfEU1rrp+YfeT1KIDdQBoATiRFPGwOIYNI
         l12OgVyhC9rA90BfP47yGQfDodoPSmRjtJrE9DTNwoSAWB6d6ttxgb5C9ujzrMfww3yk
         4mPDZNOZXHwoZcFHvwJ+6GiaGPIvyKS3XHiJjLkn4q3o50lWVNelhLm370vWivVtiK3j
         2jMg==
X-Forwarded-Encrypted: i=1; AJvYcCUc2HUxY7bBvM3Rpv5oHxFQzUeVno6FX/e1yTR+teKFOGGOwBDudMVrzTCH57QS4gZtbsO80QhIyTqR7mg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvxjv2Y4urbcc3J/9u/7EI8421WS41rU8cN4gMajxuyQpo3hdG
	EK/MPmaymVySwjQ4Qlmg88jGN89KYhDhH3mSvuMDMYXLNXGhT6mKBMs+sQWp6hNi6WumMkc6cqC
	MQqCnDgMvJQqJNBSjw/B7U8MW9Ux+cdLM0fQF7gUmQ5ihyPCgkhnpZJy5+SbzI+0ZOERgPnI44W
	kbBhn3fbRiv1AmZB9t3HCsEZd0kbZHAU0HQkxG
X-Gm-Gg: ASbGncshngA3EaI+rG8aheChAJWY7mzK7uNfqqYiYBTLL3mp0k46z1m3xBsILTnDst9
	Q99yTrXLed3MgVuhVMzWqP6drnZs9k98IELp+YdFc3B8yvGQf2uCH+2S+AeqN
X-Received: by 2002:a17:902:fc8e:b0:220:cddb:590f with SMTP id d9443c01a7336-220cddb5a5emr100603695ad.50.1739521735777;
        Fri, 14 Feb 2025 00:28:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHuBqaubRQaEkDVwIjRrkNmtm9SRsg5dycanztHceooRQ5GB1i/BRbfjGui75fNGjxIdUjFQueIH3/42nMXjoA=
X-Received: by 2002:a17:902:fc8e:b0:220:cddb:590f with SMTP id
 d9443c01a7336-220cddb5a5emr100603455ad.50.1739521735457; Fri, 14 Feb 2025
 00:28:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213161825.139952-1-sgarzare@redhat.com>
In-Reply-To: <20250213161825.139952-1-sgarzare@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 14 Feb 2025 09:28:18 +0100
X-Gm-Features: AWEUYZlR5TQa_mgtH_Q2F6DiI9ahx8UCDTCuZf-LW0E_5NbZxOqPEkv4CzX4XEQ
Message-ID: <CAJaqyWerCoW-yokJnTsnkaCeNFCuemKV+6b+9_7xn6+5H5OHPQ@mail.gmail.com>
Subject: Re: [PATCH] virtio_snd.h: clarify that `controls` depends on VIRTIO_SND_F_CTLS
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: virtualization@lists.linux.dev, 
	Matias Ezequiel Vara Larsen <mvaralar@redhat.com>, linux-sound@vger.kernel.org, 
	Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org, 
	Anton Yakovlev <anton.yakovlev@opensynergy.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 5:18=E2=80=AFPM Stefano Garzarella <sgarzare@redhat=
.com> wrote:
>
> As defined in the specification, the `controls` field in the configuratio=
n
> space is only valid/present if VIRTIO_SND_F_CTLS is negotiated.
>
>   From https://docs.oasis-open.org/virtio/virtio/v1.3/virtio-v1.3.html:
>
>   5.14.4 Device Configuration Layout
>     ...
>     controls
>        (driver-read-only) indicates a total number of all available contr=
ol
>        elements if VIRTIO_SND_F_CTLS has been negotiated.
>
> Let's use the same style used in virtio_blk.h to clarify this and to avoi=
d
> confusion as happened in QEMU (see link).
>
> Link: https://gitlab.com/qemu-project/qemu/-/issues/2805
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  include/uapi/linux/virtio_snd.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/uapi/linux/virtio_snd.h b/include/uapi/linux/virtio_=
snd.h
> index 5f4100c2cf04..a4cfb9f6561a 100644
> --- a/include/uapi/linux/virtio_snd.h
> +++ b/include/uapi/linux/virtio_snd.h
> @@ -25,7 +25,7 @@ struct virtio_snd_config {
>         __le32 streams;
>         /* # of available channel maps */
>         __le32 chmaps;
> -       /* # of available control elements */
> +       /* # of available control elements (if VIRTIO_SND_F_CTLS) */
>         __le32 controls;
>  };
>
> --
> 2.48.1
>


