Return-Path: <linux-kernel+bounces-341128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFBD987BA5
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 01:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 818691F2529C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 23:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21291B143A;
	Thu, 26 Sep 2024 23:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OQG1/dJV"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387D81B07CD
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 23:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727392888; cv=none; b=kbmbwRY93yhyPsuolyqTAythQsN68sNJIj8nSQWbu3zdSQ4oytrGiVMSVBoxk/vtxwSEfi0wj2kttA7cOg+y4rTABDw1Qpdq/LmVuLMRH07429Xs/NuvnJ5HIA56/Iwxsu3Bn1q8wYUb+d3IvTuI/V3/dXmBz7daZy7bQhvCPk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727392888; c=relaxed/simple;
	bh=X7ee8uCfCrRVZrNU8OdJ9moOzH6OXhSucidqNB01wsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vp0Nvi3bIRILrQKjmgGqEQ7uLJAwJNHv+WAqT0p7l39PY92PbXc/K5x2zJG2OjirLDz2PQ9xml75aSIPosGGvYjDyXdr1sFaFobBht/cJPtVWPMuhH+x3uPhAWN9e8EInL7Tg0LQ5Da5+CwQlfNlIHp26qzq3E5qvdPKBcNb8Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OQG1/dJV; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f75f116d11so18191721fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 16:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727392883; x=1727997683; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hj1ddZeOtN7zDwMwktNYFtzm3Gh7Tekdeg6sieYs35g=;
        b=OQG1/dJVbBW0gRg9H37UpgdBS+ytOnRUHEkNmedeDBKh3tbopYZ+HXJuwB/50/1SqO
         b0ftk9v9kaVQJ2vQ6sWQT/PeFuYohj/rQseonRvBjFurwBBf5h/zWlbro8bY7jQn5iy1
         2YN/L0xmXHZaBhFIO4e9VJxgKdOcOIWz+Jmxwwhnp8ZEI871gfTJWosbShK/hiY9lh4A
         epID9dXzkA5W063miuyFvYSNEwZLhiZDXeu+yHm37MQBKCbIk8GXnRZ8m6UI/zHPQok1
         Ld6384qGrI+NdFJo2eNyKXJ/LWRCFqY7N1Jvm3AKsqB4UqjidMEoasB75GtBi2RpPWCF
         FGrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727392883; x=1727997683;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hj1ddZeOtN7zDwMwktNYFtzm3Gh7Tekdeg6sieYs35g=;
        b=Hl2Cl0K5XIbcpXp1tgU87grqL0KOT6VFo+3JwM9rTo4e2608XNmfgrWUb1z6fXjsE5
         iQEjhI5mRnKjyvYvlV0L85fMVSkkD/FLm6qaRmEr9gEsu3zi1b4cksc8juhnKISOGtPc
         sMNDYMiXVRekR3Ha5URnQAOmGi/vBJuRyXNZIGIpBeGX6l0cOSrnP+/i2/8ll6JfZom1
         e5jABMtZQvBkc6RvEP+ABJlZapJrgd/u9qNG+pmONZ2/HqVf99JkztxxNAu0mODtFsVE
         zxwFcGCNOYbrQQp3VyvuXn3yTrOfIFDBvQ0AgSGTT9cPhb6oea4qNF3mMFoa5Ym7t8GK
         XZ4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVICe0eI6wxpZ6ftD3N0FJrHHDIwA3OvC7XbgUl+C+eoqfQi9RpHqFdVBQ8zETIWpVcwhaG/m3NEHI0G/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGWzVlRgvyrtbYNNkV8Ml2l3Kk05z1nmmkC4gY5bQmrq/Cc9GG
	3kj6LAkYCmAwSOW9S8+a1KtnDbz4ADqNUINXahRFyyCvCeh3DX2MY0JXJ/2Hg2o=
