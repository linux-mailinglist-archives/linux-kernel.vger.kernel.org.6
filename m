Return-Path: <linux-kernel+bounces-301003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D766995EB75
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5339EB24854
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCA813C676;
	Mon, 26 Aug 2024 08:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GmGF9aFj"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D534312D773
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 08:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724659735; cv=none; b=vBRez4pFwTJdIzZ498hw8591Ww3AC6kt6MSLPZTitFlJH+96oN9kzW3yB2kJeLsq7UtJZq6P1vJsRKlp0QebfTtHFUBjpRc73kE+702Zzx8uRrc0sVIC0kRInVxSbMvrrSeeYxT5k5kNAq6RqlbaMPrOQqYYQK4DSATt4KjrTF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724659735; c=relaxed/simple;
	bh=tn40YMUaCAQ/DJXVR3dqBFaS1otGQJ2t9f0pbYl/a40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gn6pzlIKf9xxNatikjuxnaNKNAtiFWvL8BZHaYoRxdTvJMWpkdWRP00feHFMWaZ8xbxTFxLGSC6GJ/BO+utqxKKSgwXc8u6kOW2KZUpyd4OVF+cB1JaBzwWwKS5GCvmaieY6lAt2XP7oUd3pj+hvmbMLkPcEOe97lNQHoDbv+6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GmGF9aFj; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7cf5e179b68so1425586a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 01:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724659732; x=1725264532; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fRo/wbfsDbFv4vokRUxbdhRpSy0+71+5/8aUqsQl01E=;
        b=GmGF9aFj7M1veonCxx7P8sntJ546JXFe8Gd6R/z3vAB6gs2eFyavy5xwowRnqIVon1
         afUGJYWhe9MsZItLTn4CZf8vUhZcN2UuReBtsgOzkYDI6FSUKTJh8uxjZ0/B6a51JIJy
         wkNY2dnjvKuykBmsLXS7RkkxXRyounjSG5DRf8nqGyPYpCtb7uK6EGJi3vA2VQbaFtLh
         3uWu6dTbL84LWHMGb8IjtNNdKlTlGrOVKCzMcE/QJfgxG+heq1Pvunkzt9QTw2ZQVnha
         Jvs8ZzFZgSd3HGkC9LzF2+FTJ0HjQU/WZPZyetDnWYYlVzgVfkzUKm/QAZ3PFq8wJb7c
         kPXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724659732; x=1725264532;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fRo/wbfsDbFv4vokRUxbdhRpSy0+71+5/8aUqsQl01E=;
        b=LzqzSUk9Cg4YDEnlpI7uKe3h2slbuASR+M/fVNdnYZtamQi2Tt2lCwTGWU6Tcuf5ix
         q+/kW71Gd6Jg5UHHTUFUpcDN6C2reFBV69+iyONfnrQmZfhEOCSb7WrLrf6whNph8fAa
         DRBq9XLrP+c+Be/W7nu6rPvAXJabyVj4Ej6lGVQQ5zGOWwxv2fxyDsPlsjV5Ijzwen3V
         ptCTuR51fiStXnGZOFmeyaEFli2srpgWtOzekNGxC4tpBXJUowpX6116b5ds/U41w41F
         74IoxmrIQnDJ1mZPYqsaXAZxymMRo6iAn1hEmMHmAmAvpcC8fJCqJLOqs5UUOiVj92P8
         DV9Q==
X-Forwarded-Encrypted: i=1; AJvYcCW95tV7/ueq1a9f7/xlgV/MPn8m7SD2VkOdV9ZpDllyKo8LWoYx3AvFGKpiyyHrREUcoSpcW4y2mZz8VDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsyLoOWir/RtEWSRCALHez6k1W7YRc3t+QtYhiJoZQvjWhR2aP
	2LN2FFMNRtF3juYqh++GVNXoyEObjUD34TuUaKxcOAfdJWJeaGTg7r39row8UA==
X-Google-Smtp-Source: AGHT+IF2FFGTkmSkhB3/aVaJKTxyAcidVgGCFapnxd1Gkrhhq7h1CAVaWdUOnm3UG/ERQdcmfDBKVA==
X-Received: by 2002:a17:90a:eb11:b0:2d3:ad41:4d7a with SMTP id 98e67ed59e1d1-2d644777e33mr15743472a91.4.1724659732042;
        Mon, 26 Aug 2024 01:08:52 -0700 (PDT)
Received: from thinkpad ([220.158.156.53])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d6136fef1bsm9115774a91.4.2024.08.26.01.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 01:08:51 -0700 (PDT)
Date: Mon, 26 Aug 2024 13:38:48 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Kunwu Chan <kunwu.chan@linux.dev>
Cc: gregkh@linuxfoundation.org, mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: Re: [PATCH] bus: mhi: host: make mhi_bus_type const
Message-ID: <20240826080848.vcj7yjdoovnnpvvd@thinkpad>
References: <20240823031129.49010-1-kunwu.chan@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240823031129.49010-1-kunwu.chan@linux.dev>

On Fri, Aug 23, 2024 at 11:11:28AM +0800, Kunwu Chan wrote:
> From: Kunwu Chan <chentao@kylinos.cn>
> 
> Now that the driver core can properly handle constant struct bus_type,
> move the mhi_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/bus/mhi/host/init.c     | 2 +-
>  drivers/bus/mhi/host/internal.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
> index ce7d2e62c2f1..a9b1f8beee7b 100644
> --- a/drivers/bus/mhi/host/init.c
> +++ b/drivers/bus/mhi/host/init.c
> @@ -1464,7 +1464,7 @@ static int mhi_match(struct device *dev, const struct device_driver *drv)
>  	return 0;
>  };
>  
> -struct bus_type mhi_bus_type = {
> +const struct bus_type mhi_bus_type = {
>  	.name = "mhi",
>  	.dev_name = "mhi",
>  	.match = mhi_match,
> diff --git a/drivers/bus/mhi/host/internal.h b/drivers/bus/mhi/host/internal.h
> index aaad40a07f69..d057e877932e 100644
> --- a/drivers/bus/mhi/host/internal.h
> +++ b/drivers/bus/mhi/host/internal.h
> @@ -9,7 +9,7 @@
>  
>  #include "../common.h"
>  
> -extern struct bus_type mhi_bus_type;
> +extern const struct bus_type mhi_bus_type;
>  
>  /* Host request register */
>  #define MHI_SOC_RESET_REQ_OFFSET			0xb0
> -- 
> 2.41.0
> 

-- 
மணிவண்ணன் சதாசிவம்

