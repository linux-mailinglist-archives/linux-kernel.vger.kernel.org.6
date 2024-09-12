Return-Path: <linux-kernel+bounces-326805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CA8976D29
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 17:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C9F61C23CEE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 15:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D2D1BC9F7;
	Thu, 12 Sep 2024 15:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KoSUqc68"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168C41B14E9
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 15:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726153782; cv=none; b=uSGMb7YqnbYgh6dpm9f2QqadZSSctqPQ8x/bCQ7uWE14nuQUIbOtSV+iyknNlrOrGx/lAIgOrmjSHqLG/3pIX8mXYl0AG79yUNacGJO7fWR8sHeogcKXU6FXszlqgyW5nbfVtNvudBVnuklnBtkyrmlTaojSJn2Ef0vPTUIiKMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726153782; c=relaxed/simple;
	bh=jpnq6+i4OOoUnH1u60SSe0DzWX0QpN9JkqbO2mQBiM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bZgmjtuWoTf7J1/Un9vM9jQQ/iaWfueS/9u9RLTOX292sBGEVWBP5BiNM7qBL7JFwD4oxmbVBxcMbSZyxsh3CzQO+lVR2lPwLBweieq0W5maEfll7A477+HpaHSflmU0wmWFQaOwug8/Ha9WFHUS+pANJOJlFn2P+3AdcSpSqHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KoSUqc68; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a8d6d0fe021so168760466b.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 08:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726153779; x=1726758579; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m2FTFSt65RpqX2pKE+PYQ5IJqaSrd1Ivf+eZBs0Jl3Q=;
        b=KoSUqc68mSC2aAsEu81RWPQ+d9773BLDKq2iE31vHR6BP/rW/b8M8UaXo7idtKerLI
         l1OZmd3uuJmBV2MWq9w/mtNxgDwgeHssoP3xN4pBHonnNp9tfjfxwTtujZF3ltQJPtTd
         3tWSE1nZ9QtDelNplbY6Lf6Ii+y0KEtGS1q7FrTwJGoTZVio8GlogW9Cju8lYwI2gil8
         47o2VQN2J3m+CrxQjZe+cVF1LrJo3sOuJWoTEkOfqT5TYAKfVxq5xkwWgQnk7B7+PeRS
         Nw05ohml/cglWft61V5FGxC5II6Rb4DyDopKHJpnMY889k3c4gN6XXuNnOWFttTrr7Z8
         1RiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726153779; x=1726758579;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m2FTFSt65RpqX2pKE+PYQ5IJqaSrd1Ivf+eZBs0Jl3Q=;
        b=X/AQOhIqI2EBz6Nfaf6AsRT1StAGnazBww9KGuw9nx1liCk10+2RuDoE4a8kbEQrCs
         jBY6OCa3YiiwvOjr18Bbe7agHAYtoKGoOHbe2dPpTPIvCYlvT/+EPHYB84koz8uH3FKo
         IO/Z4iXLdA74bHCPXDqPIHDJfO+cuuwAehYgq8YI0H+sugVrv//QyZ3ci5SVkHA0A/xf
         TqEuK1NvmYL6MRoGIaHF2q+tcrNtAqXxZbTqbPzIhgrtHYzzd6virc/E+YbCYNQhzCqB
         4VCtCcS6uEhPbM1iGNbiUMbjEN06tLE1njW7dqjRIopbsy/C8VnYV33rDH/vcudy8lXZ
         TnqA==
X-Forwarded-Encrypted: i=1; AJvYcCXJhO82odC2qWhMikUYNxRweQS5traxlyN+wVKmjO6eaKQ4fSH4VvPn7SsdF8Dx5XyxDZZQABTxNBeVF4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrZhGiNA8CqA7a8CdQkQu3kCZaY4+o3qYjm4oIMDFmRlZl+BL6
	iY0eVF7Z7h2afT6c40Vi/6PlI6Dmd9/vocX5vRJTiMJwIrKGwJumQK28y5hJg9c=
X-Google-Smtp-Source: AGHT+IFx8uklWz3IvdJl75Nws6S3qWWNNUNkE8Qf8xQTCLyZLWokkWUxAMVluycglpcbiI+lT958kQ==
X-Received: by 2002:a17:907:c7d4:b0:a8d:60e2:3972 with SMTP id a640c23a62f3a-a902943a562mr313368466b.23.1726153779212;
        Thu, 12 Sep 2024 08:09:39 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25d74e26sm763631266b.225.2024.09.12.08.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 08:09:38 -0700 (PDT)
Date: Thu, 12 Sep 2024 18:09:35 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: b1n@b1n.io
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vt6655: Rename variable apTD0Rings
Message-ID: <9d12ad46-d028-4be7-b8e3-2167e214ae66@stanley.mountain>
References: <20240912145234.75499-1-b1n@b1n.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912145234.75499-1-b1n@b1n.io>

On Thu, Sep 12, 2024 at 10:52:34PM +0800, b1n@b1n.io wrote:
> diff --git a/drivers/staging/vt6655/device.h b/drivers/staging/vt6655/device.h
> index 32d9cbd55222..32c51d794264 100644
> --- a/drivers/staging/vt6655/device.h
> +++ b/drivers/staging/vt6655/device.h
> @@ -135,7 +135,7 @@ struct vnt_private {
>  	struct vnt_tx_desc *apCurrTD[TYPE_MAXTD];
                                  ^^

>  	struct vnt_tx_desc *tail_td[TYPE_MAXTD];
>  
> -	struct vnt_tx_desc *apTD0Rings;
> +	struct vnt_tx_desc *ap_td0_rings;
>  	struct vnt_tx_desc *apTD1Rings;
                              ^^^
It's weird to have ap_td0_rings and apTD1Rings.  They no longer match.

regards,
dan carpenter


