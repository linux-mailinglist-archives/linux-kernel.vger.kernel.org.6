Return-Path: <linux-kernel+bounces-238030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCCE924260
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 17:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 574FD287C00
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 15:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8125D1BBBD5;
	Tue,  2 Jul 2024 15:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C41hIJxh"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4F91BB6B0
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 15:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719934160; cv=none; b=BSOWKIC+r8hVAnj/c10iEfrFmb42vPci1SyAcu8fYwfZRPi08oJ3xEVW3aUiytF5FzFPzR2nmiI1PATb30LHACr5r64zEk61SYJPP4PzjPS67ZEGqNPU2hsmeAHuYpCVPCjuCa1Lg6jG3kkm2Ynvl5kX6x1W900SFC2mIn/TZYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719934160; c=relaxed/simple;
	bh=vWc+6MSkDVzHr4pzSOUH5S/bvDkJBF/OTPdK/EBI214=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KdxhCl0p68IE8Vi1ohO/l9USNSwkad9eUSMYMM6Lph1VicjkFGbncLhQ8+yP5xCKbrwYiNGZFHwCJXJMM3kpMHnfPZ+c4HnmlTjKNIaQTZVtjoc94cbBGFQCoTOZP72buhv9KryQbtQuYhxn3PrXTIcpE7OtVViRcEL5DN8b5ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C41hIJxh; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42565697036so32442675e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 08:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719934157; x=1720538957; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M37+WZeSe+oikF2i/7+dIIsR6vGmSE7qj6kzbbudUC0=;
        b=C41hIJxh0TyJbDLtu+HyxN9rP+RreSTgUBMRm/UqXAfubFFtSMQLfK5uc9vqtxh0gv
         zIxvy7M59YV0xmjIvIeG0OYc2KRl+rzs0NcThprPfGDFnPHSD4fivUe9tDM5EzLGA7F3
         hi2EBwSvhYNuNZF6IVac/vY7z2AsX3HSMAgv/BqJmBiK0lVwoTOGszS/QC7t9h7Bfrfv
         XAMlGo/Ert0z2fim1cNWMchw4ULZkQ9+Lq2yVTC4z/mHKQDGlCJBJPsnmbu12/XR8ZY9
         eWpM7zaeRJV7AzZkiE/cxY9liKdLQemaHRYHowZ6c/ifS5fvUlu5UENwGPB/2pVtzaVl
         Sqkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719934157; x=1720538957;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M37+WZeSe+oikF2i/7+dIIsR6vGmSE7qj6kzbbudUC0=;
        b=sis1pBG4va4d1wsL1Qvexowb92obAJXxQWTrBHEmvk5klCGx1LiZ8e0iCL2VdNTHlF
         977HT5IK0nJ38FvoFLuZvpvHQuWHk3OI1d6QibOnAg+VTSb5pjJj2ZVmr+KS5ZuhbxGV
         OhTzQSfP2Buegf9VWw4C/wVKyVICEJrcfCyfX6VF3rNF4a7fGnp4yKLOLsCIvYT3d4ri
         NipzXJppq1n7JcXydpwmzVb85GsYvIBjEpW8Xp/eYXk5qcyUE8iG4XxFy9p1wFPTtcHx
         8BXoiGyXmqrzxnG9vKDNJygLV0lOi3fdOvUca2hbc0KoLs8p8wN7ZiQfcDwONA6+8e1i
         +7kw==
X-Forwarded-Encrypted: i=1; AJvYcCXCTmsei2EPYPxB4J0uFkkBrYxbHH7kjmgoEnvPqCKLiesK9+HqLAr4Dhhsydgyw6xrlwyv150dzWR5Bg7o/EVFgKTB7IoecjM9pbdg
X-Gm-Message-State: AOJu0Yy/UhRaD1EpduKvb/vmAHHAZfY/43H7fWls/HYX9vQKVys37dKo
	XSTsjbfsLdbZEKkKxb7dcbQ9bU7/ZE5QEQ9a4cnJBqvLHA1hb/H9
X-Google-Smtp-Source: AGHT+IFm4ASczFv+04gwkE02HpGzFWOJlA4riesLhyWmf9wxQVWR6d3VoZtP1C6Q6/pMuYMIm0DbyA==
X-Received: by 2002:adf:ec03:0:b0:367:8e63:4da4 with SMTP id ffacd0b85a97d-3678e634fa5mr971274f8f.14.1719934157387;
        Tue, 02 Jul 2024 08:29:17 -0700 (PDT)
Received: from [192.168.0.31] (84-115-213-37.cable.dynamic.surfer.at. [84.115.213.37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af5a3b0sm203368325e9.13.2024.07.02.08.29.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 08:29:16 -0700 (PDT)
Message-ID: <035757b1-5dc5-4966-9eaf-a52b707bd48e@gmail.com>
Date: Tue, 2 Jul 2024 17:29:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpu: ipu-v3: Removal of of_node_put with __free for auto
 cleanup
To: Abhinav Jain <jain.abhinav177@gmail.com>, p.zabel@pengutronix.de,
 airlied@gmail.com, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org, julia.lawall@inria.fr
References: <20240702150109.1002065-1-jain.abhinav177@gmail.com>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <20240702150109.1002065-1-jain.abhinav177@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/07/2024 17:01, Abhinav Jain wrote:
> Remove of_node_put for device node prg_node.
> 
> Suggested-by: Julia Lawall <julia.lawall@inria.fr>
> Signed-off-by: Abhinav Jain <jain.abhinav177@gmail.com>
> ---
>  drivers/gpu/ipu-v3/ipu-prg.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/ipu-v3/ipu-prg.c b/drivers/gpu/ipu-v3/ipu-prg.c
> index 729605709955..d1f46bc761ec 100644
> --- a/drivers/gpu/ipu-v3/ipu-prg.c
> +++ b/drivers/gpu/ipu-v3/ipu-prg.c
> @@ -84,8 +84,8 @@ static LIST_HEAD(ipu_prg_list);
>  struct ipu_prg *
>  ipu_prg_lookup_by_phandle(struct device *dev, const char *name, int ipu_id)
>  {
> -	struct device_node *prg_node = of_parse_phandle(dev->of_node,
> -							name, 0);
> +	struct device_node *prg_node __free(device_node) =
> +		of_parse_phandle(dev->of_node, name, 0);
>  	struct ipu_prg *prg;
>  
>  	mutex_lock(&ipu_prg_list_mutex);
> @@ -95,14 +95,11 @@ ipu_prg_lookup_by_phandle(struct device *dev, const char *name, int ipu_id)
>  			device_link_add(dev, prg->dev,
>  					DL_FLAG_AUTOREMOVE_CONSUMER);
>  			prg->id = ipu_id;
> -			of_node_put(prg_node);
>  			return prg;
>  		}
>  	}
>  	mutex_unlock(&ipu_prg_list_mutex);
>  
> -	of_node_put(prg_node);
> -
>  	return NULL;
>  }
>  

Hi Abhinav,

Apart form having sent two different patches with the same title (hence
the confusion), this cleanup is right from a functional point of view.

On the other hand, the description should address why you are doing this
cleanup (e.g. to remove the need for explicit of_node_put() when the
variable goes out of scope). The need for of_node_put() does no vanish,
it is only automated and no longer visible at first glance by means of
the cleanup attribute.

Best regards,
Javier Carrasco

