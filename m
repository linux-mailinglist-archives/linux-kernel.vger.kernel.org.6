Return-Path: <linux-kernel+bounces-393451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0689BA0CE
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 15:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEED32825AE
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 14:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B24818B47C;
	Sat,  2 Nov 2024 14:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PiiilVKB"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2C733F9
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 14:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730558171; cv=none; b=p7eTPAslfiqywJTdt0DVwMyKWrGkhkJMzgm0CmwLAza5XjGbpO9cOlFEJG/FPjvZrhQjsWFOc7NPArH/Xrec0yT/yfP24gJk545uMKOaezgrAKkZckELwz4lZnGWx//czZStjiTkgBGHjyU9cG5LPDg/zOeZ7PvAfM1MF9i2268=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730558171; c=relaxed/simple;
	bh=jen3Fr+N40Cko1laLEWb06nyy02f9b1SKWGey5w+uQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iLendk6IpZieeszz+27ONAnftrKLiWBCs20YqdN9X1nv5pBLXn8AUCgKApcv7h8Ggk8AMNwkpwS3J7iooduas1d5Nsk2Z8nidutpL6pZJhIICqE8gcdcgnh6qteRJaWmqSmL4sswVRZLjDSfhV9wj9SQzqcfsfDOROk5zkUjhSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PiiilVKB; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4315e62afe0so24108095e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Nov 2024 07:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730558168; x=1731162968; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r2f8PcOKU/FF7Pc238+N7r6RVxJuBnH+dra36GzbN3Q=;
        b=PiiilVKBm/l8zNgZ+DFEGaz4Qd1LueLzc4JocRA/EGfmx41W6Mck5M7chspWyxmOkw
         MeXs/m9SWUxD6PHJ4wZGLvezfgE26nzlrBcx7FW7iiaz7UomW6Nckw3gzdJFnoMI7GiW
         T6D0Qz5eU9o1WeH+/AsH291ouZWjyu+ClCdff3gr2X7Cg0GjgiNjkZRxi68uMO9pzgHJ
         c1nhQPNzbZ+sFP6sJzHvj6rDRO6swuzbS1EgOYSloPGqzHPSqsJ+tHRRIv7TUViUR/Bh
         RGD9lpeURmljBht2K5SPB9u+L6Hu0Y/11JSFJTsLiGFwYqq3XzguR55TGsbNkMrA7H/2
         Z9rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730558168; x=1731162968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r2f8PcOKU/FF7Pc238+N7r6RVxJuBnH+dra36GzbN3Q=;
        b=OPSqGwmAmXROixmGv5xmhLaf/vkcV3UKlffpjrmWaLwzSwI2m4hGBYZu01rqJLWq8p
         vdM6wmQUQA+aNVe5SlmDPZuu3FXyncJegcFxGZQnM+1SzrZa/jcZwXV+qoa0JIfk8sSU
         3t406QuRXpJNFyiHuWsAxQVSVMYW4WcQ21aCdJ5ys1y59JPc20bpepf60NAHP5OjbXDO
         3HXtEP1NosVNm2q5wxBU08lrXWNDA/cnqReX8XEtWr6fjsx7Z0hja1sU/7j4tHySyFOr
         BJ9Iag6IdX6yr2oXQCi3VWNN+hk2ewk9fN1f+3fI8vttuqsW6lGrKB48gZxG9vhRxG82
         DONQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEDLeqMQpAaRry2EyXeDpB79q6vMJE5Sjk8ad7L0hDFg3twesjX3pJ31Dyx1fySFfuefhByZD96xnzuZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkOrUtO+bUdYTNC5S/UumFOmLrlgTvo2FHtiAZS6ho5Y23eqX0
	oAGnA0qZDUPaXO8y8xjXFMET1JnhH+Hj6Qfp/dWTSCZNXCo6kGDM
X-Google-Smtp-Source: AGHT+IG2ZwFxftz+i126vYwTLkOIpd6nzrVgPGTfjFmQz2ucEFkNbpKfCCu2yMagL13buIP7HKDmjA==
X-Received: by 2002:adf:e28a:0:b0:37d:45f0:dd0a with SMTP id ffacd0b85a97d-380610f2a9emr19284579f8f.1.1730558168360;
        Sat, 02 Nov 2024 07:36:08 -0700 (PDT)
Received: from eichest-laptop ([2a02:168:af72:0:492c:2677:72f4:9f57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c116abb5sm8202298f8f.100.2024.11.02.07.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2024 07:36:07 -0700 (PDT)
Date: Sat, 2 Nov 2024 15:36:06 +0100
From: Stefan Eichenberger <eichest@gmail.com>
To: Shawn Guo <shawnguo2@yeah.net>
Cc: linux@armlinux.org.uk, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com,
	elinor.montmasson@savoirfairelinux.com,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: Re: [PATCH v1] ARM: imx_v6_v7_defconfig: enable SND_SOC_SPDIF
Message-ID: <ZyY41nJY9ghwe-Y4@eichest-laptop>
References: <20241030122128.115000-1-eichest@gmail.com>
 <ZyXTFhEm9UCBii2c@dragon>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyXTFhEm9UCBii2c@dragon>

Hi Shawn,

On Sat, Nov 02, 2024 at 03:21:58PM +0800, Shawn Guo wrote:
> On Wed, Oct 30, 2024 at 01:21:12PM +0100, Stefan Eichenberger wrote:
> > From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> > 
> > Enable SND_SOC_SPDIF in imx_v6_v7_defconfig to support SPDIF audio. This
> > change will fix commit d469b771afe1 ("ARM: dts: imx6: update spdif sound
> > card node properties") which moves away from the old "spdif-controller"
> > property to the new "audio-codec" property.
> > 
> > Fixes: d469b771afe1 ("ARM: dts: imx6: update spdif sound card node properties")
> 
> It doesn't look a fix to me.

I agree somehow, it was just that before the referenced commit our test
succeeds with the imx_v6_v7_defconfig and after that we get the
following error:
[   24.165534] platform sound-spdif: deferred probe pending: fsl-asoc-card: snd_soc_register_card failed

So maybe it is not a fix in the sense of a bug, but it fixes the error
message. However, I'm also fine with removing the Fixes tag.

Regards,
Stefan



