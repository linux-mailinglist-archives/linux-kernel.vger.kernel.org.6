Return-Path: <linux-kernel+bounces-316944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F4F96D75E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 13:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C7CDB25D2A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 11:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE6A199FCF;
	Thu,  5 Sep 2024 11:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rnhg0Bb4"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A11B199E8F
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 11:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725536407; cv=none; b=gIZrkUDDHG/2D5uQIuahKCovZ0JcFTzHGfQ+Q5+5nGEZIHqjTJgWM0wHHPMJTzzjbHuEmp4n+U0LNdzUpDSDJ/L7JB46EGbwTI+q12Pp8EpZd3cF2oxzUJ5uuaavAC5Hoa/5oYR80ks+wPxPBgwRs3sKMG6W3BPoNJrCEq9Bphg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725536407; c=relaxed/simple;
	bh=zrVvUahKZA1Ly+gFFCpv1OrY4hxvtMfOO87dPXkzcrQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dxpRJFxzmGFrqX11KWJ9wudPQ0LUhzWKvabM6IwK03J+GmZ3uSqidYmQMcJ/TYd9XO4WYOpWLX82ccMau/WRqOcOXsWp1LXfCstvge5uo/HeHVhq7hlJjpvzby9niDQgaba6rPiHuJF9zcjA7NlBJ4GSNwR6fO/ReVIIXDbDNkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rnhg0Bb4; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5343617fdddso1038811e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 04:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725536402; x=1726141202; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zrVvUahKZA1Ly+gFFCpv1OrY4hxvtMfOO87dPXkzcrQ=;
        b=rnhg0Bb4ttm4Yx1kIQrFVRXhXF3V0gqGlfHAA2LxxRYAL+gQM8mpw0XP1Tc3PKjUpw
         9GCOPrdY6BAVdRT7Hq+PGSXTt3nKAVcGxZtSmilfyq6MHo/E0Dmr1aNcKYyMO83L4+Vd
         t4HJkeRCINjEEchOZrGGoEa3A/wqLe71wlLakHxm7lKqxNnLVlXlbX9UMe1kOfg3rbct
         e3V8YbEsxR4yEvFnvDSVV5loUzeYFap49xUSGL0lKz2+xt70ACxTvHS7Ky5s3IzoGlcN
         HaeyyxZp3W7ewMcCpXFXwYPVHF+Eazj0EonDroz9Lwuj1Sj5OcaVTe8I29DPPI1qMp6k
         8Avw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725536402; x=1726141202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zrVvUahKZA1Ly+gFFCpv1OrY4hxvtMfOO87dPXkzcrQ=;
        b=nnHa5EWzcON+qsfP/xVwNsT6gJQWQDnB6BxE7N3T7Udxhz2oDIVRkhehxuOrrGzxBS
         d563hwOQr4aJxOYfwzXCN+tXv+GG9U+nZveIH64HH5IYAo90w1PFAwxX9seHKwRtL3D5
         dQ7Y8rbd54dWDcTdO9e5Gl4vxrT7trxwMvlnAmHL7Po+E4QSIYc8Mp9NtrwTRwQjjO7O
         usB6PG8f0k7oRbTR1fdPC2ogmsC40+EpM3UnaeHWkPMKeOzvSWSx1kOwTbk8a1R8ekR/
         DslpsqFnUI8KCdW/a1J8ujcWGsyFqaxt8lz/Nk0KrJUvMuCf27CC3iZFq+wD9L8B8pXx
         pZDg==
X-Forwarded-Encrypted: i=1; AJvYcCUlGgPsRJD5bVkSzoUX0MJWfm3TfBd6QI4ERRo9g72cRZ+rne7IqpriYTJgzCS9e+4+MsOAars7hotRgWw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw/yj0F6FWrvsmi1D9I1VlCzdB1fZ3Q5TgmVpl+qxEPGlkgQpR
	srjviL8LCcEsmG62HawrBfkZcrNGofO8SIZevAiNUtT/iOZS/vQJWWHdkcGO1syVcKN/ZqwldAa
	1rxIGCbhufHELGsLN5BQwoiI7XShNUJGI1dvnXw==
X-Google-Smtp-Source: AGHT+IEwZ/cUzkI93E/6LKm6cGyhHb8XA9AkNg8OpqoeSXVfyucD7/JsivArkGPITQJzkXL5zLtM+8AMY4ZU3v65zm0=
X-Received: by 2002:a05:6512:108b:b0:52c:df83:a740 with SMTP id
 2adb3069b0e04-53546b54df6mr16785064e87.30.1725536402123; Thu, 05 Sep 2024
 04:40:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902225534.130383-1-vassilisamir@gmail.com> <20240902225534.130383-4-vassilisamir@gmail.com>
In-Reply-To: <20240902225534.130383-4-vassilisamir@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 5 Sep 2024 13:39:50 +0200
Message-ID: <CACRpkdbjUe6aM0nHvEEEWaT1AG9kieiUuTx0M6G12Pnsvgcd6w@mail.gmail.com>
Subject: Re: [PATCH v1 3/7] net: dsa: realtek: rtl8366rb: Make use of irq_get_trigger_type()
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: linux@armlinux.org.uk, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch, 
	alsi@bang-olufsen.dk, andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	nico@fluxnic.net, arend.vanspriel@broadcom.com, kvalo@kernel.org, 
	robh@kernel.org, saravanak@google.com, andriy.shevchenko@linux.intel.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev, 
	brcm80211-dev-list.pdl@broadcom.com, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 12:55=E2=80=AFAM Vasileios Amoiridis
<vassilisamir@gmail.com> wrote:

> Convert irqd_get_trigger_type(irq_get_irq_data(irq)) cases to the more
> simple irq_get_trigger_type(irq).
>
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

