Return-Path: <linux-kernel+bounces-339641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E1198684A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 23:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF1AD1C2191A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 21:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF7B156677;
	Wed, 25 Sep 2024 21:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IYDBYT3Q"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C081CF93
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 21:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727299592; cv=none; b=XnXwL6mUmk/qKpEP3c8888zKbUDEb53CwX2WF6b2QgxR0pywSRKsA2y9+S9vgbsmFpYWKVJeO/7KSaknDTkRSkwXZ7oBwSiKZYQgHnmPBJD6V+L+RPeFFQKtgB90Nxfr3TgwfZXwGCyg7ErvNZ4L/aSIIH1by6M3vH9QWAZIA8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727299592; c=relaxed/simple;
	bh=zaF/Dm1tDIioJLLUoaqqYW8eTsn35uabr/Gky5vZDuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oLyzpwhlPcpAEJ+1AX+kZSRdS5oxzdQsZBx4/4Pk6M9sji/a9REPEuLGx4qjbWffeo/hiK/v+mayUiNTlCMhfQ8XMHD6GMEomOXdoJjOLydIMFYXxnARCOObkUS03KySNjYihx3U4uV3ILAYd8r7TQM4f/KW8Sjga7kSD1WcF9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IYDBYT3Q; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2f75c0b78fbso3185191fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 14:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727299589; x=1727904389; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TOYkNpvty++FfWXgNtcgpq0qmRgQhoDIUQ1gLZ+9OCs=;
        b=IYDBYT3QZccc47c255acGbPbeCeA+UsAO4OW/go653zzSD55oGeNex13I0DxH0uDfM
         W2tvCFIbrJJBP67oW2g32v0uXJCO83eazpjL0ki6HK8Mt5ZjhECjtRS5o8/aPgT2rYet
         um6fiquUnnVUQEyyy5/GQe62VYRoaD6PI3pJwLih+CsbLacVzGr5nxyGY89di9q3Aw5C
         pD2zMHDSBZJ2SiYhBxjOmfTQTMUYCO4G6GoQd8gG05+iuGT7VdhAVX1xwP6JVsC03Bh5
         squw75JwzPOSJszDX1WqAcg5AmLCm56Rt93pXxSFJzwogwkvScDQZqdYGy/3nfFdsguX
         2tfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727299589; x=1727904389;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TOYkNpvty++FfWXgNtcgpq0qmRgQhoDIUQ1gLZ+9OCs=;
        b=TAR+PxobWCk3K2UanpxMPVEnCbahwI+cFrZFMoupubrJAPBYHed/JbyM41dCpC270w
         FRWvse+OQNfsuBR6bTrtXhktvhDgTdXFU3JBwRBmN5Wdt3gNIIlXpsCwIRqupVVqbVHc
         cJ0kCk2ZP4lvOV3vZa1YKOrskOwKvcqmm4BTxtFqAYtqsAhhesx9CginDDyYy3jAx3hQ
         c6uOadHuN62Y072QtIzRqx488+jferOGCWZjpvJYDHNz1TPvxwOxhxnLYN2KWerST+C5
         dTOh3iWhluBZQnQy1hgiGoXSuH7XijxGRNVeR4/0MOFYJES681CWVoDb/aYw+jQEPM80
         02Qw==
X-Forwarded-Encrypted: i=1; AJvYcCUbNXc1iqPbBfuDLqkmynk8DobsB8uMO+DxkrYVfvYi99X7sKxDrZFG9h9OIYpj9onFTPDgWTvIvRN0SFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHAaSpDqNKpYuM8fxBT/oj5JazNucIb0G9LhhBWUA3JYk2hgf0
	ySyyRUIXI7mmxpBeyZWQmEdJw74awCK4e5i69Cya3aBYdPdpv2tfk8kQB7rN5IE=
X-Google-Smtp-Source: AGHT+IEmV7veckkGCnJaS53c+RIOeWgYMFU3i3KFTcPwIhFLJpfjINi6uUsM/Jg8x2BKOpYRIDVosw==
X-Received: by 2002:a05:651c:50f:b0:2f7:939f:a47f with SMTP id 38308e7fff4ca-2f915fdbbe0mr29744371fa.11.1727299588616;
        Wed, 25 Sep 2024 14:26:28 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f8d289b61fsm6086821fa.111.2024.09.25.14.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 14:26:27 -0700 (PDT)
Date: Thu, 26 Sep 2024 00:26:24 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-usb@vger.kernel.org, Ajay Gupta <ajayg@nvidia.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Haotien Hsu <haotienh@nvidia.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Utkarsh Patel <utkarsh.h.patel@intel.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Wolfram Sang <wsa@the-dreams.de>, LKML <linux-kernel@vger.kernel.org>, 
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 0/2] usb: typec: ucsi: ccg: Adjustments for common code
 in two functions
Message-ID: <jjsbnitbajdw7dc4plkbb55ezl2cdbnrfws7hnoigbzasvdzua@puhrwwlu4lvv>
References: <b890361e-e99b-43da-8571-7478b5eab475@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b890361e-e99b-43da-8571-7478b5eab475@web.de>

On Wed, Sep 25, 2024 at 07:31:04PM GMT, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 25 Sep 2024 19:19:01 +0200
> 
> A few update suggestions were taken into account
> from static source code analysis.
> 
> Markus Elfring (2):
>   Use common code in ccg_write()
>   Use common code in ccg_read()
> 
>  drivers/usb/typec/ucsi/ucsi_ccg.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)

For the series:

Acked-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

