Return-Path: <linux-kernel+bounces-198963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 429DE8D7FC1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 12:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3C4628BA8F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 10:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2560382D72;
	Mon,  3 Jun 2024 10:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WeahWID4"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5DF8060E
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 10:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717409412; cv=none; b=HBrO0+KOffeqEvbz9gwvokV3T0ortzHFswA2+EtYCFaIs8SJkwhRKTYedlC9nkMFEACmn+m4X9I88SOmcgcRr3KMSKjUsc+cgjXc7MIPNJpwgQsohOATTPN8rOItgrQIxl84agM4/4fiNaGaif+qUAWVQp1jiWBK7JfVwDeK2G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717409412; c=relaxed/simple;
	bh=axCaytBs4Nv5HrnZxUnB+aeuBj8JrqMrdedG5ZfR364=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RBA3LogOTwxY7ZX+jWWfrYFxL1Kj4qaXRUmAwj7jYv1HL0pcnrjIgnsaj++tnUK+lj9+S/uwXiEDDYUiLFAgXHh8FZM6zM0I/lHhu0l4AQxXIfE20FUgwRS6Uh3yrBnwm1plhqfkqppmwihZPxv7wbf1teOoX+Yp4g80zseRp+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WeahWID4; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2eaad2c670aso9458141fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 03:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717409407; x=1718014207; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/oQILeAKHOw/6kmTRnoLAXLSnuKdCsLUhNLs5GdUc34=;
        b=WeahWID4PFQSo+SmAHT5DaUUwVp2NjBxfgdvPVQhFTaCsd18cuzlEXE3gMbktt9UpR
         TlpdYFJ8RZYv46dvvHJzCk4alEPGZuwrKVRHivKH8Xzzh4pb47vRR2mWSSEokzdlFeVU
         qx0sJMjy2TrB2WuohOOKeAfWn4nj/Cu1lZ0rQnE3iCPLuVfEjjpBve2fYUKrCjpy59Q2
         /2z9TDsx65CH0JucJbEU7N3UJA5pklTg+xJ1WzoZ5nYmCeRxTGGHOuLKalxQKQzAeG+t
         0Kj3bjQZj3z+r0nV1gB2arZlgY3tpKW2iv4UyIc/PUMeKpJKWJ/kKvEgazymXKIDPNn/
         Focw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717409407; x=1718014207;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/oQILeAKHOw/6kmTRnoLAXLSnuKdCsLUhNLs5GdUc34=;
        b=Vh7UgN1EUQDTCRwwMztHeJ988Rb8dxOL4qxQclwyZ2i8KrA6AMw3UPJZzhdGp0xS8W
         lBQvcsw/EKoc8TbJUyL5H+L5mo59tv9OO/zYF1VaS6pi/GtT7uizRpPzv80MB1XEt3iz
         vap3d8FGQbrXp7yK6OXfPUFRhDo4DmuyMVEkGNrp3FPLvvPnvr/28wkJTzQufCA/sdS1
         8rzKwzSVyaGjiL7qfe3JHSYtDeBs+v0s5yLOs1FXqHdX9kuTh9gxkOpvOfQq3+2aAYPc
         kf0/XoyJ318lfmZftg826mOZ7VIeiabSSRjM3cHZ2xrDxY9z+VTBazHN2+aJu5E06PcY
         l5TQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsgDIo3TZ7vyFaEH/6ggYaPPFdOUsyYi6R62OuNBhvWPqSGrOCx7yx6b6PhiXD28FuzSyFje2PWI0bPS4mGitWa2T/2ZUE+aM69p51
X-Gm-Message-State: AOJu0YxL4V/OcgT2Q57jqVOuGUVHOni5UkAd8CBTjX+Q0KeX/dobsLmz
	K7RUCF6c+JfH6vd1L7ws7VIsOLept2pnUj+edJ7C0pcM80faDqkFhNYVecvlb/A=
X-Google-Smtp-Source: AGHT+IGn3CzzELML6N16hK8AnLGIUEFMcTTvwgUdRPEpFKKFP4W6B3EpYysrx8TTkgAynFdvKb3M2w==
X-Received: by 2002:a2e:be85:0:b0:2e6:b00f:da92 with SMTP id 38308e7fff4ca-2ea9510c2f2mr63295851fa.24.1717409407334;
        Mon, 03 Jun 2024 03:10:07 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ea91bb4c07sm11274131fa.45.2024.06.03.03.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 03:10:07 -0700 (PDT)
Date: Mon, 3 Jun 2024 13:10:05 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Francesco Dolcini <francesco.dolcini@toradex.com>, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH v2 2/2] usb: typec: mux: gpio-sbu: Make enable gpio
 optional
Message-ID: <mkrpe3w54u7dkwjzhbakcvjry2ot5uvwjd4fasgirdcgsjbgdb@53q4a4f5ecix>
References: <20240603083558.9629-1-francesco@dolcini.it>
 <20240603083558.9629-3-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603083558.9629-3-francesco@dolcini.it>

On Mon, Jun 03, 2024 at 10:35:58AM +0200, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> The enable gpio is not required when the SBU mux is used only for
> orientation, make it optional.
> 
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
> v2:
>  - removed useless NULL check for optional enable gpio
> ---
>  drivers/usb/typec/mux/gpio-sbu-mux.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

