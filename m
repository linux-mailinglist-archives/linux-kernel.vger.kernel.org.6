Return-Path: <linux-kernel+bounces-444245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 127319F034C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 04:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD948283FEA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 03:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B3816A395;
	Fri, 13 Dec 2024 03:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f4haocp3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E74015F41F
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 03:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734062165; cv=none; b=BS1nvbUXHiSaFcCexsyvYUtXzCAXShPfaWU+3h68sYgKjG9YYWHFbfvYFwkDTnhLOC7bKzCsAhCwpxcHdSyEyKIIjuAiBV75fsV0KdGQ5JS0xdEj6VGzL9Y19zbfXMhktdYR9bpWqmqiLM60zQJND6Snej0oZ8PQj+rtrE8sD6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734062165; c=relaxed/simple;
	bh=U4lhy29Z8mWIZhXRxJyY/aLJFxrOaq/vlhjoFQPjVqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hxG/yborC6yU5JtX9Mw0ZZBH/6gOY6H4QyMBcjHXbo9FwlQnu5Uz/eK4QkVl0C1kKRyjFAATGa4jz3BFqvvJ7RuznZb+nJniFn3ta7YZ6WpMJNvLHU6VJDG+91yZppXRFc8oH3ykvBZm9JGrCgcAu9Wbw4ROF06E0BUVw7yCB1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f4haocp3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734062161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hohhC+HKp9CnfbKmvLDDIi1grr9DkV90ygzzybVd/UU=;
	b=f4haocp3NgyZh/hl/CDs3Q4GTebA4b9BgYwGUrsZdx4v3phLABkWvwDX0CM6PgeV7V0YlC
	Lf8t8Gx+us2zhqqh4MMXIjdWvEtqy4z1lDJYdHRsCTNU+KzUJuEdpstyqh1aCKefDGSq4X
	lSRo1aNKLntYlbpMRj+LhQ5yjPnTgMM=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-GP1bZrFBMg-iy5ynQaJeEQ-1; Thu, 12 Dec 2024 22:55:59 -0500
X-MC-Unique: GP1bZrFBMg-iy5ynQaJeEQ-1
X-Mimecast-MFC-AGG-ID: GP1bZrFBMg-iy5ynQaJeEQ
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ef9b9981f1so1876605a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 19:55:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734062159; x=1734666959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hohhC+HKp9CnfbKmvLDDIi1grr9DkV90ygzzybVd/UU=;
        b=M53W6/1knSDrlU1M+0SBT6E+4u4ychojavvospjF/RHYlEEsySFYSwlHQ1VL4o5Iwq
         iF5Bt7pufD9RtM4Rudtn0yLFPqxDUBFDwYbg3vhr0VoZEYvJZyOs9eAE+reG/v2j0G13
         JUtffM402E1pv4DvhM34/uH9C7/NgddilakS75XtnyTdVhFmyW5Ul5JhBaCvNTe/2PZ+
         EiU32FFaQgy11sILLMapXrA4DsEBvv/nblLapTRkSQFLlA0slh+mV0DqQT2L3R/AnOJ3
         w4cS/Ytp55Ar62xAmcKXCD5IRqNwCNyPLVbBh+gh6PIbL9o4o8eMd7s5Ilc8xwER/Xzs
         3XJw==
X-Forwarded-Encrypted: i=1; AJvYcCUeNj1T3N4GUv5Bx1seOi36A/3OKI2A65N3iJWR97MRmGw5uEislldEoI0s8LIK4yP18yPsdwx1G5YV4sI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL3tlCLiedE25mH8Lkrvdc4An4/CGELtBBWV1hCASM0GcTERgl
	MVRxUPK1/DNcMk4fVoPXqiH+wNLzET2crrZIVfVWIdefriR3lCi18F4WAtcmOcrbkhso3KURGFg
	UkCWeI+n7WPIUh+MsnhmLCrTo0mLdiNCdfk1lZmacON9J1byN6O8zeDsyRq6crTuLfKaAHh04/z
	3HISk7v/yIOgg/YwGbD8N4VNa34xMrjBUE7Tzt
