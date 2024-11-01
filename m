Return-Path: <linux-kernel+bounces-392382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9519B936B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 15:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15118282576
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 14:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A471A7275;
	Fri,  1 Nov 2024 14:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VHfDOuJN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C696F1A0721
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 14:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730471851; cv=none; b=M+CT/n6gC8rxDqYe7Tx3NZKdupYFo35T1dA1bt2M46oDLtLlD7g02xHgxT8RiSUdHaavIQ5wVQocWG8x5+/wKwCvJsymy/CQOLp0a/dsRaQnYTKnFWAkvMp/fJEl7CajzP08L8TichGPbCp99hlkoB51kp+2OttAVb50qxG0U2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730471851; c=relaxed/simple;
	bh=xihCVwmbBEbROkwdBiHwl8sFUTycGVe7moUKh5exmVY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qIPeba7n3wxdlPuJ4d9QE2dvu3KnGwda5BxLirJU7RntO3L8drWF+I5dSbstCZs7kq6s7Ns2YIjACnIHhlK0vIvR/O7vperzd9TEjZOxZ9HQqfz/jO4FDFQ+crf79GVP+wYBG/mGpIG7Z5lRi1wNoGQFyFZF3wa45oEY8W1/3fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VHfDOuJN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730471848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Eq2uqU7pkfVUiFU7SkoeHtKd6J30m6LjXgrS5SpQUqE=;
	b=VHfDOuJNt6msUfU/EClyqlZTnaiL93oYv50CcgYjZAq9GSeVM9lfM9OL5m14PAD40xzqz6
	IQzPbiUsWI2Yyu5e+MRqSvp0GKm5kikp4NiT6e0d91AwsP+TehJ8D4QTJ1nLd4QSicbfYv
	C/NMFz3CjqGpVxBd2Bc7Mv9fpLMwd70=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-ySM2lCnnPe20C3Mx7819qQ-1; Fri, 01 Nov 2024 10:37:22 -0400
X-MC-Unique: ySM2lCnnPe20C3Mx7819qQ-1
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a4dc12d939so3461325ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 07:37:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730471842; x=1731076642;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Eq2uqU7pkfVUiFU7SkoeHtKd6J30m6LjXgrS5SpQUqE=;
        b=ZSVfxTGlOjJ3a2aSOJjGaUCcN95Se2yCMOBSfjgegFYDExYEsavTIic0EqRbrcdtzI
         8hDrr5pvB1WQd4W4jqarhvAxgebs0OqfyTbR0QWnU7HinEiHA0J0nF84u3qQGYvmNbrB
         lTmw3EDt9e8EbsLOVwyAFpBIEkGrcc1mgTULTGixAVy458zxfOtwvd3ecMoJM5IsF2q4
         ixggTOXjL0KsiOQ1OPOuy0Yg+Gmlj8O+YlUFqoh3fcNHt439jl96UCsVCR6vfeNqUPFW
         dWA2M57XhtkZp3qjzGMRWEjeoh2gyA0rGUVGmME8S6W8YEqoVHtoDK6Gea9uKhfB8YQg
         aiXw==
X-Forwarded-Encrypted: i=1; AJvYcCUshZAtQ+c8l3SQom+xgNBgO29xo17JqGYACOGYZ17ml0o1bSkt3LF+Ekt6UQD7OCQ2QaP70c6C09mEYik=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW2af4eFb2XhTaeEZ0AlVNovymTp3jEhiImZOIbz2tp98J2QXK
	MDvUw70u1V82hiitAbtGRl9WI+HK2QuQL4tjoHXrTFP5eG7YqGJ4c4KAkb++IJQyCMbiaTd2TYO
	OjA+2dtsq9r7j9vz5xOEAkz3AZOwtNXos9HSy9PovXrN2hys0chgSIgcL2mdc0w==
X-Received: by 2002:a05:6e02:148a:b0:3a6:b445:dcac with SMTP id e9e14a558f8ab-3a6b445dd73mr4761785ab.2.1730471842021;
        Fri, 01 Nov 2024 07:37:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvn5Vfsqs7qjJ8UOjFRtJ1SimPwyE/4ForKOavSr8aFXtbAKn8m8XJIDuFJ3eIu1sfmTnmTg==
X-Received: by 2002:a05:6e02:148a:b0:3a6:b445:dcac with SMTP id e9e14a558f8ab-3a6b445dd73mr4761755ab.2.1730471841650;
        Fri, 01 Nov 2024 07:37:21 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4de04aca865sm743386173.169.2024.11.01.07.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 07:37:21 -0700 (PDT)
Date: Fri, 1 Nov 2024 08:37:18 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH] kvm/vfio: Constify struct kvm_device_ops
Message-ID: <20241101083718.32f1657a.alex.williamson@redhat.com>
In-Reply-To: <e7361a1bb7defbb0f7056b884e83f8d75ac9fe21.1727517084.git.christophe.jaillet@wanadoo.fr>
References: <e7361a1bb7defbb0f7056b884e83f8d75ac9fe21.1727517084.git.christophe.jaillet@wanadoo.fr>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 28 Sep 2024 11:52:46 +0200
Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> 'struct kvm_device_ops' is not modified in this driver.
> 
> Constifying this structure moves some data to a read-only section, so
> increases overall security, especially when the structure holds some
> function pointers.
> 
> On a x86_64, with allmodconfig:
> Before:
> ======
>    text	   data	    bss	    dec	    hex	filename
>    2605	    169	     16	   2790	    ae6	virt/kvm/vfio.o
> 
> After:
> =====
>    text	   data	    bss	    dec	    hex	filename
>    2685	     89	     16	   2790	    ae6	virt/kvm/vfio.o
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Compile tested only
> ---
>  virt/kvm/vfio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/virt/kvm/vfio.c b/virt/kvm/vfio.c
> index 388ae471d258..e72a6a1d5a20 100644
> --- a/virt/kvm/vfio.c
> +++ b/virt/kvm/vfio.c
> @@ -353,7 +353,7 @@ static void kvm_vfio_release(struct kvm_device *dev)
>  
>  static int kvm_vfio_create(struct kvm_device *dev, u32 type);
>  
> -static struct kvm_device_ops kvm_vfio_ops = {
> +static const struct kvm_device_ops kvm_vfio_ops = {
>  	.name = "kvm-vfio",
>  	.create = kvm_vfio_create,
>  	.release = kvm_vfio_release,

Applied to vfio next branch for v6.13.  Thanks,

Alex


