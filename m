Return-Path: <linux-kernel+bounces-340514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D05A98747B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 15:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0925C286935
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 13:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D40825569;
	Thu, 26 Sep 2024 13:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QZcDB8FE"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3569D4D8AD
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 13:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727357587; cv=none; b=T1Skwj6Zj+uBWfOB7/F21PP1PD10YnA+32W9hgiJ8XBuay9VnFe3i2lKFdYXlifIH8HXjByXGt08JlweQaBCBU2IoO+taz1ERjC+IDa6TPzSZ/LdhvsSrmgof7WnhJ6HUvn0ZQ1x5iRafSpsHo2aEz92AVoOtam8GSr+5NM1QRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727357587; c=relaxed/simple;
	bh=6DjgITxuxMnJtFqiZJDNNiIBfC6aRD7xowfyalj+wAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XJZV4gQdnHaz8Ko3YIunH/Gixww60r4wmPLA4hb0MLSgG7MK61hU9LathI69HaI5nAn7gMtEbEfl9cB/azYUscMKHXLAS3cv1B+yKcfQPFBS03RTZq7XI92KRkp5o00f6a/IA35KH5E8w3eICoTGc9GxfLCWcJrYg9Ia4j2ZfSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QZcDB8FE; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2f75aa08a96so10537801fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 06:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727357584; x=1727962384; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SLMfEvh5MiHDpi2ZSu3TA3jK6yRE8rSCehYhzQ/c1wk=;
        b=QZcDB8FEfR1Pm9VdQTd/kkCdAWsOPHCflEoXEAcHsqc5aNJ4a8yk6F4OWUCEIofmkJ
         gUk2WoTmsuNYmXUjyhLmHs070aHMCtJf4WrDa7u7aPLUYFbPG+2QNw60NluA6Ra2H7vo
         4LK+LfhMOMZKfuNGeOrXNca8qiK0d80v93fb/giu7TuSu/fSjw4yNiNIc7OhuOeLvBdu
         i1n9DHI8LniEIwUvqv+0S1ST05nvoqAK/hgnyPQh7y7BpyDTDorHRnNhHQzPLpZ4sQoU
         XBKQ081NLCB1cxm9JnQunGRA0njKRveNy/1ABAZONBTEey9Y7vAWxG/XL+2jgUSq+b5M
         dT1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727357584; x=1727962384;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SLMfEvh5MiHDpi2ZSu3TA3jK6yRE8rSCehYhzQ/c1wk=;
        b=dUDCGldz3przMNcN8e9RX0HFXqvs7vF58V3sBoomHFzWq11WTRN7TwbpqwTx16StsX
         +cXg2LPxk70sy/veF8V0+KSrgarIsPPhyIkv/KucZdzc8BXx0pCUjWGPyQxuKOTkIRPf
         D6Gts6qOxhsqAgGTmAPQXKmITvee9VUSPITU6gUmTdKo9thJUf1x2DJMyebLBfgW2MzZ
         IlBiRbhji8XDQHXfUiCT95ORh5CSqYZFbQ+MQ7DGpjIlfjwO5lQD5xcNHDfDaLY06FIk
         HW5b0jEH7lD6PlxEI4KMbl8SpQCt0HF9mXZRZe4yXNGA2IBt9MwrGUvab1ii1imXPOZV
         HlTg==
X-Forwarded-Encrypted: i=1; AJvYcCXI/Xb6TRnLtGCDrVxWQe2G6SiCG8dnPncKUM4E80YhXQ0ZqzUAVKr3FQ0Fx4Ne03D4plPUKpfVry5ACRg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHTtkuGJ/dIsjYfR55deKecE+idGMJ0bXSzT2kUZ5IToHSWBQV
	l+7yoKNdXSxxutkOWdgu3KDeL1+13Xm/2yULa7hei3pKzTUezqg3Tw1/Jqj6wu8=
X-Google-Smtp-Source: AGHT+IGe3R/1B3NKEaxLfS+X89tuylS/2rdHSlIFy6HqcIaJi19L7E/oXqDbrjVb+1syadc4RQIWPQ==
X-Received: by 2002:a2e:5152:0:b0:2f7:4e8c:9bfa with SMTP id 38308e7fff4ca-2f91ca6eee3mr34240621fa.33.1727357584260;
        Thu, 26 Sep 2024 06:33:04 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f8d283c0easm8253391fa.52.2024.09.26.06.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 06:33:02 -0700 (PDT)
Date: Thu, 26 Sep 2024 16:32:59 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Manikandan.M@microchip.com
Cc: neil.armstrong@linaro.org, quic_jesszhan@quicinc.com, 
	airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, thierry.reding@gmail.com, sam@ravnborg.org, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dharma.B@microchip.com
Subject: Re: [PATCH v2 2/2] drm/panel: simple: Add Microchip AC69T88A LVDS
 Display panel
Message-ID: <quxjqmx5yc27cxmjvnq6irltr36josag4yltxbiweh4femqbqo@j34pxmfxglc5>
References: <20240919091548.430285-1-manikandan.m@microchip.com>
 <20240919091548.430285-2-manikandan.m@microchip.com>
 <zognzunciriytm3uvoolxjsvu43v3m2lnctsz5swusnmm3aj2z@ag7zkncccdmf>
 <83e9d20d-f294-4303-b570-816ebc989bcf@microchip.com>
 <f4z2egmrcoh7kih2pyr3mq7fzuwtvod6vxlzzim2iw3ly7jcr3@2uxiyzlfixhp>
 <17b5a11c-b9a8-4172-831e-d52f1a4270e9@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17b5a11c-b9a8-4172-831e-d52f1a4270e9@microchip.com>

On Thu, Sep 26, 2024 at 08:17:09AM GMT, Manikandan.M@microchip.com wrote:
> On 23/09/24 11:37 am, Dmitry Baryshkov wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > On Mon, Sep 23, 2024 at 05:50:22AM GMT, Manikandan.M@microchip.com wrote:
> >> On 20/09/24 9:13 pm, Dmitry Baryshkov wrote:
> >>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >>>
> >>> On Thu, Sep 19, 2024 at 02:45:48PM GMT, Manikandan Muralidharan wrote:
> >>>> Add support for Microchip AC69T88A 5 inch TFT LCD 800x480
> >>>> Display module with LVDS interface.The panel uses the Sitronix
> >>>> ST7262 800x480 Display driver
> >>>
> >>> AC69T88A seems to be a module name, rather than a panel name. What is
> >>> the actual panel name present on this module?
> >> Both names, "Microchip AC69T88A" and "MPU32-LVDS-DISPLAY-WVGA" are
> >> present on the display module
> > 
> > Which panel was used for the module? I don't think that Microchip
> > produces LVDS panels.
> Its a new LVDS display from Microchip that uses Sitronix ST7262 TFT LCD 
> driver
> 
> https://www.crystalfontz.com/controllers/datasheet-viewer.php?id=486

Ok. Anyway if somebody ends up looking for the panel, they'll probably
find the module and vice versa.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

