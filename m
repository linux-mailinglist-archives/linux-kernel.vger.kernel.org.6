Return-Path: <linux-kernel+bounces-365478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8911599E2F5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 11:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C1A41F23161
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 09:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A21B1DF980;
	Tue, 15 Oct 2024 09:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZBcnLhNp"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA091CACF9
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 09:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728985334; cv=none; b=PyoEA2Oppcm+2WxeFhhkY1Pv4tS1xBhKe5NBUsTKs0gjNKVnuIA/AOc0C91Z3zUA1tJnp3plsbJWS3dxIL6MzLrbaycomtQV7xTliuW2YA3s8/b2qSP/VLko0fty3STENCuQvOjVJg1lECId6kc74xjj5e2S1fTAFTi6jVve5QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728985334; c=relaxed/simple;
	bh=AbjIZkV3DT6x8on/kaS4iPZ3QMQjL8NVI7YnkYT+rE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qPCk1mdyYTPvE4yLL4SNYzwtgsLxp++q0cdKs3nU63KRcmM2ey8MRQCXFvePeLfrIy9APTKCUtRFJfW741CwqQ4+eZPPlSoLAqXmKmhPBtwxZHeBzvR1A9RZq+W4QEKxk7nT980vA0NLSTQbgpOu1nFDRnhq75qsVGgkUYNasvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZBcnLhNp; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9a0c7abaa6so278625766b.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 02:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728985331; x=1729590131; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BHp49d9/BhialKMrGvk56DMJ4Tuc0RIYZ8PmphUFmMs=;
        b=ZBcnLhNpZt4HwmziWbZYuhFNmysSn1xzVvbQn6G7o1rga7pD35Dhj5xfIjHdYirtgD
         GvTST+pU4Ahl6UOgLdAGnRBHPBZAa4K/7lCkpaSDXiwBqnHIg2IF/RAyOe5OF1eSqFP8
         lOi26ic6jlceN/ykRU9VFMinc3xnKVeKRcb05AP8+qH9FNTbzjXaL+SvFiBeoO9Imdz6
         pTNaYBDxrRYHgXNoxLB6f/qpe+Flf/ZtlfHQh93Z3GBtKHby9SGI9VNj3PSchAQN5trR
         VbuHWemXkWdYgHFASmWv2HElNP4j9+g5XoKgPhfGq8Af/5V8J+wE/GHoaVxAXVpwwC0V
         yIHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728985331; x=1729590131;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BHp49d9/BhialKMrGvk56DMJ4Tuc0RIYZ8PmphUFmMs=;
        b=KTTq0uWkRSBf6TAKkQHa8manqoLBCf0hHgq9b5JRwPz0TspL+WZrzHiaN9nc+iPcGh
         CdJP+fr3HswPIXPU09tfdzwEjQ37ELHF4EdVsimxI6X9aw+Gk+BqBElLLl/LbcG1buQx
         GpWtodBWo5N+BtZ7X8f3NC1r10HdyKSYqyowG7gRdy4NkWAomqhc8wtTyqSXeEDsCbjm
         iLSl7ItTdoGeVXkx83UjGx+HzD3YGu13oVIVF1xzAyr5ALmUnc9AjPdBC7UnlMwbVMOi
         NqduiEAo/L9u5Qrx5e36m18QKvr6Z42zF8hTNha9JgF7tuAkLtprWRjE297umgze78D2
         b9gw==
X-Forwarded-Encrypted: i=1; AJvYcCXSTbnhi5hsHB7JkScfdyjdUYG9EZgqbqnyNflukyi+0kFVR5G4wiiPlw1F1nHhfCzdDvPFK9aXtDwDpHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSL+GdOC05z8Zc/0HLY33OROhSUnUwoDGzgZXID+vQEtDaeuf1
	CLHzpfrJuwEjON3ToYbFpNL0KO5FcWA/ZUq1BD7TYolwM1jClAXZSGPOe3dmLiE=
X-Google-Smtp-Source: AGHT+IEKNdUVyaZ0iX1mqaNC6+kTh2EIsu3a1wAZd1DrGPAVSOBFkqhXIa23pfvozbzQifTTRIthSw==
X-Received: by 2002:a17:907:7d92:b0:a8d:3338:a48c with SMTP id a640c23a62f3a-a99e3b20e9bmr1117974566b.7.1728985330705;
        Tue, 15 Oct 2024 02:42:10 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a29844739sm49887966b.171.2024.10.15.02.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 02:42:10 -0700 (PDT)
Date: Tue, 15 Oct 2024 12:42:06 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
Cc: gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
	~lkcamp/patches@lists.sr.ht, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] staging: rtl8723bs: change remaining printk to
 proper api
Message-ID: <d20087fc-586e-4a52-99e6-6a09b33ed00e@stanley.mountain>
References: <20241015014738.41685-1-rodrigo.gobbi.7@gmail.com>
 <20241015014738.41685-2-rodrigo.gobbi.7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015014738.41685-2-rodrigo.gobbi.7@gmail.com>

On Mon, Oct 14, 2024 at 10:47:37PM -0300, Rodrigo Gobbi wrote:
> As part of TODO file for future work, use dyn debug api for
> remaining printk statements.
> 
> Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_mlme_ext.c     |  6 +++---
>  drivers/staging/rtl8723bs/hal/hal_com.c           |  7 ++++---
>  drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 10 ++++++----
>  drivers/staging/rtl8723bs/os_dep/sdio_intf.c      |  2 +-
>  4 files changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> index bbdd5fce28a1..58da34f125db 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> @@ -1870,10 +1870,10 @@ unsigned int OnAction_sa_query(struct adapter *padapter, union recv_frame *precv
>  	if (0) {
>  		int pp;
>  
> -		printk("pattrib->pktlen = %d =>", pattrib->pkt_len);
> +		pr_debug("pattrib->pktlen = %d =>", pattrib->pkt_len);
>  		for (pp = 0; pp < pattrib->pkt_len; pp++)
> -			printk(" %02x ", pframe[pp]);
> -		printk("\n");
> +			pr_debug(" %02x ", pframe[pp]);
> +		pr_debug("\n");

No, this isn't right.  You'd need to use a mix of dev_dbg() and pr_cont().
Basically in drivers it should always be dev_ printks except for pr_cont().

regards,
dan carpenter


