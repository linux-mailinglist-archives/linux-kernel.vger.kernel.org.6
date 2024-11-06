Return-Path: <linux-kernel+bounces-398038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2AD69BE495
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 11:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00CD31C2335D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 10:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC211DE2C6;
	Wed,  6 Nov 2024 10:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JHTKE9tx"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF441DB92C
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 10:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730890007; cv=none; b=EXloESgw8uNkcv6GXgw9upDcWs55KPeGuaDqsGviTCbQnd2rJ7RCpgd5HlhccZgcdm1fXbCsdG/j6KOhQIWWDTiHYV3gD17Uirn/sNtMzmugcCKA8gAHd7IRuZ2tVVb9+DbYO6/btmL6pq7Ji0QiA50R2Dydz3EaUXZxfuNjxmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730890007; c=relaxed/simple;
	bh=XbiIK6GjOS/yZ5j6g6CoF1rq3kPr/i/tae+WR3Cy8es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u6qQIkiLg02dFcqAKPm6GnFoQ8AnybssvsJvOhkV0tNgaIWTL7gcouJVQrAmzK3xNhMk+CS25yOKsG1feJMeG45nugjJ+gOvEE1DCAZ6uKFpy/PztppLalXULDQpuPPYQJ/nGKV5KdXqr1GNL7rER2O9aAeBAnDbCzrDmE7UXBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JHTKE9tx; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9a628b68a7so998829166b.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 02:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730890003; x=1731494803; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jnvfOfDupOxyZMEu8q+2hpeE5bOttK1dIHZM5bV1S7U=;
        b=JHTKE9txH2p0/9srsdDkdLbJF0RfdhDFEfl8NIEEP7b6/LnP4f4jhBvG6XzPWlAymd
         9iqZqVpuXwvt5A5JNoWhZ1btZ6gOEQ5wAcef2qJDw3lc2+sGiPZ982hs5I6gbIqqCBVx
         kzW0K/gFJZzzpyQWnKwDEJgoAo6hOAvHRg9BV+l7oAEfcfQmqhxGM3hDFMyIxsdATV/z
         VaWqbGlw3dFBQMY3HPXxT1PL1YKOrUq/VYMziyGenqoqMlAFsWMa5Rlcv6CoavzEacO4
         +sdZDkuzjiUS1zcNCKx8iWTY6r+2ClPgZqIW8ZnOvKZC/CB8kWFZZFxgjbHBVyuZHIxn
         Om5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730890003; x=1731494803;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jnvfOfDupOxyZMEu8q+2hpeE5bOttK1dIHZM5bV1S7U=;
        b=WJyUm1YfjOH5UjJFHw51CJoD0DxwVYCnkpp2CgHVG3QfMk17xq462+G1SmbQAGJZ/W
         RZzsjoUsN+vXPSOM4Qz1YQn/pfoeUGiK7op73iCd4XS93YHBHZcYsl1RvlWpH6lsziEd
         XaD7eRYPVi0phpmBOkhhPHR9ExEvJLHPL05YhOhDNlbf5/oDjog/geNiYMw2KpieUsyJ
         L2Q4R54GpPim8hxwunKnixvgFsoeFu2NM8Fl7giH/XiFXHY9TVtlLomONlYnOyLJ0QNl
         4cmFg/NABFAyjgML30k+DcRmk7XY+IgkidyArGnN93xsuH/dnv88w8e6tEgPWtoi15MQ
         7t2w==
X-Forwarded-Encrypted: i=1; AJvYcCWH1VNMFfMqqEfWoI6jBN0P2lGd2P///3pfhwwQY7OhOpgEkDv93lkKfPYNPhswZREyFFxHRZymvsAbJBo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2eOwD51FMoeOYSWYQfwHmDsxO5aGUO0RHKRs3avIPYqWwQ+bs
	jAujwJH08VP3NtXQ0xLNO2u6Wm3D8gC4Ahq2uliNDvH2XMrQirV8RI8wJP9TwcA=
X-Google-Smtp-Source: AGHT+IFLqfCVbNW7IItqNBM12Hvln8l60e4gy4+M/K4utCO4TZx6BCGSX7in4grJXnBtZUzFTWezNA==
X-Received: by 2002:a17:907:3ea3:b0:a99:d797:c132 with SMTP id a640c23a62f3a-a9e654cdcedmr2089540966b.16.1730890003621;
        Wed, 06 Nov 2024 02:46:43 -0800 (PST)
Received: from localhost ([154.14.63.34])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb17fa445sm259358966b.169.2024.11.06.02.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 02:46:43 -0800 (PST)
Date: Wed, 6 Nov 2024 13:46:41 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Qiu-ji Chen <chenqiuji666@gmail.com>
Cc: dtwlin@gmail.com, johan@kernel.org, elder@kernel.org,
	gregkh@linuxfoundation.org, greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com
Subject: Re: [PATCH v2] greybus/uart: Fix atomicity violation in
 get_serial_info()
Message-ID: <35c0f989-4618-46cd-9427-61f2a37269c0@suswa.mountain>
References: <20241106095819.15194-1-chenqiuji666@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106095819.15194-1-chenqiuji666@gmail.com>

On Wed, Nov 06, 2024 at 05:58:19PM +0800, Qiu-ji Chen wrote:
> Our static checker found a bug where set_serial_info() uses a mutex, but 
> get_serial_info() does not. Fortunately, the impact of this is relatively 
> minor. It doesn't cause a crash or any other serious issues. However, if a 
> race condition occurs between set_serial_info() and get_serial_info(), 
> there is a chance that the data returned by get_serial_info() will be 
> meaningless.
> 
> Signed-off-by: Qiu-ji Chen <chenqiuji666@gmail.com>
> Fixes: 0aad5ad563c8 ("greybus/uart: switch to ->[sg]et_serial()")
> ---

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


