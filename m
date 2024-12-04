Return-Path: <linux-kernel+bounces-430821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 283E59E3607
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 09:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E17402809DE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 08:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91E61993B5;
	Wed,  4 Dec 2024 08:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZ//tndJ"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A225E19B3E2;
	Wed,  4 Dec 2024 08:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733302629; cv=none; b=PG503KlkswuOggevjSRKdc5KoSizDpqPPjQsxkxUigDs5aC5UDsUdqAp5pnTAy+64sdf22pGeAaiidhOPCTpA5LOiETjLSRCjB46bl1hanT32+UylsiW3wSShg2Suu+j29bdHC2q4VaKgeZtanhguCSiEqeLoXIyqhdVyA/FrEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733302629; c=relaxed/simple;
	bh=IeS4svvVbIrLuRNreRNNFzeNlm5fylbPJIcGtNpzboM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sTpH+/ZwAFOChbsI5IU6/FVnN3ItKsGt/ELAlZBUYD6Yn6Jo5GPcEXbtCy0HapfRi42qh29+i+Waj7lBdVC0YylC26rbb20BNNO89eYcJkuRlBE3DrnTM8KhYtdMETh1VveXc01i3HzpvVJJrboB7UfHwhbVHXPMRaFsZz1OTnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TZ//tndJ; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d0c098c870so1167996a12.1;
        Wed, 04 Dec 2024 00:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733302626; x=1733907426; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2uhf/Mp1weWGVcNh7Y0kSv4T/66WH/BLXsUva96a+IM=;
        b=TZ//tndJnulymaYSXH+5ydMOnsyc2Ca6RyfScsyr9ANR/8NXgbiEXvWc8Ej3f88yX0
         JiIMqggb90y/yi1th3hQDDGwjqKW3NiL0FY2LkqCj1aDXRWYVcvYfbz6e3NfUGjUjibg
         se+5F6he3gZuJlSdyb2yAjXsoqx1Qd+pxB/BTm+teQ6o7v+QL+uIZlCsW2Ml/Q6ZpDOd
         jNSyvfiSTIdogyLxijBPXpbmNGVNelipnMFHTVqqftuZ1sQtsFg5hKe7VvpqM5mM4rWb
         4l3GctyLMeQGmAzQxWuX7HM5KYa2WKWs0pbBFOxWQTU6RZHkQzmZWve+AEXrjKoU7hIv
         91Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733302626; x=1733907426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2uhf/Mp1weWGVcNh7Y0kSv4T/66WH/BLXsUva96a+IM=;
        b=e1eUFMmlcnG87THqPji1jIijVoFfvYwFicQH4wQDk8xflTdD2TZllviLSa0r9CV4xM
         7lrmUGXKTx5WvXZTsiey3U+0veGubbZBW+LZ6bYBRjVPeMSjR9LuQ4wBNQ+9908aAjuL
         1Vp2MaV/c8niIdyustw7m8xk14ypqBdJbSU3R1/BW5zp+UV/YrQjdYEPBdC7DmwbW6HJ
         hhONODP3PkQ6CtDXmOD9bSH2DLZ7/5EqCfjfMxEA5FSOVh7C0rrwm9MmK1onSPv6XsQ6
         vEdFhwZCUnPmwKRyNZYwBrq69H3D1do8rXBrBghcBuZS8EsmB1hYZKAed6GxonFWygxV
         YKdQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+DXo7Ma+dlYsahynjCktqtMGIR00RN8mE34y2V6ybssGF01MlWWyimnwLJ5Ahu1h0Y3qWsCZC4qt86A==@vger.kernel.org, AJvYcCV9rTKB/qOXoXjcmCHbQOtq/ajb59jGhDUqaUUl7NxMYm+vFG69BuQW2RKJs8jY6e5kfnlwVC0Tv5VcFLV5@vger.kernel.org
X-Gm-Message-State: AOJu0YxeWOTQvQtzedgIfdYsanCIaXGfHYiINYGsHTaGBlqNcNhZGTmn
	pxT6ZSOPKnXHOl92ibILgedjBGBI/JJFSOm+HHF3j6Q+sXX1YN1k
