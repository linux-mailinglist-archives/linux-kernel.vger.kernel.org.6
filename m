Return-Path: <linux-kernel+bounces-417697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74DE59D580C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 03:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 397A7281538
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 02:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B084915AAD9;
	Fri, 22 Nov 2024 02:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UmIcGnHh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB4370824
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 02:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732241095; cv=none; b=lL7iDWy+CLkWM6t0usFs+Ahw0pUjBx6zS1l2yOOKfS0nn6ik6ANIxe/kRhu5Q2El/d4FFkcfCmrjaw3kljp2iCJ3QtmSpHXTy2mcSN3+06K/fUvpPQ3j7+tTpULysJ2XEeweXz1t/9Tgf16LUBoYN1/q+QdMN+bWMGgDcT5yqlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732241095; c=relaxed/simple;
	bh=Z2WdGSZptbI/TwwziVtEgRXhgFZuivmxmo3Efxk+zuE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EjV/CEorH5T1kbj+NxzDRmFwN2nvt9eamKrR9HzSWuQzHnx53CEhjUAHJPGAdfcl2Vxav3sZYVzcbPMVc9SfWCanwJdBsB0cA1BhqJeOB3XepGqNvagHQv1p+V96e0mGMY2MWhdDVCUKXa8rS4lQWh6BQyncbxPIgwJLVRbTYEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UmIcGnHh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732241092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X6u4jknaKda2pPeAj+1LeY7wkXaxwhRiQhTbZjxkGTg=;
	b=UmIcGnHh5TPLFRYECVlYlvkMSPucHAnEcNOTQ5xiOQlHxS8Qe/B2xbLbQ0rpOtI4mZ0B4U
	wIilbBntEUeMj4el0fZ8tI39gQrVPl2NcyXLsxeeFeKleFWcWQspkuW0fwXXahmw1mJeqX
	wqUlm3m/+yhEIe+2WVK6aOTzw9msN08=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-EWCOs7CINHCR8sSNJW4xvg-1; Thu, 21 Nov 2024 21:04:51 -0500
X-MC-Unique: EWCOs7CINHCR8sSNJW4xvg-1
X-Mimecast-MFC-AGG-ID: EWCOs7CINHCR8sSNJW4xvg
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ea45ba6b9aso1872609a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 18:04:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732241090; x=1732845890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X6u4jknaKda2pPeAj+1LeY7wkXaxwhRiQhTbZjxkGTg=;
        b=OunLySeDl69H7XxV2vUdIhmI9TlHQxSgGEd6wuf2J1tinYy7vTIhv+EAouuyIACPFT
         h3DvKP1jz7xxsciP/zQGtVJVV7DRd9RbP07IIJLahXmnrNAEnd3pVKVtKQ2hKTIhyd/W
         +XMyoIpanhi3rx9rzKT1qY6JGyRMaZS2/wWih3HxLROoYduBVmGHLcRP7YZE+O808a6p
         xRlwTbBcwmfQ3s8ATN8z3w+BB+Ma/B5j7aIej1A6TUJssSYZpyRcX8/K3zN8ePbUVmfm
         xw7D0XY4rBhfT5FZl2yKXvCzzqQyONO0Jxk7PNs3o/t5/D4wSwt3thiK3UavD7iQ7jBV
         G9Aw==
X-Forwarded-Encrypted: i=1; AJvYcCX7iVcXu10E52qKr9GVTlYnCTKnLfRADhsvhdKe3s46IC9/pmCEaJmlrhLsJLEa6XQDebcexgu1YI59rTU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7LgWU/R4JxT5rKorqsJkXp5TzH7cuFnzgwWs6baInzD0ZzynZ
	jKKdIIvrvq8CveW+T6WDyXy/AQql1IaUZhCyQI6La4JzVLYaETOSKpy8SNssB/syBF5ON7XTJc0
	R0rNEEx0gEzFh986qoYwspgFRQWCYd5XzSE/0KO6XHUsiJANMqAjUqd7HkVziostnLaj8v6x1rM
	8ozxwYArmSjFziPrxHAiFjTe3JgCSSeFRVFEyT
X-Gm-Gg: ASbGncuJEtZct2R+PbIjNurOmdSQ6vMCwCKvLaK0mPLsxAc32E9m9VDPZZc4EsP0a7p
	vHOFFzPwbgwIxypf7aMfeRyZeUALbmg==
X-Received: by 2002:a17:90b:2f4c:b0:2ea:2a8d:dd2c with SMTP id 98e67ed59e1d1-2eb0e868034mr1095853a91.36.1732241090040;
        Thu, 21 Nov 2024 18:04:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFT5gQZn2OzgKMIi4e1UDo+WMu/JUBQC9thuJdngk1k2cuJOxbkSo/JhdkERIwyiAZqgUiea7i/EaDawnzBta0=
X-Received: by 2002:a17:90b:2f4c:b0:2ea:2a8d:dd2c with SMTP id
 98e67ed59e1d1-2eb0e868034mr1095821a91.36.1732241089581; Thu, 21 Nov 2024
 18:04:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241119074238.38299-1-xieyongji@bytedance.com>
In-Reply-To: <20241119074238.38299-1-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 22 Nov 2024 10:04:37 +0800
Message-ID: <CACGkMEtzSKiMgEzZg3o4nugqqMt9DDXZKZ_LkfrbqpfVDQy4aQ@mail.gmail.com>
Subject: Re: [PATCH] vduse: relicense under GPL-2.0 OR BSD-3-Clause
To: Yongji Xie <xieyongji@bytedance.com>
Cc: maxime.coquelin@redhat.com, hemant.agrawal@nxp.com, mst@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 3:43=E2=80=AFPM Yongji Xie <xieyongji@bytedance.com=
> wrote:
>
> Dual-license the vduse kernel header file to dual
> GPL-2.0 OR BSD-3-Clause license to make it possible
> to ship it with DPDK (under BSD-3-Clause) for older
> distros.
>
> Signed-off-by: Yongji Xie <xieyongji@bytedance.com>
> ---
>  include/uapi/linux/vduse.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
> index 11bd48c72c6c..68a627d04afa 100644
> --- a/include/uapi/linux/vduse.h
> +++ b/include/uapi/linux/vduse.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-=
Clause) */
>  #ifndef _UAPI_VDUSE_H_
>  #define _UAPI_VDUSE_H_
>
> --
> 2.39.3 (Apple Git-146)
>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


