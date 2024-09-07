Return-Path: <linux-kernel+bounces-319890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D38E970375
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 19:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF2E5282C25
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 17:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E6F165EF2;
	Sat,  7 Sep 2024 17:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="c5vdIAt2"
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4861494B2
	for <linux-kernel@vger.kernel.org>; Sat,  7 Sep 2024 17:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725731932; cv=none; b=n+LznjzvIkfD1fKALBw2ZALpvo858AuLzIXMltxOUXs7bl6kYghr2h6+TLJ75/0UEY3MpcZyYpdExCiydfTGVCkU2gks/befrlxopgc0thIoquZuDV2ENPIHnHoSBAkE9fwk0OkvDjbjKw2cuQZy+SzerloeII/Ncu4VXRdFob8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725731932; c=relaxed/simple;
	bh=izSGh+6sy5PNRnbFdyM+VIV0EKPdNFOSdmi1QXPxe6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BqcVTIpFq7aUkmahrBXn6DH7WwOesJO/vR6YuRgxdiOYOYsmRejlh9MYUr8dDSxILCNjxaj03G+T+sKfk+fc1muEYOtQp93UkoWW7NWlIMna6n9sHT2nt8Z59V7Aq1n4t3QeIH9vns5+0jw5RxMfh5ulVWr0VUR1c4liWCgY/wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=c5vdIAt2; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-502af8a83daso496024e0c.1
        for <linux-kernel@vger.kernel.org>; Sat, 07 Sep 2024 10:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725731930; x=1726336730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UMtEkjEA6+MsIvWkID1mCodPN+qU9ekogIWwGSM8gSI=;
        b=c5vdIAt2LumkPNi44WHHEEhYJXcQDbKqENnTEk8fJJyhV7Dr7TDIVqsKfR22XwT0xK
         tcazANCEbHAKfI23anhA/nLVprLGcQ6Q3VTMqmRScgUQatSWhEYGyGKNmqhjJg8+Q4xY
         LYPTtHP9oLmUPUm5stPic38WIKnPKGAfmS6CX6eu03LLtTdHGIz6424ApNGlL4B4XkJm
         6Z8wh0hz9gdbHMYZjIHEN26bjQe5D11sGMNcYxrsCbHPDoSbxAoh8jn2Gi2xXqYyuGoz
         LJbLwVrjzKfWnyHPE7Z+TTXi7N7oQwWGJk7fX6JdFN6dTiPTHpEFZL+mizAFr9+Zoxxs
         N4eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725731930; x=1726336730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UMtEkjEA6+MsIvWkID1mCodPN+qU9ekogIWwGSM8gSI=;
        b=c3YnlIkGpnUAg8i3ekOWXpKReBKDfsUJIr5IBIyXe5b9VywrxScl4w4ifcmiwY6NIh
         A255ATu51+wjd4abB+Qe3Y4qjrLapy0g+Nw23GIfwsbOKkr7tJzd4kCVHluCZBsz4rV7
         l17gIX0Yh+RMq5HPfIMouc8AlumMh8jXPklBlrEG+Kr9ltEaAZMAMsPpSBO81mKb4MLK
         13GyCAotHR7iRVmXzwbDl0N4Bi/MhbisBP3CGos0ZsKIr6HALRSEbh7C6t30GEwuHV34
         VSCmJJtri5Kp0zxyw+lpIyfluvIX4TDM5dTGJpUGfl12+HWiONl1R3SHJBQ0I0EW+a0t
         K8Wg==
X-Forwarded-Encrypted: i=1; AJvYcCUsrEJ9xICggzzIL9HYYyWC+29ikQg2BVRS5us/faezLxbFaBRTMSa6hga3rOMHAF2lce2wFsnXu6epp9U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9c7ZX0LqKM+2vflE72kI1F+PD26bRMgDwiZGcSiQqJ+LvOPy7
	P5x+YJam3/1OuO9OITZ9AI6INeo59nQh3+35UuzlYKSxZKOyZEAvT7s8WMvCwsq/ya0/CyWwh+V
	tBOsxUfwWsCCyVZPFKEEOARQrVkVohdJX5gDZPg==
X-Google-Smtp-Source: AGHT+IEOaT0BYQW8cw+NkaLwFk65fiVHI1VHeKBwUhksWakjY7xaH3BIajcAn4R4yGhCGt4ZxNyadnMqwQwOoyxhIYA=
X-Received: by 2002:a05:6122:2021:b0:4fc:da8f:c8c4 with SMTP id
 71dfb90a1353d-5022146e600mr7614978e0c.12.1725731929903; Sat, 07 Sep 2024
 10:58:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240907065043.771364-1-aardelean@baylibre.com>
 <20240907065043.771364-2-aardelean@baylibre.com> <20240907155139.67a296c7@jic23-huawei>
In-Reply-To: <20240907155139.67a296c7@jic23-huawei>
From: Alexandru Ardelean <aardelean@baylibre.com>
Date: Sat, 7 Sep 2024 20:58:38 +0300
Message-ID: <CA+GgBR8URUmcru0Q=ut8gVdEO=KeVOQgzwWPr7bz1ceiSJXdEA@mail.gmail.com>
Subject: Re: [PATCH v5 1/9] iio: adc: ad7606: remove frstdata check for serial mode
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, krzk+dt@kernel.org, robh@kernel.org, 
	lars@metafoo.de, michael.hennerich@analog.com, gstols@baylibre.com, 
	Nuno Sa <nuno.sa@analog.com>, Stable@vger.kernel.org, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 7, 2024 at 5:51=E2=80=AFPM Jonathan Cameron <jic23@kernel.org> =
wrote:
>
> On Sat,  7 Sep 2024 09:50:34 +0300
> Alexandru Ardelean <aardelean@baylibre.com> wrote:
>
> > From: Guillaume Stols <gstols@baylibre.com>
> >
> > The current implementation attempts to recover from an eventual glitch
> > in the clock by checking frstdata state after reading the first
> > channel's sample: If frstdata is low, it will reset the chip and
> > return -EIO.
> >
> > This will only work in parallel mode, where frstdata pin is set low
> > after the 2nd sample read starts.
> >
> > For the serial mode, according to the datasheet, "The FRSTDATA output
> > returns to a logic low following the 16th SCLK falling edge.", thus
> > after the Xth pulse, X being the number of bits in a sample, the check
> > will always be true, and the driver will not work at all in serial
> > mode if frstdata(optional) is defined in the devicetree as it will
> > reset the chip, and return -EIO every time read_sample is called.
> >
> > Hence, this check must be removed for serial mode.
> >
> > Fixes: b9618c0cacd7 ("staging: IIO: ADC: New driver for AD7606/AD7606-6=
/AD7606-4")
> > Signed-off-by: Guillaume Stols <gstols@baylibre.com>
> > Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> > Link: https://patch.msgid.link/20240702-cleanup-ad7606-v3-1-18d5ea18770=
e@baylibre.com
> > Cc: <Stable@vger.kernel.org>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reference the fix patch in your cover letter, but don't include it in the=
 series.
>
> I'll just get confused when I pick this up.

ack
will do