X-Google-Smtp-Source: AGHT+IELK0Z3Oj9K6pV3soLuC1gTs0dfJ9rdKZI8pDVBtLZN2FDIDBgtVuAsJBZb02BkKfXRyruufA==
X-Received: by 2002:a05:6512:3a96:b0:52e:9e70:d068 with SMTP id 2adb3069b0e04-5389fc29c84mr797475e87.4.1727392882552;
        Thu, 26 Sep 2024 16:21:22 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-538a044159csm100729e87.263.2024.09.26.16.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 16:21:22 -0700 (PDT)
Date: Fri, 27 Sep 2024 02:21:19 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: Manikandan.M@microchip.com, neil.armstrong@linaro.org, 
	quic_jesszhan@quicinc.com, airlied@gmail.com, simona@ffwll.ch, 
	maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, thierry.reding@gmail.com, sam@ravnborg.org, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dharma.B@microchip.com
Subject: Re: [PATCH v2 2/2] drm/panel: simple: Add Microchip AC69T88A LVDS
 Display panel
Message-ID: <aehcvf55b52p6u5ai3uri7jzo2dywdhv6mxo4pxz3lhajjoxqe@izk23gt2yvdn>
References: <20240919091548.430285-1-manikandan.m@microchip.com>
 <20240919091548.430285-2-manikandan.m@microchip.com>
 <zognzunciriytm3uvoolxjsvu43v3m2lnctsz5swusnmm3aj2z@ag7zkncccdmf>
 <83e9d20d-f294-4303-b570-816ebc989bcf@microchip.com>
 <f4z2egmrcoh7kih2pyr3mq7fzuwtvod6vxlzzim2iw3ly7jcr3@2uxiyzlfixhp>
 <17b5a11c-b9a8-4172-831e-d52f1a4270e9@microchip.com>
 <quxjqmx5yc27cxmjvnq6irltr36josag4yltxbiweh4femqbqo@j34pxmfxglc5>
 <20240926-foamy-oarfish-of-passion-ec6fa2@houat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926-foamy-oarfish-of-passion-ec6fa2@houat>

On Thu, Sep 26, 2024 at 03:58:11PM GMT, Maxime Ripard wrote:
> On Thu, Sep 26, 2024 at 04:32:59PM GMT, Dmitry Baryshkov wrote:
> > On Thu, Sep 26, 2024 at 08:17:09AM GMT, Manikandan.M@microchip.com wrote:
> > > On 23/09/24 11:37 am, Dmitry Baryshkov wrote:
> > > > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > > > 
> > > > On Mon, Sep 23, 2024 at 05:50:22AM GMT, Manikandan.M@microchip.com wrote:
> > > >> On 20/09/24 9:13 pm, Dmitry Baryshkov wrote:
> > > >>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > > >>>
> > > >>> On Thu, Sep 19, 2024 at 02:45:48PM GMT, Manikandan Muralidharan wrote:
> > > >>>> Add support for Microchip AC69T88A 5 inch TFT LCD 800x480
> > > >>>> Display module with LVDS interface.The panel uses the Sitronix
> > > >>>> ST7262 800x480 Display driver
> > > >>>
> > > >>> AC69T88A seems to be a module name, rather than a panel name. What is
> > > >>> the actual panel name present on this module?
> > > >> Both names, "Microchip AC69T88A" and "MPU32-LVDS-DISPLAY-WVGA" are
> > > >> present on the display module
> > > > 
> > > > Which panel was used for the module? I don't think that Microchip
> > > > produces LVDS panels.
> > > Its a new LVDS display from Microchip that uses Sitronix ST7262 TFT LCD 
> > > driver
> > > 
> > > https://www.crystalfontz.com/controllers/datasheet-viewer.php?id=486
> > 
> > Ok. Anyway if somebody ends up looking for the panel, they'll probably
> > find the module and vice versa.
> > 
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> Given that aside from that mail, the module name isn't mentionned
> anywhere, I'm not sure they would.
> 
> The way we usually deal with controllers is to have a separate driver
> for panels based on that controller, even more so since that controller
> seems to be able to affect the display.

But in this case it's panel-simple, no special driver for the
controller. From my understanding the AC69T88A is the module name (at
least the datasheet uses that name). The on-board EEPROM also carries
that name and the name of the controller.

-- 
With best wishes
Dmitry