X-Gm-Gg: ASbGncs4IH1zJV13KZVtsCLnPZBOXmRePuYrz1g8lHEpTdFfWLvvzo1053ncnTwfKum
	lOcvJ802HM7Nt+VPKleEJWnVKC2UApHNNMJdmh0M=
X-Received: by 2002:a17:90b:53c6:b0:2ee:4982:e59f with SMTP id 98e67ed59e1d1-2f28fd733f2mr2137656a91.17.1734062158957;
        Thu, 12 Dec 2024 19:55:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEafW2iox6ODPxu6qNDR+J2ks4Wa7nnNcsBTsO7vNPjs+72V/eu9MzyQy/i6saU+9tuWkzkyrbFKZ5asDGbRf8=
X-Received: by 2002:a17:90b:53c6:b0:2ee:4982:e59f with SMTP id
 98e67ed59e1d1-2f28fd733f2mr2137631a91.17.1734062158559; Thu, 12 Dec 2024
 19:55:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209151427.3720026-1-sthotton@marvell.com> <20241209151427.3720026-3-sthotton@marvell.com>
In-Reply-To: <20241209151427.3720026-3-sthotton@marvell.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 13 Dec 2024 11:55:47 +0800
Message-ID: <CACGkMEsmU4LjUzKFfyoY1ao8pRCETHRqPM3X8uK9KO-TCN8Trg@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] virtio-pci: define type and header for PCI vendor data
To: Shijith Thotton <sthotton@marvell.com>
Cc: virtualization@lists.linux.dev, mst@redhat.com, dan.carpenter@linaro.org, 
	schalla@marvell.com, vattunuru@marvell.com, ndabilpuram@marvell.com, 
	jerinj@marvell.com, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 11:16=E2=80=AFPM Shijith Thotton <sthotton@marvell.c=
om> wrote:
>
> Added macro definition for VIRTIO_PCI_CAP_VENDOR_CFG to identify the PCI
> vendor data type in the virtio_pci_cap structure. Defined a new struct
> virtio_pci_vndr_data for the vendor data capability header as per the
> specification.
>
> Signed-off-by: Shijith Thotton <sthotton@marvell.com>
> ---
>  include/uapi/linux/virtio_pci.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_=
pci.h
> index a8208492e822..1f3ea5d2a6af 100644
> --- a/include/uapi/linux/virtio_pci.h
> +++ b/include/uapi/linux/virtio_pci.h
> @@ -115,6 +115,8 @@
>  #define VIRTIO_PCI_CAP_PCI_CFG         5
>  /* Additional shared memory capability */
>  #define VIRTIO_PCI_CAP_SHARED_MEMORY_CFG 8
> +/* PCI vendor data configuration */
> +#define VIRTIO_PCI_CAP_VENDOR_CFG      9
>
>  /* This is the PCI capability header: */
>  struct virtio_pci_cap {
> @@ -129,6 +131,15 @@ struct virtio_pci_cap {
>         __le32 length;          /* Length of the structure, in bytes. */
>  };
>
> +/* This is the PCI vendor data capability header: */
> +struct virtio_pci_vndr_data {
> +       __u8 cap_vndr;          /* Generic PCI field: PCI_CAP_ID_VNDR */
> +       __u8 cap_next;          /* Generic PCI field: next ptr. */
> +       __u8 cap_len;           /* Generic PCI field: capability length *=
/
> +       __u8 cfg_type;          /* Identifies the structure. */
> +       __u16 vendor_id;        /* Identifies the vendor-specific format.=
 */
> +};

Nit: I would have the following comments from the virtio spec:

"""
 /* For Vendor Definition */
  /* Pads structure to a multiple of 4 bytes */
  /* Reads must not have side effects */
"""

Thanks

> +
>  struct virtio_pci_cap64 {
>         struct virtio_pci_cap cap;
>         __le32 offset_hi;             /* Most sig 32 bits of offset */
> --
> 2.25.1
>


