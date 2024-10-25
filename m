Return-Path: <linux-kernel+bounces-382386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DD29B0D13
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 20:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0282B1C224C7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 18:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601601FB899;
	Fri, 25 Oct 2024 18:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mYcD8bjp"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5E118BC0E
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 18:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729880538; cv=none; b=gDQiLJu7PpZXKuXhowi2VBUGYrUzK4Sio+tRZj6pgD02y1OD4wPDgdD14l1gBipSnuIaFXxvvTripuXUTeXU58kZYekl7I94yfg7WX1WI7cs08KvekF1pkjd+vL3qGLJJ4BRMjaBrAIYuO9F8zZT6KAPICsSbXdCLbFmgisrj7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729880538; c=relaxed/simple;
	bh=DHS5zXjUNPH+dVkf20tdFK6y/eM9x9Zr/Z0mkBsFMdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IEpKbDnqlQ7F9vgEFELYZXAmft1MMYQlvlZcFkQQ/lCtMTleBYB/YjMk6VWxnnTt64y7gCWncyydK3p0TkVacvpzQVap+dfLNQgoYxxw1jYgTafkvtPWEyPdKdwbqeWx34WTV2n0ecN9Ny7kh7qbN1rmjlHNsrgPALocinClYRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mYcD8bjp; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20ca4877690so17575ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 11:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729880536; x=1730485336; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rhT9Vb5Ao1JDCqWhsti2yWZ8ERmFLONpg/V9kcYEdg8=;
        b=mYcD8bjpIVT3gilFS8DFEnVdXbSC0AmV9hB30XAhtihc+F78+EUIA2yTazLgJMpoEF
         JwiTLwcpeTqIMrRl5USx7fbzlhboxqkDsFKga/TyVlPMUcGFPaiBjxe5Mvq8ibLbQb/T
         s7DzF4TAPecUH5+Cm5FeJX6majOc7UMRnausILNWxzfO2Uhxihi7xQL4fGxWxxS2cXBj
         8yR1fVIR44H76CJpZvWaKMomhdKbNAgGg8itAsdc/Ig97+sFhbonyf0ezMBmTGRp/uNv
         b52Cba4TplnyfwrCOmh4i7MbzEfdDkFYSKaCBqgRlULOr7R16hrjXZSxdSTssvrAy+TY
         aTgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729880536; x=1730485336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rhT9Vb5Ao1JDCqWhsti2yWZ8ERmFLONpg/V9kcYEdg8=;
        b=cA3epSP557qigsTbkoCWluNAhheTbYAJy9fjAHqNSWcj1mRShM7m7q1gmXddMsSX1h
         CAlQi5ZBRCNMyw/RzBcF6N3e+UrRVlqV5jq7F7ROegHWq/0OYR5UR+D7nJCxbHQYWCTB
         X6m5EPxZZy3m2zJXHQKcBF3LWJo+7MFO7QVqoT4vG4wZ9MB42fMwqsB7iPW/90qhl6sX
         2WL0UfK2IRzXKpXiTFf9aFvXVk+WQEIb5pjEGm+BEK5W11VstZuEyMP2xvbqINIUgX4w
         at10jhgjcXes2yVx2EsupqkgTQ/wQQl5qptya5pD/qc1gg0I3ZbovfAgn8PZwU4LcuJy
         yXBw==
X-Forwarded-Encrypted: i=1; AJvYcCX15q6gvpWNI9wS0ihFM2suLfCpSUw8xXnpbLQ0jO4z7m/IhIid5eK1pqeR8LSnbZyUuVpAj6oHQxFzwic=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzRo+mk8wy5nRbPJcc/99dc7HjDp0rhsOQnlB3aoQGxJU9VPPN
	NRDVuQpqJvyncEy1okMYnWOzwHjrQOlAJSgsPN8q/GsXTpWLpwbZLqFQ64+h9g==
X-Google-Smtp-Source: AGHT+IGvK99AmFcJnYA/RNYkqX6v8MuFvZAAvR8VA1jOooNPBLTsJ3PVC5ESxe6rr7S9PbqoGaqj9Q==
X-Received: by 2002:a17:902:f9c3:b0:20c:a659:deba with SMTP id d9443c01a7336-210c6470f4bmr227865ad.4.1729880536032;
        Fri, 25 Oct 2024 11:22:16 -0700 (PDT)
Received: from google.com (98.144.168.34.bc.googleusercontent.com. [34.168.144.98])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a3c018sm1366625b3a.189.2024.10.25.11.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 11:22:15 -0700 (PDT)
Date: Fri, 25 Oct 2024 18:22:11 +0000
From: Igor Pylypiv <ipylypiv@google.com>
To: Jack Wang <jinpu.wang@cloud.ionos.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: pm8001: Increase request sg length to support 4MiB
 requests
Message-ID: <Zxvh0xvI4gPOalzL@google.com>
References: <20241024001026.1842458-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024001026.1842458-1-ipylypiv@google.com>

On Thu, Oct 24, 2024 at 12:10:26AM +0000, Igor Pylypiv wrote:
> Increasing the per-request size maximum (max_sectors_kb) to 4096 KiB
> runs into the per-device DMA scatter gather list limit (max_segments)
> for users of the io vector system calls (e.g. readv and writev).
> 
> This change increases the max scatter gather list length to 1024 to
> enable kernel to send 4MiB (1024 * 4KiB page size) requests.
> 
> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> ---
>  drivers/scsi/pm8001/pm8001_defs.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/pm8001/pm8001_defs.h b/drivers/scsi/pm8001/pm8001_defs.h
> index 501b574239e8..f6e6fe3f4cd6 100644
> --- a/drivers/scsi/pm8001/pm8001_defs.h
> +++ b/drivers/scsi/pm8001/pm8001_defs.h
> @@ -92,8 +92,7 @@ enum port_type {
>  #define	PM8001_MAX_MSIX_VEC	 64	/* max msi-x int for spcv/ve */
>  #define	PM8001_RESERVE_SLOT	 8
>  
> -#define	CONFIG_SCSI_PM8001_MAX_DMA_SG	528
> -#define PM8001_MAX_DMA_SG	CONFIG_SCSI_PM8001_MAX_DMA_SG
> +#define PM8001_MAX_DMA_SG	1024

Just realized that I forgot to include setting .max_sectors to 8192
in pm8001_sht. I'll fix that in v2.

Thanks,
Igor

>  
>  enum memory_region_num {
>  	AAP1 = 0x0, /* application acceleration processor */
> -- 
> 2.47.0.105.g07ac214952-goog
> 

