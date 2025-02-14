Return-Path: <linux-kernel+bounces-515703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C038DA367E5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 22:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D69F13AEA2A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 21:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506BB1DC9AA;
	Fri, 14 Feb 2025 21:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hbVoXDb1"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44661192D97
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 21:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739570249; cv=none; b=tEyjdg145FVRbhfZzJxz1wqfmkH105O6jQ107g/RJhcMY1e7Aq/X8R6BJU0r7oHYe6CHrzwUDQaPT2DTRhGCXY77sGU1vCmLgvT0HwJ6YAlPpcYeYandUS7NNNMY5ehiNhWv1BJ5oQ+WChukKmYEKMR8EUOJ/YPXpgImv06DijI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739570249; c=relaxed/simple;
	bh=J2jwGq9qpPorpXDenwVkAsbmo0Fz+ziYV4jByJMgWc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fZscK26KM09Jl89diR4a5By8KsoVAYs4Ym6m2RND5gB4vMY10Kh6ueJOkmHX5BuH2900Wf1jjk7YOYsCkOJscvEpUpGXbu4Su3KSfiSJiriinb6SQVToL6hHUgYYeMqRVvGJ0Y7Cwhrxc6eCrdmzmAXpTySSHIRtYzB2jQy1w/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hbVoXDb1; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-220c665ef4cso38613505ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 13:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739570247; x=1740175047; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wRWtn1ykS3Bkkf2XIvb7lfKIw3peefiZqLW6ILRvMlk=;
        b=hbVoXDb1gDyeGuQ+T4mEJaZifgLQU0bEwi42pgsft8IVrb5mXoV56/pL1UhmedFpMh
         XwucjXhBOAo2p8gH5viBqPJpg5RPj7NMXpXrcuRObEBf19KeK7C9IT5hMSerTxslc4+X
         nOutU19/CDnSAnm0IH9Q3m5ZpFtRiBIS1mqg+cpAMXa4NWywea95H71txHuJXtbE3Hk8
         ogu/gDlKe/Xmao2YtvgSBzoIMGrpQRTx+SqFsi8kM27jSDbCc955exzKqrOjcxSW0s+L
         P+f/2jDsyPr6+p2mBKnEgrm09JC8J7r/cfLsqCgVtEy3Kd7O7D0HqJoVJHZM3egiCaZP
         hUuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739570247; x=1740175047;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wRWtn1ykS3Bkkf2XIvb7lfKIw3peefiZqLW6ILRvMlk=;
        b=gcwBJl08etZdMH1ZxYVigQmSdy5JzbsmESjKVhm9J4rGS8vHSn+1vvtmi9CR0uCtv6
         kj2HaEcc8KtoBlGDDXKw+wL3ztQHY1vIQcxpw0Tm3w1BOwPGUu//QhLjs90p/j4V4xd+
         FthvKhMQr8iCqi/sCP8nLlf8qaRbVj8cyaHiJpm4Fm9GlKh2wfvVdZCb1pBGwW9VVPx1
         KU4ln0+a4DtYr00AiADqErwrd293rMHyJWCNtuVad34UHG3MQRqeOu7rbNwJbukGBdzu
         6rv6oF/LO76/2NzCWOZg/t3OJ4OIp9787JSfXLsa7qkwT724NiNPwwbheUsF16RAHo2x
         uKEA==
X-Forwarded-Encrypted: i=1; AJvYcCUXHal9vD5tLjukvJKmlARop5cndZ3sEaEw4FFsyhpbzIbrIlcvLmYc+oEJRithdvzYW2bysc2V2PrVonI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/tLP2chIBAUBLEoUxYpDU7d/4+vsRPd6AVcnzKvVl8bAKKX9j
	Jkl1WNXnQy8+O3yl68nt3n07bDAw99Z+Z3q8eypr0+wijzm6JT7xEqrtEKHs3Q==
