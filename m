Return-Path: <linux-kernel+bounces-296965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B147B95B136
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 11:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3BD91C220D0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 09:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465CF175D3D;
	Thu, 22 Aug 2024 09:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lCXIUzub"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B7D15F41F
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 09:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724317953; cv=none; b=t5KjDtSJtdpEct/MtRngkWNX3+h+CuLfPgFHoKRPJqWyjnq9ftYSKeESwJnwMY0AzeGLw0mi/y/8VCxBjHpSeXBC/h2jEmVxLY0Lh/iNPmy7GCvY7EADmXcJDVQoOjrymo43poFYlsrSFyPlMJVwrRNmWxjV5rrX8Idbh78MFf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724317953; c=relaxed/simple;
	bh=fFAvq+LiOUScZdK+iHMqO5f6qYOsvJSM5jiQ1E+GQK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A4+W35Rdt3efAmkcd7GdX/9dz1tg+3LkNSXeA0OuD2w9FkvksSu/2VVgyRYwINbE4ciy04Sw0jxn29mv4wx+4MSixTaE+lPSIrgZBJRbVkjU/R4Y0M6rgDuYirLjjTsfnu0JnW1ymCeOHu7y53YiseNAvSZkRQwV+dt2kaUuClU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lCXIUzub; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5334a8a1b07so799606e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 02:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724317949; x=1724922749; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OUuSMzV2vIHp0C9+1vn9JoGjag8c0vylXc1L0rYzmIw=;
        b=lCXIUzubxuS6VyUnhxwLNPCkLc/1o0UsocM+tVtv8ThMe/X5Qt2pa7PPbiCwHsIpJZ
         xm1FeZH3KpdQedps2DbfvyfJzAM3VrVUWYeDsEcUnM40CA5RP57lrasTwyyp/ByyD+g1
         +rDR/yrvkfjWlkY6dxAt36tcVEXs2dJoK3ix6MnmrE22YCNU6HX84DwkgWgdOLGM5B2o
         EygEWDJoC71L1mXlLZhADk7Wy3OjrAqzhByFgMSc7rVhg39B+mhXfF33Xk+zArNbQwSp
         H1nRd1EBgstWcumsdy68r+tkrIkzZ899mMlb0lfmYE3uZddM/9Az98zW2fUW3wzngUdR
         9mxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724317949; x=1724922749;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OUuSMzV2vIHp0C9+1vn9JoGjag8c0vylXc1L0rYzmIw=;
        b=B5rc/6xc+3eugAqDvXRBLAbs+8hkYtSj3etmWUhki2pS9rWxzae5/ZXSvouv/XA7s6
         PB0l3ZgrL9v9NsaIScdl94yMeFD4CsNLPRhAkvfs/l29qYIlMjFOYYE4XNq+Ute209mC
         J/vOJEBjf+tCN7K2qFcUQyk8xPihHkipFjvE44dj3MBykU1IMc9SIICCGCttY/COrq79
         6CRhpoYhKSSgMnJYHEvOcEQvhTEtQnSd3RAUiXYE7raT26z6X8TO5w7u3Dm9X9hHpsun
         nf0eZfWI3eYakpm6wVosfttpuDXxqggO0HRyZ7ETNWTYg2g9eIulZz1xJGy9Bkck0wwg
         /TlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzLOKsrRDeX1x6ulWp1taWE56JlFhhv0bwR+qJExB2xUKZy+hgf2G4KhNioyVibmGwtkN9HmiQT4vtm3w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwd8Fnvr/ynJA2Yz1Xyd3Gl3YBR4yDrqnjZrfYfyr7nIPicuA0
	474O8lyQfIUKZGuV6nJ4bneKGei4Sct9jExq3jti7KZf9LxJKDO6d5fWjqELiAk=
X-Google-Smtp-Source: AGHT+IGkixQ062iVw3SWBM3aPJAQvXobN0pXR0RX1oG3yd+dxTAgYJ187hfxrMqr4WvC9E7Fs9PkxA==
X-Received: by 2002:a05:6512:b16:b0:52b:c27c:ea1f with SMTP id 2adb3069b0e04-5334fd59032mr775625e87.55.1724317949009;
        Thu, 22 Aug 2024 02:12:29 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f2205e1sm91732266b.12.2024.08.22.02.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 02:12:28 -0700 (PDT)
Date: Thu, 22 Aug 2024 12:12:25 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Gustavo Montenari Pechta <mrpechta@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	~lkcamp/patches@lists.sr.ht
Subject: Re: [PATCH] staging: rtl8192e: Fix camel case
Message-ID: <6fc7a4ef-7a24-451e-8138-6cc4af033fc6@stanley.mountain>
References: <20240822002733.27609-1-mrpechta@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822002733.27609-1-mrpechta@gmail.com>

On Wed, Aug 21, 2024 at 09:27:30PM -0300, Gustavo Montenari Pechta wrote:
> Fix camel case on variable name to match style convention
> 
> Signed-off-by: Gustavo Montenari Pechta <mrpechta@gmail.com>
> ---
>  .../staging/rtl8192e/rtl8192e/r8192E_dev.c    | 32 +++++++++----------
>  1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
> index 6ef38f4ca17c..14e50acb40b5 100644
> --- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
> +++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
> @@ -240,7 +240,7 @@ static void _rtl92e_read_eeprom_info(struct net_device *dev)
>  	const u8 bMac_Tmp_Addr[ETH_ALEN] = {0x00, 0xe0, 0x4c, 0x00, 0x00, 0x01};
>  	u8 tempval;
>  	u8 ICVer8192, ICVer8256;
> -	u16 i, usValue, IC_Version;
> +	u16 i, us_value, IC_Version;

The "us" stands for unsigned short.  We don't really want that kind of variable
naming scheme in the kernel.  Just call it "value" or think of a better name.

regards,
dan carpenter


