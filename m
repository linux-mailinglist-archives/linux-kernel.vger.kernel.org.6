Return-Path: <linux-kernel+bounces-365564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDDB99E46D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 12:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E2621C21F39
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 10:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439DD1E3764;
	Tue, 15 Oct 2024 10:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TKpc3woS"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AF5170826
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 10:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728989136; cv=none; b=V81kPHBM2J0OKx6bLmBIaeUceTZ0umQUunvwAtZY8PYgB8z/XEg6UMMyPERS1JGR/DsrzPTkX94qr/TPwycGb4es9s08VsWqzIJ2R4OmhbFCbqSNH22AY0A9kgHb2SNZnzcsXsVBgDQLSifuipaxgI8PufvRi25/hcEhQRnvSV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728989136; c=relaxed/simple;
	bh=2RUa+Wp78UJcnBTaHrcjGmfuvysTndxMqeQSnUj1y4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E8WcgMmfB6WtZ/TX8gBzpwbSiT5EBbT/UNfkPUof9TyF2wo5pEYHhT/Qnspk/g0f37IGeqeRVBP1iYVTwoINvLiTJMbjqOATQE4kIZJjYg2SkzZhzuWU31G5nv86/bRNC7tQQV/dIgy+bbYY8uS67Nm3Q9knry92j6RdIpSezs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TKpc3woS; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9a2cdc6f0cso61969066b.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 03:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728989133; x=1729593933; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TCL9tE7kD/pEAlw/bIpW3296DIJpWExNiDbcmpjDgj8=;
        b=TKpc3woSI8G0lsZy7MRjDx4BQlq1YfNnEb0d2nI5J4oviCb6w6SbqWbTOjJmkmXAye
         vwIyo4fu6JgF7+ub8nAAOAZHhoSZIuPuLe46RRvZcVAUlSBDZqKe4QU1qyeEOzmiTAZQ
         FLoSkdbEDp7TtfTnw13mAj9jVbK9Bbi4XpofaLtZlo6OAE6uq80aTPug7i4t2ko7bxIV
         A6J7SU094mreEuxcTImfKFgxGvBg5CoDGcBS4+ipaqIot7FI8GlK7QPBMqyT7YhvdixT
         cKedhCqcoapObKdIXS+6ZUu6AR4wXMg2dofdx02YE5gvmqoKF1Y/s7V771sb3CNcmRVE
         TOVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728989133; x=1729593933;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TCL9tE7kD/pEAlw/bIpW3296DIJpWExNiDbcmpjDgj8=;
        b=VyE48+0Uv69ba35rS8OQxbcVxtGRLuf0SRiYNLrZQ99ZEmrk9JR5A3+ckhuVMuIlDk
         S8X7wifNT+8835RrH5VT7ztQ9sLPqzUBA1Alh1ltsa0vZ94HENzRXevPbV/ue1jCO/0q
         XDUQomKs532RB32apUUzHEIZnji+h/fqeMb5pSrqE4BFrv/Q6ZIexBAGvhY/d5BoqA86
         HSVhWDtAwNiO7xPW8cyPET/xayge5PUKptvGoDyr0vGjYQtChEs6cs4w78WHcN27NKgZ
         YX0A6y4HQ2xIbX0ft1xkmfxFUVgcBrS+U/SOjfSSb7Oy6hB1Ki7vMqtLbL4mhT5eN5YO
         TjHA==
X-Forwarded-Encrypted: i=1; AJvYcCUSekIPeBsC/RkWtTogfpMPwLMc4PojTEKb+wUik2zYTF/TS34tdpJFi9jusTeRgUGODoGvoQtt1miFBq8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1BGBAU79aS08aXNifavfQZkRhNcvSM3vu61PR9saqT7uqu3oF
	WUUHy6D7B8WcBanhdSQJWEFlM7vrCqnaXUkkzC3Y1XnPzyV7Q1CcjqnH/YIwpPc=
X-Google-Smtp-Source: AGHT+IGr2iqgWL4Av+20XWPNQ/ZE7fyuLmJsKSn2ZOfDWIZori+kUOfJFFddL5wMKnYz/zgwCRipDQ==
X-Received: by 2002:a17:907:7e8e:b0:a9a:61d:7084 with SMTP id a640c23a62f3a-a9a061d7325mr751772566b.50.1728989133267;
        Tue, 15 Oct 2024 03:45:33 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a29843318sm56079066b.150.2024.10.15.03.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 03:45:32 -0700 (PDT)
Date: Tue, 15 Oct 2024 13:45:28 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Su Hui <suhui@nfschina.com>
Cc: sfrench@samba.org, pc@manguebit.com, ronniesahlberg@gmail.com,
	sprasad@microsoft.com, stfrench@microsoft.com, tom@talpey.com,
	bharathsm@microsoft.com, nathan@kernel.org, ndesaulniers@google.com,
	morbo@google.com, justinstitt@google.com,
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] smb: client: fix possible double free in smb2_set_ea()
Message-ID: <c0afa02b-991c-4601-bacb-13ace9cb96f2@stanley.mountain>
References: <20241015102036.2882322-1-suhui@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241015102036.2882322-1-suhui@nfschina.com>

On Tue, Oct 15, 2024 at 06:20:37PM +0800, Su Hui wrote:
> Clang static checker(scan-build) warning：
> fs/smb/client/smb2ops.c:1304:2: Attempt to free released memory.
>  1304 |         kfree(ea);
>       |         ^~~~~~~~~
> 
> There is a double free in such case:
> 'ea is initialized to NULL' -> 'first successful memory allocation for
> ea' -> 'something failed, goto sea_exit' -> 'first memory release for ea'
> -> 'goto replay_again' -> 'second goto sea_exit before allocate memory
> for ea' -> 'second memory release for ea resulted in double free'.
> 
> Re-initialie 'ea' to NULL near to the replay_again label, it can fix this
> double free problem.
> 
> Fixes: 4f1fffa23769 ("cifs: commands that are retried should have replay flag set")
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
> v2: 
> - Move 'ea = NULL' near to the replay_again label.(Dan's suggestion)

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


