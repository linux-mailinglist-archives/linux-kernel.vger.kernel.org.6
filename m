Return-Path: <linux-kernel+bounces-221466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8716690F412
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 18:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACD911C20E55
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 16:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72A1153812;
	Wed, 19 Jun 2024 16:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Yo7W9KHX"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5ED1514D0
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 16:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718814791; cv=none; b=AgXjBC30+k2GKeE526OzZ37Qkg3+SLApZT/b5h5bZe6C21CVlWqlEVR8/nxF69LIOkA6MHqBN6sswpuNx0IsFJmloTUvFnRKHWEP0o32GfdxZL3LiD2YI+5MCI1tI2KYDG50/q9Os1YjzZlHGQD935gNVuiiAFjPycmiKDpByWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718814791; c=relaxed/simple;
	bh=FVFYCJ1EGfwnkU654yIVzNaWy+IFuApDG9DYERxXLt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dCzDgLS2uzcf0iZ7I87xvtAZEzc9Rc9EK4CwRTBE06kdnEW+LQ/0vKzS8qEmlCC3lEnu2Vj+h2HOa9Jw4pFLcGergoGLF0B9nk3JesL5aeiirfcUTE2ZejbZ7ckWbXcGpOdYm9Yg5416GhbHKMRoIMRvkp45djUE2t1Yq8GUbyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Yo7W9KHX; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4403bb543a4so35700731cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 09:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718814789; x=1719419589; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UxqMh14wh6rgt2Gb04HuzckvnrRRbYR5Yps3CaoDEDg=;
        b=Yo7W9KHXCsjDk594noZE6DPWa68JqoR3ltK8oYZqYjbiw7nbO+F7ywwvgJKYDmJfNM
         NFvVTm6aVXfypvEo/CAUlsbK9DwnRL69jNbNkwBZlroWJPW3xK2Pw5iGnvudi8/9ay73
         1E8YAYpsqDvjFsWGDgg/Jc4TUSVdrQ1cOfMRJ/+3ySsqkXeTfi6p9frFfLfOD9I6RF6O
         YXz59W+K07hVN9Exbh7Nf4SngTqZ6C7bEK+9FsiyWQn0+52CaNNeZNn3S/YijShLHbcF
         rigOIsZbZjsl3MCEWEmynsrxOrFpyeoD82XunmYcppiYuRcdLrfKAcNJIfQAsv2mCp1c
         mIEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718814789; x=1719419589;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UxqMh14wh6rgt2Gb04HuzckvnrRRbYR5Yps3CaoDEDg=;
        b=ToCKjPRC/Sk5Zf8WAxDvQCv6cVT8U2V6qV194caJpi0vrLokYmufByxwXz2b5fHA5E
         POvCIqssp9P+UqSyiko4+Nrgwj+tDN+3ZtfRY5qEHA1Zkt+wx2P7BfD58OW6c/OSmagd
         0UkOcI2eXqQRsOWLOeAO82+OUMnxz4th5DlczqsVtdHemfUFsrU5cJeJOBNwXT1n0Oqg
         MG5MPLeF7LSzbPeoT39Tdhw3Vw8r2E/xTct35lTveiXBQIst/aHyPxdCbnJtjFG9CS36
         F7SO8cMRLn4LkLHSwo8s93/ma/3d+2W099VzOJEMvNRRpfFYJ7F8xv6NW43aFHmPXrcz
         qNXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhUicA8NsuydCJelXdKb5s3SY/nkfMtRlEXmyK3DNfqJW7P/DvC2YOPAudVgz5aj9d0GwzElxWqtokfoC8q+CaDPKV46q0jVcXJg2Z
X-Gm-Message-State: AOJu0YyInz5wtMC6sX96H9XWbK9qplZnzA1kexfHqsKvzA3dd3oV8LJZ
	UUwxnejbdjmn+Gbar/7Z7gYp3j2C38IbO/cOJT7csRlbacofG6F0NogIp/3hYD8=
X-Google-Smtp-Source: AGHT+IEi+7foZgh/9Z0anYpjxAAXArw1uJUHOfsFSQr7PUdyfMayYNr0/bYNAmiUhoW9f3jLzo/I0A==
X-Received: by 2002:ad4:55e3:0:b0:6b2:1094:83bf with SMTP id 6a1803df08f44-6b501df81a9mr31902396d6.4.1718814788824;
        Wed, 19 Jun 2024 09:33:08 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5eb4cf9sm78898276d6.97.2024.06.19.09.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 09:33:07 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sJyF9-005AMj-BB;
	Wed, 19 Jun 2024 13:33:07 -0300
Date: Wed, 19 Jun 2024 13:33:07 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Rob Clark <robdclark@gmail.com>, Will Deacon <will@kernel.org>,
	linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
	Rob Clark <robdclark@chromium.org>, Joerg Roedel <joro@8bytes.org>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Joao Martins <joao.m.martins@oracle.com>,
	"moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>,
	"open list:IOMMU SUBSYSTEM" <iommu@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v4 1/2] iommu/io-pgtable-arm: Add way to debug pgtable
 walk
Message-ID: <20240619163307.GL791043@ziepe.ca>
References: <20240523175227.117984-1-robdclark@gmail.com>
 <20240523175227.117984-2-robdclark@gmail.com>
 <85f5250f-0d50-4aa3-93c9-2008c6ccb8fb@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85f5250f-0d50-4aa3-93c9-2008c6ccb8fb@arm.com>

On Mon, Jun 17, 2024 at 04:13:41PM +0100, Robin Murphy wrote:
> On 23/05/2024 6:52 pm, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> > 
> > Add an io-pgtable method to walk the pgtable returning the raw PTEs that
> > would be traversed for a given iova access.
> 
> Have to say I'm a little torn here - with my iommu-dma hat on I'm not super
> enthusiastic about adding any more overhead to iova_to_phys, but in terms of
> maintaining io-pgtable I do like the overall shape of the implementation...

If you mark arm_lpae_pgtable_walk() and the callbacks as
__always_inline then the compiler should generate the same code as
today for arm_lpae_iova_to_phys().

Jason

