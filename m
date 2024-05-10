Return-Path: <linux-kernel+bounces-176265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA04A8C2C7E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 00:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 876271F21D61
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 22:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C37113BAFB;
	Fri, 10 May 2024 22:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X5J5c00q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB6C1BDC8
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 22:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715379273; cv=none; b=jyWJHatd3zvG8kM8d/gZL4qsYNUfI1gVliyw4DiYqQj4yFhKQYoKdjGXw10Oj21JwRQ+G4cOh8gJmqD5z6hLdai1RjAOkeLOLNFo0k0/SQVao0J6YQNnRxZ1dLgVx7HZdGTJvcHdVrCeJmg85dFvJnP0XGii3Hd15ndhQpT5g7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715379273; c=relaxed/simple;
	bh=ROcGEvtftnjYPI08GGYz9bNGpaH/RrDFIcR0zoLFgN0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EsrWlKeDQxh/onRBQ0kFvaym+0lLmr4Xh6DyiUxdWZ2EYYTVi6r3hWmhbkBOWP44g7+zqM+Q5ncj6FT4UKZIvOtngH0pf6UBkl6oMaooK1jKLaNfip86VMzg7VLgmQxwM7HE0GWEXwdYOaU8k4ih3OP1wguxvMOd0azBf8fueqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X5J5c00q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715379270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I/QlJHr+D+VnlQcWOXKBfsNZlT2gXuYn22rJbWjqVyA=;
	b=X5J5c00qDj4fV57XwGYAeM3tbE6P/yjy0AZL/xE+aYeFJNOwR34DII14Qfnswfw2VWHq4H
	y1m6bSA3Vg1iJCa39dmx2A/xIjYNDT5gGknLUk1iVkiIhEJSQOVTJe09xGBspU5QFitvIx
	9sdrPTVV/sssWbVv02C2t3rrMXc/UPs=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-sH2AlZjTPp2NlRup_-AK7A-1; Fri, 10 May 2024 18:14:29 -0400
X-MC-Unique: sH2AlZjTPp2NlRup_-AK7A-1
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7da52a99cbdso237771439f.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 15:14:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715379268; x=1715984068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I/QlJHr+D+VnlQcWOXKBfsNZlT2gXuYn22rJbWjqVyA=;
        b=do8NCNPR4HGqGCNDsjoa/j9DVDMlSMBFw2bHCCiEeMMVYtcoGC4NIP06mH9cl3MoP9
         M971Q85M0hp6N2Oy1c6+emU46+PPAROkWlgrd/ugmpbCrnygPBzSUFv/sNvGhTiwViP+
         LSaINioJG7ZjdqrBAKHT3gmnrZtm56lW5ZRk33/g3ED47xS9V+vFqVOEjbTLTDJDJ9uw
         zXCC5goDBnZ3OWgiMsm3ISlF01/8aEyesKv3wPjWFVgPNFiiwIL/ceWyXOEz+jc+j3+u
         oCfZGAC90ztWEsukPApKJY40gztPiNMd26T2If0RejfDD+l+plisqSqT6rGpeLQ7v1WS
         mQpA==
X-Forwarded-Encrypted: i=1; AJvYcCVKC+IpJpNWe0Y80Nz8Hx4adqgDDgdLmCcVjxNX//co1CvKknL/AgZsbc8jGR5s+iBMj4CtOJpgOW9Dbbo/ZjUgezaQuG1OSNJUrKQN
X-Gm-Message-State: AOJu0Yy/Rju7RzovBvler6j5cjj5W99BMCQwGTWg8Iu1hY98sOlERlkn
	PCChYhfu5+jgRVB72M6LSlbL+hiAsP9U4vnY31jPoPuFJ2DXMURSiSPEjTmuvmpHTYeuU4fEVWj
	uJjkEluYwJVDV83Go/qvYUaLjkniY2kZxQpFTVoeWvbE6gx2fCaFfXLwgUXEx8Q==
X-Received: by 2002:a05:6602:178d:b0:7e1:b4b2:d706 with SMTP id ca18e2360f4ac-7e1b51a3f2fmr446829139f.3.1715379268282;
        Fri, 10 May 2024 15:14:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBFf1hFugwXrr0klEwmRsIlfe4M8Guf0BNT2CGB9vmEx+wes5EAiaXPPMN4KI1D245YbdcEA==
X-Received: by 2002:a05:6602:178d:b0:7e1:b4b2:d706 with SMTP id ca18e2360f4ac-7e1b51a3f2fmr446826939f.3.1715379267902;
        Fri, 10 May 2024 15:14:27 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-7e1b9499ba6sm54162539f.31.2024.05.10.15.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 15:14:27 -0700 (PDT)
Date: Fri, 10 May 2024 16:14:25 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: "foryun.ma" <foryun.ma@jaguarmicro.com>
Cc: corbet@lwn.net, kvm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, angus.chen@jaguarmicro.com
Subject: Re: [PATCH] vfio: remove an extra semicolon
Message-ID: <20240510161425.589eb25d.alex.williamson@redhat.com>
In-Reply-To: <20240510003735.2766-1-foryun.ma@jaguarmicro.com>
References: <20240510003735.2766-1-foryun.ma@jaguarmicro.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 May 2024 14:37:35 +1400
"foryun.ma" <foryun.ma@jaguarmicro.com> wrote:

> remove an extra semicolon from the example code
> 
> Signed-off-by: foryun.ma <foryun.ma@jaguarmicro.com>
> ---
>  Documentation/driver-api/vfio.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/driver-api/vfio.rst b/Documentation/driver-api/vfio.rst
> index 633d11c7fa71..2a21a42c9386 100644
> --- a/Documentation/driver-api/vfio.rst
> +++ b/Documentation/driver-api/vfio.rst
> @@ -364,7 +364,7 @@ IOMMUFD IOAS/HWPT to enable userspace DMA::
>  				    MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
>  	map.iova = 0; /* 1MB starting at 0x0 from device view */
>  	map.length = 1024 * 1024;
> -	map.ioas_id = alloc_data.out_ioas_id;;
> +	map.ioas_id = alloc_data.out_ioas_id;
>  
>  	ioctl(iommufd, IOMMU_IOAS_MAP, &map);
>  

Applied to vfio next branch for v6.10.  Thanks,

Alex


