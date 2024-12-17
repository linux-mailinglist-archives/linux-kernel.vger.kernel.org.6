Return-Path: <linux-kernel+bounces-448467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0309F4079
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 03:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05EC5188CE74
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 02:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A964312F375;
	Tue, 17 Dec 2024 02:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WLPS7Df2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B78FF9FE
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 02:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734401968; cv=none; b=VtnWtvUJzCkOCBICCYL6iccwFT8eJhVcPHA6N4iBCOUWDdT3FDZcdosq3qA4Phf/Mv17cD0oCHXSRV/lBRwrmkPCjQY869vmj5n9069bmfjxQn+pA8Yqg+Dz0OItPITr5YQoQitewzmXFA2Zm8yfHIS5oJXwtQTalFrphvDQPkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734401968; c=relaxed/simple;
	bh=EMVRt8Z0FZtdUlMH22a7skR+XExEKWpqSYCuJqQjsK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AWhFjqtgi7d2emkvdB9LYZt3KtBwSg4Su/z56pCfiD2RbCpXVGWlaCN/wbXTPq6BUacqysygIZVPb7N/3OXWgZTnUGvL1jtUZr+kgv4eBQtv00/d+7w+mDojiknOlQelSNSxL7QQCIhLhj6CCAjOaePYUWAG35MUW9DKIqAFgKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WLPS7Df2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734401964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EMVRt8Z0FZtdUlMH22a7skR+XExEKWpqSYCuJqQjsK0=;
	b=WLPS7Df2zpx1AZbx2btsDodu2E4AxpcdGQCdYch8evU1Gd6zxjSeOR0R12cOfZYpZMqsy+
	rYmXln1l5/+nk3ZOmHEY+mMAp3VQ8eFHOK12juRdctKoSsyTwbRE4iOjKkuuq1I5gvNXhf
	TTpDXpXz8xmXOam2Nmxwl4vr3O0SdNI=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-m0toDdB5N2ukI1PvDtN6GA-1; Mon, 16 Dec 2024 21:19:23 -0500
X-MC-Unique: m0toDdB5N2ukI1PvDtN6GA-1
X-Mimecast-MFC-AGG-ID: m0toDdB5N2ukI1PvDtN6GA
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-216387ddda8so40064465ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 18:19:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734401962; x=1735006762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EMVRt8Z0FZtdUlMH22a7skR+XExEKWpqSYCuJqQjsK0=;
        b=XUTwAO+fpPd5FpxQA7Kisdee/EMS8A9qzmLv26/z3cysbkWEOuEIPBFHAx831UY/IJ
         sRwk0wwRrk6Z+eO+NBRkWRposY0szJgFiNWr9GS6A3aGMWMhOLvCs6pohlMznvR81BZh
         jrQI22Zh1UEyoSlKzdLU24rNoknmsAMb9Z+FsDRIfl1qWHF+fnp9InYpnsko+iITIz/O
         kMyxM6G85OyBIuHd39k3nYkMsjQ3PoUme0b2oPZ8WTDEfPOf9dCPuk88AZr3HVLf7N/k
         8zJ0rTSl+71Lwp5YMucgejXPw/ud0k/bWPCxXalzE0x67yUMW3xorIbRz8gywuO1ztwn
         VMvA==
X-Forwarded-Encrypted: i=1; AJvYcCXw4fib6+9rbuOIWfB/muBX4JIy9vVZhl0pL2s+dIver7/780NDw+k6T6IH6MU8xRqp3DJwnsncwwcbhFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOkR62uRTU/3J2NrPM3GqO1r54sVQO4DE0RPU3LbwW+CE+1OQu
	bIAuux0yBl6RTFtJI4mUi1bytLgFJYV9BnsC+FpAmM5VZXXBjIhJFF0TqZ9CDj4+IW0vNv5cefB
	b5jgdAer/Klxgbgc9y9Ax36KJqyu3PlZ5rmFJJ63b65cl5YUrxREd70/AZgEAqr/NoucvGzzw9x
	AT931cYJgDu+TuU6YOyx9I2xOqi2owrqEjfSBN
X-Gm-Gg: ASbGncsaDF7JlVxKZ/keu6J6odcGGu58PU/tRrUmduIIPeNKVphjzZT7STsbzxehSsK
	GlcOESAWLkVzAFvIeMZa1xdVtgH1BmKQrJgee6zQ=
X-Received: by 2002:a17:902:ccc7:b0:216:59d4:40eb with SMTP id d9443c01a7336-21892a847f6mr189534345ad.57.1734401962142;
        Mon, 16 Dec 2024 18:19:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH/MjEzcA522BkO1WbgCEU349rXldXRhDHOSRwH1IThWF1Zf1U4FfgD8Qsk8l40TDb27osULcYHpC+vu/ab3L8=
X-Received: by 2002:a17:902:ccc7:b0:216:59d4:40eb with SMTP id
 d9443c01a7336-21892a847f6mr189533965ad.57.1734401961699; Mon, 16 Dec 2024
 18:19:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241214070835.568818-1-sthotton@marvell.com> <20241214070835.568818-3-sthotton@marvell.com>
In-Reply-To: <20241214070835.568818-3-sthotton@marvell.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 17 Dec 2024 10:19:10 +0800
Message-ID: <CACGkMEuY-6hsxbwgiaVKWTnirAK=3Pxf8FxVx_C9iHxf=kWaJw@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] virtio-pci: define type and header for PCI vendor data
To: Shijith Thotton <sthotton@marvell.com>
Cc: virtualization@lists.linux.dev, mst@redhat.com, dan.carpenter@linaro.org, 
	schalla@marvell.com, vattunuru@marvell.com, ndabilpuram@marvell.com, 
	jerinj@marvell.com, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 14, 2024 at 3:12=E2=80=AFPM Shijith Thotton <sthotton@marvell.c=
om> wrote:
>
> Added macro definition for VIRTIO_PCI_CAP_VENDOR_CFG to identify the PCI
> vendor data type in the virtio_pci_cap structure. Defined a new struct
> virtio_pci_vndr_data for the vendor data capability header as per the
> specification.
>
> Signed-off-by: Shijith Thotton <sthotton@marvell.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


