Return-Path: <linux-kernel+bounces-517725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4CFA384CC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 14:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C93E73A053C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 13:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1949021CA17;
	Mon, 17 Feb 2025 13:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xO+aqqle"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430C91E515
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 13:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739799099; cv=none; b=fEPpoXfK+eS88ajgny271208C5Q6ZnFtEkxXPLEz1Y7hIHnLpL1S3aB1efm4TiGPpe9Zk+1fb2zcf0DQMjyHMjf24Y7JIi84284UbHmO8wgzQYnLokUSMb10OLHV4guPQGfrB06mveOtbKNJxsksG8euqY1GDM4qC/PIuNbWZLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739799099; c=relaxed/simple;
	bh=pfta4Pm4pk5IpJlxB0EEt/X0m5YBmHer64jfAMzh9PI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q6jkZd2XGI6zYGXsW+TL0GVn8KTd9fCZPifnB36mZQuqxwiMzyoCXYN0fEaJ6LxBSxOgTFT0JxuEBR2He4N4l/zpTwrfiDIDGsMu38jTli6oI2IXah1krl0zCx9ljiAqPKLeyEUgV6syR0wVR9x0mwlQazAtelgAurXVdTBUrq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xO+aqqle; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5ded46f323fso5462101a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 05:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739799095; x=1740403895; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HePxZ4NzY+6vqhU8FtuMDirnS9ZXHHg6wU/jN8842aw=;
        b=xO+aqqle/xNfjq6cUmiYRqqW/iUdU6Jvo1QbF8RX26d5i55gM/OxCPFH3VVsdcssoZ
         TFxQ+prhTMBcXH6XwiXJSdRCPZbrLV3+EE7JFamCPxYE392MpXQgAbzASj8PKlFMZPrf
         E7pFp43wOquABKiiKxzNPdmGqKXkPXub0GYNYRS7hCbBqKP6KPmlg0mRmdLNIsL6a4u6
         KIeZQUp7brDUxjpLcgS6ZUIVaI9hHDylVHPApjDDFiW+arw/eXKheGbDJ19BQm162oRU
         x/b6jzmYbIbRbdnfJEzol4nMSB7bAnuenlZjBdE6kKLa0R1HXc3H0bxzxiEjCL6SaFKD
         tf/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739799095; x=1740403895;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HePxZ4NzY+6vqhU8FtuMDirnS9ZXHHg6wU/jN8842aw=;
        b=ZmXBDxJsuFDAsjEo8dj/m39eghQ3QVMLA2E+8JTM/Ni6QBUJi2bfXsnbB5b7gzw7sx
         ufPFfjI8IhgU4MY8snj1VNMN+G/70zL/D/h91hmKHFncZ2vmlFoPDuxKiXv3EUxa0R9w
         Et3+hR08WMUe5NRsVPjDvZVEoUUhjf4/sUHAR2IC8aXTg12J5jzLj56r76MEJgQve0Gt
         WRDUiSo24vAHEMMdIw0EYXoBQRR7cZYLLKyCnOc6iPfP+uwEtIUuF/3ZxvEhsB+7It1u
         /GIgSXTRRwTSQE22G9bJodzVaDGfvDv0XvTYdskdMvjv57pcUsKimSl1oFKlGb+/rNp3
         ewBg==
X-Forwarded-Encrypted: i=1; AJvYcCXQRw4abxHSr3N9M+jPx+Tui8WBWvcbFBqt+ZwLapacw13WbewDkZRcZQU72sMYJ+CrvJcUd1MhoNfdKls=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvnVnw1QNMtljKAAdiJt2bmx5lqX3Frtxpic403UdGHk+7xhMp
	QnYUIsft80RJY0y/bmkiEbtm0S9H0KARMh7DmYuUL10yKYXUKkNzZwRdcn1C80Y=
X-Gm-Gg: ASbGncszZ5qmiIuL9Y49LnHc/3n//g+1zzQatip4hpJzIi1UmZ8hP2EoTwlhgbx2Krv
	B8LckSkeLXHmbvXJMRlW8dulVHoEsCklqqwBD8XpH5GPjZRukJLp7494I6iMKw5oM3GS/wND0jN
	Y31W/3+alqEbTwuwe6Y2nkT1B8OReft9zJxeBAY3QQV8Wm9o9Uh4QEFmemM+CbvAYEuRZ670c2P
	SSAvTUJiFQYoUpQ8IAZHeA2mbpYELFxvVGVJeJ2pLtJbkLOyia3Ie0D1p6jCnvbbUgOo0tky0le
	0NcF3zTQec6+u9wI0WL+
X-Google-Smtp-Source: AGHT+IFh9Z5T9/NZ6mle03lBLTwxdm39QVeknchTQU0+AZJXPlmONlIdxst1Xno5kyJLM8pO7oAAVQ==
X-Received: by 2002:a17:907:7842:b0:ab7:63fa:e48f with SMTP id a640c23a62f3a-abb70bcb84emr885152766b.26.1739799095507;
        Mon, 17 Feb 2025 05:31:35 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-abb9751553fsm241554166b.86.2025.02.17.05.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 05:31:35 -0800 (PST)
Date: Mon, 17 Feb 2025 16:31:31 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ravi Kumar kairi <kumarkairiravi@gmail.com>
Cc: dpenkler@gmail.com, gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	kuba@kernel.org, rmk+kernel@armlinux.org.uk
Subject: Re: [PATCH v3 2/4] [PATCH V2 2/4] staging:gpib:agilent_82350b:
 Removed commented out code
Message-ID: <629f57dc-d6c7-48ca-8b05-f1d0169eb454@stanley.mountain>
References: <20250217103046.54294-1-kumarkairiravi@gmail.com>
 <20250217103046.54294-3-kumarkairiravi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217103046.54294-3-kumarkairiravi@gmail.com>

On Mon, Feb 17, 2025 at 04:00:36PM +0530, Ravi Kumar kairi wrote:
> From: Ravi Kumar Kairi <kumarkairiravi@gmail.com>
> 
> Removed commented out debugging code to make code look cleaner as
> spcified by TODO
> 
> Signed-off-by: Ravi Kumar Kairi <kumarkairiravi@gmail.com>
> ---
>  drivers/staging/gpib/agilent_82350b/agilent_82350b.c | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/drivers/staging/gpib/agilent_82350b/agilent_82350b.c b/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
> index 5a74a22015..7936c7285d 100644
> --- a/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
> +++ b/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
> @@ -176,7 +176,6 @@ static int agilent_82350b_accel_write(gpib_board_t *board, uint8_t *buffer, size
>  
>  	event_status = read_and_clear_event_status(board);
>  
> -	//pr_info("ag_ac_wr: event status 0x%x tms state 0x%lx\n", event_status, tms_priv->state);
>  

Same comments as for v2.

You're not supposed to mix delete comments with delete duplicate blank
lines but at the same time, you can't introduce NEW double blank line
warnings.

regards,
dan carpenter


