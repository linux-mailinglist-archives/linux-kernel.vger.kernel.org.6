Return-Path: <linux-kernel+bounces-327256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD209772E7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 22:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF6301C23FEE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 20:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC5E1C0DEB;
	Thu, 12 Sep 2024 20:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GqzAI6WT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8301C0DEA
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 20:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726174141; cv=none; b=HnC1nrgsxa0ZR5sLfVlK2bzA/fyGjcs3ESw5/wH4OGJKFZTFG7Z9ry5zipxbRBwEMqpEP2MZ/q8y4WnS21Rq3wQljMpZAwnlUf/uBVqJ18eOINp8Hr3ua31tv6z9pOvbZzzaKkf2Oiu5wJMGUSmzSn6O9pTX2vJ9IGMCmD9Ue94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726174141; c=relaxed/simple;
	bh=yIP6S9iCrMiW5fAQkDzldFnKUGGLDTbn0cgLJErdI/E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DuKa282RjaawajoWqb49ITWp+ZkyXg8MuhQf6+Z+fsWwNKSTkVH20WMJKhYYasO+JARQJuABodRtbgL/6Txcg8cgsTnx6XBvSdzn1pmJ9XwqMJJkyYXkyBQTPPQwJS0D4FKI/+JSFSnLbrVTja6/EOuPREq5h/mPdSsgkbV5uqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GqzAI6WT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726174137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vDpmMjelNalx2jwG4t1xNYLZluds06xeruDv/xAuYKQ=;
	b=GqzAI6WT9OUelHs+BnwoUiyfBmTvEEOJcjxQqrjXcqIIXUlLJmeYGAnk0a2KB4AnezkyXQ
	1mEGm+ILmwM3lAWSobikCzpOIKHxA7jsZk1BuJc8TgRjRE16jzLChXgYjKwfx8S2exsRSP
	EXifLEN3g/AqAhH8tuFX/AZPs5c9knI=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-m_JpYOBzMESqrGYMd0wXTQ-1; Thu, 12 Sep 2024 16:48:56 -0400
X-MC-Unique: m_JpYOBzMESqrGYMd0wXTQ-1
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-82a678fbd0dso30815739f.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 13:48:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726174136; x=1726778936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vDpmMjelNalx2jwG4t1xNYLZluds06xeruDv/xAuYKQ=;
        b=xVcfiLNPA2HOfVw6TiTq0CzJzfp9iNpPOYU6P4DRDJErGU2MNtJZyfPt51dfbQGh65
         QoipgOlq9swArvIU/Y7DRToiSvFWsSukRRwxwrihzOeqc7vtpyoinhVCEb5ApXSM0vRa
         vkLsFQLyWbxRyAbqA0PAPhx27tkBS3J7vt0skMUcLcEdsY631pKeT/t9sksrkZ3p7bvw
         ax6kGcCZXb9uJAkvJcYzWIby2lS4so0peFBYKVr7vjUWCcaR9eZ+tO7o0xysX2mLzRfk
         X+XwdWIsOuK9BBEu97/n3o3BR2m7pN1HNGUh/al9qgmRufver5y96ibKZr5dg0pSA27h
         QS+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWYaldQFHGI/i6z9e+6jfar9om1ZC8AWfmKEiNDN8boSwS3L0F09V7L6VqxzFuXEFYwvX7gGNKqsJXjs/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfCnhhPwDXQVfD4u+8ke1hgPgwPLx8xWYW0JQtzZ19riqOjwhg
	B0l2UhmSWlvo+9khzOohGZkAyfCaoTseaceik53t6NFU8FGEa820fPccuYi7XBSg0MGvZxCz6Ti
	Gwrq/4VRZWi/jGa1q/NeGo2hg+D5JClV1R8yWiizqtV+jHCfRQDKq3dYFsUPOvPl9XNZs/A==
X-Received: by 2002:a05:6e02:17c9:b0:3a0:4bd3:6cd with SMTP id e9e14a558f8ab-3a0847cde94mr11229535ab.0.1726174135794;
        Thu, 12 Sep 2024 13:48:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF27lLlFUrUcBat8oysYWhOtTVjDxFqpMhIx9lYi5bD/C/pP0LIVOh0yQJnIQl2kFEKYKcbRw==
X-Received: by 2002:a05:6e02:17c9:b0:3a0:4bd3:6cd with SMTP id e9e14a558f8ab-3a0847cde94mr11229455ab.0.1726174135458;
        Thu, 12 Sep 2024 13:48:55 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d35f949133sm778323173.164.2024.09.12.13.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 13:48:55 -0700 (PDT)
Date: Thu, 12 Sep 2024 14:48:53 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, Yi
 Liu <yi.l.liu@intel.com>, Christian Brauner <brauner@kernel.org>, Kunwu
 Chan <chentao@kylinos.cn>, Ankit Agrawal <ankita@nvidia.com>,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] vfio/pci: clean up a type in
 vfio_pci_ioctl_pci_hot_reset_groups()
Message-ID: <20240912144853.42ceb733.alex.williamson@redhat.com>
In-Reply-To: <262ada03-d848-4369-9c37-81edeeed2da2@stanley.mountain>
References: <262ada03-d848-4369-9c37-81edeeed2da2@stanley.mountain>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Sep 2024 11:49:10 +0300
Dan Carpenter <dan.carpenter@linaro.org> wrote:

> The "array_count" value comes from the copy_from_user() in
> vfio_pci_ioctl_pci_hot_reset().  If the user passes a value larger than
> INT_MAX then we'll pass a negative value to kcalloc() which triggers an
> allocation failure and a stack trace.
> 
> It's better to make the type unsigned so that if (array_count > count)
> returns -EINVAL instead.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/vfio/pci/vfio_pci_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index 077d4a2629c8..1ab58da9f38a 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -1324,7 +1324,7 @@ static int vfio_pci_ioctl_get_pci_hot_reset_info(
>  
>  static int
>  vfio_pci_ioctl_pci_hot_reset_groups(struct vfio_pci_core_device *vdev,
> -				    int array_count, bool slot,
> +				    u32 array_count, bool slot,
>  				    struct vfio_pci_hot_reset __user *arg)
>  {
>  	int32_t *group_fds;

Applied to vfio next branch for v6.12.  Thanks!

Alex


