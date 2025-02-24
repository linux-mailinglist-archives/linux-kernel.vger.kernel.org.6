Return-Path: <linux-kernel+bounces-530135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3859A42F83
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 22:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09039189C66C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 21:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458691DF994;
	Mon, 24 Feb 2025 21:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JZVlp5nl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A601DE3D9
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 21:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740433892; cv=none; b=fJFC9nFj8uO2v9fc6ZwdEx2SDGibcfYeEa5hLcnrvZNKbfoAB8s+uZKZVqGz353ucKVuzzdeqW/iOTsfmq1zrh9Q8ClgXFYURsCtfIeVSZIKz7HNVAUy9a4zDUxLjUo484SjF8IVp3LyDpep0FPhCZ/C7I/qUTAu7mNEZdMz++Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740433892; c=relaxed/simple;
	bh=zkF5hc0cK80WJWcCdicuqbNp3sujPPZYziecsBeVhl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tpibdeGSKJ4A2iqOjKKb/bgpbZVhyYvKRIhb17QPyjI4vS8ZgdFl0oVa/ICdjvLHcl8bBJwaeM0j7hsfRmUKQJeSOoUFCP4EeInS6CGJI/blFQXixkMx2FP/ONvUizrxq3vbH3n37MNPCkl28Loat9S3oXd+U+NJJBNfvAXCGr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JZVlp5nl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740433890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PYw3iOFdpjI7CWdvocKoz0dXbPHM+ovEK+NkNh9AWKc=;
	b=JZVlp5nl/L3KwPrR31L0KwTI5SVjjsSfCyX5nSlNQRAkh2tjHdjLzeye+MBmwAXFDXdZlt
	qlFdFTXUgZ8y7WOrorBYZyhG7fdDQ9+aQKzBzSHzrGKIQCqRiouYqb4ojGs2JkuwtMdJYS
	7UVa3pghAxcAM0Kc9ahq/fqigWJDvAw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-AY_psf_OPV2wHnGsuKwsAA-1; Mon, 24 Feb 2025 16:51:25 -0500
X-MC-Unique: AY_psf_OPV2wHnGsuKwsAA-1
X-Mimecast-MFC-AGG-ID: AY_psf_OPV2wHnGsuKwsAA_1740433884
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-abec83a498cso79768966b.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 13:51:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740433884; x=1741038684;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PYw3iOFdpjI7CWdvocKoz0dXbPHM+ovEK+NkNh9AWKc=;
        b=XG6GAoInJ8LMVO/Fstjxq5ZSjsRRcBethazV4XntgCKP/9T5arQ7xutHztTUEp56l7
         NVXNe28Jz8090T3hV7tDYm26bsyX1ZNfdxJxaB4C9nMRNqkYRCxdAG7YsmNfDN+x0wzo
         IXiULRTM3xj7h++doLYqZkCy+yAB+lf8r2TgzhnqFluO/Zkv8SusU33GA+NSeHCPKlBU
         EJHdTXVS8x2gV2ubykSXC2EvhU4X2l0Iu1y93dLbFjImv5Z2OKq/7qYgvYBSPwy8423v
         SgbmLHhev8lOYF9DN1MXDpx9G2oklrcNHdRO0NNC43GnwRaujIKjv551FFDkwy4xOi+d
         3OFg==
X-Forwarded-Encrypted: i=1; AJvYcCXVtO5UH0mjj6u3z2Yl0RTEWh8ijN8a87AY5JbaiArzETZANxyYBmGDTtUjVS6YsVC8o1pnvJJ4l/2COfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza/Tb7R1yj1bEl582V8QAcmS4OxcQhdwDQDOQyQs8ceezWNEeR
	QAZFY7Wzyi0aZ9pweC1TUbfHHfZgGlarvXIpC+E7ALOLfXLtXCYGk57lCK4DtWsuSvACYmIoE2u
	VqgwUns/dIn96m5tZLiDuB2MGKsXBcOh/+HqhkTi1mdPYEwiHwqxb1ObcbMQw+A==
X-Gm-Gg: ASbGnctS5MjfdD+jd0uum+TOZw+QYB8pWSp4zCpAXopy9YijYGmPrBR8dI5+1SDJJGG
	gY0R0iDD6bhsEUhggFiKmNE+7a2BjrwvUPVB3edsaes8HRYBSgo9JQ7Gs9HfasfCOLKb2Hw8UZA
	F5qm6Akxph/vEzoZKh2WQmGLSyn50vyvKbWyuwHiRpXYpzMAqe2AZX8f6JP14VcrhVQjmkNIrNh
	X3/JG7UqYdXbUk4SgRxu1U3zzCJqZhL1MimAU7tYs/JhJd9XTCqz338ptxCJfH+qTXtgAbxxoKA
	ipWmosHPEw==
X-Received: by 2002:a17:907:86a3:b0:abe:cecc:727 with SMTP id a640c23a62f3a-abececc0781mr173141766b.53.1740433884499;
        Mon, 24 Feb 2025 13:51:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFtaHW83Wgo/05/4WrDIXvGAbbq8f7q4IYZXTHaNGr0H2AqSCU/tm1tMIVm3RT1FmuY14Wc/A==
X-Received: by 2002:a17:907:86a3:b0:abe:cecc:727 with SMTP id a640c23a62f3a-abececc0781mr173139966b.53.1740433884105;
        Mon, 24 Feb 2025 13:51:24 -0800 (PST)
Received: from redhat.com ([2a0d:6fc7:441:1929:22c5:4595:d9bc:489e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed2053e88sm26766766b.134.2025.02.24.13.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 13:51:23 -0800 (PST)
Date: Mon, 24 Feb 2025 16:51:20 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	Hanna Reitz <hreitz@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jason Wang <jasowang@redhat.com>,
	German Maglione <gmaglione@redhat.com>, stefanha@redhat.com
Subject: Re: [PATCH] vduse: add virtio_fs to allowed dev id
Message-ID: <20250224164956-mutt-send-email-mst@kernel.org>
References: <20250121103346.1030165-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250121103346.1030165-1-eperezma@redhat.com>

On Tue, Jan 21, 2025 at 11:33:46AM +0100, Eugenio Pérez wrote:
> A VDUSE device that implements virtiofs device works fine just by
> adding the device id to the whitelist.
> 
> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>


OK, but the commit log really should say why
you are doing this. And also why is it safe.

> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index 7ae99691efdf..6a9a37351310 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -144,6 +144,7 @@ static struct workqueue_struct *vduse_irq_bound_wq;
>  static u32 allowed_device_id[] = {
>  	VIRTIO_ID_BLOCK,
>  	VIRTIO_ID_NET,
> +	VIRTIO_ID_FS,
>  };
> 
>  static inline struct vduse_dev *vdpa_to_vduse(struct vdpa_device *vdpa)
> --
> 2.48.1