X-Gm-Gg: ASbGncs3oq0HkvAcr9TbLSsDDK8/sQd6o6HvlCEjAAGVTsKb1TpAWqKg3a6hHa8zJ+Q
	jvg92rF0wj43PuKU3sjVnroZjMqVvlQ/ti/vdcjtGs18uZm5vuTBsN8P4Y2u4qS0rLRUaHmS2Py
	ZU4GmFnDf64T/wy//OWvGuTOd5cqE3U0mWpOaFFuNDFpghFWqNtLr80jBDF0Cqn0sbpyT+8AfwC
	ekeICvh4D+4ArNnX3vR0gse9NCtS4nzo+BZ5d+k8ziLGm7TzBBhSK0OhBYsK4kA+53/xe0cJxGL
	5hg3I8Lq9kGtUtJYX1Yi0TK7jSJ+YcaQPgpbZmroNNx+ZFTkjFcA2DAk
X-Google-Smtp-Source: AGHT+IFZkKyWI5cbOzU+tAQBXH6DK01VJZJyEtEn7GBkrLBMpC5lv7rkqivWWjlmMr5gTo9wQl2d1g==
X-Received: by 2002:a17:902:cec9:b0:21f:7880:8473 with SMTP id d9443c01a7336-22103efa562mr12942065ad.11.1739570247291;
        Fri, 14 Feb 2025 13:57:27 -0800 (PST)
Received: from google.com (139.11.82.34.bc.googleusercontent.com. [34.82.11.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545d663sm33080155ad.120.2025.02.14.13.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 13:57:26 -0800 (PST)
Date: Fri, 14 Feb 2025 13:57:23 -0800
From: William McVicker <willmcvicker@google.com>
To: =?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>, kernel-team@android.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: tcpm/tcpci_maxim: better interrupt name
Message-ID: <Z6-8Q9oDj04NurJ5@google.com>
References: <20250213-max33359-irq-name-v1-1-1900da7a1e79@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250213-max33359-irq-name-v1-1-1900da7a1e79@linaro.org>

On 02/13/2025, André Draszik wrote:
> This changes the output of /proc/interrupts from the non-descriptive:
>     1-0025
> (or similar) to a more descriptive:
>     1-0025-max33359
> 
> This makes it easier to find the device, in particular if there are
> multiple i2c devices, as one doesn't have to remember (or lookup) where
> it is located.
> 
> Signed-off-by: André Draszik <andre.draszik@linaro.org>
> ---
>  drivers/usb/typec/tcpm/tcpci_maxim_core.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci_maxim_core.c b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
> index fd1b80593367..46fc626589db 100644
> --- a/drivers/usb/typec/tcpm/tcpci_maxim_core.c
> +++ b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
> @@ -420,12 +420,14 @@ static irqreturn_t max_tcpci_isr(int irq, void *dev_id)
>  	return IRQ_WAKE_THREAD;
>  }
>  
> -static int max_tcpci_init_alert(struct max_tcpci_chip *chip, struct i2c_client *client)
> +static int max_tcpci_init_alert(struct max_tcpci_chip *chip,
> +				struct i2c_client *client,
> +				const char *name)
>  {
>  	int ret;
>  
>  	ret = devm_request_threaded_irq(chip->dev, client->irq, max_tcpci_isr, max_tcpci_irq,
> -					(IRQF_TRIGGER_LOW | IRQF_ONESHOT), dev_name(chip->dev),
> +					(IRQF_TRIGGER_LOW | IRQF_ONESHOT), name,
>  					chip);
>  
>  	if (ret < 0)
> @@ -485,6 +487,7 @@ static int max_tcpci_probe(struct i2c_client *client)
>  	int ret;
>  	struct max_tcpci_chip *chip;
>  	u8 power_status;
> +	const char *name;
>  
>  	chip = devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
>  	if (!chip)
> @@ -531,7 +534,11 @@ static int max_tcpci_probe(struct i2c_client *client)
>  
>  	chip->port = tcpci_get_tcpm_port(chip->tcpci);
>  
> -	ret = max_tcpci_init_alert(chip, client);
> +	name = devm_kasprintf(&client->dev, GFP_KERNEL, "%s-%s",
> +			      dev_name(&client->dev), client->name);
> +	if (!name)
> +		return -ENOMEM;
> +	ret = max_tcpci_init_alert(chip, client, name);
>  	if (ret < 0)
>  		return dev_err_probe(&client->dev, ret,
>  				     "IRQ initialization failed\n");

Can you just change the `init_name` instead like this?

  chip->client->dev.init_name = name;

That way calling `dev_name()` will get you this more informative name as well?


Thanks,
Will

