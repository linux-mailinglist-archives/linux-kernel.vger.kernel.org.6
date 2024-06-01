Return-Path: <linux-kernel+bounces-198015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E4B8D7208
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 23:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABF0C1F217B1
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 21:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6878C20B0F;
	Sat,  1 Jun 2024 21:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=philpotter-co-uk.20230601.gappssmtp.com header.i=@philpotter-co-uk.20230601.gappssmtp.com header.b="yOsDUIe1"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEDA1DDD1
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 21:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717279175; cv=none; b=YsnAJ7S/LoUx8f0jJuHTQtL3VWPEldRXCR6WCLZxdEVCBQOFZMgcJPFYr+Rn76y8XCv+IJW/PUZl9FCbPbySZ0eN8e99k2nkIVocJ+vfLs1p5yHdul3xvlVQGqJCveG3PuOelcsEhNMhYVyRRJofcqn9ViF9ykGTfQWW2Cwg3Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717279175; c=relaxed/simple;
	bh=PcYw8B0OwC576QVkyVNdU/zXFIKFiVP1GIPmCPuMW1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zzkrcab6PA7v9rrtNy1ulpw3KovMojR0nJZxnUbP1ULQRB57Fzag0alB6w7WI0UWHMwX2wSYqWHYErotMPkKyaAYHc1NKrUtM9GLo6gbpo4rSrnlRPNoALCx3KTKl2YvL8NW0lNGGEaz+1JUi3IrCmuAlDzSvF87ZHW5UQLF3iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk; spf=pass smtp.mailfrom=philpotter.co.uk; dkim=pass (2048-bit key) header.d=philpotter-co-uk.20230601.gappssmtp.com header.i=@philpotter-co-uk.20230601.gappssmtp.com header.b=yOsDUIe1; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=philpotter.co.uk
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4212f0444efso13189845e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2024 14:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20230601.gappssmtp.com; s=20230601; t=1717279172; x=1717883972; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sTOsbAZo8vNm0CKh7Mt5V21qlJPe4ljx7b2MR8QJYT0=;
        b=yOsDUIe1Iv8XcIMWamR0N2hA3FtND21E3YUmg2Tr4LfFQNcZ2wsaibO7mvmWC8s88p
         UW2z8Z1b9wggwW/mjfiFDhxIqVryoiRYzJef0bfCCA3d8BLNJxXJnvXG2XgThHBU8maB
         +W8OoAGRf2Smk/QetTA/RNr8FzspvVYgHrPKmqS4Qr83Jlz4m7s6dvho4Rmo8D76V7da
         shNiMQdNAo+em3B1mGh8M8LxtFW80LFI/l3taqgnS+JnFrfnd7fdmhrkXfB8e46E7uq6
         cUVCD5UgMrL649kGsbHV7N0VQPyHYgEh8Yj6vxWL61Pk+kEelHQAeVClXTJARozh/I/g
         H0Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717279172; x=1717883972;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sTOsbAZo8vNm0CKh7Mt5V21qlJPe4ljx7b2MR8QJYT0=;
        b=IirDpsMu+V6/Jt8K1xS5HejakcbQEB9OppjCIlES3o9oZNrlYP8t0Xb9RUl9Ox3UUU
         X6YZTF20+IZIcnXqNpRYVwO45S5FaevsdLtvyD+CshnE7bxzTEdQ5XdhmDATFpYHE/Ky
         cJ8adUZVVWDPeZ2muJdQqcH8DDxx2EkwEdMlb4yhaU4YHGk6gaDlQqmLEjIaEGc7HX+7
         6X7BamxNLweBaYgo8tVpqGLoSA3xBb4bxmGZ5i5iy48IvOSSO9JiNJAmygVMLQodzK8x
         rRxsrqxUE8lH1rYt1utymavg8Ek7SzP0eOSo8o8n4s6/0nQtc2w2Z5KMqUYiS62qXRjD
         TPyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKZ777NLTdi0NJSY+FR1LwaFj1vsMOHXO1lBRD9uECFbz5cZ6+HcBLq/nK8rJ/JKKwielztltbDNyLqUUq1ho+s4HMfYrG2v7Dnolk
X-Gm-Message-State: AOJu0YyMk+6LwLrFuIyg3nEF3T+BMq/WfcCSrVf95jBVUgeF0Q+tTXAE
	HJSu40y6KAuSMziG0KdUVRGEoepV/f90sO8B0/BK9xzApUOhbNt9a/97Tq2kpV8=
X-Google-Smtp-Source: AGHT+IEA7wwDn+BdfBi/5KDwizeC8T0MeZncA4PG97jlcNb4dxq2IwYiWK6daHMf25J7vxM6Wc3kCg==
X-Received: by 2002:a5d:4a0b:0:b0:355:3cf:49b1 with SMTP id ffacd0b85a97d-35e0f271884mr3457651f8f.19.1717279172011;
        Sat, 01 Jun 2024 14:59:32 -0700 (PDT)
Received: from KernelVM (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04c9d26sm4750470f8f.25.2024.06.01.14.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 14:59:31 -0700 (PDT)
Date: Sat, 1 Jun 2024 22:59:29 +0100
From: Phillip Potter <phil@philpotter.co.uk>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Phillip Potter <phil@philpotter.co.uk>, Jens Axboe <axboe@kernel.dk>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: Re: [PATCH] cdrom: Add missing MODULE_DESCRIPTION()
Message-ID: <ZluYQbvrJkRlhnJC@KernelVM>
References: <20240530-cdrom-v1-1-51579c5c240a@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530-cdrom-v1-1-51579c5c240a@quicinc.com>

On Thu, May 30, 2024 at 08:23:34PM -0700, Jeff Johnson wrote:
> make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cdrom/cdrom.o
> 
> Add the missing MODULE_DESCRIPTION() macro invocation.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>  drivers/cdrom/cdrom.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
> index 20c90ebb3a3f..b6ee9ae36653 100644
> --- a/drivers/cdrom/cdrom.c
> +++ b/drivers/cdrom/cdrom.c
> @@ -3708,4 +3708,5 @@ static void __exit cdrom_exit(void)
>  
>  module_init(cdrom_init);
>  module_exit(cdrom_exit);
> +MODULE_DESCRIPTION("Uniform CD-ROM driver for Linux");
>  MODULE_LICENSE("GPL");
> 
> ---
> base-commit: 4a4be1ad3a6efea16c56615f31117590fd881358
> change-id: 20240530-cdrom-543cdcf21da4
> 

Hi Jeff,

Thank you for the patch, looks good to me. I will send on for inclusion.

Reviewed-by: Phillip Potter <phil@philpotter.co.uk>

Regards,
Phil

