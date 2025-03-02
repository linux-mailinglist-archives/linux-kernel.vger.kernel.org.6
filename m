Return-Path: <linux-kernel+bounces-540670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CE0A4B38F
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 17:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB9D47A6F7E
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 16:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1211EB191;
	Sun,  2 Mar 2025 16:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUTTh4e8"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A112111AD;
	Sun,  2 Mar 2025 16:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740934468; cv=none; b=mAdNXfQuvk2kM3cA/3BzUgXNoWWYypOTaT3uD6EXkL78bcUbAPHK4bgnBJOFra7sOu466FzXURe1PWvsUskXQCEVRSAGW/ePgfSa6EZGKXmoQ9gm1lHqTRXUKfDyVfwfYko9R7g9SOR+TL3Jwd7K6kFY59INvlEdu3b72j4sqpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740934468; c=relaxed/simple;
	bh=2sEkFRy20kwTMTzZHswCvXeBdPUCwpLecoV93xMRqSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WuMdUF9A1G3P4JqyL7Xb58WJXr87AhJ5CtZUFtRpNQqEBJoeuc0XAHAk8rYgxHypJUeDS2L0Fi2YY7tN2EiQqhOGZ6ZizSZzIZNEH20bU1bxWTzsX1NIngCmaO2syQeS5yC1n6drofMZmBOhi5np9M0a8YLlHHEEtaH+vtuz1D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HUTTh4e8; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22385253e2bso26832415ad.1;
        Sun, 02 Mar 2025 08:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740934466; x=1741539266; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MxZY24dAQ53eQXmEalW2+FomGGOx0qMKAfEWi8eXumo=;
        b=HUTTh4e8FEdGZ9UC+7WKIBPgPN40bRmwZjrJEizTgP1eewG2LBiIeAEX4ACZShZcMX
         i2NZT/fZ/MwAuEI+8XAgIuc46h1xWmoWtLj5Avwq69xegy99rdUwwYasD/+rs/qkvW1Y
         j6Rp52u53vuTnNdQY1o/MSTLqh54csas9oD2FgfQ5TCbl372SFxRslzWUWQChT/lSVeH
         f3vbRl1VSsNhddWBeijoB1bFP2j0/kmvKavozX54iF2p1Gk7flJQBbZTBe7QSvcR6z2j
         cvSTpNaGRS8xkBZ+PXAcZRUTxnELJGAHeNkrPRVModHO9bBPsw1F6tQbHAy8qYI6RRfD
         8WFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740934466; x=1741539266;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MxZY24dAQ53eQXmEalW2+FomGGOx0qMKAfEWi8eXumo=;
        b=GE986+fpWkc3vL81psJ5yUH4rNVG5ouj1UwQIZTYz4w6V11i7FdVhmWC7RsMwjLzw2
         z7MjOBgs75tWuTZXgdf+SI41u22UzTS1JGtWcYle1a0MH7AYU54yudkfNh+JU+x75VHS
         OQbT+RDgYAYWjcD2omtIVy6EFxpuMJdQYhBYNR80IHyLS4v3JXMK4qC6BnUbrdfLPkqh
         v5HsqBzw1CQl0iv91JL52Nu/2fwuBhaOBd7BQtj3Lbt0OB47okqNdT1ZENNk9JMN6ETX
         CFYqK18jaZG4o7WbaV3NAaccWJ8L4NquCTB377YbzeLkgPNPaWUwLBm+dloMu7APw/mS
         /ncg==
X-Forwarded-Encrypted: i=1; AJvYcCU6AlZMBODEDcb9amFnXaDNFULqzIWHcNiUcdOviw/amj7N4ov10HFHqsAmasU20eMqj+wIpHfScuFXimeP@vger.kernel.org, AJvYcCU7pZdySLYg3qf04T7fM0209cgkEyHZD3nXw5kUaDfb2P+nHRtqLBX7laM3Ynh3vYndT3UtA0DGX659@vger.kernel.org, AJvYcCWeFMEEntXrM3Np3DQXBcqyUcRFR0xsLpRjtHGs12dJE5QebK90B3reKeR3Y9QJhjW56v88G8QXlCklRsM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmzHpxQTReEg5nA2tqHuNx3sdyDAsi6daJ3WBInBhYzubdNmQX
	uhuGcjeeH8vfPC0z2tUBkWh7t/u3/ROQVogOUe3wzWP7YUNC7DRj
X-Gm-Gg: ASbGncuWCX4fpclFhey/pfIUiUqJfM6SHh6h9AqRrQUD1Px6ztFztif+E67m6zoOKpr
	hj3ZV7qz/RSrdiFHl3SYro+6lR3Gu4X4Xk/XgL7HbB9DXh906MMeZIJ4IpfzuHSgb9tsqEfcoRi
	/wgBvrdmn/8o4o876fz1ztAF5gSOy5kfJgr3uTucQU86JfI8Z4FX6V6daXwM3CRH/Pe9RAmxk9Y
	a6i541NIZENmKrT2FdG5+K6pVRlkC/KVzmmvz7Rh1U+U90QAHdi96E6pgP9SiV8scVJLSgdArX0
	LFGVCnR2UuJoLl5NZzgLqCfD5l4zCzXq+ZoCqTsYHqIH9cGaBPtQ8aOTHQ==
X-Google-Smtp-Source: AGHT+IGwwzyPQ3zkuQ1JhSrQirDpapES/n0lb4nQumNRj1kESwZNphy/T6uym4uZbvCxYp8VKiE6tA==
X-Received: by 2002:a05:6a00:a1e:b0:730:8ed8:6cd0 with SMTP id d2e1a72fcca58-734ac42ed49mr16602550b3a.16.1740934466442;
        Sun, 02 Mar 2025 08:54:26 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73642c73e0esm1655938b3a.109.2025.03.02.08.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 08:54:26 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 2 Mar 2025 08:54:25 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] hwmon: (gpio-fan) Ensure lock is held during
 set_fan_speed()
Message-ID: <98226c50-6f36-40f5-97b8-3ade0dd9ff3c@roeck-us.net>
References: <20250210145934.761280-1-alexander.stein@ew.tq-group.com>
 <20250210145934.761280-4-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210145934.761280-4-alexander.stein@ew.tq-group.com>

On Mon, Feb 10, 2025 at 03:59:31PM +0100, Alexander Stein wrote:
> Instead of just documenting by comment, ensure locking per code.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>  drivers/hwmon/gpio-fan.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/gpio-fan.c b/drivers/hwmon/gpio-fan.c
> index b779240328d59..322b161d5ca1f 100644
> --- a/drivers/hwmon/gpio-fan.c
> +++ b/drivers/hwmon/gpio-fan.c
> @@ -124,9 +124,10 @@ static int __get_fan_ctrl(struct gpio_fan_data *fan_data)
>  	return ctrl_val;
>  }
>  
> -/* Must be called with fan_data->lock held, except during initialization. */
>  static void set_fan_speed(struct gpio_fan_data *fan_data, int speed_index)
>  {
> +	WARN_ON_ONCE(!mutex_is_locked(&fan_data->lock));
> +

No, this just increases code size for no good reason. The comment is
perfectly fine and sufficient.

Guenter

