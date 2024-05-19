Return-Path: <linux-kernel+bounces-183282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC038C96DC
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 23:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBB3B1F210C3
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 21:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C3D71B4B;
	Sun, 19 May 2024 21:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="efIwYU6G"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A40571757
	for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 21:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716155086; cv=none; b=WLYkWjFxVQZuSZbd4cxmOgH7EpQxHYddEKXH5ykcV2uv6OBc6+E++Jneg725a+gVpzq8hHwpiuaYxAJMfkqhmSbrwvZfDulnTMY30pKg3fH2cGQPeGXi+P1a1LG08O4cXmZr5AB/zyHp/I8bdEWyXtPstSOLjE7qnGs0mobXLDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716155086; c=relaxed/simple;
	bh=fGSAVIL59Ifgq2urnJfcK6Ty5wtkxO2Uaf4Wxe1mI1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pZntp8kui6U8eUOn1RdSjWrZ/rOX44AX+/igiiZLEqx11hUnQRnpF448rEgFA3b/pgSq7CkoIDRsdXIsBO5flcz6lfZLp5e81gwyFQFG/1cgrXLd0ul2wpfhtW+lb75oy3lA7MHJxTSX1sxqR1z9ubuEOrGbi7oVBm/9KzEDVpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=efIwYU6G; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-523b20e2615so4369077e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 14:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716155082; x=1716759882; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iZrkjZRHsfmxgbK3walk1XdMRADgBjFWKUVLaZqtwFE=;
        b=efIwYU6Grf2LgLW001so4qbfRvDcvZOBC/GGSKj+fdNfjKWOueVHFlCzKOtxOJ91sd
         heNk0F+6S8n43vK1ONkWPcQvPqDB0f+L+txgl+zcLxNwwn8mAi4ApTWrz9bwdRNJCN8X
         cnIsEyRWqdCVrFQRrgl2fm4D3InBOSu6ozrDVPb5IEfG3/WgW3VtZS0JTxFWt6Xit7I/
         jcKsG+Yl33smmpcEzO2Do9kf/cWdv4WjujJPQ3rvEpewDrV6taX52BHS+1KawAAHlKhQ
         Po4KuFojGIBoZhYi4roxO1H0aOgn/Psp0BXrZtuNGdxqwWEcQX75R+PDPIKe1GzSq+7e
         8z5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716155082; x=1716759882;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iZrkjZRHsfmxgbK3walk1XdMRADgBjFWKUVLaZqtwFE=;
        b=jLN3ueTeidXc68fucg1xRFcpSVZ+oJtX7B9qoDzKHe+efEQrQd+6lbsSOG3M3ePsP9
         MctqZpGeyb4dIjrgVfFxtDCUSZTIpenLsZEgTmNls9l6jCNjaeBG3EDXHPu+sW6vy8bE
         RhyCa786dFM9t/0qQQbmP3pG5CFu3hNLiApxT+8LQjxJvqMlAh6GBu1Oodw0750KXIbo
         JjItm45dkDxTVM82l/EnT5oTpW/AwZKV2ymjMP3BnHytbyK93mBo0W2PUhrNyxOPlwDm
         0UhnRkscZ8EfA1BIqP0mCgEEvfskLuurY8HOmVrgI+/Y1AQ0DeEcWTPUm6wp3LhnLjKF
         QBaA==
X-Forwarded-Encrypted: i=1; AJvYcCVtLRjhQIw/VnDM5VrXZQnue1gwDLnVuVYxaGVQ+BJIJf0gY51EfHMSNXJNBqUY2d1m5xJdXsF5yWj8yHYYQwekMpN0UZQBzz/qqXBI
X-Gm-Message-State: AOJu0Ywht1n4kylC9X4FLln1cjDnFmW7dpZ7bP7WgzUDwlEGoRB8WqqH
	3nOMoLGzKRAwyZdU+XLa9qE+Fa2C9Nm3DWo/eFqTD/bPV28cStr+v9fKAMohOew=
X-Google-Smtp-Source: AGHT+IHOuiyvikkf+YRll9mS4v1GujAEdqsCvFUwgxyyxkIYPx/CXF8ahRuYHA82wBImlUDB5iNHmA==
X-Received: by 2002:a05:6512:3b86:b0:51f:3f6c:7466 with SMTP id 2adb3069b0e04-5220fe79356mr24519590e87.48.1716155082667;
        Sun, 19 May 2024 14:44:42 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::8a5])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f35ad4d0sm4047947e87.49.2024.05.19.14.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 May 2024 14:44:42 -0700 (PDT)
Date: Mon, 20 May 2024 00:44:40 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: Maxime Ripard <mripard@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] drm/bridge: Add 'struct device *' field to the
 drm_bridge structure
Message-ID: <6khhnjtdcjvebnffrqlavowld4gvgcpnxplcinkja5xv3yefct@vjnmj72dfqtg>
References: <20240514154045.309925-1-sui.jingfeng@linux.dev>
 <20240514-scarlet-corgi-of-efficiency-faf2bb@penduick>
 <c44480ab-8d6b-4334-8eba-83db9b30ff1a@linux.dev>
 <20240515-fair-satisfied-myna-480dea@penduick>
 <d394ee32-4fa4-41a8-a5ca-c1c7f77f44d2@linux.dev>
 <20240515-copper-chimpanzee-of-fortitude-ff3dab@penduick>
 <2c15c859-6b2b-4979-8317-698bf6cc430c@linux.dev>
 <20240516-intrepid-uptight-tench-0df95e@penduick>
 <e955b706-04dd-479f-8327-32771d94f70f@linux.dev>
 <07b931d9-b11f-4829-a6c4-d5025fc071b5@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07b931d9-b11f-4829-a6c4-d5025fc071b5@linux.dev>

On Thu, May 16, 2024 at 08:04:59PM +0800, Sui Jingfeng wrote:
> 
> 
> On 5/16/24 18:40, Sui Jingfeng wrote:
> > use 'to_i2c_client(bridge->dev)' to retrieve the pointer
> 
> to_i2c_client(bridge->kdev).
> 
> Besides, this also means that we don't need to add the fwnode
> pointer into struct drm_bridge as member. Relief the conflicts
> with other reviewers if the work of switching to fwnode is still
> needed. As for majorities cases (1 to 1), of_node and fwnode can
> be retrieved with 'struct device *' easily. The aux-bridge.c and
> aux-hdp-bridge.c can also be converted too easily.
> 
> of_node, fwnode, swnode and device properties are all belong to
> the backing device structure itself. It can be more natural to use
> device_proterty_read_xxx() APIs after init time, Which in turn
> avoid the need to acquire and duplicate all properties another
> time in the driver private structure.

This doesn't sound 100% correct. This is going to drop the possibile
case when bridge driver uses child DT or FW node under the main device
node. For example of such usecase see drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c

> 
> We could do the programming around the 'struct device *.', remove
> a batch of boilerplate.

-- 
With best wishes
Dmitry

