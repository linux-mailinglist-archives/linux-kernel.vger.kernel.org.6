Return-Path: <linux-kernel+bounces-381271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A98A79AFCCE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 10:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBA651C2145E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 08:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5821D27B1;
	Fri, 25 Oct 2024 08:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TQKFRDA2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1368B1D0E26
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 08:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729845744; cv=none; b=Eo0rE/WIYyu+EX3Q4TOp4hBqAMDux5Pf2yt514LL0OKUyb8xIX4JMf7jdYDL1xp1PJLZwTbk3sjVNN1wz39sdZjG5CZPiiczDgp/19FX0MXxbDLa5hNFLWaJBh8DfIh/C4JoGYNOU6f9DNBzcjVMyL2Mh6w2CszNE8KyJ6DB9dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729845744; c=relaxed/simple;
	bh=fa6jPLAUyoylgiVXw+EMDWO7dRDSrn4n1a/XLj2kxcs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XA2QwAC2fLohqKCi6mQWgAZgWDYgVzrDDyikeYExjWZ6KVvxiXFKV4v8gf6lKapkJGWnsARFrDUcs2FfplvHi0dNyOF+DX5P8A31ORooPC4zYIW5EmMALJvjZc/bvYtz2RxU8A9eTBCquRXic085j7zFm1eBTPLSfn5CqC4mNbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TQKFRDA2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729845742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fa6jPLAUyoylgiVXw+EMDWO7dRDSrn4n1a/XLj2kxcs=;
	b=TQKFRDA2U8HSOKIYP8+GqsID/gG5oUulW6gJvxXTiWjgamHAQwusVc/HalziEvC4rfTFNv
	LTOjIRlQI2AAaxrml7dGS5o/AtQw79656BE1IZMMPmeQdrH+FGFYzcRIyJcIdgT1LDAFEx
	zu1atF0qjV35rNJHKNuZGpF289YrHGc=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-P5CqrZ60OxWqBadERZNimA-1; Fri, 25 Oct 2024 04:42:20 -0400
X-MC-Unique: P5CqrZ60OxWqBadERZNimA-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-71e467c39a4so2036452b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 01:42:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729845739; x=1730450539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fa6jPLAUyoylgiVXw+EMDWO7dRDSrn4n1a/XLj2kxcs=;
        b=m3fcTF1AD98OQd7Cvz9fSjcnFt8SRi3e1flFXVB4AaXElC3DGLoiMzDTECXb2X41hq
         eSpzbc4z+fGAHo08wYwx/91KzAF8ioKOfkppiLtr2eGFF8psy3sV/OGTmfOy6sBbtIqP
         MFlQwNtUA8GAUsECaw/kIxoBzKfJZfXBlO0yxYCqFdryRxKD8tHa7GK9FElb+n8/BZeH
         PlTyLEeZ2C0QqrDdGjiR+byJW2T2RLBIPWQ83JxoEcSRkWEuHKxTLxtg9ns0/vcCvcbR
         MLKl4nkhcsTcR5WZuwsYZfN+BMmJuNakGoLXPQVFXjJ8JUJLVeO/NqCu3dAw+gNsIijP
         3JJg==
X-Forwarded-Encrypted: i=1; AJvYcCU8rxdFu3YdilgraLKkoxkGBlLCciV94wfZnpCNj6lr7DKRJSj5acuAGRwGWT2HninEh7cqsIl82kReMds=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoR1aEulM3DAxrOMV+LC0Se+vJGRbYxR0beYKy0HIL3B+fb0+j
	TV7eHP7CHK6Zl0FZMff4PMW7GbIT1gJBC+FevKR5KDBj4AAbpKTHiqh4H7hPGmkBTNXSdZ88LJk
	/iUSDkck4SwwuF47KIDtGfXusDFgoaCOFzVFfJ7ItdQbv8Y4/HjyRE26gqZOhTmdtx3aVH6PdoT
	hYmVtjURlc28InsEYnLAdOHx3LWsdKb+nmF6F5
X-Received: by 2002:a05:6a00:2d25:b0:71e:6a99:472f with SMTP id d2e1a72fcca58-72030b992eemr10914881b3a.24.1729845739462;
        Fri, 25 Oct 2024 01:42:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyONlkxsszC6bt2HwLRo0KgqsF5/esIacDeqECLFtgNld+V9hMbY+nI2xXS/5AUrgS8dzn+R2BzN6meo0fD9c=
X-Received: by 2002:a05:6a00:2d25:b0:71e:6a99:472f with SMTP id
 d2e1a72fcca58-72030b992eemr10914845b3a.24.1729845738965; Fri, 25 Oct 2024
 01:42:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021134040.975221-1-dtatulea@nvidia.com> <20241021134040.975221-2-dtatulea@nvidia.com>
In-Reply-To: <20241021134040.975221-2-dtatulea@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 25 Oct 2024 16:42:07 +0800
Message-ID: <CACGkMEsmp3q=TQr7qUhdqtAw4ALLXYagn=BKZegks-=CAsF_XQ@mail.gmail.com>
Subject: Re: [PATCH vhost 1/2] vdpa/mlx5: Fix PA offset with unaligned
 starting iotlb map
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, 
	Si-Wei Liu <si-wei.liu@oracle.com>, Eugenio Perez Martin <eperezma@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 9:41=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> From: Si-Wei Liu <si-wei.liu@oracle.com>
>
> When calculating the physical address range based on the iotlb and mr
> [start,end) ranges, the offset of mr->start relative to map->start
> is not taken into account. This leads to some incorrect and duplicate
> mappings.
>
> For the case when mr->start < map->start the code is already correct:
> the range in [mr->start, map->start) was handled by a different
> iteration.
>
> Fixes: 94abbccdf291 ("vdpa/mlx5: Add shared memory registration code")
> Cc: stable@vger.kernel.org
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


