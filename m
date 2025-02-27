Return-Path: <linux-kernel+bounces-535950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B236DA479B2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 11:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EC147A4429
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 09:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A916229B3C;
	Thu, 27 Feb 2025 10:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CCvvIGtX"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B192C6A3
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 10:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740650402; cv=none; b=Vo7qecGydxWfjO5rtgmC+gOnby+flh244yK1IH3yrQiILSHeN1yhdvT2BfWrZRp3wdoIn2sxNEOaxe7U2Hk4yVTYffGoSasYD0sVlnnK60RIz/ygAPc34QuYIhI6dvNWGVu0uyiYzEoS2tNK72HZQKXI+Byt/5+1K+NT5fIP4xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740650402; c=relaxed/simple;
	bh=Hxy4zLP7nPAij63gn8nYyXPjhnD7qhC4nNggf0uoN4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ogrpAuqY2VgtntOCfG9VRTMtRxRsMv/fGSdvA/Z8Dlo14SIs7BCyp8G6NzCZAGsN9cMQDFZrwZkkR350o4yRlqUhky6BQRiVh6txbqoG8CwK41krAzo49iN8wULy8RK5iRIlunyPxngw5ANo1P3fx5xvWi7SSTRbLvcTTwPvijo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CCvvIGtX; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e04cb346eeso1103705a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 02:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740650399; x=1741255199; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sIHFyw4DJimMnpIl8i0OzzVtEtYlzfhRkm9JXG7+7wU=;
        b=CCvvIGtX5w7qsr8/mf52TKi5Y/qRxLm3tRtlJbxHQcMpPUZ3FQDYp2T5FngSmF9PUG
         gN0edsAS0GU40gb/7tt4Y8t7PZvo3iHwBUNybjI3KWgh2i2liOdEjbZo+cANl7GPRhKk
         8oLHlrHf4l4d/69xhJtnSAeDIJWw3h3sbiviUpJYNfb/YOPMewF0CdNXmaYTdRRhuhaJ
         0pMAQSdAke6hrQbSv50DFa4y4OuT/NHcM63P8EMBCUUcsa2P0D+Co9FQcgogDlQR2t6Y
         kAFIMunJ899aiQGbg5IwDTK2xHSLV7LY+r7wDNiYrHVRwnIVAgIhqRnEHlgYD7HzComc
         h3Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740650399; x=1741255199;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sIHFyw4DJimMnpIl8i0OzzVtEtYlzfhRkm9JXG7+7wU=;
        b=ZfNpviltz2/wvCSQNcpNfmE2nu1UOcw6V7pz2Ux2V4T+UW+sW7PaM5mhO6SOguc1Su
         N/zy4wRNAg3ifEQ5131EiDJAq84tN557oZiL+oi9c1YeY80z34jvXVWY+jqRXx5IPKdW
         fTATgamjqusbkUo/8zU6qfD/dl984K8a0h3S2y6IeK/Q8PNCu2QbKDlkoe9Bz3bsaAva
         Rnb8oqiBKj99vRFQAz2pMmY4jtjjl9GM7Sqr6YHk21pq/0+VCVP6/QhMzUdiRSE86o4g
         EfaH4XPbS2FemwGaMXz0kVl4PZSCu9wY++fspkmtqrsTBrOgBTNjQ00qVGQrR9MO+1b3
         LVjg==
X-Forwarded-Encrypted: i=1; AJvYcCWIAqdj4+QdqzHCijBnI7UUm16xo/URyCmXlgSmKySbru/mlRIMbsNEVebEgcVuBkd6n/lzrLdWIVjiZRg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkcLA6flc1fxBK98LsNvp5+kJLpPJoTgzlUzhPTY2em4WBv6wh
	T/07EsSOuvNojGaarrHCP+mSxMuHDOKKZMgMPguChpQoip21OZ0Rx9Nd1UI+UrY=
X-Gm-Gg: ASbGnctvAtsfQglhRTqqUPZSdqNKZsWZXM8RHkcYpQ1YEA3v7E8lc93cVPHCirG5wOH
	R2k2ca/G1Rn01AOLDsPGgZzQV1E3smAmd4eAlcyjAPow90hCmP5wphbYCDQDGzmsl3OK6qm46FH
	PMbQLuIFsJZcY7fguV3gM//+lpO+wLpFnLDdio+Klucz5tr042OjY2RQCq3209ix5oiSV4nHtxh
	EIeozhkdJP5P2fwFYj+ErsSZJ9K13260bMnidzH6d6Rkb4I75xfcvpYCF6MDO6TVdIhVowYZXCM
	7oDsqQxajOSkThEIC+KMjpQp8NNvqMA=
X-Google-Smtp-Source: AGHT+IHunHmqDDk/8KV7z25yVlfx9n1ZmOsivVdt03USwowQNbi9YBZAEFtlG6SH7Vi2b3fPs6n3vQ==
X-Received: by 2002:a17:906:7cd8:b0:ab7:b5d9:525a with SMTP id a640c23a62f3a-abc09c1a653mr2285136866b.37.1740650399043;
        Thu, 27 Feb 2025 01:59:59 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-abf0c0dc21csm96948866b.42.2025.02.27.01.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 01:59:58 -0800 (PST)
Date: Thu, 27 Feb 2025 12:59:51 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: slongerbeam@gmail.com, p.zabel@pengutronix.de, mchehab@kernel.org,
	gregkh@linuxfoundation.org, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	hverkuil@xs4all.nl, linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] media: imx: fix a potential memory leak in
 imx_media_csc_scaler_device_init()
Message-ID: <d09ac514-be27-46eb-8b2a-1a397e3321d6@stanley.mountain>
References: <20250227074451.3698971-1-haoxiang_li2024@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227074451.3698971-1-haoxiang_li2024@163.com>

On Thu, Feb 27, 2025 at 03:44:51PM +0800, Haoxiang Li wrote:
> Add video_device_release() in label 'err_m2m' to release the memory
> allocated by video_device_alloc() and prevent potential memory leaks.
> Remove the reduntant code in label 'err_m2m'.
> 
> Fixes: a8ef0488cc59 ("media: imx: add csc/scaler mem2mem device")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> ---
> Changes in v2:
> - Remove the reduntant code. Thanks, Dan!

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