X-Gm-Gg: ASbGncuiCLrcG6owluuip9O63ubZqYWxqYmwtyu5qwfQiiH9OgmqnpisybceF+tI7nG
	/uK+BYyG64OVuHCToDG2yWlESImu2a1y06pbZeQQ62aTj34yRL1R3ivc/aazVJNIJCNbZogtsCP
	vviFUhSbY43KeMgmjSEvKZyR/7ZfMfFo0SU1uMRhIoxC8chlhNBzSHI7VnUJNYNaQJLf9p3b4TQ
	lLPdTIwqqrc3ucB6UGWk5jDFDL5ApZKkedFiCzknKcZdy6Uae8jNd9gJMSxJ5nYkiISXLAGggu0
	r8bqLJ5uu7jIOg==
X-Google-Smtp-Source: AGHT+IEzlyC7AyDDcJakOVEneYMGdD6hVrvM9Rg0DFY8VPrvgLz2XjFjf1f/cJHs4ZBrunaALPL4xw==
X-Received: by 2002:a05:6402:210d:b0:5d0:cfd0:8816 with SMTP id 4fb4d7f45d1cf-5d0cfd08a60mr16119477a12.12.1733302625712;
        Wed, 04 Dec 2024 00:57:05 -0800 (PST)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d097dd685csm6995348a12.44.2024.12.04.00.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 00:57:05 -0800 (PST)
Date: Wed, 4 Dec 2024 09:57:03 +0100
From: Stanislav Jakubek <stano.jakubek@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH] hwmon: (tmp108) Add basic regulator support
Message-ID: <Z1AZXzw5XnsapWT5@standask-GA-A55M-S2HP>
References: <Z0WJg5MMu_1AFYog@standask-GA-A55M-S2HP>
 <fcf06424-c014-4e87-9ac5-ced1ea679fdd@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcf06424-c014-4e87-9ac5-ced1ea679fdd@roeck-us.net>

On Sat, Nov 30, 2024 at 09:58:17AM -0800, Guenter Roeck wrote:
> On 11/26/24 00:40, Stanislav Jakubek wrote:
> > TMP108/P3T1085 are powered by the V+/VCC regulator, add support for it.
> > 
> > Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
> > ---
> >   drivers/hwmon/tmp108.c | 5 +++++
> >   1 file changed, 5 insertions(+)
> > 
> > diff --git a/drivers/hwmon/tmp108.c b/drivers/hwmon/tmp108.c
> > index 1f36af2cd2d9..85e4466259a3 100644
> > --- a/drivers/hwmon/tmp108.c
> > +++ b/drivers/hwmon/tmp108.c
> > @@ -17,6 +17,7 @@
> >   #include <linux/init.h>
> >   #include <linux/jiffies.h>
> >   #include <linux/regmap.h>
> > +#include <linux/regulator/consumer.h>
> >   #include <linux/slab.h>
> >   #define	DRIVER_NAME "tmp108"
> > @@ -331,6 +332,10 @@ static int tmp108_common_probe(struct device *dev, struct regmap *regmap, char *
> >   	u32 config;
> >   	int err;
> > +	err = devm_regulator_get_enable(dev, "vcc");
> > +	if (err)
> > +		return dev_err_probe(dev, err, "Failed to enable regulator\n");
> > +
> 
> Problem with this is that existing devicetree bindings do not provide
> a reference to the regulator. Those would now fail to instantiate,
> which would be unacceptable. I think you'll need something like

Doesn't devm_regulator_get_enable fallback to a dummy regulator when
a reference to the regulator isn't provided?

lm90 does it this way too.

Regards,
Stanislav

> 
> 	err = devm_regulator_get_enable_optional(dev, "vcc");
> 	if (err && err != -ENODEV)
> 		return dev_err_probe(dev, err, "Failed to enable regulator\n");
> 
> Even though the regulator is now mandatory, existing devicetree bindings
> don't know that.
> 
> Guenter
> 

