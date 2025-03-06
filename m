Return-Path: <linux-kernel+bounces-549852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF649A557DB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 21:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E8E73A94D2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 20:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748B4278176;
	Thu,  6 Mar 2025 20:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ARWiD5T8"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43114206F22;
	Thu,  6 Mar 2025 20:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741294362; cv=none; b=QmO5udNQIXcSzbWh26PhnHrTAUD0qmNiEey5DlA0/jYMsl/5g6Ij6dmnE2AwITUAiK3L1gPsMJHp8AVhMBzZifaz6T6POlzALABubxCgaRQ77WauDineBg3Np2HnakkEwCqNmy3/Hp2csr7AoTSSt+ELZ1c4RyVQ3Iqy4Qv3KmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741294362; c=relaxed/simple;
	bh=Vpgja83UWIooWwf5d/uXLN1ObBMMF7cL8N2H1Pdp6Rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B3qy8fianf8pdq4zO75LF1eqeTXX5XI4Xktw9yNfaPXeCJZPZ8MBiTR/8iCgTPe1kHeDk9uIgNJTLzBpw4z4s3ypn0yhb4rW7Uskgcr3hjs5f0yRArP4wsA6c9cYjbt1QoUDK+7wV8OR9Vg0lziOYbWEgm6s1XV0qr5q/ySsA9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ARWiD5T8; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-224100e9a5cso21194565ad.2;
        Thu, 06 Mar 2025 12:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741294360; x=1741899160; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h1n+UrcgoUd5hYtpdy/TFcL+T0ndMAIrf0jvm8PKQVM=;
        b=ARWiD5T8u+J7oGPuaspOR0kGYDC8D1wMCycKJrWB8+T7IkcrrubFXVVKL5rqhdwRUf
         JJWltn0pxCjMJd71fMWomELn/s9vhjAo5r/nSDZPr1Hsuif1s9vlLnxF0fEqW6OYe5kl
         6PfTExevg8VGR3eBrpem1AYsf5zEXbpinIYeD4Xp2kq3BZRRrwidRH9phZzNSn5b6zjI
         L36opcbaf07Xv4d3CuuGZFVsuVCMEXrj5S8YOYTnfYyvi1HOcvHiekUAcE8UdLO1bkBr
         /3Wt59+u3shByLqom/Zrhoubi2Jz02D8bYTemgi7MT7PM/EjY/kWVks1Ltc6PFRiLwht
         GSEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741294360; x=1741899160;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h1n+UrcgoUd5hYtpdy/TFcL+T0ndMAIrf0jvm8PKQVM=;
        b=E9HFDXOfktafqhg4y3DjeiJ2323PfStJBryKgM8c/+qkBgfxiFPzSlNZbyyDcq7Ebl
         0XBYml8P1W6vCMHPbuigwvDp5Qv+U+xxsc4Tr9BBE0GcLHlfyxI4Yp+TozTtncnN1G2L
         wyjWhEbI/5NWETLw5uSKKN9QH9wVqpNBcB8LXpIWDVQbD5i22xl8KheM0slbuXZc2IDp
         4xD26yW2MAm0ov3Ppj8YMD/FGArsAmaeZ88fTVfUe4Zf/8EmnuKkoAhtYsxxQxtvQumW
         6IeTxgamYAnouYwdoUr8MMMbTTc/iQGyTKQ5+j47YpdSGQYFIi+Wm6SQpQydVO01Ooar
         YzhA==
X-Forwarded-Encrypted: i=1; AJvYcCUUuJ2zr7RdBDRR+ZtopA7CZnDKBUeWUSEHbHPkLIr5gnzQjzcjIu0gGRoHnJcynFRbEe2Q+HfakZVEDg==@vger.kernel.org, AJvYcCWf59foXiCw8FV7AbvE/iapnZSpTowG26uvziFClyD5lmTRwhI0LXoJoakzHRHTWc3Yw//DxN5BMeSyBX1W@vger.kernel.org
X-Gm-Message-State: AOJu0YyjYf1bWyZwtMo38xq3vsunMBTwXS+BvQUdf08989dgVPtLIi9e
	7h3RASBqSByppTxC50yKBMcp+Y6fpzBUh1LFnywgtVyEifXAJyWm
X-Gm-Gg: ASbGnctjUbA69ksqWFYHo9pq4LpJ+d6OZ0bkh/LQieVor7XpMqAZDyB/FqykM164a5w
	j+vwG5JkA2Zj1Bg/P2qfb+Arda1963oqJ6KL5Vcwg9m74u7fMXBxTNOH0ic6jr8WTkvjEeV60JD
	+6FC32a3Hj3p5putncg5mVdSaB3Qb4vhypPJSnvWkzNovmiKUIjmCVMTWepukzcFwiFyY/J+zSE
	fqT8sLp+1Yvd1vPfPq14LVu6zxsGlCehWXYNdvXykQv/EWSYytM6Qj+hnq0Jo/uo+BG7HAvGM0s
	1o1R6kO1SJUhETeMdDhdrOYHAXDdnXmrVLXhbqjnEzTwcIlIb1PSgZuv5g==
X-Google-Smtp-Source: AGHT+IHDEryGxttSc+6BeIDWTCRsfdbv5GWoOF/4vJ5VRpRfu7ECcxxco6yeDF5ETdxYetmT7KUlOA==
X-Received: by 2002:a17:903:1c1:b0:224:1001:6787 with SMTP id d9443c01a7336-2242888665fmr10048495ad.4.1741294360300;
        Thu, 06 Mar 2025 12:52:40 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a7fa24sm16898275ad.108.2025.03.06.12.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 12:52:39 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 6 Mar 2025 12:52:38 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Maud Spierings | GOcontroll <maudspierings@gocontroll.com>
Cc: Jean Delvare <jdelvare@suse.com>,
	"linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] hwmon: (ntc_thermistor) return error instead of clipping
 on OOB
Message-ID: <51fd276d-b20a-4791-ac05-c423025855c0@roeck-us.net>
References: <20250304-ntc_oob-v1-1-600d8992478d@gocontroll.com>
 <184d5217-149f-4f6a-b4a6-f897a8391873@roeck-us.net>
 <PA4PR04MB763051DCED9E30B9640BCDD0C5C82@PA4PR04MB7630.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PA4PR04MB763051DCED9E30B9640BCDD0C5C82@PA4PR04MB7630.eurprd04.prod.outlook.com>

On Thu, Mar 06, 2025 at 01:35:53PM +0000, Maud Spierings | GOcontroll wrote:
> >
> >Most of the above should be after "---" since it is irrelevant for the commit log.
> 
> I believe my cover letter seperated it correctly after my signed-off-by
> tag.
> 
Yes, you are correct. I missed the second (or, rather, first) "---"
above. Sorry for the noise.

> >> +     /*
> >> +      * theoretically data->comp[0].ohm can be greater than INT_MAX as it is an
> >> +      * unsigned integer, but it doesn't make any sense for it to be so as the
> >> +      * maximum return value of this function is INT_MAX, so it will never be
> >> +      * able to properly calculate that temperature.
> >> +      */
> >>        if (n > INT_MAX)
> >>                n = INT_MAX;
> >
> >I am not a friend of theoretic code or comments like this. Please drop.
> >The original code was intended to catch out-of-bounds values which would
> >otherwise have been reported as error, not to catch unrealistic resistor
> >values in the compensation tables.
> 
> So, drop the check and comment? Or just drop the comment? I was thinking
> to fully remove that check in an earlier comment in my cover letter.

Drop both.

Thanks,
Guenter

