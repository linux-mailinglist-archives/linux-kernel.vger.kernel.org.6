Return-Path: <linux-kernel+bounces-196743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E96ED8D60F6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 13:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26C311C23DDD
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 11:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E4C1422DC;
	Fri, 31 May 2024 11:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YFH+bIWg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B08E156899
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 11:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717155994; cv=none; b=MFGfqD2IEK4dtbKpCuZp5uzTuXwCVH9W2SZOJNPmixolH0NZ9LkjSWmCd4BdxfeIW0SRCBHANL4CdK70ne6LPFog8Uad1Xze+N04WgRC1jhC3JvakwSh/R6GpeHx/KCt64ABadukkGCqqDQWh0BnfxhBn1KHHnlYZZBs7XXTOLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717155994; c=relaxed/simple;
	bh=cZzInqUviBTYy37ASxA9p9wWZvIhStkg53piCJBUU3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Emu9lm4WKSFzzDVOb/5k5xYIyXz5k1yX1ld1Iu53cfutkPUic2rqy4gHSiOg0rEzvDeVC6sVvHQdlaVwx4V9ae3kmxLOAIprtl0fNRs18i3t7QCRCBevvGmywmPMEtY+EGpFsUV9VmNkMn1drlIlGli0i/5d0/70YTqayUnPqHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YFH+bIWg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717155992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gr8k/Vm02ygPW32aJTJ9dTPWwg2hxQoQtvUykdUgDb4=;
	b=YFH+bIWgrlK3omp36Gogj48UX9ZLf0dcnOEwDx1CQjylWB1NK9rE72GYI2y2/Qu4ppeZcL
	0//qhJCjfEw8oWH4ZsX70gppPtm/YKGnEqT+1ruV6850ySZbz1K9kOJK/3xemTWtRZZwrC
	tmzjSzZSFbZNwPCiDQ0BRM1YU/PJ0j0=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-efbNjY1EOIu20L5-i0uA8g-1; Fri, 31 May 2024 07:46:30 -0400
X-MC-Unique: efbNjY1EOIu20L5-i0uA8g-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2c1977f75d2so1635783a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 04:46:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717155989; x=1717760789;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gr8k/Vm02ygPW32aJTJ9dTPWwg2hxQoQtvUykdUgDb4=;
        b=i9eWbp7e+vcxCALAeGllk+poMixlLnv9byfZxgt2rtt3CIOdOvcchugnlPcuyvO4q6
         EFOFeqQYQk24luiNB8RLs3D/m1jtF40r1BVeStR6TSZy3steTymg+lBQJVLFv4uoWncl
         s+iieusmOnajBOZHmEAw+sdgcoVO8J7tv4ZEzrBgGB8tOjgSgxMc1L5/oSCE/4BlXshl
         37+K5N14nVyZvZpKMH84fl++ye2gC3p+WfwuRRN5xkbgfb0dBLL4kqNrldsP3DNY/6a5
         wo5xiauaaNxZ4Xax9ahhu+JSjt9YCk8o3eU0AcW8KqOj3eKID4LfuZDETqOSMOblqWfS
         4OCw==
X-Forwarded-Encrypted: i=1; AJvYcCXV9jc/jiS4rA2yV8ri4aO+hIQQ+x8vDLlu6MS+u8vQz4HNZRHZEIvEAvf6D84CH2tfKEWVBTujYNf7BHw+wTH8pHAb+jaDaeMOdWnf
X-Gm-Message-State: AOJu0YwOYF6rhgLe4RCU296n4dzFpCrpTINMN8dGnzvN/QXmELx70WNB
	TPS2AZ35CNk+IYhTWzE6lG2DcRV3wa9JO9wDSNEfVQbStQrxd57eP23iuSxcN3q3YHXtH1fii+r
	oUQr6Hil0R8Ii36rQIRfRMWH57uGG6Zc535//3QNYTZWXvWx8ZEmFKFcUypH5Mqd03b3tF2xadM
	dZ63QCob1QKT4ZFG4KBER126Yphi9uc9zk5p9x
X-Received: by 2002:a17:90a:aa94:b0:2bd:f049:932a with SMTP id 98e67ed59e1d1-2c1dc5c8832mr1704313a91.34.1717155989418;
        Fri, 31 May 2024 04:46:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTq1sroVC/zyco89stsGzLWmiBt5HeZSFTphj0DZrCDCYOHtXNSLNxvKpXEsf8gGnY0WWV2gmiczJH02FvAx4=
X-Received: by 2002:a17:90a:aa94:b0:2bd:f049:932a with SMTP id
 98e67ed59e1d1-2c1dc5c8832mr1704291a91.34.1717155988960; Fri, 31 May 2024
 04:46:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530-md-nvme-apple-v1-1-b8b7ca569660@quicinc.com>
In-Reply-To: <20240530-md-nvme-apple-v1-1-b8b7ca569660@quicinc.com>
From: Eric Curtin <ecurtin@redhat.com>
Date: Fri, 31 May 2024 12:45:53 +0100
Message-ID: <CAOgh=Fwfab2W=6QzhuBfm4fazXMnNLudSQpWw3rmX5ZcSo36yA@mail.gmail.com>
Subject: Re: [PATCH] nvme-apple: add missing MODULE_DESCRIPTION()
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 31 May 2024 at 06:25, Jeff Johnson <quic_jjohnson@quicinc.com> wrote:
>
> make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvme/host/nvme-apple.o
>
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
>
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Reviewed-by: Eric Curtin <ecurtin@redhat.com>

Is mise le meas/Regards,

Eric Curtin

> ---
>  drivers/nvme/host/apple.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
> index dd6ec0865141..0cfa39361d3b 100644
> --- a/drivers/nvme/host/apple.c
> +++ b/drivers/nvme/host/apple.c
> @@ -1602,4 +1602,5 @@ static struct platform_driver apple_nvme_driver = {
>  module_platform_driver(apple_nvme_driver);
>
>  MODULE_AUTHOR("Sven Peter <sven@svenpeter.dev>");
> +MODULE_DESCRIPTION("Apple ANS NVM Express device driver");
>  MODULE_LICENSE("GPL");
>
> ---
> base-commit: 4a4be1ad3a6efea16c56615f31117590fd881358
> change-id: 20240530-md-nvme-apple-e0edb9b98c45
>
>


